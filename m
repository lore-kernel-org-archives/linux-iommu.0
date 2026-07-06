Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB673D3CE0
	for <iommu@lists.linux.dev>; Mon,  6 Jul 2026 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783363739; cv=none; b=V0AOXIHlRzkFem523LWeSp/u4vY+cHQrZp1rOfxSfx8rnF/e52WWqkl2poKe+AKa5TFJjBNqvrsz2l4LVH1IL8XbSMbUppdcRXZ/Ir+PqzLgut6kIaK42+5k6d9HgJhbT5u7A+daKwj8iKN/JiqGtjrsg8cPlC61SDR80tdGfTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783363739; c=relaxed/simple;
	bh=WfAT28OYJ+3f+cNQeZth41Y6O8X27FTdpG6KyGpSJE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahaV5jxtjtBfUNJ8mGeFPImT09dcFP4TCe8kHLPhGyMeznKl1xxxMJCAWQtTcMW+crHQT/w2r1OVcW0+Ki1+1YJti2Dj2qNWqgRxZm8Y1Kz/i/aHlaxoB6bS44HXLKUfQR4D25uCkmn9Ubi+zxUG46gXBko/FzpLxOImdv4v0ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=joSi5q3E; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="joSi5q3E"
Received: from administrator-PowerEdge-R660.corp.microsoft.com (unknown [131.107.1.135])
	by linux.microsoft.com (Postfix) with ESMTPSA id C6BC420B716E;
	Mon,  6 Jul 2026 11:48:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C6BC420B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783363712;
	bh=RtDNQ78kEJ5JGbGaJRRjBoybIUetlJ6Zet0dj4TGCXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=joSi5q3EBr0ahGsUKlaz6A+3A5VwtYUPQUihfyDPqwo8kbHOV8C2VBHQs/uyQ+uFo
	 YVPjWPxp0F7G5DPU4a4i7B1M+jtJSXZdg+G829MmDLzl/DcBWKbDGIsO5aTnqEiwvn
	 4Vv8JteOcYX7FtLfG33bYbEFgZPl03psBIKXRkek=
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
Subject: [PATCH v10 2/6] iommufd: Move igroup allocation to a function
Date: Mon,  6 Jul 2026 11:48:30 -0700
Message-ID: <6bc8e5eaee89e1dc5f07d13dff69b9670b55923a.1783360051.git.jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783360051.git.jacob.pan@linux.microsoft.com>
References: <cover.1783360051.git.jacob.pan@linux.microsoft.com>
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

