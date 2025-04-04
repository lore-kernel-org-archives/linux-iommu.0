Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DEB22B588
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795637; cv=none; b=hrRuNT0At6PA39WWTfsBgCv1iqQgtY2azkkawUGqatZDvECbtf8nFIHNZLrfSpbWl5dBUQpENhdLYwQQ/VlghnUSd+QfvaHdQegUQMPfsgbCWy246MfkDy+YgBMvlVgcO5qxodTJ6W1u9XL321yVn90DHr366dpgkzk8m5MItkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795637; c=relaxed/simple;
	bh=V0MGfeZG66UFt76kNvNPvs2l8e+FatrRv8SBCWV6kxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z03li1Hx6HBjPlc6lwzlgjqSvdx6/xhS6WhAyfxpqMedAx2rjjDbI9c99Gst9nL039mpf9DjptEKkKm/edTJuOBVucmWmN1XWxPuZYYeHnM3tF7fd8tXqj5rtKx8W5wlC7ReTtrpeip5HQqXHGzxqBUsNjvDXPyWKDRz3KX2NuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k2nFvQKX; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k2nFvQKX"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736c1ea954fso1371341b3a.3
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795634; x=1744400434; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=+TG2faHkEqaXMPy8//eGevjiJYlH47y/jdqu1B7aYBw=;
        b=k2nFvQKXXteYGst4vjz3fFVYeiflTLPUk17O+mFVqOq2ygxZdGWafwiTXbj6DhrXtT
         2XMvxVV0tQiPklI2qCiIyGzDR7J0zvfsYW7HkpfemoEYH7xJBBKlM8mHUTuPJqJuUdvN
         TkCu4BlotklyLO0Ulb+lLVm3EX68p3OOsMHwzMwRokLp38KekJ6mlujPt3DofOGdcNl9
         krxrveI7VIlot2SI4UWCdjoDRH2BuWsSnP3pahW2A0kpoCo9qeK6rlw34SkQUWW6sbLJ
         6dAoLOh4r3fdax5qJJh6rIjvW5quPq8o+dGbd0Px7AS5UKegXEQWaCxhpi+4SqNNk12F
         TfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795634; x=1744400434;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TG2faHkEqaXMPy8//eGevjiJYlH47y/jdqu1B7aYBw=;
        b=cVl89PyRUKyJm+Z1A8/H7qCrxzXKNdAlaQA6b/Dn8gO1LB+mnhrKdj121hFIHw2SxK
         veJ8p5qi1WKN0slOKe/qXxslfdhz/mDeeMAdeGJd27NWwadXbF+nMLjtq/15+5TChg3h
         3AoFmf4gNleaWGfM8O8B3C0K2dwhP1Xw4/RdAFBVswxTq8UShhVMeG3KnP+06FpC7VJS
         wLGaqhmfXSeGvJC2E5Se+cMxX0gkTWlA0umoERirOeBNveML1ZIA8Ce8DU1LlqSRdhhF
         zpy31dfX9Eb9KL2CZt8xDD6rp3dzuYnI0qGL1Ct6HZV+a2uL1vKf19YMPmpP1ltev9nj
         1VZA==
X-Forwarded-Encrypted: i=1; AJvYcCXJM0j43cW258EpbX86d45vOpR5QCJRJZgHkWw5Sc+GoRIlKcsajZwh639l2+wJ1E0OMCSS7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwBRYjvi1Fptqxr8s3CD++oiZmVkL+N2Q/IWYsvRH/l7tbMzwp3
	nB0cY3KKo0aA3I4uffGhfKP2UbA7qMHLtstD1lO9bSNoYnNh/Y2xId7RHA6qsGYyjZZM6OtQBmY
	NyQ==
X-Google-Smtp-Source: AGHT+IGLDYZyajkylbmX0c1w0MumABkRavq1xwq7nD0DOCpebCVgFI0dxpSvqG/AK8qTMUuH0twfv9e2Cs0=
X-Received: from pfxa13.prod.google.com ([2002:a05:6a00:1d0d:b0:736:a68b:88f8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1397:b0:736:51ab:7ae1
 with SMTP id d2e1a72fcca58-739e4be4210mr5216803b3a.16.1743795633653; Fri, 04
 Apr 2025 12:40:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:42 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-28-seanjc@google.com>
Subject: [PATCH 27/67] iommu/amd: KVM: SVM: Pass NULL @vcpu_info to indicate
 "not guest mode"
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Pass NULL to amd_ir_set_vcpu_affinity() to communicate "don't post to a
vCPU" now that there's no need to communicate information back to KVM
about the previous vCPU (KVM does its own tracking).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c   | 15 +++------------
 drivers/iommu/amd/iommu.c | 10 +++++++---
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 7f0f6a9cd2e8..9c789c288314 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -936,19 +936,10 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		}
 	}
 
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
-	} else {
+	if (enable_remapped_mode)
+		ret = irq_set_vcpu_affinity(host_irq, NULL);
+	else
 		ret = 0;
-	}
 out:
 	srcu_read_unlock(&kvm->irq_srcu, idx);
 	return ret;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3c40bc9980b7..08c4fa31da5d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3835,7 +3835,6 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 {
 	int ret;
 	struct amd_iommu_pi_data *pi_data = vcpu_info;
-	struct vcpu_data *vcpu_pi_info = pi_data->vcpu_data;
 	struct amd_ir_data *ir_data = data->chip_data;
 	struct irq_2_irte *irte_info = &ir_data->irq_2_irte;
 	struct iommu_dev_data *dev_data;
@@ -3856,9 +3855,14 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
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
2.49.0.504.g3bcea36a83-goog

