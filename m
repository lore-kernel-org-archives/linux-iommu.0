Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3816D1757E
	for <iommu@lists.linux.dev>; Wed, 24 Jul 2024 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721842328; cv=fail; b=dPUW7cBwmkrziZsdCSfr5WYSPRmh6FcebQR7XYFpkE9b57TDbmpN4b6JLc5bM9a11nleC13VzGuXhZY8jETOvYUmKSXqhxcLnCpX5nyYLljOkc6yHNlUkO7TVG87QBbevvEGOmfgfPZbL+kFLJHiaya30+CloveLGxMBM6rDWCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721842328; c=relaxed/simple;
	bh=Q2xOMB16OUFpi6zWUsM/hg43pZQ2sKIXKTQACM7y05Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oblMwu0868la6DUDwtJC1MafY4L/zm15oqPp1zkrrp3WIBkJWU+nRMMbQ46N4feKA53wLZxsv27NtNqmdr/yFXM9lBJWs10/eriL6CE1xOz2jtGrkzsEDKXXQKjNFjQkrGcKCkMD6cAanabk4rNxeoymooTZONoiwt7aSU8z0So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n5X0Drnu; arc=fail smtp.client-ip=40.107.102.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="n5X0Drnu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+L9umyOTZARoAG10hFrtu5dsVliJVUJWLQPsnWWAh+A/5OEsjDgjfKCAn4xa1DxB+e/uuz4PlH9w8w/xjjvd8I8acTNJFb485soqnqGlSy2x6zhZE8qJsmiE7zdqa+Wd/B9a8DLDiMPbQdy0u9K6/nagu95+X6aL73Iw8TLLEalakLRY/IMOEiGY+C48ivx72N+6kyvLGnGna+SdQ0vDQGiMyNf0BTrPLbCdh3Qj+gcVreDJbTWmGWpdGmm8H8FH8bJGpeH8bU/uckzXRCI212gm3t3l1AiV+V6Dk5t5F+EEVmXu4gEtIPbO8w+lt5sX87LIAYnPKeEPeeh+rmdnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/TJmzr/zTyko0YAh4CaoY7O1vT9L8tb7Xt8Po9I2vo=;
 b=k2teObZfvfvUZYIF0d6GIyTj8qqVYJUasIASbBzYCGwlgCCaiNQ+Fywi4zV65NcdPJqKs2YbQt0wR91QAxEdbaAQMwJt07ZPXsA5Hl1ZYM0D9fJ37uLxe3PAGo0AIJbnULDkawdD3vKDSJM8U+1pgoSVJ7ZOh3E9IL/5bGxTWVdCxK47xZ86Aj7dQ9NCrWo/5tJY5JZuN4DnaGS6/i0jKv3ZRWp3kbQ/kzJABIxu0C/vqX6ZFizmtMKoRAbTFtO4GQUdixcTWkOXehoww4PIW3TeheU4X2EeswGGyQh39t3CycVQDQzbM2PcpOC2WtOsGOEnwpe1TkTqi7nR7R2FAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/TJmzr/zTyko0YAh4CaoY7O1vT9L8tb7Xt8Po9I2vo=;
 b=n5X0DrnucQ1Sbs6j0yXQ7lfVWr6j5myBeGlc3H7BEyVVme3dH9Hqzql/S1iwII6x9pnYpAZCL81jXhr1DsdYt7/b/RB47zr1V0hqDrzaFMBoQwOe0//2TlVDs1mw20OyUvu5CCenqlaExVf2P7+sP4BxBvgF2wuWRdV3cqhyKPHh8cQCtcOMb3kEt0oSmWNSR565cw/dDkm9cUDFGPGTH85h/SjoyaWdbVYS89C599YbUFNH7mcU/omHr1KbPKXMT3FS3uOzTKxBKMhSwchsyKAZEnbsq1twC165iDLjBDlPuO2/RHCnhBbBq5Q2vNAEm7ShfyOFFQvlMUeHxgAiJg==
Received: from BL1P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::18)
 by DM4PR12MB5889.namprd12.prod.outlook.com (2603:10b6:8:65::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 17:32:04 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2c4:cafe::98) by BL1P223CA0013.outlook.office365.com
 (2603:10b6:208:2c4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Wed, 24 Jul 2024 17:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Wed, 24 Jul 2024 17:32:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 24 Jul
 2024 10:31:38 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 24 Jul
 2024 10:31:38 -0700
Received: from build-amhetre-20240716T042216611.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Wed, 24 Jul 2024 10:31:38 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <will@kernel.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>
CC: <linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH V2] iommu: arm-smmu: Fix Tegra workaround for PAGE_SIZE mappings
Date: Wed, 24 Jul 2024 17:31:32 +0000
Message-ID: <20240724173132.219978-1-amhetre@nvidia.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DM4PR12MB5889:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f4dbdb-b00c-473d-24a7-08dcac068899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vSOlNHdJ7fyFm6t9uC7yKlZZa3D6nmu8zBsWM/8VdOTH1G92SN+U+Hi3FAvO?=
 =?us-ascii?Q?WljPq2oqsKyhnsW4v+iq5MSmgK2bRa3q/zRQvamPfMsFqddwfRx2WKtv7nDK?=
 =?us-ascii?Q?Pma5dw7nam54YAuQuAIMfGljh3P5CtgocWdx8cB9BX5DW+bKlugxt2Er0qD9?=
 =?us-ascii?Q?Z5qbZi+InX2XOham2JLXWOxfwR2uEwoQyLAtQYO6ofligxw1Ho5h3YrZZTQx?=
 =?us-ascii?Q?y9gKPlfOMzzE5gLtY/JjD4QT2hi2Ify8rWAx51yDAaRg/2QvquoGcqktot+b?=
 =?us-ascii?Q?qTNtobtX3NVh1jBj7STg5RXNnJrf0qPkrW6E5roi/Tpatd7rBjMmyLPoHDzp?=
 =?us-ascii?Q?mtNKIQgJWn556df8s72jTG3uM49p+bMLiCrcFiQ80Fm3h5C/0ZqV8xHjaV/7?=
 =?us-ascii?Q?lJ+lilteqrmI2eYFVSAnlHz12v5Kui+e7PXDNKUcIUu71HpocMG0WFmMNPce?=
 =?us-ascii?Q?0siiNvJfXKbKIl6yWo3gCoIMD4Jx76dauTgMDJLcL2Wnus5/HiUjIOh+Cy8U?=
 =?us-ascii?Q?e1cxmHTD2hEzG2wBqKRm8aq0E3Csz8+O/zWgs9JgR6MzKBzive/Q8+Nq2LuR?=
 =?us-ascii?Q?E6xXxy8UOM78mxiVCenGSVRJi1Xu7c8oDVEc/kGHJK7xYwuhAIO5r6LaqqHm?=
 =?us-ascii?Q?W5gqBF1T2h9/z+E1aA0tH66YtXYlltCRQ2OSovYLiHjmcL8fwTt3OG5G7myN?=
 =?us-ascii?Q?6ECFx3sx9AEzvoVWG1uch2ivKKwGcMzZ2a3Ux0pIJQQ2mu6AOGIsXHBGIffl?=
 =?us-ascii?Q?6cA/kPZ6Cb5m+XfCK8qhSRyGQ48AHvktWthWqh21cd33xdW0/Pk7hhsgmuQz?=
 =?us-ascii?Q?VkyT/HpW67pQ/sLMlClOdZSGTzSKij1lARivGaHLC9G/pa9MblcY4Vi5UeQS?=
 =?us-ascii?Q?9blDOHja2K48GCzgg3AKi6iPsrYLKVN2+YYaxHj739B8v3lS6xuc90v84ssh?=
 =?us-ascii?Q?GNcHZBX+4CDjhQLj1g9Ob/5a2qnAOJT4CL+c26a3dAMFlLwRNVs0D7Sk5y9d?=
 =?us-ascii?Q?PK0gfFi1YqKZ976H7STMj6uH/0M0Aw8XeYmU9ALSpXRdKPO76Om5Y0uv1VU4?=
 =?us-ascii?Q?oVKBx+DHLuaSY8fK44QAvZClR0w78yU5q+QESK3Ne1rbdz2F/pRAmz5eKgj4?=
 =?us-ascii?Q?EQmyFrNXXnnPEUsWB1MlU6ya2+vERmgm7rPDGSLUyIJ9NO0ulLvYtbmEN/0o?=
 =?us-ascii?Q?iaweNv98SqIm3bNa857Z9oq5T0Nf3rTe+7VQNuxlYonKIg3KAwhOBpRsCbZR?=
 =?us-ascii?Q?Zob+BlGJxpr8GDyUQM9a7NO9IJE+Q01dQJ79mwlO6cvkklIme1HXbqyUmqWX?=
 =?us-ascii?Q?c1/8zKcDR/whtr1815GNQ1fG4CfWhzoyU9ujcufytckKgGP70YE8CPzGUjVG?=
 =?us-ascii?Q?RTzfniSCzjiGM++yiXmW3kY7d6V1Q5piG0cIdj1iu3lmT8Pm7X+ISU0JMUJy?=
 =?us-ascii?Q?6sAgY+/00UmvUsQbFTDqHu1Y5CCKc7KP?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 17:32:03.9411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f4dbdb-b00c-473d-24a7-08dcac068899
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5889

PAGE_SIZE can be 16KB for Tegra which is not supported by MMU-500 on
both Tegra194 and Tegra234. Retain only valid granularities from
pgsize_bitmap which would either be 4KB or 64KB.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
index 4b2994b6126d..2fce4f6d4e1b 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
@@ -277,7 +277,7 @@ static int nvidia_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 	 */
 	if (of_device_is_compatible(np, "nvidia,tegra234-smmu") ||
 	    of_device_is_compatible(np, "nvidia,tegra194-smmu")) {
-		smmu->pgsize_bitmap = PAGE_SIZE;
+		smmu->pgsize_bitmap &= GENMASK(PAGE_SHIFT, 0);
 		pgtbl_cfg->pgsize_bitmap = smmu->pgsize_bitmap;
 	}
 
-- 
2.25.1

