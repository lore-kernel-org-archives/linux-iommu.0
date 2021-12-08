Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094DEC433EF
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:55:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA99E84B6A;
	Wed,  8 Dec 2021 01:55:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zQwkrR527pje; Wed,  8 Dec 2021 01:55:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C04A3827D9;
	Wed,  8 Dec 2021 01:55:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E733C0039;
	Wed,  8 Dec 2021 01:55:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2EE92C006E
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0F358409FA
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WOSkBdsWsxRH for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:55:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com
 [IPv6:2607:f8b0:4864:20::104a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4FC4A409F0
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:17 +0000 (UTC)
Received: by mail-pj1-x104a.google.com with SMTP id
 gf12-20020a17090ac7cc00b001a968c11642so664046pjb.4
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=iR5gsD/RoTX7Ab+ckhbUw8O3OI7/VYiJinLA00sLWPI=;
 b=WNsSNhrKWtiZPTt79yrGjP2QXJ/zO4dHXmq3vDHqWoxkLtAw17Zd8KscsmjJ5oexGb
 kAliVyZsQqhQdPrNDF3PQfsQUXNjABbMqKTfY/BVR8fXS8Rneja+8reFa1F4jOY/pcwE
 ciNn2DfNsN5BCZfZNfVggHMXqCUKq8favBTGeLtEPSZW/WIq7X2hNEVmhRguMWaIdO9s
 syVWjmq8jby34MQJXy+NvG7hmIQPQQK0w5i4VP2C4a8r84Dfz7Xux7plAzDVBCSdKRWp
 IY0wZ1LxRDp71LCRqLSV6xYBQgPTInG/LmrBIv48mELobkYVfcjaB7HqC1PidJ96oxdN
 9/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=iR5gsD/RoTX7Ab+ckhbUw8O3OI7/VYiJinLA00sLWPI=;
 b=lV9t6NyoHVzRLBt72Fhyo6/Gkfdj+gOGuhsUfSHAEJAyopiL/JMf1tucZB9PopMqxE
 pPJG7lzGbl+ASyN/gCeDu6ijaUUkZCxL7p6zKmfR5BZ0kah4tKjPPa2DyFS0wvRx3kvQ
 UO6W3db+1TtEsbpUOjlBXCP77/2xoi3t6qG/otFeKzDbl+eF6lvtFR2iom/3U0w6Uj6z
 1PVPThwbf4hM+r1W+E1oscLI+7BS+LNLv3+O2sTJnkYAjIsnIILb6t+QJ7QlkW7P6CK2
 z7FeiFxTPdrkRA0PiTTUccbOtGW0yska/yv0qWhBYpo8vJtks+71L5rtKQ8YyVK4lFD1
 zMqw==
X-Gm-Message-State: AOAM532+qz9g3xzg35sKl5aJL56bMGfYdt6rEMRZECFSWXy/NmaJwJyN
 AzEbLHVUOcrS5qCTfit00Ho6b27/9Aw=
X-Google-Smtp-Source: ABdhPJwcoBXXZdmSOghfbE08/EmszWpxoDmbsXidfNKiYXB2oVUXH7tNkAdX5obuN8xCpGSVDdPKRG2yOvc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:1913:: with SMTP id
 19mr3513966pjg.174.1638928516567; Tue, 07 Dec 2021 17:55:16 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:28 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-19-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 18/26] KVM: VMX: Pass desired vector instead of bool for
 triggering posted IRQ
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

Refactor the posted interrupt helper to take the desired notification
vector instead of a bool so that the callers are self-documenting.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0eac98589472..ff309ebe9f2c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3890,11 +3890,9 @@ static void vmx_msr_filter_changed(struct kvm_vcpu *vcpu)
 }
 
 static inline bool kvm_vcpu_trigger_posted_interrupt(struct kvm_vcpu *vcpu,
-						     bool nested)
+						     int pi_vec)
 {
 #ifdef CONFIG_SMP
-	int pi_vec = nested ? POSTED_INTR_NESTED_VECTOR : POSTED_INTR_VECTOR;
-
 	if (vcpu->mode == IN_GUEST_MODE) {
 		/*
 		 * The vector of interrupt to be delivered to vcpu had
@@ -3955,7 +3953,7 @@ static int vmx_deliver_nested_posted_interrupt(struct kvm_vcpu *vcpu,
 		smp_mb__after_atomic();
 
 		/* the PIR and ON have been set by L1. */
-		if (!kvm_vcpu_trigger_posted_interrupt(vcpu, true))
+		if (!kvm_vcpu_trigger_posted_interrupt(vcpu, POSTED_INTR_NESTED_VECTOR))
 			kvm_vcpu_wake_up(vcpu);
 		return 0;
 	}
@@ -3993,7 +3991,7 @@ static int vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector)
 	 * guaranteed to see PID.ON=1 and sync the PIR to IRR if triggering a
 	 * posted interrupt "fails" because vcpu->mode != IN_GUEST_MODE.
 	 */
-	if (!kvm_vcpu_trigger_posted_interrupt(vcpu, false))
+	if (!kvm_vcpu_trigger_posted_interrupt(vcpu, POSTED_INTR_VECTOR))
 		kvm_vcpu_wake_up(vcpu);
 
 	return 0;
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
