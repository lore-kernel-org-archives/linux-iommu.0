Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C0137144
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880913; cv=none; b=a/pEkZNCP29WejS92qgUK2KCmPPxX1/exsL3SVm5a/yvExayos8bsQG4NNNZug/gCUr0gCOYHiJj9JxQ/SFsLfVA6mSSN2ox4UBN9SnH+SEfPx1Znt2N7E9ltqNcWqTd5OgDpdCs9Clz50mwnT2OlGHOMOAc+VSaN2nUXbpIKDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880913; c=relaxed/simple;
	bh=TNz5gwP5EqQjqbQKrLe85YFRmI+VDTPreSOpieK64Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E+fKSiMJ3zoQtgDoOovG9CSmvbl9tElGQVvJNVeun2GkeMGasBskys5bsWaRXERJox9/1EpL4jIVQ3xy25cetofYh7jyN9KjRG2AGgqdjK4gNBxvrQovY0JSc3Tw1LpCMqjtTqVtqZj6isYacmqBldjhYYlPsAOYEFci5CNN4/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OdYZtpRG; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OdYZtpRG"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412DQqwU013385;
	Fri, 2 Feb 2024 13:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2023-11-20;
 bh=HSFIx6kp8aBfVi2QnJqyKWel4EQviqZmZaDRF2EtJuA=;
 b=OdYZtpRGvnEKHoAmTbXRH82I5pgWim63xucNDR8cWm+r9CVOUrUK7Menig5FdC5Z3MGR
 Yaht4aPGmRzWJmGCo39IV/lcHvLYxnG1219FmpuV/sam9e8/M/XZLA/t8a9STOMvrIuv
 u4HkYTZkJrEBWDhrM7bTLS4TLRWYbgpJTrLjl0E+xkjGXcF0jsTxizZm3JPvGm/B8ahu
 BqU0KYrfE9rRtcB/7s9nsIpj0o/ItM1YLRJcAl71L4UdWipAlwUrzrkYK9BFUFK9Q1iJ
 Hr0fQMKXfQ07v0hj8Hu9EV0aM5yioklc0ZV+Tqh/suEGw77v61bJ5OjqWavdOIgF4HIM Ng== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvrm47jdu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 13:34:59 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 412DYqb2024500;
	Fri, 2 Feb 2024 13:34:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9buf2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 13:34:59 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412DWmAj022185;
	Fri, 2 Feb 2024 13:34:58 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-220-219.vpn.oracle.com [10.175.220.219])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr9buewt-3;
	Fri, 02 Feb 2024 13:34:58 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 2/9] iommufd/iova_bitmap: Switch iova_bitmap::bitmap to an u8 array
Date: Fri,  2 Feb 2024 13:34:08 +0000
Message-Id: <20240202133415.23819-3-joao.m.martins@oracle.com>
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
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=968 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020099
X-Proofpoint-GUID: 4nF-ukURBG-qYq-dwdF7Z8Cg7NZYXWvX
X-Proofpoint-ORIG-GUID: 4nF-ukURBG-qYq-dwdF7Z8Cg7NZYXWvX

iova_bitmap_mapped_length() don't deal correctly with the small bitmaps
(< 2M bitmaps) that the starting address isn't u64 aligned, leading to
skipping a tiny part of the IOVA range. This is materialized as not
marking data dirty that should otherwise have been.

Fix that by using a u8* in the internal state of IOVA bitmap. Most
of the data structure uses the type of the bitmap to adjust its indexes,
thus changing the type of the bitmap decreases the granularity of the
bitmap indexes.

Fixes: b058ea3ab5af ("vfio/iova_bitmap: refactor iova_bitmap_set() to better handle page boundaries")
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/iommu/iommufd/iova_bitmap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index a3606b4c2229..9d42ab51a6bb 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -100,7 +100,7 @@ struct iova_bitmap {
 	struct iova_bitmap_map mapped;
 
 	/* userspace address of the bitmap */
-	u64 __user *bitmap;
+	u8 __user *bitmap;
 
 	/* u64 index that @mapped points to */
 	unsigned long mapped_base_index;
@@ -162,7 +162,7 @@ static int iova_bitmap_get(struct iova_bitmap *bitmap)
 {
 	struct iova_bitmap_map *mapped = &bitmap->mapped;
 	unsigned long npages;
-	u64 __user *addr;
+	u8 __user *addr;
 	long ret;
 
 	/*
@@ -247,7 +247,7 @@ struct iova_bitmap *iova_bitmap_alloc(unsigned long iova, size_t length,
 
 	mapped = &bitmap->mapped;
 	mapped->pgshift = __ffs(page_size);
-	bitmap->bitmap = data;
+	bitmap->bitmap = (u8 __user *)data;
 	bitmap->mapped_total_index =
 		iova_bitmap_offset_to_index(bitmap, length - 1) + 1;
 	bitmap->iova = iova;
@@ -304,7 +304,7 @@ static unsigned long iova_bitmap_mapped_remaining(struct iova_bitmap *bitmap)
 
 	remaining = bitmap->mapped_total_index - bitmap->mapped_base_index;
 	remaining = min_t(unsigned long, remaining,
-			  bytes / sizeof(*bitmap->bitmap));
+			  DIV_ROUND_UP(bytes, sizeof(*bitmap->bitmap)));
 
 	return remaining;
 }
-- 
2.17.2

