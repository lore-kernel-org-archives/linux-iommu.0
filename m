Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770E913E8B9
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486114; cv=none; b=pWjOcz7BbZBkxKnrJXs4Cn4DD4lD+TdrHKBvde0ofWmGztwvdG5jO6X+uYZ3DO59MlJl0Upk34WkA6uznCenr3LyXvb0fJqhIJcMrtm2lPXzAmDivbksY1XB56wQA2JtDxfOtmqRMIBu7vDpT6jQw+GXamQnluCKakq2I6mNFvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486114; c=relaxed/simple;
	bh=Aaw/Y6o2wWxgYUC9GQ+0BheDF4+MuWJwRvgNcpjpi3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LssN+v5kjPwTWCA08cSQdzHb9CCZFfSgF4G4IrMxC3flr6M3qjADD4mAawPUARXNzWL+e31CcLevNIQ0b/QT5/GL/nvzoBJpSLLzQsvrW2tk/+UWsiqT4cycvTIZUvQO9faz51vMIukfJDoHI64LeHcAEinNW4LkmF3dnqGGKTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TdIx9lTX; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TdIx9lTX"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7tSQk009921;
	Thu, 27 Jun 2024 11:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=C
	oJGCib9rEHrzLIu09+H/3a/DpK1hDxUq86mqbx8UaQ=; b=TdIx9lTXy5bR2Y5Jr
	OUfXXvVz//vp4EoUUWsr0TGzQP/VVuDi3Hsmq4pwLJSNs0xjpd6mHoWFUSf0hDoo
	H6Hf/Wr/eWDp2HDh63nGPIDmpPCi0uhGI1MIBvnrg15s0SPIEhp5AeK8snFFP5aR
	8yLwPa7Ko0TK3yTdzT1B384j+frbuD6rb78HzP5H31KeMhw5tiCokn1DpkYbAWq5
	9MVvh5Pza9PFydVvYDdX54BglmS/oKNWSwMrE7e7hmII10RM69fdvGBVM014fjgp
	IHLWAH7Dz4ijqvDUq/bSqCzTo/GU6z8kvy9KGViefgkmwVCT+YJR53iFGHsqoiPD
	s4rsQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnd2nt3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45R9bT5u023328;
	Thu, 27 Jun 2024 11:01:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2grvkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:42 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45RB1KNJ025281;
	Thu, 27 Jun 2024 11:01:42 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-7-218.vpn.oracle.com [10.175.7.218])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2grv3s-10;
	Thu, 27 Jun 2024 11:01:41 +0000
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
Subject: [PATCH v2 09/11] iommufd/iova_bitmap: Consolidate iova_bitmap_set exit conditionals
Date: Thu, 27 Jun 2024 12:01:03 +0100
Message-Id: <20240627110105.62325-10-joao.m.martins@oracle.com>
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
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=829
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270083
X-Proofpoint-ORIG-GUID: Ku8z7tiue4omOcjV4i04jf4Nbb2SqRTb
X-Proofpoint-GUID: Ku8z7tiue4omOcjV4i04jf4Nbb2SqRTb

There's no need to have two conditionals when they are closely tied
together. Move the setting of bitmap::set_ahead_length after it checks for
::pages array out of bounds access.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommufd/iova_bitmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index b94636b7977e..be97bb464f6b 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -465,18 +465,18 @@ void iova_bitmap_set(struct iova_bitmap *bitmap,
 					 last_bit - cur_bit + 1);
 		void *kaddr;
 
-		if (unlikely(page_idx > last_page_idx))
+		if (unlikely(page_idx > last_page_idx)) {
+			unsigned long left =
+				((last_bit - cur_bit + 1) << mapped->pgshift);
+
+			bitmap->set_ahead_length = left;
 			break;
+		}
 
 		kaddr = kmap_local_page(mapped->pages[page_idx]);
 		bitmap_set(kaddr, offset, nbits);
 		kunmap_local(kaddr);
 		cur_bit += nbits;
 	} while (cur_bit <= last_bit);
-
-	if (unlikely(cur_bit <= last_bit)) {
-		bitmap->set_ahead_length =
-			((last_bit - cur_bit + 1) << bitmap->mapped.pgshift);
-	}
 }
 EXPORT_SYMBOL_NS_GPL(iova_bitmap_set, IOMMUFD);
-- 
2.17.2

