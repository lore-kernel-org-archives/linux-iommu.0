Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791BDC433FE
	for <iommu@archiver.kernel.org>; Wed,  8 Dec 2021 01:55:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2BE47409F8;
	Wed,  8 Dec 2021 01:55:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LBqkR_gwa1rD; Wed,  8 Dec 2021 01:55:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C7B8B409F0;
	Wed,  8 Dec 2021 01:55:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A141FC001E;
	Wed,  8 Dec 2021 01:55:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F0AEC006E
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8DE8741D8D
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id muJoU7VsJ9TY for <iommu@lists.linux-foundation.org>;
 Wed,  8 Dec 2021 01:55:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com
 [IPv6:2607:f8b0:4864:20::1049])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0080141D96
 for <iommu@lists.linux-foundation.org>; Wed,  8 Dec 2021 01:55:11 +0000 (UTC)
Received: by mail-pj1-x1049.google.com with SMTP id
 d7-20020a17090a7bc700b001a6ebe3f9cbso1589858pjl.0
 for <iommu@lists.linux-foundation.org>; Tue, 07 Dec 2021 17:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=reply-to:date:in-reply-to:message-id:mime-version:references
 :subject:from:to:cc;
 bh=3aCuJMfMHs3SWtggi+I9Cs3L2a0EwivzrBeo1W7uLTQ=;
 b=YN6ImAQZaOEXzCZQuswx/CTadBK+2y0AdGEJQtahln1tgbBs1poFnAV8djVGK5n7EO
 jG+ufcxESTPvQb19oLKtRxWkutlq7NE8qy/jzV5RIRmrpVmm/3LHGF+2GB84EWjniv8W
 loQOT3iiaUndNCYXWVVYlhZqgvXOIsHCYzJ+hUQxkhUaoQbtEFEpzfeSsphdLG7hg5P4
 JMrRKbKhkgk5qttoxd1Q5137Aqwk5wAqWlPBJVS2z9279DhubHlE9fTRMqD5L79mQuMw
 E/jv4/Tao9gXqj+e/eOzAR1YwI+J8azjwocOuUZIRvgs8/rg81R4PwkLVZh+QqEr6G2/
 8GQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:date:in-reply-to:message-id
 :mime-version:references:subject:from:to:cc;
 bh=3aCuJMfMHs3SWtggi+I9Cs3L2a0EwivzrBeo1W7uLTQ=;
 b=h/fKsTCZUA6Et/yb64zEynSOwg4I0Toip68LOZZKZ2hNYDs/KMDb14kx65iFJw0M9d
 h0FiJXbqHLT82bJlZTR1IOqdM1v68Tfqpz2Amo8SXLN+cQXl9pokF+sHRktUvbdXxAYn
 lLESoKWsQlP7gYsBw8++LUR7mcM+GbX5j8UVyol1mebgWqMco3ocUnuZeVFn+AaAmCPb
 sbeRDUW84v047sphMfqNZVUez3X4Ye3tetyF+uHtvx/oK9yAFAKTB/7yRaX4AgOLj2vg
 LILbeJOxUCjfswm0PJcQUN56ur8XZnn3oxLkFno5AqI+d/w9TDY5KprBFu2Hk6tmXsjd
 lpfA==
X-Gm-Message-State: AOAM533rQbrbmtDd0uYPa1oaRVt9r54q7UCBYs5QYLI8Mz/09Iq5YIAA
 n6fUuzolshvSAt2z2nhhl/v1MkTaLgU=
X-Google-Smtp-Source: ABdhPJyH9lBa9R496fB+xYtHQMbq+NgJWpFjohfcNU7q50G/OFjItH3xA5+gGAj3jNjGfNUh4zq6Jh7tlfM=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1946:b0:492:64f1:61b5
 with SMTP id
 s6-20020a056a00194600b0049264f161b5mr2932849pfk.52.1638928511449; Tue, 07 Dec
 2021 17:55:11 -0800 (PST)
Date: Wed,  8 Dec 2021 01:52:25 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-16-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 15/26] iommu/amd: KVM: SVM: Use pCPU to infer IsRun state
 for IRTE
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

Now that the one and only caller of amd_iommu_update_ga() passes in
"is_run == (cpu >= 0)" in all paths, infer IRT.vAPIC.IsRun from @cpu
instead of having the caller pass redundant information.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c   | 8 ++++----
 drivers/iommu/amd/iommu.c | 6 ++++--
 include/linux/amd-iommu.h | 6 ++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 0c6dfd85b3bb..88b3c315b34f 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -941,7 +941,7 @@ bool svm_check_apicv_inhibit_reasons(ulong bit)
 
 
 static inline int
-avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu, bool r)
+avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu)
 {
 	int ret = 0;
 	unsigned long flags;
@@ -961,7 +961,7 @@ avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu, bool r)
 		goto out;
 
 	list_for_each_entry(ir, &svm->ir_list, node) {
-		ret = amd_iommu_update_ga(cpu, r, ir->data);
+		ret = amd_iommu_update_ga(cpu, ir->data);
 		if (ret)
 			break;
 	}
@@ -1002,7 +1002,7 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	entry |= AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
 
 	WRITE_ONCE(*(svm->avic_physical_id_cache), entry);
-	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, true);
+	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id);
 }
 
 void avic_vcpu_put(struct kvm_vcpu *vcpu)
@@ -1016,7 +1016,7 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 	if (!(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK))
 		return;
 
-	avic_update_iommu_vcpu_affinity(vcpu, -1, 0);
+	avic_update_iommu_vcpu_affinity(vcpu, -1);
 
 	entry &= ~AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
 	WRITE_ONCE(*(svm->avic_physical_id_cache), entry);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 461f1844ed1f..2affb42fa319 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3522,7 +3522,7 @@ int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 	return 0;
 }
 
-int amd_iommu_update_ga(int cpu, bool is_run, void *data)
+int amd_iommu_update_ga(int cpu, void *data)
 {
 	unsigned long flags;
 	struct amd_iommu *iommu;
@@ -3552,8 +3552,10 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 						APICID_TO_IRTE_DEST_LO(cpu);
 			ref->hi.fields.destination =
 						APICID_TO_IRTE_DEST_HI(cpu);
+			ref->lo.fields_vapic.is_run = true;
+		} else {
+			ref->lo.fields_vapic.is_run = false;
 		}
-		ref->lo.fields_vapic.is_run = is_run;
 		barrier();
 	}
 
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 58e6c3806c09..005aa3ada2e9 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -165,8 +165,7 @@ static inline int amd_iommu_detect(void) { return -ENODEV; }
 /* IOMMU AVIC Function */
 extern int amd_iommu_register_ga_log_notifier(int (*notifier)(u32));
 
-extern int
-amd_iommu_update_ga(int cpu, bool is_run, void *data);
+extern int amd_iommu_update_ga(int cpu, void *data);
 
 extern int amd_iommu_activate_guest_mode(void *data);
 extern int amd_iommu_deactivate_guest_mode(void *data);
@@ -179,8 +178,7 @@ amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
 	return 0;
 }
 
-static inline int
-amd_iommu_update_ga(int cpu, bool is_run, void *data)
+static inline int amd_iommu_update_ga(int cpu, void *data)
 {
 	return 0;
 }
-- 
2.34.1.400.ga245620fadb-goog

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
