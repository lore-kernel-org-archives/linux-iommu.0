Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F45F17B410
	for <iommu@lists.linux.dev>; Fri, 21 Jun 2024 18:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995417; cv=none; b=TuLi9FM6behO7NMBIFNMRexj3sYv2l2xOT3KWPeBkJlwZlCdOQxCGPj5Y3hKHz66hqxDzr0htMTFHk6eoPkcQeuSx+2C9o71JPj+yCzh5b0TpXJIg4rYqm0+0PLETS00XJtPdJVT9qgzuAU+enk7g00GuiCJ2vmiiSX8uL4leZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995417; c=relaxed/simple;
	bh=EITTOGRtBvv6cz9i2/18rkSPDMcDrQHtpgIyV4qa/8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dkynLn6DYs+F2gRbR+FlIteVQqpMz4hTctkPHxfH5I3sZ894qkfBqauOBvQ8OywRhNJEEPuUl/bLdjm7/Hs1IXuGtFoFIAy+GCcQLx8VLmfD88MHuCveigzM8YcjayXlqQZrL9uqXnKbySZZ3tuXqx+0xoX5ZQyJ2omllLoCVco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WN4wEifn; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WN4wEifn"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LEXYr8010289;
	Fri, 21 Jun 2024 18:43:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=N
	eHyuGtPxMKSAxSRJHVvKA7dnyZNFISveRkou6yT+Co=; b=WN4wEifndIV5Bel9j
	j/is62lmtz09giOZppP1hVxQSWZR7vY66UWHG21f2Vh+tk4dEOMQ0WML+NgwoSfK
	mNHwVM1yCBM27lwLJaEVVUPbxavPY6gDC05GbjghkwM+lFGYTNn3dMB0MkNFoCiz
	x6D71zGsRLMJup99qoVxU4mP1BlV+HoPtou/hESQkEQXm+qV8RAyPoupUs5FmSBC
	TLqTUHJcYbYmHUCdRI1VH+gTtth4VMz5IKF5KZRXpA58uLDzgTHK5xZjCwGMsPX9
	HFTkXNOY6567bf4UoWkCDQDHYxFi1Fb4V5x4RfUtDv0VnJoB84j370VwBXvf024a
	E+Z7g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkfaak5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 18:43:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45LIZGKQ039419;
	Fri, 21 Jun 2024 18:43:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn4pp1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 18:43:27 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45LIhFXA032040;
	Fri, 21 Jun 2024 18:43:26 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-63-48.vpn.oracle.com [10.175.63.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yvrn4pnuj-5;
	Fri, 21 Jun 2024 18:43:26 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 04/10] iommufd/selftest: Do not record head iova to better match iommu drivers
Date: Fri, 21 Jun 2024 19:42:48 +0100
Message-Id: <20240621184254.45477-5-joao.m.martins@oracle.com>
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
 phishscore=0 spamscore=0 mlxlogscore=564 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210136
X-Proofpoint-ORIG-GUID: CCmldlCDgY9XRUnvZ4vz0AsnCcuE1Cf9
X-Proofpoint-GUID: CCmldlCDgY9XRUnvZ4vz0AsnCcuE1Cf9

Do not se a hugepage-aligned IOVA for incrementing an IOVA, to better match
current IOMMU driver implementations. Keep it for IOPTEs where it clears
all dirty bits for a hugepage even if it is starting from a partial range.
This is also similar to AMD driver (iommu v1 format) where IOMMU uses
various subpage PTE data for dirty tracking (for non-standard page sizes).

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 drivers/iommu/iommufd/selftest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index fea60db05c9f..612d6c66813c 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -266,8 +266,8 @@ static int mock_domain_read_and_clear_dirty(struct iommu_domain *domain,
 
 		/* Clear dirty */
 		if (mock_test_and_clear_dirty(mock, head, pgsize, flags))
-			iommu_dirty_bitmap_record(dirty, head, pgsize);
-		iova = head + pgsize;
+			iommu_dirty_bitmap_record(dirty, iova, pgsize);
+		iova += pgsize;
 	} while (iova < end);
 
 	return 0;
-- 
2.17.2

