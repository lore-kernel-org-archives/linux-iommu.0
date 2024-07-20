Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B40145B00
	for <iommu@lists.linux.dev>; Sat, 20 Jul 2024 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721501814; cv=none; b=fxCJ3woJuzhJkyxSVRyIon9MW9OBUCqibx86TlsUaxuSHYB+/McLDIDeP9n+LsmiQx/e2HrDgLrKlsAAxLmjfEJZ5FxGGRY4fhsG89h0bGkDE8d2duSk2Gutn09JB0yfCHemp6IhrUUxdQ/WQlZ9D7U2FoUOPipNBHQFXu3coLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721501814; c=relaxed/simple;
	bh=eD7xAyyfTLvUdre3DE120EodX82638OfS/1LT43m9/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=HwZM3Va1a/O5WVbFIZyH2lVrZ9mF6pXb9G9aX+0RuZtTbjTbqbz+fnh8Atg5Ywjn+OTRLgxaFPfPmc5u1Gpm5MZNmZcWy5PLZKyhVE9/pOyGXJ5C/bDUtrsF+AeDXzme+ZV3iEaHlB9wiiD++z49pYo/QUaWDmLwToADHdWNaHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FZWiuZ6p; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FZWiuZ6p"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KItr9Y006601;
	Sat, 20 Jul 2024 18:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=VnVJIyz8Lzp7TC1H3Ss8Sytk/Rjx3mAj7Gl5+bDrjyw=; b=
	FZWiuZ6pX2JO1+VwbOUlmnM06Jo9KV5F7IH9Fxx9q/CkWwOOYYPYPjx4jcXrZxs0
	W9H7QBYdV4sC4Q4BQBEbJeYcCld/dCX3ZcOtTbd2xzWZ2DtgdZ04f56xfAdtACzM
	If81Kofuw8Jo13DU0v46VXTajSq0ujgLpIDe5/Jgvqg2e/ZzMcou/hvdss/Bc88l
	trZNIpxkcU67pBhREHF2mLd5NiKmdfUpszMfw4WGolgkdTVGVLMYpalZV8+XlqjR
	mQxwixuqRvAlmSrhXasDrMjuYoal7/Xtv8w9gR+73JEG8ssMaltNgROJGcPVu9Rn
	vT6930EQvJ4I9svHvUj9rA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gjxhg00v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 18:56:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46KHxaVl024407;
	Sat, 20 Jul 2024 18:56:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40g3p5xgc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 18:56:49 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46KIukDJ032989;
	Sat, 20 Jul 2024 18:56:48 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40g3p5xgb0-6;
	Sat, 20 Jul 2024 18:56:48 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 4/4] iommufd: update VA
Date: Sat, 20 Jul 2024 11:56:45 -0700
Message-Id: <1721501805-86928-6-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: oxCqGSN4ezlRnAbUIMsRiuuqSAP2AYoS
X-Proofpoint-ORIG-GUID: oxCqGSN4ezlRnAbUIMsRiuuqSAP2AYoS
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Extend IOMMU_IOAS_CHANGE_PROCESS so that the userland VA of each mapping
is also updated.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/iommu/iommufd/ioas.c | 89 ++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/iommufd.h | 51 ++++++++++++++++++++++++-
 2 files changed, 138 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 62af26e..5d23bdd 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
  */
+#include <linux/bsearch.h>
 #include <linux/interval_tree.h>
 #include <linux/iommufd.h>
 #include <linux/iommu.h>
@@ -458,6 +459,76 @@ static void change_mm(struct iopt_pages *pages)
 	free_uid(old_user);
 }
 
+#define MAX_UMAP_ENTRIES 1024
+
+static int iommufd_get_umap(struct iommu_ioas_change_process *cmd,
+			    struct iommu_ioas_userspace_map **p_umap)
+{
+	int i;
+	int len = cmd->n_umap * sizeof(**p_umap);
+	struct iommu_ioas_userspace_map *umap = kzalloc(len, GFP_KERNEL);
+
+	if (!umap)
+		return -ENOMEM;
+
+	if (len > MAX_UMAP_ENTRIES * sizeof(*umap))
+		return -E2BIG;
+
+	if (copy_from_user(umap, u64_to_user_ptr(cmd->umap), len)) {
+		kfree(umap);
+		return -EFAULT;
+	}
+
+	for (i = 0; i < cmd->n_umap - 1; i++) {
+		if (umap[i].addr_old > umap[i+1].addr_old) {
+			kfree(umap);
+			return -EINVAL;
+		}
+	}
+	*p_umap = umap;
+	return 0;
+}
+
+static int cmp_addr(const void *a, const void *b)
+{
+	u64 key = (u64)a;
+	const struct iommu_ioas_userspace_map *elem = b;
+
+	if (key < elem->addr_old)
+		return -1;
+	else if (key < elem->addr_old + elem->size)
+		return 0;
+	else
+		return 1;
+}
+
+static int pages_validate_userspace(struct iopt_pages *pages,
+				    struct iommu_ioas_userspace_map *umap,
+				    int n_umap)
+{
+	struct iommu_ioas_userspace_map *newaddr;
+	size_t pages_size = pages->npages * PAGE_SIZE;
+
+	if (!n_umap)
+		return 0;
+	newaddr = bsearch(pages->uptr, umap, n_umap, sizeof(*umap), cmp_addr);
+	if (!newaddr || pages_size > newaddr->size)
+		return -EINVAL;
+	return 0;
+}
+
+static void pages_update_userspace(struct iopt_pages *pages,
+				   struct iommu_ioas_userspace_map *umap,
+				   int n_umap)
+{
+	struct iommu_ioas_userspace_map *newaddr;
+
+	if (!n_umap)
+		return;
+	newaddr = bsearch(pages->uptr, umap, n_umap, sizeof(*umap), cmp_addr);
+	pages->uptr += newaddr->addr_new - newaddr->addr_old;
+}
+
 #define for_each_ioas_area(_xa, _index, _ioas, _area) \
 	xa_for_each((_xa), (_index), (_ioas)) \
 		for (_area = iopt_area_iter_first(&_ioas->iopt, 0, ULONG_MAX); \
@@ -467,6 +538,8 @@ static void change_mm(struct iopt_pages *pages)
 int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd)
 {
 	struct iommufd_ctx *ictx = ucmd->ictx;
+	struct iommu_ioas_change_process *cmd = ucmd->cmd;
+	struct iommu_ioas_userspace_map *umap = NULL;
 	unsigned long all_npinned[IOPT_PAGES_ACCOUNT_MODE_NUM] = {0, 0, 0};
 	struct iommufd_ioas *ioas;
 	struct iopt_area *area;
@@ -475,6 +548,17 @@ int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd)
 	unsigned long index;
 	int rc;
 
+	if (cmd->flags || cmd->__reserved)
+		return -EOPNOTSUPP;
+
+	if (cmd->n_umap > 0) {
+		rc = iommufd_get_umap(cmd, &umap);
+		if (rc)
+			return rc;
+	} else if (cmd->n_umap < 0) {
+		return -EINVAL;
+	}
+
 	xa_init(&ioas_list);
 	rc = iommufd_take_all_iova_rwsem(ictx, &ioas_list);
 	if (rc)
@@ -488,6 +572,9 @@ int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd)
 	 */
 	for_each_ioas_area(&ioas_list, index, ioas, area)  {
 		pages = area->pages;
+		rc = pages_validate_userspace(pages, umap, cmd->n_umap);
+		if (rc)
+			goto out;
 
 		if (need_charge_update(pages)) {
 			all_npinned[pages->account_mode] += pages->last_npinned;
@@ -506,6 +593,7 @@ int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd)
 
 	for_each_ioas_area(&ioas_list, index, ioas, area) {
 		pages = area->pages;
+		pages_update_userspace(pages, umap, cmd->n_umap);
 
 		/* Uncharge the old one (which also restores last_npinned) */
 		if (need_charge_update(pages))
@@ -518,6 +606,7 @@ int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd)
 	iommufd_release_all_iova_rwsem(ictx, &ioas_list);
 
 out_no_release:
+	kfree(umap);
 	return rc;
 }
 
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 6f7c243..b097ef1 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -694,11 +694,58 @@ struct iommu_hwpt_invalidate {
 };
 #define IOMMU_HWPT_INVALIDATE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_INVALIDATE)
 
+/**
+ * struct iommu_ioas_change_process - ioctl(VFIO_IOAS_CHANGE_PROCESS)
+ * @size: sizeof(struct iommu_ioas_change_process)
+ * @flags: Must be 0
+ * @n_umap: Number of entries in @umap
+ * @umap: User pointer to an array of mappings to change.
+ *        @addr_old and @size must match the virtual address and size of
+ *        an existing mapping exactly.
+ * @__reserved: Must be 0
+ *
+ * This changes the process backing the memory maps for every memory map
+ * created in every IOAS in the context to the current process.  Pinned
+ * memory counts are transferred to the current process, and the virtual
+ * address of each mapping in @umap is updated to @addr_new.
+ *
+ * If @n_umap == 0, then no mappings are updated.  This is only suitable if
+ * the current process has the same virtual addresses as the previous process,
+ * such as after fork.  If @n_map > 0, then @umap must contain entries for all
+ * existing mappings, or the operation fails.  The @umap entries must be sorted
+ * by @addr_old.
+ *
+ * The range size@new_addr in the new process must refer to the same memory
+ * object as size@old_addr in the old process, but the implementation does
+ * not enforce this restriction.  Violation of this rule is not detected and
+ * may result in the process corrupting its own memory (but no one else's).
+ *
+ * If the ioctl returns a failure status, then nothing is changed.
+ *
+ * This API is useful for transferring operation of a device from one process
+ * to another, such as during userland live update.  Beware that transferring
+ * a context containing mappings accessed by kernel threads (such as a vfio
+ * mdev) requires special care, if the original process directly exec's its
+ * successor.  The original process must fork an identical caretaker
+ * process which calls VFIO_IOAS_CHANGE_PROCESS to take temporary ownership
+ * of the mappings without changing VA's.  The original process then exec's
+ * its successor, which calls VFIO_IOAS_CHANGE_PROCESS with new VA's to take
+ * ownership from the caretaker.
+ */
+
+struct iommu_ioas_userspace_map {
+	__u64 addr_old;		/* old userspace virtual address */
+	__u64 addr_new;		/* new userspace virtual address */
+	__u64 size;		/* size of the mapping in bytes */
+};
+
 struct iommu_ioas_change_process {
 	__u32 size;
+	__u32 flags;
+	__u32 n_umap;
+	__u32 __reserved;
+	__aligned_u64 umap;
 };
-
 #define IOMMU_IOAS_CHANGE_PROCESS \
 	_IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_CHANGE_PROCESS)
-
 #endif
-- 
1.8.3.1

