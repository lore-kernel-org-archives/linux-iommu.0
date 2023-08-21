Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB231848
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0nZV8QqSwBcXBCkPXxF2WnrcgHI5ZEyO0OMYsuzAXi5aNfw0UUELHD7IjnWZwCG+5oqxAnZUn5LPP/JTtGdk4hPqGvjLi/MqvVanFOt11uWQqXMsTkqqs9jGoS2tcc2uASPdowxpBiwQLKRv5SgeqlTfgXSD4FDVwTuloIcJYevjnveNTs7k9Aqqo9+Vuhaf0WMuAVRPnR0ADnxTHg091pW8Xb2VTVnA4dVNCGucsA2WGrxeTHhjhGeDtD9SXHRBcFEvGKgSwJ/QGFE3Tw4kaXdaD5ChrRgODrdbn41Wy4DXa6wT5HS2Or74Nk8QfK17yYtIxUXAACau1Jn9mUu8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12ASi41rGfzLsloCXktWvgsEdfkGc/9uujy7YCuCTaw=;
 b=Y3SGXvSSMIlhY01KwSGSlfl+rO8dpBkIj52cIslrH34XwMH1S3HxzVPpm/gjrWCkv0m8xhXen0yWC59/EPbnLrBfLLvpbkOz5427HepVIawE4OKnvSVdkO1o80elEPFHQ/w96Gk5lCGdFPDSQx5EhjHM7+G8IKo9hCVfRpoC145FheFn98+jg1q4VC/5R/I6u0tIFgK5FcN8GyZu1J5JozTd9AE6FMyJRDAmw/hUOjhk66lYDbL71MZ2Co/n/2BnuQTsxCiqjCU/0o8GczxASq7QeBcdYIctMFs6HS5FERAkW5DpmSyvKtDnAbcGlrZnl4rTgw/dPZz5Oz/zo8y4SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12ASi41rGfzLsloCXktWvgsEdfkGc/9uujy7YCuCTaw=;
 b=avr13R6Lss3tU99EskdyThTpqrHAShgm/nRUnr9vEdfvfFcP9sMajl+09oIgAxJ7ZG72B++njMKCggldsPNcM+d4LfKjWqqUv4M946l19WNO01oewg5RLtJ//MsTOjx8tW+DQ890afwFEpRksMNez5yBljpetAHnoWY4xYhyZPE=
Received: from SA9PR13CA0116.namprd13.prod.outlook.com (2603:10b6:806:24::31)
 by CYYPR12MB8991.namprd12.prod.outlook.com (2603:10b6:930:b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 10:46:42 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:24:cafe::88) by SA9PR13CA0116.outlook.office365.com
 (2603:10b6:806:24::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Mon, 21 Aug 2023 10:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 10:46:42 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 05:46:39 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 10/14] iommu/amd: Rename ats related variables
Date: Mon, 21 Aug 2023 10:42:23 +0000
Message-ID: <20230821104227.706997-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821104227.706997-1-vasant.hegde@amd.com>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CYYPR12MB8991:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c182b6-c704-4bec-7009-08dba233e7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PMRCoT3hTpXYUpWn7spHW2HS0GnSur+aoGiLYmNZWtKbqnQvtVD8mS5k/ng+ByOUGPE08xyS8Sxj9MD7S5zHFRg5G4xAs24Q+0rl+NB/KBezeaHj2dykGF95pQ/Ljwem+HWTawAsba9iNTiJvnzwnMCqStMWVF5UHIOiDxtXIQpbyW+52YMPpnrpm7lyoBolgrkt33XPibfrnUm6weub77Cdyie7xda5UEJdJEluJhQhWIN6kTMCyAw3E3ZhiMz6QsdP3u/j6qSXqtaBgtTOBckko8wlVfIA7fAKPv87Ky80X58e8cWFTilDRxDpOwvj8UQh+O+Q9crHVR+CmxN+5gJqDyZyX8SYwzw1zcGfI6kx64PFFc5RWsaifHyU9xOELfqzG0W2K5mGJvMmJFq5JVENdgNbnRuwuE3I9wXlOp4xkWDqYJ03o+kwAUlspPsOEqY9ap0yo/0aRd/LxrY/sgQG2CklSOMEfnOjsdkpfR4au4DAshHXwjyoMK0wnf8bFZ2V+/8t0o2FLYRU7XJkF1oOxjeWWShKlUmFTtcAavDmF8WweM+H89W5aEbYQUEWVcjkbCGHL08Hf9ZZmAkO7h8w2mLT9tIIeZgHdJfeG05TgMf2tQhQ33aWDKISxc+4RlDvkOT2kVgG4Qz5YxzZDFyEFjNwkTNVtFTd2wvtzrVvD/No0Y/+a4gkE91dT/HLXb3V6FCNVAd3NVcERaShHPixhfKsb1MHp6hMJpuI34YfrSllul9kBRWs+qM5vSLNsAB13NRxOxCUmLzh+Y2Yeg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(7696005)(40480700001)(5660300002)(44832011)(336012)(426003)(16526019)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(54906003)(70586007)(110136005)(478600001)(82740400003)(356005)(81166007)(6666004)(40460700003)(41300700001)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:46:42.0692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c182b6-c704-4bec-7009-08dba233e7ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8991

Remove nested structure and make it as 'ats_{enable/qdep}'.
Also convert 'dev_data.pri_tlp' to bit field.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  8 +++-----
 drivers/iommu/amd/iommu.c           | 28 ++++++++++++++--------------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 29e76c1e9f9e..1c61dca63824 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -812,11 +812,9 @@ struct iommu_dev_data {
 	struct device *dev;
 	u16 devid;			  /* PCI Device ID */
 	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
-	struct {
-		bool enabled;
-		int qdep;
-	} ats;				  /* ATS state */
-	bool pri_tlp;			  /* PASID TLB required for
+	int ats_qdep;
+	u8 ats_enabled  :1;		  /* ATS state */
+	u8 pri_tlp      :1;		  /* PASID TLB required for
 					     PPR completions */
 	bool use_vapic;			  /* Enable device to use vapic mode */
 	bool defer_attach;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 94f8c52e8aeb..44d53d2bd755 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1091,7 +1091,7 @@ static void build_inv_iotlb_pasid(struct iommu_cmd *cmd, u16 devid, u32 pasid,
 }
 
 static void build_complete_ppr(struct iommu_cmd *cmd, u16 devid, u32 pasid,
-			       int status, int tag, bool gn)
+			       int status, int tag, u8 gn)
 {
 	memset(cmd, 0, sizeof(*cmd));
 
@@ -1314,7 +1314,7 @@ static int device_flush_iotlb(struct iommu_dev_data *dev_data,
 	struct iommu_cmd cmd;
 	int qdep;
 
-	qdep     = dev_data->ats.qdep;
+	qdep     = dev_data->ats_qdep;
 	iommu    = rlookup_amd_iommu(dev_data->dev);
 	if (!iommu)
 		return -EINVAL;
@@ -1365,7 +1365,7 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 			return ret;
 	}
 
-	if (dev_data->ats.enabled)
+	if (dev_data->ats_enabled)
 		ret = device_flush_iotlb(dev_data, 0, ~0UL);
 
 	return ret;
@@ -1398,7 +1398,7 @@ static void __domain_flush_pages(struct protection_domain *domain,
 
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
 
-		if (!dev_data->ats.enabled)
+		if (!dev_data->ats_enabled)
 			continue;
 
 		ret |= device_flush_iotlb(dev_data, address, size);
@@ -1718,7 +1718,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	iommu = rlookup_amd_iommu(dev_data->dev);
 	if (!iommu)
 		return;
-	ats   = dev_data->ats.enabled;
+	ats   = dev_data->ats_enabled;
 
 	/* Update data structures */
 	dev_data->domain = domain;
@@ -1856,14 +1856,14 @@ static int attach_device(struct device *dev,
 			if (pdev_pri_ats_enable(pdev) != 0)
 				goto out;
 
-			dev_data->ats.enabled = true;
-			dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
+			dev_data->ats_enabled = 1;
+			dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
 			dev_data->pri_tlp     = pci_prg_resp_pasid_required(pdev);
 		}
 	} else if (amd_iommu_iotlb_sup &&
 		   pci_enable_ats(pdev, PAGE_SHIFT) == 0) {
-		dev_data->ats.enabled = true;
-		dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
+		dev_data->ats_enabled = 1;
+		dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
 	}
 
 skip_ats_check:
@@ -1920,10 +1920,10 @@ static void detach_device(struct device *dev)
 
 	if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
 		pdev_iommuv2_disable(to_pci_dev(dev));
-	else if (dev_data->ats.enabled)
+	else if (dev_data->ats_enabled)
 		pci_disable_ats(to_pci_dev(dev));
 
-	dev_data->ats.enabled = false;
+	dev_data->ats_enabled = 0;
 
 out:
 	spin_unlock(&dev_data->lock);
@@ -2013,7 +2013,7 @@ static void update_device_table(struct protection_domain *domain)
 		if (!iommu)
 			continue;
 		set_dte_entry(iommu, dev_data->devid, domain,
-			      dev_data->ats.enabled, dev_data->iommu_v2);
+			      dev_data->ats_enabled, dev_data->iommu_v2);
 		clone_aliases(iommu, dev_data->dev);
 	}
 }
@@ -2612,10 +2612,10 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 		   There might be non-IOMMUv2 capable devices in an IOMMUv2
 		 * domain.
 		 */
-		if (!dev_data->ats.enabled)
+		if (!dev_data->ats_enabled)
 			continue;
 
-		qdep  = dev_data->ats.qdep;
+		qdep  = dev_data->ats_qdep;
 		iommu = rlookup_amd_iommu(dev_data->dev);
 		if (!iommu)
 			continue;
-- 
2.31.1

