Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF1B374E3
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dms4ch6p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1d1NJ6/vrL0H6Q1US3pXSITOq3cJNkXGBbRXqjJnHbE3jTuyzmxIY5ZGwo37dsjRkvitbMaBmDx+8HlIJMXURy3og2JX8IyeQxDvVH/4U4PhHv70roUb9akS2oYoaKN4Eu+uEoQpepXWCEfhHrbbD3Rz0X0cfqDtoNnkCara5yPSJhUIgYiCDzoU8YiUYBuY1iyn4uHNyytIeN3xaGqcdVJ9M2mxG+8j/qPz0Pci67ZKVLcdfMa8uE8HSej5wH2fPO9LiWKaMih77rGJLEHPkzL6cuVqbkzkJpf5ZbZCwsXDycxH9v/RuAVsLg29AzjibRF0536o7oZaEmR5H7AHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7EPZVFE+n05jPekJN5+kH/2FrNCHYMCRFkIlnDCsIQ=;
 b=S1T9byUmIL6IIcgZ4yKSwg+8X0Nnx43UF/W56GE+wMsyFsAGJIJr8+yHkqtgsfMcmuucSDanWkziJuZqy1jPie/WsRcoYWBuHn0nquv/D/LCMkAi5A8/FFcJwcs/it9uu1c0+/jcqMwdYyXL5ZFh+AzWBYOV780jcptB6aGT0U8nQQEUpIHXZhwWnn0TPz830wjeEVmaGg9revCnVc9xLA2dP65cAGWSYAAPyt2LtbIVu7AxaHEL+lxqwoWQT7OLo0Jn0HaDwMjgXN+jY95fC9LV+ZriquEqefMM2op4Xjfzt6ygMOXUg9jNaVx9qvdmyI4A4ZYDFZtlvErcBd3gmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7EPZVFE+n05jPekJN5+kH/2FrNCHYMCRFkIlnDCsIQ=;
 b=dms4ch6p2iEH++1MvW03BQqFBsDHpFDGL3tY0BY6ojXofTxjkCLsEI84FAcH+98gwakLNKwyLNepKPRMTqhGiIeFJBsD7TR64JKYD70SW7JE5pf7RDA3jbINxJTElJi50arOGNGEbty7caffnAYamvfXiiHslcYvq5OVCV2HnYs=
Received: from BYAPR01CA0016.prod.exchangelabs.com (2603:10b6:a02:80::29) by
 SA1PR12MB7442.namprd12.prod.outlook.com (2603:10b6:806:2b5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 08:54:09 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::6) by BYAPR01CA0016.outlook.office365.com
 (2603:10b6:a02:80::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 08:54:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 08:54:08 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 02:54:05 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 03/16] iommu/amd: Introduce get_amd_iommu_from_dev()
Date: Tue, 12 Dec 2023 08:52:11 +0000
Message-ID: <20231212085224.6985-4-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|SA1PR12MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: a5d1e8c3-1373-40d3-420a-08dbfaefe778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9At9EWkxqxuCHzxBn2jAXvWS5BsI5S6jNjy+mD18G6BfUa/udoMcBUxhbg/1ZN2xs6D/TzsqkHGEiuMxTWohhKEW1ixhno4Fbof6dS1UPLJvjIM17QW0jIQQlRAIS6PFe5gyrczjDFwN+PIJM2FYUpXmN1WUVN0gH7U395gphaIvHHmzAGw96j9eWNmdLBg2TJ9BGvvL9F0BVmJu9ZogDaU8cQO84z4qeC+e7OQpL9aART1rSo0HAjLmGltTPo0VBRyaZPu8USXlIUtnPW3FsuUtn6wZRC1A+9//aLyoTgsjNmfgkoh43rHAqEJ9DwF30ClsnNcbhIs07cxK1G/t9n1tQYX/1ngv7r0PfRL+EG+CvwQ1ieGwQCUjaIAl0Hvj7uHLDmtc/rp+lhTtTZSMSamN++S00tLKWEp/yvcT2uLcoj7pGhgzqS2bDYH6/f9OwJSbZXlyG56LXfhpNjQEOknAGVnT38SjsOpMyJ7VOQlogwlYZZG+Q6dQNuDu4A7jKy4HIAI/7es5bT9AKRuoeGDah6kwfK1LGzR65ytugY0Xeyb8VPoqxyX5e/7Vh8iw+8GokbNMee5KxwaOwOARnOX11KPzSzatZcg0LzTs10Ri8fTzNda2Dod9wAAbFjnQM9rFoBmbBvCfUO3Wcj+UOyh3ec9txBY0YXrXkyxaOEvzO56KOpV5tav+FkG8Z+8x4jzHxtBAouSHLIEpoQOdAaDs/BUuDR/wdTjpmDsJEO3nTX0HCeDLTjMMHPP1h1bSlFAdT5VyWxF0Snl9IqOBGA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(47076005)(8936002)(4326008)(8676002)(83380400001)(36756003)(81166007)(82740400003)(356005)(41300700001)(86362001)(2906002)(44832011)(5660300002)(26005)(2616005)(1076003)(7696005)(40480700001)(16526019)(36860700001)(478600001)(6666004)(336012)(426003)(110136005)(70206006)(316002)(54906003)(40460700003)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:54:08.9196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5d1e8c3-1373-40d3-420a-08dbfaefe778
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7442

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

And replace rlookup_amd_iommu() with the new helper function where
applicable to avoid unnecessary loop to look up struct amd_iommu from
struct device.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 11 +++++++++
 drivers/iommu/amd/iommu.c     | 43 ++++++++++-------------------------
 include/linux/iommu.h         | 13 +++++++++++
 3 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 8b3601f285fd..4edadace486a 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -150,6 +150,17 @@ static inline void *alloc_pgtable_page(int nid, gfp_t gfp)
 	return page ? page_address(page) : NULL;
 }
 
+/*
+ * This must be called after device probe completes. During probe
+ * use rlookup_amd_iommu() get the iommu.
+ */
+static inline struct amd_iommu *get_amd_iommu_from_dev(struct device *dev)
+{
+	struct iommu_device *iommu = iommu_get_iommu_dev(dev);
+
+	return container_of(iommu, struct amd_iommu, iommu);
+}
+
 bool translation_pre_enabled(struct amd_iommu *iommu);
 bool amd_iommu_is_attach_deferred(struct device *dev);
 int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 474c073a422c..6d0ba9a35489 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1395,9 +1395,7 @@ static int device_flush_iotlb(struct iommu_dev_data *dev_data, u64 address,
 	int qdep;
 
 	qdep     = dev_data->ats_qdep;
-	iommu    = rlookup_amd_iommu(dev_data->dev);
-	if (!iommu)
-		return -EINVAL;
+	iommu    = get_amd_iommu_from_dev(dev_data->dev);
 
 	build_inv_iotlb_pages(&cmd, dev_data->devid, qdep, address,
 			      size, pasid, gn);
@@ -1423,9 +1421,7 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 	u16 alias;
 	int ret;
 
-	iommu = rlookup_amd_iommu(dev_data->dev);
-	if (!iommu)
-		return -EINVAL;
+	iommu = get_amd_iommu_from_dev(dev_data->dev);
 
 	if (dev_is_pci(dev_data->dev))
 		pdev = to_pci_dev(dev_data->dev);
@@ -1813,9 +1809,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 {
 	struct amd_iommu *iommu;
 
-	iommu = rlookup_amd_iommu(dev_data->dev);
-	if (!iommu)
-		return;
+	iommu = get_amd_iommu_from_dev(dev_data->dev);
 
 	/* Update data structures */
 	dev_data->domain = domain;
@@ -1841,9 +1835,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	struct protection_domain *domain = dev_data->domain;
 	struct amd_iommu *iommu;
 
-	iommu = rlookup_amd_iommu(dev_data->dev);
-	if (!iommu)
-		return;
+	iommu = get_amd_iommu_from_dev(dev_data->dev);
 
 	/* Update data structures */
 	dev_data->domain = NULL;
@@ -2010,10 +2002,8 @@ static void update_device_table(struct protection_domain *domain)
 	struct iommu_dev_data *dev_data;
 
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
-		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
+		struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
 
-		if (!iommu)
-			continue;
 		set_dte_entry(iommu, dev_data);
 		clone_aliases(iommu, dev_data->dev);
 	}
@@ -2194,11 +2184,8 @@ static struct iommu_domain *do_iommu_domain_alloc(unsigned int type,
 	struct protection_domain *domain;
 	struct amd_iommu *iommu = NULL;
 
-	if (dev) {
-		iommu = rlookup_amd_iommu(dev);
-		if (!iommu)
-			return ERR_PTR(-ENODEV);
-	}
+	if (dev)
+		iommu = get_amd_iommu_from_dev(dev);
 
 	/*
 	 * Since DTE[Mode]=0 is prohibited on SNP-enabled system,
@@ -2279,7 +2266,7 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct protection_domain *domain = to_pdomain(dom);
-	struct amd_iommu *iommu = rlookup_amd_iommu(dev);
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
 	int ret;
 
 	/*
@@ -2418,7 +2405,7 @@ static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
 	case IOMMU_CAP_DEFERRED_FLUSH:
 		return true;
 	case IOMMU_CAP_DIRTY_TRACKING: {
-		struct amd_iommu *iommu = rlookup_amd_iommu(dev);
+		struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
 
 		return amd_iommu_hd_support(iommu);
 	}
@@ -2447,9 +2434,7 @@ static int amd_iommu_set_dirty_tracking(struct iommu_domain *domain,
 	}
 
 	list_for_each_entry(dev_data, &pdomain->dev_list, list) {
-		iommu = rlookup_amd_iommu(dev_data->dev);
-		if (!iommu)
-			continue;
+		iommu = get_amd_iommu_from_dev(dev_data->dev);
 
 		dev_table = get_dev_table(iommu);
 		pte_root = dev_table[dev_data->devid].data[0];
@@ -2509,9 +2494,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 		return;
 
 	devid = PCI_SBDF_TO_DEVID(sbdf);
-	iommu = rlookup_amd_iommu(dev);
-	if (!iommu)
-		return;
+	iommu = get_amd_iommu_from_dev(dev);
 	pci_seg = iommu->pci_seg;
 
 	list_for_each_entry(entry, &pci_seg->unity_map, list) {
@@ -2845,9 +2828,7 @@ int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 	struct iommu_cmd cmd;
 
 	dev_data = dev_iommu_priv_get(&pdev->dev);
-	iommu    = rlookup_amd_iommu(&pdev->dev);
-	if (!iommu)
-		return -ENODEV;
+	iommu    = get_amd_iommu_from_dev(&pdev->dev);
 
 	build_complete_ppr(&cmd, dev_data->devid, pasid, status,
 			   tag, dev_data->pri_tlp);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 8d4f74ff2a8b..44fe09162b21 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -670,6 +670,19 @@ static inline struct iommu_device *dev_to_iommu_device(struct device *dev)
 	return (struct iommu_device *)dev_get_drvdata(dev);
 }
 
+/**
+ * iommu_get_iommu_dev - Get iommu_device for a device
+ * @dev: an end-point device
+ *
+ * Note that this function must be called from the iommu_ops
+ * to retrieve the iommu_device for a device, which the core code
+ * guarentees it will not invoke the op without an attached iommu.
+ */
+static inline struct iommu_device *iommu_get_iommu_dev(struct device *dev)
+{
+	return dev->iommu->iommu_dev;
+}
+
 static inline void iommu_iotlb_gather_init(struct iommu_iotlb_gather *gather)
 {
 	*gather = (struct iommu_iotlb_gather) {
-- 
2.31.1

