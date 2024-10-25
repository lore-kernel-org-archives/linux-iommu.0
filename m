Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EC11CDA36
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861933; cv=none; b=Eo5Y8NhVSOv+4lp+0xoRjJlCmY3qhftCKbIMcALG7s1BGdl2JJtiOZTBztNNprzTg0Ph2kZUITQQlApk+qa+tV8nX8LdEzVE/MafJh9lwz0EcBiWrGG5k/JNbwKtSxtbb1iaUz0fd/bxLpLblBy9EjXdBQGQX34hE2FHiSARzAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861933; c=relaxed/simple;
	bh=Q3xWbxjlIpUHzaph9LNHHsMe++sfYAzDeaSqYQQqrtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LKM6lKztdHkYR2USwgtGKihTeoOaTWrXpeuqG7l4EOGxJbmhPl0i62KGa10EYi09okzmwHdTx5UHvoKjNHejdE8OOlekkZgUE+czRDwAc5RTaWAsXPwoSb4Q6d2gw629J6xfmkd/2pw8jKwh5xYR8OPJtrTQyjAeY4nmKyBysjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oTDI8VEZ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oTDI8VEZ"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PCTkRo017036;
	Fri, 25 Oct 2024 13:12:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=JoEkr/zVIvL4lZ4ag+cn5npbVC2lI4fi7Qxa9GDRfbI=; b=
	oTDI8VEZ7Z/V7c7LRQHutbtdsapxjJdcJ6nrZtn0CXBS1oIoCxc3e1RASVcXfshD
	nONJ+rT5vYBn2JEqfdia8oZtQd1T6DgHzDlvGzfQ/2otFbQlS5WQuMcagAXwV0sT
	FazxJ1U/6Kg07A3i6nxp+bEv/XSG1O84UXZTmL+B+EG52QV2A8ib7llHtmhwzpI6
	wDHFVA9ehVbk6T4119WUGA357UqMybcvK4ST06Zo9ph7kTGlnlzLwQbG6SsU1LMs
	Y4hmI96bCTf1ujkogqWIv5FUd4TIWlUfbJC12j8uUaojol1YiQzDwHMPWXzA8Uvj
	by51vAp3T0vnI4OkqJ0QzQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3m04k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:12:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBxp3G016550;
	Fri, 25 Oct 2024 13:12:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhdug30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:12:07 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49PDC0Rq000657;
	Fri, 25 Oct 2024 13:12:06 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42emhdufy3-8;
	Fri, 25 Oct 2024 13:12:06 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V7 7/9] iommufd: IOMMU_IOAS_MAP_FILE
Date: Fri, 25 Oct 2024 06:11:57 -0700
Message-Id: <1729861919-234514-8-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_12,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250102
X-Proofpoint-ORIG-GUID: IFlESgGCOgg7W86QSlyfedzua5T7a-jK
X-Proofpoint-GUID: IFlESgGCOgg7W86QSlyfedzua5T7a-jK
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Define the IOMMU_IOAS_MAP_FILE ioctl interface, which allows a user to
register memory by passing a memfd plus offset and length.  Implement it
using the memfd_pin_folios KAPI.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommufd/io_pagetable.c    | 36 ++++++++++++++++++++++++-
 drivers/iommu/iommufd/io_pagetable.h    |  2 ++
 drivers/iommu/iommufd/ioas.c            | 47 +++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  5 ++++
 drivers/iommu/iommufd/main.c            |  2 ++
 drivers/iommu/iommufd/pages.c           | 23 ++++++++++++++++
 include/uapi/linux/iommufd.h            | 25 ++++++++++++++++++
 7 files changed, 139 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 874ee9e..8a790e5 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -268,7 +268,14 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
 		/* Use the first entry to guess the ideal IOVA alignment */
 		elm = list_first_entry(pages_list, struct iopt_pages_list,
 				       next);
-		start = elm->start_byte + (uintptr_t)elm->pages->uptr;
+		switch (elm->pages->type) {
+		case IOPT_ADDRESS_USER:
+			start = elm->start_byte + (uintptr_t)elm->pages->uptr;
+			break;
+		case IOPT_ADDRESS_FILE:
+			start = elm->start_byte + elm->pages->start;
+			break;
+		}
 		rc = iopt_alloc_iova(iopt, dst_iova, start, length);
 		if (rc)
 			goto out_unlock;
@@ -446,6 +453,33 @@ int iopt_map_user_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
 			       uptr - pages->uptr, iommu_prot, flags);
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
+			unsigned long *iova, struct file *file,
+			unsigned long start, unsigned long length,
+			int iommu_prot, unsigned int flags)
+{
+	struct iopt_pages *pages;
+
+	pages = iopt_alloc_file_pages(file, start, length,
+				      iommu_prot & IOMMU_WRITE);
+	if (IS_ERR(pages))
+		return PTR_ERR(pages);
+	return iopt_map_common(ictx, iopt, pages, iova, length,
+			       start - pages->start, iommu_prot, flags);
+}
+
 struct iova_bitmap_fn_arg {
 	unsigned long flags;
 	struct io_pagetable *iopt;
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 5ac4eed..9b40b22 100644
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
index 2c4b2bb..c05d33f 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
  */
+#include <linux/file.h>
 #include <linux/interval_tree.h>
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
@@ -197,6 +198,52 @@ static int conv_iommu_prot(u32 map_flags)
 	return iommu_prot;
 }
 
+int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_ioas_map_file *cmd = ucmd->cmd;
+	unsigned long iova = cmd->iova;
+	struct iommufd_ioas *ioas;
+	unsigned int flags = 0;
+	struct file *file;
+	int rc;
+
+	if (cmd->flags &
+	     ~(IOMMU_IOAS_MAP_FIXED_IOVA | IOMMU_IOAS_MAP_WRITEABLE |
+	       IOMMU_IOAS_MAP_READABLE))
+		return -EOPNOTSUPP;
+
+	if (cmd->iova >= ULONG_MAX || cmd->length >= ULONG_MAX)
+		return -EOVERFLOW;
+
+	if (!(cmd->flags &
+	      (IOMMU_IOAS_MAP_WRITEABLE | IOMMU_IOAS_MAP_READABLE)))
+		return -EINVAL;
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
+	rc = iopt_map_file_pages(ucmd->ictx, &ioas->iopt, &iova, file,
+				 cmd->start, cmd->length,
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
+}
+
 int iommufd_ioas_map(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_ioas_map *cmd = ucmd->cmd;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index f1d865e..8f3c21a 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -69,6 +69,10 @@ int iopt_map_user_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
 			unsigned long *iova, void __user *uptr,
 			unsigned long length, int iommu_prot,
 			unsigned int flags);
+int iopt_map_file_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
+			unsigned long *iova, struct file *file,
+			unsigned long start, unsigned long length,
+			int iommu_prot, unsigned int flags);
 int iopt_map_pages(struct io_pagetable *iopt, struct list_head *pages_list,
 		   unsigned long length, unsigned long *dst_iova,
 		   int iommu_prot, unsigned int flags);
@@ -276,6 +280,7 @@ static inline struct iommufd_ioas *iommufd_get_ioas(struct iommufd_ctx *ictx,
 int iommufd_ioas_iova_ranges(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_allow_iovas(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_map(struct iommufd_ucmd *ucmd);
+int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_copy(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index b5f5d27..826a2b2 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -378,6 +378,8 @@ struct iommufd_ioctl_op {
 		 struct iommu_ioas_iova_ranges, out_iova_alignment),
 	IOCTL_OP(IOMMU_IOAS_MAP, iommufd_ioas_map, struct iommu_ioas_map,
 		 iova),
+	IOCTL_OP(IOMMU_IOAS_MAP_FILE, iommufd_ioas_map_file,
+		 struct iommu_ioas_map_file, iova),
 	IOCTL_OP(IOMMU_IOAS_UNMAP, iommufd_ioas_unmap, struct iommu_ioas_unmap,
 		 length),
 	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option,
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 5f371fa..2ee6fcd 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -45,6 +45,7 @@
  * last_iova + 1 can overflow. An iopt_pages index will always be much less than
  * ULONG_MAX so last_index + 1 cannot overflow.
  */
+#include <linux/file.h>
 #include <linux/highmem.h>
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
@@ -1340,6 +1341,26 @@ struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
 	return pages;
 }
 
+struct iopt_pages *iopt_alloc_file_pages(struct file *file, unsigned long start,
+					 unsigned long length, bool writable)
+
+{
+	struct iopt_pages *pages;
+	unsigned long start_down = ALIGN_DOWN(start, PAGE_SIZE);
+	unsigned long end;
+
+	if (length && check_add_overflow(start, length - 1, &end))
+		return ERR_PTR(-EOVERFLOW);
+
+	pages = iopt_alloc_pages(start - start_down, length, writable);
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
@@ -1352,6 +1373,8 @@ void iopt_release_pages(struct kref *kref)
 	mutex_destroy(&pages->mutex);
 	put_task_struct(pages->source_task);
 	free_uid(pages->source_user);
+	if (pages->type == IOPT_ADDRESS_FILE)
+		fput(pages->file);
 	kfree(pages);
 }
 
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 72010f7..41b1a01 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -51,6 +51,7 @@ enum {
 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP = 0x8c,
 	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
 	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
+	IOMMUFD_CMD_IOAS_MAP_FILE = 0x8f,
 };
 
 /**
@@ -214,6 +215,30 @@ struct iommu_ioas_map {
 #define IOMMU_IOAS_MAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP)
 
 /**
+ * struct iommu_ioas_map_file - ioctl(IOMMU_IOAS_MAP_FILE)
+ * @size: sizeof(struct iommu_ioas_map_file)
+ * @flags: same as for iommu_ioas_map
+ * @ioas_id: same as for iommu_ioas_map
+ * @fd: the memfd to map
+ * @start: byte offset from start of file to map from
+ * @length: same as for iommu_ioas_map
+ * @iova: same as for iommu_ioas_map
+ *
+ * Set an IOVA mapping from a memfd file.  All other arguments and semantics
+ * match those of IOMMU_IOAS_MAP.
+ */
+struct iommu_ioas_map_file {
+	__u32 size;
+	__u32 flags;
+	__u32 ioas_id;
+	__s32 fd;
+	__aligned_u64 start;
+	__aligned_u64 length;
+	__aligned_u64 iova;
+};
+#define IOMMU_IOAS_MAP_FILE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP_FILE)
+
+/**
  * struct iommu_ioas_copy - ioctl(IOMMU_IOAS_COPY)
  * @size: sizeof(struct iommu_ioas_copy)
  * @flags: Combination of enum iommufd_ioas_map_flags
-- 
1.8.3.1

