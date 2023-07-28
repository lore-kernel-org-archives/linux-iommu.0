Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896F15696
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 05:40:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cg88XWdruI6PAkB3k6rB0I4hp5g8UB4QsnqwfJiKQ2Yjx4auxsNkJQV8OFKVx0gb9cHrlTC374yPjl1hOyVDBYIW26UPxcaDAYyopn3kavA8WrQoNLVSVEzqMiMKPeWXLZ+x7BnGm46CyFBLQ1hwhy/SIwTvWiWICI7LEREIDqdS0W/v6FKXx50a5viub4wTYmbXKovr7nwRl97wCsnjMAXykvWfVBe3G7XfYF93mHCYzBn9JGlcnUioMNeexrgPyjcJNTzvg/8wQQQDVUZsHmrW2QVlZ4v+iaBeNDvT8BBuCcI6uRaPhl8AQJgEvhshzlkvPUPPPOP6PYpqhJ9d3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=536rKaGQaID3X7BgC6THeH3hixajAkaKTlt8OfHjQuM=;
 b=g7qIFmgf/iu3m+DlEI2H9Lqm4tW8xkihTsshtClJkD22OMheKwyyskcKecI+bUjb6/FY6EZcERLOrQsSYi/rdh/d25JnfSWSkF6WvF/ZF39Dm1091BwFBGhl2EWD31LO2FU7SMdkzOl3aGcFEXs0JuoUSn/IhZzh0Y8Lh2aRw0pOLVeXS2I8la4Pgc35werE1wdG844si/AJLSSr/8Sf7hUXWn4XdHVbXmWXuM31hucR0WZKrFahAMldCXSbFM4U35Q5ytq3Biff5ybBmG6hexv0vP8jgisYbycZT7XoX8wcfgghXgnUAVqQklXVifVBgf18/+ISo0czSmpbxRl16Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=536rKaGQaID3X7BgC6THeH3hixajAkaKTlt8OfHjQuM=;
 b=CRJIM+JzYccGiFA3/bZMZOgeQQkf0AzsrVGTozrkiPKdWw2mWdQR8dYmkP5R+CJqGvR4LkvpGOlaCpH4ZLB/pNZKCnr4Lv+FJuqPlwXbcNzz1PXJMKpjeqskydhTk/NO4kQpOq1w8gRQGOle7ywy4Ac1mqAf6ZvCWNHcB3VZf4Y=
Received: from BN9PR03CA0652.namprd03.prod.outlook.com (2603:10b6:408:13b::27)
 by DS7PR12MB8291.namprd12.prod.outlook.com (2603:10b6:8:e6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:40:01 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::58) by BN9PR03CA0652.outlook.office365.com
 (2603:10b6:408:13b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 05:40:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 05:40:01 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 00:39:58 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 12/16] iommu/amd: Add support for different types of PPR handler
Date: Fri, 28 Jul 2023 05:36:05 +0000
Message-ID: <20230728053609.165183-13-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT030:EE_|DS7PR12MB8291:EE_
X-MS-Office365-Filtering-Correlation-Id: 26904897-b2cd-44bb-9cd1-08db8f2d167b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uNVYyToFzDYarOQOyxeQvSG8Q+WbEWP5ArkU2idRnoHomb56XbacmqrF2ifAYFmVbRDlwhizE+fXbxVy2cxAsbN+N5FjgtCzu6L9p8rACVJ48G1dX/FaJ7VtIn6ZNo3iCU+tVjNVHMkEFvK7FI1wbZ3liHUvFlk45uJsa7x9U6K1uRxVG0APv87XElGgQEg0bywR3PHrri46dDS7TYUsRDHN0fwVBoOoaO+zJgkIyOq6XbWhQxzzBuA6kHj696CzSSEd5R7iTqMvOkgQEC5bEjSKGVz+5u5ieJtFKhaEvSbCetE+pT3v/RTKvCh7xieOsc4iBWs8inFseHhuxisXPi2dl8zOr8qE72BO7dnfbyfhEMl15YsaENFcjVj9LwuPGJL+cVwBjqoC/rEpG2FLOpzvmOEaxw06dWYjg2CkWYNxBoBH0DbApFrmCj27SIbD40WAeL7j8jsRZUByEfAYsueye8Cs7TGYVmE/kcG5Qz80EP4pedi2VqLg5r8iXIT3jA5TnBcg6Gs7MO7vNpxNYIVSXaWXFneYT0/97Zht5/gobYbvdjZI7HFxV1wtGiGTUVks4ZLsxP+LkfvN87aoy3MGSY0JUaGLkgTLYuvENSJTM8r/Jami2P1Y9XCdfdnEZBcpTNaDhR3gVUIZpPfKfe9gZYqbwTrspsF8J+6Z/X5u3wiTyxkpPJoAxTu1njKeNSFNLuhrmtY3SJt5OZFNtOcSJASzfzoSoNW1hrWIMO47H/fHU/ZSnaJ0sXDJ8EkwA+UpVljAKyAavzvq7Vf+Hw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(39860400002)(346002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(356005)(82740400003)(81166007)(86362001)(36756003)(40460700003)(40480700001)(316002)(5660300002)(1076003)(26005)(8936002)(8676002)(110136005)(54906003)(186003)(16526019)(44832011)(336012)(41300700001)(2906002)(426003)(2616005)(83380400001)(47076005)(36860700001)(4326008)(7696005)(478600001)(6666004)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:40:01.6088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26904897-b2cd-44bb-9cd1-08db8f2d167b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8291

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

For AMD IOMMU, the PPR feature is needed to support IO page fault (IOPF).
PPR is enabled per PCI end-point device, and is configured by the PPR bit
in the IOMMU device table entry (i.e DTE[PPR]).

Currently, PPR is enabled for a device when it is initialized for AMD
IOMMU v2API. To support paging for IOPF, the DTE[PPR] bit needs to be
updated when enable/disable IOPF feature.

Introducing struct iommu_dev_data.ppr and enum ppr_handlers to track PPR
setting for each device.

Finally iommu_dev_data.ppr is set only when IOMMU supports PPR. Hence
remove redundant feature support check in set_dte_entry().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  7 +++++++
 drivers/iommu/amd/iommu.c           | 10 ++++------
 drivers/iommu/amd/iommu_v2.c        | 14 +++++++++++++-
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a066f375ba87..321d361dfb60 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -803,6 +803,12 @@ struct devid_map {
 	bool cmd_line;
 };
 
+enum ppr_handlers {
+	PPR_HANDLER_NONE,	/* No handler specified */
+	PPR_HANDLER_V2API,	/* IOMMU v2 API ppr handler */
+	PPR_HANDLER_IOPF,	/* IOPF ppr handler */
+};
+
 /*
  * This struct contains device specific data for the IOMMU
  */
@@ -820,6 +826,7 @@ struct iommu_dev_data {
 	bool ats_enabled;		  /* ATS state */
 	bool pri_tlp;			  /* PASID TLB required for
 					     PPR completions */
+	enum ppr_handlers ppr;
 	bool use_vapic;			  /* Enable device to use vapic mode */
 	bool defer_attach;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5a4170592bf4..e67c6fae452c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1631,10 +1631,8 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 	if (ats)
 		flags |= DTE_FLAG_IOTLB;
 
-	if (ppr) {
-		if (iommu_feature(iommu, FEATURE_EPHSUP))
-			pte_root |= 1ULL << DEV_ENTRY_PPR;
-	}
+	if (ppr)
+		pte_root |= 1ULL << DEV_ENTRY_PPR;
 
 	if (domain->flags & PD_IOMMUV2_MASK) {
 		u64 gcr3 = iommu_virt_to_phys(domain->gcr3_tbl);
@@ -1727,7 +1725,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 
 	/* Update device table */
 	set_dte_entry(iommu, dev_data->devid, domain,
-		      ats, dev_data->iommu_v2);
+		      ats, dev_data->ppr);
 	clone_aliases(iommu, dev_data->dev);
 
 	device_flush_dte(dev_data);
@@ -2006,7 +2004,7 @@ static void update_device_table(struct protection_domain *domain)
 		if (!iommu)
 			continue;
 		set_dte_entry(iommu, dev_data->devid, domain,
-			      dev_data->ats_enabled, dev_data->iommu_v2);
+			      dev_data->ats_enabled, dev_data->ppr);
 		clone_aliases(iommu, dev_data->dev);
 	}
 }
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 9bf114382c00..4148cbf069dc 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -740,6 +740,10 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	unsigned long flags;
 	int ret, tmp;
 	u32 sbdf;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
+
+	if (!dev_data)
+		return -ENODEV;
 
 	might_sleep();
 
@@ -762,6 +766,9 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	if (dev_state == NULL)
 		return -ENOMEM;
 
+	/* Enable device for PPR support */
+	dev_data->ppr = PPR_HANDLER_V2API;
+
 	spin_lock_init(&dev_state->lock);
 	init_waitqueue_head(&dev_state->wq);
 	dev_state->pdev  = pdev;
@@ -832,6 +839,8 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 out_free_dev_state:
 	kfree(dev_state);
 
+	dev_data->ppr = PPR_HANDLER_NONE;
+
 	return ret;
 }
 EXPORT_SYMBOL(amd_iommu_init_device);
@@ -841,8 +850,9 @@ void amd_iommu_free_device(struct pci_dev *pdev)
 	struct device_state *dev_state;
 	unsigned long flags;
 	u32 sbdf;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
 
-	if (!amd_iommu_v2_supported())
+	if (!dev_data || !amd_iommu_v2_supported())
 		return;
 
 	sbdf = get_pci_sbdf_id(pdev);
@@ -859,6 +869,8 @@ void amd_iommu_free_device(struct pci_dev *pdev)
 
 	spin_unlock_irqrestore(&state_lock, flags);
 
+	dev_data->ppr = PPR_HANDLER_NONE;
+
 	put_device_state(dev_state);
 	free_device_state(dev_state);
 }
-- 
2.31.1

