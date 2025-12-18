Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6160C2F12B3
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766049409; cv=none; b=QyS75GD6da2fBbFt7dFopFboY69/g83jPnatT1Dg+81NvG57BuyV0XKpZZf5O8X/JSGzKP+P9iHAWIrKBGJH2h5Eu6rkXWOw0WraaESKO53Pi/MQtD69cKuFqVbpXgw33mfLk69vjWBZN05tMJ7RVDX75DDM3Ivh8yYo0DDAAgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766049409; c=relaxed/simple;
	bh=/hBvBWhc1YidyRQ+v7B0mLPyKphjWN1XXxejFVR95cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=HwTODSMEt0kUM0t/tbvYabjVW/C+zWXyf1kSOr/KiAsKzW0A5P4oCJj6qxF9wokIuBNfsjoiDjAzlF3nElgm9zPhODYDBxpUn1P/fc181cck4oX03mbfcFfT6wodwHTgefOrTjFVXB9hGMxcSzPVmelHoIyfTS5vbXdVR2OVcKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=NR6LwWYs; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NR6LwWYs"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251218091638euoutp019c0c738c32a37ea12070c0a471cbde8e~CRJIQmRUh3159031590euoutp01I
	for <iommu@lists.linux.dev>; Thu, 18 Dec 2025 09:16:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251218091638euoutp019c0c738c32a37ea12070c0a471cbde8e~CRJIQmRUh3159031590euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1766049398;
	bh=e5vJUKv4U75/EfGO08/80qRbRTueeAtV9fzJ5p+CPk8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=NR6LwWYsUpgyzmqkbzpbKqQ0v9ZMPH2TgOFYIdl3r35zPXuDejoxYE3tCCTegpI9D
	 ByGudS9ws4KwweH4KVG5eKC/lUllm3nLhaWSyQCxjbIXX3yNaMF9tgAXJYDStoV+1q
	 g75g6Ig/y1Ub7/I72z+NlmxN8+Le3AhiBezGiBy4=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20251218091637eucas1p215051f20c202d5c71b1b0d857d2321c4~CRJIAKeQx0890608906eucas1p2s;
	Thu, 18 Dec 2025 09:16:37 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251218091637eusmtip2ef1aa824980ebb5d20c01c972fac337c~CRJHWWPFZ1477814778eusmtip2b;
	Thu, 18 Dec 2025 09:16:36 +0000 (GMT)
Message-ID: <efd9de56-9104-4909-9321-3881f691040c@samsung.com>
Date: Thu, 18 Dec 2025 10:16:36 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: Bug#1116251: linux-image-6.12.48+deb13-rpi: Raspberry Pi Zero W
 does not boot
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>, William Zhang
	<william.zhang@broadcom.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>, 1116251@bugs.debian.org,
	regressions@lists.linux.dev, Sasha Levin <sashal@kernel.org>,
	iommu@lists.linux.dev, Benjamin Drung <bdrung@debian.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <hnwgn7glub4klmkzabzcm76eldaa3xm5ua72eldwzesblveo2a@4xq2bxhmbsyq>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251218091637eucas1p215051f20c202d5c71b1b0d857d2321c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251218083009eucas1p1a8a75fa00994c260128f8e6fd697bc85
X-EPHeader: CA
X-CMS-RootMailID: 20251218083009eucas1p1a8a75fa00994c260128f8e6fd697bc85
References: <c35629054179865b770bc3bf0ed0cfe4c01f77f7.camel@debian.org>
	<772b4ba943acec4ec24009af7db0f7ea249adc98.camel@debian.org>
	<aSaxsQB3w61sEV90@eldamar.lan>
	<c35629054179865b770bc3bf0ed0cfe4c01f77f7.camel@debian.org>
	<931652ee31f88beadd45aefd972d8ea221d1e79c.camel@debian.org>
	<c35629054179865b770bc3bf0ed0cfe4c01f77f7.camel@debian.org>
	<aSop6N7jUJ__lhy-@eldamar.lan> <aSwN5F9UlwHUnxDt@eldamar.lan>
	<6cd9babe311f6d5e2db0b51d04a4248377defcd3.camel@debian.org>
	<39590b9d90825cbc83072027b742410c3576fafa.camel@debian.org>
	<CGME20251218083009eucas1p1a8a75fa00994c260128f8e6fd697bc85@eucas1p1.samsung.com>
	<hnwgn7glub4klmkzabzcm76eldaa3xm5ua72eldwzesblveo2a@4xq2bxhmbsyq>

On 18.12.2025 09:29, Uwe Kleine-König wrote:
> Control: forwarded -1 https://lore.kernel.org/linux-iommu/hnwgn7glub4klmkzabzcm76eldaa3xm5ua72eldwzesblveo2a@4xq2bxhmbsyq
> Hello,
>
> I extended the audience to people involved in the creation of
> 2c223f7239f376a90d71903ec474ba887cf21d94.
>
> On Wed, Dec 17, 2025 at 11:07:00PM +0100, Benjamin Drung wrote:
>> On Wed, 2025-12-17 at 22:20 +0100, Benjamin Drung wrote:
>>> On Sun, 2025-11-30 at 10:27 +0100, Salvatore Bonaccorso wrote:
>>>> On Sat, Nov 29, 2025 at 12:02:00AM +0100, Salvatore Bonaccorso wrote:
>>>>> On Fri, Nov 28, 2025 at 10:53:17PM +0100, Benjamin Drung wrote:
>>>>>> On Wed, 2025-11-26 at 08:52 +0100, Salvatore Bonaccorso wrote:
>>>>>>> On Sat, Nov 22, 2025 at 04:27:53PM +0100, Benjamin Drung wrote:
>>>>>>>> On Fri, 2025-11-21 at 09:52 +0100, Uwe Kleine-König wrote:
>>>>>>>>> On Thu, Nov 20, 2025 at 11:11:07AM +0100, Benjamin Drung wrote:
>>>>>>>>>> On Thu, 2025-11-20 at 08:58 +0100, Uwe Kleine-König wrote:
>>>>>>>>>>> On Mon, Nov 17, 2025 at 02:05:41AM +0100, Benjamin Drung wrote:
>>>>>>>>>>>> On Wed, 2025-11-05 at 20:14 +0100, Uwe Kleine-König wrote:
>>>>>>>>>>>>> Can you try adding
>>>>>>>>>>>>>
>>>>>>>>>>>>> 	earlyprintk=serial,0x7e215040
>>>>>>>>>>>>>
>>>>>>>>>>>>> to the kernel commandline. Not sure this activates the right procedures,
>>>>>>>>>>>>> maybe try it with the working kernel first.
>>>>>>>>>>>> I tried with the working kernel 6.12.43+deb13-rpi but these were the
>>>>>>>>>>>> earliest lines:
>>>>>>>>>>>>
>>>>>>>>>>>> [    4.116565] printk: legacy console [ttyS1] enabled
>>>>>>>>>>>> [    4.129635] printk: legacy bootconsole [earlycon0] disabled
>>>>>>>>>>>> [    4.147050] bcm2835-power bcm2835-power: Broadcom BCM2835 power domains driver
>>>>>>>>>>>> [    4.160972] mousedev: PS/2 mouse device common for all mice
>>>>>>>>>>>> [    4.172622] i2c-bcm2835 20805000.i2c: Could not read clock-frequency property
>>>>>>>>>>>> [    4.186585] bcm2835-wdt bcm2835-wdt: Broadcom BCM2835 watchdog timer
>>>>>>>>>>>>
>>>>>>>>>>>> I tried with 6.12.57+deb13-rpi but that failed to boot and the
>>>>>>>>>>>> earlyprintk line did not give any additional logs.
>>>>>>>>>>> Can you please provide a full kernel log of the working kernel?
>>>>>>>>>> dmesg log is attached.
>>>>>>>>>>
>>>>>>>>>>> Also please provide the output of:
>>>>>>>>>>>
>>>>>>>>>>> 	for f in /proc/tty/driver/*; do echo $f; sed 's/^/  /' < $f; done
>>>>>>>>>> /proc/tty/driver/serial
>>>>>>>>>>    serinfo:1.0 driver revision:
>>>>>>>>>>    0: uart:unknown port:00000000 irq:0
>>>>>>>>>>    1: uart:16550 mmio:0x20215040 irq:53 tx:15629 rx:0 RTS|CTS|DTR
>>>>>>>>>>    2: uart:unknown port:00000000 irq:0
>>>>>>>>>>    3: uart:unknown port:00000000 irq:0
>>>>>>>>>> /proc/tty/driver/ttyAMA
>>>>>>>>>>    serinfo:1.0 driver revision:
>>>>>>>>>>    0: uart:PL011 rev2 mmio:0x20201000 irq:81 tx:452 rx:980 RTS|CTS|DTR
>>>>>>>>> OK, is
>>>>>>>>>
>>>>>>>>>   	earlyprintk=serial,0x20215040
>>>>>>>>>
>>>>>>>>> more communicative then?
>>>>>>>> Nope, but I found
>>>>>>>> https://www.raspberrypi.com/documentation/computers/configuration.html#enabling-early-console-for-linux
>>>>>>>> and setting earlycon=uart8250,mmio32,0x20215040 worked. The kernel
>>>>>>>> 6.12.43+deb13-rpi booted with printing the early lines as well (see
>>>>>>>> dmesg of previous mail).
>>>>>>>>
>>>>>>>> With all other experiments cleaned, I tried the latest kernel:
>>>>>>>>
>>>>>>>> ```
>>>>>>>> $ cat /etc/default/raspi-extra-cmdline
>>>>>>>> earlycon=uart8250,mmio32,0x20215040
>>>>>>>> $ update-initramfs -u
>>>>>>>> ```
>>>>>>>>
>>>>>>>> I got following logs before it got stuck:
>>>>>>>>
>>>>>>>> ```
>>>>>>>> [    0.000000] Booting Linux on physical CPU 0x0
>>>>>>>> [    0.000000] Linux version 6.12.57+deb13-rpi (debian-kernel@lists.debian.org) (arm-linux-gnueabi-gcc-14 (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #1 Debian 6.12.57-1 (2025-11-05)
>>>>>>>> [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387d
>>>>>>>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
>>>>>>>> [    0.000000] OF: fdt: Machine model: Raspberry Pi Zero W Rev 1.1
>>>>>>>> [    0.000000] random: crng init done
>>>>>>>> [    0.000000] earlycon: uart8250 at MMIO32 0x20215040 (options '')
>>>>>>>> [    0.000000] printk: legacy bootconsole [uart8250] enabled
>>>>>>>> [    0.000000] Memory policy: Data cache writeback
>>>>>>>> [    0.000000] Reserved memory: bypass linux,cma node, using cmdline CMA params instead
>>>>>>>> [    0.000000] OF: reserved mem: node linux,cma compatible matching fail
>>>>>>>> [    0.000000] cma: Reserved 64 MiB at 0x17000000 on node -1
>>>>>>>> ```
>>>>>>>>
>>>>>>>> It looks like being cma related and I found a cma boot option in
>>>>>>>> /etc/default/raspi-firmware. So I modified /boot/firmware/cmdline.txt
>>>>>>>> and changed cma=64M to cma=0. Then the system booted without problems:
>>>>>>>>
>>>>>>>> ```
>>>>>>>> [...]
>>>>>>>> [    0.000000] Reserved memory: bypass linux,cma node, using cmdline CMA params instead
>>>>>>>> [    0.000000] OF: reserved mem: node linux,cma compatible matching fail
>>>>>>>> [    0.000000] Zone ranges:
>>>>>>>> [    0.000000]   Normal   [mem 0x0000000000000000-0x000000001bffffff]
>>>>>>>> [    0.000000] Movable zone start for each node
>>>>>>>> [    0.000000] Early memory node ranges
>>>>>>>> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000001bffffff]
>>>>>>>> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000001bffffff]
>>>>>>>> [    0.000000] Kernel command line:  dma.dmachans=0x7ff5 bcm2708.boardrev=0x9000c1 bcm2708.serial=0x8bb1238 bcm2708.uart_clock=48000000 bcm2708.disk_led_gpio=47 smsc95xx.macaddr=B8:27:EB:BB:12:38 vc_mem.mem_base=0x1ec00000 vc_mem.mem_size=0x20000000  console=tty0 console=ttyS1,115200 root=/dev/mmcblk0p2 rw fsck.repair=yes net.ifnames=0 cma=0 rootwait earlycon=uart8250,mmio32,0x20215040
>>>>>>>> [...]
>>>>>>>> ```
>>>>>>>>
>>>>>>>> Then I persisted this change by setting CMA=0 in
>>>>>>>> /etc/default/raspi-firmware:
>>>>>>>>
>>>>>>>> ```
>>>>>>>> $ grep -Ev '^(#|$)' /etc/default/raspi-firmware
>>>>>>>> CMA=0
>>>>>>>> $ update-initramfs -u
>>>>>>>> ```
>>>>>>>>
>>>>>>>> This config removes the cma cmdline option completely. The system still
>>>>>>>> boots:
>>>>>>>>
>>>>>>>> ```
>>>>>>>> [...]
>>>>>>>> [    0.000000] Memory policy: Data cache writeback
>>>>>>>> [    0.000000] Reserved memory: created CMA memory pool at 0x17000000, size 64 MiB
>>>>>>>> [    0.000000] OF: reserved mem: initialized node linux,cma, compatible id shared-dma-pool
>>>>>>>> [    0.000000] OF: reserved mem: 0x17000000..0x1affffff (65536 KiB) map reusable linux,cma
>>>>>>>> [    0.000000] Zone ranges:
>>>>>>>> [    0.000000]   Normal   [mem 0x0000000000000000-0x000000001bffffff]
>>>>>>>> [    0.000000] Movable zone start for each node
>>>>>>>> [    0.000000] Early memory node ranges
>>>>>>>> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000001bffffff]
>>>>>>>> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000001bffffff]
>>>>>>>> [    0.000000] Kernel command line:  dma.dmachans=0x7ff5 bcm2708.boardrev=0x9000c1 bcm2708.serial=0x8bb1238 bcm2708.uart_clock=48000000 bcm2708.disk_led_gpio=47 smsc95xx.macaddr=B8:27:EB:BB:12:38 vc_mem.mem_base=0x1ec00000 vc_mem.mem_size=0x20000000  console=tty0 console=ttyS1,115200 root=/dev/mmcblk0p2 rw fsck.repair=yes net.ifnames=0  rootwait earlycon=uart8250,mmio32,0x20215040
>>>>>>>> [...]
>>>>>>>> ```
>>>>>>>>
>>>>>>>> That should hopefully narrow down the issue space.
>>>>>>> If I'm not wrong the only cma related change between 6.12.43 and
>>>>>>> 6.12.48 was the backport of 2c223f7239f3 ("of: reserved_mem:
>>>>>>> Restructure call site for dma_contiguous_early_fixup()"):
>>>>>>>
>>>>>>> 	commit 46efab01648a04082266115a8e917c3b26b97fa8
>>>>>>> 	Author: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
>>>>>>> 	Date:   Wed Aug 6 10:24:21 2025 -0700
>>>>>>>
>>>>>>> 	    of: reserved_mem: Restructure call site for dma_contiguous_early_fixup()
>>>>>>>
>>>>>>> 	    [ Upstream commit 2c223f7239f376a90d71903ec474ba887cf21d94 ]
>>>>>>>
>>>>>>> 	    Restructure the call site for dma_contiguous_early_fixup() to
>>>>>>> 	    where the reserved_mem nodes are being parsed from the DT so that
>>>>>>> 	    dma_mmu_remap[] is populated before dma_contiguous_remap() is called.
>>>>>>>
>>>>>>> 	    Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved memory regions are processed")
>>>>>>> 	    Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
>>>>>>> 	    Tested-by: William Zhang <william.zhang@broadcom.com>
>>>>>>> 	    Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>>>>> 	    Link: https://lore.kernel.org/r/20250806172421.2748302-1-oreoluwa.babatunde@oss.qualcomm.com
>>>>>>> 	    Signed-off-by: Sasha Levin <sashal@kernel.org>
>>>>>>>
>>>>>>> Uwe, would that make sense? Benjamin can you try to make a build with
>>>>>>> that commit reverted, does it fix the problem?
>>>>>> Building the kernel on the Pi Zero would probably take ages. I have a
>>>>>> Raspberry Pi 5 running arm64. That should be able to build the kernel in
>>>>>> a armel schroot, shouldn't it? Is there documentation for building the
>>>>>> kernel?
>>>>> I hope it is fine for Uwe that i respond here, he might have another
>>>>> more efficient way to reach our goal.
>>>>>
>>>>> But we have the simple-patching guideline here:
>>>>> https://protect2.fireeye.com/v1/url?k=6d29844b-0ca29171-6d280f04-74fe4860008a-0bd2c61b0efaf6bb&q=1&e=9d70d889-a8df-4ca7-962f-11b3a6da1b85&u=https%3A%2F%2Fkernel-team.pages.debian.net%2Fkernel-handbook%2Fch-common-tasks.html%23id-1.6.6.4
>>>>>
>>>>> That should work within an armel schroot work well, e.g. on a
>>>>> porterbox amdahl.d.o i would first setup a schroot via:
>>>>>
>>>>> schroot -b -c chroot:trixie_armel-dchroot -n linux
>>>>> dd-schroot-cmd -c linux apt-get update
>>>>> dd-schroot-cmd -c linux apt-get dist-upgrade
>>>>> dd-schroot-cmd -c linux apt-get build-dep linux
>>>>> schroot -r -c linux
>>>>> (see https://dsa.debian.org/doc/schroot/)
>>>>>
>>>>> Then download the linux/6.12.57-1 source and make the revert patch
>>>>> available.
>>>>>
>>>>> apt-get source linux
>>>>> cd linux-*
>>>>> ./debian/bin/test-patches -f rpi ../0001-Revert-of-reserved_mem-Restructure-call-site-for-dma.patch
>>>> In case you can/want trust unsigned packages (but I have put a
>>>> sha256sum along signed with my key in the DD keyring), you can test
>>>> the patch revert via the packages on:
>>>> https://people.debian.org/~carnil/tmp/linux/1116251/
>>> Thanks for providing the kernel. I downloaded linux-image-
>>> 6.12+unreleased-rpi_6.12.57-1a~test_armel.deb and installed it. This
>>> kernel hangs on boot (see attached boot.log). It hangs there
>>> reproducible.
>> The "Linux version 4.14.98+" in the log puzzled me and
>> /etc/kernel/postinst.d/z50-raspi-firmware did not copy kernel
>> 6.12.57-1a~test to /boot/firmware.
>>
>> I found the old kernel.img and kernel7.img that I deleted. I copied the
>> 6.12.57-1a~test kernel manually:
>>
>> ```
>> update-initramfs -u -k 6.12+unreleased-rpi
>> cd /boot/firmware/
>> cp ../vmlinuz-6.12+unreleased-rpi .
>> cp ../initrd.img-6.12+unreleased-rpi .
>> vim config.txt
>> reboot
>> ```
>>
>> Then the Pi booted the correct kernel (6.12+unreleased-rpi) successfully
>> with following cmdline configurations:
>>
>> * no cma set
>> * cma=0
>> * cma=64M
> If I understood right that means that
> 46efab01648a04082266115a8e917c3b26b97fa8 aka
> 2c223f7239f376a90d71903ec474ba887cf21d94 broke booting on the Raspberry
> Pi Zero W when CMA is used.
>
> #regzbot introduced: 2c223f7239f376a90d71903ec474ba887cf21d94
>
> Does this ring a bell for someone, or do you have some debugging
> instructions? Complete context is available at
> https://bugs.debian.org/1116251.

There is a fix posted for this case, but it needs a bit more discussion:

https://lore.kernel.org/all/20251210002027.1171519-1-oreoluwa.babatunde@oss.qualcomm.com/

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

