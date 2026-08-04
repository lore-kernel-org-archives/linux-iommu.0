Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEB7386422
	for <iommu@lists.linux.dev>; Tue,  4 Aug 2026 02:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811737; cv=none; b=PHmGXoqmQLl9xKRDmrUFs4wnnFhVkrIDJf2gCPSzigqXy25krqncopYspQu0HEHxTEqnELBwLRXaK6KgCSpZSagW8/e60AjcU9cgI+Zqyad1dnb5CxkKgB2nyAkBWMjtmK4jnFLQmUAVa8+fiuGi4H8ouh4glhJVeuD2FlkR01c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811737; c=relaxed/simple;
	bh=bYxhmqmIFX9Vs3YJLdvrfZ/i13mZ7a4GJErjKqVa80A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTVrFlO3buT6c9xr5fcOluwe+eMVXCfIBSFEaSnnB6RwBGTD8X2FPtAmMcruwYQ6uXRdN4ScGsMluIWdINYPsdR3dBQF6P2pA+dFOl6D7OmzUAGNw2Aa1ZJFJYeYZzEu45QEgg8n394maAy0LfwrnltBFM00pjfjy7Rup6f0opE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YUUuK09o; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YUUuK09o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785811736; x=1817347736;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bYxhmqmIFX9Vs3YJLdvrfZ/i13mZ7a4GJErjKqVa80A=;
  b=YUUuK09ojZOpD0odheKSquZzpIxjvLk1CiZBjVFLPMFAm+nIdBxWoWiL
   N5uYN4LAKQ/cUk8OGEMIzO970OhOeXZ7vmkUCkhyjg1sdMQyvGrDgI2KA
   nuK/quVVaLwvTO/FBKfIbXWd/KRw/rQV6/Hnr7NnHFFwVFXJtIwtgHhx0
   EmgIOx99lUpQyGag99dnf2RvXHhkcTvTzJMnd3mBwkqNOHo8+JWs4LwLU
   Vso9MlsWSvYlKgG/m8LMNCoI+x7G2bl/8zgLo4JonyEQ6e/gjYT8JpTcM
   ttEs9vCGGYi+wK2cLxViR8F6IzNR1BdUXz1jsCYSfaOScvscHHme1Vb9v
   g==;
X-CSE-ConnectionGUID: xLKy5WJ4RHWtfzD6B40W9Q==
X-CSE-MsgGUID: IfoZomfGQcqFnNiX0E4Dxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86231338"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86231338"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 19:48:55 -0700
X-CSE-ConnectionGUID: J48bjZ5VT/ev0XZHKw4CvQ==
X-CSE-MsgGUID: ayQfe9fhQOGNf+DEnL7NQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="259587576"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa006.jf.intel.com with ESMTP; 03 Aug 2026 19:48:53 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: ZhaoJinming <zhaojinming@uniontech.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	Li RongQing <lirongqing@baidu.com>,
	Desnes Nunes <desnesn@redhat.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/20] iommu/vt-d: Cache max domain ID to avoid redundant calculation
Date: Tue,  4 Aug 2026 10:37:08 +0800
Message-ID: <20260804023714.3080506-15-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
References: <20260804023714.3080506-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cap_ndoms() helper calculates the maximum available domain ID from
the value of capability register, which can be inefficient if called
repeatedly. Cache the maximum supported domain ID in max_domain_id field
during initialization to avoid redundant calls to cap_ndoms() throughout
the IOMMU driver.

No functionality change.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel/iommu.h |  1 +
 drivers/iommu/intel/dmar.c  |  1 +
 drivers/iommu/intel/iommu.c | 10 +++++-----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 656cd311ed9a..c00f44db0020 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -700,6 +700,7 @@ struct intel_iommu {
 	/* mutex to protect domain_ida */
 	struct mutex	did_lock;
 	struct ida	domain_ida; /* domain id allocator */
+	unsigned long	max_domain_id;
 	unsigned long	*copied_tables; /* bitmap of copied tables */
 	spinlock_t	lock; /* protect context, domain ids */
 	struct root_entry *root_entry; /* virtual address */
diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index 33bfaeafa7c6..c854173f6be9 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1174,6 +1174,7 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
 	spin_lock_init(&iommu->lock);
 	ida_init(&iommu->domain_ida);
 	mutex_init(&iommu->did_lock);
+	iommu->max_domain_id = cap_ndoms(iommu->cap);
 
 	ver = readl(iommu->reg + DMAR_VER_REG);
 	pr_info("%s: reg_base_addr %llx ver %d:%d cap %llx ecap %llx\n",
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index a996b72aca57..5ea584b76f77 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1047,7 +1047,7 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
 	}
 
 	num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
-			      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
+			      iommu->max_domain_id - 1, GFP_KERNEL);
 	if (num < 0) {
 		pr_err("%s: No free domain ids\n", iommu->name);
 		goto err_unlock;
@@ -1111,7 +1111,7 @@ static void copied_context_tear_down(struct intel_iommu *iommu,
 	did_old = context_domain_id(context);
 	context_clear_entry(context);
 
-	if (did_old < cap_ndoms(iommu->cap)) {
+	if (did_old < iommu->max_domain_id) {
 		iommu->flush.flush_context(iommu, did_old,
 					   PCI_DEVID(bus, devfn),
 					   DMA_CCMD_MASK_NOBIT,
@@ -1511,7 +1511,7 @@ static int copy_context_table(struct intel_iommu *iommu,
 			continue;
 
 		did = context_domain_id(&ce);
-		if (did >= 0 && did < cap_ndoms(iommu->cap))
+		if (did >= 0 && did < iommu->max_domain_id)
 			ida_alloc_range(&iommu->domain_ida, did, did, GFP_KERNEL);
 
 		set_context_copied(iommu, bus, devfn);
@@ -2431,7 +2431,7 @@ static ssize_t domains_supported_show(struct device *dev,
 				      struct device_attribute *attr, char *buf)
 {
 	struct intel_iommu *iommu = dev_to_intel_iommu(dev);
-	return sysfs_emit(buf, "%ld\n", cap_ndoms(iommu->cap));
+	return sysfs_emit(buf, "%ld\n", iommu->max_domain_id);
 }
 static DEVICE_ATTR_RO(domains_supported);
 
@@ -2442,7 +2442,7 @@ static ssize_t domains_used_show(struct device *dev,
 	unsigned int count = 0;
 	int id;
 
-	for (id = 0; id < cap_ndoms(iommu->cap); id++)
+	for (id = 0; id < iommu->max_domain_id; id++)
 		if (ida_exists(&iommu->domain_ida, id))
 			count++;
 
-- 
2.43.0

