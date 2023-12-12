Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FAC374EF
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sp80XXMV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXvtNvq4hqcKnPqmVCmoofVK2qNeAazYzdXHSiap6aepaJhYQXBCpSu0DOhsJeOYzhdUgfSscEgVNuz3MeQnPhxwXgHv4AKvI4I4UrM6xEKW59iurc2GXf+WptI+T4wO9hHfeCtNUSFTNcjtWgFU16FTBr24towQa4ZnUgCa7niIKhvxmJ9maBP6o9cNnstKqVVhwUu4otiU7sG0IlJUrrL43R+ygFePtsncrQWBh/u22hQfYoe1cw0pt76WTawnmkOh5o5jlQCsy94sMLASY+N6I5YEm9Mf4yFVpbpm/YGZDIOw+hpymWCw2fa477fdvCGvdW6Sc8c9IhALSN+yYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cf9KVu/O+BUg+1Dv6mwTdinCz/cLvpPzE6wY0cEVrAc=;
 b=knr0LPhyazbMbmNYH7M+A0kC0RZMnqyM9KV6GKX5T9D43jMeNDYYPIGC6o0VAGUNMhoojKpwjdGTrZwfrn0Do0+G0A3PVbtzpptSD2LavjLw22Z2RRPzVtnMteii1rygv3nnLrcFWuZhQZckP9lrd7fUHQbK4KpIgYKakessvDzJSeK+XffOuKeTZRzoFkmgfiFMh8DPW0zLzk6WLB/PwbrRtchvvd+UbS45jYebmda22d88gJPWmbbtLLJgKOF7a2t8NXuLfVxwmDPX2i0oPmssHopF5VQ+WjawMfjHWe8KGpNbd8tGyr1VNVS7hSf2AWTblVmh9YAiwYjIrvEd4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cf9KVu/O+BUg+1Dv6mwTdinCz/cLvpPzE6wY0cEVrAc=;
 b=sp80XXMVDzV3CaZ/F6OAdWUJv6I3yk6MfPmbVBQviozr8eytwWz45apsGyFJU51DqZaKrKY/yHgNxuVHfBiw04cqUQnGuddrIJsKgYZ1xhwP+kdG+GaV8ox7l7lD+pj/pkM43+oon2RZDteiULgBzfFkQHI5ezg5pw7RRJdp93k=
Received: from SJ0PR13CA0192.namprd13.prod.outlook.com (2603:10b6:a03:2c3::17)
 by DS7PR12MB8084.namprd12.prod.outlook.com (2603:10b6:8:ef::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.32; Tue, 12 Dec 2023 08:55:40 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::70) by SJ0PR13CA0192.outlook.office365.com
 (2603:10b6:a03:2c3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.23 via Frontend
 Transport; Tue, 12 Dec 2023 08:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 08:55:39 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 02:55:35 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 07/16] iommu/amd: Introduce per-device domain ID to workaround potential TLB aliasing issue
Date: Tue, 12 Dec 2023 08:52:15 +0000
Message-ID: <20231212085224.6985-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212085224.6985-1-vasant.hegde@amd.com>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|DS7PR12MB8084:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5e2787-62f0-4b62-f27b-08dbfaf01db3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6QayOQ9lrqopuvJlKOT4gseEClkZoZofS0Jc7vEGMajN8fzmf+28ex6vCiq9NHUGvI3515EWm1MPB7TyVhpYRzbureaEzOdoouVWFyrQZE7PIO7l1/rTLbRFd1ano7gTmqTNatf2VEskOWEq0giRJ8t/YbVYQitalgf06qMYhi3P67ZQP5DJXJqUVCBkRiXNifv+6gyXvHfCTREf6OqR+Q/d8SaU2kC3x2TiT3nu7QNIJtV8JxVgqRbBdCQPeEmkcisj60hY5KOQvNA8ICI2sEoR525v2E1OGFqDH5UGiayopv87ym9ELpN6gtH6PBi/XuRWSnmPOo1g/xZprJzWep5eVycZdXwtO5KDmuamC4T2noRkobUxqDOd4ano8FtDccqnlLrRnnZvLLfcLF9SsV2eM9LIfkE/rEzdH1vqMUjMv/l97+tTva3oNANF4IuehNaDsY80Gfc89gM/IzRGbTOXmssBWkS2rHo4WLTKwsePqAFXKXi0SWAUCSCqpYRedm02NeBsQdPaUPX4ir1uv3xCpJDmX6qqV3WEGZDc2FYGZGu8XZ+RnduNdBBX5j6tK0331tLNUwJxsxIdBqrsDEJHk1xtXKUF871x3nvDbPOaZmG4b8w0P2iPk0yEpeNPZ8XOweVyrcb+7IhnMvFsPAMxWxuTlSrVqWJjbqfKbjOdWc+XYjp0InumGxnxXxJ+FY0FBSAB/NYRNg/YEDDGUjSMs9Q2pNEsIq64nDhcpqDDzchSj1ekAlbTsQJa+ahqoesvAB1Lky4j0dxo4PUaEQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(336012)(26005)(1076003)(2616005)(426003)(16526019)(7696005)(36860700001)(5660300002)(83380400001)(44832011)(6666004)(316002)(41300700001)(2906002)(478600001)(4326008)(70586007)(8936002)(8676002)(110136005)(54906003)(70206006)(47076005)(82740400003)(86362001)(36756003)(81166007)(356005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:55:39.9078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5e2787-62f0-4b62-f27b-08dbfaf01db3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8084

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
translation on the shared v1 page table.

Domain ID can be shared until device starts using PASID. We will enhance this
code later where we will allocate per device domain ID only when its needed.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +
 drivers/iommu/amd/iommu.c           | 83 +++++++++++++++++++++++------
 2 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index fead9033796f..51daf5dd4729 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -842,6 +842,8 @@ struct iommu_dev_data {
 	u8 ppr          :1;		  /* Enable device PPR support */
 	bool use_vapic;			  /* Enable device to use vapic mode */
 	bool defer_attach;
+	/* Per device domain ID. Used with V2 page table */
+	u16 domid;
 
 	struct ratelimit_state rs;        /* Ratelimit IOPF messages */
 };
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 93d436bc3e8e..e497ce58b24a 100644
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
@@ -1451,27 +1459,36 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
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
+
+		build_inv_iommu_pages(&cmd, address, size,
+				      dev_data->domid, IOMMU_NO_PASID, true);
+
+		ret |= iommu_queue_command(iommu, &cmd);
+	}
+
+	return ret;
+}
+
+static int domain_flush_pages_v1(struct protection_domain *pdom,
+				 u64 address, size_t size)
+{
+	struct iommu_cmd cmd;
+	int ret = 0, i;
 
-	build_inv_iommu_pages(&cmd, address, size, domain->id, pasid, gn);
+	build_inv_iommu_pages(&cmd, address, size,
+			      pdom->id, IOMMU_NO_PASID, false);
 
 	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
-		if (!domain->dev_iommu[i])
+		if (!pdom->dev_iommu[i])
 			continue;
 
 		/*
@@ -1481,6 +1498,28 @@ static void __domain_flush_pages(struct protection_domain *domain,
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
@@ -1709,9 +1748,15 @@ static void set_dte_entry(struct amd_iommu *iommu,
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
 
@@ -1724,7 +1769,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	 * When SNP is enabled, Only set TV bit when IOMMU
 	 * page translation is in use.
 	 */
-	if (!amd_iommu_snp_en || (domain->id != 0))
+	if (!amd_iommu_snp_en || (domid != 0))
 		pte_root |= DTE_FLAG_TV;
 
 	flags = dev_table[devid].data[1];
@@ -1773,7 +1818,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	}
 
 	flags &= ~DEV_DOMID_MASK;
-	flags |= domain->id;
+	flags |= domid;
 
 	old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
 	dev_table[devid].data[1]  = flags;
@@ -1823,6 +1868,10 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
 
+	/* Allocate per device domain ID */
+	if (domain_id_is_per_dev(domain))
+		dev_data->domid = domain_id_alloc();
+
 	/* Update device table */
 	set_dte_entry(iommu, dev_data);
 	clone_aliases(iommu, dev_data->dev);
@@ -1852,6 +1901,10 @@ static void do_detach(struct iommu_dev_data *dev_data)
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

