Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8136D1419A1
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486107; cv=none; b=YUhknLHBruUzDCzU11IqkaMarlwo/3FU8xkZuhqR7bcUfccqWWUf1sM5QX6s1wU9dzfWUej5d5y3GdlV3mN/9reegZrUfaa6wsnshgzgb0t2kIRZllJaX5PR3zxkh4wAK1NcR9E+UpAI0duVljdY1/CjHItPelPf5PGaHMbixR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486107; c=relaxed/simple;
	bh=w1LlI+DPYPkoz2+Uowg4PYF/GMgjLoxI9ULdnRiNAzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LYUkjeXhQwaSfGj5nLRRI+AJpfY3xMMm6CGauIlVveZGeQhycsTg/91M2lzFAyEkASAobtPmUaBT9s7zmtRvemZWjOEbVKKmIrSkhr2Ner2B8LPaFGvH/aMsgK1d0CeDMphyh0FzN7RFHNtgfBv6i5UT4S49CdbzG1Y8g5mNQ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QLjOpqx5; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QLjOpqx5"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7tUV0019299;
	Thu, 27 Jun 2024 11:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=I
	XCrBbRKMW8M3NW0KjKYn9QYsA7576wdIEENd898yUU=; b=QLjOpqx5I1v+DcwWY
	3XDeCOVv2skIhARohwIqhAciCLZBatJC44MF9puqZzLlpAzSigGfUaq0YL4m9214
	dBmuOENNedOKJ2T2gDA4KE+ybCuid88ci8AqLbzQ+9/wDa3GPhJmMBzroHD5K/io
	R4uY2mFpb5UG0I8aGnThai3X5J9fQqraaA4p5s97OAMHnzAHY14ZNv1imFKmqh5/
	KzcTAvFqP3T2PN4AFKt0dqyokqlqLDUt6ZlM0A/GCwym5LhcoyEYjFbN+53KWMEz
	DhoY83lOdDuT8gWPqdipHiUWTbPNdjPuaz49XB3dSA6SRwAAy/WPQ0hBzyiw/ODA
	9duQQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7snqb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RAFsGr023413;
	Thu, 27 Jun 2024 11:01:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2grvgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:37 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45RB1KNF025281;
	Thu, 27 Jun 2024 11:01:37 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-7-218.vpn.oracle.com [10.175.7.218])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2grv3s-8;
	Thu, 27 Jun 2024 11:01:37 +0000
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
Subject: [PATCH v2 07/11] iommufd/iova_bitmap: Cache mapped length in iova_bitmap_map struct
Date: Thu, 27 Jun 2024 12:01:01 +0100
Message-Id: <20240627110105.62325-8-joao.m.martins@oracle.com>
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
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=995
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270083
X-Proofpoint-GUID: 32eBbYkxnJcbzNVt7qTm5D0odP9nXL95
X-Proofpoint-ORIG-GUID: 32eBbYkxnJcbzNVt7qTm5D0odP9nXL95

The amount of IOVA mapped will be used more often in iova_bitmap_set() in
preparation to dynamically iterate the bitmap. Cache said length to avoid
having to calculate it all the time.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommufd/iova_bitmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index e33ddfc239b5..2b87ea16ad66 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -35,6 +35,9 @@ struct iova_bitmap_map {
 	/* base IOVA representing bit 0 of the first page */
 	unsigned long iova;
 
+	/* mapped length */
+	unsigned long length;
+
 	/* page size order that each bit granules to */
 	unsigned long pgshift;
 
@@ -156,6 +159,8 @@ static unsigned long iova_bitmap_mapped_iova(struct iova_bitmap *bitmap)
 	return bitmap->iova + iova_bitmap_index_to_offset(bitmap, skip);
 }
 
+static unsigned long iova_bitmap_mapped_length(struct iova_bitmap *bitmap);
+
 /*
  * Pins the bitmap user pages for the current range window.
  * This is internal to IOVA bitmap and called when advancing the
@@ -206,6 +211,7 @@ static int iova_bitmap_get(struct iova_bitmap *bitmap)
 	 * aligned.
 	 */
 	mapped->pgoff = offset_in_page(addr);
+	mapped->length = iova_bitmap_mapped_length(bitmap);
 	return 0;
 }
 
-- 
2.17.2

