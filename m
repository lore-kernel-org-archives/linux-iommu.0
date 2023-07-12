Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ED1100AE
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:17:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISLr0fXz25QBI4CH2LYncjueGreO2EtsxbWsj5RF0DFFqN3PbMG/1nQF6QLa3te31YZTLXG2/aE1RAJNK6FESEeF3aqTK42quQPQE26oV/osEy6Dlkt1VyeHLe2cUYi4IO1oRvDpCYvotEYrf3e5ma+brsbgRSQGF0rKSQLQAHhXwckTTWSnRPv34UAwLVSUBq259gAvMo2uTRirTxH8J0+fvK7DGioAzUHSlZbYmX8a/7fIj3q3rnQkDTUd8aG9axXrNrMYtPm2ubK2bbk5d1oS1chxqoe/OTEfVyd2iM0MxVo8xP36IN9Cy36zByVKN08HRbtYDbLkGNPcIgyxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u62TPzabh9NI6+ImQ12PvWHJpzTBdYxLxSfRnsQVA9o=;
 b=TG1Fz1ihBvpsWk3zyCiJCMX+QTPbYCetmEyfNLlTOCnpSx/3nXtgb0vvaXm81GUaDe+XPHqMNFTOvk1u/aAx2WuZ/W5zRGS/z6DuFQygWrgAs8+s0CL/NUHGaN+Me4U62CV82oREbUFpFkviQZPlMvbLttbhEvRGcCyqBPt33u7wSYeFkOETGEBptW4WbukYCajA1EMbL4UV5UTw4GSP4+jgRHWbQxhe7NdC05HNru6UcyiQFd7mFzeLphF9e8FOJ6VGY3gbTjYjp6S0/DVTzs4PHyHxOaAnNx47IE9eyagDd8LOJK7iuSAt+QUSYlbEv6izbd+hKz90roVFtoA+Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u62TPzabh9NI6+ImQ12PvWHJpzTBdYxLxSfRnsQVA9o=;
 b=E6erOlbAAz1z10RytRTzirQscW98d56qM13raspjD4Q2jHz860FVlXgiQ1nUQgP+SUM/j79Rbf4pacpW+HfAX7Ql6azzdAmHnsnGKOIrcvNGenZbvaOvxLUbMhsjii6xneVkmGxS1p+bG1nC9Sh+2Wi5v2J49QAK+qFkG60GDtk=
Received: from DM6PR06CA0073.namprd06.prod.outlook.com (2603:10b6:5:336::6) by
 SA0PR12MB4350.namprd12.prod.outlook.com (2603:10b6:806:92::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.22; Wed, 12 Jul 2023 14:17:38 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::a2) by DM6PR06CA0073.outlook.office365.com
 (2603:10b6:5:336::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 14:17:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 14:17:38 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:17:36 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 07/21] iommu/amd: Use struct protection_domain in helper functions
Date: Wed, 12 Jul 2023 14:15:02 +0000
Message-ID: <20230712141516.154144-8-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT047:EE_|SA0PR12MB4350:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ca008d-16ee-49e4-89a1-08db82e2bf60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ie7ee2aO06GEuDnRR8QoXIdC96TQx1TnI0EtKMicOk1khXMhP/3YfTbtMgpWpOXh6Xvc2jn53y1obkYyxisebJ2Pl5vmNtiLlbNaqETIzIKXOSOwbPJJZ7NadiJqJIFdjC/Z6IHVXllQs+YLkwhlq8mqYZ/+WLudT2wbDnM5einVsD2HYL9lYianZagO9fv/2FeGIlQoMUbCCZKmoYOIr21Rgpo+p8nXk2+1Z8w2J80Efp0vAVE64MEcnpzn06/ACmu4mzrFNX80jya1+I/Jh95t0u+m3L7wHHbWijZsYuAPJMsqOnL3XkeX7iow+AZ/dzvtLaB/fLNTx1Tz7oaRe2zvsKzA7QQ9MiYqu/HZ9s8x5Wq4DNWMofRqsCwIz4R87YijHJsBRSqQNsgnLRTjkTZO0+FC2J+ctFrDdrlVcU/GytMuASpLDHKHjn/MnfTMU2YVxWMnJGwN6HojGpRzmu2cz5Ddq9bsTXpT1pzbpnMu576D9mlU2wCeXvAOun2VS8zcv+yTt6xOgBkcXG4u6TbGH5nInVyL39W7wL0Tj9TFmZm/robJpT/OAs7onswcLjo5aFF69tcO0JE3pJ089cO/4wh5uVIP/32MIa1GWa2VLfCEzsRigAmn7Lr/QDWs/vcymlr6eSmXd68p3nLVJCNhPDDgpnK3GI5N3DmLljwIULhcHr/rC4uLKvTJhP8ySI5/m6TodayEJbRb1WB7jfO5xKlzbkSCHd3Uoj+beao8ywbrrAuN2u6tYeTicqWiV+0zCRa6Z6Pf7u3eDrTgRQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(478600001)(6666004)(54906003)(110136005)(7696005)(4326008)(70206006)(70586007)(316002)(40460700003)(82740400003)(41300700001)(40480700001)(356005)(81166007)(336012)(186003)(2616005)(16526019)(2906002)(44832011)(8676002)(8936002)(1076003)(26005)(36756003)(5660300002)(86362001)(47076005)(36860700001)(426003)(82310400005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:17:38.7270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ca008d-16ee-49e4-89a1-08db82e2bf60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4350

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To simplify the unnecessary use of container_of() on the struct
iommu_domain to get the container structure.

No functional changes intended.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       | 13 +++++++++----
 drivers/iommu/amd/amd_iommu_types.h | 10 ++++++++++
 drivers/iommu/amd/io_pgtable_v2.c   |  6 +++---
 drivers/iommu/amd/iommu.c           | 18 ++++--------------
 drivers/iommu/amd/iommu_v2.c        | 11 +++++------
 5 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 6bf55de9fbeb..a5a350ee36fe 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -58,15 +58,15 @@ int amd_iommu_register_ppr_notifier(struct notifier_block *nb);
 int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb);
 void amd_iommu_domain_direct_map(struct iommu_domain *dom);
 int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids);
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
@@ -134,6 +134,11 @@ static inline void *alloc_pgtable_page(int nid, gfp_t gfp)
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
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a8d264026f7f..1d3a35a460d0 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -927,6 +927,16 @@ static inline int get_hpet_devid(int id)
 	return -EINVAL;
 }
 
+static inline struct protection_domain *amd_iommu_get_pdomain(struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	if (!dev_data || !dev_data->domain)
+		return NULL;
+
+	return dev_data->domain;
+}
+
 enum amd_iommu_intr_mode_type {
 	AMD_IOMMU_GUEST_IR_LEGACY,
 
diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index e9ef2e0a62f6..a4fa830eab54 100644
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
@@ -384,7 +384,7 @@ static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	if (!pgtable->pgd)
 		return NULL;
 
-	ret = amd_iommu_domain_set_gcr3(&pdom->domain, 0, iommu_virt_to_phys(pgtable->pgd));
+	ret = amd_iommu_domain_set_gcr3(pdom, 0, iommu_virt_to_phys(pgtable->pgd));
 	if (ret)
 		goto err_free_pgd;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a278bd9aa9e6..037a4e28a2f3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -174,11 +174,6 @@ static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
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
@@ -2641,10 +2636,8 @@ static int __amd_iommu_flush_page(struct protection_domain *domain, u32 pasid,
 	return __flush_pasid(domain, pasid, address, false);
 }
 
-int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
-			 u64 address)
+int amd_iommu_flush_page(struct protection_domain *domain, u32 pasid, u64 address)
 {
-	struct protection_domain *domain = to_pdomain(dom);
 	unsigned long flags;
 	int ret;
 
@@ -2662,9 +2655,8 @@ static int __amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid)
 			     true);
 }
 
-int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
+int amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid)
 {
-	struct protection_domain *domain = to_pdomain(dom);
 	unsigned long flags;
 	int ret;
 
@@ -2741,10 +2733,9 @@ static int __clear_gcr3(struct protection_domain *domain, u32 pasid)
 	return __amd_iommu_flush_tlb(domain, pasid);
 }
 
-int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
+int amd_iommu_domain_set_gcr3(struct protection_domain *domain, u32 pasid,
 			      unsigned long cr3)
 {
-	struct protection_domain *domain = to_pdomain(dom);
 	unsigned long flags;
 	int ret;
 
@@ -2756,9 +2747,8 @@ int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
 }
 EXPORT_SYMBOL(amd_iommu_domain_set_gcr3);
 
-int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid)
+int amd_iommu_domain_clear_gcr3(struct protection_domain *domain, u32 pasid)
 {
-	struct protection_domain *domain = to_pdomain(dom);
 	unsigned long flags;
 	int ret;
 
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index e4507a211d6b..a9733fbc1761 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -282,7 +282,7 @@ static void unbind_pasid(struct pasid_state *pasid_state)
 	smp_wmb();
 
 	/* After this the device/pasid can't access the mm anymore */
-	amd_iommu_domain_clear_gcr3(&dev_state->pdom->domain, pasid_state->pasid);
+	amd_iommu_domain_clear_gcr3(dev_state->pdom, pasid_state->pasid);
 
 	/* Make sure no more pending faults are in the queue */
 	flush_workqueue(iommu_wq);
@@ -365,10 +365,10 @@ static void mn_invalidate_range(struct mmu_notifier *mn,
 	dev_state   = pasid_state->device_state;
 
 	if ((start ^ (end - 1)) < PAGE_SIZE)
-		amd_iommu_flush_page(&dev_state->pdom->domain, pasid_state->pasid,
+		amd_iommu_flush_page(dev_state->pdom, pasid_state->pasid,
 				     start);
 	else
-		amd_iommu_flush_tlb(&dev_state->pdom->domain, pasid_state->pasid);
+		amd_iommu_flush_tlb(dev_state->pdom, pasid_state->pasid);
 }
 
 static void mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -647,7 +647,7 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 	if (ret)
 		goto out_unregister;
 
-	ret = amd_iommu_domain_set_gcr3(&dev_state->pdom->domain, pasid,
+	ret = amd_iommu_domain_set_gcr3(dev_state->pdom, pasid,
 					__pa(pasid_state->mm->pgd));
 	if (ret)
 		goto out_clear_state;
@@ -781,8 +781,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 		goto out_free_states;
 
 	/* Retrieve new protection_domain that has just been allocated */
-	dev_state->pdom = container_of(domain,
-				       struct protection_domain, domain);
+	dev_state->pdom = to_pdomain(domain);
 
 	/* See iommu_is_default_domain() */
 	domain->type = IOMMU_DOMAIN_IDENTITY;
-- 
2.31.1

