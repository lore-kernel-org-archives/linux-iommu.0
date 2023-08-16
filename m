Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0500174D0
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 17:43:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YbZxTUt+Kam2SS7fFQ20s6BW2ccStx8S2nL65oS6zpLCOeJmKDT+5OC7+BIgxe5t8nedAQ5cKuaxSSBIUHQlQJiAKyOqfFf325nkDVr+KQTsfoDWeDprAaL2tqVrTULLkKRg+CZnRWK7IcxhddB3hiRvBXlqvO2e8hzybhL+C84oJbHb9VFugfEYCe0igvCFKN7ioblaCC+4pO/ZPkQRJtowUroQ1k0sVEiZaxQtTnZ9feXiLmKyzIKzE/y8Roy6N13QY+V5ynI5Pr5sLwmme8ShPJ+qBoqi5+/FfvyO7KuRPNB2Dnm1Ic1Du61w+xn1HR2njJuh51EUc2NXPKcjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfxlmSsHMe19cVp7KIkrbqEhWFA7keLc1IX0wNZfHEA=;
 b=lVO/rkXFwziD49L5eDPBEDRFQ2IdYdTH4ySSYLQ8xV7KoRDdIXV7WwmQ3RCEMxeu19dP+EQyM6e5ALKMRF1cMco5bWCTJHpjY2D9j5tNAsVF5tWPVWj/ot1qDWK91RHUjnhBMKE7vEYLjx4ceCHWB1lehNIlUdVbNBV4zvVCiR7j95YXov6fl4AIpxMM4Km6JT6L0FEijQoftg4scnuE7uFMcsp4kULOhiA2azfS9Pvu9h1fNYhdTpWODmEwV3d0s63DsoHEbqIHjkv1ZMOFRpiMDIb5ca15dD7uHcNpr/icM2wFGc2RknIwISrbRqelezJtw691eHWaqpqkxbWW3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfxlmSsHMe19cVp7KIkrbqEhWFA7keLc1IX0wNZfHEA=;
 b=hm+4k/uyAIbdnJB2gRFulgAXnmV5r8NXSWb31EOYlR2ub+NL2qI3J6qM6VHRyLP8h8T95TlPCQzcsSEHioJmiTcGAGhIkf2bVUyFY01DsXeqrcBfRqwzQIR1zynZgLNECawiOyxjZfM836Yx4RiNThTcyi6QBb7TBA6fZ0S3NFI=
Received: from SJ0PR03CA0095.namprd03.prod.outlook.com (2603:10b6:a03:333::10)
 by CY5PR12MB6083.namprd12.prod.outlook.com (2603:10b6:930:29::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 17:43:18 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::2c) by SJ0PR03CA0095.outlook.office365.com
 (2603:10b6:a03:333::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 17:43:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 17:43:17 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 12:43:14 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 09/10] iommu/amd: Refactor GCR3 table helper functions
Date: Wed, 16 Aug 2023 17:40:30 +0000
Message-ID: <20230816174031.634453-10-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|CY5PR12MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f65a5d3-f42e-4529-7784-08db9e804665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5Zm7iEczlNnQKWrHbtIKcj5K1UnaPSWK36qhsvtWuMbUxBveMro1zV1i1t0OPXlA9UDME44fDBofSQd3+WETu1IqohIyt8U4tRg0YYF5XUecGnz8cFl2p80TX9ySBJXuMOZ/HtlAZgEDGbDp32JOSuaBVOU8A2dv7ku8Iar0wbGBzzScsbAFG+f4nAdTxPP82slW+2vyJ0Z01rL25bTRZkchERLMilWFZ3ode8gzKZi+/5H63Uz5ZB1ghBNSw8JJB2T3ddRUjW+7jaxfs56CIGBdQRcR6y8yYbAzdDH8r53OPWfm4uxQo1IVFt4qGrvdKB5u2lLxiSFQsUqznS5OpHDHcjnC4shl6SpZwAZpfzWRzdC7/VzVvRqQcaMhk3gasxTft8Wt9bQdlQ/KJAh4XeIsCm64Zqu+zsxJfMvBBZrFvX6pLZo5cqssAied+4DVBTmRLA62fqOcr48+QtZQqvMMFqOqYRzk9ZoKOK4E9hsGQ4NWpkCZnv8tigWy+rooSj0nSixpSYc14ZVTTqqmEBO0OZ7nE3fk6ttA84UbvSeOFqUifD4h8NvKxIeaT8mCsNB6lflWeJyzqA1+Syc2nNwcmGznftCIGhIxC/pPlNCbC8QmzeBACnTzdueKox/rs4XnTmSVQgmJh3glttXAO6BG2w8rJjp2Rs6h54Y5heEIQCfnjPfMf4mKsJdBHVqk/XM1cFSbMX0LmfsUE1SN6JAn1ZJTo1WfX1IKuBe08ReE0iPHIiwHBr8cPFGERGsvR//j3htS7PhQWE6q8LsxvQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(5660300002)(44832011)(36860700001)(41300700001)(356005)(54906003)(82740400003)(316002)(81166007)(70206006)(70586007)(110136005)(8676002)(8936002)(4326008)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:43:17.5395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f65a5d3-f42e-4529-7784-08db9e804665
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6083

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To use the new per-device struct gcr3_tbl_info. Also modify
set_dte_entry() to use new per device GCR3 table.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 76 ++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index be68d77861f5..8d3d520a525a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -77,6 +77,11 @@ struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
 
+static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
+			  struct gcr3_tbl_info *gcr3_info,
+			  struct protection_domain *domain, bool ats,
+			  bool ppr);
+
 static int __set_gcr3(struct iommu_dev_data *dev_data,
 		       u32 pasid, unsigned long gcr3);
 
@@ -1659,16 +1664,27 @@ static void free_gcr3_tbl_level2(u64 *tbl)
 	}
 }
 
-static void free_gcr3_table(struct protection_domain *domain)
+static void free_gcr3_table(struct iommu_dev_data *dev_data)
 {
-	if (domain->glx == 2)
-		free_gcr3_tbl_level2(domain->gcr3_tbl);
-	else if (domain->glx == 1)
-		free_gcr3_tbl_level1(domain->gcr3_tbl);
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
+
+	if (gcr3_info->glx == 2)
+		free_gcr3_tbl_level2(gcr3_info->gcr3_tbl);
+	else if (gcr3_info->glx == 1)
+		free_gcr3_tbl_level1(gcr3_info->gcr3_tbl);
 	else
-		BUG_ON(domain->glx != 0);
+		WARN_ON_ONCE(gcr3_info->glx != 0);
 
-	free_page((unsigned long)domain->gcr3_tbl);
+	gcr3_info->glx = 0;
+
+	set_dte_entry(iommu, dev_data->devid, NULL, dev_data->domain,
+		      dev_data->ats_enabled, dev_data->ppr);
+	clone_aliases(iommu, dev_data->dev);
+	device_flush_dte(dev_data);
+
+	free_page((unsigned long)gcr3_info->gcr3_tbl);
+	gcr3_info->gcr3_tbl = NULL;
 }
 
 /*
@@ -1687,28 +1703,37 @@ static int get_gcr3_levels(int pasids)
 	return levels ? (DIV_ROUND_UP(levels, 9) - 1) : levels;
 }
 
-/* Note: This function expects iommu_domain->lock to be held prior calling the function. */
-static int setup_gcr3_table(struct protection_domain *domain, int pasids)
+static int setup_gcr3_table(struct iommu_dev_data *dev_data, int pasids)
 {
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
 	int levels = get_gcr3_levels(pasids);
 
 	if (levels > amd_iommu_max_glx_val)
 		return -EINVAL;
 
-	domain->gcr3_tbl = alloc_pgtable_page(domain->nid, GFP_ATOMIC);
-	if (domain->gcr3_tbl == NULL)
+	if (gcr3_info->gcr3_tbl)
+		return -EBUSY;
+
+	gcr3_info->gcr3_tbl = alloc_pgtable_page(dev_to_node(dev_data->dev),
+						 GFP_ATOMIC);
+	if (gcr3_info->gcr3_tbl == NULL)
 		return -ENOMEM;
 
-	domain->glx      = levels;
-	domain->flags   |= PD_IOMMUV2_MASK;
+	gcr3_info->glx = levels;
 
-	amd_iommu_domain_update(domain);
+	set_dte_entry(iommu, dev_data->devid, &dev_data->gcr3_info,
+		      dev_data->domain, dev_data->ats_enabled, dev_data->ppr);
+	clone_aliases(iommu, dev_data->dev);
+	device_flush_dte(dev_data);
 
 	return 0;
 }
 
 static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
-			  struct protection_domain *domain, bool ats, bool ppr)
+			  struct gcr3_tbl_info *gcr3_info,
+			  struct protection_domain *domain, bool ats,
+			  bool ppr)
 {
 	u64 pte_root = 0;
 	u64 flags = 0;
@@ -1738,9 +1763,9 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 	if (ppr)
 		pte_root |= 1ULL << DEV_ENTRY_PPR;
 
-	if (domain->flags & PD_IOMMUV2_MASK) {
-		u64 gcr3 = iommu_virt_to_phys(domain->gcr3_tbl);
-		u64 glx  = domain->glx;
+	if (gcr3_info && gcr3_info->gcr3_tbl) {
+		u64 gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
+		u64 glx  = gcr3_info->glx;
 		u64 tmp;
 
 		pte_root |= DTE_FLAG_GV;
@@ -1768,7 +1793,7 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 				((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
 		}
 
-		if (domain->flags & PD_GIOV_MASK)
+		if (gcr3_info->giov)
 			pte_root |= DTE_FLAG_GIOV;
 	}
 
@@ -1815,7 +1840,7 @@ static int _init_gcr3_tbl(struct iommu_dev_data *dev_data)
 	 * By default, setup GCR3 table to support MAX PASIDs
 	 * support by the IOMMU HW.
 	 */
-	return setup_gcr3_table(dev_data->domain, -1);
+	return setup_gcr3_table(dev_data, -1);
 }
 
 static inline void _destroy_gcr3_tbl(struct iommu_dev_data *dev_data)
@@ -1823,7 +1848,7 @@ static inline void _destroy_gcr3_tbl(struct iommu_dev_data *dev_data)
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 
 	gcr3_info->giov = false;
-	free_gcr3_table(dev_data->domain);
+	free_gcr3_table(dev_data);
 }
 
 static int do_attach(struct iommu_dev_data *dev_data,
@@ -1864,8 +1889,8 @@ static int do_attach(struct iommu_dev_data *dev_data,
 	}
 
 	/* Update device table */
-	set_dte_entry(iommu, dev_data->devid, domain,
-		      ats, dev_data->ppr);
+	set_dte_entry(iommu, dev_data->devid, &dev_data->gcr3_info,
+		      domain, ats, dev_data->ppr);
 	clone_aliases(iommu, dev_data->dev);
 
 	device_flush_dte(dev_data);
@@ -2068,8 +2093,9 @@ static void update_device_table(struct protection_domain *domain)
 
 		if (!iommu)
 			continue;
-		set_dte_entry(iommu, dev_data->devid, domain,
-			      dev_data->ats_enabled, dev_data->ppr);
+
+		set_dte_entry(iommu, dev_data->devid, &dev_data->gcr3_info,
+			      domain, dev_data->ats_enabled, dev_data->ppr);
 		clone_aliases(iommu, dev_data->dev);
 	}
 }
-- 
2.31.1

