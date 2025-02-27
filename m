Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9971ACEB5
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674072; cv=fail; b=Z+Hv4U51MVPDQbFcJFDKgz+J2DMX9S2UplJGUuupwy678w1cTKgUUq/YjHlgn61VOw51lpyv+2z0vaXuNDerJryE1K/L4Rmk+t6lp8gMTdDdAxUCq7Btw8soKYkmVCiuW1kzkR73RM+uCBvGRbg/Bt3nzzfIcua5Xef8UqW0ogs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674072; c=relaxed/simple;
	bh=qTPBc0o2q6oc8FvAzDtgmxb29qRKiDx8YysGoRtgWYw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gbhwNE6v9kDkweGcGpvGE93Mn81D8TZSQ/8ZmosneeVtA0UcIN0RbJFo+vtOUn+GNLHxgHh7njMP21ZUMxEDDWhktaCvwLq3S+5tCmDo099gMufBVuWN3B3dAHhj3EImysq1g0pjzs6s6Cp2HZSd60GfVASG/KE05n0nmbcq4Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BdPm8NmQ; arc=fail smtp.client-ip=40.107.101.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BdPm8NmQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9vprCTyctMy1l54m6ujaBMW7S3068pXvhUtvs9iNTACOumnUQeaUuol28dxCX3lt2h/zAqKuR4IJeRHFpYSuMtXtMGtB9l/xytvyQ9jgGw9MWuOn2zcB7rDx5uNBlriUcguSCeav0f9t184tlfTtTQ8dmamcBMsurrb/ZU7jVkuMaUmMvIIeyyAA8QLvCs1LSLmDXLGNKbBt0h2otjh9lAEcQiee+4y+UKo1JEl/583OO+u9OXxkNcE3mUa48CIW0mlSHxK09W1hsKBPjnBTWLPRy0B/vIQtXlB7ZNJeij3u1YR82A6Wrdf2Ezth9zn95X6/+cOZKCRRsEAhUFP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iw6qziX5lw2n7jyC3h1Y6D3TzjX59RQUh3qmvjFB+wA=;
 b=ABqN3hYj5r1LDE0SbbZxYHuUzSz+2b74tBnUEv5MJuv//HxAJ091SzLrR7nDHssNKLexv9c8DEvwNS2Vs85D/xvagMDVh/n/uN9A9Wf0DRuwv3DcJw9oZA/Cbnke3f8mYBg+hWu3qhZt/qfibq3oaseJGTWaFj7X66yc3ahR+KXAXmtz/F2bZ2oDU0+JPGRjwQuDyXVdj84IlcNk/LNsphm+B00C7Xmu8k7bpEzA/YxCYCkZVvF7BONRcAjZuJzw7w1RtHp4AxoPHqi1a8QSNFzuiXu8eSPzm/Sxwc2X8joDRRGP6pE2yjaBsupGM/0Tg3v3KQ9sS58Tod4oP0pkBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iw6qziX5lw2n7jyC3h1Y6D3TzjX59RQUh3qmvjFB+wA=;
 b=BdPm8NmQFVTDeJltDZmftmy2Q9ciP/YDSGZT/nW/kTcjd8PBf0mSkvM/9jKFtAoGvJg7Bwp3J1kyv82AZ+8yrwkgFg0DyUndcgjzpMl9pzGA6aXURojZ/AZn0VoxL6RnB7c3mj9lL1cXOAWxUvEYZd5psTHO967rzC0Fw21mpcQ=
Received: from MN2PR16CA0066.namprd16.prod.outlook.com (2603:10b6:208:234::35)
 by SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 16:34:29 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::9a) by MN2PR16CA0066.outlook.office365.com
 (2603:10b6:208:234::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Thu,
 27 Feb 2025 16:34:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 16:34:09 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Feb
 2025 10:33:00 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 6/7] iommu/amd: Remove unused forward declaration
Date: Thu, 27 Feb 2025 16:23:19 +0000
Message-ID: <20250227162320.5805-7-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|SN7PR12MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae402ba-2977-484b-c1bd-08dd574c9b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i6dL65LmuMb/puMaspuBvXQOQoC+qgUpRFTvMDNEH9cKMfzDgVyYLu2rXRul?=
 =?us-ascii?Q?xnofu5cMAZAgpFSigTTQScr777/h7TaW3wfE7qtCDG4ezjWN8Fgip345fizO?=
 =?us-ascii?Q?k/SYJrSOizhXC387vr3iJ4beyUQM00E4PjHRi4IkWRRPOKTfFrKBpqm8EB1y?=
 =?us-ascii?Q?6SUceK/Agy/oWZiMMlkExt2eUuX2hRJbZXFEAIMtXGsQkNALMLUe/fU6j6XY?=
 =?us-ascii?Q?IUbzs5QcSppQa+Or9Plc1vdwVvnV5+wAgunf5vdUZBM30JYi6i5OVwJvT1kj?=
 =?us-ascii?Q?SPoOb9oas1cgHRte1s6joJ0SnhDj38qnIvxDRpwfxgwvkee9BkGcTFVeXvBM?=
 =?us-ascii?Q?1dvuK+q36w2ig3vBzb7hnFoIrosPYg+I2Ntbtl637BAAyWKIyTCbcx/946Yp?=
 =?us-ascii?Q?Mssnu0SqegYARP6rLN1XjyN/WkL9aFetk/HKjsJo8z7IxFkMAssffg0vmkmD?=
 =?us-ascii?Q?oj4B+djcaJEKA1i3buPzJxoXv4PiGuqfj5M24hg3PLJIE+Rzl+uO0iE0yxQH?=
 =?us-ascii?Q?R2x1rBYzQymuir417Lchu590CCD8PpVsvwBOnMV654ptwLrJCuKGrqtDAGuH?=
 =?us-ascii?Q?Lj+I5Wt8N4defVN8qxpF773ks6QfZB670u+8y2gH4s2ELbAlugpqdeIqhexn?=
 =?us-ascii?Q?XzFE5BE1v/S0BRjnduVhKsjQYSw10GHg/gzMwQ8MdfNpICsuaZRfZec3wEwD?=
 =?us-ascii?Q?XHJAQ9U3ewEz6MaA5jfjxClxpsZYALkZdtdgYraWqaADFPrqOxFSXzbC9iE2?=
 =?us-ascii?Q?9tNglzmIaFbpJCi1nTn4WWMeZn968SCNyw57r8YcNiwAHDb+Nvm91TjgCaxH?=
 =?us-ascii?Q?00VR+WdpUpSlVEwA+3tbbyhrbVAjM4BRomOnOWozAfBdm5GEinOJzaplATrr?=
 =?us-ascii?Q?HxVcfWtvSp3WYnDyoVjp+9EdOHH6y456waGRHVBUYz2J1pgVEtfiTBy/CVc7?=
 =?us-ascii?Q?73XDA9QUCir8DFAZkR7YKcTaAiSY3ZQuF4jVLraNaGujAC3I3ErIWaZjWgk6?=
 =?us-ascii?Q?3jzGa1F/vBjoJ8diTMjEuA/kT7W1hUpk764invYN+TO7R23Sqqz43svATep+?=
 =?us-ascii?Q?9l9XzX570vUDjSoOi2mpISwIoRkfUkEXchPYgbY92siF2ts4slZwHf0y0hXP?=
 =?us-ascii?Q?kx8plmBd0jJtM3rn4u34HxMjTGz0PucljaUBxRhM0qN9soaVPDfG1bTz662h?=
 =?us-ascii?Q?M3Q84BnVXWSOUI/vc89dsRAVo1McMD92aXghxmJG42WpMv+j84SwzLIac32D?=
 =?us-ascii?Q?kISApvtPKG9rMPOHyyyE5APgxB3YntAe86oqHsLUjgicQrXZzYwh8wMOLyv+?=
 =?us-ascii?Q?jBzDzT78tv99axetx2F17n3Ri1Fm1r8dI+bp2tEcpNKGfyhDvyq1FdJx5YEi?=
 =?us-ascii?Q?clqY/wa72ZKv06imjXTQ4OYOLN270Vh9yw8s9yhwWy15Xgf8p2wNsOSVid5J?=
 =?us-ascii?Q?D1+7Al4ybdS7vP4YOoN/4SOhhNNG9Pd1wBWgrgVhuS9IKXzzTepNGF2lThep?=
 =?us-ascii?Q?4OabyO0Keyygl0M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 16:34:09.4580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae402ba-2977-484b-c1bd-08dd574c9b05
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8131

Remove unused forward declaration.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index cb536d372b12..94aaa4b2a903 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -219,7 +219,6 @@ static bool __initdata cmdline_maps;
 static enum iommu_init_state init_state = IOMMU_START_STATE;
 
 static int amd_iommu_enable_interrupts(void);
-static int __init iommu_go_to_state(enum iommu_init_state state);
 static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg);
 
 static bool amd_iommu_pre_enabled = true;
-- 
2.31.1

