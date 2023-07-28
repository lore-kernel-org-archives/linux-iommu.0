Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF25696
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 05:39:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ndOmOhe1xchz3LByVQDkeFn4bTR+0/Qu4uyZwXw06H2mc2VUUGxVD85seNtx96K/VFhVxlXkye7oq8lbjlzhXlgjv/ZOu4YT1quLxL3omdqVoIHLb/f6sdkrMxUqAOZjkcXBQF18BrFGyfYzhKDr/3gEeq6wa9rgjl+xgS0lvrPrK73dUGghmSLKv17mpgl4+LslwTSG3ZP6qAaPW8733U+7mw9iU9pEueiNag2FrLh0JVcQH7dVCv/KNu4mty55/BjJEGBXrMhgwdAhzOr+jAHQmP5JlSrdOm6JmjSa22+3dept8LuAUZnK91iygV2wBaMCqSSRfv+sscXBOQEuKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOS+iJhIvhTvcWBr49n0a04hlMJCnWMv3c+H0f4Mfws=;
 b=PddaefSYJtaM4Aa2Sojhzef+iqa91uoHuaaQPY3yRTFDu8qmNRe0XL8E7zj3aQj318EIvKgWoh2vVe41v1ZO9MFnR5YEsVlWpQnTQd5HhnPRd2qG4hVTL0LP12FmAtjW/3ep6hF40TezfrISuut8qwEySBq46DOP9kPtU2KMo2JsbaQeK353p7v6dT3RCD8Sixz5YSRIQf5V9p0SocfX9nEXqpjoWziR3Zbg24bwk6GgdTYnmsfL0jD7Ixf/B81j382RxlbK+K1gtqyxh0WbY5JDiemsQ5A/DQiWFbb7OtB+iGDR4IH2lraDy2NYNackERPjvPBPyeEzyNNhSDO47Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOS+iJhIvhTvcWBr49n0a04hlMJCnWMv3c+H0f4Mfws=;
 b=209uQTO/qgBvgm4IT3Nqh2+iZlPp1ZYmQrSGuhoiWd9RdoVsUTlwrSbC42SmYf7DzXCOvL97zfjsaRZCXyroepXDAV4dcIvLEmarzqaV/GucyCBM+Xnp+Qxc5ZZxzO8BJCFDgB2eR6dGkacy95AAUhk9queMh2E3JEEhQ94Jmug=
Received: from BN9PR03CA0271.namprd03.prod.outlook.com (2603:10b6:408:f5::6)
 by DS0PR12MB7946.namprd12.prod.outlook.com (2603:10b6:8:151::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:39:46 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::c8) by BN9PR03CA0271.outlook.office365.com
 (2603:10b6:408:f5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 05:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 05:39:45 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 00:39:42 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 11/16] iommu/amd: Rename ats related variables
Date: Fri, 28 Jul 2023 05:36:04 +0000
Message-ID: <20230728053609.165183-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728053609.165183-1-vasant.hegde@amd.com>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|DS0PR12MB7946:EE_
X-MS-Office365-Filtering-Correlation-Id: 06dbe639-f633-4bdf-2312-08db8f2d0cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	18AGjdSLZcpHNkvIA1mZ2Gpz4TtBOomJ/cDbvvrqg3AjI2yfBleWWtPuvdLAq2GOAMjEBUvxiLUMXRanb0oQVg2ENVcVQ9TL+2nG+Brvjo4ui/kgTqcLPs0CQgDfcDUXgWgN0MEW15HETYZhQOQL8iFOl7FPMvWHXFDWHRS5w8reRiGG4+wPERZNMXqrqClrXLagLvaaUVy8D+yRxih7VfXeOL2oIvaiQ09EasD7hMXLgjCYjWuKg6gQChe45NlQy1XfnUxotKv6jKFCdEkUhAkUXIyOHLzANDkAjqKDq5N0aahwk8zhSD225MSjoFJMFIs2Sj2J0ggNuaKOUYgLM1k5l1h0ALnoaZqb1f8K2z2xOV937iHs6nepTnhxzdmQI/3RMIsxRJIJ8NkOk+uug7d39D5YUZ6DCLsTkP6vhpsF6YR17JMWraOxJjxWWpZSYkQuQvNH1sYgusA+rHn3ad6ZnozLL2P13hmt4s8hRV+2IO0PjvX0JVkAEMYytWhSzTl0WqF/6KAJItB0qjzhPp4pFmuay3Coi/KLM3id4qUu59uImaDuOqjJvsMvy0fSRFzz0iQyjK5M+24CkyQI8uHGnbQzQ1pDlt8+D1125oGEnsTQ0P+MNBjnUHcwVhefNJiUwwAVvVmmUpAAtVWwW/2CwIx3a96kwpVcQc7A2SU9Ope8Cqz/+gOxUAh7uBmy6sCDIStD4MAQPWbKrK5uezGdzmIYtOqApU7rRPB6Ls8DG2Xud6ZYbQQRNkUcQQsRcAx4H99n+AflVAGlyqxxtA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(86362001)(356005)(36756003)(40460700003)(40480700001)(2906002)(110136005)(478600001)(54906003)(82740400003)(81166007)(336012)(36860700001)(26005)(426003)(2616005)(1076003)(186003)(47076005)(16526019)(41300700001)(44832011)(8676002)(6666004)(316002)(7696005)(83380400001)(70206006)(70586007)(5660300002)(4326008)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:39:45.4380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dbe639-f633-4bdf-2312-08db8f2d0cd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7946

Remove nested structure and make it as 'ats_{enable/qdep}'.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 ++----
 drivers/iommu/amd/iommu.c           | 26 +++++++++++++-------------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index bbb5ac4f0d39..a066f375ba87 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -816,10 +816,8 @@ struct iommu_dev_data {
 	struct device *dev;
 	u16 devid;			  /* PCI Device ID */
 	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
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
index 1f707944b23f..5a4170592bf4 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1309,7 +1309,7 @@ static int device_flush_iotlb(struct iommu_dev_data *dev_data,
 	struct iommu_cmd cmd;
 	int qdep;
 
-	qdep     = dev_data->ats.qdep;
+	qdep     = dev_data->ats_qdep;
 	iommu    = rlookup_amd_iommu(dev_data->dev);
 	if (!iommu)
 		return -EINVAL;
@@ -1360,7 +1360,7 @@ static int device_flush_dte(struct iommu_dev_data *dev_data)
 			return ret;
 	}
 
-	if (dev_data->ats.enabled)
+	if (dev_data->ats_enabled)
 		ret = device_flush_iotlb(dev_data, 0, ~0UL);
 
 	return ret;
@@ -1393,7 +1393,7 @@ static void __domain_flush_pages(struct protection_domain *domain,
 
 	list_for_each_entry(dev_data, &domain->dev_list, list) {
 
-		if (!dev_data->ats.enabled)
+		if (!dev_data->ats_enabled)
 			continue;
 
 		ret |= device_flush_iotlb(dev_data, address, size);
@@ -1711,7 +1711,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	iommu = rlookup_amd_iommu(dev_data->dev);
 	if (!iommu)
 		return;
-	ats   = dev_data->ats.enabled;
+	ats   = dev_data->ats_enabled;
 
 	/* Update data structures */
 	dev_data->domain = domain;
@@ -1849,14 +1849,14 @@ static int attach_device(struct device *dev,
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
@@ -1913,10 +1913,10 @@ static void detach_device(struct device *dev)
 
 	if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
 		pdev_iommuv2_disable(to_pci_dev(dev));
-	else if (dev_data->ats.enabled)
+	else if (dev_data->ats_enabled)
 		pci_disable_ats(to_pci_dev(dev));
 
-	dev_data->ats.enabled = false;
+	dev_data->ats_enabled = false;
 
 out:
 	spin_unlock(&dev_data->lock);
@@ -2006,7 +2006,7 @@ static void update_device_table(struct protection_domain *domain)
 		if (!iommu)
 			continue;
 		set_dte_entry(iommu, dev_data->devid, domain,
-			      dev_data->ats.enabled, dev_data->iommu_v2);
+			      dev_data->ats_enabled, dev_data->iommu_v2);
 		clone_aliases(iommu, dev_data->dev);
 	}
 }
@@ -2605,10 +2605,10 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
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

