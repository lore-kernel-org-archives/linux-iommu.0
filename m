Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF6D17B410
	for <iommu@lists.linux.dev>; Fri, 21 Jun 2024 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995422; cv=none; b=is2Z8SDCVYjjITWlBDVGJ1FjchR9k1qisNHq4WcHpctZ5sZPAgnkqzZjTSz+Y+8Z7h7w5Ejx25RCElSyjaefdeolj71YACj3FpUXAcJUONK08OvtZ0VacY9b7xwWlpwgd3dh5u0IfMkJl//9Gwu+oOF1qclIEvWjFQSo7944ysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995422; c=relaxed/simple;
	bh=d8pWRjU3x+vsJzv9clciWbiVM5kO3cd170ONPt2VMtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lriTuupUsoQV9m67EEXL7VRhJi77Fb45N32vib4aDEBG37pzztsLQ9wKJYdVX0C0ZlIGN5cYrYv2TfrwC609EioQI8ObZh8YcV3uIA0DN30ZVopvNLnSozyJ3VieB9H8RuJArXi5jDIFCf20h8BabvqVw1jadW17iT4J2kkRJN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K9bfxqdy; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K9bfxqdy"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LEXTFv010247;
	Fri, 21 Jun 2024 18:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=g
	ux74StIEIYptmMqb2qAgTo03Ci2cYLiO/pnTpUrBEg=; b=K9bfxqdydHL4Vz3wA
	/0Kb+SqMtRCE6yvm1z1Xo6i5Ls8ZDNLsJf0NkbKy+k6aNnrrTt/ko/ClVGXr6rYp
	IRg4Kx4QZVah7374QGPG9R3FEgbYeNqPrPt5gfk25mDnddcwthXpQpNgAWhYAsVd
	/zLHMPMY84dFeXV5OMcF2exdsY5e0RiJcALf3/7SE9JOlYeGsqOg7hkrG/uSsB4h
	5CJE+wYpmZC2fIy0flSgBkSlAMSQgHZEdevedR/DiKyugdMx1zO6rz9ypIWfZ+bS
	Twj6vUcTx0mIUqjyUPnA36ur9KlOG1mh3CucmNQlKcZdMa0Y0NpsfZHwC0UhWYz1
	fXplg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkfaake-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 18:43:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45LISVha040153;
	Fri, 21 Jun 2024 18:43:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn4pp3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 18:43:32 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45LIhFXE032040;
	Fri, 21 Jun 2024 18:43:32 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-63-48.vpn.oracle.com [10.175.63.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yvrn4pnuj-7;
	Fri, 21 Jun 2024 18:43:32 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 06/10] iommufd/iova_bitmap: Cache mapped length in iova_bitmap_map struct
Date: Fri, 21 Jun 2024 19:42:50 +0100
Message-Id: <20240621184254.45477-7-joao.m.martins@oracle.com>
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
 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210136
X-Proofpoint-ORIG-GUID: VhEVSkv_BrP9STa_ckMXyyF_Yo201qaX
X-Proofpoint-GUID: VhEVSkv_BrP9STa_ckMXyyF_Yo201qaX

The amount of IOVA mapped will be used more often in iova_bitmap_set() in
preparation to dynamically iterate the bitmap. Cache said length to avoid
having to calculate it all the time.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
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

