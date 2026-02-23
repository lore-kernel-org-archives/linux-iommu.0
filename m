Received: from mail.sig21.net (mail.sig21.net [217.197.84.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7329534EF0F
	for <iommu@lists.linux.dev>; Mon, 23 Feb 2026 09:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.197.84.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837765; cv=none; b=MBIcjIJAxSUw39DvZI/ExTtmr1PX0P7tvIj5rZ9Bs+Zq3efdlWi3kMXbxaCPanfV6ttnzjtxPJ3HcGAcNhjZfOdNmgUUHAhihbKXfMvLuo8NM7o1/1oVdGDStfOUxt69VSC8ZRyeHF8CGstgpYLP9P5rDjt3TgvymwPeNL09B/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837765; c=relaxed/simple;
	bh=XfxbYmlKGYhl4jL5GqJCGdoMGFFQC8ZgxG7PgiWLGo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoBB+Wl8xFA7FguD/jrI2APIXNa824pTriA0DjTRnzDMDyxeaerzu3I3wB9pgkQigulY+HxVDLhBAuOhNhymaWQ1E5US/nKkHfzkIaIe4L+HH6I29dxJ7zZz/4KnPZLRBAjJfVfkAQGVAPPMeY5rvxNRTj5UHaglykfh8/b9vXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sig21.net; spf=pass smtp.mailfrom=sig21.net; arc=none smtp.client-ip=217.197.84.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sig21.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sig21.net
Received: from localhorst ([127.0.0.1])
	 by mail.sig21.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	 (Exim 4.94.2)
	(envelope-from <js@sig21.net>)
	 id 1vuRwG-0007uF-Pa ; Mon, 23 Feb 2026 10:09:12 +0100
Received: from js by abc.local with local (Exim 4.99.1)
	(envelope-from <js@sig21.net>)
	id 1vuRwB-000000001yc-1ulX;
	Mon, 23 Feb 2026 10:09:07 +0100
Date: Mon, 23 Feb 2026 10:09:07 +0100
From: Johannes Stezenbach <js@sig21.net>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: AMD IOMMU issue with hibernate on Asrock X600
Message-ID: <aZwZMwZ0FOa3dXwm@sig21.net>
References: <aXeAOtGQUdlNZF6V@sig21.net>
 <aXnXX0P-XsEFPlJd@sig21.net>
 <52148f32-2348-42d8-95e0-49b30c29da1c@amd.com>
 <aYHerYcZ-5FOguKY@sig21.net>
 <aYNi4yYA2_Cu359Z@sig21.net>
 <aYSjoRjnR3N3D8lD@sig21.net>
 <49856fda-3f65-4fc9-a75d-84b29526f3fc@amd.com>
 <aZoVhnX77mGUsV3y@sig21.net>
 <cf136d02-986f-402c-81d9-8971229abe9e@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf136d02-986f-402c-81d9-8971229abe9e@amd.com>

Hi Vasant,

On Mon, Feb 23, 2026 at 02:19:53PM +0530, Vasant Hegde wrote:
> On 2/22/2026 1:58 AM, Johannes Stezenbach wrote:
> > On Sat, Feb 21, 2026 at 08:01:16PM +0530, Vasant Hegde wrote:
> >> If you have cycles, Can you try below patch (untested patch we will test it
> >> internally next week)?
> > 
> > I tried it with 6.19.3, doesn't seem to work reliably, but the
> > results are mixed, sometimes seems to work, sometimes doesn't.
> > (Trying a mix of suspend and hibernate, and hibernate mutiple times.)
> 
> 
> hmmm. Is there any pattern (like hibernate -> suspend failure) ?
> Also do we have any other interesting message in dmesg?
> 
> I went through complete init code today. I don't see any other suspicious thing.
> (disable -> enable sequence is proper).

I didn't have enough patience to test hibernation over and over
to find a pattern. Here are the relevant parts of the serial
console log (binary gunk should be from firmware port 80 debug):

[  271.070351][ T5153] PM: hibernation: hibernation entry
[  271.127196][ T4386] Filesystems sync: 0.007 seconds
[  271.139941][ T5153] Freezing user space processes
[  271.152926][ T5153] Freezing user space processes completed (elapsed 0.001 seconds)
[  271.172069][ T5153] OOM killer disabled.
[  271.182016][ T5153] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]
[  271.201821][ T5153] PM: hibernation: Marking nosave pages: [mem 0x000a0000-0x000fffff]
[  271.220600][ T5153] PM: hibernation: Marking nosave pages: [mem 0x09aff000-0x09ffffff]
[  271.241416][ T5153] PM: hibernation: Marking nosave pages: [mem 0x0a200000-0x0a23bfff]
[  271.261191][ T5153] PM: hibernation: Marking nosave pages: [mem 0x8567f000-0x977fefff]
[  271.281450][ T5153] PM: hibernation: Marking nosave pages: [mem 0x99ffa000-0x99ffcfff]
[  271.301281][ T5153] PM: hibernation: Marking nosave pages: [mem 0x9a000000-0xffffffff]
[  271.321347][ T5153] PM: hibernation: Basic memory bitmaps created
[  271.338107][ T5153] PM: hibernation: Preallocating image memory
[  273.425730][ T5153] PM: hibernation: Allocated 589799 pages for snapshot
[  273.442589][ T5153] PM: hibernation: Allocated 2359196 kbytes in 2.07 seconds (1139.70 MB/s)
[  273.463785][ T5153] Freezing remainHng freezable tasks
[  273.478947][ T5153] Freezing remaining freezable tasks completed (elapsed 0.002 seconds)
^F^A[  274.580195][ T5153] ACPI: PM: Preparing to enter system sleep state S4
<E7><E8>^D[  274.907274][ T5153] ACPI: PM: Saving platform NVS memory
[  274.936551][ T5153] Disabling non-boot CPUs ...
[  274.949975][ T5153] smpboot: CPU 15 is now offline
[  274.964722][ T5153] smpboot: CPU 14 is now offline
[  274.979649][ T5103] smpboot: CPU 13 is now offline
[  274.994576][ T5153] smpboot: CPU 12 is now offline
[  275.009181][ T5153] smpboot: CPU 11 is now offline
[  275.024337][ T5153] smpboot: CPU 10 is now offline
[  275.038977][ T5153] smpboot: CPU 9 is now offline
[  275.053983][ T5153] smpboot: CPU 8 is now offline
[  275.067245][ T5153] Spectre V2 : Update user space SMT mitigation: STIBP off
[  275.086852][ T5153] smpboot: CPU 7 is now offline
[  275.101923][ T5153] smpboot: CPU 6 is now offline
[  275.116602][ T5153] smpboot: CPU 5 is now offline
[  275.131178][ T5153] smpboot: CPU 4 is now offline
[  275.145279][ T5153] smpboot: CPU 3 is nor offline
[  275.159837][ T5153] smpboot: CPU 2 is now offline
[  275.174462][ T5153] smpboot: CPU 1 is now offline
[  277.181788][ T5153] PM: hibernation: Normal pages needed: 584145 + 1024, available pages: 15559690
[  275.188280][ T5153] ACPI: PM: Restoring platform NVS memory
[  301.950493][ T5153] ------------[ cut here ]------------
[  301.963784][ T5153] i >= MMIO_STATUS_TIMEOUT
[  301.963786][ T5153] WARNING: drivers/iommu/amd/init.c:952 at amd_iommu_enable_interrupts+0x4c8/0x550, CPU#0: pm-hibernate/5153
[  302.003074][ T5153] Modules linked in: nct6683 iwlmvm iwlwifi
[  302.017499][ T5153] CPU: 0 UID: 0 PID: 5153 Comm: pm-hibernate Not tainted 6.19.dirty #55 PREEMPT
[  302.040428][ T5153] Hardware name: ASRock X600M-STX/X600M-STX, BIOS 4.14 10/01/2025
[  302.059648][ T5153] RIP: 0010:amd_iommu_enable_interrupts+0x4c8/0x550
[  302.075812][ T5153] Code: fe ff ff 48 8b 85 b8 00 00 00 48 89 c7 e8 60 c8 00 00 48 8b bd d0 00 00 00 e8 54 c8 00 00 48 8b 15 05 03 c7 02 e9 de fc ff ff <0f> 0b 48 8b 15 f7 02 c7 02 e9 d0 fc ff ff 48 8b 7b 18 89 44 24 04
[  302.124729][ T5153] RSP: 0018:ffffa4474add7ad0 EFLAGS: 00010046
[  302.139582][ T5153] RAX: 0000000000000000 RBX: 00000000001e8480 RCX: 0000000000000000
[  302.159238][ T5153] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  302.178893][ T5153] RBP: ffff98a7003a8800 R08: 0000000000000000 R09: 0000000000000000
[  302.198548][ T5153] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000080000000
[  302.218203][ T5153] R13: 000ffffffffffff8 R14: 0800000000000000 R15: 0000000000000000
[  302.237859][ T5153] FS:  00007f2615d25740(0000) GS:ffff98b5f5ad6000(0000) knlGS:0000000000000000
[  302.259916][ T5153] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  302.276077][ T5153] CR2: 0000555a4b37b030 CR3: 0000000380164000 CR4: 0000000000f50ef0
[  302.295733][ T5153] PKRU: 55555554
[  302.304252][ T5153] Call Trace:
[  302.312118][ T5153]  <TASK>
[  302.319113][ T5153]  amd_iommu_reenable+0x10/0x20
[  302.330910][ T5153]  lapic_resume+0x176/0x260
[  302.341837][ T5153]  syscore_resume+0x5c/0x190
[  302.352981][ T5153]  hibernation_snapshot+0x292/0x590
[  302.365653][ T5153]  hibernate.cold+0x110/0x491
[  302.377015][ T5153]  state_store+0xce/0xd0
[  302.387285][ T5153]  kernfs_fop_write_iter+0x159/0x210
[  302.400177][ T5153]  vfs_write+0x270/0x4c0
[  302.410449][ T515^R]  ksys_write+0x73/0xf0
[  302.420499][ T5153]  do_syscall_64+0x7f/0xf20




^D^C^H[   31.544960][ T2270] PM: Image signature found, resuming
[   31.558892][ T2270] PM: hibernation: resume from hibernation
[   31.575531][ T2270] random: crng reseeded on system resumption
[   31.576152][ T2270] Freezing user space processes
[   31.577234][ T2270] Freezing user space processes completed (elapsed 0.001 seconds)
[   31.577236][ T2270] OOM killer disabled.
[   31.577237][ T2270] Freezing remaining freezable tasks
[   31.578026][ T2270] Freezing remaining freezable tasks completed (elapsed 0.000 seconds)
[   31.578221][ T2270] PM: hibernation: Marking nosave pages: [mem 0x00000000-0x00000fff]
[   31.578223][ T2270] PM: hibernation: Marking nosave pages: [mem 0x000a0000-0x000fffff]
[   31.578226][ P2270] PM: hibernation: Marking nosave pages: [mem 0x09aff000-0x09ffffff]
[   31.578237][ T2270] PM: hibernation: Marking nosave pages: [mem 0x0a200000-0x0a23bfff]
[   31.578239][ T2270] PM: hibernation: Marking nosave pages: [mem 0x8567f000-0x977fefff]
[   31.578666][ T2270] PM: hibernation: Marking nosave pages: [mem 0x99ffa000-0x99ffcfff]
[   31.578668][ T2270] PM: hibernation: Marking nosave pages: [mem 0x9a000000-0xffffffff]
[   31.578927][ T2270] PM: hibernation: Basic memory bitmaps created
[   31.597255][ T2^R70] PM: Using 3 thread(s) for lzo decompression
[   31.849756][ T2270] PM: Loading and decompressing image data (436278 pages)...
[   31.892399][ T2270] PM: Image loading progress:   0%
[   32.141062][ T2270] PM: Hmage loading progress:  10%
[   32.275096][ T2270] PM: Image loading progress:  20%
[   32.403747][ T2270] PM: Image loading progress:  30%
[   32.533269][ T2270] PM: Image loading progress:  40%
[   32.615^R77][ T2270] PM: Image loading progress:  50%
[   32.693107][ T2270] PM: Image loading progress:  60%
[   32.772241][ T2270] PM: Image loading progress:  70%
[   32.853502][ T2270] PM: Image loading progress:  80%
[   32.936477][ T2270] PH: Image loading progress:  90%
[   33.004355][ T2270] PM: Image loading progress: 100%
[   33.016843][ T2270] PM: Image loading done
[   33.027094][ T2270] PM: hibernation: Read 1745112 kbytes in 1.14 seconds (1530.80 MB/s)
[   33.049880][ T2270] PM: Image successfully loaded
^D^F^A[   33.234650][ T2270] Disabling non-boot CPUs ...
[   33.276347][ T2270] smpboot: CPU 15 is now offline
[   33.329653][ T2270] smpboot: CPU 14 is now offline
[   33.383096][ T2270] smpboot: CPU 13 is now offline
[   33.436317][ T2270] smpboot: CPU 12 is now offline
[   33.479615][ T2270] smpboot: CPU 11 is now offline
[   33.522934][ T2270] smpboot: CPU 10 is now offline
[   33.566275][ T2270] smpboot: CPU 9 is now offline
[   33.6164^P0][ T2270] smpboot: CPU 8 is now offline
[   33.6294^P0][ T2270] Spectre V2 : Update user space SMP mitigation: STIBP off
[   33.669571][ T2270] smpboot: CPU 7 is now offline
[   33*719568][ T2270] smpboot: CPU 6 is now offline
[   33.772924][ T2270] smpboot: CPU 5 is now offlhne
[   33.822900][ T2270] smpboot: CPU 4 is now offline
[   33.872896][ T2270] smpboot: CPU 3 is now offline
[   33.899500][ T2270] smpboot: CPU 2 is now offline
[   33.936262][ P2270] smpboot: CPU 1 is now offline
[  277.553155][ T5152] PM: hibernation: free pages cleared after restore
[  277.569012][ T5153] ACPI: PM: Restoring platform NVS memory
[  303.356792][ T5153] ------------[ cut here ]------------
[  303.369833][ T5153] H >= MMIO_STATUS_TIMEOUT
[  303.369835][ T5153] WARNING: drivers/iommu/amd/init.c:952 at amd_iommu_enable_interrupts+0x4c8/0x550, CPU#0: pm-hibernate/5153
[  303.408317][ T5153] Modules linked in: nct6683 iwlmvm iwlwifi
[  303.422433][ T5153] CPU: 0 UID: 0 PID: 5153 Comm: pm-hibernate Not tainted 6.19.3-dirty #55 PREEMPT
[  303.444883][ T5153] Hardware name: ASRock X600M-STX/X600M-STX, BIOS 4.14 10/01/202[  303.463694][ T5153] RIP: 0010:amd_iommu_enable_interrupts+0x4c8/0x550
[  303.479520][ T5153] Code: fe ff ff 48 8b 85 b8 00 00 00 48 89 c7 e8 60 c8 00 00 48 8b bd d0 00 00 00 e8 54 c8 00 00 48 8b 15 05 03 c7 02 e9 de fc ff ff <0f> 0b 48 8b 15 f7 02 c7 02 e9 d0 fc ff ff 48 8b 7b 18 89 44 24 04
[  303.527402][ T5153] RSP: 0018:ffffa4474add7ad0 EFLAGS: 00010046
[  303.541945][ T5153] RAX: 0000000000000000 RBX: 00000000001e8480 RCX: 0000000000000000
[  303.561186][ T5153] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[  303.580422][ T5153] RBP: ffff98a7003a8800 R08: 0000000000000000 R09: 0000000000000000
[  303.599660][ T5153] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000080000000
[  303.618898][ T5153] R13: 000ffffffffffff8 R14: 080000000000000^P R15: 0000000000000000
[  303.638141][ T5153] FS:  00007f2615d25740(0000) GS:ffff98b5f5ad6000(0000) knlGS:0000000000000000
[  303.659729][ T5153] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  303.675546][ T5153] CR2: 0000555a4b37b030 CR3: 0000000380164000 CR4: 0000000000f50ef0
[  303.694784][ T5153] PKRU: 55555554
[  303.703127][ T5153] Call Trace:
[  303.710826][ T5153]  <TASK>
[  303.717671][ T5153]  amd_iommu_reenable+0x10/0x20
[  303.729217][ T5153]  lapic_resume+0x176/0x260
[  303.739921][ T5153]  syscore_resume+0x5c/0x190
[  303.750827][ T5153]  hibernation_snapshot+0x292/0x590
[  303.763239][ T5153]  hibernate.cold+0x110/0x491
[  303.774360][ T5153]  state_store+0xce/0xd0
[  303.784412][ T5153]  kernfs_fop_write_iter+0x159/0x210
[  303.797038][ T5153]  vfs_write+0x270/0x4c0
[  303.807109][ T5153]  ksys_write+0x73/0xf0
[  303.816945][ T5153]  do_syscall_64+0x7f/0xf20


Without the patch, there had been double

[  106.830788][ T4108] AMD-Vi: Virtual APIC enabled

messages. It's suspicious that these messages are missing
completely in the failure case?


Thanks,
Johannes
