Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60FF1848
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:47:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c7NdXcgPlVFw6gpJqfu5/y77wMdmfFmChUmb+5ygGdVVj1kGZNhjU5Z/LhPAshXmxyEUnOyVl+MzHKLtZcg8cAfkqixOsTh7enXNyt//Z2MPFrX56QRuFc+V8u5NPah8fThgBQgLOB0cAAonNjgXpk3q8yTHTZl04aPrtp2/dWBNLToYvctUvkYegHHWTbEDCCzA5oJT/qSNA4JFUJn8D2qLPNG5M3YoisqLeVTuAPxBGDKvLfV9M1RQylLqkPqefHi2aw1si/iCRmk4ms2G7a5qUM4Zla9pb9rMdWLFfXtaRabeMk9IzCh6RCn58jfcVJXyLdDBKMhJr3oui3r7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCXhnvzFBivzEf294jOl3+a3nAULjOFotJNTh69Y+0I=;
 b=PmE4DOzufpBtgjQ1OUgj2dm5l5fjX6ugaJZKbcbAKKHLAuKkMThC9NsTKiMaTQa+0tgz7VCCvGZ0xZMzNcLQwRH5ykU+KNIuroynPUPViVtpD7AmRoxxindEK+7Q7cYrqIcBoj4o/6yTxKqf8lkXS4K/Kw7NvIsai+ik+BM2qXX3ItM3tJoiuWV9S4IbGs9ZmcbFbPL363WinEL7Aa9NnNJgYCL2WhbZWuPNPsNp5oc5qygDlAy+8N3XKH6eMIVPZ0yz9CFgq1QupbuCTamsKLL2C2Lb9gI6kgyNBX8cZnbW2R4siC2ahEdD5z1Mq7rebWR1UMyBiqLWVT8FwJIoow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCXhnvzFBivzEf294jOl3+a3nAULjOFotJNTh69Y+0I=;
 b=nxaNrLp1wj2P1N0CHN3I8M+5GAcfHchefsgf6TCasGvk5lCdjVvobc7buuRisgAX9VfY2cEvYpLVdXQhjPH2XphfmHdMui+NJnZlc65iFVyiF5GDoZXf2Nc69WQDq5IIalCSFGfM3iyZUmPnD7YS25mljNN5QZzQ5FZL5kmcwik=
Received: from PH0P220CA0027.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::10)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 10:47:15 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::a8) by PH0P220CA0027.outlook.office365.com
 (2603:10b6:510:d3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 10:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Mon, 21 Aug 2023 10:47:14 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 05:47:11 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 12/14] iommu/amd: Introduce iommu_dev_data.flags to track device capabilities
Date: Mon, 21 Aug 2023 10:42:25 +0000
Message-ID: <20230821104227.706997-13-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|MW6PR12MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 150866bd-22ce-4e25-ab1f-08dba233fb84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wqpkxW7DC69QLh+KM95F3nzUYe4GTiVVsZ6T3sNpozcvQoEc2qj1JPFj+6jc5GOQhswqUek9cVboptmN0qRB3Qwn9/L6HzT1LuTqppJ239A0gt+imBZypJ2qOyGO1ZkJhGLAuWD3NdDGLSHsI1nWpwIIr68Jsz7uTId/35KzzrfotZqMwhbg2pM0G8/Nk7/OKCWkRWnfikboyk1ihiif5WpXEYhJiGRuGXC4T/Kie78hZy8Uh7CPFTiPG8n+yAQ8HzwuEQGqYWzwqXazGvzaZHHusREC/8HsCk6mckX/NMk+dekk2YQIJondgkaR4ZH99xArsb/Y7U6OZwystp7lIcbQFFPMBcLQT17svXC1Y9eHfuquymTR8oBQs5AHqXyKCk0FJ+mjsWBZNts45JA0APIJo4tA3BWhGRh9iTMidoaC1RTYlk9JI4SLzBAoeJ6nrum4Xx+R8xtBpdIKg+GosQnreAZItNI7D7dAdZ5dAHIAj22gvkgL+E/i3bCQyYpT1D5JzXLJ8Zdp9CIWwpGVA25tS+Y3g55piG8Fva3COueQWTe5QAYBIcMZBjuLOZY9AFr9BVX0Pdqnjs7zgsACAObCMYBpNnEOtGnYTYZXENKZciP8U4V3sLe8B0sf2JxdRn/+8IL86/MSfWNGhDy/C1bGTeUBgejr1Jf2/vgvCo4THD4Ybtb25vwxik6OpCSJjc4AS6fJRO0j7245nOUqSiSG6ymGwB1cNyMWYDPSVjG3qyGjVZwuswhTAIU5GyxxyDjBkQvnuxhJy3SfoODvVQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(7696005)(40480700001)(5660300002)(44832011)(336012)(426003)(16526019)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(54906003)(70586007)(110136005)(478600001)(82740400003)(356005)(81166007)(6666004)(40460700003)(41300700001)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:47:14.9239
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 150866bd-22ce-4e25-ab1f-08dba233fb84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070

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
index 9163e3a9aab9..b1a99b7d1956 100644
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

