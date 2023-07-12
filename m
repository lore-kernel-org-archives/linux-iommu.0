Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3E9100AE
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:19:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqWedbvnUv8mypkCgt17lCnE0ZCV+gqf22EQrZMf6HxIaY+l32zDs4j/k8X+hjmY9P/lU1xEUwRn+JJXcn0wRuEvSod/0AQRT235E/K3eWSj8nkPWytkyAPR8kN5H/PrMrnZaQvuRUCFmuJSwYcuUC7jvofijpoR//5maICB/xkCeyHGR48YQjh1eVumqgyUy6xOSq8yzHK/GNUCY2qNf9o1Y3XyCsCfNkT22w2UeiOgbhqC5x/DleLsrCpSM2uhmAzgAjbQAZNFMpnXPcxebExtg7oZmRw9rsUSsn7ZuHd84VH3On6fmy/1YhA7ttftsEU46ihdq/fjQBLHhubK3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BrlWeWG10swHKXv9mJwmcs5zEyC1Gz3P9XeQG53b0I=;
 b=MmPRw/8mxLmuYTzvBQD0tKOlQOzUgWmpCyU6Jq4106sEMX41sEVqUBr9MNbwa/F34Zewf8X/MfPi2YCfi+QbyugEquQnDNi5XAL4nQsvvZXiRcS7qkzqJdSd06SakFsLjF+i+aWJnZt4L8pv8sfff/PAk/2tKO4UIhRTI2bcUQDmWIZtRH/S/djPUyyqzp1totpOqhBLYNlPs0k+KZPoyB6ODDZ8G/sWY91g/CxZangDUjoDNCSHOmLdIG+Q9gI5QakdYNN/O1PF1ybviJJk2paz9zn9EJsOyjvbbw8p5LEyj2jtzDXa9A2O6fJZIYdC91HW+qA3icAA69Bhx8TkPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BrlWeWG10swHKXv9mJwmcs5zEyC1Gz3P9XeQG53b0I=;
 b=xLKyvtRkK8x8CjdjrPeZb43OgP4MaFft0fyJD/ibiXxQDMpKR465xmqPJ3Kkv5JWpyu7VJdtSy5Sjc/nm1jeFtOP7dYd1NfyiwRpknrj8qjjXor1gUwI/1GUCWVylDq5rMJ6GYwwxLskBndTrPe+kVLxyseBMEqGaWmzVtNZtXU=
Received: from MW4PR04CA0200.namprd04.prod.outlook.com (2603:10b6:303:86::25)
 by IA0PR12MB7773.namprd12.prod.outlook.com (2603:10b6:208:431::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 14:19:56 +0000
Received: from CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::fa) by MW4PR04CA0200.outlook.office365.com
 (2603:10b6:303:86::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 14:19:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT030.mail.protection.outlook.com (10.13.174.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 14:19:55 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:19:52 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 16/21] iommu/amd: Introduce iommu_dev_data.flags to track device capabilities
Date: Wed, 12 Jul 2023 14:15:11 +0000
Message-ID: <20230712141516.154144-17-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT030:EE_|IA0PR12MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ccf718-07d1-49c9-607a-08db82e31100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+ubwR0wCxUxEK3ELV9+kKLMWVhuXofWIUaS+gut8X4FehNfRSQXlhY6z7/PIyqrfS/mSDzC2+fvWe3AtswdtIcPLQ34pmC7m9LCXwxzzL1wgeSoRPhu3vcZQquBKwjDwTJ4zz9mmqU7LAih83iuOYAW9HJubwtq6a3ydd9vfl80Px0XkAMukmKnwta4FwXtHWMQO8BChuw2sEPeVXUTRehUnTlyH8goahLBBwBa37kHB8LnanB0lzpeSRH7v/I7DByIfLZ/DyxRdV1mQHp3Xvtbf/6aKaU9v3Ki9569xc29F3FOwyrWfUu5fy5bVilkLnnWb+PG2w3D1pdGydNWGt5zqfmrlweAMrnTSATNoTdFveiEVJ93IPIPJzt+R1id/qgfME+JrZLmGgcOe0RJz4QAyEvRdqxzhByaE/v2IOPNYD8Hrsaa0GyVCjiHhxZEwOwxCNLYPJJH3/wh7KHT5+2EMCoONVg/0+3PMqLWmhLQNOBQYPI9f3/o7FhkTjfzHGZuBuUVtmsEkxz9fx6DYxXoc2mZifVxfbQSyWbeHIpDv6HCch0vm1ftubHj3JJcTmYLjOzAnooe/FmrWA62+Kkvf13q7na2ddBbe7a2cWf2mx7fNexp71miP8uoEG7+SmXtchjAZgwfgyhKyDV/N7J1IQVeHZphBEn8VFrR4Cte9MbsAjm2vYDwFXEQSICH/2VmioNuIGXGn31Q7IqkSqWRewKGHs7/w5Kq4wBcsfc/CeANm6LorCRNPcJRVs+TMptjJy5uOrWbypPyfoi3YYg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(426003)(336012)(36756003)(2616005)(2906002)(41300700001)(36860700001)(83380400001)(47076005)(40480700001)(5660300002)(26005)(1076003)(16526019)(186003)(44832011)(40460700003)(8936002)(8676002)(82740400003)(356005)(81166007)(54906003)(110136005)(7696005)(70586007)(70206006)(4326008)(6666004)(86362001)(82310400005)(478600001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:19:55.5919
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ccf718-07d1-49c9-607a-08db82e31100
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773

Currently we use struct iommu_dev_data.iommu_v2 to keep track of the device
ATS, PRI, and PASID capabilities. But these capabilities can be enabled
independently (except PRI requires ATS support). Hence, replace
the iommu_v2 variable with a flags variable, which keep track of the device
capabilities.

Finally device PRI/PASID is shared between PF and any associated VFs (See
commit 9bf49e36d718 ("PCI/ATS: Handle sharing of PF PRI Capability with
all VFs")). Hence use pci_pri_supported() and pci_pasid_features() instead
of pci_find_ext_capability() to check device PRI/PASID support.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  2 +-
 drivers/iommu/amd/iommu.c           | 43 +++++++++++++++--------------
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f74750b7f963..57586a8c451e 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -814,7 +814,7 @@ struct iommu_dev_data {
 	struct protection_domain *domain; /* Domain the device is bound to */
 	struct device *dev;
 	u16 devid;			  /* PCI Device ID */
-	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
+	u32 flags;			  /* Holds AMD_IOMMU_DEVICE_FLAG_<*> */
 	struct {
 		bool enabled;
 		int qdep;
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ce405cece3b5..ff38561435e2 100644
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
@@ -1733,7 +1734,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 
 	/* Update device table */
 	set_dte_entry(iommu, dev_data->devid, domain,
-		      ats, dev_data->iommu_v2);
+		      ats, dev_data->flags);
 	clone_aliases(iommu, dev_data->dev);
 
 	device_flush_dte(dev_data);
@@ -1851,7 +1852,7 @@ static int attach_device(struct device *dev,
 			goto out;
 		}
 
-		if (dev_data->iommu_v2) {
+		if (pdev_pasid_supported(dev_data)) {
 			if (pdev_pri_ats_enable(pdev) != 0)
 				goto out;
 
@@ -1917,7 +1918,7 @@ static void detach_device(struct device *dev)
 	if (!dev_is_pci(dev))
 		goto out;
 
-	if (domain->flags & PD_FLAG_GCR3 && dev_data->iommu_v2)
+	if (domain->flags & PD_FLAG_GCR3 && pdev_pasid_supported(dev_data))
 		pdev_iommuv2_disable(to_pci_dev(dev));
 	else if (dev_data->ats.enabled)
 		pci_disable_ats(to_pci_dev(dev));
@@ -2012,7 +2013,7 @@ static void update_device_table(struct protection_domain *domain)
 		if (!iommu)
 			continue;
 		set_dte_entry(iommu, dev_data->devid, domain,
-			      dev_data->ats.enabled, dev_data->iommu_v2);
+			      dev_data->ats.enabled, dev_data->flags);
 		clone_aliases(iommu, dev_data->dev);
 	}
 }
@@ -2551,7 +2552,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
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

