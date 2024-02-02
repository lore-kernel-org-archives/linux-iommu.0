Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ECA4643A
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880924; cv=none; b=N6KW4mEAXxuvGhW6SYW4b2LtpbkJ08fL7WWHXSSMiSih/SrvXbohHYdJAC8Oz8Q869aSgHcxHTbDTX200y3HURmQcLih8ha5iiNXEAoyZ0rIEIRJycCDi/jAejWRp3dqF4fX9BbEoR2WTxNCixFfTO9ESRl3Z5qkVuT+KxeKzbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880924; c=relaxed/simple;
	bh=Nx4l/mW/R3KV8jZTJGJnr08NykuuAY/ZpMJn6zP9PE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Abg3xRptKDsqfy3xtkiPwIrB2JJg+NoNJNqC8gVcRUgxbUGXRtcYosQ4cWfS73yLYFWITqC/2o3O55fFQKlGGl5BvZOjXGVWJRvZ+rIwc1HIrbv3maRQgYKDqQtQth1NdizieX4/w5qAi4GYSK2DE2U0Qjo0y2KRdvd55vaW1VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GWGCqUaO; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GWGCqUaO"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412DQoP4019851;
	Fri, 2 Feb 2024 13:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=mmcR8+O9h3EB6+SM741llLbmnvPfyyBfpb1pgQmUIUg=;
 b=GWGCqUaO+uF+Mf189UGHcQnKqQkskIRYnf/UxlFQZ0Suu7gatcRVGjdrdigtmsM2Bbkr
 tQIvnmBT5G4vCxIFCcwtZsatxqkSyuDIbMPmHP6Xf5ihahPRbK9hZKancDYtDoS0osFF
 3QQbpwwGAkuGdBkWr5LWqeZalPtFpXAQRTQX5nL+qMUADzdg/z8a2EeSXuqqB2+w86fj
 OUkKcKMIO8EUk7BPlLGmGMWzpWw4KQEdRoRbuBJb37A6ZGYeIaWzbuyhSqK4LTKla4q5
 tzg9dtpzJRA3pBrVqNn+I/qjdaSq9TRlpITxBnLDqML9KaW2L2ypX4jtG5qrkid421FN CA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre2qs3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 13:35:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 412DYqbC024500;
	Fri, 2 Feb 2024 13:35:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9buffh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 13:35:17 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412DWmAx022185;
	Fri, 2 Feb 2024 13:35:17 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-220-219.vpn.oracle.com [10.175.220.219])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr9buewt-10;
	Fri, 02 Feb 2024 13:35:16 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 9/9] iommufd/iova_bitmap: Consider page offset for the pages to be pinned
Date: Fri,  2 Feb 2024 13:34:15 +0000
Message-Id: <20240202133415.23819-10-joao.m.martins@oracle.com>
In-Reply-To: <20240202133415.23819-1-joao.m.martins@oracle.com>
References: <20240202133415.23819-1-joao.m.martins@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_07,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=997 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020099
X-Proofpoint-GUID: sZrVvsVgX8IIlK8rndeFhbSN1odnpn7W
X-Proofpoint-ORIG-GUID: sZrVvsVgX8IIlK8rndeFhbSN1odnpn7W

For small bitmaps that aren't PAGE_SIZE aligned *and* that are less than
512 pages in bitmap length, use an extra page to be able to cover the
entire range e.g. [1M..3G] would be iterated more efficiently in a
single iteration, rather than two.

Fixes: b058ea3ab5af ("vfio/iova_bitmap: refactor iova_bitmap_set() to better handle page boundaries")
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/iommu/iommufd/iova_bitmap.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index b370e8ee8866..db8c46bee155 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -178,18 +178,19 @@ static int iova_bitmap_get(struct iova_bitmap *bitmap)
 			       bitmap->mapped_base_index) *
 			       sizeof(*bitmap->bitmap), PAGE_SIZE);
 
-	/*
-	 * We always cap at max number of 'struct page' a base page can fit.
-	 * This is, for example, on x86 means 2M of bitmap data max.
-	 */
-	npages = min(npages,  PAGE_SIZE / sizeof(struct page *));
-
 	/*
 	 * Bitmap address to be pinned is calculated via pointer arithmetic
 	 * with bitmap u64 word index.
 	 */
 	addr = bitmap->bitmap + bitmap->mapped_base_index;
 
+	/*
+	 * We always cap at max number of 'struct page' a base page can fit.
+	 * This is, for example, on x86 means 2M of bitmap data max.
+	 */
+	npages = min(npages + !!offset_in_page(addr),
+		     PAGE_SIZE / sizeof(struct page *));
+
 	ret = pin_user_pages_fast((unsigned long)addr, npages,
 				  FOLL_WRITE, mapped->pages);
 	if (ret <= 0)
-- 
2.17.2

