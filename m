Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8C4C4332F
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:55:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4619241D74;
	Wed,  8 Dec 2021 01:55:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JCL6SNkp2bwI; Wed,  8 Dec 2021 01:55:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2FF9341D8E;
	Wed,  8 Dec 2021 01:55:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0B22C001E;
	Wed,  8 Dec 2021 01:55:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52C15C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 42041824EE
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AOjj6iywQAs3 for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:54:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AC33582660
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:54:59 +0000 (UTC)
Received: by mail-pl1-x649.google.com with SMTP id
 i3-20020a170902c94300b0014287dc7dcbso265223pla.16
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=1/Aw66oshUqg3ESqwspg+eXMi1ISq9b769Ix+vUef7Y=;
 b=Lo5e73zH8YgqQRvRWdIZEl/+aocgwtcCYU4og8Zkd2L/EebAc3UWDKdnuLWnEpoBuV
 cMh6A5AKunoPNTpu5/ZTp0vYASWYw+5Dl6dc2JzhKhfmdqGzZzo/u8zz0UX9b0mwj7aI
 OzXzByONVRk6LSETTmsSMAhP+CR2a6lyT3qCjYe+Owpom2u6mVnZrcnrV+KH1BgsyCWQ
 dZhBgaJzAi7mPEgFpMy2yNh4zSpw/iRWED1iWxMTbxIuoW0NIKmWLH3SKe0Z74vxqTym
 1ImbI/wehmcCIhvB2MvXEma6XSV7g/9zW4eweepUCs+ltwg5JeuoH6HyzvVhQROdRsRn
 gTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=1/Aw66oshUqg3ESqwspg+eXMi1ISq9b769Ix+vUef7Y=;
 b=ze9nDp0lfBtqjPr3LP8RToEdhMnQtW62QDemdgSKAC06Zf2gAvAGkfwsYX+Z/ZX+FR
 u2O5/9XsKy+5cenbFbYAtF2vl7Ok9yIfnL0fnxfejjCMHSZOutRwgy73m9DafkwHRjsk
 m17qY+w9t9paG5m3Cd+xBudMvPNELTgf7uGMDQcUrH9sAkld9vKFOqTvSjPsZ5XBIq7c
 r9CxlVVvLGB/NgF74y4SlosMMHx8PWzirSY8rufT5lmM8qKLAQw75JGMWqHuMXjRb+xI
 5pno8Wrj9tM9e8OEyH0spF/52tNVhDP9tU3DtyspGyxR89PNI7FiuupSyCBq3eY3mhVW
 QDgw==
X-Gm-Message-State: AOAM532Ce2plCuE/bAcZ3okR8SFRZ76ZgaoiDGMKBV98OpZ25M+bNFCH
 /Z9+oZrsmg5HyDoZZFH57psdjBa8G/4=
X-Google-Smtp-Source: ABdhPJyv4xcQqlmYYSltg7TnDvcTBERE1HFhlxtZo3nTa9A4jlHdI79RblIzvi3U6LiFmiXsfhFdaYs5EKw=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:c541:0:b0:4ad:561a:5b6c with
 SMTP id
 j62-20020a62c541000000b004ad561a5b6cmr2897540pfg.48.1638928499087; Tue, 07
 Dec 2021 17:54:59 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:17 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-8-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 07/26] KVM: VMX: Move preemption timer <=> hrtimer dance to
 common x86
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

Handle the switch to/from the hypervisor/software timer when a vCPU is
blocking in common x86 instead of in VMX.  Even though VMX is the only
user of a hypervisor timer, the logic and all functions involved are
generic x86 (unless future CPUs do something completely different and
implement a hypervisor timer that runs regardless of mode).

Handling the switch in common x86 will allow for the elimination of the
pre/post_blocks hooks, and also lets KVM switch back to the hypervisor
timer if and only if it was in use (without additional params).  Add a
comment explaining why the switch cannot be deferred to kvm_sched_out()
or kvm_vcpu_block().

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c |  6 +-----
 arch/x86/kvm/x86.c     | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 64932cc3e4e8..a5ba9a069f5d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7444,16 +7444,12 @@ void vmx_update_cpu_dirty_logging(struct kvm_vcpu *vcpu)
 
 static int vmx_pre_block(struct kvm_vcpu *vcpu)
 {
-	if (kvm_lapic_hv_timer_in_use(vcpu))
-		kvm_lapic_switch_to_sw_timer(vcpu);
-
 	return 0;
 }
 
 static void vmx_post_block(struct kvm_vcpu *vcpu)
 {
-	if (kvm_x86_ops.set_hv_timer)
-		kvm_lapic_switch_to_hv_timer(vcpu);
+
 }
 
 static void vmx_setup_mce(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a05a26471f19..f13a61830d9d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10041,8 +10041,21 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 static inline int vcpu_block(struct kvm *kvm, struct kvm_vcpu *vcpu)
 {
+	bool hv_timer;
+
 	if (!kvm_arch_vcpu_runnable(vcpu) &&
 	    (!kvm_x86_ops.pre_block || static_call(kvm_x86_pre_block)(vcpu) == 0)) {
+		/*
+		 * Switch to the software timer before halt-polling/blocking as
+		 * the guest's timer may be a break event for the vCPU, and the
+		 * hypervisor timer runs only when the CPU is in guest mode.
+		 * Switch before halt-polling so that KVM recognizes an expired
+		 * timer before blocking.
+		 */
+		hv_timer = kvm_lapic_hv_timer_in_use(vcpu);
+		if (hv_timer)
+			kvm_lapic_switch_to_sw_timer(vcpu);
+
 		srcu_read_unlock(&kvm->srcu, vcpu->srcu_idx);
 		if (vcpu->arch.mp_state == KVM_MP_STATE_HALTED)
 			kvm_vcpu_halt(vcpu);
@@ -10050,6 +10063,9 @@ static inline int vcpu_block(struct kvm *kvm, struct kvm_vcpu *vcpu)
 			kvm_vcpu_block(vcpu);
 		vcpu->srcu_idx = srcu_read_lock(&kvm->srcu);
 
+		if (hv_timer)
+			kvm_lapic_switch_to_hv_timer(vcpu);
+
 		if (kvm_x86_ops.post_block)
 			static_call(kvm_x86_post_block)(vcpu);
 
@@ -10244,6 +10260,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 			r = -EINTR;
 			goto out;
 		}
+		/*
+		 * It should be impossible for the hypervisor timer to be in
+		 * use before KVM has ever run the vCPU.
+		 */
+		WARN_ON_ONCE(kvm_lapic_hv_timer_in_use(vcpu));
 		kvm_vcpu_block(vcpu);
 		if (kvm_apic_accept_events(vcpu) < 0) {
 			r = 0;
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
