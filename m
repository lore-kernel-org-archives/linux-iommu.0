Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD14100AE
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:20:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mgtd8NqM78NXSbsvDJav93aMQbKr0HI6RZAtO5YqLGz/d0CQwV70JK852Pam1uTbBgRfBHR8KvqI8nnB/Fiaepmn5cAn0fO09YWzuiYLdOK2nOzsjAVf++LwaFmbslk4gjOq36YkCsRfL3+rBSI6Wql68L4lB26H6+HwI0rP5lWW635ac52QwRJTAaEygthJIfNVsyV56brkXye6X1IrzhGFGeh+BTc3BHUnoOyxKmmWrZdK2Fk2DkPaGFbn2zgUinj/ntg/RYDONsArX5aOgdhbCdDLdOsd+VYRDrzN1WEwzplrXYpnJKRmy/IaXWjmWyDFkQ90lLd84jgf3PqGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpM+vfVENfowPxly3/v39WWYJh+kBQzlBIwext6GucQ=;
 b=RQJ3Yi8PESW2fI2wgcDsTVtgwc0Rp2S8xyfmdGbQ3eINg5ESSDLN6kvKO/3/+c2QzrSbfALSMQP8FPCKr+C/mixaN0QnMsS+OlLetp9j+xZp1HFhsXeN+Sf6i4r3Byth0EmXnoEYChlZgGx55X4O7OhujyR7HNO8CAcaWOnCe6ckli+MfNOv39N6YxVddaic0/0/oZkA1shGvKkl4ovsl+8+x/DKsm9xTUSBkA7P09qrUHhN9XGb8dmvysyIdIcOFmgFawugMQJJGUleAzE//e8Hws1eYGYZ+8wivF7AhNv17sqw6jvzZPwo/mjQtg9/I5dim1ya/x2A/KEw4vs8sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpM+vfVENfowPxly3/v39WWYJh+kBQzlBIwext6GucQ=;
 b=nyLKlVHL3tYuvrVsLrM+/RKEm9X/6hMiW62RyC0RCgbfPfw5EQeQHgrVyOiQs0V5lJr4OhURnFTSoMBMdCGtYgVGbw4UO+A36b/YgZ2nLACj51y1dj1eja/FOmT05CsQ+6sGnSAHTAFxC/QWeG5lF+vXkDN5EtqJBm3xmd8xtMA=
Received: from MW4PR04CA0100.namprd04.prod.outlook.com (2603:10b6:303:83::15)
 by DS0PR12MB9037.namprd12.prod.outlook.com (2603:10b6:8:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 14:20:10 +0000
Received: from CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::63) by MW4PR04CA0100.outlook.office365.com
 (2603:10b6:303:83::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 14:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT077.mail.protection.outlook.com (10.13.175.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 14:20:10 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:20:07 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 17/21] iommu/amd: Rename ats related variables
Date: Wed, 12 Jul 2023 14:15:12 +0000
Message-ID: <20230712141516.154144-18-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712141516.154144-1-vasant.hegde@amd.com>
References: <20230712141516.154144-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT077:EE_|DS0PR12MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f56a9d3-4142-44a0-ff82-08db82e319c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w1r/X0rOMt/+AeCcC08E0c/2TTU6gpZfDVFgWCK/QdO8AQ0fib4QzVErerAOO42iOVPgyTmBP24cSgtcK4RE+jeHK0E7ph43wllyAIVOz8KO/ejXeyQa9BqD+RK+vnveGtLgqHXUUZuAO+iGMZClV61jm/ZAyCDBv4MfhIhSCXIpqc7qF4lsBjyA7fQtsG8TBgRRkWdx745oLr1zkLQ0RQ32ipa0NR++DVNcpkr9esudpvBPFWDgWA6gYhLh5h3HSTA8yM+zrugTauvrN4d8u34TR1Ej1ot/mfKeTiib634BzGeiNVc2IJx9rJru7pHLeF+HqWZoIyo+KN+4OQDCkF6DdMCZhJP3FiQs1zPtJCNFLItkke7wf5TBOmAhUlvKaVlHNtY0cJamx/BJAWdxs0qxTPa6KUSBWtvcEjIClDw2QaUSTfsV9uUuvhracMo2d0nqRxv3ur/8PV6yQI7ds4d6fEoXSW6pEZl0kQWBaiR9aRIRaZRd9HfbmOB1CGTXO+gPQZNEBWj9Q6r7O0A8RI88FZ7hCxm/zf7tCtVTMTmxtBOWcuyeSdnGNFzCasviSXgUVVY/B3JGY4NYrhZLVkaWX3wTxVO0wwtU0KDLxNdR1UwjZPFObz3fES55dXwlorNvEhiD6ZV9b3UAWbZTsxB8EDnjN2cGxQ5GzzHCRBUzkWSgj5xMmYxAicZoHDwvHH4eCMon//5yD6L11NoxwZA/Goug2GqL/Nxe4p+k4N9aYygkgsAEjvMaPJTS4BW0MRfRpBUh4i1TTmk9tFsgBQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(44832011)(86362001)(8936002)(5660300002)(8676002)(41300700001)(316002)(82310400005)(2906002)(70586007)(4326008)(70206006)(82740400003)(356005)(81166007)(54906003)(110136005)(83380400001)(6666004)(7696005)(478600001)(36860700001)(26005)(186003)(16526019)(2616005)(1076003)(47076005)(36756003)(40460700003)(336012)(426003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:20:10.2997
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f56a9d3-4142-44a0-ff82-08db82e319c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9037

Remove nested structure and make it as 'ats_{enable/qdep}'.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 ++----
 drivers/iommu/amd/iommu.c           | 26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 57586a8c451e..15c129dbacab 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -815,10 +815,8 @@ struct iommu_dev_data {
 	struct device *dev;
 	u16 devid;			  /* PCI Device ID */
 	u32 flags;			  /* Holds AMD_IOMMU_DEVICE_FLAG_<*> */
-	struct {
-		bool enabled;
-		int qdep;
-	} ats;				  /* ATS state */
+	int  ats_qdep;
+	bool ats_enabled;		  /* ATS state */
 	bool pri_tlp;			  /* PASID TLB required for
 					     PPR completions */
 	bool use_vapic;			  /* Enable device to use vapic mode */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ff38561435e2..6c425aa521c7 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1310,7 +1310,7 @@ static int device_flush_iotlb(struct iommu_dev_data *dev_data,
 	struct iommu_cmd cmd;
 	int qdep;
 
-	qdep     = dev_data->ats.qdep;
+	qdep     = dev_data->ats_qdep;
 	iommu    = rlookup_amd_iommu(dev_data->dev);
 	if (!iommu)
 		return -EINVAL;
@@ -1361,7 +1361,7 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 			return ret;
 	}
 
-	if (dev_data->ats.enabled)
+	if (dev_data->ats_enabled)
 		ret = device_flush_iotlb(dev_data, 0, ~0UL);
 
 	return ret;
@@ -1394,7 +1394,7 @@ static void __domain_flush_pages(struct protection_domain *domain,
 
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
+			dev_data->ats_enabled = true;
+			dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
 			dev_data->pri_tlp     = pci_prg_resp_pasid_required(pdev);
 		}
 	} else if (amd_iommu_iotlb_sup &&
 		   pci_enable_ats(pdev, PAGE_SHIFT) == 0) {
-		dev_data->ats.enabled = true;
-		dev_data->ats.qdep    = pci_ats_queue_depth(pdev);
+		dev_data->ats_enabled = true;
+		dev_data->ats_qdep    = pci_ats_queue_depth(pdev);
 	}
 
 skip_ats_check:
@@ -1920,10 +1920,10 @@ static void detach_device(struct device *dev)
 
 	if (domain->flags & PD_FLAG_GCR3 && pdev_pasid_supported(dev_data))
 		pdev_iommuv2_disable(to_pci_dev(dev));
-	else if (dev_data->ats.enabled)
+	else if (dev_data->ats_enabled)
 		pci_disable_ats(to_pci_dev(dev));
 
-	dev_data->ats.enabled = false;
+	dev_data->ats_enabled = false;
 
 out:
 	spin_unlock(&dev_data->lock);
@@ -2013,7 +2013,7 @@ static void update_device_table(struct protection_domain *domain)
 		if (!iommu)
 			continue;
 		set_dte_entry(iommu, dev_data->devid, domain,
-			      dev_data->ats.enabled, dev_data->flags);
+			      dev_data->ats_enabled, dev_data->flags);
 		clone_aliases(iommu, dev_data->dev);
 	}
 }
@@ -2651,10 +2651,10 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
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

