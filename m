Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979CF19E98C
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 10:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680325; cv=fail; b=FD1cXm6GwGY31KheWBlvqsDXCYZufnOylGpkrxPRpllS+bMJDMQasALnrHsx49Rc6InW8QyT6BY/GUOhD/vXQGTJoG591n0KJkIwO7guhO+D66SWBm6+IX+AVutmvXOj4HSwNLjkqJnpSX2G464XCBMH4Oh8dzYfPO9ccRGxnCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680325; c=relaxed/simple;
	bh=jpXFus5E1vR/yMZj0JA7HfAEzWUuCLyJkIE5jy14f1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ax5IFKQG+ws1G+6yE0vbzF2atX24BiYAXFF3w3K9Jz3AR1Ji8ih1dAu0Xz1rgS8XG3KkStHWvBTx57b3qNTi3nzzMGnowDYHMyTT3T3mHC7TluiZMy0SoxYKDRhw+cmibZYGWwDqQnHOZ81C6/ojgRzHK6vlHeH0JhSsVaadOdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HIfCt8Qy; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HIfCt8Qy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fG2rZO/1YMT8K00Mo4UzxEOiu/QFXn/nf7YZtP8GApwluNyky8lkjMfJGLgU5aKiudS5OGr8z/YnRfauMznFhgpa33utEhyK9CmAa8fshh5scpKrUTd1/M1QGgH/TKp3asIJ8CLisBqonuyvu26qU1Eh65nEYyMvhPKlN6Yu945/Rm47vWqbYP9NmO9ErAhzufWKPlFfTx5VA17675H66l/vIfVhRM/Cw+WPbx9DkDkMUGqBEHET0C2b97uXprszyljf00kdzj3GfamQIQJmtLu7wW/FNZYj2Y6K9CBZi3LX/ycfBtMhCcP+1YjExxzsyY3roehur/LAFzmvQ/NmEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GnCjcf7RekqAOJHf1+Fea5+aJgqwRSZH8s2SymL+hc=;
 b=AHvOpJGg9SBbcvqMMVc1MLCiL/7j4n4R781aLjMN8V0WKfavOcNtHQICbawLl82qHCvX/lF/q3DyE6udg3NYMYAV8NVttjVBRQfNoF1d4TWkCOkiUtTLR/wDBCvCKiX5breBJN/R61Y7jL04I636moHIb4IL7mXIbBuoe89HeGgowwldk8Ka/uGVHSU76UV+29g6dfRaD2pASCAbt4lmoseSQI5uFoVJx/4H3IAYEqcPKFlSbQN/NGeKkuB1cXSTbt58Vba4vpJoTmdOcou9QQ3cL+I5RN4pvYkQ2egxaulWmdnsQq20kmRIXvJ6eiVCZrswUUfeo5k758mADoyMtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GnCjcf7RekqAOJHf1+Fea5+aJgqwRSZH8s2SymL+hc=;
 b=HIfCt8QyQZaR87BVcvmVABUsBQHW9lltQjLUvAXbtUBQ1m9OOrgCvxCcYpqAdbfU5gF4xFph5VJXNOJCB6DG0+TOf+ZJiIkI9Nk0ilNTwm0rgCe8ubJ2J7SLDUsUiCuLQ10j4RvUcWLAgNVMs7idWvLtfEmzIN3dEQ9XkcUh630=
Received: from BN9PR03CA0959.namprd03.prod.outlook.com (2603:10b6:408:108::34)
 by CY8PR12MB7362.namprd12.prod.outlook.com (2603:10b6:930:52::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 10:45:20 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::1) by BN9PR03CA0959.outlook.office365.com
 (2603:10b6:408:108::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 10:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 10:45:19 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 05:45:15 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v4 10/12] iommu/amd: Implement global identity domain
Date: Wed, 23 Oct 2024 10:42:05 +0000
Message-ID: <20241023104207.5894-11-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|CY8PR12MB7362:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b299a4-5a86-42cd-cd39-08dcf34fca0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nH79dpePauqsuP5cyJb3efcn/LtfvK49cGCJ6375UuzRe4Efr8V5tr/EqSIw?=
 =?us-ascii?Q?iYtf9YqLAPk8PdVVo6iy0Px6AP2dD7657KmXEY+ML2V8MAf9XujXvGrMIf47?=
 =?us-ascii?Q?QuPthK+zMgZqYliwUWjD2dSZymmNn4pufm4F+psW2wPnbT73I3vVHqXyBkB5?=
 =?us-ascii?Q?0ks7ftsk+1R+HRkvI8a42w+seM0AUBA+2GuZHpSjWvTHny9uxYOGixxWuGQD?=
 =?us-ascii?Q?0Eswg8On/f5B4s98T5CDrAPSoksg5deFCnTwF76AzhNDxyy9ZZmA/WkgE2KJ?=
 =?us-ascii?Q?bZBM4UhBPkZxzXKQuiEp6yz+Mftk7MRU+/4uh6L5eBeMmCifaYVv4T89sNFH?=
 =?us-ascii?Q?5Na6rIWHxICFBwHY362nuM6Ip7R2en7LvPdRlAw6Fct2A4sqy1aE4z7DQ5K7?=
 =?us-ascii?Q?Mjb/DuKufHwL619lIOjaA6/fN088CUfNbtapoGGeHVgZgyoJUhHDPASBYrte?=
 =?us-ascii?Q?Gk6Svkhfv9xYzwHYP37rhENHK5CJeicdSlnyHgODFvG6BuNkPqvn5S1u/qQb?=
 =?us-ascii?Q?jY4L/0653zmPpUr0htRNFHk1nAilKqrJ4jME8uj+sJ5pw6HwxM5H/WOSfy1u?=
 =?us-ascii?Q?j5DDkZtYKTE5A/pJXAsxjzvPFTzAMisCEiAAEEraQ3cXCjTdaUzlCGzFRVOs?=
 =?us-ascii?Q?s0FgG+bx2WoWrFWwtJsui/ly4CBPHOT3BhRmrMRId7OaAjyj9tIjYzGG2uma?=
 =?us-ascii?Q?8uFFLbDlvJQvw9ilep/FTmud5lT8b7vXtx2L42Jfj3XbCOyJKWJftW/s9S83?=
 =?us-ascii?Q?e2/iP+lb8wwItfw8Ks0skGupVg24mxpi9Ny0Bf+tYYNrM/2XPrYAEXQrsRll?=
 =?us-ascii?Q?IoqIpR4dHRTihmThJWcIOecoUuoop7to63xmZHjfzOj53HmmIVepZZHnhPsH?=
 =?us-ascii?Q?bw737spJa0BjLLTeoxs++ZQnmMNoDKZVbpExMV0ciTiJCCWcd/FTqfXjCJsl?=
 =?us-ascii?Q?WoBMIaZYsIwLjEBrxrnDgJKkLwV7lKmE7ZRXsb6SYU7FXl3zPv0Yzb6aQu4V?=
 =?us-ascii?Q?aCvtYd55f2ldu48xGLvs/MdsQv6AEjCD13BkR4RNCMlICfxPtssHcbuFjeGp?=
 =?us-ascii?Q?SPlA+toVxKNndqO/SHsgxE02l2/FqU2AxsW2JezHy6R8M64K/RJAjllQKMJx?=
 =?us-ascii?Q?N0OyTqnjpKt1Bae+YqmdqTZNvqlVPWN4jPcXA1tP2LP3n5NQTOMVEi3cnQjD?=
 =?us-ascii?Q?t32xOhB76YI04Q3YNECfENZh0HVWgSyP4VzZq9p3U2wfJOr3i1bA0RnyKyYl?=
 =?us-ascii?Q?ZZx9q6qidu4f5n2JkzOYCQ6SMq2Nu6g+KflVLoks5jIb5yKeqtVD15B0atvx?=
 =?us-ascii?Q?v3HmMWiXWle6ftEPDtUT0YdYbKU8s4Idy7hFNbdWkZJQrOQ5PP2iFyxBqcbT?=
 =?us-ascii?Q?aw1gXg0mA0d7hoZ32ub+kH+veu/zNxIVNmTgczl7ZV1gk1kr1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:45:19.7141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b299a4-5a86-42cd-cd39-08dcf34fca0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7362

Implement global identity domain. All device groups in identity domain
will share this domain.

In attach device path, based on device capability it will allocate per
device domain ID and GCR3 table. So that it can support SVA.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/init.c      |  3 +++
 drivers/iommu/amd/iommu.c     | 36 +++++++++++++++++++++++++++++++----
 3 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 3b6c6332b09f..38509e1019e9 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -46,6 +46,7 @@ extern int amd_iommu_gpt_level;
 extern unsigned long amd_iommu_pgsize_bitmap;
 
 /* Protection domain ops */
+void amd_iommu_init_identity_domain(void);
 struct protection_domain *protection_domain_alloc(unsigned int type, int nid);
 void protection_domain_free(struct protection_domain *domain);
 struct iommu_domain *amd_iommu_domain_alloc_sva(struct device *dev,
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 7c883be22559..45fdba48d54d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2164,6 +2164,9 @@ static int __init amd_iommu_init_pci(void)
 	struct amd_iommu_pci_seg *pci_seg;
 	int ret;
 
+	/* Init global identity domain before registering IOMMU */
+	amd_iommu_init_identity_domain();
+
 	for_each_iommu(iommu) {
 		ret = iommu_init_pci(iommu);
 		if (ret) {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cdc93c794eff..73c7ffa2ee02 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -74,6 +74,9 @@ struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
 
+static int amd_iommu_attach_device(struct iommu_domain *dom,
+				   struct device *dev);
+
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data);
 
@@ -2263,6 +2266,14 @@ void protection_domain_free(struct protection_domain *domain)
 	kfree(domain);
 }
 
+static void protection_domain_init(struct protection_domain *domain, int nid)
+{
+	spin_lock_init(&domain->lock);
+	INIT_LIST_HEAD(&domain->dev_list);
+	INIT_LIST_HEAD(&domain->dev_data_list);
+	domain->iop.pgtbl.cfg.amd.nid = nid;
+}
+
 struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 {
 	struct protection_domain *domain;
@@ -2277,10 +2288,7 @@ struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 		return NULL;
 	}
 
-	spin_lock_init(&domain->lock);
-	INIT_LIST_HEAD(&domain->dev_list);
-	INIT_LIST_HEAD(&domain->dev_data_list);
-	domain->iop.pgtbl.cfg.amd.nid = nid;
+	protection_domain_init(domain, nid);
 
 	return domain;
 }
@@ -2465,6 +2473,25 @@ static struct iommu_domain blocked_domain = {
 	}
 };
 
+static struct protection_domain identity_domain;
+
+static const struct iommu_domain_ops identity_domain_ops = {
+	.attach_dev = amd_iommu_attach_device,
+};
+
+void amd_iommu_init_identity_domain(void)
+{
+	struct iommu_domain *domain = &identity_domain.domain;
+
+	domain->type = IOMMU_DOMAIN_IDENTITY;
+	domain->ops = &identity_domain_ops;
+	domain->owner = &amd_iommu_ops;
+
+	identity_domain.id = domain_id_alloc();
+
+	protection_domain_init(&identity_domain, NUMA_NO_NODE);
+}
+
 static int amd_iommu_attach_device(struct iommu_domain *dom,
 				   struct device *dev)
 {
@@ -2863,6 +2890,7 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.blocked_domain = &blocked_domain,
+	.identity_domain = &identity_domain.domain,
 	.domain_alloc = amd_iommu_domain_alloc,
 	.domain_alloc_user = amd_iommu_domain_alloc_user,
 	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
-- 
2.31.1

