Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DF633D515
	for <iommu@lists.linux.dev>; Fri,  3 Apr 2026 05:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775193116; cv=none; b=FneZ6YZ0JVFh0rBR+SOzFf/8Vxoiz8KJwyCBiqnrK28LzpugIElbqu/PHNJb82adJsU2Ov/RADYpsO1Tjw34r6d8+O1HRjSbuNzBKQOFQHf6gToKctZG2IfbwltvxRleDZQJvJ/Z2p1VbvcAn/j9uOXxXhe2V5jp3F2msfYzpwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775193116; c=relaxed/simple;
	bh=KQ3WJU1tt1zFvb7kVMmh4hH+Z0AesLtbM2yhVBuAunw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WnHkbz9JBiiQpCm7RAA4g9TEgJZd22mgAohDLKG4hVbApIX1+vb2nx9dHhJFv3wkoHOCjIs0PYpctry/NZ/CNRLq7cT2NqQAoRxSq1eht9zT5nPvsJwRq1RlBj4j+YZ1m/+jHLEvyYDsVeZHgIcyE9By0vUCYxAq1ssGr278r7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Gglb4NcP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Gglb4NcP"
Received: from DESKTOP-0403QTC.corp.microsoft.com (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2698920B7138;
	Thu,  2 Apr 2026 22:11:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2698920B7138
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775193113;
	bh=sIlQBLNxFlHKmin2kwEEybGlzkD3r2mL3/Ib5b7lBo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gglb4NcPKhDTzD9SfOPXUrmtDfIOsTv8AVrafohiFBoMBTPXqWJkjWTJrBKQur07L
	 3e+1LfHd43OA+RpeHoyMaJZpnA9EDsT6uqP+9xZ7pOe/ctDV0JhdVW4GydBax5KqOh
	 KoxwgaEjAbd4G040XQetAwaPkso3tftW2gLefLqU=
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
Cc: skhawaja@google.com,
	pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: [PATCH V3 04/10] iommufd: Add an ioctl IOMMU_IOAS_GET_PA to query PA from IOVA
Date: Thu,  2 Apr 2026 22:11:40 -0700
Message-Id: <20260403051146.10210-5-jacob.pan@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260403051146.10210-1-jacob.pan@linux.microsoft.com>
References: <20260403051146.10210-1-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support no-IOMMU mode where userspace drivers perform unsafe DMA
using physical addresses, introduce a new API to retrieve the
physical address of a user-allocated DMA buffer that has been mapped to
an IOVA via IOAS. The mapping is backed by mock I/O page tables maintained
by generic IOMMUPT framework.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
v2:
   - Scan the contiguous physical-address span beyond the first page and return its length.
---
 drivers/iommu/iommufd/io_pagetable.c    | 60 +++++++++++++++++++++++++
 drivers/iommu/iommufd/ioas.c            | 25 +++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  3 ++
 drivers/iommu/iommufd/main.c            |  3 ++
 include/uapi/linux/iommufd.h            | 25 +++++++++++
 5 files changed, 116 insertions(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index ee003bb2f647..5372fac6077b 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -849,6 +849,66 @@ int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
 	return iopt_unmap_iova_range(iopt, iova, iova_last, unmapped);
 }
 
+int iopt_get_phys(struct io_pagetable *iopt, unsigned long iova, u64 *paddr,
+		  u64 *length)
+{
+	struct iopt_area *area;
+	u64 tmp_length = 0;
+	u64 tmp_paddr = 0;
+	int rc = 0;
+
+	if (!IS_ENABLED(CONFIG_VFIO_NOIOMMU))
+		return -EOPNOTSUPP;
+
+	down_read(&iopt->iova_rwsem);
+	area = iopt_area_iter_first(iopt, iova, iova);
+	if (!area || !area->pages) {
+		rc = -ENOENT;
+		goto unlock_exit;
+	}
+
+	if (!area->storage_domain ||
+	    area->storage_domain->owner != &iommufd_noiommu_ops) {
+		rc = -EOPNOTSUPP;
+		goto unlock_exit;
+	}
+
+	*paddr = iommu_iova_to_phys(area->storage_domain, iova);
+	if (!*paddr) {
+		rc = -EINVAL;
+		goto unlock_exit;
+	}
+
+	tmp_length = PAGE_SIZE;
+	tmp_paddr = *paddr;
+	/*
+	 * Scan the domain for the contiguous physical address length so that
+	 * userspace search can be optimized for fewer ioctls.
+	 */
+	while (iova < iopt_area_last_iova(area)) {
+		unsigned long next_iova;
+		u64 next_paddr;
+
+		if (check_add_overflow(iova, PAGE_SIZE, &next_iova))
+			break;
+
+		next_paddr = iommu_iova_to_phys(area->storage_domain, next_iova);
+
+		if (!next_paddr || next_paddr != tmp_paddr + PAGE_SIZE)
+			break;
+
+		iova = next_iova;
+		tmp_paddr += PAGE_SIZE;
+		tmp_length += PAGE_SIZE;
+	}
+	*length = tmp_length;
+
+unlock_exit:
+	up_read(&iopt->iova_rwsem);
+
+	return rc;
+}
+
 int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped)
 {
 	/* If the IOVAs are empty then unmap all succeeds */
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index fed06c2b728e..93cebb4c23bd 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -375,6 +375,31 @@ int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd)
 	return rc;
 }
 
+int iommufd_ioas_get_pa(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_ioas_get_pa *cmd = ucmd->cmd;
+	struct iommufd_ioas *ioas;
+	int rc;
+
+	if (cmd->flags || cmd->__reserved)
+		return -EOPNOTSUPP;
+
+	ioas = iommufd_get_ioas(ucmd->ictx, cmd->ioas_id);
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+
+	rc = iopt_get_phys(&ioas->iopt, cmd->iova, &cmd->out_phys,
+			   &cmd->out_length);
+	if (rc)
+		goto out_put;
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
index 9c18c5eb1899..3302c6a1f99e 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -118,6 +118,8 @@ int iopt_map_pages(struct io_pagetable *iopt, struct list_head *pages_list,
 int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
 		    unsigned long length, unsigned long *unmapped);
 int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped);
+int iopt_get_phys(struct io_pagetable *iopt, unsigned long iova, u64 *paddr,
+		  u64 *length);
 
 int iopt_read_and_clear_dirty_data(struct io_pagetable *iopt,
 				   struct iommu_domain *domain,
@@ -346,6 +348,7 @@ int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_copy(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd);
+int iommufd_ioas_get_pa(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
 int iommufd_option_rlimit_mode(struct iommu_option *cmd,
 			       struct iommufd_ctx *ictx);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 8c6d43601afb..ebae01ed947d 100644
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
+		 out_phys),
 	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option, val64),
 	IOCTL_OP(IOMMU_VDEVICE_ALLOC, iommufd_vdevice_alloc_ioctl,
 		 struct iommu_vdevice_alloc, virt_id),
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1dafbc552d37..9afe0a1b11a0 100644
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
+ * @flags: Reserved, must be 0 for now
+ * @ioas_id: IOAS ID to query IOVA to PA mapping from
+ * @__reserved: Must be 0
+ * @iova: IOVA to query
+ * @out_length: Number of bytes contiguous physical address starting from phys
+ * @out_phys: Output physical address the IOVA maps to
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
+	__aligned_u64 out_length;
+	__aligned_u64 out_phys;
+};
+#define IOMMU_IOAS_GET_PA _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_GET_PA)
+
 /**
  * struct iommu_ioas_map_file - ioctl(IOMMU_IOAS_MAP_FILE)
  * @size: sizeof(struct iommu_ioas_map_file)
-- 
2.34.1

