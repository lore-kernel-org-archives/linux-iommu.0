Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB581EF92E
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067709; cv=none; b=ZuBqoDJGCJHoj3QjxK9bD+xgEvyVe1CNoFPtwaWc1g3jMyD6lsphgfmtNsJ4bMOd9BWAiv1gyYQZPzNefZsbLT1DWOviOtqezbvPH6uvmITKWGfLfKcY/h5R9366VoWL/GIudoM0jdIOIeDCB/XTtU35+iqX0BdmJNr0KNvhCzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067709; c=relaxed/simple;
	bh=c6rI+z747efcbUERjSFgtm3yDYdsyMwJiSqG6JjpYXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ArB360m8bs17BxPEGeR/okJDm5tshq4/7b6ueqIYngiwIKBAY4CE/qP+Qzxj11N39sTKkipJVTVg2MpFIIZdflswDQO7R2q2YjimYsQn5qSfGbt8eJoenJqosflxlhYBHuRbhKGyUC1yo8Sry/97I4zAjtv55NrhAaD25Ea6g34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gZaRfw7F; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gZaRfw7F"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494HfbuB030400;
	Fri, 4 Oct 2024 18:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=11mRThiCKG7DxWfgjqV8qvZm9p0rp/MhOhHauNxbpxg=; b=
	gZaRfw7FCFu8UBMAlhb5npGfSMfnODmqAOcCkKPkFrAkD9GI5MhxbaybuIUkybyH
	swIfMue6mdBkPbmLpiRLfuAHbcvf+pxLo+OyNVVmxFxjAkT61Zzmzxx4nxnnl3wL
	mBB0pP8mj7aE53pxUfOqX9y3e0cHu6c6XKNS67N115ETYPHAtIHHexeWzacDX+X/
	TuKZxik+SN1ZGj53FS4V4vV116cJ5ZZyAKe7WkgLnNPXtFvVDeJmLWIdQPwOORAd
	ESeIaC2JhjY/K3y1JnV0r2dEf05c4e69A+r04CRilpGGCmzyGQV1XRkQiSgpJXw2
	SMQwY1yxA2lPMnUFmhqznw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204b29qf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 18:48:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494H3t0j037929;
	Fri, 4 Oct 2024 18:48:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422057p5uj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 18:48:24 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 494ImLa2029789;
	Fri, 4 Oct 2024 18:48:24 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 422057p5sn-4;
	Fri, 04 Oct 2024 18:48:24 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 3/9] iommufd: generalize iopt_pages address
Date: Fri,  4 Oct 2024 11:48:14 -0700
Message-Id: <1728067700-32092-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
References: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_16,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040129
X-Proofpoint-ORIG-GUID: rYkjIaAeuPNRgE86VM1139F_lB6f5ITS
X-Proofpoint-GUID: rYkjIaAeuPNRgE86VM1139F_lB6f5ITS
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
---
 drivers/iommu/iommufd/io_pagetable.c | 55 ++++++++++++++++++++++--------------
 drivers/iommu/iommufd/io_pagetable.h | 13 +++++++--
 drivers/iommu/iommufd/pages.c        | 31 ++++++++++++++------
 3 files changed, 67 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 20e31e1..9dd7c03 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -375,6 +375,34 @@ int iopt_map_pages(struct io_pagetable *iopt, struct list_head *pages_list,
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
@@ -399,29 +427,14 @@ int iopt_map_user_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
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
index 0ec3509..7c4a338 100644
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
index 117f644..5419795 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1139,11 +1139,11 @@ static int pfn_reader_first(struct pfn_reader *pfns, struct iopt_pages *pages,
 	return 0;
 }
 
-struct iopt_pages *iopt_alloc_pages(void __user *uptr, unsigned long length,
-				    bool writable)
+static struct iopt_pages *iopt_alloc_pages(unsigned long length,
+					   unsigned long start_byte,
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
+	pages = iopt_alloc_pages(length, uptr - uptr_down, writable);
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

