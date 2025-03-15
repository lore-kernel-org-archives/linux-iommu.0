Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CCC18C910
	for <iommu@lists.linux.dev>; Sat, 15 Mar 2025 02:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742007104; cv=none; b=sp5PAxxdOg/FoKLBYecgTcR0uU36lrGmZuBT2zoWPm8VAv3PYwGoXbS5DVddoxB4Lf7rmDSXNCbvMPmh8dCGx9dbWHYMGYVqfc5gcBDHVkq84zn8Qenhr2fKOGc7mOBIbuRz80/sWtUWbYfA2TfSw3NeXAx9ktWLNv2Zry157uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742007104; c=relaxed/simple;
	bh=cklmUwPs0BxA9rEG9UWa48PfZeDOKMwX41YSmqVc8mo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ubP4yi1DpvqnWBqtCEPuvG+WUI9yILnCVqH3/MF5VJbAIzy2F1zibjRhEZUWHPxElN8wIcLNz+sBGGYRFUcnfrwQpeHXW6PHOCijFFsx0Ja7RrkyFhV/UaRNha/BGFE8d7nL2ENPkrJLscSOIGUrgzeMNWOr/IcbsCqzpNHSTLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3s2FBMO6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3s2FBMO6"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-223d86b4df0so52036205ad.3
        for <iommu@lists.linux.dev>; Fri, 14 Mar 2025 19:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742007101; x=1742611901; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hsZoVmhQefEgpTWMkq2HswkVofLF7WHPskHUUQL39pM=;
        b=3s2FBMO6tsQNcatBYNGQ+UvLHyfl8Bkqzp2DW8W616pK17b0i0rFckHUOPjo2mYkmV
         rAjZY/Y1DCQSyXC5O2MpNgOfGUU6He4CBWIQDcCY1206w/+uw+4DFY6/iGoH+2YXXn+v
         C6G8AzY3ZRunqMFMcZ/VinzWLdTOjlLybZkLHH2pes/CGIMxECDBp6tZAkctDbak6GVh
         0C/u4ClUD6sY4iDePUK5DGUMN3QaVYo2MjZY8Yi2zupq5Q0kX6+Pm+lYkPBsiqtlq6fV
         tMRH2T68hvmV4yHQwAeSNDoEs+UHDwXGTJiD5r5JfX1wmMAqEaJSww2Ic9GhOgiwERWY
         18TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742007101; x=1742611901;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hsZoVmhQefEgpTWMkq2HswkVofLF7WHPskHUUQL39pM=;
        b=F2ovjEOLQ4oW6fG1WrCpAfMhMsDUhBqwZwZJUmrkGdFHyqf9sdmmYXwCRoi6vTt9gF
         g8vAKE1VS/B9DCO2952QM6FG71Xfo5sV3siPqDkmmsYVFyFzwoFl9LioPKfgEfH06tZR
         OOy/eInMBHzSGu34zXJnw2I4o1Had1DUM15ESC3EUM9mS2f76BCwW/HFet29OgsibcWA
         V64ASwSiQf9KShYyg2YqK4FJj3M/EbNdzvRRLXdh2a93IfqtRwcOqC7bHgsWjXjvGXuC
         uqqUHkBB+5N+mFNzz/Fn74VUKar8Wwm1/0iD1oSBaGhumX7zpTE0i4yOcILXkP1F2oRa
         Rlkw==
X-Gm-Message-State: AOJu0YxQio/jTxwcXMcyHPa4H2kt56rV8PDY/Z4px8fBqNsFTX4n/cli
	Xo2Gm7rg058LDkQsFpjPhCbXoAe06YEDFRnvoVVw17gJ/KgcVVovEjtNjgQnrOBRUNtOKCEw/oF
	kog==
X-Google-Smtp-Source: AGHT+IF3FyGhKX75Hq9YTFpkiJaxD/Kh+N2dlF6+aF64zugIVthmZiSeHYdR4w+YvG5hNjn+DctyXCgsp2g=
X-Received: from pfbna3.prod.google.com ([2002:a05:6a00:3e03:b0:736:4ad6:181b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:14c3:b0:736:4830:68a6
 with SMTP id d2e1a72fcca58-73722311d89mr5664120b3a.4.1742007101170; Fri, 14
 Mar 2025 19:51:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 14 Mar 2025 19:51:35 -0700
In-Reply-To: <20250315025135.2365846-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250315025135.2365846-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315025135.2365846-3-seanjc@google.com>
Subject: [PATCH 2/2] iommu/vt-d: Don't clobber posted vCPU IRTE when host IRQ
 affinity changes
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Jacob Pan <jacob.jun.pan@linux.intel.com>, 
	Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"

Don't overwrite an IRTE that is posting IRQs to a vCPU with a posted MSI
entry if the host IRQ affinity happens to change.  If/when the IRTE is
reverted back to "host mode", it will be reconfigured as a posted MSI or
remapped entry as appropriate.

Drop the "mode" field, which doesn't differentiate between posted MSIs and
posted vCPUs, in favor of a dedicated posted_vcpu flag.  Note!  The two
posted_{msi,vcpu} flags are intentionally not mutually exclusive; an IRTE
can transition between posted MSI and posted vCPU.

Fixes: ed1e48ea4370 ("iommu/vt-d: Enable posted mode for device MSIs")
Cc: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/iommu/intel/irq_remapping.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index c495b533103f..ea3ca5203919 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -25,11 +25,6 @@
 #include "../irq_remapping.h"
 #include "../iommu-pages.h"
 
-enum irq_mode {
-	IRQ_REMAPPING,
-	IRQ_POSTING,
-};
-
 struct ioapic_scope {
 	struct intel_iommu *iommu;
 	unsigned int id;
@@ -49,8 +44,8 @@ struct irq_2_iommu {
 	u16 irte_index;
 	u16 sub_handle;
 	u8  irte_mask;
-	enum irq_mode mode;
 	bool posted_msi;
+	bool posted_vcpu;
 };
 
 struct intel_ir_data {
@@ -138,7 +133,6 @@ static int alloc_irte(struct intel_iommu *iommu,
 		irq_iommu->irte_index =  index;
 		irq_iommu->sub_handle = 0;
 		irq_iommu->irte_mask = mask;
-		irq_iommu->mode = IRQ_REMAPPING;
 	}
 	raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
 
@@ -193,8 +187,6 @@ static int modify_irte(struct irq_2_iommu *irq_iommu,
 
 	rc = qi_flush_iec(iommu, index, 0);
 
-	/* Update iommu mode according to the IRTE mode */
-	irq_iommu->mode = irte->pst ? IRQ_POSTING : IRQ_REMAPPING;
 	raw_spin_unlock_irqrestore(&irq_2_ir_lock, flags);
 
 	return rc;
@@ -1173,9 +1165,18 @@ static void __intel_ir_reconfigure_irte(struct irq_data *irqd, bool force_host)
 {
 	struct intel_ir_data *ir_data = irqd->chip_data;
 
+	/*
+	 * Don't modify IRTEs for IRQs that are being posted to vCPUs if the
+	 * host CPU affinity changes.
+	 */
+	if (ir_data->irq_2_iommu.posted_vcpu && !force_host)
+		return;
+
+	ir_data->irq_2_iommu.posted_vcpu = false;
+
 	if (ir_data->irq_2_iommu.posted_msi)
 		intel_ir_reconfigure_irte_posted(irqd);
-	else if (force_host || ir_data->irq_2_iommu.mode == IRQ_REMAPPING)
+	else
 		modify_irte(&ir_data->irq_2_iommu, &ir_data->irte_entry);
 }
 
@@ -1270,6 +1271,7 @@ static int intel_ir_set_vcpu_affinity(struct irq_data *data, void *info)
 		irte_pi.pda_h = (vcpu_pi_info->pi_desc_addr >> 32) &
 				~(-1UL << PDA_HIGH_BIT);
 
+		ir_data->irq_2_iommu.posted_vcpu = true;
 		modify_irte(&ir_data->irq_2_iommu, &irte_pi);
 	}
 
@@ -1496,6 +1498,9 @@ static void intel_irq_remapping_deactivate(struct irq_domain *domain,
 	struct intel_ir_data *data = irq_data->chip_data;
 	struct irte entry;
 
+	WARN_ON_ONCE(data->irq_2_iommu.posted_vcpu);
+	data->irq_2_iommu.posted_vcpu = false;
+
 	memset(&entry, 0, sizeof(entry));
 	modify_irte(&data->irq_2_iommu, &entry);
 }
-- 
2.49.0.rc1.451.g8f38331e32-goog

