Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F92222EE5
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 03:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737342526; cv=none; b=RkCDmshzw8MNxLCDseGWv14xUWtwRCA1a3i8QZ+2gamJ3b840aMPJteaYBXOOYJPcCthfIH0ITjBkW/R5m27+hPh4DVPguIpIZnCCcbcZtGjqWCxTqW8dmi1Snp59Ha1F7ZHHRqPok1MafjIteDxP2LvpyJPBViiI8M1uhaZ8yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737342526; c=relaxed/simple;
	bh=tRb/+m2CHIBQzMJH33b+ExYAOKP5Ga6+rARxXXmPz1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o+B/XdwWOqtu1S+VAf6ioZfghcx98giCGR+XP28XaLDqJmBzktiAhWPByvfcCTcsQIKYrCJMMWwYBFb4z7Bz2tlvrkc2gPgGGdVhs7zHU7l8QQsAXMdwdAcZaaTZQmvmAYCpXN+PZzjtQr4rf5oBCisptOaBfah+iFdf59PuNYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cezblYLn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cezblYLn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737342525; x=1768878525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tRb/+m2CHIBQzMJH33b+ExYAOKP5Ga6+rARxXXmPz1E=;
  b=cezblYLnnLM3sHR2BCRiM4W/VzPeQN/puc98Vn4TtK3ciyEazi6lCCYW
   7OIeVbqyvq2b4Ehgl9vLdIVkuTQIc3KAYairzWmm4UmF4FIaLMG6/tKdl
   2HeNC3Y9MnaNEVtaw5zPEPsITj0ku+r/ttns+hghdsJaANyMQ7K8RSgYy
   zyf7Lgtj48+XAezfi3yECgvEWj4G/WzKttmOF6o599vkw2GA5mJJ9Gsll
   VRSuuq4qzr9Xu/ipcr3IsOltMyPWYytjBglucH1kPhyk37p1z5WWgIq1N
   D/ZiH6QeWfWMkf9jSfHN/V31ZkAxan0d9GNYHlVbAUqPtcPGK5f2rngnP
   w==;
X-CSE-ConnectionGUID: fGmbDoRsRzeFVQmaUFdE+w==
X-CSE-MsgGUID: Ii0oSYt4QTCSwh+Ia6R8uA==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="55104341"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="55104341"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 19:08:44 -0800
X-CSE-ConnectionGUID: +n1GLTUkS4eZ7TUVH1cawQ==
X-CSE-MsgGUID: nqGupLSBRFm7FaI//DlQvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143634399"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa001.jf.intel.com with ESMTP; 19 Jan 2025 19:08:42 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: joro@8bytes.org,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	jgg@nvidia.com
Cc: yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	jacob.pan@linux.microsoft.com,
	robin.murphy@arm.com,
	nicolinc@nvidia.com,
	will@kernel.org
Subject: [PATCH 1/2] iommu: Store either domain or handle in group->pasid_array
Date: Sun, 19 Jan 2025 19:08:39 -0800
Message-Id: <20250120030840.4171-2-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250120030840.4171-1-yi.l.liu@intel.com>
References: <20250120030840.4171-1-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_attach_device_pasid() only stores handle to group->pasid_array
when there is a valid handle input. However, it makes the
iommu_attach_device_pasid() unable to detect if the pasid has been
attached or not. To be complete, let the iommu_attach_device_pasid()
store the domain to group->pasid_array if no valid handle.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 28ffd836592b..278c4eb8f225 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -45,6 +45,8 @@ static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
 static u32 iommu_cmd_line __read_mostly;
 
+enum { IOMMU_PASID_ARRAY_DOMAIN, IOMMU_PASID_ARRAY_HANDLE };
+
 struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
@@ -3374,6 +3376,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	struct iommu_group *group = dev->iommu_group;
 	struct group_device *device;
 	const struct iommu_ops *ops;
+	void *xa_entry;
 	int ret;
 
 	if (!group)
@@ -3397,10 +3400,14 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 		}
 	}
 
-	if (handle)
+	if (handle) {
 		handle->domain = domain;
+		xa_entry = xa_tag_pointer(handle, IOMMU_PASID_ARRAY_HANDLE);
+	} else {
+		xa_entry = xa_tag_pointer(domain, IOMMU_PASID_ARRAY_DOMAIN);
+	}
 
-	ret = xa_insert(&group->pasid_array, pasid, handle, GFP_KERNEL);
+	ret = xa_insert(&group->pasid_array, pasid, xa_entry, GFP_KERNEL);
 	if (ret)
 		goto out_unlock;
 
@@ -3480,13 +3487,17 @@ struct iommu_attach_handle *
 iommu_attach_handle_get(struct iommu_group *group, ioasid_t pasid, unsigned int type)
 {
 	struct iommu_attach_handle *handle;
+	void *xa_entry;
 
 	xa_lock(&group->pasid_array);
-	handle = xa_load(&group->pasid_array, pasid);
-	if (!handle)
+	xa_entry = xa_load(&group->pasid_array, pasid);
+	if (xa_pointer_tag(xa_entry) == IOMMU_PASID_ARRAY_HANDLE) {
+		handle = xa_untag_pointer(xa_entry);
+		if (type && handle->domain->type != type)
+			handle = ERR_PTR(-EBUSY);
+	} else {
 		handle = ERR_PTR(-ENOENT);
-	else if (type && handle->domain->type != type)
-		handle = ERR_PTR(-EBUSY);
+	}
 	xa_unlock(&group->pasid_array);
 
 	return handle;
-- 
2.34.1

