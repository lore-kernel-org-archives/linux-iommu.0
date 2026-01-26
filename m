Received: from mail.sig21.net (mail.sig21.net [217.197.84.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F6D3375A6
	for <iommu@lists.linux.dev>; Mon, 26 Jan 2026 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.197.84.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769440358; cv=none; b=WYzibwK49hdDm6LbNo2NozF6q4V4h0k7cVpzR/8bscSomBX+nC5+Vxz++CBxknkiFyYR1EHGVyQnNLrRbuu35ksEcu3uUg+ZJyr8ML9oiEJnUvallY19j0A9zaoNyUyquiCjMnU7aa1YaGQwGhK9H83jd+IBAvfrCmzovnU5HUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769440358; c=relaxed/simple;
	bh=S1KUWsq5OgneXXpeZFqAuoQD9+wgMLTQyWvYicbCoho=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MPTntmFNrNX7O/5canizhbMR/xwaDHOgmt8RsuHfUP4nyVhFWmKxDjkSgIIu3I0UbY6Qk/wDB0XWIc3MJSKZaJ8/ru7H3gWXTH31IHtKs8i2AFvDlsp3fmzWzItRQ1X0h8k1yKNWWjtPHW1LyQL26T7rQNW6hjWUpcyy+fEz3zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sig21.net; spf=pass smtp.mailfrom=sig21.net; arc=none smtp.client-ip=217.197.84.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sig21.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sig21.net
Received: from localhorst ([127.0.0.1])
	 by mail.sig21.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	 (Exim 4.94.2)
	(envelope-from <js@sig21.net>)
	 id 1vkNzP-0000D2-PS 
	for iommu@lists.linux.dev; Mon, 26 Jan 2026 15:54:51 +0100
Received: from js by abc.local with local (Exim 4.99.1)
	(envelope-from <js@sig21.net>)
	id 1vkNzO-0000000053d-27PA
	for iommu@lists.linux.dev;
	Mon, 26 Jan 2026 15:54:50 +0100
Date: Mon, 26 Jan 2026 15:54:50 +0100
From: Johannes Stezenbach <js@sig21.net>
To: iommu@lists.linux.dev
Subject: AMD IOMMU issue with hibernate on Asrock X600
Message-ID: <aXeAOtGQUdlNZF6V@sig21.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

hibernate on Asrock Deskmini X600 with Ryzen 7 8700G hangs for
about one minute before the power is turned off. It happens with
older kernels but also still with 6.19.0-rc6-00200-gc072629f05d7.
Sometimes it also hangs for about half a minute after resume from
hibernate.

After some experimenting I found it can be worked around with
amd_iommu_intr=3Dlegacy. But below is the log without the
workaround. Is this a firmware issue or Linux bug?

Maybe related is an error during suspend-to-ram/resume printed
in dmesg but with no apparent consequence:

[2026-01-22 15:33:04.697] [  481.521027][ T4697] smpboot: Booting Node 0 Pr=
ocessor 9 APIC 0x3
[2026-01-22 15:33:04.752] [  481.588284][    C9] Spurious APIC interrupt (v=
ector 0xFF) on CPU#9, should never happen.
[2026-01-22 15:33:04.753] [  481.609421][ T4697] CPU9 is up

(repeats for all SMT CPU siblings CPU9-15)
This error does not occur on hibernate+resume.

Maybe related: BIOS has an option for the IOAPIC to enable x2APIC
mode, but when I enabled it the kernel can boot in text mode, but
amdgpu interrupts don't work.

APIC related boot messages:

[    1.630911][    T0] ACPI: LAPIC_NMI (acpi_id[0xff] high edge lint[0x1])
[    1.647515][    T0] IOAPIC[0]: apic_id 32, version 33, address 0xfec0000=
0, GSI 0-23
[    1.666717][    T0] IOAPIC[1]: apic_id 33, version 33, address 0xfec0100=
0, GSI 24-55
[    1.686135][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl =
dfl)
[    1.703812][    T0] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low =
level)
[    1.721926][    T0] ACPI: Using ACPI (MADT) for SMP configuration inform=
ation

[    2.805841][    T0] APIC: Switch to symmetric I/O mode setup
[    2.820496][    T0] AMD-Vi: Using global IVHD EFR:0x246577efa2254afa, EF=
R2:0x0

[    5.927269][    T1] ACPI: Using IOAPIC for interrupt routing

[   11.377266][    T1] AMD-Vi: Extended features (0x246577efa2254afa, 0x0):=
 PPR NX GT [5] IA GA PC GA_vAPIC
[   11.401017][    T1] AMD-Vi: Interrupt remapping enabled
[   11.907996][    T1] AMD-Vi: Virtual APIC enabled



Hibernate log (first column is minicom timestamp relative
to previous line, see follow-up mail about port80 UART):

[192.926] [  285.082216][ T4340] PM: hibernation: hibernation entry
[0.125] [  285.173051][   T97] Filesystems sync: 0.007 secoJds
[0.000] [  285.185793][ T4340] Freezing user space processes
[0.000] [  285.199143][ T4340] Freezing user space processes completed (ela=
psed 0.001 seconds)
[0.001] [  285.218331][ T4340] OOM killer disabled.
[0.000] [  285.228528][ T4340] PM: hibernation: Marking nosave pages: [mem =
0x00000000-0x00000fff]
[0.052] [  285.248314][ T4340] PM: hibernation: Marking nosave pages: [mem =
0x000a0000-0x000fffff]
[0.000] [  285.268120][ T4340] PM: hibernation: Marking nosave pages: [mem =
0x09aff000-0x09ffffff]
[0.050] [  285.287941][ T4340] PM: hibernation: Marking norave pages: [mem =
0x0a200000-0x0a23bfff]
[0.000] [  285.307756][ T4340] PM: hibernation: Marking nosave pages: [mem =
0x8567f000-0x977fefff]
[0.000] [  285.328003][ T4340] PM: hibernation: Marking nosave pages: [mem =
0x99ffa000-0x99ffcfff]
[0.057] [  285.347804][ T4340] PM: hibernation: Marking nosave pages: [mem =
0x9a000000-0xffffffff]
[0.000] [  285.367872][ T4340] PM: hibernation: Basic memory bitmaps created
[0.000] [  285.385430][ T4340] PM: hibernation: Preallocating image memory
[2.140] [  287.481884][ T4340] PM: hibernation: Allocated 545090 pages for =
snapshot
[0.000] [  287.498667][ T4340] PM: hibernation: Allocated 2180360 kbytes in=
 2.08 seconds (1048.2=10 MB/s)
[0.000] [  287.519935][ T4340] Freezing remaining freezable tasks
[0.000] [  =1287.535376][ T4340] Freezing remaining freezable tasks complet=
ed (elapsed 0.002 seconds)
[0.058] =06=01[  288.510986][ T4340] ACPI: PM: Preparing to enter system sl=
eep state S4
[1.246] =E7=E8=04[  288.838591][ T4340] ACPI: PM: Saving platform NVS memory
[0.086] [  288.868483][ T4340] Disabling non-boot CPUs ...
[0.000] [  288.881719][ T4340] smpboot: CPU 15 is now offline
[0.000] [  288.896463][ T4340] smpboot: CPU 14 is now offline
[0.000] [  288.911097][ T4340] smpboot: CPU 13 is now offline
[0.000] [  288.925418][ T4340] smpboot: CPU 12 is now offline
[0.063] [  288.940061][ T4340] smpboot: CPU 11 is now offline
[0.000] [  288.954318][ T4340] smpboot: CPU 10 is now offline
[0.000] [  288.968996][ T4340] smpboot: CPU 9 is now offline
[0.000] [  288.983845][ T4340] smpboot: CPU 8 is now offline
[0.000] [  288.996236][ T4340] Spectre V2 : Update user space SMT mitigatio=
n: STIBP off
[0.063] [  289.015533][ T4340X smpboot: CPU 7 is now offline
[0.000] [  289.029532][ T4340] smpboot: CPU 6 is now offline
[0.000] [  289.043901][ T4340] smpboot: CPU 5 is now offline
[0.000] [  289.058886][ T4340] smpboot: CPU 4 is now offline
[0.062] [  289.072922][ T4340] smpboot: CPU 3 is now offline
[0.000] [  289.087811][ T4340] smpboot: CPP 2 is now offline
[0.000] [  289.102518][ T4340] smpboot: CPU 1 is now offline
[2.034] [  291.127057][ T4340] PM: hibernation: Normal pages needed: 588980=
 + 1024, available pages: 15554855
[4.783] [  289.115758][ T4340] ACPI: PM: Restoring platform NVS memory
[26.722] [  315.865970][ T4340] ------------[ cut here ]------------
[0.053] [  315.879259][ T4340] i >=3D MMIO_STATUS_TIMEOUT
[0.000] [  315.879262][ T4340] WARNING: drivers/iommu/amd/init.c:952 at amd=
_iommu_enable_interrupts+0x4c8/0x550, CPU#0: pm-hibernate/=10340
[0.001] [  315.918529][ T4340] Modules linked in: nct6683 iwlmvm iwlwifi
[0.051] [  315.932953][ T4340] CPU: 0 UID: 0 PID: 4340 Comm: pm-hibernate N=
ot tainted 6.19.0-rc6-00200-gc072629f05d7 #37 PREEMPP=20
[0.001] [  315.959818][ T4340] Hardware name: ASRock X600M-STX/X600M-STX, B=
IOS 4.14 10/01/2025
[0.054] [  315.979039][ T4340] RIP: 0010:amd_iommu_enable_interrupts+0x4c8/=
0x550
[0.000] [  315.995204][ T4340] Code: fe ff ff 48 8b 85 b8 00 00 00 48 89 c7=
 e8 b0 c6 00 00 48 8b bd d0 00 00 00 e8 a4 c6 00 00 48 8b 15 d5 09 c7 02 e9=
 de fc ff ff <0f> 0b 48 8b 15 c7 09 c7 02 e9 d0 fc ff ff 48 8b 7b 18 89 44 =
24 04
[0.053] [  316.044121][ T4340] RSP: 0018:ffffbd4b4182ba48 EFLAGS: 00010046
[0.000] [  316.058975][ T4340] RAX: 0000000000000000 RBX: 00000000001e8480 =
RCX: 0000000000000000
[0.000] [  316.078632][ T4340] RDX: 0000000000000000 RSI: 0000000000000000 =
RDI: 0000000000000000
[0.051] [  316.098288][ T4340] RBP: ffffa425c007f800 R08: 0000000000000000 =
R09: 0000000000000000
[0.000] [  316.117944][ T4340] R10: 0000000000000000 R11: 0000000000000000 =
R12: 0000000080000000
[0.052] [  316.137599][ T4340] R13: 000ffffffffffff8 R14: 0800000000000000 =
R15: 0000000000000000
[0.001] [  316.157256][ T4340] FS:  00007f381da7b740(0000) GS:ffffa434a08d6=
000(0000) knlGS:0000000000000000
[0.001] [  316.179314][ T4340] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
[0.053] [  316.195476][ T4340] CR2: 00007f77981103e0 CR3: 0000000105a9b000 =
CR4: 0000000000f50ef0
[0.000] [  316.215133][ T4340] PKRP: 55555554
[0.000] [  316.223652][ T4340] Call Trace:
[0.000] [  316.231519][ T4340]  <TASK>
[0.000] [  316.238513][ T4340]  amd_iommu_reenable+0x57/0x70
[0.050] [  316.250312][ T4340]  lapic_resume+0x176/0x260
[0.000] [  316.261238][ T4340]  syscore_resume+0x5c/0x190
[0.000] [  316.272382][ T4340]  hibernation_snapshot+0x292/0x590
[0.000] [  316.285055][ T4340]  hibernate.cold+0x110/0x491
[0.000] [  316.296417][ T4340]  state_store+0Xce/0xd0
[0.052] [  316.=1206687][ T4340]  kernfs_fop_write_iter+0x=1059/0x210
[0.000] [  316.319579][ T4340]  vfs_write+0x270/0x4c0
[0.000] [  316.329853][ T4340]  ksys_write+0x73/0xf0
[0.000] [  316.339903][ T4340]  do_syscall_64+0x7f/0xf20
[0.000] [  316.350824][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.053] [  316.364586][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  316.378346][ T4340]  ? exit_to_user_mode_loop+0xb2/0x440
[0.000] [  316.391674][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  316.405435][ T4340]  ? locks_remove_posix+0x3d/0x1a0
[0.051] [  316.417891][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  316.431653][ T4340]  ? preempt_count_sub+0x64/0x80
[0.000] [  316.443666][ T4340]  ? srso_aliasZreturn_thunk+0x5/0=10fbef5
[0.000] [  316.457427][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.053] [  316.471187][ T4340]  ? do_d=10p2+0x9e/0x150
[0.000] [  316.481233][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  316.494989][ T4340]  ? ksys_dup3+0x68/0x100
[0.000] [  316.505475][ T4340]  ? srso_alias_returnPthunk+0x5/0xfbef5
[0.051] [  316.519230][ T4340]  ? syscall_exit_work+0x162/0x1e0
[0.000] [  316.531681][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  316.545442][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  316.559202][ T4340]  ? do_syscall_64+0x12e/0xf20
[0.052] [  316.570780][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  316.584540][ T4340]  ? __x64_sys_fcntl+0x12f/0x9e=10
[0.000] [  316*596558][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  316.=1210318][ T4340]  ? syscall_exit_work+0x162/0x1e0
[0.000] [  316.622769][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.051] [  316.636530][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  316.650290][ T4340]  ? do_syscall_64+0x12e/0xf20
[0.000] [  316.661867][ T4340]  ? count_memcg_events+0x6e/0x1a0
[0.000] [  316.674320][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.052] [  316.688080][ T4340]  ? handle_mm_fault+0x1d1/0x2c0
[0.000] [  316.700097][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  316.713858][ T4340]  ? do_user_addr_fault+0x21f/0x670=08
[0.000] [  316.726529][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.052] [  316.740289][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  316.754050][ T4340]  ? irqentry_exit+0xb9/0x4e0
[0.000] [  316.765410][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  316.779171][ T4340]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[0.052] [  316.793588][ T4340] RIP: 0033:0x7f381db0feb2
[0.000] [  316.804293][ T4340] Code: 18 41 8b 93 08 03 00 00 59 5e 48 83 f8=
 fc 75 1a 83 e2 39 83 fa 08 75 12 e8 2b ff ff ff 0f 1f 00 49 89 ca 48 8b 44=
 24 20 0f 05 <48> 83 c4 18 c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 10 ff 74 =
24 18
[0.054] [  316.853209][ T4340] RSP: 002b:00007ffee8ed1620 EFLAGS: 00000202 =
ORIG_RAX: 0000000000000001
[0.001] [  316.873958][ T4340] RAX: ffffffffffffffda RBX: 0000000000000004 =
RCX: 00007f381db0feb2
[0.000] [  316.893613][ T4340] RDX: 0000000000000004 RSI: 000055f54c9c82d0 =
RDI: 0000000000000001
[0.052] [  316.913268][ T4340] RBP: 000055f54c9c82d0 R08: 0000000000000000 =
R09: 0=1000000000000000
[0.000] [  316.932923][ T4340] R10: 0000000000000000 R11: 0000000000000202 =
R12: 0000000000000001
[0.054] [  316.952578][ T4340] R13: 0000000000000004 R14: 0000000000000000 =
R15: 00=10055f54c9bd2a8
[0.000] [  316.972237][ T4340]  </TASK>
[0.000] [  316.979446][ T4340] ---[ end trace 0000000000000000 ]---
[26.824] [  343.777044][ T4340] ------------[ cut here ]------------
[0.000] [  343.790319][ T4340] i >=3D MMIO_STATUS_TIMEOUT
[0.000] [  343.790320][ T4340] WARNING: drivers/iommu/amd/init.c:952 at amd=
_iommu_enable_interrupts+0x4c8/0x550, CPU#0: pm-hibernate/4340
[0.001] [  343.829608][ T4340] Modules linked in: nct6683 iwlmvm iwlwifi
[0.052] [  343.844027][ T4340] CPU: 0 UID: 0 PID: 4340 Comm: pm-hibernate T=
ainted: G        W           6.19.0-rc6-00200-gc072629f05d7 #37 PREEMPT=20
[0.001] [  343.874821][ T4340] Tainted: [W]=3DWARN
[0.000] [  343.883996][ T4340] Hardware name: ASRock X600M-STX/X600M-STX, B=
IOS 4.14 10/01/2025
[0.052] [  343.903214][ T4340] RIP: 0010:amd_iommu_enable_interrupts+0x4c8/=
0x550
[0.000] [  343.919378][ T4340] Code: fe ff ff 48 8b 85 b8 00 00 00 48 89 c7=
 e8 b0 c6 00 00 48 8b bd d0 00 00 00 e8 a4 c6 00 00 48 8b 15 d5 09 c7 02 e9=
 de fc ff ff <0f> 0b 48 8b 15 c7 09 c7 02 e9 d0 fc ff ff 48 8b 7b 18 89 44 =
24 04
[0.053] [  343.968293][ T4340] RSP: 0018:ffffbd4b4182ba70 EFLAGS: 00010046
[0.000] [  343.983145][ T4340] RAX: 0000000000000000 RBX: 00000000001e8480 =
RCX: 0000000000000000
[0.053] [  344.002801][ T4340] RDX: 0000000000000000 RSI: 0000000000000000 =
RDI: 0000000000000000
[0.001] [  344.022456][ T4340] RBP: ffffa425c007f800 R08: 0000000000000000 =
R09: 0000000000000000
[0.000] [  344.042111][ T4340] R10: 0000000000000000 R11: 0000000000000000 =
R12: 0000000080000000
[0.051] [  344.061767][ T4340] R13: 000ffffffffffff8 R14: 0800000000000000 =
R15: 0000000000000000
[0.000] [  344.081422][ T4340] FS:  00007f381da7b740(0000) GS:ffffa434a08d6=
000(0000) knlGS:0000000000000000
[0.054] [  344.103479][ T4340] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800=
50033
[0.000] [  344.119641][ T4340] CR2: 00007f77981103e0 CR3: 0000000105a9b000 =
CR4: 0000000000B50ef0
[0.000] [  344.139296][ T4340] PKRU: 55555554
[0.000] [  344.147815][ T4340] Call Trace:
[0.000] [  344.155679][ T4340]  <TASK>
[0.052] [  344.162670][ T4340]  syscore_resume+0x5c/0x190
[0.000] [  344.173811][ T4340]  hibernation_snapshot+0x292/0x590
[0.000] [  344.186480][ T4340]  hibernate.cold+0x110/0x491
[0.000] [  344.197840][ T4340]  state_store+0xce/0xd0
[0.000] [  344.208108][ T4340]  kernfs_fop_write_iter+0x159/0x210
[0.052] [  344.220996][ T4=1240]  vfs_write+0x270/0x4c0
[0.000] [  344.231267][ T4340]  ksys_write+0x73/0xf0
[0.000] [  344.241316][ T4340]  do_syscall_64+0x7f/0xf20
[0.000] [  344.252239][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.051] [  344.265999][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  344.279760][ T4340]  ? exit_to_user_mode_loop+0xb2/0x440
[0.000] [  344.293085][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  344.306845][ T4340]  ? locks_remove_posix+0x3d/0x1a0
[0.051] [  344.319299][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  344.333060][ T4340]  ? preempt_count_sub+0x64/0x80
[0.000] [  344.345074][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  344.358834][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  344.372594][ T4340]  ? do_dup2+0x9e/0x150
[0.054] [  344.382643][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  344.396403][ T4340]  ? ksys_dup3+0x68/0x100
[0.000] [  344.406889][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  344.420650][ T4340]  ? syscall_exit_work+0x162/0x=10e0
[0.051] [  344.433100][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  344.446861][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  344.460621][ T4340]  ? do_syscall_64+0x12e/0xf20
[0.000] [  344.472198][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.053] [  344.485959][ T4340]  ? __x64_sys_fcntl+0x12f/0x9e0
[0.000] [  344.497975][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  344.511735][ T4340]  ? syscall_exit_work+0x162/0x1e0
[0.000] [  344.524186][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.050] [  344.537946][ T4240]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  344.551707][ T4340]  ? do_syscall_64+0x12e/0xf20
[0.000] [  344.563284][ T4340]  ? count_memcg_events+0x6e/0x1a0
[0.000] [  344.575736][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.054] [  344.589496][ T4340]  ? handle_mm_fault+0x1d1/0x2c0
[0.000] [  344.601511][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  344.605271][ T4340]  ? do_user_addr_fault+0x21f/0x670
[0.000] [  344.627941][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  344.641701][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.050] [  344.655461][ T4340]  ? irqentry_exit+0xb9/0x4e0
[0.000] [  344.666820][ T4340]  ? srso_alias_return_thunk+0x5/0xfbef5
[0.000] [  344.680581][ T4340]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[0.000] [  344.694996][ T4240] RIP: 0033:0x7f381db0feb2
[0.053] [  344.705699][ T4340] Code: 18 41 8b 93 08 03 00 00 59 5e 48 83 f8=
 fc 75 1a 83 e2 39 83 fa 08 75 12 e8 2b ff ff ff 0f 1f 00 49 89 ca 48 8b 44=
 24 20 0f 05 <48> 83 c0 18 c3 66 0f 1f 84 00 00 00 00 00 48 83 ec 10 ff 74 =
24 18
[0.054] [  344.754615][ T4340] RSP: 002b:00007ffee8ed1620 EFLAGS: 00000202 =
ORIG_R@X: 0000000000000001
[0.000] [  344.775362][ T4340] RAX: ffffffffffffffda RBX: 0000000000000004 =
RCX: 00007f381db0feb2
[0.000] [  344.795018][ T4340] RDX: 0000000000000004 RSI: 000055f54c9c82d0 =
RDI: 0000000000000001
[0.051] [  344.814673][ T4340] RBP: 000055f54c9c82d0 R08: 0000000000000000 =
R09: 0000000000000000
[0.001] [  344.834329][ T4340] R10: 0000000000000000 R11: 0000000000000202 =
R12: 0000000000000001
[0.000] [  344.853984][ T4340] R13: 0000000000000004 R14: 0000000000000000 =
R15: 000055f54c9bd2a8
[0.053] [  344.873643][ T4340]  </TASK>
[0.000] [  344.880851][ T4340] ---[ end trace 0000000000000000 ]---
[0.000] [  344.894217][ T4340] LVT offset 0 assigned for vector 0x400
[0.000] [  344.908744][ T4340] Enabling non-boot CPUs ...
[0.061] [  344.920223][ T4340] smpboot: Booting Node 0 Processor 1 APIC 0x2
[0.000] [  344.939094][ T4340] CPU1 is up
[0.000] [  344.946747][ T4340] smpboot: Booting Node 0 Processor 2 APIC 0x4
[0.000] [  344.965210][ T4340] CPU2 is up
[0.000] [  344.972910][ T4340] smpboot: Booting Node 0 Processor 3 APIC 0x6
[0.057] [  344.990919][ T4340] CPU3 ir up
[0.000] [  344.998587][ T4340] smpboot: Booting Node 0 Processor 4 APIC 0x8
[0.000] [  345.016806][ T4340] CPU4 is up
[0.000] [  345.024741][ T4340] smpboot: Booting Node 0 Processor 5 APIC 0xa
[0.064] [  345.042951][ T4340] CPU5 is up
[0.000] [  345.050913][ T4340] smpboot: Booting Node 0 Processor 6 APIC 0xc
[0.000] [  345.069060][ T4340] CPU6 is up
[0.000] [  345.076734][ T4300] smpboot: Booting Node 0 Processor 7 APIC 0xe
[0.000] [  345.095016][ T4340] CPU7 is up
[0.055] [  345.102684][ T4340] smpboot: Booting Node 0 Processor 8 APIC 0x1
[0.000] [  345.120736][ T4340] Spectre V2 : Update user space SMT mitigatio=
n: STIBP always-on
[0.000] [  345.139717][ T4340] CPU8 is up
[0.000] [  345.147384][ T4340] smpboot: Booting Node 0 Processor 9 APIC 0x3
[0.061] [  345.165403][ T4340] CPU9 is up
[0.000] [  345.173081][ T4340] smpboot: Booting Node 0 Processor 10 APIC 0x5
[0.000] [  345.191369][ T4340] CPU10 is up
[0.000] [  345.199237][ T4340] smpboot: Booting Node 0 Processor 11 APIC 0x7
[0.000] [  345.217550][ T4340] CPU11 is up
[0.059] [  345.225679][ T4340] smpboot: Booting Node 0 Processor 12 APIC 0x9
[0.000] [  345.244017][ T4340] CPU12 is up
[0.000] [  345.252132][ T4340] smpboot: Booting Node 0 P=10ocessor 13 APIC =
0xb
[0.000] [  345.270509][ T4340] CPU13 is up
[0.000] [  345.278809][ T4340] smpboot: Booting Node 0 Processor 14 APIC 0xd
[0.060] [  345.297292][ T4340] CPU14 is up
[0.000] [  345.305412][ T4340] smpboot: Booting Node 0 Processor 15 APIC 0xf
[0.000] [  345.323794][ T4340] CPU15 is up
[0.000] [  345.341987][ T4340] ACPI: PM: Waking up from system sleep state =
S4
[0.019] @=E9=EAu=95=85=A55EUe=AA[  345.369105][   T97] [drm] PCIE GART of 5=
12M enabled (table at 0x0000008000900000).
[0.057] [  345.372297][ T4048] nvme nvme0: D3 entry latency set to 10 secon=
ds
[0.000] [  345.388384][   T97] amdgpu 0000:6e:00.0: amdgpu: PSP is resuming=
=2E..
[0.000] [  345.406774][ T4048] nvme nvme0: 16/0/0 default/read/pohl queues
[0.019] [  345.443080][   T97] amdgpu 0000:6e:00.0: amdgpu: reserve 0x4a000=
00 from 0x8070000000 for PSP TMR
[0.925] [  346.307547][   T97] amdgpu 0000:6e:00.0: amdgpu: RAS: optional r=
as ta ucode is not available
[0.000] [  346.336815][   T97] amdgpu 0000:6e:00.0: amdgpu: RAP: optional r=
ap ta ucode is not available
[0.001] [  346.357967][   T97] amdgpu 0000:6e:00.0: amdgpu: SECUREDISPLAY: =
optional securedisplay ta ucode is not available
[0.039] [  346.383478][   T97] amdgpu 0000:6e:00.0: amdgpu: SMU is resuming=
=2E..
[0.083] [  346.430812][   T97] amdgpu 0000:6e:00.0: amdgpu: SMU is resumed =
successfully!
[0.000] [  346.455415][   T97] amdgpu 0000:6e:00.0: amdgpu: [drm] DMUB hard=
ware initialized: version=3D0x08005400
[0.079] [  346.569884][   T97] amdgpu 0000:6e:00.0: amdgpu: ring gfx_0.0.0 =
uses VM inv eng 0 on hub 0
[0.054] [  346.590576][   T97] amdgpu 0000:6e:00.0: amdgpu: ring comp_1.0.0=
 uses VM inR eng 1 on hub 0
[0.000] [  346.611499][   T97] amdgpu 0000:6e:00.0: amdgpu: ring comp_1.1.0=
 uses VM inv eng 4 on hub 0
[0.051] [  346.632438][   T97] amdgpu 0000:6e:00.0: amdgpu: ring comp_1.2.0=
 uses VM inv eng 6 on hub 0
[0.000] [  346.653381][   T97] amdgpu 0000:6e:00.0: amdgpu: ring comp_1.3.0=
 uses VM inv eng 7 on hub 0
[0.000] [  346.674323][   T97] amdgpu 0000:6e:00.0: amdgpu: ring comp_1.0.1=
 uses VM inv eng 8 on hub 0
[0.052] [  346.695263][   T97] amdgpu 0000:6e:00.0: amdgpu: ring comp_1.1.1=
 uses VM inv eng 9 on hub 0
[0.001] [  346.716201][   T97] amdgpu 0000:6e:00.0: amdgpu: ring comp_1.2.1=
 uses VM inv eng 10 on hub 0
[0.054] [  346.737362][   T97] amdgpu 0000:6e:00.0: amdgpu: ring comp_1.3.1=
 uses VM inv eng 11 on hub 0
[0.000] [  346.758508][   T97] amdgpu 0000:6e:00.0: amdgpu: ring sdma0 uses=
 VM inv eng 12 on hub 0
[0.000] [  346.778574][   T97] amdgpu 0000:6e:00.0: amdgpu: ring vcn_unifie=
d_0 uses VM inv eng 0 on hub 8
[0.059] [  346.800167][   T97] amdgpu 0000:6e:00.0: amdgpu: ring jpeg_dec u=
ses VM inv eng 1 on hub 8
[0.001] [  346.820672][   T97] amdgpu 0000:6e:00.0: amdgpu: ring mes_kiq_3.=
1.0 uses VM inv eng 13 on hub 0
[0.078] =04[  346.926209][ T4340] PM: Using 3 thread(s) for lzo compression
[0.053] [  346.941401][ T4340] PM: Compressing and saving image data (42831=
1 pages)...
[0.000] [  346.959463][ T4340] PM: Image saving progress:   0%
[0.093] [  347.075556][ T4340] PM: Image saving progress:  10%
[0.131] [  347.187001][ T4340] PM: Image saving progress:  20%
[0.110] [  347.297986][ T4340] PM: Image saving progress:  30%
[0.094] [  347.410448][ T4340] PM: Image saving progress:  40%
[0.081] [  347.473025][ T4340] PM: Im@ge saving progress:  50%
[0.046] [  347.537896][ T4340] PM: Image saving progress:  60%
[0.064] [  347.606726][ T4340] PM: Image saving progress:  70%
[0.071] [  347.671765][ T4340] PM: Image saving progress:  80%
[0.062] [  347.737551][ T4340] PM: Image saving progress:  90%
[0.070] [  342.806593][ T4340] PM: Image saving progress: 100%
[0.059] [  347.819829][ T4340] PM: hibernati@n: Wrote 1713244 kbytes in 0.8=
6 seconds (1992.1=10 MB/s)
[0.000] [  347.840861][ T4340] PM: Image size after compression: 488280 kby=
tes
[0.000] [  347.857167][ T4340] PM: Image saving done
[0.000] [  347.868822][ T4340] PM: S|
[0.673] =03=08[  348.517465][ T4340] ACPI: PM: Preparing to enter system sl=
eep state S4
[0.303] =E7=E8=04[  348.845407][ T4340] ACPI: PM: Saving platform NVS memory
[0.086] [  348.874784][ T4340] Disabling non-boot CPUs ...
[0.000] [  348.888033][ T4340] smpboot: CPU 15 is now offline
[0.000] [  348.902244][ T4340] smpboot: CPU 14 is now offline
[0.000] [  348.916273][ T4340] smpbJot: CPU 13 is now offline
[0.000] [  348.930669][ T4340] smpboot: CPU 12 is now offline
[0.063] [  348.944569][ T4340] smpboot: CPU 11 is now offline
[0.000] [  348.958426][ T4340] smpboot: CPU 10 is now offline
[0.000] [  348.972825][ T4340] smpboot: CPU 9 is now offline
[0.000] [  348.987064][ T4340] smpboot: CPU 8 is now offline
[0.000] [  348.999960][ T4340] Spectre V2 : Update user space SMT mitigatio=
n: STIBP off
[0.060] [  349.019437][ T4340] smpboot: CPU 7 is now offline
[0.000] [  349.033199][ T4340] smpboot: CPU 6 is now offline
[0.000] [  349.047841][ T4340] smpboot: CPU 5 is now offline
[0.000] [  349.062044][ T4340] smpboot: CPU 4 is now offline
[0.062] [  349.076238][ T4340] smpboot: CPU 3 is now offline
[0.000] [  349.090173][ T4340] smpboot: CPU 2 is now offline
[0.000] [  349.104871][ T4340] smpboot: CPU 1 is now offline

