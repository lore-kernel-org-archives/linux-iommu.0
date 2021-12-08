Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4187FC433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 23:01:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BF07A4013F;
	Wed,  8 Dec 2021 23:01:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LvtIkX9k_tK8; Wed,  8 Dec 2021 23:01:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 00679400FC;
	Wed,  8 Dec 2021 23:01:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D719AC001E;
	Wed,  8 Dec 2021 23:01:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B8BFC0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 23:01:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 36187826F5
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 23:01:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X2CDKElSzJbl for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 23:01:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E979C82660
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 23:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639004459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iNGEVUe3rNTMTHBuJyGoKjgYgDPiTtUcd05Jf7jhrLI=;
 b=YNnzEMy+0L6Gufi4cjrVlrV6ZovQygXdhTJKDstonoBYdtLjOHJjOmxlOIwqOzNECXQrdC
 S2EJPrAvW8CeqkErSe5H9hY2JUefpn6EVBmvOtonFUG1P4G1c9f8B8zAvI9f85f93nO5fH
 Lzd+Yln5RBny63j12rUKxfcHPqPK1EQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-254-L5rc2EZjPOSZS3VExVydFg-1; Wed, 08 Dec 2021 18:00:56 -0500
X-MC-Unique: L5rc2EZjPOSZS3VExVydFg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D7BC81EE62;
 Wed,  8 Dec 2021 23:00:55 +0000 (UTC)
Received: from starship (unknown [10.40.192.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9849F610A6;
 Wed,  8 Dec 2021 23:00:47 +0000 (UTC)
Message-ID: <39c885fc6455dd0aa2f8643e725422851430f9ec.camel@redhat.com>
Subject: Re: [PATCH v3 00/26] KVM: x86: Halt and APICv overhaul
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Joerg Roedel <joro@8bytes.org>
Date: Thu, 09 Dec 2021 01:00:46 +0200
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
References: <20211208015236.1616697-1-seanjc@google.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Jim Mattson <jmattson@google.com>
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

On Wed, 2021-12-08 at 01:52 +0000, Sean Christopherson wrote:
> Overhaul and cleanup APIC virtualization (Posted Interrupts on Intel VMX,
> AVIC on AMD SVM) to streamline things as much as possible, remove a bunch
> of cruft, and document the lurking gotchas along the way.
> 
> Patch 01 is a fix from Paolo that's already been merged but hasn't made
> its way to kvm/queue.  It's included here to avoid a number of conflicts.
> 
> Based on kvm/queue, commit 1cf84614b04a ("KVM: x86: Exit to ...")
> 
> v3:
>  - Rebase to kvm/queue (and drop non-x86 patches as they've been queued). 
>  - Redo AVIC patches, sadly the vcpu_(un)blocking() hooks need to stay.
>  - Add a patch to fix a missing (docuentation-only) barrier in nested
>    posted interrupt delivery. [Paolo]
>  - Collect reviews.
> 
> v2:
>  - https://lore.kernel.org/all/20211009021236.4122790-1-seanjc@google.com/
>  - Collect reviews. [Christian, David]
>  - Add patch to move arm64 WFI functionality out of hooks. [Marc]
>  - Add RISC-V to the fun.
>  - Add all the APICv fun.
> 
> v1: https://lkml.kernel.org/r/20210925005528.1145584-1-seanjc@google.com
> 
> Paolo Bonzini (1):
>   KVM: fix avic_set_running for preemptable kernels
> 
> Sean Christopherson (25):
>   KVM: nVMX: Ensure vCPU honors event request if posting nested IRQ
>     fails
>   KVM: VMX: Clean up PI pre/post-block WARNs
>   KVM: VMX: Handle PI wakeup shenanigans during vcpu_put/load
>   KVM: Drop unused kvm_vcpu.pre_pcpu field
>   KVM: Move x86 VMX's posted interrupt list_head to vcpu_vmx
>   KVM: VMX: Move preemption timer <=> hrtimer dance to common x86
>   KVM: x86: Unexport LAPIC's switch_to_{hv,sw}_timer() helpers
>   KVM: x86: Remove defunct pre_block/post_block kvm_x86_ops hooks
>   KVM: SVM: Signal AVIC doorbell iff vCPU is in guest mode
>   KVM: SVM: Don't bother checking for "running" AVIC when kicking for
>     IPIs
>   KVM: SVM: Remove unnecessary APICv/AVIC update in vCPU unblocking path
>   KVM: SVM: Use kvm_vcpu_is_blocking() in AVIC load to handle preemption
>   KVM: SVM: Skip AVIC and IRTE updates when loading blocking vCPU
>   iommu/amd: KVM: SVM: Use pCPU to infer IsRun state for IRTE
>   KVM: VMX: Don't do full kick when triggering posted interrupt "fails"
>   KVM: VMX: Wake vCPU when delivering posted IRQ even if vCPU == this
>     vCPU
>   KVM: VMX: Pass desired vector instead of bool for triggering posted
>     IRQ
>   KVM: VMX: Fold fallback path into triggering posted IRQ helper
>   KVM: VMX: Don't do full kick when handling posted interrupt wakeup
>   KVM: SVM: Drop AVIC's intermediate avic_set_running() helper
>   KVM: SVM: Move svm_hardware_setup() and its helpers below svm_x86_ops
>   KVM: SVM: Nullify vcpu_(un)blocking() hooks if AVIC is disabled
>   KVM: x86: Skip APICv update if APICv is disable at the module level
>   KVM: x86: Drop NULL check on kvm_x86_ops.check_apicv_inhibit_reasons
>   KVM: x86: Unexport __kvm_request_apicv_update()
> 
>  arch/x86/include/asm/kvm-x86-ops.h |   2 -
>  arch/x86/include/asm/kvm_host.h    |  12 -
>  arch/x86/kvm/hyperv.c              |   3 +
>  arch/x86/kvm/lapic.c               |   2 -
>  arch/x86/kvm/svm/avic.c            | 116 ++++---
>  arch/x86/kvm/svm/svm.c             | 479 ++++++++++++++---------------
>  arch/x86/kvm/svm/svm.h             |  16 +-
>  arch/x86/kvm/vmx/posted_intr.c     | 234 +++++++-------
>  arch/x86/kvm/vmx/posted_intr.h     |   8 +-
>  arch/x86/kvm/vmx/vmx.c             |  66 ++--
>  arch/x86/kvm/vmx/vmx.h             |   3 +
>  arch/x86/kvm/x86.c                 |  41 ++-
>  drivers/iommu/amd/iommu.c          |   6 +-
>  include/linux/amd-iommu.h          |   6 +-
>  include/linux/kvm_host.h           |   3 -
>  virt/kvm/kvm_main.c                |   3 -
>  16 files changed, 510 insertions(+), 490 deletions(-)
> 

Probably just luck (can't reproduce this anymore) but
while running some kvm unit tests with this patch series (and few my patches
for AVIC co-existance which shouldn't affect this) I got this

(warning about is_running already set)

Dec 08 22:53:26 amdlaptop kernel: ------------[ cut here ]------------
Dec 08 22:53:26 amdlaptop kernel: WARNING: CPU: 3 PID: 72804 at arch/x86/kvm/svm/avic.c:1045 avic_vcpu_load+0xe3/0x100 [kvm_amd]
Dec 08 22:53:26 amdlaptop kernel: Modules linked in: kvm_amd(O) ccp rng_core kvm(O) irqbypass xt_conntrack ip6table_filter ip6_tables snd_soc_dmic snd_acp3x_>
Dec 08 22:53:26 amdlaptop kernel:  r8169 realtek 8250_pci usbmon nbd fuse autofs4 [last unloaded: rng_core]
Dec 08 22:53:26 amdlaptop kernel: CPU: 3 PID: 72804 Comm: qemu-system-i38 Tainted: G           O      5.16.0-rc4.unstable #6
Dec 08 22:53:26 amdlaptop kernel: Hardware name: LENOVO 20UF001CUS/20UF001CUS, BIOS R1CET65W(1.34 ) 06/17/2021
Dec 08 22:53:26 amdlaptop kernel: RIP: 0010:avic_vcpu_load+0xe3/0x100 [kvm_amd]
Dec 08 22:53:26 amdlaptop kernel: Code: 0d 9f e0 85 c0 74 e8 4c 89 f6 4c 89 ff e8 a5 99 f4 e0 5b 41 5c 41 5d 41 5e 41 5f 5d c3 0f 0b 5b 41 5c 41 5d 41 5e 41 >
Dec 08 22:53:26 amdlaptop kernel: RSP: 0018:ffffc9000b17bba8 EFLAGS: 00010247
Dec 08 22:53:26 amdlaptop kernel: RAX: 6f63203a756d6571 RBX: ffff888106194740 RCX: ffff88812e7ac000
Dec 08 22:53:26 amdlaptop kernel: RDX: ffff8883ff6c0000 RSI: 0000000000000003 RDI: 0000000000000003
Dec 08 22:53:26 amdlaptop kernel: RBP: ffffc9000b17bbd0 R08: ffff888106194740 R09: 0000000000000000
Dec 08 22:53:26 amdlaptop kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
Dec 08 22:53:26 amdlaptop kernel: R13: 0000000000000003 R14: ffff88810023b060 R15: dead000000000100
Dec 08 22:53:26 amdlaptop kernel: FS:  0000000000000000(0000) GS:ffff8883ff6c0000(0000) knlGS:0000000000000000
Dec 08 22:53:26 amdlaptop kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Dec 08 22:53:26 amdlaptop kernel: CR2: 00005587e812f958 CR3: 0000000105f31000 CR4: 0000000000350ee0
Dec 08 22:53:26 amdlaptop kernel: DR0: 00000000004008da DR1: 0000000000000000 DR2: 0000000000000000
Dec 08 22:53:26 amdlaptop kernel: DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Dec 08 22:53:26 amdlaptop kernel: Call Trace:
Dec 08 22:53:26 amdlaptop kernel:  <TASK>
Dec 08 22:53:26 amdlaptop kernel:  svm_vcpu_load+0x56/0x60 [kvm_amd]
Dec 08 22:53:26 amdlaptop kernel:  kvm_arch_vcpu_load+0x32/0x210 [kvm]
Dec 08 22:53:26 amdlaptop kernel:  vcpu_load+0x34/0x40 [kvm]
Dec 08 22:53:26 amdlaptop kernel:  kvm_arch_destroy_vm+0xd4/0x1c0 [kvm]
Dec 08 22:53:26 amdlaptop kernel:  kvm_destroy_vm+0x163/0x250 [kvm]
Dec 08 22:53:26 amdlaptop kernel:  kvm_put_kvm+0x26/0x40 [kvm]
Dec 08 22:53:26 amdlaptop kernel:  kvm_vm_release+0x22/0x30 [kvm]
Dec 08 22:53:26 amdlaptop kernel:  __fput+0x94/0x250
Dec 08 22:53:26 amdlaptop kernel:  ____fput+0xe/0x10
Dec 08 22:53:26 amdlaptop kernel:  task_work_run+0x63/0xa0
Dec 08 22:53:26 amdlaptop kernel:  do_exit+0x358/0xa30
Dec 08 22:53:26 amdlaptop kernel:  do_group_exit+0x3b/0xa0
Dec 08 22:53:26 amdlaptop kernel:  get_signal+0x15b/0x880
Dec 08 22:53:26 amdlaptop kernel:  ? _copy_to_user+0x20/0x30
Dec 08 22:53:26 amdlaptop kernel:  ? put_timespec64+0x3d/0x60
Dec 08 22:53:26 amdlaptop kernel:  arch_do_signal_or_restart+0x106/0x740
Dec 08 22:53:26 amdlaptop kernel:  ? hrtimer_nanosleep+0x9f/0x120
Dec 08 22:53:26 amdlaptop kernel:  ? __hrtimer_init+0xd0/0xd0
Dec 08 22:53:26 amdlaptop kernel:  exit_to_user_mode_prepare+0x112/0x1f0
Dec 08 22:53:26 amdlaptop kernel:  syscall_exit_to_user_mode+0x17/0x40
Dec 08 22:53:26 amdlaptop kernel:  do_syscall_64+0x42/0x80
Dec 08 22:53:26 amdlaptop kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
Dec 08 22:53:26 amdlaptop kernel: RIP: 0033:0x7f537abb13b5
Dec 08 22:53:26 amdlaptop kernel: Code: Unable to access opcode bytes at RIP 0x7f537abb138b.
Dec 08 22:53:26 amdlaptop kernel: RSP: 002b:00007f5376a39680 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
Dec 08 22:53:26 amdlaptop kernel: RAX: fffffffffffffdfc RBX: 00007f5376a396d0 RCX: 00007f537abb13b5
Dec 08 22:53:26 amdlaptop kernel: RDX: 00007f5376a396d0 RSI: 0000000000000000 RDI: 0000000000000000
Dec 08 22:53:26 amdlaptop kernel: RBP: 00007f5376a396c0 R08: 0000000000000000 R09: 0000000000000000
Dec 08 22:53:26 amdlaptop kernel: R10: 00007f5376a396c0 R11: 0000000000000293 R12: 00007f5376a3b640
Dec 08 22:53:26 amdlaptop kernel: R13: 0000000000000002 R14: 00007f537ab66880 R15: 0000000000000000
Dec 08 22:53:26 amdlaptop kernel:  </TASK>
Dec 08 22:53:26 amdlaptop kernel: ---[ end trace 676058aaf29d0267 ]---


I'll post my patches tomorrow, after some more testing.

Best regards,
	Maxim Levitsky

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
