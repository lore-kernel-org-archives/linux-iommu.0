Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26AF3CA4A5
	for <iommu@lists.linux.dev>; Thu, 12 Mar 2026 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773331002; cv=none; b=UsFHHBOG5w1ZG+EFNhw4YR1HPbLyENUabtV2rbt1Q/VkJUIK5mqKPd7pco2HtSPQZQR03iSD0yP7BDx0gxwhUbf+zOGQcskec8GYZKwsv89cZ4a6WBRTVRPyH/JM4yJUVw8hvUxCnYW3mzciV96ZmXiGYMwkCv1WSLtJQvnuncI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773331002; c=relaxed/simple;
	bh=2pSNNjCMJCzi4E9NiX/bZFyADwrRK7bee1k67bm0SZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R5y2Gh+dEFfin+RHmX0qPwk+ll3E7ea38A5o3MKQE/P/k2/wgaQaSmKsAsa5+ie/Yqm2v/Q+8y999lueJuZ6jdgP8G3aPhUFWMR/da1dHajCLqgjQe/ModqUu4GdpfeG7KLzbWHWMJrIxCmC3MirPjyIPV9Y/GHE+P+v2VwFes8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BLYsY5PL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BLYsY5PL"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 644D220B6F0C;
	Thu, 12 Mar 2026 08:56:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 644D220B6F0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773331000;
	bh=4uSNyWj8lWw77lOFEo+XTvKl1no/K1YZKJTwbDlGzmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BLYsY5PLCEsBtVOqNoasSLZbDu0kmw3Y8j710uBlL2a/qbtBPT9RN72pFABsF4JSh
	 qjJQOJqberD9TKru/li5qacQU5ZxzUGsQKi0vPd9Si3aDfFi3dEOfVTEfpjozJDRSH
	 2CMb/NvS0UmCtXtpPhwI27R5xh1G1SRZQZ2LP5J4=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: [PATCH V2 02/11] iommufd: Move igroup allocation to a function
Date: Thu, 12 Mar 2026 08:56:28 -0700
Message-Id: <20260312155637.376854-3-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Gunthorpe <jgg@nvidia.com>

So it can be reused in the next patch which allows binding to noiommu
device.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/iommufd/device.c | 48 +++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 344d620cdecc..54d73016468f 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -30,8 +30,9 @@ static void iommufd_group_release(struct kref *kref)
 
 	WARN_ON(!xa_empty(&igroup->pasid_attach));
 
-	xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group), igroup,
-		   NULL, GFP_KERNEL);
+	if (igroup->group)
+		xa_cmpxchg(&igroup->ictx->groups, iommu_group_id(igroup->group),
+			   igroup, NULL, GFP_KERNEL);
 	iommu_group_put(igroup->group);
 	mutex_destroy(&igroup->lock);
 	kfree(igroup);
@@ -56,6 +57,30 @@ static bool iommufd_group_try_get(struct iommufd_group *igroup,
 	return kref_get_unless_zero(&igroup->ref);
 }
 
+static struct iommufd_group *iommufd_alloc_group(struct iommufd_ctx *ictx,
+						 struct iommu_group *group)
+{
+	struct iommufd_group *new_igroup;
+
+	new_igroup = kzalloc(sizeof(*new_igroup), GFP_KERNEL);
+	if (!new_igroup)
+		return ERR_PTR(-ENOMEM);
+
+	kref_init(&new_igroup->ref);
+	mutex_init(&new_igroup->lock);
+	xa_init(&new_igroup->pasid_attach);
+	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
+	/* group reference moves into new_igroup */
+	new_igroup->group = group;
+
+	/*
+	 * The ictx is not additionally refcounted here becase all objects using
+	 * an igroup must put it before their destroy completes.
+	 */
+	new_igroup->ictx = ictx;
+	return new_igroup;
+}
+
 /*
  * iommufd needs to store some more data for each iommu_group, we keep a
  * parallel xarray indexed by iommu_group id to hold this instead of putting it
@@ -87,25 +112,12 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
 	}
 	xa_unlock(&ictx->groups);
 
-	new_igroup = kzalloc_obj(*new_igroup);
-	if (!new_igroup) {
+	new_igroup = iommufd_alloc_group(ictx, group);
+	if (IS_ERR(new_igroup)) {
 		iommu_group_put(group);
-		return ERR_PTR(-ENOMEM);
+		return new_igroup;
 	}
 
-	kref_init(&new_igroup->ref);
-	mutex_init(&new_igroup->lock);
-	xa_init(&new_igroup->pasid_attach);
-	new_igroup->sw_msi_start = PHYS_ADDR_MAX;
-	/* group reference moves into new_igroup */
-	new_igroup->group = group;
-
-	/*
-	 * The ictx is not additionally refcounted here becase all objects using
-	 * an igroup must put it before their destroy completes.
-	 */
-	new_igroup->ictx = ictx;
-
 	/*
 	 * We dropped the lock so igroup is invalid. NULL is a safe and likely
 	 * value to assume for the xa_cmpxchg algorithm.
-- 
2.34.1

