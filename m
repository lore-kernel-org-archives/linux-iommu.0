Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774EC6D1C2
	for <iommu@lists.linux.dev>; Thu, 21 Dec 2023 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xxGqjkyL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3RRaiHdwY9yYIpkmepgnXYGeCpREO/G13Gc9SsCKKP0RXJl1OUrceEnl3UQgAZRRye9H5OlskRLzD+AQnnvJwKn4d0K43nLTJlOZWXzLLoy1b8eK4i+qe7bkOXzW/9GuH4b0n/e0enMQc8fTZ8HC/RxMG82jV+x247WQ5fF1TH/AciCn4ZeMk4ZMT/f9bNwEQs8rW3BJjgLpUTkcibXEvTv+3vkvYU8bagl3dbCoHF1/iB0v4ou7D38fnuZHA1ntw/oY6yqIJS4yfBsuJf4yUUPX8JpSAKuWczCk/UyMA7KLjO3tTI1sMzt7g55KvRB71bLl9c8m27CYOv/BM0Z6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOSjCW27lsG00xEymIJ465E8R377+0DKtngYAdKus/A=;
 b=P2Fi8kKMMTKw16Jk7QfGD0ucXd3waWlIBGic2Iu20HOnunLKjyWTxq9xJ+RawZdsKX8S++fFva+7hQaCxQ0nQNLPMGYivCbx1eigiYCq6iIE/RHSZh+dYFnDlROKBOpRGClUxJifjKChqUyH9ZIbUr33KRucEBwb5wc9k8r2gGKlF1iw4xUWk5O/JRz6RnTs9cOacvTVOU6xSa+i+M4ZOlSJJsNwFFtU96rEBbtaVr8I4o6/86hZKPfe+Wt/+nkb5y8hkzJU1bDlH4o/OMzLuOcDx6ImlPgdrFVJ1ykPbMqqx/iG72Zc5YEUwniTDiI3dVLOTb5Kl8hpZGizyeHXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOSjCW27lsG00xEymIJ465E8R377+0DKtngYAdKus/A=;
 b=xxGqjkyLPSREm97Hj/eVIPJsPn6WbHYn9Oi3EddZ5cZYDJSlDFZJ4XUZsO2Qt4Pf1iHlSyRlWsFkliro2janp1wQZ/IVvsmtWA5MqHd+ednTOYOX3BHZL8dYx89p96JTKncGfRepwZl4HhE7+yy72eMRfd/icWQwuiSFBVPo6DQ=
Received: from MW4PR03CA0336.namprd03.prod.outlook.com (2603:10b6:303:dc::11)
 by SJ2PR12MB8876.namprd12.prod.outlook.com (2603:10b6:a03:539::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 11:20:24 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:303:dc:cafe::bb) by MW4PR03CA0336.outlook.office365.com
 (2603:10b6:303:dc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21 via Frontend
 Transport; Thu, 21 Dec 2023 11:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 11:20:24 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 05:20:21 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 14/14] iommu/amd: Add SVA domain support
Date: Thu, 21 Dec 2023 11:15:58 +0000
Message-ID: <20231221111558.64652-15-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221111558.64652-1-vasant.hegde@amd.com>
References: <20231221111558.64652-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|SJ2PR12MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: be0e9fd5-5bf0-4807-cec0-08dc0216d3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dd+AARbOWlYNljVJAZSs+Tz+pi9ZpacfMlcQKvGJ2Qqe/7xH5OAmnvECnvoksk2jiygd7VlyvvTA5Wcv8eMU+xoQaVlyh7OxekotimDd89v8d46cyu28zUKaEf22H1Z0oJshDrtYg23Yo9vDXSfnMZOXHtTMjm2WuXIch6FyHJ+idg+iUZ6XR4rMeFBRxvhop06yJ8TTsPqhbUA43tjOjpQomqzAOOEW6MZfS9qxEEHpRRrqvROSQL8jZ5vJ2pdXab6sU3kqVE1ebvlbKVUt1fbyfa3Kd8ISibQepLhpJLILablDHwSdh9jOykMNeRDXSG48uwUbSjmuxSz13ImwNdoPmshJUQxNEfyt9cBMVSBjt4D3+8OndocHvXpHfxBoDyoW3NH06mkxvkJJN0lL8sl99RzHlRgpwguvOWfqjY6f+ADP14yQIffiKcXWeTQvF8b618QzInPBfIqgakf2F2F4bsxtqHuzTf0qnbRXGv/6UxfjOpYin5TlFgzUTLhRhl19dRZxtrZ3Gn05/JXVLbAgJJ0FPZVlUFt1YMHox5ESVvArvv+UusHUKIoC9Al1ga2QsI22NIKTaO2r1cFROWgx19I9SSyZaOgvGWeT1mBbHP96o3KicVPDNpXvbSddtVkqjBM0WSwepggC2IwV0OlRrS8AY+gfhUB41ox1Cds2n0kxeiAGJmWpV6P+xmD//R2R48fVzg+w4yvTdHW7BnvYwnCxAJxKXDx0xtDYdShNaNWhvnbOkAK8sEfFjs4N5iCFdG5/zxqfAAWTry/4yw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(47076005)(86362001)(36860700001)(356005)(82740400003)(41300700001)(478600001)(81166007)(4326008)(2616005)(40480700001)(44832011)(8676002)(8936002)(5660300002)(1076003)(26005)(16526019)(426003)(336012)(36756003)(70586007)(70206006)(54906003)(110136005)(316002)(6666004)(7696005)(2906002)(83380400001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 11:20:24.6712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be0e9fd5-5bf0-4807-cec0-08dc0216d3f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8876

- Allocate SVA domain and setup mmu notifier. In free path unregister
  mmu notifier and free protection domain.

- Add mmu notifier callback function. It will retrieve SVA protection
  domain and invalidates IO/TLB.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  5 ++
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 10 ++--
 drivers/iommu/amd/pasid.c           | 84 +++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index c21e7d64ad88..1bb93671aa76 100644
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
index 9662a56a3a83..b60b1b0f780e 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -588,6 +588,7 @@ struct protection_domain {
 	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
 
+	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
 	struct list_head pasid_list; /* List of pdom_pasid_data */
 };
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7aea652cebd8..87ea60160dc8 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2278,7 +2278,7 @@ static void cleanup_domain(struct protection_domain *domain)
 	WARN_ON(domain->dev_cnt != 0);
 }
 
-static void protection_domain_free(struct protection_domain *domain)
+void protection_domain_free(struct protection_domain *domain)
 {
 	if (!domain)
 		return;
@@ -2321,7 +2321,7 @@ static int protection_domain_init_v2(struct protection_domain *pdom)
 	return 0;
 }
 
-static struct protection_domain *protection_domain_alloc(unsigned int type)
+struct protection_domain *protection_domain_alloc(unsigned int type)
 {
 	struct io_pgtable_ops *pgtbl_ops;
 	struct protection_domain *domain;
@@ -2344,6 +2344,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	switch (type) {
 	/* No need to allocate io pgtable ops in passthrough mode */
 	case IOMMU_DOMAIN_IDENTITY:
+	case IOMMU_DOMAIN_SVA:
 		return domain;
 	case IOMMU_DOMAIN_DMA:
 		pgtable = amd_iommu_pgtable;
@@ -2463,7 +2464,7 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	return do_iommu_domain_alloc(type, dev, flags);
 }
 
-static void amd_iommu_domain_free(struct iommu_domain *dom)
+void amd_iommu_domain_free(struct iommu_domain *dom)
 {
 	struct protection_domain *domain;
 	unsigned long flags;
@@ -2831,6 +2832,7 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
+	case IOMMU_DEV_FEAT_SVA:
 		break;
 	default:
 		ret = -EINVAL;
@@ -2846,6 +2848,7 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
+	case IOMMU_DEV_FEAT_SVA:
 		break;
 	default:
 		ret = -EINVAL;
@@ -2858,6 +2861,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
 	.domain_alloc_user = amd_iommu_domain_alloc_user,
+	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
 	.probe_device = amd_iommu_probe_device,
 	.release_device = amd_iommu_release_device,
 	.probe_finalize = amd_iommu_probe_finalize,
diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index cf14ddbc2c4f..7e353189dac6 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -120,6 +120,53 @@ static void remove_pdom_dev_pasid(struct protection_domain *pdom,
 	}
 }
 
+static void sva_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
+				    struct mm_struct *mm,
+				    unsigned long start, unsigned long end)
+{
+	struct pdom_pasid_data *pasid_data;
+	struct protection_domain *sva_pdom;
+	struct iommu_dev_data *dev_data;
+	unsigned long flags;
+
+	sva_pdom = container_of(mn, struct protection_domain, mn);
+
+	spin_lock_irqsave(&sva_pdom->lock, flags);
+
+	list_for_each_entry(pasid_data, &sva_pdom->pasid_list, pdom_link) {
+		dev_data = pasid_data->dev_data;
+
+		amd_iommu_dev_flush_pasid_pages(dev_data, pasid_data->pasid,
+						start, end - start);
+	}
+
+	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+}
+
+static void sva_mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
+{
+	struct pdom_pasid_data *pasid_data, *next;
+	struct protection_domain *sva_pdom;
+	unsigned long flags;
+
+	sva_pdom = container_of(mn, struct protection_domain, mn);
+
+	spin_lock_irqsave(&sva_pdom->lock, flags);
+
+	/* Assume pasid_list contains same PASID with different devices */
+	list_for_each_entry_safe(pasid_data, next,
+				 &sva_pdom->pasid_list, pdom_link) {
+		remove_dev_pasid(pasid_data);
+	}
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
@@ -191,3 +238,40 @@ void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 
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

