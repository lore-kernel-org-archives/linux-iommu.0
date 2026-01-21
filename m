Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56E438E120;
	Wed, 21 Jan 2026 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768992049; cv=none; b=ar28+mHQuvzujG4XCFmt2xeDldXW8dHIr4T/ZVHr1Xv1qIZLmZwEm53MRyUSMk893DLx6N6/+Kh0rBgzEYWPqCZGqXp35Eppm2gtUnTfWi6Gc1TKJfhVn6PAfT+X3Ce6U0X1o4u1Ui+TDaKxlOYDZAYeDSZJ+PnxcSBa9JG35tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768992049; c=relaxed/simple;
	bh=diILtPbIO2e/lmvjVRrgZemqYdsA6zxNoXkieHKJLyY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=MpvYlkJanK3mgT5ULxsCZ3TIjtw20lyp/yjYHAbMWXeTpNgDUERCvk9C10wBOfhjKToF3Q0U/Ncpm11kyc3GBSXAY1+hvtOVyt8QaKx5s4qyQWKrz0t73uiTA1FE90itFbTzkHs7RQTYDBxZ2p1B2W0CehTLDpBUqLMq+QndpCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvVoMAMI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvVoMAMI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A17C116D0;
	Wed, 21 Jan 2026 10:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768992049;
	bh=diILtPbIO2e/lmvjVRrgZemqYdsA6zxNoXkieHKJLyY=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=JvVoMAMIrIilphYRliPGYIT2HNWRsllPqpbCepyHI8ZvQPR6t9GB43dclizDB3gfB
	 YLGotfNc3NSGDTXmnira7yUt3siS5DzEe0jupTy6BMZOX/6rufN12NwXgKZGEaDa6w
	 YIBg9eQBZgZkYGdSJ1ybBWOnfvtKh0rm8UkTPcX+oxLQ4x17ckgFCBb4ctneVQElIe
	 L2bnBpFqfBN4MXxXjuzqt7dyQslZcdIEbn2xysz28871/5CwjqXdi5Fw52YS5jPvKh
	 xChGe2vexQo64YVOycWPfC6PGdWxwtdmCkm9SCCN0OHtf2+Dl7PHDW8HxiDLaYHpKf
	 wBVEnF0UN5G+A==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Jan 2026 11:40:45 +0100
Message-Id: <DFU7CEPUSG9A.1KKGVW4HIPMSH@kernel.org>
Cc: <Aishwarya.TCV@arm.com>, <broonie@kernel.org>, <chenqiuji666@gmail.com>,
 <linux-kernel@vger.kernel.org>, <m.szyprowski@samsung.com>,
 <robin.clark@oss.qualcomm.com>, <will@kernel.org>, <robin.murphy@arm.com>,
 <joro@8bytes.org>, <iommu@lists.linux.dev>
To: "Wang Jiayue" <akaieurus@gmail.com>, <hanguidong02@gmail.com>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5] driver core: enforce device_lock for
 driver_match_device()
References: <CALbr=LYt-MqGM0ua78Rt7M679WR9hNnk0Or-WrB2myZ=KhaN0w@mail.gmail.com> <20260121085549.165428-1-akaieurus@gmail.com>
In-Reply-To: <20260121085549.165428-1-akaieurus@gmail.com>

(Cc: Rob, Will, Robin, Joerg)

On Wed Jan 21, 2026 at 9:55 AM CET, Wang Jiayue wrote:
> After partially modifying juno.dts, I managed to roughly emulate kernel
> boot on juno board with qemu and successfully reproduced the boot hang.
> Below is the gdb backtrace:
>
> #0  0xffff800080114ae0 in mutex_spin_on_owner (lock=3D0xffff0000036bfc90,=
 owner=3D0xffff000003510000, ww_ctx=3D0x0, waiter=3D0x0) at kernel/locking/=
mutex.c:377
> #1  0xffff80008118cecc in mutex_optimistic_spin (waiter=3D<optimized out>=
, ww_ctx=3D<optimized out>, lock=3D<optimized out>) at kernel/locking/mutex=
.c:480
> #2  __mutex_lock_common (use_ww_ctx=3D<optimized out>, ww_ctx=3D<optimize=
d out>, ip=3D<optimized out>, nest_lock=3D<optimized out>, subclass=3D<opti=
mized out>, state=3D<optimized out>, lock=3D<optimized out>) at kernel/lock=
ing/mutex.c:618
> #3  __mutex_lock (lock=3D0xffff0000036bfc90, state=3D0x2, ip=3D<optimized=
 out>, nest_lock=3D<optimized out>, subclass=3D<optimized out>) at kernel/l=
ocking/mutex.c:776
> #4  0xffff80008118d1dc in __mutex_lock_slowpath (lock=3D0xffff0000036bfc9=
0) at kernel/locking/mutex.c:1065
> #5  0xffff80008118d230 in mutex_lock (lock=3D0xffff0000036bfc90) at kerne=
l/locking/mutex.c:290
> #6  0xffff8000809cdd1c in device_lock (dev=3D<optimized out>) at ./includ=
e/linux/device.h:895
> #7  class_device_constructor (_T=3D<optimized out>) at ./include/linux/de=
vice.h:913
> #8  driver_match_device_locked (dev=3D<optimized out>, drv=3D<optimized o=
ut>) at drivers/base/base.h:193
> #9  __driver_attach (dev=3D0xffff0000036bfc10, data=3D0xffff800082e64440 =
<qcom_smmu_tbu_driver+40>) at drivers/base/dd.c:1183
> #10 0xffff8000809cb17c in bus_for_each_dev (bus=3D0xffff0000036bfc90, sta=
rt=3D0x0, data=3D0xffff800082e64440 <qcom_smmu_tbu_driver+40>, fn=3D0xffff8=
000809cdcec <__driver_attach>) at drivers/base/bus.c:383
> #11 0xffff8000809cd03c in driver_attach (drv=3D0x0) at drivers/base/dd.c:=
1245
> #12 0xffff8000809cc748 in bus_add_driver (drv=3D0xffff800082e64440 <qcom_=
smmu_tbu_driver+40>) at drivers/base/bus.c:715
> #13 0xffff8000809ced28 in driver_register (drv=3D0xffff800082e64440 <qcom=
_smmu_tbu_driver+40>) at drivers/base/driver.c:249
> #14 0xffff8000809d0254 in __platform_driver_register (drv=3D0x0, owner=3D=
0xffff000003510000) at drivers/base/platform.c:908
> #15 0xffff8000809a6208 in qcom_smmu_impl_init (smmu=3D0xffff0000037c0080)=
 at drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c:780
> #16 0xffff8000809a48a0 in arm_smmu_impl_init (smmu=3D0xffff0000037c0080) =
at drivers/iommu/arm/arm-smmu/arm-smmu-impl.c:224
> #17 0xffff8000809a2ae0 in arm_smmu_device_probe (pdev=3D0xffff0000036bfc0=
0) at drivers/iommu/arm/arm-smmu/arm-smmu.c:2155
> #18 0xffff8000809d060c in platform_probe (_dev=3D0xffff0000036bfc10) at d=
rivers/base/platform.c:1446
> #19 0xffff8000809cd6a4 in call_driver_probe (drv=3D<optimized out>, dev=
=3D<optimized out>) at drivers/base/dd.c:583
> #20 really_probe (dev=3D0xffff0000036bfc10, drv=3D0xffff800082e641c0 <arm=
_smmu_driver+40>) at drivers/base/dd.c:661
> #21 0xffff8000809cd8f8 in __driver_probe_device (drv=3D0xffff800082e641c0=
 <arm_smmu_driver+40>, dev=3D0xffff0000036bfc10) at drivers/base/dd.c:803
> #22 0xffff8000809cdb34 in driver_probe_device (drv=3D0xffff0000036bfc90, =
dev=3D0xffff0000036bfc10) at drivers/base/dd.c:833
> #23 0xffff8000809cddb8 in __driver_attach (data=3D<optimized out>, dev=3D=
<optimized out>) at drivers/base/dd.c:1227
> #24 __driver_attach (dev=3D0xffff0000036bfc10, data=3D0xffff800082e641c0 =
<arm_smmu_driver+40>) at drivers/base/dd.c:1167
> #25 0xffff8000809cb17c in bus_for_each_dev (bus=3D0xffff0000036bfc90, sta=
rt=3D0x0, data=3D0xffff800082e641c0 <arm_smmu_driver+40>, fn=3D0xffff800080=
9cdcec <__driver_attach>) at drivers/base/bus.c:383
> #26 0xffff8000809cd03c in driver_attach (drv=3D0x0) at drivers/base/dd.c:=
1245
> #27 0xffff8000809cc748 in bus_add_driver (drv=3D0xffff800082e641c0 <arm_s=
mmu_driver+40>) at drivers/base/bus.c:715
> #28 0xffff8000809ced28 in driver_register (drv=3D0xffff800082e641c0 <arm_=
smmu_driver+40>) at drivers/base/driver.c:249
> #29 0xffff8000809d0254 in __platform_driver_register (drv=3D0x0, owner=3D=
0xffff000003510000) at drivers/base/platform.c:908
> #30 0xffff800081f3d12c in arm_smmu_driver_init () at drivers/iommu/arm/ar=
m-smmu/arm-smmu.c:2368
> #31 0xffff800080015218 in do_one_initcall (fn=3D0xffff800081f3d10c <arm_s=
mmu_driver_init>) at init/main.c:1378
> #32 0xffff800081ed13e4 in do_initcall_level (command_line=3D<optimized ou=
t>, level=3D<optimized out>) at init/main.c:1440
> #33 do_initcalls () at init/main.c:1456
> #34 do_basic_setup () at init/main.c:1475
> #35 kernel_init_freeable () at init/main.c:1688
> #36 0xffff800081187b50 in kernel_init (unused=3D0xffff0000036bfc90) at in=
it/main.c:1578
> #37 0xffff800080015f58 in ret_from_fork () at arch/arm64/kernel/entry.S:8=
60
> Backtrace stopped: previous frame identical to this frame (corrupt stack?=
)

Thanks, this backtrace is very helpful. My lockdep patch should reveal the =
same
issue once run on real hardware, but with this it's probably not even neces=
sary
anymore.

So, the problem is that in the callstack of the arm-smmu driver's (a platfo=
rm
driver) probe() function, the QCOM specific code (through arm_smmu_impl_ini=
t())
registers another platform driver. Since we are still in probe() of arm-smm=
u the
call to platform_driver_register() happens with the device lock of the arm-=
smmu
platform device held.

platform_driver_register() eventually results in driver_attach() which iter=
ates
over all the devices of a bus. Since the device we are probing and the driv=
er we
are registering are for the same bus (i.e. the platform bus) it can now hap=
pen
that by chance that we also match the exact same device that is currently p=
robed
again. And since we take the device lock for matching now, we actually take=
 the
same lock twice.

Now, we could avoid this by not matching bound devices, but we check this
through dev->driver while holding the device lock, so that doesn't help.

But on the other hand, I don't see any reason why a driver would call
platform_driver_register() from probe() in the first place. I think drivers
should not do that and instead just register the driver through a normal
initcall.

(If, however, it turns out that registering drivers from probe() is somethi=
ng we
really need for some reason, it is probably best to drop the patch and don'=
t
make any guarantees about whether match() is called with the device lock he=
ld or
not.

Consequently, driver_override must be protected with a separate lock (which
would be the cleaner solution in any case).)
