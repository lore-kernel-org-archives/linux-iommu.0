Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2667643DA59
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747736; cv=fail; b=dOu3l+nBqwhS/acKfSv3atJdnRBo06ZxNDa+3sWJYZLGz6mwHB2mV1nIatVXA/AmWSeeBV4t4Ab/mlWUVNDSZXhNNqtwxzrNKpgnR5CiVaqIpN6vwRyHz3TXhI8A24pOB2LswVt+v8i5MuZxXFVPAd/G0xvp0+61yTKJnpUtXNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747736; c=relaxed/simple;
	bh=3701spbEslAb0tO6LIY8hgt8sug5vc/F6Mf4YTF/kEg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMAaiVHhhpTSk/ylCH1uAslEIl+HZ+Y+P0BUFFZmJVheRzFl9K0XTZ8tidzJ1uEj4XJHdzTaGH4Qr8hxEpUjUpis+6y7b5Hh1i3vGAsdREuP64mm3Y0S9sGGQ+Mm7KLWJK6pblGrZO2kCZoGrD+50Vo50O3C6EcIOGNjRJ/OzSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cI+WwasB; arc=fail smtp.client-ip=52.101.48.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cI+WwasB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gwf2ojqavT2Cp1lapg2W2wiepsuyYufYZNV0rbcnP3lGWyJNoxIufhRh7d9mA0IyGe3tA8zgzOCiIsQw5O2I3I00bZ4oxNDO3GqzyISfHw7kLlgu7mpNPEKiHS9rDJtrzlAM5LlDNCctf+nFtrGlTFo74FOvCdr6KfmSxVR3ndkPOugXk6UUbKS2YkYDK/AwyEbxIFOTN+9IdCOfCWVGXyBYsoEldfxObBsn3mvfta60vMP32SvkYAsyWVbyms/Rvf5gWS4NbZJJmXPQrcr5X4xPm7lO7kksOKWi9KAs+sj5idlJIAy438gxu2bdNao/0xiOKcY+R3Id7reW83yxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ua7UOYFPuC6NmiX4vfca3D5NFs6LYq0YpkBoOAWLLrs=;
 b=eazxJETPyurmvjYcuM0k8bAWhW2uKhjP2EdjY2dL3ruWvVY48NiURPjwCLSxoM+vqLjmdSiJKix9ujk18f+LqGh+S8LPwv1vcc1GDdvDANgZ57RSvDUUTfsPWvzHnUDVDiXro2K6BrVJNH7ATqVtneaBMN9btkZDR+odcN+cfd59vZz7m8NvqhPbaFHJBYTkBrR9m4RA1UCiiMlTowdDJrgr4yiaO1r+IeCTEhUjJ8Gq+b8xKoOKLOT+I1g+CKBRwGypWqTTAZlz6ABu0GK9KeakiKZnz8wV0TUsaSuZE6t8wFQTbLsrAbSJEgwAZiIh2piYkTeYRFtLDmvD3ocGOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ua7UOYFPuC6NmiX4vfca3D5NFs6LYq0YpkBoOAWLLrs=;
 b=cI+WwasBH7/S//p9v6pPZNHGqf5uEk3vSppi6a5WYEXvdkpLWlzDnXvG3Rb5RyfzR0dzCHUl5iOry4u5pZOnKRnrEtWfMOSfKlYWKqaT6L0Rx6fUxfRS+fsr0se5P/QqsJZkj7TpgPueyBZCL3DFTHU/pwd58lhshRKQOjMHelw=
Received: from MN2PR08CA0027.namprd08.prod.outlook.com (2603:10b6:208:239::32)
 by PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Mon, 29 Jun
 2026 15:42:10 +0000
Received: from BN2PEPF000055E0.namprd21.prod.outlook.com
 (2603:10b6:208:239:cafe::60) by MN2PR08CA0027.outlook.office365.com
 (2603:10b6:208:239::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000055E0.mail.protection.outlook.com (10.167.245.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.0 via Frontend Transport; Mon, 29 Jun 2026 15:42:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:58 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:37:17 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 18/22] iommu/amd: Introduce helper function for updating device ID mapping table
Date: Mon, 29 Jun 2026 15:35:31 +0000
Message-ID: <20260629153535.15775-19-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E0:EE_|PH7PR12MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: f536cd56-18a6-4058-5002-08ded5f4fba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700016|82310400026|23010399003|3023799007|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	OZDW4x3Mk4rI9M3t95bebZBQbOot6A5NBZ333v5Ijsgd+kbs7/DNipSs+tw3JPpyogTQOUb2NAhCCPtDHh/R5N9WgkBEeS1T8Qnwd4BxGSBOGLDta4yGCQxoT2AD/qt4odil67KxxlDf6SFrBN20rWbhnD97RQ/52HzXl7GYVaL11hySi1Ygh7sIU863C9h6rvr5cUkmHLIcH30vl0+3Y7rxuojxGeOTfFyTGoOiZyNyRn/UI0wbQhC0WYvyr7OeOMK7wQpwMWvu9s9XLCK/vWZ1Ql3db1OhBjhJiTL68UEL5QGGoMG52pINduNmFo1bhBk4+zyqVRMQKg4dkxWFdCY2hMG5DusRorlfEJK6IyACA/MxscXclHpv7ZqqoCt2ykX2qteYXmzJy17/bmzxr6fyBAcrJliCvLT2JLohJiQ9aUq5jUnNKkelfnnE/vgEXKz81fgEDpTHnykolMmx1YcQivGcpVuL67SZJgbx4ijTN1xCfGXS2EqrV+LjzvFt4zrpyyOgC8He4lnAOeFBshx2GAgRZvvmVtITcZ5P/NXXzvkPhVHmPL6nXpjehu8Lw1J/LHdIDKK/ZUlRrvDcKU8bN0jNEd4OUhHB8fHsfe1ez20ZB+VLemISS3i8acEj3AaFqxvX4QTkFrGU6s4nxDgJH0u4NqNqHjgens4E5Z18XtdJoRdZ2V2vVSK+e/35OqjaiHLFcPFuL+cynQTneA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700016)(82310400026)(23010399003)(3023799007)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BO906/l8bGoLkHJFPbcZe6UfCPJwAT73Vg+5C6f3X/TovHuEUXtqx6wrgoghFse88HCmSqn/4Eevwdel6IFMzWnzYCOBTCzr/622C5EsDLe7HHnUMkRnQ4pq5gBvgQnvI3CbeJopy1HzuF0iAjq5yMQN3idgB2HxrNjkI5P2H93FJ84b30zH6sTlr8LE5g+O3OBb52qLKN2D488ncmGtKv9ZHnqbqypYlH/IBhNsLYGIS6kbVFmsJU2srN0wsCwFW4itRMheuht2681kbAVpAznYio0lTDzmJQ90+Rb3dozBG9tbgCF6+m/ZdOlkaEpW9ogQnF/K18Uhf4V4w6XoVKg7Vum3mO4caiw2Z4iMHaL/CBHonq7e74HLRHqTVOMLhUgUXBvtFxtUZegCwliWsMVbGGHVBJGMdlp9H5sXY2aRi6wkwJlNyrXkwQauU0EO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:42:10.3189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f536cd56-18a6-4058-5002-08ded5f4fba1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055E0.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655

AMD vIOMMU hardware uses the Device ID mapping table to map Guest Device ID
(GDevID) to Host Device ID when it virtualises guest IOMMU commands.
It uses GID and GDevID to indexe into the table to look up host device ID.

Linux IOMMU driver programs the table entry using VFCntlMMIO Guest Device
Map Control Register.

Introduce amd_viommu_set/clear_device_mapping(), which are used to set
the entry when initialize the IOMMUFD vDevice.  Clearing the entry is
done during VM destroy.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_viommu.h |  8 ++++++
 drivers/iommu/amd/iommufd.c    |  3 ++
 drivers/iommu/amd/viommu.c     | 52 ++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index b6fd5ffc3b82..3a8f41baaab9 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -20,6 +20,9 @@ void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *vio
 
 int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
 				u16 hdom_id, u16 gdom_id);
+
+void amd_viommu_set_device_mapping(struct amd_iommu *iommu, u16 hDevId,
+				   u16 guestId, u16 gDevId);
 #else
 
 static inline int amd_viommu_init(struct amd_iommu *iommu)
@@ -45,6 +48,11 @@ static inline void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iom
 {
 }
 
+static inline void amd_viommu_set_device_mapping(struct amd_iommu *iommu, u16 hDevId,
+						 u16 guestId, u16 gDevId)
+{
+}
+
 #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
 
 #endif /* AMD_VIOMMU_H */
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 1d159b78e37c..8b569b469a07 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -136,6 +136,7 @@ static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
 	struct pci_dev *pdev = to_pci_dev(vdev->idev->dev);
 	struct iommufd_viommu *viommu = vdev->viommu;
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
 
 	if (!pdev) {
 		pr_err("%s: not a PCI device\n", __func__);
@@ -154,6 +155,8 @@ static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
 	pr_debug("%s: gid=%#x, hdev_id=%#x, gdev_id=%#x\n", __func__,
 			 dev_data->gid, pci_dev_id(pdev), dev_data->gDevId);
 
+	amd_viommu_set_device_mapping(iommu, pci_dev_id(pdev), dev_data->gid, dev_data->gDevId);
+
 	return 0;
 }
 
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 9b471aadd5df..7b3127d829c5 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -40,6 +40,7 @@
 #define VIOMMU_DOMID_MAPPING_BASE	0x2000000000ULL
 #define VIOMMU_DOMID_MAPPING_ENTRY_SIZE	(1 << 19)
 
+#define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET	0x00
 #define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET	0x08
 
 LIST_HEAD(viommu_devid_map);
@@ -429,6 +430,53 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
 	*entry = NULL;
 }
 
+#define DEVID_ENTRY_GDEVID_MASK		GENMASK_ULL(61, 46)
+#define DEVID_ENTRY_HDEVID_MASK		GENMASK_ULL(29, 14)
+#define DEVID_ENTRY_WRITE		BIT_ULL(63)
+#define DEVID_ENTRY_VALID		BIT_ULL(0)
+
+/*
+ * Program the DevID via VFCTRL registers
+ * This function will be called during VM init via VFIO.
+ */
+void amd_viommu_set_device_mapping(struct amd_iommu *iommu, u16 hDevId,
+				   u16 guestId, u16 gDevId)
+{
+	u64 val;
+	u8 __iomem *vfctrl;
+
+	pr_debug("%s: iommu_devid=%#x, gid=%#x, hDevId=%#x, gDevId=%#x\n",
+		__func__, pci_dev_id(iommu->dev), guestId, hDevId, gDevId);
+
+	val = FIELD_PREP(DEVID_ENTRY_GDEVID_MASK, gDevId) |
+	      FIELD_PREP(DEVID_ENTRY_HDEVID_MASK, hDevId) |
+	      DEVID_ENTRY_WRITE | DEVID_ENTRY_VALID;
+
+	vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, guestId);
+
+	writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET);
+}
+
+/*
+ * Clear the DevID via VFCTRL registers
+ * This function will be called during VM destroy via VFIO.
+ */
+static void clear_device_mapping(struct amd_iommu *iommu, u16 guestId, u16 gDevId)
+{
+	u64 val;
+	u8 __iomem *vfctrl;
+
+	/*
+	 * Clear the DevID in VFCTRL registers
+	 */
+	val = FIELD_PREP(DEVID_ENTRY_GDEVID_MASK, gDevId) |
+	      FIELD_PREP(DEVID_ENTRY_HDEVID_MASK, 0) |
+	      DEVID_ENTRY_WRITE | DEVID_ENTRY_VALID;
+
+	vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, guestId);
+	writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET);
+}
+
 static void viommu_clear_mapping(struct amd_iommu *iommu,
 				 struct amd_iommu_viommu *aviommu)
 {
@@ -443,6 +491,10 @@ static void viommu_clear_mapping(struct amd_iommu *iommu,
 	 */
 	for (i = 0; i <= VIOMMU_MAX_GDOMID; i++)
 		amd_viommu_domain_id_update(iommu, gid, aviommu->parent->id, i);
+
+	for (i = 0; i <= VIOMMU_MAX_GDEVID; i++)
+		clear_device_mapping(iommu, gid, i);
+
 }
 
 void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *aviommu)
-- 
2.34.1

