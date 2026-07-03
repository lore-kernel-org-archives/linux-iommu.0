Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CE935E1B7
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 05:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056738; cv=fail; b=QtXa4g41Bgp79UinsTzvKRrNwRawkSUeueQie6V3CwIPGToQbGec0aBTXMr4LJpE5c687BRs3Ockv57e1Qka48lPDEos1rBEmI7B8Xjojw2tZJvewlZQ0WcJQM81yoYjVtfldjQlo5f+VZwA6AkHxqSiDC9CUbeVlOo97UqYaJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056738; c=relaxed/simple;
	bh=L6vSZlnkKzXT0/u06WpyGZkVTuh2d2qPddgWaJtDvz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F4UQ08Pt14FYOPvC60b/uhEPrJfTPIoM+SZgPywRbwiE8cho/ac8mYBv4J8/jqGeBAFRYb44aBpm2OBMcy9rozDpFSO6qQ+LOFZfi4Tu5xlftIEmPArstFZFU8NhNBmDtQoMg0CC7BO6mP4GCp7Jb0uDnFtSvQ75pOd57Wepl8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kJRlAt0o; arc=fail smtp.client-ip=52.101.53.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kJRlAt0o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQ54LE2mafPxsCGnwXC4JRDI7RloU9aCo5U0hzWOwOuMkpaz9gurah3JvQ+UcyLblnYsB2E0sgfEdyEFj5ngxNbJ160EtJPRiZShvJuBaS/1DrzJ7//1WrP6ePI7cYMZpySEaZocZBYC+KhhHSjoNpgNXT/Es1WW6qKVmEpkClcJjt1DpoxIA7/qJ4bNJkk3oAQsu9ZxkhXY9Xs6eRO/dft1EWcEJIehKuJdIIgZkeGOiEqgYM8gqckH9KEr+Hs5r3bHdrR0FN+Wbggr3yZVdrz2tqFHfL0Spy1/vvaQMeHB0BXDb1zZW6QKNAk0JckccJ0NnLfg/Kbgiv9QQaRTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDmi1qOMqU+TFJl+nhjVsxCcb6m8FjYYGcjO/oHi4AI=;
 b=nSl1c5W4TxcVlbY4MHorLg5NNjFMDa5FVqtOby37FmliqnVEfqiKTRj6JpHJ877XrR/OSrw30MMSQTkLR7bg7vWF3t5w6vybuIJUYifL8q+xDk49ieHHx3CgXu3WO/AasG2GUX9mb5E9M6obc6UiUho5un7a5FO8ISHQTKO2NavQX0bE4mLF5ltKseSmar5tPEookUcGGerTvNTAtbbIpahwOQ3cfdqr600R4eCTZD8vY0ldzkAnGwq8bftuxPqIPAQke3xd1RGiLApVICUIfh8wpH8EBl68gTrOgoOou3xu2q+QEHdflp0elf0CzXbbzIs2oUN+iY586etAwUBi/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDmi1qOMqU+TFJl+nhjVsxCcb6m8FjYYGcjO/oHi4AI=;
 b=kJRlAt0oJ2zz1S0rchMmz/mmauMMmSb2mV4QXlnIDxLc04GzebL8ISNvXrVA/XXDesPunLVh2r4D6EnhHUxD9V9SQLaTGpvCqSSRGrAh5Cg1jQq7A/2Hw5daSzQ5+UG45OVC0BcqJ02VbASZV58YV5NhnIslaFy2SLTjeDcLAPIL7tWLQ7HkfeyQYOqwRv/pPK/B6cU5BV3dxyEqoLHzd5xULA8QmxoCFxZUISCHDrPxhkq3oHRiY8yhiNdAyQFrXyq8oBriWSX7+4N9k2BOLCNyhbWro9KuZZvLZl/DEHwoW08sohX8r9KSYuGQ+SeYUgyH8kKjfV5eOcvO+St8ug==
Received: from SJ0PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:33a::15)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 05:32:03 +0000
Received: from BY1PEPF0001AE18.namprd04.prod.outlook.com
 (2603:10b6:a03:33a:cafe::6b) by SJ0PR03CA0010.outlook.office365.com
 (2603:10b6:a03:33a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Fri, 3
 Jul 2026 05:32:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE18.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 05:32:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 22:31:50 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 22:31:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 22:31:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 08/11] iommu/tegra241-cmdqv: Require exactly one Stream ID for a vSID
Date: Thu, 2 Jul 2026 22:31:34 -0700
Message-ID: <3177c49c4d9f24b1dc001d54b5ac30e5061feb7c.1783054570.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783054570.git.nicolinc@nvidia.com>
References: <cover.1783054570.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE18:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: a64bdc81-869a-49b4-f876-08ded8c469d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	qC2zMqExHpYcVQ9xJvEmsrkKUa6i3yaKD87l1Ev0mTROsBk0urunYywbf3Nve9vdCcFpjTLXM7DbXGy/ILrIvmA9IfKVuyC8HfDuFp9tESsdcAflE22gwIKEE+aW+s0AzeoBxosxQGA0Vs6HYSkuBxckIYHr6BNSwj67+UXK1w4pdVMJinNyeiSQkJvXLeJjHRbEFRBFJJn6dJ4cMj2nhidSoALUittz/mOemXql7tF/6mAO8IBxppMFZ+NNlCcn78FW3la66nWUa7Y4K6BsJkNeDsf7G6KcFOFSMbYLDwDOaPmuF6Se4N7qCxwN6pWCA2jhf6k8P40fwbb/B7LpaUUzQMTt2zp4QOzr/d2obbnlqlpR5rXZ8rkSEWALvxErH7Ycf4f7xRCkQg+Nxomb6C2TwgL7YPpdj52ocDy9rCxTStPFUj0bvrGJny60mstBHUZwFr4EIYYX8JCaYkEM5Z87kCJSNiirL9Uk4VXQGLnc/SiwqhtWKXHTQfq0a0CV8F8/7aX//v+OFs8vP0t4zAff/m14kRaqciq64cQIww35FQ6e9w/Mu2wXbJaQ6fHX/Eu1QiajUXtn1MbjrD6aC5lr8mswRFyrcT6mPeiGTtJsFA6B2vXQE63iXGkyYLU3i530FMe9FBw61VA0QbV44X/GV8qTVx1yIry7VkNXWAcoTpHhNjZfZygL0ET8eOjKCKi4Xt744+SnEDKHIsMccg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	REgfUfiJelojRH2/OxrdPpXGDWwxQ7UM/snVhTP4rZilOIxZB9HLlS10UzdMl230hIlP2nbBtnyDAyM2g2+wWLmDMH8d+2yATxyX2qrvs8g2HXfqw13MulIxfsDL5uDKkyK/Mcb+bjWqoDvGdL/5aZKHYoi7CHIr8sDuwQnsMmalsn3mEM4upJpxuZxThtFDNrgCJg9JDYOi95RZNsfUiKhOOsWl7roIkEIH2fBsM83rbjirLLyb1rThy/4uarqb5ZaRW8G/vathTjfSmr8HvKtEwCJnVBLzqCj6fxRiZjH9RG/D189owO8jugmAgRWLOYTXdWKTe0EvTDJn6PFXpNu7pS0MMqZb8f9VKs1VHEMJERcgk6JA8IjZZwq/MNLDal0fiE8giS7vNmfm6BN9Vdc/SOyRoohEC3JO4wCoqyKEhQMRoXZ13aeZfkUQ4U6C
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 05:32:03.3640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a64bdc81-869a-49b4-f876-08ded8c469d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE18.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030

tegra241_vintf_init_vsid() maps a guest vSID to a single physical Stream ID
taken from master->streams[0], and only warns when the device does not have
exactly one stream. A device with several streams gets only its first one
mapped, so a guest vSID invalidation cannot reach the others' ATC and IOTLB
entries; a device with none makes master->streams a ZERO_SIZE_PTR, read out
of bounds.

Reject the mapping with -EINVAL when master->num_streams is not one, rather
than warning and pressing on.

Fixes: 4dc0d12474f9 ("iommu/tegra241-cmdqv: Add user-space use support")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 812cc500b4a1e..aa0568e328356 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -1249,7 +1249,8 @@ static int tegra241_vintf_init_vsid(struct iommufd_vdevice *vdev)
 	if (virt_sid > FIELD_MAX(VINTF_SID_MATCH_VIRT_SID))
 		return -EINVAL;
 
-	WARN_ON_ONCE(master->num_streams != 1);
+	if (master->num_streams != 1)
+		return -EINVAL;
 
 	/* Find an empty pair of SID_REPLACE and SID_MATCH */
 	sidx = ida_alloc_max(&vintf->sids, vintf->cmdqv->num_sids_per_vintf - 1,
-- 
2.43.0

