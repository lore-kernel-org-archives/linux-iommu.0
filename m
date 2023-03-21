Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E7279C7
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 09:24:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xby/EWlteHge8rMC4LVTNHbuqFRRLvSBPdcvgQB5YqNhtpmtenzQ4Tu+7mBoGHIc/uWRVkLUVYSc1/P7Y87a9W2uRZBcF+c3vvGBUC88KhCi/eJlkHeHzFYstMDmIeLI/DBw4yEAMAPUzngRtpD1k/wbpC/aAFAs7guaf5vsElCPx4LS6Lx/PLeu13jj9UEU/Vytc8TreEVpMa7yG3W1cCL1fzJ3XWCaX7i+WqpJLxxSEnWHbmusutpBOuuwg7r2JBT6XMznyxsxvPYWCC5NrKspTtcJnFZyFmppvdQewUH3vxtUFMoQ18fM4cRTwa95UOl+AN4U9VfD/mM3EZtJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjryidJYpfXMWOg/lfArrEW6Gsx5Y/5mnSm3lpWrDD0=;
 b=Xv0+itcV4S9M/FG/WkKeVg/Nl1dwu5mv0kIgMyImGGni8/MoRzyc+nNnmQS0OA8XBpDz8vSW9JuTc7UYjinlK0iHQZTweFZfp3XovC8R9A4sgAHqz/giz56qARuuk0JQIyjn8l94HaLGIEDyt7Xl+HoqsuPucSHwCk+2gdnO0l7YsA3qKc7ImsAZ70RYAit2OLbhDTdehU4kfKll91f1EsIFpsxlh7x2Q4ku36cyez7YPEwOt+L8PPiA7VXwzjfMGIVF9U4EkCcjAVVHQxAnTnpvrvy6bqFz6zu/PR4RmOc8KxENLtNO6DbjJ5Xg+xma0CYUOiVMURJliBegcOx99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjryidJYpfXMWOg/lfArrEW6Gsx5Y/5mnSm3lpWrDD0=;
 b=mP/YOek1rO6eAiKMn3pBse0AuIvY9s+4j2LhzryCW2olsesMQB37L22Nhv+lIYa1LGldAvtslKxlR5IuRwthSfHr6ljzxjLBH/C0RNtxzHj3OUJDOzHD/chbezUdDlL3KeR+S+/Z3B93euwkhuR2OYj8imDWVGiIJirCC+tRafU=
Received: from BN9P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::22)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 09:24:30 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::17) by BN9P220CA0017.outlook.office365.com
 (2603:10b6:408:13e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 09:24:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 09:24:30 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Mar
 2023 04:24:18 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <aik@amd.com>,
	<baolu.lu@linux.intel.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 1/2] iommu/amd: Allocate page table using numa locality info
Date: Tue, 21 Mar 2023 09:23:47 +0000
Message-ID: <20230321092348.6127-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321092348.6127-1-vasant.hegde@amd.com>
References: <20230321092348.6127-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT013:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 41d71d08-ed38-48e2-3967-08db29ee1367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kWZrhmEh9PWPBmrL6CgluznSzyFkW8Plckqn1JI2bjncwwiDwIppRi4zezha+BlFEPmLNbfhKvA2kCUFcgAcRzb7FZm/tKTiV7mT43vzGHmrkhgJgbDWru1PYPovNTKGXt8qFLc09PP3h5bRCaL3mwizs4nDeG3hjyazLSYM98p1v1CMXxI0GnDLfhm+n1zYXnkd0klQy/UZ6kNHwd8X7cK95Jm0OpbAlDKedUSsVr+OuJ83eEN5ZEQ6PGykbhDdcqN9YEsr3Ncv5fubkzWLIbyHB43oBqJGoSWXC7Lnx8xd8n2nfngTU/71fLYfSYxPOOxQo6ZN+dF7Lu8OZyB6fv7hvCHOf3EYa9Tq3/v1IFSAjeg4c2cvqDHEEA+bEzoiil5nJCHvnmgTsvClbvR0K/a68x6IcGzHiER2qwqCXg279UEASQLt4LXIZx7kRellt5IKvB3svGcJxyXUohNZ1mIQ2sqUFsIySGwmhgQC5pv9LkHF20KU98+QCdSBMpz0acOShvoIgx+BtwTp34ix4TV+o6Mad3SWfV7dBG/feVyQmKF9xXYCrcr5A1eKxDo75Q2L3zBOlcrKersztRy7JwAT8EiERvPujnUbMt3agOWdFb73wfUHqA/AgJU3LZAYpleKI3T+hPRAxN8xS/xy6B0suB44LbAaSFqfCawsesOVQKjCHeN1n1xkRPUHYLaBAhJjdCkyAND4lRFng7gWk/FwSCBnBw6a1JMlalcYT+w=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199018)(36840700001)(40470700004)(46966006)(82740400003)(2906002)(81166007)(356005)(47076005)(478600001)(82310400005)(426003)(40460700003)(7696005)(186003)(83380400001)(2616005)(16526019)(86362001)(40480700001)(36756003)(316002)(54906003)(41300700001)(6666004)(4326008)(5660300002)(8676002)(70206006)(70586007)(336012)(8936002)(110136005)(44832011)(1076003)(26005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 09:24:30.7075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d71d08-ed38-48e2-3967-08db29ee1367
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880

Introduce 'struct protection_domain->nid' variable. It will contain
IOMMU NUMA node ID. And allocate page table pages using IOMMU numa
locality info. This optimizes page table walk by IOMMU.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  8 ++++++++
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/io_pgtable.c      |  4 ++--
 drivers/iommu/amd/io_pgtable_v2.c   | 16 ++++++----------
 drivers/iommu/amd/iommu.c           |  6 ++++++
 5 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index c160a332ce33..20a142b54498 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -122,6 +122,14 @@ static inline int get_pci_sbdf_id(struct pci_dev *pdev)
 	return PCI_SEG_DEVID_TO_SBDF(seg, devid);
 }
 
+static inline void *alloc_pgtable_page(int nid, gfp_t gfp)
+{
+	struct page *page;
+
+	page = alloc_pages_node(nid, gfp | __GFP_ZERO, 0);
+	return page ? page_address(page) : NULL;
+}
+
 extern bool translation_pre_enabled(struct amd_iommu *iommu);
 extern bool amd_iommu_is_attach_deferred(struct device *dev);
 extern int __init add_special_device(u8 type, u8 id, u32 *devid,
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 3d684190b4d5..e5cfdeaaad48 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -549,6 +549,7 @@ struct protection_domain {
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
 	int glx;		/* Number of levels for GCR3 table */
+	int nid;		/* Node ID */
 	u64 *gcr3_tbl;		/* Guest CR3 table */
 	unsigned long flags;	/* flags to find out type of domain */
 	unsigned dev_cnt;	/* devices assigned to this domain */
diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index ace0e9b8b913..1b67116882be 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -156,7 +156,7 @@ static bool increase_address_space(struct protection_domain *domain,
 	bool ret = true;
 	u64 *pte;
 
-	pte = (void *)get_zeroed_page(gfp);
+	pte = alloc_pgtable_page(domain->nid, gfp);
 	if (!pte)
 		return false;
 
@@ -250,7 +250,7 @@ static u64 *alloc_pte(struct protection_domain *domain,
 
 		if (!IOMMU_PTE_PRESENT(__pte) ||
 		    pte_level == PAGE_MODE_NONE) {
-			page = (u64 *)get_zeroed_page(gfp);
+			page = alloc_pgtable_page(domain->nid, gfp);
 
 			if (!page)
 				return NULL;
diff --git a/drivers/iommu/amd/io_pgtable_v2.c b/drivers/iommu/amd/io_pgtable_v2.c
index 8638ddf6fb3b..9f8b423f7630 100644
--- a/drivers/iommu/amd/io_pgtable_v2.c
+++ b/drivers/iommu/amd/io_pgtable_v2.c
@@ -46,11 +46,6 @@ static inline bool is_large_pte(u64 pte)
 	return (pte & IOMMU_PAGE_PSE);
 }
 
-static inline void *alloc_pgtable_page(void)
-{
-	return (void *)get_zeroed_page(GFP_KERNEL);
-}
-
 static inline u64 set_pgtable_attr(u64 *page)
 {
 	u64 prot;
@@ -138,8 +133,8 @@ static void free_pgtable(u64 *pt, int level)
 }
 
 /* Allocate page table */
-static u64 *v2_alloc_pte(u64 *pgd, unsigned long iova,
-			 unsigned long pg_size, bool *updated)
+static u64 *v2_alloc_pte(int nid, u64 *pgd, unsigned long iova,
+			 unsigned long pg_size, gfp_t gfp, bool *updated)
 {
 	u64 *pte, *page;
 	int level, end_level;
@@ -162,7 +157,7 @@ static u64 *v2_alloc_pte(u64 *pgd, unsigned long iova,
 		}
 
 		if (!IOMMU_PTE_PRESENT(__pte)) {
-			page = alloc_pgtable_page();
+			page = alloc_pgtable_page(nid, gfp);
 			if (!page)
 				return NULL;
 
@@ -262,7 +257,8 @@ static int iommu_v2_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
 
 	while (mapped_size < size) {
 		map_size = get_alloc_page_size(pgsize);
-		pte = v2_alloc_pte(pdom->iop.pgd, iova, map_size, &updated);
+		pte = v2_alloc_pte(pdom->nid, pdom->iop.pgd,
+				   iova, map_size, gfp, &updated);
 		if (!pte) {
 			ret = -EINVAL;
 			goto out;
@@ -384,7 +380,7 @@ static struct io_pgtable *v2_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	struct protection_domain *pdom = (struct protection_domain *)cookie;
 	int ret;
 
-	pgtable->pgd = alloc_pgtable_page();
+	pgtable->pgd = alloc_pgtable_page(pdom->nid, GFP_ATOMIC);
 	if (!pgtable->pgd)
 		return NULL;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5a505ba5467e..5452d0dd6569 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1662,6 +1662,10 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	dev_data->domain = domain;
 	list_add(&dev_data->list, &domain->dev_list);
 
+	/* Update NUMA Node ID */
+	if (domain->nid == NUMA_NO_NODE)
+		domain->nid = dev_to_node(dev_data->dev);
+
 	/* Do reference counting */
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
@@ -2097,6 +2101,8 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	if (type == IOMMU_DOMAIN_IDENTITY)
 		return domain;
 
+	domain->nid = NUMA_NO_NODE;
+
 	pgtbl_ops = alloc_io_pgtable_ops(pgtable, &domain->iop.pgtbl_cfg, domain);
 	if (!pgtbl_ops) {
 		domain_id_free(domain->id);
-- 
2.31.1

