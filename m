Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010007.outbound.protection.outlook.com [52.101.193.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC9D33B6E9
	for <iommu@lists.linux.dev>; Fri, 19 Dec 2025 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766175157; cv=fail; b=V6Spmuf/weZU7pKExuIIerL0TY4XvMTdcrSHnajSll/C7XRdOQzBaVV1k+nYvdl/lAt8KX8vIJI0Eq18mFLzRDOyS+RvA+Vt88OjhEvPQHlrKcyi9Ex1haRwUOilo2YRI/4H+pPdFgVJqT1Yv6sMWCfk/ZZO40zu9B5gltnsrI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766175157; c=relaxed/simple;
	bh=vVGB0lPKN/pv18vEZZZt4tefmNsDV8+XzzlYCxL8LyQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q9rqPg+nmfEMHIpYHv3I/6uk/YZKGS8ZG17EQ1zT/DF8TROMn+Z7Hw61xUihqjDk+hn9hOlUTHMtv2EA56PG2kOOe4IFk1s11qLrAuha6N2Um932z7G2zrH5G9tvFaIQoWfcUlpNSSaVZjNt4v56iyEaAswhfygJ+rTr4ldC8Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IIPCFJZE; arc=fail smtp.client-ip=52.101.193.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IIPCFJZE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0tHMMK5DLbnvf/oVpGek8uNWXsgWeGZ0C/Kvpj8I0gvrrXmL24GRxb0ML60hFeMcP9epozuXLScNI31+Au4sEgmrbV3cnAOpx6ICosWfpzgm7ttcwcTo/EVHHiHMH7ZPpdowpH4dHvSwd2VSS4eDRZSmbuYMnKD5XL3OLpuWZWEi8PqjkG1vaUF9+h+R3rMeE9JaSpGzv5x9kjZGamGHT7uoRRxAglu4ccOXueZRUKu/RgVsFUT4C3T/c/S4vDMeR3frLR6Qhe2iSGCZ4d8n9fggq2v0uEyvb+GzIIBRYq1rMIOZRqbbUG5KVZcwCKtGSokpEGnQZIjREG9oSS3iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FUS3J7ddqTG9iTzGTOqOIvTTqkZWKjY7Lu16MSGs34=;
 b=GbExU+QXxQPkh0Rx7G34sOTRmTiYTkICpFkfvnYz7EPmIxJSoWeQw9z8nk0RUxFzFYlDTiWKQe+fY34FMRYFOrmHRFBFDJ9rGWyuQo2EkT4Ng8mVkKJriEjVzkl3X/oVQauuP+XwnRKY+RkKTsizzU5UVUFbqkkQKWvrsee3lRZgNG2P7KdZx41x65Cxawd/SxU5vRYGUrDKM70fJ4JNQ9MYScadCYgiwToK/cCD40F/M9rCM83WBzmEZqjZyTRZUZJ1g4OY9kpCFip+ZURc7EzYXuTTk1omf989uGTSn8oco1cJ+aPgV9HFDpe1FRw1JQpUwwowWPM4hlCxhuN4KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FUS3J7ddqTG9iTzGTOqOIvTTqkZWKjY7Lu16MSGs34=;
 b=IIPCFJZEvCtl6z7VnOuPr7Nke9h+0UBiiQAo9BfM5wsNBON4UmAeZ97BZNCHS4XFva3jNn5+L01KJcApDfE9B89emUvHvUR5673c0eZ86ToxR5WQDVmeJbDtTcDTk5DIRNUa/86j9uJd58yIWc4lw7D6kHU8LoWdXXpmeRy2jjtC6pypi5vXzuoeNjjZJ24fUU+gQPjPc18W0Bq6J4h30oK0oeNkxTE/qQ2y4fdlknTvNpUfNU9a1dPf+Zz+0PHmgX85/Hl5mFT3IDgRI+gsm0b2zYFK5iMa7fo4Ye8O51NJZehknF5SlsixqtPGVY6fmiShmtn0gnypDZzjB1METw==
Received: from BYAPR02CA0025.namprd02.prod.outlook.com (2603:10b6:a02:ee::38)
 by DS0PR12MB8042.namprd12.prod.outlook.com (2603:10b6:8:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 20:12:28 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a02:ee:cafe::eb) by BYAPR02CA0025.outlook.office365.com
 (2603:10b6:a02:ee::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.9 via Frontend Transport; Fri,
 19 Dec 2025 20:12:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Fri, 19 Dec 2025 20:12:28 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 19 Dec
 2025 12:12:10 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 19 Dec
 2025 12:12:10 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Fri, 19 Dec 2025 12:12:09 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <jean-philippe@linaro.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <balbirs@nvidia.com>, <miko.lenczewski@arm.com>,
	<peterz@infradead.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v9 2/7] iommu/arm-smmu-v3: Add an inline arm_smmu_domain_free()
Date: Fri, 19 Dec 2025 12:11:24 -0800
Message-ID: <b516338bdde0bc6f06e2719b9292ffa260085a67.1766174731.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1766174731.git.nicolinc@nvidia.com>
References: <cover.1766174731.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|DS0PR12MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: e7cbc710-ca98-4d64-ba87-08de3f3aeeda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xEz3hMvholcxOX7YwUUTQbGLesGfJzNZXgRi2vhiqk7fVDI2GqOsygjTSIfx?=
 =?us-ascii?Q?juxhzW3iqjaiHfNSGEYgkZu2Na/2l5IwkEuYXmUEsPZTE+L0nUlk9tRvquYG?=
 =?us-ascii?Q?1/cPcNyx0MnpK/XRdmag67VYbNyV78yQ89QpkJnJj+l06be+ZHvQewYQMWHi?=
 =?us-ascii?Q?UYFgcHtowmy21nwxTNasqRj7YVxgzGz22nPSwxtoEc/Q0kP1PQASnDmQX+yW?=
 =?us-ascii?Q?arsN5fkLUTuSAAzDXo3VjaMaARVkVgwlQrUoPZP0l4duSYl5BnCKhV2yod39?=
 =?us-ascii?Q?DQvZuJjJjWfAsEq5v5J3IubA0w+93U08QwGTfdJ+I2As7vRb+pElfW+GvJXp?=
 =?us-ascii?Q?/muqu2PxMUbkVuVBISiMv+2b5vFeBAAyYxT/njVBXxDOajAaeOVLz095bzKL?=
 =?us-ascii?Q?Kulx3R17ABBMxXD43hpi0LnpXyMalJTm3P/Y82uIoUOtXbOEqJEqSmWmPsuk?=
 =?us-ascii?Q?QC/YBInPHyC2sG1gc73PDHk7wKw5IQq7yS2PY/MeOMl938QX0Zk1TcuGMmFl?=
 =?us-ascii?Q?+G9xntq+koen+1bx19lB2X4dyxKnLuIQ4LclMOTxGSehjXwqS/QhcIDEuBx4?=
 =?us-ascii?Q?bBtplkszyWZxvMczrFzTFzmXR7VQQ+6tri7zM8U5FqSwtuGYGUxmrVHFXcrI?=
 =?us-ascii?Q?Khf3bNSSp3+GD6xuWwe1mI52u0oiv7iX6486ckdOyDVeUQUbLBL2H+7oVprc?=
 =?us-ascii?Q?oK6GRK+B8e+UP4KhFb/s+iIwJAsqHA0vUxVOMRl6v8Ml0OI6Wr0bu/tKUpnT?=
 =?us-ascii?Q?bzU/Jr+bDeJL1ZC2bliQOHMAMxlSmaL2oiU8wYJ21wr3gOeIap8XFsizX+xi?=
 =?us-ascii?Q?7OPOC4IK4jdUULJ7DKlMChNX2RW+1Dq8PH+GOfBdlxdbCcgUxxUzmyI7k0B5?=
 =?us-ascii?Q?c8DEFQR+WeIs4OsVufu2J9OP3X0q3u5xEyQIKhVKWfjT8qu88h9DM5uSFJ3z?=
 =?us-ascii?Q?HQH3/N32sLb/kHA/NMjdGIKfr4IqrPxDXnXHgVg8bsYq1XlNxW1z84gzOiWo?=
 =?us-ascii?Q?cwflZfM7q5G2LbvRbcYAl0GIfxOLIgvzV/JjEBBUB2lPVCzkBj8nXslbBqqu?=
 =?us-ascii?Q?bwTSeBr/mu5ZOyzJzjeSxV2Iso1l6CFf+mfzHSzwhuiBsKHst+eQMAdZjIvh?=
 =?us-ascii?Q?U/AlkgvifIc6rPs42YR2s3Omv01HAZjzFeh52EKebFsMBhVVCACw7FI8jBd7?=
 =?us-ascii?Q?1MtPznUE26HBzR7D4XIQe6+kHqmwJ2/IYm3C1EvqhliFL34pMUyV7I6gZcK3?=
 =?us-ascii?Q?P8DxPloQPpqxJX5AUDZP1ZxmIKibbHSxTGPaITMB6zkzEEM2AwY0PR4tAHhK?=
 =?us-ascii?Q?vlY9l0akZZ70n/MTWIsctsbDLk8YvjgJSgleroYPjn0swxdLXBt7Ue0TCo3F?=
 =?us-ascii?Q?lTqegI3cyRe4EPtikWUv/3a7JUS9nu1G4ec0fKWalkMFKi4spHFf68FsvRPO?=
 =?us-ascii?Q?zxmB305Td4PX0uTD0vZlYind9o2uTfN9UiqnAccZKxjoj9QVDQE34YYgTkUl?=
 =?us-ascii?Q?jyUBuBaRSEgvJFjXQ4mN1wnUyWX62Exy4PIaMO0tTLV32ffxQtS1x2JUqmzb?=
 =?us-ascii?Q?C+1a0EJzYxy1eHhOFUU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 20:12:28.0852
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cbc710-ca98-4d64-ba87-08de3f3aeeda
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8042

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

