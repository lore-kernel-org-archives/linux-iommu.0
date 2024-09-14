Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC451CEE87
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726319169; cv=none; b=MbmJwAYwz3R0n3L8SS5Qb5fBxLjxThHH4Hjel/MqQJzw9UjNoNXwSYrpuc2G/xu9x5Y/VKxN9SCoND9an6BjsMmG5shcpEYEsXWDuC92+p9cLaEJoyvx8hfVSQ60kkW87O1Xu/lZIFqZ9ObWdweUp5FE7Gj5Wbl+lIYuxv4h9Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726319169; c=relaxed/simple;
	bh=dp3C0T9pZfGDLWv5T/5RZuWlN/kV60aCq3ITsb+u8+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EloZ9UkuihrrYXMUIlcz24FYnOig/Qo5T43tsc8inyRcKKozAXjZltBhphc2n+WZzwrRLRjnPe16EdUCOUjdOxs5URUNAUKHe2dDHN1VKArlcUHYxUHRLTPtre2A9w4or8khUaYPTWt6TG8h/UiZlqz1kMcFW12YytuqI/Iwvnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LU5Bhe2I; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LU5Bhe2I"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48EACvGU008426;
	Sat, 14 Sep 2024 13:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=nC0aDD9lletjXvc4sf/oAgk4L2f1CMjPUkgR3tAtV0U=; b=
	LU5Bhe2I+lX/gJ1P3kRrsjogA87EbRQhwTLK1nYIc2+gIsqlE4xjZxUA8avkyKv1
	V+E3GPqf34f6do3K9yuQ24uhrsKZOUqqdmCPRqAhEV/L4apt+mAXKaU9Npr3F2U3
	zTgJTbNf9x2/sXLM+QzLW1geGUyBLsAJD78kPj2zvmkrXrFGgbmr0Av4EbL+cAAZ
	NKWO6tGr39CClB1gbFJ5Nenywv1erGMyY1OBdRhhl91fOclTM4MsWyqy418E8rA5
	wHJWfqw0gDOb7V8fVTenVeo9eCtIY773lhKx/DQ/kWqnnDJ5KcxDnM35vZGbc0fX
	xE0/o+OnFujR6P923DYEHg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3pdgdrt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:06:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48E9lI7D019376;
	Sat, 14 Sep 2024 13:06:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41n0x6a1uu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:06:05 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48ED60jP024307;
	Sat, 14 Sep 2024 13:06:04 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41n0x6a1su-7;
	Sat, 14 Sep 2024 13:06:04 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 6/9] iommufd: IOMMU_IOAS_MAP_FILE implementation
Date: Sat, 14 Sep 2024 06:05:55 -0700
Message-Id: <1726319158-283074-7-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-14_09,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409140092
X-Proofpoint-GUID: 8L4q4lQthYJpcoR31pJHqAZi5rELGo1B
X-Proofpoint-ORIG-GUID: 8L4q4lQthYJpcoR31pJHqAZi5rELGo1B
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Implement the IOMMU_IOAS_MAP_FILE ioctl using the memfd_pin_folios KAPI.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/iommu/iommufd/io_pagetable.c    | 26 ++++++++++++++++++++-
 drivers/iommu/iommufd/io_pagetable.h    |  2 ++
 drivers/iommu/iommufd/ioas.c            | 40 ++++++++++++++++++++++++++++++++-
 drivers/iommu/iommufd/iommufd_private.h |  5 +++++
 drivers/iommu/iommufd/pages.c           | 16 +++++++++++++
 5 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 3f8f0de..615c1a5 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -260,7 +260,10 @@ static int iopt_alloc_area_pages(struct io_pagetable *iopt,
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
@@ -443,6 +446,27 @@ int iopt_map_user_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
 			       iommu_prot, flags);
 }
 
+/**
+ * iopt_map_file_pages() - Like iopt_map_user_pages, but map @file starting
+ * at byte offset @start.
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
index 065c28f..8c8d0ff 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1239,6 +1239,22 @@ struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
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

