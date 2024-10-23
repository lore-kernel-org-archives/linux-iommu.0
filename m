Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8409F1A0AE1
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680276; cv=fail; b=ZBAE8MWl2SJoA50G+IwS+kF4U4FM0QvFSY1MaB+zcJ5zZplJdK0xnvwHLXx/0BrRMq1c2gGmVnc7qSPVsDG0oSTAAFJ94L114dVoGi/v4/fhWUUPEmbdCv1dPjLZziUjxUGj1n7fvjRQq9cIA8mrxDvQJWA8G9e2Y6gj2GJrJ6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680276; c=relaxed/simple;
	bh=EsBD+Eb8HXXPlyNaWwptoxX0VraCIU3xYVvIz0SaiVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X18QHx16Kh3X4BydN9yWMOLFGoqofCPALg3AFVLXSX5AlQs4Z0xKf5MXPr1T924PJdxJelEX9+0mSaXgdHO72nghtsv3Jg6ZmgRh4uNk/VSvJR6ZcuDscbgUsyYpi6rl+c1O2OVBKgLNrmG9HegOBq/xaXuqWPsoh5szpo/l8U0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dupt8g/i; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dupt8g/i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=thUL49GrU7++5ztlvOQOUjZdNWhycnQaGnlgdD9VX+SXZDjXgtfQInYgxm04mpyBjQYBNZ8tq2haM4M2ykhd9D38STrL+Tubq3C+XUpIaFdVsnFvUHQJFkv2TeTCAd7C79P1qrC1tmDT/+WiuOFTlyq06gE8MYov3Kmb5+KFd10eSQ1BoOOvLX+Jc6bcsUvJGTbQWUKyxVJoqBpLvfCtMF3KpO4lctv53pFZQ3Ghxl5vZyfDH6r1L6WD+eLhvYrx/I3MYccblMaH5+ju6b83Dkg05tBmAH2vg94vwJDWahg79RT+HQQMuUqTHzOe0p6iXl8fX5bTefi8GbQxIaGCTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUWuWCXZdJgKeqGF6ECbcieeTuWspqNfhISf5+g6HL0=;
 b=PpPodt497UwXjAYj5b1TviaKK1c0PeS6KQHH8/jFBjhNQNfNZnbcSAkkZDb40MXS4ZxZsRal4eHfV/W1mS30H4k/NguditYbskG16ZbLX9a2h3DxCtxTskvZm815IpKaiEpqpmg5nH9i56u8lFh9HrUKobOctYts+CWwo19DFyTY9ND74a+uhXc4KpQnPzktMkfLIEvIENO1OFY2FAD6guW5jSUkjRFoLrbtNfRlqRFU1GDG2lQbHTqYIWqoMoWA5EeJvGR6mq3HuXSIrFUataCEC9fYGjUBDHPv2c/3vSlrGOEq/EYE+cX7uwQxNhKwpb5iF9dgOM+wFrppCdKTgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUWuWCXZdJgKeqGF6ECbcieeTuWspqNfhISf5+g6HL0=;
 b=Dupt8g/iuI5mUYsD7/1lgO/7aMcdvKD+QX8Q2o9OEkrIwj1AXqbrsNwiv5v12cdqS32+FPy4S/p3ah5QT4WrYgAeQIF/41hQw2RbbWsPh+heVGA1BHheJ+kVLK3kzeQbU4LIUK7jOK/xAc1bA3QvKPdkZzcz/J/9dFfQbBmRq3g=
Received: from BN9PR03CA0096.namprd03.prod.outlook.com (2603:10b6:408:fd::11)
 by DS0PR12MB8526.namprd12.prod.outlook.com (2603:10b6:8:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 10:44:30 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:408:fd:cafe::1d) by BN9PR03CA0096.outlook.office365.com
 (2603:10b6:408:fd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Wed, 23 Oct 2024 10:44:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 10:44:30 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 05:44:26 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v4 07/12] iommu/amd: Separate page table setup from domain allocation
Date: Wed, 23 Oct 2024 10:42:02 +0000
Message-ID: <20241023104207.5894-8-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|DS0PR12MB8526:EE_
X-MS-Office365-Filtering-Correlation-Id: a38c383b-4d12-4d9c-84ad-08dcf34fac9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7JfaUuzwBHQH7pdLVry5Ip4HvaYneZ8EsXtJVnPFmYJfW5IAMRqI4wKj6cO/?=
 =?us-ascii?Q?sj6VwDrC3W5JlfgCmBNj3uw00yYky/vgpl6ruda6FYNmA19/aXjb9baHDN42?=
 =?us-ascii?Q?MLeZDG93k7S/wny282w19lut2qMt7qjn6ce76WrrJBrjNM3Gaci2/8ydYofY?=
 =?us-ascii?Q?qMvn+YR20e2hD7vewN2Aw2qb2GwgBUKV/ax8YQS3dXZj1xShmbkBdT5i95Sj?=
 =?us-ascii?Q?ERy/0nLeuQZLPxIiwpcC2KRTQFy0BYsw5ffEJzikFcouit22gxnMB7xiNOx6?=
 =?us-ascii?Q?ASEKrrVh3lB5gx17q1D/Z1IWgSapct/cL1IfN8Qi7xKT+hbdkBVd7xDrY8Uu?=
 =?us-ascii?Q?kATP6Zy5HYWHHKP7B+pACTD7ZIgiftGl6Rn6NJh8akTLVCtgYorCqZ8TLEUR?=
 =?us-ascii?Q?QTkipbxR4d2zNzlHHrTB4obj1fFpdY+F+uHRlGEDPupgG1hzDMFZgknnwE66?=
 =?us-ascii?Q?B+kR9tAI4M3ILDsY3Xtt56mXBKmFDZqrskDCTBWHOey8cS+PVYThUf5isNKa?=
 =?us-ascii?Q?FVGNc9VZS9CMd3bwHbrWhxCAm+Jz5s1oKfYbI/F2dmz4eBrLzlWmrv/UT3c5?=
 =?us-ascii?Q?npL319TKHjq32WiTSrFEkBzBX3W6traoubxvlPBGrv3A7fOR0dEU2stcbUAq?=
 =?us-ascii?Q?t4vywclIFSeF6qyQ+g3LWt8v/CxLNrBTLRMIw+6fLIPnnlu59ZkBcuvJ3MnJ?=
 =?us-ascii?Q?MmA1YDizuK7t/dV2xg6VOAPOCquIsVQzlZcOrqnhWoseKoCDsQIeEed7Keut?=
 =?us-ascii?Q?wsPYcOHz4AhRNJi9wmvzOXUildw2WGrXDruYOiVw8moK0cBuQfNZ376OnTsT?=
 =?us-ascii?Q?eIHDiCp6L6C7i/ZaCctupiv7BlF+xvE+pAt/b1hJyooIVed/aKlUKQBnmwIy?=
 =?us-ascii?Q?q/T2GPjX6ZYbsUhmMqYBIcaKkZrr0VgvwDWFoM2ZRkylBVuPeDuSIqFd+9sa?=
 =?us-ascii?Q?aPr3rmrZFtLJWgEgPBzNq7AV8cDGM1yeQ4UTmaN20MWoOe8KYBhnYnOalfeI?=
 =?us-ascii?Q?WcsZWEEXJWABRbcmwRz2DJ2NkWaIOtfasmIMjRmqUXtmm7zMJ0iUlNFR9pi7?=
 =?us-ascii?Q?QgySOdjfsjvuJyNxJp+xHupUePoQ1DABdowu3t+En2qR0u1O6kbQLjgVRBEf?=
 =?us-ascii?Q?EB2wQiZ8UOzRfbWJP/tDa0iIJwxjEWfBGLZ+MnzqBBvVb/GDO25p8L1YPb1t?=
 =?us-ascii?Q?PoJRPw/AtZbWDmAr4B7IlIuRAs1aBcssgNPBojMkSJQdX/zjtoYWg2+8arbm?=
 =?us-ascii?Q?FEoKgtPzBgG/TyKVFYe7OUr4rSQCiH3ltRMJmRjYEy+kTUtAsFNv8guIS32K?=
 =?us-ascii?Q?GYX/Rtmu/zGbAtmrSaQwMOXBqrwQWSGKxz+OUZUX8biaOmYliIjDFujD1ov9?=
 =?us-ascii?Q?h9RAn7gq3hpXqWSd7H0cWW6xcU/azBF3Wvq1jCd6Bh72k2tVQQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 10:44:30.3087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a38c383b-4d12-4d9c-84ad-08dcf34fac9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526

Currently protection_domain_alloc() allocates domain and also sets up
page table. Page table setup is required for PAGING domain only. Domain
type like SVA doesn't need page table. Hence move page table setup code
to separate function.

Also SVA domain allocation path does not call pdom_setup_pgtable().
Hence remove IOMMU_DOMAIN_SVA type check.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 42 ++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8364cd6fa47d..6285fd1afd50 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2265,28 +2265,36 @@ void protection_domain_free(struct protection_domain *domain)
 
 struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 {
-	struct io_pgtable_ops *pgtbl_ops;
 	struct protection_domain *domain;
-	int pgtable;
 
 	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
 	if (!domain)
 		return NULL;
 
 	domain->id = domain_id_alloc();
-	if (!domain->id)
-		goto err_free;
+	if (!domain->id) {
+		kfree(domain);
+		return NULL;
+	}
 
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
 	INIT_LIST_HEAD(&domain->dev_data_list);
 	domain->iop.pgtbl.cfg.amd.nid = nid;
 
+	return domain;
+}
+
+static int pdom_setup_pgtable(struct protection_domain *domain,
+			      unsigned int type)
+{
+	struct io_pgtable_ops *pgtbl_ops;
+	int pgtable;
+
 	switch (type) {
 	/* No need to allocate io pgtable ops in passthrough mode */
 	case IOMMU_DOMAIN_IDENTITY:
-	case IOMMU_DOMAIN_SVA:
-		return domain;
+		return 0;
 	case IOMMU_DOMAIN_DMA:
 		pgtable = amd_iommu_pgtable;
 		break;
@@ -2298,7 +2306,7 @@ struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 		pgtable = AMD_IOMMU_V1;
 		break;
 	default:
-		goto err_id;
+		return -EINVAL;
 	}
 
 	switch (pgtable) {
@@ -2309,20 +2317,14 @@ struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 		domain->pd_mode = PD_MODE_V2;
 		break;
 	default:
-		goto err_id;
+		return -EINVAL;
 	}
-
 	pgtbl_ops =
 		alloc_io_pgtable_ops(pgtable, &domain->iop.pgtbl.cfg, domain);
 	if (!pgtbl_ops)
-		goto err_id;
+		return -ENOMEM;
 
-	return domain;
-err_id:
-	domain_id_free(domain->id);
-err_free:
-	kfree(domain);
-	return NULL;
+	return 0;
 }
 
 static inline u64 dma_max_address(void)
@@ -2345,6 +2347,7 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 	bool dirty_tracking = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 	struct protection_domain *domain;
 	struct amd_iommu *iommu = NULL;
+	int ret;
 
 	if (dev)
 		iommu = get_amd_iommu_from_dev(dev);
@@ -2364,6 +2367,13 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
+	ret = pdom_setup_pgtable(domain, type);
+	if (ret) {
+		domain_id_free(domain->id);
+		kfree(domain);
+		return ERR_PTR(ret);
+	}
+
 	domain->domain.geometry.aperture_start = 0;
 	domain->domain.geometry.aperture_end   = dma_max_address();
 	domain->domain.geometry.force_aperture = true;
-- 
2.31.1

