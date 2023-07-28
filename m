Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD415696
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 05:40:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AGoOUQBz1L1cfmCPMYw3mOYie+go1oEPOaMEIW9GOwJE6tAKGclUkHrvX8gblW2dQHOZEcPImM+NAYv/zxAATIqhcxt+zWzEagk2AGsaICq4UxUmISPXCNG+10Lc0Uh52FcVWvrCB5Fskuo/K9dMEyj8AzQ/VQAHMxqpL8djOqZeipVnPD41VibVJuE2Q5z8RpMgZ69RCYzeL5RrOr32X9pxe+vQJhzUyd5aVU66nPV2xWimaEZpB7uduoQR3hSFYRjqCDEzqmOwqau7eOJzLKpR36I/ESLWbY6+MuwQG35s6hy0sLzrHwnTn6SsSOR/u8p0E20mR4ggd6Fjqz94cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8HIV21dP7WxBQ4vUe36pew3eTKrsaMqw9NARAnfpaM=;
 b=fETXjqCWcAgsP9ntt5JCV9oKwPXzt/se6Xb8QQubmBRhRSR7Feldqgfgyw/VFpXH71KlZtDbgeFznL2UQ5D06sZIamxiw70blHyoPyW5xbsrTcp4QnIOtCfI2GaOmSW4WBwdmz7e6CbhoPkUPw4GmjXdPVyy7aFWHnmgC8df1itUcMG8k3YTddgPvwdetvScpr8fqxV0A2/AKwfTH56WX5EDlznxzicOHihlIT4ORuqo+6Xbwe+/Pz9htrZWGDnKX19q3BfathONGtc0CBdPc1Evx4BSOLuWYPLHnv7nYxUsui0IGjhiyC7e9lJaKtLhiBvQLneHB3c7DoBxP2HL5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8HIV21dP7WxBQ4vUe36pew3eTKrsaMqw9NARAnfpaM=;
 b=q9K+SCURo6vegns5kpjTnCSBSEmJoTXTCq/qXeBMHzcOkyEbu0O1BwYhc9DTMaPuVY3wQHcH/9eC80bt41BaepHjV+ZJedDR8nT1vqI/l0PZ2jI2aVkDK8UMMZ/O2Zd7iO4c/JIPajuMh4f9vOewCBYB3rIdEiQIJ0GOVBnGYzY=
Received: from BN7PR06CA0057.namprd06.prod.outlook.com (2603:10b6:408:34::34)
 by BL1PR12MB5255.namprd12.prod.outlook.com (2603:10b6:208:315::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:40:23 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::fc) by BN7PR06CA0057.outlook.office365.com
 (2603:10b6:408:34::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 05:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 05:40:22 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 00:40:20 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 13/16] iommu/amd: Introduce iommu_dev_data.flags to track device capabilities
Date: Fri, 28 Jul 2023 05:36:06 +0000
Message-ID: <20230728053609.165183-14-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|BL1PR12MB5255:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d8ac56c-b641-4501-e955-08db8f2d2337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9X+/upS7PdFDmZvUh9fLbIjA52aBe++icLtEPCD/rpsvIOs1e9nBEekij2JBEaft5zyd66hBJr+0y+CfLjyjaMIaqfaue0rKp0kY6yqnXhfK2OkRkeRG6o518HaOuTJlZ1mqzNPDUciiTxkC4mUhXnNcd++7Is0zasG2tbvAy0bLNRrfqhPPGkInfg2U/VhOTudTwXibiucJAErG31gDsmQEdYXlm1pF9EncOusySEj4chESTOTp3qBYaZhxqRJpKGNAlvXF3dHQIuEVO0J8YSaUH/LiPukbRIWeL5g7U7g9dbMsmUXnexZoOHEjXEo5oDbfaHLFMqUC/f0bnZXM8ngqHqF14DHDZ/8q+QSbf6kye8kcFYQAwqB4Wdfl6Fv/X0VsRT71aspkRGXRzF+gAEGWAUgalhIn82oDliNfLHs/AR1YtObWOkmZzHJX66alBTOlAP3J+aA6hgSqsK2Hhrojo4wfHtgJ7t53GGJQM4n4DtDfoXw6bq59NufT3Dlnw9yoQbxTp5wx5PjyvmFKGzq98s7MM40NSj5mviQF6hu7lHwZx3k57vUlTRux+1f8bo2sO8nPErMFKza60XdYGCboVtK7J/CY6aOj6Dj7HwRAB8DMA9FXuEeWlwF3QCanzZJ51TkH5aH/JEMqa3JUG3qBSV83Lt+LBjahVYA7QvTchYBG9sJnhsGru4YmutDbGpQyS96JuM9gs0unaSqD9FyONxiTCJ6TKOcS0VnNu4NqJbZfDxqUJFcYGOoCBj18YLbOj2YOW5zcdEgnsvHjAg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(54906003)(6666004)(7696005)(110136005)(478600001)(83380400001)(36860700001)(40460700003)(36756003)(86362001)(356005)(40480700001)(2906002)(426003)(2616005)(47076005)(336012)(1076003)(186003)(16526019)(26005)(81166007)(82740400003)(70206006)(44832011)(8936002)(70586007)(316002)(8676002)(41300700001)(4326008)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:40:22.9755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d8ac56c-b641-4501-e955-08db8f2d2337
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5255

Currently we use struct iommu_dev_data.iommu_v2 to keep track of the device
ATS, PRI, and PASID capabilities. But these capabilities can be enabled
independently (except PRI requires ATS support). Hence, replace
the iommu_v2 variable with a flags variable, which keep track of the device
capabilities.

Device PRI/PASID is shared between PF and any associated VFs (See commit
9bf49e36d718 ("PCI/ATS: Handle sharing of PF PRI Capability with
all VFs")). Hence use pci_pri_supported() and pci_pasid_features()
instead of pci_find_ext_capability() to check device PRI/PASID support.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/iommu.c           | 39 +++++++++++++++--------------
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 321d361dfb60..57c74870b17f 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -821,7 +821,7 @@ struct iommu_dev_data {
 	struct protection_domain *domain; /* Domain the device is bound to */
 	struct device *dev;
 	u16 devid;			  /* PCI Device ID */
-	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
+	u32 flags;			  /* Holds AMD_IOMMU_DEVICE_FLAG_<*> */
 	int  ats_qdep;
 	bool ats_enabled;		  /* ATS state */
 	bool pri_tlp;			  /* PASID TLB required for
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e67c6fae452c..7f67e8991949 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -314,24 +314,25 @@ static struct iommu_group *acpihid_device_group(struct device *dev)
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
+	u32 flags = 0;
 
-	for (i = 0; i < 2; ++i) {
-		pos = pci_find_ext_capability(pdev, caps[i]);
-		if (pos == 0)
-			return false;
-	}
+	if (pci_ats_supported(pdev))
+		flags |= AMD_IOMMU_DEVICE_FLAG_ATS_SUP;
 
-	return true;
+	if (pci_pri_supported(pdev))
+		flags |= AMD_IOMMU_DEVICE_FLAG_PRI_SUP;
+
+	if (pci_pasid_features(pdev) >= 0)
+		flags |= AMD_IOMMU_DEVICE_FLAG_PASID_SUP;
+
+	return flags;
 }
 
 /*
@@ -391,8 +392,8 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
 	 * it'll be forced to go into translation mode.
 	 */
 	if ((iommu_default_passthrough() || !amd_iommu_force_isolation) &&
-	    dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev))) {
-		dev_data->iommu_v2 = amd_iommu_gt_ppr_supported();
+	    dev_is_pci(dev) && amd_iommu_gt_ppr_supported()) {
+		dev_data->flags = pdev_get_caps(to_pci_dev(dev));
 	}
 
 	dev_iommu_priv_set(dev, dev_data);
@@ -1843,7 +1844,7 @@ static int attach_device(struct device *dev,
 			goto out;
 		}
 
-		if (dev_data->iommu_v2) {
+		if (pdev_pasid_supported(dev_data)) {
 			if (pdev_pri_ats_enable(pdev) != 0)
 				goto out;
 
@@ -1909,7 +1910,7 @@ static void detach_device(struct device *dev)
 	if (!dev_is_pci(dev))
 		goto out;
 
-	if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
+	if (domain->flags & PD_IOMMUV2_MASK && pdev_pasid_supported(dev_data))
 		pdev_iommuv2_disable(to_pci_dev(dev));
 	else if (dev_data->ats_enabled)
 		pci_disable_ats(to_pci_dev(dev));
@@ -2464,7 +2465,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
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

