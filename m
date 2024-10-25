Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE771632F2
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861929; cv=none; b=U0WwF8Fvl+7bYYkjZkD16SCpw0jM0Ya1oU6DdiW/EQ74U8RDEEtL9jBsD03BAAbNpzMKgSikBd1wEWLGhnnwOm5TT11yGaHbUhdEAHgdtr95yI3AlsglyWkybQqF4XQaV9kvOHnCb0ppJSOUegjSo2QiXruUHQCbR9o1fP1c1Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861929; c=relaxed/simple;
	bh=zEYrjLXJTKpPhDgSPvb0Gbt9/ZGo4xqtnDi8t3i5Wu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=B8utCR3li479VL25CXvATFJkILemg8yoHRhUPA8gP42P5lp5O/OyINf1wdOeaXKHup4NYLCPnG7X6p+VGhw6nxItsGIU3nKK5GAk9rKaC1UBhXAdmjKBrkGYwD8LnxE37zwgbrJMSGlrEb0S+itGkDISBVk2hK1xqbwJpJrqbSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ATc9HGOJ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ATc9HGOJ"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PCU1PY032547;
	Fri, 25 Oct 2024 13:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=ku17Gi8XVSGEYJSf8fBcFhnMBUA6MEN1i1FEqKH0v1Y=; b=
	ATc9HGOJgMCblnuDQx/XvqGHfEGVrM0cxY44Zjdr6v523P1FEs1j1+T2AHElL7W0
	EOkyfWHgJumngxlugo1J6XhcpSdihsuoJ2+hIDL7RiBoQkSLJ7nA95jGW9dF3K98
	s4YAusHhZk7whSyQSuvwobEW/MqSVWCnxr2qxHSZwp4s3UIq8ETcMlzAdM2HmsMi
	8GagZKkagOXBkhWtg8YwhHFsjDU+bAW0cyjBPf4epDckqiMp8RPni0VTBZ0bx3H5
	1AhKs/8QMEMDT/S96yENlNY6fRQRsVvyfsWTz/IbDsc4NQDXJqm11BHrOca3IblC
	J25vDu4WQkezeng2asRrHw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53uvwt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:12:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBxnYK016383;
	Fri, 25 Oct 2024 13:12:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhdug1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:12:03 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49PDC0Ri000657;
	Fri, 25 Oct 2024 13:12:03 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42emhdufy3-4;
	Fri, 25 Oct 2024 13:12:03 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V7 3/9] iommufd: generalize iopt_pages address
Date: Fri, 25 Oct 2024 06:11:53 -0700
Message-Id: <1729861919-234514-4-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: Atog6_wlasCGpu9gCdjS5stW1m15G66-
X-Proofpoint-ORIG-GUID: Atog6_wlasCGpu9gCdjS5stW1m15G66-
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

The starting address in iopt_pages is currently a __user *uptr.  Generalize
to allow other types of addresses.  Refactor iopt_alloc_pages and
iopt_map_user_pages into address-type specific and common functions.

Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommufd/io_pagetable.c | 55 ++++++++++++++++++++++--------------
 drivers/iommu/iommufd/io_pagetable.h | 13 +++++++--
 drivers/iommu/iommufd/pages.c        | 31 ++++++++++++++------
 3 files changed, 67 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 68ad91d..874ee9e 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -384,6 +384,34 @@ int iopt_map_pages(struct io_pagetable *iopt, struct list_head *pages_list,
 	return rc;
 }
 
+static int iopt_map_common(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
+			   struct iopt_pages *pages, unsigned long *iova,
+			   unsigned long length, unsigned long start_byte,
+			   int iommu_prot, unsigned int flags)
+{
+	struct iopt_pages_list elm = {};
+	LIST_HEAD(pages_list);
+	int rc;
+
+	elm.pages = pages;
+	elm.start_byte = start_byte;
+	if (ictx->account_mode == IOPT_PAGES_ACCOUNT_MM &&
+	    elm.pages->account_mode == IOPT_PAGES_ACCOUNT_USER)
+		elm.pages->account_mode = IOPT_PAGES_ACCOUNT_MM;
+	elm.length = length;
+	list_add(&elm.next, &pages_list);
+
+	rc = iopt_map_pages(iopt, &pages_list, length, iova, iommu_prot, flags);
+	if (rc) {
+		if (elm.area)
+			iopt_abort_area(elm.area);
+		if (elm.pages)
+			iopt_put_pages(elm.pages);
+		return rc;
+	}
+	return 0;
+}
+
 /**
  * iopt_map_user_pages() - Map a user VA to an iova in the io page table
  * @ictx: iommufd_ctx the iopt is part of
@@ -408,29 +436,14 @@ int iopt_map_user_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
 			unsigned long length, int iommu_prot,
 			unsigned int flags)
 {
-	struct iopt_pages_list elm = {};
-	LIST_HEAD(pages_list);
-	int rc;
+	struct iopt_pages *pages;
 
-	elm.pages = iopt_alloc_pages(uptr, length, iommu_prot & IOMMU_WRITE);
-	if (IS_ERR(elm.pages))
-		return PTR_ERR(elm.pages);
-	if (ictx->account_mode == IOPT_PAGES_ACCOUNT_MM &&
-	    elm.pages->account_mode == IOPT_PAGES_ACCOUNT_USER)
-		elm.pages->account_mode = IOPT_PAGES_ACCOUNT_MM;
-	elm.start_byte = uptr - elm.pages->uptr;
-	elm.length = length;
-	list_add(&elm.next, &pages_list);
+	pages = iopt_alloc_user_pages(uptr, length, iommu_prot & IOMMU_WRITE);
+	if (IS_ERR(pages))
+		return PTR_ERR(pages);
 
-	rc = iopt_map_pages(iopt, &pages_list, length, iova, iommu_prot, flags);
-	if (rc) {
-		if (elm.area)
-			iopt_abort_area(elm.area);
-		if (elm.pages)
-			iopt_put_pages(elm.pages);
-		return rc;
-	}
-	return 0;
+	return iopt_map_common(ictx, iopt, pages, iova, length,
+			       uptr - pages->uptr, iommu_prot, flags);
 }
 
 struct iova_bitmap_fn_arg {
diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index c61d744..8e48266 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -175,6 +175,10 @@ enum {
 	IOPT_PAGES_ACCOUNT_MM = 2,
 };
 
+enum iopt_address_type {
+	IOPT_ADDRESS_USER = 0,
+};
+
 /*
  * This holds a pinned page list for multiple areas of IO address space. The
  * pages always originate from a linear chunk of userspace VA. Multiple
@@ -195,7 +199,10 @@ struct iopt_pages {
 	struct task_struct *source_task;
 	struct mm_struct *source_mm;
 	struct user_struct *source_user;
-	void __user *uptr;
+	enum iopt_address_type type;
+	union {
+		void __user *uptr;		/* IOPT_ADDRESS_USER */
+	};
 	bool writable:1;
 	u8 account_mode;
 
@@ -206,8 +213,8 @@ struct iopt_pages {
 	struct rb_root_cached domains_itree;
 };
 
-struct iopt_pages *iopt_alloc_pages(void __user *uptr, unsigned long length,
-				    bool writable);
+struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
+					 unsigned long length, bool writable);
 void iopt_release_pages(struct kref *kref);
 static inline void iopt_put_pages(struct iopt_pages *pages)
 {
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 93d806c..4206e90 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1139,11 +1139,11 @@ static int pfn_reader_first(struct pfn_reader *pfns, struct iopt_pages *pages,
 	return 0;
 }
 
-struct iopt_pages *iopt_alloc_pages(void __user *uptr, unsigned long length,
-				    bool writable)
+static struct iopt_pages *iopt_alloc_pages(unsigned long start_byte,
+					   unsigned long length,
+					   bool writable)
 {
 	struct iopt_pages *pages;
-	unsigned long end;
 
 	/*
 	 * The iommu API uses size_t as the length, and protect the DIV_ROUND_UP
@@ -1152,9 +1152,6 @@ struct iopt_pages *iopt_alloc_pages(void __user *uptr, unsigned long length,
 	if (length > SIZE_MAX - PAGE_SIZE || length == 0)
 		return ERR_PTR(-EINVAL);
 
-	if (check_add_overflow((unsigned long)uptr, length, &end))
-		return ERR_PTR(-EOVERFLOW);
-
 	pages = kzalloc(sizeof(*pages), GFP_KERNEL_ACCOUNT);
 	if (!pages)
 		return ERR_PTR(-ENOMEM);
@@ -1164,8 +1161,7 @@ struct iopt_pages *iopt_alloc_pages(void __user *uptr, unsigned long length,
 	mutex_init(&pages->mutex);
 	pages->source_mm = current->mm;
 	mmgrab(pages->source_mm);
-	pages->uptr = (void __user *)ALIGN_DOWN((uintptr_t)uptr, PAGE_SIZE);
-	pages->npages = DIV_ROUND_UP(length + (uptr - pages->uptr), PAGE_SIZE);
+	pages->npages = DIV_ROUND_UP(length + start_byte, PAGE_SIZE);
 	pages->access_itree = RB_ROOT_CACHED;
 	pages->domains_itree = RB_ROOT_CACHED;
 	pages->writable = writable;
@@ -1179,6 +1175,25 @@ struct iopt_pages *iopt_alloc_pages(void __user *uptr, unsigned long length,
 	return pages;
 }
 
+struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
+					 unsigned long length, bool writable)
+{
+	struct iopt_pages *pages;
+	unsigned long end;
+	void __user *uptr_down =
+		(void __user *) ALIGN_DOWN((uintptr_t)uptr, PAGE_SIZE);
+
+	if (check_add_overflow((unsigned long)uptr, length, &end))
+		return ERR_PTR(-EOVERFLOW);
+
+	pages = iopt_alloc_pages(uptr - uptr_down, length, writable);
+	if (IS_ERR(pages))
+		return pages;
+	pages->uptr = uptr_down;
+	pages->type = IOPT_ADDRESS_USER;
+	return pages;
+}
+
 void iopt_release_pages(struct kref *kref)
 {
 	struct iopt_pages *pages = container_of(kref, struct iopt_pages, kref);
-- 
1.8.3.1

