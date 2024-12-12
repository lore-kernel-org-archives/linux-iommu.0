Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8659F240360
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 18:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026791; cv=none; b=TZ8ewPd2Bp5jwtUIKoDu3cJSKyrjQMa2kdBfFAy6sUbjiN6lpcDCbWU5WDMho4Td0riRlYlR7k7KmnJJd6c459mbwqFQyA7OtIb67ZMqPfyEsqFV5Guxy81TXBKiSw5PW/uAVbbtFBwpdNBfVrPGZ31cHhrlFkURYe4JznS1G7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026791; c=relaxed/simple;
	bh=GZlHSVCi9DCDsyP55JASUXXIEwXOMYR8FDYiO32tVeg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f6KCrelfo7s6MHoTPXhiuTIslsThaToQDDMckAIpd8w4z3Bp7S5P57m7sytaY2xxn5Z7WUVFZuvl+Ey8YnVc/OHjUeolAfLKB/3xub9qlL5n7jbS1PM4wTHO5dqHSPbbtw6chx8l0b5Ib2vKtXhomhwPk1Q1LCY3JW2VBiR06YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p0V8qyTe; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p0V8qyTe"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3862e986d17so428623f8f.3
        for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 10:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734026788; x=1734631588; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FlfJ2RoRGMYx/VEn6wy5+97mQsVAl5qyYx+2pIE2d8k=;
        b=p0V8qyTeE305uj+jMxkQZ4tdnaaaL/aWR7lLOvU5eJuLJZ8uKgWh09lIYGHYsyccaZ
         LG8TTonwAGqBTotMsnVXDi//v9q2YLDaz7rHvOWCtvZVKhjEjwuHbXXHdm/FxaUm7xVd
         X6Zz67aYD5OQttIuOd9FaufF4YRR4TfmKYgolovoQucMwvswJlVWJh92K7nrSP2htdvB
         Hkjxm6m91ivWgttassCoGWyRCl19CO5jM2EQ0yKLhxB+qjIz9iZj2HsF2AGjnkVW4PEt
         NbXgpTIp8Sjr6esEZLo/nopqRSx+KUTzQJfpRCDPXY9iMBIIBxuFnvBNxxfTjiqYXS2y
         SoXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026788; x=1734631588;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlfJ2RoRGMYx/VEn6wy5+97mQsVAl5qyYx+2pIE2d8k=;
        b=NBJRmBlKmpgZkEaBnXAwIHTkQml4RzAgurBgOnsbOlzK2WaIfx8OF64GBGbqFkmQr3
         ysOaf5mVbjPHOI/c1FGomNniH9O/9HdPt8EHLC4N+7vVtv6RaCrauLZqlmwS18tYOKcp
         SwOI057ZuAiJ/AxfZa1BxVxrkd5QziWV2YBZwsxRCaPYP2Inpc8MODqa0hPajdOLSxNj
         B0QsOOnmIS/CogMmqF7cl6BzEMOowA1/HlcujYvKSl9+1btDPXKsaNZfpBh3Wbl6/sWi
         CUk5fw57U//g2Jrd6qBqz+NcCG0LjoKhbL34Vz1QN8lyR93L/dRpxf9KF/mrpEHj3PgI
         fYAw==
X-Gm-Message-State: AOJu0YwSfUPRBu9YCmr7gQkY4zYFIor/ldHB2dnLKh1aHKd16SIokif7
	02csieRZaZ3syMh+EDdh49mwPty2g7lH3i7ZFw7frsUeiPGQQz70Er7gtnSsmgNXlxf4TEu96O5
	vAjlFMjwE+er62luFQJ3TJHRfRnEDYEpPYSnwbsHF2VNJbK0/tNJJtS3W2gzYQw5IC8xkd86jF0
	ag3JMMM2hBhsgPjSOX/v6EgSHExSr8gE6oPTFTWrxTiQ==
X-Google-Smtp-Source: AGHT+IGJYqzxLBeZXH8b4nITiRWycPugiMNUuQieYr7f4NE4ezaD/pAg6hUBcibKZ+vgqVmM+kM3IYkR8ouErw==
X-Received: from wmmu14.prod.google.com ([2002:a05:600c:ce:b0:434:f0a3:7876])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:154a:b0:385:ef2f:92ad with SMTP id ffacd0b85a97d-3864ce86a7fmr7352121f8f.10.1734026788086;
 Thu, 12 Dec 2024 10:06:28 -0800 (PST)
Date: Thu, 12 Dec 2024 18:04:14 +0000
In-Reply-To: <20241212180423.1578358-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20241212180423.1578358-1-smostafa@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212180423.1578358-51-smostafa@google.com>
Subject: [RFC PATCH v2 50/58] iommu/arm-smmu-v3-kvm: Add map, unmap and
 iova_to_phys operations
From: Mostafa Saleh <smostafa@google.com>
To: iommu@lists.linux.dev, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, robdclark@gmail.com, joro@8bytes.org, 
	robin.murphy@arm.com, jean-philippe@linaro.org, jgg@ziepe.ca, 
	nicolinc@nvidia.com, vdonnefort@google.com, qperret@google.com, 
	tabba@google.com, danielmentz@google.com, tzukui@google.com, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

Add map, unmap and iova_to_phys, which are forwarded to the
hypervisor.

Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
index 071743f5acf9..82f0191b222c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
@@ -331,6 +331,75 @@ static bool kvm_arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 	}
 }
 
+static int kvm_arm_smmu_map_pages(struct iommu_domain *domain,
+				  unsigned long iova, phys_addr_t paddr,
+				  size_t pgsize, size_t pgcount, int prot,
+				  gfp_t gfp, size_t *total_mapped)
+{
+	size_t mapped;
+	size_t size = pgsize * pgcount;
+	struct kvm_arm_smmu_domain *kvm_smmu_domain = to_kvm_smmu_domain(domain);
+	struct arm_smccc_res res;
+
+	do {
+		res = kvm_call_hyp_nvhe_smccc(__pkvm_host_iommu_map_pages,
+					      kvm_smmu_domain->id,
+					      iova, paddr, pgsize, pgcount, prot);
+		mapped = res.a1;
+		iova += mapped;
+		paddr += mapped;
+		WARN_ON(mapped % pgsize);
+		WARN_ON(mapped > pgcount * pgsize);
+		pgcount -= mapped / pgsize;
+		*total_mapped += mapped;
+	} while (*total_mapped < size && !kvm_arm_smmu_topup_memcache(&res, gfp));
+	if (*total_mapped < size)
+		return -EINVAL;
+
+	return 0;
+}
+
+static size_t kvm_arm_smmu_unmap_pages(struct iommu_domain *domain,
+				       unsigned long iova, size_t pgsize,
+				       size_t pgcount,
+				       struct iommu_iotlb_gather *iotlb_gather)
+{
+	size_t unmapped;
+	size_t total_unmapped = 0;
+	size_t size = pgsize * pgcount;
+	struct kvm_arm_smmu_domain *kvm_smmu_domain = to_kvm_smmu_domain(domain);
+	struct arm_smccc_res res;
+
+	do {
+		res = kvm_call_hyp_nvhe_smccc(__pkvm_host_iommu_unmap_pages,
+					      kvm_smmu_domain->id,
+					      iova, pgsize, pgcount);
+		unmapped = res.a1;
+		total_unmapped += unmapped;
+		iova += unmapped;
+		WARN_ON(unmapped % pgsize);
+		pgcount -= unmapped / pgsize;
+
+		/*
+		 * The page table driver can unmap less than we asked for. If it
+		 * didn't unmap anything at all, then it either reached the end
+		 * of the range, or it needs a page in the memcache to break a
+		 * block mapping.
+		 */
+	} while (total_unmapped < size &&
+		 (unmapped || !kvm_arm_smmu_topup_memcache(&res, GFP_ATOMIC)));
+
+	return total_unmapped;
+}
+
+static phys_addr_t kvm_arm_smmu_iova_to_phys(struct iommu_domain *domain,
+					     dma_addr_t iova)
+{
+	struct kvm_arm_smmu_domain *kvm_smmu_domain = to_kvm_smmu_domain(domain);
+
+	return kvm_call_hyp_nvhe(__pkvm_host_iommu_iova_to_phys, kvm_smmu_domain->id, iova);
+}
+
 static struct iommu_ops kvm_arm_smmu_ops = {
 	.capable		= kvm_arm_smmu_capable,
 	.device_group		= arm_smmu_device_group,
@@ -344,6 +413,9 @@ static struct iommu_ops kvm_arm_smmu_ops = {
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= kvm_arm_smmu_attach_dev,
 		.free		= kvm_arm_smmu_domain_free,
+		.map_pages	= kvm_arm_smmu_map_pages,
+		.unmap_pages	= kvm_arm_smmu_unmap_pages,
+		.iova_to_phys	= kvm_arm_smmu_iova_to_phys,
 	}
 };
 
-- 
2.47.0.338.g60cca15819-goog

