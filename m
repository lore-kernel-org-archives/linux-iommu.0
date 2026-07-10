Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59B72D7DD4
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783662483; cv=none; b=kmYZwY6R4aGLVubuYywwg9QtdCex/XXMJmayMeqKjTcsndn6pL5KJRFVmhkVk6Nn6evHhZBdFiEFT6y93O+X6TDsQIrUFZ7GWVgHJRWRXcPmzEFqmsxbY5ESJtKuceGLSRTTwQEgCeKDQ3ETYQe0MZ+JNHyqboiDsHKaY/gdj10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783662483; c=relaxed/simple;
	bh=4z8ysp2HmloWl1VYJpDeMCZuUqqUQAowWkjtJisye2c=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=SGy4sTccjBWugHEQ6x0QBW4CHyVm4FKDOngSNG7mSTZnSj7pP23yptA5Rdd27v1GO+l7BhIUiLeFG4XgbUebPIrrC+jExfS4IrJHdCD1XgHM7yKX5CpTqtWLW/3G+m3Myq4nGKoWFMDLuagrznBzj3BdAIn7bvoo54ODcn3syX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=RFpyA3CN; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="RFpyA3CN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1783662424;
	bh=LRTWa3sWxw9OE/ekdltyReiPfgritCnHI3rAoogQik4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject;
	b=RFpyA3CNfxQE657iT4w97T/MyDEUcQb+qW+KnhxlfYl14OI18uLASuCWgKCeN5tVy
	 vP0st1q8B4mHkCa5LBr0jwd/6NaLtah0WcEDRN2/ViaTU4pCV4ZO+c6VVb/IZS5RcK
	 khbxtT29pyG37lYlJ3O3rFggGOpZN5iHiln2APKo=
X-QQ-mid: esmtpsz19t1783662417t31a65a2e
X-QQ-Originating-IP: +LoVeXPiclrt5m4gAYug3E1xQXr9DcfkTN1dHYvH+y4=
Received: from [127.0.0.1] ( [36.152.24.146])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 10 Jul 2026 13:46:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11418582051815141711
Message-ID: <870BB9ADBBEDDD1A+37c5bfab-ad32-4fc5-a302-57c81a8432b5@smail.nju.edu.cn>
Date: Fri, 10 Jul 2026 13:46:55 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, kevin.tian@intel.com
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [BUG] iommufd/selftest: fault injection in iommufd_get_object can
 trigger a teardown UAF
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MSyoPQEuxKCuJGzQrB5/2QnYwmR7tvSGErzVthik1pYB46lFg4TUITmF
	fM7oR4stZF7j8lW3z1N/CCFHH7Sk44qqLugwC72eBma7ZMlIs9w1KtIVHcM1IT8J5G7mqwm
	DgkBnxMpWHq6T30sMRjI1UVxw2QDWh7jVqcxpZoaw/GCBNg+fxEIWMMhjjF6FtBuxJt5SeQ
	xP1JDZR4U9dGiLZ5XqRY5q8hsU2o1oQukk8K1EsnKbhKCYmVlgaIaneivUGyNkg6QNiBd4n
	zkxPSkXbd8P8Sx6H6HZP4yRAlEM+jenHa5SQaKXvbNl6f1nsQC0yLTkY60V0xAQv7mNx+dK
	tS+FwAy3JPg4KI+T6rQZOcQR60/gXmebU/2uL5dAyYiu/Le/3PZTkxaHc73EcmAeNg7tIiw
	r9F+rYYQL+OZucOBwmVMIxJSUIXxP5CAMLW9lYl32uNpLJ3booVkfe6kk+EiBe4H1dsW7T2
	Cpj3sfKgAP6dBxQM2k95/Qj4Ji9LfYYIINGVZhDyvRWsbzEfvFoSf7JX6ro0K2CKqex3+qz
	cwLGreBZqlY8i1ukMzxQMjmWMigseYJt6FaMStTPLqIxeWX0vRVoJh1A9maBBAOBuXj+/21
	ookotajcFHoCylRcqaQswcVa8WMxdrI6GjT1HnCfMyERhtt3UlwwZRKWvo4X33R9/1mwxOM
	PQGFk/re3O0PlwLvq6LiKutTjYyndb2eUSGSKjYAgH/XDfIwuEDvt3bWbU+wexxLunPQueE
	CMd6JscyR/tjPcj/lPV0oMP8FeuwKsRDHgNsDIBqjBNWiyCLPOmY5cYvKigROOGZ/tgOUa1
	xvCrpHVMWiuJcZkkjov411i4EeR3KAxI9PSa7xq/+8JGK1RUUAJQIHH/Q2IbIrvbFj53rik
	GpvH/DotippLnUq1gq3IRG/BVsHGYJdztijdJAOGMyXang3R625rRP79H6M01sEAw9ObpYv
	ThZtGCATlhuJJXEcTNfw/3Px1yd/G/ar5ZUwAluxkvmT65ngxzcp8Gd8bwxeHc+FzZZVSec
	poPI4exMUdPYEr/AiecGGEeIBl93N1doaTuv5WZA==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

Hello Linux kernel developers and maintainers,

We found a KMSAN use-after-free in iommu_device_release_dma_owner warning when fuzzing IOMMUFD with selftest
with Syzkaller.

After our digging, we believe this UAF has limited impact, but it exposes a possible improvement on how
fault injection is handled in iommufd_device_pre_destroy().

The root cause for this UAF is that iommufd_device_pre_destroy() uses the fault-injectable iommufd_get_object(),
causing it to mistakenly assume that the vdev destruction has been taken over by another thread.
More detailed analysis will be given below.

===========
Kernel info
===========

Version: commit 8cd9520d35a6c38db6567e97dd93b1f11f185dc6 (tag v7.1).

Relevant config: (the complete config is available in https://drive.google.com/file/d/12oVjpfA3-PnZGMI6afFT6Ik33jXDcIn9/view?usp=sharing)

CONFIG_IOMMUFD=y
CONFIG_IOMMUFD_TEST=y
CONFIG_DEBUG_KERNEL=y
CONFIG_FAULT_INJECTION=y
CONFIG_KMSAN=y

The kernel must additionally run with panic_on_warn=0; otherwise, the
preceding warning stops execution before the UAF is reached.

================
Syzkaller report
================

WARNING: drivers/iommu/iommu.c:745 at __iommu_group_free_device+0x161/0x430 drivers/iommu/iommu.c:744, CPU#0: syz.2.3323/37757
Modules linked in:
CPU: 0 UID: 0 PID: 37757 Comm: syz.2.3323 Tainted: G        W           7.1.0 #6 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__iommu_group_free_device+0x161/0x430 drivers/iommu/iommu.c:744
Code: 89 58 08 44 89 a8 90 0c 00 00 31 ff 44 89 e6 e8 35 2f 8a fa 85 db 74 07 f7 d3 44 21 e3 74 3d 45 85 e4 74 45 e8 e0 2a 8a fa 90 <0f> 0b 90 e9 86 00 00 00 8b 7d d4 e8 0f 78 36 fb 4d 85 ff 0f 84 0d
RSP: 0018:ffff888034c57880 EFLAGS: 00010293
RAX: ffffffff8765c7a0 RBX: 0000000000000000 RCX: ffff88801cc2c300
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff888034c578f0 R08: ffffea000000000f R09: 0000000000000000
R10: ffff88813bcb2028 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888076fc9d00
FS:  00007f1b3bdd56c0(0000) GS:ffff8880ea7fc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6223143fc8 CR3: 0000000058274000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 __iommu_group_remove_device+0x2ba/0x590 drivers/iommu/iommu.c:763
 iommu_release_device drivers/iommu/iommu.c:784 [inline]
 iommu_bus_notifier+0x94/0x580 drivers/iommu/iommu.c:1827
 notifier_call_chain kernel/notifier.c:85 [inline]
 blocking_notifier_call_chain+0x127/0x4d0 kernel/notifier.c:380
 bus_notify+0x2aa/0x3a0 drivers/base/bus.c:1079
 device_del+0xba8/0xd80 drivers/base/core.c:3912
 device_unregister+0x1e/0x40 drivers/base/core.c:3936
 mock_dev_destroy drivers/iommu/iommufd/selftest.c:1037 [inline]
 iommufd_selftest_destroy+0xd5/0x100 drivers/iommu/iommufd/selftest.c:1922
 iommufd_object_remove+0x4ae/0x6c0 drivers/iommu/iommufd/main.c:273
 iommufd_destroy+0x89/0xd0 drivers/iommu/iommufd/main.c:292
 iommufd_fops_ioctl+0x7bb/0x950 drivers/iommu/iommufd/main.c:533
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0x23d/0x400 fs/ioctl.c:583
 __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:583
 x64_sys_call+0x1975/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15c/0x3c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1b3dba788d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1b3bdd5018 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f1b3de36090 RCX: 00007f1b3dba788d
RDX: 00002000000008c0 RSI: 0000000000003b80 RDI: 0000000000000003
RBP: 00007f1b3bdd5080 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007f1b3de36128 R14: 00007f1b3de36090 R15: 00007ffe1aa200c0
 </TASK>
---[ end trace 0000000000000000 ]---
=====================================================
BUG: KMSAN: use-after-free in iommu_device_release_dma_owner+0x105/0x820 drivers/iommu/iommu.c:3519
 iommu_device_release_dma_owner+0x105/0x820 drivers/iommu/iommu.c:3519
 iommufd_device_destroy+0x3d/0x100 drivers/iommu/iommufd/device.c:196
 iommufd_fops_release+0x1f3/0x610 drivers/iommu/iommufd/main.c:361
 __fput+0x6c1/0x1050 fs/file_table.c:510
 ____fput+0x25/0x30 fs/file_table.c:538
 task_work_run+0x25a/0x300 kernel/task_work.c:233
 get_signal+0x13b/0x2c50 kernel/signal.c:2810
 arch_do_signal_or_restart+0x53/0xc70 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
 exit_to_user_mode_loop+0x228/0x2410 kernel/entry/common.c:98
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x276/0x3c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_free_hook mm/slub.c:2615 [inline]
 slab_free mm/slub.c:6251 [inline]
 kfree+0x32f/0x10e0 mm/slub.c:6566
 mock_dev_release+0x47/0x60 drivers/iommu/iommufd/selftest.c:978
 device_release+0xda/0x330 drivers/base/core.c:2562
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x2b7/0x3a0 lib/kobject.c:737
 put_device drivers/base/core.c:3814 [inline]
 device_unregister+0x30/0x40 drivers/base/core.c:3937
 mock_dev_destroy drivers/iommu/iommufd/selftest.c:1037 [inline]
 iommufd_selftest_destroy+0xd5/0x100 drivers/iommu/iommufd/selftest.c:1922
 iommufd_object_remove+0x4ae/0x6c0 drivers/iommu/iommufd/main.c:273
 iommufd_destroy+0x89/0xd0 drivers/iommu/iommufd/main.c:292
 iommufd_fops_ioctl+0x7bb/0x950 drivers/iommu/iommufd/main.c:533
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0x23d/0x400 fs/ioctl.c:583
 __x64_sys_ioctl+0x97/0xe0 fs/ioctl.c:583
 x64_sys_call+0x1975/0x3ea0 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15c/0x3c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 37757 Comm: syz.2.3323 Tainted: G        W           7.1.0 #6 PREEMPT(lazy) 
Tainted: [W]=WARN
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
=====================================================

<<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>

The complete log is available in https://drive.google.com/file/d/1J-2DrF2o9GYRnKsZ1dKFW4NUbGlSz3aL/view?usp=sharing

==========
Root cause
==========

S = the TYPE_IDEV selftest object created by IOMMU_TEST_OP_MOCK_DOMAIN.
I = the iommufd_device owned by S.
M = the mock_dev backing I, with I->dev pointing to &M->dev.
V = an iommufd_vdevice bound to I.

TLDR:

The device pre-destroy path must revoke V before I can be destroyed.
However, it tries to find V through the *fault-injectable* iommufd_get_object().
When fail_iommufd forces that lookup to return -ENOENT, the code treats the
failure as if V were already being destroyed concurrently. V is actually still
alive and continues to hold I's wait_cnt reference, so iommufd_device_unbind()
times out and leaves I in the object xarray for cleanup during file close.

iommufd_selftest_destroy() does not observe that unbind failed.
It unconditionally unregisters M, and mock_dev_release() frees M even though the
surviving I still contains I->dev = &M->dev. Later, iommufd_fops_release()
destroys V and then I. iommufd_device_destroy(I) passes the dangling I->dev to
iommu_device_release_dma_owner(), which reads the freed struct device and
triggers the UAF.

Detailed call stack:

1. IOMMU_TEST_OP_MOCK_DOMAIN creates S, I and M. I is bound to M, so I->dev
   points to M:

        iommufd_test_mock_domain()
        --> mock_dev_create() /* M is created here */
        --> iommufd_device_bind(..., &M->dev, ...)

2. IOMMU_VDEVICE_ALLOC creates V for I. The persistent V->idev pointer is
   protected by an object reference on I, including a wait_cnt reference. The
   reverse I->vdev pointer records the V that must be revoked before I can be
   destroyed:

        iommufd_vdevice_alloc_ioctl()
        --> idev = iommufd_get_device(...) /* Get I here */
        --> V->idev = I
        --> I->vdev = V

3. Userspace destroys S with fail_nth enabled. Destroying S enters the selftest
   destructor, which first tries to unbind I:

        ioctl(IOMMU_DESTROY, S)
        --> iommufd_object_remove(S)
            --> iommufd_selftest_destroy(S)
                --> iommufd_device_unbind(I)
                    --> iommufd_object_destroy_user(I)
                        --> iommufd_object_remove(I, REMOVE_WAIT)
                            --> iommufd_object_dec_wait(I)

4. I's wait_cnt cannot reach zero because V still references it. The object
   core therefore calls iommufd_device_pre_destroy() to revoke V:

        iommufd_object_dec_wait(I)
        --> iommufd_device_pre_destroy(I)
            --> iommufd_device_remove_vdev(I)
                --> I->destroying = true
                --> iommufd_get_vdevice(I->ictx, I->vdev->obj.id)
                    --> iommufd_get_object()

   iommufd_get_object() contains an iommufd_should_fail() fault injection point.
   In this execution, fail_nth forces it to return -ENOENT:

        if (iommufd_should_fail())
                return ERR_PTR(-ENOENT);

   iommufd_device_remove_vdev() assumes an error means that a concurrent V
   destroy has already removed V from the object xarray and will eventually
   release I's wait_cnt reference. That assumption is not true for an injected
   failure: V remains present, I->vdev remains V, and no concurrent path
   will drop the reference. This function simply unlocks and returns:

        if (IS_ERR(vdev))
                goto out_unlock;

5. Because V still holds I's wait_cnt reference, iommufd_object_dec_wait()
   waits for 60 seconds, restores I's wait_cnt, and returns -EBUSY.
   iommufd_object_remove() then leaves I in the xarray so file close
   can retry its destruction. iommufd_object_destroy_user() only reports this
   with WARN_ON(ret); its void return type gives iommufd_selftest_destroy() no
   indication that I remains alive:

        wait_event_timeout(... I->wait_cnt == 0, 60000 ms)
        --> refcount_inc(&I->wait_cnt)
        --> return -EBUSY

        iommufd_object_remove(I)
        --> refcount_dec(&I->users)
        --> return -EBUSY

        iommufd_object_destroy_user(I)
        --> WARN_ON(ret)

6. After the failed unbind, iommufd_selftest_destroy() still destroys
   M unconditionally:

        iommufd_selftest_destroy(S)
        --> iommufd_device_unbind(I)       /* failed; I is still alive */
        --> mock_dev_destroy(M)            /* runs anyway */
            --> device_unregister(&M->dev)
                --> mock_dev_release(&M->dev)
                    --> kfree(M)

   At this point M has been freed, but I is still reachable from the iommufd
   object xarray and I->dev still points to the *freed* &M->dev.

7. During file close, iommufd_fops_release() repeatedly destroys leaf objects.
   It first destroys V, which clears I->vdev and drops V's reference on I. I
   then becomes destroyable in a later pass:

        iommufd_fops_release()
        --> iommufd_vdevice_destroy(V)
            --> iommufd_vdevice_abort(V)
                --> I->vdev = NULL
            --> iommufd_put_object(I)

        iommufd_fops_release() /* later xarray pass */
        --> iommufd_device_destroy(I)
            --> iommu_device_release_dma_owner(I->dev)

   iommu_device_release_dma_owner() accesses dev->iommu_group, but dev is the
   embedded struct device in the already freed M. This is the reported KMSAN
   use-after-free:

        struct iommu_group *group = dev->iommu_group;
        mutex_lock(&group->mutex);

The fault-injected V lookup is what prevents the normal pre-destroy revocation,
and the unconditional mock device destruction converts that failed cleanup
into a UAF. Without the lookup failure, V is tombstoned and releases
I's reference, allowing I to be destroyed before M is unregistered.

=============
Suggested fix
=============

iommufd_device_pre_destroy() should bypass the fault injection point in iommufd_get_object().
(we cannot simply delete this fault injection point since other callers may rely on it)

One possible fix is to split the real object lookup logic from the fault-injectable wrapper:

        struct iommufd_object *
        _iommufd_get_object(struct iommufd_ctx *ictx, u32 id,
                            enum iommufd_object_type type)
        {
                struct iommufd_object *obj;

                xa_lock(&ictx->objects);
                obj = xa_load(&ictx->objects, id);
                if (!obj ||
                    (type != IOMMUFD_OBJ_ANY && obj->type != type) ||
                    !iommufd_lock_obj(obj))
                        obj = ERR_PTR(-ENOENT);
                xa_unlock(&ictx->objects);
                return obj;
        }

        struct iommufd_object *
        iommufd_get_object(struct iommufd_ctx *ictx, u32 id,
                           enum iommufd_object_type type)
        {
                if (iommufd_should_fail())
                        return ERR_PTR(-ENOENT);

                return _iommufd_get_object(ictx, id, type);
        }

And make iommufd_get_vdevice (whose only caller is iommufd_device_remove_vdev)
call _iommufd_get_object.

But I am not sure whether such a wrapper-style fix is the best practice for the kernel.
Happy to hear any feedback!

Thanks,
Peiyang
