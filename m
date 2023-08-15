Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8213C1D
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+4b/t8Dggy8mNn+0xDA2xI3NPEemuYJWhrYgQ2m6jqzFWCx2FX6Wh+FA3bav0G6cXZmbGfMOVkqqJTKKZVziUQkOrJoJdBtQ36lo8KI+ZAphhTxyuH8OdaJAICaQv5NipqtqhbNK2CyjinYTvmAShbAhSgZAVws6wi1isJAX1o2pS12lIfnzO/5/SXeyUL7M//Wu5mFf2UdI9GXC+7OGrV30WYzMlAijmJhpDPWfDk2TdzYXiPzPmKg2FtYyO2nBPNLfCLwO+4xqo1PNSAD1KfQ0ll2mFJnHDZbZVI9q2D8wK9SgdREuJd4ZQWD9vwB9+kEif2kj49VmVAvDDwrlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVRlx053PSZDgW2y7jv5AeADfgRhosnT48WyxdSmRZ8=;
 b=M6lZ1tIMcMTdoMn6C3j7hVRzOR7wkHuFxIE5q3m30L0NCUQtaQQXb/7IJCoc7VSpb5lrk3klyHlmDoznMfXrnfs7b/hkuni380lqIOoQDzD0vJ2RMnhZF2AVr9JEy+FXrRd84CVwqzq1EXeRMQTuvc/mPmHdgbrN/9WxKWo3weeuyCfyQ2uF3UK3jpKu9OxTt4BgA57HuG4LZFwis46fv6emZfEpLXGwTmb8YYR3z42yy+x12OeQfkJw8DARlqt7GQxAi60twdR/FT1Jy7A+c34bLM2x9jUL3ofho0rublDnCU5yvkUEB3Zx/gRMkjOmLmsljztvlf570tYT2yIwrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVRlx053PSZDgW2y7jv5AeADfgRhosnT48WyxdSmRZ8=;
 b=ysr/70uFDXPI+lNO6Vyx7cJIQ5mG0wHumXpuCoZVAXiO4SqIjU+ttfioT7q/UfnbxBaipLVhKcopFvNAgeskzmBojH7uHrre7rwh4gIOyytsUoBtMcegFyGYxtM8nMK2XDf19F0bdecIklcelYpwBH95Ms1T968wks21BHUQrKM=
Received: from CY5PR19CA0083.namprd19.prod.outlook.com (2603:10b6:930:69::21)
 by IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:34:38 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::b8) by CY5PR19CA0083.outlook.office365.com
 (2603:10b6:930:69::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 10:34:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 10:34:38 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 05:34:35 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 4/4] iommu/amd: Remove unused EXPORT_SYMBOLS
Date: Tue, 15 Aug 2023 10:32:55 +0000
Message-ID: <20230815103255.565295-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815103255.565295-1-vasant.hegde@amd.com>
References: <20230815103255.565295-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|IA1PR12MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ccbca5-a0d1-4120-891f-08db9d7b3a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GFboti/9dgJUXCbbpCw2k5xuqU0GD7GOd3KToQ7NfQJ7jD/BY4L1AHCw3vjQl+wSg+I70fRMMSlVSmpdfqEXE8nEGYPIH/JNTzeKi5sadUggyfEdNv1vNDa+hSV7tpz/OD6weLQhAamEG+yhGKtqnxA0qxkbXxgtlJFSn66ETZoQpBBz5Y4cLgDGkvxPVj0lDlxNBbfbQRtOhod3gFidpd7DR3VqH0lE+10jleZ/NGiv4O6TJtpMqEzgAbfgEBVGY1xcGneeAwwKPTK5cFQAJ1Bge2sh+Lu8ZTDKUlwyZywZe9avEPV7wNZ5QxC8ZSkYY8bhOGaL/wAtL8CsTo3wnbuAhDLclY5dPdrFbsZ9MoEt6VqgObIh/N74CW3h3QXF3BXOl65dzX5etQ5Cm+hXTLSUkHJhFPJTTc1yBGDQaPM6MrletI116kxwRUESGEnOEEHZQC/Shf/aSwaA/Kbb8WJTbdT+xrIwV65RFVDUunCuDq7fUNVGoYUF5VPAeZdmYi4SbNeLLFWWhqx1ZDrA40f+oKjuNiFlp8G/3sXT1lmlaEqF4ltpy/hynZenm7jNdtuIHzxGQMpce37fpAx9RGkAdCSixTZH5Hi9jTLYfyoYJhhSodbyxtbXY/V7GbI+4+p11NXWTR4ZnjD+std5NyCuMSwuOjjDJu4oHz/X5Kg7/QuEB5NOv3RDcCjJ0iBMeEMXFsyNhB9QDDmbppKkhAy/PL58Po7LyxeQtTjZ/MnD4G9itUKA+h2e2Ec0Vnbq1cMTQxixC4/B4+GRN8I39w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(82310400008)(1800799006)(451199021)(186006)(40470700004)(36840700001)(46966006)(83380400001)(36756003)(82740400003)(40460700003)(40480700001)(356005)(81166007)(54906003)(478600001)(110136005)(7696005)(6666004)(41300700001)(44832011)(5660300002)(8936002)(8676002)(2906002)(4326008)(316002)(70206006)(70586007)(47076005)(2616005)(426003)(36860700001)(16526019)(26005)(336012)(1076003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:34:38.4367
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ccbca5-a0d1-4120-891f-08db9d7b3a2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192

Drop EXPORT_SYMBOLS for the functions that are not used by any modules.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c  | 1 -
 drivers/iommu/amd/iommu.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index b6b6e64960ce..fb203df03dfa 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3667,7 +3667,6 @@ bool amd_iommu_v2_supported(void)
 	 */
 	return amd_iommu_gt_ppr_supported() && !amd_iommu_snp_en;
 }
-EXPORT_SYMBOL(amd_iommu_v2_supported);
 
 struct amd_iommu *get_amd_iommu(unsigned int idx)
 {
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fdb5b1362ba0..8e4f52d8bc9d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2446,7 +2446,6 @@ bool amd_iommu_is_attach_deferred(struct device *dev)
 
 	return dev_data->defer_attach;
 }
-EXPORT_SYMBOL_GPL(amd_iommu_is_attach_deferred);
 
 static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
@@ -2606,7 +2605,6 @@ int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
 
 	return ret;
 }
-EXPORT_SYMBOL(amd_iommu_flush_page);
 
 static int __amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid)
 {
@@ -2626,7 +2624,6 @@ int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
 
 	return ret;
 }
-EXPORT_SYMBOL(amd_iommu_flush_tlb);
 
 static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
 {
@@ -2706,7 +2703,6 @@ int amd_iommu_domain_set_gcr3(struct iommu_domain *dom, u32 pasid,
 
 	return ret;
 }
-EXPORT_SYMBOL(amd_iommu_domain_set_gcr3);
 
 int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid)
 {
@@ -2720,7 +2716,6 @@ int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid)
 
 	return ret;
 }
-EXPORT_SYMBOL(amd_iommu_domain_clear_gcr3);
 
 int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 			   int status, int tag)
@@ -2739,7 +2734,6 @@ int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 
 	return iommu_queue_command(iommu, &cmd);
 }
-EXPORT_SYMBOL(amd_iommu_complete_ppr);
 
 #ifdef CONFIG_IRQ_REMAP
 
-- 
2.31.1

