Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0544C433F5
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 59A2B409ED;
	Wed,  8 Dec 2021 01:55:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iWeq3Xp7qB-A; Wed,  8 Dec 2021 01:55:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B4599409EC;
	Wed,  8 Dec 2021 01:55:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 97889C006E;
	Wed,  8 Dec 2021 01:55:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F8D5C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C2D8409C5
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aTdfgLTKNxvQ for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:55:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com
 [IPv6:2607:f8b0:4864:20::1049])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 562D8409F1
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:04 +0000 (UTC)
Received: by mail-pj1-x1049.google.com with SMTP id
 jx2-20020a17090b46c200b001a62e9db321so655876pjb.7
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=ubKaUKBLNmscD+a3SeZQyfO/SnsUn3R2x3pqUaMRRWU=;
 b=q4lQsDkJTgHl+2yoht+vVP93CTkCaT7wE7IowKnCX3k4dPDPnMAs3X37zJQUbFaU3c
 1iCMHxZl55owo9ie7mhUk9qQ4Zj66LOwfh5wXj/X6YGoHRyUh3f1FK+NwsZTEoCb8V18
 Ov7OSrf1k5AqUoHUra7Wf/g8YNPefJgqWdUUxn9LcyjXh8DYd0GVr2qqfZmhw8Q9kYRR
 GHZOeaWcS3SgKjstJ6jA9kWWfjSMWNzYxuqhaivzcza5fFyKXi+MFSeD1pdyUP0G9ADD
 4aw7KNThSCq4y59OELcH/eh/2XBvXlf7ep28ZCvariMiVZ7oCMqO0am08ZI95LMdoCvb
 uGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=ubKaUKBLNmscD+a3SeZQyfO/SnsUn3R2x3pqUaMRRWU=;
 b=dqxHkTQ0nOTIsm4kUnq5dPbG2a/8jeiFbiFQN+ztIeRgNpexkrKFxDUMbAFwIMs3S3
 y4raIBn+3gR0eF9wefcf3JTjMal+8Mn6Zh/bB87qt2KN1rjCHRsv0a/eStuEAq6OLDww
 OaJSmo5hkmvJvCjSOYivdVrz/JhcVFHexybV5+gBlSIXsM1qIBaVSeAhlubywi5wbe/u
 nViEOnvZS0/3x7Dsm8KybndUR1F46HyDESUrpvdrhfFI/cUQFZrdn/x1roJ3ec2dS8vJ
 aa7zn7AVpt6xm1dCZLmojtIjtQedpxmiHuMKbThq4KL7na4ulJK9ooHHpg8BAnbnJnCR
 pvXg==
X-Gm-Message-State: AOAM530O4srqsDcOzXnUvuZeGmP3wrBCozhSfJNEOfyk3dFOFJUEsjkc
 x2DmUP+0H74TOEmMqTJTVmEM7qavvOk=
X-Google-Smtp-Source: ABdhPJx04oxzGnbwJs3aAuGW/R98Z2oolg+A8xq1n3WCg/qpbISnK5Yk2KiQTm+tvTeNHqYR7nJq0yfT7fY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:aa7:9004:0:b0:4a2:e58e:9442 with
 SMTP id
 m4-20020aa79004000000b004a2e58e9442mr2949977pfo.24.1638928503771; Tue, 07 Dec
 2021 17:55:03 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:20 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-11-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 10/26] KVM: SVM: Signal AVIC doorbell iff vCPU is in guest
 mode
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

Signal the AVIC doorbell iff the vCPU is running in the guest.  If the vCPU
is not IN_GUEST_MODE, it's guaranteed to pick up any pending IRQs on the
next VMRUN, which unconditionally processes the vIRR.

Add comments to document the logic.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index d7132a4551a2..e2e4e9f04458 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -672,9 +672,22 @@ int svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
 		return -1;
 
 	kvm_lapic_set_irr(vec, vcpu->arch.apic);
+
+	/*
+	 * Pairs with the smp_mb_*() after setting vcpu->guest_mode in
+	 * vcpu_enter_guest() to ensure the write to the vIRR is ordered before
+	 * the read of guest_mode, which guarantees that either VMRUN will see
+	 * and process the new vIRR entry, or that the below code will signal
+	 * the doorbell if the vCPU is already running in the guest.
+	 */
 	smp_mb__after_atomic();
 
-	if (avic_vcpu_is_running(vcpu)) {
+	/*
+	 * Signal the doorbell to tell hardware to inject the IRQ if the vCPU
+	 * is in the guest.  If the vCPU is not in the guest, hardware will
+	 * automatically process AVIC interrupts at VMRUN.
+	 */
+	if (vcpu->mode == IN_GUEST_MODE) {
 		int cpu = READ_ONCE(vcpu->cpu);
 
 		/*
@@ -688,8 +701,13 @@ int svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec)
 		if (cpu != get_cpu())
 			wrmsrl(SVM_AVIC_DOORBELL, kvm_cpu_get_apicid(cpu));
 		put_cpu();
-	} else
+	} else {
+		/*
+		 * Wake the vCPU if it was blocking.  KVM will then detect the
+		 * pending IRQ when checking if the vCPU has a wake event.
+		 */
 		kvm_vcpu_wake_up(vcpu);
+	}
 
 	return 0;
 }
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
