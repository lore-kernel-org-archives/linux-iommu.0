Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83035DDBE
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 21:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016025; cv=none; b=uS+bt19ZAIxSiSzMbkMQX6f5Kbm0cpkfF0kap+cvUetZGq5vtEXe0f8U1e2NOe3oEzTP+b47tDfCgBAt92P/71ww60tJQ/fqVuQ5pGjm0NYNCsfBW3WvugSshpb4ww44+k0Ep1/tcRal3VB8JG706lJq62b7MwejWn6NOXcFt7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016025; c=relaxed/simple;
	bh=wcJxE1Cdlj71Ic640LYKMfSxGekrIMAp0MxcphX8QRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OrRbMWCfOMi90DEuNPmgb5nsWoYg/zXJj97WBMp/QZHFAAX56K9MPrLY8mOabFirtMHi8LV3t61aleGkO27OkiDGaOYlAwezcFc9EaoIF8PSabUH+4xuMzu8fCBSgWSgS2DNJqfgUWLZHMMdWXMEOqxovP8q4hB6mwpsNmTZkdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i94VUW4b; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i94VUW4b"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7LggUa027993;
	Thu, 7 Nov 2024 21:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=QT6TeXSvRFN6ulnorLuo1pObEH598DEOsrrsnmZuVPM=; b=
	i94VUW4b6bya21rUy5SWl+0xroubCrqkw/ffmnj/YCRwPTX8CEZIUB5uDl0p+lqx
	zJUOVOipYbehDFBEqSx4I02X8eZs2ej+re+A1EsDDP+Rf+J9fjoo+i5RLHZsKXG2
	MbC5zXILufLPpGNGwzGGQnOP86s3GS5Q5nhHiudfDrJ+DqNQkeVkeNPQIGf9oPF8
	R0RMI/eFwtKzD7CtqNCr4J0RtAAS1BlQDb4+gc7z5le36EOMX4C5vOKLPBwLi1Hu
	MS9jrD5kSijx2mIUzL1/QnTTHdfh8pKEHKYrOKfwRJNXdKsAKZ26Ok4Qoe+vj/l0
	f9ZmrRIkMWBSddDMQYSikw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nav2brk9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 21:47:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7K1kIe031455;
	Thu, 7 Nov 2024 21:46:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nahaca51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 21:46:59 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A7LkwwW034016;
	Thu, 7 Nov 2024 21:46:58 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42nahaca4a-2;
	Thu, 07 Nov 2024 21:46:58 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 1/4] iommufd: Export do_update_pinned
Date: Thu,  7 Nov 2024 13:46:54 -0800
Message-Id: <1731016017-430373-2-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: q_zmmzpRc2DdNUzqMzxPRTPFZpeQxAdA
X-Proofpoint-ORIG-GUID: q_zmmzpRc2DdNUzqMzxPRTPFZpeQxAdA
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Export do_update_pinned. No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.h |  5 +++++
 drivers/iommu/iommufd/pages.c        | 10 +++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 9b40b22..e26a0d7 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -252,4 +252,9 @@ struct iopt_pages_access {
 	unsigned int users;
 };
 
+struct pfn_reader_user;
+
+int iopt_update_pinned(struct iopt_pages *pages, unsigned long npages, bool inc,
+		       struct pfn_reader_user *user);
+
 #endif
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 8f24916..d42098c 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -985,8 +985,8 @@ static int update_mm_locked_vm(struct iopt_pages *pages, unsigned long npages,
 	return rc;
 }
 
-static int do_update_pinned(struct iopt_pages *pages, unsigned long npages,
-			    bool inc, struct pfn_reader_user *user)
+int iopt_update_pinned(struct iopt_pages *pages, unsigned long npages, bool inc,
+		       struct pfn_reader_user *user)
 {
 	int rc = 0;
 
@@ -1020,8 +1020,8 @@ static void update_unpinned(struct iopt_pages *pages)
 		return;
 	if (pages->npinned == pages->last_npinned)
 		return;
-	do_update_pinned(pages, pages->last_npinned - pages->npinned, false,
-			 NULL);
+	iopt_update_pinned(pages, pages->last_npinned - pages->npinned, false,
+			   NULL);
 }
 
 /*
@@ -1051,7 +1051,7 @@ static int pfn_reader_user_update_pinned(struct pfn_reader_user *user,
 		npages = pages->npinned - pages->last_npinned;
 		inc = true;
 	}
-	return do_update_pinned(pages, npages, inc, user);
+	return iopt_update_pinned(pages, npages, inc, user);
 }
 
 /*
-- 
1.8.3.1

