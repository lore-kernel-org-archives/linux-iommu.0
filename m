Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136B11A3178
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673689; cv=fail; b=WQ/kNYCfTbeSPx5wWA0Hi54wjqGwCOwHE8Q00jIcNul8HmFFKgjVUb7w/DEjuEo91xNXyqrTRyKa51x3g6AXBHZtTaw1YdIAInoxgTO4vsbPcPyHujeSa5BcQ06QMJHizoZSfuwirWO93YNB74OYc3L1vYgm9llENRUJi1torF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673689; c=relaxed/simple;
	bh=K8Q6RzNY++Uw2edmWPnZz9RT0Zbc7W7NAhITkGh5l6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y68fO/197Fj9gKn0qhDhtSmTQ8hmPx7CgfJx6uCFznBk1m6PelMyd8qR+L13CWZYcl3L1XSe8VCyb8l/5ctvjYi6CqmnWax6nxqveamJwZGE540no82bFV/GHmudDRxGwPR4MsjdVKiNjpYQZ2o896Y3Z7EQDyAYBAsKTBjm/78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=h7sExA+R; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="h7sExA+R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyFZJgmJoIQGXwnPTJnn3qHtd4o1TzncePCtehuWvokXMK+YMbE+BBBJsUp1Jj4oRcSlveUqyP9sdt3IWUQZeR++6PvKXyrGaxQcUYOy+Hpowim/R9kZLzhKOc9oSlPeyLeJ6j7rqRP8hsXcFzYGV3+QMTfv15m+rukIFU9QihfH4+As4zqdLX9MTIDyMpZoWOn5Uj/Zi7HLrLvrrzBrBb/6QNIr9StAIecuU47L/UFLO+EP6XuRxribVcdZ8C7yXbGJ0rRd3TSuf/rncNWtiQiX9Ntw3D85jxdZ+X68wdhe6d1ZpQG/AJtaiOEFkPnlhPv5cki1hi3ADMM/n3fExQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PODp97VR+f23hewTaMp9ILr6TJMwjrIlxe5mNZPBLpM=;
 b=rFQ0OBle1oc+UA/tVzDWITE7WSviAUqgp7xm+zsi0gBYx6OkxbKcU2wdBYOoyW7K1vLdjAj6+erA2MytZ3QCqR4rInFjfGvDffIC9m3wWvAtYnGL7aEX1V0TeqvTZHKggsecbahKFIXj5iyEEsNEQ+xDtT27wsw6a/MQjkalU7ntD4wtmwBnfr36WczVltATDq+ikHNNkLT2E3Taigs/NtpLxzvpgz6VB8Y4Ums+rSyzW5EkF2kIr+g/qN5Hk5JMFxd1jC+KYd+RUAba0ZGgadtDJDGTKWgjS0Moryy4A0CmiF+RTNrianK6xjCo2Nybe5gXAgawr6V1kMyfAFq2sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PODp97VR+f23hewTaMp9ILr6TJMwjrIlxe5mNZPBLpM=;
 b=h7sExA+Rqz+SNOIRD6+tzSx5IDzW8lvtnV5RGTP/3bIfp28dk9SAHojgZxft0cDB8xKyJGpfq+uKP0XnenSVH481/0I58o9FqixP7IOWma5XSNMKsTzVebaU5TgCt9EwDXeDnvYK0diKuf+VkxDqyNfhRZt/eLK+MkQmpbUkr5A=
Received: from BL1PR13CA0171.namprd13.prod.outlook.com (2603:10b6:208:2bd::26)
 by BN7PPF9507C739C.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6da) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 16:28:05 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::5c) by BL1PR13CA0171.outlook.office365.com
 (2603:10b6:208:2bd::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.9 via Frontend Transport; Thu,
 27 Feb 2025 16:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 16:28:05 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 10:27:15 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 2/7] iommu/amd: Remove unused variable
Date: Thu, 27 Feb 2025 16:23:15 +0000
Message-ID: <20250227162320.5805-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227162320.5805-1-vasant.hegde@amd.com>
References: <20250227162320.5805-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|BN7PPF9507C739C:EE_
X-MS-Office365-Filtering-Correlation-Id: d1760cb4-04b3-48aa-1f46-08dd574bb6df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WODb66afltfhtjxq/h7aG+zYKeqKQteOXcXtJ4n4IZpwSxG44bz/A373f58s?=
 =?us-ascii?Q?c2QUnLt+vlPB7A7TNI1aNAKttpGt6WX+AIW3i0MZzX4rVpF2KsFquiISfGs6?=
 =?us-ascii?Q?MF8KiA4LlTGrldKLkv5FRDJ7ilKOyvXvhKvsEpua3zRI2dP7iBdSw3FJZyO5?=
 =?us-ascii?Q?QM6gtx7VAjtqCi1xu4KWcuTT8BAdIrFnqoTTLIT1/29TbSNHr1xpHkwDkm4a?=
 =?us-ascii?Q?Tb7XYlDNL0nNcjARfANxVbns9i5kcLlIttnU/kDSLa5QJ593BjgSfCUHrhf4?=
 =?us-ascii?Q?/dUOwjJ5or7QEVMqpjfNxyYnuv2d8DeR9Sc0RaSjga7SRwujyVjFQKT7Rjmq?=
 =?us-ascii?Q?jHIOPkE4PsCw2etdiy5qj9yBaq10OW744wW+25Llq1QY0CbfoZFzFTy9JQfs?=
 =?us-ascii?Q?YeOIfZrrSpzczGDduJmLoZfzimi7tBE0Zht53gYScqRr87s7BoFs5zc3PKyO?=
 =?us-ascii?Q?7A6ohZ0RdLQ6BhQZ4YWdFeuOg5wkA5IX+VI9HJ1rVaGiybxPXPCQc48UaEIr?=
 =?us-ascii?Q?H+XB0FAWBBEOC+DYIju5ZbzVYOizG1yAu/NWK3SU/LmIl1yBmePeVw6K3Ee3?=
 =?us-ascii?Q?0vAngiTPr0mlknl1kSuVQ+ua5nM+PqrThW5WpNuDug3SUAEfaFKIj733aLyK?=
 =?us-ascii?Q?wKgl3pxwPqh5AnfG5PUFWfufS2tmOmJd6eVsL3rHocPRwaqa8PZVh95qtB0o?=
 =?us-ascii?Q?ge+xEC6seaflvJexQjElvJI54cNRCEEtq53rkznxi1B3BdekcUz2btVLHpUg?=
 =?us-ascii?Q?bGiHVsy7e+AHDj1/W33JAVOeYs4g8Eu2uzKcDWD/k3kkpIPG4Wy2WuYD/Cht?=
 =?us-ascii?Q?cdH362RFDMr/FAid5FTUBuOnxvjyatX/I5BF4HkdjdFoD7t07dcuQFcZnWFr?=
 =?us-ascii?Q?mBRVSqaS7lX/HJlpgUJFTcAGK63GSuddN4w09lX7ykXppPpBPTkfvKbklJJN?=
 =?us-ascii?Q?WiUsQBFFA1n+qpMqGy1nAQ9PMSCjZif8JDTKzFodOFp68R4KIGCfQuDLDRiD?=
 =?us-ascii?Q?BROlsGCn5UQian/iBgw8uLgM+ZJPNHnFCNEmxrAkslp2VTCH8RBAdQ94Yk8q?=
 =?us-ascii?Q?yiwFn+WgEH9gejBZNyeekQ5gJ9kysnzdwFddr0uBBWpxx92QwWyToRKfnFSo?=
 =?us-ascii?Q?Fld5cX1J0fz/fH1qd05/8NWhDSLr/Quj5zr1hMOj9HNIgKg8mmf7IGGj2qs0?=
 =?us-ascii?Q?jLVYz9yPd4IlokXVd+s3jL+LrR9jal+Ww5Q+aCw0hu60rLs42o/uGDUsxSeF?=
 =?us-ascii?Q?QUfR8NwJA6LOZBO4VHpqUz7Z6seuC7UgwmbRbaA5283/RerbHgYb6WhGNgx7?=
 =?us-ascii?Q?d82W7N+8vBcjyrwJ/VkxtEEV6uufLfdm/tKrndzeey5NCR8UCdxlHYhKyhuT?=
 =?us-ascii?Q?jmSmv5NAQKziUFe62CioIlboRV9Iz4IX7umFWZ5yI+5vAdXWXIMX5E9SfxUE?=
 =?us-ascii?Q?Eqn4fN14H6dGvUoWAeYd9XLKxbzgfnNHxN/xejL20vNhm7dPgfGOCR7h6V+N?=
 =?us-ascii?Q?QxOzK+oVQRiZeGo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:28:05.8249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1760cb4-04b3-48aa-1f46-08dd574bb6df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9507C739C

Remove 'amd_iommu_aperture_order' as its not used since commit d9cfed925448.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 23caea22f8dc..3f57bdd0a659 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -928,9 +928,6 @@ struct unity_map_entry {
  * Data structures for device handling
  */
 
-/* size of the dma_ops aperture as power of 2 */
-extern unsigned amd_iommu_aperture_order;
-
 extern bool amd_iommu_force_isolation;
 
 /* Max levels of glxval supported */
-- 
2.31.1

