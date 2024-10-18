Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69E218CBED
	for <iommu@lists.linux.dev>; Fri, 18 Oct 2024 21:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729286863; cv=none; b=COqM6nennS7LFC6UldgKg4UxTolGNGu6RPcVa7anXzcRdoTzn+33BmnAe3T+t44syj9Hkc3zlQid9yiL3A8PKUliqWaZvQceoj7tMOk8lG84HGkg71NnqdiDvxnER9Z/ohhtMg6pn62zT5zKNSQArj04Xf+ttnLGx1Os2beNB0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729286863; c=relaxed/simple;
	bh=pHTJopqjeeNaPIXVRmGjoedR+1E8S87Un9OOmT/IYZg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qG04gS7nUaUHpEY8SQ02unvPo6ZcFQWlgr5fJ8YNUWKJhdY+I2y5K9rorLfdJbL/M09jHKa7EKKZAAwaYbLbaqm7qeIEuBV6Q8E8oM4UrYC6T1QyaVoXhOA6x1bZq61QNSDmHWx9S1O2FSNgmN1HsCmaBT1ia6Z9lZTnY8x962I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cFWJDsiL; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cFWJDsiL"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IKBgih014721;
	Fri, 18 Oct 2024 21:27:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2023-11-20; bh=3S4twhli
	ktMFeuTSogt+324Xks0X4PSAJOIaAKOJwRs=; b=cFWJDsiLKXoZEeXsxuhZfnrT
	1NKcWb/Judx3OfXY0pBq97t1y4rM4sJQvoavp9J/XdLBAnLESHt60fpElvmu8cTQ
	+GAr2p5bmKIW3QLcunOaGCcoCCPldTekksWLVIkMdHmXn+OWaonwEsPKgXMvEifb
	oLZ4KSjg4svYbOkvcXsGDDg4pOh3LPR4Ek3D3+2TzkR7C6KHPqpuEaz6x30xtBgM
	+r67nCVQDAVIdkIgjq2TkTOf29NflN7ewi4LUCdzhga46SZsAaKdoyT5og/bXk9Q
	heTdP12G/pCkg25Gj6o/zJgOhF8wMXpszey5vyncU177dYU+yMu0O8I0/uAodQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427g1ashxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 21:27:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IKQAKM027278;
	Fri, 18 Oct 2024 21:27:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjjq9rg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 21:27:38 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49ILRcVZ023093;
	Fri, 18 Oct 2024 21:27:38 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 427fjjq9r5-1;
	Fri, 18 Oct 2024 21:27:38 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 0/9] iommu_ioas_map_file
Date: Fri, 18 Oct 2024 14:27:27 -0700
Message-Id: <1729286856-127844-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_16,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180137
X-Proofpoint-GUID: MPJjD4W4tNa6gKtPvq4-ItDa3NLMqJq8
X-Proofpoint-ORIG-GUID: MPJjD4W4tNa6gKtPvq4-ItDa3NLMqJq8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Provide the IOMMU_IOAS_MAP_FILE ioctl, which allows a user to register
memory by passing a memfd plus offset and length.  Implement it using
the memfd_map_folios KAPI, and the proposed folio_add_pins KAPI.
See the individual patches for details.

Changes in V2:
 * changed names and commit message in "rename uptr in iopt_alloc_iova"
 * normalized comments describing the iopt_map_user_pages interface
 * submitted folio_split_user_page_pin (fka folio_repin_unhugely) separately
 * replaced nupages[] optimization with folio-to-batch optimization
 * added selftests for map file

Changes in V3:
  * fixed bug setting user->locked
  * fixed bug in pages->file refs
  * replaced lockdep_off with down_write_nest_lock
  * added ufolios_next to track folio consumption in reader
  * combined IOMMU_IOAS_MAP_FILE interface and implementation
  * added patch folio_add_pins (fka folio_split_user_page_pin )
  * reformatted patches using clang-format
  * misc cosmetic changes in response to review comments

Changes in V4:
  * deleted ufolios_huge optimization
  * optimized batch_from_folios
  * squashed "optimize file mapping" into "pfn reader for file mappings"
  * moved length overflow check to iopt_alloc_file_pages
  * one declaration per line, and use local scope declarations
  * rebased to iommufd git tree

Steve Sistare (9):
  mm/gup: folio_add_pins
  iommufd: rename uptr in iopt_alloc_iova
  iommufd: generalize iopt_pages address
  iommufd: pfn reader local variables
  iommufd: folio subroutines
  iommufd: pfn reader for file mappings
  iommufd: IOMMU_IOAS_MAP_FILE
  iommufd: file mappings for mdev
  iommufd: map file selftest

 drivers/iommu/iommufd/io_pagetable.c          | 117 +++++++---
 drivers/iommu/iommufd/io_pagetable.h          |  20 +-
 drivers/iommu/iommufd/ioas.c                  |  38 ++++
 drivers/iommu/iommufd/iommufd_private.h       |   5 +
 drivers/iommu/iommufd/main.c                  |   2 +
 drivers/iommu/iommufd/pages.c                 | 306 +++++++++++++++++++++-----
 include/linux/mm.h                            |   1 +
 include/uapi/linux/iommufd.h                  |  25 +++
 mm/gup.c                                      |  24 ++
 tools/testing/selftests/iommu/iommufd.c       | 151 +++++++++++--
 tools/testing/selftests/iommu/iommufd_utils.h |  41 ++++
 11 files changed, 625 insertions(+), 105 deletions(-)

base-commit: e2d8fe9148b79ed1cbf0663edc988db7769173dc

-- 
1.8.3.1

