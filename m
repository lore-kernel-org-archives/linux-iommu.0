Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012D11D0E38
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115335; cv=fail; b=TLYiMu3rrOQkT++xiytvCji25tb/sBAnswEF8OpYHndzfkn1xqEfii/GmADiSldQwgaS9HqwC6wCiFd3Fi0Di3XRr0qoPNgMlu+XXSgPxIo9//HvYDmU+fuYX7c1yVVxFiCA+XzPfTc1qUsTXDZwaWFf22gRjFiNio4UW9fdaEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115335; c=relaxed/simple;
	bh=nqeEY4h29U/X3nOxtoClH5/nUztbFDYof42qNUFy3Tw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+oYI6tYehjPOC+Iz9OxIjg6iFSOG7BQPs28duaUlgO9TfzHP/7qNllZpyHNas0PmvXSF6MY7hVNM6Dg62FT8p5M11AsSnOMkOSxAfJjmlx0191owVxppEND/mmpLaSho1ceCr5SWnZmejjlDFs2yUbSdwhTaelR+CTwvlBdIm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aORtmaOA; arc=fail smtp.client-ip=40.107.244.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aORtmaOA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UcaBxUhbywDC9ctWujY7TvPa4Hz2p9MDqyRQQ/cJTRVp+PWXf6G41ygnZYbe6GQ103XF82Ar7pTSfezM7KUuI+wiIbRZJonthLKo2AC6d/qCMC6TIxYAjdGFgA5d9QmbgEcDp6mzC2CC4kRglCClSOW29vTueUWlpv762mRmiSiQXKCWoqHgm2UxUt9ZAR7pwaqlwKeiNSL9BUqrzN1WTYkBKfCxBWu25ofp8/PXLF1KmpUGeBrR4OqFE/nmbqZ05RlyCcq0NAEVw2qb+SSO+Ht1OVjbInPTIdiy+32e1osXsNYBcspUD9Oz+eBvpG1Wfk2RDjvkaDLApiNSRi0zIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYDXiZOHRStR3QcG++lSP4zsAmQv0UqQYpq6xUm/YFs=;
 b=T2HMdTwtk0OJBI5dvyl91VPyT+WzARK5af+PNKUfYrhe0wutysUVlKuc56+wQpnbDbq4LB4/Vz+z/Z0Rubh7hD1xmnLY30nDpIP23AH6zVQRTc/jLBph18UcmyvHIPnfas3zbgDpGIyOk7eAQTuLdGIOlxDFAEUsEWnLhVBgdr5nhQN/ZoNtJNkEn4laYUNksd1KAUw8Fp460W2bM1uKkNclAB6WK86Lej4TieVrPWMJergu6l8NCkB9LXhN9xI82m9RfR56tmzEpy2b7j+vLRsVDip+BJtWsGYAutUGgPR0cIMZ4dDnSU/FLiXSTX2hE+zP3bIb8aNvUAPKrYVtWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kYDXiZOHRStR3QcG++lSP4zsAmQv0UqQYpq6xUm/YFs=;
 b=aORtmaOAhSIpyuYobtQxIGrR793qZpTqIrUEW4X/YwIiefzvwKYOLAVFjBUKQ/kFmNykRUKBhrwRujszxXsk9r4JY3LD4yCL1c4aQtN+WebwoszB87wJMLZATMuiqF4FLtXiPaBC5LT3ivoyULC84AmYQVGZfEDHJl1okank8XY=
Received: from SA1P222CA0111.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::8)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Mon, 28 Oct
 2024 11:35:11 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:3c5:cafe::b4) by SA1P222CA0111.outlook.office365.com
 (2603:10b6:806:3c5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Mon, 28 Oct 2024 11:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 11:35:10 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 06:35:06 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v4 11/12] iommu/amd: Add opa->release_domain
Date: Mon, 28 Oct 2024 11:31:47 +0000
Message-ID: <20241028113148.5774-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028113148.5774-1-vasant.hegde@amd.com>
References: <20241028113148.5774-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: abc31477-8e67-4b4c-a484-08dcf74494ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8TiaGPSJg2uNrqelSNb2/9YcsGrvoISEjNpOsUSCocKggKmg7/OWeXXu3rV2?=
 =?us-ascii?Q?sRu17oBBpWE09PH1n8ZqJb598UW1bwBB5h8B1F4OsslOjIEnHjpMUwI+LAOV?=
 =?us-ascii?Q?zG00DAvaicpgKNZW28612WkHwC6sGptakR5tmTxpLGwChmTGIphQJWUhhao7?=
 =?us-ascii?Q?FSOasFKEazpYbxTCclk4vsmqorlFZfQNSkJFI9UQFFtcyNn5FO6Evp5KFL0f?=
 =?us-ascii?Q?bpLJ/TowzeZoxj/74pwUpe2VfNzaMq2YQk+3Vzh/sGgy3RHQ16cnRBvXC3p3?=
 =?us-ascii?Q?CydUdfhIxLTw14f6PRodN87q6ukk/yPQ6G7gwCXd4V8nfHiYOUFQdSrTqMs/?=
 =?us-ascii?Q?PLkM0/Fx4mGHzMKEAEq4W2eoDb4rkorMddulC8AZ/NdQnZ4xePyIZUXEKpVw?=
 =?us-ascii?Q?4wRaYMtVBNCwO+YpQ7BapK3Mi+0+SqFwsjk8SivYC4Afq5UqNKgu/uIjgTek?=
 =?us-ascii?Q?KxyaMrjBQHEdq8ugtaIarL5fbUzIGOhhlNg/AD6eWwFjhYkf1aXcNc9ska+O?=
 =?us-ascii?Q?IVL+W38SR+pLpLQBOnIMduLNwpHC5rpk+MFie5pRyqUducgFRa3TNeXVFCgC?=
 =?us-ascii?Q?ffJTKRzLySrUoTZw0YknOBo+h1L8dKFQioD/cBXCzPLF4ezFLKhQ6p6iBsOd?=
 =?us-ascii?Q?bozDvoVInlncursVs1ns5G56CAkRUslovXC1K8lVWrD8LNU2GJbfkGgiG/iL?=
 =?us-ascii?Q?q0DXDvNQl+Vxg9+bxaK8uVrwdw/LKb43zzU3LoKz1m3cSXx4gduxB63F1npX?=
 =?us-ascii?Q?YkMxK92s3qQ9GuYhEr8ccgBpRae1bJoaaHGogAZoYNmwO9oMmt62sqso437x?=
 =?us-ascii?Q?9ATqw86AwjZzr2Fa3bUyAd4Cp7S6bzI1loJjU5W+7Gn84s+Isck8LKP94L0G?=
 =?us-ascii?Q?23j5bvtLVpqHvBepLJLM9EA3+zbARJ33XgDPRtwxchvYlWjJu5/SMrcdFHuN?=
 =?us-ascii?Q?XOOeJMLWt7oAv+kwrJMb0QFQq6xfLyo8VLy5Yd2fMxC42MeDGFoqUw+aObnd?=
 =?us-ascii?Q?3O8Qq/w3VMI5MuTz7xWWYfAPJTNGtg975s68JKA2hmO6tED5fJI7Z+WtTe9M?=
 =?us-ascii?Q?vuNKY1hcUpxvOKsLjF6sDZBNqBmtCs8e6eN1/nlnAkujJGcPRLX1omEOLSLD?=
 =?us-ascii?Q?sLnv+kZY3vKkfXJt6KKEqrJEXh2kH90Ll4FHJNJOuTUDamO907bSmnLovlCU?=
 =?us-ascii?Q?115kyqNTo52vd/hTpfjp06ckU7FqHiheBdy5WkR8h6/Q/TF9uq2eekjHFtOr?=
 =?us-ascii?Q?6wC9gtxSrfjPpQDtodf1tBiusr8ytuVgBov181B9zcbxQ/I9yIo6q+Ysu+1y?=
 =?us-ascii?Q?/XtjjlNjnp+eunq+bsoK3PF/CmjGkfESi4RcVAZRmzOxJk/UEbnLZZOy9auQ?=
 =?us-ascii?Q?mV5dG2t54n2ouAApWHsNfalRFogpF6Ny8bPeVbvcFZ7/tgQfoA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 11:35:10.3256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abc31477-8e67-4b4c-a484-08dcf74494ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212

In release path, remove device from existing domain and attach it to
blocked domain. So that all DMAs from device is blocked.

Note that soon blocked_domain will support other ops like
set_dev_pasid() but release_domain supports only attach_dev ops.
Hence added separate 'release_domain' variable.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c2e1d87891e5..b613636286c1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2460,6 +2460,14 @@ static struct iommu_domain blocked_domain = {
 	}
 };
 
+/* Same as blocked domain except it supports only ops->attach_dev() */
+static struct iommu_domain release_domain = {
+	.type = IOMMU_DOMAIN_BLOCKED,
+	.ops = &(const struct iommu_domain_ops) {
+		.attach_dev     = blocked_domain_attach_device,
+	}
+};
+
 static int amd_iommu_attach_device(struct iommu_domain *dom,
 				   struct device *dev)
 {
@@ -2839,6 +2847,7 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.blocked_domain = &blocked_domain,
+	.release_domain = &release_domain,
 	.domain_alloc = amd_iommu_domain_alloc,
 	.domain_alloc_user = amd_iommu_domain_alloc_user,
 	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
-- 
2.31.1

