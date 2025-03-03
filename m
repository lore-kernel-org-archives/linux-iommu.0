Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2067.outbound.protection.outlook.com [40.107.236.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6871238D49
	for <iommu@lists.linux.dev>; Mon,  3 Mar 2025 20:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741035207; cv=fail; b=S33joHkwryZtZ/RM6lydTw3d+eZ1fauACen6icR4N/+X6tv51j2s7IxQ2iPcveGwTMLglg2VXOixTx29diQpueZ4KhV1JZ3VkrmQjHCnc+wKWm8Me5u+muN1eOrYrZIT65J3kmdH7ud/2ugbruqtW0VB4EfkERrwz9Jp7wL1FAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741035207; c=relaxed/simple;
	bh=BFCBgBppE/mW58ItAEowCNQNdpOE26zdSCGzfSNCg74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvCu7woVz4vd5gIKj7qY7fgU5NFgj8WaBhlRWGGfZryKbSPp6vOGT3A6AMYwOCkgHb5q0RWq5J3W+PUu/JJMvQ8mrecIYGMQYdq9OTD8Y3DRSC1b2EfruWEjl+CFMEqIFH2rRp+hib26Xt688G23wlbM864VWpkv8rp3eMpsS70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cCyThRpz; arc=fail smtp.client-ip=40.107.236.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cCyThRpz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zOmHtlGNLO050mZS7by8WvsEjErR6OPtYfLvjWxulszs24clwYefUa7KJZ7REOzYSDky7ssC9lT45og8dtGeGpTSXtd2oi1gfdBvLhQUTiMR+yDgGqGL9Y500DVfAUUfHm8UttJSbuasEYo9zzKVoWUKAA3Rm6KUJgzDjApui1vKfb177pVQJJ0zdBpWruwQuHJXqT+PrtpmHLjTjfQSzTZyZaHqn64EiepCHdF7RHhUAGG9cSUcpZr3/wua9O5pq+IuHRQR6n2VuFqTUksw5Qxj5M3z6yNn7jXfBTiHFix3h/UCcyie7rpPYaXOsfmf/Xc3WIhjj7RiCe53hBE3YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SNaIAZYFuU6j7JOmcXOK7GZZ02/RKpa/b8pH+6T/Ffg=;
 b=hc7q1yRCX0NpxvypGO+QceOzjB5q4TNTnrT0pkL0nRk+gziudpliQZ/xMW8XyAmrx74DS6ZKx5UbDac3cRDdhlJxotrZk6NKo9NZCS7SgmFno4WA76Rj1c5C8Qx9A7XoV4SLijs2BjnJfgypRH7HxPr/Uez9RA0I7qSDJ/fOh9uMp4st+ENDuei7TCssnrBAeRe3avY5TLbGzH9VoAoJbLfauL9h5dgMU0klvKMv38YmYY9dVb6lzfJSaJKx+wsGOd86619wLvfUzfXfC+2ljokGRKYYLtXlZeDNLPAwSTLpgWm1t9g8fjTqD6KNqQt1xJCTC0pgLBtc0p3MTenyFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SNaIAZYFuU6j7JOmcXOK7GZZ02/RKpa/b8pH+6T/Ffg=;
 b=cCyThRpzhGNyHc2MqeDwsRPIiASaiR9i4EIjToSe07H8muXS65t7XzfYHdXuYM95GaYgOrEDLGZJ8Yeb3XCv77hD0ltZ1XXA8A6auRewYfjw1gEKsuT7996Ksko6DKh4pnzC+VwxXqiQQLcZP9Nw3rtWUxM83TrnrPea5b5oxtW0t59RfO3oGi+1Yg2+IwufCgx6xwuOrLFV0GN8+axOpgf009XqUg7ZMolD3RYjc63XZGg/UYNJ5BzbGMK/HF1ittZtrMmnR39gwwUjp2xZ1x/9HyY8Riela4rrvkZ4TyufMwUUbXZo7PjRXLENVZi7JZDthocTLanG+CuBpqXmew==
Received: from MW4PR03CA0262.namprd03.prod.outlook.com (2603:10b6:303:b4::27)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Mon, 3 Mar
 2025 20:53:16 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:303:b4:cafe::26) by MW4PR03CA0262.outlook.office365.com
 (2603:10b6:303:b4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Mon,
 3 Mar 2025 20:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 20:53:16 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Mar 2025
 12:53:06 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Mar
 2025 12:53:05 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 3 Mar 2025 12:53:05 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] iommu: Drop sw_msi from iommu_domain
Date: Mon, 3 Mar 2025 12:52:52 -0800
Message-ID: <17eead28dcf8ae6b246471c05c2cf1eb0774236b.1741034886.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ec5269-5494-4916-83c0-08dd5a956c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ptdHpK7a0x02d50XWM0vJzwInRkq2evM9zqTuQSdjwywrcbYYpfqTWhfgLdR?=
 =?us-ascii?Q?fiO5hH6FdQHqKu2Pamb5GldJnex2bL/Ub+w8II8pUq/7ltUGoeroSzsnvhC0?=
 =?us-ascii?Q?GWkRFcZmCMbJdy54HEfp2rGpVHzGWaRJuWwFQRw5yg2/3ISGrhE/JWuqc9Ij?=
 =?us-ascii?Q?ZS0VOibMw0C+XQLApri+hidt+pAWVzJHRKafIxvwLo3vYjkNeaYn5mpEmEmI?=
 =?us-ascii?Q?K45u9Bac2MrM2ltpEOHgbaTboS+5t4JTyfaFZUjYC83SDZ8mLOtPhH244Dhh?=
 =?us-ascii?Q?+x7MhSJlYA9bIpy510Ekm4VECZ3zYhL7eTrzKlZUwvLIcae+gGMG1f1IPPLO?=
 =?us-ascii?Q?Zj0E+/SQLN7bmUROxEJS8fMeZLyYecJNAxhcxxopg2oezwIeYISSoIwlDYfd?=
 =?us-ascii?Q?9YscTeLWuIOfUt1DBDTOuzRfQwubkuZ7gQILH7sCNyy+8V+cdWB3ZGJc1AD2?=
 =?us-ascii?Q?zH/EBEFOK8XYwdlMciXuizo72ziwTtPFLEQCW2rOPS2bgBrq/TKRxCyh5yvf?=
 =?us-ascii?Q?YtJnKyQb+IRk/RptWzmHY+EDE0VJak8TzGt3CIGdP41+k74V6eVl8o91/6tq?=
 =?us-ascii?Q?CTgnFuQK3eh/D4KBncrPxffQwSyO663z11QA+GqGo2KLrEfRjJnMlIGGjSZ+?=
 =?us-ascii?Q?jODfBdAPcVJJqMccQO+PsPwqS5HIRq6G3Q4+P/paVrA1Ii9RvLe9u8E0BZh0?=
 =?us-ascii?Q?ff+TdJrQTrIFt44JwHLT1GyjwemaL2iE9QVATf/FRyIg2IB9eqRrLti3J8Mp?=
 =?us-ascii?Q?fCVKyxRm3qsSPABhfdWuCvR5LSXfNsuWuxznF3cHYu6+5Js7zW1UvOdfI4PN?=
 =?us-ascii?Q?sEr0uiXGvEFFoM5VfHNbEop9DFw3BwmBN6Fi6FUJN2x2NAYVCbRMXKfWyA9r?=
 =?us-ascii?Q?gRXxDZ6M4tl5af18Y+x/hEZ203+vJBE8DdQ3m9rA5nTuO4GwItMyEuA0A0J9?=
 =?us-ascii?Q?SuD7pQ2Iw8UojIoobs9UFwMljUDDSo1FJIxi+F7NFppmPLma7jAQO0t8ZcI+?=
 =?us-ascii?Q?7uNcDr+KdPfzgnDep3CvpAd1YpddBXSC4oFH/UoXDTxjkFqbQK1ilGIGCcSF?=
 =?us-ascii?Q?zt1tqsymBz86lwg5DUj1/BmDIJRy9ePfhdPPZbUReFJCrd1XndP3wf6qmkfy?=
 =?us-ascii?Q?9xEbbjVaN64/fetVtp0bPuj+3xH/bbbIIpWS2QtLO9N1n0jcmXgesS8h1yQy?=
 =?us-ascii?Q?TnTwF0EhZICpNPtnfCKuekBNvgEEd/x/QIJFqh9LeriI3nWInJYU71uodToC?=
 =?us-ascii?Q?V/7gd/nWQJIaxlx8hIkcGJaJvtPqHvp89urmxTfyGClsJGZC0CuLU/PHGJsW?=
 =?us-ascii?Q?CzoBHN9i7CYH/bOzfe7BP9NOWKF1WxWXRuyWP3Udw4DFlJb25xvCzSLv8gnA?=
 =?us-ascii?Q?BVbWuX15kgKDPiXV03+jCkXiXxU4l3gkREvffjPoklmVcErkqQi9VOMhSMwz?=
 =?us-ascii?Q?6M30/86x6p8veKBZ95OpB6dBJfFCS1IPSrwUhqEgOhaSi71wRJenvws+AS5e?=
 =?us-ascii?Q?7i7KYUO6wKadrK0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 20:53:16.5920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ec5269-5494-4916-83c0-08dd5a956c14
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492

There are only two sw_msi implementations in the entire system, thus it's
not very necessary to have an sw_msi pointer.

Instead, check domain->private_data_owner to call the two implementations
directly from the core code.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/dma-iommu.h            |  9 +++++++++
 include/linux/iommu.h                | 15 ---------------
 drivers/iommu/dma-iommu.c            | 14 ++------------
 drivers/iommu/iommu.c                | 17 +++++++++++++++--
 drivers/iommu/iommufd/hw_pagetable.c |  3 ---
 5 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index 9cca11806e5d..eca201c1f963 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -19,6 +19,9 @@ int iommu_dma_init_fq(struct iommu_domain *domain);
 
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
 
+int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
+		     phys_addr_t msi_addr);
+
 extern bool iommu_dma_forcedac;
 
 #else /* CONFIG_IOMMU_DMA */
@@ -49,5 +52,11 @@ static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_he
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
index 06cc14e9993d..e01c855ae8a7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -229,11 +229,6 @@ struct iommu_domain {
 	struct iommu_domain_geometry geometry;
 	int (*iopf_handler)(struct iopf_group *group);
 
-#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
-	int (*sw_msi)(struct iommu_domain *domain, struct msi_desc *desc,
-		      phys_addr_t msi_addr);
-#endif
-
 	union { /* cookie */
 		struct iommu_dma_cookie *iova_cookie;
 		struct iommu_dma_msi_cookie *msi_cookie;
@@ -254,16 +249,6 @@ struct iommu_domain {
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
index bc9bb9cb70c8..96e9f8d0a4f6 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -94,9 +94,6 @@ static int __init iommu_dma_forcedac_setup(char *str)
 }
 early_param("iommu.forcedac", iommu_dma_forcedac_setup);
 
-static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
-			    phys_addr_t msi_addr);
-
 /* Number of entries per flush queue */
 #define IOVA_DEFAULT_FQ_SIZE	256
 #define IOVA_SINGLE_FQ_SIZE	32768
@@ -377,7 +374,6 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
 
 	mutex_init(&cookie->mutex);
 	INIT_LIST_HEAD(&cookie->msi_page_list);
-	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
 	domain->cookie_type = IOMMU_COOKIE_DMA_IOVA;
 	domain->iova_cookie = cookie;
 	return 0;
@@ -411,7 +407,6 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 
 	cookie->msi_iova = base;
 	INIT_LIST_HEAD(&cookie->msi_page_list);
-	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
 	domain->cookie_type = IOMMU_COOKIE_DMA_MSI;
 	domain->msi_cookie = cookie;
 	return 0;
@@ -427,11 +422,6 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
 	struct iommu_dma_msi_page *msi, *tmp;
 
-#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
-	if (domain->sw_msi != iommu_dma_sw_msi)
-		return;
-#endif
-
 	if (cookie->iovad.granule) {
 		iommu_dma_free_fq(cookie);
 		put_iova_domain(&cookie->iovad);
@@ -1825,8 +1815,8 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
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
index 8b9423340221..c1c0656f41ef 100644
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
@@ -3649,8 +3650,20 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 		return 0;
 
 	mutex_lock(&group->mutex);
-	if (group->domain && group->domain->sw_msi)
-		ret = group->domain->sw_msi(group->domain, desc, msi_addr);
+	if (group->domain) {
+		switch (group->domain->cookie_type) {
+		case IOMMU_COOKIE_DMA_MSI:
+		case IOMMU_COOKIE_DMA_IOVA:
+			ret = iommu_dma_sw_msi(group->domain, desc, msi_addr);
+			break;
+		case IOMMU_COOKIE_IOMMUFD:
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
index 227514030655..98aecf904902 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -156,7 +156,6 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 			goto out_abort;
 		}
 	}
-	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
 	/*
 	 * Set the coherency mode before we do iopt_table_add_domain() as some
@@ -252,7 +251,6 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 		goto out_abort;
 	}
 	hwpt->domain->owner = ops;
-	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
 		rc = -EINVAL;
@@ -309,7 +307,6 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 		goto out_abort;
 	}
 	hwpt->domain->owner = viommu->iommu_dev->ops;
-	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
 		rc = -EINVAL;
-- 
2.43.0

