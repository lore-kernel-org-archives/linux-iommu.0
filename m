Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9271C15E8B
	for <iommu@lists.linux.dev>; Sat, 10 Jan 2026 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768038379; cv=none; b=dQlrBe1fC4c/GV/AU72sNSvstU4KX99bfyH/gzK2MGO0aKWS7gyDsli2RY5tC1Aq9E8oxUp4pAPFSqiYSjSXDGouanrA0v6jXFfLQPUS3In1lqYHldsuXBA9cRQKAK0DiJjG4D3ZZ65AMzCQwrZQJfNqMFum7ceS/bOG19cDkss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768038379; c=relaxed/simple;
	bh=ZYcl4t+gK69ImW1AqjA/oU9vNTX/Ecqb28P2QI4MO1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MroXQLzH5taqVfxR7i1pX9+e8kl/zjlmyUincdh/IeLndp3mqZGZQevDNxwtQocjgcv3ktDUMA1wXtaVohhDzf8CwaUG60dHlYIKUmn0NfjcwuIjO5t9a573yQ1kEHivjPzrsyLbzXqC3S457PYuJQnKOKo9iZOWEH09NtjFGwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=h4kE9jCC; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="h4kE9jCC"
Received: from 8bytes.org (p200300f6af1d9600dfc71246d978d903.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:dfc7:1246:d978:d903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 881B45ED0B;
	Sat, 10 Jan 2026 10:46:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1768038375;
	bh=ZYcl4t+gK69ImW1AqjA/oU9vNTX/Ecqb28P2QI4MO1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h4kE9jCCSba9G/eGgv/0aDVN3cROUkoEAbvxkmTwXTkSIlEb+yKb9fSk5TrcI269j
	 bFts5GxUljpOmHdEqmauPRKTGdnJl7ySJC5zqlI/QBaVyeHTWgcCcR8Wx6nNrQi2L+
	 E1cDXRa2D+rUqYzI8+07y+eG7dUPuu0VboK25gnUaSSiGsUv101B/X1xf7b18H/qB5
	 hG4ne1zE+oqiwZ3Y8p0HosqUqe1RL7/MA56bxVAyZorPcy7Mybkc8+oguqAqGtK+LE
	 G65UvlIA/Sf5voo+dEvN31sCXnPyGUanK6Sk4hLBGK38gf8T+tn/600c5DUijjPSoh
	 EUUoRBJZwVe0w==
Date: Sat, 10 Jan 2026 10:46:14 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Tj <tj.iam.tj@proton.me>, Vasant Hegde <vasant.hegde@amd.com>, 
	suravee.suthikulpanit@amd.com
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: amd_iommu: Kernel panic - not syncing: timer doesn't work
 through Interrupt-remapped IO-APIC
Message-ID: <6ahuavyulwnpg2njob4l7rhcew6c4blircf7thrivzw2fqemwc@t4p62fxg7e7d>
References: <1Z2Ru2RmAxtkhZhrEa2zqn0k2zgpgbB6W-SgyuWJioaY8S40qY9b8UkPH8UpVCzfljOfC2KFIQKr9rpWW6_k5IReGboeeA10QUgma15NNis=@proton.me>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1Z2Ru2RmAxtkhZhrEa2zqn0k2zgpgbB6W-SgyuWJioaY8S40qY9b8UkPH8UpVCzfljOfC2KFIQKr9rpWW6_k5IReGboeeA10QUgma15NNis=@proton.me>

Adding Vasant and Suravee for awareness.

On Wed, Jan 07, 2026 at 05:12:47PM +0000, Tj wrote:
> Currently debugging a KEXEC_JUMP preserve_context panic with amd iommu on kexec restart using:
> 
> /usr/sbin/kexec --debug --load-preserve-context --mem-max=0x3f000000 --load /boot/vmlinuz --initrd /boot/initrd.img --reuse-cmdline
> 
> From my limited understanding so far it seems that because the KEXEC_JUMP preserve_context path mostly follows the same flow as an S4 hibernation the IOMMU code, on restart, assumes the IOMMU had a hardware reset. In this preserve_context case that is not correct and the IOMMU is still in the state from the prior kernel where it has done:
> 
> drivers/iommu/amd/init.c::amd_iommu_enable(void)
> ...
>  ret = iommu_go_to_state(IOMMU_ENABLED);
> ...
> irq_remapping_enabled = 1;
> 
> So I wonder if in the shutdown path this needs handling in amd_iommu_suspend() ?
> 
> I've been testing some changes to syscore to enable passing runtime state in struct syscore_data in order to notify amd_iommu_suspend() this is a KEXEC_JUMP but cannot find a way to force a reset of the IOMMU. I initially attempted to handle it in amd_iommu_resume() but that doesn't seem early enough in the startup flow - I don't think syscore_resume() is called until after this panic point.
> 
> ...
> [  141.722644] shutdown[1]: Rebooting with kexec.
> [  141.781931] Freezing user space processes
> [  141.787032] Freezing user space processes completed (elapsed 0.001 seconds)
> [  141.794028] OOM killer disabled.
> ...
> [  142.975667] Disabling non-boot CPUs ...
> ...
> [  143.594423] Calling amd_iommu_suspend+0x0/0x20
> ...
> [    0.000000] Linux version 6.19.0-rc3+debian+tj (linux@iam.tj) (gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #364 SMP PREEMPT_DYNAMIC Wed Jan  7 12:46:49 UTC 2026
> [    0.000000] Command line: root=/dev/mapper/SUNNY-rootfs ro debug systemd.log_level=info drm.edid_firmware=DP-2:edid/UE50NU7400.edid fbcon=rotate:3 modprobe.blacklist=radeon amdgpu.si_support=1 console=ttyS0,115200 console=tty0 no_console_suspend nosplash vt.handoff=7 pm_debug_messages=1 "dyndbg=file syscore.c +p" elfcorehdr=1032176K kexec_jump_back_entry=0x00000001ff34012b
> ...
> [    1.571701] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484873504 ns
> [    1.580860] APIC: Switch to symmetric I/O mode setup
> [    1.586226] AMD-Vi: Using global IVHD EFR:0x0, EFR2:0x0
> [    1.591467] AMD-Vi: Re-using command buffer from the previous kernel
> [    1.597834] AMD-Vi: Re-using event buffer from the previous kernel
> [    1.923179] x2apic: IRQ remapping doesn't support X2APIC mode
> [    1.929564] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    1.980114] Kernel panic - not syncing: timer doesn't work through Interrupt-remapped IO-APIC
> [    1.988652] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.19.0-rc3+debian+tj #364 PREEMPT(lazy)
> [    1.997882] Hardware name: System manufacturer System Product Name/PRIME X370-PRO, BIOS 6203 07/27/2023
> [    2.007289] Call Trace:
> [    2.009747]  <TASK>
> [    2.011856]  vpanic+0x31f/0x3a0
> [    2.015010]  panic+0x63/0x70
> [    2.017902]  ? timer_irq_works+0x80/0x130
> [    2.021921]  panic_if_irq_remap+0x1d/0x20
> [    2.025943]  setup_IO_APIC+0x8c1/0xa30
> [    2.029706]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
> [    2.035030]  ? __pfx_amd_iommu_enable_faulting+0x10/0x10
> [    2.040351]  ? __cpuhp_setup_state+0x63/0xf0
> [    2.044626]  apic_intr_mode_init+0x76/0xf0
> [    2.048733]  x86_late_time_init+0x2d/0x50
> [    2.052754]  start_kernel+0x7f2/0xc50
> [    2.056428]  x86_64_start_reservations+0x18/0x30
> [    2.061057]  x86_64_start_kernel+0xfa/0x150
> [    2.065251]  common_startup_64+0x13e/0x141
> [    2.069361]  </TASK>
> [    2.071558] ---[ end Kernel panic - not syncing: timer doesn't work through Interrupt-remapped IO-APIC ]---
> 
> 
> $ grep -E '(IOMMU|KEXEC)' /boot/config-$(uname -r)
> CONFIG_KEXEC_CORE=y
> CONFIG_HAVE_IMA_KEXEC=y
> CONFIG_KEXEC=y
> CONFIG_KEXEC_FILE=y
> CONFIG_KEXEC_SIG=y
> # CONFIG_KEXEC_SIG_FORCE is not set
> CONFIG_KEXEC_BZIMAGE_VERIFY_SIG=y
> CONFIG_KEXEC_JUMP=y
> CONFIG_KEXEC_HANDOVER=y
> # CONFIG_KEXEC_HANDOVER_DEBUG is not set
> CONFIG_KEXEC_HANDOVER_DEBUGFS=y
> # CONFIG_KEXEC_HANDOVER_ENABLE_DEFAULT is not set
> CONFIG_GART_IOMMU=y
> CONFIG_ARCH_SUPPORTS_KEXEC=y
> CONFIG_ARCH_SUPPORTS_KEXEC_FILE=y
> CONFIG_ARCH_SELECTS_KEXEC_FILE=y
> CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY=y
> CONFIG_ARCH_SUPPORTS_KEXEC_SIG=y
> CONFIG_ARCH_SUPPORTS_KEXEC_SIG_FORCE=y
> CONFIG_ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG=y
> CONFIG_ARCH_SUPPORTS_KEXEC_JUMP=y
> CONFIG_ARCH_SUPPORTS_KEXEC_HANDOVER=y
> CONFIG_IOMMU_MM_DATA=y
> CONFIG_VFIO_IOMMU_TYPE1=m
> # CONFIG_VFIO_NOIOMMU is not set
> CONFIG_IOMMU_IOVA=y
> CONFIG_IOMMU_API=y
> CONFIG_IOMMU_SUPPORT=y
> # Generic IOMMU Pagetable Support
> # end of Generic IOMMU Pagetable Support
> # CONFIG_IOMMU_DEBUGFS is not set
> # CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
> CONFIG_IOMMU_DEFAULT_DMA_LAZY=y
> # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
> CONFIG_IOMMU_DMA=y
> CONFIG_IOMMU_SVA=y
> CONFIG_IOMMU_IOPF=y
> CONFIG_AMD_IOMMU=y
> CONFIG_INTEL_IOMMU=y
> CONFIG_INTEL_IOMMU_SVM=y
> # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
> CONFIG_INTEL_IOMMU_FLOPPY_WA=y
> CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=y
> CONFIG_INTEL_IOMMU_PERF_EVENTS=y
> # CONFIG_IOMMUFD is not set
> CONFIG_HYPERV_IOMMU=y
> CONFIG_VIRTIO_IOMMU=m
> CONFIG_IOMMU_PT=y
> CONFIG_IOMMU_PT_AMDV1=y
> CONFIG_IOMMU_PT_VTDSS=y
> CONFIG_IOMMU_PT_X86_64=y
> # CONFIG_IMA_KEXEC is not set
> CONFIG_IOMMU_HELPER=y
> # CONFIG_IOMMU_DEBUG is not set
> # CONFIG_TEST_KEXEC_HANDOVER is not set
> 
> Thanks for looking at this.
> 
> Tj.
