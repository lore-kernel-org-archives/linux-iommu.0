Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD01923A9AD
	for <iommu@lists.linux.dev>; Sat, 27 Sep 2025 22:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759012815; cv=none; b=H/SvJ5ilMouAblju542FyTvnddM89mfk36OMp861nrJb4j4yFrYcAYEfQIu26hcIAPE8Mu3iAPCNrnAKh6jwAFi+oUpbsWZZwWXKxg7dfKmvynknFnKGenUvlXFuQwY6j3SB23Yi+OJNRvBwEiV4266seEX182iNgUNRiyNFeLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759012815; c=relaxed/simple;
	bh=b/oNVW2/yDoFBqwXnNKcqDo98sE8Dwz/kzjEHnPaqLI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jVgixzyLEze93eVM8dKyrLbMEV4fnD/eAnBoL5d93t4JxbUdOX48eUaWL0i++4n7hbD+YcHmdWIG1v52D6+ARaOqK/rpxY+97REJIvhN+GIeSupCRpex5tYtCs3uWpT/FZa/cs9Vf0f35P9Y35rBfppXDfK+BZTqs8oZQoRvN2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L7NwgZsi; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--danielmentz.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L7NwgZsi"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581ce13aso58288525ad.2
        for <iommu@lists.linux.dev>; Sat, 27 Sep 2025 15:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759012813; x=1759617613; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Q4ctgw3TCRfxdQOeE/B58PrVob15spvvnivVaYg/9A=;
        b=L7NwgZsiTajsxJYzxP5Fq/sIYNQuXJ3n2vi7KVGRi8zDP8BHRsaXUEiLxsfehu3Gu9
         HS/6LFyxUPDrf+8nheHUTi3nZ/il3xi7Xq+H9lMDhdDeGdNc8mcSTJ5tK/yqedNQ7T91
         93GJMLilhuqX1ScKAvXzbj7nqZrvAKFz4i+JtYP56Uxtd5NH8srCyw34Nwbc5XMQP1Tw
         fmQ1hGZvWCeHCOdCKBbvOmpV8wtGRMXuQxcrXvJcENPsexoR0MniewmSGL+Qa5JDsS4h
         UrWrqSoktQ4/WOpJDFcJ1PLZh0becJh9rAEnCRZ3jT7h55QLmuRBBlLIQ2eeydTjJvgm
         1zEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759012813; x=1759617613;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Q4ctgw3TCRfxdQOeE/B58PrVob15spvvnivVaYg/9A=;
        b=vEF6ZCH66Mob4emo3M95Jvi2s3zpupAqPRTopo52/BcvEBDqGiAkd0+conBZP295xE
         pcMCR1K615p2o9PHY9fOM4RYmHU1koweXlmxIxO0AZSltwPF2pJeRQ5ONhWA3UDMNwfh
         crLM4mgMIGdJC0y9IirHj4ppNHpq4hLYy7G1AjO3A4hkePlH+ia2QLFOiOLEhijdD+iA
         BPQYneS/oFlQW4jEN9IiEjzKF2+B8WHrIymo+ek7FpeWj9oxaGc9BJxDOT0rLDIcCmSj
         sbLNVca+AQv1heTtQZSVyVSm0gm4Pet9igHESAgwh76RqB4FpIw11Tr398po14ZvKnJO
         ct/g==
X-Gm-Message-State: AOJu0YxIv/PFNUlD19klbt9c08ttbIa/rPF8yM8ijjsKzPYHS8v109d1
	mL2B7wy/LBkc/tUYZ/1JETzsd+TXx+r6wr4AZr0Py1ssD7TLUuzfpoBumiG+5ArK4uuixJleG0K
	uJbWdCMaWPGDimc9O+4e0S5BK07Pf5GVDBfuB/qvudM+6CjSTuGo5HxjNRTw5wCXGZbFgIoPU3i
	7Haevd8iWUlnEz6+dPqsi7ddyEfK6ixAEEZrwWW1E8GafIKQVP7AO0InB/orccRg==
X-Google-Smtp-Source: AGHT+IGYiMn3jieoglt5EaDwtTABS1lQ7XOYjstaJzvmaH1fcBe9vU372TzFLpDxOPfBcxSuOS8Twkd59UTtaIkCkg==
X-Received: from plau15.prod.google.com ([2002:a17:903:304f:b0:26a:e046:7605])
 (user=danielmentz job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e946:b0:269:6052:3536 with SMTP id d9443c01a7336-27ed4a4937dmr133470415ad.45.1759012812970;
 Sat, 27 Sep 2025 15:40:12 -0700 (PDT)
Date: Sat, 27 Sep 2025 22:39:53 +0000
In-Reply-To: <20250927223953.936562-1-danielmentz@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250927223953.936562-1-danielmentz@google.com>
X-Mailer: git-send-email 2.51.0.570.gb178f27e6d-goog
Message-ID: <20250927223953.936562-2-danielmentz@google.com>
Subject: [PATCH 2/2] drivers/arm-smmu-v3: Implement .iotlb_sync_map callback
From: Daniel Mentz <danielmentz@google.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Liviu Dudau <liviu.dudau@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Rob Clark <robin.clark@oss.qualcomm.com>, Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"

Implement .iotlb_sync_map callback based on the new callback in the
io-pgtable code.

Signed-off-by: Daniel Mentz <danielmentz@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2a8b46b948f0..0ffcc6c8e4bf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2541,6 +2541,7 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
 	pgtbl_cfg = (struct io_pgtable_cfg) {
 		.pgsize_bitmap	= smmu->pgsize_bitmap,
 		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
+		.defer_sync_pte	= true,
 		.tlb		= &arm_smmu_flush_ops,
 		.iommu_dev	= smmu->dev,
 	};
@@ -3366,6 +3367,18 @@ static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
 	return ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot, gfp, mapped);
 }
 
+static int arm_smmu_iotlb_sync_map(struct iommu_domain *domain,
+				    unsigned long iova, size_t size)
+{
+	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
+
+	if (!ops || !ops->iotlb_sync_map)
+		return 0;
+
+	ops->iotlb_sync_map(ops, iova, size);
+	return 0;
+}
+
 static size_t arm_smmu_unmap_pages(struct iommu_domain *domain, unsigned long iova,
 				   size_t pgsize, size_t pgcount,
 				   struct iommu_iotlb_gather *gather)
@@ -3700,6 +3713,7 @@ static const struct iommu_ops arm_smmu_ops = {
 		.map_pages		= arm_smmu_map_pages,
 		.unmap_pages		= arm_smmu_unmap_pages,
 		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
+		.iotlb_sync_map		= arm_smmu_iotlb_sync_map,
 		.iotlb_sync		= arm_smmu_iotlb_sync,
 		.iova_to_phys		= arm_smmu_iova_to_phys,
 		.free			= arm_smmu_domain_free_paging,
-- 
2.51.0.570.gb178f27e6d-goog

