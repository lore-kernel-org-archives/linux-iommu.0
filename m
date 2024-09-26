Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A9527470
	for <iommu@lists.linux.dev>; Thu, 26 Sep 2024 13:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727358836; cv=none; b=s4Pr34K5b6xiMYm4xTaGVLmTbozXvFoDSi/FqocIv6YIZcHt2IQrMD1qO/MOwZyHOfvN14c63F7fhZvMSGtV/WEeb0rmo/yNQPyC6unjyf905vkVSFB5nUVQQCsuDWM4r+l15C4nSTCvpfUwER23kQAp3djgp3PRFKxb0bvdRS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727358836; c=relaxed/simple;
	bh=qumbLM2pvw1zjsCGQJhAkHI1gsigApXXZI8xTy0vDhY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=TPyYN8mt23NYz0JuUMBHfDqGcK+XCjpsvyAG3ruXB5AJYwi5FXbnI6/bV1e7CTpgYkuXc7on7hSyFE4V3+wNAdirMGnI07mpXUfYVZ4B903VaeGHOX6oP1YmCWs0Gu5S6Gan5gJtgEp6lIgZAjwY87TF/hvw9aOLIkPh/byXX+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LGFQV7v3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LGFQV7v3"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48QAklM5005392;
	Thu, 26 Sep 2024 13:53:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id; s=corp-2023-11-20; bh=8WQYne
	/4kA8HHK+kndiDGsnvWyxfNrCD+SyJniuHWDE=; b=LGFQV7v31p07EL2+2CEZc4
	J/Ewqj8n6H4eQ28BJCeYolozDnZ+h64+dH1+lWzh+5k/kzkGcPwkIe0ou2VjM4Q/
	9B/uQI+5ad32W0EWtjSm+zKdrjmd2Cx+a73ylip16OJK7PpDDFkTBao5PnlrxXpQ
	dDqHxFJdoknjIbzNADiHCRLjae6T7jGZ40ALVSKi0OKG1ElAQwUR/TUExCCqJ3P4
	yZ6S/tMpjbpV2jzPpEkMGidF0ot0qe5ROTL2niM+CSNEekHVaaknEvbO7vDW7tQZ
	DNcTnrx/HCdazjBuASf04gcJaG/LYjeCeRiIDA7Ge0g6MbI3vLbL6yl7uSj7hK8w
	==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sppud7dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 13:53:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48QCkuGp032892;
	Thu, 26 Sep 2024 13:53:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkjfd7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 13:53:50 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48QDroXQ027500;
	Thu, 26 Sep 2024 13:53:50 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41smkjfd62-1;
	Thu, 26 Sep 2024 13:53:50 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 0/4] iommufd live update
Date: Thu, 26 Sep 2024 06:53:44 -0700
Message-Id: <1727358828-97791-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-26_04,2024-09-26_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=1 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409260096
X-Proofpoint-GUID: ydFHM95uC3jEosQJyN9FUFRvk7P2wiSv
X-Proofpoint-ORIG-GUID: ydFHM95uC3jEosQJyN9FUFRvk7P2wiSv
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
  [PATCH V2] iommu_ioas_map_file

This is implemented in QEMU by the series:
   [PATCH] Live update: iommufd (V2 to be posted shortly)

Changes in V2:
  * deleted interface to update VA
  * add selftest cases

Steve Sistare (4):
  iommufd: Export do_update_pinned
  iommufd: Lock all objects
  iommufd: Add IOMMU_IOAS_CHANGE_PROCESS
  iommufd: IOMMU_IOAS_CHANGE_PROCESS selftest

 drivers/iommu/iommufd/io_pagetable.h          |   6 +
 drivers/iommu/iommufd/ioas.c                  | 209 ++++++++++++++++++++++++++
 drivers/iommu/iommufd/iommufd_private.h       |   2 +
 drivers/iommu/iommufd/main.c                  |   3 +
 drivers/iommu/iommufd/pages.c                 |  10 +-
 include/uapi/linux/iommufd.h                  |  23 +++
 tools/testing/selftests/iommu/Makefile        |   1 +
 tools/testing/selftests/iommu/iommufd.c       | 148 +++++++++++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h |   8 +-
 9 files changed, 398 insertions(+), 12 deletions(-)

-- 
1.8.3.1

