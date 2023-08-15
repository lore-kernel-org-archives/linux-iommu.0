Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C156910788
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:25:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsxzsSD5QhwBiTn3emKAZl5JmIf0pkFIR0PZmrwo74XmmISNxM+PDEEnJ8+rHfquHC9NE5MA/L4bf0kZCi4zJIuhSC3cg+Fb7RyK+83nDkhgL7eafGaQ+YrIhV21FZ705uzOY0RmztHHsx7RUAlBgtoP8RSlcBkg/kz6pk7vgblSTDBCEF0hoo+Gpq8MWCz28fe4D2NJqdVsIlyK4Hdp0wViuwaepcuhqqE5lktJfCfiSSZByIqoW2e5/8QAPIVVe1sQ6Cm+mLLket8RQ22c0LWBCSa4Hd6/sLvSe1BB5Ur0F/aFhi3juywkR4yq6CHAAdnIPqpEkRx7CO0jxhYmRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=12ASi41rGfzLsloCXktWvgsEdfkGc/9uujy7YCuCTaw=;
 b=IICiOQBcosBDooDAFb/fTY7A4ogtOwIzl3RsMb9o2QCVKbYkTrHKwBH+VZsu0xSLk2sqHtOfvKII1lZ5hzjEz1H9JMs1wzlWzJlAtTXiVWzUeimrXmpDAwiJGETkycxMOZOY06oVoApNSCXYF6T205vzDmQvXQ6+31wwbboS4SM0ulWPRP1TWni6W/5DCiQFwVT1r7o8E6EwFaXIQV1S7eUzqhKtNRSZVneAR5aKYNKxHt7eoVuUiK9BRbMI84yKAe+eKHbCj3cjEBSaXpo0BgR2j2MVwSnRlYAdivsksGgiPwVjLOkpPvSH0uR3f79kjs3S3Jlhq7tGz5lQ4t/3DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=12ASi41rGfzLsloCXktWvgsEdfkGc/9uujy7YCuCTaw=;
 b=X1+9SWVlVVq7l2jueXQWSAiZk9JSYo0gMljiaT51Vk6NDb4VwHGxd/COPdVyAdvf4wblmwZvrSaBz2lOqVeeso6Y9/F6e98s0EpTf+TLR4KsnfFI3AEifDxrNpIyk3E+5bs+6SP6aWsaPt6k6qmH6lxCZSTBZHXbK4XwTGfr5BY=
Received: from MWH0EPF00056D07.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:7) by SJ0PR12MB8092.namprd12.prod.outlook.com
 (2603:10b6:a03:4ee::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 10:25:40 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2a01:111:f403:f807::1) by MWH0EPF00056D07.outlook.office365.com
 (2603:1036:d20::b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.8 via Frontend
 Transport; Tue, 15 Aug 2023 10:25:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.3 via Frontend Transport; Tue, 15 Aug 2023 10:25:40 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 05:25:33 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 10/14] iommu/amd: Rename ats related variables
Date: Tue, 15 Aug 2023 10:21:58 +0000
Message-ID: <20230815102202.565012-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815102202.565012-1-vasant.hegde@amd.com>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SJ0PR12MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f5e846-14d1-4dcc-3e02-08db9d79f944
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jO92bhAs5ezfZfGemJC1Gl/j8Rujf870Z3j7zfn8xmkbaMv3BvlYtmNVfcD1XwUkm58U8sg90FR/iwXPjRo5gudOIVy94W7ie1zYNqHxSGmW5trbvta/ljTV31AWZyq7E4DTZWwfTB4oaVQ74rTpkJGGis37vQ54fYHkHHN9eFVNCYyo8BUsmag6kBpsIHVaYCIccWE4xDI1VKA8DMNeDfx41LQ+fB96sGIpVKKicIFyKK8DzjB3NSBJidhEGmOt15yamEpAua8eDCIVdx7C3FclYA5YqE7Ua9Gc5IlofjR0Q23l43r5LLg+dtPXe19hqawS8FkbHrYvgDbLtDXz+ZP5EIXICurzyAesfUE8uVQfxX7cJogs6PkaM+pGPgadneqD0GSi3oQ6XWPmcurvWFIhnpn5Kp3AAUty/kA8rOyeoz9owA9BMf8ZQ0kQOaM30Cw2ZXOZzztqFMPEVGyN0PZQ8u8eKJQW/+1H1B5tw8128BaEUgYTZanidkjcqYQU8dfovrxEqNYPSn29Juuen70cnf6MGzf+U2LkEPsfKj3GkdLn75G2CGWIYzxxdroIpmt0E7Ngbwg5zCRCdOXACm5M3wvw4hJk4xImdGJ9Kw3qk9iOIeU66+xdvIA7zhW8/TThBBmWMAH+4rz1J28dUUD88yOQRIgmP1huR/OihohvHCy70RYGwaqRC4uJVUlobkeCaTdo6wT8p0mZWsCHC01g68c6buj9APEGZreJoPZ+1kst+G+Iw1LijEbuZo0YJerqAzOKYucMql1FE8AADw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(186006)(82310400008)(1800799006)(451199021)(40470700004)(36840700001)(46966006)(7696005)(6666004)(54906003)(81166007)(36756003)(86362001)(356005)(82740400003)(83380400001)(47076005)(36860700001)(26005)(16526019)(1076003)(2906002)(336012)(426003)(478600001)(40480700001)(110136005)(2616005)(4326008)(8936002)(8676002)(70586007)(5660300002)(40460700003)(41300700001)(44832011)(316002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:25:40.0253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f5e846-14d1-4dcc-3e02-08db9d79f944
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8092

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

