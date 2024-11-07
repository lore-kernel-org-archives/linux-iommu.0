Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EEB21830A
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016024; cv=none; b=H0VoyerjVXY25N3yNSIFJysJPkse9qeyn7cwtts+1jTQQRcX501rn4hf4F2/H5M3KPq/a2hEwlHsfSJtVfy+AuEucPl/NC75Zmu0YtcQismkXjAfoyZ9UgESe07T9affLNgeBbNCD94WXsCkhiaSnL5ylMv4cczPkwE+/zmlEQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016024; c=relaxed/simple;
	bh=kPavegT1sLagwY/Ky8sWI8WXCLKepfuTFxJjB47bXNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Peg0sMkFliUALPWiuJyMc7vesR8CxsAwsoTUCwBgDEketOdvafe963Zp5HsREHV2DFxiqT5up9GOwPg3a0AmE3fa8q+cNHP+V1PYr4Q6s8Y16qBnbcsRN4G3RFlWEb43I2QETJ92OnFPgMlKGbd1ovfoFBboh6nKLzxbNJ0sgFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dq/k7VEQ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dq/k7VEQ"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7LfY7s029788;
	Thu, 7 Nov 2024 21:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=FUBZjy0Dcv/QP2B4eCj0EFR0Kdl4BD/XRntv1JSdslY=; b=
	Dq/k7VEQW984RiD917mgBDnWXyxsNTAhf/6Gy4QXbYops1fibjI1z9v+jwQURNu8
	JSHl43toF4ly9p1i4LfBhSiE5w3w9owbcvQTLuecyxk74nPNae3ESuLw5cBItBj7
	P90q4k4dVeSRmLEEm1UCPtTkrihyqUU50mJ6x9mcC3vqF2HVK3yPm8fIE1HFMIgE
	c4X1hLJ9ZDGoV50IaNGl4qP0J36DrnKwNjFnas3/hIvf6GzeMT6KtID/3+vIJyIe
	o6mDA0V2XT7XZO+/MhiXAQ8//wZ7DhEIg6lMOiKJEMTTyY9pIQfNnbT58Yh6/I8g
	x+ES8tq2m8YX9jH0xieBrw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nc4c3t84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 21:47:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7KJXTt031434;
	Thu, 7 Nov 2024 21:46:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nahaca5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 21:46:59 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A7LkwwY034016;
	Thu, 7 Nov 2024 21:46:59 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42nahaca4a-3;
	Thu, 07 Nov 2024 21:46:59 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 2/4] iommufd: Lock all objects
Date: Thu,  7 Nov 2024 13:46:55 -0800
Message-Id: <1731016017-430373-3-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: 1DIXWvevUop0_LQLw8YvWrSA_YwQiglR
X-Proofpoint-GUID: 1DIXWvevUop0_LQLw8YvWrSA_YwQiglR
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
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/ioas.c            | 65 +++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  1 +
 3 files changed, 67 insertions(+)

diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index c05d33f..c82ed5a 100644
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
@@ -374,6 +377,68 @@ int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd)
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
index 8f3c21a..a2b5a35 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -24,6 +24,7 @@ struct iommufd_ctx {
 	struct xarray objects;
 	struct xarray groups;
 	wait_queue_head_t destroy_wait;
+	struct rw_semaphore ioas_creation_lock;
 
 	u8 account_mode;
 	/* Compatibility with VFIO no iommu */
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 826a2b2..577f251e 100644
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

