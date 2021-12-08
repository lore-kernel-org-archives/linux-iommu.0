Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63054C4332F
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:55:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C9BA82A5D;
	Wed,  8 Dec 2021 01:55:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BxT72b8hFCut; Wed,  8 Dec 2021 01:55:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 09E0A827D9;
	Wed,  8 Dec 2021 01:55:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2E55C0039;
	Wed,  8 Dec 2021 01:55:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6578BC0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4075A41D96
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 40qpzB1WT2hT for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:55:18 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com
 [IPv6:2607:f8b0:4864:20::449])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B601C41D99
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:18 +0000 (UTC)
Received: by mail-pf1-x449.google.com with SMTP id
 p1-20020aa79e81000000b004a82ea1b82bso713726pfq.1
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=rsEyQZ3DP35HLKbmnGk57dHMCfFGAuWmWI/6PgsECHs=;
 b=hmKYUrxitUrLwoogjptnDL/ItRNyBWfvVS9Wu829MCVieaIX/69uvnMqZoWgsv4/Sq
 KDhuHw01hnhIklE4ptBeKj3ufvxBQ4lnCrnn/qi7szxPYTTl/+WMp4gsAqmSl7HbeSxr
 Kl6Is8rRCv9pnDzLHe10jdOzymQ3C1BE7AFq3WOgNf+2dcRyiY/PMBzZLplZqf2+K1qU
 5gLqaGdirXNOKlVwItpG5Ngw09mQMVdBqSDxbAWy2O1xsdMfl4U4QGuMeO5gOJfLjjm6
 ImLq1x3TtdSq8N5XABQHSr/HqN4q3QwMqB4vnhIkvHlX932XlxC+PfHF6L36lUGb4pqn
 L2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=rsEyQZ3DP35HLKbmnGk57dHMCfFGAuWmWI/6PgsECHs=;
 b=XxbJVLkMZat0Sorz2sX9IuZovHRBGzz+lqTi52qFJhbann9G03pOLXg9yd7Np1IXdz
 bgpb7AhRgMaBe6DNP237IbYml5p9Dk7qDwwB6J3CU+XGwSgHdZOqv4dp1zyr1RRiY4Eg
 P/bORod682udivjvIJ0+2CP9790D0tyKzw7qyQjr6nihZHUzA9yxlFxAVWq7be/Agdhh
 rX7iotZ3xCT2F1rHR995UDAuUrXyVwf96WSTLH/9PPtnkNZ+P3XUPx68sWVSFh48qFgk
 KjdZZ52KFUgPkM9WOdfoGmSyH2ENb1x019G70A99FPmrhuk8NwP7raMDUu8xZALL1WdL
 jv+A==
X-Gm-Message-State: AOAM533+tojBCbp1l3i4UvxDWLXewxLPphpk0QW8L9jLXcVmRVuWlq7P
 HFzKGqqbnxn8/n2Fn8u/W3Y3kFryt7w=
X-Google-Smtp-Source: ABdhPJxc6ZNvK2ni0NY4zn1pqNTbfF6S4S3QCEyDwLu/l6woBMqErCmjW6iRbSGR/2Al2p3yHA0CHhwy/Z0=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:e810:b0:141:d8e9:a8b0
 with SMTP id
 u16-20020a170902e81000b00141d8e9a8b0mr55667312plg.9.1638928518234; Tue, 07
 Dec 2021 17:55:18 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:29 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-20-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 19/26] KVM: VMX: Fold fallback path into triggering posted
 IRQ helper
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

Move the fallback "wake_up" path into the helper to trigger posted
interrupt helper now that the nested and non-nested paths are identical.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ff309ebe9f2c..9153f5f5d424 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3889,7 +3889,7 @@ static void vmx_msr_filter_changed(struct kvm_vcpu *vcpu)
 	pt_update_intercept_for_msr(vcpu);
 }
 
-static inline bool kvm_vcpu_trigger_posted_interrupt(struct kvm_vcpu *vcpu,
+static inline void kvm_vcpu_trigger_posted_interrupt(struct kvm_vcpu *vcpu,
 						     int pi_vec)
 {
 #ifdef CONFIG_SMP
@@ -3920,10 +3920,15 @@ static inline bool kvm_vcpu_trigger_posted_interrupt(struct kvm_vcpu *vcpu,
 		 */
 
 		apic->send_IPI_mask(get_cpu_mask(vcpu->cpu), pi_vec);
-		return true;
+		return;
 	}
 #endif
-	return false;
+	/*
+	 * The vCPU isn't in the guest; wake the vCPU in case it is blocking,
+	 * otherwise do nothing as KVM will grab the highest priority pending
+	 * IRQ via ->sync_pir_to_irr() in vcpu_enter_guest().
+	 */
+	kvm_vcpu_wake_up(vcpu);
 }
 
 static int vmx_deliver_nested_posted_interrupt(struct kvm_vcpu *vcpu,
@@ -3953,8 +3958,7 @@ static int vmx_deliver_nested_posted_interrupt(struct kvm_vcpu *vcpu,
 		smp_mb__after_atomic();
 
 		/* the PIR and ON have been set by L1. */
-		if (!kvm_vcpu_trigger_posted_interrupt(vcpu, POSTED_INTR_NESTED_VECTOR))
-			kvm_vcpu_wake_up(vcpu);
+		kvm_vcpu_trigger_posted_interrupt(vcpu, POSTED_INTR_NESTED_VECTOR);
 		return 0;
 	}
 	return -1;
@@ -3991,9 +3995,7 @@ static int vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector)
 	 * guaranteed to see PID.ON=1 and sync the PIR to IRR if triggering a
 	 * posted interrupt "fails" because vcpu->mode != IN_GUEST_MODE.
 	 */
-	if (!kvm_vcpu_trigger_posted_interrupt(vcpu, POSTED_INTR_VECTOR))
-		kvm_vcpu_wake_up(vcpu);
-
+	kvm_vcpu_trigger_posted_interrupt(vcpu, POSTED_INTR_VECTOR);
 	return 0;
 }
 
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
