Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2934A3402
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 18:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778524882; cv=none; b=Vb9899+dihUr7wmGaABYHpGw9syH6GLKek/rj8ww4SETneCrdmZahrVobJ+xeHc0AYoQCockpn3cPtPrkQzoDDQUbcPyewsaZmwXt8NJh1HESSTKq29lYGGA/hQyrtRG1oXFqzKCuTTf9ZKka7dNfju2KiMaUCgFKgaiY/olOGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778524882; c=relaxed/simple;
	bh=IR26TFVF1p/ShoJ7hk/esRjA5uezcqic+/+KTROdqiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZuw61NyiZSLyoXFyIQyGflssIlxr+GKeRodhNnbmhNH+s9ZOCpRzFQRfZSy4JGMD6N3Uk4mXvMwki1aKbtB73EQ5LD8QI6P9znySu4cj66XP+/zPQzB0FFpeGGLXDlbUYVBpxUThMWlIgaGw2TZdPPITiMsqMtX4d/mDQF11Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KeuDHUOY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KeuDHUOY"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.147.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id B5C1B20B716B;
	Mon, 11 May 2026 11:41:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B5C1B20B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778524877;
	bh=DymJjM/8uCvIk2lLmgH7Wp2OWbrYkSL1YxpydroEpMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KeuDHUOYSPV6eKAKENoMcl650GCj6IG3V8A8yl4VgQe0qGPuxp2jamsRls/CJruIP
	 Mn8LPZ1SNC5iYEJ09wROONJ4zq27o7+PemgKtlfp57xWMz56A1H1iIUJiOV+5L6eOT
	 SJdB9Q9tYj1657TO6ieZcN5rBlgH3LsA8Ut8oL/8=
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
	Yi Liu <yi.l.liu@intel.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: [PATCH v5 3/9] iommufd: Move igroup allocation to a function
Date: Mon, 11 May 2026 11:41:08 -0700
Message-ID: <20260511184116.3687392-4-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
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

