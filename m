Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A59C433F5
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 563B560F19;
	Wed,  8 Dec 2021 01:55:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BxisL98aNi4P; Wed,  8 Dec 2021 01:55:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3CF0460F0B;
	Wed,  8 Dec 2021 01:55:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8423C0012;
	Wed,  8 Dec 2021 01:55:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65E9FC0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5452C409F4
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dlDN-61DbZgx for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:55:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com
 [IPv6:2607:f8b0:4864:20::449])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 87FC9409F0
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:13 +0000 (UTC)
Received: by mail-pf1-x449.google.com with SMTP id
 4-20020a621604000000b004a4ab765028so683523pfw.13
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=X7msKu2GVp9E0ZpcDJCdOmGYb8rkZCL+gG+mH7XwWxU=;
 b=MGCS3s5h+GUbkgbaytoK6R5wN1WpbpF8O5CZTZYFVIUfvB0My+TiFlx0/zyrqez/ev
 tXeDJh6olo1GekmGi8gOMvHQHaqhjuZhoP7yDY0VB11bJBkq349WsBPHBNDAsJxkm29J
 SRrd3q67wwtmHgE5CW+pxL+yZ0oZGMJQO3xu8Q6871L1t5JCCKjUNCUxJMrA2iGJFcQG
 2XixkIdqSCM5nqc6GTG+rOUyGEP6pGfSIf9Bt+e+v+n8HnSnCpTUyfWUu8U1dnhN5x+p
 /s9gKdYQQbGKQP9cZxAzusWXegQcDb4Vvl2nh+kWm9bQIzlchxvuMT9i3eGafh5eWnsS
 As3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=X7msKu2GVp9E0ZpcDJCdOmGYb8rkZCL+gG+mH7XwWxU=;
 b=A4+Gfb6NUteu1GqHQs2Uj2+zHWL75xk5SnbEiVM6zjhu+mq/jGixEVpJQ9QJn3p7ai
 txkjP86wkC1IL8ZPg/JTdt1kf8IuFVKaNw8Qn9VBYlnkJWKk5W26TK3qoqbR9CkpM8Bh
 99jKgR2xrq0vSvqB8JrYXxzTYsZRYlvRE/Ll6tM+NUKnEBKcyhu7xvlLLhNBujQnxbPI
 +pJ/XkBjMFdk31I12fXXkAsHx2Z2SYoCoFofEeNjXR60m+i6bH2sZEVcoYCA0yJEudF3
 nfcGt8onvrvbsrTzCNgu9U5geA7BG1Do/z1Y8bDWhddU6dPeHJEwBSB9I80Wl/Pr6kJk
 1E/w==
X-Gm-Message-State: AOAM533AOZc7abJv9syrSgsGyzITlDm6jNMNcxzaJtC3Z4qRcmcsN7RT
 6CbYVDl27+omi1jLvCNQ2S5oQ/USk2Q=
X-Google-Smtp-Source: ABdhPJwwd8WUavyXWkw+OViuN+eQTI5AawYBwATEwNoGUp+lxKsz+H67sWAVn33+UEgO/j7hG//O4mVszWM=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e07:: with SMTP id
 pg7mr3527958pjb.185.1638928512956; Tue, 07 Dec 2021 17:55:12 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:26 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-17-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 16/26] KVM: VMX: Don't do full kick when triggering posted
 interrupt "fails"
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

Replace the full "kick" with just the "wake" in the fallback path when
triggering a virtual interrupt via a posted interrupt fails because the
guest is not IN_GUEST_MODE.  If the guest transitions into guest mode
between the check and the kick, then it's guaranteed to see the pending
interrupt as KVM syncs the PIR to IRR (and onto GUEST_RVI) after setting
IN_GUEST_MODE.  Kicking the guest in this case is nothing more than an
unnecessary VM-Exit (and host IRQ).

Opportunistically update comments to explain the various ordering rules
and barriers at play.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 4 ++--
 arch/x86/kvm/x86.c     | 9 +++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 1b8804d93776..fa90eacbf7e2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3956,7 +3956,7 @@ static int vmx_deliver_nested_posted_interrupt(struct kvm_vcpu *vcpu,
 
 		/* the PIR and ON have been set by L1. */
 		if (!kvm_vcpu_trigger_posted_interrupt(vcpu, true))
-			kvm_vcpu_kick(vcpu);
+			kvm_vcpu_wake_up(vcpu);
 		return 0;
 	}
 	return -1;
@@ -3995,7 +3995,7 @@ static int vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector)
 	 */
 	if (vcpu != kvm_get_running_vcpu() &&
 	    !kvm_vcpu_trigger_posted_interrupt(vcpu, false))
-		kvm_vcpu_kick(vcpu);
+		kvm_vcpu_wake_up(vcpu);
 
 	return 0;
 }
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4a2341e4ff30..abf99b77883e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9887,10 +9887,11 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	smp_mb__after_srcu_read_unlock();
 
 	/*
-	 * This handles the case where a posted interrupt was
-	 * notified with kvm_vcpu_kick.  Assigned devices can
-	 * use the POSTED_INTR_VECTOR even if APICv is disabled,
-	 * so do it even if !kvm_vcpu_apicv_active(vcpu).
+	 * Process pending posted interrupts to handle the case where the
+	 * notification IRQ arrived in the host, or was never sent (because the
+	 * target vCPU wasn't running).  Do this regardless of the vCPU's APICv
+	 * status, KVM doesn't update assigned devices when APICv is inhibited,
+	 * i.e. they can post interrupts even if APICv is temporarily disabled.
 	 */
 	if (kvm_lapic_enabled(vcpu))
 		static_call_cond(kvm_x86_sync_pir_to_irr)(vcpu);
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
