Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7189E45C06
	for <iommu@lists.linux.dev>; Fri,  2 Feb 2024 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880907; cv=none; b=Yzipo+3GIs4LjLyeqTBA4aYk2LYns3XHi9MT1Zccu4hzw8w7plpb+BAxGf5JrG7SQxOv8Vx9OKqOTdLU8TDqYpBrU7E+HJwpnRoIJyWv7oKMC7ycF5jjCcYhGqAIDHNmkJlyjVctZUon2k7rAXfP4HxBLzRYW/288rlG0lECjPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880907; c=relaxed/simple;
	bh=smIL+CTMz0c5Q9UvEZmjvwQdznEjqUCzJr37nig6cbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RLk9EbkIfW8G52Zjblxyv7/p4Glc6svR4ig9M/MPbT4cHGr+25shxXx2xhaEo7A16vax9rLNym3qfhamX2SG1y89YOezn3nJ+86RcyTm+8+qWkMl5kEnf5k+arOwlAa3jWj4vOY70i+sXvZm6oof5EMxB4UhrVbamtVso6Oj+N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N3yCk7eM; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N3yCk7eM"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 412DQniP019833;
	Fri, 2 Feb 2024 13:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=jGfkiDT18ffzTMoqM6DhOaDwS4B9Nr5XqZ8Z7oBFfq8=;
 b=N3yCk7eMYjwxXpSldln+6DJ49aPZB7z63xFCuJY9Q0kgM2qyYA9WULUFBRc1u2C7ALu/
 HcEx7FZqXJU+txUoaBqmF3O+c4Q2G8nH8fmrI7C8snQsLxaSBKJyB7kHss/16DxOrh/k
 aEwZzg94LzWJnhyKfQkU57eKEZk1l/wqqyCxXDg7nXQ42w5ljDUmrgSDWRqK7wNRq5I+
 DyWS5l8aFAYtRpUPniupwOqu1fpOOIEzc0V2Z9CYf7nPp13fRXnYQG/UakItxyrRI20X
 3DsvlTMGGGeivG7cBBNfIaqKvD4yKFICZJ1+zXLuAYQkroGBc+mmN7ybrZAv0GAmakPf lQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvre2qs2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 13:34:54 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 412BT9SD024587;
	Fri, 2 Feb 2024 13:34:53 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9buey2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Feb 2024 13:34:53 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 412DWmAf022185;
	Fri, 2 Feb 2024 13:34:53 GMT
Received: from joaomart-mac.uk.oracle.com (dhcp-10-175-220-219.vpn.oracle.com [10.175.220.219])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3vvr9buewt-1;
	Fri, 02 Feb 2024 13:34:52 +0000
From: Joao Martins <joao.m.martins@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v1 0/9] iommufd/iova_bitmap: Bug fixes for IOMMU dirty tracking
Date: Fri,  2 Feb 2024 13:34:06 +0000
Message-Id: <20240202133415.23819-1-joao.m.martins@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_07,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=273 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402020099
X-Proofpoint-GUID: hGC2J95L9AFTE_ORUQoEmIATezv2Q-CZ
X-Proofpoint-ORIG-GUID: hGC2J95L9AFTE_ORUQoEmIATezv2Q-CZ

Hey,

This relatively small series fixes a couple of bugs while extending the
selftests to test it all and one small improvement for in iova bitmap
number of iterations.

The main bug is that we miss marking part of the required dirty bits in
the migration stream when we record hugepage PTE dirty pages on a lower
page size bitmap. This is due to how we iterate IOVA bitmap ranges (see
patch 4) and that the end of the range might not be aligned to the huge
page size. As I tried to find a reproducer[0] (which were very hard in
my setup) fixed up other things around it related to the same subject.

I have a separate set of changes, that proved also instrumental in
reproducing some of these corner cases in a more predictable manner but
with IOMMU drivers instead, rather than IOMMUFD mock IOMMU driver...
without relying on VF specific behaviour. Though, it relies on being
able to map IOVAs as dirty. This is not included in this series, as I
am not sure yet if such direction would make sense (outside of testing).
Comments, appreciated.

The selftests in this series (a large majority of the series changes)
are meant to be kept in this order to be more clear in history that the
selftests exercise a given fix added earlier in the series.
The last patch is an efficiency improvement, but can act as workaround if
the IOVA ranges are smaller than 64G, which is why it is placed last.

[I think this should be targetted for -rc rather than -next]

Regards,
	Joao

[0] Using latest qemu draft here: https://github.com/jpemartins/qemu/commits/iommufd-v4

Joao Martins (9):
  iommufd/iova_bitmap: Bounds check mapped::pages access
  iommufd/iova_bitmap: Switch iova_bitmap::bitmap to an u8 array
  iommufd/selftest: Test u64 unaligned bitmaps
  iommufd/iova_bitmap: Handle recording beyond the mapped pages
  iommufd/selftest: Refactor dirty bitmap tests
  iommufd/selftest: Refactor mock_domain_read_and_clear_dirty()
  iommufd/selftest: Hugepage mock domain support
  iommufd/selftest: Add mock IO hugepages tests
  iommufd/iova_bitmap: Consider page offset for the pages to be pinned

 drivers/iommu/iommufd/iommufd_test.h          |  1 +
 drivers/iommu/iommufd/iova_bitmap.c           | 68 +++++++++++++---
 drivers/iommu/iommufd/selftest.c              | 79 ++++++++++++++-----
 tools/testing/selftests/iommu/iommufd.c       | 78 ++++++++++++++----
 tools/testing/selftests/iommu/iommufd_utils.h | 39 +++++----
 5 files changed, 205 insertions(+), 60 deletions(-)

-- 
2.17.2

