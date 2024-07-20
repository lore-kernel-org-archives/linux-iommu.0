Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65131147C8B
	for <iommu@lists.linux.dev>; Sat, 20 Jul 2024 18:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721501813; cv=none; b=hLdEEpdms7yKw9KrNV6tmktT0kA2f0xMDFfd8cKIZmYqSvVciXA5weB8nLYSvNXdxKAPUIsIvjcdDNe3IomIMMOjBz9JfDUkThbU6CLAEW5rlNrkzY9bcyQYILCiLwAfdUWYdfmF5rs4sExdUZRpE4wEeP7h/W6x5ZGbvtsoc4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721501813; c=relaxed/simple;
	bh=OKp7VGl402xnbD4pBS/23aNin/orV3zou6YUHWfeaqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bURZT/ObwLryLOTzbaDUsfdz4JMaWQIlIAtebVTJgEXJWetlVzU+whrei2k/qLJNiKuIO3cQwReXZnAjIzvf9FVWRe7qAkQHZHUajXSLpDMdww/F85GSAQPq1jtl1utdVQPKKnxnNLfH5whre2lWRHM+G9VM7TxAdd4XVHyF2wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dnJ0AbUk; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dnJ0AbUk"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KIjjiZ028481;
	Sat, 20 Jul 2024 18:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=WnUijtWG6+16HcpPy0WjjYWjJ/qUk2eoB04JTeWKKVE=; b=
	dnJ0AbUk3HAX3xxAtkibK0JgFCIqzID2Y2C/KYQnR5PCw72HFNFlql4+4m32ytqB
	VbEhbvmC8YrFoTNhmlYrTVE4FFM7exTi01yYP+QcYUNDvuL4OKVGwCTx9BffhClq
	ptxW+kX0B/BkgThsisFv3qnQ7vWBj5Se+NYzNhvhNwzt4VxClnZwWXHEVtPtydgU
	2FCn7AVY2NlgmGNdJi7OTIlVUDsPH/DB5VU8Zn2Zl8M7jVJibpWQ1M1PVNwpNQ8I
	m8vfwQNQul1oTBk/BRTxy655U5zzbTMFeoabOCBSweDeKNjBRhGTUX3SBmLyHCmV
	UfFOROIACVQ8fMjqSmy2Pw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gjst008q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 18:56:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46KHak0H024462;
	Sat, 20 Jul 2024 18:56:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40g3p5xgbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 18:56:48 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46KIukDF032989;
	Sat, 20 Jul 2024 18:56:47 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40g3p5xgb0-4;
	Sat, 20 Jul 2024 18:56:47 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 2/4] iommufd: Lock all objects
Date: Sat, 20 Jul 2024 11:56:43 -0700
Message-Id: <1721501805-86928-4-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: JT6rMqJWxEH9EB43z_hyE9VvoZwaQiJL
X-Proofpoint-ORIG-GUID: JT6rMqJWxEH9EB43z_hyE9VvoZwaQiJL
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
index 7422482..ab31879 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -51,7 +51,10 @@ int iommufd_ioas_alloc_ioctl(struct iommufd_ucmd *ucmd)
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 	if (rc)
 		goto out_table;
+
+	down_read(&ucmd->ictx->ioas_creation_lock);
 	iommufd_object_finalize(ucmd->ictx, &ioas->obj);
+	up_read(&ucmd->ictx->ioas_creation_lock);
 	return 0;
 
 out_table:
@@ -319,6 +322,70 @@ int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd)
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
index 991f864..1ad19a9 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -22,6 +22,7 @@ struct iommufd_ctx {
 	struct xarray objects;
 	struct xarray groups;
 	wait_queue_head_t destroy_wait;
+	struct rw_semaphore ioas_creation_lock;
 
 	u8 account_mode;
 	/* Compatibility with VFIO no iommu */
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 39b3293..4a15cf9 100644
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

