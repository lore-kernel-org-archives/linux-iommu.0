Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A3A34753B
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 22:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779401519; cv=none; b=OFOgUrd9y2cjKdqKTV2E30jY4A0H/+5QfowL7hKmcEoLujP+FQ/NoC4BUPeOEpy2PnhEuUoFtuZ5hIpGkrrE92WVVacdKzQEqG9NOFBg4JVroiGvaf+O4BesYXgWMlNpmsrtpdVkftsTUdT1pF+AFV1YUPfz1FBXO8+9zha0R4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779401519; c=relaxed/simple;
	bh=IR26TFVF1p/ShoJ7hk/esRjA5uezcqic+/+KTROdqiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CNu2IaNUm16HGl8VL2h0V2OetL6ZlkfLISQGDhk+Lahz8mlmuN6fz48V4dTPLKmT2/XtMyMhOxJ6E0gQ13QRHRvzuj/E6lE/W6bMxO++JDUV92PW6qAPLC67mNZwUGtX2kkNM5y08eyy3SUalSVxadE6eaGcaCWmAKKXkh2SrdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OeX6CneR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OeX6CneR"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.147.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2228C20B716B;
	Thu, 21 May 2026 15:11:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2228C20B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779401510;
	bh=DymJjM/8uCvIk2lLmgH7Wp2OWbrYkSL1YxpydroEpMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OeX6CneRFtnnwecBwfzTkPbuNlPEF0Bkvc08BkKwrY5g2qCXeo8etMxcVv7vCotS6
	 kfZz6YI4j8rNI5o8/n+6yhpN/tl3HnD2pYJnw20C1z7ESW22erda0nJF0Z1Igd/KFy
	 m2iXmbC6Q8Kac7M6RDRFBWX2ns+GnInZzGE/NXs8=
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
Subject: [PATCH v6 2/7] iommufd: Move igroup allocation to a function
Date: Thu, 21 May 2026 15:11:49 -0700
Message-ID: <20260521221155.1375144-3-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
References: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
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
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
v5:
   - Add NULL group to the error handling path of
     iommufd_group_setup_msi()
v3:
   - New patch
---
 drivers/iommu/iommufd/device.c | 43 +++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 170a7005f0bc..d03076fcf3c2 100644
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

