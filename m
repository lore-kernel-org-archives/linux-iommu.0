Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC6C1AAE30
	for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 15:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190349; cv=none; b=KXHIiVIe8q5Ensv4/2uANIedoNDKxUF39ASE6S/mNECiZdq97WfnhYWRonf+eadHu/+MrGP620vgm+pfR4UJEaKZ6GrkWewGRNBpktcmAns46QKGeyO9t3I5vgXIDjlPHkqguVaLe1q3ueLVCYSl+857hz1vtq1zOp1mCPxEU2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190349; c=relaxed/simple;
	bh=udzLEBzYyoxXKGaEZVFnWyH4WG6lTHjM466y3nLc9Uw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Z9NcC4lb57YevJhKoX1vmln7zaumOlK5xG8Qm3ilxs+JkBnT6j1zu3s2EGNT9uK8x4vln9ClUWpNIWWYTeOLYQ3Gd99bMETcsc2kQkdAVy6opOaGt2ZYCMWxXtYZXZnfqM71RF7z5ghzpZ2nXgCxryIpdC+xE68Y6Sq8auYyZRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N5JYwiSB; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N5JYwiSB"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OEQYcI007298;
	Tue, 24 Sep 2024 15:05:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=KhXzBX9cogGBCcXVRwXsmEdcnO3I2LWuJFVvLRB9aN4=; b=
	N5JYwiSBjXTSQZOpcDy94VQ3pqtEBkABZdxeOwnLO7OS2JKvw3g0tLc9piPwfP/d
	RqOFsHh77gG5dE210Z2VB9Em/rq6t7dbm61C5Bl6wI3OAy5VoTUHepYODcrcC3JK
	cZ7CPvqNlhVQzDYhPiCd9podEEJpRyAJI6X7AwzVc9/xYPM2c6wAouMFAKqW7g+J
	zSFvrVifBDq/fDx+QQzeWp9fPZrqFvhH9x3wvSszypVOI4sqkPysocivy7rEfaIR
	YZaTuw4fQEKAvxuhuktftZbW0T0lnBgrMIcnxmKnblJsBJ8fopR2X0m6M7eybtJJ
	b85VPUT/7OiQOKKRWfNJOQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sp1afpgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:05:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OEMgd2004698;
	Tue, 24 Sep 2024 15:05:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smk9cr3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:05:44 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48OF5dLJ027122;
	Tue, 24 Sep 2024 15:05:43 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41smk9cqxg-5;
	Tue, 24 Sep 2024 15:05:43 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 4/9] iommufd: IOMMU_IOAS_MAP_FILE interface
Date: Tue, 24 Sep 2024 08:05:33 -0700
Message-Id: <1727190338-385692-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409240108
X-Proofpoint-ORIG-GUID: ZXsFYZMXwxK13pY9WCsOnJLxPdBvsPGT
X-Proofpoint-GUID: ZXsFYZMXwxK13pY9WCsOnJLxPdBvsPGT
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Define the IOMMU_IOAS_MAP_FILE ioctl interface, which allows a user to
register memory by passing a memfd plus offset and length.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/iommu/iommufd/ioas.c            |  5 +++++
 drivers/iommu/iommufd/iommufd_private.h |  1 +
 drivers/iommu/iommufd/main.c            |  2 ++
 include/uapi/linux/iommufd.h            | 25 +++++++++++++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index 157a89b..270e8ea 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -197,6 +197,11 @@ static int conv_iommu_prot(u32 map_flags)
 	return iommu_prot;
 }
 
+int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd)
+{
+	return -ENOTTY;
+}
+
 int iommufd_ioas_map(struct iommufd_ucmd *ucmd)
 {
 	struct iommu_ioas_map *cmd = ucmd->cmd;
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 92efe30..21ec075 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -275,6 +275,7 @@ static inline struct iommufd_ioas *iommufd_get_ioas(struct iommufd_ctx *ictx,
 int iommufd_ioas_iova_ranges(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_allow_iovas(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_map(struct iommufd_ucmd *ucmd);
+int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_copy(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd);
 int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 83bbd7c..5f77ce6 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -378,6 +378,8 @@ struct iommufd_ioctl_op {
 		 struct iommu_ioas_iova_ranges, out_iova_alignment),
 	IOCTL_OP(IOMMU_IOAS_MAP, iommufd_ioas_map, struct iommu_ioas_map,
 		 iova),
+	IOCTL_OP(IOMMU_IOAS_MAP_FILE, iommufd_ioas_map_file,
+		struct iommu_ioas_map_file, iova),
 	IOCTL_OP(IOMMU_IOAS_UNMAP, iommufd_ioas_unmap, struct iommu_ioas_unmap,
 		 length),
 	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option,
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 4dde745..c484981 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -51,6 +51,7 @@ enum {
 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP = 0x8c,
 	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
 	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
+	IOMMUFD_CMD_IOAS_MAP_FILE = 0x8f,
 };
 
 /**
@@ -214,6 +215,30 @@ struct iommu_ioas_map {
 #define IOMMU_IOAS_MAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP)
 
 /**
+ * struct iommu_ioas_map_file - ioctl(IOMMU_IOAS_MAP_FILE)
+ * @size: sizeof(struct iommu_ioas_map_file)
+ * @fd: the memfd to map
+ * @start: byte offset from start of file to map from
+ * @flags: same as for iommu_ioas_map
+ * @ios_id: ditto
+ * @length: ditto
+ * @iova: ditto
+ *
+ * Set an IOVA mapping from a memfd file.  All other arguments and semantics
+ * match those of IOMMU_IOAS_MAP.
+ */
+struct iommu_ioas_map_file {
+	__u32 size;
+	__u32 flags;
+	__u32 ioas_id;
+	__s32 fd;
+	__aligned_u64 start;
+	__aligned_u64 length;
+	__aligned_u64 iova;
+};
+#define IOMMU_IOAS_MAP_FILE _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP_FILE)
+
+/**
  * struct iommu_ioas_copy - ioctl(IOMMU_IOAS_COPY)
  * @size: sizeof(struct iommu_ioas_copy)
  * @flags: Combination of enum iommufd_ioas_map_flags
-- 
1.8.3.1

