Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6601213F42E
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486106; cv=none; b=dhNppArwfOtlHvQPy4dst9Sms6K3lN+yxq7S9x++eSmP2uqRo+yANklAtUdjsIkqwRu8ouKWHviRI3n/82mUNx+pGx15xoecXgsqH3fvCiSBi2oIol+uONxfpFwYY9pxXo7vyiI9SvgnfNuoKdb6zWkYR3W8eI66U8W3YiALSqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486106; c=relaxed/simple;
	bh=IcmsFc9b/RwZbSR8HQp7D2HkYeceZR21MCtvMz78j3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YY2/u8qNN6iLdJHak3HpDC7NuLeI8HdFt+g7PUymDZNZ0uDfFv469aShZCmrvlVQyElHlTUz3aDSXWC9JGjnCbXBlFFT7gvwmYUARBDrwwQHwzdApxA0YdfyTVbUmNKp/yaBbJzTbzOgtpTWISM5eK0NotGHo97T82g2QgNZ7N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dazerd70; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dazerd70"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7tTCO029115;
	Thu, 27 Jun 2024 11:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=9
	7d+L5sRyK3XBZ/NNn5Lyykd7AnPh7BpF89sHFkq+LA=; b=Dazerd70j3YEo/LRA
	V3lP2TzNItSPl9DRuHZ/u0ViPohVf7EGNA4GXtu/RZ2DSRJlk6y26tCRQnnNQHQc
	pymidcY/5L8esJ6J3b3klvINMo/iDNJHXzX7YNhc1SIzTeXGpM5ugoa+kvI8c5JB
	IeqPBTmRPaz8brvE0JdxvArIBQPFUKQ5vjYNnJ9xvYx8ZbFYC+og5CTpRrJAtdjE
	CQG06AGVWryYb7QXqqitqdin21oXhKKbpBRUTLAEZsdabEs8M9xe3ZQforN39SWr
	5BDzxvzUNPUxoIZlNE7h/iJBNJNgEQ/l2mjj3oaceIbQKrMynaOHGUzmwYpDwdTg
	aHQSA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 400ttn9bmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RAX1BM023305;
	Thu, 27 Jun 2024 11:01:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2grve5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:33 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45RB1KNB025281;
	Thu, 27 Jun 2024 11:01:32 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-7-218.vpn.oracle.com [10.175.7.218])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2grv3s-6;
	Thu, 27 Jun 2024 11:01:32 +0000
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
Subject: [PATCH v2 05/11] iommufd/selftest: Do not record head iova to better match iommu drivers
Date: Thu, 27 Jun 2024 12:00:59 +0100
Message-Id: <20240627110105.62325-6-joao.m.martins@oracle.com>
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
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=582
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270083
X-Proofpoint-GUID: 0Rw3HkGvpLbv5OPPYzCQnuC6wmursEdh
X-Proofpoint-ORIG-GUID: 0Rw3HkGvpLbv5OPPYzCQnuC6wmursEdh

Do not set a hugepage-aligned IOVA for incrementing an IOVA, to better
match current IOMMU driver implementations. Keep the logic of clearing all
IOPTE dirty bits for a whole hugepage, even if the range being dirtied
starts from part of the hugepage. This is also similar to AMD driver (iommu
v1 format) where IOMMU uses various subpage PTE data for dirty tracking
(for non-standard page sizes).

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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

