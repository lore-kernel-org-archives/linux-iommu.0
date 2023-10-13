Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B71F11CBC
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EkkWmEsK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBBAemHY4vb9rp+mketqWV/5DnqrwnmNXrucDoVhl8fg7jD4lpRvLT+bMuLtG+dVHocKwOMwDP9wrkkfLT3rX+SeJHp3v9btTQUOgbaxHm+RCfTFoHH00qmZ4PINQQ7BdhJMURkX5iff9gSm5Id3bDDhlwPNkIeJPTIiRbwUdAc47R+RQE7Qmf3eVIBoIJeTw+gLrbx/UW75XGdGwbfT1xrWJVIOwa6918NOPfVh3xOuDEG5Joww95iG5tkMokahXTlbhgkTwJqoIFmHpM26yJxP7RJQa2dvtDjRCBsQS+b5m2nDs4L7qS/gy3Dq7hIkKsKG3wqBuBWr3faCDdyp7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Voy9GPdtb2ZwYbRnb3/NYWy37HRqF0Ic8jvG+T79Usg=;
 b=aPgUxB2RGnQL6dkwt1+R9eyQ122wBXT0VrP47B/J5Cj8pIAqB2DBuYGyfOrGMYDpDCJoNi7CkYy95vr/5UQtYLb6MMsTXEAQog1Ta31fY9ejLCtWrgTYVtL4G5XkGL/wOSVb1rNrgDfadpXioKTmIFGF+QSNcYxZ1jbtylJ62x39TuJxjb8XDqEUNAWmEvosscF/4vDEPZkhaa15UY+Xr26nUHoIKyIefWL0QDBGPP/xC7nYnvbZmrE8wHhDMTcyaprPRshAV3waoxUH9cf/lsWOeXJ3z7DxEmp3uQtdfQDUlX/VlOu0HJD7JwzI6k9xgbAGpm7aRQe95a97rwH7sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Voy9GPdtb2ZwYbRnb3/NYWy37HRqF0Ic8jvG+T79Usg=;
 b=EkkWmEsKP5ThQRi6or9zzYqk+fGZ+PwfP3SP6PxWQm1+NK/3/W1qFpvjV+PfUnyozULk/dEk/0Tlc3LJp4p8MQlbkfNvA8R6nOh5qpwmlMhVGiBqs7rT/rL744bun7BdG5XmzW7GcN6yAfK8PdzO7f8a1+KE1noQoZH9zcAc5y8=
Received: from BL1PR13CA0263.namprd13.prod.outlook.com (2603:10b6:208:2ba::28)
 by MN0PR12MB6002.namprd12.prod.outlook.com (2603:10b6:208:37e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Fri, 13 Oct
 2023 15:18:10 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::54) by BL1PR13CA0263.outlook.office365.com
 (2603:10b6:208:2ba::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.16 via Frontend
 Transport; Fri, 13 Oct 2023 15:18:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 15:18:10 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 10:18:07 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 02/13] iommu/amd: Introduce get_amd_iommu_from_dev()
Date: Fri, 13 Oct 2023 15:16:41 +0000
Message-ID: <20231013151652.6008-3-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|MN0PR12MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab929f9-bcb7-4db2-0ba0-08dbcbff9c38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Zcv2UY9PmgJ/rvaNLsuFxwcUNh/VsJSaXHsnmeCqshz0aOgRBAivDLYZAb+uBauZuBLoUbDhz3k/SLzDHHr6xSJHEDpO8eJdIAXsXgkyvpiF2gCAlhVj1cwYRJ0l5PzdtiKgZNLlwEhDzODO2gOkRuxsZWWkEDrUxOOcsVtiHNgF8txodpRj2I6VE2RJvuzSuy3wYjfuhQRzMCD3NU+ELVZGVh/K49KDhS7HP7Vix94oweZybcca/d7BL3cOm6Py0oT5DevpAFvLksz5NDdAjuDzUX5FlgM7fLOwJvME1ueTDTseoZKwJ6FfIhhr9kuy+MBElasidDgI6wYRcm3pxUu0kdqr//9j/+zInEJFS1fbr4VOx0nKF5HDTuUcQ7Nnuz+H8L5OYYurEZra3nsIUP5uZ1A4KWfN43gveAIQC2sPuoUinTLaNmlBRP4Cx3485ruKeFMIHatRppKq/6TqehWZLfkj7kcqpALM5w9tEbzAjSYKAadNB4SdptS8LafWz5WpWpVIuX4lf4iGwv46tUl1iBE/CrlCvsEYcr6GOvyY7XBFx/4+q/i/nMsZ5siR994NkwFWgysWcX7w0ioQKR04ZX+lerQZNfYDXC8rIJN0b5ChvNwSX52X7p94Qy1CqaZhCozq4EyTekC//9YbWk9piM5yyr8lw0vec3c26dwwFikEv1dfjSdhOex/X++1YJIvKDl23/ayq8VioP/cCq4EruX2qDKDgr/kGIDkt51hBsMR4gk/+Xamkw/epx4QVtnCcgFPk+frhltP++UkFQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(5660300002)(16526019)(26005)(336012)(426003)(2616005)(1076003)(36860700001)(8936002)(8676002)(7696005)(4326008)(2906002)(44832011)(478600001)(54906003)(316002)(70206006)(70586007)(41300700001)(110136005)(47076005)(82740400003)(81166007)(356005)(36756003)(40460700003)(40480700001)(86362001)(83380400001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:18:10.0293
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab929f9-bcb7-4db2-0ba0-08dbcbff9c38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6002

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

And replace rlookup_amd_iommu() with the new helper function where
applicable to avoid unnecessary loop to look up struct amd_iommu from
struct device.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 14 ++++++++++++++
 drivers/iommu/amd/iommu.c     | 20 ++++++++++----------
 include/linux/iommu.h         | 13 +++++++++++++
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 38b3f4562f3b..b2071ebc73b5 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -150,6 +150,20 @@ static inline void *alloc_pgtable_page(int nid, gfp_t gfp)
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
+	if (!iommu)
+		return NULL;
+
+	return container_of(iommu, struct amd_iommu, iommu);
+}
+
 bool translation_pre_enabled(struct amd_iommu *iommu);
 bool amd_iommu_is_attach_deferred(struct device *dev);
 int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4f1b356adb8f..eedfa341085c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1408,7 +1408,7 @@ static int device_flush_iotlb_range(struct iommu_dev_data *dev_data,
 	bool gn = is_pasid_valid(pasid);
 
 	qdep     = dev_data->ats_qdep;
-	iommu    = rlookup_amd_iommu(dev_data->dev);
+	iommu    = get_amd_iommu_from_dev(dev_data->dev);
 	if (!iommu)
 		return -EINVAL;
 
@@ -1436,7 +1436,7 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 	u16 alias;
 	int ret;
 
-	iommu = rlookup_amd_iommu(dev_data->dev);
+	iommu = get_amd_iommu_from_dev(dev_data->dev);
 	if (!iommu)
 		return -EINVAL;
 
@@ -1644,7 +1644,7 @@ static void update_device_table(struct protection_domain *domain)
 	struct iommu_dev_data *dev_data;
 
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
-		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
+		struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
 
 		if (!iommu)
 			continue;
@@ -1676,7 +1676,7 @@ int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 	struct iommu_cmd cmd;
 
 	dev_data = dev_iommu_priv_get(&pdev->dev);
-	iommu    = rlookup_amd_iommu(&pdev->dev);
+	iommu    = get_amd_iommu_from_dev(&pdev->dev);
 	if (!iommu)
 		return -ENODEV;
 
@@ -1902,7 +1902,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 {
 	struct amd_iommu *iommu;
 
-	iommu = rlookup_amd_iommu(dev_data->dev);
+	iommu = get_amd_iommu_from_dev(dev_data->dev);
 	if (!iommu)
 		return;
 
@@ -1930,7 +1930,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	struct protection_domain *domain = dev_data->domain;
 	struct amd_iommu *iommu;
 
-	iommu = rlookup_amd_iommu(dev_data->dev);
+	iommu = get_amd_iommu_from_dev(dev_data->dev);
 	if (!iommu)
 		return;
 
@@ -2072,7 +2072,7 @@ static void amd_iommu_release_device(struct device *dev)
 	if (!check_device(dev))
 		return;
 
-	iommu = rlookup_amd_iommu(dev);
+	iommu = get_amd_iommu_from_dev(dev);
 	if (!iommu)
 		return;
 
@@ -2283,7 +2283,7 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct protection_domain *domain = to_pdomain(dom);
-	struct amd_iommu *iommu = rlookup_amd_iommu(dev);
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
 	int ret;
 
 	/*
@@ -2435,7 +2435,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 		return;
 
 	devid = PCI_SBDF_TO_DEVID(sbdf);
-	iommu = rlookup_amd_iommu(dev);
+	iommu = get_amd_iommu_from_dev(dev);
 	if (!iommu)
 		return;
 	pci_seg = iommu->pci_seg;
@@ -2769,7 +2769,7 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
 {
 	struct irq_remap_table *table = data;
 	struct amd_iommu_pci_seg *pci_seg;
-	struct amd_iommu *iommu = rlookup_amd_iommu(&pdev->dev);
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(&pdev->dev);
 
 	if (!iommu)
 		return -EINVAL;
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d52d0826cae1..25d9e428797c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -559,6 +559,19 @@ static inline struct iommu_device *dev_to_iommu_device(struct device *dev)
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

