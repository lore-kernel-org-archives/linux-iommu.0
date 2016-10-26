From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH V3 0/8] IOMMU probe deferral support
Date: Wed, 26 Oct 2016 20:14:45 +0530
Message-ID: <003a01d22f97$82534c70$86f9e550$@codeaurora.org>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
	<60ee8066-f167-e9df-ae3e-4138f1133bad@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <60ee8066-f167-e9df-ae3e-4138f1133bad-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Robin Murphy' <robin.murphy-5wv7dgnIgG8@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

>On 04/10/16 18:03, Sricharan R wrote:
>> Initial post from Laurent Pinchart[1]. This is
>> series calls the dma ops configuration for the devices
>> at a generic place so that it works for all busses.
>> The dma_configure_ops for a device is now called during
>> the device_attach callback just before the probe of the
>> bus/driver is called. Similarly dma_deconfigure is called during
>> device/driver_detach path.
>>
>>
>> pci_bus_add_devices    (platform/amba)(_device_create/driver_register)
>>        |                         |
>> pci_bus_add_device     (device_add/driver_register)
>>        |                         |
>> device_attach           device_initial_probe
>>        |                         |
>> __device_attach_driver    __device_attach_driver
>>        |
>> driver_probe_device
>>        |
>> really_probe
>>        |
>> dma_configure
>>
>>  Similarly on the device/driver_unregister path __device_release_driver is
>>  called which inturn calls dma_deconfigure.
>>
>>  If the ACPI bus code follows the same, we can add acpi_dma_configure
>>  at the same place as of_dma_configure.
>>
>>  This series is based on the recently merged Generic DT bindings for
>>  PCI IOMMUs and ARM SMMU from Robin Murphy robin.murphy-5wv7dgnIgG8@public.gmane.org [2]
>>
>>  This time tested this with platform and pci device for probe deferral
>>  and reprobe on arm64 based platform. There is an issue on the cleanup
>>  path for arm64 though, where there is WARN_ON if the dma_ops is reset while
>>  device is attached to an domain in arch_teardown_dma_ops.
>>  But with iommu_groups created from the iommu driver, the device is always
>>  attached to a domain/default_domain. So so the WARN has to be removed/handled
>>  probably.
>
>I've finally got the chance to take a proper look at this series (sorry
>for the delay). First up, with these patches on top of 4.9-rc2, my
>little script for unbinding some PCI devices and rebinding them to VFIO
>now goes horribly, horribly wrong.
>
>Robin.
>

   Thanks for looking in to this.
    I was trying to reproduce the below with a command like this in my setup.

echo 0002\:00\:00.0 >  /sys/bus/pci/devices/0002\:00\:000.0/driver/unbind0.0/driver/unbind
echo 0x17cb 0x0104 > /sys/bus/pci/drivers/vfio-pci/new_id

But for me the unbind and reconfiguring/adding the iommus_ops to vfio-pci did
succeed, although the WARN_ON in arch_teardown_dma_ops was there, that
could be suppresed.  The vfio_pci_probe was not going through because
 the pci hdr_type was not PCI_HEADER_TYPE_NORMAL.
 But anyways iommu unbind/rebind seemed to be going through.

If i can get what your script is doing, i can try that and see what happens.

Regards,
  Sricharan



>[   39.901592] iommu: Removing device 0000:08:00.0 from group 0
>[   39.907383] ------------[ cut here ]------------
>[   39.911969] WARNING: CPU: 0 PID: 174 at
>arch/arm64/mm/dma-mapping.c:856 arch_teardown_dma_ops+0x48/0x68
>[   39.921266] Modules linked in:
>[   39.924290]
>[   39.925766] CPU: 0 PID: 174 Comm: vfio Not tainted 4.9.0-rc2+ #1249
>[   39.931967] Hardware name: ARM Juno development board (r1) (DT)
>[   39.937826] task: ffffffc975ee9900 task.stack: ffffffc974d60000
>[   39.943687] PC is at arch_teardown_dma_ops+0x48/0x68
>[   39.948603] LR is at arch_teardown_dma_ops+0x34/0x68
>[   39.953516] pc : [<ffffff80080948f8>] lr : [<ffffff80080948e4>]
>pstate: 60000145
>[   39.960834] sp : ffffffc974d63ca0
>[   39.964112] x29: ffffffc974d63ca0 x28: ffffffc974d60000
>[   39.969377] x27: ffffff80088a2000 x26: 0000000000000040
>[   39.974642] x25: 0000000000000123 x24: ffffffc976a48918
>[   39.979907] x23: ffffffc974d63eb8 x22: ffffff8008db7550
>[   39.985171] x21: 000000000000000d x20: ffffffc9763e9b50
>[   39.990435] x19: ffffffc9763f20a0 x18: 0000000000000010
>[   39.995699] x17: 0000007f99c18018 x16: ffffff80080c0580
>[   40.000964] x15: ffffff8008bb7000 x14: 000137c100013798
>[   40.006228] x13: ffffffffff000000 x12: ffffffffffffffff
>[   40.011492] x11: 0000000000000018 x10: 000000000000000d
>[   40.016757] x9 : 0000000040000000 x8 : 0000000000210d00
>[   40.022021] x7 : 00000049771bc000 x6 : 00000000001f17ed
>[   40.027286] x5 : ffffff80084c4208 x4 : 0000000000000080
>[   40.032551] x3 : ffffffc975ea9800 x2 : ffffffbf25d7aa50
>[   40.037815] x1 : 0000000000000000 x0 : 0000000000000080
>[   40.043078]
>[   40.044549] ---[ end trace 35c1e743d6e6c035 ]---
>[   40.049117] Call trace:
>[   40.051537] Exception stack(0xffffffc974d63ad0 to 0xffffffc974d63c00)
>[   40.057914] 3ac0:                                   ffffffc9763f20a0
>0000008000000000
>[   40.065668] 3ae0: ffffffc974d63ca0 ffffff80080948f8 ffffffbf25d7aa40
>ffffffc975ea9800
>[   40.073421] 3b00: ffffffc974d60000 000000000002fc80 ffffffc976801e00
>ffffffc974d60000
>[   40.081175] 3b20: ffffff80084c4208 0000000000000040 ffffff80088a2000
>ffffffc974d60000
>[   40.088928] 3b40: ffffff80084caf78 ffffffc974d60000 ffffffc974d60000
>ffffffc974d60000
>[   40.096682] 3b60: ffffffc975ea9800 ffffffc974d60000 0000000000000080
>0000000000000000
>[   40.104435] 3b80: ffffffbf25d7aa50 ffffffc975ea9800 0000000000000080
>ffffff80084c4208
>[   40.112188] 3ba0: 00000000001f17ed 00000049771bc000 0000000000210d00
>0000000040000000
>[   40.119941] 3bc0: 000000000000000d 0000000000000018 ffffffffffffffff
>ffffffffff000000
>[   40.127695] 3be0: 000137c100013798 ffffff8008bb7000 ffffff80080c0580
>0000007f99c18018
>[   40.135450] [<ffffff80080948f8>] arch_teardown_dma_ops+0x48/0x68
>[   40.141400] [<ffffff8008764a14>] of_dma_deconfigure+0xc/0x18
>[   40.147005] [<ffffff8008552804>] dma_deconfigure+0xc/0x18
>[   40.152353] [<ffffff800853ba10>] __device_release_driver+0x88/0x120
>[   40.158560] [<ffffff800853bacc>] device_release_driver+0x24/0x38
>[   40.164507] [<ffffff800853a868>] unbind_store+0xe8/0x110
>[   40.169767] [<ffffff8008539c70>] drv_attr_store+0x20/0x30
>[   40.175113] [<ffffff800823ab18>] sysfs_kf_write+0x48/0x58
>[   40.180458] [<ffffff8008239ea8>] kernfs_fop_write+0xb0/0x1d8
>[   40.186063] [<ffffff80081c507c>] __vfs_write+0x1c/0x100
>[   40.191237] [<ffffff80081c5e80>] vfs_write+0xa0/0x1b8
>[   40.196239] [<ffffff80081c7274>] SyS_write+0x44/0xa0
>[   40.201155] [<ffffff8008082ef0>] el0_svc_naked+0x24/0x28
>[   40.206703] vfio-pci 0000:08:00.0: Failed to setup iommu ops
>[   40.212382] vfio-pci: probe of 0000:08:00.0 failed with error -22
>[   40.228075] ------------[ cut here ]------------
>[   40.235263] WARNING: CPU: 1 PID: 174 at ./include/linux/kref.h:46
>kobject_get+0x64/0x88
>[   40.243181] Modules linked in:
>[   40.246201]
>[   40.247673] CPU: 1 PID: 174 Comm: vfio Tainted: G        W
>4.9.0-rc2+ #1249
>[   40.255076] Hardware name: ARM Juno development board (r1) (DT)
>[   40.260932] task: ffffffc975ee9900 task.stack: ffffffc974d60000
>[   40.266787] PC is at kobject_get+0x64/0x88
>[   40.270840] LR is at iommu_bus_notifier+0x40/0x110
>[   40.275577] pc : [<ffffff800834d20c>] lr : [<ffffff80084c3fd0>]
>pstate: 80000145
>[   40.282894] sp : ffffffc974d63c00
>[   40.286169] x29: ffffffc974d63c00 x28: ffffffc974d60000
>[   40.291431] x27: ffffff80088a2000 x26: 0000000000000040
>[   40.296692] x25: 0000000000000123 x24: ffffffc974c8f418
>[   40.301953] x23: 0000000000000006 x22: ffffffc9763f10a0
>[   40.307214] x21: ffffffc9763e9a00 x20: ffffffc9763f10a0
>[   40.312474] x19: ffffffc9763ebc80 x18: 0000007fd65069e0
>[   40.317734] x17: 0000007f8d0ae3c0 x16: ffffff80081c7230
>[   40.322995] x15: 0000007f8d136588 x14: ffffffffffffffff
>[   40.328255] x13: 0000000000000004 x12: 0000000000000030
>[   40.333515] x11: 0000000000000030 x10: 0101010101010101
>[   40.338775] x9 : feff716475687163 x8 : 7f7f7f7f7f7f7f7f
>[   40.344035] x7 : feff716475687163 x6 : ffffffc976abf400
>[   40.349295] x5 : ffffffc976abf400 x4 : 0000000000000000
>[   40.354555] x3 : ffffff80084c3f90 x2 : ffffffc9763ebcb8
>[   40.359814] x1 : 0000000000000001 x0 : ffffff8008d4f000
>[   40.365074]
>[   40.366542] ---[ end trace 35c1e743d6e6c036 ]---
>[   40.371107] Call trace:
>[   40.373523] Exception stack(0xffffffc974d63a30 to 0xffffffc974d63b60)
>[   40.379895] 3a20:                                   ffffffc9763ebc80
>0000008000000000
>[   40.387643] 3a40: ffffffc974d63c00 ffffff800834d20c ffffffc976812400
>ffffff8008237d94
>[   40.395391] 3a60: ffffffbf25d78940 ffffffc974d60000 ffffffc975e259d8
>0000000000005b81
>[   40.403139] 3a80: ffffffc974d60000 ffffff8008d4b31f ffffff8008b0f000
>ffffffc976811c80
>[   40.410887] 3aa0: ffffffc974d60000 ffffffc974d60000 ffffffc974d60000
>ffffff8008237000
>[   40.418634] 3ac0: ffffffc975e259d8 ffffff8008b1b9a8 ffffff8008d4f000
>0000000000000001
>[   40.426382] 3ae0: ffffffc9763ebcb8 ffffff80084c3f90 0000000000000000
>ffffffc976abf400
>[   40.434130] 3b00: ffffffc976abf400 feff716475687163 7f7f7f7f7f7f7f7f
>feff716475687163
>[   40.441877] 3b20: 0101010101010101 0000000000000030 0000000000000030
>0000000000000004
>[   40.449625] 3b40: ffffffffffffffff 0000007f8d136588 ffffff80081c7230
>0000007f8d0ae3c0
>[   40.457372] [<ffffff800834d20c>] kobject_get+0x64/0x88
>[   40.462455] [<ffffff80084c3fd0>] iommu_bus_notifier+0x40/0x110
>[   40.468227] [<ffffff80080da288>] notifier_call_chain+0x50/0x90
>[   40.473997] [<ffffff80080da694>] __blocking_notifier_call_chain+0x4c/0x90
>[   40.480713] [<ffffff80080da6ec>] blocking_notifier_call_chain+0x14/0x20
>[   40.487259] [<ffffff800853b9e4>] __device_release_driver+0x5c/0x120
>[   40.493460] [<ffffff800853bacc>] device_release_driver+0x24/0x38
>[   40.499402] [<ffffff800853a868>] unbind_store+0xe8/0x110
>[   40.504656] [<ffffff8008539c70>] drv_attr_store+0x20/0x30
>[   40.509997] [<ffffff800823ab18>] sysfs_kf_write+0x48/0x58
>[   40.515337] [<ffffff8008239ea8>] kernfs_fop_write+0xb0/0x1d8
>[   40.520936] [<ffffff80081c507c>] __vfs_write+0x1c/0x100
>[   40.526104] [<ffffff80081c5e80>] vfs_write+0xa0/0x1b8
>[   40.531100] [<ffffff80081c7274>] SyS_write+0x44/0xa0
>[   40.536011] [<ffffff8008082ef0>] el0_svc_naked+0x24/0x28
>[   40.541324] ata1.00: disabled
>[   40.544878] sd 0:0:0:0: [sda] Synchronizing SCSI cache
>[   40.550062] sd 0:0:0:0: [sda] Synchronize Cache(10) failed: Result:
>hostbyte=0x04 driverbyte=0x00
>[   40.558871] sd 0:0:0:0: [sda] Stopping disk
>[   40.563037] sd 0:0:0:0: [sda] Start/Stop Unit failed: Result:
>hostbyte=0x04 driverbyte=0x00
>[   40.586990] Unable to handle kernel paging request at virtual address
>0002003e
>[   40.594702] pgd = ffffffc974c80000
>[   40.598165] [0002003e] *pgd=00000009f5102003[   40.602241] ,
>*pud=00000009f5102003
>, *pmd=0000000000000000[   40.607694]
>[   40.609171] Internal error: Oops: 96000006 [#1] PREEMPT SMP
>[   40.614684] Modules linked in:
>[   40.617712] CPU: 3 PID: 174 Comm: vfio Tainted: G        W
>4.9.0-rc2+ #1249
>[   40.625118] Hardware name: ARM Juno development board (r1) (DT)
>[   40.630977] task: ffffffc975ee9900 task.stack: ffffffc974d60000
>[   40.636841] PC is at kobject_get+0x14/0x88
>[   40.640897] LR is at iommu_get_domain_for_dev+0x1c/0x48
>[   40.646068] pc : [<ffffff800834d1bc>] lr : [<ffffff80084c3dec>]
>pstate: 60000145
>[   40.653387] sp : ffffffc974d63c60
>[   40.656664] x29: ffffffc974d63c60 x28: ffffffc974d60000
>[   40.661928] x27: ffffff80088a2000 x26: 0000000000000040
>[   40.667193] x25: 0000000000000123 x24: ffffffc974c8f418
>[   40.672457] x23: ffffffc974d63eb8 x22: ffffff8008dab568
>[   40.677720] x21: 000000000000000d x20: ffffff8008dab568
>[   40.682984] x19: 0000000000020002 x18: 0000000000000000
>[   40.688246] x17: 0000000000000007 x16: 0000000000000001
>[   40.693509] x15: ffffffc974cd091c x14: ffffffffffffffff
>[   40.698773] x13: ffffffc974cd01cd x12: 0000000000000030
>[   40.704036] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
>[   40.709300] x9 : 0000000040000000 x8 : 0000000000210d00
>[   40.714563] x7 : ffffffc975f95018 x6 : 0000000000000000
>[   40.719826] x5 : 0000000000000000 x4 : ffffffc9763f1210
>[   40.725088] x3 : 0000000000000000 x2 : ffffffc9763f10e8
>[   40.730351] x1 : 0000000000000000 x0 : 0000000000020002
>[   40.735613]
>[   40.737085] Process vfio (pid: 174, stack limit = 0xffffffc974d60020)
>[   40.743460] Stack: (0xffffffc974d63c60 to 0xffffffc974d64000)
>[   40.749150] 3c60: ffffffc974d63c80 ffffff80084c3dec ffffffc9763e9a00
>ffffff80085377a4
>[   40.756904] 3c80: ffffffc974d63ca0 ffffff80080948c4 ffffffc9763f10a0
>ffffff8008dab568
>[   40.764658] 3ca0: ffffffc974d63cc0 ffffff8008764a14 ffffffc9763f10a0
>ffffff8008dab568
>[   40.772411] 3cc0: ffffffc974d63cd0 ffffff8008552804 ffffffc974d63ce0
>ffffff800853ba10
>[   40.780165] 3ce0: ffffffc974d63d00 ffffff800853bacc ffffffc9763f1100
>ffffffc9763f10a0
>[   40.787918] 3d00: ffffffc974d63d20 ffffff800853a868 ffffff8008d68f18
>ffffffc9763f10a0
>[   40.795672] 3d20: ffffffc974d63d50 ffffff8008539c70 000000000000000d
>ffffffc974c8f400
>[   40.803425] 3d40: ffffffc9757d5880 0000000000000000 ffffffc974d63d60
>ffffff800823ab18
>[   40.811178] 3d60: ffffffc974d63d70 ffffff8008239ea8 ffffffc974d63dc0
>ffffff80081c507c
>[   40.818931] 3d80: 000000000000000d 0000000000000000 ffffffc974c8f100
>ffffffc974d63eb8
>[   40.826684] 3da0: 000000001285f6a0 0000000000000015 0000000000000123
>ffffff80080bf6ac
>[   40.834437] 3dc0: ffffffc974d63e40 ffffff80081c5e80 000000000000000d
>0000000000000000
>[   40.842190] 3de0: ffffffc974d63e30 ffffff80080c087c ffffffc974d63e20
>ffffff80081c5c0c
>[   40.849943] 3e00: ffffffc974c8f100 0000000000000001 ffffffc974c8f100
>ffffffc974d63eb8
>[   40.857696] 3e20: ffffffc974d63e40 ffffff80081c5f48 000000000000000d
>ffffffc974c8f100
>[   40.865450] 3e40: ffffffc974d63e80 ffffff80081c7274 ffffffc974c8f100
>ffffffc974c8f100
>[   40.873203] 3e60: 000000001285f6a0 000000000000000d 0000000060000000
>0000000000000000
>[   40.880956] 3e80: 0000000000000000 ffffff8008082ef0 0000000000000000
>0000000000000001
>[   40.888709] 3ea0: ffffffffffffffff 0000007f8d0ae3dc 0000000000000000
>0000000000000000
>[   40.896461] 3ec0: 0000000000000001 000000001285f6a0 000000000000000d
>0000000000000000
>[   40.904215] 3ee0: ae2e2e2e3f464b49 0000000000000000 000000001285f6b0
>39322f392f2f2f2f
>[   40.911968] 3f00: 0000000000000040 fefefeff2f2d2f2f 7f7f7f7f7f7f7f7f
>0101010101010101
>[   40.919721] 3f20: 0000000000000002 0000000000000004 ffffffffffffffff
>0000007f8d136588
>[   40.927474] 3f40: 0000000000000000 0000007f8d0ae3c0 0000007fd65069e0
>00000000004ee000
>[   40.935226] 3f60: 0000000000000001 000000001285f6a0 000000000000000d
>0000000000000001
>[   40.942980] 3f80: 0000000000000020 000000001285eed8 00000000004ba158
>0000000000000000
>[   40.950732] 3fa0: 0000000000000000 0000007fd6507f30 000000000040e74c
>0000007fd6507130
>[   40.958485] 3fc0: 0000007f8d0ae3dc 0000000060000000 0000000000000001
>0000000000000040
>[   40.966238] 3fe0: 0000000000000000 0000000000000000 0000002000103a00
>4000000010000000
>[   40.973986] Call trace:
>[   40.976405] Exception stack(0xffffffc974d63a90 to 0xffffffc974d63bc0)
>[   40.982780] 3a80:                                   0000000000020002
>0000008000000000
>[   40.990533] 3aa0: ffffffc974d63c60 ffffff800834d1bc ffffffc974d63ae0
>ffffff80085377a4
>[   40.998287] 3ac0: ffffffc974d63b10 ffffff8008537424 ffffffc975e3ac28
>ffffffc975e3ac38
>[   41.006041] 3ae0: ffffffc974d63b30 ffffff80081737cc ffffffc975e3ac38
>ffffff8008da62c0
>[   41.013794] 3b00: ffffffc975e98100 ffffff80085401b0 0000000000000001
>ffffff8008540a08
>[   41.021547] 3b20: 00000000000036b8 0000000000000040 0000000000020002
>0000000000000000
>[   41.029300] 3b40: ffffffc9763f10e8 0000000000000000 ffffffc9763f1210
>0000000000000000
>[   41.037053] 3b60: 0000000000000000 ffffffc975f95018 0000000000210d00
>0000000040000000
>[   41.044805] 3b80: 7f7f7f7f7f7f7f7f 0101010101010101 0000000000000030
>ffffffc974cd01cd
>[   41.052558] 3ba0: ffffffffffffffff ffffffc974cd091c 0000000000000001
>0000000000000007
>[   41.060311] [<ffffff800834d1bc>] kobject_get+0x14/0x88
>[   41.065398] [<ffffff80084c3dec>] iommu_get_domain_for_dev+0x1c/0x48
>[   41.071607] [<ffffff80080948c4>] arch_teardown_dma_ops+0x14/0x68
>[   41.077556] [<ffffff8008764a14>] of_dma_deconfigure+0xc/0x18
>[   41.083161] [<ffffff8008552804>] dma_deconfigure+0xc/0x18
>[   41.088509] [<ffffff800853ba10>] __device_release_driver+0x88/0x120
>[   41.094715] [<ffffff800853bacc>] device_release_driver+0x24/0x38
>[   41.100663] [<ffffff800853a868>] unbind_store+0xe8/0x110
>[   41.105922] [<ffffff8008539c70>] drv_attr_store+0x20/0x30
>[   41.111268] [<ffffff800823ab18>] sysfs_kf_write+0x48/0x58
>[   41.116612] [<ffffff8008239ea8>] kernfs_fop_write+0xb0/0x1d8
>[   41.122216] [<ffffff80081c507c>] __vfs_write+0x1c/0x100
>[   41.127390] [<ffffff80081c5e80>] vfs_write+0xa0/0x1b8
>[   41.132391] [<ffffff80081c7274>] SyS_write+0x44/0xa0
>[   41.137307] [<ffffff8008082ef0>] el0_svc_naked+0x24/0x28
>[   41.142567] Code: 910003fd f9000bf3 aa0003f3 b4000180 (3940f000)
>[   41.148667] ---[ end trace 35c1e743d6e6c037 ]---
>Segmentation fault
>/ #
>
>
>_______________________________________________
>linux-arm-kernel mailing list
>linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
>http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
