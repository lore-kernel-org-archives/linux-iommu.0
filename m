Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1578A17E900
	for <iommu@lists.linux.dev>; Wed, 11 Sep 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050064; cv=fail; b=tkmhZwLTnfWwDMmOYp0aA84ND8zXIFLh7mOIQUK5iVXULl/hU7k8gGwVIA+evEDQ1WombE3gWjjC9JsG8gfUHSS2ywb9UAIaq1tBiOIOnhl4Nj539mVamlsVKGdlQtPD8rgtnp23xVt/RIQUDWOehrY9wU/8RhSFIwTdQzWc2wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050064; c=relaxed/simple;
	bh=LGZBhxrtqgsmmWHylWviwhuPVK+IgLs0rCtsYvTsbH0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AigJBqqzUdSIHD0JsPBdR8si5XeRhO0tLnM6ZXoFymJFR9F5Irw+xvv++Z1kg0muPQxF5v5eo0KajtPg2UXMvGFiAli9R6uvFbTsQ6QtEMZ7hxw4Zk2sqkK74Yatv46brhLJa+XgRwAtGzyqmhgP+u6ezIDLWcKHiJdWzVbjSGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5Bm3ivE/; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5Bm3ivE/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FebgGxmu05xqyHvZ5Zt29qjavOFKAtAwgh2FvGqsgUywHEjiSBy7ig11iC26eqTSxVrwSKRbmEo+posFhk3MIouhUaWac2hGoJK43FxkO1GBhLbzl5/ci4ALtzgexV92Cf8CqJqSDt2enmIHshON8olzsP/qxxhkAthKwGwA+00PoghUnapH0U/KCo4PNgSHRlZNOrKOjXAjONx+jrlwGspAH1v5LAM8bYzrhxiM+iqbwp/679BV07pGLSFaqyzhfVl/AKgVczRe2XPgS735myeGX5zC6S3YSJzQBB7GyRrSR7vAIIqwyeKoXDf/wy8VyE8oEaWQ/CiHGWwyMTlnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5imGw7jILqac5uGZPhrAfwCtjmTj+nXAz4s8EQQEBtE=;
 b=Mt3nTDr0GJfPBw1fqKYMdz+WEUu3UW09QfaSFdlKrHuAomYcbBV+GubYw1dG4+IynG+z8oGxOEbvVCvvy2FTWSU7vt+2A8p0uRNGl+zjhpv+9ZpOQwCjVfR0DPh1jIv4zlVZOwuG7tkRHat3Ilg+AxOtbQiW23UfM5bU7iGuWcP7t6/zt/T88TMojnx3f7JF3YNsRKPXAimc0wWSnPkQrGO6MUXK/3eoRnnH3fv3TwFKS+CNjEGwL0t5hu7Z8C9+g3fXWT86ZV+QyexW0tJJGQSjAUxBI4Mknv5kmcye77Xh9ZxcgNeISfC7I85mbzFBd4buPWHUyCfLMBWdtMn0+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5imGw7jILqac5uGZPhrAfwCtjmTj+nXAz4s8EQQEBtE=;
 b=5Bm3ivE/piz6NLN3JLqxR0TVtv0OH4i/Bb/1q5lXur6Ao+D1gJKOp4u9otwvJX3aDbqhdrCdW8kOWhsN9mwiy0zF6TTgj3h2gUO3Vhcmxdep8L759vKoxe+rz7ICt2rFlBUH96t4S3lCFu0n/fXbNkulDklW2QZhGcDEXdsVoss=
Received: from CH0PR03CA0275.namprd03.prod.outlook.com (2603:10b6:610:e6::10)
 by PH7PR12MB7019.namprd12.prod.outlook.com (2603:10b6:510:1b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Wed, 11 Sep
 2024 10:20:57 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::a6) by CH0PR03CA0275.outlook.office365.com
 (2603:10b6:610:e6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Wed, 11 Sep 2024 10:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 10:20:57 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Sep
 2024 05:20:53 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 4/8] iommu/amd: Separate page table setup from domain allocation
Date: Wed, 11 Sep 2024 10:19:07 +0000
Message-ID: <20240911101911.6269-5-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|PH7PR12MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c4fbca-f71d-4320-58a8-08dcd24b6cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PhBV92Z6oDJQtO9sxU6q3cYTgFHVJG69OAboTP/d8ueTx2k0roHJbIqJ8I59?=
 =?us-ascii?Q?ZjfSRN1PItTaQiECt4HQkTXVeQf5UYxGkF+4AoLay7bMHX+N5nF7gpAYsTzp?=
 =?us-ascii?Q?iO/39fw5VGDEPILkvKVDCqyPFjzSEO036YU5ycHzah4biIPjBupJqB2T3I65?=
 =?us-ascii?Q?VMfvmoFNvzNud0xmRt9DgaVvcuCGWFaXwTYpO9azeFmbk2McBoCXgiPBgGIW?=
 =?us-ascii?Q?g+s9uLRHTLSHew68fvfvn1gIYAE3mJv+u3uNOReVjyQuNpb3BudLgFNHGF34?=
 =?us-ascii?Q?QqFFQzanXLJD8B75fuVs03ql3DNkFcMoHfgIAY68hOREVk/BEI3RSgYqF+q+?=
 =?us-ascii?Q?7NVwXRr52wJq6odwhiaJ5LNxROFElTiL784wxQA+X+K4voETtUBXwSstRU5f?=
 =?us-ascii?Q?sR9bzN2KDdPwadEuUte13W3bcneIMOETbTmOUjzWy1cLu/KikQeYTzqlgan8?=
 =?us-ascii?Q?rfuZISO6YSdpx/YI14Qmdy3FgWDAfEgguB2A41gn3QQ0ugNQi5iGyB0/VNWI?=
 =?us-ascii?Q?3enuVv5/jvB6/ZoUjUoIRizoyFPYsoWu3LGHbgWgSpDOIDqBifCE5B9pgpjI?=
 =?us-ascii?Q?I5469vtfrTRnTeocV2LTRZb0cxFJ8g+gmc27CU+qhlc3K2NaONN2630CHchX?=
 =?us-ascii?Q?VZER22axZx+0Be7kNOga1eC20B3BU8VSy/Kp0Ea+n6n3jB4N2g3p8dFCQhhZ?=
 =?us-ascii?Q?/T/iQKqtYzcdqXiOEepN/3c9Fx00klS6QPf4tx+8Xn/t4nh4/1k9UPyHjR4k?=
 =?us-ascii?Q?Q5XgP/waeUgQqFVHWzWB9et1PaBcJVF0eBKydYR8e2i9OInDam70ONOMeaR5?=
 =?us-ascii?Q?zzyuS3wjqRE0AK2V4sFdXP4LwsImLaFzqbQNyJilfQMjecCt/YGPP3Oa9yWV?=
 =?us-ascii?Q?NeyZ1C5l+wRPLO/vUwkrlxF2WQFk4rJtGsdO4WRsbdbmijd94edCCbLrsh0g?=
 =?us-ascii?Q?nTz9gQtiOQrFQRF5Tu/LtpnQuALT2Un1fhdEpbsjDbuZBHmOkCrlipwBVkH5?=
 =?us-ascii?Q?uEP1XXoMDjxJOR7jp21yY2fZsm3aMe8VzBcUrqWFcrd5SiU+SGmpiJaH/x+4?=
 =?us-ascii?Q?WCF8m0TQSafT02HIzKGWcTByUUz3mT1t20XjtXRhKjNvvGiklIdcsO2egMBY?=
 =?us-ascii?Q?b05w+EsHgvAlhxaV1TnNXp7IpmRHvaiGrMiKVT41kO5itIo6BQnYLJUQaxJs?=
 =?us-ascii?Q?arV8wFgaI9m+gv2yH0FdXMpxwMpAdlK9m+utuIgzyVzn4W244Lg+WowrWhxc?=
 =?us-ascii?Q?veTcYX9Wwg6SKil0ZRPMPT8DUf3EQMqBkw19bCmSr4GSLzBU4QwL7+zsAzFk?=
 =?us-ascii?Q?diywSXBscr2gSv9GbSxFW+W2hhG6LNcyTK7N8LTMzXyDvCkNv/SiA6NQeOsQ?=
 =?us-ascii?Q?RQAH2QAz1OP6bYPjvgyDQo/Piit/iYfKiSOIlnWnGkXfy/vWUsHk4xUCjyLg?=
 =?us-ascii?Q?62J6Ft6U6QZ8wPLAgG4at0dPXlJzp4eK?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 10:20:57.1818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c4fbca-f71d-4320-58a8-08dcd24b6cfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7019

Currently protection_domain_alloc() allocates domain and also sets up
page table. Page table setup is required for PAGING domain only. Domain
type like SVA doesn't need page table. Hence move page table setup code
to separate function.

Also SVA domain allocation path does not call pdom_setup_pgtable().
Hence remove IOMMU_DOMAIN_SVA type check.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 42 ++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2d0a681a2052..6844040b3702 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2264,28 +2264,36 @@ void protection_domain_free(struct protection_domain *domain)
 
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
@@ -2297,7 +2305,7 @@ struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
 		pgtable = AMD_IOMMU_V1;
 		break;
 	default:
-		goto err_id;
+		return -EINVAL;
 	}
 
 	switch (pgtable) {
@@ -2308,20 +2316,14 @@ struct protection_domain *protection_domain_alloc(unsigned int type, int nid)
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
@@ -2344,6 +2346,7 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 	bool dirty_tracking = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
 	struct protection_domain *domain;
 	struct amd_iommu *iommu = NULL;
+	int ret;
 
 	if (dev)
 		iommu = get_amd_iommu_from_dev(dev);
@@ -2363,6 +2366,13 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
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

