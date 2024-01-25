Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B130B36B10
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185202; cv=fail; b=uwOVEItW1lzmX9ohP1aGKGTT6Ty4uZCFRDDPrzsXCUVG0LFJ+tP6WuoAek07KTicwfpM8Co6sF5AMBKCCLl6tJ+tZVg82fQOgWpR2Hw3GRoadr8SuRQMcFRqNzqP9uIv2PgUV2xC5E//K3nFH7Qa5BkI4FmPQJwuvXIkyW0sjG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185202; c=relaxed/simple;
	bh=ZEeQ3i1/77hgech3Zwt6EwtAK2RS0AUxfqPpuYAXVvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sI+v80Aw3nrVcRmOQimemmY3QKggHQMPHRggu/V+uCpnGEUEtVhMVbzZvtMxcXWC2wSuldj/6yv83OWk9DSXkXqepFZnSiC6dXZd/gQGDCEPeZZ33ACTrHh0xUwrtwbfj5D+Y5WoDveb93UeT7aoGZRZYhsWIEi6ok1dRfLa9Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i0os7fAM; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i0os7fAM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0D+0x7RUbycr/Nm5uJqSKnPuUXxt2MZv7eG12L5dg7HEEuDSzsW1iv9cmSgK+1ZW9Xc8PhHelrg1hmSv6DvC1r/8b29L4Xx9+dNjC+3sk6vNqKg0CYPvZ/3br0lig38yefR167MbsuYd25NyuiXoo8620udv5Hyh0OzelzwzJA5ryKQ/1d1LI+zuzJP6TKPi7qaOge3ViNRUtceAPkNAJdcUbhkqWGxjnrQpGg61oqsNbTjHO9P4Z/RcueSYSdrzhICcy/UmbC+d8PwmaeEtvxRv1fUsDIpb4RRVgM7O2Z/d2P84qPM3g/AyI8BqYQSGt9V9VpPll6IbJbqOwqJcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcJ8Y4uRQcfAWLjOW4w2Rg+tQPRG25j+9qwykw5yZs4=;
 b=foyJ0b2j4yQaS65jzLZ2y4a86SQw0xk1wyWFKXLpSM+eSxgXdtdOllhh8ZWk2FrbMcsxgZTcs1AQMn+raWxMWpmIYFVD0zAhju1KA+PPhFBwyf6/NHa6DeZlh/aQ/2LMAXJYDUhlzc06PnF5zKG+HX9lXCLvgL5kBQufKavryfFU+IXwI8x0JV4D+jwKYh5yrt69E5rOGuFC9w7EBE0EpIe6zZyfbAyq760ymEMftRoocAmk/+1symJCdl/+yUIA5PuBLYyBORSlbSneroaf4NtQXLd5HWspePt+pw6QRm/uaPZzUEgmyxNjcRgUz72DV7tuS0DVDtV5vtj/8k3azw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcJ8Y4uRQcfAWLjOW4w2Rg+tQPRG25j+9qwykw5yZs4=;
 b=i0os7fAMjaQYFsVRDTw3/PljcK0GVG9Dan0xMibdCAAQtoWIaNAaTKRkPLE/k3l/vwenccOOTf70DkjvhXY5H7m879/uE/ECn5WBSpvdX1K45pr62uBIUrMXqbHv8Y8WudgoMfv+o3KMCNMlXxDJfUwtObIKwNgL4tRNZI299OQ=
Received: from CH0PR03CA0036.namprd03.prod.outlook.com (2603:10b6:610:b3::11)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 12:19:57 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::dc) by CH0PR03CA0036.outlook.office365.com
 (2603:10b6:610:b3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Thu, 25 Jan 2024 12:19:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 12:19:57 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 06:19:51 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v6 17/17] iommu/amd: Introduce per-device domain ID to workaround potential TLB aliasing issue
Date: Thu, 25 Jan 2024 12:11:35 +0000
Message-ID: <20240125121135.8217-18-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125121135.8217-1-vasant.hegde@amd.com>
References: <20240125121135.8217-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: dbf99126-ea74-469f-edea-08dc1d9ff1af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u/zru0OLjJmj1juMrFoHh5iAJ/Fm5mhxa9tgIRFE7Ykem0Bp3dSBYF64cy32MvUrRUcQm4RVnN+/2jOSyenOGWyPulYsUVbrtl55B2+MVqhfBne4lFpwEbcTWOnUvwhE11VbREhDCyoSTGEktR6prJ6kaNcK19mXY7P4aJRd9WV3b673f6E6YHCV+7lHXFlEVRe/LyOWJJimUvou83BIz2Vfl28+/7K+7JL2qdya6EwhNKTxD6es/oNQCm7C5iQbkt/RN86bWJt7YpBtsJXqe1Pqwa6M7ZE3kCAT/ZtKt2Zhi1mCnax2lnZ2hc4ByA8fYa2My7FJXRZnJxHV310SzZew5W//mAFwvLCj97hMOHuoAUy1I40AEOqhf2/t882GcRG6OA9jY1IAcroyoGy1pn+afqi0+BbTMbsgfIGPChK2PyPcWOZFGLyxb2YfCHAwc+RJbzXRAH9GSzkpeE8UF+XcqxkvAmB1oGwHkv4DIRsuLdQNce7GqPDgGM0d20F/8PV0q21Iiv8eEG4cv46egk72/U9hdnaTzfPb77Dwf5yGsB6cdnWrabUIFyRLgJzhHOPuieEn3SLM0/VBENAHCKq9j0HILCcZ6yXPuJJE+lnREJk2b4+WD/oxbZHfDYEgLbzHcuH2dOiF1bNJMrliOGmkOKYcQglZfIeadt5MZIRYwN1TCn4P+zRYmd53GU2z+Q3tWaN1Lhs1AGwUXafvKaOBV6F12kewHuiXAQ+gqP/6ROjuuH7dG/YXSad4NdTPjFTE7+5+fdtMEglKn5Xq7w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(356005)(47076005)(54906003)(6666004)(316002)(82740400003)(40480700001)(40460700003)(36860700001)(81166007)(36756003)(7696005)(336012)(83380400001)(2906002)(426003)(8676002)(8936002)(4326008)(41300700001)(70586007)(110136005)(70206006)(478600001)(86362001)(5660300002)(26005)(16526019)(44832011)(2616005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:19:57.0987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf99126-ea74-469f-edea-08dc1d9ff1af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241

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
page table. Please note that this workaround would result in multiple
INVALIDATE_IOMMU_PAGES commands (one per domain id) when unmapping a
translation.

Domain ID can be shared until device starts using PASID. We will enhance this
code later where we will allocate per device domain ID only when its needed.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
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
index 6cc9ed0b6e87..8c49788f3361 100644
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
 
@@ -1858,10 +1898,16 @@ static void set_dte_entry(struct amd_iommu *iommu,
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
 
@@ -1874,7 +1920,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	 * When SNP is enabled, Only set TV bit when IOMMU
 	 * page translation is in use.
 	 */
-	if (!amd_iommu_snp_en || (domain->id != 0))
+	if (!amd_iommu_snp_en || (domid != 0))
 		pte_root |= DTE_FLAG_TV;
 
 	flags = dev_table[devid].data[1];
@@ -1924,7 +1970,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	}
 
 	flags &= ~DEV_DOMID_MASK;
-	flags |= domain->id;
+	flags |= domid;
 
 	old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
 	dev_table[devid].data[1]  = flags;
-- 
2.31.1

