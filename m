Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A3E207A2E
	for <iommu@lists.linux.dev>; Wed,  6 Nov 2024 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730907979; cv=none; b=GDUna787+1fHFK31voX1i68OSmFBpbNwdOhRGSXn5jAGv2ujJLhjUwlJq7OxN2KXEsNfwdddyGEe2ZjkzELKGoJMX3wYViyl4jfa2gg1gfXWR/qQgU8dE9SmwLRwIICEWzOwqVtGHmoz3XMpIUhBKisw7lIZIKvNi5t0M16ZQis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730907979; c=relaxed/simple;
	bh=RXe1e0lpDmoY4yOdlKQD+FyrfZS6AMGHeVy4+CirLKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qh4JN72Jhp2iW+GWd1rK6E/BJ95qYfah/IiDTmSZkO5umWNcdl5IuVPUb5IyB4O6e/CGRzA4CVmCYJb4w7hxbVqYCSw6sXPEgkZsezLN+1VoDiHUHWmGSdZhpTcbTGVoXesiTblc7K/gfeRaoyf5ih9QCSixIj2V2OluoJnTb90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yzlw4HwY; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yzlw4HwY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730907977; x=1762443977;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RXe1e0lpDmoY4yOdlKQD+FyrfZS6AMGHeVy4+CirLKU=;
  b=Yzlw4HwYEe1jRwatJXKiqEKaq60/4+exE9A1tI+EIIeJu2BFkvlvjvKh
   LnBQoLdTEyLCQgihxmxjI7FYBpffkr4BUoWdZcdt1X3NT6JpILEMExJxy
   U8B+FgSK7JADDUPXqrm16AA2MSA71976huoAF54b3GMZUOD8lHGXfReho
   yrZBxpptgOu6uYw2NAmyORVFRx87ZWqesfHGKfwLlO3pq5h3keSjx8EbA
   hbkZq8tW0Sq4GkdlGv0cJu4ZE2v0YFn76JU1OC+Eeg4p9kv0QvpKEvUCE
   bfOK+gJZ0COKUe5JrVvvmbSUvtvVcS+wRx4gpCKF9Hx2vjq6EGGM9GtY7
   Q==;
X-CSE-ConnectionGUID: AnPBh3xMQheevDVEVFrZ9Q==
X-CSE-MsgGUID: 5RAkhi2pTmWr8M5otkj07w==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="48174301"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="48174301"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 07:46:13 -0800
X-CSE-ConnectionGUID: yuzx9q4USVW0O45JxmaVdw==
X-CSE-MsgGUID: FKhxTiL9QEaGP9nB0nR3fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="89468273"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa005.jf.intel.com with ESMTP; 06 Nov 2024 07:46:12 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	jgg@nvidia.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com,
	eric.auger@redhat.com,
	nicolinc@nvidia.com,
	kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com,
	yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	zhenzhong.duan@intel.com,
	vasant.hegde@amd.com,
	willy@infradead.org
Subject: [PATCH v5 12/13] iommu/arm-smmu-v3: Make set_dev_pasid() op support replace
Date: Wed,  6 Nov 2024 07:46:05 -0800
Message-Id: <20241106154606.9564-13-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106154606.9564-1-yi.l.liu@intel.com>
References: <20241106154606.9564-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

set_dev_pasid() op is going to be enhanced to support domain replacement
of a pasid. This prepares for this op definition.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 2 +-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 9 +++------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 2 +-
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 645da7b69bed..1d3e71569775 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -349,7 +349,7 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
 	 * get reassigned
 	 */
 	arm_smmu_make_sva_cd(&target, master, domain->mm, smmu_domain->cd.asid);
-	ret = arm_smmu_set_pasid(master, smmu_domain, id, &target);
+	ret = arm_smmu_set_pasid(master, smmu_domain, id, &target, old);
 
 	mmput(domain->mm);
 	return ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a66d9a044e52..7ee3cbbe3744 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2901,7 +2901,7 @@ static int arm_smmu_s1_set_dev_pasid(struct iommu_domain *domain,
 	 */
 	arm_smmu_make_s1_cd(&target_cd, master, smmu_domain);
 	return arm_smmu_set_pasid(master, to_smmu_domain(domain), id,
-				  &target_cd);
+				  &target_cd, old);
 }
 
 static void arm_smmu_update_ste(struct arm_smmu_master *master,
@@ -2931,16 +2931,13 @@ static void arm_smmu_update_ste(struct arm_smmu_master *master,
 
 int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
-		       struct arm_smmu_cd *cd)
+		       struct arm_smmu_cd *cd, struct iommu_domain *old)
 {
 	struct iommu_domain *sid_domain = iommu_get_domain_for_dev(master->dev);
 	struct arm_smmu_attach_state state = {
 		.master = master,
-		/*
-		 * For now the core code prevents calling this when a domain is
-		 * already attached, no need to set old_domain.
-		 */
 		.ssid = pasid,
+		.old_domain = old,
 	};
 	struct arm_smmu_cd *cdptr;
 	int ret;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index c9e5290e995a..1e96d4af03f8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -879,7 +879,7 @@ void arm_smmu_write_cd_entry(struct arm_smmu_master *master, int ssid,
 
 int arm_smmu_set_pasid(struct arm_smmu_master *master,
 		       struct arm_smmu_domain *smmu_domain, ioasid_t pasid,
-		       struct arm_smmu_cd *cd);
+		       struct arm_smmu_cd *cd, struct iommu_domain *old);
 
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
-- 
2.34.1

