Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CF653368
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358839; cv=none; b=M5o0jlaD3WoXPLqF9IUyUnI7lWfM/20m8w7gtQB7Y/Gzz5NdyzfBRT9rEiDLDPFx7vRP0CCb8ig7LgI2snXtnuAb6CY4hWTOVcSvhHCc6No8G0/SU+351+3K94WT+cdQEYwpegSjRxC2kgn2LsIB/ozZEJ3/zbvhLxvPegjIxWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358839; c=relaxed/simple;
	bh=XbKd84wEZNsfBoLPq/X/a37LjZ3bgELvxIHNzERya1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WO369RC9OEYgSZd4KWzO6Y0ly3wruhh1sxDJmgprLT3/FF66kADScgt1j6VVQqcvTw7z9f7TW0D3a2ch58tFYVwBAYItBiJbKkl7zP0Mqd/neWtcNAwK77CfC4Rg41iNabEcFvcIQLvlbztjDrAO2nvlmDQMiFVM+A+rtyUGEdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CZg91wM5; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CZg91wM5"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QAvrLT029222;
	Thu, 26 Sep 2024 13:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=MvQ54NV/eNOaScBFw1ThqqcnStZMjsCLAlMdYoQ0p6A=; b=
	CZg91wM5dlj0jMrTHyD2DMQdcM1mm42MNS0V1W4SJL3BAelRWGhNzWdVD+ZLE7Pa
	5XXMgaGHFL2hPYBQRs2JoRKUWDHdSq3ctNLXuWG+97RFr3nj2cboDr9pqW5/nl5J
	VXfdwfFsmO93fH0cl5ZPdc7cTxRudC3e0cF50zEtr39OIkqsDU6tHzWv3JNYJ519
	dSE8fh3xqS2gt8zmBxeTyAd6bQQPzA5DTRXNGy6SNCTg7zlbcA6c0WyYqepSUYY8
	HJX3FXyxpNj4W0qG3BKuE4OCFGtvPz8U3r4nIlXRE5SVritIDVcga2HLDj7/7pgt
	/tH2RpdKPMZCwDQr1WYG0g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sn2cwb44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 13:53:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48QCmkm7032834;
	Thu, 26 Sep 2024 13:53:54 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkjfd9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 13:53:54 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48QDroXW027500;
	Thu, 26 Sep 2024 13:53:53 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41smkjfd62-4;
	Thu, 26 Sep 2024 13:53:53 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 3/4] iommufd: Add IOMMU_IOAS_CHANGE_PROCESS
Date: Thu, 26 Sep 2024 06:53:47 -0700
Message-Id: <1727358828-97791-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1727358828-97791-1-git-send-email-steven.sistare@oracle.com>
References: <1727358828-97791-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_04,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409260096
X-Proofpoint-GUID: MC2_MUMrngXGhAklY6xosZB8z-_pXeCq
X-Proofpoint-ORIG-GUID: MC2_MUMrngXGhAklY6xosZB8z-_pXeCq
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Add an ioctl that updates all DMA mappings to reflect the current process,
Change the mm and transfer locked memory accounting from old to current mm.
This will be used for live update, allowing an old process to hand the
iommufd device descriptor to a new process.  The new process calls the
ioctl.

IOMMU_IOAS_CHANGE_PROCESS only supports DMA mappings created with
IOMMU_IOAS_MAP_FILE, because the kernel metadata for such mappings does not
depend on the userland VA of the pages (which is different in the new process).
IOMMU_IOAS_CHANGE_PROCESS fails if other types of mappings are present.

This code is substantially the same as an initial version provided by Jason,
plus fixes.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/iommu/iommufd/io_pagetable.h    |   1 +
 drivers/iommu/iommufd/ioas.c            | 142 ++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |   1 +
 drivers/iommu/iommufd/main.c            |   2 +
 include/uapi/linux/iommufd.h            |  23 ++++++
 5 files changed, 169 insertions(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 5552911..255fb01 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -173,6 +173,7 @@ enum {
 	IOPT_PAGES_ACCOUNT_NONE = 0,
 	IOPT_PAGES_ACCOUNT_USER = 1,
 	IOPT_PAGES_ACCOUNT_MM = 2,
+	IOPT_PAGES_ACCOUNT_MODE_NUM = 3,
 };
 
 enum iopt_address_type {
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 8eb869d..122a40b 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -437,6 +437,148 @@ static int iommufd_take_all_iova_rwsem(struct iommufd_ctx *ictx,
 	return 0;
 }
 
+static bool need_charge_update(struct iopt_pages *pages)
+{
+	switch (pages->account_mode) {
+	case IOPT_PAGES_ACCOUNT_NONE:
+		return false;
+	case IOPT_PAGES_ACCOUNT_MM:
+		return pages->source_mm != current->mm;
+	case IOPT_PAGES_ACCOUNT_USER:
+		/*
+		 * Update when mm changes because it also accounts
+		 * in mm->pinned_vm.
+		 */
+		return (pages->source_user != current_user()) ||
+		       (pages->source_mm != current->mm);
+	}
+	return true;
+}
+
+static int charge_current(unsigned long *npinned)
+{
+	struct iopt_pages tmp = {
+		.source_mm = current->mm,
+		.source_task = current->group_leader,
+		.source_user = current_user(),
+	};
+	unsigned int account_mode;
+	int rc;
+
+	for (account_mode = 0; account_mode != IOPT_PAGES_ACCOUNT_MODE_NUM;
+	     account_mode++) {
+		if (!npinned[account_mode])
+			continue;
+
+		tmp.account_mode = account_mode;
+		rc = iopt_update_pinned(&tmp, npinned[account_mode], true,
+					NULL);
+		if (rc)
+			goto err_undo;
+	}
+	return 0;
+
+err_undo:
+	while (account_mode != 0) {
+		account_mode--;
+		tmp.account_mode = account_mode;
+		iopt_update_pinned(&tmp, npinned[account_mode], false, NULL);
+	}
+	return rc;
+}
+
+static void change_mm(struct iopt_pages *pages)
+{
+	struct task_struct *old_task = pages->source_task;
+	struct user_struct *old_user = pages->source_user;
+	struct mm_struct *old_mm = pages->source_mm;
+
+	pages->source_mm = current->mm;
+	mmgrab(pages->source_mm);
+	mmdrop(old_mm);
+
+	pages->source_task = current->group_leader;
+	get_task_struct(pages->source_task);
+	put_task_struct(old_task);
+
+	pages->source_user = get_uid(current_user());
+	free_uid(old_user);
+}
+
+#define for_each_ioas_area(_xa, _index, _ioas, _area) \
+	xa_for_each((_xa), (_index), (_ioas)) \
+		for (_area = iopt_area_iter_first(&_ioas->iopt, 0, ULONG_MAX); \
+		     _area; \
+		     _area = iopt_area_iter_next(_area, 0, ULONG_MAX))
+
+int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd)
+{
+	struct iommu_ioas_change_process *cmd = ucmd->cmd;
+	struct iommufd_ctx *ictx = ucmd->ictx;
+	unsigned long all_npinned[IOPT_PAGES_ACCOUNT_MODE_NUM] = {0, 0, 0};
+	struct iommufd_ioas *ioas;
+	struct iopt_area *area;
+	struct iopt_pages *pages;
+	struct xarray ioas_list;
+	unsigned long index;
+	int rc;
+
+	if (cmd->__reserved)
+		return -EOPNOTSUPP;
+
+	xa_init(&ioas_list);
+	rc = iommufd_take_all_iova_rwsem(ictx, &ioas_list);
+	if (rc)
+		goto out_no_release;
+
+	for_each_ioas_area(&ioas_list, index, ioas, area)  {
+		if (area->pages->type != IOPT_ADDRESS_FILE) {
+			rc = -EINVAL;
+			goto out;
+		}
+	}
+
+	/*
+	 * Count last_pinned pages, then clear it to avoid double counting
+	 * if the same iopt_pages is visited multiple times in this loop.
+	 * Since we are under all the locks, npinned == last_npinned, so we
+	 * can easily restore last_npinned before we return.
+	 */
+	for_each_ioas_area(&ioas_list, index, ioas, area)  {
+		pages = area->pages;
+
+		if (need_charge_update(pages)) {
+			all_npinned[pages->account_mode] += pages->last_npinned;
+			pages->last_npinned = 0;
+		}
+	}
+
+	rc = charge_current(all_npinned);
+
+	if (rc) {
+		/* Charge failed.  Fix last_npinned and bail. */
+		for_each_ioas_area(&ioas_list, index, ioas, area)
+			area->pages->last_npinned = area->pages->npinned;
+		goto out;
+	}
+
+	for_each_ioas_area(&ioas_list, index, ioas, area) {
+		pages = area->pages;
+
+		/* Uncharge the old one (which also restores last_npinned) */
+		if (need_charge_update(pages))
+			iopt_update_pinned(pages, pages->npinned, false, NULL);
+
+		change_mm(pages);
+	}
+
+out:
+	iommufd_release_all_iova_rwsem(ictx, &ioas_list);
+
+out_no_release:
+	return rc;
+}
+
 int iommufd_option_rlimit_mode(struct iommu_option *cmd,
 			       struct iommufd_ctx *ictx)
 {
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 06a52f2..968bc17 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -282,6 +282,7 @@ static inline struct iommufd_ioas *iommufd_get_ioas(struct iommufd_ctx *ictx,
 int iommufd_ioas_allow_iovas(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_map(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd);
+int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_copy(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 13ec031..244eb4d 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -373,6 +373,8 @@ struct iommufd_ioctl_op {
 		 struct iommu_ioas_alloc, out_ioas_id),
 	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
 		 struct iommu_ioas_allow_iovas, allowed_iovas),
+	IOCTL_OP(IOMMU_IOAS_CHANGE_PROCESS, iommufd_ioas_change_process,
+		 struct iommu_ioas_change_process, size),
 	IOCTL_OP(IOMMU_IOAS_COPY, iommufd_ioas_copy, struct iommu_ioas_copy,
 		 src_iova),
 	IOCTL_OP(IOMMU_IOAS_IOVA_RANGES, iommufd_ioas_iova_ranges,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index c484981..523de8c 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -52,6 +52,7 @@ enum {
 	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
 	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
 	IOMMUFD_CMD_IOAS_MAP_FILE = 0x8f,
+	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x90,
 };
 
 /**
@@ -822,4 +823,26 @@ struct iommu_fault_alloc {
 	__u32 out_fault_fd;
 };
 #define IOMMU_FAULT_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_FAULT_QUEUE_ALLOC)
+
+/**
+ * struct iommu_ioas_change_process - ioctl(VFIO_IOAS_CHANGE_PROCESS)
+ * @size: sizeof(struct iommu_ioas_change_process)
+ * @__reserved: Must be 0
+ *
+ * This transfers pinned memory counts for every memory map in every IOAS
+ * in the context to the current process.  This only supports maps created
+ * with IOMMU_IOAS_MAP_FILE, and returns EINVAL if other maps are present.
+ * If the ioctl returns a failure status, then nothing is changed.
+ *
+ * This API is useful for transferring operation of a device from one process
+ * to another, such as during userland live update.
+ */
+struct iommu_ioas_change_process {
+	__u32 size;
+	__u32 __reserved;
+};
+
+#define IOMMU_IOAS_CHANGE_PROCESS \
+	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_CHANGE_PROCESS)
+
 #endif
-- 
1.8.3.1

