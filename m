Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1998933C6
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:49:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFcWKaGACh/Gh320aEB34UuA+LQLMDinWKjsWYqc1L47OhvKzQ+4VHVDgdm/CHUGQ8iLasB61g/40z3qmO+ieUkun0Hx32ICdq+eZ/h/BWoRgF2OG9/s5xMtoEVMFMhEzBQk6huKJcHiUydlaU0rcVVmXkrwTe+1TfMlAlaB2LsPdiXX63MkMr3Qql9NNNSyhLVmdtgmEUJYewS0LgftBlH4EXvLt/TiCfvTDg/NdC+amx/7F7kUv7DtsEF4FuSkLqaHIVMKN1sY969H2+7rkh9STr/WQztkng9mBgLWls3Z4U7yvEn+VsiVXqO0ASkxF6MJCCJ1XyV17iVJ8kx5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XrgbqrFkmE3B6StURfTVXYUgqCGAu8hRD/4R8CwAU6M=;
 b=OEyUbSTYHUgAVdridyUHGiQo8XHv6qkrZGWqLaOzPGFtYZ/yBPkSBfWUcg5RXXHxlPfLHiKbvelOlN70zNMYh1/RPoQE1azkOiyuzVIJ4bqOaBetJRVrP9rJOlfH3SC44N7Sq9mYHoJ8OkYIZ5zO29GZWw8UytlyG8kHxTR/7Z87gbpfOaWrWENa1CM041zvXo/xASwf15N/DLz9efmb+xMU2mkPSjq4iiakV9HKW/F82jVdK6KYswfaBcsU629syiVlvjK/7ZjMTWWSqy4UkfJJfVYvvKvi8rpV97pzfB54cRuENnr641LWEBW50ppJuywK1kXylQMsdzG+QMucpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XrgbqrFkmE3B6StURfTVXYUgqCGAu8hRD/4R8CwAU6M=;
 b=KEaGaaxkTwEGA8CgRq5jBevNOTwYYuuiArk3MiMgCcx1AEAbNdJT0PSDI6DFsDcquZue3kKF4TQscJObwgm+moBpT12Yegc90nLJKICbDT4gGg+DRq1xy3kRLsViigasXi6z+nBcHVacNIEF3SEEK/IG+nojKCt7mj35AmIqVcU=
Received: from MW4PR03CA0266.namprd03.prod.outlook.com (2603:10b6:303:b4::31)
 by MWHPR12MB1533.namprd12.prod.outlook.com (2603:10b6:301:f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Wed, 6 Jul
 2022 11:49:50 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::e9) by MW4PR03CA0266.outlook.office365.com
 (2603:10b6:303:b4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18 via Frontend
 Transport; Wed, 6 Jul 2022 11:49:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:49:50 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:49:46 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 29/35] iommu/amd: Introduce get_device_sbdf_id() helper function
Date: Wed, 6 Jul 2022 17:08:19 +0530
Message-ID: <20220706113825.25582-30-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: eb99b2ac-8637-48a2-6eac-08da5f45a20b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1533:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Wb4NXx7FGrT4/G/kfQ4qp6IjP45vH+urUYjCLnCoXiuZq8pH4ejgmYw9UPWe1DmgYNmlNw/juiqALFRPFEXGs0OhmE/clVv/gaMkw9NE1ZYAmetE7lzktO0nTEe4tM9N4O3j7RAx2GLeCun+RbUIs/tgxgMpf15EZXVot7rrlHRL3TseJpjsbDoYW5Go2KXO6Jf8QLq3OhQPPgfsDl4Ew6kp5kissL0Booe4xEnRjwbpS4EFTILMJNJHJqsI/BsF0x86JTiXPPNOu24wxWCABBfEWlUlAVqNhdUn4ScBT0JIrZP8g4b7PtSNqa/w175hery1MZ6iUT+Iy72/iSqVnaGK9G45lYKLqOJQVxH7BXVn3LxLbfj3syku04BE8OXlroIueICEQ5ma7B4cKcgRHmTN6nj7Dysj4dRneKAXUsQU8KeW2fU1fLZ7AKw8x+Vl38DGGOdmhT5Q86NbGRlge6Ma5YGH+jAYUwpE1pZe9UU5n5JLMUU4B2EfObGYeMTus3iefteDcrnxKS2CbHynJwegSqSwFYO4npwPl4yqLgeGwrRw953rJFqi/3BFD1TEtH96uqd2mFp9w1YvBymKAHJTDQ88hBIqBWxk9sGhDmlagxbiEs7hGWHKF6T3jKVaH4RfXB6JtjrqpVi2gyqaqd0Eb4NBtnMVLK8NWKTEmyTFmhvkSdV+HHsa57m2TK2Wc7HsT6kq+EozYuvzFfT6pFgWWMd1+404WpiNPVV6kspNgS6XZ7kuqHpVbA5iYXGJTteDJ0MZKwdLl0kmb8EtBEb3O9snN34ZezwEHDJ+jTy1VCJDwbMkid3xvDEQ66oEkneMqgZxhl0s16Is6RX5W4J7G1eOYz85KGQ6uW4lvRXii2J9oPYL8QKFKPtvsZIh
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(39860400002)(40470700004)(36840700001)(46966006)(47076005)(110136005)(40460700003)(426003)(336012)(26005)(54906003)(44832011)(82310400005)(16526019)(186003)(36756003)(316002)(83380400001)(1076003)(86362001)(2616005)(5660300002)(34020700004)(70586007)(81166007)(2906002)(40480700001)(36860700001)(478600001)(7696005)(8936002)(6666004)(8676002)(4326008)(41300700001)(70206006)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:49:50.0511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb99b2ac-8637-48a2-6eac-08da5f45a20b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1533
Message-ID: <20220706113819.lTRhW0B-N-74SID2xJhcG3UyNLfcVw_V5s9cSeePRn8@z>

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Current get_device_id() only provide 16-bit PCI device ID (i.e. BDF).
With multiple PCI segment support, we need to extend the helper function
to include PCI segment ID.

So, introduce a new helper function get_device_sbdf_id() to replace
the current get_pci_device_id().

Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  7 ++++
 drivers/iommu/amd/amd_iommu_types.h |  2 +
 drivers/iommu/amd/iommu.c           | 58 ++++++++++++++---------------
 3 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 64c954e168d7..e73bd48fc716 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -115,6 +115,13 @@ void amd_iommu_domain_clr_pt_root(struct protection_domain *domain)
 	amd_iommu_domain_set_pt_root(domain, 0);
 }
 
+static inline int get_pci_sbdf_id(struct pci_dev *pdev)
+{
+	int seg = pci_domain_nr(pdev->bus);
+	u16 devid = pci_dev_id(pdev);
+
+	return PCI_SEG_DEVID_TO_SBDF(seg, devid);
+}
 
 extern bool translation_pre_enabled(struct amd_iommu *iommu);
 extern bool amd_iommu_is_attach_deferred(struct device *dev);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 65b02e2ae28f..ea238e8e6c99 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -456,6 +456,8 @@ extern struct kmem_cache *amd_iommu_irq_cache;
 
 #define PCI_SBDF_TO_SEGID(sbdf)		(((sbdf) >> 16) & 0xffff)
 #define PCI_SBDF_TO_DEVID(sbdf)		((sbdf) & 0xffff)
+#define PCI_SEG_DEVID_TO_SBDF(seg, devid)	((((u32)(seg) & 0xffff) << 16) | \
+						 ((devid) & 0xffff))
 
 /* Make iterating over all pci segment easier */
 #define for_each_pci_segment(pci_seg) \
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6914911d4fb6..0751dda04a10 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -92,13 +92,6 @@ static void detach_device(struct device *dev);
  *
  ****************************************************************************/
 
-static inline u16 get_pci_device_id(struct device *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	return pci_dev_id(pdev);
-}
-
 static inline int get_acpihid_device_id(struct device *dev,
 					struct acpihid_map_entry **entry)
 {
@@ -119,16 +112,16 @@ static inline int get_acpihid_device_id(struct device *dev,
 	return -EINVAL;
 }
 
-static inline int get_device_id(struct device *dev)
+static inline int get_device_sbdf_id(struct device *dev)
 {
-	int devid;
+	int sbdf;
 
 	if (dev_is_pci(dev))
-		devid = get_pci_device_id(dev);
+		sbdf = get_pci_sbdf_id(to_pci_dev(dev));
 	else
-		devid = get_acpihid_device_id(dev, NULL);
+		sbdf = get_acpihid_device_id(dev, NULL);
 
-	return devid;
+	return sbdf;
 }
 
 struct dev_table_entry *get_dev_table(struct amd_iommu *iommu)
@@ -182,9 +175,11 @@ static struct amd_iommu *__rlookup_amd_iommu(u16 seg, u16 devid)
 static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
 {
 	u16 seg = get_device_segment(dev);
-	u16 devid = get_device_id(dev);
+	int devid = get_device_sbdf_id(dev);
 
-	return __rlookup_amd_iommu(seg, devid);
+	if (devid < 0)
+		return NULL;
+	return __rlookup_amd_iommu(seg, PCI_SBDF_TO_DEVID(devid));
 }
 
 static struct protection_domain *to_pdomain(struct iommu_domain *dom)
@@ -360,14 +355,15 @@ static bool check_device(struct device *dev)
 {
 	struct amd_iommu_pci_seg *pci_seg;
 	struct amd_iommu *iommu;
-	int devid;
+	int devid, sbdf;
 
 	if (!dev)
 		return false;
 
-	devid = get_device_id(dev);
-	if (devid < 0)
+	sbdf = get_device_sbdf_id(dev);
+	if (sbdf < 0)
 		return false;
+	devid = PCI_SBDF_TO_DEVID(sbdf);
 
 	iommu = rlookup_amd_iommu(dev);
 	if (!iommu)
@@ -375,7 +371,7 @@ static bool check_device(struct device *dev)
 
 	/* Out of our scope? */
 	pci_seg = iommu->pci_seg;
-	if ((devid & 0xffff) > pci_seg->last_bdf)
+	if (devid > pci_seg->last_bdf)
 		return false;
 
 	return true;
@@ -384,15 +380,16 @@ static bool check_device(struct device *dev)
 static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 {
 	struct iommu_dev_data *dev_data;
-	int devid;
+	int devid, sbdf;
 
 	if (dev_iommu_priv_get(dev))
 		return 0;
 
-	devid = get_device_id(dev);
-	if (devid < 0)
-		return devid;
+	sbdf = get_device_sbdf_id(dev);
+	if (sbdf < 0)
+		return sbdf;
 
+	devid = PCI_SBDF_TO_DEVID(sbdf);
 	dev_data = find_dev_data(iommu, devid);
 	if (!dev_data)
 		return -ENOMEM;
@@ -420,12 +417,13 @@ static void iommu_ignore_device(struct amd_iommu *iommu, struct device *dev)
 {
 	struct amd_iommu_pci_seg *pci_seg = iommu->pci_seg;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
-	int devid;
+	int devid, sbdf;
 
-	devid = (get_device_id(dev)) & 0xffff;
-	if (devid < 0)
+	sbdf = get_device_sbdf_id(dev);
+	if (sbdf < 0)
 		return;
 
+	devid = PCI_SBDF_TO_DEVID(sbdf);
 	pci_seg->rlookup_table[devid] = NULL;
 	memset(&dev_table[devid], 0, sizeof(struct dev_table_entry));
 
@@ -2258,11 +2256,13 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 	struct unity_map_entry *entry;
 	struct amd_iommu *iommu;
 	struct amd_iommu_pci_seg *pci_seg;
-	int devid;
+	int devid, sbdf;
 
-	devid = get_device_id(dev);
-	if (devid < 0)
+	sbdf = get_device_sbdf_id(dev);
+	if (sbdf < 0)
 		return;
+
+	devid = PCI_SBDF_TO_DEVID(sbdf);
 	iommu = rlookup_amd_iommu(dev);
 	if (!iommu)
 		return;
@@ -3156,7 +3156,7 @@ static int get_devid(struct irq_alloc_info *info)
 		return get_hpet_devid(info->devid);
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		return get_device_id(msi_desc_to_dev(info->desc));
+		return get_device_sbdf_id(msi_desc_to_dev(info->desc));
 	default:
 		WARN_ON_ONCE(1);
 		return -1;
-- 
2.31.1

