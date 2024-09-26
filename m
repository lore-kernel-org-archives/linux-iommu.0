Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04D754F95
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 13:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358838; cv=none; b=f9d+mNUDmpIApusLO/vWVgcIxqbG8DIT9QKhsw8XClbohJBRRJg8jzqGm1PsrQ5BkDywc38cRkpiKHC0nM9VugjInPnWJHePjj5Kv5UgnxP3mrT4eUsN4CCrF0q1OVIBISEf1pA2squJ15zwvN0Wy8P3cXpyf0Yq5y4Wo5ifF6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358838; c=relaxed/simple;
	bh=Bqo9TNKzdiJwXYePTJqJ7HdVJMyS9NW4qBpOUcbcicU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cpEp24waR10BHtmCJ5kn5zMLhYpKo9jc/LySlhdvc//Vr9CHz6DTL/FjMsNEnNfVBKQ1n3ka3EfSESxViG/GgtAihQn8XWV0qdz4xF8sCmXLOiVMoW01gTzC3C9t0AD0gS1jVaWRl7cWLnQOjn3QeN/n5cP6g10pidfDYhG+g+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dup0Ecmk; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dup0Ecmk"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QAmtYm029394;
	Thu, 26 Sep 2024 13:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=hJm6JYvL3g5Rgj83Ke8i3BijcXZaiAK/syfUFR7RRjE=; b=
	dup0EcmkTYuAl64ZDhUKcKK80hoBHNF3TEHm366C+LkWP0D8/Fzku1Lig+WvjOHA
	WMgcnr+/8q2e1/QjJ04BCdYrhPIotV43T9nC3u6/1MbVcNLEkiKxhW71ZKkgXrcf
	d+DicxyjG5sD5mjv7drf75zGPsvrC6vdElpInHzYIVgVhqASrFo99xDJqwfAumpM
	xam3T4HDBQuZ1M3XrNlrb9gdWHg2GXSzZLC4ws2io7Uzl0DHF/4ywtZhHbGGsycv
	a6nqkXC84w1nFVTj1ZB9p8VUOnY9bxAkIi0WYK2gs5oKNpyrjv8VH8SyTylBH/Yd
	n+1/aU8+s2YpbTdSdTE4eA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sn2cwb43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 13:53:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48QCMCvO032943;
	Thu, 26 Sep 2024 13:53:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkjfd92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 13:53:53 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48QDroXU027500;
	Thu, 26 Sep 2024 13:53:52 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41smkjfd62-3;
	Thu, 26 Sep 2024 13:53:52 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 2/4] iommufd: Lock all objects
Date: Thu, 26 Sep 2024 06:53:46 -0700
Message-Id: <1727358828-97791-3-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: Zvbpow7CcK0Gi_CBHpGA2RlUMR2XB39J
X-Proofpoint-ORIG-GUID: Zvbpow7CcK0Gi_CBHpGA2RlUMR2XB39J
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Define helpers to lock and unlock all iommufd_ctx objects.
This will allow DMA mappings to be updated atomically during live update.
This code is substantially the same as an initial version provided by
Jason, plus fixes.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/iommu/iommufd/ioas.c            | 67 +++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  1 +
 3 files changed, 69 insertions(+)

diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 2d25ba0..8eb869d 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -52,7 +52,10 @@ int iommufd_ioas_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
 		goto out_table;
+
+	down_read(&ucmd->ictx->ioas_creation_lock);
 	iommufd_object_finalize(ucmd->ictx, &ioas->obj);
+	up_read(&ucmd->ictx->ioas_creation_lock);
 	return 0;
 
 out_table:
@@ -370,6 +373,70 @@ int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd)
 	return rc;
 }
 
+static void iommufd_release_all_iova_rwsem(struct iommufd_ctx *ictx,
+				      struct xarray *ioas_list)
+{
+	struct iommufd_ioas *ioas;
+	unsigned long index;
+
+	xa_for_each(ioas_list, index, ioas) {
+		up_write(&ioas->iopt.iova_rwsem);
+		refcount_dec(&ioas->obj.users);
+	}
+	up_write(&ictx->ioas_creation_lock);
+	xa_destroy(ioas_list);
+}
+
+static int iommufd_take_all_iova_rwsem(struct iommufd_ctx *ictx,
+				       struct xarray *ioas_list)
+{
+	struct iommufd_object *obj;
+	unsigned long index;
+	int rc;
+
+	/*
+	 * This is very ugly, it is done instead of adding a lock around
+	 * pages->source_mm, which is a performance path for mdev, we just
+	 * obtain the write side of all the iova_rwsems which also protects the
+	 * pages->source_*. Due to copies we can't know which IOAS could read
+	 * from the pages, so we just lock everything. This is the only place
+	 * locks are nested and they are uniformly taken in ID order.
+	 *
+	 * ioas_creation_lock prevents new IOAS from being installed in the
+	 * xarray while we do this, and also prevents more than one thread from
+	 * holding nested locks.
+	 */
+	down_write(&ictx->ioas_creation_lock);
+	xa_lock(&ictx->objects);
+	lockdep_off();
+	xa_for_each(&ictx->objects, index, obj) {
+		struct iommufd_ioas *ioas;
+
+		if (!obj || obj->type != IOMMUFD_OBJ_IOAS)
+			continue;
+
+		if (!refcount_inc_not_zero(&obj->users))
+			continue;
+
+		xa_unlock(&ictx->objects);
+
+		ioas = container_of(obj, struct iommufd_ioas, obj);
+		down_write(&ioas->iopt.iova_rwsem);
+
+		rc = xa_err(xa_store(ioas_list, index, ioas, GFP_KERNEL));
+		if (rc) {
+			lockdep_on();
+			iommufd_release_all_iova_rwsem(ictx, ioas_list);
+			return rc;
+		}
+
+		xa_lock(&ictx->objects);
+	}
+	lockdep_on();
+	xa_unlock(&ictx->objects);
+	return 0;
+}
+
 int iommufd_option_rlimit_mode(struct iommu_option *cmd,
 			       struct iommufd_ctx *ictx)
 {
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 0ebb5bd..06a52f2 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -23,6 +23,7 @@ struct iommufd_ctx {
 	struct xarray objects;
 	struct xarray groups;
 	wait_queue_head_t destroy_wait;
+	struct rw_semaphore ioas_creation_lock;
 
 	u8 account_mode;
 	/* Compatibility with VFIO no iommu */
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 5f77ce6..13ec031 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -248,6 +248,7 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
 		pr_info_once("IOMMUFD is providing /dev/vfio/vfio, not VFIO.\n");
 	}
 
+	init_rwsem(&ictx->ioas_creation_lock);
 	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
 	xa_init(&ictx->groups);
 	ictx->file = filp;
-- 
1.8.3.1

