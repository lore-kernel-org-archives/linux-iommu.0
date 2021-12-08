Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C999C4332F
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:55:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1207A409FE;
	Wed,  8 Dec 2021 01:55:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JkFFarGBeN6y; Wed,  8 Dec 2021 01:55:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B65EC409BF;
	Wed,  8 Dec 2021 01:55:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F9D2C001E;
	Wed,  8 Dec 2021 01:55:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2253EC001E
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C93DE409EE
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2cxFtTBUyILD for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:55:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com
 [IPv6:2607:f8b0:4864:20::549])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ECAAF409F8
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:25 +0000 (UTC)
Received: by mail-pg1-x549.google.com with SMTP id
 d2-20020a656202000000b00325603f7d0bso433100pgv.12
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=zMqSw9DjsctvX2kHjzsjMwRHpb1qJqGe5cba6m1kl4s=;
 b=SGoA9JReTHagmcuj4wdk6JIDMU3iSsEWgylUiO0/XB4jaezJSuiFhkzeR/n1JIQdiw
 rgX8vkf/9pt/W30P5NvLEqoR2I77x3O3aNxligZRhbb6pcn3jJfp28Tx5X+6kiCHzKum
 fDnFkxpLBYjjc7d4ewYMyLMdpXnBypZE6KaEah1iOnRsp6HWj2Q08bphnl13hb+sh5pe
 GbtrDPgtdV6D9XC+okWYuxegfA869PT4dsbOAGBhDzfr+y1I9PcPvZId4tcy3dQ8brw2
 /oUSrIPXD+UYD5+zduLQOvOcgkt8bnvQ9uyi9J4nJGKY7fIW4zFDRSOkRL1QVBMMJird
 GVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=zMqSw9DjsctvX2kHjzsjMwRHpb1qJqGe5cba6m1kl4s=;
 b=uov6qwtfAcOP8nt3fF22jxhCM9VXnlIRs2+Qdj/3cqcDXWHJGLXsqRGW9rbtOZLtyz
 oo46FzlD6ZNHfLHpJXkQj6rgAoej67iZJSQ7g/eNgrLtPvzC0rSEXduyHN3CnJ+SKhrh
 Y1ErCWCC39VGTTk55BWUEI8YHNquJC3rx0Vrfxq7sNM/j51MxCWAC8ty1QDUrwikYnFG
 IAh3igIHU6VG4rYRgcFz6JAJ6gGBDMBZjhAEktDnm2W7EyWPhwc767unCcslDMqntaCy
 36Qbyin1m+F8zUvT/HT0o4k999ko7k9DpOIKc4GBltSVSe5NgkgvFD8+aNhzJo1h8vaP
 LhFg==
X-Gm-Message-State: AOAM532t3VRugtyMDN2JFKal24TdjPf48gHTsbv8I/z15P+ZqDtXLxRo
 1iJxEO+6ifMcr7/ziDQWbKRJPYdIQMY=
X-Google-Smtp-Source: ABdhPJx/DCvh/0By4lkVe+LvL+R6Uz52EC3FR3J8mjqoo2v1YJZTtqCtNOkmuVRMivr6qzF1Mg4BXJiztRA=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a63:751a:: with SMTP id
 q26mr22763534pgc.529.1638928525427; 
 Tue, 07 Dec 2021 17:55:25 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:33 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-24-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 23/26] KVM: SVM: Nullify vcpu_(un)blocking() hooks if AVIC
 is disabled
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

Nullify svm_x86_ops.vcpu_(un)blocking if AVIC/APICv is disabled as the
hooks are necessary only to clear the vCPU's IsRunning entry in the
Physical APIC and to update IRTE entries if the VM has a pass-through
device attached.

Opportunistically rename the helpers to clarify their AVIC relationship.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 4 ++--
 arch/x86/kvm/svm/svm.c  | 7 +++++--
 arch/x86/kvm/svm/svm.h  | 4 ++--
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index dd0d688bc342..26ed5325c593 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -1026,7 +1026,7 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 	WRITE_ONCE(*(svm->avic_physical_id_cache), entry);
 }
 
-void svm_vcpu_blocking(struct kvm_vcpu *vcpu)
+void avic_vcpu_blocking(struct kvm_vcpu *vcpu)
 {
 	if (!kvm_vcpu_apicv_active(vcpu))
 		return;
@@ -1046,7 +1046,7 @@ void svm_vcpu_blocking(struct kvm_vcpu *vcpu)
 	preempt_enable();
 }
 
-void svm_vcpu_unblocking(struct kvm_vcpu *vcpu)
+void avic_vcpu_unblocking(struct kvm_vcpu *vcpu)
 {
 	int cpu;
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 98f7c454a784..e57e6857e063 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4370,8 +4370,8 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
 	.prepare_guest_switch = svm_prepare_guest_switch,
 	.vcpu_load = svm_vcpu_load,
 	.vcpu_put = svm_vcpu_put,
-	.vcpu_blocking = svm_vcpu_blocking,
-	.vcpu_unblocking = svm_vcpu_unblocking,
+	.vcpu_blocking = avic_vcpu_blocking,
+	.vcpu_unblocking = avic_vcpu_unblocking,
 
 	.update_exception_bitmap = svm_update_exception_bitmap,
 	.get_msr_feature = svm_get_msr_feature,
@@ -4658,6 +4658,9 @@ static __init int svm_hardware_setup(void)
 		pr_info("AVIC enabled\n");
 
 		amd_iommu_register_ga_log_notifier(&avic_ga_log_notifier);
+	} else {
+		svm_x86_ops.vcpu_blocking = NULL;
+		svm_x86_ops.vcpu_unblocking = NULL;
 	}
 
 	if (vls) {
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 83ced47fa9b9..daa8ca84afcc 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -593,8 +593,8 @@ int svm_deliver_avic_intr(struct kvm_vcpu *vcpu, int vec);
 bool svm_dy_apicv_has_pending_interrupt(struct kvm_vcpu *vcpu);
 int svm_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
 		       uint32_t guest_irq, bool set);
-void svm_vcpu_blocking(struct kvm_vcpu *vcpu);
-void svm_vcpu_unblocking(struct kvm_vcpu *vcpu);
+void avic_vcpu_blocking(struct kvm_vcpu *vcpu);
+void avic_vcpu_unblocking(struct kvm_vcpu *vcpu);
 
 /* sev.c */
 
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
