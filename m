Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DF913E8B9
	for <iommu@lists.linux.dev>; Thu, 27 Jun 2024 11:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719486099; cv=none; b=PQGl1CgyGCaHs+Hr/tfSPEGS/j7a1zTCNWa+ffWKaH5RrMEJ42vBPQMLNbqaQ2BYFf75ReI4JU5Mp380f1ck3uleJ6k+hXZfD4ViCrTFkcl7HcMhC3O6MBlyT+Uaps/wPgl2QH+W5QIDNhsET6F+EBfjJItMr4vxCzyqM2usHAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719486099; c=relaxed/simple;
	bh=cBXYleM1KU3H19uKzrkB5LPB74Id09MogENI/y0IAzM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BJPX6zUIV+6kUhzx7cv+vuNW7J7TtFttlcprNgOCrCWFeLi4VYWbJYvJc2HrxPPTqPj3OHMTqJj1ZnPLqFvjazt0c5sJOfohbMNqeFtTfyGdageVnDAHTfRNaNTsdFiHSmr/nEDpjDRHOyxWGwAZJzFlFXLGxEe74AQMEsSY0q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F1qjyZJf; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F1qjyZJf"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7tWbG006744;
	Thu, 27 Jun 2024 11:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=o
	+TYdbQi7NYaihdRnuV7Az0KDbQd8zVkpKt+6i5LhjE=; b=F1qjyZJfp4X3LHftR
	KbWsgiuspvCujtyIq3N7qC74bBXK0PrvG14+6GWEG/KyZ9uGryyIajdQTuCIsbpl
	5OAzTQDonSyXCqyYBM1yCuRkllK7lL4TFL28mHbbImnW0vtf7hE23XmVFFyfefZ+
	6if7DU8mQAWuWhkSBPquHk3JAFZOTFzW58XlX+a/x87gxjFoAr6+MB54bM9vSplK
	m9dNmVtiqCTKDbcKC6vjKfL9V71lwDw9l0SYgEYd8t9IXCNlUbwcQpI+FtUN3SK5
	ClAbSQljgl6s4eB6XKxXVEFHdP5nnhdyFGw2uPaHNYevBFhNY92WXDiepEJNu3r4
	t4ZZQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhb5t07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45R97vHE023318;
	Thu, 27 Jun 2024 11:01:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2grvd2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 11:01:30 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45RB1KN9025281;
	Thu, 27 Jun 2024 11:01:30 GMT
Received: from joaomart-mac.nl.oracle.com (dhcp-10-175-7-218.vpn.oracle.com [10.175.7.218])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2grv3s-5;
	Thu, 27 Jun 2024 11:01:29 +0000
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
Subject: [PATCH v2 04/11] iommufd/selftest: Fix tests to use MOCK_PAGE_SIZE based buffer sizes
Date: Thu, 27 Jun 2024 12:00:58 +0100
Message-Id: <20240627110105.62325-5-joao.m.martins@oracle.com>
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
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270083
X-Proofpoint-GUID: wlniAaZKZw62A6O8LS1lVguY1jIxybZY
X-Proofpoint-ORIG-GUID: wlniAaZKZw62A6O8LS1lVguY1jIxybZY

commit a9af47e382a4 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")
added tests covering edge cases in the boundaries of iova bitmap. Although
it used buffer sizes thinking in PAGE_SIZE (4K) as opposed to the
MOCK_PAGE_SIZE (2K) that is used in iommufd mock selftests. This meant that
isn't correctly exercising everything specifically the u32 and 4K bitmap
test cases. Fix selftests buffer sizes to be based on mock page size.

Reported-by: Kevin Tian <kevin.tian@intel.com>
Closes: https://lore.kernel.org/linux-iommu/96efb6cf-a41c-420f-9673-2f0b682cac8c@oracle.com/
Fixes: a9af47e382a4 ("iommufd/selftest: Test IOMMU_HWPT_GET_DIRTY_BITMAP")
Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
---
 tools/testing/selftests/iommu/iommufd.c | 36 ++++++++++++-------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 61189215e1ab..5f7d5a5ba89b 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1797,47 +1797,47 @@ FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty16k)
 	.buffer_size = 16UL * 1024UL,
 };
 
-FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty128k)
+FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty64k)
 {
 	/* one u32 index bitmap */
-	.buffer_size = 128UL * 1024UL,
+	.buffer_size = 64UL * 1024UL,
 };
 
-FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty256k)
+FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty128k)
 {
 	/* one u64 index bitmap */
-	.buffer_size = 256UL * 1024UL,
+	.buffer_size = 128UL * 1024UL,
 };
 
-FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty640k)
+FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty320k)
 {
 	/* two u64 index and trailing end bitmap */
-	.buffer_size = 640UL * 1024UL,
+	.buffer_size = 320UL * 1024UL,
 };
 
-FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty128M)
+FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty64M)
 {
-	/* 4K bitmap (128M IOVA range) */
-	.buffer_size = 128UL * 1024UL * 1024UL,
+	/* 4K bitmap (64M IOVA range) */
+	.buffer_size = 64UL * 1024UL * 1024UL,
 };
 
-FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty128M_huge)
+FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty64M_huge)
 {
-	/* 4K bitmap (128M IOVA range) */
-	.buffer_size = 128UL * 1024UL * 1024UL,
+	/* 4K bitmap (64M IOVA range) */
+	.buffer_size = 64UL * 1024UL * 1024UL,
 	.hugepages = true,
 };
 
-FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty256M)
+FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty128M)
 {
-	/* 8K bitmap (256M IOVA range) */
-	.buffer_size = 256UL * 1024UL * 1024UL,
+	/* 8K bitmap (128M IOVA range) */
+	.buffer_size = 128UL * 1024UL * 1024UL,
 };
 
-FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty256M_huge)
+FIXTURE_VARIANT_ADD(iommufd_dirty_tracking, domain_dirty128M_huge)
 {
-	/* 8K bitmap (256M IOVA range) */
-	.buffer_size = 256UL * 1024UL * 1024UL,
+	/* 8K bitmap (128M IOVA range) */
+	.buffer_size = 128UL * 1024UL * 1024UL,
 	.hugepages = true,
 };
 
-- 
2.17.2

