Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C09193060
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 09:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108487; cv=fail; b=HgWXoZWN6KuyEmt9d4S01YzABzsvlkJ3jXBuvLN4Pmxgx1zCBYv8+THupZRr0qYId2ZeASuMSM4AE6ybwxlnO0ppj0OI1OvUj4yxjL4imPEw+Mrc5mjVCTafplmSnEE2k+YVG+8b8X2ab9dzgFcPzMr7s5kxZhPG+yGSc+g7ZPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108487; c=relaxed/simple;
	bh=ROO2uom9xtBe3H765bnmij0GOshylhIJQzWuoB9Gkq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gSF96AwOSEAZacLqz6iYUCdpTLds8iFRg4PXrQibNfpdtA53VXZTQ5rdO0H+1i5O0+Rs7hkAr/Zel8/FmTPoG5YL9CEabtQq+q2Je8g2jyZe/zXHF8jkO7JHSuNeQVLOoZyGXGS6kdr9JrqB8KzXwEeNKKwl12EoDJT/srHgbI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hLAgHVBl; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hLAgHVBl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqhTihnSeRwCoLbvacthiRSPaUjtxvilA8x5m9FkxXlHBvGSi+WdWI6haN7II9vCUfZWLM4qfItu4akJqZD35v25+lo1VjAm4ESP+4ns1wPpMSOwa3ddgT+rXSnd8L0uSN4bdJ4HXyqoJQ3H9BZmti0bZziaH9yRl9L8VEaiEl9AgOIpI1mgPiu7z0uOMYwLA/Ty+4I18q3cwzf0jcSxyC5m6VZX1OQf33ha25U5uKJkuBdS/iEL6q0NlJrd2KLmyX8voP0PJqSWJEW4GRKSWVvMQ2S6+5eG6Sb96ODXDZbLPMkjIhxyld8xZ5L+/ybNmAB5UuSQgm9gMV3i8xXOKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2isJZoGcIsqFhWhmX+SW/cBCu9sEEYz+iAOARo2syw=;
 b=iDAbAXBee28pzBCp3G+201JhECvpYH9povjWOKQK0XhE9GArT6CGOaRzYoWMHjB40PV/sWrBNfi7Kxi5+h7/K3xZ2W95Hp2LWTk+ov9vt7qQiZJpJvg6jFAKqcyp+ZG6irwJt4tIorZB/07q/3THbJq4Kbkftq5THDvyUnA+28NiQElJdIBpHl2msnr9YUIFjAktWroeVBXU13AGljdDKPHghDzjqFZkztYV3qIsoe9aRYsZzmP0R8/8p7fq5SQqArUrXksjzlSxs3KwqP5qVpzRyBfgPYhQW9gZ1vtigNPe3s24qozBjoKyrruvSm0F0GTANNBOVgdK0IE9yY22Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2isJZoGcIsqFhWhmX+SW/cBCu9sEEYz+iAOARo2syw=;
 b=hLAgHVBluYI6BGbFrTT7whqTc5p0P+WoSjh11Aq0XgTH581qwVM4MbIPuJniWYGa6T4l3PMsZ9HaomUAWlNX2gR0Y3zIz+iTZ9+Iq6NS6ytn+lkdStVKrsbxGve60TDMAicxxz0Cjbt0P5qIWcFZIIvFr3TuCICPZ9uu1YPntA0=
Received: from SJ0PR03CA0180.namprd03.prod.outlook.com (2603:10b6:a03:338::35)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 09:41:22 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:338:cafe::d1) by SJ0PR03CA0180.outlook.office365.com
 (2603:10b6:a03:338::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 09:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.0 via Frontend Transport; Mon, 28 Oct 2024 09:41:21 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 04:41:17 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v5 10/12] iommu/amd: Implement global identity domain
Date: Mon, 28 Oct 2024 09:38:08 +0000
Message-ID: <20241028093810.5901-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028093810.5901-1-vasant.hegde@amd.com>
References: <20241028093810.5901-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: e22a6832-6045-43d0-9e8c-08dcf734ae83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oZgTeyToPpGeuqrJFCc/ORWJ8IIBkSu/ylto7LqavA6ceFfBlEy2UBh8UNur?=
 =?us-ascii?Q?Xq3TpGm9S5K+lZzeI1iy24lOBpGO91Vv4oujM4qd9NgjBCOyP26tJd5/oEry?=
 =?us-ascii?Q?LZ7WCcw9coAD/lKXA0EouIvzRT0C/Bgy1UwS4j8wpKWSt0z2CQOyusCA8ByV?=
 =?us-ascii?Q?15H8Mib8j1zcRZh+SexhMw0jO+8MkDCvpGeD9xXG73xIwXEIlU82B8zoWfwY?=
 =?us-ascii?Q?x48j3yWYmiWvpXVSUuuLPYVG8YnLEkLeD+IIcrSLulV5Or+bYgI7ro5GuTX9?=
 =?us-ascii?Q?GEwPg/Z1H8o4FuzVE2CzkC6ArBOXL/mdxYdf5GhmZWktahlhBp+pzwUvAEog?=
 =?us-ascii?Q?dRPzCW2ex0P1jq8fTHz2gPky6iE0YLYuipnccqYAdd+Ba/uV4Y/K8Nz488Wz?=
 =?us-ascii?Q?Gy/F+W7MtkxhO4U9Gqbk3vc/Q3/uJzuG9dI4csAZfmsr2Vnq/tI3xJTuY+By?=
 =?us-ascii?Q?uNBFRCWU9Gqn5yvFqHG6y8iDuocZeV3S84Rv0TIGqOAUty4pciw0fT9LCy5J?=
 =?us-ascii?Q?Zctl9VAWsb0aj1g159IgZZQsrv0GcvwlG5PETPcBbbtgCpQ3UqLMNv2Wq1gi?=
 =?us-ascii?Q?6iezv76gRFksV78lX2NS5uaDz1cxZ8fOE2cc3nB2MyCTI2indsxYHS53B9tC?=
 =?us-ascii?Q?RdueqgkbLOxsDdVpb8CqUE+5ql6fBVtJD7BCp0FZVlp7nA6iYCoS8KV/vePU?=
 =?us-ascii?Q?wkAHXtNpVtBfdXxoLk0AOFUaOSWtI+WSjVbXCoD9KSRdZwqAfEGeldLSOE5M?=
 =?us-ascii?Q?VxCPo/BLn8NSc4SDGqa8gdjRSW1VSQwBIwxEZrjMjqwv+CMJ77XMQPK9+Ha/?=
 =?us-ascii?Q?AhF/sMpdmebENWPmHa+A5lho52hnbRkknL++vUp2P8gOrAo+Up4bywAW2+Dm?=
 =?us-ascii?Q?VmOBI62ebtJPO/xmcCFYEGh5/m5yQb+rvY8EjzTKK9whR/nIt4xMyeeYQ4/j?=
 =?us-ascii?Q?2t2FB3FovwuGUG3F3Qz5Qtuw66xRwEOndJ0O+nMFrb8aJ7KQqtZOb6gjX2Fp?=
 =?us-ascii?Q?sX/T5ERAFq/DA8oUfPNW2mTuY8KexUNbSj/4PEdIRB0R3rYvRkb6XanjU1l9?=
 =?us-ascii?Q?SI8z9Dgtm6405KMWI18URvoywdOv0NplzQ3ffeez8UtRrvKaRoffldS+fDzI?=
 =?us-ascii?Q?L/ecmcXp0PngYA0Essg/uWCA7Kxvr8gnwKscaAF9wFH99joUqYKuRLaCg3Ei?=
 =?us-ascii?Q?uFxEOi0p84ZK17nB0Qurbxi5Ru0DM4coaGAdSER4y6OtpzXKu1BljDS+U5ZM?=
 =?us-ascii?Q?L/YwXDHeDPXKk3fra6BbzxLZ2uc58ITlCS9/44OtXLXKwS1x1TeT2qXzcpur?=
 =?us-ascii?Q?547KdOZTbFxHGiXfNSbbbovYhFVe0htpWdhXQOrYB/VwF9ntNJ3Y9DMmkdjg?=
 =?us-ascii?Q?llaRoc+PmSAwGn80gR7g4V7rJ3/P9lCn7gPU0TnNfttT01Y0hw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:41:21.6426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e22a6832-6045-43d0-9e8c-08dcf734ae83
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333

Implement global identity domain. All device groups in identity domain
will share this domain.

In attach device path, based on device capability it will allocate per
device domain ID and GCR3 table. So that it can support SVA.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
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
index 671131c22d9d..477aaf76b7ad 100644
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
@@ -2471,6 +2479,25 @@ static struct iommu_domain blocked_domain = {
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
@@ -2869,6 +2896,7 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.blocked_domain = &blocked_domain,
+	.identity_domain = &identity_domain.domain,
 	.domain_alloc = amd_iommu_domain_alloc,
 	.domain_alloc_user = amd_iommu_domain_alloc_user,
 	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
-- 
2.31.1

