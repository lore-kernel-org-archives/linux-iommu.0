Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86335BE5B
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 12:05:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tqd3MIcwMmV8bTNPYHag94VT6CD8EMnIkiC4D/EgNYzHSC7iNRs3JpC0IInIeUDWya4v9O26A16jQlDc6P9ZGmkzzEIvSahovF8aChmnkgfXFp2tfx9ydFMQEkG9LpFSUmu65+fZ5yQRvUa1xMHApuVuRIGeNK17S7JvFEvZxoJBLZmUa/vJ6K/GnRsuRNzRQNM721mWlzld32M/9gvoZ0RTK/9eoAD4nFdricptVYELklzT0LoHYJlkhA6cV/fziVaazjEr9NHGk8bQzreaid8wfPQjx3ChcxoIhv0HIuef1rfgTbUKPjybeIrhs8QWb2jhMV8/2BFckEKe301PpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFPjm9xABuzA47OiKsLXHs1nhCLI3OQNFLfDAhqZQmI=;
 b=C2DJ9z4z56A1GVrJlpe2PcLsHAaAGmv3SrCIUw/fukf/+SNPDjD7NCmYMrQ7uNTNLxv1/k5GTKvp29bpqg4rDa/+u/Ea0+mBt5rEtwBhqzuJWo1hHiMM7TMMT9Xv+Pvu19q6VNY9rmlegk72Y2QiJDt0EzhQ01rIKzsNOc6PbiQ7zS9NCY0WnvAi5EyjkyV2emA+oBpp12Te9pyJMOvX4Pb7RVxnfrz7CFVZYyWKOqiSsKd6oYAdd6tPEdFfhbaw1pJmCd64QeOKfj5c5MeXD7tkToYgZalopUfeu9bueitGHoWxqMTMjANZYqEoO7MWC4EFg6bSXHk36QIsvjWc5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFPjm9xABuzA47OiKsLXHs1nhCLI3OQNFLfDAhqZQmI=;
 b=azgkjvhHH80qWst7S/PoEB+nNJ/Ztg0yJW7xl6FW8VC/VuxiC9hL3ibDNx4rZTUr/ay48Bc2Zi2jiUTpRnidsHM9rWrVOeawqu0GtH4fwlWkjjUN5lya6nVtLh3cvovxAWiW4aXWlqbJdv22NDOYvxT8w1wET3Q7lUPmZcxWsFY=
Received: from CY5P221CA0113.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::6) by
 PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 12:05:07 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:1f:cafe::ba) by CY5P221CA0113.outlook.office365.com
 (2603:10b6:930:1f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 12:05:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 12:05:06 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 07:05:03 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 04/10] iommu/amd: Add support to enable/disable SVA feature
Date: Wed, 23 Aug 2023 12:02:17 +0000
Message-ID: <20230823120230.727935-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823120230.727935-1-vasant.hegde@amd.com>
References: <20230823120230.727935-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 97dc4d3f-8d86-4909-7883-08dba3d13120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ApL/t6p5xq/BI0DPHSMZkvtQnpf4F1KmowmTd4c0Bdo83YEejBofiMhUqUqCfZbz8WrCl0adm4KSQa8KavgUYEz0la4vlr7E6LO4tCOGI8PXajmsMYBXAAmvPaVz4kxRXtRI+0hGMsoLmG1gUTR4Ut/ald/2XhS+a98fH4Gm2AOWM1Y7krLRK+MurH2HiDTIpeRZBMClWub8JnNidKFcodCxbnNTC4Oh9LGg4WPWmFKfH6GKvhn55g6Q7a7BwxWi/+40hNN/p8QcaMoq2uVakcbTRy+i4H8N02ze4xLs2H9zmw1859bZKXADXa9T8ff1KJwuJV7yLtZ7ckk5b2U50Q3Z47R9Gw63vQCckyDYb3xqdVp6pkIPsIUhKAtmiYf6WbcTdFFL0R1eHlxRufxX8Ao4Qz6pjPzoZMcXgHUUk8gDbkkdJU3b5zJY9rI16fnVzWHhu9bDZYwOSMjR8rpWpyf0oC8UVl73vSDcQH+yL0XMrjNR3W+xLJIyx/bBffb+wxLg86vW1arPWZ+PjhjL2anXeg80XeSL7eurZuH2SFPgNzZA/dBf1GQc9WP1pAnpiwHXVN1hZr89mjwWNb9JnIGPxNOvzf8Pes5fQqONskOIP8xcQ8BEsKehckP47DhQS1k2+tqXY8ppYXlz9pPrU+RlpKblM20tfOWSMb/jZ/5aPopj2aClQDUIXcE1cFX9ryvs9YmW5a7NKYsdmKbLVlE07zxokRFukX1euOd+OgpUXHFgTHwCP4uycwBxoMEa2xxGJTArhTrKMLcoYKkpDw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(82310400011)(451199024)(1800799009)(186009)(46966006)(36840700001)(40470700004)(2906002)(83380400001)(40480700001)(7696005)(5660300002)(44832011)(336012)(426003)(16526019)(26005)(47076005)(86362001)(36860700001)(8676002)(8936002)(2616005)(4326008)(70206006)(316002)(70586007)(54906003)(110136005)(478600001)(81166007)(82740400003)(356005)(6666004)(36756003)(40460700003)(41300700001)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 12:05:06.9667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97dc4d3f-8d86-4909-7883-08dba3d13120
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Add support to enable/disable SVA feature. It will setup v2
page table mode with PASID and enables SVA.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  4 +++
 drivers/iommu/amd/iommu.c     | 63 +++++++++++++++++++++++++++++++++++
 drivers/iommu/amd/sva.c       | 29 ++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 6fdad7a54781..3f7ddf19ed72 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -46,6 +46,10 @@ bool amd_iommu_sva_supported(void);
 int amd_iommu_set_dev_pasid(struct iommu_domain *domain,
 			    struct device *dev, ioasid_t pasid);
 void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid);
+int amd_iommu_sva_enable(struct device *dev);
+int amd_iommu_sva_disable(struct device *dev);
+int amd_iommu_sva_gcr3_init(struct iommu_dev_data *dev_data, int pasids);
+int amd_iommu_sva_gcr3_uninit(struct iommu_dev_data *dev_data);
 
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 46bb1bfdc322..4868eee4c4f9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2162,6 +2162,63 @@ static void protection_domain_free(struct protection_domain *domain)
 	kfree(domain);
 }
 
+/*******************************
+ * SVA-related helper functions
+ */
+static inline bool pdom_is_pt_mode(struct protection_domain *pdom)
+{
+	return (pdom->domain.type == IOMMU_DOMAIN_IDENTITY);
+}
+
+static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
+{
+	return (pdom->iop.pgd != NULL);
+}
+
+int amd_iommu_sva_gcr3_init(struct iommu_dev_data *dev_data, int pasids)
+{
+	struct protection_domain *pdom = dev_data->domain;
+	unsigned long flags;
+	int ret = 0;
+
+	/*
+	 * We cannot support SVA w/ existing v1 page table in the same domain
+	 * since it will be nested. However, existing domain w/ v2 pagetable
+	 * can be used for SVA.
+	 */
+	if (pdom->pd_mode == PD_MODE_V1)
+		return -EOPNOTSUPP;
+
+	spin_lock_irqsave(&dev_data->lock, flags);
+
+	/* Allocate GCR3 table */
+	if (pdom_is_pt_mode(dev_data->domain))
+		ret = setup_gcr3_table(dev_data, pasids);
+
+	spin_unlock_irqrestore(&dev_data->lock, flags);
+	return ret;
+}
+
+int amd_iommu_sva_gcr3_uninit(struct iommu_dev_data *dev_data)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev_data->lock, flags);
+
+	if (gcr3_info->pasid_cnt) {
+		spin_unlock_irqrestore(&dev_data->lock, flags);
+		return -EBUSY;
+	}
+
+	/* Free GCR3 table */
+	if (pdom_is_pt_mode(dev_data->domain))
+		free_gcr3_table(dev_data);
+
+	spin_unlock_irqrestore(&dev_data->lock, flags);
+	return 0;
+}
+
 static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 {
 	u64 *pt_root = NULL;
@@ -2578,6 +2635,9 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
 	int ret;
 
 	switch (feat) {
+	case IOMMU_DEV_FEAT_SVA:
+		ret = amd_iommu_sva_enable(dev);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -2591,6 +2651,9 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 	int ret;
 
 	switch (feat) {
+	case IOMMU_DEV_FEAT_SVA:
+		ret = amd_iommu_sva_disable(dev);
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/drivers/iommu/amd/sva.c b/drivers/iommu/amd/sva.c
index c7c7e7cb5414..b4cc5b854753 100644
--- a/drivers/iommu/amd/sva.c
+++ b/drivers/iommu/amd/sva.c
@@ -297,3 +297,32 @@ void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 		break;
 	}
 }
+
+int amd_iommu_sva_enable(struct device *dev)
+{
+	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	if (!pdev || !iommu || !dev_data)
+		return -EINVAL;
+
+	if (!amd_iommu_sva_supported())
+		return -ENODEV;
+
+	if (!dev_data->pasid_enabled)
+		return -EINVAL;
+
+	return amd_iommu_sva_gcr3_init(dev_data, dev->iommu->max_pasids);
+}
+
+int amd_iommu_sva_disable(struct device *dev)
+{
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	if (!iommu || !dev_data)
+		return -EINVAL;
+
+	return amd_iommu_sva_gcr3_uninit(dev_data);
+}
-- 
2.31.1

