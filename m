Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136E01DCB25
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321212; cv=none; b=pws0Nv9AcuHADboM+M6NMmNON9gG12+lGvAvNN73vsXUJ2cdiEb2qz0pZRrZtPCyftsQB02/SsC8mFGaL3C13J3pIwkI9ua5TylRaFD00SWO90lK++Wvmo0ZBYH6D8QGAR6VziC8QYEs5sbhNmc/smCOMW0u5J0b4wv+TRKtLbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321212; c=relaxed/simple;
	bh=hwLCY0uxQPLbEXwkhF6V1xXlK7G1gPGxjAba7RdjiDk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=HO2eHMAx75a1dH5KwpLp/MeLGpruVYTkJyB3cYVIguPDZTTk651fcEiM7dJ6jie6rUAUL9hNNSj/ZnY5D4zXmBm95pe/vEbT1csja/WvFgmx5xrKny/iR2/38AeMDhtu6iG62kjBIFAzTdVmqCsA5Rcly3rIQZnhLUkwUjWgD1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JZ3+yWZA; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JZ3+yWZA"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMdR3005130;
	Mon, 7 Oct 2024 17:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=IXoj6hDc+6GjRkErf78tS0FHgW012F50FOcBPg1FHBk=; b=
	JZ3+yWZArX1/rZAMQlk2eO0tAPslOg1zepalhtvJvC+8VVaxhUFmHyx7TP8lgSPg
	CFTRstzEooVISOSscoF6SZDMYdrnd9JYxUU2vbFwdB4o6/QuMexLxDp1tzmPJSK3
	l1b3Pzr1XRLu7ZDrJrOQZsaRasDLA9XIqKKUzQqVT0xtQHCi1yFqR2kheUU0t+rQ
	CwJVCM/dk7cBx05QjW+dmpWttoJFg8Y72DkpEMImPooc+jEXcyUGeB+AS8Th8Kie
	yIfnJ1L4gdl/Mbm2pA1I3O6kKIn8AQ2/3FX6l516UAMy1oqPVD6HiTpmk8kSCU0v
	edJVLd/MLHmhgNnmvrhGrQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300duyqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 17:13:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497GQRPd004682;
	Mon, 7 Oct 2024 17:13:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uw63f36-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 17:13:27 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 497HAoJ6003812;
	Mon, 7 Oct 2024 17:13:27 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 422uw63f0s-3;
	Mon, 07 Oct 2024 17:13:27 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 2/4] iommufd: Lock all objects
Date: Mon,  7 Oct 2024 10:13:21 -0700
Message-Id: <1728321203-189608-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1728321203-189608-1-git-send-email-steven.sistare@oracle.com>
References: <1728321203-189608-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_10,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070121
X-Proofpoint-GUID: YuCq8_T4tZFWfOaU8K4GpC8h84w-O7pv
X-Proofpoint-ORIG-GUID: YuCq8_T4tZFWfOaU8K4GpC8h84w-O7pv
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
 drivers/iommu/iommufd/ioas.c            | 65 +++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  1 +
 3 files changed, 67 insertions(+)

diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 2b2e172..480fe75 100644
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
@@ -370,6 +373,68 @@ int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd)
 	return rc;
 }
 
+static void iommufd_release_all_iova_rwsem(struct iommufd_ctx *ictx,
+					   struct xarray *ioas_list)
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
+		down_write_nest_lock(&ioas->iopt.iova_rwsem,
+				     &ictx->ioas_creation_lock);
+
+		rc = xa_err(xa_store(ioas_list, index, ioas, GFP_KERNEL));
+		if (rc) {
+			iommufd_release_all_iova_rwsem(ictx, ioas_list);
+			return rc;
+		}
+
+		xa_lock(&ictx->objects);
+	}
+	xa_unlock(&ictx->objects);
+	return 0;
+}
+
 int iommufd_option_rlimit_mode(struct iommu_option *cmd,
 			       struct iommufd_ctx *ictx)
 {
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 34b1f3a..49557de 100644
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
index f57c3318..e7ff72f 100644
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

