Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F971C30
	for <iommu@lists.linux.dev>; Thu, 25 Aug 2022 06:40:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNUZ2343kY5su8pNPa7+GnCSIR7hvw9IHUatHBbdvRiO6fCm3J9DEpq0ty2xhcq1DmJFeXKiZtTkc0uV8ceokY/kk6kYT0NJS1ifLM45VWKM7MHavhrTRzuvzCLdmiVCaL7sOOAeM8+P+tBkIjM+XoUMsQRgQdCCXO8hInKXslRLzB0UMVtYhdE334GoWuurpQfWTehPrzq0Ca3w8Zm067bJQUwF/qtxxfW0qQ34NWzPAHCtP+o3cMM+SUfJUAH8QcTYNB+v+fLRENDKCHeyh62GFODL6NN1Jbho7nDkAKI4j/4ABXnk+JtVnVB3CALbOq+IScofCjvSXgCW/F7cpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80Pwk4KhTYrv30cIjc69KrNZeJ595gjC366CTNftJEA=;
 b=cZXtsDKlEece7xlCjuDpq7DOS+P2NOkkHzmqUfa1z7O86AyMHw7lqBew5ykzvQ6cZWNVduzbG192Up0sdMgb0mrdXQpirmODQm9A4xvVV9VqaYx8Rd83feP+o4Qv/Cb4T0NFiOk6MqR+K279pp88vwG7NfXlZdpzjiBZpNGCYyy6SA+1AJGISqS2HqsgM0HhGoVHSI3svRLCWTeg3hBmskqL5Tf+PMsC1Ci/wPTBpHPTtit9NYUbEnfTKpL9GPnlsZKMhPJFe0PQvY6dm1wwrYBNStx2nIdo94TeaTcbglFnVsbN45jjDINBQ0/s05CPNRZ7TbzgibFxeFS9M+63xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80Pwk4KhTYrv30cIjc69KrNZeJ595gjC366CTNftJEA=;
 b=sPmRfwP4GXLCOXnYuwYfAZvJ1aDVSN9z8PO/R1szahG5HCbM/nWwVjdZeiHcRw4qosCplcC7saC8PwfbNYdds49VMMdhGAsq5Ey6dCBzPnNvzOZVibi8n/iGTXnq2pLm0eHZ+JPAbVTYMkX/FkIlMxVd6NoTDe/hXVSzTdsdb5s=
Received: from MW4PR04CA0099.namprd04.prod.outlook.com (2603:10b6:303:83::14)
 by LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Thu, 25 Aug
 2022 06:40:42 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::15) by MW4PR04CA0099.outlook.office365.com
 (2603:10b6:303:83::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19 via Frontend
 Transport; Thu, 25 Aug 2022 06:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 06:40:41 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 25 Aug
 2022 01:40:38 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <robin.murphy@arm.com>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 1/9] iommu/amd/io-pgtable: Implement map_pages io_pgtable_ops callback
Date: Thu, 25 Aug 2022 06:39:31 +0000
Message-ID: <20220825063939.8360-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825063939.8360-1-vasant.hegde@amd.com>
References: <20220825063939.8360-1-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d3e0845-e90a-4b32-739f-08da8664bb0d
X-MS-TrafficTypeDiagnostic: LV2PR12MB5989:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9fS5GkvmJFtTGhH4u+EE/9gPjfjs+OmZTq0q7hnpijkmgAhMpAlkmL8jBJDkBhJFCnTpkpZWMQiP7BTEN7KBB/lCm1l4q1FRbKBdZjFUpcePj59oLfxPiBDI/Tus4g67mZxI5driKQ7YYgMKIqYAURUi0DoZCduzNeNJzq6uZj5W/7G0CCnlhypbKkj0nRk/ZqF8MXIe0hAS550zFRynHuvSeF2iUlhK6LnOnBJbW3Kw0Z3R9o1TNxjRyNM+1mRP2sNGckdaapJEwISjdD2/nw1dN9rHRvI9DvGLHUze6jZgCSU59j0LUBmYy8rQ+IqJ2NGqP9yOsUo5TDPe63RHm3XyaL5CVQTXryrRVGdK6oKfxqi1r2Wkif8Bn9g62gDDk+Mv9l5KE4EzBhS3CCvAmPyR3WJFVGtadabqxoG5kqA64sBo54b5zJ2ieIqFWyHkR1Jw24L2JNV89bP2nxEIkexNp8Lil2zQbg4hETQY3dC+5vM/VF1iEBb1UVqdS16Rs2LYc56wWbHusk+fLOpNIKBXe9aTVzFpXqy67cLlkNUJFAu8fGoCTT7iT2I5Agm27a0zIiRP62HnBib7zaPzabTV7iVaAVAMUXslBhY6+c4Lqh7IqJi4VuV+m4hs5vyCVrrEZueo/6zywrMexqwCacOku4kzrFI7IssHjoYRsAuRtL6i5Ypq9ERZFmY+uXTB7nao0GCPbISaeaWo+fGT82LjNh69oiBaBuRqLLY1RP6p/iWEpirX0zl8KRoU6VOdovOA69hVYbMfNaMarDFl//QPsOEPk8woEafT03Ni3mghQBAHdN5BmcMHbnbHLJzp
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(39860400002)(396003)(46966006)(40470700004)(36840700001)(426003)(6666004)(26005)(478600001)(7696005)(16526019)(47076005)(186003)(41300700001)(8936002)(2906002)(82310400005)(5660300002)(83380400001)(316002)(40460700003)(40480700001)(336012)(54906003)(110136005)(44832011)(8676002)(2616005)(4326008)(70206006)(86362001)(82740400003)(36860700001)(356005)(70586007)(81166007)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 06:40:41.7544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3e0845-e90a-4b32-739f-08da8664bb0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989

Implement the io_pgtable_ops->map_pages() callback for AMD driver.
Also deprecate io_pgtable->map callback.

Suggested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/io_pgtable.c | 59 ++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
index 7d4b61e5db47..df7799317f66 100644
--- a/drivers/iommu/amd/io_pgtable.c
+++ b/drivers/iommu/amd/io_pgtable.c
@@ -360,8 +360,9 @@ static void free_clear_pte(u64 *pte, u64 pteval, struct list_head *freelist)
  * supporting all features of AMD IOMMU page tables like level skipping
  * and full 64 bit address spaces.
  */
-static int iommu_v1_map_page(struct io_pgtable_ops *ops, unsigned long iova,
-			  phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
+static int iommu_v1_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
+			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
+			      int prot, gfp_t gfp, size_t *mapped)
 {
 	struct protection_domain *dom = io_pgtable_ops_to_domain(ops);
 	LIST_HEAD(freelist);
@@ -369,39 +370,47 @@ static int iommu_v1_map_page(struct io_pgtable_ops *ops, unsigned long iova,
 	u64 __pte, *pte;
 	int ret, i, count;
 
-	BUG_ON(!IS_ALIGNED(iova, size));
-	BUG_ON(!IS_ALIGNED(paddr, size));
+	BUG_ON(!IS_ALIGNED(iova, pgsize));
+	BUG_ON(!IS_ALIGNED(paddr, pgsize));
 
 	ret = -EINVAL;
 	if (!(prot & IOMMU_PROT_MASK))
 		goto out;
 
-	count = PAGE_SIZE_PTE_COUNT(size);
-	pte   = alloc_pte(dom, iova, size, NULL, gfp, &updated);
+	while (pgcount > 0) {
+		count = PAGE_SIZE_PTE_COUNT(pgsize);
+		pte   = alloc_pte(dom, iova, pgsize, NULL, gfp, &updated);
 
-	ret = -ENOMEM;
-	if (!pte)
-		goto out;
+		ret = -ENOMEM;
+		if (!pte)
+			goto out;
 
-	for (i = 0; i < count; ++i)
-		free_clear_pte(&pte[i], pte[i], &freelist);
+		for (i = 0; i < count; ++i)
+			free_clear_pte(&pte[i], pte[i], &freelist);
 
-	if (!list_empty(&freelist))
-		updated = true;
+		if (!list_empty(&freelist))
+			updated = true;
 
-	if (count > 1) {
-		__pte = PAGE_SIZE_PTE(__sme_set(paddr), size);
-		__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_PR | IOMMU_PTE_FC;
-	} else
-		__pte = __sme_set(paddr) | IOMMU_PTE_PR | IOMMU_PTE_FC;
+		if (count > 1) {
+			__pte = PAGE_SIZE_PTE(__sme_set(paddr), pgsize);
+			__pte |= PM_LEVEL_ENC(7) | IOMMU_PTE_PR | IOMMU_PTE_FC;
+		} else
+			__pte = __sme_set(paddr) | IOMMU_PTE_PR | IOMMU_PTE_FC;
 
-	if (prot & IOMMU_PROT_IR)
-		__pte |= IOMMU_PTE_IR;
-	if (prot & IOMMU_PROT_IW)
-		__pte |= IOMMU_PTE_IW;
+		if (prot & IOMMU_PROT_IR)
+			__pte |= IOMMU_PTE_IR;
+		if (prot & IOMMU_PROT_IW)
+			__pte |= IOMMU_PTE_IW;
 
-	for (i = 0; i < count; ++i)
-		pte[i] = __pte;
+		for (i = 0; i < count; ++i)
+			pte[i] = __pte;
+
+		iova  += pgsize;
+		paddr += pgsize;
+		pgcount--;
+		if (mapped)
+			*mapped += pgsize;
+	}
 
 	ret = 0;
 
@@ -514,7 +523,7 @@ static struct io_pgtable *v1_alloc_pgtable(struct io_pgtable_cfg *cfg, void *coo
 	cfg->oas            = IOMMU_OUT_ADDR_BIT_SIZE,
 	cfg->tlb            = &v1_flush_ops;
 
-	pgtable->iop.ops.map          = iommu_v1_map_page;
+	pgtable->iop.ops.map_pages    = iommu_v1_map_pages;
 	pgtable->iop.ops.unmap        = iommu_v1_unmap_page;
 	pgtable->iop.ops.iova_to_phys = iommu_v1_iova_to_phys;
 
-- 
2.31.1

