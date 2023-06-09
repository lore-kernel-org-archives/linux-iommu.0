Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7F6BE53
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 09:07:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vt4FCSwJRVXyZL/Q9MeA7JiDA1tKbFMYDwU1fhwK0TN1PdxLq9h/vdAe7j5B8hxA9wF4DUXka0vGi88CzSnRjqH/VB1+tqFuPnmTKP0/woY1GDXXH3oR3xscYzCSbaVaY0jVwRAhpIpTbAjTzg9dkvYRhY1ccFds8qMg4G8lJfRODqvovPjGPtMPWO8Aqly93upeB3RH9mAeuk/d0PSLojxRvJHgcijaQkht2dzFbBgazgDwdSh01Khf5Epwvcc1atzuUlKasOme5yCBNqcLtWFjGrEtC3lpamCo81lR++F5LC63zZtGriYT1KlN0XoxS8K4dCcb0GL2VdjNyPAKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdPkv+7duQTEkG+TeCvXwBYtLKqLUibmnn1pM6JIh5c=;
 b=Ck3AHbfztkvNq/r4lD9aFpHFpcRRFnnxQA+LsooUFqmH6Q1351a3YZn/zmn8YFTdYh8kcxNnoucBccB07DbOe03KCO5E99AruGNtGTmJh/6VyRm925PU8od+B30W5JSH0FOebyxZyEkO7AP5QEoEQ/Du3FpFKdNg7lHwQBRzF6kW/kamyup/X7dTE/tmMpwfhWlJ3SgMHEbIpA3WsJ/iILXL7s319wNEjY1+ctJVKYgA7CJ8Rqfo2MC5Ogz93+fQ9nXPC9bQfopbONhEC2tK5OsqH8n+r6AifRkGuTBh+ynywcqUxjIM3KtEKVnebLkZYnhuMs8Gi3iJqVknH+9mvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdPkv+7duQTEkG+TeCvXwBYtLKqLUibmnn1pM6JIh5c=;
 b=RGmqZEAXzNugdps9km0tWoq+lNlX6+VAcimln4YNXIZtLsF6uXmTcvMRg7df3cyCcm3CsLeJsvHhInA/ytuFcaql7nC1jsdPeZKhmjDFeVP8Cj5bHXq8yFQJCZi1Hun055NVhHzt588tHkHS7GHNIO1tDu0nm9zNyW4fkgNJr+o=
Received: from MW4PR04CA0106.namprd04.prod.outlook.com (2603:10b6:303:83::21)
 by MW4PR12MB6682.namprd12.prod.outlook.com (2603:10b6:303:1e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Fri, 9 Jun
 2023 09:07:11 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::29) by MW4PR04CA0106.outlook.office365.com
 (2603:10b6:303:83::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.27 via Frontend
 Transport; Fri, 9 Jun 2023 09:07:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Fri, 9 Jun 2023 09:07:11 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 04:07:08 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 2/2] iommu/amd: Remove extern from function prototypes
Date: Fri, 9 Jun 2023 09:06:31 +0000
Message-ID: <20230609090631.6052-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609090631.6052-1-vasant.hegde@amd.com>
References: <20230609090631.6052-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|MW4PR12MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b7148a-e608-4866-5c22-08db68c8e928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z1WUT8UlFnAejrFt7oAdA3GtxrNCSOsXM43k8SYwoaOki0B18+xa3ufKq/2Jup1YoCnXbsyWpYtXJAkAlIL5iSox6qjoAx0w2HWWXrrY3X/E93MWMJLkGvmeXN5i/ZUXxGnSd7Jl/JmAm6ZZc6m+r0eGCcRsbX4FC0Xf7NR/7f1ZPaLtxmQ2qHqAeDB/nWG9MTSK7DJNH8UbcsBEWac3afeXt1KaxF4gpdHxJGDNhRzNXXFnfe+UY81TlcWPtYwQm8LrWko3hpRJRW2TgWBjsYymFnU9vXgIkIDmfdK+FQg+GEP+pRl117hyVgmmgeyyetlorvuU/EWwH9rVJahvjpfit4XbmGsX/7kViwfe4OQ9Sxh0afruDV/60e23N9gT5+8xWK7PH0hJ/4/EQ4FDyXTzqGOrd595a1jg9dmT6TLg5eEBb1/06o3/RdjXUbA3mwPmq0phH7z12I1tnAj9tmbXKnOI/DHe0Bcj33aYMdcq5gCpNwTGuzJpGQS+7FEEvgNZBg6SUQ0UHXRA7ugLrd/b4XU/f0J+or3IIboQiQZP7GLV/Rxuuj/4FPZWzkzZlkt9e5Z3IX0KcvK1fk8Thl4v6yPox+aK5mDvAwPD4fvZjZsJFUI8Rw3NOc8xD2DXmw6V5z7XU69XZwk0eEAcnicXkDoYj3vzr49AbGV3lSYDq+czMwkvOM856G2Y6NBjql95Dt0N4Q+o1PrLSs96bniVTr7f2UopoiRtEJBs85tSZOXT3QAzA7VkV3TadqVEDCAeDOyFvsw94Jh9eZ2gpg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(110136005)(54906003)(478600001)(82740400003)(81166007)(356005)(41300700001)(8676002)(8936002)(4326008)(70586007)(316002)(70206006)(2616005)(186003)(16526019)(36860700001)(6666004)(47076005)(83380400001)(7696005)(1076003)(26005)(426003)(336012)(82310400005)(44832011)(86362001)(5660300002)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 09:07:11.5978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b7148a-e608-4866-5c22-08db68c8e928
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6682

The kernel coding style does not require 'extern' in function prototypes.
Hence remove them from header file.

No functional change intended.

Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       | 88 ++++++++++++++---------------
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 2 files changed, 44 insertions(+), 46 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 9beeceb9d825..317d5c26c614 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -11,12 +11,12 @@
 
 #include "amd_iommu_types.h"
 
-extern irqreturn_t amd_iommu_int_thread(int irq, void *data);
-extern irqreturn_t amd_iommu_int_handler(int irq, void *data);
-extern void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
-extern void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
-extern void amd_iommu_restart_ga_log(struct amd_iommu *iommu);
-extern void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
+irqreturn_t amd_iommu_int_thread(int irq, void *data);
+irqreturn_t amd_iommu_int_handler(int irq, void *data);
+void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
+void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
+void amd_iommu_restart_ga_log(struct amd_iommu *iommu);
+void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
@@ -25,11 +25,11 @@ static inline void amd_iommu_debugfs_setup(struct amd_iommu *iommu) {}
 #endif
 
 /* Needed for interrupt remapping */
-extern int amd_iommu_prepare(void);
-extern int amd_iommu_enable(void);
-extern void amd_iommu_disable(void);
-extern int amd_iommu_reenable(int);
-extern int amd_iommu_enable_faulting(void);
+int amd_iommu_prepare(void);
+int amd_iommu_enable(void);
+void amd_iommu_disable(void);
+int amd_iommu_reenable(int mode);
+int amd_iommu_enable_faulting(void);
 extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
@@ -37,33 +37,32 @@ extern int amd_iommu_gpt_level;
 /* IOMMUv2 specific functions */
 struct iommu_domain;
 
-extern bool amd_iommu_v2_supported(void);
-extern struct amd_iommu *get_amd_iommu(unsigned int idx);
-extern u8 amd_iommu_pc_get_max_banks(unsigned int idx);
-extern bool amd_iommu_pc_supported(void);
-extern u8 amd_iommu_pc_get_max_counters(unsigned int idx);
-extern int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
-				u8 fxn, u64 *value);
-extern int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
-				u8 fxn, u64 *value);
-
-extern int amd_iommu_register_ppr_notifier(struct notifier_block *nb);
-extern int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb);
-extern void amd_iommu_domain_direct_map(struct iommu_domain *dom);
-extern int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids);
-extern int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
-				u64 address);
-extern void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
-extern void amd_iommu_domain_update(struct protection_domain *domain);
-extern void amd_iommu_domain_flush_complete(struct protection_domain *domain);
-extern void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain);
-extern int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid);
-extern int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
-				     unsigned long cr3);
-extern int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid);
+bool amd_iommu_v2_supported(void);
+struct amd_iommu *get_amd_iommu(unsigned int idx);
+u8 amd_iommu_pc_get_max_banks(unsigned int idx);
+bool amd_iommu_pc_supported(void);
+u8 amd_iommu_pc_get_max_counters(unsigned int idx);
+int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
+			 u8 fxn, u64 *value);
+int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
+			 u8 fxn, u64 *value);
+
+int amd_iommu_register_ppr_notifier(struct notifier_block *nb);
+int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb);
+void amd_iommu_domain_direct_map(struct iommu_domain *dom);
+int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids);
+int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid, u64 address);
+void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
+void amd_iommu_domain_update(struct protection_domain *domain);
+void amd_iommu_domain_flush_complete(struct protection_domain *domain);
+void amd_iommu_domain_flush_tlb_pde(struct protection_domain *domain);
+int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid);
+int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
+			      unsigned long cr3);
+int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid);
 
 #ifdef CONFIG_IRQ_REMAP
-extern int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
+int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
 #else
 static inline int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 {
@@ -75,8 +74,8 @@ static inline int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 #define PPR_INVALID			0x1
 #define PPR_FAILURE			0xf
 
-extern int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
-				  int status, int tag);
+int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
+			   int status, int tag);
 
 static inline bool is_rd890_iommu(struct pci_dev *pdev)
 {
@@ -129,10 +128,9 @@ static inline void *alloc_pgtable_page(int nid, gfp_t gfp)
 	return page ? page_address(page) : NULL;
 }
 
-extern bool translation_pre_enabled(struct amd_iommu *iommu);
-extern bool amd_iommu_is_attach_deferred(struct device *dev);
-extern int __init add_special_device(u8 type, u8 id, u32 *devid,
-				     bool cmd_line);
+bool translation_pre_enabled(struct amd_iommu *iommu);
+bool amd_iommu_is_attach_deferred(struct device *dev);
+int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line);
 
 #ifdef CONFIG_DMI
 void amd_iommu_apply_ivrs_quirks(void);
@@ -140,9 +138,9 @@ void amd_iommu_apply_ivrs_quirks(void);
 static inline void amd_iommu_apply_ivrs_quirks(void) { }
 #endif
 
-extern void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
-					 u64 *root, int mode);
-extern struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
+void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
+				  u64 *root, int mode);
+struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
 
 extern u64 amd_iommu_efr;
 extern u64 amd_iommu_efr2;
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a49cc2258a76..364fdaa52e74 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -882,7 +882,7 @@ extern int amd_iommu_max_glx_val;
  * This function flushes all internal caches of
  * the IOMMU used by this driver.
  */
-extern void iommu_flush_all_caches(struct amd_iommu *iommu);
+void iommu_flush_all_caches(struct amd_iommu *iommu);
 
 static inline int get_ioapic_devid(int id)
 {
-- 
2.31.1

