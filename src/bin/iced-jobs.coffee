exports.command =
  description: 'Displays and manages running (and complete) jobs.'

if require.main is module
  glacier = require '../lib/glacier'
  columnify = require 'columnify'
  moment = require 'moment'
  humanize = require 'string-humanize'
  nopt = require 'nopt'
  knownOpts =
    completed: Boolean
    failed: Boolean
  shortHands =
    complete: ['--completed']
    c: ['--completed']
    fail: ['--failed']
    f: ['--failed']
  parsedOptions = nopt(knownOpts, shortHands, process.argv)
  vaultName = parsedOptions.argv.remain.shift()

  unless vaultName?
    console.error """
    usage: iced jobs [--completed] <vault>

    List the jobs associated with <vault>
    """
    process.exit 1

  statuscode = if parsedOptions.failed
      'Failed'
    else if parsedOptions.completed
      'Succeeded'
    else
      'InProgress'

  glacier.listJobs {vaultName, statuscode}, (err, data) ->

    if err?
      console.error err.message
      process.exit 1

    if data.JobList.length is 0
      console.error "No jobs found"
      process.exit 0

    jobs = data.JobList.map (job) ->
      action: if job.Action is 'ArchiveRetrieval' then 'archive' else 'inventory'
      status: if job.StatusMessage? then job.StatusMessage else humanize(job.StatusCode).toLowerCase()
      started: moment(job.CreationDate).format('YYYY MMM D, hh:mma')
      id: job.JobId
      desc: job.JobDescription

    console.log columnify(jobs)
    process.exit 0
