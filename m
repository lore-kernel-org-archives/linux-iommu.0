Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E354F320CC2
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 23:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764716629; cv=none; b=AXRnUe4wOQkRuEwUdr+77iuJj75bPdIAY5rAu2kdiFT4f/PClCmKb59RtFvDuepN/Njyg3ggGo6wntDxKdggaw5sYZgBAXvg01cYSsp45CIVeVSoIYomu0dD5WXtpzh8ORAgUMxcpYQaR+QBUmZTptmlyGL9an/LMIy0m0zWhdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764716629; c=relaxed/simple;
	bh=N3EqjwtTe9su2bIBiTmXGew4mmqSpg+pDjvGW6S4hCo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N4Leogx2SIpj6eVgaBx3hgqVV09sHwr/EgBUsSXPMckJx5IUC3x8C8V93+w0bhJs0rLR8+ibnEEH6quB7Be463DIF4j1RPkQeuvcKEAKo+rdW4lNBVggUm3moPAezX+NHsbQwUreaSjpayaetxXG3ZiPLi81weWLEnnQqHn+LZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v41fNwmw; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v41fNwmw"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7b96038aa68so262909b3a.0
        for <iommu@lists.linux.dev>; Tue, 02 Dec 2025 15:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764716627; x=1765321427; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DNSA26/0+alws+cJX6nlD69kg695LZYJa/y+ifDRVVk=;
        b=v41fNwmwPC672RXbjKUPWfPHsG0aUzUZthts476Ig0Cnr++PVnxFeyWsUsrpYrl/gv
         I9Bg/fFACwSNV72eTb6j2+JMFtQc1jwqbkHWAvALcK7yL3Ei8Q8LjlMnIkcAKRnCIatQ
         SZrrYO2ns0g5ype1lc7gcMC5ho3zIQLjlWGPevkee1MECwj9S6vloiV6fQbf6ahFCu5y
         YEa/jfhtiB5k4VKnohMaex7Uh5/VSOKN0HVrIGpt4J6TMT7OM5lXSgF2JcumZKnnPxOK
         PG6R+sJWUY+JlHPs2fDdf1so9K6NTD66sD6l1oSp7bx/OwbrJTswUxC4DXR6Ey7gI3C+
         HVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764716627; x=1765321427;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DNSA26/0+alws+cJX6nlD69kg695LZYJa/y+ifDRVVk=;
        b=TUDDLB8D28QyadLu7Nb/fsHo5NcFyOv8ko1lPaTAt60VZJXfRfoznmcK91tuQ+ox6n
         WEh51kEDhImkjsoajlu5uhRHjvQKbAAwnlFb/dF6VU7sWqFu1OzObjqtrTJqfGsYENde
         JQOYUIxfhLbEQ3onxstszTeoWGre3YGBnlUWcuRK+qlagBa1IBN+UUFAxZR9xx1w6AsR
         8FjkAxnriFRYB21/yKAoWUM1atthSOTiLZC9JlbAzZ7zC4nZCke1yj0af9KIkL4FGz7X
         +6S9fO5Nuodh5UbIPHmiL9FB0Q3AVBAufeAYgyuJVi9Th+KVqRQDpEERBbOPdfI8D0RI
         snqw==
X-Forwarded-Encrypted: i=1; AJvYcCU90W+7V8CyaSBodpfPC985/lpQ9Th962WFKC9mls+jXpxBh5G643XjL1ZHRAbX8sOXN+azbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzo6TmY8JCQukXK3VRBQBlD1NuIX6jevaZi4NtM+zl19WRRzXS1
	hQQx5qjZqK0ri/lWIl3Xj5Bzm+tUdF/XFfFLLI5oNC94xIawWaWOre28FtbTbewKk1qOnxuYvyM
	kKqOE9tPx2Nj1Ag==
X-Google-Smtp-Source: AGHT+IEQcTdBsG+lezU0a0aTxC6nQMJIRJmCEjaChT/fOWKOUkp2R6PTeSxb+1Ke6yUnV01KNpqjsxktw4Uf7w==
X-Received: from pfbfh23.prod.google.com ([2002:a05:6a00:3917:b0:7a5:9e0b:aed9])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d43:b0:7aa:d1d4:bb7b with SMTP id d2e1a72fcca58-7dff4758789mr341995b3a.16.1764716627187;
 Tue, 02 Dec 2025 15:03:47 -0800 (PST)
Date: Tue,  2 Dec 2025 23:02:58 +0000
In-Reply-To: <20251202230303.1017519-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251202230303.1017519-1-skhawaja@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251202230303.1017519-29-skhawaja@google.com>
Subject: [RFC PATCH v2 28/32] iommu/vt-d: reuse the preserved domain id for
 preserved devices
From: Samiullah Khawaja <skhawaja@google.com>
To: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev
Cc: Samiullah Khawaja <skhawaja@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, linux-kernel@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Vipin Sharma <vipinsh@google.com>, dmatlack@google.com, YiFei Zhu <zhuyifei@google.com>, 
	Chris Li <chrisl@kernel.org>, praan@google.com
Content-Type: text/plain; charset="UTF-8"

Preserved devices have their domain ids preserved by the previous
kernel. During restore and reattach in the next kernel the domain ids
are already reclaimed so reuse the presered domain id.

Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 drivers/iommu/intel/iommu.c  | 42 +++++++++++++++++++++++-------------
 drivers/iommu/intel/iommu.h  |  3 ++-
 drivers/iommu/intel/nested.c |  2 +-
 3 files changed, 30 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 888351f91918..177bf1b2715f 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1033,7 +1033,8 @@ static bool first_level_by_default(struct intel_iommu *iommu)
 	return true;
 }
 
-int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
+int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu,
+			int restore_did)
 {
 	struct iommu_domain_info *info, *curr;
 	int num, ret = -ENOSPC;
@@ -1053,8 +1054,11 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 		return 0;
 	}
 
-	num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
-			      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
+	if (restore_did >= 0)
+		num = restore_did;
+	else
+		num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
+				      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
 	if (num < 0) {
 		pr_err("%s: No free domain ids\n", iommu->name);
 		goto err_unlock;
@@ -1325,10 +1329,16 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
+	struct device_ser *device_ser = NULL;
 	unsigned long flags;
 	int ret;
 
-	ret = domain_attach_iommu(domain, iommu);
+#ifdef CONFIG_LIVEUPDATE
+	device_ser = dev_iommu_restored_state(dev);
+#endif
+
+	ret = domain_attach_iommu(domain, iommu,
+				  dev_iommu_restore_did(dev, &domain->domain));
 	if (ret)
 		return ret;
 
@@ -1341,16 +1351,18 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	if (dev_is_real_dma_subdevice(dev))
 		return 0;
 
-	if (!sm_supported(iommu))
-		ret = domain_context_mapping(domain, dev);
-	else if (intel_domain_is_fs_paging(domain))
-		ret = domain_setup_first_level(iommu, domain, dev,
-					       IOMMU_NO_PASID, NULL);
-	else if (intel_domain_is_ss_paging(domain))
-		ret = domain_setup_second_level(iommu, domain, dev,
-						IOMMU_NO_PASID, NULL);
-	else if (WARN_ON(true))
-		ret = -EINVAL;
+	if (!device_ser) {
+		if (!sm_supported(iommu))
+			ret = domain_context_mapping(domain, dev);
+		else if (intel_domain_is_fs_paging(domain))
+			ret = domain_setup_first_level(iommu, domain, dev,
+						       IOMMU_NO_PASID, NULL);
+		else if (intel_domain_is_ss_paging(domain))
+			ret = domain_setup_second_level(iommu, domain, dev,
+							IOMMU_NO_PASID, NULL);
+		else if (WARN_ON(true))
+			ret = -EINVAL;
+	}
 
 	if (ret)
 		goto out_block_translation;
@@ -3612,7 +3624,7 @@ domain_add_dev_pasid(struct iommu_domain *domain,
 	if (!dev_pasid)
 		return ERR_PTR(-ENOMEM);
 
-	ret = domain_attach_iommu(dmar_domain, iommu);
+	ret = domain_attach_iommu(dmar_domain, iommu, -1);
 	if (ret)
 		goto out_free;
 
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index b0c56e27f167..aa336050015e 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1174,7 +1174,8 @@ void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
  */
 #define QI_OPT_WAIT_DRAIN		BIT(0)
 
-int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
+int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu,
+			int restore_did);
 void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
 void device_block_translation(struct device *dev);
 int paging_domain_compatible(struct iommu_domain *domain, struct device *dev);
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index a3fb8c193ca6..4fed9f5981e5 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -40,7 +40,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
 		return ret;
 	}
 
-	ret = domain_attach_iommu(dmar_domain, iommu);
+	ret = domain_attach_iommu(dmar_domain, iommu, -1);
 	if (ret) {
 		dev_err_ratelimited(dev, "Failed to attach domain to iommu\n");
 		return ret;
-- 
2.52.0.158.g65b55ccf14-goog

