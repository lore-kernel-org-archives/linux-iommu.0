Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDEFC433FE
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:54:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C433282660;
	Wed,  8 Dec 2021 01:54:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s6W1x5e40wrZ; Wed,  8 Dec 2021 01:54:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AB1AE824EE;
	Wed,  8 Dec 2021 01:54:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F251C001E;
	Wed,  8 Dec 2021 01:54:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19985C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:54:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 027BF82572
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:54:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CGj4FHVGXs8X for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:54:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 265C4824EE
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:54:45 +0000 (UTC)
Received: by mail-pg1-x54a.google.com with SMTP id
 a8-20020a63cd48000000b00330605939c0so446790pgj.5
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:message-id:mime-version:subject:from:to:cc;
 bh=JPQ6j/8Xcv0ZDoVXkCoBftcZyNezl+x5YdkfDBVpnRI=;
 b=qAqDIWUEHqQyDYxwc0+4yVfPyvyNpDFCJVxAudjYg2EtOtdKAPSrzURp++VyziDdd4
 +sZTKUjhSYuPd8BT/jGf92EPsIMU5itBK3Mgwpr7S/TnW98GgL/OMOr1plBEbRiAibw8
 xcOVwxCb8wL+Aj4nGsObFCq7lkhljjtdfD3bDJTmAWWewZvJ3TFRNyvAdXFoVWVozYKV
 Wbk017UDqhXPuGbPPpUYMY7bRDsqCQYs57AZqbAsbhB39e4U7hm2IZecAv9nuLRPnF4o
 f5P3BfzEjv2BjzRG0vyhp9Z+O5hJU5RL0U+joxSgtorf336zBd+XOm1O1U3g5fu4mSg+
 WEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
 :from:to:cc;
 bh=JPQ6j/8Xcv0ZDoVXkCoBftcZyNezl+x5YdkfDBVpnRI=;
 b=SavwhdyKoVlwQBRC1LH8HvWYj5B2J6zvvDB8OPOP3myQZMHzW8IPpcIBW3RyKzVtSm
 471hg8H03fgfVCrLDs1L1+smHD6on5XGQwrjAyb7r/lfS0k8vatycLF+uevrNS/8b92i
 QfozYr5CnMFfxE/YI1AbdLrTk7ReGDAJ6g41qWYFj2Q/awEeUp7h7b1L6ltJs7DF8mJU
 tGkRNOzXTVZCO8ronrQlUHwKmRrS2Kwm6zgG35q6AP/EIkXuULM7OkrwH80rjQz1GrVb
 5iyL6n4cc4+XJCb7gaEEbWHF+TTbDIMB+e5hoCiJoeYaYOBNu+2/33Zh3trsqek8n6rf
 4lIQ==
X-Gm-Message-State: AOAM5332kBkLJAOekZP5cLuJBJZfwSEwW8shHyOOiM33rV2IGBCW7/6p
 BMvB0nxPtRuC6MyTatvEIxdSATCx6qI=
X-Google-Smtp-Source: ABdhPJzxCNWX1tuxOjc/ou63x3Jxba7eb96x4TWBltqYeCrNS7u7paGPYAYB4fpGzXGrtX5cewu2W8J1gUc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1b52:: with SMTP id
 nv18mr3632061pjb.43.1638928484575; Tue, 07 Dec 2021 17:54:44 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:10 +0000
Message-Id: <20211208015236.1616697-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 00/26] KVM: x86: Halt and APICv overhaul
To: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>
Cc: Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>, linux-kernel@vger.kernel.org,
 Maxim Levitsky <mlevitsk@redhat.com>, iommu@lists.linux-foundation.org,
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
From: Sean Christopherson via iommu <iommu@lists.linux-foundation.org>
Reply-To: Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Overhaul and cleanup APIC virtualization (Posted Interrupts on Intel VMX,
AVIC on AMD SVM) to streamline things as much as possible, remove a bunch
of cruft, and document the lurking gotchas along the way.

Patch 01 is a fix from Paolo that's already been merged but hasn't made
its way to kvm/queue.  It's included here to avoid a number of conflicts.

Based on kvm/queue, commit 1cf84614b04a ("KVM: x86: Exit to ...")

v3:
 - Rebase to kvm/queue (and drop non-x86 patches as they've been queued). 
 - Redo AVIC patches, sadly the vcpu_(un)blocking() hooks need to stay.
 - Add a patch to fix a missing (docuentation-only) barrier in nested
   posted interrupt delivery. [Paolo]
 - Collect reviews.

v2:
 - https://lore.kernel.org/all/20211009021236.4122790-1-seanjc@google.com/
 - Collect reviews. [Christian, David]
 - Add patch to move arm64 WFI functionality out of hooks. [Marc]
 - Add RISC-V to the fun.
 - Add all the APICv fun.

v1: https://lkml.kernel.org/r/20210925005528.1145584-1-seanjc@google.com

Paolo Bonzini (1):
  KVM: fix avic_set_running for preemptable kernels

Sean Christopherson (25):
  KVM: nVMX: Ensure vCPU honors event request if posting nested IRQ
    fails
  KVM: VMX: Clean up PI pre/post-block WARNs
  KVM: VMX: Handle PI wakeup shenanigans during vcpu_put/load
  KVM: Drop unused kvm_vcpu.pre_pcpu field
  KVM: Move x86 VMX's posted interrupt list_head to vcpu_vmx
  KVM: VMX: Move preemption timer <=> hrtimer dance to common x86
  KVM: x86: Unexport LAPIC's switch_to_{hv,sw}_timer() helpers
  KVM: x86: Remove defunct pre_block/post_block kvm_x86_ops hooks
  KVM: SVM: Signal AVIC doorbell iff vCPU is in guest mode
  KVM: SVM: Don't bother checking for "running" AVIC when kicking for
    IPIs
  KVM: SVM: Remove unnecessary APICv/AVIC update in vCPU unblocking path
  KVM: SVM: Use kvm_vcpu_is_blocking() in AVIC load to handle preemption
  KVM: SVM: Skip AVIC and IRTE updates when loading blocking vCPU
  iommu/amd: KVM: SVM: Use pCPU to infer IsRun state for IRTE
  KVM: VMX: Don't do full kick when triggering posted interrupt "fails"
  KVM: VMX: Wake vCPU when delivering posted IRQ even if vCPU == this
    vCPU
  KVM: VMX: Pass desired vector instead of bool for triggering posted
    IRQ
  KVM: VMX: Fold fallback path into triggering posted IRQ helper
  KVM: VMX: Don't do full kick when handling posted interrupt wakeup
  KVM: SVM: Drop AVIC's intermediate avic_set_running() helper
  KVM: SVM: Move svm_hardware_setup() and its helpers below svm_x86_ops
  KVM: SVM: Nullify vcpu_(un)blocking() hooks if AVIC is disabled
  KVM: x86: Skip APICv update if APICv is disable at the module level
  KVM: x86: Drop NULL check on kvm_x86_ops.check_apicv_inhibit_reasons
  KVM: x86: Unexport __kvm_request_apicv_update()

 arch/x86/include/asm/kvm-x86-ops.h |   2 -
 arch/x86/include/asm/kvm_host.h    |  12 -
 arch/x86/kvm/hyperv.c              |   3 +
 arch/x86/kvm/lapic.c               |   2 -
 arch/x86/kvm/svm/avic.c            | 116 ++++---
 arch/x86/kvm/svm/svm.c             | 479 ++++++++++++++---------------
 arch/x86/kvm/svm/svm.h             |  16 +-
 arch/x86/kvm/vmx/posted_intr.c     | 234 +++++++-------
 arch/x86/kvm/vmx/posted_intr.h     |   8 +-
 arch/x86/kvm/vmx/vmx.c             |  66 ++--
 arch/x86/kvm/vmx/vmx.h             |   3 +
 arch/x86/kvm/x86.c                 |  41 ++-
 drivers/iommu/amd/iommu.c          |   6 +-
 include/linux/amd-iommu.h          |   6 +-
 include/linux/kvm_host.h           |   3 -
 virt/kvm/kvm_main.c                |   3 -
 16 files changed, 510 insertions(+), 490 deletions(-)

-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
