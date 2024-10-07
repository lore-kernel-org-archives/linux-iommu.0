Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC091DCB25
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321210; cv=none; b=tuLL15vRldI3x0xabsFr0q/9BlnhiAriPybx2/lD2nqU31SAeurxctGAvRW+NcfWwI46ItzxlBb/jBvlsaS0Ch3AqLo6dkD4eReyq2tGiYcxOWo86qpz55UhGtYcwCcqODAPiucADV3NrjicJi4Sq0Z8zhhNgKUFKPVm2ENuwa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321210; c=relaxed/simple;
	bh=efAoVrnUoJamNTcyR3us8qmKDy16x/WXVp+l1d0heWM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=bHyHmnkG5M+oRjrjV7mRNUSU+xzPEstgsJ1cpBBw+p7L0z30rW7V3SSXji16PH9+dPJ1ePRDV4WupTrbKBSyCLcUhrpuaiHBLhpbyokNO3rCjX5/rf91s+JbCWF6okDhY7XvOY1PILElpW3E7Dl2mcEMzjetHpRPK+oPwojTNZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C33TmyFU; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C33TmyFU"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMdbK005114;
	Mon, 7 Oct 2024 17:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2023-11-20; bh=6VCHBO1t
	CnWYSra+d6imYSkIIO8TXHkCZoBtUu7kWjM=; b=C33TmyFUI9zaxsEMf/Q0I69f
	Xc25by6cAfLiwCskT+0mR+HQJU/00YXcHCNo+f3PFiA1O4/QkFze4CeqoA3Ozz9O
	hH0Z5TEPT8nqKTYDOFLWGC6Wc9SYY9HoQbfApM6Ou9DyRzNLoLaHVHC2KoqyPr3v
	WKohsshvxAJQnnupfwgzG+CT1YXyvpBL4XcrvdmKQoYc4A8CIXgiBpFtYvNd+OBn
	mHJXRczBJAnDYWsXKENNIGP/mY5ioJYixDLBRELaT4jsqBSQK3c9EZSz1BIcfS66
	nvYmbGYNcOvj4BAhKHklbhpXFoSePtBVQyvzibv62j3knez4U4yLH7l8aONZGg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42300duyqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 17:13:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497GqGcs004602;
	Mon, 7 Oct 2024 17:13:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uw63f1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 17:13:25 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 497HAoJ2003812;
	Mon, 7 Oct 2024 17:13:25 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 422uw63f0s-1;
	Mon, 07 Oct 2024 17:13:25 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 0/4] iommufd live update
Date: Mon,  7 Oct 2024 10:13:19 -0700
Message-Id: <1728321203-189608-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_10,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=1 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070121
X-Proofpoint-GUID: -f5g05VnVYCj74v1w_L3otCo-R3vanYd
X-Proofpoint-ORIG-GUID: -f5g05VnVYCj74v1w_L3otCo-R3vanYd
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

Steve Sistare (4):
  iommufd: Export do_update_pinned
  iommufd: Lock all objects
  iommufd: Add IOMMU_IOAS_CHANGE_PROCESS
  iommufd: IOMMU_IOAS_CHANGE_PROCESS selftest

 drivers/iommu/iommufd/io_pagetable.h          |   6 +
 drivers/iommu/iommufd/ioas.c                  | 207 ++++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h       |   2 +
 drivers/iommu/iommufd/main.c                  |   3 +
 drivers/iommu/iommufd/pages.c                 |  10 +-
 include/uapi/linux/iommufd.h                  |  23 +++
 tools/testing/selftests/iommu/Makefile        |   1 +
 tools/testing/selftests/iommu/iommufd.c       | 148 +++++++++++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h |  34 +++--
 9 files changed, 409 insertions(+), 25 deletions(-)

-- 
1.8.3.1

