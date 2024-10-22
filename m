Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679CC13AD2A
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 21:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630851; cv=none; b=Xxx7ECHEF8SLOpuC0xHfh5YCuOc0l9LJjOHMIeBE4J+ZLHKl9wiIlRUB3rSWawsq2Y6PtWBsg/GV75x22Jxn8Ezz4cirFOaFYMU7gQDwXRlScPBJQmfiyjvzGJZit+Xz7msYqTKLibAx3yaVCF7PaVieTKm5LwMloyxrHooTNOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630851; c=relaxed/simple;
	bh=gDJZRTyrHsTC2CbmhegQOkn0oxrljmqtJaxKI05ri2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qWGYNc0HoQ6WcIopVRbQ3kyptiLkqKre4qveBQUxZwFRDXabFwKNct3Goznrg9ec/IznISoFPenBIR2YjoA0+wpCcxggGlcg1nvZcQV3CkLzT5cCMZlql+L+xtK39IwpLhbSfeQ0K6lXvG1G/mxDL+9DxaKXIbeIca69AFgkS9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bpumn6md; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bpumn6md"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MKqMMR005978;
	Tue, 22 Oct 2024 21:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=/O+blJF9nfbs5xaaQlq030l4W7LntJCLSfmaRCuEeYo=; b=
	Bpumn6mdtKp8HZo8mDGkCUtKnnDhOfKgRY1wDAfRYvIuQNdoCCRCip3DIwjukd9V
	4tKWQ16XEgC2r9kn25vnFSURTj2Ik2QOmWQuEBzTqIkbIfxWfSDdq6aHyOxle4MU
	bYbWLozrrXfUu/ta/7Ru0rGWAnawfLNG7Mim3y94tKmT5StQW15XZ0yrO0tA3cpG
	ZeRJqeb/5kocUtYdBToqopGLDM7+v7HtoliY7O+YWEZ71y0Ymnd/jArzFI1Jhk5E
	0hqqbhIa39hiV64Zw0KgrZP3sc7k+1gZdz8NEvuXFdz7aQLtUz+KHL2hlpboqyX9
	h7wRcv8s/vaeumFSadoFmA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qept1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 21:00:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MKj6m7011992;
	Tue, 22 Oct 2024 21:00:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c3781ama-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 21:00:46 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49ML0dEo016716;
	Tue, 22 Oct 2024 21:00:46 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42c3781a7p-8;
	Tue, 22 Oct 2024 21:00:45 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 7/9] iommufd: IOMMU_IOAS_MAP_FILE
Date: Tue, 22 Oct 2024 14:00:36 -0700
Message-Id: <1729630838-24586-8-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_23,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410220135
X-Proofpoint-ORIG-GUID: tIQwRKz6nOohoUVYj7xfbRbe8zVtpkqu
X-Proofpoint-GUID: tIQwRKz6nOohoUVYj7xfbRbe8zVtpkqu
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
---
 drivers/iommu/iommufd/io_pagetable.c    | 36 ++++++++++++++++++++++++++++++-
 drivers/iommu/iommufd/io_pagetable.h    |  2 ++
 drivers/iommu/iommufd/ioas.c            | 38 +++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  5 +++++
 drivers/iommu/iommufd/main.c            |  2 ++
 drivers/iommu/iommufd/pages.c           | 23 ++++++++++++++++++++
 include/uapi/linux/iommufd.h            | 25 ++++++++++++++++++++++
 7 files changed, 130 insertions(+), 1 deletion(-)

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
index 2c4b2bb..3d31bcf 100644
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
@@ -197,6 +198,43 @@ static int conv_iommu_prot(u32 map_flags)
 	return iommu_prot;
 }
 
+int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_ioas_map_file *cmd = ucmd->cmd;
+	unsigned long iova = cmd->iova;
+	struct iommufd_ioas *ioas;
+	unsigned int flags = 0;
+	int rc;
+	struct file *file;
+
+	if (cmd->iova >= ULONG_MAX || cmd->length >= ULONG_MAX)
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
index 59d40c1..1b8c3bf 100644
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
@@ -1352,6 +1373,8 @@ void iopt_release_pages(struct kref *kref)
 	mutex_destroy(&pages->mutex);
 	put_task_struct(pages->source_task);
 	free_uid(pages->source_user);
+	if (pages->type == IOPT_ADDRESS_FILE)
+		fput(pages->file);
 	kfree(pages);
 }
 
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 72010f7..a8f0d30 100644
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
+ * @fd: the memfd to map
+ * @start: byte offset from start of file to map from
+ * @flags: same as for iommu_ioas_map
+ * @ios_id: ditto
+ * @length: ditto
+ * @iova: ditto
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

