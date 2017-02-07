# xos-sample-gui-extension

## TODO:

- [ ] Provide a dev environment

## Platform install integration

Having a profile deployed is required. To add extensions listed in your `profile-manifest` as:

```
enabled_gui_extensions:
  - name: sample
    path: orchestration/xos-sample-gui-extension
```

_NOTE: the `name` field must match the subdirectory specified in `conf/app/gulp.conf.js` (eg: `dist/extensions/sample`)_

Execute: `ansible-playbook -i inventory/mock-rcord deploy-xos-gui-extensions-playbook.yml`
_NOTE: remember to replate `inventory/**` with the actual `cord_profile` you are using_ 