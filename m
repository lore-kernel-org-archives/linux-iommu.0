Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9940C1805A
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706306; cv=fail; b=qbzNXA5EhsBrnK8Hv42fge0lQGp0+NVhFCG/BCKBu8/tb3Txi0MCirRYDgqt8TpjCTff/YdrMPhmZuL/EYetRLdDuBp1XVqv7IfTI3JiJWVdyO0BwU+PconGUyu9CCtlPhTY3s2qU4Tr5BsQdb+wgaOMyQJ0YziduXs+fnhOsyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706306; c=relaxed/simple;
	bh=YV7nOB+EjqCqWTXPkKidCBy77d4vPKnexZA+D5HZoBk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpF4qTJvuUBHcGjnI2vDw3nXgGeLmfgJQoeFDYiOSDmEpXH96xC2wHd04qtt4x5SK4voWdMdhtIg9q9IIXXSGw1o3gQlXXQgbA8SUcsBcrdY0LXUrbuxSA8ecJtXs6Sj6LmbRgLs+GPOMLe4aADdnwl3jcMaNklNpMA9rpZRGmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rr35U8yO; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rr35U8yO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fpu2IZYyvs8v8b5QrzC5ADXIMKSV/6aTQ1U4GhnnjJJCXKzEv0AykLuw9ns1po7qRGRMZGVCe3IxI8CxCr94VmNphJnbCxLnOXCwewI7gwWXiknUx1V3LXS8C1fB3GduOgj7g9Dj9IM+Kjcjzqu9Pbfh1AXZdJMzQLlzOxRks/DzAFppANaSB86UU7/Pvbx/yMBCrcE4U+ZtSyqHhctplP5MMpFxQnYTuS4nBewyyI1rtEsqQJL2UJZufZV0wLI6vfVWZTn5OZUYinb/P5WP1Duccbzsg3TepiNWUvGBnY5qHZRdslIPZzANoKmZW1JDIt58MzSrnv0jX2vNLNFxsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwnTuuJ2ZdOxm3eIeTElB769H7LWenbqCyhRM2uN7nE=;
 b=wQAMFVfndWMKKYxOrVg1ZRZYLQS+LiYMdov0b+LrNFXt9EjLDXENM3XqimHNpCqrh5qrN6h2tVvU+6OQf2tGKtMtwIJGnjPfXolbJPr/u/BzQSSj4ZFhUpo4TXgHppGldJ5TKgythkdsgDlhvfWQblMyrfX/ZEHpAi26y1FyWzf4Pn7iZeKTiCU2Od+qBed9t5a1fgVOI7j0smcDzuYZuyEuQ1lJEG39JUuwYV1FA13oWLBeePa96BXO1ILCkIOryD9lmepaMf50P7YhIEVwsDxha4pS0a/0bqWwSziMS+adr80WSVKqddRYLCw0MwjlYyO3CdhnOpnOCcc7DiyNSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwnTuuJ2ZdOxm3eIeTElB769H7LWenbqCyhRM2uN7nE=;
 b=rr35U8yOVZSY0d3Iqq/K0IOFOir7ImkAGjH0+8MwdPpOmmy3ac6qBI7/N0W2BefMke4uHyjWZmoYaTyDC+CwQsSY7oIEVb9+/Zn0Y44Rs7nzOquvVmkfzU6u7R2yW01EhoxLHB/5wOPCUQwFvmXQgVidmpudM9a9srrYVmUiCTiseUkOXg1cIQ7EmBRbj4Gv6hAX7lI+QSkUGvpkLwr9yyuSEQgONHYfqDaG3QJyP6XcobYqFac4+pqwTCQJG03n4xHFi9wLipXho4mmVMWOMRECstYFhXSZB9mmQyn/UTKFkSjTN2xVjLS87k1Nd7HgnJmOfBSN7pacMY2/4PGbEg==
Received: from BLAPR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:36e::9)
 by PH7PR12MB6835.namprd12.prod.outlook.com (2603:10b6:510:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 01:31:39 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::2d) by BLAPR05CA0006.outlook.office365.com
 (2603:10b6:208:36e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.9 via Frontend Transport; Fri,
 28 Feb 2025 01:31:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 01:31:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 17:31:24 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 27 Feb
 2025 17:31:24 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 27 Feb 2025 17:31:24 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] iommu: Drop sw_msi from iommu_domain
Date: Thu, 27 Feb 2025 17:31:17 -0800
Message-ID: <c451161add9a598b6746eea947a99166e44bac31.1740705776.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740705776.git.nicolinc@nvidia.com>
References: <cover.1740705776.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|PH7PR12MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb1d2d1-265a-411b-275f-08dd5797a614
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lXUEqZiQL2AWtDhnfNJApK+tT6r/5bOniiSiUbDZr7FgMPMh3Enrsjqy9UI+?=
 =?us-ascii?Q?uY1nZz6qfa/J78cr2P42WI5KJ6L89abrOwB6C7d4CFhZCI5r+7bFswebjBEz?=
 =?us-ascii?Q?cy9+H/1sanbYSngogq+H99hs1rvR9EYfxbWJw4Tm51E6/E77AGgip1MrvlzO?=
 =?us-ascii?Q?tcHaGHBIkAsU5oVoYfrcXBrr5EU1/1wTF1l0civDr9LlXZKCCa5NMU435LaD?=
 =?us-ascii?Q?h57JIsYpYjUsEvUWojwRvIkvdFBL2k5/UB+ukir1zkbMrhp/0sFf8Jgr7NJC?=
 =?us-ascii?Q?yp5rdtjPvqO6FTtqTU16X4fp7pTXy+3enM0kNoom8WTZaIQAvkbdoj9933bl?=
 =?us-ascii?Q?CuxaA+9KNwn7Jx82F5ST7yueuNV6633N5aboE/FESByM2l+KU1FFslRZpHfC?=
 =?us-ascii?Q?mKBYwa+m/htyvwhHZLsn/xc4n4071jJZ/s16fDP3Xvl1UHESODHaYDcIGpyA?=
 =?us-ascii?Q?gxWrPLncVwKIt8z3x2ED9qYDoFulw2cDWRlYMBJLM5tX7AV8HysJ23sveXXX?=
 =?us-ascii?Q?c7sznlG6GeX+sri0zrvhJRX4Opf/1rIUCKvJHfQUnUpjfnK3grl3E1u4+L3+?=
 =?us-ascii?Q?N1ci74JFwK9LEeNP2yj5NJ197eERwYvqeiAPvkmuT+z3NgHwszfcQKXY32ss?=
 =?us-ascii?Q?dCzwx03HaHKqKsXLi+1hqbTfakrKrxT9y1f2L7MffWL9t/vmLmDrHSLe0fDo?=
 =?us-ascii?Q?0Yl34V8VgbgpJiihkw33h3EILHJCnJgl1E/hSoMB+QX3018A2F2VM7KOPVbW?=
 =?us-ascii?Q?zQm3K1QwYl3RoR1A9uhH0WM69w0rjFSKKgj4Af7fgDSrEKRumnXF4yIcp7Bs?=
 =?us-ascii?Q?grXPyEW/d66t6VhEt8jfhGG/6P6GeCeyiVhkEZ2D/7WQjZpMQG5TB0zPfqPD?=
 =?us-ascii?Q?wkuXlmkv4te7h5lohnxYzRJ4Mv6JaMmjY9aR5KwELv3w3+6YyMEjhZXZ9Ge+?=
 =?us-ascii?Q?HmSUxnWZfYhHCPL8+0JJ0oIHZS42smgrGywcS1Hn7ip/B8PK8Vp8g6orMk5S?=
 =?us-ascii?Q?tvmssWPY4muBYYVnfMpOcr+EWXlx7A6CWuBfcyXkFOLFpgUaP7XWQwFHUI8b?=
 =?us-ascii?Q?h4GiWo7h6Zxu9iimvh3B0oD6zl/tpIy+G78dviyrZbQy9/2Dx3z4RQPBbiIM?=
 =?us-ascii?Q?bcoiLE+G+LMndzqJVfnI6AU8HP2+nD4V+o2gYRu3khivNpjC3f624N6jAEho?=
 =?us-ascii?Q?3pNJ7FMzzpLEKRYjB/RauJyogdpgfCwV5EL9M76cKGWt7SkITaARHx007nMT?=
 =?us-ascii?Q?S/zWrmQoOJiVxzdsEQ75KrYQBOz+JBysZjXIqTtfbovVCf8Vh/R2FjKVLB/l?=
 =?us-ascii?Q?+F6r9xJxwzwC455Ddo2RadwcSpNdsg6kQS3yJ6665eaICRdiPF9cw2j5Zr5h?=
 =?us-ascii?Q?JlBV/pz/0H6wMrDP6SviLDfB0w3VgIRhheseBtEJtfxEVIT4rIovm9lzoSZW?=
 =?us-ascii?Q?1mlHnwMV0k4YLpVmlkTGzzCTd9St4mo4K/JMjFlXQQkv5vIZ74tsdJRamWg6?=
 =?us-ascii?Q?n4HX8tI7q9P5N2w=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 01:31:39.2464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb1d2d1-265a-411b-275f-08dd5797a614
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6835

There are only two sw_msi implementations in the entire system, thus it's
not very necessary to have an sw_msi pointer.

Instead, check domain->private_data_owner to call the two implementations
directly from the core code.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/dma-iommu.h            |  9 +++++++++
 include/linux/iommu.h                | 15 ---------------
 drivers/iommu/dma-iommu.c            | 13 +++----------
 drivers/iommu/iommu.c                | 16 ++++++++++++++--
 drivers/iommu/iommufd/hw_pagetable.c |  3 ---
 5 files changed, 26 insertions(+), 30 deletions(-)

diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index c12d63457c76..97f1da1efbb4 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -18,6 +18,9 @@ int iommu_dma_init_fq(struct iommu_domain *domain);
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
+int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+		     phys_addr_t msi_addr);
+
 extern bool iommu_dma_forcedac;
 
 #else /* CONFIG_IOMMU_DMA */
@@ -44,5 +47,11 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
 {
 }
 
+static inline int iommu_dma_sw_msi(struct iommu_domain *domain,
+				   struct msi_desc *desc, phys_addr_t msi_addr)
+{
+	return -ENODEV;
+}
+
 #endif	/* CONFIG_IOMMU_DMA */
 #endif	/* __DMA_IOMMU_H */
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4f2774c08262..29400060d648 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -224,11 +224,6 @@ struct iommu_domain {
 	struct iommu_dma_cookie *iova_cookie;
 	int (*iopf_handler)(struct iopf_group *group);
 
-#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
-	int (*sw_msi)(struct iommu_domain *domain, struct msi_desc *desc,
-		      phys_addr_t msi_addr);
-#endif
-
 	union { /* Pointer usable by owner of the domain */
 		struct iommufd_hw_pagetable *iommufd_hwpt; /* iommufd */
 	};
@@ -249,16 +244,6 @@ struct iommu_domain {
 	};
 };
 
-static inline void iommu_domain_set_sw_msi(
-	struct iommu_domain *domain,
-	int (*sw_msi)(struct iommu_domain *domain, struct msi_desc *desc,
-		      phys_addr_t msi_addr))
-{
-#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
-	domain->sw_msi = sw_msi;
-#endif
-}
-
 static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
 {
 	return domain->type & __IOMMU_DOMAIN_DMA_API;
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 78915d74e8fa..7ee71b9c53bd 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -103,9 +103,6 @@ static int __init iommu_dma_forcedac_setup(char *str)
 }
 early_param("iommu.forcedac", iommu_dma_forcedac_setup);
 
-static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-			    phys_addr_t msi_addr);
-
 /* Number of entries per flush queue */
 #define IOVA_DEFAULT_FQ_SIZE	256
 #define IOVA_SINGLE_FQ_SIZE	32768
@@ -402,7 +399,6 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
 		return -ENOMEM;
 
 	mutex_init(&domain->iova_cookie->mutex);
-	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
 	domain->private_data_owner = IOMMU_DOMAIN_DATA_OWNER_DMA;
 	return 0;
 }
@@ -435,7 +431,6 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 
 	cookie->msi_iova = base;
 	domain->iova_cookie = cookie;
-	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
 	domain->private_data_owner = IOMMU_DOMAIN_DATA_OWNER_DMA;
 	return 0;
 }
@@ -451,10 +446,8 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iommu_dma_msi_page *msi, *tmp;
 
-#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
-	if (domain->sw_msi != iommu_dma_sw_msi)
+	if (domain->private_data_owner != IOMMU_DOMAIN_DATA_OWNER_DMA)
 		return;
-#endif
 
 	if (!cookie)
 		return;
@@ -1813,8 +1806,8 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
 	return NULL;
 }
 
-static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-			    phys_addr_t msi_addr)
+int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+		     phys_addr_t msi_addr)
 {
 	struct device *dev = msi_desc_to_dev(desc);
 	const struct iommu_dma_msi_page *msi_page;
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 022bf96a18c5..462d7bc0d47a 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -18,6 +18,7 @@
 #include <linux/errno.h>
 #include <linux/host1x_context_bus.h>
 #include <linux/iommu.h>
+#include <linux/iommufd.h>
 #include <linux/idr.h>
 #include <linux/err.h>
 #include <linux/pci.h>
@@ -3619,8 +3620,19 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 		return 0;
 
 	mutex_lock(&group->mutex);
-	if (group->domain && group->domain->sw_msi)
-		ret = group->domain->sw_msi(group->domain, desc, msi_addr);
+	if (group->domain) {
+		switch (group->domain->private_data_owner) {
+		case IOMMU_DOMAIN_DATA_OWNER_DMA:
+			ret = iommu_dma_sw_msi(group->domain, desc, msi_addr);
+			break;
+		case IOMMU_DOMAIN_DATA_OWNER_IOMMUFD:
+			ret = iommufd_sw_msi(group->domain, desc, msi_addr);
+			break;
+		default:
+			ret = -EOPNOTSUPP;
+			break;
+		}
+	}
 	mutex_unlock(&group->mutex);
 	return ret;
 }
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 5640444de475..ba46f9c0a81f 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -156,7 +156,6 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			goto out_abort;
 		}
 	}
-	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 	hwpt->domain->private_data_owner = IOMMU_DOMAIN_DATA_OWNER_IOMMUFD;
 
 	/*
@@ -253,7 +252,6 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 		goto out_abort;
 	}
 	hwpt->domain->owner = ops;
-	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 	hwpt->domain->private_data_owner = IOMMU_DOMAIN_DATA_OWNER_IOMMUFD;
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
@@ -311,7 +309,6 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 		goto out_abort;
 	}
 	hwpt->domain->owner = viommu->iommu_dev->ops;
-	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 	hwpt->domain->private_data_owner = IOMMU_DOMAIN_DATA_OWNER_IOMMUFD;
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
-- 
2.43.0

