Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8681521830B
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016025; cv=none; b=W6SFAKbzUpnF6u1RaT7dDyObw24UfVJMBA4j51u9T0Or95R+5QIP2vgF8s/djTIC0iudr8Fnz0i8vlHQNC7GI+5u2ufCxd49dIpUwp4A6K4jOV7ED+2RS0lKT5Ytwu/q09ZSueTSC7y0VbRCyvHNmcFcb7qKrjfEEEjmeYVxaSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016025; c=relaxed/simple;
	bh=SKg8UuSQ1cvejXcANo9RNGaR5E5rCrWILgz03LNmAsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=D0kMCAN/BaqhRHOxFjM9aBRNVv2Htt22XBxJBruM49i92xXlBPQ0Lv4NcQS7XVQa/+f2a0sJrK27NPpugM6nBO+MLwEiKdebG4OS7Xxf+0m3eX70MszAWnrOPW2JwiYlfW4zKDQPsdqhapyM/L0t3Lms/sqlvcLX602znCfInpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HrTHbgY7; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HrTHbgY7"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7Lfdc2021798;
	Thu, 7 Nov 2024 21:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=B4noxrx80mIWMJvnq8dXsiiLTGlfMVMJyHo/1+5vRHc=; b=
	HrTHbgY70eU4f/okyMcE+2W/rGMDu86S5bmM0VXzla1AjgKHkJAPVfpExc2JHQxM
	35JpK+lplJQwE7+mJqEdPb256SpSPQGfmcmwdXSkf2erhmjLW21fg0rOxTZswrG/
	vBxfkaaZ/iKX2zYFc/gep6o8xMBLLhJ4EzkYCVwn10dizcUP/WyhKouhWIQyzdpB
	J/C5ttqFz5HtV4rNlynI0UT/JJLMDXw6l8BTCFDk3zBAHOM7HWVgiUkRX0au28CT
	HhgDFHOl6BaPLEPoINrg+Tvi8MvIs2vOcQRTEA3B+jYgUOuZPQryCQyL5CkCP7SL
	Vnrw/Ec0Wb+k0cuBS524Hw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nagcbp37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 21:47:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7KGsjL031449;
	Thu, 7 Nov 2024 21:47:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nahaca5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 21:47:00 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A7Lkwwa034016;
	Thu, 7 Nov 2024 21:46:59 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42nahaca4a-4;
	Thu, 07 Nov 2024 21:46:59 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 3/4] iommufd: Add IOMMU_IOAS_CHANGE_PROCESS
Date: Thu,  7 Nov 2024 13:46:56 -0800
Message-Id: <1731016017-430373-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1731016017-430373-1-git-send-email-steven.sistare@oracle.com>
References: <1731016017-430373-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_10,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070171
X-Proofpoint-ORIG-GUID: UMyNFgvV3wqz_hAgnpx6LIsZvS84k6zd
X-Proofpoint-GUID: UMyNFgvV3wqz_hAgnpx6LIsZvS84k6zd
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
IOMMU_IOAS_MAP_FILE, because the kernel metadata for such mappings does
not depend on the userland VA of the pages (which is different in the new
process).
IOMMU_IOAS_CHANGE_PROCESS fails if other types of mappings are present.

This is a revised version of code originally provided by Jason.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.h    |   1 +
 drivers/iommu/iommufd/ioas.c            | 142 ++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |   1 +
 drivers/iommu/iommufd/main.c            |   2 +
 include/uapi/linux/iommufd.h            |  23 ++++++
 5 files changed, 169 insertions(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index e26a0d7..ed0b3cb 100644
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
index c82ed5a..877f61c 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -439,6 +439,148 @@ static int iommufd_take_all_iova_rwsem(struct iommufd_ctx *ictx,
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
+		if (!npinned[account_mode])
+			continue;
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
+	unsigned long all_npinned[IOPT_PAGES_ACCOUNT_MODE_NUM] = {};
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
+		return rc;
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
+	return rc;
+}
+
 int iommufd_option_rlimit_mode(struct iommu_option *cmd,
 			       struct iommufd_ctx *ictx)
 {
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index a2b5a35..bce20ef 100644
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
index 577f251e..c3cb6c3 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -373,6 +373,8 @@ struct iommufd_ioctl_op {
 		 struct iommu_ioas_alloc, out_ioas_id),
 	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
 		 struct iommu_ioas_allow_iovas, allowed_iovas),
+	IOCTL_OP(IOMMU_IOAS_CHANGE_PROCESS, iommufd_ioas_change_process,
+		 struct iommu_ioas_change_process, __reserved),
 	IOCTL_OP(IOMMU_IOAS_COPY, iommufd_ioas_copy, struct iommu_ioas_copy,
 		 src_iova),
 	IOCTL_OP(IOMMU_IOAS_IOVA_RANGES, iommufd_ioas_iova_ranges,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 41b1a01..19b646c 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -52,6 +52,7 @@ enum {
 	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
 	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
 	IOMMUFD_CMD_IOAS_MAP_FILE = 0x8f,
+	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
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

