Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CF81EF929
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728067708; cv=none; b=AIrdqQFqnnVcSANA5m1YOwMpFFEZYm0EkMu8a47XoED62h2hOiSsGKHYe99iVUOrbyp7Xq3AjFRsj+q5xZ3hrxdjgmaBxMKGrBE+jE0gHfV6W0sKfG+ZAvZnbaNLtlIZdPD1DJMq+IrkIXayZU9IIdhdi6Z1Zsf57gighi8NTzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728067708; c=relaxed/simple;
	bh=c5BWIb68x5bKtO8AzEF90ulinx1i5CzPgeSCAqRqSbs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GZnNow+M2DslSPa7GzJAifT81B80ubMmDkNawwmZJJOy7OVTNBSTWAFY84QGiY4qVpno9oYp1LkPrtbdBKOLk4CjhvL3qyDhMWBxelXuc1k+j0PEpjxnlzf5MlnQ7GtQGSWWO1ZjWtpSDHbsh92Y/1oiLX7yOBtqvsMo1IQi6Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hy38Ss0v; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hy38Ss0v"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494HfekS013304;
	Fri, 4 Oct 2024 18:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id; s=corp-2023-11-20; bh=uGZ0+A
	qiNTcYbU3x6fiSWxPaWBUNrcHaQmhJZsTpCcI=; b=Hy38Ss0vO05hGY19hLV5L3
	UpEZgruHb0l5ejnuXQ4WQyXEaK8cEJ1OcysEra2z4f/B8EkzTTj5ov29eH3ooZhC
	udEFIHzYW3mY3jW3CUsp/kO2pO+MvAHCZILO/V8+yrM7lmHiChI7W7xYk01WEYiA
	jE3Aq7ON8/nchzOngJHzJby+1i6Gpjk45UVFMfi+4mwH75698uGN1LzN8n9sVsV1
	A60aLPB0SxiPnBZQ/N2MkAGbAUuqXl33QijPlU1Dj+oGOtnRe++sWBRjqrXhbpgu
	mSf7pJ/W2vQFSwZiSSXYEBb4VEsg/rC541DxcSP5LD7OuBkUN0EBzAVxIJ62R30A
	==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204gt7gh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 18:48:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494GXfmc037991;
	Fri, 4 Oct 2024 18:48:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422057p5t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 18:48:21 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 494ImLZu029789;
	Fri, 4 Oct 2024 18:48:21 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 422057p5sn-1;
	Fri, 04 Oct 2024 18:48:21 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 0/9] iommu_ioas_map_file
Date: Fri,  4 Oct 2024 11:48:11 -0700
Message-Id: <1728067700-32092-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_16,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040129
X-Proofpoint-GUID: ciKXXdwFWX9p74TN3BR5fuv2zkSI0VLT
X-Proofpoint-ORIG-GUID: ciKXXdwFWX9p74TN3BR5fuv2zkSI0VLT
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

Steve Sistare (9):
  mm/gup: folio_add_pins
  iommufd: rename uptr in iopt_alloc_iova
  iommufd: generalize iopt_pages address
  iommufd: pfn reader for file mappings
  iommufd: IOMMU_IOAS_MAP_FILE
  iommufd: file mappings for mdev
  iommufd: pfn reader local variables
  iommufd: optimize file mapping
  iommufd: map file selftest

 drivers/iommu/iommufd/io_pagetable.c          | 118 +++++++---
 drivers/iommu/iommufd/io_pagetable.h          |  20 +-
 drivers/iommu/iommufd/ioas.c                  |  43 ++++
 drivers/iommu/iommufd/iommufd_private.h       |   5 +
 drivers/iommu/iommufd/main.c                  |   2 +
 drivers/iommu/iommufd/pages.c                 | 320 +++++++++++++++++++++-----
 include/linux/mm.h                            |   1 +
 include/uapi/linux/iommufd.h                  |  25 ++
 mm/gup.c                                      |  24 ++
 tools/testing/selftests/iommu/iommufd.c       | 151 ++++++++++--
 tools/testing/selftests/iommu/iommufd_utils.h |  41 ++++
 11 files changed, 644 insertions(+), 106 deletions(-)

-- 
1.8.3.1

