Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25361DCB2A
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321211; cv=none; b=iO1g9jfxl2kQTr3jfrz2X2mhC4lKRztmZ41VYJUGL/nW/lio1fIZ+KYKENavmMxnHARkE3Uk2V5o36Nbb3PZS/PW/tkX+g0J9idj57TSxyTF02PqYixLWZTEIewnYzMtD8AtT+wFr/LNKxrO5RlIZAW5dogeOSw3IR7P6speBWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321211; c=relaxed/simple;
	bh=dIEV7mK7iHJRM49lvnMSUGzS4hblxt4TyWCb8IkEIYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=KsQlWU68UcVlnPkjvNpJpNeavP4Kt9YiRNC9sn/nYxKKZYAphvQQzUYaoKW64IClOYd6yLndYwTovqiMYbK/AKnQgcMqWulwRUVhkL68BzAK2SYCfgG914EdGs9EL4ElF8O38TZ8efkezdpdZ9dZvYKS1NQwQk0LDXoARMiWRjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IjLfoc+/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IjLfoc+/"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMabu022208;
	Mon, 7 Oct 2024 17:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:in-reply-to:message-id:references:subject:to; s=
	corp-2023-11-20; bh=xPUpOR9hiNgx8tMawOAPZvh5LheGCCGxoQ5fyErVhoY=; b=
	IjLfoc+/cY2FBl0xlcc+7W4aVICMovujIKQJfvnp5wHellpQcXlOEt1f3wSJaUVL
	jmF7zqVtz0jMsDC+2sCz56bIejlS1GPzQyGFy5f1xd7vBEb7x1stiRwawjhySlhQ
	g7VNEfynjYTxJJEFcCiJwjJB9TPiCjDJfep+rLDPl4IBdyWX0litwByMC1o9nkNv
	8gAZLNA/LSaD4l3UwUHIJSoG47aISwiFKfIyfYdpPSvaSR/6E2rovNf9MoQn1erN
	AgS1QToelfubAjvgNqGlXdYTgcRNQMPs80XMS6neMojcTJN8C4hqFTlUzdThmjoC
	Xes9B0hX+MwoPWBsZBsYNA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034m36j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 17:13:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497Fofcb004852;
	Mon, 7 Oct 2024 17:13:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uw63f28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 17:13:26 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 497HAoJ4003812;
	Mon, 7 Oct 2024 17:13:26 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 422uw63f0s-2;
	Mon, 07 Oct 2024 17:13:26 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 1/4] iommufd: Export do_update_pinned
Date: Mon,  7 Oct 2024 10:13:20 -0700
Message-Id: <1728321203-189608-2-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: Sxll-kOERi2uSTlJea0Tt-FjMGywX1W4
X-Proofpoint-ORIG-GUID: Sxll-kOERi2uSTlJea0Tt-FjMGywX1W4
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
index 909d396..622773a 100644
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
index b57c2b9..c3700e7 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -1006,8 +1006,8 @@ static int update_mm_locked_vm(struct iopt_pages *pages, unsigned long npages,
 	return rc;
 }
 
-static int do_update_pinned(struct iopt_pages *pages, unsigned long npages,
-			    bool inc, struct pfn_reader_user *user)
+int iopt_update_pinned(struct iopt_pages *pages, unsigned long npages, bool inc,
+		       struct pfn_reader_user *user)
 {
 	int rc = 0;
 
@@ -1041,8 +1041,8 @@ static void update_unpinned(struct iopt_pages *pages)
 		return;
 	if (pages->npinned == pages->last_npinned)
 		return;
-	do_update_pinned(pages, pages->last_npinned - pages->npinned, false,
-			 NULL);
+	iopt_update_pinned(pages, pages->last_npinned - pages->npinned, false,
+			   NULL);
 }
 
 /*
@@ -1072,7 +1072,7 @@ static int pfn_reader_user_update_pinned(struct pfn_reader_user *user,
 		npages = pages->npinned - pages->last_npinned;
 		inc = true;
 	}
-	return do_update_pinned(pages, npages, inc, user);
+	return iopt_update_pinned(pages, npages, inc, user);
 }
 
 /*
-- 
1.8.3.1

