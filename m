From: Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>
Subject: Re: [PATCH 4/4] iommu/pamu: Add support for generic iommu-device
Date: Thu, 24 Aug 2017 12:04:13 +1000
Message-ID: <87ziapwwki.fsf@concordia.ellerman.id.au>
References: <1502290014-2890-1-git-send-email-joro@8bytes.org>
	<1502290014-2890-5-git-send-email-joro@8bytes.org>
	<878tiaxyu4.fsf@concordia.ellerman.id.au>
	<20170823142134.GD19533@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170823142134.GD19533-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
Cc: Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> writes:

> Hello Michael,
>
> On Wed, Aug 23, 2017 at 10:17:39PM +1000, Michael Ellerman wrote:
>
>> [    0.358192] Call Trace:
>> [    0.360624] [c0000000f7173680] [c0000000f7173710] 0xc0000000f7173710 (unreliable)
>> [    0.368088] [c0000000f7173710] [c0000000002abf7c] .kernfs_find_and_get_ns+0x4c/0x7c
>> [    0.375729] [c0000000f71737a0] [c0000000002b13c8] .sysfs_add_link_to_group+0x44/0x9c
>> [    0.383456] [c0000000f7173840] [c000000000591660] .iommu_device_link+0x70/0x144
>> [    0.390744] [c0000000f71738e0] [c0000000005942dc] .fsl_pamu_add_device+0x4c/0x80
>> [    0.398121] [c0000000f7173960] [c00000000058ce8c] .add_iommu_group+0x5c/0x9c
>> [    0.405153] [c0000000f71739e0] [c00000000059d6b8] .bus_for_each_dev+0x98/0xfc
>> [    0.412269] [c0000000f7173a80] [c00000000058f1a0] .bus_set_iommu+0xd8/0x11c
>> [    0.419218] [c0000000f7173b20] [c000000000d86998] .pamu_domain_init+0xb0/0xe0
>> [    0.426331] [c0000000f7173ba0] [c000000000d86864] .fsl_pamu_init+0xec/0x170
>> [    0.433276] [c0000000f7173c30] [c000000000001934] .do_one_initcall+0x68/0x1b8
>> [    0.440395] [c0000000f7173d00] [c000000000d440e4] .kernel_init_freeable+0x24c/0x324
>> [    0.448031] [c0000000f7173db0] [c000000000001b90] .kernel_init+0x20/0x140
>> [    0.454801] [c0000000f7173e30] [c0000000000009bc] .ret_from_kernel_thread+0x58/0x9c
>> [    0.462438] Instruction dump:
>> [    0.465390] 7c0802a6 fb81ffe0 f8010010 fba1ffe8 fbc1fff0 fbe1fff8 f821ff71 7c7e1b78 
>> [    0.473114] 7cbd2b78 7c9c2378 60000000 60000000 <a13e0068> 311dffff ebfe0048 552906b4 
>> [    0.481017] ---[ end trace 5d11d3e6c29380bd ]---
>
> Thanks for the report, this looks like an initialization ordering
> problem.

Yes I suspect so.

> Can you please try the attached patch?

Thanks, that works.

It boots happily, much later in boot I see these messages:

[    2.085616] iommu: Adding device ffe301000.jr to group 9
[    2.091101] iommu: Adding device ffe302000.jr to group 10
[    2.096633] iommu: Adding device ffe303000.jr to group 11
[    2.102161] iommu: Adding device ffe304000.jr to group 12

In /sys I see:

root@p5020ds:~# ls -l /sys/class/iommu/iommu0
lrwxrwxrwx 1 root root 0 Aug 24 12:01 /sys/class/iommu/iommu0 -> ../../devices/virtual/iommu/iommu0

And:

root@p5020ds:~# ls -l /sys/devices/virtual/iommu/iommu0/devices/
total 0
lrwxrwxrwx 1 root root 0 Aug 24 12:02 0000:00:00.0 -> ../../../../platform/ffe200000.pcie/pci0000:00/0000:00:00.0
lrwxrwxrwx 1 root root 0 Aug 24 12:02 2000:00:00.0 -> ../../../../platform/ffe202000.pcie/pci2000:00/2000:00:00.0
lrwxrwxrwx 1 root root 0 Aug 24 12:02 2000:01:00.0 -> ../../../../platform/ffe202000.pcie/pci2000:00/2000:00:00.0/2000:01:00.0
lrwxrwxrwx 1 root root 0 Aug 24 12:02 2000:01:00.1 -> ../../../../platform/ffe202000.pcie/pci2000:00/2000:00:00.0/2000:01:00.1
lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe100300.dma -> ../../../../platform/ffe000000.soc/ffe100300.dma
lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe101300.dma -> ../../../../platform/ffe000000.soc/ffe101300.dma
lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe114000.sdhc -> ../../../../platform/ffe000000.soc/ffe114000.sdhc
lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe200000.pcie -> ../../../../platform/ffe200000.pcie
lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe202000.pcie -> ../../../../platform/ffe202000.pcie
lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe210000.usb -> ../../../../platform/ffe000000.soc/ffe210000.usb
lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe211000.usb -> ../../../../platform/ffe000000.soc/ffe211000.usb
lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe220000.sata -> ../../../../platform/ffe000000.soc/ffe220000.sata
lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe221000.sata -> ../../../../platform/ffe000000.soc/ffe221000.sata
lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe301000.jr -> ../../../../platform/ffe000000.soc/ffe300000.crypto/ffe301000.jr
lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe302000.jr -> ../../../../platform/ffe000000.soc/ffe300000.crypto/ffe302000.jr
lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe303000.jr -> ../../../../platform/ffe000000.soc/ffe300000.crypto/ffe303000.jr
lrwxrwxrwx 1 root root 0 Aug 24 12:02 ffe304000.jr -> ../../../../platform/ffe000000.soc/ffe300000.crypto/ffe304000.jr


Which seems like it's working?

cheers
