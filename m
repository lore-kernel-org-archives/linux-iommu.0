Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D9513FFC
	for <iommu@lists.linux.dev>; Mon, 20 Jan 2025 03:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737342527; cv=none; b=Pgpo8PdEDibG33JznoNQZ5Q/eRUY2cA9cjW+j1rMHEPdsofzbXr0FkrQR+Q/cseJn9GvnMKIvbz/ajPduMHpmiBIg34T9lsNJafTtiLCkx6wvcwlcixkfIrYCEVc5kn5d4EyKiGDHctb8ZDTvkG3zDQFVq5aL8Lw2ko/ay72sas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737342527; c=relaxed/simple;
	bh=yJQCrF/FDWbLpG3P70ROMLOFsXNWTkCBlxv7SoPd6KQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aYhehbOd8Lgx7ui5E20ydiKs4FIleMaNgJsy17PAiFfdRAzPXrWaIO5Va70AL+UG2RmgReHmls7FqxNfT2tuA52zV4bQ3j5h4snm6TJGREk+dbtBW/7zoC38FdpjrAaodJEFhOkbJeLWo8E2kZLzZC67qe4a1rg5WQinrGxJ4wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agCbWppL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agCbWppL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737342525; x=1768878525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yJQCrF/FDWbLpG3P70ROMLOFsXNWTkCBlxv7SoPd6KQ=;
  b=agCbWppLVpc418C6rnbkN4PUNruvtOijDkz1jMqfqGzQGqtkPAzEsAK1
   vja4ADhTJbWdfSofAB2vPQM5Ldxw2s+ugPVPcFYbl2/XFkiX9UaeszJer
   YRtSUEcOzOFZfikN+1W+tLZ5dIMwGJF2wF2PRGOMiyvJ7+VC7DisE77AR
   JF8QNR+aNQrpb6lsWGP6ytdJgeaYmX/mX0BZGZkCP5Ow5y6dpT/42InYJ
   O29xG0QduBNzk+j0NBqXV74YUDXalxt5mkPNT/oCS0t6IbrTVNYQ9R26s
   jyb8xCMiPv3Tqe4N7pkqZirVDUPCCT3+j8vsGGQ39zuz/8szmwurx8o1n
   w==;
X-CSE-ConnectionGUID: WnxNqnkXTYWhY0LcmhBLIw==
X-CSE-MsgGUID: LVplql4rSI+kLdYmObI4ww==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="55104350"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="55104350"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 19:08:45 -0800
X-CSE-ConnectionGUID: BgAjM6/hQrym416skmu4/w==
X-CSE-MsgGUID: KC+2Kc1AQyib2fiYtbJ8Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143634411"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa001.jf.intel.com with ESMTP; 19 Jan 2025 19:08:44 -0800
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
Subject: [PATCH 2/2] iommu: Swap the order of setting group->pasid_array and __iommu_set_group_pasid()
Date: Sun, 19 Jan 2025 19:08:40 -0800
Message-Id: <20250120030840.4171-3-yi.l.liu@intel.com>
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

Following the current order of setting group->pasid_array and
__iommu_set_group_pasid() in iommu_attach_device_pasid(), PRIs may be
forwarded to the domain before the attach succeeds. If the attach failed
in the end, the PRIs on the domain need to be flushed in the caller side.
Caller can do it, but it can be avoided by swapping the order. This is
more self-contained.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 278c4eb8f225..b69bcf559839 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3376,7 +3376,7 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	struct iommu_group *group = dev->iommu_group;
 	struct group_device *device;
 	const struct iommu_ops *ops;
-	void *xa_entry;
+	void *curr, *xa_entry;
 	int ret;
 
 	if (!group)
@@ -3400,6 +3400,16 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 		}
 	}
 
+	curr = xa_load(&group->pasid_array, pasid);
+	if (curr) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	ret = __iommu_set_group_pasid(domain, group, pasid);
+	if (ret)
+		goto out_unlock;
+
 	if (handle) {
 		handle->domain = domain;
 		xa_entry = xa_tag_pointer(handle, IOMMU_PASID_ARRAY_HANDLE);
@@ -3407,13 +3417,12 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 		xa_entry = xa_tag_pointer(domain, IOMMU_PASID_ARRAY_DOMAIN);
 	}
 
-	ret = xa_insert(&group->pasid_array, pasid, xa_entry, GFP_KERNEL);
-	if (ret)
-		goto out_unlock;
+	curr = xa_store(&group->pasid_array, pasid, handle, GFP_KERNEL);
+	if (curr) {
+		__iommu_remove_group_pasid(group, pasid, domain);
+		ret = xa_err(curr);
+	}
 
-	ret = __iommu_set_group_pasid(domain, group, pasid);
-	if (ret)
-		xa_erase(&group->pasid_array, pasid);
 out_unlock:
 	mutex_unlock(&group->mutex);
 	return ret;
-- 
2.34.1

