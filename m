Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26CD221579
	for <iommu@lists.linux.dev>; Fri,  4 Apr 2025 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743795634; cv=none; b=Io88IOKKTsbHuzHZLR+N30kwMf/uBP0H+NCAYjOKwQNZqFRJb5UPPbhVK2M+JCKq+kSIJy0zHnO+m21WBIh0nIwtzf2fwoz4LTKwRDJZkGttpQYDpUQcT7A7uFP+Pt08urH/kFpXPCPyt022jVw63B2adUrA4v41uH1+xPcCIOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743795634; c=relaxed/simple;
	bh=numHIJ2fVUixTwPl70w3f1Z9LTsloAbGJqKA3GVrevU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JcHL+ZrUyJKj7CCGP+11IhzogxLL1i8fz7DXjli6t3dik4zay7CcghEnmBjYANoh86CTAJ70Sf8eJUwde2Yl4Ej4wyc/VELrXzeaKyBpPySBixKp4S43ulwVdgjEJCpFfleMrK5htEdKPBKyOKrLCCg8LVbqVnSOSLDt5FpcBMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wbLYvHBA; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wbLYvHBA"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2242ce15cc3so22838165ad.1
        for <iommu@lists.linux.dev>; Fri, 04 Apr 2025 12:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743795632; x=1744400432; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=VyaPnhLqGsMwpjiZdqn/1mWwUn+QLwb4TwRlvb1iqoM=;
        b=wbLYvHBA4TKNMVzrclwp8R3sBa89z7BcHSeF9dIq6Ka/qWh26Z8gXpX2ecv7MkJh0p
         F6miuZdSsg59LDIPxyqCFUyO95yWQ0/+lStp2+1g+gon+cY/FZRj/kjtOrbGXx7K57Yr
         uipiZ+Qd68lbYF2dMR98g333GSNu7VOuShkO+YM0RU3dnFjyRxGeANNSwCXJZKeDuXS1
         Fab5nHW4LbkIoZr8EtFaN+N8pUBCooIa87kdF7l6tJrGtjtrqmCJhxt9weWXKX0PxyaT
         qZCNno050EerIKnJyCAcvNsh87n8u3SPNolYN5qzxeTMKsAsEq06FrAOMXNTML5n1NGk
         IgvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743795632; x=1744400432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VyaPnhLqGsMwpjiZdqn/1mWwUn+QLwb4TwRlvb1iqoM=;
        b=NgRQLt21aPT3U2wwwOtPZ9GZuOwnf93wof6b5hgPGe6ZYRnC8fQ1BsfjXzQbpzm63R
         44EZe06Xe9wQUfMvQBInsjC+8jwo0L9rM/ebg+iwm/QSve44efQNLb2SwTuIAE6qoCtV
         AHpB4HiLEe7UwuBr5WG3M03JdLGswD9vN8bv/VFZRBaVjJl+EdvqNEgk08MoQNAnEAUa
         qBqodclImgxcwqIspWIjTxPycy5DHXCMgq/ohMfvzljJYG20NigGfr8HS3U+1PBs1NL+
         HTfuyIXAWwhLlSCwaOy1hdCafwWUezpa+qRR1HSfaVSusSkC7GPjGfv4DCiMt4iwNBR5
         DCVw==
X-Forwarded-Encrypted: i=1; AJvYcCUwqVdWT6cwY6bEwIk2B1cvZdJfX9HuxF5SRhllDCd/xOHAOSVCmaG2HPIGSccql0/g0JzvLA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw9B+dtpioGJ7esWyi8pIUJaAC6jlLSRGVITBoIx3FmvELdQatr
	Wdh3VaXl1P8NFlG1X//86V46BLd3RCRn0hppAVwgVmF/421pYzSd+VAczWYXsGrGe8nqmzZ/DZr
	6LQ==
X-Google-Smtp-Source: AGHT+IGMwxs0YOBPs8h+elgyRVkuAbPHKTSrU7awNNYaCT+HPFTcP/hO7N3HdKAFdFfYL9/K+0CGHpH7MBY=
X-Received: from pfop9.prod.google.com ([2002:a05:6a00:b49:b0:739:9e9:feea])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f605:b0:220:e9f5:4b7c
 with SMTP id d9443c01a7336-22a8a865825mr59456785ad.17.1743795632180; Fri, 04
 Apr 2025 12:40:32 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  4 Apr 2025 12:38:41 -0700
In-Reply-To: <20250404193923.1413163-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250404193923.1413163-27-seanjc@google.com>
Subject: [PATCH 26/67] iommu/amd: KVM: SVM: Delete now-unused cached/previous
 GA tag fields
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Delete the amd_ir_data.prev_ga_tag field now that all usage is
superfluous.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c             |  2 --
 drivers/iommu/amd/amd_iommu_types.h |  1 -
 drivers/iommu/amd/iommu.c           | 10 ----------
 include/linux/amd-iommu.h           |  1 -
 4 files changed, 14 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 9024b9fbca53..7f0f6a9cd2e8 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -943,9 +943,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		/**
 		 * Here, pi is used to:
 		 * - Tell IOMMU to use legacy mode for this interrupt.
-		 * - Retrieve ga_tag of prior interrupt remapping data.
 		 */
-		pi.prev_ga_tag = 0;
 		pi.is_guest_mode = false;
 		ret = irq_set_vcpu_affinity(host_irq, &pi);
 	} else {
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 23caea22f8dc..319a1b650b3b 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -1060,7 +1060,6 @@ struct irq_2_irte {
 };
 
 struct amd_ir_data {
-	u32 cached_ga_tag;
 	struct amd_iommu *iommu;
 	struct irq_2_irte irq_2_irte;
 	struct msi_msg msi_entry;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 635774642b89..3c40bc9980b7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3858,23 +3858,13 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
 	ir_data->cfg = irqd_cfg(data);
 	pi_data->ir_data = ir_data;
 
-	pi_data->prev_ga_tag = ir_data->cached_ga_tag;
 	if (pi_data->is_guest_mode) {
 		ir_data->ga_root_ptr = (vcpu_pi_info->pi_desc_addr >> 12);
 		ir_data->ga_vector = vcpu_pi_info->vector;
 		ir_data->ga_tag = pi_data->ga_tag;
 		ret = amd_iommu_activate_guest_mode(ir_data);
-		if (!ret)
-			ir_data->cached_ga_tag = pi_data->ga_tag;
 	} else {
 		ret = amd_iommu_deactivate_guest_mode(ir_data);
-
-		/*
-		 * This communicates the ga_tag back to the caller
-		 * so that it can do all the necessary clean up.
-		 */
-		if (!ret)
-			ir_data->cached_ga_tag = 0;
 	}
 
 	return ret;
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 4f433ef39188..deeefc92a5cf 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -19,7 +19,6 @@ struct amd_iommu;
  */
 struct amd_iommu_pi_data {
 	u32 ga_tag;
-	u32 prev_ga_tag;
 	bool is_guest_mode;
 	struct vcpu_data *vcpu_data;
 	void *ir_data;
-- 
2.49.0.504.g3bcea36a83-goog

