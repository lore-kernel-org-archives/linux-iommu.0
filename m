Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011044.outbound.protection.outlook.com [40.93.194.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B13B358379
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 02:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779071354; cv=fail; b=kkl6T9BZ5lWEMYLKWgZAb00vR957fPck8VIjyHRiQWa1EnSy9rPhn28JOToYTPR8m2LhfVKDXekpm4sQ/OmDIYw0mjsUXaPUd5PO5juNwlqOqi74s8772zDelM/5vvRodI/Kabs5LIjMLyC7YFBoPo21HgvvFLBKdJRkuPqVvbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779071354; c=relaxed/simple;
	bh=777sO4xvZlBxr7D2S3ExmqF5yLV7kiUx7WZpuzJyIQU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=djMj3Ei4mgZpHdOnfzql7WgAs5Q1rOOjn8X4wYeulJdty3E089fYnAC0etmBjga0ynt3HlwbxpKCYj4a/Lcj/sCnE2S8CGjghNjcZpVFrojd5jW0uzTjvzYU6c6RuBsOGHfhRZujn8iVOESmzSfQhds8ORCsp8ggjJujqELtkWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TfaayDqt; arc=fail smtp.client-ip=40.93.194.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TfaayDqt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRhr1ojOcwzMQZykzFIkwTKinjpKTVHfwpQecSo09CuEZbp5kcCUraDq9IxAPDwYgY2wTZiQ5kvvjg25Rv7w1xfVnoodg6N/t20qK88qSficfQMOpXsXOWEbWzlfjFxDSnDG76jW8/ADEMiSYGhG3JNPa73Pgmm9xCGwHNJ7NiLNXSqx0Jdl25bLdOYqodX2a64fb/j2BJ6nHe87SSdJQFFjFxAbLVph3Qc1chfF86kEEmXHt1T2XEetWcZKa34sbBtjuCFqGVm1p0yZpHkAbWXLj++upusxKJoHDaWeEcUphBD7vKWzhumUtAqeYqH2tMZfQI7A5Sqqd7dc3plFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5Xxz2ZFEFWqm5cbXw7mFcusDBRZ9uPMPATZ45FCdzI=;
 b=h30LMevIkQId/pMGGRHZ3TrOoJKAqS9PQ830qrb5sk3bWie05n+KRYw6Uc1Z0NNYvCupFTu4apWEQIr5UXA1By4D2/Acl+vUqT2FL6AsstW2c//VS/ozIzjk1Fmi2XJe420C9EJApjPliaTN8ne8fKccsz2ZwqSfPTo+EFP+vPvAgMmhg2aGeYcx1szwmkjxsl4BAarM4A6WNw47+dJoA/Nkep0yhiCqVrFIFRJxcPSvwB9mdaN4IQKQ6OtTRuwVWwCe9buHp0BRWviHUbWqCk65a2jxlxCJk8VQEO0BRH1EnZySwcBmnW9o5Uw8F49gVQExOmyNvCF/Gx3lbM94SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5Xxz2ZFEFWqm5cbXw7mFcusDBRZ9uPMPATZ45FCdzI=;
 b=TfaayDqtaxnZnHv+5je46Qtx6mLOueEl4YimJXFGl8+nQQHz4jDZNSx/vtAcDuNFAFv9Q2FtK4KdHCS5QNnbO5RGBLdiTALFcFGZVDs745FwiDr8d8Nklxd9iAV6tKLw5sysmV+ilTPu6nO5Kl6C4Y5xBrUm5MZud09/sy+StjTtMQUED9glAcrew/fzCeSAsDLCXNmlbTvaO3w6nI/aF0+esS5xtrNUh9ILvVs4VVDa8zZEZoRvfrd+icryZ6dxBEwo2fBrZ/qGmDIqyNDZ64DGSA19PuzpOCHRxYZG70kyWH8wEQ1woIQKI4HzZmKj+mVwicACpXIm92FUn/BvyA==
Received: from BN9PR03CA0038.namprd03.prod.outlook.com (2603:10b6:408:fb::13)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 02:29:05 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:fb:cafe::c9) by BN9PR03CA0038.outlook.office365.com
 (2603:10b6:408:fb::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.22 via Frontend Transport; Mon, 18
 May 2026 02:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 02:29:05 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 17 May
 2026 19:28:57 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 17 May 2026 19:28:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 17 May 2026 19:28:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH rc v1 0/4] iommufd: Fix veventq_depth boundary
Date: Sun, 17 May 2026 19:28:45 -0700
Message-ID: <cover.1779070992.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: fe41189a-429d-4b35-faaa-08deb4853b9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|13003099007|11063799003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	r5dos7IVBVA93u6j4vSQPeFs4alNAnTry5QMUJ40wcH5fsP2KGCBIFRlt0hQb8WyuIjYr5AOZoFRwYx2FLDkIfhwRNdnxrxtzCg7/TqZ4Hx8RtirTzqKgple1zkU4oIZBsWSJsIGMvGi+/uCxJBrHwNolOdCGNKHDoAtvwG7CrKrK1nLeU00mKtSMezYCfGgB27wVVILj1vvivFhRvdL+urJ0apokvv6aVsetCVLj8shIJ2X19Wa3rDVHvvZhwuo5m8PZm+FYgkVrF9qkyYCdNcbhLWJ+Y+/Ych9SUj2YuBdHcQgj5lzLGR9TZ9HmBPTGk9UtusX6U6Cx89lD3+feerEQy+CtBnqVL7kq7cwgjlhX+hKIKJ1gJPUrIqqzt6RvcN3ALTnkFfEjcjH2Xa5za3pViqZ3vXJEuOBj8oUKB0Tle373yySlzoh3chA7nPOWpub59J92dVcrrAMULe4Mbchz6mAVE3aYWB6pZ1+NhtAO15Z1GVNe5LGFWW3Lx6hVpGiwZjScv2/oz+zo3NKdfUVMOzkjm6qUy5g9zK4cuVb7nnaW57wKjqdQTdeGl+vluE2h/A4c6FwpdIrIvQJG3irQspfBjJ36wy+bICl07iXwUugwKO4LL5sMK4bFTns+n0acH+ClRnHo4dqq7URIi3qJeb6QVBD5Gpa0958DGLKn2Y+jVrFsAOKHKUThyKDuy10MEOy6CcP7VjT7ECgRThp7mRBRRNX5DEQxZIyHQM=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(13003099007)(11063799003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mDnFFUSjrOfCir4grPeaKEync3U9TKBsgfKavMssTt/LPxCEOHcEFNlcget3Sxk3DBna2L9Qcr9UFVYIidYWBmctndD2MesFSBp/qGz2QikFDM6r9R4tRGHNWfT8hVTrAXgI3UaDtNqBakIVSD10iy0/j2/t3gdBwc9zOwQog+Np2D6JIzWqX6fb6Nzo1t6Hm1lpR9zWQs/vCQ3/FUKHZeI9Mrbx3xtY5owtMWJrxXkFufjdfgioqssrjUGQouGJM0TzDK42QKoO3YX9QCKaATOp2V6CGQlzC6Rsf53+O2FP4rCdXleJfPKcfpQY954qZ44ZaGd3CVsvctBuXgCApJd1JbeVtQ3ND7OTIwVDw9DIxYEPM8tNk9jTnlybg0Nt+8QA/12t+wkgUjMHeegSzkjI/FhEVZJYAwvdfX/21LfdNmIQb2WMbbOL+D4UJbqZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 02:29:05.4962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe41189a-429d-4b35-faaa-08deb4853b9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405

The upper bound of veventq_depth has been missing for veventq allocation,
leaving a vulnerability where userspace could exhaust atomic memory pool.

Fix it properly:
 - Allocate outside the spinlock to avoid GFP_ATOMIC
 - Cap the veventq_depth upper bound
 - Fix event_data byte-count
 - Add selftest coverage

Note that QEMU's SMMU has been already allocating veventq using a "HW"
EVTQ entry number. So, picking 19 as the known use case, for a minimal
level of ABI consistency.

This is on github:
https://github.com/nicolinc/iommufd/commits/fix_veventq_depth-v1

Nicolin Chen (4):
  iommufd: Move vevent memory allocation outside spinlock
  iommufd: Set veventq_depth upper bound
  iommufd: Fix data_len byte-count vs element-count mismatch
  iommufd/selftest: Add boundary tests for veventq_depth

 drivers/iommu/iommufd/iommufd_private.h       |  2 +-
 tools/testing/selftests/iommu/iommufd_utils.h | 17 +++++++++--------
 drivers/iommu/iommufd/driver.c                | 19 ++++++++++++++++---
 drivers/iommu/iommufd/eventq.c                |  5 ++++-
 tools/testing/selftests/iommu/iommufd.c       | 19 +++++++++++++++++--
 .../selftests/iommu/iommufd_fail_nth.c        |  2 +-
 6 files changed, 48 insertions(+), 16 deletions(-)

-- 
2.43.0

