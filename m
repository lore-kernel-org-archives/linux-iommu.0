Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F6F13F44E
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486109; cv=none; b=CdJ/VeGO/DKF02vPpG3nb4lHP4tt3Y9/tBFbrBYrvLL7WyAAOVXJYLX58/KShkZFfB91jjX68EmOvutqeizcyOacrrueXSlBkv3/60Ov7rk+jlZJvOvpvnTTLm3ZCKxZ1cSrOp59QZaiZN6YqEMGSfAVuRoTXMEA/vZJFi3Y5KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486109; c=relaxed/simple;
	bh=vix9qWYK3DFNA5Zw+/nzICkPkN038tsznwvTYQiTL+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qhSez2itJ2dLsbgI4CK/2eMbr+sXXZsa7TxphHmOcaMe2WQCpI7cyyRk4/9paDawy1PuptbxPYzQLyh4/3NedLBqUScXEd+pUo8TUq+AgdW+badVUWyeTahE6xj+SJTfFJA6Rc6VQXiC7FFYIuu+zBUs46WzI0QY5hQWNdWaK4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RxEv9cds; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RxEv9cds"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7tTj4029112;
	Thu, 27 Jun 2024 11:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=X
	zT0tCvoZjBcT612f7yHiJhoRcJpZ+7Qe7opBBT/zRc=; b=RxEv9cdsbbqJq8cEl
	8bwPAI00bVfLD541aDuKgyictNJqCTf/GtgZZaWpRKP1tKT1XGc8dyK2CPxgyi1C
	CvVOvOPukX9QYGG/An04Wg+y5sEzuP/ehdfbu14BbPVLFaiN8nqGoqk7isI6c9FK
	DJhiVO6WlDe/MsVJJNCzRVckLNG21nvBZw8dpSGd27H1MLjPIIIvOtpCnvKT8dJe
	meXu3mU7L530/Y4vJ3lscuXVu2Iuxww+yZpxDASMAckvtewWU5Pl4ZsaHc5/0nH0
	4TFN7/SnHeFcHM/pj60p83j8OedXst1luHzStwSkQmZkFtwgsWTtuf9+5TWZnkUn
	WAgJQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 400ttn9bmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45R8q2qJ023401;
	Thu, 27 Jun 2024 11:01:40 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2grvj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:40 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45RB1KNH025281;
	Thu, 27 Jun 2024 11:01:39 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-7-218.vpn.oracle.com [10.175.7.218])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2grv3s-9;
	Thu, 27 Jun 2024 11:01:39 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Matt Ochs <mochs@nvidia.com>
Subject: [PATCH v2 08/11] iommufd/iova_bitmap: Move initial pinning to iova_bitmap_for_each()
Date: Thu, 27 Jun 2024 12:01:02 +0100
Message-Id: <20240627110105.62325-9-joao.m.martins@oracle.com>
In-Reply-To: <20240627110105.62325-1-joao.m.martins@oracle.com>
References: <20240627110105.62325-1-joao.m.martins@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_06,2024-06-27_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=903
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270083
X-Proofpoint-GUID: 1_Gd9ikXF-ETm-P-rEVuXTdfO-bEGlRQ
X-Proofpoint-ORIG-GUID: 1_Gd9ikXF-ETm-P-rEVuXTdfO-bEGlRQ

The pinned pages are only relevant when it starts iterating the bitmap so
defer that into iova_bitmap_for_each().

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommufd/iova_bitmap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index 2b87ea16ad66..b94636b7977e 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -269,9 +269,6 @@ struct iova_bitmap *iova_bitmap_alloc(unsigned long iova, size_t length,
 		goto err;
 	}
 
-	rc = iova_bitmap_get(bitmap);
-	if (rc)
-		goto err;
 	return bitmap;
 
 err:
@@ -425,6 +422,10 @@ int iova_bitmap_for_each(struct iova_bitmap *bitmap, void *opaque,
 {
 	int ret = 0;
 
+	ret = iova_bitmap_get(bitmap);
+	if (ret)
+		return ret;
+
 	for (; !iova_bitmap_done(bitmap) && !ret;
 	     ret = iova_bitmap_advance(bitmap)) {
 		ret = fn(bitmap, iova_bitmap_mapped_iova(bitmap),
-- 
2.17.2

