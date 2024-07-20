Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D0F146D41
	for <iommu@lists.linux.dev>; Sat, 20 Jul 2024 18:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721501813; cv=none; b=HMLZ3xGu6kt8v8q0pfoRODDgw2DeZ/De7Lm9TTa5cTi17wI+n1cPhMMLu0ovjqy2Ju1fiLcOAlIBKi3TEOrNY0x+41f1UsLmH22gAwrHu5akH96VFiGUfhlfhw75tLlVobcudrMDL8WttumGUMGjL4UtrMM5CT1mn1wmEyNqttY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721501813; c=relaxed/simple;
	bh=UO4Mw5lTgd+j6XYjC6kP7r0TEqq6LhDsZaXPIDtGwhg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ZZqXqNWOmGmXXLpoqX1PpTmGa7J5x2WUvOptFCerFsTCGtD5UkBn8Vm799clwPmas1u3qMLX+MS2UinlDbp9CyawgKoV8+kwQvOTZQVdazM/Cezji5JUDTHoLpEn7yka3YLWh1hbEBMKlxoc5NLjxyDOKEU2i5dOkLaDHlCT55E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YOjJ9Y5p; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YOjJ9Y5p"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46KIj2uE027491;
	Sat, 20 Jul 2024 18:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id; s=corp-2023-11-20; bh=wAZpVk
	ga4QN0STwW0UtxzmFCFiHbZ1WDUl+XPh70f1I=; b=YOjJ9Y5pVuSgI87mT57jDx
	AOp3NGpvMl/oT1tPoI4XzCvjq0F9wPhnD+UqL29ecyt7ppDR0O4c+sFP6n0oG4QC
	UxNp7BV30Rg7+SuK4g2dfBuw+cCGutv14LXmOeDyXlEgyT0ip4nm85xvGkSAbFA1
	4/FbVJ9krtVu7GQM3QHpzz4nK5zGiQ3qYBDeT4j0nRgpkpLG061DBud7JvHqTBYG
	5EFGkp/O2ZFhTcdkSpb3D4SnoIVMj74AggOhP6jKeTZ3bIKMXuYfyLYdk4XA8Bu7
	z6AyUnjhCfsLkDLYUaRBP3EmGp30qHUfhOIFeERFohMO2/l2t5GhfkQlNrJ86kSQ
	==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40gjst008m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 18:56:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46KHnB3W024449;
	Sat, 20 Jul 2024 18:56:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40g3p5xgba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 20 Jul 2024 18:56:46 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46KIukD9032989;
	Sat, 20 Jul 2024 18:56:46 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40g3p5xgb0-1;
	Sat, 20 Jul 2024 18:56:46 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [RFC V1 0/4] iommufd live update
Date: Sat, 20 Jul 2024 11:56:40 -0700
Message-Id: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-20_16,2024-07-18_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=1
 mlxlogscore=746 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407200138
X-Proofpoint-GUID: rBgrcoKbMd_YEPKktmL0YXCftjHWK77l
X-Proofpoint-ORIG-GUID: rBgrcoKbMd_YEPKktmL0YXCftjHWK77l
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

All memory objects that were mapped for iommufd DMA in the old process
must also be mapped in the new process, but they may have different virtual
addresses in the new.  The application passes an array of new addresses to
IOMMU_IOAS_CHANGE_PROCESS, and it atomically updates everything to the current
process, grabbing the new mm, transferring pinned page counts, and recording
new virtual addresses.

If the application directly exec's the new version of itself, it must take
special care if the mappings may be accessed by kernel threads, such as by
vfio mdevs.  The original process must fork an identical caretaker
process which calls VFIO_IOAS_CHANGE_PROCESS to take temporary ownership
of the mappings without changing VA's.  The original process then exec's
its successor, which calls VFIO_IOAS_CHANGE_PROCESS with new VA's to take
ownership from the caretaker.  

Thanks to Jason Gunthorpe for code and ideas in this series.

This is implemented in QEMU by the patch series "Live update: iommufd"
  https://lore.kernel.org/qemu-devel   (to be posted shortly)

Steve Sistare (4):
  iommufd: Export do_update_pinned
  iommufd: Lock all objects
  iommufd: Add IOMMU_IOAS_CHANGE_PROCESS
  iommufd: update VA

 drivers/iommu/iommufd/io_pagetable.h    |   6 +
 drivers/iommu/iommufd/ioas.c            | 291 ++++++++++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h |   2 +
 drivers/iommu/iommufd/main.c            |   3 +
 drivers/iommu/iommufd/pages.c           |  10 +-
 include/uapi/linux/iommufd.h            |  56 ++++++
 6 files changed, 363 insertions(+), 5 deletions(-)

-- 
1.8.3.1

