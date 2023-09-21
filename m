Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D838F55
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 09:28:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrOwukDsB9wv8QI7vLogcRHEif5yK8j3I67eRjr9HlQFR5zfrOMYNFQ4qvyqlF3tgpvYeZKF2oh2vTtL7PvRCnXEOSHNGVJXreS51CgWGScsdjvMfEDtSfQGkcyqMWUa/yF8KfWLCasAorOiZGrdsXrUZ1qr/MP9XYCA86oW/JX8IcxExb8anmo5zUHwy+jNhFpx3WURXHG2/WHABCuJvuP9GnPQBkK4go2Tl+VET7FXyCHodiYx3B6FEMO1MMhFjeexD3CBwpNScuu6y/s0jTubaBkRmelJDBKKt7cIQkM5nWK6UMJuzeoESfpu+SKxFl8uEAxYVroR76IdH8YEvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmTgFLaVK/BwAQe0N4hKNsz4SQ/ijRq1F2viaL6oQfQ=;
 b=OX1HZLzELK/lDKLVyJ5k8/xjLbaTn3Eoer5Xrw4XtnziwJvb2MzvFg5sfOIty5Nk46sn1Sxd3GjUfBWXOeIoDuAoK5VOmb6NB9t1C6GwMlJwo7T+VogKHUK6ufO/U6L7oxRrWIabS4HCf14n3o0NqYQyvFe75jR6gCzS1oma65epWpUriZVww+MB8TsSyitlYwSK9LqHelCPAqFJgfKMTrn2hiUwVtMLs3fy7Z8DKefINQDX2PoTQ5mEB4Flk2T/1lb03xW1IiuJpMGnMrDsl1EvIknL4JNB+Phv/PaahQ4hppiVDnyvPQxPG36c0krX+giEDW3vwC4h6WqPB+Nv9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmTgFLaVK/BwAQe0N4hKNsz4SQ/ijRq1F2viaL6oQfQ=;
 b=yVhfP1UB9V5HbgEi3NBy+MEqm7i882mTyCtgbuzortDst5ert+vdZsNumRmia4xYdbNYlAEQQht514a5tqmdOLJEC5pP+NIs/QUSUafdE0H1fnYZJ0GKyKwhq+ht6oSk6qE06/B1z8XR6jB6ZdeH6CiPPNfuob1lyca9NqGtvbs=
Received: from DM6PR07CA0107.namprd07.prod.outlook.com (2603:10b6:5:330::21)
 by IA1PR12MB8518.namprd12.prod.outlook.com (2603:10b6:208:447::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 09:28:14 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:5:330:cafe::65) by DM6PR07CA0107.outlook.office365.com
 (2603:10b6:5:330::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.30 via Frontend
 Transport; Thu, 21 Sep 2023 09:28:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 09:28:13 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 04:27:35 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 12/14] iommu/amd: Introduce iommu_dev_data.flags to track device capabilities
Date: Thu, 21 Sep 2023 09:21:45 +0000
Message-ID: <20230921092147.5930-13-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|IA1PR12MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: b00efd53-9ca1-4695-9f26-08dbba851484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rq0IEHyJidoWF7R0iy4oetNj3Sua+YHTQF6WV/4q8z5+KMVoKq5b0Phu5MERvsFUILLLcTmwpdYGmhw8eXzzJJOSydnqbPzd30MLkV2+htx/nrZOip+k3k3v20phSm5gRw8/saxQ9OMAPHcusnhjUTlpkDBiiUtpaHt3IvlFFXuaAXU1SyhJKfZa0KPo53rQdR7RPeMeHA/O+HZsJKacQPdennCRVXQ4pynB1GBNq+jybzRq56JkeSU5pFKGeMkjCJk+D9Sx9j/77k6vSo6oNQGnc/8fPhMZWv+zeD9eFGP5MnSTr3slzhWGJbfvYR2JP64NSKrdU9FCIRJiMnthQ9mMPF7MUsbcB1FnywLCDN6PNOkycWx2moeD+wk4lbGdNjJg9F0XtWCyqrsLSic8hcyTUqrcTSF7Xsf9YLUocUfK8Xx53pcSDjmKNYwWMI49fcPHV9JtBolNW0kyHX6qsshJlE4ixkqM45K+jiOWD90kAQsvU4SdtdsFbZpdZVZBF2Ak8+m3SlwHbk4VJiAxIbU9EzXIUPzEtvCwJx4e5FWGX6FgDJaVntq1tPx4XN4tKW8TVlorgd2cJuiGjHmgxr2DSv6b6n+ysvCPzZBhnWACDez7EzfAFn7Ls99MBeiJCM/5vI9V8EDaaHegr8dbkpXftt4ym1QZHsSZoZynA5zULyXdTd8HB8SLGm0uFV56x3iQ8hSWYrEmJFdxlJxrMa6t3xPf3J/rfQUmsXqFyqnKU3ej5CyeK405vQoUWOPCJJbeFM/tGYiJNmnFkgPYcQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(186009)(451199024)(1800799009)(82310400011)(40470700004)(36840700001)(46966006)(86362001)(6666004)(7696005)(2616005)(40480700001)(40460700003)(36756003)(82740400003)(356005)(2906002)(81166007)(316002)(70586007)(110136005)(54906003)(478600001)(70206006)(1076003)(47076005)(83380400001)(426003)(336012)(36860700001)(16526019)(26005)(8676002)(8936002)(41300700001)(44832011)(5660300002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:28:13.9928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b00efd53-9ca1-4695-9f26-08dbba851484
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8518

Currently we use struct iommu_dev_data.iommu_v2 to keep track of the device
ATS, PRI, and PASID capabilities. But these capabilities can be enabled
independently (except PRI requires ATS support). Hence, replace
the iommu_v2 variable with a flags variable, which keep track of the device
capabilities.

From commit 9bf49e36d718 ("PCI/ATS: Handle sharing of PF PRI Capability
with all VFs"), device PRI/PASID is shared between PF and any associated
VFs. Hence use pci_pri_supported() and pci_pasid_features() instead of
pci_find_ext_capability() to check device PRI/PASID support.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 +-
 drivers/iommu/amd/iommu.c           | 46 ++++++++++++++++++-----------
 2 files changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 87fa39c490e8..07f8919ee34e 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -811,7 +811,8 @@ struct iommu_dev_data {
 	struct protection_domain *domain; /* Domain the device is bound to */
 	struct device *dev;
 	u16 devid;			  /* PCI Device ID */
-	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
+
+	u32 flags;			  /* Holds AMD_IOMMU_DEVICE_FLAG_<*> */
 	int ats_qdep;
 	u8 ats_enabled  :1;		  /* ATS state */
 	u8 pri_tlp      :1;		  /* PASID TLB required for
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4ee69ccdc17b..151f405686e3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -319,24 +319,34 @@ static struct iommu_group *acpihid_device_group(struct device *dev)
 	return entry->group;
 }
 
-static bool pci_iommuv2_capable(struct pci_dev *pdev)
+static inline bool pdev_pasid_supported(struct iommu_dev_data *dev_data)
 {
-	static const int caps[] = {
-		PCI_EXT_CAP_ID_PRI,
-		PCI_EXT_CAP_ID_PASID,
-	};
-	int i, pos;
+	return (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PASID_SUP);
+}
 
-	if (!pci_ats_supported(pdev))
-		return false;
+static u32 pdev_get_caps(struct pci_dev *pdev)
+{
+	int features;
+	u32 flags = 0;
+
+	if (pci_ats_supported(pdev))
+		flags |= AMD_IOMMU_DEVICE_FLAG_ATS_SUP;
+
+	if (pci_pri_supported(pdev))
+		flags |= AMD_IOMMU_DEVICE_FLAG_PRI_SUP;
 
-	for (i = 0; i < 2; ++i) {
-		pos = pci_find_ext_capability(pdev, caps[i]);
-		if (pos == 0)
-			return false;
+	features = pci_pasid_features(pdev);
+	if (features >= 0) {
+		flags |= AMD_IOMMU_DEVICE_FLAG_PASID_SUP;
+
+		if (features & PCI_PASID_CAP_EXEC)
+			flags |= AMD_IOMMU_DEVICE_FLAG_EXEC_SUP;
+
+		if (features & PCI_PASID_CAP_PRIV)
+			flags |= AMD_IOMMU_DEVICE_FLAG_PRIV_SUP;
 	}
 
-	return true;
+	return flags;
 }
 
 /*
@@ -396,8 +406,8 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 	 * it'll be forced to go into translation mode.
 	 */
 	if ((iommu_default_passthrough() || !amd_iommu_force_isolation) &&
-	    dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev))) {
-		dev_data->iommu_v2 = amd_iommu_gt_ppr_supported();
+	    dev_is_pci(dev) && amd_iommu_gt_ppr_supported()) {
+		dev_data->flags = pdev_get_caps(to_pci_dev(dev));
 	}
 
 	dev_iommu_priv_set(dev, dev_data);
@@ -1850,7 +1860,7 @@ static int attach_device(struct device *dev,
 			goto out;
 		}
 
-		if (dev_data->iommu_v2) {
+		if (pdev_pasid_supported(dev_data)) {
 			if (pdev_pri_ats_enable(pdev) != 0)
 				goto out;
 
@@ -1916,7 +1926,7 @@ static void detach_device(struct device *dev)
 	if (!dev_is_pci(dev))
 		goto out;
 
-	if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
+	if (domain->flags & PD_IOMMUV2_MASK && pdev_pasid_supported(dev_data))
 		pdev_iommuv2_disable(to_pci_dev(dev));
 	else if (dev_data->ats_enabled)
 		pci_disable_ats(to_pci_dev(dev));
@@ -2471,7 +2481,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
 	 *    and require remapping.
 	 *  - SNP is enabled, because it prohibits DTE[Mode]=0.
 	 */
-	if (dev_data->iommu_v2 &&
+	if (pdev_pasid_supported(dev_data) &&
 	    !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
 	    !amd_iommu_snp_en) {
 		return IOMMU_DOMAIN_IDENTITY;
-- 
2.31.1

