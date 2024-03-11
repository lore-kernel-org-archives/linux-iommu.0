Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2AF12B8D
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148393; cv=fail; b=jJ3kJadFHOKCEGaxWIwHlNGCHc0sqbvvOn7KfSJVOPbm1imw4rpySn2H1D3dOXBke2easkMz0ZaYQlaUmWeRy+6t5GA6P5pKKxqjYHSsnXiaPiKbp7FQIL0pPQK1T6VN92WKa9wqVfvT0MOQdk9LroPofSwWXaxUkHh2wvet3Qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148393; c=relaxed/simple;
	bh=TGBJIGtTN0GZ737WeBuVaJzpuq/sJ3Qw82HRsUezM7s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hckbMjp0cXGnW5i/aaX2uAaeD2bDJCBY6OCwocIvyumQt0XAqxwVEjkHo2B5ZN6VVT78O8AFEpiJvYFBBTVmNXG/taZiLSc61qGorhGD8PQJdrY5FltPCfb4jaBFReQ3QwxuGCqOy9aLgJTQ8lwNJn6/E4HFwniQx97QfjatCzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V0x9k1tM; arc=fail smtp.client-ip=40.107.244.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V0x9k1tM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtF8DSTJu+fU13iRLmd5NGiIpCCI+Esl7AUrwI45AjZG4yO7wulaXsXCAoYCsd2aVdaDxTNsPpDhIHHrsE+tiUUfX/OL251kyRoSjZIvVJifniPWgAFFgpbuID9KEzbLwHIsrtroG5MPOMVKYpwJsNQeaeuNtDq6T6bk9Ffds2fANUZnyEKulMjnNExG/e34hHsU/2dyahYLTNbvNnomsS7VJkboCXkmfpt9/UgdYGP3dr/ixKjQtipwiX432aZXNXjwnLDaDHSx2NVpDcHWvl48hUbwtQY/0BbiwCl0iX3AaTsMiFpU6wMdgBWSrGmZZ981XT1TSWMF4in5HNb/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XE6L/vp0NEr8MpHfWFpSNVehZQ6DXOjhUzKV3GFx5is=;
 b=ANKeCPi0JvklRgByPNFvB4ymsXyocYJe1deYgQPuiSOXzEOvQMTn+dNhGixBdpvVg0RQLpg03OnavSseDFUOFG1sPpbQD8tfUdUhbImSGq9j1VdydhYPL7rG+qtNffv+YTrimGjevfX3cy3pJJKhhAIkqya6MhkXNcA5m6OZDjNfa3x9qNQ6LTGcKth+RrES7WSPWYBBzPBv5PdQyrDNXd5E6UuZN6TEWlZp5gFvtBz7GwOkzd2knqzGdgzAd15S9iuw3y/xso/W7UG/JVWo4Od76XGaEcLlfikv0c4/rBJo37HjtZpeY4U28ohob5R4QRBcynOiq7i5KFRrguqKCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XE6L/vp0NEr8MpHfWFpSNVehZQ6DXOjhUzKV3GFx5is=;
 b=V0x9k1tM2Gq45LVmTkwILgsxrx1H8feR+JEKyD85gfcIGJxG5aH2DyTaJsnav6CTgJJpvdgzm/JbXEUweBYVUw26IiyGlRjsg7gU6YeqGT9V8vJiVFxWjj8sz6dQX+i+OiHr10WhNoIrtJHkOykPKUMTpo6DwTDbbD9GaM7AGIU=
Received: from BLAPR03CA0009.namprd03.prod.outlook.com (2603:10b6:208:32b::14)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 09:13:08 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::fe) by BLAPR03CA0009.outlook.office365.com
 (2603:10b6:208:32b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 09:13:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 09:13:08 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 04:13:04 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 15/15] iommu/amd: Add SVA domain support
Date: Mon, 11 Mar 2024 09:08:43 +0000
Message-ID: <20240311090843.133455-16-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311090843.133455-1-vasant.hegde@amd.com>
References: <20240311090843.133455-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 60025bce-a8b8-4cd6-7d16-08dc41ab7800
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oO6cTsybQ9ATdNRTsR0uiXhp8e0zTUFnotbk5D0Pb9jm57CXo3poaFj8RnfikhaOLc4S6ek8INwJDZwtkcm2+gtiuTqpx03etSR8F9AMMx15Xcke1fIox9SRBZEZ5i8vJX9P4FnOT0LpeWbtY00EgWQ/9qrWuFOsw61y6JouqLZCw8M0356n6h9HehX7QuJONKckEQWIZ1DiHs2Xj3/Dg2PSJNwa3WmT8oep+75vClHtqXgaTNBIWXulvbjr/MxoEA7JnboVBhNpsAOiuKnKQoM/X3LcUf4szvyYMdnDONBxszNHg/m60vzhPWAdnIPZJQ4aemaT6zOdtrzQ8PxiFepwGRaGCTMfjcivAEDKUNaD0zunsv1CSvwVcjOJOX6glEELpVXYpmwlGdwQCD0VX36wuYxu3ru3IOYGEVsZpaIWggsWdE2FKKILCrFpJpWkf8epuVGF37GjBSSq9JbSqpavQH2zbKJlTHvFrSVCQnh07f+ijsD5e02PlhKDItGt9EbPwwYxf08zS3Diy2t7dlmWosupEphhUyzskh8sLzwcP5qy1mrQjocUeFOpT1+0CfCQAQWreAYu4lDIrh2JSLktM7zaIRvq+hGFnPrZv/xKHX07Q15i31lAPEIhVpjQ7FjjKEW4owUMbycX3DtArbS2UunqWjRcDCR7O5tPD3IUnKKnZKrYRRuSE+LabI4WT05fxukIF7LFXMgy08N8N7ymXNnfWjwa5jxMX51i8TnNJ0hgWb+IemMv6OouGqgM
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 09:13:08.7966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60025bce-a8b8-4cd6-7d16-08dc41ab7800
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942

- Allocate SVA domain and setup mmu notifier. In free path unregister
  mmu notifier and free protection domain.

- Add mmu notifier callback function. It will retrieve SVA protection
  domain and invalidates IO/TLB.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h       |  5 ++
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 10 ++--
 drivers/iommu/amd/pasid.c           | 80 +++++++++++++++++++++++++++++
 4 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 23e7449f16b8..8ca434b8a885 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -45,6 +45,11 @@ extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
 /* Protection domain ops */
+struct protection_domain *protection_domain_alloc(unsigned int type);
+void protection_domain_free(struct protection_domain *domain);
+struct iommu_domain *amd_iommu_domain_alloc_sva(struct device *dev,
+						struct mm_struct *mm);
+void amd_iommu_domain_free(struct iommu_domain *dom);
 int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
 			    struct device *dev, ioasid_t pasid);
 void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index ed9971cd3f0e..2b76b5dedc1d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -586,6 +586,7 @@ struct protection_domain {
 	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
 
+	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
 	struct list_head dev_data_list; /* List of pdom_dev_data */
 };
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 82fdfd68cf6d..9df2695a0f46 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2277,7 +2277,7 @@ static void cleanup_domain(struct protection_domain *domain)
 	WARN_ON(domain->dev_cnt != 0);
 }
 
-static void protection_domain_free(struct protection_domain *domain)
+void protection_domain_free(struct protection_domain *domain)
 {
 	if (!domain)
 		return;
@@ -2320,7 +2320,7 @@ static int protection_domain_init_v2(struct protection_domain *pdom)
 	return 0;
 }
 
-static struct protection_domain *protection_domain_alloc(unsigned int type)
+struct protection_domain *protection_domain_alloc(unsigned int type)
 {
 	struct io_pgtable_ops *pgtbl_ops;
 	struct protection_domain *domain;
@@ -2343,6 +2343,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	switch (type) {
 	/* No need to allocate io pgtable ops in passthrough mode */
 	case IOMMU_DOMAIN_IDENTITY:
+	case IOMMU_DOMAIN_SVA:
 		return domain;
 	case IOMMU_DOMAIN_DMA:
 		pgtable = amd_iommu_pgtable;
@@ -2462,7 +2463,7 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	return do_iommu_domain_alloc(type, dev, flags);
 }
 
-static void amd_iommu_domain_free(struct iommu_domain *dom)
+void amd_iommu_domain_free(struct iommu_domain *dom)
 {
 	struct protection_domain *domain;
 	unsigned long flags;
@@ -2830,6 +2831,7 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
+	case IOMMU_DEV_FEAT_SVA:
 		break;
 	default:
 		ret = -EINVAL;
@@ -2845,6 +2847,7 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
+	case IOMMU_DEV_FEAT_SVA:
 		break;
 	default:
 		ret = -EINVAL;
@@ -2857,6 +2860,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
 	.domain_alloc_user = amd_iommu_domain_alloc_user,
+	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
 	.probe_device = amd_iommu_probe_device,
 	.release_device = amd_iommu_release_device,
 	.probe_finalize = amd_iommu_probe_finalize,
diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index c96384ae3442..04beb2217d93 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -56,6 +56,49 @@ static void remove_pdom_dev_pasid(struct protection_domain *pdom,
 	}
 }
 
+static void sva_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
+				    struct mm_struct *mm,
+				    unsigned long start, unsigned long end)
+{
+	struct pdom_dev_data *pdom_dev_data;
+	struct protection_domain *sva_pdom;
+	unsigned long flags;
+
+	sva_pdom = container_of(mn, struct protection_domain, mn);
+
+	spin_lock_irqsave(&sva_pdom->lock, flags);
+
+	for_each_pdom_dev_data(pdom_dev_data, sva_pdom) {
+		amd_iommu_dev_flush_pasid_pages(pdom_dev_data->dev_data,
+						pdom_dev_data->pasid,
+						start, end - start);
+	}
+
+	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+}
+
+static void sva_mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
+{
+	struct pdom_dev_data *pdom_dev_data, *next;
+	struct protection_domain *sva_pdom;
+	unsigned long flags;
+
+	sva_pdom = container_of(mn, struct protection_domain, mn);
+
+	spin_lock_irqsave(&sva_pdom->lock, flags);
+
+	/* Assume dev_data_list contains same PASID with different devices */
+	for_each_pdom_dev_data_safe(pdom_dev_data, next, sva_pdom)
+		remove_dev_pasid(pdom_dev_data);
+
+	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+}
+
+static const struct mmu_notifier_ops sva_mn = {
+	.arch_invalidate_secondary_tlbs = sva_arch_invalidate_secondary_tlbs,
+	.release = sva_mn_release,
+};
+
 int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
 			    struct device *dev, ioasid_t pasid)
 {
@@ -120,3 +163,40 @@ void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 
 	spin_unlock_irqrestore(&sva_pdom->lock, flags);
 }
+
+static void iommu_sva_domain_free(struct iommu_domain *domain)
+{
+	struct protection_domain *sva_pdom = to_pdomain(domain);
+
+	if (sva_pdom->mn.ops)
+		mmu_notifier_unregister(&sva_pdom->mn, domain->mm);
+
+	amd_iommu_domain_free(domain);
+}
+
+static const struct iommu_domain_ops amd_sva_domain_ops = {
+	.set_dev_pasid = iommu_sva_set_dev_pasid,
+	.free	       = iommu_sva_domain_free
+};
+
+struct iommu_domain *amd_iommu_domain_alloc_sva(struct device *dev,
+						struct mm_struct *mm)
+{
+	struct protection_domain *pdom;
+	int ret;
+
+	pdom = protection_domain_alloc(IOMMU_DOMAIN_SVA);
+	if (!pdom)
+		return ERR_PTR(-ENOMEM);
+
+	pdom->domain.ops = &amd_sva_domain_ops;
+	pdom->mn.ops = &sva_mn;
+
+	ret = mmu_notifier_register(&pdom->mn, mm);
+	if (ret) {
+		protection_domain_free(pdom);
+		return ERR_PTR(ret);
+	}
+
+	return &pdom->domain;
+}
-- 
2.31.1

