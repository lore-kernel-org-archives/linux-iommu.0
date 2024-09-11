Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077141714C7
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050136; cv=fail; b=HavIDs4WzW1oCl5EutcCZ2+oo7+vYYmb0yufy5G+6bZOKmyYvLGjP+C9B1wYVLHs9F+vwrchvnvPQ2aw9n6c+a88ShGUje+yswofFrPF+GGd2knpkJ9r1wX70JsDUm3EH85aJpcSYcb7YUbrkP3P6t34EOYKgSHK1/YacJoXpPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050136; c=relaxed/simple;
	bh=EmluAgwcHjwHwEIOTLviYsoR8PGmSXjjFv3ZOL+Hyms=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5HUoEaO1QjBsoXAvEhqeXYyQYmzluT4RLVMMWn33du7eXl/Rbxpu4GUpsseFJG8Ae+awhxSM7TdQuuJQ3NulfgfJy4TKRHYIC5oZgh7A+sRQrK4PG1K0qnuX5d8mP+gX9mdplFcz6iiWHeAjNeGJviSl9GesBGDTZfI4NYXFLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1999CaHx; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1999CaHx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OeF78BwhAI4rx6OlKtXgzwNi146lp0Tfu7i8VoD62KzVq3qNfWhlK4versCVEAJLTl+M1N5T7y/+PIVB+rvbGTdkKJ+vyUrak1rTotj0vkV9EoxffsIwafMGgNVQQHTQh+H3Ok+fsJaQQBECCEUQX3gogDLK/qj3wTTwp+DcrOdk3IS3DvY+FuJErLqAVbFhi7Y8jljDcdmHLnjXOiORUuiOp02RScNNQOlaxJxBN6qM9HjpooZAGIUJrBbSst6l7KEqCxP50WAsv9wDHGg4YnANrAeQPTK2EOfHs6pjFmvLxf9fuzzGwLitAvsOw/84XjADLZoEb/kH3/pLB2j2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/C0VMrv46QQLEfk72KEceNXDUU4ai73anmXfOpg1Pg=;
 b=v2T2c0FopaRwDsmeB22x1zDcTzk6NcvxZ+6OgO2VJQWQzB7wgmu6x0ewRMnYVDWySg1mmnMqUGWq31VQg7EVdUb+vu8r0ZbMo2HR73uAd0nU96Vj95O5S3LfjUtPxlAKrrq8P9YP4hpBqnrGqXIMS8ScJRsoAFGqXchKMOcNedaenU0CmufGTPX/xPLhzJX4DHIgiPLz1/7WCjrNOOQ4qOshnEmlMxmkvOseuqlLG8q9zc4sy5Cb10R8T3BzVSzevmXplPgI20FrbYJ+kU7qjZ47uA6kj4v9tjJoKOqKqc2ypCK0agu5ha4R5SXMYE/TeZztpcZ3JtKDnSWAlYNIfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/C0VMrv46QQLEfk72KEceNXDUU4ai73anmXfOpg1Pg=;
 b=1999CaHxMtOfpAixPYui8F7z+2UzZv7Dj5zSBlexxClbQQMW5NBHx5//ZIzZoFBMy86dbJ6yYTfJ4+SMfODDzZ8kaPPzKuHWb75bdHexKcejjb4cOw13X2inEDtcF/KYsksjIbwXuC56EpVaUZ/Yetn4oJZx4Oy7ws8sklViyOs=
Received: from CH2PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:59::11)
 by SA1PR12MB7197.namprd12.prod.outlook.com (2603:10b6:806:2bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 11 Sep
 2024 10:22:11 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::7a) by CH2PR03CA0001.outlook.office365.com
 (2603:10b6:610:59::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 10:22:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 10:22:11 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 05:22:03 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 8/8] iommu/amd: Implement global identity domain
Date: Wed, 11 Sep 2024 10:19:11 +0000
Message-ID: <20240911101911.6269-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911101911.6269-1-vasant.hegde@amd.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|SA1PR12MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e217c93-3a76-4ac4-f33a-08dcd24b9905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K3oFYG5ROKDPPIEGMq/UIs/xLZADe12+yEd/eKP8efMG1ssnUzmsEY/PlwHn?=
 =?us-ascii?Q?+g8CuDzNC3Aa9C5+VCoSZnOCk0bAHxkfGqm6leDrs+A7iclGWnmvbDwMmld/?=
 =?us-ascii?Q?Z5IagjIHHsugttPfHdQtoGizOQIrKZDzfMvv1xG3JpapTn0rdmJylW9IaIdJ?=
 =?us-ascii?Q?KWZve+qmn4ZohPGP/IqOb9y8eKdi6vOl47GtSU9NY7TexgkbPWwyIVSVspVJ?=
 =?us-ascii?Q?IejM3/jtdJm+A7TdZ9XMthSfPuQKC4L8sd3hB9N/0IM3yIBKcBJw8miEA2K1?=
 =?us-ascii?Q?DWqnXA7PJCMrC8aInIyEAzWaArJkwkteyY0gkIOzEte7ZnZjCqjXTvZrNMMu?=
 =?us-ascii?Q?t2Q9QcQJadg6gbVVGMY5GylKloZEhYEW12LcsuNUD0i1TVmZrBgYSSmT5hu8?=
 =?us-ascii?Q?fuNuspqR8Ba+HJzd/k8/2bgmqw1Sj6rjwBqyOQheVMfoaVyLyKRDg9NEmqRe?=
 =?us-ascii?Q?P2CBYsCQ5I3kuFhdTOYNqS/779gVHiDKaekAaAS5tdTPOJIFFxhuj6YJuync?=
 =?us-ascii?Q?V1GZuHre0GKmfvPrxWT/iMugtB7NE3zCr5Ef7nlctd71/xML7jL9/PGLvPVu?=
 =?us-ascii?Q?v5msfUN8sdvb1aENlXcbMxUo7Y0ZyhCaGat4DIXoPb5J0MvE9g/4PbzHlJcL?=
 =?us-ascii?Q?I/ymequUvwCuYZzeCNJ+5sWAo40zz7ylNQ2qJiNZstABqCpp6wTN0o3iw4xv?=
 =?us-ascii?Q?Hg+y15CjW2H1a6mPioZYso+aYany/3m9FYFBjphZzRn0emVqCVrBnXPyIfhg?=
 =?us-ascii?Q?GHCUPM0Ok6TLpk/Qu1V45P3LjFIQ96ZS9pyI9GCYc3p8gV64doZggsiu8qD+?=
 =?us-ascii?Q?IB7G05ExQusrBNJjhpcU2vh8rNtve8SD4LY4oEoOJJPdbkYClDSwBnSUEvgR?=
 =?us-ascii?Q?lydDN9fuoZBh7FS/2XIDjdjFWKpyLokiLSn5rhmFpqT40nliMNN0c1vzgQpd?=
 =?us-ascii?Q?GcbHXhUKOQhCxn6wf9eCTnGhwDcWOpZkzRpWyx0Fuyn1u5N5uHEcPWmO+/Yu?=
 =?us-ascii?Q?1jkCARcZlI5/+aCZp5rQ4xhYfZYHACfoXiPHrL1hdWx3Pb8mDtTGa739XUIR?=
 =?us-ascii?Q?0gz/F0KcVqaV01B8j3azrFka7UP9J6IUKf8t/ALDYeOlKzYS6aCE2dvrMcLG?=
 =?us-ascii?Q?Ru3v2vin84vvSok41PrQO5iR+UvfTsD32Va4W2Ixbsqq8C1gBSzAFSzSmSvs?=
 =?us-ascii?Q?zmmUDuCwyE4nmfFQ/cbDmCBKQ8t2KbxjJuaHAl+EhuOYQGGAZEKowJHV+W9c?=
 =?us-ascii?Q?GSwI6TjPxwf7Y3y4RZQq8KYlojSRSAwjGiZbBV84uXGjFEz1uHrw+ZhOQThv?=
 =?us-ascii?Q?euUeoeSv/HnX+jbFUoN8T6NZvXQ0mcakp7j3GMvqiZoqCbIcEwB5eXRzBtm6?=
 =?us-ascii?Q?pFgc2qPGhIXjG4diHu0eiawUhEz62HH9MOVQxfpqpTummffjcWHphK98gE2l?=
 =?us-ascii?Q?IkNfLnbxSzDSwVktkgsNK6L2pYOAKezS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 10:22:11.0358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e217c93-3a76-4ac4-f33a-08dcd24b9905
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7197

Implement global identity domain. All devices groups in identity domain
will share this domain.

In attach device path, based on device capability it will allocate per
device domain ID and GCR3 table. So that it can support SVA.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/init.c      |  3 +++
 drivers/iommu/amd/iommu.c     | 36 +++++++++++++++++++++++++++++++----
 3 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 6386fa4556d9..983a9d109206 100644
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
index 43131c3a2172..8517a854c331 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2172,6 +2172,9 @@ static int __init amd_iommu_init_pci(void)
 	struct amd_iommu_pci_seg *pci_seg;
 	int ret;
 
+	/* Init global identity domain before registering IOMMU */
+	amd_iommu_init_identity_domain();
+
 	for_each_iommu(iommu) {
 		ret = iommu_init_pci(iommu);
 		if (ret) {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e6b4460c485d..6b1bb07e0aae 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -74,6 +74,9 @@ struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
 
+static int amd_iommu_attach_device(struct iommu_domain *dom,
+				   struct device *dev);
+
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data);
 
@@ -2262,6 +2265,14 @@ void protection_domain_free(struct protection_domain *domain)
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
@@ -2276,10 +2287,7 @@ struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 		return NULL;
 	}
 
-	spin_lock_init(&domain->lock);
-	INIT_LIST_HEAD(&domain->dev_list);
-	INIT_LIST_HEAD(&domain->dev_data_list);
-	domain->iop.pgtbl.cfg.amd.nid = nid;
+	protection_domain_init(domain, nid);
 
 	return domain;
 }
@@ -2469,6 +2477,25 @@ static struct iommu_domain blocked_domain = {
 	}
 };
 
+static struct protection_domain identity_domain;
+
+const struct iommu_domain_ops identity_domain_ops = {
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
@@ -2867,6 +2894,7 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.blocked_domain = &blocked_domain,
+	.identity_domain = &identity_domain.domain,
 	.domain_alloc = amd_iommu_domain_alloc,
 	.domain_alloc_paging = amd_iommu_domain_alloc_paging,
 	.domain_alloc_user = amd_iommu_domain_alloc_user,
-- 
2.31.1

