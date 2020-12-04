Return-Path: <SRS0=gcKa=FI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CADC4361A
	for <iommu@archiver.kernel.org>; Fri,  4 Dec 2020 15:10:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584E222B3F
	for <iommu@archiver.kernel.org>; Fri,  4 Dec 2020 15:10:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584E222B3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 05BEF8718D;
	Fri,  4 Dec 2020 15:10:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A2arlmk2bgqW; Fri,  4 Dec 2020 15:10:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A6A9187144;
	Fri,  4 Dec 2020 15:10:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BC70C0FA8;
	Fri,  4 Dec 2020 15:10:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42946C013B
 for <iommu@lists.linux-foundation.org>; Fri,  4 Dec 2020 15:10:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 240CB2E319
 for <iommu@lists.linux-foundation.org>; Fri,  4 Dec 2020 15:10:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EdwsvGMUBRcm for <iommu@lists.linux-foundation.org>;
 Fri,  4 Dec 2020 15:10:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com
 [209.85.221.178])
 by silver.osuosl.org (Postfix) with ESMTPS id B71EE2E308
 for <iommu@lists.linux-foundation.org>; Fri,  4 Dec 2020 15:10:26 +0000 (UTC)
Received: by mail-vk1-f178.google.com with SMTP id h133so325652vka.6
 for <iommu@lists.linux-foundation.org>; Fri, 04 Dec 2020 07:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=yr79ws+aRz6CL7NXpRXk5pCdKTWdLSe/OS1y/B0KD0M=;
 b=NvSd3sW9jejAsqzbQ8VNUZXEgnsZkSZ4hHX/4e1e3qzmGEn8EU0c8eYbVQerzT+oqk
 Es2k198+8bDXd0R9Jg1MwM3ATc1xpuj0E7qLRQvVWOZgveVkUHSEYIV9Q6ANd8ycjRIi
 t8P3VSyZGXL4jaZWLALkfEklsGuV5B/gNnZpiADYL+xUk7w4AkQ5cqEkn7Wz1i6+VZMA
 0Czx04Zpwb56q3wQq93mLth3GacZRK7JNOKWwK5zA1gIIoXYUPN74/U3XtMvRRde9XS/
 NTRxfRrI3GJTQJ1Mz+S/37AfxDeN0Uoa981r1YKPZXmGKofQ/SLtlrv9joThmeCjgrU7
 myWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=yr79ws+aRz6CL7NXpRXk5pCdKTWdLSe/OS1y/B0KD0M=;
 b=h7DdaJidrgpczMEbfrRY4/SL/QzGM8nxdN1SUBwc8iPPAQ4/BUm4yg/2u32NcalBtM
 MEgt773a1kPl5CBiaoMVJ69Njo9uCMbV55gq8VEcZAoOWwFjekAwS+08AuvpmcLLhdn/
 lv9wd4joaz7WpqHPq5GgwnkLlAmhmWNZgMlKrZjVZjk8aKpNE+AdDCybfTP0s/toEIUR
 aomSFtHVYmmqdfrYhnJJf34DWvsjxKImET06Husd2IrZ9qfe8OiwCOt28r6EcDw75BHH
 qtetZTYxCyj9mRVw+XXIZ0LA6zchrB/EFUpK6SNojAMXAgCX7LPzXpQqxNo4Hb8LdF7P
 T6Zg==
X-Gm-Message-State: AOAM533zC8E1j4FVpV2bf+zZQNIyNnDEUIEOosHrjEBcp3H2tpABIXms
 vBvhJ1+C9NbemRdqdqmJlIKhnv+syp3g3MYivygGmC/Uo/Fkgw==
X-Google-Smtp-Source: ABdhPJyNjjH/OXdabOq/MGbooJy0zHuZOwfxqCxBO8Ho5gK+foLJqVIE5j1G/wmTwRpORPVa8Y7DBHM1A3J2YB57EqE=
X-Received: by 2002:a1f:b40c:: with SMTP id d12mr3950280vkf.17.1607094625258; 
 Fri, 04 Dec 2020 07:10:25 -0800 (PST)
MIME-Version: 1.0
References: <CAH6h+heGo0bV20LRV5dP2VvH1j-kD_DMSK=aHr4ZpbBuuHT1DA@mail.gmail.com>
In-Reply-To: <CAH6h+heGo0bV20LRV5dP2VvH1j-kD_DMSK=aHr4ZpbBuuHT1DA@mail.gmail.com>
From: Marc Smith <msmith626@gmail.com>
Date: Fri, 4 Dec 2020 10:10:14 -0500
Message-ID: <CAH6h+hecOE_RYKYcZW7=2fNKT+=ebBHa-10u=1vW5+AKr_gSzg@mail.gmail.com>
Subject: Re: AMD-Vi: Event logged [IO_PAGE_FAULT device=42:00.0 domain=0x005e
 address=0xfffffffdf8030000 flags=0x0008]
To: iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Dec 3, 2020 at 1:18 AM Marc Smith <msmith626@gmail.com> wrote:
>
> Hi,
>
> First, I must preface this email by apologizing in advance for asking
> about a distro kernel (RHEL in this case); so not truly reporting this
> problem and requesting a fix here (I know this should be taken up with
> the vendor), rather hoping someone can give me a few hints/pointers on
> where to look next for debugging this issue.
>
> I'm using RHEL 7.8.2003 (CentOS) with a 3.10.0-1127.18.2.el7 kernel.
> The systems use a Supermicro H12SSW-NT board (AMD), and we have the
> IOMMU enabled along with SR-IOV. I have several virtual machines (QEMU
> KVM) that run on these servers, and I'm passing PCIe end-points into
> the VMs (in some cases the whole PCIe EP itself, and for some devices
> I use SR-IOV and pass in the VFs to the VMs). The VM's run Linux as
> their guest OS (a couple different distros).
>
> While the servers (VMs) are idle, I don't experience any problems. But
> when I start doing a lot of I/O in the virtual machines (iSCSI across
> Ethernet interfaces, disk I/O via SAS HBAs that are passed into the
> VM, etc.) I notice the following after some time at the host layer
> ("hypervisor"):
> Nov 29 10:50:00 node1 kernel: AMD-Vi: Event logged [IO_PAGE_FAULT
> device=42:00.0 domain=0x005e address=0xfffffffdf8030000 flags=0x0008]
> Nov 29 22:02:03 node1 kernel: AMD-Vi: Event logged [IO_PAGE_FAULT
> device=c8:02.1 domain=0x005f address=0xfffffffdf8060000 flags=0x0008]
> Nov 30 02:13:54 node1 kernel: AMD-Vi: Event logged [IO_PAGE_FAULT
> device=42:00.0 domain=0x005e address=0xfffffffdf8020000 flags=0x0008]
> Nov 30 02:28:44 node1 kernel: AMD-Vi: Event logged [IO_PAGE_FAULT
> device=c8:02.0 domain=0x005e address=0xfffffffdf8020000 flags=0x0008]
> Nov 30 10:48:53 node1 kernel: AMD-Vi: Event logged [IO_PAGE_FAULT
> device=01:00.0 domain=0x005e address=0xfffffffdf8040000 flags=0x0008]
> Dec  2 07:05:22 node1 kernel: AMD-Vi: Event logged [IO_PAGE_FAULT
> device=c8:03.0 domain=0x005e address=0xfffffffdf8010000 flags=0x0008]
>
> These events happen to all PCIe devices that are passed into the VMs,
> although not all at once... as you can see on the timestamps above,
> they are not very frequent when under heavy load (in the log snippet
> above, the system was doing a big workload over several days). For the
> Ethernet devices that are passed into the VMs, I noticed that they
> experience transmit hangs / resets in the virtual machines, and when
> these occur, they correspond to a matching IO_PAGE_FAULT that belongs
> to that PCI device.
>
> FWIW, those NIC hangs look like this (visible in the VM guest OS):
> [17879.279091] NETDEV WATCHDOG: s1p1 (bnxt_en): transmit queue 2 timed out
> [17879.279111] WARNING: CPU: 5 PID: 0 at net/sched/sch_generic.c:447
> dev_watchdog+0x121/0x17e
> ...
> [17879.279213] bnxt_en 0000:01:09.0 s1p1: TX timeout detected,
> starting reset task!
> [17883.075299] bnxt_en 0000:01:09.0 s1p1: Resp cmpl intr err msg: 0x51
> [17883.075302] bnxt_en 0000:01:09.0 s1p1: hwrm_ring_free type 1
> failed. rc:fffffff0 err:0
> [17886.957100] bnxt_en 0000:01:09.0 s1p1: Resp cmpl intr err msg: 0x51
> [17886.957103] bnxt_en 0000:01:09.0 s1p1: hwrm_ring_free type 2
> failed. rc:fffffff0 err:0
> [17890.843023] bnxt_en 0000:01:09.0 s1p1: Resp cmpl intr err msg: 0x51
> [17890.843025] bnxt_en 0000:01:09.0 s1p1: hwrm_ring_free type 2
> failed. rc:fffffff0 err:0
>
> We see these NIC hangs in the VMs occur with both Broadcom and
> Mellanox Ethernet adapters that are passed into the VMs, so I don't
> think it's the NICs causing the IO_PAGE_FAULT events observed in the
> hypervisor. Plus we see IO_PAGE_FAULT's for devices other than
> Ethernet adapters.
>
>
> I have several of these same servers (all using the same motherboard,
> processor, memory, BIOS, etc.) and they all experience this behavior
> with the IO_PAGE_FAULT events, so I don't believe it to be any one
> faulty server / component. I guess my question is I'm not sure where
> to dig/push next. Is this perhaps an issue with the BIOS/firmware on
> these motherboards? Something with the chipset (AMD IOMMU)? A
> colleague has suggested that even the AGESA may be related. Or should
> I be focusing on the Linux kernel, the AMD IOMMU driver (software)?
>
> I've been poking around other similar bug reports, and I see the
> IO_PAGE_FAULT and NIC reset / transmit hang seem to be related in
> other posts. This commit looked promising:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4e50ce03976fbc8ae995a000c4b10c737467beaa
>
> But I see RH has already back-ported it into their
> 3.10.0-1127.18.2.el7 kernel source. I'm open to trying a newer Linux
> vanilla kernel (eg, 5.4.x) but would prefer to resolve this in the
> RHEL kernel I'm using now. I'll take a look at this next, although due
> to the complex nature of this hypervisor/VM setup, it's a bit tedious
> to test.
>
>
> Kernel messages from boot (using the amd_iommu_dump=1 parameter):
> ...
> [    0.214395] AMD-Vi: Using IVHD type 0x11
> [    0.214627] AMD-Vi: device: c0:00.2 cap: 0040 seg: 0 flags: b0 info 0000
> [    0.214628] AMD-Vi:        mmio-addr: 00000000f3700000
> [    0.214634] AMD-Vi:   DEV_SELECT_RANGE_START  devid: c0:01.0 flags: 00
> [    0.214635] AMD-Vi:   DEV_RANGE_END           devid: ff:1f.6
> [    0.214763] AMD-Vi:   DEV_SPECIAL(IOAPIC[241])               devid: c0:00.1
> [    0.214765] AMD-Vi: device: 80:00.2 cap: 0040 seg: 0 flags: b0 info 0000
> [    0.214766] AMD-Vi:        mmio-addr: 00000000f2600000
> [    0.214771] AMD-Vi:   DEV_SELECT_RANGE_START  devid: 80:01.0 flags: 00
> [    0.214772] AMD-Vi:   DEV_RANGE_END           devid: bf:1f.6
> [    0.214900] AMD-Vi:   DEV_SPECIAL(IOAPIC[242])               devid: 80:00.1
> [    0.214901] AMD-Vi: device: 40:00.2 cap: 0040 seg: 0 flags: b0 info 0000
> [    0.214902] AMD-Vi:        mmio-addr: 00000000b4800000
> [    0.214906] AMD-Vi:   DEV_SELECT_RANGE_START  devid: 40:01.0 flags: 00
> [    0.214907] AMD-Vi:   DEV_RANGE_END           devid: 7f:1f.6
> [    0.215036] AMD-Vi:   DEV_SPECIAL(IOAPIC[243])               devid: 40:00.1
> [    0.215037] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: b0 info 0000
> [    0.215038] AMD-Vi:        mmio-addr: 00000000fc800000
> [    0.215044] AMD-Vi:   DEV_SELECT_RANGE_START  devid: 00:01.0 flags: 00
> [    0.215045] AMD-Vi:   DEV_RANGE_END           devid: 3f:1f.6
> [    0.215173] AMD-Vi:   DEV_ALIAS_RANGE                 devid:
> ff:00.0 flags: 00 devid_to: 00:14.4
> [    0.215174] AMD-Vi:   DEV_RANGE_END           devid: ff:1f.7
> [    0.215179] AMD-Vi:   DEV_SPECIAL(HPET[0])           devid: 00:14.0
> [    0.215180] AMD-Vi:   DEV_SPECIAL(IOAPIC[240])               devid: 00:14.0
> [    0.215181] AMD-Vi:   DEV_SPECIAL(IOAPIC[244])               devid: 00:00.1
> ...
> [    4.345723] AMD-Vi: Found IOMMU at 0000:c0:00.2 cap 0x40
> [    4.345724] AMD-Vi: Extended features (0x58f77ef22294ade):
> [    4.345724]  PPR X2APIC NX GT IA GA PC GA_vAPIC
> [    4.345728] AMD-Vi: Found IOMMU at 0000:80:00.2 cap 0x40
> [    4.345729] AMD-Vi: Extended features (0x58f77ef22294ade):
> [    4.345729]  PPR X2APIC NX GT IA GA PC GA_vAPIC
> [    4.345731] AMD-Vi: Found IOMMU at 0000:40:00.2 cap 0x40
> [    4.345732] AMD-Vi: Extended features (0x58f77ef22294ade):
> [    4.345733]  PPR X2APIC NX GT IA GA PC GA_vAPIC
> [    4.345735] AMD-Vi: Found IOMMU at 0000:00:00.2 cap 0x40
> [    4.345735] AMD-Vi: Extended features (0x58f77ef22294ade):
> [    4.345736]  PPR X2APIC NX GT IA GA PC GA_vAPIC
> [    4.345737] AMD-Vi: Interrupt remapping enabled
> [    4.345738] AMD-Vi: virtual APIC enabled
> [    4.345739] AMD-Vi: X2APIC enabled
> [    4.345805] pci 0000:c0:00.2: irq 26 for MSI/MSI-X
> [    4.345947] pci 0000:80:00.2: irq 27 for MSI/MSI-X
> [    4.346073] pci 0000:40:00.2: irq 28 for MSI/MSI-X
> [    4.346208] pci 0000:00:00.2: irq 29 for MSI/MSI-X
> [    4.346305] AMD-Vi: IO/TLB flush on unmap enabled
> ...
>
> I have also tried using 'amd_iommu=fullflush' (as denoted in the
> kernel message above) on a hunch after reviewing other user's posts
> with similar IO_PAGE_FAULT events, but this doesn't seem to change
> anything -- the events still occur with or without this kernel
> parameter.
>
> So, any guidance/tips/advice on how to tackle this would be greatly
> appreciated. Thank you for your consideration and time!

I booted the systems with "amd_iommu_intr=legacy" and the problem went
away! No more IO_PAGE_FAULT's in the hypervisor, and no NIC
hangs/resets in the virtual machines! No noticeable degradation of I/O
performance either. Confirmed on two systems.

--Marc

>
>
> --Marc
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
