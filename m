Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD963142E98
	for <iommu@lists.linux.dev>; Sat, 20 Jul 2024 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721501813; cv=none; b=Jov/eFRGIW8w1HYwQDlnWe7LkKOVVKTdEZYEhxoShCU5pJIBw+bD/Aeuc46T851PvL41KNxxWZ1wxcihIEgpBkRcOfzrWy1ZZZayIFn2uCWxknACGtetISG00MJMIBe7BdXMA/3klGZojaMABj51MbBes3PVG7hOc3pVM92t4h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721501813; c=relaxed/simple;
	bh=mkU3KbKkzwN5UxGjWW+81NEg7VjMhi1ZDGMVAg5O3lY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nSSvTytlnXi+xR+3d38H4cK3x/GEhvvaKK7jLTKpK/ZLhuNf8PSkfVACdWT7/C7dY9OT2Hll04zYTtMQi5GxuWt6bZpGX9ouOeJ8oPz5ZjWjtwM/YYS6qfA1LbPqNWIhIClhpy1k5ujqWtJGt2UTXMGEL03jSjoNTB4MCS9uJh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RWTvNfLi; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RWTvNfLi"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KItxBq006777;
	Sat, 20 Jul 2024 18:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=fTDjg+j5KlVhfe9/M/6utBDSezphcBGSTxvusZ7cryU=; b=
	RWTvNfLifSUmgpRSNJVvxBiRX/7NR9hDTxFPk6Y5+bVrJi7GAtXEdQpCK7nrwaMj
	M1ZJy5o12Vhn6r48D7fxngx5jOAdOW6HW7g2Mi+eU82FxpzJmMsa+/y66RisI/2k
	DpN/HjBe+vM8RhkajgYPsZIyEIKnTa5Upcb8EucprC9F4eXa5JOfzknsdjEGsBAx
	M5SDNhtX2FKyAtMtYO2mQXKecHIf0ik4BzynE8zI4o44McKyuQhQx6vy+Wb7Ud0e
	taRXx1SAqieWJA2NZT2dFSvx0FV/zjJgpWOhZgyc9S7VIkrlNrx30dpMfNaliXOX
	CDeEla/Pt4R/CAhhfJC40Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gjxhg00t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 18:56:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46KGU9OP024416;
	Sat, 20 Jul 2024 18:56:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40g3p5xgbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 18:56:48 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46KIukDH032989;
	Sat, 20 Jul 2024 18:56:48 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40g3p5xgb0-5;
	Sat, 20 Jul 2024 18:56:48 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 3/4] iommufd: Add IOMMU_IOAS_CHANGE_PROCESS
Date: Sat, 20 Jul 2024 11:56:44 -0700
Message-Id: <1721501805-86928-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_16,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200138
X-Proofpoint-GUID: zzYkQ7UEVABWknnQIaRPQYeXuI9V4LO_
X-Proofpoint-ORIG-GUID: zzYkQ7UEVABWknnQIaRPQYeXuI9V4LO_
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

This is only a partial implementation.  A subsequent patch also changes
the userland VA of each mapping.  The API is documented in that patch.

This code is substantially the same as an initial version provided by
Jason, plus fixes.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/iommu/iommufd/io_pagetable.h    |   1 +
 drivers/iommu/iommufd/ioas.c            | 135 ++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |   1 +
 drivers/iommu/iommufd/main.c            |   2 +
 include/uapi/linux/iommufd.h            |   9 +++
 5 files changed, 148 insertions(+)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index c37b680..8c29fbb 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -173,6 +173,7 @@ enum {
 	IOPT_PAGES_ACCOUNT_NONE = 0,
 	IOPT_PAGES_ACCOUNT_USER = 1,
 	IOPT_PAGES_ACCOUNT_MM = 2,
+	IOPT_PAGES_ACCOUNT_MODE_NUM = 3,
 };
 
 /*
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index ab31879..62af26e 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -386,6 +386,141 @@ static int iommufd_take_all_iova_rwsem(struct iommufd_ctx *ictx,
 	return 0;
 }
 
+static bool need_charge_update(struct iopt_pages *pages)
+{
+	if (pages->source_task == current->group_leader &&
+	    pages->source_mm == current->mm &&
+	    pages->source_user == current_user()) {
+		return false;
+	}
+
+	switch (pages->account_mode) {
+	case IOPT_PAGES_ACCOUNT_NONE:
+		return false;
+	case IOPT_PAGES_ACCOUNT_USER:
+		if (pages->source_user == current_user())
+			return false;
+		break;
+	case IOPT_PAGES_ACCOUNT_MM:
+		if (pages->source_mm == current->mm)
+			return false;
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
+	struct iommufd_ctx *ictx = ucmd->ictx;
+	unsigned long all_npinned[IOPT_PAGES_ACCOUNT_MODE_NUM] = {0, 0, 0};
+	struct iommufd_ioas *ioas;
+	struct iopt_area *area;
+	struct iopt_pages *pages;
+	struct xarray ioas_list;
+	unsigned long index;
+	int rc;
+
+	xa_init(&ioas_list);
+	rc = iommufd_take_all_iova_rwsem(ictx, &ioas_list);
+	if (rc)
+		goto out_no_release;
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
index 1ad19a9..4f747ba 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -274,6 +274,7 @@ static inline struct iommufd_ioas *iommufd_get_ioas(struct iommufd_ctx *ictx,
 int iommufd_ioas_iova_ranges(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_allow_iovas(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_map(struct iommufd_ucmd *ucmd);
+int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_copy(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 4a15cf9..f8a2736 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -370,6 +370,8 @@ struct iommufd_ioctl_op {
 		 struct iommu_ioas_alloc, out_ioas_id),
 	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
 		 struct iommu_ioas_allow_iovas, allowed_iovas),
+	IOCTL_OP(IOMMU_IOAS_CHANGE_PROCESS, iommufd_ioas_change_process,
+		 struct iommu_ioas_change_process, size),
 	IOCTL_OP(IOMMU_IOAS_COPY, iommufd_ioas_copy, struct iommu_ioas_copy,
 		 src_iova),
 	IOCTL_OP(IOMMU_IOAS_IOVA_RANGES, iommufd_ioas_iova_ranges,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 1dfeaa2..6f7c243 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -50,6 +50,7 @@ enum {
 	IOMMUFD_CMD_HWPT_SET_DIRTY_TRACKING,
 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP,
 	IOMMUFD_CMD_HWPT_INVALIDATE,
+	IOMMUFD_CMD_IOAS_CHANGE_PROCESS,
 };
 
 /**
@@ -692,4 +693,12 @@ struct iommu_hwpt_invalidate {
 	__u32 __reserved;
 };
 #define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
+
+struct iommu_ioas_change_process {
+	__u32 size;
+};
+
+#define IOMMU_IOAS_CHANGE_PROCESS \
+	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_CHANGE_PROCESS)
+
 #endif
-- 
1.8.3.1

