Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2D11AAE26
	for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190345; cv=none; b=MPo3G7i9QO5YxqqrNpppmWGAvVI86qK3skhUVynaKtmYKn8awvSiAHyd7X8PtoxM+hNhmF5FRlbJjq8faLCZiyP0dJZe+gULfYRmKyD7isv/xk/X8z8VF/cTZD5OLPCE24Fya4NXZSabbaD3ZWQbH1CRmLfQt+cxQ8JMZNDkc0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190345; c=relaxed/simple;
	bh=h7Be4a2+zMeLREhEmKvWVG3mfW9+YC5nYa/bQWS6mag=;
	h=From:To:Cc:Subject:Date:Message-Id; b=T2JsclJcN9amAKx7EAP3HuJNcAFdTmCvavDFohFs9f0Vg4daG4VS9evFPTB+mHloLw5mi0HnGSs7/PqJM1mei+9862VwgMc4pAqySGtCt1VhXYQRzZV/GY8wMrBYr5c8NiD5N7zqzG0CUhAEosDpZ8FaIOSZieTP2VVIjhxwWUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ekohhn5s; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ekohhn5s"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OEQWs3008326;
	Tue, 24 Sep 2024 15:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id; s=corp-2023-11-20; bh=Bz/roX
	b8SQvdNF1ChBF1Q3k4Z8AY+ZAbX6J0F0y3W1U=; b=ekohhn5s5HyTmeQ87TfqzA
	P4K+gWy2cfTx1aOx7Cq6RhAN+oxi292NDxvJRUJYIgypimPhnQPhZamOFzv2i2SB
	Yg1Mz5OTEMxq1PaCq0QmTZpBwHMOP0AvmFxhzwQHfV7EDDsbppUnPCQEncaEIPMR
	kW6+lQUE7b2lFO/XXfr07Ox0xX4DC5SxBQMXGe5a2wjPBSCdcAnyUQNhc9gRtT7g
	zKTqg8vUt0xVRqZU9bbzpIHfyjLWHvtf54xbUTP4DlP6Kr/wMaS/JVR/iFd0BuJy
	DKClyrKYEGUPzNDRIU2v2J4U55Vf64ujeax3Rg/zdHsLaLMF31dgBcMoPEeCHy+A
	==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41snrt56rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:05:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OEPoxI005426;
	Tue, 24 Sep 2024 15:05:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smk9cqye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:05:39 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48OF5dLB027122;
	Tue, 24 Sep 2024 15:05:39 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 41smk9cqxg-1;
	Tue, 24 Sep 2024 15:05:39 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: iommu@lists.linux.dev
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 0/9] iommu_ioas_map_file
Date: Tue, 24 Sep 2024 08:05:29 -0700
Message-Id: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409240108
X-Proofpoint-GUID: FZ9OeZKg2eChfMTgYx2e4I8pdkzrJAz8
X-Proofpoint-ORIG-GUID: FZ9OeZKg2eChfMTgYx2e4I8pdkzrJAz8
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Provide the IOMMU_IOAS_MAP_FILE ioctl, which allows a user to register
memory by passing a memfd plus offset and length.  Implement it using
the memfd_map_folios KAPI, and the proposed folio_split_user_page_pin KAPI.
See the individual patches for details.

Changes in V2:
 * changed names and commit message in "rename uptr in iopt_alloc_iova"
 * normalized comments describing the iopt_map_user_pages interface
 * submitted folio_split_user_page_pin (fka folio_repin_unhugely) separately
 * replaced nupages[] optimization with folio-to-batch optimization
 * added selftests for map file

Steve Sistare (9):
  iommufd: rename uptr in iopt_alloc_iova
  iommufd: generalize iopt_pages address
  iommufd: pfn reader for file mappings
  iommufd: IOMMU_IOAS_MAP_FILE interface
  iommufd: IOMMU_IOAS_MAP_FILE implementation
  iommufd: file mappings for mdev
  iommufd: pfn reader local variables
  iommufd: optimize file mapping
  iommufd: map file selftest

 drivers/iommu/iommufd/io_pagetable.c          | 121 +++++++----
 drivers/iommu/iommufd/io_pagetable.h          |  20 +-
 drivers/iommu/iommufd/ioas.c                  |  43 ++++
 drivers/iommu/iommufd/iommufd_private.h       |   6 +
 drivers/iommu/iommufd/main.c                  |   2 +
 drivers/iommu/iommufd/pages.c                 | 292 ++++++++++++++++++++++----
 include/uapi/linux/iommufd.h                  |  25 +++
 tools/testing/selftests/iommu/iommufd.c       | 156 ++++++++++++--
 tools/testing/selftests/iommu/iommufd_utils.h |  41 ++++
 9 files changed, 607 insertions(+), 99 deletions(-)

-- 
1.8.3.1

