Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100B033892F
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764610225; cv=none; b=sNnZSy32KSiUBVfEtwTsRcSsYQBN479KDuLKQTgeCGE17xKAiwFfbl+BoEkY4hksvwZ0XDO4OPZlhCv5xE9vcWRXps3vGPA8EtROsUBp6tGL74qX3Nd0v01vsOKDmSOoztxM3wiyxYHNCL+7HYxJrujOS+/pEA340NC8D7eO5c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764610225; c=relaxed/simple;
	bh=W4zrwr45dXYYcO7iKO41qJJddSemH0Ip/g+WpAV5llE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JoAJ89aG8CYJYn0JhitLXEfz6QBQXh2vZ8QfKbr5E45BUeMLVvTHRXJN45F4byAi/3qOFnGs2TgiWmGH3gGjI3KwtqwfNFP/pn2hIRE5s4lgzjsrVdMB3xrXTYf4DeuGzeKpgGAeYo4XoTlQqnRTA8vQ9loq9NKCQzaM2ImOc6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YhQ4xPen; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YhQ4xPen"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 08E3D20A10E4;
	Mon,  1 Dec 2025 09:30:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 08E3D20A10E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764610222;
	bh=1Rfy6S/Akn9qX5xzf1fS1wP+nHDcp2JwJ+OdzpXMGjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YhQ4xPenb1H0DuHYv7ki2rFRe3PrZgIrYf66XUJtCywQVqnP/q253mm1lzI5wT0wj
	 t234UrrFz5aStnvZ9uowT6ftE5e3Bw+7i/GF9veo1fCUVTz53Tf5ntWVzna0puZ0tD
	 8T9Y5lnFA3AG5t8A7pFkbw3RWgNas1jCrN/PRzW0=
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
Subject: [RFC 8/8] iommufd: Add an ioctl IOMMU_IOAS_GET_PA to query PA from IOVA
Date: Mon,  1 Dec 2025 09:30:12 -0800
Message-Id: <20251201173012.18371-9-jacob.pan@linux.microsoft.com>
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

To support no-IOMMU mode where userspace drivers perform unsafe DMA
using physical addresses, introduce an new API to retrieve the
physical address of a user-allocated DMA buffer that has been mapped to
an IOVA via IOAS. The mapping is backed by mock I/O page tables maintained
by generic IOMMUPT framework.

Link: https://lore.kernel.org/linux-iommu/20250603175403.GA407344@nvidia.com/
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
---
 drivers/iommu/iommufd/io_pagetable.c    | 44 +++++++++++++++++++++++++
 drivers/iommu/iommufd/ioas.c            | 24 ++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  3 ++
 drivers/iommu/iommufd/main.c            |  3 ++
 include/uapi/linux/iommufd.h            | 25 ++++++++++++++
 5 files changed, 99 insertions(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index c0360c450880..134a16acb44f 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -813,6 +813,50 @@ int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
 	return iopt_unmap_iova_range(iopt, iova, iova_last, unmapped);
 }
 
+int iopt_get_phys(struct io_pagetable *iopt, unsigned long iova,
+			phys_addr_t *paddr, u64 *length)
+{
+	unsigned long area_iova;
+	struct iopt_area *area;
+	unsigned long offset;
+	int rc = 0;
+
+	down_read(&iopt->iova_rwsem);
+	area = iopt_area_iter_first(iopt, iova, iova);
+	if (!area || !area->pages) {
+		pr_warn("%s: No area for iova 0x%lx\n", __func__, iova);
+		rc = -ENOENT;
+		goto unlock_exit;
+	}
+
+	if (!area->storage_domain) {
+		pr_warn("%s: area has no storage_domain\n", __func__);
+		rc = -EINVAL;
+		goto unlock_exit;
+	}
+
+	area_iova = iopt_area_iova(area);
+	offset = iova - area_iova;
+	*paddr = iommu_iova_to_phys(area->storage_domain, iova);
+	if (!*paddr) {
+		pr_warn("%s: No paddr for iova 0x%lx\n", __func__, iova);
+		rc = -EINVAL;
+		goto unlock_exit;
+	}
+	/*
+	 * TBD: we can return contiguous IOVA length so that userspace can
+	 * keep searching for next physical address.
+	 * e.g.
+	 * iopt_area_length(area) - offset;
+	 */
+	*length = PAGE_SIZE;
+
+unlock_exit:
+	up_read(&iopt->iova_rwsem);
+
+	return rc;
+}
+
 int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped)
 {
 	int rc;
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 1542c5fd10a8..c11c5fce955a 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -377,6 +377,30 @@ int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd)
 	return rc;
 }
 
+int iommufd_ioas_get_pa(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_ioas_get_pa *cmd = ucmd->cmd;
+	struct iommufd_ioas *ioas;
+	int rc;
+
+	ioas = iommufd_get_ioas(ucmd->ictx, cmd->ioas_id);
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+
+	rc = iopt_get_phys(&ioas->iopt, cmd->iova, &cmd->phys, &cmd->length);
+	if (rc) {
+		pr_err("%s: Failed to get PA for IOVA 0x%llx length 0x%llx: %d\n",
+		       __func__, cmd->iova, cmd->length, rc);
+		goto out_put;
+	}
+
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+out_put:
+	iommufd_put_object(ucmd->ictx, &ioas->obj);
+
+	return rc;
+}
+
 static void iommufd_release_all_iova_rwsem(struct iommufd_ctx *ictx,
 					   struct xarray *ioas_list)
 {
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 627f9b78483a..f74a0aea70bf 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -117,6 +117,8 @@ int iopt_map_pages(struct io_pagetable *iopt, struct list_head *pages_list,
 int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
 		    unsigned long length, unsigned long *unmapped);
 int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped);
+int iopt_get_phys(struct io_pagetable *iopt, unsigned long iova,
+			phys_addr_t *paddr, u64 *length);
 
 int iopt_read_and_clear_dirty_data(struct io_pagetable *iopt,
 				   struct iommu_domain *domain,
@@ -345,6 +347,7 @@ int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_copy(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd);
+int iommufd_ioas_get_pa(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
 int iommufd_option_rlimit_mode(struct iommu_option *cmd,
 			       struct iommufd_ctx *ictx);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index ce775fbbae94..37e785d0e40d 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -432,6 +432,7 @@ union ucmd_buffer {
 	struct iommu_veventq_alloc veventq;
 	struct iommu_vfio_ioas vfio_ioas;
 	struct iommu_viommu_alloc viommu;
+	struct iommu_ioas_get_pa get_pa;
 #ifdef CONFIG_IOMMUFD_TEST
 	struct iommu_test_cmd test;
 #endif
@@ -484,6 +485,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
 		 struct iommu_ioas_map_file, iova),
 	IOCTL_OP(IOMMU_IOAS_UNMAP, iommufd_ioas_unmap, struct iommu_ioas_unmap,
 		 length),
+	IOCTL_OP(IOMMU_IOAS_GET_PA, iommufd_ioas_get_pa, struct iommu_ioas_get_pa,
+		 phys),
 	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option, val64),
 	IOCTL_OP(IOMMU_VDEVICE_ALLOC, iommufd_vdevice_alloc_ioctl,
 		 struct iommu_vdevice_alloc, virt_id),
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index c218c89e0e2e..915cb128f220 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -57,6 +57,7 @@ enum {
 	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
 	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
 	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
+	IOMMUFD_CMD_IOAS_GET_PA = 0x95,
 };
 
 /**
@@ -219,6 +220,30 @@ struct iommu_ioas_map {
 };
 #define IOMMU_IOAS_MAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP)
 
+/**
+ * struct iommu_ioas_get_pa - ioctl(IOMMU_IOAS_GET_PA)
+ * @size: sizeof(struct iommu_ioas_get_pa)
+ * @flags: TBD
+ * @ioas_id: IOAS ID to query IOVA to PA mapping from
+ * @__reserved: Must be 0
+ * @iova: IOVA to query
+ * @length: Number of bytes contiguous physical address starting from phys
+ * @phys: Output physical address the IOVA maps to
+ *
+ * Query the physical address backing an IOVA range. The entire range must be
+ * mapped already. For noiommu devices doing unsafe DMA only.
+ */
+struct iommu_ioas_get_pa {
+	__u32 size;
+	__u32 flags;
+	__u32 ioas_id;
+	__u32 __reserved;
+	__aligned_u64 iova;
+	__aligned_u64 length;
+	__aligned_u64 phys;
+};
+#define IOMMU_IOAS_GET_PA _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_GET_PA)
+
 /**
  * struct iommu_ioas_map_file - ioctl(IOMMU_IOAS_MAP_FILE)
  * @size: sizeof(struct iommu_ioas_map_file)
-- 
2.34.1

