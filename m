Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC4FBA2B
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563578; cv=fail; b=n1PSCRh4rBBwWMMii9aAsa9rfEwovxXCTzMvXOwMzX8a4o0yxw1ehJiaQyIPcXidk+1I8jV0fAHJpcMTAAMjH8pWvQwve5iri72tJcro3EyoEdQBCgTf7a7rQXXBhTi27RKJbhvT4lTNdLkMa+DdAO+jjB0YHeD7cVdM4h4S+m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563578; c=relaxed/simple;
	bh=6f0VvLb0HFhOPL/e2Y7vXgOcFrrrIQQHmHrg+MEOzsU=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=ddDsHGetjwmtIoWaw186adlwGkTJfde9EftX7dDuibEXX0QC4CBvmp+w7sJzCa+gutU5saeB4RMp7Htfn/ea7aysLQ2DIOv/+f+Vg8YCKyGOpJSG72zS0IFG8xxnkklQfaGA7I7A3jkzhA8oTxKzQ99sv6CglzkBo4bTwetqtu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AF4K6ktq; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AF4K6ktq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBT/m0e4DvY2wbY1HydVzkL8V7GK+c0ga1NYs7t5WjgsDYFiQKZx/lwkc2LAVzsbVWbp4YlZ5ke+QIh31DUcvZNCTps4dN57K5W45nuZvVMMLOU5PCQ/4Y/hiWUCh7kN2ItiEUkHnMDqpmxS2DAuiOJV1FpLzagJn+dm0IJxPZgrx6bmwbmvQJLWQaszV8P8SV/YOb77zc0mm2HR/+S5tte6ulwYhwTJAUfKZqIsBRVlTYBfpevmFo5wY4Z9kGRK7nsAFe+nvwOD6q5IoW6rzNl1V5cgHUrE5GgK25HZ5dz2s4qhJP5cZLxL96H0t/Z6vY9J+p6bs4YBXOCt2uaAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91P46YSg+DFFCSrQJdE20Ig2mLvE8xSblNHUrMJcap0=;
 b=lLOLCG/1v1iHyCZhdoluq4c6+8x1sVUQeFnX2owBMSk/A9aZ69u1QO0VxLV8aST8i1VdL6GPtRHyn4A16ZKRkzHmBvlluvT8VC2zCGvHE/rZeHipnegOcYef/c5ZVQHX7pi5WMLJBqg9tvG080TGYhjml2tdbflHO681PwT1Ba1H8dh6AShSBxT4Kp41izF021l/8/IIeO9dRsohDTd/HCwmLmCeFqFGoKC1xiIZ7GY3Lel4vd9QpMabGDffG5ymki+l6VdEivzd7xLBxfwMoDK/It3XZPtlIHOGc0BTg2Qp95WurVZKhNA+CGPMqjxfuUPAA4UfZq+l3LEqng8IfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91P46YSg+DFFCSrQJdE20Ig2mLvE8xSblNHUrMJcap0=;
 b=AF4K6ktqB54UCxG4/9mkA5zh7R6sfwIWbM9+X1EHtQw6hmHH3RRkFsNA4Y2DXX68EOvLkqMuTNSwgAGXMCgcfCia3Jl2nNkxtwHBocpzsXZ8ZnnL8Dvv9LHPd0Y197Vc/FznFmhWQJHtkDow0KE/UmIpXLcVmfykr8hHFkazQuE=
Received: from DM6PR05CA0058.namprd05.prod.outlook.com (2603:10b6:5:335::27)
 by IA1PR12MB8495.namprd12.prod.outlook.com (2603:10b6:208:44d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 07:39:34 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::a1) by DM6PR05CA0058.outlook.office365.com
 (2603:10b6:5:335::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.8 via Frontend
 Transport; Thu, 18 Jan 2024 07:39:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:39:33 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:39:31 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 14/14] iommu/amd: Add SVA domain support
Date: Thu, 18 Jan 2024 07:33:39 +0000
Message-ID: <20240118073339.6978-15-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118073339.6978-1-vasant.hegde@amd.com>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|IA1PR12MB8495:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e5342e-1b58-4551-a162-08dc17f89d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OXLf0BomYd2Bt+IuAaTmJJWBLz4kn2P0KwtwCGx4xADAkmMQzHQlWcUMnykHj1ZZnDY6+PJ+pcnWSCw4pzCNTqtquSUnWXdbY/vvhgAwF9IYbf41j5AJUZsS/icIwfBnIlOKktAOVz4Ch1PQFI310nkOfbvcWP8mgZxh0IId/WUaIxVfgrRheP14MQKduqZ/PUawFTXmx9zXXLNy4zv5Mxh09bURhNZqe6uHIYiJZPq91lGC34U0j4k21PrqDP+QVj3e2cbA3rzsZPTzKxl3eTvbclwE7lXRUc9dpOaFb2mOhnwmBRsb3CaynTExo8HukxJ2bn7fCeqvXD4GnfZ6CxjQWRwCxKK4DfsZTAgceUe3CrL2Z4PrKNCxMmvEPDSdmTzFNYVjqMmbSaiQfd8shcnPxCXoV5Nve2SaOFs9f76xGQfFdoJi8odhlGcDO24vUpJg+wbepbXS4dyohcthXMw056Bsddh5EfMVwpJxHREWjUwDWIrfFCGeC2D3Iuhqf6JrDn+qu7Wnz5v6jLQ/dcz8XfzvRaZ3OPDwdkILUQvv7Kzvyf3Tom3UwqXSwCrzUJQ8GjH4gbbAreofkjk1XyuV2Qmuod0ciGDj05rYZepCpu3vhy7gmLlJcTS8/SDC62cc6bf/4QVqy0POwzeBqAqPfifbb4FFLNbSxTnZC6O3XdrbzcvzhqFrtrcrnFTKYegzzpFCDY+smZNKEznPajM6cJX6fdpA6ClOTKOTX1VXCGpLDCJrrrKNv2LHJp5fE2SIh+cUmhzskKPxJXG0PA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(41300700001)(26005)(336012)(16526019)(83380400001)(426003)(86362001)(36756003)(82740400003)(81166007)(356005)(44832011)(8936002)(8676002)(4326008)(5660300002)(7696005)(1076003)(2616005)(47076005)(36860700001)(54906003)(70586007)(70206006)(316002)(110136005)(2906002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:39:33.9719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e5342e-1b58-4551-a162-08dc17f89d70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8495

- Allocate SVA domain and setup mmu notifier. In free path unregister
  mmu notifier and free protection domain.

- Add mmu notifier callback function. It will retrieve SVA protection
  domain and invalidates IO/TLB.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  5 ++
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 10 ++--
 drivers/iommu/amd/pasid.c           | 80 +++++++++++++++++++++++++++++
 4 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1344b48caa46..3008503513df 100644
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
index 7609fc1c5aee..722120f95647 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -594,6 +594,7 @@ struct protection_domain {
 	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
 
+	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
 	struct list_head dev_data_list; /* List of pdom_dev_data */
 };
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 703f2c081ed0..4280d97fa6ba 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2251,7 +2251,7 @@ static void cleanup_domain(struct protection_domain *domain)
 	WARN_ON(domain->dev_cnt != 0);
 }
 
-static void protection_domain_free(struct protection_domain *domain)
+void protection_domain_free(struct protection_domain *domain)
 {
 	if (!domain)
 		return;
@@ -2294,7 +2294,7 @@ static int protection_domain_init_v2(struct protection_domain *pdom)
 	return 0;
 }
 
-static struct protection_domain *protection_domain_alloc(unsigned int type)
+struct protection_domain *protection_domain_alloc(unsigned int type)
 {
 	struct io_pgtable_ops *pgtbl_ops;
 	struct protection_domain *domain;
@@ -2317,6 +2317,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	switch (type) {
 	/* No need to allocate io pgtable ops in passthrough mode */
 	case IOMMU_DOMAIN_IDENTITY:
+	case IOMMU_DOMAIN_SVA:
 		return domain;
 	case IOMMU_DOMAIN_DMA:
 		pgtable = amd_iommu_pgtable;
@@ -2436,7 +2437,7 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	return do_iommu_domain_alloc(type, dev, flags);
 }
 
-static void amd_iommu_domain_free(struct iommu_domain *dom)
+void amd_iommu_domain_free(struct iommu_domain *dom)
 {
 	struct protection_domain *domain;
 	unsigned long flags;
@@ -2804,6 +2805,7 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
+	case IOMMU_DEV_FEAT_SVA:
 		break;
 	default:
 		ret = -EINVAL;
@@ -2819,6 +2821,7 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
+	case IOMMU_DEV_FEAT_SVA:
 		break;
 	default:
 		ret = -EINVAL;
@@ -2831,6 +2834,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
 	.domain_alloc_user = amd_iommu_domain_alloc_user,
+	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
 	.probe_device = amd_iommu_probe_device,
 	.release_device = amd_iommu_release_device,
 	.probe_finalize = amd_iommu_probe_finalize,
diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index 6b9d1917aa4c..f47feacfe92a 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -121,6 +121,49 @@ static void remove_pdom_dev_pasid(struct protection_domain *pdom,
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
@@ -189,3 +232,40 @@ void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 
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

