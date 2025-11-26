Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349DA2FA0DB
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 01:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764119469; cv=fail; b=WQeDGDJf6fKJ6qZ1merQkeOuH8PYo1jGPA9an9gYPmRnmp0sYX1TJu70HddZ4iUIXqdDuXyijlQu2PSkBabx+gPE+GcWwhsrkB8yt6+LUsFkZs2VK3v+Ts4HuSKghe5g34/f6E47NSWhWyQK447MjepsbM6HYH2EBWWYea+R/5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764119469; c=relaxed/simple;
	bh=vVGB0lPKN/pv18vEZZZt4tefmNsDV8+XzzlYCxL8LyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YleGDVpJF4MmPsiwGhVqGgdtmBz8OOP3YCqrNKEuaJ5yjnBOPTNH9aASkgd8GngZR4/xUY9wxPori72yAeRpHCUv5Hc/lcgANeTHS2mne8GYW67PX4fHIL2YpGQQSRB9SRxuYjpJrtrFeMUC1JBv6gkiXnqIkGLu41JcXV/CrV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IvfwI6LK; arc=fail smtp.client-ip=52.101.62.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IvfwI6LK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYF8Tds2C0DqQHI95D1apjWb1Qcc2hY5p+kNCyiuTdbE2hBCR8mVW1BRyMpIeTHfGVw4fpBii30Di3xvUtAmopf/zViJRxKEIyPuCmMxhMAaLUy4T95WuJkXJSv+3n2u9mn+o05y307F5iV7fjFUWgNlsor0DrPNL6s2oY73zxEzesFzrZhnTqW7s5LXuSwyCTh0R7tcToYjd3Um9NPy23R0cU/Jr3OxhArtbtXz4yscWW+HgBLI1RxfnFJ8B5ouhBxNuLq5V+FFjCw2Np4rx/pnyuWPvLn7MyOmEWOEaHD04nDXrIvKdgq9Aa2Kg2p54l5surscbAVhAmNrRDzB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FUS3J7ddqTG9iTzGTOqOIvTTqkZWKjY7Lu16MSGs34=;
 b=URkhc+Z3NjWRJfumPmiTC1FDaoS064gu2NP/7VD7jx5R4JpOrpUgEQ4sGWmZDzYHsrCpOwo8M1TxVPoZt2WQqfCFUXk2XkKQrSAHp99KMXlgWRY+hhdUTojPYvOCbAmLyp7diHFY2EZc2wEVtDD5qU3CXj2AcDrX08/56m4m+Yv9xbICnKcAaLqF7s8jShoDdcLtxPJPmjry4RULaRLyjcSOWjchHvYagNF/lZBngxas9CZK2rznS17oi8g3LPeF3jZ01N1gi9FTRKxuQbyCtoDTcwD5PT2xUORMgDDYxGzv+37e3CK8mHQNjRztjSpoigkxf/lWU04C89Q1OrCupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FUS3J7ddqTG9iTzGTOqOIvTTqkZWKjY7Lu16MSGs34=;
 b=IvfwI6LKNmHMpY7GgbZg5vYcjydax6JRXTZ25Fy2/6IWco8oEYwbsoR33oJTNnYBwaBqSacywvhHDKQgUDpqqsYRut5m6mMWeXlYPaDnuV5c6h76FZWUwuuxzz0pRbpK/fhbsSye3E4cFVoCILyG1jFvhXhzIUoeAp5wHxpLsZh3oivr3lNL0+9d88q9B0yWppIGZErCiYDmuZTV08aiArZuHF/+xKFFpBUlcpKE1ftGUYKJ3I6b1lj40k/bpqJs3IQV6eK+3QnquYtytF79z66Aii5ooLuVRRdAhE+MoYy+suZAGBCm2YUCbfh0jPnR5+RuMDNMk+gCr3gkhAQx1A==
Received: from DS7PR03CA0360.namprd03.prod.outlook.com (2603:10b6:8:55::33) by
 SJ5PPFF6E64BC2C.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9aa) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 01:10:58 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::5d) by DS7PR03CA0360.outlook.office365.com
 (2603:10b6:8:55::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Wed,
 26 Nov 2025 01:10:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 01:10:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 17:10:39 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 17:10:39 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 25 Nov 2025 17:10:38 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/7] iommu/arm-smmu-v3: Add an inline arm_smmu_domain_free()
Date: Tue, 25 Nov 2025 17:10:07 -0800
Message-ID: <271ea7ce11292aa8e51fbdf06f69e9a527e0bb3b.1764119291.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1764119291.git.nicolinc@nvidia.com>
References: <cover.1764119291.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|SJ5PPFF6E64BC2C:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8f93ba-40d2-4efd-0014-08de2c88a7cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mlksDGBVWyxGjdk72DE/SXQG1bfyimmOa4GwHPX2a7aoTg3zO8l+Nc4tQjJH?=
 =?us-ascii?Q?dz75QXFTExwXttm1nhU5nI96UG6xhm0cPicxTqAsyeoVTREo+h52ztR1m4X/?=
 =?us-ascii?Q?sTLNYMsy9gMfAwVr1M/k2g3bCMyV+mkslvYSYLj0K4ekxLgLBfz0VSp/3PAo?=
 =?us-ascii?Q?lxZcnDoTMfsAcPIzdfdRsHyrD3+/48+es9UIWZA83mR9ulz+opvrL7WTKgxx?=
 =?us-ascii?Q?qhbV0aO2CwPtU3wsEgL82w0FIyxthIm0NkUs4XGvinO3DWVCbmW0LCX7p1QN?=
 =?us-ascii?Q?BE7ZztQbZv0SaMu0AR2jKKU/rUdPFa3oNxERuvv/HtyqPOAhLnBwpa/PGez/?=
 =?us-ascii?Q?0UiJWkY+xRWxxYfu6dJxZvHWz8PPA3PQmOGwPgsb2dNaiIpQm1gsynwvUk2F?=
 =?us-ascii?Q?FrY7XO2jrGZOF+z0TAztgx3kzS+TXKnaTnHnxgsLaBisDoZ2aaeRgtkkMZlx?=
 =?us-ascii?Q?R+DXNbNqUXe6u66Mip2TPnQj8PrbBUVh2v47/uOMiYrVyI/zciqF4ZbqAec2?=
 =?us-ascii?Q?dqYbqQdjrNXx0nvOvNN/gJE+AT83oXeD0rKZa+ylPd2CrR5h9BVpunroKggn?=
 =?us-ascii?Q?GA6wYsdncuk6OJj/RXxx0mrgHQziO019L6dOYcLhdo5qyAWKtwyK1X0Ri8px?=
 =?us-ascii?Q?iuxaeTck8lhUVGS4y086AwM1XU025JRR3snaQjHgp+jGxDlDDIuS+G01Igof?=
 =?us-ascii?Q?jKo6SQZPq5QY/aDUBvPYetW+Xbg8pI1PTb/DkUbbgZC4mh3uU/KXyeVUajmO?=
 =?us-ascii?Q?4Lhlv3EtYyZFlZrwXkGDAEmXFXvq1JaU98vRhB4+Lt6KRrxxW1Jvs9oy6aEi?=
 =?us-ascii?Q?0L3Ev00G7Y7IxuXbHOHzOVRVpxfSDPrALe0+9bD5ty0cZJIURVxXxoAH5f3/?=
 =?us-ascii?Q?UJiQtBwHDuK8xo+bV6VPNBahVTOCAcxwgVkGM5s+zoHh3j3ITNm0orN7s0UH?=
 =?us-ascii?Q?Oa4WD4pynLpfwFNjzUPWGqXFfIaYHqFs1E3CVaI1c350gwKVt3Pb3URbY19e?=
 =?us-ascii?Q?1LWYMhtoCBk2d0qTWlMbSsa3gQi4BubHb/8dYhnMkzCiiNNy3T89JBod4OrY?=
 =?us-ascii?Q?ujl+i5GgACmkL9Yox/b2Uqox9bG1IvD16GBd+hVWSljA/saMwyCnHDivw3Dp?=
 =?us-ascii?Q?pY0a2Fe3MqO24JTM5A/x/BUao1stAdJ824I9CHf+tqYvC6LiKShXCch+aDRr?=
 =?us-ascii?Q?A83hG1QMYYSt7wwKFEy6zjS32T4mrYNU09fb6XZ4p47pErqrYEEOTf+yWyTB?=
 =?us-ascii?Q?0n31xb3nhlDgGKhByolvPSzmZrhVqvbazMoX1V4bj1N/VR4eL2J8t2hrxuOt?=
 =?us-ascii?Q?OqaqA4k8op7NJX+PvrurKLkjeiKYwWc7OGBDaI6CaUdV6gJoKAts6rgKNrDR?=
 =?us-ascii?Q?2qfdN+m0Ss8soGfEI0gsKPvsXaW02C0ez/orDrnLNH52zu97kF1WzO0E1I39?=
 =?us-ascii?Q?EeO20FUotkxJ8XlTfEh1VWndnyoVkghF19NnYZXf/8d0VE42Y/1UwYeozoH9?=
 =?us-ascii?Q?3TtzK14PHU+u9DGEyKZPEzhu/y/btmuLlTPg+hbkJIufMljRxngoC6jH749v?=
 =?us-ascii?Q?i6lLRI0LE3JVA3y3TV0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 01:10:57.4108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8f93ba-40d2-4efd-0014-08de2c88a7cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFF6E64BC2C

There will be a bit more things to free than smmu_domain itself. So keep a
simple inline function in the header to share aross files.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     | 5 +++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 5 +++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c     | 4 ++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 5c0b38595d20..96a23ca633cb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -954,6 +954,11 @@ extern struct mutex arm_smmu_asid_lock;
 
 struct arm_smmu_domain *arm_smmu_domain_alloc(void);
 
+static inline void arm_smmu_domain_free(struct arm_smmu_domain *smmu_domain)
+{
+	kfree(smmu_domain);
+}
+
 void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid);
 struct arm_smmu_cd *arm_smmu_get_cd_ptr(struct arm_smmu_master *master,
 					u32 ssid);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 6097f1f540d8..440ad8cc07de 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -197,7 +197,8 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 
 static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
 {
-	kfree(container_of(mn, struct arm_smmu_domain, mmu_notifier));
+	arm_smmu_domain_free(
+		container_of(mn, struct arm_smmu_domain, mmu_notifier));
 }
 
 static const struct mmu_notifier_ops arm_smmu_mmu_notifier_ops = {
@@ -365,6 +366,6 @@ struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
 err_asid:
 	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
 err_free:
-	kfree(smmu_domain);
+	arm_smmu_domain_free(smmu_domain);
 	return ERR_PTR(ret);
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9d9f24a08062..e9759e8af0c0 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2492,7 +2492,7 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
 			ida_free(&smmu->vmid_map, cfg->vmid);
 	}
 
-	kfree(smmu_domain);
+	arm_smmu_domain_free(smmu_domain);
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_device *smmu,
@@ -3359,7 +3359,7 @@ arm_smmu_domain_alloc_paging_flags(struct device *dev, u32 flags,
 	return &smmu_domain->domain;
 
 err_free:
-	kfree(smmu_domain);
+	arm_smmu_domain_free(smmu_domain);
 	return ERR_PTR(ret);
 }
 
-- 
2.43.0

