Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85661FC8
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 06:44:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIia/PJ/pa8ciCESxO+hyRg2cay2njjx3LRjAGaYQlD3bYXnZHlp+4HSzxvl14rBmgklbsd/OqzAyTJwj75Y4uG0r0BL7W+2Ynz5pZi84z8lAEoMJBJqCXxhfEPkKtv/wbV/8L83kJ8+mi/QY2JOHaCuIWuToImEVRndODME4fZXAxrfs40EeJXFolYst0mbpLI7wL9NCWqPHSoWDu4Gt3JGX2voca2ZZ7MIhYyXr++GUEuj+r20g5cWlY5Ey9ZAQghR5P1AhAnXMJtqOdW7kHKH7OUQirKsGkSeNZpI845DK3rIJrX471lpkoJfrgiu6/qRgGpoZYx0Am1EMnReSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I5YRmn+/xroOyxcSO1MF9KMhlZzlQqQeEpuWbqk81Uo=;
 b=OviEI8wf9NkZNuuI2K/93EvbBjT1KuACcxlHDWotZkmNPssRsgzbiyWYpOqrncoBFf3I2XTFWRvR4iD9S+f8itZyVQCHVh0OaDUT6CFCvdsaFmQmOYBTB1c0Mdy0yBwDBiOJ4fN7lb8HMs+pir2/fLoswyuHIYVs5EtiJ1cFf8dH/Y8fcOisqAxnqtUDRCTYc2uMXuQ3Td40gRV7wHLeRvCW0ALXJ6xPyErEZfTgAgi7o0YHWPBL5WJLccmhPt6MQPbVM4TDcXL5BDNFi/8L8X/CVYG20luE023ThV8if6cXXV7RQUVZhw46shmIUeBnsF1Fw902EYB1d3hF5t5ECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I5YRmn+/xroOyxcSO1MF9KMhlZzlQqQeEpuWbqk81Uo=;
 b=YxzXkeOZZgJXlzcWcZ9xPNMO261EwBMIB3VnC2qBszgZOvU8WlhUBFC4UFM2FDVNGtwRqEsJl1X8AhaqkejuQqnXuBYW0xX2LH+NPUAJVs6D9ww8zLMJb0vtc6cBbYp2jgvpQ9bx8w6k5Vy5HdczrtvJbBcUv19o4r+04e7e8Fw=
Received: from CY5P221CA0059.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:4::44) by
 SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.28; Fri, 4 Aug 2023 06:44:50 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:4:cafe::d) by CY5P221CA0059.outlook.office365.com
 (2603:10b6:930:4::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Fri, 4 Aug 2023 06:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.140) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 06:44:50 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 01:44:40 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 07/16] iommu/amd: Use struct protection_domain in helper functions
Date: Fri, 4 Aug 2023 06:42:07 +0000
Message-ID: <20230804064216.835544-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804064216.835544-1-vasant.hegde@amd.com>
References: <20230804064216.835544-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|SJ2PR12MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: 08b9cccd-4aa8-4510-7749-08db94b64d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Omv9z991bhnT5+Md+yuYilyG158hEIfatfzaFcZtZuh58FsNURunIhEq8FmUc13VprBydnUN526pYQm0qIUuS3QsnFv3Vp5wmuCr5O+CHs5BOQcbW6Gr5yx8kv+dR/eLmKYwGXPp+pRiz4eUANqvaJIN/wpLl/qQuFkd9gX4DEXlWkgS1lDWFPpmoRdLilyo665B5rEP3YwdNFe9z0Hi67te30cEJt3IOPu25ANVRWCy+rWF4tkXTs0uUWGniXuyRvkj1ETUcWNUB+HPbWfSFBuOsJ25bhs6/RWhnaSdTd13uAHK/XRZpPz2L0xKgZGyGfOj20UoRK7rZqcIckmARMbwhEDH6KUZpTUo8fVuB5niSCXhQpvF9tPWP9v4rM/GDSq2X3aUcFssSZ/tsufSYv7NVLXYaHb0KX/8KYwAGyti+SDCgE04ErZCpEP/OT/rf6HA+tzVev5doMdsuqPt3hs5nLOxFzKdoi5Y4acMcog1zJqWEQZXATMDEDOfrhxqppkSayTrpzVjtfbAZl00KxpSGCNQTHAsh1kAxIwA+b/lg378I1weE/C4CySc+dvNVxfoC1RMKIqhsXj1JqTmTXpA6Xs6L0EG+/ymgsrbgHVeLzMKeiDgPV7ta+bKqeAvv3JqRcxeFcN8KcB22DKSX+ESovT0CYUj3gsLjLzmM/EeKLj1/qhZUpx0MepraYwg+xA0gl/RpF8ZOnUmslsZCl575yeQeFnVwBcWZF1+us3lgR/mXcek1VBaGjNiklCF5BY5fc3nKe5Rb6NsoArPAyzYoGMDaX7KXHxtJwUDUs9u1aORi/NuN9YuhtCQu5aY
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(186006)(451199021)(1800799003)(82310400008)(46966006)(40470700004)(36840700001)(81166007)(26005)(1076003)(40460700003)(478600001)(8676002)(8936002)(5660300002)(44832011)(110136005)(41300700001)(4326008)(70206006)(70586007)(54906003)(6666004)(86362001)(40480700001)(316002)(7696005)(2616005)(426003)(336012)(356005)(82740400003)(16526019)(36756003)(2906002)(47076005)(83380400001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 06:44:50.1354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b9cccd-4aa8-4510-7749-08db94b64d27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To simplify the unnecessary use of container_of() on the struct
iommu_domain to get the container structure.

No functional changes intended.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h     | 13 +++++++++----
 drivers/iommu/amd/io_pgtable_v2.c |  6 +++---
 drivers/iommu/amd/iommu.c         | 18 ++++--------------
 drivers/iommu/amd/iommu_v2.c      | 11 +++++------
 4 files changed, 21 insertions(+), 27 deletions(-)

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
index 135fa087ce47..1836df41fc7e 100644
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
@@ -2644,10 +2639,8 @@ static int __amd_iommu_flush_page(struct protection_domain *domain, u32 pasid,
 	return __flush_pasid(domain, pasid, address, false);
 }
 
-int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
-			 u64 address)
+int amd_iommu_flush_page(struct protection_domain *domain, u32 pasid, u64 address)
 {
-	struct protection_domain *domain = to_pdomain(dom);
 	unsigned long flags;
 	int ret;
 
@@ -2665,9 +2658,8 @@ static int __amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid)
 			     true);
 }
 
-int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
+int amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid)
 {
-	struct protection_domain *domain = to_pdomain(dom);
 	unsigned long flags;
 	int ret;
 
@@ -2744,10 +2736,9 @@ static int __clear_gcr3(struct protection_domain *domain, u32 pasid)
 	return __amd_iommu_flush_tlb(domain, pasid);
 }
 
-int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
+int amd_iommu_domain_set_gcr3(struct protection_domain *domain, u32 pasid,
 			      unsigned long cr3)
 {
-	struct protection_domain *domain = to_pdomain(dom);
 	unsigned long flags;
 	int ret;
 
@@ -2759,9 +2750,8 @@ int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
 }
 EXPORT_SYMBOL(amd_iommu_domain_set_gcr3);
 
-int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid)
+int amd_iommu_domain_clear_gcr3(struct protection_domain *domain, u32 pasid)
 {
-	struct protection_domain *domain = to_pdomain(dom);
 	unsigned long flags;
 	int ret;
 
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 6a423928d5b5..9bf114382c00 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -282,7 +282,7 @@ static void unbind_pasid(struct pasid_state *pasid_state)
 	smp_wmb();
 
 	/* After this the device/pasid can't access the mm anymore */
-	amd_iommu_domain_clear_gcr3(&dev_state->pdom->domain, pasid_state->pasid);
+	amd_iommu_domain_clear_gcr3(dev_state->pdom, pasid_state->pasid);
 
 	/* Make sure no more pending faults are in the queue */
 	flush_workqueue(iommu_wq);
@@ -368,10 +368,10 @@ static void mn_invalidate_range(struct mmu_notifier *mn,
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
@@ -650,7 +650,7 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 	if (ret)
 		goto out_unregister;
 
-	ret = amd_iommu_domain_set_gcr3(&dev_state->pdom->domain, pasid,
+	ret = amd_iommu_domain_set_gcr3(dev_state->pdom, pasid,
 					__pa(pasid_state->mm->pgd));
 	if (ret)
 		goto out_clear_state;
@@ -784,8 +784,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 		goto out_free_states;
 
 	/* Retrieve new protection_domain that has just been allocated */
-	dev_state->pdom = container_of(domain,
-				       struct protection_domain, domain);
+	dev_state->pdom = to_pdomain(domain);
 
 	/* See iommu_is_default_domain() */
 	domain->type = IOMMU_DOMAIN_IDENTITY;
-- 
2.31.1

