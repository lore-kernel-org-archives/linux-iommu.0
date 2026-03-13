Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F98929B8E8
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 00:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773362235; cv=fail; b=Mea/yWTVs1p77BrHtja3N/z1SXErF3C0x69I9clQj8cq3hkM7ey//1DexJDxK64YEI0NB6yUOrqv1AEHqxFUgnPSPXwLb0k9rTWUSbglRTvP3AadIwGf8uISqXPEDfw4rI8PsAxkePreUMkudOFFoIj7GI6VLFkAzhVQK+XAuxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773362235; c=relaxed/simple;
	bh=p4nC52r/1S77ruL6UaLnJcxFgJaGgxMM+Iux6Z9vnaw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SostDYwyZQ92+cnR7H8rDpXmSrovKtZojojSLRUv8FYnQP5RmGM+zfgZMmK9DOB/cpJo+SsRVvqHUjUs59qcp3ArfXr2BZoffe3WWFvBkvw6eMHtyAYo3qIz/20x59G2934xk7KIjHzy10x6QZ3GhwRiupNFai/4B2MHe0h/bgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UxgBihVa; arc=fail smtp.client-ip=52.101.57.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UxgBihVa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=th5zw9iMVRfT3iK4I3JYzMVRqVFhx10JB5iS4dFjPAea5eF/bD4SbtaAsSNFlezIBH9p5gQ1GXKLYvvj0sLXkJ1tvuWxgD2nKSzYVBPUyqB/vqb3zZhfYMcdRIesBO7mhoPY8JUMrCOq+Qhv3FfVo+KEMASQGw7ZM2p54/lSQboyFzqLA6B0NTzaxENEZaMsFpGDO9pt3BPr6h26hKdKa/tzeXkW/F33p5P6x948fLyEy4OTk/lIDg6tYfydZ8sGr7fE6PIdJIxoUc5imZnh1GV5StwiNdVdri8zu+xOOSfM591crqrfMMqYzOIjEskMqBUX0HaKTu4i4F4ufbfluw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/Mzib1nsWFhIJuM4E8zkXT3GrRXPYxVU593L+nAlbM=;
 b=rPSVe6IAAvz3n77exQAyBrpNJDIpQx0m+P3R+/dr10udS4v7rByngVsanTMjEM5NRUQ51n8RaUT2L9j+sxx2bgSpcdvH407161Vj//cM83yeRR0N7U3TstSE0d1d6RNYMFkxPNvVpdU7kQt28CLmR/i4LKq6d/65B8ajtr6jTaSA7dXPeFGLTAybAPBQPfA+OOcVWNmYQlwyJ5AswitG1Nd30gPymWa3RZNQeYXArDPQbtnKyOW0Z/hLMm2+9l0oV6aBzSNRbjXWFCj4QaolXtbcsbhIXhPhQBr44eNghcgGKBpSwY4MmxJRDuS38jQlzmN/YZ+DwsmYfx0Ww+E8Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/Mzib1nsWFhIJuM4E8zkXT3GrRXPYxVU593L+nAlbM=;
 b=UxgBihVammU45IiEa4WtJm6dlKLsDWFM9zgwxqW/SukA0iCnejrlBuyHDug388Cf/t/jE8rUedu/LKf6ItW4SidyOHlPjpx29cSG7NMNBvVDvM6fEJ08F40YUOOH0lFDAg8h3iysOV2v+C8vxKjZwKExPqn58nTr15CBGEnhFiELvk3cFlHEBfYYtDG/pUZCaf2sPSVlLBcJ04KHHlKMGR/nmAwcca8LIuDdjMz+4aaREBR4ffdhXqlbUL7e7enNITnP9/mW2ByDJ70l7TVrCnKhvsZniF2Rb+ETm1FkgyiPDKjixzFdrRx3t5uULfTRREEEvq3dX5i6p5Jg/hczmw==
Received: from PH7P220CA0172.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::33)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 00:37:08 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:510:33b:cafe::32) by PH7P220CA0172.outlook.office365.com
 (2603:10b6:510:33b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Fri,
 13 Mar 2026 00:37:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 00:37:08 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 12 Mar
 2026 17:36:52 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 12 Mar 2026 17:36:52 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 12 Mar 2026 17:36:51 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <joro@8bytes.org>, <linux-tegra@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <eric.auger@redhat.com>,
	<skolothumtho@nvidia.com>
Subject: [PATCH 0/2] iommu/tegra241-cmdqv: Fix initialization and uAPI related to HYP_OWN
Date: Thu, 12 Mar 2026 17:36:33 -0700
Message-ID: <cover.1773361875.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: ac23080c-b8ef-4960-96d9-08de8098a88d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6FRAK4CU+ttAtzjc1Qa9WKcUntC1dIV1V0c8kVy67vQ9rADCWEvKxRfgPtggEz1xbrmrUOGweXUwDR3c9XNfs21HwoziIStIAKHTOuUaxhNAPlpuXTHEuY9nTq+qt1tHaMjnqrtney36zFGHKRMIfOYCnGwU7TtqmE/ARhhJdcvKY5qXU3dNqK2bfXbBYFJ4dLCyt6EKS/HW6uJS+RfhVrGDBkkfrvASaqR6llt6JSGBuPf5Da31wg+yJQQf+b1ykN+HJEPWeFB97YXOxVeaVURogCp/91s2DpDu9ZgmsHSjeyrPzIz7JctQTYS0hC7Bdcd37tB1exQ+2hO7YE3Qq061/5/7fHu+scBkVszkITuXdB4YISfdeMlM0JPcoVALqndUjb7u1iQi6yomPZyJFy4uzD0KpikzBlfNAm1/1fFNuUZp/E0WH7zIMUx5HEdfMNtnjtHVX6n5AZkzXm44zizVfN+MXBMGkvxOcuVfGhgvNM62tztqBDBnkiAEgH7KZbFIHZigaHWd24edetT/yrFcgQJiH3EJfvypj2l2C4EDqAWPyLBVkIycYri2lgkRqXli4xdT7HgUm9+I8O20ICgC+G8l2Vh9Ijf2WIZRNL3ZkUpXm4Lz5yBG/cTJ2qwTuJTVGbZm23IisNxeh967kUynGmAr8hRTPa8ya4MSE4VYPp/YtCSpsYsbVpahwPAtA4UQIrvQfEJrQxKOCjB6fNIuHPmlUxoLFN/ZuuY1QlqL3bWKAR1OWmcgGuIjNqhRDN6KMOyaactDqqfkT5S3jA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hNk1d4z+FdfFf9Pav6l0zkgQXaeSLCUMd4ECTlzPY2IFdgKTj5avn/EiwgXineDQfQe4QUqZ2ccnOuU4gD7sQfQFgd0MbVLr+wG9MnnzyiTz/bOPjL2zZ6vN5sSJ/985WoiSZBa5DFHIVHHI+VpdrAlQCSgaM9Xr35UBjZYyeDDlgRI7UNC1/CjTsLMXxAw09PxafmE9yoCcm68mZ41vNgUNbCVgMTCSDuy+T1/6IraEgd4lTSQStB4Y/Yd2r05fPiWZLCTxjvQ6sxcgrLW8gLX4Im0qoDG+dA/4miaJkZILf1ziLSxt7AcJWblqtzSc7tsRpeeu94B2uyAxyGcmmjwbWnW0hOjeUcPYHqeaR00VaHEznyEsIki/c6rE6CSiav1r8QUUV10sJ5tlEDQ46QPHuJx1vn49nmD4F7baKuRZOhCL5wgPu+fW1uMBFvh+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 00:37:08.3177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac23080c-b8ef-4960-96d9-08de8098a88d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570

Hi,

Eric and Shameer found a bug in kernel driver that supports_cmd is set in
an incorrect order related to the hyp_own finalization. This results in a
unnecessary command filter in the host environment that sends unsupported
(non-invalidation) commands to the SMMU CMDQ.

Also, Eric pointed it out that the requirement of VMM wiring HYP_OWN to 0
is unclear.

Thus, I am sending this small series to address these issues.

Nicolin Chen (2):
  iommu/tegra241-cmdqv: Set supports_cmd op in tegra241_vcmdq_hw_init()
  iommu/tegra241-cmdqv: Update uAPI to clarify HYP_OWN requirement

 include/uapi/linux/iommufd.h                   | 5 +++++
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 7 ++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.43.0

