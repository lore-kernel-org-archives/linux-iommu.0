Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4ED04778E
	for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 14:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718374956; cv=none; b=WymisaXhvKgxSXfx+YSiWNNhOz+8vQg/pvmxQTYU1mumCvDjQV8A5W7raFavAWEX0b4lX3wh4xdfdWOKBBaGHk8DdZxRDOTwWabMyuTYar6fESMSBAUtsCX2HeYbY3WP4g0Wo3traSqEqG1F0JP/+kGHi5R+1gy0h0f5tgcm14A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718374956; c=relaxed/simple;
	bh=7Yb/SMMlZn1tJaUWC6e7+SVPbq9JvQRpG9Rr2Zf6yls=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uH5EMnvTCNS5VrlW31jROHxFYXgzLW0/3qwvKvi/5xYeDZ5NGL2EhqOscXSrheWDgwhpAX7Eb1HYjP3vYHIP+83SYie2DRx5U0TXmzH8XekpSPX4hJCSEwVsBr8CFRwh4sZTiPVnShkKFV+iBQUYjb7VpaffyWlCNTfaz5caoJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=PHeRzw4h; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PHeRzw4h"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f6f1677b26so16574105ad.0
        for <iommu@lists.linux.dev>; Fri, 14 Jun 2024 07:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718374953; x=1718979753; darn=lists.linux.dev;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BxtO7IOLUtPSQ+XdcXJ6pDuSrhddnSGqhgchDX3PwwI=;
        b=PHeRzw4hACtnFWhaH/VYnzigPFv/ypi3rtXqUYTidyjgG3BQ6TTfEY0nsyt+4nnoSg
         2gESZ8dxwu0p4O3VvWceRkxEeVPPU3VTVacoX4z7aiVQI2ne3WCxFb1L2utOhJyFKyE7
         ATewOPT2U5yrcSCCucqFt0/fh46eJ+K/rqCYZRcx3torvjUiuAfjwNAFN2UV3r3ATax4
         C+dKJSrOJqc/BQeEq+9JdkF/SQK8szhj+tvG/MVGKl1uOopgyJLA3dGph+eKlGx0NfRa
         /twk6ZtsIznBOkQ07WKunatCvUZaNvf5sCHGKjlPBMLXL/3Gm0L2phRTK63X+QBhSwHa
         brMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718374953; x=1718979753;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxtO7IOLUtPSQ+XdcXJ6pDuSrhddnSGqhgchDX3PwwI=;
        b=Yr1qaPTY9hfyMJj7PMd6K8aZ9GXe4myT/HKBXtz/t/uLTf7GbA+1H+7U1Obs790XtY
         yS5QKm7IH5ZBJh8L02ewRe6BVtkxnyrfluXMtF5KM6BJnufTzaifzeP/HzjH/TxnFe4H
         wAuNcSY6sT/vNCe4YTUnrruySwEniJnC/iEfyYNKjmc95p6TTInwKzMsRqAGYr/ODVIk
         LtKDOHI5qpPOHEQ/C/X+HBQDrenPV9Fr1ZxYnl0gb2Y0T+nFNXekq+gl7dld7s0jxtU+
         +DL6NQEt3NZ0n0tccg5ySsHC0YvU/kbO1sBpr6suTqVYAa86AGanh1//9X8ITmKJlnmY
         zaMw==
X-Forwarded-Encrypted: i=1; AJvYcCW0AGIiAqo5/QB8bi45evfKY5J93Cb5i7/Jq9lGybN/IIDcgml3daZDXy9tTVOakEsmiV3y5M3qUg1Felg1UiTMO4Mx7h8=
X-Gm-Message-State: AOJu0YxI8x1Z3j3EHYFFuZ7GNZVLzxrRpF/TyV30qCQWgOi3eRqCyQVs
	lSgkRcN9UqoMUj2qAf9Xz+MGh4Z5kJUm87YyvBpaOYGAyhz9jSV7tml8RNsL9Nk=
X-Google-Smtp-Source: AGHT+IG11s4ZHx3p3pdh0/8168TEMxbmtzHZ+b6vnWRUAkFpilwyNQyd4ZLsjbcQgl8XVHvD/vsepw==
X-Received: by 2002:a17:902:cccc:b0:1f7:126:5ba7 with SMTP id d9443c01a7336-1f84e42e7bamr92287235ad.21.1718374952848;
        Fri, 14 Jun 2024 07:22:32 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e559d9sm32522005ad.35.2024.06.14.07.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 07:22:32 -0700 (PDT)
From: Zong Li <zong.li@sifive.com>
To: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	tjeznach@rivosinc.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org
Cc: Nicolin Chen <nicolinc@nvidia.com>
Subject: [RFC PATCH v2 09/10] iommu/dma: Support MSIs through nested domains
Date: Fri, 14 Jun 2024 22:21:55 +0800
Message-Id: <20240614142156.29420-10-zong.li@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240614142156.29420-1-zong.li@sifive.com>
References: <20240614142156.29420-1-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

From: Robin Murphy <robin.murphy@arm.com>

Currently, iommu-dma is the only place outside of IOMMUFD and drivers
which might need to be aware of the stage 2 domain encapsulated within
a nested domain. This would be in the legacy-VFIO-style case where we're
using host-managed MSIs with an identity mapping at stage 1, where it is
the underlying stage 2 domain which owns an MSI cookie and holds the
corresponding dynamic mappings. Hook up the new op to resolve what we
need from a nested domain.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/dma-iommu.c | 18 ++++++++++++++++--
 include/linux/iommu.h     |  4 ++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index f731e4b2a417..d4235bb0a427 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1806,6 +1806,20 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return NULL;
 }
 
+/*
+ * Nested domains may not have an MSI cookie or accept mappings, but they may
+ * be related to a domain which does, so we let them tell us what they need.
+ */
+static struct iommu_domain *iommu_dma_get_msi_mapping_domain(struct device *dev)
+{
+	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+
+	if (domain && domain->type == IOMMU_DOMAIN_NESTED &&
+	    domain->ops->get_msi_mapping_domain)
+		domain = domain->ops->get_msi_mapping_domain(domain);
+	return domain;
+}
+
 /**
  * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
  * @desc: MSI descriptor, will store the MSI page
@@ -1816,7 +1830,7 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 {
 	struct device *dev = msi_desc_to_dev(desc);
-	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	struct iommu_domain *domain = iommu_dma_get_msi_mapping_domain(dev);
 	struct iommu_dma_msi_page *msi_page;
 	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
 
@@ -1849,7 +1863,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
 {
 	struct device *dev = msi_desc_to_dev(desc);
-	const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
+	const struct iommu_domain *domain = iommu_dma_get_msi_mapping_domain(dev);
 	const struct iommu_dma_msi_page *msi_page;
 
 	msi_page = msi_desc_get_iommu_cookie(desc);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 7bc8dff7cf6d..400df9ae7012 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -629,6 +629,8 @@ struct iommu_ops {
  * @enable_nesting: Enable nesting
  * @set_pgtable_quirks: Set io page table quirks (IO_PGTABLE_QUIRK_*)
  * @free: Release the domain after use.
+ * @get_msi_mapping_domain: Return the related iommu_domain that should hold the
+ *                          MSI cookie and accept mapping(s).
  */
 struct iommu_domain_ops {
 	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
@@ -659,6 +661,8 @@ struct iommu_domain_ops {
 				  unsigned long quirks);
 
 	void (*free)(struct iommu_domain *domain);
+	struct iommu_domain *
+		(*get_msi_mapping_domain)(struct iommu_domain *domain);
 };
 
 /**
-- 
2.17.1

