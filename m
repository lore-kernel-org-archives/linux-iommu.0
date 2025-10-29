Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C31D32938C
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742358; cv=none; b=KyBi6FfGulJ3LCsyRrHm1RJs/B8b/h4u2TTliySQdrgfVczU1N85ZK59JKhZ2n2S2iVOHuxiIrDrMM36Efx1z7njG+9Fd+zKq4OZ2daVU7M6wIE3Atu3dv28JBgfmR7QBmvGy6RHTT36tEzYwj5k2PuQDf11c14QooKqJqZ9gVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742358; c=relaxed/simple;
	bh=X5YkO56fqtFK/lXLL7rNg81RTPAPJ//X5hkVZfx7cko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tRL+HnAWfB0L7n0TSz492StpVXRiNRfoTI8vj8xbYLjD9RBwxeHOgLUjB1aOzgtnRd1bD7Kc19wog8vFm4LSV0SSYgxgFnv3luU8nBOlNHyq/n+Cl123oMIq2g/gapBTlX5dxgEY7gi94df8NWNV0ddlIcTYQn0ymgrhP7kuWPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Yqv4m7Zg; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Yqv4m7Zg"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761742352; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=0GV8hXLCtMunxr5n+XrWMvLJYJWHZBZqTR+DhgCUQYM=;
	b=Yqv4m7ZgrU75paJAPkpZCmg3cA4DQc7Q2KVJsAF0dcP9XiAVa30OHjrEde66fMRHi8CL/PZdhLF5Bu8B3DksksBRK4/RlOC/3ux7vytX2m3mkyV350t2OSYmUdc4IGZhzOCCHqOPmv+JZjBxpFpJEbT6VqzDrzkttC+aRYspMPU=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WrG1q.C_1761742350 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Oct 2025 20:52:31 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: jgg@ziepe.ca,
	iommu@lists.linux.dev
Cc: kevin.tian@intel.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	linux-kernel@vger.kernel.org,
	xueshuai@linux.alibaba.com
Subject: [PATCH] iommu: iommufd: Explicitly check for VM_PFNMAP in iommufd_ioas_map
Date: Wed, 29 Oct 2025 20:52:26 +0800
Message-Id: <20251029125226.81949-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iommufd_ioas_map function currently returns -EFAULT when attempting
to map VM_PFNMAP VMAs because pin_user_pages_fast() cannot handle such
mappings. This error code is misleading and does not accurately reflect
the nature of the failure.

Add an explicit check for the VM_PFNMAP flag before attempting the
pin_user_pages operation. If VM_PFNMAP is set, return -EOPNOTSUPP to
clearly indicate that PFNMAP regions are not supported through the
IOMMU_IOAS_MAP interface.

This change improves error reporting and helps userspace applications
distinguish between different failure modes when working with special
mappings like MMIO regions.

Note that Jason Gunthorpe is working on extending IOMMU_IOAS_MAP_FILE to
support dma-buf file descriptors for MMIO BARs[1], which will provide a
secure and controlled method for sharing device memory. Until that
support is available, PFNMAP mappings through IOMMUFD are not supported.
[1]https://lore.kernel.org/all/0-v1-64bed2430cdb+31b-iommufd_dmabuf_jgg@nvidia.com/

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
 drivers/iommu/iommufd/ioas.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 0dee38d7252d..0c4f242eba49 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -241,6 +241,32 @@ int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
 	return rc;
 }
 
+/**
+ * iommufd_check_vm_pfnmap - Check if a user address has the VM_PFNMAP flag set
+ * @vaddr: User virtual address to check
+ *
+ * This function checks if the VMA (Virtual Memory Area) containing the given
+ * virtual address has the VM_PFNMAP flag set. This flag is typically used for
+ * memory regions that directly map hardware resources (e.g., PCI BARs).
+ *
+ * Returns: true if VM_PFNMAP is set, false otherwise.
+ */
+static bool iommufd_check_vm_pfnmap(unsigned long vaddr)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	bool ret = false;
+
+	mmap_read_lock(mm);
+	vaddr = untagged_addr_remote(mm, vaddr);
+	vma = vma_lookup(mm, vaddr);
+	if (vma && vma->vm_flags & VM_PFNMAP)
+		ret = true;
+	mmap_read_unlock(mm);
+
+	return ret;
+}
+
 int iommufd_ioas_map(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_ioas_map *cmd = ucmd->cmd;
@@ -254,6 +280,8 @@ int iommufd_ioas_map(struct iommufd_ucmd *ucmd)
 	       IOMMU_IOAS_MAP_READABLE)) ||
 	    cmd->__reserved)
 		return -EOPNOTSUPP;
+	if (iommufd_check_vm_pfnmap(cmd->user_va))
+		return -EOPNOTSUPP;
 	if (cmd->iova >= ULONG_MAX || cmd->length >= ULONG_MAX)
 		return -EOVERFLOW;
 
-- 
2.39.3

