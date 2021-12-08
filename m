Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821A7C433FE
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:54:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1D39041D74;
	Wed,  8 Dec 2021 01:54:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wfvbf5A5kRZM; Wed,  8 Dec 2021 01:54:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 125D141D8A;
	Wed,  8 Dec 2021 01:54:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5B81C001E;
	Wed,  8 Dec 2021 01:54:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E681EC0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:54:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CEB9F827D9
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:54:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id owbVP9IXxLO0 for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:54:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com
 [IPv6:2607:f8b0:4864:20::54a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4027C82784
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:54:51 +0000 (UTC)
Received: by mail-pg1-x54a.google.com with SMTP id
 i12-20020a63584c000000b00330ec6e2c37so443390pgm.7
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=dJfQR7SNrodeHl+1uM4QnaH90bN7dxbb2nVm/KO0Fr0=;
 b=E6q7ZoNKap3puayKpMyApx5aMM7cpIA29jNBAm9RU9qZ2GsBRZJfo9m90cE5YibjKS
 /Oqgenvs55WfnwkYUvBoCk+My3oUfiaTjkyMxYFWO3kk1h8G8HtGhEo6Irx/isGI39P8
 YAupJ+v5JJALrli/83tKDSLpVhDiUSKDU/wVs7ag7lbqCuykiVB1elNOTh55hiyT8D9v
 jmnX+mcFaHf8KkrFeSKV3qxr2kd4tBBqfQlKRW6eshGxdpztNEqJsQJh8QwW4i9TNc0q
 rlqaM09jieisbicgfB7o9jhF24ra4lV3zdBRr9IhEOVwZ6sT5TUz2j1F46A73P/S5cS7
 l4RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=dJfQR7SNrodeHl+1uM4QnaH90bN7dxbb2nVm/KO0Fr0=;
 b=IMmqhBbHu6yIF+k+kEyJEv/ymimBACnylWBagwF3gJAsobE+VfAGbew258sLyYRk9Y
 DdH1BQ0SHfiB7jOBkgQ7klIL1EjY74xvKhIN/YPJ4xStQVIoibXuE6pwZ1VkgDcUh3eH
 x0k5Hx2hcXJe3bpKZcfNOHr2LmZ2Kdn5ECZbCtXSvwnpR8nEwZSqFh+b6HnnCH31JJp3
 90caMWAQR1DaCcWtC5t31Scv/GBeZ7WsYIxVuRQEKyAw2F9GrsTnuC1uG5GtpUNkj9nW
 LjXR2Lxbf1MPbJ78IUnUdFdtQOWOSJZD3mdzQGUBI7bluhXS3kLYlCkQKsJyiH7vxKGD
 l5fA==
X-Gm-Message-State: AOAM532esDLr5kfVLIwAOtiJcQ3muvssoxb7RU4dzWvIyj/iRaF5YGrW
 bSBMOQex5KAdvE5k3JsAPksGgkuwZ+I=
X-Google-Smtp-Source: ABdhPJzRAo1jT1w67ssZL5EULvdAsrstbRdTXsE4od1JORZJT4BANLfRDFxRIq1Nz+VdNTWiu5B+Wyay4gI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:300d:b0:142:744f:c74d
 with SMTP id
 o13-20020a170903300d00b00142744fc74dmr56964166pla.26.1638928490614; Tue, 07
 Dec 2021 17:54:50 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:12 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-3-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 02/26] KVM: nVMX: Ensure vCPU honors event request if
 posting nested IRQ fails
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

Add a memory barrier between writing vcpu->requests and reading
vcpu->guest_mode to ensure the read is ordered after the write when
(potentially) delivering an IRQ to L2 via nested posted interrupt.  If
the request were to be completed after reading vcpu->mode, it would be
possible for the target vCPU to enter the guest without posting the
interrupt and without handling the event request.

Note, the barrier is only for documentation since atomic operations are
serializing on x86.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Fixes: 6b6977117f50 ("KVM: nVMX: Fix races when sending nested PI while dest enters/leaves L2")
Fixes: 705699a13994 ("KVM: nVMX: Enable nested posted interrupt processing")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index efcc5a58abbc..a94f0fb80fd4 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3941,6 +3941,19 @@ static int vmx_deliver_nested_posted_interrupt(struct kvm_vcpu *vcpu,
 		 */
 		vmx->nested.pi_pending = true;
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
+
+		/*
+		 * This pairs with the smp_mb_*() after setting vcpu->mode in
+		 * vcpu_enter_guest() to guarantee the vCPU sees the event
+		 * request if triggering a posted interrupt "fails" because
+		 * vcpu->mode != IN_GUEST_MODE.  The extra barrier is needed as
+		 * the smb_wmb() in kvm_make_request() only ensures everything
+		 * done before making the request is visible when the request
+		 * is visible, it doesn't ensure ordering between the store to
+		 * vcpu->requests and the load from vcpu->mode.
+		 */
+		smp_mb__after_atomic();
+
 		/* the PIR and ON have been set by L1. */
 		if (!kvm_vcpu_trigger_posted_interrupt(vcpu, true))
 			kvm_vcpu_kick(vcpu);
@@ -3974,6 +3987,12 @@ static int vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector)
 	if (pi_test_and_set_on(&vmx->pi_desc))
 		return 0;
 
+	/*
+	 * The implied barrier in pi_test_and_set_on() pairs with the smp_mb_*()
+	 * after setting vcpu->mode in vcpu_enter_guest(), thus the vCPU is
+	 * guaranteed to see PID.ON=1 and sync the PIR to IRR if triggering a
+	 * posted interrupt "fails" because vcpu->mode != IN_GUEST_MODE.
+	 */
 	if (vcpu != kvm_get_running_vcpu() &&
 	    !kvm_vcpu_trigger_posted_interrupt(vcpu, false))
 		kvm_vcpu_kick(vcpu);
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
