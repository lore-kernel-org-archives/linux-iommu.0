Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94004143891
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486107; cv=none; b=VUohjnWsVTdlWCzAqyAL808k1f7sskw8QBG4bx6P0J9dv77OwqGiUlVstoO2iJXSUvUztNByVr0k90T7qsGLgTNg01kZwQ//OkBVTGGHwG4PT4A5UQ1g+OcjvYJDHONmPpqtwpEahRS5lnoX0+1apGBztZ5U1wblz35r+eJaQx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486107; c=relaxed/simple;
	bh=O1iQUQUri2sQ3KdUNYgiTHCIuX2Qc0IM7ZLRMxPPKKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nKYNJAK31zATLm6cx/mNnb+yqTj04ENGkr8CkzG/fW8AJjr0wmPiL78SBni3nWVRnsgqXR7kUOR9ioau+MERRJkDftKnczOTlIugF7SNZ9AB1vTW/mfRPDNHKIWIEcQK30KnriVZc51tbeulEjxLe+zdpfLzxN/SWqpdc+209WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oaYdtUCf; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oaYdtUCf"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7tSrt009925;
	Thu, 27 Jun 2024 11:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=F
	9wWKfExxN957ijSh5aWkrdHQcKU7TAQGZLiFdnRGnY=; b=oaYdtUCfsgStXHZt1
	q55p84Nu79ZJ7UY56mWG62l4zoo1xH5ilLjzi9YdjFD+GnVFWmf9uNAeVpTV1NLc
	NHZW7DuUZjRHt0fKr3szvxt79kSSgteT4mdDfGDtEUEpWlpdvNdpP49Zm6mVYA3E
	gzcqVDemKTDEY3vW+SP0IVpbTtpvX+3LvggcHcXq9mEPp+w5BgwvVasAVAfCN74s
	x/cwG4tPg8YX/JiT/At6zH0Rvp696w6NQx+Luu/Hpr1JkwsftLLwL+eO+0wEQQTH
	jOSRAL9mqQ8Idy9Re2Gu7/HOTUrm8wWfrugHZNEf0JmG1KbpCl8smxrylvcIMAi0
	ukdSA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnd2nt3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45R9guj7023390;
	Thu, 27 Jun 2024 11:01:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2grvfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:35 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45RB1KND025281;
	Thu, 27 Jun 2024 11:01:34 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-7-218.vpn.oracle.com [10.175.7.218])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2grv3s-7;
	Thu, 27 Jun 2024 11:01:34 +0000
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
Subject: [PATCH v2 06/11] iommufd/iova_bitmap: Check iova_bitmap_done() after set ahead
Date: Thu, 27 Jun 2024 12:01:00 +0100
Message-Id: <20240627110105.62325-7-joao.m.martins@oracle.com>
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
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=797
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270083
X-Proofpoint-ORIG-GUID: Bk7zKB6MItoJBcdTTb8F-oMNZLkX6kX5
X-Proofpoint-GUID: Bk7zKB6MItoJBcdTTb8F-oMNZLkX6kX5

After iova_bitmap_set_ahead() returns it may be at the end of the range.
Move iova_bitmap_set_ahead() earlier to avoid unnecessary attempt in
trying to pin the next pages by reusing iova_bitmap_done() check.

Fixes: 2780025e01e2 ("iommufd/iova_bitmap: Handle recording beyond the mapped pages")
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommufd/iova_bitmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/iova_bitmap.c b/drivers/iommu/iommufd/iova_bitmap.c
index db8c46bee155..e33ddfc239b5 100644
--- a/drivers/iommu/iommufd/iova_bitmap.c
+++ b/drivers/iommu/iommufd/iova_bitmap.c
@@ -384,8 +384,6 @@ static int iova_bitmap_advance(struct iova_bitmap *bitmap)
 	bitmap->mapped_base_index += count;
 
 	iova_bitmap_put(bitmap);
-	if (iova_bitmap_done(bitmap))
-		return 0;
 
 	/* Iterate, set and skip any bits requested for next iteration */
 	if (bitmap->set_ahead_length) {
@@ -396,6 +394,9 @@ static int iova_bitmap_advance(struct iova_bitmap *bitmap)
 			return ret;
 	}
 
+	if (iova_bitmap_done(bitmap))
+		return 0;
+
 	/* When advancing the index we pin the next set of bitmap pages */
 	return iova_bitmap_get(bitmap);
 }
-- 
2.17.2

