Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74C22040AE
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 19:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731527506; cv=none; b=XXwLG5rKihLQ6nLL2gRbV0wDQUnZ4YhtqgC5fLXKctDVZFNUNowIl/E4cw7I6+vUIo1zhODV/qjpyoxBSta+SbqdLiqwGg6vGaFpb2S1kZad68DeN65HM8WhJedPb+muI701l0sHL3K/bUgQafybGBr/Pi5WfWEqm1pcDtnLbpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731527506; c=relaxed/simple;
	bh=R7QA3V0hPuLSAw6LGxBJ5zUzwOmt6NZRrQDHizGnjDM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=nYPVXjnN4EuYttMMLkan/MxSEfxnJ3IV/bqaYDsmdOf4FKOJxh7cy89gC79iyTpenY4uReFy2AMBTcvx2aP+RtJegPhhoDxFYNgCoxi1wCa06KZOk/Fyy77T52BVsc08addAYP+gRa7tYs45JMgIcjcixiIbn6pWXbXEELUyvOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CDf4L7op; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CDf4L7op"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADIBVMq006337;
	Wed, 13 Nov 2024 19:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=wOpTAruHkcOyuewCLd5rIUYg3UQKKnhiAUKp6Pmgfgs=; b=
	CDf4L7opkzJ0E8IvTPJLcUJhim3j0ZRPwx2KmD2tWGEF/pXP+kc0kePaQxFKEPL9
	Od8dRpJwF62ZhzqrTw1exKFRfH3+JYEFTbxdFbVJcZp0h/XMoL4RM5d0sXrGFHsf
	GXmJQtto+xqt9se16VDgQDGZBiXKjGW9pK4Yb/1VynwijwEen59YIt5s45F3ZSFy
	A1r8sTpBwPK6jB5ebFCBlu033+dbwEVge06VuqesrkMCMKAjiNqqMn1qC86mmZJP
	yQGcrpqhTAcIE6UPFmlqwmUrmIDLYGVnopKPVpdzgc/0liPxVCoY5fh6TL3yJuQt
	KTwLC567DcpE+/1yGJfVBg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0nwqpx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 19:51:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADIHn3G001273;
	Wed, 13 Nov 2024 19:51:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6a4b68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 19:51:40 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4ADJpdsj023287;
	Wed, 13 Nov 2024 19:51:39 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42sx6a4b5c-2;
	Wed, 13 Nov 2024 19:51:39 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 1/4] iommufd: Export do_update_pinned
Date: Wed, 13 Nov 2024 11:51:34 -0800
Message-Id: <1731527497-16091-2-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1731527497-16091-1-git-send-email-steven.sistare@oracle.com>
References: <1731527497-16091-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_12,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130163
X-Proofpoint-GUID: YvljISirs3kPY2CjYZ-d1ZfZleLDf_Lv
X-Proofpoint-ORIG-GUID: YvljISirs3kPY2CjYZ-d1ZfZleLDf_Lv
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Export do_update_pinned. No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommufd/io_pagetable.h |  5 +++++
 drivers/iommu/iommufd/pages.c        | 10 +++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 9b40b22..f5f20fa 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -252,4 +252,9 @@ struct iopt_pages_access {
 	unsigned int users;
 };
 
+struct pfn_reader_user;
+
+int iopt_pages_update_pinned(struct iopt_pages *pages, unsigned long npages,
+			     bool inc, struct pfn_reader_user *user);
+
 #endif
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 8f24916..3427749 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -985,8 +985,8 @@ static int update_mm_locked_vm(struct iopt_pages *pages, unsigned long npages,
 	return rc;
 }
 
-static int do_update_pinned(struct iopt_pages *pages, unsigned long npages,
-			    bool inc, struct pfn_reader_user *user)
+int iopt_pages_update_pinned(struct iopt_pages *pages, unsigned long npages,
+			     bool inc, struct pfn_reader_user *user)
 {
 	int rc = 0;
 
@@ -1020,8 +1020,8 @@ static void update_unpinned(struct iopt_pages *pages)
 		return;
 	if (pages->npinned == pages->last_npinned)
 		return;
-	do_update_pinned(pages, pages->last_npinned - pages->npinned, false,
-			 NULL);
+	iopt_pages_update_pinned(pages, pages->last_npinned - pages->npinned,
+				 false, NULL);
 }
 
 /*
@@ -1051,7 +1051,7 @@ static int pfn_reader_user_update_pinned(struct pfn_reader_user *user,
 		npages = pages->npinned - pages->last_npinned;
 		inc = true;
 	}
-	return do_update_pinned(pages, npages, inc, user);
+	return iopt_pages_update_pinned(pages, npages, inc, user);
 }
 
 /*
-- 
1.8.3.1

