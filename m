Received: from mail.sig21.net (mail.sig21.net [217.197.84.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228E73EF0C3
	for <iommu@lists.linux.dev>; Thu,  5 Feb 2026 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.197.84.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300327; cv=none; b=mZjCGMXHiCLrBUiBtn7K7srFvhK94/kDkLuAwFFAellU0Z/O+bB8mdCFwGfei96Ez9ofRPC73RubhimyREJnq+BqKhAHdTBWYxXNBP0wyIh/J/IrcEHYiYLfNg/Z9KSMCqY3HR8aZUJxFdHf9zigXQ2SzTpqM1IpPNiYzCAPi9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300327; c=relaxed/simple;
	bh=OviBRzvDsv3X2xltqOIL7ZKF4dOtOuGr50O8D5gqaUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TddI3ag1XwST6+/huMQLV/SlYmWcgAN9sVtY7kGNazalk7DAbPngq0i2ueMufAJbLn/oo/HMtO425tjVK9gUOnWPDMPcB9vBO3TG7DItdo2QqpbFROv6W9YvM1pzIohW/4z1aCOizVTDgT0EtvDLmnSmvgUHYXGPMgu+1BXQi8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sig21.net; spf=pass smtp.mailfrom=sig21.net; arc=none smtp.client-ip=217.197.84.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sig21.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sig21.net
Received: from localhorst ([127.0.0.1])
	 by mail.sig21.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	 (Exim 4.94.2)
	(envelope-from <js@sig21.net>)
	 id 1vnzz0-0002Gy-4f ; Thu, 05 Feb 2026 15:05:22 +0100
Received: from js by abc.local with local (Exim 4.99.1)
	(envelope-from <js@sig21.net>)
	id 1vnzyz-000000001ji-123l;
	Thu, 05 Feb 2026 15:05:21 +0100
Date: Thu, 5 Feb 2026 15:05:21 +0100
From: Johannes Stezenbach <js@sig21.net>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: AMD IOMMU issue with hibernate on Asrock X600
Message-ID: <aYSjoRjnR3N3D8lD@sig21.net>
References: <aXeAOtGQUdlNZF6V@sig21.net>
 <aXnXX0P-XsEFPlJd@sig21.net>
 <52148f32-2348-42d8-95e0-49b30c29da1c@amd.com>
 <aYHerYcZ-5FOguKY@sig21.net>
 <aYNi4yYA2_Cu359Z@sig21.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYNi4yYA2_Cu359Z@sig21.net>

On Wed, Feb 04, 2026 at 04:16:51PM +0100, Johannes Stezenbach wrote:
> I'm also attaching the ACPI IVRS table.
> 
> Side note: I wanted to check AMD documents at https://docs.amd.com/
> but the "Create Account" button doesn't work. :-(
> (And why do they require an account anyway, Intel and ARM don't...)

Eventually I could download the "AMD I/O Virtualization Technology
(IOMMU) Specification" document (link on https://uefi.org/acpi
is stale, BTW).

> [074h 0116 001h]               Subtable Type : 11 [Hardware Definition Block (IVHD)]
> [075h 0117 001h]       Flags (decoded below) : 30
>                                      HtTunEn : 0
>                                       PassPW : 0
>                                    ResPassPW : 0
>                                 Isoc Control : 0
>                                Iotlb Support : 1
>                                     Coherent : 1
>                             Prefetch Support : 0
>                                  PPR Support : 0
> [076h 0118 002h]                      Length : 0054
> [078h 0120 002h]                    DeviceId : 0002
> [07Ah 0122 002h]           Capability Offset : 0040
> [07Ch 0124 008h]                Base Address : 00000000F7500000
> [084h 0132 002h]           PCI Segment Group : 0000
> [086h 0134 002h]         Virtualization Info : 0000
> [088h 0136 004h]                  Attributes : 00048000
> [08Ch 0140 008h]                   EFR Image : 246577EFA2254AFA
> [094h 0148 008h]                    Reserved : 0000000000000000

So the platform doesn't support x2APIC, but it's no problem.
GALog should be supported.

I added a printk for the MMIO_STATUS_OFFSET register after
the wait loop, and a WARN_ON(1) at the end of
iommu_ga_log_enable() to find all call chains.
Below are the important parts of the log, it shows on resume
iommu_ga_log_enable() is called twice:

1. from lapic_resume() syscore_ops via
   irq_remapping_reenable() -> amd_iommu_reenable()

2. from amd_iommu_resume() syscore_ops

The first time works, the second time fails.
amd_iommu_resume() calls early_enable_iommu() -> iommu_disable(),
maybe this double enable+disable in quick succession triggers
the problem?

BTW, iommu_init_ga_log() is called everytime in
enable_iommus_vapic() and allocates new ga_log
and ga_log_tail buffers, but the previous allocation
is never freed.


Best Regards,
Johannes



Log excerpts:
At bootup:

[    2.609023] [    T1] AMD-Vi: Extended features (0x246577efa2254afa, 0x0): PPR NX GT [5] IA GA PC GA_vAPIC
[    2.609036] [    T1] AMD-Vi: Interrupt remapping enabled
[    2.643865] [    T1] AMD-Vi: iommu_ga_log_enable status 00000118

[    2.643887] [    T1] WARNING: drivers/iommu/amd/init.c:956 at amd_iommu_enable_interrupts.cold+0xf/0x9d, CPU#4: swapper/0/1
[    2.644009] [    T1] Call Trace:
[    2.644015] [    T1]  <TASK>
[    2.644021] [    T1]  iommu_go_to_state+0xb20/0x1830
[    2.644031] [    T1]  ? __pfx_pci_iommu_init+0x10/0x10
[    2.644039] [    T1]  pci_iommu_init+0x15/0x40
[    2.644047] [    T1]  do_one_initcall+0x5b/0x310

[    2.644137] [    T1] AMD-Vi: Virtual APIC enabled


S3 suspend + resume:

[   55.915000] [ T3615] ACPI: PM: Low-level resume complete
[   55.915029] [ T3615] ACPI: PM: Restoring platform NVS memory
[   58.883988] [ T3615] AMD-Vi: iommu_ga_log_enable status 00000118

[   58.883997] [ T3615] WARNING: drivers/iommu/amd/init.c:956 at amd_iommu_enable_interrupts.cold+0xf/0x9d, CPU#0: pm-suspend/3615

[   58.884026] [ T3615] Call Trace:
[   58.884028] [ T3615]  <TASK>
[   58.884030] [ T3615]  amd_iommu_reenable+0x57/0x70
[   58.884034] [ T3615]  lapic_resume+0x176/0x260
[   58.884038] [ T3615]  syscore_resume+0x5c/0x190
[   58.884040] [ T3615]  suspend_devices_and_enter+0x752/0x870
[   58.884044] [ T3615]  pm_suspend.cold+0x2e1/0x35f

[   58.884167] [ T3615] AMD-Vi: Virtual APIC enabled
[   63.874343] [ T3615] AMD-Vi: iommu_ga_log_enable status 00000118

[   63.874351] [ T3615] WARNING: drivers/iommu/amd/init.c:956 at amd_iommu_enable_interrupts.cold+0xf/0x9d, CPU#0: pm-suspend/3615

[   63.874382] [ T3615] Call Trace:
[   63.874384] [ T3615]  <TASK>
[   63.874386] [ T3615]  syscore_resume+0x5c/0x190
[   63.874388] [ T3615]  suspend_devices_and_enter+0x752/0x870
[   63.874391] [ T3615]  pm_suspend.cold+0x2e1/0x35f
[   63.874394] [ T3615]  state_store+0x6b/0xd0
[   63.874398] [ T3615]  kernfs_fop_write_iter+0x159/0x210
[   63.874401] [ T3615]  vfs_write+0x270/0x4c0
[   63.874407] [ T3615]  ksys_write+0x73/0xf0

[   63.874563] [ T3615] AMD-Vi: Virtual APIC enabled


S4 hibernate + resume:

[  113.664694] [ T4023] PM: hibernation: Normal pages needed: 594162 + 1024, available pages: 15549652
[  114.020974] [ T4023] PM: hibernation: free pages cleared after restore
[  114.020993] [ T4023] ACPI: PM: Restoring platform NVS memory
[  115.909880] [ T4023] AMD-Vi: iommu_ga_log_enable status 00000118

[  115.909892] [ T4023] WARNING: drivers/iommu/amd/init.c:956 at amd_iommu_enable_interrupts.cold+0xf/0x9d, CPU#0: pm-hibernate/4023

[  115.909926] [ T4023] Call Trace:
[  115.909928] [ T4023]  <TASK>
[  115.909931] [ T4023]  amd_iommu_reenable+0x57/0x70
[  115.909936] [ T4023]  lapic_resume+0x176/0x260
[  115.909940] [ T4023]  syscore_resume+0x5c/0x190
[  115.909943] [ T4023]  hibernation_snapshot+0x292/0x590
[  115.909947] [ T4023]  hibernate.cold+0x110/0x491
[  115.909950] [ T4023]  state_store+0xce/0xd0
[  115.909954] [ T4023]  kernfs_fop_write_iter+0x159/0x210
[  115.909958] [ T4023]  vfs_write+0x270/0x4c0
[  115.909964] [ T4023]  ksys_write+0x73/0xf0

[  115.910063] [ T4023] AMD-Vi: Virtual APIC enabled
[  142.633907] [ T4023] AMD-Vi: iommu_ga_log_enable status 00000018
[  142.633912] [ T4023] ------------[ cut here ]------------
[  142.633912] [ T4023] i >= MMIO_STATUS_TIMEOUT
[  142.633913] [ T4023] WARNING: drivers/iommu/amd/init.c:953 at amd_iommu_enable_interrupts+0x4d2/0x500, CPU#0: pm-hibernate/4023

[  142.633937] [ T4023] Call Trace:
[  142.633938] [ T4023]  <TASK>
[  142.633939] [ T4023]  syscore_resume+0x5c/0x190
[  142.633941] [ T4023]  hibernation_snapshot+0x292/0x590
[  142.633943] [ T4023]  hibernate.cold+0x110/0x491
[  142.633945] [ T4023]  state_store+0xce/0xd0
[  142.633948] [ T4023]  kernfs_fop_write_iter+0x159/0x210
[  142.633950] [ T4023]  vfs_write+0x270/0x4c0
[  142.633955] [ T4023]  ksys_write+0x73/0xf0

[  142.634072] [ T4023] LVT offset 0 assigned for vector 0x400
[  142.634583] [ T4023] Enabling non-boot CPUs ...

