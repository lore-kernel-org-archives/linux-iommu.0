Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2061.outbound.protection.outlook.com [40.107.95.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1542F23645F
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741035202; cv=fail; b=uaVqmdyf+xuD11I8LF0Frzak6fQcs9He+DZS3NbjssoO+M9sFcK6jKeEv42xau1TED3v0r7YBtTt9/OZNf4Ikq+5SvgMy+oZe1vDPhgSWVIz8eE6c+mRK6ceE51/Q6lFwZQDywQEf9LoZq6uxbWFyutTk5huYQmVF6wzco0RT0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741035202; c=relaxed/simple;
	bh=xayPBxa4Fu/ziAd6eAj0ogaPCi3t8Xl/E2gBiTW8hTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8JnNY5/a83JgfoD6+Umdn4WVq8ViyQ+tEWMamVzqXIX+qCuAaFuK1QFlJ+Z1gYjsbc+/T4QFlwpvj4HBT7yLEiQdAf6GaKKLDNaDMzA1Dz87DZqzYIPRW7DX11ba3e7WUqS/GZ49shKB1FPxzuq6tfhgfxZ/aJna1lRWlO5pzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RpPRL0ag; arc=fail smtp.client-ip=40.107.95.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RpPRL0ag"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlpwiGTUaGIAmoV8AtVIFhJ6g/EQZCADC/bFPPP3QLxPP8AcY23/NBoz2FR7gAOx6G1ZKnxgKJMzM9vgRtiWc9ND9ZmW0c9p/gdo9JbgyB29K5Aw2DCILFnE3/1YGv+VTWdARO2xycR1nnIZioZ5AS0GjxKInJIu/J4yskK6WN5j5kDevkYLTC+1MWtdHJRYN4vJLgLRyYmjahveH9wnKCu2sVFqfZWA7ttRyHd3iww6m+W5mRkKfHgN9iEUDdWgGD+0VMTnqLsUiC4BkFluEqh2Fp0Y2f6TDKyrpy2KGnnAhVs+/XbGXtG/GihnzSrBf+urKAkK4JDVG2j7CyNWFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+i9JEVtJx/0xznTcUUi4YDTi94KdP08JvS512+kl4eA=;
 b=jlFP79EEnGl5DuxxNVEGmC605QH8yHCNHBxgqLRPs1Xly4tjUYLR/BJV+lNxmnEmLzM8d3YWZi80j7fwns5cUHveHZxP7MYfxLJRbWplpwPVYyQG9I9j+Be3FHgl6yPrHkfxalgCSKXMdSwt+7kXVyOzbvmBvfxx3uFpFklMYjwT0T13XnM5nSb+C0Rk6lJEPUbbO+OhBOjbr0n+4x0VJTW1b21kbawIsvC8orTYd+myUhHfH5G0CNVcBuUu6s9eeJ5POjjWs0zC2MMNxtF+MtERkCltXpzZ/0Jtj+vhNo/w5XKoPBr7wF/D54Y4p0V4MZZjpetNhBqM5c9uduV6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+i9JEVtJx/0xznTcUUi4YDTi94KdP08JvS512+kl4eA=;
 b=RpPRL0ag4zLI6hULBuo2jcDLiJiD4yS+qL3191iBZ+gjhDTwtqjyNUq4xeDUE1Ni81r7XdnMED4zfSRWouAzhtl+ONMbH+I/CyHFGrw0hNsAU/vPhcpGSLvdhtKTSJamU+8i0rz1kCOWmfTnD8FRvdo7eLb+ViinzaRDrqxODgmRbnCTcxO9kEstLNZ0iapeWdSAVIJHN0y8KeCpIBxVVehnCfFElPutLMNKpR3FAdzOB9X0KtKbZBTrg1c08gvjdIGqc+JzrznuapW0nLOmadb3QnBjstlCVVHtXSOip/o19wofTKzsmjlsePeEgS3tkYtT14316mT9/kG37K4KYg==
Received: from SJ0PR13CA0069.namprd13.prod.outlook.com (2603:10b6:a03:2c4::14)
 by SA0PR12MB7002.namprd12.prod.outlook.com (2603:10b6:806:2c0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 20:53:14 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::7f) by SJ0PR13CA0069.outlook.office365.com
 (2603:10b6:a03:2c4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.20 via Frontend Transport; Mon,
 3 Mar 2025 20:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 20:53:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Mar 2025
 12:53:04 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 12:53:04 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 3 Mar 2025 12:53:03 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/3] iommu: Sort out domain user data
Date: Mon, 3 Mar 2025 12:52:50 -0800
Message-ID: <74a3bf91b52563faaf7ef7de065931e4df47e63f.1741034886.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1741034885.git.nicolinc@nvidia.com>
References: <cover.1741034885.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|SA0PR12MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d54a3e-8544-4ce7-4ec8-08dd5a956ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e3C4jTatg3SFex9nSQxxBvJ9/RnIfPG/DkwN2SOwdUPMEbZH/PZp5xLu+rZi?=
 =?us-ascii?Q?WnWK9BcmVfpyUbFivwGlOebl6tFBsiwpDS4HoFbmN7WHDkApYFlvxIhW542j?=
 =?us-ascii?Q?NqeguJwfvp00afA62Ib9a0WC+vlX1IrbVBQlFrb8i9NnyySQ0oBiYQPtLAAZ?=
 =?us-ascii?Q?OJk/aiUFhx0mGy3qx0j+bZZg+j05p4nlUwjI6Q8eM5oInBvJIVOM44ULLuT3?=
 =?us-ascii?Q?1aMWEwsflwat3FrGscuaKCVCFBfgqbX4LEFAsv9ZjUf7zjYQkNNcpcKgi6we?=
 =?us-ascii?Q?2N9cHAwY95bKi23olgpvdXzS0h/vlftA5X0wBLKHCgcxPFb8GVHVjUgqY8LO?=
 =?us-ascii?Q?D1BSaRIR/znKchZoD1t/Xg6hubThy+Xq6IFBdlDVR4J/tYRv5Q9PC2HIjbB5?=
 =?us-ascii?Q?xmvuv5QoigRbtZt7Jv6DHZ7LSmqDo4ce7d7FbsArRSMpcdNWGfLITfZEEQl2?=
 =?us-ascii?Q?mFIkFpIBR5skTRWIC9QluevzpzR33XaYsv0pYxcPukzEK5ppkb++cn7iNJwf?=
 =?us-ascii?Q?a9JvkNZb42KG+JRbDLD2yqpAKyP/gCiWw9vTxADP2tFZbEs4e3XAN4517YDp?=
 =?us-ascii?Q?t5rdCmK1DdnvDhjWCFZ9mAgKnanxvhTOnahqHyTZ1z/o8uwMCM0wtIQDnED2?=
 =?us-ascii?Q?9BM2ftC7vIpwV4S7cXxWOh2woczA78U8Jv6rnP50DxYpbPzfy0z9XxPVNICm?=
 =?us-ascii?Q?okx1bwwvsC8M9LICdcrtXr2rKY/ybwGkjzDbOF549fQ0dOj/XSgL0tynqRO4?=
 =?us-ascii?Q?ddpMbYMM8FpLBkK633iiHc9UPmbjpkjLVObzHmrjwQqgNwFJ+NWGJ+VGohF+?=
 =?us-ascii?Q?8Z444s8cuoJ4j1AlAFJ+0tUXTI1DtHI9/HHTbJQE836OaLFKVOHLU2mHbqgF?=
 =?us-ascii?Q?WAmlWVaCgEIbkNHGSdKWyPsmsTfoyfGYq1F6/inXwpQO2g4jv0KAE14CNg2B?=
 =?us-ascii?Q?LsGwaPPqtLSBCubENfp0K5UHZYgiCbBo53krBJm+yUNgoVRjwRouKUUtVoeN?=
 =?us-ascii?Q?lBfliudSzVCE4wjcyoC2l+f2qPTYZ0uhsacQkC/qk0aErkKPF8u8UgmDQB/X?=
 =?us-ascii?Q?TyKtl1k8Unew5XkhBxBgYop48UuuYzaTW7b1Eb752wHGKkqmE2jrVFhqVkOH?=
 =?us-ascii?Q?cjNDLAsE6r+AMfCS8cLBQrKdaSLJfUG72xFG8Iu1eOZAggsRs2uZEPVk1RuG?=
 =?us-ascii?Q?16Gkkhcch2QdUcShk5qVQw4cWhy31P92bI43zC3xOHZgqSSbfequgbjtRzIx?=
 =?us-ascii?Q?W6U8fZBQfvsQno2zGeD9WHPH66tzwdBEFZVPG9iDTV36rR8aFKmDKDgEA4sY?=
 =?us-ascii?Q?T/3xQiQo+wbxdRbwHUJxQYgU8w29jsQeMZJvw27u8BLmfqGn9sRTALlV5yOf?=
 =?us-ascii?Q?CcQGDkYriVbxs8L1jsa1xE5ZiavUukORouTkLXyh/pKHh1K4N8zskHbem8gW?=
 =?us-ascii?Q?5QWm7utQ6XicuIwpY0zuf6ud11NfOVLwsfmrbWVTeWSa+DhBXi49LFDe2l3y?=
 =?us-ascii?Q?pINPpQzZlX4+2kc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 20:53:14.5328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d54a3e-8544-4ce7-4ec8-08dd5a956ada
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7002

From: Robin Murphy <robin.murphy@arm.com>

When DMA/MSI cookies were made first-class citizens back in commit
46983fcd67ac ("iommu: Pull IOVA cookie management into the core"), there
was no real need to further expose the two different cookie types.
However, now that IOMMUFD wants to add a third type of MSI-mapping
cookie, we do have a nicely compelling reason to properly dismabiguate
things at the domain level beyond just vaguely guessing from the domain
type.

Meanwhile, we also effectively have another "cookie" in the form of the
anonymous union for other user data, which isn't much better in terms of
being vague and unenforced. The fact is that all these cookie types are
mutually exclusive, in the sense that combining them makes zero sense
and/or would be catastrophic (iommu_set_fault_handler() on an SVA
domain, anyone?) - the only combination which *might* be reasonable is
perhaps a fault handler and an MSI cookie, but nobody's doing that at
the moment, so let's rule it out as well for the sake of being clear and
robust. To that end, we pull DMA and MSI cookies apart a little more,
mostly to clear up the ambiguity at domain teardown, then for clarity
(and to save a little space), move them into the union, whose ownership
we can then properly describe and enforce entirely unambiguously.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
[nicolinc: rebase on latest tree; use prefix IOMMU_COOKIE_; merge unions
           in iommu_domain; add IOMMU_COOKIE_IOMMUFD for iommufd_hwpt]
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/dma-iommu.h            |   5 +
 include/linux/iommu.h                |  20 ++-
 drivers/iommu/dma-iommu.c            | 193 ++++++++++++++-------------
 drivers/iommu/iommu-sva.c            |   1 +
 drivers/iommu/iommu.c                |  17 ++-
 drivers/iommu/iommufd/hw_pagetable.c |   1 +
 6 files changed, 139 insertions(+), 98 deletions(-)

diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index c12d63457c76..9cca11806e5d 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -13,6 +13,7 @@ void iommu_setup_dma_ops(struct device *dev);
 
 int iommu_get_dma_cookie(struct iommu_domain *domain);
 void iommu_put_dma_cookie(struct iommu_domain *domain);
+void iommu_put_msi_cookie(struct iommu_domain *domain);
 
 int iommu_dma_init_fq(struct iommu_domain *domain);
 
@@ -40,6 +41,10 @@ static inline void iommu_put_dma_cookie(struct iommu_domain *domain)
 {
 }
 
+static inline void iommu_put_msi_cookie(struct iommu_domain *domain)
+{
+}
+
 static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e93d2e918599..06cc14e9993d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -41,6 +41,7 @@ struct iommu_dirty_ops;
 struct notifier_block;
 struct iommu_sva;
 struct iommu_dma_cookie;
+struct iommu_dma_msi_cookie;
 struct iommu_fault_param;
 struct iommufd_ctx;
 struct iommufd_viommu;
@@ -165,6 +166,15 @@ struct iommu_domain_geometry {
 	bool force_aperture;       /* DMA only allowed in mappable range? */
 };
 
+enum iommu_domain_cookie_type {
+	IOMMU_COOKIE_NONE,
+	IOMMU_COOKIE_DMA_IOVA,
+	IOMMU_COOKIE_DMA_MSI,
+	IOMMU_COOKIE_FAULT_HANDLER,
+	IOMMU_COOKIE_SVA,
+	IOMMU_COOKIE_IOMMUFD,
+};
+
 /* Domain feature flags */
 #define __IOMMU_DOMAIN_PAGING	(1U << 0)  /* Support for iommu_map/unmap */
 #define __IOMMU_DOMAIN_DMA_API	(1U << 1)  /* Domain for use in DMA-API
@@ -211,12 +221,12 @@ struct iommu_domain_geometry {
 
 struct iommu_domain {
 	unsigned type;
+	enum iommu_domain_cookie_type cookie_type;
 	const struct iommu_domain_ops *ops;
 	const struct iommu_dirty_ops *dirty_ops;
 	const struct iommu_ops *owner; /* Whose domain_alloc we came from */
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	struct iommu_domain_geometry geometry;
-	struct iommu_dma_cookie *iova_cookie;
 	int (*iopf_handler)(struct iopf_group *group);
 
 #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
@@ -224,10 +234,10 @@ struct iommu_domain {
 		      phys_addr_t msi_addr);
 #endif
 
-	union { /* Pointer usable by owner of the domain */
-		struct iommufd_hw_pagetable *iommufd_hwpt; /* iommufd */
-	};
-	union { /* Fault handler */
+	union { /* cookie */
+		struct iommu_dma_cookie *iova_cookie;
+		struct iommu_dma_msi_cookie *msi_cookie;
+		struct iommufd_hw_pagetable *iommufd_hwpt;
 		struct {
 			iommu_fault_handler_t handler;
 			void *handler_token;
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 94263ed2c564..bc9bb9cb70c8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -42,11 +42,6 @@ struct iommu_dma_msi_page {
 	phys_addr_t		phys;
 };
 
-enum iommu_dma_cookie_type {
-	IOMMU_DMA_IOVA_COOKIE,
-	IOMMU_DMA_MSI_COOKIE,
-};
-
 enum iommu_dma_queue_type {
 	IOMMU_DMA_OPTS_PER_CPU_QUEUE,
 	IOMMU_DMA_OPTS_SINGLE_QUEUE,
@@ -59,35 +54,31 @@ struct iommu_dma_options {
 };
 
 struct iommu_dma_cookie {
-	enum iommu_dma_cookie_type	type;
+	struct iova_domain iovad;
+	struct list_head msi_page_list;
+	/* Flush queue */
 	union {
-		/* Full allocator for IOMMU_DMA_IOVA_COOKIE */
-		struct {
-			struct iova_domain	iovad;
-			/* Flush queue */
-			union {
-				struct iova_fq	*single_fq;
-				struct iova_fq	__percpu *percpu_fq;
-			};
-			/* Number of TLB flushes that have been started */
-			atomic64_t		fq_flush_start_cnt;
-			/* Number of TLB flushes that have been finished */
-			atomic64_t		fq_flush_finish_cnt;
-			/* Timer to regularily empty the flush queues */
-			struct timer_list	fq_timer;
-			/* 1 when timer is active, 0 when not */
-			atomic_t		fq_timer_on;
-		};
-		/* Trivial linear page allocator for IOMMU_DMA_MSI_COOKIE */
-		dma_addr_t		msi_iova;
+		struct iova_fq *single_fq;
+		struct iova_fq __percpu *percpu_fq;
 	};
-	struct list_head		msi_page_list;
-
+	/* Number of TLB flushes that have been started */
+	atomic64_t fq_flush_start_cnt;
+	/* Number of TLB flushes that have been finished */
+	atomic64_t fq_flush_finish_cnt;
+	/* Timer to regularily empty the flush queues */
+	struct timer_list fq_timer;
+	/* 1 when timer is active, 0 when not */
+	atomic_t fq_timer_on;
 	/* Domain for flush queue callback; NULL if flush queue not in use */
-	struct iommu_domain		*fq_domain;
+	struct iommu_domain *fq_domain;
 	/* Options for dma-iommu use */
-	struct iommu_dma_options	options;
-	struct mutex			mutex;
+	struct iommu_dma_options options;
+	struct mutex mutex;
+};
+
+struct iommu_dma_msi_cookie {
+	dma_addr_t msi_iova;
+	struct list_head msi_page_list;
 };
 
 static DEFINE_STATIC_KEY_FALSE(iommu_deferred_attach_enabled);
@@ -369,40 +360,26 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
 	return 0;
 }
 
-static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
-{
-	if (cookie->type == IOMMU_DMA_IOVA_COOKIE)
-		return cookie->iovad.granule;
-	return PAGE_SIZE;
-}
-
-static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
-{
-	struct iommu_dma_cookie *cookie;
-
-	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
-	if (cookie) {
-		INIT_LIST_HEAD(&cookie->msi_page_list);
-		cookie->type = type;
-	}
-	return cookie;
-}
-
 /**
  * iommu_get_dma_cookie - Acquire DMA-API resources for a domain
  * @domain: IOMMU domain to prepare for DMA-API usage
  */
 int iommu_get_dma_cookie(struct iommu_domain *domain)
 {
-	if (domain->iova_cookie)
+	struct iommu_dma_cookie *cookie;
+
+	if (domain->cookie_type != IOMMU_COOKIE_NONE)
 		return -EEXIST;
 
-	domain->iova_cookie = cookie_alloc(IOMMU_DMA_IOVA_COOKIE);
-	if (!domain->iova_cookie)
+	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
+	if (!cookie)
 		return -ENOMEM;
 
-	mutex_init(&domain->iova_cookie->mutex);
+	mutex_init(&cookie->mutex);
+	INIT_LIST_HEAD(&cookie->msi_page_list);
 	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
+	domain->cookie_type = IOMMU_COOKIE_DMA_IOVA;
+	domain->iova_cookie = cookie;
 	return 0;
 }
 
@@ -420,29 +397,30 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
  */
 int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 {
-	struct iommu_dma_cookie *cookie;
+	struct iommu_dma_msi_cookie *cookie;
 
 	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
 		return -EINVAL;
 
-	if (domain->iova_cookie)
+	if (domain->cookie_type != IOMMU_COOKIE_NONE)
 		return -EEXIST;
 
-	cookie = cookie_alloc(IOMMU_DMA_MSI_COOKIE);
+	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
 	if (!cookie)
 		return -ENOMEM;
 
 	cookie->msi_iova = base;
-	domain->iova_cookie = cookie;
+	INIT_LIST_HEAD(&cookie->msi_page_list);
 	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
+	domain->cookie_type = IOMMU_COOKIE_DMA_MSI;
+	domain->msi_cookie = cookie;
 	return 0;
 }
 EXPORT_SYMBOL(iommu_get_msi_cookie);
 
 /**
  * iommu_put_dma_cookie - Release a domain's DMA mapping resources
- * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie() or
- *          iommu_get_msi_cookie()
+ * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
  */
 void iommu_put_dma_cookie(struct iommu_domain *domain)
 {
@@ -454,20 +432,27 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 		return;
 #endif
 
-	if (!cookie)
-		return;
-
-	if (cookie->type == IOMMU_DMA_IOVA_COOKIE && cookie->iovad.granule) {
+	if (cookie->iovad.granule) {
 		iommu_dma_free_fq(cookie);
 		put_iova_domain(&cookie->iovad);
 	}
+	list_for_each_entry_safe(msi, tmp, &cookie->msi_page_list, list)
+		kfree(msi);
+	kfree(cookie);
+}
 
-	list_for_each_entry_safe(msi, tmp, &cookie->msi_page_list, list) {
-		list_del(&msi->list);
+/**
+ * iommu_put_msi_cookie - Release a domain's MSI mapping resources
+ * @domain: IOMMU domain previously prepared by iommu_get_msi_cookie()
+ */
+void iommu_put_msi_cookie(struct iommu_domain *domain)
+{
+	struct iommu_dma_msi_cookie *cookie = domain->msi_cookie;
+	struct iommu_dma_msi_page *msi, *tmp;
+
+	list_for_each_entry_safe(msi, tmp, &cookie->msi_page_list, list)
 		kfree(msi);
-	}
 	kfree(cookie);
-	domain->iova_cookie = NULL;
 }
 
 /**
@@ -687,7 +672,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, struct device *dev
 	struct iova_domain *iovad;
 	int ret;
 
-	if (!cookie || cookie->type != IOMMU_DMA_IOVA_COOKIE)
+	if (!cookie || domain->cookie_type != IOMMU_COOKIE_DMA_IOVA)
 		return -EINVAL;
 
 	iovad = &cookie->iovad;
@@ -777,9 +762,9 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	struct iova_domain *iovad = &cookie->iovad;
 	unsigned long shift, iova_len, iova;
 
-	if (cookie->type == IOMMU_DMA_MSI_COOKIE) {
-		cookie->msi_iova += size;
-		return cookie->msi_iova - size;
+	if (domain->cookie_type == IOMMU_COOKIE_DMA_MSI) {
+		domain->msi_cookie->msi_iova += size;
+		return domain->msi_cookie->msi_iova - size;
 	}
 
 	shift = iova_shift(iovad);
@@ -816,16 +801,16 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	return (dma_addr_t)iova << shift;
 }
 
-static void iommu_dma_free_iova(struct iommu_dma_cookie *cookie,
-		dma_addr_t iova, size_t size, struct iommu_iotlb_gather *gather)
+static void iommu_dma_free_iova(struct iommu_domain *domain, dma_addr_t iova,
+				size_t size, struct iommu_iotlb_gather *gather)
 {
-	struct iova_domain *iovad = &cookie->iovad;
+	struct iova_domain *iovad = &domain->iova_cookie->iovad;
 
 	/* The MSI case is only ever cleaning up its most recent allocation */
-	if (cookie->type == IOMMU_DMA_MSI_COOKIE)
-		cookie->msi_iova -= size;
+	if (domain->cookie_type == IOMMU_COOKIE_DMA_MSI)
+		domain->msi_cookie->msi_iova -= size;
 	else if (gather && gather->queued)
-		queue_iova(cookie, iova_pfn(iovad, iova),
+		queue_iova(domain->iova_cookie, iova_pfn(iovad, iova),
 				size >> iova_shift(iovad),
 				&gather->freelist);
 	else
@@ -853,7 +838,7 @@ static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
 
 	if (!iotlb_gather.queued)
 		iommu_iotlb_sync(domain, &iotlb_gather);
-	iommu_dma_free_iova(cookie, dma_addr, size, &iotlb_gather);
+	iommu_dma_free_iova(domain, dma_addr, size, &iotlb_gather);
 }
 
 static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
@@ -881,7 +866,7 @@ static dma_addr_t __iommu_dma_map(struct device *dev, phys_addr_t phys,
 		return DMA_MAPPING_ERROR;
 
 	if (iommu_map(domain, iova, phys - iova_off, size, prot, GFP_ATOMIC)) {
-		iommu_dma_free_iova(cookie, iova, size, NULL);
+		iommu_dma_free_iova(domain, iova, size, NULL);
 		return DMA_MAPPING_ERROR;
 	}
 	return iova + iova_off;
@@ -1018,7 +1003,7 @@ static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
 out_free_sg:
 	sg_free_table(sgt);
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, size, NULL);
+	iommu_dma_free_iova(domain, iova, size, NULL);
 out_free_pages:
 	__iommu_dma_free_pages(pages, count);
 	return NULL;
@@ -1495,7 +1480,7 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 	return __finalise_sg(dev, sg, nents, iova);
 
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, iova_len, NULL);
+	iommu_dma_free_iova(domain, iova, iova_len, NULL);
 out_restore_sg:
 	__invalidate_sg(sg, nents);
 out:
@@ -1773,17 +1758,46 @@ void iommu_setup_dma_ops(struct device *dev)
 	dev->dma_iommu = false;
 }
 
+static bool has_msi_cookie(const struct iommu_domain *domain)
+{
+	return domain && (domain->cookie_type == IOMMU_COOKIE_DMA_IOVA ||
+			  domain->cookie_type == IOMMU_COOKIE_DMA_MSI);
+}
+
+static size_t cookie_msi_granule(const struct iommu_domain *domain)
+{
+	switch (domain->cookie_type) {
+	case IOMMU_COOKIE_DMA_IOVA:
+		return domain->iova_cookie->iovad.granule;
+	case IOMMU_COOKIE_DMA_MSI:
+		return PAGE_SIZE;
+	default:
+		unreachable();
+	};
+}
+
+static struct list_head *cookie_msi_pages(const struct iommu_domain *domain)
+{
+	switch (domain->cookie_type) {
+	case IOMMU_COOKIE_DMA_IOVA:
+		return &domain->iova_cookie->msi_page_list;
+	case IOMMU_COOKIE_DMA_MSI:
+		return &domain->msi_cookie->msi_page_list;
+	default:
+		unreachable();
+	};
+}
+
 static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 		phys_addr_t msi_addr, struct iommu_domain *domain)
 {
-	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iommu_dma_msi_page *msi_page;
 	dma_addr_t iova;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
-	size_t size = cookie_msi_granule(cookie);
+	size_t size = cookie_msi_granule(domain);
 
 	msi_addr &= ~(phys_addr_t)(size - 1);
-	list_for_each_entry(msi_page, &cookie->msi_page_list, list)
+	list_for_each_entry(msi_page, cookie_msi_pages(domain), list)
 		if (msi_page->phys == msi_addr)
 			return msi_page;
 
@@ -1801,11 +1815,11 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	INIT_LIST_HEAD(&msi_page->list);
 	msi_page->phys = msi_addr;
 	msi_page->iova = iova;
-	list_add(&msi_page->list, &cookie->msi_page_list);
+	list_add(&msi_page->list, cookie_msi_pages(domain));
 	return msi_page;
 
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, size, NULL);
+	iommu_dma_free_iova(domain, iova, size, NULL);
 out_free_page:
 	kfree(msi_page);
 	return NULL;
@@ -1817,7 +1831,7 @@ static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 	struct device *dev = msi_desc_to_dev(desc);
 	const struct iommu_dma_msi_page *msi_page;
 
-	if (!domain->iova_cookie) {
+	if (!has_msi_cookie(domain)) {
 		msi_desc_set_iommu_msi_iova(desc, 0, 0);
 		return 0;
 	}
@@ -1827,9 +1841,8 @@ static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 	if (!msi_page)
 		return -ENOMEM;
 
-	msi_desc_set_iommu_msi_iova(
-		desc, msi_page->iova,
-		ilog2(cookie_msi_granule(domain->iova_cookie)));
+	msi_desc_set_iommu_msi_iova(desc, msi_page->iova,
+				    ilog2(cookie_msi_granule(domain)));
 	return 0;
 }
 
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index 503c5d23c1ea..ab18bc494eef 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -310,6 +310,7 @@ static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 	}
 
 	domain->type = IOMMU_DOMAIN_SVA;
+	domain->cookie_type = IOMMU_COOKIE_SVA;
 	mmgrab(mm);
 	domain->mm = mm;
 	domain->owner = ops;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 0ee17893810f..8b9423340221 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1953,8 +1953,10 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
 					iommu_fault_handler_t handler,
 					void *token)
 {
-	BUG_ON(!domain);
+	if (WARN_ON(!domain || domain->cookie_type != IOMMU_COOKIE_NONE))
+		return;
 
+	domain->cookie_type = IOMMU_COOKIE_FAULT_HANDLER;
 	domain->handler = handler;
 	domain->handler_token = token;
 }
@@ -2024,9 +2026,18 @@ EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);
 
 void iommu_domain_free(struct iommu_domain *domain)
 {
-	if (domain->type == IOMMU_DOMAIN_SVA)
+	switch (domain->cookie_type) {
+	case IOMMU_COOKIE_DMA_IOVA:
+		iommu_put_dma_cookie(domain);
+		break;
+	case IOMMU_COOKIE_DMA_MSI:
+		iommu_put_msi_cookie(domain);
+		break;
+	case IOMMU_COOKIE_SVA:
 		mmdrop(domain->mm);
-	iommu_put_dma_cookie(domain);
+		break;
+	default:
+	}
 	if (domain->ops->free)
 		domain->ops->free(domain);
 }
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 7de6e914232e..227514030655 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -413,6 +413,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
 		iommufd_put_object(ucmd->ictx, &fault->obj);
 	}
 	hwpt->domain->iommufd_hwpt = hwpt;
+	hwpt->domain->cookie_type = IOMMU_COOKIE_IOMMUFD;
 
 	cmd->out_hwpt_id = hwpt->obj.id;
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
-- 
2.43.0

