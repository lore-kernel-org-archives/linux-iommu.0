Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E76C433F5
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:55:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BBCF141D96;
	Wed,  8 Dec 2021 01:55:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b3A0U2plTp0w; Wed,  8 Dec 2021 01:55:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9DA9041D93;
	Wed,  8 Dec 2021 01:55:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D640C006F;
	Wed,  8 Dec 2021 01:55:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 122E7C0012
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AFFF941D72
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kfwIC2VQKAxV for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:55:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com
 [IPv6:2607:f8b0:4864:20::649])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2AC1E41D8E
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:09 +0000 (UTC)
Received: by mail-pl1-x649.google.com with SMTP id
 p24-20020a170902a41800b001438d6c7d71so283628plq.7
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=RN6WvHTMttYY9G5+WvO2UU4giOt+jhBO4kXUEfmjbVY=;
 b=ijxneh9EkX++RC8ZhHk1tJ6Zb7Yu7HTQmaTahYE7i+pCeGF9EJyb/lDqHnBsFGQJEV
 ApQmbD5s1JrNnOUCGtZH31rfODOPlzdq3Bb1hGUJTcSrfxvdL4uo9q05pattTdOrzJap
 /5XtsoYPuaiqXyhPY1u0N98R/HLDsAJv9sVcP+WFDb79RlMa6TiYUK7Gn1j0lZ00Ge/+
 afrk3KdsTr2cZUjjuuhZnaLzF1TEjhdV/RMGHJTzer0BsCZyFzHAWKzuplz/wKHRBKmv
 BxmJY04YnT5H8pRaGZeFejAdPOShDbmHQcURiEW0cVjT9L7VIL0fdrBkbHgfHnx7V4uD
 fmog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=RN6WvHTMttYY9G5+WvO2UU4giOt+jhBO4kXUEfmjbVY=;
 b=gBiF0yUrPcrXDj5hsnMmniDh7ed7vactJgFavtGF/QqM3Ci7OmnJTlIbjme1PQsORP
 sZcY9+H0LN7jYDADmCxpzbS074ONOpwnnzlO95Hgjtqbxk1LpVw31riBSXSt7UkX3qca
 uGFHAN1nJGLTXwYDSaG7PNjlblFQt2SkLw1zWdKHy3ApeJdNstdyHFXnzVP2ViWeA8uo
 kx3iLJYtLXG8ZbFtQ+vb6oXeLkwcfJJ8VQrGqgjPJGT80y0FJfrZ5W+AJFcyA/2o7jNY
 KfYPo91I0EES1GaTfYkKlHjrzcKi5KKdrJTPUHXQeY1JcBnu+aQklXiUNd6fMIiAZmid
 VnCA==
X-Gm-Message-State: AOAM531gS73LoQA/XaxF43/sejfgiU4SOHA83E6LkggQLQJT2z4aqNId
 XqAtbxjwsaICausr3ojQx1cr0RFIK/4=
X-Google-Smtp-Source: ABdhPJwpV9KyfQg8BjQExB6hqkzZypTPztaQh+jY5QSQJCH5c9MrySGkChv+eh0Hm/a7Q2Bxuo/M4x5RTYI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a63:bf4a:: with SMTP id
 i10mr26354995pgo.196.1638928508625; 
 Tue, 07 Dec 2021 17:55:08 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:23 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-14-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 13/26] KVM: SVM: Use kvm_vcpu_is_blocking() in AVIC load to
 handle preemption
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

Use kvm_vcpu_is_blocking() to determine whether or not the vCPU should be
marked running during avic_vcpu_load().  Drop avic_is_running, which
really should have been named "vcpu_is_not_blocking", as it tracked if
the vCPU was blocking, not if it was actually running, e.g. it was set
during svm_create_vcpu() when the vCPU was obviously not running.

This is technically a teeny tiny functional change, as the vCPU will be
marked IsRunning=1 on being reloaded if the vCPU is preempted between
svm_vcpu_blocking() and prepare_to_rcuwait().  But that's a benign change
as the vCPU will be marked IsRunning=0 when KVM voluntarily schedules out
the vCPU.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 14 +++++++++-----
 arch/x86/kvm/svm/svm.c  |  6 ------
 arch/x86/kvm/svm/svm.h  |  1 -
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 16e4ebd980a2..dc0cbe500106 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -974,6 +974,7 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	u64 entry;
 	/* ID = 0xff (broadcast), ID > 0xff (reserved) */
+	bool is_blocking = kvm_vcpu_is_blocking(vcpu);
 	int h_physical_id = kvm_cpu_get_apicid(cpu);
 	struct vcpu_svm *svm = to_svm(vcpu);
 
@@ -991,12 +992,17 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	entry |= (h_physical_id & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK);
 
 	entry &= ~AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
-	if (svm->avic_is_running)
+
+	/*
+	 * Don't mark the vCPU as running if its blocking, i.e. if the vCPU is
+	 * preempted after svm_vcpu_blocking() but before KVM voluntarily
+	 * schedules out the vCPU.
+	 */
+	if (!is_blocking)
 		entry |= AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
 
 	WRITE_ONCE(*(svm->avic_physical_id_cache), entry);
-	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id,
-					svm->avic_is_running);
+	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, !is_blocking);
 }
 
 void avic_vcpu_put(struct kvm_vcpu *vcpu)
@@ -1017,11 +1023,9 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
  */
 static void avic_set_running(struct kvm_vcpu *vcpu, bool is_run)
 {
-	struct vcpu_svm *svm = to_svm(vcpu);
 	int cpu = get_cpu();
 
 	WARN_ON(cpu != vcpu->cpu);
-	svm->avic_is_running = is_run;
 
 	if (kvm_vcpu_apicv_active(vcpu)) {
 		if (is_run)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 208566f63bce..dde0106ffc47 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1444,12 +1444,6 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
 	if (err)
 		goto error_free_vmsa_page;
 
-	/* We initialize this flag to true to make sure that the is_running
-	 * bit would be set the first time the vcpu is loaded.
-	 */
-	if (irqchip_in_kernel(vcpu->kvm) && kvm_apicv_activated(vcpu->kvm))
-		svm->avic_is_running = true;
-
 	svm->msrpm = svm_vcpu_alloc_msrpm();
 	if (!svm->msrpm) {
 		err = -ENOMEM;
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index ca51d6dfc8e6..83ced47fa9b9 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -226,7 +226,6 @@ struct vcpu_svm {
 	u32 dfr_reg;
 	struct page *avic_backing_page;
 	u64 *avic_physical_id_cache;
-	bool avic_is_running;
 
 	/*
 	 * Per-vcpu list of struct amd_svm_iommu_ir:
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
