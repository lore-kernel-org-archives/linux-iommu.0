Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B44328DB6E
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962076; cv=none; b=cxUpHERpTH/brpo1impbcH1wGkD/9VeeSxfn35aPD7140lQ6XBCMpBxHqE7t7eyZ8WRNmG55kmW18LSVh5xjChz8sB2MKPqSmJBCKQUkd5rD5R4dIl1W60TBGeu64V50Bb/4XrKa9Zeb1FoEJ0gQlFzw06YXxaTG9mVU/U9/WKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962076; c=relaxed/simple;
	bh=GqaZYSOh5Yivyj2qFqb00jJ6hR1JshloGdmkeWMFgz8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EdOvNdmI++SfbkcorBX+Un0DoQ/btuVBrgBjCgc7ANXyugLzkPxQeE1WfWA2MnS9vYrPUm3b5WZyiY1xCnRfYrR3EB6/QjsLuyV2kWctxCBbl+xCTX/fNRArFHRmK90Xelbm2QonGwBSzX+dl5S9cliFhv287k5295MFvNCKJNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=llinzYac; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="llinzYac"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-742951722b3so7407974b3a.2
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962074; x=1748566874; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=x0SQOCMzf8MbWWt1DyUg5caMlYYVCTMHKmyxGamNwc0=;
        b=llinzYac5UIPoG+sT8NxCJ5kjQBFvN1wnQ4GZcRJ9dE1MDd2oIPF22pbat3FeLZfB4
         E32IT0PHxIjNxAnZpvBOOtIo6DteeNwM29iJk+tj0Q5geaPJ32NAe7adqEGTZvqoCaxz
         Hw4ym/H9L1IUzValA/TSSOeQ98NRflpVhj+gLrW18OY9QYJlEkwvDRMW15/dPgXXFtOO
         JaQW0CZfmY8mqh5yQ15KcPXBznm5uyFL6P43xxKotSmPfHD3UPVIpgD52JI6VpcshqIQ
         KyPB53x0JIbeT4izWiWyoG5m56vhOTmi1LHtPkPXUirrXlsLilvcJQtcscoyO3Czx5SI
         U8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962074; x=1748566874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0SQOCMzf8MbWWt1DyUg5caMlYYVCTMHKmyxGamNwc0=;
        b=b8mWNiOiZ5Aarp/0KisTORX6E+HLLSQtWog4v0qKLio2Sk2LI2o5YByrYGwn555GFO
         AiATyXgSMFVtZx3Kj1nelJElMBUaiK8IxWDKbjzhCe6YZcgDzHBJmUYdZdwsmd17OOFw
         vEOZdmzGZ/1tzZDzVhZCSeLHdpERnRyOSTn7XhGyH6iDN/NyqG/7Fpu80kWdVggKZFTz
         SdJO7V+fpCJXqADsmhazUBZ37iR8M0uSvKKiBQTOo6aaf8u7IwkoljswPaO0HkVPtyAA
         +65kKsNA6mPl6wxYXdG7rHRHkbYhjqzkX8P/Sbu7lOQZfP1W/oWQp+z/GXvbEiCIY2BX
         Eo/A==
X-Forwarded-Encrypted: i=1; AJvYcCUrHUZd34/yDqROrDGGkWCL8fFcIrEciCN0tyCihPK0eQc6l6O4O3X9ZVZFpCsXckYgHBbvGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAsO0XyRnQM5O+0kfE8/T0u4CdjCCtre0hQTWA55VYF5kD7bP2
	sbIZXWgS3E3uDa1t5wS/C7hqaLWp1b2M5Sd4v6yBZcF1N8xbxJbJqL0DvKYPhymjFvR/TK+Sv7D
	rwLTW1w==
X-Google-Smtp-Source: AGHT+IGnAWR1Ge5/kNVjom0UceZOieMbcvP7V10C2KnBUEzzCVxlhXi3O6dwFOIaCRRkmy7JIN59ucCqu8k=
X-Received: from pfbcd23.prod.google.com ([2002:a05:6a00:4217:b0:736:7120:dd05])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:e0e:b0:736:9f20:a175
 with SMTP id d2e1a72fcca58-742acc8d8f4mr36938652b3a.2.1747962073957; Thu, 22
 May 2025 18:01:13 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:43 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-39-seanjc@google.com>
Subject: [PATCH v2 38/59] iommu/amd: KVM: SVM: Infer IsRun from validity of
 pCPU destination
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Infer whether or not a vCPU should be marked running from the validity of
the pCPU on which it is running.  amd_iommu_update_ga() already skips the
IRTE update if the pCPU is invalid, i.e. passing %true for is_run with an
invalid pCPU would be a blatant and egregrious KVM bug.

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c   | 11 +++++------
 drivers/iommu/amd/iommu.c | 14 +++++++++-----
 include/linux/amd-iommu.h |  6 ++----
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 4747fb09aca4..c79648d96752 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -832,7 +832,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		entry = svm->avic_physical_id_entry;
 		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK)
 			amd_iommu_update_ga(entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK,
-					    true, pi_data.ir_data);
+					    pi_data.ir_data);
 
 		irqfd->irq_bypass_data = pi_data.ir_data;
 		list_add(&irqfd->vcpu_list, &svm->ir_list);
@@ -841,8 +841,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	return irq_set_vcpu_affinity(host_irq, NULL);
 }
 
-static inline int
-avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu, bool r)
+static inline int avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu)
 {
 	int ret = 0;
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -861,7 +860,7 @@ avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu, bool r)
 		return 0;
 
 	list_for_each_entry(irqfd, &svm->ir_list, vcpu_list) {
-		ret = amd_iommu_update_ga(cpu, r, irqfd->irq_bypass_data);
+		ret = amd_iommu_update_ga(cpu, irqfd->irq_bypass_data);
 		if (ret)
 			return ret;
 	}
@@ -923,7 +922,7 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
 
-	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, true);
+	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id);
 
 	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
 }
@@ -963,7 +962,7 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
 	 */
 	spin_lock_irqsave(&svm->ir_list_lock, flags);
 
-	avic_update_iommu_vcpu_affinity(vcpu, -1, 0);
+	avic_update_iommu_vcpu_affinity(vcpu, -1);
 
 	entry &= ~AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
 	svm->avic_physical_id_entry = entry;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5adc932b947e..bb804bbc916b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3990,15 +3990,17 @@ int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
  * Update the pCPU information for an IRTE that is configured to post IRQs to
  * a vCPU, without issuing an IOMMU invalidation for the IRTE.
  *
- * This API is intended to be used when a vCPU is scheduled in/out (or stops
- * running for any reason), to do a fast update of IsRun and (conditionally)
- * Destination.
+ * If the vCPU is associated with a pCPU (@cpu >= 0), configure the Destination
+ * with the pCPU's APIC ID and set IsRun, else clear IsRun.  I.e. treat vCPUs
+ * that are associated with a pCPU as running.  This API is intended to be used
+ * when a vCPU is scheduled in/out (or stops running for any reason), to do a
+ * fast update of IsRun and (conditionally) Destination.
  *
  * Per the IOMMU spec, the Destination, IsRun, and GATag fields are not cached
  * and thus don't require an invalidation to ensure the IOMMU consumes fresh
  * information.
  */
-int amd_iommu_update_ga(int cpu, bool is_run, void *data)
+int amd_iommu_update_ga(int cpu, void *data)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
 	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
@@ -4015,8 +4017,10 @@ int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 					APICID_TO_IRTE_DEST_LO(cpu);
 		entry->hi.fields.destination =
 					APICID_TO_IRTE_DEST_HI(cpu);
+		entry->lo.fields_vapic.is_run = true;
+	} else {
+		entry->lo.fields_vapic.is_run = false;
 	}
-	entry->lo.fields_vapic.is_run = is_run;
 
 	return __modify_irte_ga(ir_data->iommu, ir_data->irq_2_irte.devid,
 				ir_data->irq_2_irte.index, entry);
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 99b4fa9a0296..fe0e16ffe0e5 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -30,8 +30,7 @@ static inline void amd_iommu_detect(void) { }
 /* IOMMU AVIC Function */
 extern int amd_iommu_register_ga_log_notifier(int (*notifier)(u32));
 
-extern int
-amd_iommu_update_ga(int cpu, bool is_run, void *data);
+extern int amd_iommu_update_ga(int cpu, void *data);
 
 extern int amd_iommu_activate_guest_mode(void *data);
 extern int amd_iommu_deactivate_guest_mode(void *data);
@@ -44,8 +43,7 @@ amd_iommu_register_ga_log_notifier(int (*notifier)(u32))
 	return 0;
 }
 
-static inline int
-amd_iommu_update_ga(int cpu, bool is_run, void *data)
+static inline int amd_iommu_update_ga(int cpu, void *data)
 {
 	return 0;
 }
-- 
2.49.0.1151.ga128411c76-goog

