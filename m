Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99461E495
	for <iommu@lists.linux.dev>; Sat, 14 Sep 2024 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726319169; cv=none; b=pXun7P+fHTXqY5Y2yrtduk/658QT72pBuy5zQ9hT8ZEcpR72X1yfdhIfJLhMobxKs0L2dLpeamreG5+5swDavZWuoE5uzjjP0lGYLluRNH9KMs2u449RHj4qOoYoFZfNPg1QjSTTvO1cF8Uq3vuMCSZCO7Q+O2St01rzR9uTxcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726319169; c=relaxed/simple;
	bh=KoVSmszSfCRApKOeLZITLy6K4xK8OTYVrLTbjP6wN6U=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NxD49Zt3Y4DxOgL7mTw5pH08JLktKcsUHJE/qpWNmOsXS9GZ9sqH13fsSCVrw44HDZH2Ip6Zzi+789l5bzg6/BjwVmEPPnkonxLhAIgvfQ8HrkFcqA6XYkycBqj4Tuyec8oGrelT7KVmqdHae6KLac4XtWoCu14uOe/e5LGQfWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HjRDt5PQ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HjRDt5PQ"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48EABvoV014061;
	Sat, 14 Sep 2024 13:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id; s=corp-2023-11-20; bh=QX0BcK
	L972+8ngcjWuExGPQexa6fdH4Nz0iE6uXjj74=; b=HjRDt5PQabC4Z/eP1xy47Q
	y7v/GqB1SOotcnOcllaSKp4ePEFScAmtAuXsbOFo77fkfBYyBHWOan+v1kbY4c5R
	Zzsh6BrRnWaaDQc6fcLsGHBg823JnTGP8XKRTmoCZ8QNj187prD537nQqLOsOEd9
	AU1bXN+B7GKy0k9HZBQhHtv8WzXK1z02D8VSYBjbvId6a5iz7W7+X14lwZMzv3Gs
	clHo9WjZ2rJzvOkbblE+XB9vuwxWc6jqJwX3aTa0Bmc2jjbbBdu5koTcWvmDGGt2
	L5UDGDCt8q93GPbBlp5CTCd0Xymfz9mYCYGDbDvEiaPRlIirgMPkh8aUTFhmAQGg
	==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3rwrdv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:06:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48E8Qu2G019282;
	Sat, 14 Sep 2024 13:06:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41n0x6a1t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 13:06:00 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48ED60jD024307;
	Sat, 14 Sep 2024 13:06:00 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41n0x6a1su-1;
	Sat, 14 Sep 2024 13:06:00 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 0/9] iommu_ioas_map_file
Date: Sat, 14 Sep 2024 06:05:49 -0700
Message-Id: <1726319158-283074-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-14_09,2024-09-13_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxlogscore=859 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409140092
X-Proofpoint-GUID: 8PhAWuSJQLdFjNdNqrvT2js222BV-_kd
X-Proofpoint-ORIG-GUID: 8PhAWuSJQLdFjNdNqrvT2js222BV-_kd
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Provide the IOMMU_IOAS_MAP_FILE ioctl, which allows a user to register
memory by passing a memfd plus offset and length.  Implement it using
the memfd_map_folios KAPI, and the proposed repin_folio_unhugely KAPI.
See the individual patches for details.

Steve Sistare (9):
  mm/gup: repin_folio_unhugely
  iommufd: remove uptr from iopt_alloc_iova
  iommufd: generalize iopt_pages address
  iommufd: pfn reader for file mappings
  iommufd: IOMMU_IOAS_MAP_FILE interface
  iommufd: IOMMU_IOAS_MAP_FILE implementation
  iommufd: file mappings for mdev
  iommufd: replace upages_len
  iommufd: optimize file mapping

 drivers/iommu/iommufd/io_pagetable.c    | 102 +++++++++++-----
 drivers/iommu/iommufd/io_pagetable.h    |  20 ++-
 drivers/iommu/iommufd/ioas.c            |  43 +++++++
 drivers/iommu/iommufd/iommufd_private.h |   6 +
 drivers/iommu/iommufd/main.c            |   2 +
 drivers/iommu/iommufd/pages.c           | 210 ++++++++++++++++++++++++++------
 include/linux/mm.h                      |   1 +
 include/uapi/linux/iommufd.h            |  22 ++++
 mm/gup.c                                |  18 +++
 9 files changed, 354 insertions(+), 70 deletions(-)

-- 
1.8.3.1

