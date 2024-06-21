Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F0E1662F0
	for <iommu@lists.linux.dev>; Fri, 21 Jun 2024 18:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995429; cv=none; b=uR+/LiYaU1rWwUgdq/PuDnE6W9exGh7rWuvFydbMSBXyLzMWovYP+Pq3JH39DLLucjJfRJVadJWYjZ2Ylo/KGB8S3Aeqld+PZmW3jz1mkMFY9Zrt0/4rOVk711pQtwZ90lSmmapQXa/N3/cfqAJjzh/QJGkFs2rZ/L7+4i+ZZLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995429; c=relaxed/simple;
	bh=SoXyRfQhrJof/+btAI/rx7qi2iP4O2m5QBxXQm0s3Sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N3X448IPZoeaZlrc8IT6R8zpVoFKAmWj6XgUBMF2D2FvR1KrofnVwCXRWORPXGEmuqH24YidSASCOcUmevlBgoEv485ELQAehPMo1lBF9UL4Pde72MpjbdNUFCsiALhdttN8MWeqN8PfGdkn/6afYfrmTqXpmP+GP0HrbRUn6A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dTrKrhw4; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dTrKrhw4"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LEXeCK022367;
	Fri, 21 Jun 2024 18:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=k
	Th8zAInI1xnkenwM5uM63bb9jG5/KMEdhUB3JktX6k=; b=dTrKrhw4ZqA2CHLeX
	g0OGU5Vt5rmDOR1qGcP6Om/T68RAsHr6d2k6iQymiegdO+k8+4j4nApiqr5J8oNd
	NOEe1XtquMkiv+zgtlhDOs+E9FfAYeXnQqowgE07W/FANj1z3NeXLV35317J2iQJ
	NZbfFZty6jcsDsrPwGxHj7UWvXZSqmdpFp+LZsPQmEClqROtaCe560UdzUgRWuAf
	i5kcMDROlTSGAnc/hhnfQAbRPaYCm6fLHeaeYADsm9iosRzqZlQ00VdRfxr/cddO
	oUsz+stdFHMyFUeh9spjfVfbROUw9oH2EESkFrwKNcrYsEdyf1rUJ14rQBraPwRn
	mAg0w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrka2bg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 18:43:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45LHeb8r039437;
	Fri, 21 Jun 2024 18:43:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn4pp65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 18:43:36 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45LIhFXG032040;
	Fri, 21 Jun 2024 18:43:36 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-63-48.vpn.oracle.com [10.175.63.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yvrn4pnuj-8;
	Fri, 21 Jun 2024 18:43:35 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 07/10] iommufd/iova_bitmap: Move initial pinning to iova_bitmap_for_each()
Date: Fri, 21 Jun 2024 19:42:51 +0100
Message-Id: <20240621184254.45477-8-joao.m.martins@oracle.com>
In-Reply-To: <20240621184254.45477-1-joao.m.martins@oracle.com>
References: <20240621184254.45477-1-joao.m.martins@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_10,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=913 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210136
X-Proofpoint-GUID: 5KKQ0uTLnpZRd5ikEdKw1YY4F3Yqpl1f
X-Proofpoint-ORIG-GUID: 5KKQ0uTLnpZRd5ikEdKw1YY4F3Yqpl1f

The pinned pages are only relevant when it starts iterating the bitmap so
defer that into iova_bitmap_for_each().

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
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

