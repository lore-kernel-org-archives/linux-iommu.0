Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD931B81D
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 16:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kDhG6cwQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zg3LHRRfoZsSx22JNIM7POS4SMlx2Jb0zMBqbjczcPeFov/uMujAgTlCDrM6sxjyX2VMmzoLIJQKgYUyQgRggla7jbG8UjXKuPoGRp9G/9O8RT3FXSXMkPuVLsvK2JE5/lzhWczY4BcGwueWIPswh3lFZoj7IdPxRNj2RxMupvM3jCZRdpQ/hz9WORoWg964IaBoM10kjh5U4nB5wC1V1dmmPH1Ut+fjA0+ydI3GGGt2PC/efJFilVskqLjquF44zeGaD6m0wx4Om83oUNaRN5XcWT2JjH4k6Oy4soWM+SaQ7jDqWRkFOfwNX5tLzKEsgHQ0MhGhHcrGxMLJSxoCvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFek4B2ud24BgDaStIHmVHeL8fen4fFc/uahhp4Ty4E=;
 b=KzkBnER3Sov1A0hvjvGmezsT6Ex4dHd76iCvZjt9JlmlmJO7upg+d9lIw3RyVBxujlJazMErdzXdoL/FsdhOlThYOicLfBgKiKwmfwrFsN6i5YSVuc3hU9UhuUcVFQuKND9H8A+zB6NInTk5TKIYmrJ/ySnb4Ud8wixfFa+bY+OwQayvYEic/s0L8JbNZf6iRtXhMsfsjBXQ7W3I+Tvjq8MPpfr/auirUL08FfNYhrdgWbUn4ir3EnGBZcyekucyuhjXDXoeDu4mxnKEir4jEiXEy7fel0/lBCB2GW8ZuNTjvYcfSTtJq+Ut7QPdNXaLK7vfbrsXl0UbckkSQpBd3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFek4B2ud24BgDaStIHmVHeL8fen4fFc/uahhp4Ty4E=;
 b=kDhG6cwQRZYq6xDs6p8yIOC+DW1fPnOIWI6hayZ+zjuOnowziGahEIBaXU2ob8RVdbyT17VeAn1a08G4HifXhhv8x9almV1XPqgW/B4PfsHuGmvzQcSNTEhFKljfuyOOYKmCsQeQJhQY4CCAI7cNY6OhwpEkD2KBAXEK2b/jiy8=
Received: from MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::12)
 by BN9PR12MB5308.namprd12.prod.outlook.com (2603:10b6:408:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 16:55:48 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::7) by MW4P222CA0007.outlook.office365.com
 (2603:10b6:303:114::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29 via Frontend
 Transport; Tue, 16 Jan 2024 16:55:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 16:55:48 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 10:55:45 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 07/17] iommu/amd: Introduce per-device domain ID to workaround potential TLB aliasing issue
Date: Tue, 16 Jan 2024 16:53:25 +0000
Message-ID: <20240116165335.6043-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116165335.6043-1-vasant.hegde@amd.com>
References: <20240116165335.6043-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|BN9PR12MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: 18cd267d-21f9-4fec-bf7b-08dc16b3fd58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3LVGGBR5TDc4NeXOnvN9DCkA52zNbUeko64HccCC5qK9DGe+QJxaV0RJiL8nE3OA375RI3zCOHyu9B4iCgi4n6P50bSNkiTTRonOWsdsDF7qwEDDyIUuRG04oKZ/1972lZ7VPq6ZAQ3pX/svnphQfGuu/1+AUFcKdFqzUbxB5YQbVBH/d68zUR87MeUODzhyjtGSSGkJLVmvInp4cAygPZq/0L9FyBSoeNQ0B8Wdsi7hodJDkAM9TH0lkVx3F9hGHy1mPOdXqOQxrgNtihFJASsPX4qOboESGdOqqBZmuQDEUEZnlapsjdcPi2HiMVxmpHeyCaJZ9Wk8iV1gXBGfNdepyAQ2nUpi4Ne/CA16fRlfsCbsxYlItFrfnJgIK2F5v42Gyb26KmLgly7wUltd8aoJErjQ/bdkQDVxdbKkGoDotU0nE9mwB8mCNC8Ls4CLjtt6PxeHpHESjDvCmVpnUHQSRgHRMic9oD6otXoEN+R9pzCCuj4oL385Gc2zyyLEMzVBoMNF/PurPbADywiRa6nK+WmbTMCwR6BxEms29qj4JD/ovZX0ptgtJ8UWarMfAz7Q3vSw4NHezKNsxXHeN+oUjI+jG/XwRjPwe4B5d5TZD8XfJHVcry1Az5BDL/vEwzGdcqoGd/CnPHRh9b0Xowt0R9YzkbnkEqhYSIihPs7KFbhMEEaXaiYdDF/YjCJ14qrCQeW83l7883M6EZJp/OmSt2o1Vbvd53xEFSS30/d2q+9PAAob1vFXSC0KTU5bT/ufSRlPwZsHEtTHJOXzPA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(478600001)(7696005)(6666004)(110136005)(316002)(8676002)(8936002)(70206006)(54906003)(47076005)(426003)(336012)(36860700001)(16526019)(1076003)(83380400001)(26005)(70586007)(4326008)(2906002)(5660300002)(41300700001)(44832011)(2616005)(36756003)(82740400003)(81166007)(356005)(86362001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 16:55:48.3614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cd267d-21f9-4fec-bf7b-08dc16b3fd58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5308

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
 drivers/iommu/amd/iommu.c           | 84 +++++++++++++++++++++++------
 2 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index fead9033796f..9e23710fd3ec 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -545,6 +545,7 @@ struct gcr3_tbl_info {
 	u64	*gcr3_tbl;	/* Guest CR3 table */
 	int	glx;		/* Number of levels for GCR3 table */
 	u32	pasid_cnt;	/* Track attached PASIDs */
+	u16	domid;		/* Per device domain ID */
 };
 
 struct amd_io_pgtable {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index dac04585c7fc..34004f0e90dc 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -90,6 +90,14 @@ static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 	return (pdom && (pdom->flags & PD_IOMMUV2_MASK));
 }
 
+/*
+ * Allocate per device domain ID when using V2 page table
+ */
+static inline bool domain_id_is_per_dev(struct protection_domain *pdom)
+{
+	return (pdom && pdom->pd_mode != PD_MODE_V1);
+}
+
 static inline int get_acpihid_device_id(struct device *dev,
 					struct acpihid_map_entry **entry)
 {
@@ -1444,27 +1452,37 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
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
+
+	return ret;
+}
 
-	build_inv_iommu_pages(&cmd, address, size, domain->id, pasid, gn);
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
@@ -1474,6 +1492,28 @@ static void __domain_flush_pages(struct protection_domain *domain,
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
@@ -1702,9 +1742,15 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	u64 flags = 0;
 	u32 old_domid;
 	u16 devid = dev_data->devid;
+	u16 domid;
 	struct protection_domain *domain = dev_data->domain;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
+	if (domain_id_is_per_dev(domain))
+		domid = dev_data->gcr3_info.domid;
+	else
+		domid = domain->id;
+
 	if (domain->iop.mode != PAGE_MODE_NONE)
 		pte_root = iommu_virt_to_phys(domain->iop.root);
 
@@ -1717,7 +1763,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	 * When SNP is enabled, Only set TV bit when IOMMU
 	 * page translation is in use.
 	 */
-	if (!amd_iommu_snp_en || (domain->id != 0))
+	if (!amd_iommu_snp_en || (domid != 0))
 		pte_root |= DTE_FLAG_TV;
 
 	flags = dev_table[devid].data[1];
@@ -1766,7 +1812,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	}
 
 	flags &= ~DEV_DOMID_MASK;
-	flags |= domain->id;
+	flags |= domid;
 
 	old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
 	dev_table[devid].data[1]  = flags;
@@ -1814,6 +1860,10 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
 
+	/* Allocate per device domain ID */
+	if (domain_id_is_per_dev(domain))
+		dev_data->gcr3_info.domid = domain_id_alloc();
+
 	/* Update device table */
 	set_dte_entry(iommu, dev_data);
 	clone_aliases(iommu, dev_data->dev);
@@ -1841,6 +1891,10 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	/* decrease reference counters - needs to happen after the flushes */
 	domain->dev_iommu[iommu->index] -= 1;
 	domain->dev_cnt                 -= 1;
+
+	/* Free per device domain ID */
+	if (domain_id_is_per_dev(domain))
+		domain_id_free(dev_data->gcr3_info.domid);
 }
 
 /*
-- 
2.31.1

