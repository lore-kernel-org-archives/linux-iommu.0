Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F46123AF
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 09:32:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4/uvZhg9EEtXfBQD6KZiQPUKkAVerdcBhp8l91pAFF74jpUYraUkc0m4qQeNzlI6OjPHT5niAAeLAv/SidoOwy2k+zYSjqI4ekmMqS9WcFhT9svSz4XcG0h1LhwYo3CvwrengQTGCd78vKg47HMPzt4NG3SQoUrjJC0vrmKXAvOH7VzcqkR+cBVfVTt8+wKPtRQSljAJzCO7O1vtz3+uEHo2qSrE3GH3ZD3Q1kj8tRfZU3h209peNBvms2Yo4ptLD5UB/cmNUMJtLFljINl3qMqFcaDYLtc4xo91CPSAp+GdXeX8oBstpRjd/sSdduP3LEkjK11y5VsD4tR3jh15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eN65SRgRrx+iVXxhQQXgHNnTr9wVbotW+msayI76PI=;
 b=TqLDCMbDMAIj0p94h5QBYQ3ueflFWD0r2z8RvexR47jesIpfLCB/U+276UXWzMqiKi2ryQBH3ut62QKcsnK43fqMGyeb8eYohMOqu/6lG38SAIaYhF57VNFfF04dOZIeIB0TS3PGysbx/krutYSH0tkOcE0ZYU1pw/ls5CYhp32HwgykWv2FypQgULHb0r2pEMWzs00Xfl5VHbAScHAzicCyqKB9SHskPHjb8CJN+A8eKuoFaoIeiyd/reITUF31OS2QeYiRpzTgbye1ePprTGBDna9ayxFJUq1aAcGUb1WdUr1ahou7nCIXDWvWAch88klvz5tlzPGKSVol523RSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eN65SRgRrx+iVXxhQQXgHNnTr9wVbotW+msayI76PI=;
 b=z4Mx99V0ctLYtZYIQVdobWfTxwP31sQiOb+40Gdz4dCSwYsE+DUkxrcmgBU4jJ00FMBPBPV/fKFcN3mh643OPU94kWa9vWbAV9zxtgoQwtcXYmwQl7SYgsQRFz4oGhjb+kqVkx7AiubypJDeXDTmusy7frXM5GlJbyrNEh3e7vU=
Received: from CY5PR19CA0067.namprd19.prod.outlook.com (2603:10b6:930:69::11)
 by CY8PR12MB8266.namprd12.prod.outlook.com (2603:10b6:930:79::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 09:32:25 +0000
Received: from CY4PEPF0000C976.namprd02.prod.outlook.com
 (2603:10b6:930:69:cafe::f3) by CY5PR19CA0067.outlook.office365.com
 (2603:10b6:930:69::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19 via Frontend
 Transport; Fri, 10 Mar 2023 09:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C976.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 09:32:24 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 03:32:22 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 2/3] iommu/amd: Allocate page table using numa locality info
Date: Fri, 10 Mar 2023 09:31:29 +0000
Message-ID: <20230310093130.6064-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310093130.6064-1-vasant.hegde@amd.com>
References: <20230310093130.6064-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C976:EE_|CY8PR12MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b4e890-97cc-4318-d3ec-08db214a5b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	egKdcqvZBR56hHCBok04Lvn+4ew0Trh9FbmI+Tphl7DTyuqnWkCGxW0MVnRCg1DD7oS5yKH7Bd1nDTRg7eDLfNp5hh+hEcDlMdbmBh/YjenltYKNHnjgc+d06cuiikSGpNyaUzTwCEqMWdww9FQ/tihg1sO3kB+BlD9Nt9BH7H9BFxaTOKdMcTDPwpw3QqdAT5bU/v0Gb3TCizpN0FoPe4EvMLzcNdxjRKM6HPaZTNPUSB/Q5ksCxyI5BjVkk9l+Q7nM2ruAO4z09+zK4mwKoQGxVBIYfBw+5ABuaesGfZJmFgaei+uPQcN7GmEcnbCZHNYj8I/iHwHTPRcNG15Udb5wSv0G3gLhPv+N4Je97Q4DNay9a8eC2CUhmaW/b4hvBEHw7c8Eu4jSxVnrAh3L2KK6PTBlniubp3HEY7ePg/1O7UYEDtA7VS+LAEgcgs2Rk9RN+wFqBPyh1Mw3F0MzV6qIcQTRVFCV7P/dJ52JeP53mPToTDeu5L3yERPExhUAjU/62dbEhToDZkwW9BkJvdxFR1/Vs9tXZ+Lu0y8MgObKOAOHcPI2cQpaoewLwvTOnwpCkVJoLJCu7hK0xyUFd71O9txyjHFtVjQbmfyO9WavaX+wbq+ETFol3EQOKYawvcsu9IKqp2Z0mlR2hZV5IqkTo3Ou79spCtWpcNRxXE8/92S94ZcfD1W5RqX3KgrQOxbcU0G8eUztoicybCcjTJgaK5vZtn2X04lO9x5wQes=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199018)(36840700001)(46966006)(40470700004)(336012)(2616005)(82310400005)(478600001)(83380400001)(110136005)(7696005)(26005)(16526019)(186003)(54906003)(1076003)(356005)(40480700001)(82740400003)(36860700001)(47076005)(426003)(40460700003)(86362001)(2906002)(44832011)(36756003)(5660300002)(8936002)(41300700001)(70206006)(81166007)(8676002)(4326008)(70586007)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:32:24.9215
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b4e890-97cc-4318-d3ec-08db214a5b8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C976.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8266

Allocate page table pages using IOMMU numa locality info. This optimizes
page table walk by IOMMU.

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h     |  8 ++++++++
 drivers/iommu/amd/io_pgtable.c    |  4 ++--
 drivers/iommu/amd/io_pgtable_v2.c | 16 ++++++----------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index c160a332ce33..916e888a941a 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -122,6 +122,14 @@ static inline int get_pci_sbdf_id(struct pci_dev *pdev)
 	return PCI_SEG_DEVID_TO_SBDF(seg, devid);
 }
 
+static inline void *alloc_pgtable_page(int nid, gfp_t gfp)
+{
+	struct page *page;
+
+	page = alloc_pages_node(nid, gfp | GFP_ATOMIC | __GFP_ZERO, 0);
+	return page ? page_address(page) : NULL;
+}
+
 extern bool translation_pre_enabled(struct amd_iommu *iommu);
 extern bool amd_iommu_is_attach_deferred(struct device *dev);
 extern int __init add_special_device(u8 type, u8 id, u32 *devid,
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
 
-- 
2.31.1

