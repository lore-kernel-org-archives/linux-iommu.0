Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12943E47B
	for <iommu@lists.linux.dev>; Sat, 25 Apr 2026 01:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777079762; cv=fail; b=ZxZ21Pi6X4UyT2GySdbp65uXJVS8nkToJEDuib5zMPc6AsK7oaf035Hik0ZQ/tq3dEUuB84fSvxWyGxnAQtWCMUOh3sZeplpTDn9fUiSNzDjTwQz/wysf8R01f771dz+nuePqtyn950huswni/w6BbNd31+wvtfk0NsXhBveCJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777079762; c=relaxed/simple;
	bh=Vpw50taVDgVyY56vvSdGxjWKiis9sH6bkTDwjUKRZmc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Blfor9fkm7GvROjNWbrXIaqJOWMoLfKqkTzy1Qoe/0ThTlvzhqw3DRSVEhroHgWtR/EC/5UEno6ENnm6d8WF3F54/E7q7ddy/cIN0mCZPKEBS6CGWgf7pwiBNL1OdrpKxyEWIGCMH2Ie8hmxmY0YHusnWvWbb3v5j47THDMV7LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PX2eC8TR; arc=fail smtp.client-ip=52.101.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PX2eC8TR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7A422wj58k3943GPcnUYH2V5EHVkoC3c+o4uNr4U+CMnMImOWESk5UdiUxc3LopGVGlIX7g1jYu0jxeWvnfVQZjXk6SeQdYramYGM4H7CkZ47zcczWob+m7j8UeohBD3QJvPIFMhT/qQMCiE2Txcy6PJ+qNTunQ9Bl3hFa/3y7iKunTKo94PEaZHDdCj9O1iOJdPEZm4C+0zv/nAh/wvf+LZdapNDthvVaDSaEJUyPNIvOabo4SxFVIBzFo1OuYdirh8FSv4TfUQijdMprDTHix0vbBkel3SAbH9SrSG6XCgGFcpwplM7ruxiHmYATug3pKWZ4Fc1MyR8uBF8eyWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bf4+jppRrUTWNCubeVGZUBAuPPWXYQ/WJUm1LkedghY=;
 b=F5JCafkNRofgKWNtR7F6tM15Xp6ECNkuZyj3bVbGAQXb+os2WfMMrAq6uS9n3Ce53inwfsYgFp462PUJIKGVFesbq0bgOHVF4wr6GRCvoMxs9+e7T0jRzakE0Y1L5FHrdeSafHnj5AyuGO5uEy2iHzBw+YyKF3C9dqIpgO9dcpTTJIyifzGWgyyxC7Mz7VX7Pzzd/1pO1v7qbtjJwCn686HnCOCXHDtXdZd7Gpy9wCYWJSumWKYN0/KjTMKD+jYldj/V2LNFC5jlnD9gtt2D5ZLqsvan3tSkZf699QQ9vR95v02fz8utyKznjeEdjsc/XGl6fZKZ5mwh9U8msN8w3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf4+jppRrUTWNCubeVGZUBAuPPWXYQ/WJUm1LkedghY=;
 b=PX2eC8TRFHAyrfSFAikfSFZ8DQB7aMiasvuP40o1CJxZJlMtN+PNNLgF3h5WAMI2E9FSJL24C3+nHSeWuZNPSPGMTEAw99s8BpAISfEaORsSXpZwlsey6T4VMzcn6hgZw4e8Ha2iv2c+bFlYXlxg8ALXv5y7sKfwPT1FZOJaOaRwlE07eoj20czckJki5UODTujtJPV6RptghPp6xW6EQ3lHP+bojEGspKzK0TC3ZjVmrP3rwBxKNPJeHFRedu5/O3jBkg6v2J/rnmAOA1ttqB8ILzSPWpcMETmxz8Xh9NODbcuTCRoZpJ6z1Ynb0mM5sLe/8aM+5Qn5yVcQwPr7OA==
Received: from CY5PR17CA0044.namprd17.prod.outlook.com (2603:10b6:930:12::31)
 by BL1PR12MB5948.namprd12.prod.outlook.com (2603:10b6:208:39b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Sat, 25 Apr
 2026 01:15:51 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:930:12:cafe::74) by CY5PR17CA0044.outlook.office365.com
 (2603:10b6:930:12::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.23 via Frontend Transport; Sat,
 25 Apr 2026 01:15:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Sat, 25 Apr 2026 01:15:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 24 Apr
 2026 18:15:40 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 24 Apr 2026 18:15:40 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 24 Apr 2026 18:15:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>, <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: [PATCH rc v8 2/8] iommu: Fix kdocs of pci_dev_reset_iommu_done()
Date: Fri, 24 Apr 2026 18:15:21 -0700
Message-ID: <99806e050a3d52ab5fa33a4ebc75a8968ccedd76.1777074513.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777074513.git.nicolinc@nvidia.com>
References: <cover.1777074513.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|BL1PR12MB5948:EE_
X-MS-Office365-Filtering-Correlation-Id: 329939b9-039c-4410-1449-08dea2683078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Rl6CNXHqqJYCIJcfC9y5SLUtsx4OjqROzsEdxqCczyhtY7nAcvFwx4cziQUTOcB4gHy0EvGNfgkaWY4wKhPw2KNuO4UADzUC94sdJ0m+gRbE6s2j/ThyusAjug//fWeS+uSYBWoYUvlLdF7NA3iikU7x6ZFu+Uq/Gv0z3byDW7KEqOQAf7d2jlf0CgOmswGhrk+5xUT15lT6R2W1/hl2fTJZieobn79Mn6FT4P3krKR/j6mmzraoYSX3/oLjEUhnZHz1eVYgW66h4X5paHicqlVJljRtH9GfNTqwb+tQrwztGzkHmJLdBgkhmF8hLb1PvndXTxiDTW4xLVf63+2PNW+CYw7spdoMWItsjAV7znG9bNTDdrw0F3HWcv2ME0IyrsM0yi1rdaNjv7OPC9nfchDJtSm2N+L3TdjA4IMNH3Y3XKNxn9z5QnRJyzZHonT1+NtTVz8JY1TKcHrjSWhk12ZO3mQkg6h5dYPpeaTUz1+OSZghnCY2KBd37fysUnJpGgKnc1qjuz+6371P7woa7O+JhlYlpW6S5rkrY1DzL0VpTTo0G8EUMLJ581KmTRf3bxzVk/DdcpF+iySmdKxJEFvBvws8Kvj3Txtt4RLkwZlgijrFAqTjPfXgdhPThyi3BC5qNZcOQ5Une+EVJjfanTwzFD875fXy9E3AW5i8qJDmM9Sdu89s9+gk17ZatNim7grDZeBdsYTto5XlhjCwBfPkK1tGX3s98TKo47frVBfHDFiwZKSWgTopLRW56KCRr+sPW/dx8JDtE5kuT3/VLg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vTF8W82odUKjw/Bv0TCivYBmvEh2RACPQaf/y6g7DSaWbqDcsKILhIOtejBGvvsK52UWNx83d9oVmhzMq6MSsHlkHtrw31UpHh2LhEkytUZq5yB3rGmC+GXB+ZOsjW4WAcL2K5P6WMNmdm4Gn/fJBhb87TTgEGy7H3dTo/kDQsjG6t3p8smLb4ylbZM8KVn0CHJ2kuAj0peebAwZHPjIjlT6DNe6JasCp0jMUad+A947Hgli8JJ+t7ONJhGfitdv5ilqOPHfLvKaWRPqCeMbElyTt9w0F4GvHgny4CJU3nWfuDPPtUONX+IjxdLxiKa1m96nq4u0qAu3VksBHnB67mYrbF7mIWmfqNoyDxpGKL3K6J1zYZ3YVp8KoPlbHGck88lTdHqSiTS1tnvLVzLYrzDbkehobsIyV52I+JOp/ANwDxwTC4+jRG4Y0rJE6N7J
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 01:15:50.5128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 329939b9-039c-4410-1449-08dea2683078
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5948

Remove the duplicated word. No functional change.

Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 00b6a33515398..82dd806e5e6a6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3997,9 +3997,9 @@ EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_prepare);
  * @pdev: PCI device that has finished a reset routine
  *
  * After a PCIe device finishes a reset routine, it wants to restore its IOMMU
- * IOMMU activity, including new translation as well as cache invalidation, by
- * re-attaching all RID/PASID of the device's back to the domains retained in
- * the core-level structure.
+ * activity, including new translation and cache invalidation, by re-attaching
+ * all RID/PASID of the device back to the domains retained in the core-level
+ * structure.
  *
  * Caller must pair it with a successful pci_dev_reset_iommu_prepare().
  *
-- 
2.43.0

