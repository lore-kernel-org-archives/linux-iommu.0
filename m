Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B698D1AA1FE
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 08:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014921; cv=fail; b=Av6tBJjDbOxSEMbp1513H0Sp/8MZHxb/Gi05XvMtpWigGzKtPvSTi+lXxkKLKs5NHpGsaKbbfNtS5HpXyJ9EaaZA38YCkIYWEf+kFuz4wtWL63j+a5/DvmmpFv7KhHQGlK/6E3MC2/wYHCdXMdUXAZw0weTxVB75qXhnDZizKjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014921; c=relaxed/simple;
	bh=lD21JDg/k3h0pvkqEwDVwXPgYfV7UnVzsIfW0cq+DsM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uh+ab5DTHunz4eGri6KNZgLYQaXCkWPVo1uGaoVkxYDmAd7W71LmusnppzqFM/dN0K31ZL3a+B3vfur02zWD6alB0C5aXxXib/S/4QUuXfho1B43al97/SvCP6v+WOiHVteQrEPFJBu/RPrjzdeRUHnll5sARmqmEpPabi1JzhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P/4N6SPw; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P/4N6SPw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p0eKiefc7oKiOclQhUqewKgG4ERpGDooG05D1/MT/sk54zjrURqylvXvs/gJ6NgFmfpHPZ6qoLd+sFhJGanNeFscB5rVrNY9EjenK85C6CAlHxeJB3PlpnqSF+7PfH4La3H8DWFzwsTfH9Nfyeq0BwOKQUHXB7p86H+JKRjp1+biYLMkl6sL4P77g14f1glKuQFKLLlAaC5n1MgfbXoUo8+EB5YsFyQybeF+xgfVT4nzm8Y663lczh5GmmA5Se9BaLasqwiFxH0qHTqpk1Tjl8TmShZl2vEGEhqpS5x4jmKYLDbZ+JPUWqJuSh3jb15h1KBorYuq27HnSwKVvh7U6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2XQ8rL5cX72dgpJ0+K/Y2c1m0qtDN/FGAVsDx1JxzI=;
 b=Y5X9FU5/g69dLjchZS3YukMnwLKbMN7Hfpp+mkxdBvq161W+X1M7INrRYHcScsBnv4eiJal800VyNL0GOrKbE9fR9IyhaMI/y4VRRwHQjVlB3Jw0Wq/YCPyXM/qqEFWLN1+lKbA52n01/NOIYS6WR/r5l0T9DS9usl07LiKnDukggEtK9O8cx/CfduT3AL/z2hTMmNEMLEIYqehotzE7ieHFr8JACotsolC2TRDlbr3XIpxXYUxhi3m7qPdQ6n9dwMcHvwjbxVMM4M9EiBZDkV3ZSwDFWQ/bsthP+EXvv4oCQ23Cx6qEvM9RBk+q/SSSHhgIorcr/wXv6ZNmvl6sRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2XQ8rL5cX72dgpJ0+K/Y2c1m0qtDN/FGAVsDx1JxzI=;
 b=P/4N6SPwe7BvRok6TtvjIrpQAWP3rTdHI7bD16IkFzjOoMHk8cuPTUoT9cOqqY9AB80bNnzwOVzlqQdc42BZciIE2u5KsqmT+zcVoudXDO1DkIjPQEf4UZJSuhVJYMLZRzogCChqWqxy7THu953MCsKHCWgYhUVCGf3ggyz4X193ViupVdGNLrhCmSgwKq7e4o8fRnKfU/DeOKFyhCl1c4RiT3939QINZLVxmTvAZEmTs7XnofHmjHG+2yifYFThMGEjlvPGrxhCjov6UBr3jeVlusNCyuWL+ncuxUIwRUHHCpWKYiFyk+3hMqsNUPiLfUbzwBCi5ucsdwfwIfblsQ==
Received: from SA0PR11CA0195.namprd11.prod.outlook.com (2603:10b6:806:1bc::20)
 by DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 08:35:17 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:1bc:cafe::c4) by SA0PR11CA0195.outlook.office365.com
 (2603:10b6:806:1bc::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.32 via Frontend Transport; Mon,
 7 Apr 2025 08:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Mon, 7 Apr 2025 08:35:16 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Apr 2025
 01:35:06 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 7 Apr 2025 01:35:06 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 7 Apr 2025 01:35:05 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <jonathanh@nvidia.com>, <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH rc 0/2] iommu/tegra241-cmdqv: Two bug fixes in fallback routine
Date: Mon, 7 Apr 2025 01:34:58 -0700
Message-ID: <cover.1744014481.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: 97ef0f10-1040-45e9-307c-08dd75af1fb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?28s/QckuxZyX8U9U4RNNBV12v3dNBjuNcZp/TZnpIBJ5s6fPRAadORDH17yw?=
 =?us-ascii?Q?ulRUr7YT1EjshI3hzcFp/daoK1x1+z/B2egnbuo7zxvZuqIwennzzf/pjbW4?=
 =?us-ascii?Q?F10c86OLBiDQN1ZqsnTqDrgjPt8vZbijz8VIw9iE9Iokg+r0SuRDf3E/R7bX?=
 =?us-ascii?Q?n/px6ObGgkrjRhb1qtIuBhUf6nlvQs1bZ4SFooP8wgrt2//7ZuIOoBd5EoSe?=
 =?us-ascii?Q?HTcod04H4nZr8EhD3wgIyia0QTBJiPbW9++gYRtC+uRaaqQCC2kUmzI/wM9C?=
 =?us-ascii?Q?6Qp1UyLxdlJIE6nO/E/aZC8jWsHSTM8i16Dr7YQdcKS5b4B4gpMO1Sk9myG9?=
 =?us-ascii?Q?fj/ti4XIRSlgNLE09t+W9ogMnTQuyP0USw5w3oRMnexxPUm0RS2bYxwE0gG9?=
 =?us-ascii?Q?XYqx8+mNGoeMebAnXlAd3QYE/iddsaucGdtcmM/vsBa4yYPiIHNrpc6bd3zS?=
 =?us-ascii?Q?rBcO+3Llo40VoyIIbDgtEEOrIfc/YngIVot3HiHya5uW1YOjqwwq1bsjxeGm?=
 =?us-ascii?Q?VELe23e1TZYHr4ILR2lCKyY5S+XZReU1lKJXQQz1fqTu/GcCuxT4EPdSNQNA?=
 =?us-ascii?Q?KffgjRdG+p/65lMO1XcYjrVD5cRxWIZbBpeV4DNbbFfvY1ZijMJSjXLSiAhH?=
 =?us-ascii?Q?W7hjwPTRTsZXgABBPHFKOzDaGMrpHWyHPX7agFincB4bjbMVt7Wj0I62AiBu?=
 =?us-ascii?Q?N3cVV7A/CTV3dx+oK0hFzpv/bhQ1G/yRiwBtggTxH79bolkgEtEAe/VuuNwE?=
 =?us-ascii?Q?izvXm72Z1nbwZRWoqi6vFENfbUJx2z4lJ192nAci9Z5953h+B57Bwu0do4QW?=
 =?us-ascii?Q?0bFQY9wI/QlgKl136eZOf4TFCQoerHKEeZUfgYzKIm7yjno4o9H9Ribv+0uH?=
 =?us-ascii?Q?fuh1h5tNXHoo+KartGEK4oXLdwBxq9U2AgPiQRXsnQeOITdJZCxikZKJXX9z?=
 =?us-ascii?Q?Q3Tts4RtfHlS63pwndqxCtx9HJJwdgSowouLpYVh9f/h8HT6BYm09axTZybt?=
 =?us-ascii?Q?YcKmhU/dAPaG91Mb95LTCFHCefre+q1fXlnPAA21IDkfYdvHK0uewtDZzLAh?=
 =?us-ascii?Q?ixvoXYdcaQ2pnelbQAvAphf6ZvTCdwwLprRR88rajLli6mO/JFWR9J8P3Oxa?=
 =?us-ascii?Q?2ThiKso3KqZj54GqY0Ahu0bOvp+m5OgGIrvM06FsXK8C/02UNz0CSYIT4ZjP?=
 =?us-ascii?Q?/hewSpam5INhNABlQR76dghEUwfO3NhY4eUaLfoZVbi83241cKmB7JQD8SzW?=
 =?us-ascii?Q?DKN1yl3j12BC5USMBcEd0lDGEig//9XxiNE4xpWXeIPnsimxi3tjAwSgGKEN?=
 =?us-ascii?Q?d3ytfYpG9ryzaq1NJKh02zV3Zh1cmPy8V7i2HaD4hhfmqWorGRD9LxAzoYl3?=
 =?us-ascii?Q?qvGpW0qeRPpJK0nuWuYRfGNFcjDMXc0xmR5cjCDRNhFkh4PGha9l0XQKPvDF?=
 =?us-ascii?Q?vqArSDLeFiQHuUOjaxuO+KzMObXkviLBtrCgIiYoY/IwjpUfmVSmUvTXgbIA?=
 =?us-ascii?Q?tbN1w2jtR846fZb0iOvXahSgdJrvMh3+98E8?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 08:35:16.6988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97ef0f10-1040-45e9-307c-08dd75af1fb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664

Hi Will,

Here are two patches fixing two kernel warnings and a UAF bug.

Both need to be delivered to stable trees.

Thanks
Nicolin

Nicolin Chen (2):
  iommu/tegra241-cmdqv: Fix warnings due to dmam_free_coherent()
  iommu/tegra241-cmdqv: Fix UAF due to re-entry of
    tegra241_cmdqv_remove()

 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.43.0

