Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564FB17F38D
	for <iommu@lists.linux.dev>; Wed, 17 Jul 2024 10:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210816; cv=fail; b=cuEf04Ctk462TGxVNZdAv6XulyB7bKmRYWX6DME0EXuxM6Z+DuES2+XdBynbhBzkksXYV7yDOiaA2OvwucEKesLAxHKpszOe0/wsvwal4m9PxOiYvg8S89ZE9QR9LS83PdIPG2tydbZ/Ifil4mj7nF0PreElsclc7KrTCWqQHO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210816; c=relaxed/simple;
	bh=jDNmRwOTHblC5WHvyK1XQ9RCaX4kSnUSOsckzwPD9c0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPWEFIbiCab1viRKZw+Jm04LVoAujigkbiCBQlWIvEL6rJMMX4m7iIzCemB/eA3TFHvTaM+dCTKprZvUGVDisxJNYwsn85YALECe2EHwREKz2x6DOtxzhb68z2X0mIZgU9BTB5taAIeIrwlgXoAtUy/WLrtJg3NWpxpNJgg47Y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s0/Eq+qo; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s0/Eq+qo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKLvfcyfjEnn+VPuG8QX6ybwAxW2uQ+fBeQRDlkQE8NJo/YnUMxwWByEO7CYmmPAgdV5ZXWzvsbO56Qxwc8xiLKZnRr/RD9BRfnEOIDI+pJsQKNExevuvRPAh1XKPSQm4WbfbXNuBnZaar3vFukcUXVY+ydFZ6/xQnjar8E8jJy6tRmhdM4PyUJdB3vlosukB8u/okd88gLhOiyXZccuqzZhF5R0z/61M0bAsGH5M6K58p2+4hQ/k7nnjXiG35Ukdoy1ZJJcmgtjJKrdxwtqmjcbsZ4kZnC+HfgIxDrH9oZT17WMD/Z2w2Sxsy0xHUupAF85Nc3XrmuSrZUf55Mzlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/JYYuNywcOlvbc7IRcLncHn6vGzXZYzbS9x8PuOD4Y=;
 b=UfZyc5uWsNHyjvJI7CkPBpZaHuoiNYAkVjPbxrDxZjxyfU/ij/ppxIs13WVWQ39JjuaYgzxavN752bK2NKWj9VlSGIAE68cDWU//qQbbdgS9U9UapCOj+a1cgiGmpn+hvoYCa0aB2Ndj3rVmhhIXXjfs5qbOOF/ReTQPTZ7JrSRzDMdLEcRwxuSMxbAXbEJwH6oUq5l42MtjCyaE4uZILc3IA7tTaFcrj6halypxuq+RcRZf0A0lUyFT0KS864iOobtBLh82De1uTYsnTWSyouwgCChutVKDpJqdzM7heAMpl9Bf1BYG3pj7LbrzdXM0cwAKU4RiyPLtBux/8uAJzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/JYYuNywcOlvbc7IRcLncHn6vGzXZYzbS9x8PuOD4Y=;
 b=s0/Eq+qoOnVD6Z83hjENNxUIa7rl1OVAlNDNDbEXD88kzRn0F1L6a37hsJxoXExgn10JNFkhU5LM3HI64vuXEIGLnIMdqAQ+1DEsZRg+leOpSGKrnRPOAlMhE0qDz8R7/GW/+JCm+CDApHbhVM8AWV/iv/4Jbuf411VY1u4q8eciXaI7PsdyitG5y9Wnu3zGWWICSItBqsosCxudkCYsJ9vrlRqMiJLq4d7PghmZxo0jbJwLQAsP0YJYrvHc3+z4pLTTwCxB303rr5tEPJfRFQYPFCSQo0JfYyKyb2Crl/h4h/uwFbRgcNJjb2YDDtKuM/Z9qt+ESA1alZW/wgAfZQ==
Received: from CH5P222CA0024.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::9)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.27; Wed, 17 Jul
 2024 10:06:49 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::22) by CH5P222CA0024.outlook.office365.com
 (2603:10b6:610:1ee::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Wed, 17 Jul 2024 10:06:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Wed, 17 Jul 2024 10:06:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 17 Jul
 2024 03:06:35 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 17 Jul
 2024 03:06:35 -0700
Received: from build-amhetre-20240716T042216611.internal (10.127.8.10) by
 mail.nvidia.com (10.129.68.9) with Microsoft SMTP Server id 15.2.1544.4 via
 Frontend Transport; Wed, 17 Jul 2024 03:06:35 -0700
From: Ashish Mhetre <amhetre@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC: <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>, Ashish Mhetre
	<amhetre@nvidia.com>
Subject: [PATCH 2/2] include: linux: Update gather only if it's not NULL
Date: Wed, 17 Jul 2024 10:06:19 +0000
Message-ID: <20240717100619.108250-2-amhetre@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240717100619.108250-1-amhetre@nvidia.com>
References: <20240717100619.108250-1-amhetre@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|PH7PR12MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 42bb99e1-c5c1-4af5-ebf9-08dca6482c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XeKCDvi1VR6E4atH86uFFmutFuTOUW13owC1m5J85N2P29IK9j/hZrM00VDi?=
 =?us-ascii?Q?886IiaCt/yyBj/1oNmvsxQY0Lsun/Z0VZNPpobjYRVlV64CXJ33BrtNidyz2?=
 =?us-ascii?Q?CNsGxehmDIlgA8YMODyEIBQjzgmrITNGFUzcVGoo9JikDhPOrse99drvtB6Z?=
 =?us-ascii?Q?Hzac4qRFtH6rHGTJFilCraeKg14Z9sIKX3HmBncllt1/KfaSAISzyg3BpSLV?=
 =?us-ascii?Q?9Jj1jvujUclpsfibI3Hk+wq9drNXGLqWO7ypG8kRoNtbVscQ5YnDG6tujV04?=
 =?us-ascii?Q?vEZ3N9lv08BlsQCYuzVLzdbSQGCLA3SsImt6RqiXoYyTiLNSZeXaUzkkiiAC?=
 =?us-ascii?Q?3eH8ns3geNmCs7OW3dPjz8y2by3Eo8lkiVIQI75HseSWMFDZfOOMey3FD0CH?=
 =?us-ascii?Q?uKLhsr/PKYGQcQ/bofDk/DlvgwXdJ5dIM7eRZieoU091pRagFDPu3d6F0KDc?=
 =?us-ascii?Q?Rk3DDhGlLi6cCZPAebn1fOo456W2FgojzeQAC9yUjg/jeXNJY5ZssTZGdKWA?=
 =?us-ascii?Q?9GxAQidK+VQrBPsiR6qORTf8Ic9QWhFUoBgDqFRTinuzjekJ9dfD/luhxibX?=
 =?us-ascii?Q?BQyR2qSshEAmvW38DlIiCnYcL7ReU9mzFu3xHa9GU8tJZ1f0Z/dS8rds7xWh?=
 =?us-ascii?Q?fZGXz1+mTBTG+HJ6hZvRkA9EmccXYycHEuw1DDkbLV1MZAFKu3JJpxKzCyYX?=
 =?us-ascii?Q?PngZmK66eF+JEypO/kJKVFoboIa0Gn5gXH+Ywc47n4rjk91sTQdkwX9y+p8P?=
 =?us-ascii?Q?IZvI+QRiFn7XAVUuv3ZpZ0/wvTmW7QScGd7q1WX8RoY0PVGziW/JLpBYvcfD?=
 =?us-ascii?Q?nzpG8MgXqkgnQiJGQhrjfnu7Cj31byuxgvB4ESjd3cadGAGvB5BCTAiSmW30?=
 =?us-ascii?Q?inSm8Xq/LhrWYfz+BkV4DxPl3l3gHhZ1u8iDFWLknOySSfXrWxrb83r9uFAi?=
 =?us-ascii?Q?C7w5YSdCgKnf1DC9Mg4DKVRF/KTTomBKawlUaFiUazEhwrZMOT7Z33G25RBU?=
 =?us-ascii?Q?RQyYacWD45Q91nUgyP4HtOiL2h5+BrLP29xPjNmk4Zasq9vwz5QBzfo92kdZ?=
 =?us-ascii?Q?oc40pcGo+ZPsLB1vwmy+4G7j3SIE3sLLgnberT4NPIFbqbKh00dNoixVXT3I?=
 =?us-ascii?Q?+wOuHSUzvez9mrNXlOsaweMJ+ZwFZOkZY+t935V2HFYu5ONa9yQsrqgi3qBW?=
 =?us-ascii?Q?uo1sKWzukhdU/9pFWGiCy+JnHHCol0c0BiaYQCK0oIcnkUKxQPGY2MnXwPAs?=
 =?us-ascii?Q?k8ygsD8CkONU9wE3x7Eoo9n2zKkrsGFoBeC+kf4VFVafLbdblbNBGB7MAOqC?=
 =?us-ascii?Q?VZ3EG7FB5ZhQ7I8Qmw5tDO/Ahdoo5o/EMOTs32wM/yB2TIYDCHRnAHd1IkFP?=
 =?us-ascii?Q?7eRfRtJn1sw5rSFOVjLTWs68aDx1Qpl+gevAv0Dx1i+XEAtbVHmlrwM+/WWn?=
 =?us-ascii?Q?aoz8ZoZnPmfCku7/9OsUknCgTaeeWu9n?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 10:06:49.4230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42bb99e1-c5c1-4af5-ebf9-08dca6482c9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417

Gather can be NULL when unmap is called for freeing old table while
mapping. If it's NULL then there is no need to add page for syncing
the TLB.

Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
---
 include/linux/iommu.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 4d47f2c33311..2a28c1ef8517 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -928,6 +928,9 @@ static inline void iommu_iotlb_gather_add_page(struct iommu_domain *domain,
 					       struct iommu_iotlb_gather *gather,
 					       unsigned long iova, size_t size)
 {
+	if (!gather)
+		return;
+
 	/*
 	 * If the new page is disjoint from the current range or is mapped at
 	 * a different granularity, then sync the TLB so that the gather
-- 
2.25.1

