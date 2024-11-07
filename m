Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E80217F3D
	for <iommu@lists.linux.dev>; Thu,  7 Nov 2024 21:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016024; cv=none; b=O4BBcUdVRdkT69EydR6TYPRfcj7tLJbYq1xYSnRybdCssU5BfELqTrEV72GDiP30OmTK7eiQUgSfnhTyxO0xRecUfeaeovHYTqU6sRuZohHmRo1tVVJhXipxxJKjOmZEjEat0EkMrKjHmTMJ7en+q4Lm+UQ1u6zkxpDSePXGAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016024; c=relaxed/simple;
	bh=nFSkmi4jNMpNIuvMvSUczV0cwrwde26sjcK9/0BZG6Y=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GEuORcTmzOzImsNibl2FX2Rrg868llOKftibGLluIJwNrbf3RilFBp5RyXV7K0JL4/eCH4dN8aX7qo0rBDXVJWlIAikUGKxEXI7cB1g389ELKx6uEcitEwWCJZ/9EF7H6XeUef7x8+u1Z4h45hkRo/PTLmaWOdCi/jxCcbyexKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fVVbytQA; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fVVbytQA"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7LfbSF005889;
	Thu, 7 Nov 2024 21:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:date:from:message-id:subject:to; s=corp-2023-11-20; bh=zVtmdXT0
	LOydAcmQhsY4VvKt9GTq+HzYbDXFUMtE47Y=; b=fVVbytQAA5pzEfOaIDJJq6PW
	i6JOOEFXeGSjcTeRDCydyQT8fMNmPiRgJZR8KHRr1dIZ7fLYn4qnQmgkYe14cWJd
	smoSi517rRSQFgcCarGODySByW+6mHZuYBQayty4HYRVcMJ6750ti8KaO3JIfFzH
	muGbrqJ6fnqk6hbRs05boJCQhGBeViXMQiDk02eQg9xbbyGL4BUdaOMH2+1Qj8KF
	pw2hRAQR9f+cEv0W/yK0ol49VmgKXDSxggbW/4fp+G4WsvkOF2nbjHTbLtkCg6UW
	4lRJ7hvlvLM7t4+4DhtWRwjkJsA4cGMGkAyFoVSX0fJxBv//KpbZAZ/MhZjs0A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nbpsunpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 21:46:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7JtZEu031320;
	Thu, 7 Nov 2024 21:46:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nahaca4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 21:46:58 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A7LkwwU034016;
	Thu, 7 Nov 2024 21:46:58 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42nahaca4a-1;
	Thu, 07 Nov 2024 21:46:58 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 0/4] iommufd live update
Date: Thu,  7 Nov 2024 13:46:53 -0800
Message-Id: <1731016017-430373-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_10,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070171
X-Proofpoint-ORIG-GUID: IDfcgQ3sO8rgduGTsPBKlWNvSeTVKXZo
X-Proofpoint-GUID: IDfcgQ3sO8rgduGTsPBKlWNvSeTVKXZo
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
 tools/testing/selftests/iommu/iommufd.c       | 141 ++++++++++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h |   6 +
 9 files changed, 394 insertions(+), 5 deletions(-)

base-commit: c9d6ee6699fd6626b0974143a72c3406276e1c65
-- 
1.8.3.1

