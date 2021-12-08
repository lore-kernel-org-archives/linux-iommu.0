Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9994C433F5
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9372A84B7C;
	Wed,  8 Dec 2021 01:55:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LRL57NTh7zbO; Wed,  8 Dec 2021 01:55:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 64585827D9;
	Wed,  8 Dec 2021 01:55:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EDC3C001E;
	Wed,  8 Dec 2021 01:55:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 85B4BC006E
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6838460F13
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2l5PtA8vF0YB for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:55:22 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com
 [IPv6:2607:f8b0:4864:20::449])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C730660F12
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:22 +0000 (UTC)
Received: by mail-pf1-x449.google.com with SMTP id
 c6-20020aa781c6000000b004a4fcdf1d6dso706547pfn.4
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=lSh30i++wti8tFPA9afgXl8JTEqp4ySOIwGy8kr7tR8=;
 b=Htlzvs+plCJtV9VSlYiOapDMHz3HBEbpS8QE4+92NjOXvayrW/KMXuarwtdNEXrpSX
 CQzYdPtUTaqKXHFKtWn39LWRyJsx5U5FDn/zca9RHCNWYIKcc6ekwGgXx3zNFChT39w2
 ph15CtPxFYriuAhHfTVmCm0z/pjlrfV1KY5qkZpqcgLlt/u+s9/7i4WV8RSoE5UbH7vF
 todxgJWzRlHRpkzl9dETXe5B97vq9tbL2jSOL83irp6bZgsbX0XYvqFCYxzcMplw5vri
 1X8vG/Cej3k3m0FK+GHH0XitfECppGUvIPk+wOHRA0n340lY3QJkVDF+F2Vl5lJOBcuN
 0fTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=lSh30i++wti8tFPA9afgXl8JTEqp4ySOIwGy8kr7tR8=;
 b=44NukxNGemHHiaYbxwwqM/DT2HLpBO8Cg0FNQdVVHEUgR1L4L83gp6wPmSsmuUy984
 A2qEOWtv3w/7VM6A2UKdfM2DqoXqzAk5yeyx4kCFF6m2aZiwjC6UcwqBidOwqjzlKPF8
 81mNKUSnPfNDoh/pvoucBU1SR45in++N8+HeFXKtrNSBOOJ/K5fkbp93GHcFVcbjZxy1
 hLLSZMgFUFqmMulpmCU2noSDxH8czXQY0JdDaIS7WWAQo+P+/d6TR13rHc7ZqPMiI82o
 aq5gZDVO2QrsPGwYhQ/Dp+fEuVixU5BApSJpDbbSZS/Y3oN3JikaaxxvALUcDevs15Og
 HCCQ==
X-Gm-Message-State: AOAM531FT+PatnIO7SwNkaQ6BKU9K/Bt+c87ckUuvckmIAFDNY7iAcbC
 dg5G4+aHlBv+Oti0caHF6eu+A0pUzEw=
X-Google-Smtp-Source: ABdhPJxBRvOj5N/bhP8b+AjMFz0tiJwLiByWoRzaCUE9KYasIigz5qVHTot6i47figsMioG93rRFft4c9is=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:2ec8:: with SMTP id
 h8mr3521139pjs.168.1638928522214; Tue, 07 Dec 2021 17:55:22 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:31 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-22-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 21/26] KVM: SVM: Drop AVIC's intermediate
 avic_set_running() helper
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

Drop avic_set_running() in favor of calling avic_vcpu_{load,put}()
directly, and modify the block+put path to use preempt_disable/enable()
instead of get/put_cpu(), as it doesn't actually care about the current
pCPU associated with the vCPU.  Opportunistically add lockdep assertions
as being preempted in avic_vcpu_put() would lead to consuming stale data,
even though doing so _in the current code base_ would not be fatal.

Add a much needed comment explaining why svm_vcpu_blocking() needs to
unload the AVIC and update the IRTE _before_ the vCPU starts blocking.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 50 ++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 88b3c315b34f..dd0d688bc342 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -977,6 +977,8 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	int h_physical_id = kvm_cpu_get_apicid(cpu);
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	lockdep_assert_preemption_disabled();
+
 	/*
 	 * Since the host physical APIC id is 8 bits,
 	 * we can support host APIC ID upto 255.
@@ -1010,6 +1012,8 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 	u64 entry;
 	struct vcpu_svm *svm = to_svm(vcpu);
 
+	lockdep_assert_preemption_disabled();
+
 	entry = READ_ONCE(*(svm->avic_physical_id_cache));
 
 	/* Nothing to do if IsRunning == '0' due to vCPU blocking. */
@@ -1022,31 +1026,37 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 	WRITE_ONCE(*(svm->avic_physical_id_cache), entry);
 }
 
-/*
- * This function is called during VCPU halt/unhalt.
- */
-static void avic_set_running(struct kvm_vcpu *vcpu, bool is_run)
-{
-	int cpu = get_cpu();
-
-	WARN_ON(cpu != vcpu->cpu);
-
-	if (kvm_vcpu_apicv_active(vcpu)) {
-		if (is_run)
-			avic_vcpu_load(vcpu, cpu);
-		else
-			avic_vcpu_put(vcpu);
-	}
-	put_cpu();
-}
-
 void svm_vcpu_blocking(struct kvm_vcpu *vcpu)
 {
-	avic_set_running(vcpu, false);
+	if (!kvm_vcpu_apicv_active(vcpu))
+		return;
+
+	preempt_disable();
+
+	/*
+	 * Unload the AVIC when the vCPU is about to block, _before_ the vCPU
+	 * actually blocks.  The vCPU needs to be marked IsRunning=0 before the
+	 * final pass over the vIRR via kvm_vcpu_check_block().  Any IRQs that
+	 * arrive before IsRunning=0 will not signal the doorbell, i.e. it's
+	 * KVM's responsibility to ensure there are no pending IRQs in the vIRR
+	 * after IsRunning is cleared, prior to scheduling out the vCPU.
+	 */
+	avic_vcpu_put(vcpu);
+
+	preempt_enable();
 }
 
 void svm_vcpu_unblocking(struct kvm_vcpu *vcpu)
 {
+	int cpu;
 
-	avic_set_running(vcpu, true);
+	if (!kvm_vcpu_apicv_active(vcpu))
+		return;
+
+	cpu = get_cpu();
+	WARN_ON(cpu != vcpu->cpu);
+
+	avic_vcpu_load(vcpu, cpu);
+
+	put_cpu();
 }
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
