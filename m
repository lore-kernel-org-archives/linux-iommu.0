Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2B22C1B1
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 11:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478551; cv=fail; b=CjLJ6fX0whgQRECFsWCTglPBf6ZHWDK5uVQOXoipl14QUUB0MKTjqrdtKLdTTXsTIj256isaTI1iePiEja5Uq1cYqJoKrOdj92Avi99ir+/eKRmJUOAw+D4DLe341rWasr+Q3Grh+6qGREGQsd7irddgoR0cHdRVWzwTxdyp/N0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478551; c=relaxed/simple;
	bh=x9QHpb6w4BEc/3zsu3a8Bspax4YOYG5lG4lwH9pVq0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q0j4lPxSbHUXwjUHESfotfkyiu8CA9/5wPFr5mhpwe/lePHone1fmZ5ygFLeWPPvi0liULZUeDSFrJIigGkAtaoVqacpKaLFJjjUFEv0xbRHMswRtBKnjctWTIlmFwcMbEX8oFHfdbz7wyuvsPQCHdo62x4QnSQz3/TDBr+n2as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CQa/UVv1; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CQa/UVv1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCTfiYYPg0ypimsevHSfd3G+U7dWAcpmc97amPH6tcaSXSjArAUZSrEfIJ0qsHoCCjNcQn3nEmtFGbXTfSGoYHl+OrBSXd7/0XBzb3ig3mRUp6tBnPH3zhoJ9EDHgl77LC5jNBt35ENNTiLc2LKpy8lm6J5YJt1NTM4M8AxlLlEwShYu90xKxlbeW//3J6ms26b4RwU4kuU+2YlpuIe06vg2WZK7c6g3MNGVOcC5vrP3zBrik1p5O0g+UXUPvBTG5OFSZAFmyGYXaVvobxv4gqetnPyhFoa+DgZgdrldawA/KIBOkY6242Y9fHNfigp/a4yZV4nQwrIVpBJ3DJsMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRRF4/bAzxyXlibAVERrDe7g6Cy2aMYZgXFFSJyuFHA=;
 b=kxcD/wLBFaT/55cPRQvKmKdT/xUYi1L5P/9vFhedo5JLDyQNV5fj+BqAq+344hmbr2I3jXE4ymIFkiKocFmFtFJv9mgLhgpA2BOX2HlT8bDW4PAIywMzFZY6fuFW4zOC5ITD1OBFN23mg0ev9qjV6VPiuZNL1eowSfrfXUngm/sDA4wWFOP9XeGKRLmH4qY/oJDKtY8p36UREJnsSnzegr52do4/82MVywdpJqkPeQFkb9MTpnlVp+3cZAfIhzxDfhkcyfx5frNfgbp8aKNP0+z6KzoplKA3klJ41KsZhHo3oIRbAOwrWUzFuljp9Z9v5f2PA84JQPu4E8BJ7d+7ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRRF4/bAzxyXlibAVERrDe7g6Cy2aMYZgXFFSJyuFHA=;
 b=CQa/UVv1jABHjMS5UbIu6qDPGRZnms3izfo7ckDgCgxnL4XUngpBFuzcCC1NMX1YIOyfvmy61L3tvIuLRJsIDww/mQ6FOLWdwm+YjjZlJwc9v9/6J5ljYUNTQ742S7oKuxESPHoAWxocSk549LB195MXYsV/GyUBP518JduGr1k=
Received: from MW4PR03CA0029.namprd03.prod.outlook.com (2603:10b6:303:8f::34)
 by DS0PR12MB9348.namprd12.prod.outlook.com (2603:10b6:8:1a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.12; Fri, 9 Feb
 2024 11:35:46 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:303:8f:cafe::df) by MW4PR03CA0029.outlook.office365.com
 (2603:10b6:303:8f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Fri, 9 Feb 2024 11:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 11:35:46 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 05:35:42 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 15/15] iommu/amd: Add SVA domain support
Date: Fri, 9 Feb 2024 11:29:30 +0000
Message-ID: <20240209112930.63663-16-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209112930.63663-1-vasant.hegde@amd.com>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|DS0PR12MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: 090109d5-6ef9-45e7-9a02-08dc296341ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X0024Hi1korryPKHxgmkHI+l5zLGREWRrD3tILYXSEFwX3okBCyoVZgReFVsnT974J+RHwy1nk32jDUqI3oUqPj/8T6xXpDWdsN5cOke/po9vgHLwxAop/VutLgy7wd9oIGS4dgJgvpIF8Vq9ngn2HpxSC6FPMC2V4LqcAXoip9PPsKrT6mn7NnQwP4ZKm4I9S6R1eg3s+iaoXTf4du+BswrwBC95aRWFX+rPH8LHhm2ZWeR08Jdsmx6u26Wst6BrPvCpE7maYEOvGvZzWrkERZX1M7T7vrp/fmQdczxVicwEXjkf5JJSTPUDNpGBuXHxwlQdvceIK6sKsIFzajdI+4kdys0Wr1icMnQBUO0ejvsI++jQuaj4+WofdWfWfdWMElM1U1M3YQ5YyIC90sMwrPzG3d7UrJcDc0oPsyrYV4aBOUwUIKKspv7RiaatbZB0peZMOQA6W48LUTUFOks0QouL2xvn+QLlSOSSkhI/szU4/dZbhqPCvrSWKa6p2mufaDwYv1YsEMJ7MDD+TgWhUUejIXKCP8nVBsQUOo/a0P0BprNfjdfeGIPv3L0o2Fkn7Zi3lh1beoenSQffuBWo7Z5tlXJf1RvlYKegzqjya8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(44832011)(5660300002)(82740400003)(2906002)(81166007)(86362001)(356005)(16526019)(26005)(7696005)(6666004)(426003)(336012)(83380400001)(1076003)(2616005)(110136005)(316002)(54906003)(70206006)(8676002)(8936002)(70586007)(4326008)(478600001)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 11:35:46.1793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 090109d5-6ef9-45e7-9a02-08dc296341ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9348

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
index ceecc18279ab..5f90082316b5 100644
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
index 1ae2a9b3e383..1c5ee8ebab49 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -594,6 +594,7 @@ struct protection_domain {
 	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
 
+	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
 	struct list_head dev_data_list; /* List of pdom_dev_data */
 };
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 36ae01d53bfa..f46608ddd13d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2283,7 +2283,7 @@ static void cleanup_domain(struct protection_domain *domain)
 	WARN_ON(domain->dev_cnt != 0);
 }
 
-static void protection_domain_free(struct protection_domain *domain)
+void protection_domain_free(struct protection_domain *domain)
 {
 	if (!domain)
 		return;
@@ -2326,7 +2326,7 @@ static int protection_domain_init_v2(struct protection_domain *pdom)
 	return 0;
 }
 
-static struct protection_domain *protection_domain_alloc(unsigned int type)
+struct protection_domain *protection_domain_alloc(unsigned int type)
 {
 	struct io_pgtable_ops *pgtbl_ops;
 	struct protection_domain *domain;
@@ -2349,6 +2349,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	switch (type) {
 	/* No need to allocate io pgtable ops in passthrough mode */
 	case IOMMU_DOMAIN_IDENTITY:
+	case IOMMU_DOMAIN_SVA:
 		return domain;
 	case IOMMU_DOMAIN_DMA:
 		pgtable = amd_iommu_pgtable;
@@ -2468,7 +2469,7 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
 	return do_iommu_domain_alloc(type, dev, flags);
 }
 
-static void amd_iommu_domain_free(struct iommu_domain *dom)
+void amd_iommu_domain_free(struct iommu_domain *dom)
 {
 	struct protection_domain *domain;
 	unsigned long flags;
@@ -2836,6 +2837,7 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
+	case IOMMU_DEV_FEAT_SVA:
 		break;
 	default:
 		ret = -EINVAL;
@@ -2851,6 +2853,7 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 
 	switch (feat) {
 	case IOMMU_DEV_FEAT_IOPF:
+	case IOMMU_DEV_FEAT_SVA:
 		break;
 	default:
 		ret = -EINVAL;
@@ -2863,6 +2866,7 @@ const struct iommu_ops amd_iommu_ops = {
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

