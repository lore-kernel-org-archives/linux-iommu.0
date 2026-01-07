Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4184392628
	for <iommu@lists.linux.dev>; Wed,  7 Jan 2026 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805989; cv=none; b=lXPbkAA6HlKfO4j5t5l9l6Yh36RjeKGWztAnxom4uBh3SYdAZd6uMVthWtK0VyNmN/Uo1LvgBmDjN7foK4WIpt9oADsBT4XijE+lsfc+sPYcZmmGMKkLsJ2JboW7P/r0jaP99t2k5zxm+mHQI9WiT2z6lwy/HaS3sUHXgKQokP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805989; c=relaxed/simple;
	bh=KPXjS+m50oZ2FiY4Maaq1+icW3dTYCp58q42lx+h+A0=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=N9OiF/q4IFdQZukNEvUI7GUrluNSoN8K1aYXwSlqHF6womLQAk+7fdvMpmPCRGpeJ122Fv73FUZKhqdrpKQ4bUlp9FZOJoHOc6JQcbWFCJudloLw4zqVVYchjMymneNgxutrCV4DYhrrZz27a7T5aJ4gAc0mpTfC7rZuOdIblyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dA7BY/Ek; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dA7BY/Ek"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=y4mgpxcufrf2jbp7icyvx6kgty.protonmail; t=1767805970; x=1768065170;
	bh=NJx7dY9YCLh75L1rM9Jw9KJFuHY3g0wrtZ2TeIdB9oc=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dA7BY/EkBHpfgDLXXP3Bf4WgMSvASVIsvhkW1ljGXBVxb+qnruJVKGEM/ly3FxORb
	 TNrbQW1waG9c6xd/oZkX/KSTNKj3rCOxUiIrftPFXTQ3vlYrx7gEJ9ZBlKt88u07kt
	 x1tag8tWudKS8U5J0C7KPY3Lzo8UPWLyhF18lSVga+eToZzoxiJ6EstFDCyrWwKzeZ
	 ArIY1FnT7/XtK3Qt96egweOJKdXz20MT7+hq5DBa4PsdgOevqisoYCEHyMH+L0ffCz
	 rgI4rFnEjrxgZMO2Q4MHYvupKmMPfZ4iEj5qy0qF9vSCsbxvtiBDVNzaNo+uQqiIX1
	 Q9iCqWs5ATYaw==
Date: Wed, 07 Jan 2026 17:12:47 +0000
To: "iommu@lists.linux.dev" <iommu@lists.linux.dev>
From: Tj <tj.iam.tj@proton.me>
Cc: Joerg Roedel <joro@8bytes.org>
Subject: amd_iommu: Kernel panic - not syncing: timer doesn't work through Interrupt-remapped IO-APIC
Message-ID: <1Z2Ru2RmAxtkhZhrEa2zqn0k2zgpgbB6W-SgyuWJioaY8S40qY9b8UkPH8UpVCzfljOfC2KFIQKr9rpWW6_k5IReGboeeA10QUgma15NNis=@proton.me>
Feedback-ID: 113488376:user:proton
X-Pm-Message-ID: f601dee083fdffdd5a3de04f3f224d180c581f09
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Currently debugging a KEXEC_JUMP preserve_context panic with amd iommu on k=
exec restart using:

/usr/sbin/kexec --debug --load-preserve-context --mem-max=3D0x3f000000 --lo=
ad /boot/vmlinuz --initrd /boot/initrd.img --reuse-cmdline

From my limited understanding so far it seems that because the KEXEC_JUMP p=
reserve_context path mostly follows the same flow as an S4 hibernation the =
IOMMU code, on restart, assumes the IOMMU had a hardware reset. In this pre=
serve_context case that is not correct and the IOMMU is still in the state =
from the prior kernel where it has done:

drivers/iommu/amd/init.c::amd_iommu_enable(void)
...
 ret =3D iommu_go_to_state(IOMMU_ENABLED);
...
irq_remapping_enabled =3D 1;

So I wonder if in the shutdown path this needs handling in amd_iommu_suspen=
d() ?

I've been testing some changes to syscore to enable passing runtime state i=
n struct syscore_data in order to notify amd_iommu_suspend() this is a KEXE=
C_JUMP but cannot find a way to force a reset of the IOMMU. I initially att=
empted to handle it in amd_iommu_resume() but that doesn't seem early enoug=
h in the startup flow - I don't think syscore_resume() is called until afte=
r this panic point.

...
[  141.722644] shutdown[1]: Rebooting with kexec.
[  141.781931] Freezing user space processes
[  141.787032] Freezing user space processes completed (elapsed 0.001 secon=
ds)
[  141.794028] OOM killer disabled.
...
[  142.975667] Disabling non-boot CPUs ...
...
[  143.594423] Calling amd_iommu_suspend+0x0/0x20
...
[    0.000000] Linux version 6.19.0-rc3+debian+tj (linux@iam.tj) (gcc (Debi=
an 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #364 SMP PREEM=
PT_DYNAMIC Wed Jan  7 12:46:49 UTC 2026
[    0.000000] Command line: root=3D/dev/mapper/SUNNY-rootfs ro debug syste=
md.log_level=3Dinfo drm.edid_firmware=3DDP-2:edid/UE50NU7400.edid fbcon=3Dr=
otate:3 modprobe.blacklist=3Dradeon amdgpu.si_support=3D1 console=3DttyS0,1=
15200 console=3Dtty0 no_console_suspend nosplash vt.handoff=3D7 pm_debug_me=
ssages=3D1 "dyndbg=3Dfile syscore.c +p" elfcorehdr=3D1032176K kexec_jump_ba=
ck_entry=3D0x00000001ff34012b
...
[    1.571701] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, =
max_idle_ns: 133484873504 ns
[    1.580860] APIC: Switch to symmetric I/O mode setup
[    1.586226] AMD-Vi: Using global IVHD EFR:0x0, EFR2:0x0
[    1.591467] AMD-Vi: Re-using command buffer from the previous kernel
[    1.597834] AMD-Vi: Re-using event buffer from the previous kernel
[    1.923179] x2apic: IRQ remapping doesn't support X2APIC mode
[    1.929564] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    1.980114] Kernel panic - not syncing: timer doesn't work through Inter=
rupt-remapped IO-APIC
[    1.988652] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-rc3+=
debian+tj #364 PREEMPT(lazy)
[    1.997882] Hardware name: System manufacturer System Product Name/PRIME=
 X370-PRO, BIOS 6203 07/27/2023
[    2.007289] Call Trace:
[    2.009747]  <TASK>
[    2.011856]  vpanic+0x31f/0x3a0
[    2.015010]  panic+0x63/0x70
[    2.017902]  ? timer_irq_works+0x80/0x130
[    2.021921]  panic_if_irq_remap+0x1d/0x20
[    2.025943]  setup_IO_APIC+0x8c1/0xa30
[    2.029706]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
[    2.035030]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
[    2.040351]  ? __cpuhp_setup_state+0x63/0xf0
[    2.044626]  apic_intr_mode_init+0x76/0xf0
[    2.048733]  x86_late_time_init+0x2d/0x50
[    2.052754]  start_kernel+0x7f2/0xc50
[    2.056428]  x86_64_start_reservations+0x18/0x30
[    2.061057]  x86_64_start_kernel+0xfa/0x150
[    2.065251]  common_startup_64+0x13e/0x141
[    2.069361]  </TASK>
[    2.071558] ---[ end Kernel panic - not syncing: timer doesn't work thro=
ugh Interrupt-remapped IO-APIC ]---


$ grep -E '(IOMMU|KEXEC)' /boot/config-$(uname -r)
CONFIG_KEXEC_CORE=3Dy
CONFIG_HAVE_IMA_KEXEC=3Dy
CONFIG_KEXEC=3Dy
CONFIG_KEXEC_FILE=3Dy
CONFIG_KEXEC_SIG=3Dy
# CONFIG_KEXEC_SIG_FORCE is not set
CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=3Dy
CONFIG_KEXEC_JUMP=3Dy
CONFIG_KEXEC_HANDOVER=3Dy
# CONFIG_KEXEC_HANDOVER_DEBUG is not set
CONFIG_KEXEC_HANDOVER_DEBUGFS=3Dy
# CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT is not set
CONFIG_GART_IOMMU=3Dy
CONFIG_ARCH_SUPPORTS_KEXEC=3Dy
CONFIG_ARCH_SUPPORTS_KEXEC_FILE=3Dy
CONFIG_ARCH_SELECTS_KEXEC_FILE=3Dy
CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY=3Dy
CONFIG_ARCH_SUPPORTS_KEXEC_SIG=3Dy
CONFIG_ARCH_SUPPORTS_KEXEC_SIG_FORCE=3Dy
CONFIG_ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG=3Dy
CONFIG_ARCH_SUPPORTS_KEXEC_JUMP=3Dy
CONFIG_ARCH_SUPPORTS_KEXEC_HANDOVER=3Dy
CONFIG_IOMMU_MM_DATA=3Dy
CONFIG_VFIO_IOMMU_TYPE1=3Dm
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_IOMMU_IOVA=3Dy
CONFIG_IOMMU_API=3Dy
CONFIG_IOMMU_SUPPORT=3Dy
# Generic IOMMU Pagetable Support
# end of Generic IOMMU Pagetable Support
# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
CONFIG_IOMMU_DEFAULT_DMA_LAZY=3Dy
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_IOMMU_DMA=3Dy
CONFIG_IOMMU_SVA=3Dy
CONFIG_IOMMU_IOPF=3Dy
CONFIG_AMD_IOMMU=3Dy
CONFIG_INTEL_IOMMU=3Dy
CONFIG_INTEL_IOMMU_SVM=3Dy
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=3Dy
CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=3Dy
CONFIG_INTEL_IOMMU_PERF_EVENTS=3Dy
# CONFIG_IOMMUFD is not set
CONFIG_HYPERV_IOMMU=3Dy
CONFIG_VIRTIO_IOMMU=3Dm
CONFIG_IOMMU_PT=3Dy
CONFIG_IOMMU_PT_AMDV1=3Dy
CONFIG_IOMMU_PT_VTDSS=3Dy
CONFIG_IOMMU_PT_X86_64=3Dy
# CONFIG_IMA_KEXEC is not set
CONFIG_IOMMU_HELPER=3Dy
# CONFIG_IOMMU_DEBUG is not set
# CONFIG_TEST_KEXEC_HANDOVER is not set

Thanks for looking at this.

Tj.
