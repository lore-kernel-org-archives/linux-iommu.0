Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D4117B409
	for <iommu@lists.linux.dev>; Fri, 21 Jun 2024 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995421; cv=none; b=Vo/4wDB5PjDKHxmEPbF+flcpXCLMtpuo9vOze8fleaTV1eb131wwWzDaS5yMpkHleuh0UJQ/cFyQd6jcQ9oyv/0Thhn60BeyC3+LzXkQaESP0/oYj0Uy9jFx7KWxtCwIayAEZcEDF8IFdulS2Fl2yl5AnCURiUs47o2QELJP+VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995421; c=relaxed/simple;
	bh=IlJ1XWLp6UiyMRGHwQ0zamZWWjvnHJ1d7kt/mMsgAMU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lquCqcfXz2nkfnou+UCowChMnUF/zFJOz42QIoOctxxWT1wsAwEn5xBPVumyt+LkCuSa7C/MfxNBc368lWRV/VZXvBofEYuGd4sNPBbPEANES6UgF0But3/jmSxuQM/5jji1BY1u5/+cUVEuKyJQ0hH2N5rKKysuKMHGeAMy/0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k3ZQSkmd; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k3ZQSkmd"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LEXeMn021651;
	Fri, 21 Jun 2024 18:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=f
	U5Aal3k7gzQqj4LuDceZ0W6EWAPoAkN8DRiRRJAyfs=; b=k3ZQSkmdRqskEMyDH
	L1mbE0ayUqVO2vyzDXmxbpMB4GyYVQ8fcypWLzkQ6ubaxXz4BYgzvxkyWzNF2wcG
	QM3C4AdZY0mIGEBB0RzDnGpyHyRIVersUstDUknoy/s5BlM46ZEvjUZS/6JYless
	Q1Pwz1NcrICdOjIGDSA62kLSoTCMrmJmEMvugfclssecN+t9YrYAcea76vVfJQ/P
	7mDDRQ7L6FHp+2qBbeD9fxqfF2W3znecuKT4DnVe+pQBPtsgC/bnsifxxNymhqvZ
	mIdgrg1c+1SwVQpi3Xkxfj4xWH7GUOfSP+r/2rK0+7fcJP4rL8DpVCAu3wYVZGch
	qj3oA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkjtc6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 18:43:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45LHBBdt040116;
	Fri, 21 Jun 2024 18:43:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn4pp2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 18:43:30 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45LIhFXC032040;
	Fri, 21 Jun 2024 18:43:29 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-63-48.vpn.oracle.com [10.175.63.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yvrn4pnuj-6;
	Fri, 21 Jun 2024 18:43:29 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 05/10] iommufd/iova_bitmap: Check iova_bitmap_done() after set ahead
Date: Fri, 21 Jun 2024 19:42:49 +0100
Message-Id: <20240621184254.45477-6-joao.m.martins@oracle.com>
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
 phishscore=0 spamscore=0 mlxlogscore=810 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210136
X-Proofpoint-GUID: FEBVe5IvytURUcDO9-PsMjniS1EGK8u6
X-Proofpoint-ORIG-GUID: FEBVe5IvytURUcDO9-PsMjniS1EGK8u6

After iova_bitmap_set_ahead() returns it may be at the end of the range.
Move iova_bitmap_set_ahead() earlier to avoid unnecessary attempt in
trying to pin the next pages by reusing iova_bitmap_done() check.

Fixes: 2780025e01e2 ("iommufd/iova_bitmap: Handle recording beyond the mapped pages")
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
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

