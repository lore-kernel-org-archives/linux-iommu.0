Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D6100AE
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:18:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwukXQ1A2aiqCWOKJgCeUgL6o8eILguFSBKThk8yuxZNY4g8H4YkTKNuuHdubFOWbCSltsIV7X7aagzsOBEpvacTeaafKg958F5YfDII6HpUxN9q0fAkHAbuOyeJyYueOA1sjoeRb8xB0J/brJJWGTFaFkpkOvFckxuWOKJH7Qyp29WMdKkD5M2K8fmN4gTyw5JFd5QdOqskFZGtgMm3ZR5ABnP/xMsDnps53xz1EBhHLaZf2UW4ULkvOd3FLMCy/vrMj2Tv4ypCM4eRLVXNdTcVopfTWDp6DdqmoKU9+jWyRil8JmWFfVmRWNe8dasBShCSkLFofxHTvwkdVGZxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DOBJlnruHkvGH381SJtjZ95ta2T//zsxpZZaOGDcog=;
 b=fqd+NVUdFY4qBGjKF1iuU29QsP+N4pI7tpc5b9iAgnIlkQHRQeYqQ4fOuG5tCbuO51XgJ0TaaDdnqmXrRNKZWrTwfqO6KA0EwwdyaziItqXIFGVjGyNJSkRn4hQCdUC/uN9/w9hf4j13up1l9T/QVrjW+hItSaoi4X+7ma/5sK0iqAQxnpcEC8QypY29fZit/6EaQ77Ytb8QzUzjpWj2AfeRtlY6auE1dBH5h+By7pc+YP+NTWwCi5yYQH53r7CqYJFQ/OEMK3JvAdyCh8BQ5p52X/zW+Fwai1V81AVTe2IDFOgJIqWT5SNBRJsccIGLSzZum9bBTM8C9nM5mxqjGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DOBJlnruHkvGH381SJtjZ95ta2T//zsxpZZaOGDcog=;
 b=SkgVzTm51jRBzpxFvbAkAsVQAfOq3HkaG9rMBp4TFlvjhfmoYytg654TnoGlkh0Rd6tofbJL5ucgfckBqZpYshp9UAvKQEpM4h+BxckUjg1QQLkXRhT89Jf2d/j2bgOK/iiBCBftk1wUEEyAyoEp58L1/UMoY6QTSkWdL3dt/Zs=
Received: from DM6PR21CA0001.namprd21.prod.outlook.com (2603:10b6:5:174::11)
 by DM6PR12MB4090.namprd12.prod.outlook.com (2603:10b6:5:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 14:18:40 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::95) by DM6PR21CA0001.outlook.office365.com
 (2603:10b6:5:174::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.7 via Frontend
 Transport; Wed, 12 Jul 2023 14:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 14:18:40 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:18:37 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 11/21] iommu/amd: Clean up and enhance protection domain flags
Date: Wed, 12 Jul 2023 14:15:06 +0000
Message-ID: <20230712141516.154144-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712141516.154144-1-vasant.hegde@amd.com>
References: <20230712141516.154144-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT013:EE_|DM6PR12MB4090:EE_
X-MS-Office365-Filtering-Correlation-Id: d632bfc6-5baf-4696-c7b1-08db82e2e403
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DqTaIxDErWqN25QZC7rb5NaAoc+FW6FoAc3+Uy5iDlJm1MzPT8ajrYHjbMcWCdAxcehBROmjtAM0y5aNt1BpVOmJpfwEF2fbJiSDYFDm7pNMXC21tq2AHDcAHSP+NkHBNgG/CEVYa2CGnBzoKpA+CAxknjtuRF1KdUeWZb55Rh8WpMPwKhJX81drSGDQlpMfBE81I+oXRWOLUrvL2UvYsvfhMYQwhTGxcpWU+0NlKMlfpISRF4trRjBXMEpdSMElCod+Kz3H43GNJhc0kPjU8uY+h/pYaqUAT1eZUuuoonUcz0UIsh/E0HvJghRo3rQd1S5lFUal/UlODa1fUgOtv8x4gl22BD6CRoVm4QvdJC3oRD5eIHkyRcp0bybpTCbDKW1BgYlIRDKIod75FX2eN5+CWJSLYVXKh0SNSUt40byufI6z64pClFYpUMxOoXhZRsJdxG25Jkjit+Kym6Iy+tyBsIvD5r/MCNkCbj5/vSdnZqipzufrPZs9CeUWyDM//j+ElzStKBQl+EG2WvZzmN8nNIQF+NqDVA9w7m0uDLFuxq+ENcj8ndGZhoKmaJVr0IkRd+ccEyF7WodMlbfzV1ae/3joCtNuNRLv/u2AF9z/tA9Wndp8cFS+531l2moIloHPeYhy6V68UwEq4fn5j5IvpsUNK+wZzi23aqA2ke/CWx0MC4QdIHFdYkPUV3R2agcGu3RuANsmwsF1DcBvYTjTHygZm5HakQ90ufrOz2SP9lhuiYbnhcuEgDNzEDeMHL4Q+o5AL/5Co6nvws4dOw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(41300700001)(82740400003)(40460700003)(316002)(5660300002)(1076003)(26005)(36756003)(44832011)(8676002)(8936002)(83380400001)(426003)(82310400005)(86362001)(47076005)(36860700001)(16526019)(336012)(186003)(2616005)(2906002)(40480700001)(356005)(81166007)(54906003)(110136005)(6666004)(478600001)(70586007)(70206006)(7696005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:18:40.1636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d632bfc6-5baf-4696-c7b1-08db82e2e403
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4090

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

With IOMMU v1 and v2 page tables per domain, and the v2 table can
be used in various modes, keeping track of how a particular domain
is configured becoming cumbersome.

Enhance protection_domain.flags to keep track of how a domain is
configured. Also Remove unused flags, and rename them accordingly.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 14 +++++---------
 drivers/iommu/amd/io_pgtable_v2.c   |  2 +-
 drivers/iommu/amd/iommu.c           | 21 ++++++++++++---------
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 346c32343417..907af6e41ae9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -443,13 +443,11 @@
 #define MAX_DOMAIN_ID 65536
 
 /* Protection domain flags */
-#define PD_DMA_OPS_MASK		BIT(0) /* domain used for dma_ops */
-#define PD_DEFAULT_MASK		BIT(1) /* domain is a default dma_ops
-					      domain for an IOMMU */
-#define PD_PASSTHROUGH_MASK	BIT(2) /* domain has no page
-					      translation */
-#define PD_IOMMUV2_MASK		BIT(3) /* domain has gcr3 table */
-#define PD_GIOV_MASK		BIT(4) /* domain enable GIOV support */
+#define PD_FLAG_PT		BIT(0) /* Passthrough mode */
+#define PD_FLAG_V1DMA		BIT(1) /* DMA-API mode w/ v1 page table */
+#define PD_FLAG_V2DMA		BIT(2) /* DMA-API mode w/ v2 page table */
+#define PD_FLAG_GCR3		BIT(3) /* domain has gcr3 table */
+#define PD_FLAG_GIOV		BIT(4) /* domain enable GIOV support */
 
 /* Timeout stuff */
 #define LOOP_TIMEOUT		100000
@@ -891,8 +889,6 @@ extern unsigned long *amd_iommu_pd_alloc_bitmap;
 /* Smallest max PASID supported by any IOMMU in the system */
 extern u32 amd_iommu_max_pasid;
 
-extern bool amd_iommu_v2_present;
-
 extern bool amd_iommu_force_isolation;
 
 /* Max levels of glxval supported */
diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index c17cda83bca5..0b7bab01f006 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -360,7 +360,7 @@ static void v2_free_pgtable(struct io_pgtable *iop)
 	struct amd_io_pgtable *pgtable = container_of(iop, struct amd_io_pgtable, iop);
 
 	pdom = container_of(pgtable, struct protection_domain, iop);
-	if (!(pdom->flags & PD_IOMMUV2_MASK))
+	if (!(pdom->flags & PD_FLAG_GCR3))
 		return;
 
 	/* Clear gcr3 entry */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 982d5450595c..a138727b3176 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1596,7 +1596,7 @@ static int setup_gcr3_table(struct protection_domain *domain, int pasids)
 		return -ENOMEM;
 
 	domain->glx      = levels;
-	domain->flags   |= PD_IOMMUV2_MASK;
+	domain->flags   |= PD_FLAG_GCR3;
 
 	amd_iommu_domain_update(domain);
 
@@ -1636,7 +1636,7 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 			pte_root |= 1ULL << DEV_ENTRY_PPR;
 	}
 
-	if (domain->flags & PD_IOMMUV2_MASK) {
+	if (domain->flags & PD_FLAG_GCR3) {
 		u64 gcr3 = iommu_virt_to_phys(domain->gcr3_tbl);
 		u64 glx  = domain->glx;
 		u64 tmp;
@@ -1666,7 +1666,7 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
 		}
 
-		if (domain->flags & PD_GIOV_MASK)
+		if (domain->flags & PD_FLAG_GIOV)
 			pte_root |= DTE_FLAG_GIOV;
 	}
 
@@ -1830,7 +1830,7 @@ static int attach_device(struct device *dev,
 		goto skip_ats_check;
 
 	pdev = to_pci_dev(dev);
-	if (domain->flags & PD_IOMMUV2_MASK) {
+	if (domain->flags & PD_FLAG_GCR3) {
 		struct iommu_domain *def_domain = iommu_get_dma_domain(dev);
 
 		ret = -EINVAL;
@@ -1911,7 +1911,7 @@ static void detach_device(struct device *dev)
 	if (!dev_is_pci(dev))
 		goto out;
 
-	if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
+	if (domain->flags & PD_FLAG_GCR3 && dev_data->iommu_v2)
 		pdev_iommuv2_disable(to_pci_dev(dev));
 	else if (dev_data->ats.enabled)
 		pci_disable_ats(to_pci_dev(dev));
@@ -2062,7 +2062,7 @@ static void protection_domain_free(struct protection_domain *domain)
 	if (domain->iop.pgtbl_cfg.tlb)
 		free_io_pgtable_ops(&domain->iop.iop.ops);
 
-	if (domain->flags & PD_IOMMUV2_MASK)
+	if (domain->flags & PD_FLAG_GCR3)
 		free_gcr3_table(domain);
 
 	if (domain->iop.root)
@@ -2086,6 +2086,7 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 			return -ENOMEM;
 	}
 
+	domain->flags |= PD_FLAG_V1DMA;
 	amd_iommu_domain_set_pgtable(domain, pt_root, mode);
 
 	return 0;
@@ -2093,13 +2094,14 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 
 static int protection_domain_init_v2(struct protection_domain *domain)
 {
-	domain->flags |= PD_GIOV_MASK;
+	domain->flags |= PD_FLAG_GIOV;
 
 	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 
 	if (setup_gcr3_table(domain, 1))
 		return -ENOMEM;
 
+	domain->flags |= PD_FLAG_V2DMA;
 	return 0;
 }
 
@@ -2125,6 +2127,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	switch (type) {
 	/* No need to allocate io pgtable ops in passthrough mode */
 	case IOMMU_DOMAIN_IDENTITY:
+		domain->flags |= PD_FLAG_PT;
 		return domain;
 	case IOMMU_DOMAIN_DMA:
 		fallthrough;
@@ -2555,7 +2558,7 @@ int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
 	 * devices attached when it is switched into IOMMUv2 mode.
 	 */
 	ret = -EBUSY;
-	if (pdom->dev_cnt > 0 || pdom->flags & PD_IOMMUV2_MASK)
+	if (pdom->dev_cnt > 0 || pdom->flags & PD_FLAG_GCR3)
 		goto out;
 
 	if (!pdom->gcr3_tbl)
@@ -2574,7 +2577,7 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 	struct iommu_cmd cmd;
 	int i, ret;
 
-	if (!(domain->flags & PD_IOMMUV2_MASK))
+	if (!(domain->flags & PD_FLAG_GCR3))
 		return -EINVAL;
 
 	build_inv_iommu_pasid(&cmd, domain->id, pasid, address, size);
-- 
2.31.1

