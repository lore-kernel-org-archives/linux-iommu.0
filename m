Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAB01CE70E
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726319169; cv=none; b=ujGtkmIHUEJwwPhXYu7RZiNySw7OPmQaN3Cy51oIepTAq+dt1/VGOiNCZOaGuVdxnrEXab/77lF1VkZWceFyXGTqlkNRLou/GucH12USY8Who15nNKSqNlf50jWX5RFY8UB2XLMVXeTC98qmOH9s6Q2ef3swX+u7+D0aappTWNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726319169; c=relaxed/simple;
	bh=Bcnf85zx4bYB06xeM15wH8Gw6d7Lw/oMgVF69HyPuko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Il9DDKNsi6AZLptXEH2/THiOHBYB3zRQxVRFyt1qt1iCvHFAliq0tGJnqbZg1hHmQ65PqODGo6KIDpRXIkdRI5qWeTzHG4lZqU9WHkomDZSYiHKxjsDdoVUfS5FFnfwwg6mhh3IJ/faPf3EpzPkcYgKmcbvaIsTGLLXcp9WIfQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S3tQmxBq; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S3tQmxBq"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48EAbL1s028080;
	Sat, 14 Sep 2024 13:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=SNZMHCXlIPyUsbEJVjnaIV+Jtxom9RUJ9slssAfAX/c=; b=
	S3tQmxBqHNl0ej72M+AojWmXlDMcaz2doIMXZx6M6m2IhGdapoufYx7psDyLCGg3
	VoxWz52v7tRtFEqWpPWIxC7b3C0u5bxSv3qtY4L/pXB2Ol8LDj5/MIcrkoMPa950
	YJy8o4jt7dsNoID5GTK9eDeNrFHpv4u9Xr+5MH4jWASwhxAC64cihJktYsL8e2Hf
	3NKahfEXXa/4mS4SCZtKcY3mP1vg+Nx7YhzWa9Hw+exVAtkp/ZjRjUhOjknc45SM
	glt8d0nv7qPJ3EATzZ9BPXQQwNMc2JMYqaAQNgxRqRKnike82iGYBfgy2l9l1tK0
	CAgTwPxthQsP7z4o6W6f/Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3nfge51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:06:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48E90XeX019183;
	Sat, 14 Sep 2024 13:06:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41n0x6a1un-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:06:04 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48ED60jN024307;
	Sat, 14 Sep 2024 13:06:04 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41n0x6a1su-6;
	Sat, 14 Sep 2024 13:06:04 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 5/9] iommufd: IOMMU_IOAS_MAP_FILE interface
Date: Sat, 14 Sep 2024 06:05:54 -0700
Message-Id: <1726319158-283074-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
References: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-14_09,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409140092
X-Proofpoint-GUID: ciaOeJdTGFf6q-N3mMfW2ZariFJe74mh
X-Proofpoint-ORIG-GUID: ciaOeJdTGFf6q-N3mMfW2ZariFJe74mh
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
 include/uapi/linux/iommufd.h            | 22 ++++++++++++++++++++++
 4 files changed, 30 insertions(+)

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
index 4dde745..1e760da 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -51,6 +51,7 @@ enum {
 	IOMMUFD_CMD_HWPT_GET_DIRTY_BITMAP = 0x8c,
 	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
 	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
+	IOMMUFD_CMD_IOAS_MAP_FILE = 0x8f,
 };
 
 /**
@@ -214,6 +215,27 @@ struct iommu_ioas_map {
 #define IOMMU_IOAS_MAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP)
 
 /**
+ * struct iommu_ioas_map_file - ioctl(IOMMU_IOAS_MAP_FILE)
+ * @size: sizeof(struct iommu_ioas_map_file)
+ * @fd: the memfd to map
+ * @start: byte offset from start of file to map from
+ * @flags, @ios_id, @length, @iova: same as for iommu_ioas_map
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

