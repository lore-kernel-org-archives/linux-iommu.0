Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074931A5BA0
	for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 04:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742875553; cv=fail; b=bW2pnnPgzz1uT1fOpCn67O7TBBx85KJOZDJIMoN7HGeK8wcpxX5lxHjygUf9/kmULpVIyEM4rZuZ0enKx+C/Sqg0D1oO6Q4i0zBFZtHD0nfhF22+1uL6HectMSdel3A04xybzEstopeVPWtOOWLyS/ALI9mX6rwK5vBbmYiOzc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742875553; c=relaxed/simple;
	bh=KMc3Z9QtcvPaiT4Lb6RMUbyhGMK/tB94EGHDSl9nqNs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EEDAesvQq8FPr/ZrHK7uynZ2LW82xgHkdRuClU0tglOYveO4UdAbqQevhYatVeeTdy8dJIbVRHPlltnapKVO+/4/xMTZbBxCwb/eaGDDLINgPyXqKFG1t/HH0EuHjaFhmRx+kYpa/62IhACJda/ONMrhWcXo0YNePhT24PPlnf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PdMlJzxf; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PdMlJzxf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U7smCjdADMsQgxK9whcuf301Pp5Kjqi7xYKmqddE6MyrgX7b2MH0lPWN4MnxXAVvp4YyHqtk1u+Ue/lzSVkOEoQ6Ax4p5NfmtYJ5ssXdgzVIkF8spF9Wa29mbdvE0uX1elDykqb0TB/LJ5C6DAnB9I9AeksnzZUeHYtH2AoeoKRWEBZCa+KP5cEdTS4w8y+IZGOYBTKSFOjp9wCMJSjojdVcClYpR902T9o+y4wAa06Acpf8J89IuIdOpAj9bf19H4OWbpObDUDwjp7wq99fARpXj8ky7ss+fIKG7q/DvetL+C81aaVMYBA5ZXUS4Ol+BTVCCNaOHOoU5Suh3nFy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7nRM4Cmqibc1ea2+t61wNNfm0QT+iik+n3hUCIfeCo=;
 b=PSM2enXF9bt1lMF3SFef9Abaw8GVzrbTDmln7D2AYI0/Wd/c+K0VM3jauKb/cf95s4A7USQCbzJ++AStsGDWSTG+63fLDLeT8oZZ1GxBCFY8JhulMyOVl9bSNFeW5OG+qd44bAyBiXsx9oeWaPS3q9tEUPxaA/U7tPLWKDN5e+mhS3yscCZUABSKW/jz7ceFQ2gUO6eTxK76TDDtyGru6Tb0ozyOFDdqig5FfhBcMUW0CJvep7Xudik3xf88tSxVrkDtRoErQh3VCde5Za5/nyAMGFa3cKf49XOeCZX0TjTzB/cwRlogY4E7fV8gmF2RbPs2Vf8Ld/T8Fu1H2nPC6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7nRM4Cmqibc1ea2+t61wNNfm0QT+iik+n3hUCIfeCo=;
 b=PdMlJzxf9157EBwMNkK+f0yyZqaT80kzbk4pcWTlW5MnfoyIiYmqt2O7Vt34cZqupaLbo31ArKZkbRb2HT8zsDulPwRb0HZm15gJUraolDASQlfaqMyzMT3KQ96B/6qMyJEGz88s8rfO4rwi+9FVpnjgmBmdmId74E/XxnH0EHDU82sCZoD2Z5kSrK18qNj5P1szjiMsJP7UU9PgUtdWv2EXHY2ntbI4EFkb1zKOmiJvfyFR1obJkwLFSq/aMJn1jziGvaMqLWfszQW+zUKXJ7kzlUDo2pma/4MLB9ipfII1GcErq0urEFhu+TjO3TNMSmL3MpySiw9AmlPlfNdCwQ==
Received: from SJ0PR03CA0219.namprd03.prod.outlook.com (2603:10b6:a03:39f::14)
 by DS7PR12MB8274.namprd12.prod.outlook.com (2603:10b6:8:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 04:05:43 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::f2) by SJ0PR03CA0219.outlook.office365.com
 (2603:10b6:a03:39f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 04:05:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 25 Mar 2025 04:05:42 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Mar
 2025 21:05:27 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 24 Mar
 2025 21:05:27 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 24 Mar 2025 21:05:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<kevin.tian@intel.com>, <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <nathan@kernel.org>, <arnd@arndb.de>
Subject: [PATCH v5 1/3] iommu: Sort out domain user data
Date: Mon, 24 Mar 2025 21:05:15 -0700
Message-ID: <1ace9076c95204bbe193ee77499d395f15f44b23.1742871535.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1742871535.git.nicolinc@nvidia.com>
References: <cover.1742871535.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|DS7PR12MB8274:EE_
X-MS-Office365-Filtering-Correlation-Id: 924a3587-069a-418e-76cf-08dd6b524fd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kt9/gBgKSTj+hmZfjSxiR7t409eYQSmMQ27AhdUOpGPGDnwmqIbeOgr7ZhHs?=
 =?us-ascii?Q?pzmsiiGwcJmqqRYkLfvYbxC7I8QgXinfq8RiimStt1IAA/71fi/sC0qhEU9E?=
 =?us-ascii?Q?sAU8yKmtHcaYyKLVS8z4RC0MMIgGg728myoaXWWhg8XjfLeC6bH+Z6tAuWqL?=
 =?us-ascii?Q?mHpL7ElbNNYtoKiZdVamulAw8k3hPkZEZfDdxV0KNlRQDGzOVvAH68Iot+Cn?=
 =?us-ascii?Q?QsHJGihQsts9EcjkLWVoI2GqLqZOdX0ReaO85kqP/i5PssCjpSqffGlL5T1l?=
 =?us-ascii?Q?DcwUKHKfKWOTjkmSbPW4gbe2hllirMAPEU3DGFngIu17i7WM0K21CMQeF2zd?=
 =?us-ascii?Q?mTPyT+TDJ4Em2pvZ+VjY3jz4nx3SYbeRbqTz1TMvYY/Zod1AhKajGp1oWyrt?=
 =?us-ascii?Q?Y6yHcxAYL6+aCvhZQKS/4h86oL9OVhvevnV9l7e+EK8DlHr6MIfJxg/iJAT/?=
 =?us-ascii?Q?YbiRgqK49aorSya1umhTTg0hwjujrKBlYqnXHsW167EjctdfcPBoBtTX1Djv?=
 =?us-ascii?Q?4YwwrUiZnMLOZSv5aDdAzngG3vYYw78r8XtHPXR4jBnR1o/lS76mKTSoixHk?=
 =?us-ascii?Q?ViZaIIjPcReotvkqCPWhNuC/gu+z6AL/n/KQRi8AJXnwwwwwUCmacs24EHzR?=
 =?us-ascii?Q?RrQo/Gje+jeloj/poCz5bNdq7ks8jz7p1uHgCTrjWACA6cw6fPkjK+h3cvr+?=
 =?us-ascii?Q?u46IPRIicXpPuRTkubPpMJAZ4e0yxkPk4GF28a3pRMm39OYcJl0hAeNZLwwC?=
 =?us-ascii?Q?aTUSUFHMyzHO8RPU8XsF1eGUBJsIMq7Q65gckvyCxkWZwT2U8njp/doL23TE?=
 =?us-ascii?Q?n/ZIMLg0AJSRpvXxlnfO0J0yuHNd6ztN4obCpfhoj/4wNIUgMwh+HYTG7EfZ?=
 =?us-ascii?Q?NDmhAhi6Gzq5V82yME2EEgsOK9DUQoHUwAXOG/kfvP8yaP7aofYwQfSHyz/n?=
 =?us-ascii?Q?LunQoDlLpAY1WrOWecfnYpb5eMtriUL9MmrsYC0B7bQR03DyjkTMrohSj2j9?=
 =?us-ascii?Q?0bEXc1nVLXfFiQ/GKeJhOty56CP8xSbRb+bDDQun23iK6csfekOJopV0gqTU?=
 =?us-ascii?Q?IpfnMw9wkiO24ZuOPMLraFIdZVvaihwuTIUf61/xmB75Ef0w7RSttzPzNqM/?=
 =?us-ascii?Q?ZZbGMcLdY+8rx/nRnRlFB2++RbtklUi40HLRTSlWiRMrL8/PBrkC3/8vjPRr?=
 =?us-ascii?Q?IO1T6pnB6aBNKmjFw6DMWGke97VixvE+JcQFd7zCFVxXTcFmtkdl4YQdrBoR?=
 =?us-ascii?Q?B3vq3vjW03mY0YY7r1pVnPWOlP6/lwQFc8lCZtpG7bjnk+eH6o6YJmSSbJ3q?=
 =?us-ascii?Q?PUKrp2vzXfEmx7IyleIsk+E/5c399NDVQl8yVjE2EOMMH1vggGgtxxi12dWa?=
 =?us-ascii?Q?CuTp1DBiDudqQlWhhGFJXkyILQbLYOOdbulbCH0zCFITy4txE7NNE0YRuq2Z?=
 =?us-ascii?Q?98fbCxJl8P3FqZGw24IP1kVtdTMbGDvwXLx+hfk6QazkFE7xmNbCcpRn0M7L?=
 =?us-ascii?Q?ksde8jKj8Vur5NU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 04:05:42.6551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924a3587-069a-418e-76cf-08dd6b524fd7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8274

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

[nicolinc: rebase on latest tree; use prefix IOMMU_COOKIE_; merge unions
           in iommu_domain; add IOMMU_COOKIE_IOMMUFD for iommufd_hwpt]

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/dma-iommu.h            |   5 +
 include/linux/iommu.h                |  20 ++-
 drivers/iommu/dma-iommu.c            | 194 ++++++++++++++-------------
 drivers/iommu/iommu-sva.c            |   1 +
 drivers/iommu/iommu.c                |  18 ++-
 drivers/iommu/iommufd/hw_pagetable.c |   3 +
 6 files changed, 143 insertions(+), 98 deletions(-)

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
index 94263ed2c564..31a7b4b81656 100644
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
@@ -1773,17 +1758,47 @@ void iommu_setup_dma_ops(struct device *dev)
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
+	struct list_head *msi_page_list = cookie_msi_pages(domain);
 	struct iommu_dma_msi_page *msi_page;
 	dma_addr_t iova;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
-	size_t size = cookie_msi_granule(cookie);
+	size_t size = cookie_msi_granule(domain);
 
 	msi_addr &= ~(phys_addr_t)(size - 1);
-	list_for_each_entry(msi_page, &cookie->msi_page_list, list)
+	list_for_each_entry(msi_page, msi_page_list, list)
 		if (msi_page->phys == msi_addr)
 			return msi_page;
 
@@ -1801,11 +1816,11 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	INIT_LIST_HEAD(&msi_page->list);
 	msi_page->phys = msi_addr;
 	msi_page->iova = iova;
-	list_add(&msi_page->list, &cookie->msi_page_list);
+	list_add(&msi_page->list, msi_page_list);
 	return msi_page;
 
 out_free_iova:
-	iommu_dma_free_iova(cookie, iova, size, NULL);
+	iommu_dma_free_iova(domain, iova, size, NULL);
 out_free_page:
 	kfree(msi_page);
 	return NULL;
@@ -1817,7 +1832,7 @@ static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
 	struct device *dev = msi_desc_to_dev(desc);
 	const struct iommu_dma_msi_page *msi_page;
 
-	if (!domain->iova_cookie) {
+	if (!has_msi_cookie(domain)) {
 		msi_desc_set_iommu_msi_iova(desc, 0, 0);
 		return 0;
 	}
@@ -1827,9 +1842,8 @@ static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
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
index 0ee17893810f..c92e47f333cb 100644
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
@@ -2024,9 +2026,19 @@ EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);
 
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
+		break;
+	}
 	if (domain->ops->free)
 		domain->ops->free(domain);
 }
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 9a89f3a28dc5..fded3f07bfa7 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -160,6 +160,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		}
 	}
 	hwpt->domain->iommufd_hwpt = hwpt;
+	hwpt->domain->cookie_type = IOMMU_COOKIE_IOMMUFD;
 	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
 	/*
@@ -257,6 +258,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	}
 	hwpt->domain->owner = ops;
 	hwpt->domain->iommufd_hwpt = hwpt;
+	hwpt->domain->cookie_type = IOMMU_COOKIE_IOMMUFD;
 	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
@@ -315,6 +317,7 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 	}
 	hwpt->domain->iommufd_hwpt = hwpt;
 	hwpt->domain->owner = viommu->iommu_dev->ops;
+	hwpt->domain->cookie_type = IOMMU_COOKIE_IOMMUFD;
 	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
-- 
2.43.0

