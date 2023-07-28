Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2041.outbound.protection.outlook.com [40.107.101.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B99D23AE
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 05:38:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0SWYSZndoeforRi+qacfn1ylWQfqvTWBnp1dQecq2MNO1SyOd371gA+6uAavJHqO5Jck56TyEeH243ppj1V6Bxvzbs+SU3vHoVgGnt9EbY3CqNfQ1/mVwh9oV0gpS9iiZAr0GL3kBDdVMU/t/iVhPGmYmGp1Q3Po9Fe9aM0WMEja/zbbRKIKAlfZyUsa6bRgUe0m6PlC+elUsZPRtAyUfkPO4ni2IwamH8jcbQVvsyYbgaNuOSQpa/sjvL955SAqiZF/3qTfjJNpSHrQ1u8JJQtzZYWiA6Hji9trw9tP/rU02AJ8VcKfvnMv6qlc8P63JtrTpV74WgbcZ4A8apSeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGcvD+0+xtocXhpnRe9SEvGobXGiYyS9GcGn+tV7rpw=;
 b=OypZ2sBVVYvmwZSL0os8KKWbCVpcj0BJZXfVP71ZtHCq7/cGBZSS+4j/mLtgD/ullEr3KeJp+yOkucfrH/kUz6k4Dz2ubr/nfWLH1He8oad/YAj0j1wUyCondtWgGFubL4+xBFh4qjw4U35wz5EbAiXQy+R+wlO1JfK8BiveqtKaaNpJWAhauKXDrUMjTgO7qdouqukTceudWz3+UHXi16rgFdQ3eCj9n9rvNlQ9tA5vw+6bDkUHJixNt30TmDhUxbTf3PqNvjOfOhIMzpGYUyjwxDxWEYrWpFSb74I3fqiiR4r7Nd/vQaWEWjAEKie4gmIvy5jMtNLABFKEQAaC4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGcvD+0+xtocXhpnRe9SEvGobXGiYyS9GcGn+tV7rpw=;
 b=c5MHKQjricG81UtUVUN+uRsmUjupMGIeIVCph5uFdMWQK/ugif7JdaUcVTH9/IT1h+ZKrJdAugcjPq/hYRt3c24ucZx2lic2RodFuDByNxgSeIFZ+H58VPcryeSnDrYxJ39P3bzfSYzH2EneDkYb8Hc0XYsifH0KQ5sT+hVZiRw=
Received: from MW4PR03CA0322.namprd03.prod.outlook.com (2603:10b6:303:dd::27)
 by CO6PR12MB5489.namprd12.prod.outlook.com (2603:10b6:303:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:38:32 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::d) by MW4PR03CA0322.outlook.office365.com
 (2603:10b6:303:dd::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 05:38:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 05:38:29 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 00:38:26 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 07/16] iommu/amd: Use struct protection_domain in helper functions
Date: Fri, 28 Jul 2023 05:36:00 +0000
Message-ID: <20230728053609.165183-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728053609.165183-1-vasant.hegde@amd.com>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|CO6PR12MB5489:EE_
X-MS-Office365-Filtering-Correlation-Id: a16186da-da01-482e-ed58-08db8f2cdfd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	i6S3Eer3vT8M0M1ySc/z/nXfYwZQN/Si87IIbT8A0qU/u3iJ34t2/YWdTLxPJshbyQjhLfVeRY5E1EqHO+o4xn7SAwtMHO13o0VWpfZkqF1x3UC1VVT4iNOe/L1mPUYuR7wh0Q29n29sQNnTu23rqo4XX80uUxMPF6CPLJCtKxxTd5BS4tyyP/oQU5EwaFwev1nyiVJP5P070rNv6nzHujl3UHl1f+FV/u3iMGHo4eW6ulY1xFhxrbPuVw0MXXmQVFmtD4+QVVX0zkajzg+tudZRv3ZoALrof687FHmqKr3ayrszDZLooxfE1G8VuUZEYuMoYaUa6BHXH4fC6+1Kq0QfdDnkkEKYVOKzjMtG4JBQy+dDMRYr0bQZGPEmRkyF9up+SvPgzixPy8+8NbY7DTy9t1vxORPlWEz+zXX5yABIufe0N76V6eWMr/+p7n3goycKAQ0Jao0G0YBgAw56AR0BLIgWxLBc5D7RUpuFEqafnqFOqZpDXhnsAETT7UR+enR9l1EyfFUAq1HBbHx2FbZC7Km2dKYzZTnFGlQarSqoDYld7NujgJFGfX+ijIQwvP0x6PPhhRhzcX1vz0RdnEaF/vFHBdeAoTGmqZiqyAyViw4Ejmn1FTW6RBCB6jHKn6C5wT50jBByTf1xRW/xXzNmDlUy19OyU4BHe+3ENHR+6Bf2e6WDSspsUL6weTZA8oK1+VpPY2EOx4zDlD59wiwZ4awNKlk/UNM9beqHL5recfqMUVbomngZ8hPnMY7pPhwCsvw2h+hvld8hvSV+3Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(2616005)(110136005)(54906003)(36756003)(478600001)(36860700001)(81166007)(356005)(40460700003)(47076005)(426003)(316002)(40480700001)(2906002)(7696005)(44832011)(4326008)(8936002)(8676002)(5660300002)(6666004)(82740400003)(70206006)(83380400001)(26005)(41300700001)(1076003)(70586007)(86362001)(336012)(186003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:38:29.8101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a16186da-da01-482e-ed58-08db8f2cdfd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5489

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To simplify the unnecessary use of container_of() on the struct
iommu_domain to get the container structure.

No functional changes intended.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
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
index 3c14c49d6d72..f5a05779573f 100644
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
@@ -2642,10 +2637,8 @@ static int __amd_iommu_flush_page(struct protection_domain *domain, u32 pasid,
 	return __flush_pasid(domain, pasid, address, false);
 }
 
-int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
-			 u64 address)
+int amd_iommu_flush_page(struct protection_domain *domain, u32 pasid, u64 address)
 {
-	struct protection_domain *domain = to_pdomain(dom);
 	unsigned long flags;
 	int ret;
 
@@ -2663,9 +2656,8 @@ static int __amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid)
 			     true);
 }
 
-int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
+int amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid)
 {
-	struct protection_domain *domain = to_pdomain(dom);
 	unsigned long flags;
 	int ret;
 
@@ -2742,10 +2734,9 @@ static int __clear_gcr3(struct protection_domain *domain, u32 pasid)
 	return __amd_iommu_flush_tlb(domain, pasid);
 }
 
-int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
+int amd_iommu_domain_set_gcr3(struct protection_domain *domain, u32 pasid,
 			      unsigned long cr3)
 {
-	struct protection_domain *domain = to_pdomain(dom);
 	unsigned long flags;
 	int ret;
 
@@ -2757,9 +2748,8 @@ int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
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

