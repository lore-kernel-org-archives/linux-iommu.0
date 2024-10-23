Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C14A136331
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 10:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680178; cv=fail; b=OFoCvi9+wzZoUKASZr7IYtXbmqYVTNHPlHoSfs/oYdVk3ADXb0ahpetvuEpQEPmLExfrZ0e+MgnCGiz4DpBdoXns3OZAYDA36ya8cSW4J1t94jKe1y7UzxGzVl7klLgDek4lypu+KCRFeqjm3SEtBjaGR4rrusSY+2Gi+jpFW64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680178; c=relaxed/simple;
	bh=X/APcutF9a/bXlYf6WtUSmnIOcjwL7rV2/80IdOXUe8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ESzoCoE1qoNgBdd0N6uPyZO/mLH4SzkUYD8zptjgwDJtQ74jwXhKH8F208AM2wUU+h9VPkeAAkVubkltrAY4Nq4auUdiAT5gQNQn3sDP9pTTbNZhzeTV7JyJe88qEg29dpvzE4pHniIanaGapVgEfpEMKqEPrJvdudRhMYC70a8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X8ot3wX/; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X8ot3wX/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLn6SLoUYesJi63q0VWfqnv2p0nyAK8gGu6je0ZDwWPUaHPz4OQxiPy+9jzr37hwKEtFsmKI7IUHggP4KNidv4Ooaw2JZjocqg0HdX/pbiSZnNM0ggpj9q+avjxRuV9czpdN2ysy2nixX3qXuJlVFGnT4vRdkoe1gPnEQwAdftT4jbL770vhri+YFxIj4AUBdsSY6pCNiZehEsjYwzrPt6CnH6wjTXXd/v23TOslIPyixZbSKnWzlnG83tXQStbTMvf+8e+DQ+QLbkULzScmTcTlt5YQON6eKAwl+kQk8uNQpT4Ozv7ntRdBT6rXrL8tDrzO7VYD1ztQc8003904Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHDUevirY/a3ux1qh23oq5+yEOHQjFsJP3lyxzCjIaI=;
 b=waT/sljs7MU5JoIVmpbGX0DLVOAZGbchafDQdwarZOspsf03IZRNYSOE+4UFW35gWTtEI1uUKM3pLWKGF888xbSpz5TsOAV2guSc0KV/Kj1ZY1eTEueRxp1ec3kNyYDDex/1CBN0JxO7c4KwDf/M6Z2xnm8gxatfri4F7aPp8PzFslrFrEVMIFppqh9wzgcIkCNF0CcO5HxP4My4JnfMw4eZ0Vd0cX2YAfQyvhXe//qa3LN56K4ieiZ8MGgKWO0HxImfBgsbsJll6g4J3uxlDvVIsdnCpx9COSDwZPzUzWzKdyIoa9uS4rLujc1iTiYdJ+EBy1A4TFl+WH0Unee5Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHDUevirY/a3ux1qh23oq5+yEOHQjFsJP3lyxzCjIaI=;
 b=X8ot3wX/fGP7aoi6YDJCLIBJ2/NJUNmhUW1+fNXbeXPPRS7p5v8kE/GCl6Z2Zlbnrs8ko6GbVTRW6Wtg/stWXVHnH5Nd/UvEqXPNPt1g39llGqLAL8TmvMb4UadvZkp5xEB42G/tTl11h9XmQSXiJd9mjxY3z9MeUJSjfmQyFwY=
Received: from CH2PR11CA0005.namprd11.prod.outlook.com (2603:10b6:610:54::15)
 by MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Wed, 23 Oct
 2024 10:42:52 +0000
Received: from CH1PEPF0000AD7B.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::17) by CH2PR11CA0005.outlook.office365.com
 (2603:10b6:610:54::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Wed, 23 Oct 2024 10:42:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7B.mail.protection.outlook.com (10.167.244.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 10:42:51 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 05:42:47 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v4 01/12] iommu: Refactor __iommu_domain_alloc()
Date: Wed, 23 Oct 2024 10:41:56 +0000
Message-ID: <20241023104207.5894-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023104207.5894-1-vasant.hegde@amd.com>
References: <20241023104207.5894-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7B:EE_|MW4PR12MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: d929bcf3-da9b-4ce0-e4d3-08dcf34f71e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0u0YbrX2zDDaTJm53a7NQGq+T7lEv6Shoe2EyGglO1UW2TxnTSAoiKWzIB2T?=
 =?us-ascii?Q?uQJEyIc8neq/0pbPCKw2a/ycK49Ip0OdxHqCHggwsmuqbtcZDAFjvX30lYgy?=
 =?us-ascii?Q?DOSc2qiboFhqGdXhHdX9VG3N7ytpKGy2UiR8Usz7fZfGR8Yh6rMe9JEaaicJ?=
 =?us-ascii?Q?6GlteBUZ6pEwEhBgDqFT8yaOEnXuO0mz62oOUmf4aivl4uFyRbgctQgHL63f?=
 =?us-ascii?Q?roRdPaOuYUb/OupwoQWZI5GsxFvLVYWeb1fXHLKPts6JR76j9xQuz7saKb9A?=
 =?us-ascii?Q?xRifvhSa8XzGtcu3rkoJy1XvRZZmPdNe+D9tnFAcGaQ+HQCNgCBLyLfjdwT7?=
 =?us-ascii?Q?ipF/9T4Kb7j/iPd+HgrvPOqOsL6AAQq9aypNovUsIo1BRim8z9CpWSHM5WtM?=
 =?us-ascii?Q?ddTswGPJwh6gtUCGke7RJcrHR80k4F0J2doD9U5rO780gA4OeGRMry5IfKd6?=
 =?us-ascii?Q?Kz0eicre/KH3qkt6n6ajVXeeCvMocwyZZ5cKWV+plucFWPrFlL3AxnTrqlGQ?=
 =?us-ascii?Q?eUzoUi3Prgjcf7LrDDy+bqOYgXW+u5p+GSAT0skhyfp5Po2CFMei514tMSFn?=
 =?us-ascii?Q?x0FH3++wTyrrRydgUVlM0oojuE2KsH2FIJMksAR2bmQFEUMLrjzBnE9XwJU3?=
 =?us-ascii?Q?wIAKCmQp46l77K+PLr6gJ0MhPlnAeuL/1DbJqb9+luaT6fO2ysOYl4ACsAC6?=
 =?us-ascii?Q?XaMIM6PoXNojh34bJlH0YAqXr8KiF0sHnyu0lPjG7lMc1KY3zUG/SNlUg2Q2?=
 =?us-ascii?Q?PKK3oDe0x+6kwK5iVZ3LOqFmtMtZIqsRKeZtrk7bH3TGNxIHpI1jRRspRWT0?=
 =?us-ascii?Q?5N8jsfUgDGtoLbv2LtOES/dKyQGbldXvtYoBEv3UYwT9ZrDBoxOjGO2EIqP4?=
 =?us-ascii?Q?+m1Z1UTIPbzWA658dnUJKnJdLE3SKrD3QMmXCfr9wZtp1Ak073l1Upq6otRP?=
 =?us-ascii?Q?/L/b0Tx8kaFnG+jfasSSHeuRaa86XZoYzAOOalOhKx3PAt0UCU4AyOVdMojd?=
 =?us-ascii?Q?uDtmfmP710nps5Sx7+zcU77oCpwalihZkYsKULMs4170IEdUO9zyWZV9sTwo?=
 =?us-ascii?Q?7RKkHXnMgEqWGT55m1skyaJq+BodhZrkYqTCHPp5qk9j4J7NUa/RluU1jVfu?=
 =?us-ascii?Q?+UNU+OFV/tDDsoTCX9hi0aw1Xj564fT9G2QmY7WWAuLkWPFnvnUsoEQE/pzX?=
 =?us-ascii?Q?Rm5XuoM/lzdijzcswe3BxoDdyQz3x6J1bQoRo4vp92mu2H7hCKFwseRDfJqg?=
 =?us-ascii?Q?cbPsxERz0adNRZJVwlzN1STCvYP+htP5mrd96cEb42owl66DC0pXYmRB3DJS?=
 =?us-ascii?Q?6OmSopuGDSmUN7bSt9E6Hks2UY4h0GTYlVnPCBATb4NOL0+QRtVa0e404NI9?=
 =?us-ascii?Q?9FpdYI9wc9r+YETf5DT7Y09BKZJ1N0lYvEWm7m1tivH4SuGJYQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:42:51.7713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d929bcf3-da9b-4ce0-e4d3-08dcf34f71e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603

From: Jason Gunthorpe <jgg@ziepe.ca>

Following patch will introduce iommu_paging_domain_alloc_flags() API.
Hence move domain init code to separate function so that it can be
reused.

Also move iommu_get_dma_cookie() setup iommu_setup_default_domain() as
it is required in DMA API mode only.

Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
[Split the patch and added description - Vasant]
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommu.c | 46 +++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 83c8e617a2c5..811748bec4b0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1934,6 +1934,22 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 
+static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
+			      const struct iommu_ops *ops)
+{
+	domain->type = type;
+	domain->owner = ops;
+	if (!domain->ops)
+		domain->ops = ops->default_domain_ops;
+
+	/*
+	 * If not already set, assume all sizes by default; the driver
+	 * may override this later
+	 */
+	if (!domain->pgsize_bitmap)
+		domain->pgsize_bitmap = ops->pgsize_bitmap;
+}
+
 static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 						 struct device *dev,
 						 unsigned int type)
@@ -1962,27 +1978,7 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	domain->type = type;
-	domain->owner = ops;
-	/*
-	 * If not already set, assume all sizes by default; the driver
-	 * may override this later
-	 */
-	if (!domain->pgsize_bitmap)
-		domain->pgsize_bitmap = ops->pgsize_bitmap;
-
-	if (!domain->ops)
-		domain->ops = ops->default_domain_ops;
-
-	if (iommu_is_dma_domain(domain)) {
-		int rc;
-
-		rc = iommu_get_dma_cookie(domain);
-		if (rc) {
-			iommu_domain_free(domain);
-			return ERR_PTR(rc);
-		}
-	}
+	iommu_domain_init(domain, type, ops);
 	return domain;
 }
 
@@ -2965,6 +2961,14 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	if (group->default_domain == dom)
 		return 0;
 
+	if (iommu_is_dma_domain(dom)) {
+		ret = iommu_get_dma_cookie(dom);
+		if (ret) {
+			iommu_domain_free(dom);
+			return ret;
+		}
+	}
+
 	/*
 	 * IOMMU_RESV_DIRECT and IOMMU_RESV_DIRECT_RELAXABLE regions must be
 	 * mapped before their device is attached, in order to guarantee
-- 
2.31.1

