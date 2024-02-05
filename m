Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB041B597
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134677; cv=fail; b=CXqwpMzLGn4sBHR302lUPUnsUGy7/sOXIEteZA41fYyCTOrmlFsP7yNB01FbBHiFV70um8B6lsk1c6LmNk/PPzOrGmn4x06WrOuFpy1VUjeoU4bZy9lEd6BcOxwlAzctSFiv5WRwmTgr7zbroqIskJ+Q80f9lL9cj8LVsSS7eyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134677; c=relaxed/simple;
	bh=L2moDP9mZdY4YnLNhMDMs/h7TzV/2wI/WDWOENoi1kc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVo45csk+AgkrxlBkKjIxQif5K8DgpPXWjMVaAgjlRSuREOTqhAsw+Yx+kuu84hsst91Pc5C8DkW3KCODsD5x6bzWQDIk09+u13ygIH/j48tZ2iJrjxpsLJel4zYN0jtoxfFxLnKVAnq26tg80ndRwOdRCEN/4uWV68bflFtxwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p9hFoNgq; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p9hFoNgq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDG9ULJi+1CQi59gvmNbi1kwQnTUQvt+cJ0QVNhoKot5zIEmAWjLm8ystH4kYjiy+U9KXfhPexw/d3+Q9jKKUA4XK4s/mbIqDkXVLwY46nwTtEpXPXhvFfFWUQSux1lYJXG/TN1nkTL8wbBdx6XJEDFg63HmCrcpuFQiG9iXoaLgxWjaxHMPNxew8OFDx4oqRFP7ENC+uhwi63yX6DIl5TAY1BG58oQgHazsIUYNlHvOiXjv7XvBFNWsy0raOSSzSvCx0iQZVZ1pRiHKNXVMFeGThaHzLOZ2kWpG5LTRo2zH0Yd0v6bSApSvoca0inb4TSQbsp1gG+WdZuaETaCJ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQdUodQtPrGVtBmDpBw9vDjw1YoaSSDRnIqfQPnS2CI=;
 b=BPLFRdA7zIWSRqqOM+9GBn+Sg9ByWCM+86sCjRUzPt4AIqUZlJcbhuzycbSVwLXcnGX0OfjLBIjI3QnGyo8LFX1kIU2+HGXKf73a5RAiXsAgI68m+YoLa+isJJWd6MgotCVDEEklvYyeX1TTAFZZcNiFpAD2WgY3MDV1UekymGB1j3LRtiDnY7vRjxJ6G98/7WJ8OAXYvPkfAwr2h+ElHD0lQSCxOPfDikyrcunlBUhgwCEYOgveapK1P0dCR5wt5modChSmgLYDpESQPSzCyHVnkdg0kpwnwSeBrExTn8YvJSkyBEyfOSYNasZXmRh7IEbMSuxHRK5xEtWNjBrUtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQdUodQtPrGVtBmDpBw9vDjw1YoaSSDRnIqfQPnS2CI=;
 b=p9hFoNgq8vW/pWZkEAQWdJCM08Fg2mMM3Lee68hmvJMNOChZeVhrMbZwlGwmMMbky75M78vz2gsjQjfJTdRx7IlmnWOxv0hqrgrnjq4sbZSvKotJqr4yjmBQvFxBBVB0EAlfqs0L9VcD+Tb9TaXEnJS/XDNleuPiY0WyFBmlaE4=
Received: from BN9PR03CA0842.namprd03.prod.outlook.com (2603:10b6:408:13d::7)
 by DS0PR12MB7827.namprd12.prod.outlook.com (2603:10b6:8:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Mon, 5 Feb
 2024 12:04:31 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::ff) by BN9PR03CA0842.outlook.office365.com
 (2603:10b6:408:13d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Mon, 5 Feb 2024 12:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 12:04:30 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 06:04:27 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 17/17] iommu/amd: Introduce per-device domain ID to fix potential TLB aliasing issue
Date: Mon, 5 Feb 2024 11:56:15 +0000
Message-ID: <20240205115615.6053-18-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205115615.6053-1-vasant.hegde@amd.com>
References: <20240205115615.6053-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|DS0PR12MB7827:EE_
X-MS-Office365-Filtering-Correlation-Id: 788fcd2b-53f8-4830-ade3-08dc26429bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uNv+lKHsQOtYT9wlGvPIAGUgCC2pc/Mum7AEOHnEaBFbyCxTOZZn83m/Xl5WlfUGYFQpAVpGKkevx9DF+qpFLwRDYProE91wmuPrelRrm1biNoe+aIPB/2vruoTp5AZSXtBZ2PhVnbExO/ELUr98G5MUQOEiqyyxxBec5yXABr8YH1Cz1dNXq/6bQ/ZzvTo4u2FXxElckTdyzFE+J+H6T4yrqnGteWWCmPcnOlBYd4d5mVL1IUtHA4iISdh9+nBk+JM67S49I+Ore1zPge/M0Alxm/Kn3yU/Kk1rHUo3PqYHPdJqaPnGeArhoa/XgBpR/9FaKl6qxLbx6wrwp+p2KMgN4t8fKKUTT8FnQp6n+0bXpc5Gz++oaGOKG4/o1wHQ8kyoGcoh+uvg6zPKNJfmjCXmE2Ea2T0SmyCOoGG5//VVZ9N0r4BKPgcaRRGTWOh5ykaueIKMoF3/w6odlDcuXS69BsUtnaSVOLhhyUarPgRT7PgqS3ZHO5gpwjKp/bCYiAnc9YHASCw0g3kOTgAHigZlZlRfEJndO4twwt5X5FA9vcaXMlpQgjr+gcwp0GvIlWUoAzhwq2Qj7OBscOuWqvo8Xn+4AXdSAx6ywRotzumPkIiI+2HQZksppOypL2e+tA4lRF68RGNFB9jmMRM3VrwqICSMyG0K7idy/qN3abRMKC9GgPnz0ekBCND03IAWvFFvu7H6WU40klyME9tPwvyNs1Aq116WLRcPFXderbM/FSMGKqFHUDCsUVLvB1tN/lNihBu9JzvSpcXa/8n0Xw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(6666004)(1076003)(83380400001)(336012)(16526019)(26005)(426003)(40460700003)(40480700001)(7696005)(41300700001)(44832011)(36860700001)(70586007)(5660300002)(110136005)(54906003)(316002)(2906002)(70206006)(47076005)(82740400003)(478600001)(2616005)(86362001)(356005)(81166007)(4326008)(8936002)(36756003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 12:04:30.5696
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 788fcd2b-53f8-4830-ade3-08dc26429bf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7827

With v1 page table, the AMD IOMMU spec states that the hardware must use
the domain ID to tag its internal translation caches. I/O devices with
different v1 page tables must be given different domain IDs. I/O devices
that share the same v1 page table __may__ be given the same domain ID.
This domain ID management policy is currently implemented by the AMD
IOMMU driver. In this case, only the domain ID is needed when issuing the
INVALIDATE_IOMMU_PAGES command to invalidate the IOMMU translation cache
(TLB).

With v2 page table, the hardware uses domain ID and PASID as parameters
to tag and issue the INVALIDATE_IOMMU_PAGES command. Since the GCR3 table
is setup per-device, and there is no guarantee for PASID to be unique
across multiple devices. The same PASID for different devices could
have different v2 page tables. In such case, if multiple devices share the
same domain ID, IOMMU translation cache for these devices would be polluted
due to TLB aliasing.

Hence, avoid the TLB aliasing issue with v2 page table by allocating unique
domain ID for each device even when multiple devices are sharing the same v1
page table. Please note that this fix would result in multiple
INVALIDATE_IOMMU_PAGES commands (one per domain id) when unmapping a
translation.

Domain ID can be shared until device starts using PASID. We will enhance this
code later where we will allocate per device domain ID only when its needed.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 80 +++++++++++++++++++++++------
 2 files changed, 64 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 79a07a2e4bec..d5786c33aee6 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -536,6 +536,7 @@ struct gcr3_tbl_info {
 	u64	*gcr3_tbl;	/* Guest CR3 table */
 	int	glx;		/* Number of levels for GCR3 table */
 	u32	pasid_cnt;	/* Track attached PASIDs */
+	u16	domid;		/* Per device domain ID */
 };
 
 struct amd_io_pgtable {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index bcf8f44e0860..1769f3860ea7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1447,27 +1447,37 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 	return ret;
 }
 
-/*
- * TLB invalidation function which is called from the mapping functions.
- * It invalidates a single PTE if the range to flush is within a single
- * page. Otherwise it flushes the whole TLB of the IOMMU.
- */
-static void __domain_flush_pages(struct protection_domain *domain,
+static int domain_flush_pages_v2(struct protection_domain *pdom,
 				 u64 address, size_t size)
 {
 	struct iommu_dev_data *dev_data;
 	struct iommu_cmd cmd;
-	int ret = 0, i;
-	ioasid_t pasid = IOMMU_NO_PASID;
-	bool gn = false;
+	int ret = 0;
 
-	if (pdom_is_v2_pgtbl_mode(domain))
-		gn = true;
+	list_for_each_entry(dev_data, &pdom->dev_list, list) {
+		struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
+		u16 domid = dev_data->gcr3_info.domid;
+
+		build_inv_iommu_pages(&cmd, address, size,
+				      domid, IOMMU_NO_PASID, true);
+
+		ret |= iommu_queue_command(iommu, &cmd);
+	}
 
-	build_inv_iommu_pages(&cmd, address, size, domain->id, pasid, gn);
+	return ret;
+}
+
+static int domain_flush_pages_v1(struct protection_domain *pdom,
+				 u64 address, size_t size)
+{
+	struct iommu_cmd cmd;
+	int ret = 0, i;
+
+	build_inv_iommu_pages(&cmd, address, size,
+			      pdom->id, IOMMU_NO_PASID, false);
 
 	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
-		if (!domain->dev_iommu[i])
+		if (!pdom->dev_iommu[i])
 			continue;
 
 		/*
@@ -1477,6 +1487,28 @@ static void __domain_flush_pages(struct protection_domain *domain,
 		ret |= iommu_queue_command(amd_iommus[i], &cmd);
 	}
 
+	return ret;
+}
+
+/*
+ * TLB invalidation function which is called from the mapping functions.
+ * It flushes range of PTEs of the domain.
+ */
+static void __domain_flush_pages(struct protection_domain *domain,
+				 u64 address, size_t size)
+{
+	struct iommu_dev_data *dev_data;
+	int ret = 0;
+	ioasid_t pasid = IOMMU_NO_PASID;
+	bool gn = false;
+
+	if (pdom_is_v2_pgtbl_mode(domain)) {
+		gn = true;
+		ret = domain_flush_pages_v2(domain, address, size);
+	} else {
+		ret = domain_flush_pages_v1(domain, address, size);
+	}
+
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
 
 		if (!dev_data->ats_enabled)
@@ -1552,7 +1584,7 @@ void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
 	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
 
 	build_inv_iommu_pages(&cmd, address, size,
-			      dev_data->domain->id, pasid, true);
+			      dev_data->gcr3_info.domid, pasid, true);
 	iommu_queue_command(iommu, &cmd);
 
 	if (dev_data->ats_enabled)
@@ -1727,6 +1759,9 @@ static void free_gcr3_table(struct gcr3_tbl_info *gcr3_info)
 
 	gcr3_info->glx = 0;
 
+	/* Free per device domain ID */
+	domain_id_free(gcr3_info->domid);
+
 	free_page((unsigned long)gcr3_info->gcr3_tbl);
 	gcr3_info->gcr3_tbl = NULL;
 }
@@ -1759,9 +1794,14 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 	if (gcr3_info->gcr3_tbl)
 		return -EBUSY;
 
+	/* Allocate per device domain ID */
+	gcr3_info->domid = domain_id_alloc();
+
 	gcr3_info->gcr3_tbl = alloc_pgtable_page(nid, GFP_KERNEL);
-	if (gcr3_info->gcr3_tbl == NULL)
+	if (gcr3_info->gcr3_tbl == NULL) {
+		domain_id_free(gcr3_info->domid);
 		return -ENOMEM;
+	}
 
 	gcr3_info->glx = levels;
 
@@ -1860,10 +1900,16 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	u64 flags = 0;
 	u32 old_domid;
 	u16 devid = dev_data->devid;
+	u16 domid;
 	struct protection_domain *domain = dev_data->domain;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 
+	if (gcr3_info && gcr3_info->gcr3_tbl)
+		domid = dev_data->gcr3_info.domid;
+	else
+		domid = domain->id;
+
 	if (domain->iop.mode != PAGE_MODE_NONE)
 		pte_root = iommu_virt_to_phys(domain->iop.root);
 
@@ -1876,7 +1922,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	 * When SNP is enabled, Only set TV bit when IOMMU
 	 * page translation is in use.
 	 */
-	if (!amd_iommu_snp_en || (domain->id != 0))
+	if (!amd_iommu_snp_en || (domid != 0))
 		pte_root |= DTE_FLAG_TV;
 
 	flags = dev_table[devid].data[1];
@@ -1926,7 +1972,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	}
 
 	flags &= ~DEV_DOMID_MASK;
-	flags |= domain->id;
+	flags |= domid;
 
 	old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
 	dev_table[devid].data[1]  = flags;
-- 
2.31.1

