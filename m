Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2A85FDA7
	for <iommu@lists.linux.dev>; Wed, 13 Nov 2024 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731527505; cv=none; b=pk4dHr15vf5kbIa5gCXfbOvfIjNsM6I6J3H2wmAx1UsJmhcabZzqifZH2NPqS6C89Vrdby9wWg17AYueqPP2wqG5/ygDD9pIYNfraOAxkuDqjjVk5CtJhFk2mACv0nDeTcRMtql1TwQFnWAVV1B3BZ0rjLOExjX5yoDksFe+DqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731527505; c=relaxed/simple;
	bh=QHamFQSIeFzdJint89DHowzPOZPfMd7eEjOFhNIAnEY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=m6yA8bCl6DUdV+kcljr0iwyTJsbKkr+W8LvZ78uEsIr1kIFBB1TkzxVTfVVUAebuEQ9kmoWFdYe0w+nXZvEYbd7HKdyyL1WxyeiBc5xUucWQSSQURC0SZTyHXTJHstz/M2gO25DD6krS+MsVW4+NC5sR7yr2UU/BFYh9fZgAgYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IFSnpKW+; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IFSnpKW+"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADIBXvq001195;
	Wed, 13 Nov 2024 19:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2023-11-20; bh=sDhio54a
	csCgP9WiK5yckn/rJwGNJ12Tqg2pHneNnuk=; b=IFSnpKW+ebg+W0v0PTNxOVNK
	oqG8sOGBRKoYCD9AiYXFnmURfjh6sou21qg4XVRxrOOMI7fEosU7Zcgcl3w8Fx7M
	O421KKVC7af355H13oTDvpMQPTJZTcMYPsg3qf7zioFyaFWQUqHPZALOQtVMAxrC
	ulRDVf3Tzg23D/Tqod6WDuSRpbptB0psRHzZsZ6zCpPLVrzc991sQ0jkq4yXmrk3
	AZxPdRYsGc1TCbKiikuLqqb79nrZt7D5K1h/j02lfzBTrNLAvYC3hdGvJUCV77Dy
	xP8g4MVkkpXm6/NRhwbR8NIcgQhdkrUDtVNW/KQxH8wydS7+uynfBtRubP+scg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0heqkr7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 19:51:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADIWh8E001217;
	Wed, 13 Nov 2024 19:51:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6a4b5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 19:51:39 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4ADJpdsh023287;
	Wed, 13 Nov 2024 19:51:39 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42sx6a4b5c-1;
	Wed, 13 Nov 2024 19:51:38 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V5 0/4] iommufd live update
Date: Wed, 13 Nov 2024 11:51:33 -0800
Message-Id: <1731527497-16091-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_12,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130163
X-Proofpoint-ORIG-GUID: OtNguRK9D7FpMkYhmAWktvtW4Z80ejnE
X-Proofpoint-GUID: OtNguRK9D7FpMkYhmAWktvtW4Z80ejnE
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Live update is a technique wherein an application saves its state, launches
an updated version of itself, and restores its state.  Clients of the
application experience a brief suspension of service, on the order of
100's of milliseconds, but are otherwise unaffected.

Define the IOMMU_IOAS_CHANGE_PROCESS ioctl to allow management and use
of an iommufd device to be transferred from one process to another.  The
application is responsible for transferring the device descriptor to the new
process, eg either by preservation across fork and exec or via SCM_RIGHTS.
It atomically updates everything to the current process, grabbing the new mm,
and transferring pinned page counts.

IOMMU_IOAS_CHANGE_PROCESS only supports DMA mappings created with
IOMMU_IOAS_MAP_FILE, because the kernel metadata for such mappings does not
depend on the userland VA of the pages (which is different in the new process).
IOMMU_IOAS_CHANGE_PROCESS fails if other types of mappings are present.

Thanks to Jason Gunthorpe for code and ideas in this series.

This series depends on the series:
  [PATCH V3] iommu_ioas_map_file

This is implemented in QEMU by the series:
   [PATCH] Live update: iommufd (V2 to be posted)

Changes in V2:
  * deleted interface to update VA
  * add selftest cases

Changes in V3:
  * replaced lockdep_off with down_write_nest_lock
  * cosmetic changes as requested
  * check for zero length in iommufd_ioas_map_file

Changes in V4:
  * added TEST_LENGTH for iommu_ioas_change_process
  * fixed context vs patch "Selftest coverage for IOMMU_IOAS_MAP_FILE"
  * changed IOMMUFD_CMD_IOAS_CHANGE_PROCESS to 0x92
  * added RB's

Changes in V5:
  * renamed iopt_update_pinned -> iopt_pages_update_pinned
  * reworded lock all *IOAS* objects
  * added WARN for iopt_pages_update_pinned failure
  * added RB's

Steve Sistare (4):
  iommufd: Export do_update_pinned
  iommufd: Lock all IOAS objects
  iommufd: Add IOMMU_IOAS_CHANGE_PROCESS
  iommufd: IOMMU_IOAS_CHANGE_PROCESS selftest

 drivers/iommu/iommufd/io_pagetable.h          |   6 +
 drivers/iommu/iommufd/ioas.c                  | 212 ++++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h       |   2 +
 drivers/iommu/iommufd/main.c                  |   3 +
 drivers/iommu/iommufd/pages.c                 |  10 +-
 include/uapi/linux/iommufd.h                  |  23 +++
 tools/testing/selftests/iommu/Makefile        |   1 +
 tools/testing/selftests/iommu/iommufd.c       | 141 +++++++++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h |   6 +
 9 files changed, 399 insertions(+), 5 deletions(-)

-- 
1.8.3.1

