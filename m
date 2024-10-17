Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBE11DDA39
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 14:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173896; cv=fail; b=tOMyMOK21SxzHDY/j9tKdh1Oza8oPYLb2ZP54yr7/w/nqFSmdVhEfVJYldJJjgbqOZH8eqMHJLWRRaMEQbaazBv2xo5ruyk37d+9SVjSR9vBlESevRdd7T1nlQFbF4fA02xwCv2btZkNjxhwGH/WB67CE2DxDTdPpQuhBmlgnS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173896; c=relaxed/simple;
	bh=XeJLPF7sVyVChjat1g8AwbctRCOj+5SxqmcNB+qP+Vo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJ0iyhdLLcChkMtzo6hCmNvc6EzCEpX4BcBaGozTaAiP3p0xTJH3zHRQTBmI2LorHp4+Pi5h4eAOQDrvCEFBwZcTpOMby6XitMgznrMw2BWOzWnD+ywRXGG+jQgj8bJCKWmZli3IGp+uKaueFWM0x19+MyTitztXHdTY50PqDyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aswsutm4; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aswsutm4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+kTmA4mfUHvHBSZ7MNpqYHdXqp359mqRVp5MYkKLFF/jbkwH3aFUEy4QcmTqLgSfYd8x9iVOwvrchCO1mhsg98fpjrF0uR/hgIfFk9BVw4taUSmElmq/kf4koi23JXLQsFHq3FDrD8bl+MSRF6iYzRVKd4tw7SLRvC+7yku7IVPk5HVyNW4fOouzyPa+agfyoywUTHl2PD2/o7CrORnB4adFuZ48Qk3IEujrlfNtibkyLIrACnHKJ8I05TwWa7cU5GjYhUIhp+jgx7U6RN4O3Zvy5YU99qdgGSdENkpj92l1kIPIpKJb8Yq6NUr5CSs0DtmHr/Y/p+XZzXfgqAu+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwwjGXhJl65aYdlXnrQ+C6+jMGsFhoZKdq7ZSAugC1g=;
 b=v1uD4uHJ72O1axa9sKYvtyPRM1XLsucvH6zV8bwxrFb2zuR1qJp3Zv50V5Y9f2StEiWBxZirx7YUGjQUscv6wr3RgaT5naNuSWeS4dPPUWRisg/etD+VHhGobyJEM6jt3r0SBXPND1EZ8zSMloa+Yb5kamvV9zmLh7mDRd0KWzCVf5LTvmwQn14Gh4Y9kSNLK7WF5125O7LUuIg8Keb4LRsY7LYREMTsrvDhKukSS22YF64AE9sTviVO/X3kofnyXINlxLJ42wm7ukYumUTrw/+ucSz7iCWYh6JeS/hxru/aDJ9GGN3JqYBCxg4brgBKlUyvt3ybEYR0kaloOD1T+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwwjGXhJl65aYdlXnrQ+C6+jMGsFhoZKdq7ZSAugC1g=;
 b=aswsutm455p/XWVhaPYoG8eCo9hG4IPcATExVOMBD17+JSrwNeL/Lzr11FxaJB3on9Ouzjgum/yR8ESobJ7flxcyPpxbkcjFIsSZDfNEJvZrFjXpajs9IiwgdZb1Wc1ED9eGEWoYknz2fGvdjg6aHQladtUG0o+zT8yH63Iqxpo=
Received: from CH3P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::33)
 by IA1PR12MB6281.namprd12.prod.outlook.com (2603:10b6:208:3e7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 14:04:48 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::aa) by CH3P220CA0026.outlook.office365.com
 (2603:10b6:610:1e8::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19 via Frontend
 Transport; Thu, 17 Oct 2024 14:04:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 14:04:47 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 09:04:44 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v3 10/12] iommu/amd: Implement global identity domain
Date: Thu, 17 Oct 2024 14:01:35 +0000
Message-ID: <20241017140137.6028-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017140137.6028-1-vasant.hegde@amd.com>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|IA1PR12MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 93da2fb1-1263-487e-ecdf-08dceeb4a93e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gOFfvj+DhNxPgM49gNUCGTXn1Af5p1qMQKtEKhWPJXf5+93QeNK1fA5ItxWg?=
 =?us-ascii?Q?5ZIoQS64mMVmNaYzhjh9sDADrYwBqPqy6BnPXzieK48hWPLY2gGpHC4pjRVD?=
 =?us-ascii?Q?65GKZHmuCPZKfqEWwGMIXy8lWqkWxwIC/zwulBFljg9NZIGInax4PZPWkKbY?=
 =?us-ascii?Q?V2mjoHgOVTNriFb0DHLfD0h+djHkX72PbplZB5qAEkkBog/Xt61H+9rhlZ5U?=
 =?us-ascii?Q?l4mBDQABYL25WGAs5SZcMLxzKUPeHBRvkkoVfQmDv5+IPurNbZlA3lIZUY+q?=
 =?us-ascii?Q?n2Q0caVGwp4mkaqC5UZrdun0Pk0e2CI5RQDwQh+tTsa0PJ3I04/7wx+o2V95?=
 =?us-ascii?Q?YZdMF6R2495qRk5WDKYSOKj/ksaJdDQSctOYOKmEynxHR5AWoItKfODRmPaM?=
 =?us-ascii?Q?RUgNTCOUIOJUGour1seCXK4X4Fcvl9VjHTCYnsrE617zU9czhXTuWnNvC68d?=
 =?us-ascii?Q?d3R11ggkPFSzYosG/3eGLXlTju6AdDqUHd2aR5kHT83vPs7GP8y9Fgy5Roov?=
 =?us-ascii?Q?IaJTXwUugu6PnrbHS5zVnY37k/SG0NJo8J44TXlffz2QJQqVOERwsOn8zgjF?=
 =?us-ascii?Q?4FY7n6+T0wj2iM0YGJVclVY6PftkcCqddqstH6zod8OHtVrcKnMN+d4GHOEr?=
 =?us-ascii?Q?EwftZzlUCdLUvrBB9wFPQQVawYDCcP5lZ5w/eq/YhdrVFXscCyHCPm8lNivW?=
 =?us-ascii?Q?II4fIS/y6dV1gUGE3e+YifHjbwktqiJ9RbKZGaDMG8Pv7zI66Gg6LRhdslDJ?=
 =?us-ascii?Q?S3LFPybg0LbmNom7OBJhFmocDQdubQpy6FmSAQt0qqCN8EqHDxcxjSm3cZhI?=
 =?us-ascii?Q?6VSbxrcKYK47Q1zwG0dwVQc4jat6nK/er4cdIUDltELpKFXYudWQVbLYlgLv?=
 =?us-ascii?Q?VQLsUVN2AcqmppZqFOWX2bdpwCigI62tMetQpAdQ7ZyCpKIF8SFOzXm335y6?=
 =?us-ascii?Q?6C9HbrqxtYlxqOsLPLQaekaHg/iUrgpNtrsHwjIRxBCZfuM+m1hccqF1RAmq?=
 =?us-ascii?Q?0jAzQt6fHCN+4tZdgX8bpH2iyHeuekh2xnsEkXmMgRzw/2v4OSBG7u1CvgEW?=
 =?us-ascii?Q?+k/EXvENw3IzgNyQpbP5+WdPuJLZ6Rp2XTnwuzKkRvpomlkCYud5KeD0JjTv?=
 =?us-ascii?Q?ybqKpRk1/DCdZ0HNKoBqLTh3S0AaVMjKT6I6mwfXVa2n/t5qsBdyvsH+KyU8?=
 =?us-ascii?Q?iC+9xHww0A3I3Bs6mcOMKYI5k9GC1OL1rkhcP/9+u3pCqAU/9RgE9hsu6TKD?=
 =?us-ascii?Q?OxYTPjTeZTQ0ADuwgTAF/+OvLCE6pTFLIRmXhWHBgtHGBMKW3WFum6Ynk+WJ?=
 =?us-ascii?Q?0ZhH/Zerw397NqQdqJEMWed63SRdNuHQ8HyH9RRI0Iyw9SZ5HVrD2HJQkd7K?=
 =?us-ascii?Q?psX6ydn58xrHEksrBqaiws3ATOFXr7ymJ2+BRKfoa2stTvf4qQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:04:47.9983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93da2fb1-1263-487e-ecdf-08dceeb4a93e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6281

Implement global identity domain. All devices groups in identity domain
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
index 87eff85c0c23..893b8ac82fa4 100644
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
@@ -2463,6 +2471,25 @@ static struct iommu_domain blocked_domain = {
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
@@ -2861,6 +2888,7 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.blocked_domain = &blocked_domain,
+	.identity_domain = &identity_domain.domain,
 	.domain_alloc = amd_iommu_domain_alloc,
 	.domain_alloc_user = amd_iommu_domain_alloc_user,
 	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
-- 
2.31.1

