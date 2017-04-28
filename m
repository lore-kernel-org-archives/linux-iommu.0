From: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/s390: Fix IOMMU groups
Date: Sat, 29 Apr 2017 01:50:53 +0800
Message-ID: <201704290152.FMDe9fGu%fengguang.wu@intel.com>
References: <1493306905-32334-2-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1493306905-32334-2-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Sebastian Ott <sebott-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kbuild-all-JC7UmRfGjtg@public.gmane.org, Gerald Schaefer <gerald.schaefer-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Joerg,

[auto build test ERROR on s390/features]
[also build test ERROR on v4.11-rc8 next-20170428]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Joerg-Roedel/iommu-s390-Fix-iommu-groups-and-add-sysfs-support/20170429-003440
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
config: s390-default_defconfig (attached as .config)
compiler: s390x-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=s390 

All errors (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:95:0,
                    from include/trace/events/iommu.h:167,
                    from include/linux/iommu.h:27,
                    from arch/s390/include/asm/pci.h:11,
                    from include/linux/pci.h:1627,
                    from include/trace/events/iommu.h:14,
                    from drivers/iommu/iommu-traces.c:12:
   include/trace/events/iommu.h: In function 'ftrace_test_probe_add_device_to_group':
   include/trace/trace_events.h:716:2: error: implicit declaration of function 'check_trace_callback_type_add_device_to_group' [-Werror=implicit-function-declaration]
     check_trace_callback_type_##call(trace_event_raw_event_##template); \
     ^
   include/trace/events/iommu.h:39:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_group_event, add_device_to_group,
    ^~~~~~~~~~~~
   include/trace/events/iommu.h: In function 'ftrace_test_probe_remove_device_from_group':
   include/trace/trace_events.h:716:2: error: implicit declaration of function 'check_trace_callback_type_remove_device_from_group' [-Werror=implicit-function-declaration]
     check_trace_callback_type_##call(trace_event_raw_event_##template); \
     ^
   include/trace/events/iommu.h:47:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_group_event, remove_device_from_group,
    ^~~~~~~~~~~~
   include/trace/events/iommu.h: In function 'ftrace_test_probe_attach_device_to_domain':
   include/trace/trace_events.h:716:2: error: implicit declaration of function 'check_trace_callback_type_attach_device_to_domain' [-Werror=implicit-function-declaration]
     check_trace_callback_type_##call(trace_event_raw_event_##template); \
     ^
   include/trace/events/iommu.h:72:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_device_event, attach_device_to_domain,
    ^~~~~~~~~~~~
   include/trace/events/iommu.h: In function 'ftrace_test_probe_detach_device_from_domain':
   include/trace/trace_events.h:716:2: error: implicit declaration of function 'check_trace_callback_type_detach_device_from_domain' [-Werror=implicit-function-declaration]
     check_trace_callback_type_##call(trace_event_raw_event_##template); \
     ^
   include/trace/events/iommu.h:79:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_device_event, detach_device_from_domain,
    ^~~~~~~~~~~~
   include/trace/events/iommu.h: In function 'ftrace_test_probe_map':
   include/trace/trace_events.h:716:2: error: implicit declaration of function 'check_trace_callback_type_map' [-Werror=implicit-function-declaration]
     check_trace_callback_type_##call(trace_event_raw_event_##template); \
     ^
   include/trace/trace_events.h:66:2: note: in expansion of macro 'DEFINE_EVENT'
     DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:86:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(map,
    ^~~~~~~~~~~
   include/trace/events/iommu.h: In function 'ftrace_test_probe_unmap':
   include/trace/trace_events.h:716:2: error: implicit declaration of function 'check_trace_callback_type_unmap' [-Werror=implicit-function-declaration]
     check_trace_callback_type_##call(trace_event_raw_event_##template); \
     ^
   include/trace/trace_events.h:66:2: note: in expansion of macro 'DEFINE_EVENT'
     DEFINE_EVENT(name, name, PARAMS(proto), PARAMS(args));
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:109:1: note: in expansion of macro 'TRACE_EVENT'
    TRACE_EVENT(unmap,
    ^~~~~~~~~~~
   include/trace/events/iommu.h: In function 'ftrace_test_probe_io_page_fault':
   include/trace/trace_events.h:716:2: error: implicit declaration of function 'check_trace_callback_type_io_page_fault' [-Werror=implicit-function-declaration]
     check_trace_callback_type_##call(trace_event_raw_event_##template); \
     ^
   include/trace/events/iommu.h:158:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_error, io_page_fault,
    ^~~~~~~~~~~~
   In file included from arch/s390/include/asm/pci.h:11:0,
                    from include/linux/pci.h:1627,
                    from include/trace/events/iommu.h:14,
                    from drivers/iommu/iommu-traces.c:12:
   include/linux/iommu.h: In function 'report_iommu_fault':
>> include/linux/iommu.h:368:2: error: implicit declaration of function 'trace_io_page_fault' [-Werror=implicit-function-declaration]
     trace_io_page_fault(dev, iova, flags);
     ^~~~~~~~~~~~~~~~~~~
   In file included from include/trace/events/iommu.h:13:0,
                    from drivers/iommu/iommu-traces.c:12:
   include/trace/events/iommu.h: At top level:
>> include/trace/events/iommu.h:20:11: error: expected ')' before 'int'
     TP_PROTO(int group_id, struct device *dev),
              ^
   include/linux/tracepoint.h:104:27: note: in definition of macro 'TP_PROTO'
    #define TP_PROTO(args...) args
                              ^~~~
   include/trace/events/iommu.h:41:11: error: expected ')' before 'int'
     TP_PROTO(int group_id, struct device *dev),
              ^
   include/linux/tracepoint.h:104:27: note: in definition of macro 'TP_PROTO'
    #define TP_PROTO(args...) args
                              ^~~~
   include/trace/events/iommu.h:49:11: error: expected ')' before 'int'
     TP_PROTO(int group_id, struct device *dev),
              ^
   include/linux/tracepoint.h:104:27: note: in definition of macro 'TP_PROTO'
    #define TP_PROTO(args...) args
                              ^~~~
>> include/trace/events/iommu.h:56:11: error: expected ')' before 'struct'
     TP_PROTO(struct device *dev),
              ^
   include/linux/tracepoint.h:104:27: note: in definition of macro 'TP_PROTO'
    #define TP_PROTO(args...) args
                              ^~~~
   include/trace/events/iommu.h:74:11: error: expected ')' before 'struct'
     TP_PROTO(struct device *dev),
              ^
   include/linux/tracepoint.h:104:27: note: in definition of macro 'TP_PROTO'
    #define TP_PROTO(args...) args
                              ^~~~
   include/trace/events/iommu.h:81:11: error: expected ')' before 'struct'
     TP_PROTO(struct device *dev),
              ^
   include/linux/tracepoint.h:104:27: note: in definition of macro 'TP_PROTO'
    #define TP_PROTO(args...) args
                              ^~~~
>> include/trace/events/iommu.h:88:11: error: expected ')' before 'unsigned'
     TP_PROTO(unsigned long iova, phys_addr_t paddr, size_t size),
              ^
   include/linux/tracepoint.h:104:27: note: in definition of macro 'TP_PROTO'
    #define TP_PROTO(args...) args
                              ^~~~
   include/trace/events/iommu.h:111:11: error: expected ')' before 'unsigned'
     TP_PROTO(unsigned long iova, size_t size, size_t unmapped_size),
              ^
   include/linux/tracepoint.h:104:27: note: in definition of macro 'TP_PROTO'
    #define TP_PROTO(args...) args
                              ^~~~
   include/trace/events/iommu.h:134:11: error: expected ')' before 'struct'
     TP_PROTO(struct device *dev, unsigned long iova, int flags),
              ^
   include/linux/tracepoint.h:104:27: note: in definition of macro 'TP_PROTO'
    #define TP_PROTO(args...) args
                              ^~~~
   include/trace/events/iommu.h:160:11: error: expected ')' before 'struct'
     TP_PROTO(struct device *dev, unsigned long iova, int flags),
              ^
   include/linux/tracepoint.h:104:27: note: in definition of macro 'TP_PROTO'
    #define TP_PROTO(args...) args
                              ^~~~
>> include/trace/events/iommu.h:20:11: error: expected ')' before 'int'
     TP_PROTO(int group_id, struct device *dev),
              ^
   include/linux/tracepoint.h:104:27: note: in definition of macro 'TP_PROTO'
    #define TP_PROTO(args...) args
                              ^~~~
   include/linux/tracepoint.h:233:20: error: redefinition of '__tpstrtab_add_device_to_group'
     static const char __tpstrtab_##name[]     \
                       ^
   include/linux/tracepoint.h:243:2: note: in expansion of macro 'DEFINE_TRACE_FN'
     DEFINE_TRACE_FN(name, NULL, NULL);
     ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:50:2: note: in expansion of macro 'DEFINE_TRACE'
     DEFINE_TRACE(name)
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:39:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_group_event, add_device_to_group,
    ^~~~~~~~~~~~
   include/linux/tracepoint.h:233:20: note: previous definition of '__tpstrtab_add_device_to_group' was here
     static const char __tpstrtab_##name[]     \
                       ^
   include/linux/tracepoint.h:243:2: note: in expansion of macro 'DEFINE_TRACE_FN'
     DEFINE_TRACE_FN(name, NULL, NULL);
     ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:50:2: note: in expansion of macro 'DEFINE_TRACE'
     DEFINE_TRACE(name)
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:39:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_group_event, add_device_to_group,
    ^~~~~~~~~~~~
   include/linux/tracepoint.h:235:20: error: redefinition of '__tracepoint_add_device_to_group'
     struct tracepoint __tracepoint_##name     \
                       ^
   include/linux/tracepoint.h:243:2: note: in expansion of macro 'DEFINE_TRACE_FN'
     DEFINE_TRACE_FN(name, NULL, NULL);
     ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:50:2: note: in expansion of macro 'DEFINE_TRACE'
     DEFINE_TRACE(name)
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:39:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_group_event, add_device_to_group,
    ^~~~~~~~~~~~
   include/linux/tracepoint.h:235:20: note: previous definition of '__tracepoint_add_device_to_group' was here
     struct tracepoint __tracepoint_##name     \
                       ^
   include/linux/tracepoint.h:243:2: note: in expansion of macro 'DEFINE_TRACE_FN'
     DEFINE_TRACE_FN(name, NULL, NULL);
     ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:50:2: note: in expansion of macro 'DEFINE_TRACE'
     DEFINE_TRACE(name)
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:39:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_group_event, add_device_to_group,
    ^~~~~~~~~~~~
   include/linux/tracepoint.h:238:35: error: redefinition of '__tracepoint_ptr_add_device_to_group'
     static struct tracepoint * const __tracepoint_ptr_##name __used  \
                                      ^
   include/linux/tracepoint.h:243:2: note: in expansion of macro 'DEFINE_TRACE_FN'
     DEFINE_TRACE_FN(name, NULL, NULL);
     ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:50:2: note: in expansion of macro 'DEFINE_TRACE'
     DEFINE_TRACE(name)
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:39:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_group_event, add_device_to_group,
    ^~~~~~~~~~~~
   include/linux/tracepoint.h:238:35: note: previous definition of '__tracepoint_ptr_add_device_to_group' was here
     static struct tracepoint * const __tracepoint_ptr_##name __used  \
                                      ^
   include/linux/tracepoint.h:243:2: note: in expansion of macro 'DEFINE_TRACE_FN'
     DEFINE_TRACE_FN(name, NULL, NULL);
     ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:50:2: note: in expansion of macro 'DEFINE_TRACE'
     DEFINE_TRACE(name)
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:39:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_group_event, add_device_to_group,
    ^~~~~~~~~~~~
   include/linux/tracepoint.h:233:20: error: redefinition of '__tpstrtab_remove_device_from_group'
     static const char __tpstrtab_##name[]     \
                       ^
   include/linux/tracepoint.h:243:2: note: in expansion of macro 'DEFINE_TRACE_FN'
     DEFINE_TRACE_FN(name, NULL, NULL);
     ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:50:2: note: in expansion of macro 'DEFINE_TRACE'
     DEFINE_TRACE(name)
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:47:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_group_event, remove_device_from_group,
    ^~~~~~~~~~~~
   include/linux/tracepoint.h:233:20: note: previous definition of '__tpstrtab_remove_device_from_group' was here
     static const char __tpstrtab_##name[]     \
                       ^
   include/linux/tracepoint.h:243:2: note: in expansion of macro 'DEFINE_TRACE_FN'
     DEFINE_TRACE_FN(name, NULL, NULL);
     ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:50:2: note: in expansion of macro 'DEFINE_TRACE'
     DEFINE_TRACE(name)
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:47:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_group_event, remove_device_from_group,
    ^~~~~~~~~~~~
   include/linux/tracepoint.h:235:20: error: redefinition of '__tracepoint_remove_device_from_group'
     struct tracepoint __tracepoint_##name     \
                       ^
   include/linux/tracepoint.h:243:2: note: in expansion of macro 'DEFINE_TRACE_FN'
     DEFINE_TRACE_FN(name, NULL, NULL);
     ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:50:2: note: in expansion of macro 'DEFINE_TRACE'
     DEFINE_TRACE(name)
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:47:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_group_event, remove_device_from_group,
    ^~~~~~~~~~~~
   include/linux/tracepoint.h:235:20: note: previous definition of '__tracepoint_remove_device_from_group' was here
     struct tracepoint __tracepoint_##name     \
                       ^
   include/linux/tracepoint.h:243:2: note: in expansion of macro 'DEFINE_TRACE_FN'
     DEFINE_TRACE_FN(name, NULL, NULL);
     ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:50:2: note: in expansion of macro 'DEFINE_TRACE'
     DEFINE_TRACE(name)
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:47:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_group_event, remove_device_from_group,
    ^~~~~~~~~~~~
   include/linux/tracepoint.h:238:35: error: redefinition of '__tracepoint_ptr_remove_device_from_group'
     static struct tracepoint * const __tracepoint_ptr_##name __used  \
                                      ^
   include/linux/tracepoint.h:243:2: note: in expansion of macro 'DEFINE_TRACE_FN'
     DEFINE_TRACE_FN(name, NULL, NULL);
     ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:50:2: note: in expansion of macro 'DEFINE_TRACE'
     DEFINE_TRACE(name)
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:47:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_group_event, remove_device_from_group,
    ^~~~~~~~~~~~
   include/linux/tracepoint.h:238:35: note: previous definition of '__tracepoint_ptr_remove_device_from_group' was here
     static struct tracepoint * const __tracepoint_ptr_##name __used  \
                                      ^
   include/linux/tracepoint.h:243:2: note: in expansion of macro 'DEFINE_TRACE_FN'
     DEFINE_TRACE_FN(name, NULL, NULL);
     ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:50:2: note: in expansion of macro 'DEFINE_TRACE'
     DEFINE_TRACE(name)
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:47:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_group_event, remove_device_from_group,
    ^~~~~~~~~~~~
>> include/trace/events/iommu.h:56:11: error: expected ')' before 'struct'
     TP_PROTO(struct device *dev),
              ^
   include/linux/tracepoint.h:104:27: note: in definition of macro 'TP_PROTO'
    #define TP_PROTO(args...) args
                              ^~~~
   include/linux/tracepoint.h:233:20: error: redefinition of '__tpstrtab_attach_device_to_domain'
     static const char __tpstrtab_##name[]     \
                       ^
   include/linux/tracepoint.h:243:2: note: in expansion of macro 'DEFINE_TRACE_FN'
     DEFINE_TRACE_FN(name, NULL, NULL);
     ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:50:2: note: in expansion of macro 'DEFINE_TRACE'
     DEFINE_TRACE(name)
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:72:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_device_event, attach_device_to_domain,
    ^~~~~~~~~~~~
   include/linux/tracepoint.h:233:20: note: previous definition of '__tpstrtab_attach_device_to_domain' was here
     static const char __tpstrtab_##name[]     \
                       ^
   include/linux/tracepoint.h:243:2: note: in expansion of macro 'DEFINE_TRACE_FN'
     DEFINE_TRACE_FN(name, NULL, NULL);
     ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:50:2: note: in expansion of macro 'DEFINE_TRACE'
     DEFINE_TRACE(name)
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:72:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_device_event, attach_device_to_domain,
    ^~~~~~~~~~~~
   include/linux/tracepoint.h:235:20: error: redefinition of '__tracepoint_attach_device_to_domain'
     struct tracepoint __tracepoint_##name     \
                       ^
   include/linux/tracepoint.h:243:2: note: in expansion of macro 'DEFINE_TRACE_FN'
     DEFINE_TRACE_FN(name, NULL, NULL);
     ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:50:2: note: in expansion of macro 'DEFINE_TRACE'
     DEFINE_TRACE(name)
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:72:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_device_event, attach_device_to_domain,
    ^~~~~~~~~~~~
   include/linux/tracepoint.h:235:20: note: previous definition of '__tracepoint_attach_device_to_domain' was here
     struct tracepoint __tracepoint_##name     \
                       ^
   include/linux/tracepoint.h:243:2: note: in expansion of macro 'DEFINE_TRACE_FN'
     DEFINE_TRACE_FN(name, NULL, NULL);
     ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:50:2: note: in expansion of macro 'DEFINE_TRACE'
     DEFINE_TRACE(name)
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:72:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_device_event, attach_device_to_domain,
    ^~~~~~~~~~~~
   include/linux/tracepoint.h:238:35: error: redefinition of '__tracepoint_ptr_attach_device_to_domain'
     static struct tracepoint * const __tracepoint_ptr_##name __used  \
                                      ^
   include/linux/tracepoint.h:243:2: note: in expansion of macro 'DEFINE_TRACE_FN'
     DEFINE_TRACE_FN(name, NULL, NULL);
     ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:50:2: note: in expansion of macro 'DEFINE_TRACE'
     DEFINE_TRACE(name)
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:72:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_device_event, attach_device_to_domain,
    ^~~~~~~~~~~~
   include/linux/tracepoint.h:238:35: note: previous definition of '__tracepoint_ptr_attach_device_to_domain' was here
     static struct tracepoint * const __tracepoint_ptr_##name __used  \
                                      ^
   include/linux/tracepoint.h:243:2: note: in expansion of macro 'DEFINE_TRACE_FN'
     DEFINE_TRACE_FN(name, NULL, NULL);
     ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:50:2: note: in expansion of macro 'DEFINE_TRACE'
     DEFINE_TRACE(name)
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:72:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_device_event, attach_device_to_domain,
    ^~~~~~~~~~~~
   include/linux/tracepoint.h:233:20: error: redefinition of '__tpstrtab_detach_device_from_domain'
     static const char __tpstrtab_##name[]     \
                       ^
   include/linux/tracepoint.h:243:2: note: in expansion of macro 'DEFINE_TRACE_FN'
     DEFINE_TRACE_FN(name, NULL, NULL);
     ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:50:2: note: in expansion of macro 'DEFINE_TRACE'
     DEFINE_TRACE(name)
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:79:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_device_event, detach_device_from_domain,
    ^~~~~~~~~~~~
   include/linux/tracepoint.h:233:20: note: previous definition of '__tpstrtab_detach_device_from_domain' was here
     static const char __tpstrtab_##name[]     \
                       ^
   include/linux/tracepoint.h:243:2: note: in expansion of macro 'DEFINE_TRACE_FN'
     DEFINE_TRACE_FN(name, NULL, NULL);
     ^~~~~~~~~~~~~~~
   include/trace/define_trace.h:50:2: note: in expansion of macro 'DEFINE_TRACE'
     DEFINE_TRACE(name)
     ^~~~~~~~~~~~
   include/trace/events/iommu.h:79:1: note: in expansion of macro 'DEFINE_EVENT'
    DEFINE_EVENT(iommu_device_event, detach_device_from_domain,
..

vim +/trace_io_page_fault +368 include/linux/iommu.h

4f3f8d9d Ohad Ben-Cohen 2011-09-13  362  	 * invoke it.
4f3f8d9d Ohad Ben-Cohen 2011-09-13  363  	 */
4f3f8d9d Ohad Ben-Cohen 2011-09-13  364  	if (domain->handler)
77ca2332 Ohad Ben-Cohen 2012-05-21  365  		ret = domain->handler(domain, dev, iova, flags,
77ca2332 Ohad Ben-Cohen 2012-05-21  366  						domain->handler_token);
4a77a6cf Joerg Roedel   2008-11-26  367  
56fa4849 Shuah Khan     2013-09-24 @368  	trace_io_page_fault(dev, iova, flags);
4f3f8d9d Ohad Ben-Cohen 2011-09-13  369  	return ret;
4a77a6cf Joerg Roedel   2008-11-26  370  }
4a77a6cf Joerg Roedel   2008-11-26  371  

:::::: The code at line 368 was first introduced by commit
:::::: 56fa484969c367e3ae43a012a7b99f75bb4f3bdb iommu: Change iommu driver to call io_page_fault trace event

:::::: TO: Shuah Khan <shuah.kh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
:::::: CC: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--Kj7319i9nmIyA2yE
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--Kj7319i9nmIyA2yE--
