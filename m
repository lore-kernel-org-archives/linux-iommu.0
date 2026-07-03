Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF902222AC
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 03:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783049877; cv=fail; b=LrHNw6mb76PPnpNnxCIFleAYZpUXcmxeb40SH+OZP/O3EIjpGHbFXk94ValqcJHEXGaXuiXdwkVZJDlsZVn0sfm2mzc6qggZ70DNxQdrOvlBZd5JNEEP+jHvrwapablm+gpJ+rhCrdMHMSOSMgZwhPzJrnBQXtnv/h1d6NWqZXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783049877; c=relaxed/simple;
	bh=IGajNHBwhlE1DitC10n6770DdmsA24b0qwAUu5cAqAc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LpdN9TnI6kBpBpDD9D8CAqQ/mA0ikeRdTWjt+4JDv2FUR9zUlWdVmlrbjM8r72S+fgEG5V0a0Hjw/aV4PEfKc1SACOavvMeoI/aThl/JjHtr7FTcLbWGmix3FMd/bQIFD40FziS17m5MQrwJs5HSOsulTeO/pJ/9X9APlwjZ/tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3e9vn9fh; arc=fail smtp.client-ip=52.101.62.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3e9vn9fh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuPBP8vnLReNWyQ+nwMlzriHIHTwKqUtAz6i8aT2BSftL7iPfEnghgntBJFWe1+iTjj1B3bOOI2Dthxn2vRkYiT4VUn3yfheNRhZIaDPdmfK/qEJJ6RducDGGYXvYkRQkJejshNMtXhP5o6Wg40GF68n54U0dlqAvy/LbfTFyIVyzXey70n0UgU2qb/BxecdfhlSQpsny8k7un4cTo3nEY/K4ATsDQ0MDv8z29l6IImS+coIg+WKq6Xa1Zymn5LohZuiDkGsG5bNLmnACOVjxEcLUb0H1aIzB/tMx08Ayw2ADTWutX8MDF8CcU938+RuMI0WM6sRnrCjx8M0y0kR6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MGEhnGkkNPhth1S+gSySFZQWLp8uYqrhL4R0j0Rg8g=;
 b=FVxCPwGcQbVyirtwpVTAVpt+KzM9JmJYbBBRMO5aDfx7diZX6HoxUkmCKBb0cq/cLNNw04JgXddbJ9QvNah1BH2kZ5vHBaEd4IiVewVXoMzXLrD6xQ9wutdMnvYYdYakQKcmeWd3br1raTrIcqI63tJ8lPa9ik6wGlwmzdOieBv2d2iNUyOlMbGjdeHvib7eviNU/ZlAaZkdu2El0nt7cnSXeB0suJN3VERWAadHu6kTd3YyleBu1g5QWQPoLOEgdkpLCnSDCdh3bTclsKWQyJzgFnAFh0avWUK7JrZthRn5YmcsGlBUC5cJcR9bXyA5j8Bt7eXmhifNAKvbEtZrlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MGEhnGkkNPhth1S+gSySFZQWLp8uYqrhL4R0j0Rg8g=;
 b=3e9vn9fhhlfU9PUOeFU0FEB5RRsaO0ARIuxIeexzkWZxaBnBNNjoNbBQ4Yr01Iybfc/U06nBqT1xKYZTLSHbQkLj7rru/EgaBiUFkdtiOAOMX2++EWnpcmrKfZ6xRE0SbPW62rFwEJObqYeWVIfxtJXn4ItpUdI1IDO9Nqi6EAA=
Received: from CH2PR04CA0013.namprd04.prod.outlook.com (2603:10b6:610:52::23)
 by SJ1PR12MB6049.namprd12.prod.outlook.com (2603:10b6:a03:48c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 03:37:42 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::8e) by CH2PR04CA0013.outlook.office365.com
 (2603:10b6:610:52::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.11 via Frontend Transport; Fri, 3
 Jul 2026 03:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 03:37:41 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 2 Jul
 2026 22:37:39 -0500
From: Honglei Huang <honghuan@amd.com>
To: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<leonro@nvidia.com>, <m.szyprowski@samsung.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<Ray.Huang@amd.com>, <honghuan@amd.com>
Subject: [PATCH v2] iommu/dma: simplify dma_iova_destroy() and drop the free_iova helper
Date: Fri, 3 Jul 2026 11:37:29 +0800
Message-ID: <20260703033729.455358-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|SJ1PR12MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: 23f2bdd2-643c-4f4a-4a27-08ded8b47012
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|18002099003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	55HTdrKCvlA8FtpFWABlvTaVuY9aA/1eV/vzjwPJwdUaycfkFpK4lSj0iBLqnzLacnEa04y19l8GEgzpj7yJNvzdrZpEq9ICXJAuWtxnMG5CNA+8o6gYhSbWSFvJtEsQdwtzoHbwP6kGgzGRoLsi7uarNDbEXhNirJz1niU5R42h9QSIcta+dUZHwYkNeyG4nBq5HHmhsSvb9ilvVaukM+cI3TGRTsZGLpkK4x3JtmUlkhSDGQ4sbh+j/swdKB6td5AVfb0SwOxURS+mLfloCR3eqPZoU0ECbzjQOtWbpuqYwyOaHl+xnD6Wyangv/4Mc90XRjLlm92I8epZwOr9bych4dh/+3lWGhIyqHKG8qlC6Wwt/adhJT4oxheF5SW9QWc+xmvZ7nLKnvcH0F1JS4Y67QuvVPBcF1vaBHh/uWJ+GTaOVz8628h70ZtM6f/yCuzYgoEJxtobvG5IW6L34d3qrdOIw/6B0ppzLyomvFntQIay6K3tDHqrFkDtNawDtiCaGTSEBKF/Uzis/yPJfZ2f2JRxXhmZ9HOHnu5V4Su937byYC9lyyld5CC8hMQqKS50kA7efSOVgxJSzQEbH24mrMEVwO6xhhAbrJbY7VJXyVg/al1c9ILMQJpcUEIenyYE6p9c9aFXwlJGTACAHxZsRzV/eA8kEZI9q9ENIuchmlVfNnZlEjrNg1oKXt5xqRZb8+5PTIfuHRYkXA2ngQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(18002099003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tXFBC1BhRy6OykjqNesZK9NMQ3PwgNt84719iVe5Oj4HTagb3b6CsyEhRdgdK0kYcknFMCcvGG91PV2KpEDbf2LjAP/0L3na9ici45IYdBJaEV5S3B5pxF3MGl4N30oT8kmLG3Uoy8/ZoLs2R6JxVWCOl+8UPi5QglWeRLg3oeJRxzZppiomFm0O19YFhUm49PbCQvPrRBp//CWBe9p3jlZYRcEJ2+yjwoz4N5Z1cwjVb4g+/SK+hkRbnh456vvQrxcEH+sZd8VdVWoOPAxeKSufYB8AWSl8Vbc/cobNAsP/UqbHNkJ/szx8xuFNvuaTYCO1X/3fsRlqjEskQwhqJ2X58IxwmUC/ivaNpxzqo7/wJlkdKMMpQ/M2vsCoV+xd4d0yI1f6HJtDyLjCvyrBdn5FrCBD2qzyv3iTe6r18YvYtwis+8FdWfTTsLKD87hC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 03:37:41.8836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f2bdd2-643c-4f4a-4a27-08ded8b47012
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6049

dma_iova_destroy() frees the IOVA space through __iommu_dma_iova_unlink()
using a "free_iova" boolean, which duplicates the IOVA free logic in
dma_iova_free(). And it frees using the unmapped @mapped_len, which for a
partially linked reservation is smaller than the reserved size. This
results in a benign waste as pointed out by Robin, not a leak. So this is
a cleanup, not a fix.

Drop the duplicated free path. Fold __iommu_dma_iova_unlink into
dma_iova_unlink and remove the free_iova parameter so it only unmaps.
dma_iova_destroy then unlinks the mapped range if mapped_len is set and
unconditionally calls dma_iova_free, which frees the whole reservation
via dma_iova_size. The freed size now always matches the reserved size,
and destroy reads as unlink then free.

Note that dma_iova_destroy() no longer routes the free through the flush
queue; teardown now unmaps synchronously and frees directly, matching
dma_iova_free().

No functional change intended for callers.

Suggested-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
Changes since v1:
 - Reframed from an IOVA-leak fix into a cleanup; dropped Fixes:/Cc: stable.
 - Fold the free_iova helper into dma_iova_unlink() according to Leon's
   diff, so destroy is unlink + dma_iova_free(). Added Suggested-by: Leon.

 drivers/iommu/dma-iommu.c | 57 +++++++++++++++------------------------
 1 file changed, 22 insertions(+), 35 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9abaec0703e..5598ed4bff7 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -2068,10 +2068,20 @@ static void iommu_dma_iova_unlink_range_slow(struct device *dev,
 		arch_sync_dma_flush();
 }
 
-static void __iommu_dma_iova_unlink(struct device *dev,
-		struct dma_iova_state *state, size_t offset, size_t size,
-		enum dma_data_direction dir, unsigned long attrs,
-		bool free_iova)
+/**
+ * dma_iova_unlink - Unlink a range of IOVA space
+ * @dev: DMA device
+ * @state: IOVA state
+ * @offset: offset into the IOVA state to unlink
+ * @size: size of the buffer
+ * @dir: DMA direction
+ * @attrs: attributes of mapping properties
+ *
+ * Unlink a range of IOVA space for the given IOVA state.
+ */
+void dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
+		size_t offset, size_t size, enum dma_data_direction dir,
+		unsigned long attrs)
 {
 	struct iommu_domain *domain = iommu_get_dma_domain(dev);
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
@@ -2087,35 +2097,13 @@ static void __iommu_dma_iova_unlink(struct device *dev,
 		iommu_dma_iova_unlink_range_slow(dev, addr, size, dir, attrs);
 
 	iommu_iotlb_gather_init(&iotlb_gather);
-	iotlb_gather.queued = free_iova && READ_ONCE(cookie->fq_domain);
 
 	size = iova_align(iovad, size + iova_start_pad);
 	addr -= iova_start_pad;
 	unmapped = iommu_unmap_fast(domain, addr, size, &iotlb_gather);
 	WARN_ON(unmapped != size);
 
-	if (!iotlb_gather.queued)
-		iommu_iotlb_sync(domain, &iotlb_gather);
-	if (free_iova)
-		iommu_dma_free_iova(domain, addr, size, &iotlb_gather);
-}
-
-/**
- * dma_iova_unlink - Unlink a range of IOVA space
- * @dev: DMA device
- * @state: IOVA state
- * @offset: offset into the IOVA state to unlink
- * @size: size of the buffer
- * @dir: DMA direction
- * @attrs: attributes of mapping properties
- *
- * Unlink a range of IOVA space for the given IOVA state.
- */
-void dma_iova_unlink(struct device *dev, struct dma_iova_state *state,
-		size_t offset, size_t size, enum dma_data_direction dir,
-		unsigned long attrs)
-{
-	 __iommu_dma_iova_unlink(dev, state, offset, size, dir, attrs, false);
+	iommu_iotlb_sync(domain, &iotlb_gather);
 }
 EXPORT_SYMBOL_GPL(dma_iova_unlink);
 
@@ -2136,14 +2124,13 @@ void dma_iova_destroy(struct device *dev, struct dma_iova_state *state,
 		unsigned long attrs)
 {
 	if (mapped_len)
-		__iommu_dma_iova_unlink(dev, state, 0, mapped_len, dir, attrs,
-				true);
-	else
-		/*
-		 * We can be here if first call to dma_iova_link() failed and
-		 * there is nothing to unlink, so let's be more clear.
-		 */
-		dma_iova_free(dev, state);
+		dma_iova_unlink(dev, state, 0, mapped_len, dir, attrs);
+
+	/*
+	 * We can be here if the first call to dma_iova_link() failed and
+	 * there is nothing to unlink, so let's be more clear.
+	 */
+	dma_iova_free(dev, state);
 }
 EXPORT_SYMBOL_GPL(dma_iova_destroy);
 

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.34.1

