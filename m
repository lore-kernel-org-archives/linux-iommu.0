Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A747C433FE
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:54:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6743F82835;
	Wed,  8 Dec 2021 01:54:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AzDlxKE6N_xZ; Wed,  8 Dec 2021 01:54:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2C582826B0;
	Wed,  8 Dec 2021 01:54:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16C98C001E;
	Wed,  8 Dec 2021 01:54:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0255CC0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:54:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D8F4E41D74
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:54:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X_gh9BZcAv_s for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:54:53 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 36ED141D8C
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:54:53 +0000 (UTC)
Received: by mail-pf1-x44a.google.com with SMTP id
 p1-20020aa79e81000000b004a82ea1b82bso713174pfq.1
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=ilHbL1zM5sA2K5veDQLis+uY2bL/xuS76iOY+nyTdGE=;
 b=c5RtAmRaT2Y3w+R/IQqFpqUXhwlQrn4jp1yOv2W1qLQjnbCURiuvLhj9RrUC4pPDbo
 5FJg5WrqcsuvvIAP3hE3YxaMAhxw9Q8Oe8omOqdEOMK5a3EUFxLvxajyDi2o5F4VNuIA
 Uca6Jy4rZ9vxm9ykt1r7J3YMwFtaNOyVCsP1/xwsJ4MBBS5WPZ8oKDcTchv4BCQMmaSJ
 p005rwSoJgFECwptXyt5k7t9BvTOCFpWNxnOnI7/HLtpGX/naDKiJxhOOr6UCmhuj6mh
 OEi/V65CuC3hRc2HJmA5u1WrY5swWXD6xaEO89gSLS/yqycKxKM4g3jTVtwBi9f3ftn4
 Y8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=ilHbL1zM5sA2K5veDQLis+uY2bL/xuS76iOY+nyTdGE=;
 b=d0hTwfwioPrdGZgXiG2iIPRc95eQYabDJl6xkFS38/M30lPk1Se9nz1h+kiq5PdJ6J
 XjddwX+19gFqiF39CalSDpc2rcOY0XR6Qs0kI1IA3V7ZlstnrAJuFHl12WpEZG1KIOMQ
 aN7/xiMNkv7RRLvADoSgoNl7HH5bkAujt0E2/aUZ24036InIUTyslvNNqEm3Hv3bXHMi
 XdO02KdtluZnDbpt427Q9wTS9bY2DInf+GVAG1C+X0Qs/opWxCFvpKK8O5zWnVMyxPvv
 cWe5yC5TDnBv/DbIUpPI728meWOI6XULgmKqeg1ghkSsZIM/qcEsoEWy2UURIM8GcNMt
 mnng==
X-Gm-Message-State: AOAM530tTI9vXX1WP6TcdMtToQvUEnQkCLuC0S9F3S91wSrBR1M8IPPJ
 1X84bWS+zpTzQjtMbNAEFCwug5A/SSM=
X-Google-Smtp-Source: ABdhPJwnOpyy2IErsNWYguDbB1MXtbsLB9E0BGGdyZgI+a9yD1F7l/JjN9pIk5ij2InfTRFDZI7vKkwBraY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1486:: with SMTP id
 js6mr342723pjb.0.1638928492264; Tue, 07 Dec 2021 17:54:52 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:13 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-4-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 03/26] KVM: VMX: Clean up PI pre/post-block WARNs
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

Move the WARN sanity checks out of the PI descriptor update loop so as
not to spam the kernel log if the condition is violated and the update
takes multiple attempts due to another writer.  This also eliminates a
few extra uops from the retry path.

Technically not checking every attempt could mean KVM will now fail to
WARN in a scenario that would have failed before, but any such failure
would be inherently racy as some other agent (CPU or device) would have
to concurrent modify the PI descriptor.

Add a helper to handle the actual write and more importantly to document
why the write may need to be retried.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/posted_intr.c | 35 ++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 4db2b14ee7c6..88c53c521094 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -34,6 +34,20 @@ static inline struct pi_desc *vcpu_to_pi_desc(struct kvm_vcpu *vcpu)
 	return &(to_vmx(vcpu)->pi_desc);
 }
 
+static int pi_try_set_control(struct pi_desc *pi_desc, u64 old, u64 new)
+{
+	/*
+	 * PID.ON can be set at any time by a different vCPU or by hardware,
+	 * e.g. a device.  PID.control must be written atomically, and the
+	 * update must be retried with a fresh snapshot an ON change causes
+	 * the cmpxchg to fail.
+	 */
+	if (cmpxchg64(&pi_desc->control, old, new) != old)
+		return -EBUSY;
+
+	return 0;
+}
+
 void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	struct pi_desc *pi_desc = vcpu_to_pi_desc(vcpu);
@@ -74,8 +88,7 @@ void vmx_vcpu_pi_load(struct kvm_vcpu *vcpu, int cpu)
 
 		new.ndst = dest;
 		new.sn = 0;
-	} while (cmpxchg64(&pi_desc->control, old.control,
-			   new.control) != old.control);
+	} while (pi_try_set_control(pi_desc, old.control, new.control));
 
 after_clear_sn:
 
@@ -128,17 +141,17 @@ static void __pi_post_block(struct kvm_vcpu *vcpu)
 	if (!x2apic_mode)
 		dest = (dest << 8) & 0xFF00;
 
+	WARN(pi_desc->nv != POSTED_INTR_WAKEUP_VECTOR,
+	     "Wakeup handler not enabled while the vCPU was blocking");
+
 	do {
 		old.control = new.control = READ_ONCE(pi_desc->control);
-		WARN(old.nv != POSTED_INTR_WAKEUP_VECTOR,
-		     "Wakeup handler not enabled while the VCPU is blocked\n");
 
 		new.ndst = dest;
 
 		/* set 'NV' to 'notification vector' */
 		new.nv = POSTED_INTR_VECTOR;
-	} while (cmpxchg64(&pi_desc->control, old.control,
-			   new.control) != old.control);
+	} while (pi_try_set_control(pi_desc, old.control, new.control));
 
 	vcpu->pre_pcpu = -1;
 }
@@ -173,17 +186,15 @@ int pi_pre_block(struct kvm_vcpu *vcpu)
 		      &per_cpu(blocked_vcpu_on_cpu, vcpu->cpu));
 	spin_unlock(&per_cpu(blocked_vcpu_on_cpu_lock, vcpu->cpu));
 
+	WARN(pi_desc->sn == 1,
+	     "Posted Interrupt Suppress Notification set before blocking");
+
 	do {
 		old.control = new.control = READ_ONCE(pi_desc->control);
 
-		WARN((pi_desc->sn == 1),
-		     "Warning: SN field of posted-interrupts "
-		     "is set before blocking\n");
-
 		/* set 'NV' to 'wakeup vector' */
 		new.nv = POSTED_INTR_WAKEUP_VECTOR;
-	} while (cmpxchg64(&pi_desc->control, old.control,
-			   new.control) != old.control);
+	} while (pi_try_set_control(pi_desc, old.control, new.control));
 
 	/* We should not block the vCPU if an interrupt is posted for it.  */
 	if (pi_test_on(pi_desc))
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
