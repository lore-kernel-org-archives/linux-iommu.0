Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241B1632D6
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861926; cv=none; b=iEcbLQjI6PbXqnMPHNCxpYNnf5C59X8ZYsLfeOnB/uyan85EiOohjb7uErsrOSo+YXt25VUpfNEPTXPmHB80ilo+URYeoTCTN4ASZ/2z+c88zg7z32DBbn6BOFtG3mczn0sr15uZfbU3wp/mtHApRaJMk8Jdzj/d8qQjh4YRe+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861926; c=relaxed/simple;
	bh=EhqbLpz6NlPg8YpymEqiNYsYqd0bQF4SNAj1eJFUl2U=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LxuY3ickWlwQM4rXqiQg6gcRV8nwenw78EDtwNArNc3wIlWcYs/SMdR21tziT7pUE9XnwmmmsRrUp6RdttT+xBmaygxzzjPs9chw6tX6jPqMePg8qJf7TWd14Mdwh4+sOGf7+ayklUhK/kInUt/Ved/KO9kimYhoXciD7qcCOBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HkJNEIYt; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HkJNEIYt"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PCU7og000335;
	Fri, 25 Oct 2024 13:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2023-11-20; bh=uvTj2Aim
	8iN4U2VE7t5Kn4TnudAS4YKRAM1a0giIys4=; b=HkJNEIYt8CxcGFc64w2ir50a
	OlnJpZ0cXVTHdFXqOMhglVyD4EF4yM3T7KdgezgBlaC5YWOxPhPGPGFLsGLCuaIl
	uZ97/TggAysaAJD9TnSIb8cfU7xg83rbE3cdPt9wY5pLIudAU9KwAviWRPxexG77
	ugaWCug90q1rAEaQUT8KF4pLeIuFKjnAkOs6FW0nFOQbpLeoJ0Dh4aLbkEwVNeqe
	DhxA49Rh1E78MVPKrsBX7acczbogWh40nrBJHViBQweEQ/rvrKJ8OZXthPxjwbr0
	h4Y5YNNnr3t6uZncI9YgCb1QqLpvdShCp+p1ZABd+ONJPANwJxR5ptPzu24TQA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53uvwsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:12:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBxoj8016432;
	Fri, 25 Oct 2024 13:12:01 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhdug02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:12:01 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49PDC0Rc000657;
	Fri, 25 Oct 2024 13:12:00 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42emhdufy3-1;
	Fri, 25 Oct 2024 13:12:00 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V7 0/9] iommu_ioas_map_file
Date: Fri, 25 Oct 2024 06:11:50 -0700
Message-Id: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_12,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250102
X-Proofpoint-GUID: AuGI1GHjTbyKg2vlHcANcpQu6-RrN30X
X-Proofpoint-ORIG-GUID: AuGI1GHjTbyKg2vlHcANcpQu6-RrN30X
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

Changes in V6:
  * added argument checks in iommufd_ioas_map_file
  * misc minor and cosmetic changes

Changes in V7:
  * fixed compilation of selftest

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
 drivers/iommu/iommufd/ioas.c                     |  47 ++++
 drivers/iommu/iommufd/iommufd_private.h          |   5 +
 drivers/iommu/iommufd/main.c                     |   2 +
 drivers/iommu/iommufd/pages.c                    | 307 +++++++++++++++++++----
 include/linux/mm.h                               |   1 +
 include/uapi/linux/iommufd.h                     |  25 ++
 mm/gup.c                                         |  24 ++
 tools/testing/selftests/iommu/iommufd.c          | 124 +++++++--
 tools/testing/selftests/iommu/iommufd_fail_nth.c |  39 +++
 tools/testing/selftests/iommu/iommufd_utils.h    |  57 +++++
 12 files changed, 660 insertions(+), 108 deletions(-)

base-commit: e2d8fe9148b79ed1cbf0663edc988db7769173dc

-- 
1.8.3.1

