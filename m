Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD5D174D0
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 17:41:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fE4Jk0krzkuJlkj4sYTSWnJQ7NE+xeG/U1kfVpOUjXiidWk7qnmjwaQtFjPVjOhqSh8Zsh4Yr6776jx0b9rvf82Dr4p1QZc3Bt0e5qNz5YOEYwFQwwEjZjTTXhx81i0TkEJlxm5vXCKvLn1zg5UWja/I46BasbxXORqTs38PCWCk/Aio3c601BHO8R4vWt2pqGoAd5pXkIVIslTwj64GF2T0yWD9PwQ+Ap1cZcmokxZOSEk2bpiQ/ZYJIVh0pvBojXeaTrww1XNkOpXc5/dtw+0toFuzSekNEKlwrGfMHErX7ugW73Ww9lQuIoufTdFUINnhAz025LQgcnXwflVGHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJEFLScuUKqA6DkEBmiQLgxSQIslFa8HB88TncAcvIU=;
 b=WYHUIfVQf8GGu/ENXIKmsRueITcCvPq9V1GkaM3sj6JumVwac5EcClRWp8Qra5V+siGIFpXWki4m2r/IggY/xC31P0VzMS5f+3500g79r+O3CF0ZvHrxxMt7ZFClQql+34FvS60wenBjPeEDj1y+6bqKzuHXvRzqiirOoiCMzLwNhZYec1uRzHcMYG6co5hd4c31IyFlt31Zr8la+kRssFgkGJXHf3XxFYhI/XFBGMLywyi8EbyAT4H02RCPTnwZXTgjq7XLglW8fCwJEegSGxjO+LgHIJNZvqr+8ifeN8sufhCWGHxepnMvxAH7mX8P8554wHCLsrMRRmpYTZfmBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJEFLScuUKqA6DkEBmiQLgxSQIslFa8HB88TncAcvIU=;
 b=EsB/U3o1szm4veuea7rdziJOhtStPjtQIZZ1Et1cgH2fu5e495rl3HxkPw5KlOqL2r+KOHYl18PH9nkAOyju5/VNcpUnTJcHpRgMTDJT9YTbFFXmWgkrDU8JChdDHkH47s1m2I7B1nUiNp9SNzzhZy6Q29334ZwsDxWreOVaD9U=
Received: from SA0PR13CA0027.namprd13.prod.outlook.com (2603:10b6:806:130::32)
 by DS7PR12MB5813.namprd12.prod.outlook.com (2603:10b6:8:75::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 17:41:09 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:130:cafe::6a) by SA0PR13CA0027.outlook.office365.com
 (2603:10b6:806:130::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 17:41:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 17:41:08 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 12:41:06 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 01/10] iommu/amd: Use struct protection_domain in helper functions
Date: Wed, 16 Aug 2023 17:40:22 +0000
Message-ID: <20230816174031.634453-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816174031.634453-1-vasant.hegde@amd.com>
References: <20230816174031.634453-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|DS7PR12MB5813:EE_
X-MS-Office365-Filtering-Correlation-Id: 1146eadc-3f89-40e0-6e24-08db9e7ff995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cKTwyJlZ9nZGM+WtH1MGE7NVMKoEvSf2cAEEHVZgZ1gxi4ZkkQLKjcJOBLD3veOP41RWMEzFvsKMtUCG3V/dawEfRWbuNOCT1kCi4ojfWpR30QzrzJ5F3+vNfeZKUzwUOc1KZN0P8PBby4XlX+sI1QvXC74bP2nGB5/QKVOLKSGooou1tFAUhQCMxKJoTNNxXhXav7VviN7siS34jRP/3y+oIS7D0bOfEBiX79t7fJ2aIYWxMeGmJYv9jQAErJI0BgV9tU6QNG7k5HoWoSZzOY9mHBluwoWVteKiH45YPBM6EpXgoYnZvkuoc5X4yQr4qtsIuMgOs26I+BefFeeV9bP6jckRajo5+sxT9/Fxe/0dMChECU4EfS8oLeB3RgG+4Ie8Vi91db3VrgLX5R73d9avcoKWpJsY2FmG19/hPkove66vcPn0qW9eID8gDktGv8iNwUa0ZmnMHHB2qQdDAvzQoEd4ST4cMJnYXrVCUWOjm4kRDWX9sM6wTj3izVb8I7+cLco0tgzyJ3yeJotV4PmMnzUXsTHQV0UShLfCeKP6j1Yaaiu4kMysIKhHaenEpkCWEUZNTPybSe33o4RBekPV5nqinS9LAoZVdFcQPidmFbnzDxIZjW4N08wctATW10fhapkddxHmmDoRr+yWWkmrXYuQDrFlEeSzC6EDJHPek5ollr0qS9CevbdPrXMUWj7VTLL1VoJ943Ja2MObNDh/NZ7tpzBR/mivfb9eIv7rxR03ygVCzl5jlrgyNpDXIPcLDiLYwZOZyoe3/Urrcw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(5660300002)(44832011)(36860700001)(41300700001)(356005)(54906003)(82740400003)(316002)(81166007)(70206006)(70586007)(110136005)(8676002)(8936002)(4326008)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:41:08.7787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1146eadc-3f89-40e0-6e24-08db9e7ff995
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5813

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To simplify the unnecessary use of container_of() on the struct
iommu_domain to get the container structure.

No functional changes intended.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h     | 13 +++++++++----
 drivers/iommu/amd/io_pgtable_v2.c |  8 ++++----
 drivers/iommu/amd/iommu.c         | 18 ++++--------------
 3 files changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 8b586effbefc..87739d95ea8b 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -55,15 +55,15 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
 void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
 
-int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid, u64 address);
+int amd_iommu_flush_page(struct protection_domain *domain, u32 pasid, u64 address);
 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_update(struct protection_domain *domain);
 void amd_iommu_domain_flush_complete(struct protection_domain *domain);
 void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain);
-int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid);
-int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
+int amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid);
+int amd_iommu_domain_set_gcr3(struct protection_domain *domain, u32 pasid,
 			      unsigned long cr3);
-int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid);
+int amd_iommu_domain_clear_gcr3(struct protection_domain *domain, u32 pasid);
 
 #ifdef CONFIG_IRQ_REMAP
 int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
@@ -147,6 +147,11 @@ static inline void *alloc_pgtable_page(int nid, gfp_t gfp)
 	return page ? page_address(page) : NULL;
 }
 
+static inline struct protection_domain *to_pdomain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct protection_domain, domain);
+}
+
 bool translation_pre_enabled(struct amd_iommu *iommu);
 bool amd_iommu_is_attach_deferred(struct device *dev);
 int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line);
diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index f818a7e254d4..c17cda83bca5 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -274,9 +274,9 @@ static int iommu_v2_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 out:
 	if (updated) {
 		if (count > 1)
-			amd_iommu_flush_tlb(&pdom->domain, 0);
+			amd_iommu_flush_tlb(pdom, 0);
 		else
-			amd_iommu_flush_page(&pdom->domain, 0, o_iova);
+			amd_iommu_flush_page(pdom, 0, o_iova);
 	}
 
 	if (mapped)
@@ -364,7 +364,7 @@ static void v2_free_pgtable(struct io_pgtable *iop)
 		return;
 
 	/* Clear gcr3 entry */
-	amd_iommu_domain_clear_gcr3(&pdom->domain, 0);
+	amd_iommu_domain_clear_gcr3(pdom, 0);
 
 	/* Make changes visible to IOMMUs */
 	amd_iommu_domain_update(pdom);
@@ -384,7 +384,7 @@ static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	if (!pgtable->pgd)
 		return NULL;
 
-	ret = amd_iommu_domain_set_gcr3(&pdom->domain, 0, iommu_virt_to_phys(pgtable->pgd));
+	ret = amd_iommu_domain_set_gcr3(pdom, 0, iommu_virt_to_phys(pgtable->pgd));
 	if (ret)
 		goto err_free_pgd;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8e4f52d8bc9d..fca6e6ceeef3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -173,11 +173,6 @@ static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
 	return __rlookup_amd_iommu(seg, PCI_SBDF_TO_DEVID(devid));
 }
 
-static struct protection_domain *to_pdomain(struct iommu_domain *dom)
-{
-	return container_of(dom, struct protection_domain, domain);
-}
-
 static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
@@ -2592,10 +2587,8 @@ static int __amd_iommu_flush_page(struct protection_domain *domain, u32 pasid,
 	return __flush_pasid(domain, pasid, address, false);
 }
 
-int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
-			 u64 address)
+int amd_iommu_flush_page(struct protection_domain *domain, u32 pasid, u64 address)
 {
-	struct protection_domain *domain = to_pdomain(dom);
 	unsigned long flags;
 	int ret;
 
@@ -2612,9 +2605,8 @@ static int __amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid)
 			     true);
 }
 
-int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
+int amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid)
 {
-	struct protection_domain *domain = to_pdomain(dom);
 	unsigned long flags;
 	int ret;
 
@@ -2690,10 +2682,9 @@ static int __clear_gcr3(struct protection_domain *domain, u32 pasid)
 	return __amd_iommu_flush_tlb(domain, pasid);
 }
 
-int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
+int amd_iommu_domain_set_gcr3(struct protection_domain *domain, u32 pasid,
 			      unsigned long cr3)
 {
-	struct protection_domain *domain = to_pdomain(dom);
 	unsigned long flags;
 	int ret;
 
@@ -2704,9 +2695,8 @@ int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
 	return ret;
 }
 
-int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid)
+int amd_iommu_domain_clear_gcr3(struct protection_domain *domain, u32 pasid)
 {
-	struct protection_domain *domain = to_pdomain(dom);
 	unsigned long flags;
 	int ret;
 
-- 
2.31.1

