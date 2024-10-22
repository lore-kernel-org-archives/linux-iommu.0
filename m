Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7501F1CB325
	for <iommu@lists.linux.dev>; Tue, 22 Oct 2024 21:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630850; cv=none; b=T1WGQXrGkT6PlnFxSqyTqB2FRcR72dTwwdB4gx8IrZoIPTAMKdfaPwBnLYc6TBjA/sH+3SPUB9a0JAzry8KSix/TbGPcz/HyOtWMGo/SSX0TO1UvtyZEAvosBlU2ZbQbPJfupQVeH6IVt/xU5Y8JmiinJ6fETGQS0ljMsh4gWXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630850; c=relaxed/simple;
	bh=rlNa8MndmU4BU5QTQEsjwPlplDn1GAwoUB3vYoAl0G4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CT8zSzqxPIzHpafI6lq3RIP4llucDctBv70nGf4bBJ/idgKcWM4b67milDxK3crBLl6wj9qIQtaElPy/LH6eHFo0snlmQqLiIjryFtgtyzVyWIpA5uwfAce+X7ShlsJue1HJkhwvObMMv96pt8a88Qoj2ct3d2wXjkNwV3hyx7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o2DKChmi; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o2DKChmi"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MKqU7A028589;
	Tue, 22 Oct 2024 21:00:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2023-11-20; bh=nQJ06VLb
	gh335UV0r3//cS4GY6bo4CMGMWPQNTTMcyU=; b=o2DKChmiOKAKTTyMaKUg2q/y
	2K2Cftju1ZkGll/IMSlhIF+Kww5m0hV6FuZHnUSDP09eexfRgoi6LXLyhB/ELgB5
	3pm2XoT3FkXuNGE9Fl5MPK+udcCbZfD3i3hbuEyltj1bFXx8kNtfpITTKgmL+SoY
	v4YNI+Usd3vL2BGEMXAZIhYgPemr0Qa0I+N/69Ij5oiGkB7tzLF6h2/YQVngDm18
	EJF9BpDW5l3Y4LrmzjXFt9hdWdE3XN+D/Rz8sDBDWovk1poB8Plq11utzxtZTu40
	N76XPlYzGbATy/JLcIkKUAOwOcGAHJFynlVO7x0IkiKavlxEz5QqxxY7LDL8xw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3du6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 21:00:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MJuKOU012295;
	Tue, 22 Oct 2024 21:00:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c3781a9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 21:00:39 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49ML0dEa016716;
	Tue, 22 Oct 2024 21:00:39 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42c3781a7p-1;
	Tue, 22 Oct 2024 21:00:39 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 0/9] iommu_ioas_map_file
Date: Tue, 22 Oct 2024 14:00:29 -0700
Message-Id: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_23,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410220135
X-Proofpoint-ORIG-GUID: aQ4O6NjiigyHaFp3Qz67tmKiDtYE4mu_
X-Proofpoint-GUID: aQ4O6NjiigyHaFp3Qz67tmKiDtYE4mu_
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

Changes in V5:
  * hoisted folio_add_pins call and deleted folios_unpin_partial
  * simplified batch_add_pfn_num and its caller
  * added cmd_length selftest for iommu_ioas_map_file
  * added map_file case for iommufd_fail_nth selftest
  * fixed an unreported mmput bug in pfn_reader_user_destroy that broke mdev

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

 drivers/iommu/iommufd/io_pagetable.c             | 117 ++++++---
 drivers/iommu/iommufd/io_pagetable.h             |  20 +-
 drivers/iommu/iommufd/ioas.c                     |  38 +++
 drivers/iommu/iommufd/iommufd_private.h          |   5 +
 drivers/iommu/iommufd/main.c                     |   2 +
 drivers/iommu/iommufd/pages.c                    | 309 +++++++++++++++++++----
 include/linux/mm.h                               |   1 +
 include/uapi/linux/iommufd.h                     |  25 ++
 mm/gup.c                                         |  24 ++
 tools/testing/selftests/iommu/iommufd.c          | 136 ++++++++--
 tools/testing/selftests/iommu/iommufd_fail_nth.c |  39 +++
 tools/testing/selftests/iommu/iommufd_utils.h    |  57 +++++
 12 files changed, 664 insertions(+), 109 deletions(-)

base-commit: e2d8fe9148b79ed1cbf0663edc988db7769173dc

-- 
1.8.3.1

