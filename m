Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C067DDBF
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 10:03:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ml7gRBx6n8HVWaiem6995leVgk0h0LqR061u2/QD2X00CyBqgapEIbzrctzo51x5FLPVo9dYDuGKOlKnd8vKTwSvqzYq2izIjBXb5fzny6OHP/9VIS97LDiKczpl6D8g2BcvCs86hcUUSPjsaizf6T10qQPZ+B9qgik4z7FNJWN6swJkGhjG0sA0Q0gIpSOHdVUPGTnG9Imv6eCScdFvgIHT/oJZO5jxx2dRnscQlMB/1CVGw9+qZ1cJiBnquJB3O0yBXH1CXPJk2hfWCng6qUqgvKRhrhoei408kVShploCsqzSc7P4XLMs+CX8Eh29asTc6HFqE7MIs1nYotYV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y140zXomV8J0sAQrWAtzCke+CEUZcBUwYOupA2df5q8=;
 b=A2vZQzDzyQ6/ECNbDkGA44AyojWx1snIsjb7WuJ8sNMHnbaLF35cq+nGEIk6RPbPL47+cx6m81/FPVkhXg4fEcluLELF+NA3o2pf439h9R2cqkgtJfjPDiCwO+SnozxMyyvE9lOP42MJ5DgMFBtarfoYbQVMQ22wGAHT3NwN8pe/X+NCd27PES0/ewgExUL4/jtsq+dGwg5sbx4Kncx82UE8tS124aMsvyi2FgEk3m1IYz676aXYvwAW/yuRd4Wq6WaEQ3Avr09E2EAGWX/NykGNclcIEFF1ueBALVdGFyRTzF6oksbtOG6xCzgWQCS4dkeIsyZQIWc6j1ASLP6wTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y140zXomV8J0sAQrWAtzCke+CEUZcBUwYOupA2df5q8=;
 b=oRCaqi7nljU+wSK9v8EpCNoA5Wz2Q38eUFfDaH8fpWxoS/I+u70zLIkQ9IbaW/2ZfKmsa6pSv1Xnt4qoPO6ifnzQfYDOUVd/UOs8mCPi78OUM7eYrTawzosF9qu8LSXB3fHacmgJMt//3aBqIQFt7NqFX9C9I0JPY0UbSEo75J0=
Received: from SA9PR13CA0095.namprd13.prod.outlook.com (2603:10b6:806:24::10)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 10:03:15 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::6e) by SA9PR13CA0095.outlook.office365.com
 (2603:10b6:806:24::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.16 via Frontend
 Transport; Tue, 8 Aug 2023 10:03:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 10:03:18 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 05:03:15 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 01/11] iommu/amd: Rename helper function rlookup_amd_iommu()
Date: Tue, 8 Aug 2023 10:02:22 +0000
Message-ID: <20230808100232.5977-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808100232.5977-1-vasant.hegde@amd.com>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: a15e8072-6720-4999-71fa-08db97f6b0d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s06KLmUa4tyml59pYSkuazIBw73rGEgEnCSEOFRBbWuh8z17NkLjt2j+rV+FOI65+iDhSVMNxev4lNn5Xf4ylXu52bGc0K3AmH25uezWVrEr9qH1RbE47ateMA+j81V+2pOGpms1a1hS8u/J/LJehzWYaHFUip+WzCjXplCBBpr+NMoE+Dv+CxSedrXjmIt9PT/O4P5ZoMZjq4M+D4hzEODDyCOTWcr4GTaqAdRwNNnr3vHY+UOTWaAmpi8PGzULmj6pdCMaRTha+ml2Wyb1amDLkho+oFLZFK+eZum0ULaIWVRv1P9Mo2Zj+0RzPUj2TibaXnABCddKLOvVw7a8pEVV4f3oAs2VbLlDWL6uOXufNg3aFW8PXT/TaDGFan35YruBMl+efRYK1dwJn0VdFoDi1DLt5xxPTHzT5l8mALM/rIV8dC0MLcpCBTtUSQDOr66opqm6XUhGGj6Rb5T4B/FMt25yb+wZhDkipZ/onfs/tVv2grTVsogn5gnDJbGasQ7zACCNYmnzD2Ekyx+7YE7KduJ8FjMIqV9Gq/90oD1hqbDuAV6mln8xZTlmTOXWGdJ/XL49Lgr+9wSjlT3r085uw10oP936cdIaovwsq+zNYOlcyzF3MeFLlmFyko0uH6NSOXK67RYKlY25klVgPAxy5x/YSP5umiqE1ZGg0mx695G7iWGiz6nzdkDfXeP9vVceWOq9ZjZq8VXQtG/oI3YBIeWYxNu57HBs7f9NnWxVNmxRDZZ3pI/csKwtPR3EqdeXwsHySJEHCv/OB72eag==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(82310400008)(186006)(1800799003)(36840700001)(40470700004)(46966006)(40460700003)(82740400003)(16526019)(336012)(1076003)(26005)(86362001)(83380400001)(47076005)(2616005)(426003)(356005)(36860700001)(81166007)(2906002)(478600001)(7696005)(6666004)(36756003)(54906003)(40480700001)(110136005)(70206006)(70586007)(5660300002)(44832011)(8676002)(8936002)(41300700001)(4326008)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:03:18.6853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a15e8072-6720-4999-71fa-08db97f6b0d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Rename and make it available to other code.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 +
 drivers/iommu/amd/iommu.c     | 30 +++++++++++++++---------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 56996dc2868d..1471ab2dddd1 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -24,6 +24,7 @@ int amd_iommu_init_devices(void);
 void amd_iommu_uninit_devices(void);
 void amd_iommu_init_notifier(void);
 void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
+struct amd_iommu *amd_iommu_rlookup_iommu(struct device *dev);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
 void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 26e509ffe77a..77b913211c35 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -164,7 +164,7 @@ static struct amd_iommu *__rlookup_amd_iommu(u16 seg, u16 devid)
 	return NULL;
 }
 
-static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
+struct amd_iommu *amd_iommu_rlookup_iommu(struct device *dev)
 {
 	u16 seg = get_device_segment(dev);
 	int devid = get_device_sbdf_id(dev);
@@ -218,7 +218,7 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 	if (devid == alias)
 		return 0;
 
-	iommu = rlookup_amd_iommu(&pdev->dev);
+	iommu = amd_iommu_rlookup_iommu(&pdev->dev);
 	if (!iommu)
 		return 0;
 
@@ -469,7 +469,7 @@ static bool check_device(struct device *dev)
 		return false;
 	devid = PCI_SBDF_TO_DEVID(sbdf);
 
-	iommu = rlookup_amd_iommu(dev);
+	iommu = amd_iommu_rlookup_iommu(dev);
 	if (!iommu)
 		return false;
 
@@ -1427,7 +1427,7 @@ static int device_flush_iotlb(struct iommu_dev_data *dev_data,
 	int qdep;
 
 	qdep     = dev_data->ats_qdep;
-	iommu    = rlookup_amd_iommu(dev_data->dev);
+	iommu    = amd_iommu_rlookup_iommu(dev_data->dev);
 	if (!iommu)
 		return -EINVAL;
 
@@ -1454,7 +1454,7 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 	u16 alias;
 	int ret;
 
-	iommu = rlookup_amd_iommu(dev_data->dev);
+	iommu = amd_iommu_rlookup_iommu(dev_data->dev);
 	if (!iommu)
 		return -EINVAL;
 
@@ -1822,7 +1822,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	struct amd_iommu *iommu;
 	bool ats;
 
-	iommu = rlookup_amd_iommu(dev_data->dev);
+	iommu = amd_iommu_rlookup_iommu(dev_data->dev);
 	if (!iommu)
 		return;
 	ats   = dev_data->ats_enabled;
@@ -1852,7 +1852,7 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	struct protection_domain *domain = dev_data->domain;
 	struct amd_iommu *iommu;
 
-	iommu = rlookup_amd_iommu(dev_data->dev);
+	iommu = amd_iommu_rlookup_iommu(dev_data->dev);
 	if (!iommu)
 		return;
 
@@ -1965,7 +1965,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 	if (!check_device(dev))
 		return ERR_PTR(-ENODEV);
 
-	iommu = rlookup_amd_iommu(dev);
+	iommu = amd_iommu_rlookup_iommu(dev);
 	if (!iommu)
 		return ERR_PTR(-ENODEV);
 
@@ -2006,7 +2006,7 @@ static void amd_iommu_release_device(struct device *dev)
 	if (!check_device(dev))
 		return;
 
-	iommu = rlookup_amd_iommu(dev);
+	iommu = amd_iommu_rlookup_iommu(dev);
 	if (!iommu)
 		return;
 
@@ -2033,7 +2033,7 @@ static void update_device_table(struct protection_domain *domain)
 	struct iommu_dev_data *dev_data;
 
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
-		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
+		struct amd_iommu *iommu = amd_iommu_rlookup_iommu(dev_data->dev);
 
 		if (!iommu)
 			continue;
@@ -2254,7 +2254,7 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct protection_domain *domain = to_pdomain(dom);
-	struct amd_iommu *iommu = rlookup_amd_iommu(dev);
+	struct amd_iommu *iommu = amd_iommu_rlookup_iommu(dev);
 	int ret;
 
 	/*
@@ -2405,7 +2405,7 @@ static void amd_iommu_get_resv_regions(struct device *dev,
 		return;
 
 	devid = PCI_SBDF_TO_DEVID(sbdf);
-	iommu = rlookup_amd_iommu(dev);
+	iommu = amd_iommu_rlookup_iommu(dev);
 	if (!iommu)
 		return;
 	pci_seg = iommu->pci_seg;
@@ -2641,7 +2641,7 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 			continue;
 
 		qdep  = dev_data->ats_qdep;
-		iommu = rlookup_amd_iommu(dev_data->dev);
+		iommu = amd_iommu_rlookup_iommu(dev_data->dev);
 		if (!iommu)
 			continue;
 		build_inv_iotlb_pasid(&cmd, dev_data->devid, pasid,
@@ -2800,7 +2800,7 @@ int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 	struct iommu_cmd cmd;
 
 	dev_data = dev_iommu_priv_get(&pdev->dev);
-	iommu    = rlookup_amd_iommu(&pdev->dev);
+	iommu    = amd_iommu_rlookup_iommu(&pdev->dev);
 	if (!iommu)
 		return -ENODEV;
 
@@ -2943,7 +2943,7 @@ static int set_remap_table_entry_alias(struct pci_dev *pdev, u16 alias,
 {
 	struct irq_remap_table *table = data;
 	struct amd_iommu_pci_seg *pci_seg;
-	struct amd_iommu *iommu = rlookup_amd_iommu(&pdev->dev);
+	struct amd_iommu *iommu = amd_iommu_rlookup_iommu(&pdev->dev);
 
 	if (!iommu)
 		return -EINVAL;
-- 
2.31.1

