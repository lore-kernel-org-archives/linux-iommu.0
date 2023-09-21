Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C728F55
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 09:26:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDSTU+XdnBRUJG4FY8xACDVZ6A4lc6CDYuI9MkuYEmYZFHUnuI3bwMV/b+QPmIxAUElyOi9S+gzE4r9lyXVwrgT/98OHr9ba64oxvCGpxM4mG/jp1E5MmLhI00Ydw5u7Dp1HoZdnijKIaIzT2WJ6nh2w+sk8Qaso30YNOFcO2P0cJXmRYCcS9FARSw7P0+2v2/pKcKLIrAa1CpajZC00Ns84laumFlUFsldTza+yxbFegSfLukUtTtYNPxF74aZ9N34XUTMKUpN0TV2hzuUDWsRbYjgRTnTQA5t4ihivzAVrv2ouRKtwy8KZLcdvdYRC+TOMs5OJQG0AWtmT3YWy5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNolRK7ETZYG9Pr2uLV8REFHOpluUgJ5/fUToiXPEPE=;
 b=I+I5edMUsc10VNZAkEgJ1yUl0zPFUMPL/noUfWIef2KOFTz01kNxzN8lh1HnGrFuzuw1af7WLbFUHMuspR9SZ1rHM8mWu2CanItUwy3WEt7iLA6rqjxLtVvWNSvqEoiDXjOZAJLjAAOdXTAHRXYA11XPITT/OSXE9T+uo2/iCOCnDKjsgAPlfnykAVW4CJ3vN8z3XiPOJgqGv+DtIHF0Ey57Zz6rLwoo8eo2M+G/SqeFAzfRa1c73eIhPoHGs/O31/Ji5E0RGC9jParpOjp6JP2+Cylh00ufuQS7ujn7Eq09LRQJvweUra7HGVMudxZ1wvd4LI6yc1igFi8CJaX7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNolRK7ETZYG9Pr2uLV8REFHOpluUgJ5/fUToiXPEPE=;
 b=QVSW0iPnYpalNWPV6ZES1sdTqkflRJlJ/3Bto3LvBsVYwEWt4N0YZsT99oQ7f8RweXVAB12fgUwp8ukk11JOShDl54gOTjXhpvAr5chHlfMJnsduMSOsP5OcTjFmkD9/SrgR71SHZfncfZ24orV9F2H35O/nZqEXXk16a7gtheo=
Received: from BY3PR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:217::33)
 by BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Thu, 21 Sep
 2023 09:26:23 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:a03:217:cafe::a0) by BY3PR04CA0028.outlook.office365.com
 (2603:10b6:a03:217::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Thu, 21 Sep 2023 09:26:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.11 via Frontend Transport; Thu, 21 Sep 2023 09:26:22 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 04:26:19 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 10/14] iommu/amd: Rename ats related variables
Date: Thu, 21 Sep 2023 09:21:43 +0000
Message-ID: <20230921092147.5930-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921092147.5930-1-vasant.hegde@amd.com>
References: <20230921092147.5930-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bbd3d8c-ad27-42cd-19ec-08dbba84d258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+yj4g2EYsQb8Or5FAzTRf9r0vWNXincuRv/vqeyMeKkWJK7fFHM4M8oL9nBc+3pGchJ+5YQGyZ/ZYlvHMM43EpXWMTGmOuuVsY0gmng88auLUDrALeXELi3KwimQiCv9WqYdy404bXzNvM1uUNfgfUsqoy3jCimrE1V43aIvWYSka8Jb9UM1aNCQSFiF8NoJFfPEWCTpwz2TXwuyxVcY89BpGRq7kL1vCWLlFDoPTDAlFH2GezYlRBxwnVyIqogamx+rZb/HaOKskrqA7wef0cRp3uIOoHmlaYxm27Zjo2EiokLFP0PR033r5d6Yq56ItFD2ZFmrFGz5pagP7BSGIRIkV1rD+TLUKsVu07FI7TdqrltjGULnPip5RIdIOLge41G9GTh1hwhuhsNVRSFaMiFwCaSp2P579dEOLcCUKaLdHjX6BIYxv8heI1TYjuuY8AGwjx/A+WOL3TdnATdoFdwsnevcZW9aA7sMszNN8f1JbN+cFTVi+1jQ6qkqTBhQ52YzuDTyuYmzA2fgDbEWbb+RoE+yOxJVexpOyRIWVImg/KAEEOKtYLsgEwZMH9deNh0I9OolPsMWAMxV0vSJJWyKLHb9qFRbAz+qFOXW/i5YsqAC13x7w60Ns6EF4YoKv/PSYEVN5fkiV3QKeyW/4GTLTulshJSnCuKypM+JM6GzXA0M8OIXBNaIqXA7S8H5tJy9e7a0p4FopLBldVRw7QsWSKoTFl5xkFRwG4H4ayPQ2OBI00sb6fF6F1KKFo+4AxDNr/t1/mEqFRDKZ5oaSQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(82310400011)(1800799009)(186009)(451199024)(40470700004)(36840700001)(46966006)(6666004)(7696005)(478600001)(83380400001)(2616005)(336012)(1076003)(44832011)(2906002)(110136005)(4326008)(70586007)(41300700001)(54906003)(316002)(70206006)(40480700001)(26005)(8936002)(5660300002)(8676002)(16526019)(86362001)(40460700003)(36860700001)(47076005)(426003)(356005)(36756003)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:26:22.9558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bbd3d8c-ad27-42cd-19ec-08dbba84d258
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243

Remove nested structure and make it as 'ats_{enable/qdep}'.
Also convert 'dev_data.pri_tlp' to bit field.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
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
index 126f58784829..433000276923 100644
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

