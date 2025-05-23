Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3971274FEE
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 01:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962047; cv=none; b=QehtZjdxtTNMffcOwIIReXpiaS1Pwz6DBxX6rr038M5uV+i6GtrHGP/7JeH6ngOnvB3rSpEGmW/bbEfcKT+4DuE2UityZP8MfIB/sX+i5x6XCqQIm2gc4JgD+UUtgIlJiDbR1JEBiXAYt0mqp31oZ3gLI3zb4qgKNeAun0bR24E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962047; c=relaxed/simple;
	bh=fW2G94RfLD78AMcqDsZ5ps4G4Sno9GFbL+j5/DPryVk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LprhCtsYKXHPWszS/1IcwE6OG/JcuU+0ZExuyyZhJdMFILO+AbpG9/FCGwUfRzFHUaeXk/a7jiRQ4//N+Lydwun7x4x87x6eK8YU5zcqGhvzBLvfKRLsYzeDPjp/p4C5dQ65pfnX5VJvK/slS1+u1T1TLTaE/nEY7H8PzBA6p5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ohUVgEr1; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ohUVgEr1"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b0e0c573531so5902589a12.3
        for <iommu@lists.linux.dev>; Thu, 22 May 2025 18:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962044; x=1748566844; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=LEcBPUoa4oxCDsr/z1+DJV9LnDo6qsS8eDb1DWTU3As=;
        b=ohUVgEr1vZMKrJd0ry9860McuN0bAzBsZNHkt3akEj1mt28mjiaQAIX8/CXhYX3CAu
         f4/Lm56O40aJ1BkSf6tfdC+0QTGslmK3HQtjWUWbgV/2rRGc6kkguYyS4HqkarBruS2q
         EiDQiBK7MdCpF21UmJVKrUe3T+WW+pICfYe57+kjLkRFB5upfMQxWyNx7LJftcJ4PS/+
         71rwuKdELl0WHUsgbdaFerjO50FGlO85ecOHU7sYQgCPRPR9whSarqIcqka7liNW0oa1
         u+xAbs8QCcDgcuo82cgQl9OkvpwtCG8XCj9r9kFxg9TZ0rt7UL9cntwG7uExl4107o33
         tV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962044; x=1748566844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LEcBPUoa4oxCDsr/z1+DJV9LnDo6qsS8eDb1DWTU3As=;
        b=Y1ZqvgIijfGLgs10hgLOVbIVOUeQSrPJWqo3OI9ktGTbGuHASAmjL81s/sFZodfxth
         3cy8h4cOkufu12uKN42Re81rI4B13L3pjgktuQYsjFpMqtkzHlkNxGsnLDZKaI20jby2
         AnUHDBpKi/Uqa4jdCF9BSHDBAz9PhTnLCD8lgVvdbod8zAbs3dPneE/k+ME7V4B+7yEn
         Q1T59vJnr2rIIDQoVqKtvaPNcvg0cF4yu8BGWCxFNiCdHnie7CsvJ+fF1u2wWKjQLgIT
         V475WFIOfGXJD7pWlDAPXVyBy/iXy9VfrUITnKhhIECVcPCOgBTZi+eAwEqlgqHaLmSG
         SQnw==
X-Forwarded-Encrypted: i=1; AJvYcCXZP9V+fSoBoYesBwYVgIjGMP6/5vprUKXMuPWpAf+62Om1alTlz4KYkwhLiTjlGltUeNEAow==@lists.linux.dev
X-Gm-Message-State: AOJu0YwlGGy8oSVvVXoV0rG+VQGLppQwhQwP1tjJz5NYwW2ebl+KIQck
	4eKI+/erolHma4vZiYdOKm+WwnC1zL6bACYK5XdR4KiZzmS4VHCiQBnke3yegx5115q7ZDZZkyh
	Px8RM7Q==
X-Google-Smtp-Source: AGHT+IGKaHuHYtNmHM5Kq9jQbWuDh5HQqrhGXZK4H0D0g7q7j+eU/9f1bdcnBIi1ajs832Ec0O94mR8aIqk=
X-Received: from pjbsl8.prod.google.com ([2002:a17:90b:2e08:b0:301:1bf5:2f07])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b48:b0:2ee:d433:7c50
 with SMTP id 98e67ed59e1d1-30e7d5ac7ecmr33843110a91.23.1747962044116; Thu, 22
 May 2025 18:00:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:25 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-21-seanjc@google.com>
Subject: [PATCH v2 20/59] iommu/amd: KVM: SVM: Pass NULL @vcpu_info to
 indicate "not guest mode"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Pass NULL to amd_ir_set_vcpu_affinity() to communicate "don't post to a
vCPU" now that there's no need to communicate information back to KVM
about the previous vCPU (KVM does its own tracking).

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c   | 16 ++++------------
 drivers/iommu/amd/iommu.c | 10 +++++++---
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 461300bc5608..6260bf3697ba 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -927,18 +927,10 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		}
 	}
 
-	ret = 0;
-	if (enable_remapped_mode) {
-		/* Use legacy mode in IRTE */
-		struct amd_iommu_pi_data pi;
-
-		/**
-		 * Here, pi is used to:
-		 * - Tell IOMMU to use legacy mode for this interrupt.
-		 */
-		pi.is_guest_mode = false;
-		ret = irq_set_vcpu_affinity(host_irq, &pi);
-	}
+	if (enable_remapped_mode)
+		ret = irq_set_vcpu_affinity(host_irq, NULL);
+	else
+		ret = 0;
 out:
 	srcu_read_unlock(&kvm->irq_srcu, idx);
 	return ret;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 512167f7aef4..5141507587e1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3864,7 +3864,6 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 {
 	int ret;
 	struct amd_iommu_pi_data *pi_data = vcpu_info;
-	struct vcpu_data *vcpu_pi_info = pi_data->vcpu_data;
 	struct amd_ir_data *ir_data = data->chip_data;
 	struct irq_2_irte *irte_info = &ir_data->irq_2_irte;
 	struct iommu_dev_data *dev_data;
@@ -3885,9 +3884,14 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 		return -EINVAL;
 
 	ir_data->cfg = irqd_cfg(data);
-	pi_data->ir_data = ir_data;
 
-	if (pi_data->is_guest_mode) {
+	if (pi_data) {
+		struct vcpu_data *vcpu_pi_info = pi_data->vcpu_data;
+
+		pi_data->ir_data = ir_data;
+
+		WARN_ON_ONCE(!pi_data->is_guest_mode);
+
 		ir_data->ga_root_ptr = (vcpu_pi_info->pi_desc_addr >> 12);
 		ir_data->ga_vector = vcpu_pi_info->vector;
 		ir_data->ga_tag = pi_data->ga_tag;
-- 
2.49.0.1151.ga128411c76-goog

