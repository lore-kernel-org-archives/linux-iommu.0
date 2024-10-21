Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174D81FDF85
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729552151; cv=fail; b=OaDydZJRVLkbYW2Uy8BPjDXEAFb2R66IEOXEb73lJF4j9mrOeSM0wAOOf6ebMN3aHrkc22i8/JthsNiTDTKdtiSF78iv4H4Nip67og4XLNUP/AMnetZRaSWggAmlxD7XJb2qySlMTHiO6b9j6l7ndAvt9yqW2LZoirvUtfpK5DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729552151; c=relaxed/simple;
	bh=ZlJy7TsHJF9CZZvuwwgfVIKQt0LBj4015Jr6UKIBO/0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T0xP064ZsHSI8iu8yLBBnVwbmYUka6fV1lC9dYg8ZShjCcO9b1h3qXjbjd63xX9vxaIeu+etf3fnduLIMSjHu6o2ZPK5nAMTPLlzwE4B+EVMdmKvR0VYqYkVbBIhEw3qXAeixsRPrpp82lDJdWuG8bMKZ7UAY0Uj3H8dHUqxI+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g+E98ERK; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g+E98ERK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GGKjefCo2K4aOzzGQHxYot0zNglkM6+j8EvTezUBPGrmILjcNuylLNJAwjYxXfpLVWc02Pw3WSbcTZOnlU/RFSPEEQqVhoauMjAaA3Pw34X8a4/IeNalH3p8FZ3sNfkKyEgPQnHe5TSIXWhBzS/qN0TEL1xUYIPbKbzPB2GAXfQKh1kFpjFY1HTIh6uFTx6LxsaOiyezPRI/7I8E3/QhrEW14g5+Gd9FxI8EUOnK5QqBECwS4chuq9jotHEqWoP4zpnv24cK7x2WOxmbxe4n6iBt6nnThJcf4ts6ObZTQGpz0K2Mnhu9+1wVswHWVvcVHeACBL2QDgdf6DSMMwV2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBBx6ucmCPHgdM14Cm9fhaj2Z7ZEuzt6RmJ7fuKaUOk=;
 b=VI4K3Gc2l0SorLevHfofLB/h6PvPsdBzfE7Xr3VJXOERqnPXI3nV5NKXUIX+xaIsnYBTo/2C27Lbavp96Va4arsWZGKKTs2tP0IOmhPSFcoIvtcFGZfv/cGnvqc+jXmSXpKquIaksBJakc5c54i1TL+hGHvy+n9uZXtohUA48jD5cmySHv91g3wpDEWk5Uw5EtNsqoAmpiFYrLUjhVUd8yWTSbzV1R10Y48hZW/Otr8AG37CMUinMErQYKXRNaM9ypgeHAaOPsT9rUT8d9bQCWQQqe9Y/HylNUX+/YUVDlclLDriG1lzd+oxwrkv3PnL7cYyc7VOcuOh5NlxPWemsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBBx6ucmCPHgdM14Cm9fhaj2Z7ZEuzt6RmJ7fuKaUOk=;
 b=g+E98ERKzDHxuUpNNt7YLWVOk/l1ce+veazfDHUJY12ejQGdyu9g5B42IoqSgL27FBDvY432addui7/to8f331atTIkcs6fg0XuF9FZEe8JPknFeee2QQ9H0ztBcFiINsilAER295PdAHY80OQmz8gCPTZpNBnkNkJPssqsXdxdsvmiGbGCMOrja3ahgAZ5XlCp5+7edTWE7BNLZWOR5YsNg27h9CpB9UIzMdpYsxIhYzOzC8pFxKIqwfwD5T4PcG77OV16GrS7xt+bjLJUWaSvb2GPD/IjZkKq/7fQUdZzHi1r0SAPkEV7N2R8TMzaOc5UhsqXvjkb3uewRKv4u3A==
Received: from SJ0PR13CA0186.namprd13.prod.outlook.com (2603:10b6:a03:2c3::11)
 by IA1PR12MB8309.namprd12.prod.outlook.com (2603:10b6:208:3fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 23:09:06 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::85) by SJ0PR13CA0186.outlook.office365.com
 (2603:10b6:a03:2c3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15 via Frontend
 Transport; Mon, 21 Oct 2024 23:09:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Mon, 21 Oct 2024 23:09:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 16:08:50 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 21 Oct
 2024 16:08:50 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 21 Oct 2024 16:08:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <jonathanh@nvidia.com>, <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <mochs@nvidia.com>
Subject: [PATCH] iommu/tegra241-cmdqv: Staticize cmdqv_debugfs_dir
Date: Mon, 21 Oct 2024 16:08:46 -0700
Message-ID: <20241021230847.811218-1-nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|IA1PR12MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 27689047-0f6b-42e5-b712-08dcf2255c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FBLnAFr/fo+HSNshMNt6bSgSHAsd6DGEZG7L80KVs4QFyw1oPUTJsVF1zrpW?=
 =?us-ascii?Q?Y1A7VzNIBm1d3rE6hTW0pwYxGIk+fAKF7ITiwDQHfEnklqfbFXwB2BJgtlcp?=
 =?us-ascii?Q?EBaDFTk1WkB4kQSAQiYF9rdmlxNNAIOht2Gs8YCVZBGfssFCWqO0XMiooFVQ?=
 =?us-ascii?Q?eUmLMJbOPAGumTYF3397c0/aZ1awK9yvaUBP13Cn7iUGoU84UqkwEdzVyppu?=
 =?us-ascii?Q?pQCLwdt5xT6NZ/QlFEaohPPaM5f19qfWkjz1tNjqohgPC2W7nXctoTiDfqyP?=
 =?us-ascii?Q?0R7RItCT2M4gLv3zA5Dnv4DE8i0vzDdndCTjF4CggAXFioC2h6TLS2NsUHQP?=
 =?us-ascii?Q?52Dnzb3zsFK1vmFb3Ia5bjBeIH1UkEcbtznxAkThL/rxyrNF5EG1pYM2U3bc?=
 =?us-ascii?Q?ng+mwy/DxiS2HrY0k9R9RTT5Mn8OiLG6adDXTYhc7NFTYdGdjZtNgztJqmVN?=
 =?us-ascii?Q?5pVBjIU21H8y5rUrXyo1SEDVh4ZUhb94E5XqRjNtuA9ZwoOfePOVprKC3DO2?=
 =?us-ascii?Q?mCTBctSoGkdzzeZ36y8cOEpzQ5CLnwzrxTXQAh19Pb+P5EEMUq+iOn/BItHK?=
 =?us-ascii?Q?C/wTbP24h3FO95L82PbxycFVyHK+Znc8DZiAu3NtimV8zoPtIQ0MLnVAIhnD?=
 =?us-ascii?Q?2jy/Zy2NGtpHJyXfGxVNE+ddCJZsGUtdeC6Qp4UBuHOdBFotP39QCqgxiAxG?=
 =?us-ascii?Q?3bMIv2Ev0vqZo6RJ0J37vmPr8Uf3VD8HkT4zS0Y0lh7rYsYMh0M3jtZQG+2s?=
 =?us-ascii?Q?4oPdUd0DzgnnHY4p3jLfkl3aTM7f73Y8voH8E0pxWJ7K/zBn1TczmN4emWgd?=
 =?us-ascii?Q?q22OiBXzSyuOd5XN8JyGKifYzgp7uMpJFI5tVQUfpQn7DSrCR4p0Lw8SVNpA?=
 =?us-ascii?Q?kzMiR+uNBkxWTkP7jNFGRTU9E/Y9gEevSFcvnxK40Jc+EkVnWKVPAJoIeEn5?=
 =?us-ascii?Q?/t+JwgKKEXFL5jSXQP+c08zafR4PR5+OAnMKZ3qaq8VYw+ZOeJknMreGhI/X?=
 =?us-ascii?Q?f0FfIqILax6lyr6/glOUinUqRN2nufJCbcimyG7NDK0ffFu1TJJ262l1yXQs?=
 =?us-ascii?Q?eSDhd/7uhtkHibkXo+fTTTp/RRFDp4oaK/MlrNuvoPntwiDmd6+3fLXuMaeU?=
 =?us-ascii?Q?lZZ4qKDA1Vk2qv6YiNCkblzLHAGmMDkCQylcZ+9is1WwTRvp+7Ex94X3O944?=
 =?us-ascii?Q?FiNn8idpemcCXEx9NZ2MyqJIkH+/SNAFrMzPiklMTMH7qSUXz/fgsPoW3/YM?=
 =?us-ascii?Q?WgCofRKwWB6B6k09TOEU630FGMvuZJOq1gJZ311ZZzTxsvPmHYGsoyICcTBM?=
 =?us-ascii?Q?OrsM3xzG1uk2N4FQ4IhpddR4d8gh32wKG6yQSY6F820TgI4RB/VgrfWs1IvE?=
 =?us-ascii?Q?HI3jiedfs3ebW99cHMZ3twL2mh6nOmlyCq19bm9viq0D4ksxDQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 23:09:05.5824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27689047-0f6b-42e5-b712-08dcf2255c61
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8309

Fix a sparse warning.

Fixes: 918eb5c856f6 ("iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410172003.bRQEReTc-lkp@intel.com/
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index fcd13d301fff..a243c543598c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -800,7 +800,7 @@ static int tegra241_cmdqv_init_structures(struct arm_smmu_device *smmu)
 	return 0;
 }
 
-struct dentry *cmdqv_debugfs_dir;
+static struct dentry *cmdqv_debugfs_dir;
 
 static struct arm_smmu_device *
 __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
-- 
2.34.1

