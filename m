Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8885F153820
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050009; cv=fail; b=o8hkY1nc+memtbgJ25IVh2MWDMZDeme/MsB80D0k/kjex+WzjyeNHJ0OuezdanqT1qqkMKXLk6fAfPoPjpv3svMnu4N/uK7olrkNoB5pODkLTyPnsPv/ZK8Z12nm58i3jAWxhHnhU9aSROM7KcN/mrOalxZ/CCPOvmoVpYbjUVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050009; c=relaxed/simple;
	bh=yKZu72mLjDu7snuDHYagZwurcZ5nuiVqMdljbcoZCgg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WboJYPEAIGjAdkvG3plYuHDOKTDwxXkleUFdzXcCCq2nPRF/KlyNGXoyukey65D3y96hfedxnpNbRf3aGTODT3sMYiCgBxcxyLfiOdxvBlblHjJycTRlMhc+WSG4iR7Xpt2ZsgZQyklEF2R9AhWjVUtg4kSPiN7HMPo66UbRjFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3hhiLhGL; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3hhiLhGL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SL45kcNlRjaGAR9ugj0n3Z48S9Viv8VeEF+ZCgcSvAz68mbaI00bBvv7Ft+oAPmGo8G+NBT1sfDI2CH1Qw4H0MKBY+iQfeF1Z9f4MmsLuqe9UNdPXnh9kr+BNcFAUmRZArXcdnxTfC0AlPucR9yFRjXHLB4jh5BvFGcl2WKsz7XQ8IVxRaWj17X+v3b5eWKT7gfpHUx+TWNX5ot/3kIIOY8NyuSG1g9UWx5r0V/bKOA8fwx9oyuFQmbP3bP2/kkn3axqb/7KWW3+EvCQ1RC3j5iypYoWiIaYTBGyTNw3dbKaSTtnfpByZkyJKvt3PNBXz2xnAmJkGRZAp1BfCaqYIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dzf26unO4N+p8zKTw/UO62eyh+24R4h3zg6MI4yn18E=;
 b=hXUqYd6d/ZKi83OxET8VUGR0G4ynxOZnQRohX0ST3SRiR42qJdEbS8I6CuYpgypYKc//YWp+/3R0GzxGTEAelX2KkPBIi3+9P1UzL/eMRowWNTC0B648R92g1ALoa/exc1JYWa8jSE9BBMNKOhBQW4Yxcttmc7I75rss2f8DXf8iZDgGcDuNLmEkrwlPRvc98KiMHT2S15kmdSQyKqBVLV4eoCu40DwRLsQfnJpVOABcxc8Okgxb8cFpW6YlO4abNCNledx7Hk/R908tqKCckRscidcfhKCzS+EI3dC3W4nxNy9WsjE6O0+KfmNZNfKeVXFdyM61Fc7P6sRJTa6TPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dzf26unO4N+p8zKTw/UO62eyh+24R4h3zg6MI4yn18E=;
 b=3hhiLhGLZRiWBrNEqmh1slo/wqfx5gwF28MaZIm59o6J8dlwiDK9KIRkLJd84RPSe+LPpusOHMuXQ7O4UHHx71loqOzK3qdUmYzzlfm745slKjSFfNuzW4QB64l/3WERG45bTlHYgIVEnB8Lj3Qr865ggcKklYr9aYLYCpVg+14=
Received: from CH2PR20CA0022.namprd20.prod.outlook.com (2603:10b6:610:58::32)
 by CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 10:20:03 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::17) by CH2PR20CA0022.outlook.office365.com
 (2603:10b6:610:58::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 10:20:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 10:20:03 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 05:19:59 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 1/8] iommu: Refactor __iommu_domain_alloc()
Date: Wed, 11 Sep 2024 10:19:04 +0000
Message-ID: <20240911101911.6269-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911101911.6269-1-vasant.hegde@amd.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: d624b0fc-7eb3-49a6-d219-08dcd24b4d08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Or+2P1YVtwWkJd/bz254kn98uzlvAF/FpEY74ivknCVmr015Z+hPwL5xvdfz?=
 =?us-ascii?Q?hM49Zw+eb62uQjK+Gj04vGxGNwONftwrWj5P56BfD+/Kwgt1MRLizOAbM44b?=
 =?us-ascii?Q?V8dJeavv56D+AroUFMhM1nJmnD1gp9hLBc9nbtbHV16pkJZgPB9Yr7gy19Xy?=
 =?us-ascii?Q?2N5wSrSiThuVdW+z0SHPuBCG/jKyh6F4Zmv7CPOqq6jYKBF2HT8u3tQhFOGc?=
 =?us-ascii?Q?G+b1tkycfn1L81/LBwDe2XgD0xI5AZZV1OUfwJ0xy4uvrvXsK3k6ZPIk4amX?=
 =?us-ascii?Q?0hKKWagsbHNQf/daQOQ3ooH/DaSTfvEIySLEyHGHYkDtG0FOLZSi1Gk9AIvZ?=
 =?us-ascii?Q?Do4G0EooiLeDfTfRWdPoFH5hq9ui02NwiXGEpsyW1oWspssvYTF06N6GxoXF?=
 =?us-ascii?Q?xSIJG4BwSot2zwEuRpXf//5ExENnPCsnFBKuna5xu9yCsNOQH/rNlQHiLbap?=
 =?us-ascii?Q?6bsWrIZDYCtOl/NUV+JoJb3qnaoinIktZKdOb3uyUFcwlU1gaAikW9ZdlGc8?=
 =?us-ascii?Q?yNKGdfCDzU+sYtjeK3Kq3LkT1uvOsd9uogRRGh7a7WWN9QqeyG3ZC9UlXedD?=
 =?us-ascii?Q?GMqLV//nG+mqzGSf/Ftx7D7bAuFuW1iCs9xGHRIIm6vvXAvAPRGGfIPRadkg?=
 =?us-ascii?Q?cXz0ZXcsaMM+72Vjje4xSWgLUqqMeZuo+jVpR6YvLmFl6okELFNSVm8yjRRl?=
 =?us-ascii?Q?8MCa0RL2qPkbqEZw8Z/Kn0nHrLxD4EiacaFiu7LMk33SMRxT5+fW9wJcT+ut?=
 =?us-ascii?Q?RcI9xcWF4F42nbMrz9SR6B+waYcSmN9c4HAgwE826Sx2pS/itFoNmWr2NEXs?=
 =?us-ascii?Q?Zie2LZiYktJAHeCcr9TWVlC8NXnI2gUkHWiFYzWJ6+mkEkyCgFEf5VPNZ73t?=
 =?us-ascii?Q?LeQgVxrBtPzxhFVLDPwefvTQ1x5DQOd39+0eoFZIv/gDxMLd2N5UQodOmLt8?=
 =?us-ascii?Q?HFx7tudaP+byp0b3HPxEf+ed+vo2nYG0kPumpab7CvIFDT4Z40Nog6rYL1J6?=
 =?us-ascii?Q?HrUy7sWq6qgvDDhDjD56wKcm8jPFM8QI8lxCTYamLfWuV9etukw+5FzR8lVG?=
 =?us-ascii?Q?/x2ej/AgzjD4781AinXgRnL4D0H1EaJy1ETwe6IG+g1Hr5+9+TiGXohz0t0r?=
 =?us-ascii?Q?AFU7fm3D950hZPpQFe+FhuBHLbC3/bm4z2hnF4f3Owq6rkvzD/l9tNnYmGjq?=
 =?us-ascii?Q?Od+9GjonLN0rObowJpTc9iDZzHfJPhZIASy/bAyf3RWN/7LEWDo8JgXcl7ho?=
 =?us-ascii?Q?fM4DRQpS24mCJhYGKU+hS7JnusfREK1ib4VoVbrzk/QTAgX6VARythj+z/UM?=
 =?us-ascii?Q?r1J+PFSKNdw/+IcyQ4nY8VmON+uCKClRe7Duy78TB3ttaE8DkUFGr6er8y0q?=
 =?us-ascii?Q?MXsOan1g/LHsx54Smj5qZfdu+t9Yk9J5ZFLrXzJEODEGO/7l7UDFsI7tG5Ty?=
 =?us-ascii?Q?pMw4xy7gwzgM60J8ORE02n4YiZxC7aWg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 10:20:03.5634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d624b0fc-7eb3-49a6-d219-08dcd24b4d08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196

From: Jason Gunthorpe <jgg@ziepe.ca>

Following patch will introduce iommu_paging_domain_alloc_flags() API.
Hence move domain init code to separate function so that it can be
resued.

Also move iommu_get_dma_cookie() setup iommu_setup_default_domain() as
its required in DMA API mode only.

Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
[Split the patch and added description - Vasant]
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/iommu.c | 46 +++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index ed6c5cb60c5a..4118d3b15310 100644
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

