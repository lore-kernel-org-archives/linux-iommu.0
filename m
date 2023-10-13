Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F0611CBC
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2I2xpA8M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGEth6sDu+YzZAdZwsH6m5wUxc6kSedWtSANGZY7v6dHgrwTB6fBsle7PDdZBEO42uCS1uzMFxLwW1hd+4zSKVwMZiiAKRAJVR4FXEPNwofkY1BK6B3B07h+Tf2oR9oWG5Xant4n6bBPDfLJnY04vHbnseS1hV0wstQl1uQNBmstOvMClxMAIA5bDHA0KrXsIzbcXAEaEKYEVyew+SipWNhq5sHxcMV1qKu2XRvNSSCv9WqiMUtf9qmR9DAX+Axf3wir0T/mz89219SC2NsbQJpYvjsKLeIOA0mIb7If5ee7imEyUi0J5g7Mu3ZJ8GGoNoVZ0XqdgJnLUlwq/tu5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJgSCbzZB1c5arTtauhpJYMg7ZAdGiag8sC90fF6enE=;
 b=EUmLl9lcgvgJLqbWAFwfKF2xFOJoyYn5kMOy2PO7RNEqg0DGiztyN4wPdp73QTzHXjBIwIh6lwiJx815QbO3scg/s9Ety51tYUnAavIjS0G4mkr/kkdOGQNpinqnaj9mnEzVDalhR1EfH74ER0r88XUlUj5PkR6hswON6GctLJlBWxT7Xdb2mV/71+gVa+yizMkclJR3JTITJLWWUBfVAFpkR3nICdHsfGtyrLliNtAxfVQosU7FOlPuEiPt3w7jNvTLXSF+T/tHIYeOxtbUzs0WegQzxbdimMDlgV6K1QRE6ou6JxyFZzeabos3BNlT/MkIJwmvHQP1DAhqIm/fog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJgSCbzZB1c5arTtauhpJYMg7ZAdGiag8sC90fF6enE=;
 b=2I2xpA8Mz5ZjlobKzgP3r4z1RS4e2ZFd/pVJ9v2Wfe/YAw0ivxXQm3E+rbSHU51mH3GupX9vN/tfptOQ06XLnorcCm41rHKkZXXf9vm4ojGdhwlC9f1RTnZQ79TOgBRaV7IjKRHDeDlVtqqVH76RUUdrRNjSkLo2a+Y6PNHQ478=
Received: from BL1PR13CA0086.namprd13.prod.outlook.com (2603:10b6:208:2b8::31)
 by SJ2PR12MB7919.namprd12.prod.outlook.com (2603:10b6:a03:4cc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 15:19:20 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2b8:cafe::43) by BL1PR13CA0086.outlook.office365.com
 (2603:10b6:208:2b8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 15:19:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 15:19:20 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 10:19:16 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 06/13] iommu/amd: Introduce per-device domain ID to workaround potential TLB aliasing issue
Date: Fri, 13 Oct 2023 15:16:45 +0000
Message-ID: <20231013151652.6008-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013151652.6008-1-vasant.hegde@amd.com>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|SJ2PR12MB7919:EE_
X-MS-Office365-Filtering-Correlation-Id: 738fa61f-75f0-4bb2-e151-08dbcbffc602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U2eUGi4rnrMIPm2Ghg2cCd/Hm6JqbaIejrVhODgGdXkSy6dRdv0spkxBvE8nIyJWjRVvfamvYxS8MSmj9Oilfiv5EyKRYPot8WR2g/mHQHl0Iz3IhRmsNiZraqn5+BHb/DSt/rC1ianOa3QJsF0fPYFXWyZSOhsxkSy9y/5CQicr8152wVNB7duFwCQmWkFaKq2cCbvlsYaS+swQg/VevCAojI4bAGAFVUCOaU5jppsmcmEEMMbHzsG1KkEypHmE7iWI4IN+cHHuT+T0zin/K39qDEtqJ0/Cwnpgt0DJSaInI9tQaff1qALsegQOyrUs3y5hVIufh1Z3aFznZqbAW/4jgbLOnI/D3AcoPcTZ4nQ+nAlpHsVN06jqEea+SiZZ8l5VbF6YVezvT9ESJb0oGzrXcx/QwoH0OIDpbUhG6XXEohNiPVXcTkZPb2Gtc+qM1oQKDC9TKDq0lEd0bFkAITjyphfgJ4BgfFPHYCsEY52Mp4fk1oq2W4XitEGDTGdJtD/MuyAZFIBlJEZUwIix7c/a+LF764KRGtUJCf8Th5ZAP0sBQpemFE8W8T6SPMu5QOVJD1WxqbD1cP7ukYNSzAAlgQcDvHrzJuNWXkyqTo7Rn1AEhVnrLMroXf0nrp9MsNbTNmOkOOe/cfq6xQHdZG8IRKPZMHb53t0Gsq9g1cmD8+WCuz4otwh88s6a6xMGE2DdfD/EXA+qzm5OhC/ZMSuhbA1p40cZDpuDpSu9cCj7B5ZvESnhy32kIGSiyiPtPwVG7PC6oRTTLjicuQ771w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(54906003)(110136005)(316002)(70206006)(4326008)(8936002)(336012)(36756003)(41300700001)(426003)(8676002)(70586007)(81166007)(356005)(5660300002)(82740400003)(44832011)(2906002)(36860700001)(16526019)(47076005)(2616005)(26005)(478600001)(40460700003)(6666004)(40480700001)(7696005)(1076003)(83380400001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:19:20.1139
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 738fa61f-75f0-4bb2-e151-08dbcbffc602
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7919

With v1 page table (stage-2), the AMD IOMMU spec states that the hardware
must use the domain ID to tag its internal translation caches. I/O devices
with different v1 page tables must be given different domain IDs. I/O
devices that share the same v1 page table __may__ be given the same domain
ID. This domain ID management policy is currently implemented by the AMD
IOMMU driver. In this case, only the domain ID is needed when issuing the
INVALIDATE_IOMMU_PAGES command to invalidate the IOMMU translation cache
(TLB).

With v2 page table (stage-1), the hardware uses domain ID and PASID as
parameters to tag and issue the INVALIDATE_IOMMU_PAGES command. Since the
GCR3 table is setup per-device, and there is no guarantee for PASID to be
unique across multiple devices, the same PASID for different devices could
have different v2 page tables. In such case, if multiple devices share the
same domain ID, IOMMU translation cache for these devices would be polluted
due to TLB aliasing.

Hence, avoid the TLB aliasing issue by allocating unique domain ID for each
device even when multiple devices are sharing the same v1 page table.
Please note that this workaround would result in multiple
INVALIDATE_IOMMU_PAGES commands (one per domain id) when unmapping a
translation on the shared v1 page table.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +
 drivers/iommu/amd/iommu.c           | 59 ++++++++++++++++++++++++++---
 2 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 3b1ef1030687..e836438a9318 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -831,6 +831,8 @@ struct iommu_dev_data {
 	u8 ppr          :1;		  /* Enable device PPR support */
 	bool use_vapic;			  /* Enable device to use vapic mode */
 	bool defer_attach;
+	/* Per device domain ID. Used with V2 page table */
+	u16 domid;
 
 	struct ratelimit_state rs;        /* Ratelimit IOPF messages */
 };
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 85d73555c1f9..09762332f681 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -102,6 +102,14 @@ static inline bool is_pasid_valid(ioasid_t pasid)
 	return (pasid != IOMMU_PASID_INVALID) ? true : false;
 }
 
+/*
+ * Allocate per device domain ID when protection domain is in V2 page table
+ */
+static inline bool domain_id_is_per_dev(struct protection_domain *pdom)
+{
+	return (pdom && pdom->pd_mode != PD_MODE_V1);
+}
+
 static inline int get_acpihid_device_id(struct device *dev,
 					struct acpihid_map_entry **entry)
 {
@@ -1418,6 +1426,19 @@ static int device_flush_iotlb_range(struct iommu_dev_data *dev_data,
 	return iommu_queue_command(iommu, &cmd);
 }
 
+/* Flush IOMMU TLB for the given device */
+static int device_flush_tlb_range(struct iommu_dev_data *dev_data,
+				  ioasid_t pasid, u64 address, size_t size)
+{
+	struct iommu_cmd cmd;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
+	bool gn = is_pasid_valid(pasid);
+
+	build_inv_iommu_pages(&cmd, address, size, dev_data->domid, pasid, gn);
+
+	return iommu_queue_command(iommu, &cmd);
+}
+
 static int device_flush_dte_alias(struct pci_dev *pdev, u16 alias, void *data)
 {
 	struct amd_iommu *iommu = data;
@@ -1523,11 +1544,25 @@ static int domain_flush_tlb_range(struct protection_domain *pdom,
 static void __domain_flush_pages(struct protection_domain *pdom,
 				 ioasid_t pasid, u64 address, size_t size)
 {
-	int ret;
+	struct iommu_dev_data *dev_data;
+	int ret = 0;
 
-	ret = domain_flush_tlb_range(pdom, pasid, address, size);
+	if (domain_id_is_per_dev(pdom)) {
+		list_for_each_entry(dev_data, &pdom->dev_list, list) {
+			ret |= device_flush_tlb_range(dev_data,
+						      pasid, address, size);
 
-	ret |= domain_flush_dev_iotlb_range(pdom, pasid, address, size);
+			if (!dev_data->ats_enabled)
+				continue;
+
+			ret |= device_flush_iotlb_range(dev_data,
+							pasid, address, size);
+		}
+	} else {
+		ret = domain_flush_tlb_range(pdom, pasid, address, size);
+
+		ret |= domain_flush_dev_iotlb_range(pdom, pasid, address, size);
+	}
 
 	WARN_ON(ret);
 }
@@ -1805,9 +1840,15 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	u64 flags = 0;
 	u32 old_domid;
 	u16 devid = dev_data->devid;
+	u16 domid;
 	struct protection_domain *domain = dev_data->domain;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
+	if (domain_id_is_per_dev(domain))
+		domid = dev_data->domid;
+	else
+		domid = domain->id;
+
 	if (domain->iop.mode != PAGE_MODE_NONE)
 		pte_root = iommu_virt_to_phys(domain->iop.root);
 
@@ -1820,7 +1861,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	 * When SNP is enabled, Only set TV bit when IOMMU
 	 * page translation is in use.
 	 */
-	if (!amd_iommu_snp_en || (domain->id != 0))
+	if (!amd_iommu_snp_en || (domid != 0))
 		pte_root |= DTE_FLAG_TV;
 
 	flags = dev_table[devid].data[1];
@@ -1866,7 +1907,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	}
 
 	flags &= ~DEV_DOMID_MASK;
-	flags |= domain->id;
+	flags |= domid;
 
 	old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
 	dev_table[devid].data[1]  = flags;
@@ -1918,6 +1959,10 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
 
+	/* Allocate per device domain ID */
+	if (domain_id_is_per_dev(domain))
+		dev_data->domid = domain_id_alloc();
+
 	/* Update device table */
 	set_dte_entry(iommu, dev_data);
 	clone_aliases(iommu, dev_data->dev);
@@ -1949,6 +1994,10 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	/* decrease reference counters - needs to happen after the flushes */
 	domain->dev_iommu[iommu->index] -= 1;
 	domain->dev_cnt                 -= 1;
+
+	/* Free per device domain ID */
+	if (domain_id_is_per_dev(domain))
+		domain_id_free(dev_data->domid);
 }
 
 /*
-- 
2.31.1

