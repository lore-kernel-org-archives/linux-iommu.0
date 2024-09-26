Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F08753368
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 13:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358837; cv=none; b=KuDogGz9EAzs6QgPVVDbr0dVbYut+ZqDgI0p+v9xmdgIzZHG9zVf3eAZnI30gecSj3Kunt+4iD0uHMhlLMGcNWnsgqlQ24J8g2vYsFhsRUQZtPYvnbqOb9obrgQHScvuEjHnO1cj/piH1lfyA9NHNyXPZkOjq66nen3KYrAnNbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358837; c=relaxed/simple;
	bh=j2g1RHYqnFXaZwHvvgxAvq+I63JISTTfPFxOpZ3ABuU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qeMXgHKbPH81ClfFlo7Bn/hlLBUAzWYQ+RyTDooFXKqxmYwTOX4NaB0bUJhH26wFrTD56yEXGOL47/ct+FS+hMVlzNT9EkxscflTb4yLchaRfY9JAlGz8+tcLzCn8oqXyRCI02QTqCnd8VK7GYL9rCnXWr+awEQ/iXUz4vJs6Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BOH0ZEXA; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BOH0ZEXA"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QAYQqS031460;
	Thu, 26 Sep 2024 13:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	corp-2023-11-20; bh=zx0qG/0MVL0P/BsxD4iS76Tw8/2IRjPR26k1VMfyiN4=; b=
	BOH0ZEXABAfvk5mYgpxIjjFYY+zhQ+PZzPIC80gSxYDz1YgktA8T2l+lS1uMXKpe
	ZYcmHhqT3msTk+q9W+KQ8918xEtdye57NVawhI7vHnoGYtx0Oo9xT4b3ZH1YqkJ4
	DdU5wTsJZat4vilCkty5bzbfKX/zBncs7uxXPjULGvSVVidI3xDFHvatcd1elb/2
	jho72IHSWTKPNep7/fmNmnihvCL8N48tsL04vekowovsWEYyyQNIV4ZwNd4rV23l
	xNcOvbAhP/YV5dfpY4EuZ3mbnyf3jfW0FDKfYB5B5bX+f4odBjDJ6JHzRxCdUF2I
	7x+tQwZKXvnjOBpp40d6hA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smr1daga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 13:53:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48QCU7So032720;
	Thu, 26 Sep 2024 13:53:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkjfd8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 13:53:52 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48QDroXS027500;
	Thu, 26 Sep 2024 13:53:51 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41smkjfd62-2;
	Thu, 26 Sep 2024 13:53:51 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 1/4] iommufd: Export do_update_pinned
Date: Thu, 26 Sep 2024 06:53:45 -0700
Message-Id: <1727358828-97791-2-git-send-email-steven.sistare@oracle.com>
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
X-Proofpoint-ORIG-GUID: rK9Y8SkS-KyJr0Gl9L7r84KRvwXtx7UG
X-Proofpoint-GUID: rK9Y8SkS-KyJr0Gl9L7r84KRvwXtx7UG
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
index 909d396..5552911 100644
--- a/drivers/iommu/iommufd/io_pagetable.h
+++ b/drivers/iommu/iommufd/io_pagetable.h
@@ -252,4 +252,9 @@ struct iopt_pages_access {
 	unsigned int users;
 };
 
+struct pfn_reader_user;
+
+int iopt_update_pinned(struct iopt_pages *pages, unsigned long npages,
+		       bool inc, struct pfn_reader_user *user);
+
 #endif
diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
index 6b71072..db606b1 100644
--- a/drivers/iommu/iommufd/pages.c
+++ b/drivers/iommu/iommufd/pages.c
@@ -991,8 +991,8 @@ static int update_mm_locked_vm(struct iopt_pages *pages, unsigned long npages,
 	return rc;
 }
 
-static int do_update_pinned(struct iopt_pages *pages, unsigned long npages,
-			    bool inc, struct pfn_reader_user *user)
+int iopt_update_pinned(struct iopt_pages *pages, unsigned long npages,
+		       bool inc, struct pfn_reader_user *user)
 {
 	int rc = 0;
 
@@ -1026,8 +1026,8 @@ static void update_unpinned(struct iopt_pages *pages)
 		return;
 	if (pages->npinned == pages->last_npinned)
 		return;
-	do_update_pinned(pages, pages->last_npinned - pages->npinned, false,
-			 NULL);
+	iopt_update_pinned(pages, pages->last_npinned - pages->npinned, false,
+			   NULL);
 }
 
 /*
@@ -1057,7 +1057,7 @@ static int pfn_reader_user_update_pinned(struct pfn_reader_user *user,
 		npages = pages->npinned - pages->last_npinned;
 		inc = true;
 	}
-	return do_update_pinned(pages, npages, inc, user);
+	return iopt_update_pinned(pages, npages, inc, user);
 }
 
 /*
-- 
1.8.3.1

