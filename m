Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF10F1AB500
	for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190349; cv=none; b=SFpYp3Nujc+Axnba50jRqIHm3hL9tY0XIWrlid4sjJI7UaBYobk9JtLROKuZrhoNX9jP6IQzQbjZfELyVmnOnH5NKGVb0HlWgUMsiNqsuxeufUisDjKwEtxqcjN/swCMbJJ/PIXxJArWLJMqnZKG6zFZYznvGb51fgGS+ik5JZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190349; c=relaxed/simple;
	bh=D++/H1CabO6oL2wMP8FYjlkrKzduKMU320O3t0ezkvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Tgw8amqTUKyqFxcUtxQbKkSuvILAU4VGoQkDZpKCCFMu7q+m9SSbn0klbEBh3j+WT1Sqi06XOtDJ4n0edFaIp8qWecIDJKzu3Gmd1M0YWRn+6k+sfLcxqT308KjVYd43Q/TswWOdaudaw4FyLjjZwVfgsuz73TPN1FHeOQN8vp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ScvF444K; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ScvF444K"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OEQWtR032372;
	Tue, 24 Sep 2024 15:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=7FYnM+VpRyXck9ItOr6FsnFDl8piWkincoHsEu7ftsU=; b=
	ScvF444KBwilm/jLv567Q4Ktxnr8vELhF6ZchzD2aUHwerzztCa7+8LbDi8fOovi
	YUyxdAoPKHe5z9ej2A5PPN0P9bS/jAtkWHUHMKdRq9OBLTKPZ+hw30iP+2E2K0Fu
	jQTGcxgeU5M80l/jbr8z4gdlR5nQz4sQb9eJh0sn0lA2aZzqyxV6JqxY02LO6yXD
	ZpnVWBbaAj1MGZvl/W1woARHpm9MMJD8izXF2J+8+3XsmA5DYZIe5xHWzdMcy8mt
	QSwouhEO0XrHxNxdE92+kfQoHv09mqkjBxBl06u00veXmMagILGUZ6P0Sowo4HUT
	vv8V5HcHZde5AGk/FjosrQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sppu7qcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:05:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OEVJp5004812;
	Tue, 24 Sep 2024 15:05:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smk9cr4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:05:45 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48OF5dLL027122;
	Tue, 24 Sep 2024 15:05:44 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41smk9cqxg-6;
	Tue, 24 Sep 2024 15:05:44 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 5/9] iommufd: IOMMU_IOAS_MAP_FILE implementation
Date: Tue, 24 Sep 2024 08:05:34 -0700
Message-Id: <1727190338-385692-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409240108
X-Proofpoint-GUID: yT_t1Wqs1jwIXBVYbSI9KXDJW8Lw1zCJ
X-Proofpoint-ORIG-GUID: yT_t1Wqs1jwIXBVYbSI9KXDJW8Lw1zCJ
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Implement the IOMMU_IOAS_MAP_FILE ioctl using the memfd_pin_folios KAPI.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/iommu/iommufd/io_pagetable.c    | 34 +++++++++++++++++++++++++++-
 drivers/iommu/iommufd/io_pagetable.h    |  2 ++
 drivers/iommu/iommufd/ioas.c            | 40 ++++++++++++++++++++++++++++++++-
 drivers/iommu/iommufd/iommufd_private.h |  5 +++++
 drivers/iommu/iommufd/pages.c           | 19 +++++++++++++++-
 5 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index a0a66f1..1e14a0f 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -259,7 +259,10 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
 		/* Use the first entry to guess the ideal IOVA alignment */
 		elm = list_first_entry(pages_list, struct iopt_pages_list,
 				       next);
-		start = elm->start_byte + (uintptr_t)elm->pages->uptr;
+		if (elm->pages->type == IOPT_ADDRESS_FILE)
+			start = elm->start_byte + elm->pages->start;
+		else
+			start = elm->start_byte + (uintptr_t)elm->pages->uptr;
 		rc = iopt_alloc_iova(iopt, dst_iova, start, length);
 		if (rc)
 			goto out_unlock;
@@ -442,6 +445,35 @@ int iopt_map_user_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
 			       iommu_prot, flags);
 }
 
+/**
+ * iopt_map_file_pages() - Like iopt_map_user_pages, but map a file.
+ * @ictx: iommufd_ctx the iopt is part of
+ * @iopt: io_pagetable to act on
+ * @iova: If IOPT_ALLOC_IOVA is set this is unused on input and contains
+ *        the chosen iova on output. Otherwise is the iova to map to on input
+ * @file: file to map
+ * @start: map file starting at this byte offset
+ * @length: Number of bytes to map
+ * @iommu_prot: Combination of IOMMU_READ/WRITE/etc bits for the mapping
+ * @flags: IOPT_ALLOC_IOVA or zero
+ */
+int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
+			unsigned long *iova,
+			struct file *file, unsigned long start,
+			unsigned long length, int iommu_prot,
+			unsigned int flags)
+{
+	struct iopt_pages *pages;
+
+	pages = iopt_alloc_file_pages(file, start, length,
+				      iommu_prot & IOMMU_WRITE);
+	if (IS_ERR(pages))
+		return PTR_ERR(pages);
+	return iopt_map_common(ictx, iopt, pages, iova, length,
+			       start - pages->start,
+			       iommu_prot, flags);
+}
+
 struct iova_bitmap_fn_arg {
 	unsigned long flags;
 	struct io_pagetable *iopt;
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 3a28f46..909d396 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -220,6 +220,8 @@ struct iopt_pages {
 
 struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
 					 unsigned long length, bool writable);
+struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
+					 unsigned long length, bool writable);
 void iopt_release_pages(struct kref *kref);
 static inline void iopt_put_pages(struct iopt_pages *pages)
 {
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 270e8ea..2d25ba0 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
  */
+#include <linux/file.h>
 #include <linux/interval_tree.h>
 #include <linux/iommufd.h>
 #include <linux/iommu.h>
@@ -199,7 +200,44 @@ static int conv_iommu_prot(u32 map_flags)
 
 int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
 {
-	return -ENOTTY;
+	struct iommu_ioas_map_file *cmd = ucmd->cmd;
+	unsigned long iova = cmd->iova;
+	struct iommufd_ioas *ioas;
+	unsigned int flags = 0;
+	int rc;
+	struct file *file;
+	unsigned long end;
+
+	if (cmd->iova >= ULONG_MAX || cmd->length >= ULONG_MAX)
+		return -EOVERFLOW;
+
+	if (check_add_overflow(cmd->start, cmd->length - 1, &end))
+		return -EOVERFLOW;
+
+	ioas = iommufd_get_ioas(ucmd->ictx, cmd->ioas_id);
+	if (IS_ERR(ioas))
+		return PTR_ERR(ioas);
+
+	if (!(cmd->flags & IOMMU_IOAS_MAP_FIXED_IOVA))
+		flags = IOPT_ALLOC_IOVA;
+
+	file = fget(cmd->fd);
+	if (!file)
+		return -EBADF;
+
+	rc = iopt_map_file_pages(ucmd->ictx, &ioas->iopt, &iova,
+				 file, cmd->start,
+				 cmd->length,
+				 conv_iommu_prot(cmd->flags), flags);
+	if (rc)
+		goto out_put;
+
+	cmd->iova = iova;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+out_put:
+	iommufd_put_object(ucmd->ictx, &ioas->obj);
+	fput(file);
+	return rc;
 }
 
 int iommufd_ioas_map(struct iommufd_ucmd *ucmd)
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 21ec075..0ebb5bd 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -68,6 +68,11 @@ int iopt_map_user_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
 			unsigned long *iova, void __user *uptr,
 			unsigned long length, int iommu_prot,
 			unsigned int flags);
+int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
+			unsigned long *iova,
+			struct file *file, unsigned long start,
+			unsigned long length, int iommu_prot,
+			unsigned int flags);
 int iopt_map_pages(struct io_pagetable *iopt, struct list_head *pages_list,
 		   unsigned long length, unsigned long *dst_iova,
 		   int iommu_prot, unsigned int flags);
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index df5ba4f..0a432dc2 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -902,7 +902,8 @@ static int update_mm_locked_vm(struct iopt_pages *pages, unsigned long npages,
 		mmap_read_unlock(pages->source_mm);
 		user->locked = 0;
 		/* If we had the lock then we also have a get */
-	} else if ((!user || !user->upages) &&
+
+	} else if ((!user || (!user->upages && !user->ufolios)) &&
 		   pages->source_mm != current->mm) {
 		if (!mmget_not_zero(pages->source_mm))
 			return -EINVAL;
@@ -1257,6 +1258,22 @@ struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
 	return pages;
 }
 
+struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
+					 unsigned long length, bool writable)
+
+{
+	struct iopt_pages *pages;
+	unsigned long start_down = ALIGN_DOWN(start, PAGE_SIZE);
+
+	pages = iopt_alloc_pages(length, start - start_down, writable);
+	if (IS_ERR(pages))
+		return pages;
+	pages->file = get_file(file);
+	pages->start = start_down;
+	pages->type = IOPT_ADDRESS_FILE;
+	return pages;
+}
+
 void iopt_release_pages(struct kref *kref)
 {
 	struct iopt_pages *pages = container_of(kref, struct iopt_pages, kref);
-- 
1.8.3.1

