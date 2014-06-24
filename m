From: Alvise Rigo <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: Vfio-on-arm: the device tree does not contain the DMA device
Date: Tue, 24 Jun 2014 16:50:24 +0200
Message-ID: <53A99030.4030901@virtualopensystems.com>
References: <53A0FA5D.5090204@huawei.com>
	<53A192FE.2070303@virtualopensystems.com>
	<53A2AA0E.3060207@huawei.com>
	<a96a278c8fd04586b8120c48b78cb963@BLUPR03MB566.namprd03.prod.outlook.com>
	<53A2AF80.5080705@huawei.com>
	<53A2BFAA.2050507@virtualopensystems.com>
	<53A2C57A.9050504@huawei.com>
	<53A2C8D5.4070801@virtualopensystems.com>
	<53A2D2B2.2040902@huawei.com>
	<cf15be43f0964293a969c5a93f3c5d54@BLUPR03MB566.namprd03.prod.outlook.com>
	<53A2D4A2.9070600@huawei.com>
	<a6fcdaa299594393a4274ed44d49ae46@BLUPR03MB566.namprd03.prod.outlook.com>
	<53A3A315.4010409@huawei.com>
	<53A3DFA7.4060006@virtualopensystems.com>
	<53A3EF9C.8040405@huawei.com>
	<53A3F2CC.1030800@virtualopensystems.com>
	<53A921D7.9060306@huawei.com>
	<a161f9f0084f4b25b544db91cfd48dcc@BLUPR03MB566.namprd03.prod.outlook.com>
	<53A92CB1.3010203@huawei.com>
	<343b7fe9d9d44a18b44ab031d8e00db6@BLUPR03MB566.namprd03.prod.outlook.com>
	<53A93E3B.4060802@huawei.com>
	<53A94180.8080404@virtualopensystems.com>
	<53A97ACC.2060300@huawei.c om>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <53A97ACC.2060300-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shannon Zhao <zhaoshenglong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, "zhangchengxing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <zhangchengxing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hello,

This is a known error, caused by using the last version of VFIO with an
old version of QEMU.
Try to use the vfio-platform-v4 kernel, if it still doesn't work, use
the vfio-platform-v5.

Regards,
alvise

Il 24/06/2014 15:19, Shannon Zhao ha scritto:
> Hi Alvise,
> 
> Thanks for your help.
> I'm using pl330-vfio-dev branch but it's not up-to-date.
> Then I update the qemu code.
> Now I can start up the guest.
> 
> I run the following cmd in guest :
> 
> 	echo 1 > /sys/kernel/debug/vosys_dmatest/start
> 		dmaengine: dma_sync_wait: timeout!
> 		vosys dmatest: tx error
> 		vosys dmatest: src and destination do not match
> 	dmesg | grep vosys
> 		vosys dmatest: vosys dmatest module init
> 		vosys dmatest: tx error
> 		vosys dmatest: tx completed
> And at the terminal running isim_system there is an error :
> 
> 	ERROR: DMAC330 channel thread abort.
> 	ERROR: DMAC330: Instruction fetch ERROR, thread set to FAULTING state
> 
> Is there something wrong?
> 
> Thanks,
> Shannon
> 
> 
> On 2014/6/24 17:14, Alvise Rigo wrote:
>> This is a QEMU error. Are you using the pl330-vfio-dev branch? Is it
>> up-to-date?
>>
>> alvise
>>
>> Il 24/06/2014 11:00, Shannon Zhao ha scritto:
>>> Hi Bharat,
>>>
>>>
>>> ls -l /sys/bus/platform/devices/2c0a0000.dma/iommu_group/devices
>>> total 0
>>> lrwxrwxrwx 1 root root 0 Jan  1 02:58 2c0a0000.dma -> ../../../../devices/2c0a0000.dma
>>>
>>> Then I run "echo 2c0a0000.dma > /sys/bus/platform/drivers/vfio-platform/bind". There is /dev/vfio/0.
>>>
>>> But there is also an error reported.
>>>
>>> 	-nographic can not be used with -daemonize
>>> 	char device redirected to /dev/pts/3 (label pty0-base)
>>> 	PL330_VFIO: === VFIO device file descriptor 13 ===
>>> 	Device has 1 region(s):
>>> 	PL330_VFIO: - Region 0: size=0x1000 offset=0x0 flags=0x7
>>> 	PL330_VFIO: - IRQ 0: range of 1, flags=0x7
>>> 	PL330_VFIO: - IRQ 1: range of 1, flags=0x7
>>> 	PL330_VFIO: - IRQ 2: range of 1, flags=0x7
>>> 	PL330_VFIO: - IRQ 3: range of 1, flags=0x7
>>> 	PL330_VFIO: - IRQ 4: range of 1, flags=0x7
>>> 	qemu-system-arm: -device pl330,vfio_group=/dev/vfio/0,vfio_device=2c0a0000.dma,vfio_container=/dev/vfio/vfio: Property '.vfio_group' not found
>>>
>>> Thanks,
>>> Shannon
>>> On 2014/6/24 16:08, Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Shannon Zhao [mailto:zhaoshenglong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org]
>>>>> Sent: Tuesday, June 24, 2014 1:16 PM
>>>>> To: Bhushan Bharat-R65777; Alvise Rigo; a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org;
>>>>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org;
>>>>> zhangchengxing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
>>>>> Subject: Re: Vfio-on-arm: the device tree does not contain the DMA device
>>>>>
>>>>> Hi Bharat,
>>>>>
>>>>> Thanks for your help.
>>>>>
>>>>> I executed the following cmd:
>>>>> 	echo vfio-platform >
>>>>> /sys/bus/platform/devices/2c0a0000.dma/driver_override
>>>>
>>>> You have to bind the device with vfio-platform driver after the above command.
>>>>
>>>>> But there is no /dev/vfio/0 and error reported starting guest
>>>>>
>>>>> 	-nographic can not be used with -daemonize
>>>>> 	char device redirected to /dev/pts/3 (label pty0-base)
>>>>> 	PL330_VFIO: Group is not viable (not all devices bound for vfio)
>>>>
>>>> A bit surprised; it should be failing when opening /dev/vfio/0 but it is failing in VFIO_GROUP_GET_STATUS ioctl.
>>>>
>>>> Also looks like there are more device attached to the said iommu-group.
>>>> Can check by running below command:
>>>> #ls -l /sys/bus/pci/devices/2c0a0000.dma/iommu_group/devices
>>>>
>>>> Thanks
>>>> -Bharat
>>>>
>>>>> 	qemu-system-arm: Error while probing real device.
>>>>>
>>>>> 	qemu-system-arm: Initialization of device pl330 failed Is there something
>>>>> wrong?
>>>>>
>>>>> Thank you very much.
>>>>> Shannon
>>>>>
>>>>> On 2014/6/24 15:05, Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:
>>>>>>
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: Shannon Zhao [mailto:zhaoshenglong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org]
>>>>>>> Sent: Tuesday, June 24, 2014 12:30 PM
>>>>>>> To: Alvise Rigo; Bhushan Bharat-R65777;
>>>>>>> a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
>>>>>>> kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org; zhangchengxing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
>>>>>>> Subject: Re: Vfio-on-arm: the device tree does not contain the DMA
>>>>>>> device
>>>>>>>
>>>>>>> Hi Alvise,
>>>>>>>
>>>>>>> Thanks for your help.
>>>>>>> Now I can see /dev/vfio/vfio and /dev/vfio/0 after executing "echo
>>>>>>> 2c0a0000.dma
>>>>>>>> /sys/bus/platform/drivers/vfio-platform/vfio_bind".
>>>>>>> But when using qemu to start guest, there is an error :
>>>>>>>
>>>>>>> -nographic can not be used with -daemonize char device redirected to
>>>>>>> /dev/pts/3 (label pty0-base)
>>>>>>> PL330_VFIO: === VFIO device file descriptor 13 === Device has 1
>>>>>>> region(s):
>>>>>>> PL330_VFIO: - Region 0: size=0x1000 offset=0x2c0a0000 flags=0x7
>>>>>>> PL330_VFIO: - IRQ 0: range of 1, flags=0x7 ------------[ cut here
>>>>>>> ]------------ kernel BUG at mm/slub.c:3386!
>>>>>>> Internal error: Oops - BUG: 0 [#1] SMP ARM Modules linked in:
>>>>>>> CPU: 2 PID: 1746 Comm: qemu-system-arm Tainted: G        W    3.14.0-rc1+ #19
>>>>>>> task: ee665580 ti: ed0b8000 task.ti: ed0b8000 PC is at
>>>>>>> kfree+0x128/0x134 LR is at vfio_set_trigger.isra.5+0x40/0x104
>>>>>>> pc : [<800d9e3c>]    lr : [<80319094>]    psr: 400f0013
>>>>>>> sp : ed0b9e64  ip : 000800f3  fp : 000014ac
>>>>>>> r10: 00000000  r9 : ed0b8000  r8 : edeb3b80
>>>>>>> r7 : 0000000e  r6 : 80620584  r5 : 00000000  r4 : eea0b000
>>>>>>> r3 : 00000400  r2 : 800f38b0  r1 : eea0ce60  r0 : 00000400
>>>>>>> Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>>>>>>> Control: 30c53c7d  Table: eddac080  DAC: 00000000 Process
>>>>>>> qemu-system-arm (pid: 1746, stack limit = 0xed0b8240)
>>>>>>> Stack: (0xed0b9e64 to 0xed0ba000)
>>>>>>> 9e60:          ee603700 00000000 ee603700 0000000e edeb3b80 00000000 80319094
>>>>>>> 9e80: ee603700 00003b6e 00000000 edeb3b80 ee603700 00003b6e 0000000d
>>>>>>> 80319208
>>>>>>> 9ea0: 0000000e edeb3b80 80492a18 edeb3b80 ee57f780 80319690 00000024
>>>>>>> 008b2074
>>>>>>> 9ec0: 008b2074 8031886c 00000001 008b2074 00000018 00000024 00000000
>>>>>>> 00000000
>>>>>>> 9ee0: 00000001 00000004 00000001 00000001 ee088e70 008b2060 ee57f780
>>>>>>> 803155d0
>>>>>>> 9f00: 803155b0 800ef430 80477a58 00080802 ed0b8000 800e1358 00000020
>>>>>>> ed0b9f50
>>>>>>> 9f20: ed0b9f60 00000003 8061e808 00080802 ed0b9f60 800e14f0 00000000
>>>>>>> 806522f8
>>>>>>> 9f40: 80477a58 8061e808 ede4c1c0 8011af18 00000000 00000009 8053bbc0
>>>>>>> 00000000
>>>>>>> 9f60: ee683610 00000001 ee57f780 008b2060 00003b6e 0000000d ed0b8000
>>>>>>> 00000000
>>>>>>> 9f80: 000014ac 800ef9ac 0000000e 00000001 008b2060 00429eb0 0000000d
>>>>>>> 00000036
>>>>>>> 9fa0: 8001c464 8001c2e0 008b2060 00429eb0 0000000d 00003b6e 008b2060
>>>>>>> 00000001
>>>>>>> 9fc0: 008b2060 00429eb0 0000000d 00000036 00000000 7ea99040 0089a220
>>>>>>> 000014ac
>>>>>>> 9fe0: 003fa474 7ea98fc4 000bc5c8 76ceb2ec 200f0010 0000000d 00000000
>>>>>>> 8062c770 [<800d9e3c>] (kfree) from [<80319094>]
>>>>>>> (vfio_set_trigger.isra.5+0x40/0x104)
>>>>>>> [<80319094>] (vfio_set_trigger.isra.5) from [<80319208>]
>>>>>>> (vfio_platform_set_irq_trigger+0xb0/0x144)
>>>>>>> [<80319208>] (vfio_platform_set_irq_trigger) from [<80319690>]
>>>>>>> (vfio_platform_set_irqs_ioctl+0x44/0x58)
>>>>>>> [<80319690>] (vfio_platform_set_irqs_ioctl) from [<8031886c>]
>>>>>>> (vfio_platform_ioctl+0x2e0/0x314)
>>>>>>> [<8031886c>] (vfio_platform_ioctl) from [<803155d0>]
>>>>>>> (vfio_device_fops_unl_ioctl+0x20/0x2c)
>>>>>>> [<803155d0>] (vfio_device_fops_unl_ioctl) from [<800ef430>]
>>>>>>> (do_vfs_ioctl+0x78/0x5b8)
>>>>>>> [<800ef430>] (do_vfs_ioctl) from [<800ef9ac>] (SyS_ioctl+0x3c/0x5c)
>>>>>>> [<800ef9ac>] (SyS_ioctl) from [<8001c2e0>]
>>>>>>> (ret_fast_syscall+0x0/0x30)
>>>>>>> Code: 15913038 e1a01003 e8bd45f0 eaff28e5 (e7f001f2)
>>>>>>>
>>>>>>> I'm using branch vfio-platform-v4 for kernel and pl330-vfio-dev for qemu.
>>>>>>> Following is qemu cmdline:
>>>>>>> 	./qemu-system-arm -enable-kvm -M vexpress-a15 -cpu cortex-a15 \
>>>>>>>        	-chardev pty,id=pty0,mux=on -monitor chardev:pty0 \
>>>>>>>        	-serial chardev:pty0 -daemonize \
>>>>>>>        	-device
>>>>>>> pl330,vfio_group="/dev/vfio/0",vfio_device="2c0a0000.dma",vfio_contai
>>>>>>> ner="/dev/v
>>>>>>> fio/vfio" \
>>>>>>>        	-append "earlyprintk ip=dhcp console=ttyAMA0 rootwait" \
>>>>>>>        	-kernel zImage -dtb guest-a15.dtb -initrd filesystem.cpio.gz
>>>>>>> - nographic
>>>>>>>
>>>>>>> If I change to branch vfio-platform-v6 for kernel, there is "/dev/vfio/vfio".
>>>>>>> But no "/sys/bus/platform/drivers/vfio-platform/vfio_bind".
>>>>>>
>>>>>> Can you Check if you have driver_override at
>>>>> "/sys/bus/platform/devices/DEVICE-XXX/ ?
>>>>>> If yes then you should use driver_override mechanism to bind that device to
>>>>> vfio-platform driver.
>>>>>>
>>>>>> Thanks
>>>>>> -Bharat
>>>>>>
>>>>>>> And if I use above qemu cmdline to start guest, there is also an error :
>>>>>>> 	PL330_VFIO: Group is not viable (not all devices bound for vfio)
>>>>>>> 	qemu-system-arm: Error while probing real device.
>>>>>>>
>>>>>>> 	qemu-system-arm: Initialization of device pl330 failed
>>>>>>>
>>>>>>> The usage about v4 and v6 has changed ?
>>>>>>> And would you tell me when you will update the guideline about vfio-on-arm?
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Shannon
>>>>>>> On 2014/6/20 16:37, Alvise Rigo wrote:
>>>>>>>> Linaro has a great set of pre-built images here http://releases.linaro.org/.
>>>>>>>>
>>>>>>>> For example these should work fine:
>>>>>>>> http://releases.linaro.org/13.12/ubuntu/saucy-images
>>>>>>>>
>>>>>>>> alvise
>>>>>>>>
>>>>>>>> Il 20/06/2014 10:23, Shannon Zhao ha scritto:
>>>>>>>>> Hi Alvise,
>>>>>>>>>
>>>>>>>>> I'm so sorry that I can't use qemu-debootstrap because my
>>>>>>>>> environment can't
>>>>>>> access some links using proxy.
>>>>>>>>> Are there other ways to get a proper fs?
>>>>>>>>>
>>>>>>>>> Thanks
>>>>>>>>> Shannon
>>>>>>>>>
>>>>>>>>> On 2014/6/20 15:15, Alvise Rigo wrote:
>>>>>>>>>> Hi Shannon,
>>>>>>>>>>
>>>>>>>>>> If you follow the steps in the section "Creating the File System"
>>>>>>>>>> of the guide you should be able to obtain a working fs.
>>>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>> alvise
>>>>>>>>>>
>>>>>>>>>> Il 20/06/2014 04:57, Shannon Zhao ha scritto:
>>>>>>>>>>> Hi Bharat,
>>>>>>>>>>>
>>>>>>>>>>> Thanks for your advice .
>>>>>>>>>>>
>>>>>>>>>>> I'm using the rootfs getting from the url
>>>>>>> "http://www.virtualopensystems.com/downloads/guides/kvm_on_arm/fs-ali
>>>>>>> p-
>>>>>>> armel.cramfs".
>>>>>>>>>>>
>>>>>>>>>>> Can you give me another link to get a newer rootfs?
>>>>>>>>>>>
>>>>>>>>>>> Thank you
>>>>>>>>>>> Shannon
>>>>>>>>>>>
>>>>>>>>>>> On 2014/6/19 20:20, Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>> -----Original Message-----
>>>>>>>>>>>>> From: Shannon Zhao [mailto:zhaoshenglong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org]
>>>>>>>>>>>>> Sent: Thursday, June 19, 2014 5:47 PM
>>>>>>>>>>>>> To: Bhushan Bharat-R65777; Alvise Rigo;
>>>>>>>>>>>>> a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org;
>>>>>>>>>>>>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org
>>>>>>>>>>>>> Subject: Re: Vfio-on-arm: the device tree does not contain the
>>>>>>>>>>>>> DMA device
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 2014/6/19 20:12, Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> -----Original Message-----
>>>>>>>>>>>>>>> From: Shannon Zhao [mailto:zhaoshenglong-hv44wF8Li93QT0dZR+AlfA@public.gmane.org]
>>>>>>>>>>>>>>> Sent: Thursday, June 19, 2014 5:38 PM
>>>>>>>>>>>>>>> To: Alvise Rigo; Bhushan Bharat-R65777;
>>>>>>>>>>>>>>> a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org;
>>>>>>>>>>>>>>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
>>>>>>>>>>>>>>> kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org
>>>>>>>>>>>>>>> Subject: Re: Vfio-on-arm: the device tree does not contain
>>>>>>>>>>>>>>> the DMA device
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Hi Alvise,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I run following cmds :
>>>>>>>>>>>>>>> 	echo 2c0a0000.dma >
>>>>>>>>>>>>>>> /sys/bus/platform/drivers/vfio-platform/vfio_bind
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> run "ls /dev/vfio/" before and after the above command
>>>>>>>>>>>>> Hi Bharat,
>>>>>>>>>>>>>
>>>>>>>>>>>>> Nothing appeared either before or after the cmd "echo
>>>>>>>>>>>>> 2c0a0000.dma > /sys/bus/platform/drivers/vfio-platform/vfio_bind".
>>>>>>>>>>>>> There is only /dev/vfio.
>>>>>>>>>>>>
>>>>>>>>>>>> I am not sure, but may be you are using pretty old rootfs with
>>>>>>>>>>>> broken udev
>>>>>>> rules. Try to fetch a newer rootfs form somewhere.
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks
>>>>>>>>>>>> -Bharat
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Thanks
>>>>>>>>>>>>>> -Bharat
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> 	./qemu-system-arm -enable-kvm -M vexpress-a15 -cpu cortex-a15 \
>>>>>>>>>>>>>>>         	-device
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>> pl330,vfio_group="/dev/vfio/0",vfio_device="2c0a0000.dma",vfio_contai
>>>>>>> ner="/dev/v
>>>>>>>>>>>>>>> fio/vfio" \
>>>>>>>>>>>>>>>         	-append "earlyprintk ip=dhcp console=ttyAMA0 rootwait" \
>>>>>>>>>>>>>>>         	-kernel zImage -dtb guest-a15.dtb -initrd
>>>>>>>>>>>>>>> filesystem.cpio.gz
>>>>>>> -
>>>>>>>>>>>>>>> nographic But the error still exists.
>>>>>>>>>>>>>>> 	qemu-system-arm: -device
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>> pl330,vfio_group=/dev/vfio/0,vfio_device=2c0a0000.dma,vfio_container=
>>>>>>> /dev/vfio/v
>>>>>>>>>>>>>>> fio: Parameter 'driver' expects pluggable device type
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Thanks,
>>>>>>>>>>>>>>> Shannon
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On 2014/6/19 19:26, Alvise Rigo wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Il 19/06/2014 13:11, Shannon Zhao ha scritto:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On 2014/6/19 18:47, Alvise Rigo wrote:
>>>>>>>>>>>>>>>>>> Hi,
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Il 19/06/2014 11:38, Shannon Zhao ha scritto:
>>>>>>>>>>>>>>>>>>> Hi Bharat,
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>> On 2014/6/19 17:19, Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> -----Original Message-----
>>>>>>>>>>>>>>>>>>>>> From: kvmarm-bounces-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org
>>>>>>>>>>>>>>>>>>>>> [mailto:kvmarm- bounces-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org] On
>>>>>>>>>>>>>>>>>>>>> Behalf Of Shannon Zhao
>>>>>>>>>>>>>>>>>>>>> Sent: Thursday, June 19, 2014 2:45 PM
>>>>>>>>>>>>>>>>>>>>> To: Alvise Rigo; a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org;
>>>>>>>>>>>>>>>>>>>>> iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org foundation.org;
>>>>>>>>>>>>>>>>>>>>> kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org
>>>>>>>>>>>>>>>>>>>>> Subject: Re: Vfio-on-arm: the device tree does not
>>>>>>>>>>>>>>>>>>>>> contain the DMA device
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Hi Alvise,
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Thanks for your reply.
>>>>>>>>>>>>>>>>>>>>> I have apply the patch and could see the DMA devices.
>>>>>>>>>>>>>>>>>>>>> But there is no vosys_dmatest int the directory
>>>>>>>>>>>>>>>>>>>>> "/sys/kernel/debug/" after mounting debugfs.
>>>>>>>>>>>>>>>>>>>>> I found that the branch vfio-platform-v4 doesn't
>>>>>>>>>>>>>>>>>>>>> contain the module vosys_dmatest.
>>>>>>>>>>>>>>>>>>>>> Then I port it from the branch pl330_dmatest and run
>>>>>>> vosys_dmatest
>>>>>>>>>>>>>>> successfully.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> 	echo 1 > /sys/kernel/debug/vosys_dmatest/start
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> 	[ 6145.343419] dmaengine: __dma_request_channel:
>>>>>>>>>>>>>>>>>>>>> success
>>>>>>>>>>>>>>> (dma0chan0)
>>>>>>>>>>>>>>>>>>>>> 	[ 6145.344000] vosys dmatest: callback: transfer completed
>>>>>>>>>>>>>>>>>>>>> 	[ 6145.344147] vosys dmatest: tx completed
>>>>>>>>>>>>>>>>>>>>> 	[ 6145.344589] vosys dmatest: source and destination match.
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Download the qemu and use following command to start a guest:
>>>>>>>>>>>>>>>>>>>>> 	./qemu-system-arm -enable-kvm -M vexpress-a15 -cpu
>>>>>>>>>>>>>>>>>>>>> cortex-
>>>>>>> a15 \
>>>>>>>>>>>>>>>>>>>>>         	-device
>>>>>>>>>>>>>>> pl330,vfio_group="/dev/vfio/0",vfio_device="2c0a0000.dma",\
>>>>>>>>>>>>>>>>>>>>>         	vfio_container="/dev/vfio/vfio" \
>>>>>>>>>>>>>>>>>>>>>         	-append "earlyprintk ip=dhcp console=ttyAMA0 rootwait"
>>>>>>> \
>>>>>>>>>>>>>>>>>>>>>         	-kernel zImage -dtb guest.dtb -initrd
>>>>>>> filesystem.cpio.gz
>>>>>>>>>>>>>>>>>>>>> - nographic An error reported:
>>>>>>>>>>>>>>>>>>>>> 	qemu-system-arm: -device
>>>>>>>>>>>>>>>>>>>>> pl330,vfio_group=/dev/vfio/0,vfio_device=2c0a0000.dma,:
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Why do we need to give "vfio_group=/dev/vfio/0" ?
>>>>>>>>>>>>>>>>>>> I refer to the url
>>>>>>>>>>>>>>> "http://www.virtualopensystems.com/en/solutions/guides/vfio-on-arm/".
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> 	could not open disk image vfio_container=/dev/vfio:
>>>>>>>>>>>>>>>>>>>>> 	Could not open 'vfio_container=/dev/vfio': No such
>>>>>>>>>>>>>>>>>>>>> file or directory
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Are you unbinding "2c0a0000.dma" from its driver and
>>>>>>>>>>>>>>>>>>>> binding with
>>>>>>> "vfio-
>>>>>>>>>>>>>>> playform" driver ?
>>>>>>>>>>>>>>>>>>> How to unbind "2c0a0000.dma" from its driver?
>>>>>>>>>>>>>>>>>>> I have tried following cmd to bind "2c0a0000.dma" with
>>>>>>>>>>>>>>>>>>> "vfio-
>>>>>>> playform"
>>>>>>>>>>>>>>> driver.
>>>>>>>>>>>>>>>>>>> 	echo 2c0a0000.dma >
>>>>>>>>>>>>>>>>>>> /sys/bus/platform/drivers/vfio-platform/vfio_bind
>>>>>>>>>>>>>>>>>>> But there is no /dev/vfio/0 or /dev/vfio/vfio .
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Can you please verify that while configuring the host you enabled:
>>>>>>>>>>>>>>>>>> - Device Drivers -> IOMMU Hardware Support -> ARM Ltd.
>>>>>>>>>>>>>>>>>> System MMU
>>>>>>>>>>>>>>>>>> (SMMU) Support and
>>>>>>>>>>>>>>>>>> - Device Drivers -> VFIO Non-Privileged userspace driver
>>>>>>>>>>>>>>>>>> framework
>>>>>>>>>>>>>>>>>> -> VFIO support for platform devices
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Hi Alvise,
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> I have checked the two configuration are enabled.
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Then try the following cmd, but another error reported:
>>>>>>>>>>>>>>>>> 	qemu-system-arm: -device
>>>>>>>>>>>>>>>>> pl330,vfio_group=/dev/vfio/0,vfio_device=2c0a0000.dma,vfio_
>>>>>>>>>>>>>>>>> container=
>>>>>>>>>>>>>>>>> /dev/vfio/vfio: Parameter 'driver' expects pluggable device
>>>>>>>>>>>>>>>>> type
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> Do I need to unbind the "2c0a0000.dma" from its driver and
>>>>>>>>>>>>>>>>> binding
>>>>>>> with
>>>>>>>>>>>>>>> "vfio-platform" driver as Bharat mentioned ?
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Yes, the 2c0a0000.dma should not be bound to any driver at
>>>>>>>>>>>>>>>> boot, so you just need to:
>>>>>>>>>>>>>>>> echo 2c0a0000.dma >
>>>>>>>>>>>>>>>> /sys/bus/platform/drivers/vfio-platform/vfio_bind
>>>>>>>>>>>>>>>> to bind the device to the VFIO driver.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>>>> alvise
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Then try to update the pl330-vfio-dev branch and run QEMU
>>>>>>>>>>>>>>>>>> with the
>>>>>>>>>>>>> following
>>>>>>>>>>>>>>> command:
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> ./qemu-system-arm -enable-kvm -M vexpress-a15 -cpu cortex-a15 \
>>>>>>>>>>>>>>>>>>     -device
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>> pl330,vfio_group="/dev/vfio/0",vfio_device="2c0a0000.dma",vfio_contai
>>>>>>> ner="/dev/v
>>>>>>>>>>>>>>> fio/vfio" \
>>>>>>>>>>>>>>>>>>     -append "earlyprintk ip=dhcp console=ttyAMA0 rootwait" \
>>>>>>>>>>>>>>>>>>     -kernel zImage -dtb guest.dtb -initrd
>>>>>>>>>>>>>>>>>> filesystem.cpio.gz
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> that means without breaking the "-device pl330" options.
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> Regards,
>>>>>>>>>>>>>>>>>> alvise
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> Thanks
>>>>>>>>>>>>>>>>>>>> -Bharat
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Is there something I'm wrong or do I miss some steps?
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> Thank you,
>>>>>>>>>>>>>>>>>>>>> Shannon
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> On 2014/6/18 21:24, Alvise Rigo wrote:
>>>>>>>>>>>>>>>>>>>>>> Hi Shannon,
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> Thank you for reporting this issue, the device tree
>>>>>>>>>>>>>>>>>>>>>> file was
>>>>>>> indeed
>>>>>>>>>>>>>>> missing.
>>>>>>>>>>>>>>>>>>>>>> To solve the problem, you can apply the following
>>>>>>>>>>>>>>>>>>>>>> patch to the repository you mentioned
>>>>>>>>>>>>>>>>>>>>>> (git://github.com/virtualopensystems/arm-dts.git).
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> For your information, soon we will update the guide
>>>>>>>>>>>>>>>>>>>>>> with a newer version of VFIO with this issue fixed.
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> Thank you,
>>>>>>>>>>>>>>>>>>>>>> alvise
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> ---
>>>>>>>>>>>>>>>>>>>>>>  fast_models/rtsm_ve-cortex_a15x4_a7x4.dts | 100
>>>>>>>>>>>>>>>>>>>>>> +++++++++++++++++++++++++++++-
>>>>>>>>>>>>>>>>>>>>>>  1 file changed, 97 insertions(+), 3 deletions(-)
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> diff --git a/fast_models/rtsm_ve-cortex_a15x4_a7x4.dts
>>>>>>>>>>>>>>>>>>>>>> b/fast_models/rtsm_ve-cortex_a15x4_a7x4.dts
>>>>>>>>>>>>>>>>>>>>>> index ef1275b..79c6af2 100644
>>>>>>>>>>>>>>>>>>>>>> --- a/fast_models/rtsm_ve-cortex_a15x4_a7x4.dts
>>>>>>>>>>>>>>>>>>>>>> +++ b/fast_models/rtsm_ve-cortex_a15x4_a7x4.dts
>>>>>>>>>>>>>>>>>>>>>> @@ -142,7 +142,7 @@
>>>>>>>>>>>>>>>>>>>>>>  		cpu7: cpu@7 {
>>>>>>>>>>>>>>>>>>>>>>  			device_type = "cpu";
>>>>>>>>>>>>>>>>>>>>>>  			compatible = "arm,cortex-a7";
>>>>>>>>>>>>>>>>>>>>>> -			reg = <0x104>;
>>>>>>>>>>>>>>>>>>>>>> +			reg = <0x103>;
>>>>>>>>>>>>>>>>>>>>>>  			cluster = <&cluster1>;
>>>>>>>>>>>>>>>>>>>>>>  			core = <&core7>;
>>>>>>>>>>>>>>>>>>>>>>  		};
>>>>>>>>>>>>>>>>>>>>>> @@ -159,7 +159,7 @@
>>>>>>>>>>>>>>>>>>>>>>  		#address-cells = <0>;
>>>>>>>>>>>>>>>>>>>>>>  		interrupt-controller;
>>>>>>>>>>>>>>>>>>>>>>  		reg = <0 0x2c001000 0 0x1000>,
>>>>>>>>>>>>>>>>>>>>>> -		      <0 0x2c002000 0 0x2000>,
>>>>>>>>>>>>>>>>>>>>>> +		      <0 0x2c002000 0 0x1000>,
>>>>>>>>>>>>>>>>>>>>>>  		      <0 0x2c004000 0 0x2000>,
>>>>>>>>>>>>>>>>>>>>>>  		      <0 0x2c006000 0 0x2000>;
>>>>>>>>>>>>>>>>>>>>>>  		interrupts = <1 9 0xf04>; @@ -183,6 +183,101 @@
>>>>>>>>>>>>>>>>>>>>>>  			     <1 10 0xf08>;
>>>>>>>>>>>>>>>>>>>>>>  	};
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> +	smmu@2c0b0000 {
>>>>>>>>>>>>>>>>>>>>>> +                compatible = "arm,smmu-v2";
>>>>>>>>>>>>>>>>>>>>>> +                reg = <0x0 0x2c0b0000 0x0 0x10000>;
>>>>>>>>>>>>>>>>>>>>>> +                #global-interrupts = <2>;
>>>>>>>>>>>>>>>>>>>>>> +                interrupts = <0 58 4>,
>>>>>>>>>>>>>>>>>>>>>> +                             <0 59 4>,
>>>>>>>>>>>>>>>>>>>>>> +                             <0 60 4>,
>>>>>>>>>>>>>>>>>>>>>> +                             <0 60 4>,
>>>>>>>>>>>>>>>>>>>>>> +                             <0 60 4>,
>>>>>>>>>>>>>>>>>>>>>> +                             <0 60 4>,
>>>>>>>>>>>>>>>>>>>>>> +                             <0 60 4>,
>>>>>>>>>>>>>>>>>>>>>> +                             <0 60 4>,
>>>>>>>>>>>>>>>>>>>>>> +                             <0 60 4>;
>>>>>>>>>>>>>>>>>>>>>> +                mmu-masters = <&dma0 0x0 0x8>,
>>>>>>>>>>>>>>>>>>>>>> +                              <&dma1 0x1 0x9>,
>>>>>>>>>>>>>>>>>>>>>> +                              <&dma2 0x2 0xa>,
>>>>>>>>>>>>>>>>>>>>>> +                              <&dma3 0x3 0xb>;
>>>>>>>>>>>>>>>>>>>>>> +        };
>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>> +	dma0: dma@2c0a0000 {
>>>>>>>>>>>>>>>>>>>>>> +		compatible = "arm,pl330";
>>>>>>>>>>>>>>>>>>>>>> +		reg = <0 0x2c0a0000 0 0x1000>;
>>>>>>>>>>>>>>>>>>>>>> +		interrupts = <0 64 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 65 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 66 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 67 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 68 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 69 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 70 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 71 4>;
>>>>>>>>>>>>>>>>>>>>>> +		#dma-cells = <1>;
>>>>>>>>>>>>>>>>>>>>>> +		#stream-id-cells = <2>;
>>>>>>>>>>>>>>>>>>>>>> +		clocks = <&oscclk6a>;
>>>>>>>>>>>>>>>>>>>>>> +		clock-names = "apb_pclk";
>>>>>>>>>>>>>>>>>>>>>> +	};
>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>> +	dma1: dma@2c0a1000 {
>>>>>>>>>>>>>>>>>>>>>> +		compatible = "arm,pl330", "arm,primecell";
>>>>>>>>>>>>>>>>>>>>>> +		reg = <0 0x2c0a1000 0 0x1000>;
>>>>>>>>>>>>>>>>>>>>>> +		interrupts = <0 96 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 97 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 98 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 99 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 100 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 101 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 102 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 103 4>;
>>>>>>>>>>>>>>>>>>>>>> +		#dma-cells = <1>;
>>>>>>>>>>>>>>>>>>>>>> +		#stream-id-cells = <2>;
>>>>>>>>>>>>>>>>>>>>>> +		clocks = <&oscclk6a>;
>>>>>>>>>>>>>>>>>>>>>> +		clock-names = "apb_pclk";
>>>>>>>>>>>>>>>>>>>>>> +	};
>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>> +	dma2: dma@2c0a2000 {
>>>>>>>>>>>>>>>>>>>>>> +		compatible = "arm,pl330", "arm,primecell";
>>>>>>>>>>>>>>>>>>>>>> +		reg = <0 0x2c0a2000 0 0x1000>;
>>>>>>>>>>>>>>>>>>>>>> +		interrupts = <0 128 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 129 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 130 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 131 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 132 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 133 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 134 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 135 4>;
>>>>>>>>>>>>>>>>>>>>>> +		#dma-cells = <1>;
>>>>>>>>>>>>>>>>>>>>>> +		#stream-id-cells = <2>;
>>>>>>>>>>>>>>>>>>>>>> +		clocks = <&oscclk6a>;
>>>>>>>>>>>>>>>>>>>>>> +		clock-names = "apb_pclk";
>>>>>>>>>>>>>>>>>>>>>> +	};
>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>> +	dma3: dma@2c0a3000 {
>>>>>>>>>>>>>>>>>>>>>> +		compatible = "arm,pl330", "arm,primecell";
>>>>>>>>>>>>>>>>>>>>>> +		reg = <0 0x2c0a3000 0 0x1000>;
>>>>>>>>>>>>>>>>>>>>>> +		interrupts = <0 160 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 161 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 162 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 163 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 164 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 165 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 166 4>,
>>>>>>>>>>>>>>>>>>>>>> +			     <0 167 4>;
>>>>>>>>>>>>>>>>>>>>>> +		#dma-cells = <1>;
>>>>>>>>>>>>>>>>>>>>>> +		#stream-id-cells = <2>;
>>>>>>>>>>>>>>>>>>>>>> +		clocks = <&oscclk6a>;
>>>>>>>>>>>>>>>>>>>>>> +		clock-names = "apb_pclk";
>>>>>>>>>>>>>>>>>>>>>> +	};
>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>> +	oscclk6a: oscclk6a {
>>>>>>>>>>>>>>>>>>>>>> +		/* Reference 24MHz clock */
>>>>>>>>>>>>>>>>>>>>>> +		compatible = "fixed-clock";
>>>>>>>>>>>>>>>>>>>>>> +		#clock-cells = <0>;
>>>>>>>>>>>>>>>>>>>>>> +		clock-frequency = <24000000>;
>>>>>>>>>>>>>>>>>>>>>> +		clock-output-names = "oscclk6a";
>>>>>>>>>>>>>>>>>>>>>> +	};
>>>>>>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>>>>>>  	smb {
>>>>>>>>>>>>>>>>>>>>>>  		compatible = "simple-bus";
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>> @@ -244,4 +339,3 @@
>>>>>>>>>>>>>>>>>>>>>>  		/include/ "rtsm_ve-motherboard.dtsi"
>>>>>>>>>>>>>>>>>>>>>>  	};
>>>>>>>>>>>>>>>>>>>>>>  };
>>>>>>>>>>>>>>>>>>>>>> -
>>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>>>>>>>> Shannon
>>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>>> _______________________________________________
>>>>>>>>>>>>>>>>>>>>> kvmarm mailing list
>>>>>>>>>>>>>>>>>>>>> kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org
>>>>>>>>>>>>>>>>>>>>> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>> .
>>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>> .
>>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> .
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> --
>>>>>>>>>>>>>>> Shannon
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> .
>>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> --
>>>>>>>>>>>>> Shannon
>>>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> .
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> .
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>
>>>>>>>> .
>>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> Shannon
>>>>>>
>>>>>
>>>>> --
>>>>> Shannon
>>>>
>>>
>>
>> .
>>
> 
