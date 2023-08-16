Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F10174D0
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 17:41:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CNlqKz7b7pM1LfkxA0xGWvufGcVfQ3K/Gj4FyfGpwM566SqVHDLJajLEmK7M3rtO9lurkCyzgCWk1ZCIgVWeY5FUF3YfNtgNOwcNaeu4LFlEECDqvxmciVwBibVHmT9sQi9RBwnn9PuvRngBn8w7g3FwXClDxrELf24TLFtQeJIg2bhfe75vM2N2WYYtEGjki9mTU8SDXOEAkaNPzwGTYjQCGX2i5uAna3wEjziHpgB1mgzi/nseUmULkyYtvOwyeZZONhjb6G5OXIpA2qffUBXaJ1SlrdtIQJjMV/jfRbP/SVHqst9mZNdrNMVMSnek8k8sa6eAR7swyInmXlo+bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4zK1n+aaQPbSYiimQ4JADcCxHpGZqzgEcdWOwTrkL8=;
 b=Hci67hxaNB3c7s/rAXL17HwVJNwAPiZQZ1z8IL9afWD3C/hy4v/ewQPREzlCdoDnH9VaM426bkyQtH5Egwo6mzJe98LEnC2d6Hno3WYEfa8nGlXuyjg8vI3gOs3asR/s3ukYkQW3wM1XxQYNIeoNRJ6ARWztlRojzdo0xnwzMKfPVj2DY5CndOykjVaornb/iGNCrNhDR2Vf/aPhuFaI7a5kva2QBUERMLy9mKEagTRTdbf2dZhXhRucRbIvIOJ7q0AD9eu0gOKy00C0TZorBDZoAw9Ekd5uUjYvXPEWgrOuizR2dGDee+CU2WFRt92mbMyjeXnmbSZIwNkMzjAWYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4zK1n+aaQPbSYiimQ4JADcCxHpGZqzgEcdWOwTrkL8=;
 b=3LCTTJTvoX9b7FKHucBpqUrhT4+QCz0IfKjEJxvGIFl7ZyHB/YYI2ZJl2g51kWWEYTEOtlq0MAo0h0TQBuv1TqGbhIBqojY2AbwtrNxhT7ZNg2bBNqpBz7YRkFVnud/aXRTSJDhoRMPTe75IH9dCfdU2LcA3f8MxfMYtRayyQbc=
Received: from SN6PR05CA0001.namprd05.prod.outlook.com (2603:10b6:805:de::14)
 by MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 17:41:26 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::9) by SN6PR05CA0001.outlook.office365.com
 (2603:10b6:805:de::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 17:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 17:41:25 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 12:41:21 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 02/10] iommu/amd: Introduce get_amd_iommu_from_dev()
Date: Wed, 16 Aug 2023 17:40:23 +0000
Message-ID: <20230816174031.634453-3-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: a7843ce9-902a-48f1-de76-08db9e800396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iBMmjgogRRFxmuE3TAFxAUHaa4XKyg9tjC5gGEe3Xz6Id8u+rAQkr4AYLsvJpBYDOeIm0oB9ysHErB2NUT4bMVYi+5QTA8AZDhTPqvp4U2U785dmBZb4o2X9DiZ+25fuX1OwHnLohZIGBIHoPPggXmAEkFcoG2fn67lEAHkJJNZPEND121mIJyBuiwgIhM2OKajooA186aytGvOb7YFPbsdwOb4pcu6PQTgurq4iMO8A5RoZjK+JZCYHzxI5Nua1bPMN/DoPRy2Xlf9vx76ruiZ2ND90/c/42/NACOW3J3lfqI9ABazyyqiAsVYK629cruWG0dWRqn/Nc8klV2t6leVIP0Ofo4QQBm17TFIGJguB30vGY3NOfZB2fVLtWjuBaGZ6/OrRx95kDC5rrOXrpOsxF2M9L/RvaoUIm1tY+tunPCXCM04W1JtU55JGM9rK21YSCsjWRmCDybA+e+kPv9b5zoF1P8uE0GDOvQTIzbSa33RYLpruax6r/hZo8QO8GRO5Zz8agna8N+lB34wVcaKa8/2E2LD60ZLtKx9Xj/LcfXbpCiieCTKlgkFVfz3D17Mqu4lP6kXQzqPR6Uw63roVUq7wn438AWxdViD8SMjoDrcdsBae2UcS8Xxq+hLA5sg93mEiqPRK861/Ud+R5TmauYalvmlWf2rZ4H6Qc+1kFSdc2Tb4oc5GrLY8bpdzcKqvWi85sqea1IIhMCwaeQs537w72g4svssYSHHMPA4S1G/QPpTqehbuOpzDhNetAn6nq7rTbs7W+gu1GZaFzA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(1076003)(26005)(16526019)(5660300002)(44832011)(36860700001)(41300700001)(356005)(54906003)(82740400003)(316002)(81166007)(70206006)(70586007)(110136005)(8676002)(8936002)(4326008)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:41:25.5653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7843ce9-902a-48f1-de76-08db9e800396
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

And replace rlookup_amd_iommu() with the new helper function
where applicable to avoid unnecessary loop to look up struct amd_iommu
from struct device.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  7 +++++++
 drivers/iommu/amd/iommu.c     | 24 ++++++++++++------------
 include/linux/iommu.h         | 14 ++++++++++++++
 3 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 87739d95ea8b..639d82295797 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -152,6 +152,13 @@ static inline struct protection_domain *to_pdomain(struct iommu_domain *dom)
 	return container_of(dom, struct protection_domain, domain);
 }
 
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
index fca6e6ceeef3..002b29048813 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -217,7 +217,7 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 	if (devid == alias)
 		return 0;
 
-	iommu = rlookup_amd_iommu(&pdev->dev);
+	iommu = get_amd_iommu_from_dev(&pdev->dev);
 	if (!iommu)
 		return 0;
 
@@ -1407,7 +1407,7 @@ static int device_flush_iotlb(struct iommu_dev_data *dev_data,
 	int qdep;
 
 	qdep     = dev_data->ats_qdep;
-	iommu    = rlookup_amd_iommu(dev_data->dev);
+	iommu    = get_amd_iommu_from_dev(dev_data->dev);
 	if (!iommu)
 		return -EINVAL;
 
@@ -1434,7 +1434,7 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 	u16 alias;
 	int ret;
 
-	iommu = rlookup_amd_iommu(dev_data->dev);
+	iommu = get_amd_iommu_from_dev(dev_data->dev);
 	if (!iommu)
 		return -EINVAL;
 
@@ -1805,7 +1805,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	struct amd_iommu *iommu;
 	bool ats;
 
-	iommu = rlookup_amd_iommu(dev_data->dev);
+	iommu = get_amd_iommu_from_dev(dev_data->dev);
 	if (!iommu)
 		return;
 	ats   = dev_data->ats_enabled;
@@ -1835,7 +1835,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	struct protection_domain *domain = dev_data->domain;
 	struct amd_iommu *iommu;
 
-	iommu = rlookup_amd_iommu(dev_data->dev);
+	iommu = get_amd_iommu_from_dev(dev_data->dev);
 	if (!iommu)
 		return;
 
@@ -1989,7 +1989,7 @@ static void amd_iommu_release_device(struct device *dev)
 	if (!check_device(dev))
 		return;
 
-	iommu = rlookup_amd_iommu(dev);
+	iommu = get_amd_iommu_from_dev(dev);
 	if (!iommu)
 		return;
 
@@ -2016,7 +2016,7 @@ static void update_device_table(struct protection_domain *domain)
 	struct iommu_dev_data *dev_data;
 
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
-		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
+		struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
 
 		if (!iommu)
 			continue;
@@ -2237,7 +2237,7 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct protection_domain *domain = to_pdomain(dom);
-	struct amd_iommu *iommu = rlookup_amd_iommu(dev);
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
 	int ret;
 
 	/*
@@ -2388,7 +2388,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 		return;
 
 	devid = PCI_SBDF_TO_DEVID(sbdf);
-	iommu = rlookup_amd_iommu(dev);
+	iommu = get_amd_iommu_from_dev(dev);
 	if (!iommu)
 		return;
 	pci_seg = iommu->pci_seg;
@@ -2560,7 +2560,7 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 			continue;
 
 		qdep  = dev_data->ats_qdep;
-		iommu = rlookup_amd_iommu(dev_data->dev);
+		iommu = get_amd_iommu_from_dev(dev_data->dev);
 		if (!iommu)
 			continue;
 		build_inv_iotlb_pasid(&cmd, dev_data->devid, pasid,
@@ -2715,7 +2715,7 @@ int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 	struct iommu_cmd cmd;
 
 	dev_data = dev_iommu_priv_get(&pdev->dev);
-	iommu    = rlookup_amd_iommu(&pdev->dev);
+	iommu    = get_amd_iommu_from_dev(&pdev->dev);
 	if (!iommu)
 		return -ENODEV;
 
@@ -2835,7 +2835,7 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
 {
 	struct irq_remap_table *table = data;
 	struct amd_iommu_pci_seg *pci_seg;
-	struct amd_iommu *iommu = rlookup_amd_iommu(&pdev->dev);
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(&pdev->dev);
 
 	if (!iommu)
 		return -EINVAL;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f1e18e81fca7..5a44567678ce 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -446,6 +446,20 @@ static inline struct iommu_device *dev_to_iommu_device(struct device *dev)
 	return (struct iommu_device *)dev_get_drvdata(dev);
 }
 
+/**
+ * iommu_get_iommu_dev - Get iommu_device for a device
+ *
+ * @dev: an end-point device
+ *
+ * Note that this function must be called from of of the iommu_ops
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

