Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCA24963D4
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781198829; cv=none; b=RPfGVgfwo3ELppaZ+KFogBAHNnCmuD8BtlHMUi5REDPqFKBK0GQE24HjlAheL+i97W5sgy84BZrNvNk4VM/JoWIwx9QjGYTJH2XZF72R+7JrndDLBQA+ZjY2QMWnxfvrYZme+eJj5twLYlyw99IBzxUZb5TEU96cVAL+lv8UVsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781198829; c=relaxed/simple;
	bh=WfAT28OYJ+3f+cNQeZth41Y6O8X27FTdpG6KyGpSJE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jJblz4lgd7Ol6rx8Eb3JCy/4XN1HZPDgOP8TOvj/I2XkUReemC2C0UI4J67bvkayQGUhYdqEFCyv0Y1H1R/hR3nQ0aR72pona9ZlC62uF1IvdmRpeDQpWH2rnSUd3FL4GNSAq+qT5J0phaSZDYIgPeV7BaUIWZvNuNsl0T44/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=K5oWXZSO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="K5oWXZSO"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.1.135])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9052020B716D;
	Thu, 11 Jun 2026 10:26:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9052020B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781198801;
	bh=RtDNQ78kEJ5JGbGaJRRjBoybIUetlJ6Zet0dj4TGCXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K5oWXZSOVCxvHEfvUk1B2nmm0Ccs+ociYx/jmWV+4uha5TKUVxy/Sx9xR2YUZFXnO
	 zIQEMI8OJTwsEB5LjiMTPfClMB7xeX9dGHiwY3bqphgS9V5yTfzsDzH3znyg+zWZwy
	 9oU8zBJeKRsOC3VCozegF7UDHXQ0RrWLOaJU+Rlk=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Joerg Roedel <joro@8bytes.org>,
	Mostafa Saleh <smostafa@google.com>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>
Subject: [PATCH v9 2/6] iommufd: Move igroup allocation to a function
Date: Thu, 11 Jun 2026 10:26:54 -0700
Message-ID: <20260611172658.3421138-3-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611172658.3421138-1-jacob.pan@linux.microsoft.com>
References: <20260611172658.3421138-1-jacob.pan@linux.microsoft.com>
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

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
v9:
   - Use kzalloc_obj() for igroup allocation
v5:
   - Add NULL group to the error handling path of
     iommufd_group_setup_msi()
---
 drivers/iommu/iommufd/device.c | 43 +++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 170a7005f0bc..b23a20c89f66 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -56,6 +56,30 @@ static bool iommufd_group_try_get(struct iommufd_group *igroup,
 	return kref_get_unless_zero(&igroup->ref);
 }
 
+static struct iommufd_group *iommufd_alloc_group(struct iommufd_ctx *ictx,
+						 struct iommu_group *group)
+{
+	struct iommufd_group *new_igroup;
+
+	new_igroup = kzalloc_obj(*new_igroup, GFP_KERNEL);
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
+	 * The ictx is not additionally refcounted here because all objects using
+	 * an igroup must put it before their destroy completes.
+	 */
+	new_igroup->ictx = ictx;
+	return new_igroup;
+}
+
 /*
  * iommufd needs to store some more data for each iommu_group, we keep a
  * parallel xarray indexed by iommu_group id to hold this instead of putting it
@@ -87,25 +111,12 @@ static struct iommufd_group *iommufd_get_group(struct iommufd_ctx *ictx,
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
2.43.0

