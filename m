Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24985CA4D
	for <iommu@lists.linux.dev>; Mon, 11 Sep 2023 12:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQQ5w2pgouIb9d94RFZ+evZtUEmUL8J4vKxU9anWOT5/BlXh+xqlbUI0wXtdIsI/9qWBV3bMqfbFqmcrLviLlabYZexoFUDH03gL8vaB/2uDSf4Z5DEgU+tARX2RFy1LYHL40Bca1gAg+rYFZi7IOdT4Ch2vuBBKGsjpX86cJ56t2cEqls6ksh99Sm1+vFjFHo+C95x2ry1sBlkCcY2BpcY/HKBFEphgnSkFJVh5GQwfVQy+cHqiTKG9pHmcRpp9TBExaEvECnDrh2Om7R0fh+Rw/je7xGwPT87ayHpfnrweqRxOBCd1Hf42YZfe7+fnISyuNGjO8ULSktZj1+/n/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOdtlyaFRH7JHI0KvT7mAoz61J/8EmxgyDop1skDHfc=;
 b=Vs8USgg1Tr9ggMY1MTkZrbChr8xqIGqx+QKbZEvFwl8uES6OzpoOZYpF5calWrTpDNh0zKBwHFdnBxu5oXAa5anhaPzC4pPdbYyHeoLHnTfEKqqRcejD7DVzQW6I1COglZCDdcC6lwNgP/UL7cRzs7cs7BBrlxl+ntW2PAw5Mt4w6niCSBBMlYtOuB8Ml3yh8M4E1x4O/p0j8hylEtFxBotfhSY34RCpsJAP8WDsORNpORbxjzfHcIEVz9jB18i75GCMjSEGoCjuqqhVLzh1a/7vOyGXuVPgmJgJP9qYlWDeJfXtl2lw2ASpwZgnxaAA44468/0Qy6Rmd4EqYR6PFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOdtlyaFRH7JHI0KvT7mAoz61J/8EmxgyDop1skDHfc=;
 b=E0I1jJkwZbhITvZ+mPj/OCmKlTaLa7iTRQvbdA70HIg/M2CfnFNDny7pB5AXfSGKcaE0caCDtzWH9s3yeslPQA1mBRfFwOlz0DjhOsxdmGN35aeMH9Bwa22BSIx3JC8yoSU9E7mjBztDiX92xE39Sif8qSPZ13bKk+KKsN0xHfk=
Received: from SN7PR04CA0109.namprd04.prod.outlook.com (2603:10b6:806:122::24)
 by IA0PR12MB7649.namprd12.prod.outlook.com (2603:10b6:208:437::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Mon, 11 Sep
 2023 12:12:55 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:122:cafe::ee) by SN7PR04CA0109.outlook.office365.com
 (2603:10b6:806:122::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 12:12:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Mon, 11 Sep 2023 12:12:55 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 07:12:52 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 05/11] iommu/amd: Add support to enable/disable PASID feature
Date: Mon, 11 Sep 2023 12:10:40 +0000
Message-ID: <20230911121046.1025732-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911121046.1025732-1-vasant.hegde@amd.com>
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|IA0PR12MB7649:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c570a9a-6002-41a6-b792-08dbb2c06e15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mDrJADnPnfQpiR+Z69ywofxKAxppTVoaoZb5kmk/QmziHa5E7Hg6Lic7TYS/6FAZmuLFC4Vd0QAMwIVrBZgfzOZnOBbJAvWEg3ypMnkkUnEx51ZXFUiA1axHQz7Yc6USX++z4oPqNWROsDFKY8LLpEKYHVdFCZ+3iorFsj7K/WPyB/GtJdQ5tio7tpgk2DcIA+RdKZlAGqkqXPVjeX/Ytp5hUp5V3ox7AIC03j45OO0+Fjvwnbp+3d/OkUNXFWOhGTiN68JKAtHKC9IB4s7pjj2tERC6R8cZgFGO3Qa4nvLKM1TYRkEfa65UDLRWdRvxT/uVCC5xH3UZD3LfxxuciXn6o2BVu+NufukIXEgjGZVsrwQJLkImSs2aQp8K1R6pCeB/IZG+D7+LekIBm6p1X09xN2MhONPQtPw+Hx0HJjjZwmDaQHwpa+uHtgf44RUcbdc6FXa7IDLYzqA5WJPoJ7wc90Yg3GGcPyizSppS/HaHZVzlkp1SqU4TZf4Xf5N8rfTAJqfkL+DYi/nKph3SK4gCCmoYbk7XPsSoerDRVoSFouwvEyqmiClr7Y4g/OMrHT7P5PXEJKfGwZ+Z1a4WOBBW4Gxt+IWBIInptgnEnj7QGxui0TxIT13dygWrme3Dm88emY52ADBAJ4cwO8KT2cCKUPoMqkeh+mm7gHGcQ+wAW6ULxsvwe1qkjVxO/ZJkeo6M946GdcVKiUokSlEWgbCPGj3VJmiExMMbrWN0w0xHhMTPSdAcb84xesJYAVgBBx8qIZXFKxnjvXkqD6Uufg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(82310400011)(186009)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(44832011)(47076005)(36860700001)(40460700003)(2906002)(36756003)(86362001)(110136005)(81166007)(356005)(82740400003)(40480700001)(7696005)(316002)(70586007)(1076003)(2616005)(70206006)(4326008)(8676002)(41300700001)(8936002)(426003)(6666004)(54906003)(478600001)(336012)(83380400001)(16526019)(5660300002)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 12:12:55.2814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c570a9a-6002-41a6-b792-08dbb2c06e15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7649

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

It seems iommu_dev_enable_feature(SVA) will be deprecated soon. Hence in
this path we just return success.

Instead we add necessary check during pasid bind to device. IN this path
it checks whether device GCR3 table is setup or not. If not it will try
to setup the GCR3.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  2 ++
 drivers/iommu/amd/iommu.c     | 50 +++++++++++++++++++++++++++
 drivers/iommu/amd/sva.c       | 63 +++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 7159b2610702..f7f576b8c8f6 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -43,6 +43,8 @@ bool amd_iommu_sva_supported(void);
 int amd_iommu_set_dev_pasid(struct iommu_domain *domain,
 			    struct device *dev, ioasid_t pasid);
 void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid);
+int amd_iommu_gcr3_init(struct iommu_dev_data *dev_data, int pasids);
+void amd_iommu_gcr3_uninit(struct iommu_dev_data *dev_data);
 
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 94eec3dac8f6..5a9749cfe14e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2162,6 +2162,50 @@ static void protection_domain_free(struct protection_domain *domain)
 	kfree(domain);
 }
 
+/*******************************
+ * PASID setup related helper functions
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
+int amd_iommu_gcr3_init(struct iommu_dev_data *dev_data, int pasids)
+{
+	struct protection_domain *pdom = dev_data->domain;
+	int ret = 0;
+
+	lockdep_assert_held(&dev_data->lock);
+
+	/*
+	 * We cannot support PASID w/ existing v1 page table in the same domain
+	 * since it will be nested. However, existing domain w/ v2 page table
+	 * can be used for PASID.
+	 */
+	if (pdom->pd_mode == PD_MODE_V1)
+		return -EOPNOTSUPP;
+
+	/* Allocate GCR3 table */
+	if (pdom_is_pt_mode(dev_data->domain))
+		ret = setup_gcr3_table(dev_data, pasids);
+
+	return ret;
+}
+
+void amd_iommu_gcr3_uninit(struct iommu_dev_data *dev_data)
+{
+	lockdep_assert_held(&dev_data->lock);
+
+	/* Free GCR3 table */
+	if (pdom_is_pt_mode(dev_data->domain))
+		free_gcr3_table(dev_data);
+}
+
 static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 {
 	u64 *pt_root = NULL;
@@ -2579,6 +2623,9 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
 	int ret;
 
 	switch (feat) {
+	case IOMMU_DEV_FEAT_SVA:
+		ret = 0;
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -2592,6 +2639,9 @@ static int amd_iommu_dev_disable_feature(struct device *dev,
 	int ret;
 
 	switch (feat) {
+	case IOMMU_DEV_FEAT_SVA:
+		ret = 0;
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/drivers/iommu/amd/sva.c b/drivers/iommu/amd/sva.c
index d18dc3f676b9..4cf1fb7864c4 100644
--- a/drivers/iommu/amd/sva.c
+++ b/drivers/iommu/amd/sva.c
@@ -12,6 +12,60 @@
 
 #include "amd_iommu.h"
 
+static inline bool is_pasid_enabled(struct iommu_dev_data *dev_data)
+{
+	if (dev_data->gcr3_info.gcr3_tbl != NULL &&
+	    dev_data->gcr3_info.pasid_cnt != 0)
+		return true;
+
+	return false;
+}
+
+static int amd_iommu_pasid_enable(struct iommu_dev_data *dev_data)
+{
+	struct device *dev = dev_data->dev;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&dev_data->lock, flags);
+
+	if (dev_data->gcr3_info.gcr3_tbl != NULL &&
+	    dev_data->gcr3_info.pasid_cnt != 0)
+		goto out;
+
+	if (!amd_iommu_sva_supported()) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (!dev_data->pasid_enabled) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = amd_iommu_gcr3_init(dev_data, dev->iommu->max_pasids);
+
+out:
+	spin_unlock_irqrestore(&dev_data->lock, flags);
+	return ret;
+}
+
+static void amd_iommu_pasid_disable(struct iommu_dev_data *dev_data)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev_data->lock, flags);
+
+	if (dev_data->gcr3_info.gcr3_tbl == NULL)
+		return;
+
+	if (dev_data->gcr3_info.pasid_cnt != 0)
+		return;
+
+	amd_iommu_gcr3_uninit(dev_data);
+	spin_unlock_irqrestore(&dev_data->lock, flags);
+}
+
 static void sva_mn_invalidate_range(struct mmu_notifier *mn,
 				    struct mm_struct *mm,
 				    unsigned long start, unsigned long end)
@@ -60,6 +114,13 @@ int amd_iommu_set_dev_pasid(struct iommu_domain *domain,
 	/* Use SVA protection domain lock */
 	spin_lock_irqsave(&sva_pdom->lock, flags);
 
+	/* Make sure PASID is enabled */
+	if (!is_pasid_enabled(dev_data)) {
+		ret = amd_iommu_pasid_enable(dev_data);
+		if (ret)
+			goto out;
+	}
+
 	/* Add PASID to protection domain pasid list */
 	pasid_data = kzalloc(sizeof(*pasid_data), GFP_KERNEL);
 	if (pasid_data == NULL) {
@@ -151,6 +212,8 @@ void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 	/* Update GCR3 table and flush IOTLB */
 	amd_iommu_clear_gcr3(dev_data, pasid);
 
+	amd_iommu_pasid_disable(dev_data);
+
 	spin_unlock_irqrestore(&sva_pdom->lock, flags);
 
 	if (list_empty(&sva_pdom->pasid_list))
-- 
2.31.1

