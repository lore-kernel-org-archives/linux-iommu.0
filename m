Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CC31DDF6
	for <iommu@lists.linux.dev>; Sat, 20 Jul 2024 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721501812; cv=none; b=GADfnl0sbJbWXE7b4F3msisyIyXoj1uVXV9y+J89qjcViAOjMaqozOIZriO1DqVHfN38mt5MgdfzBwxcZ+N6+SKUd9E0QfbXL5dKio8VAzez9Jqr+hwEvgg+P2MR1ndpaHql1fSNaG4I/GQeK5NurLVJ7IvhG5j9RozQWiczvZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721501812; c=relaxed/simple;
	bh=HSstDn56I2SJmE2N7/Y4xrFcR6lYAfYncOgdmAUU/Wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dXGQZxSS1xbEoDdXlRTZQrqrbPKlu7h9kUuP57MmUNMIiO+iZL14hrnQQBhv+0sVoShEUXTj42N5LnJlU4J5LUIw0ciQhT8wPURMkUj9/+53e3/EqCWKBU9bUuJB7F16HoXnNAs3ZYAWFwV6zglmTOP4z4WMh8jHRTEvMJEy+3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sc8gbb5c; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sc8gbb5c"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KIu0UO006784;
	Sat, 20 Jul 2024 18:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=Z6yWN0M/HWN0HEOa3uRgH/LAvgIWUjBWhwP3WVl0g6I=; b=
	Sc8gbb5cf0WjvP/MENNq3IxJAeUU5iR5dc7WEXev0+k/uIiEFCdkUW21nhAHGsmz
	S4tCzssKZd2AWxUTjolAxJvDjnh8HqXoUhQ1YwIzwZ55RQOr7bjArvk9eLnEsd41
	HY0R1ZZfiwcWxG2zu9/nSYCaFQxbBq445gOHJH8tn8OKJk5OxRgsTQ2eiyUoSSF6
	MpEWPuUjASRBdG1VXwJg2EdDJZM9AeptvufPzqaOtHQDPictVCMQOx5yGWwKPs+J
	JCS2NN74JEwtShMLgaY+tRdc51Q20BO2YZ8hfeNg1ePuNici5ME81zkVkNwQgnmq
	OzyJtTqMw8IMF1FAXVHX0Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gjxhg00r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 18:56:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46KH3Z5E024412;
	Sat, 20 Jul 2024 18:56:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40g3p5xgbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 18:56:47 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46KIukDB032989;
	Sat, 20 Jul 2024 18:56:46 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40g3p5xgb0-2;
	Sat, 20 Jul 2024 18:56:46 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 1/4] iommufd: Export do_update_pinned
Date: Sat, 20 Jul 2024 11:56:41 -0700
Message-Id: <1721501805-86928-2-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-GUID: yEelvCGCBrhFHGJ_4w5Jl09c-x4_ub-Z
X-Proofpoint-ORIG-GUID: yEelvCGCBrhFHGJ_4w5Jl09c-x4_ub-Z
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Export do_update_pinned. No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 drivers/iommu/iommufd/io_pagetable.h |  5 +++++
 drivers/iommu/iommufd/pages.c        | 10 +++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.h b/drivers/iommu/iommufd/io_pagetable.h
index 0ec3509..c37b680 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -238,4 +238,9 @@ struct iopt_pages_access {
 	unsigned int users;
 };
 
+struct pfn_reader_user;
+
+int iopt_update_pinned(struct iopt_pages *pages, unsigned long npages,
+		       bool inc, struct pfn_reader_user *user);
+
 #endif
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 528f356..2366c15 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -854,8 +854,8 @@ static int update_mm_locked_vm(struct iopt_pages *pages, unsigned long npages,
 	return rc;
 }
 
-static int do_update_pinned(struct iopt_pages *pages, unsigned long npages,
-			    bool inc, struct pfn_reader_user *user)
+int iopt_update_pinned(struct iopt_pages *pages, unsigned long npages,
+		       bool inc, struct pfn_reader_user *user)
 {
 	int rc = 0;
 
@@ -889,8 +889,8 @@ static void update_unpinned(struct iopt_pages *pages)
 		return;
 	if (pages->npinned == pages->last_npinned)
 		return;
-	do_update_pinned(pages, pages->last_npinned - pages->npinned, false,
-			 NULL);
+	iopt_update_pinned(pages, pages->last_npinned - pages->npinned, false,
+			   NULL);
 }
 
 /*
@@ -920,7 +920,7 @@ static int pfn_reader_user_update_pinned(struct pfn_reader_user *user,
 		npages = pages->npinned - pages->last_npinned;
 		inc = true;
 	}
-	return do_update_pinned(pages, npages, inc, user);
+	return iopt_update_pinned(pages, npages, inc, user);
 }
 
 /*
-- 
1.8.3.1

