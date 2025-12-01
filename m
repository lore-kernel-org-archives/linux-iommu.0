Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F91D338905
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610223; cv=none; b=jwsKRRJcBsM5/jw4U4ICWwrIqiTop7oYitxAtBacdHUG8SHQGnF2hfOa05elVNwbz7XP+bQtBdTFpW3BQxLNhnUEokEWS9NMmsSdtpDQek0MXVCMhrNgKgD0dzhnswQmtdUEFHykcUwMp/2KeQFgPQebJ+DnoS9XAJfee28xd2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610223; c=relaxed/simple;
	bh=7WcQI7ptM3Pq4VBxQhJMksQCk8jUX2k/LFJwgO0ZI8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W3GatVrbaq5iQCke9R9shoUiT2B/70veiXX8FiMw8ppl2O11XdB7CoGRXvwmAjy//gwv0FsihaD22uGteeU+K9BTKYH4MBHpHa2O8NeebUHf2ejGUukGTBCI40uF07MNBg+C2oCa1+bTdRdxJ2kVSxWiuUgaX0mw+0E1UkxUf6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qkIUwc96; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qkIUwc96"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8FB07206C15D;
	Mon,  1 Dec 2025 09:30:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8FB07206C15D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764610219;
	bh=8qKnjYD9ftt2lodJmR4nVyYNpscAUqYpv2zFFnUYyL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qkIUwc96rAqyfB5xWtP7o6lALu4plaSikYejniWaA9eDCcWvkgzBntnW0kBR6eYKY
	 zx4lByQPvVpxVMZ38aRcKCbdpHUnRrE95YQsWfYMUL9kcUJSeOz6rMVEfgBDvlUAjb
	 eQ34AG11T5Q24bcyjpXSfCF+pLLnPhzrx3lzR2C8=
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Zhang Yu <zhangyu1@linux.microsoft.com>,
	Jean Philippe-Brucker <jean-philippe@linaro.org>,
	David Matlack <dmatlack@google.com>
Subject: [RFC 6/8] vfio: Rename and remove compat from noiommu set function
Date: Mon,  1 Dec 2025 09:30:10 -0800
Message-Id: <20251201173012.18371-7-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
References: <20251201173012.18371-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the dummy iommu driver, noiommu mode can be supported beyond
vfio_compat mode under IOMMUFD. Rename it accordingly.

Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/iommufd/vfio_compat.c | 6 +++---
 drivers/vfio/group.c                | 2 +-
 include/linux/iommufd.h             | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/vfio_compat.c b/drivers/iommu/iommufd/vfio_compat.c
index a258ee2f4579..82630fe024a6 100644
--- a/drivers/iommu/iommufd/vfio_compat.c
+++ b/drivers/iommu/iommufd/vfio_compat.c
@@ -47,12 +47,12 @@ int iommufd_vfio_compat_ioas_get_id(struct iommufd_ctx *ictx, u32 *out_ioas_id)
 EXPORT_SYMBOL_NS_GPL(iommufd_vfio_compat_ioas_get_id, "IOMMUFD_VFIO");
 
 /**
- * iommufd_vfio_compat_set_no_iommu - Called when a no-iommu device is attached
+ * iommufd_vfio_set_no_iommu - Called when a no-iommu device is attached
  * @ictx: Context to operate on
  *
  * This allows selecting the VFIO_NOIOMMU_IOMMU and blocks normal types.
  */
-int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
+int iommufd_vfio_set_no_iommu(struct iommufd_ctx *ictx)
 {
 	int ret;
 
@@ -66,7 +66,7 @@ int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
 	xa_unlock(&ictx->objects);
 	return ret;
 }
-EXPORT_SYMBOL_NS_GPL(iommufd_vfio_compat_set_no_iommu, "IOMMUFD_VFIO");
+EXPORT_SYMBOL_NS_GPL(iommufd_vfio_set_no_iommu, "IOMMUFD_VFIO");
 
 /**
  * iommufd_vfio_compat_ioas_create - Ensure the compat IOAS is created
diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
index c376a6279de0..39fada00ef50 100644
--- a/drivers/vfio/group.c
+++ b/drivers/vfio/group.c
@@ -134,7 +134,7 @@ static int vfio_group_ioctl_set_container(struct vfio_group *group,
 	if (!IS_ERR(iommufd)) {
 		if (IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
 		    group->type == VFIO_NO_IOMMU)
-			ret = iommufd_vfio_compat_set_no_iommu(iommufd);
+			ret = iommufd_vfio_set_no_iommu(iommufd);
 		else
 			ret = iommufd_vfio_compat_ioas_create(iommufd);
 
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 6e7efe83bc5d..fb3bc387b78e 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -212,7 +212,7 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
 		      void *data, size_t len, unsigned int flags);
 int iommufd_vfio_compat_ioas_get_id(struct iommufd_ctx *ictx, u32 *out_ioas_id);
 int iommufd_vfio_compat_ioas_create(struct iommufd_ctx *ictx);
-int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx);
+int iommufd_vfio_set_no_iommu(struct iommufd_ctx *ictx);
 #else /* !CONFIG_IOMMUFD */
 static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
 {
@@ -250,7 +250,7 @@ static inline int iommufd_vfio_compat_ioas_create(struct iommufd_ctx *ictx)
 	return -EOPNOTSUPP;
 }
 
-static inline int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx)
+static inline int iommufd_vfio_set_no_iommu(struct iommufd_ctx *ictx)
 {
 	return -EOPNOTSUPP;
 }
-- 
2.34.1

