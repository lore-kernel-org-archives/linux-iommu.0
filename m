Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611A741B8D4
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159122; cv=fail; b=IsbpCloiUcGfzwLWWTlliO9m1T7a4G6hH6qgFK7dO29vfp5YJPo4cWXYIpw2w/07c5xdFST1kfRfXIPWu0OcAlRL1z4u+qVfC0S9qEc94oA6/TzbmKRch9+t909jA7hrGxbtwdjvrNf2/R6HuM6UXvKpdiozYdrM7dIDmn/7CaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159122; c=relaxed/simple;
	bh=mr338XbovdhX98Co9go9E+K9fJ6474PmhuE5IP6AKtA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onZaJsm+oqHFfpAsSvqtkEAlEnK5vJTTVLeDcrtKkoLx8AZh9XNPlrQ2yoGaNllsQFwHbWkbE+6+D0G3AzO4cNMmCW3kIpDUYGXBHg5Ly8GysSTKtYEg5COFbBggZpHchjrCnjA34A5u3Z0AJSqZm2JobsZYxQ4lof3tvBXkHf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dZw7woJa; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dZw7woJa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPUJrhiaLLhGxw0uyiteWVoIJQHs/jGmgUpkitDXmTYAimT9/0vN04o9iGFfeNKmDPzXH3ejaliMnmY/ouYWRrXFW6VpiZ0+rlWbxgC8MOZQOnpTei1nhfdOpFny4pefTrqYgbQLdk95tNxSKuqjMOMNk0aIv7h2QD+mk35qWe8htrEN8fDMhPcWUDQk7wqX6nTDrrhCKaSF+30mH9pnBPKQVas/eVlrwfHLeiSf5cmQgp0TS5K2QEpC2Ks87SLCAScvnivuLsFwEFlek6/qGcAwh4iMF7HnjewuisGJuokMm++nQOkrYHIrHkMh0f1ULksl/374/s/hx8FEvlUVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8m4gRaTZMv7mpOGDXg3w0eXa7nze4yCCy6duvzNS/9E=;
 b=A0tMfzrplcVuWBQsGjFWhesf9Ofs6a7WWu29pxbBACxR+xnQKstpGfgUI5pppQsUK9qHD0ptZDpgDsGq1QRKE8ouNt/m5DInp0quHHdNv3t5KgvnwKJuViqoU/NkOBJ4/9ZhdwIbzA2AiHVgzg6xffEBDQKLV5kb2g1ktKgWOoENiXS2kSxztJ+tDhUppiA35bH8FffHT57X0XsdhhIh1b6WYDevqu1bhH/4b0WSkOAcJXI9XetNhu6F8HVVUkhUaWQqrgFD2KeMreUwHzi3fVxY+7XpAHeXyWpENcBFG4KFaV6K+O+NmbYxbx/erjinA0eDLjDvd+Vz044jUFprfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8m4gRaTZMv7mpOGDXg3w0eXa7nze4yCCy6duvzNS/9E=;
 b=dZw7woJaT0JdkrJOqipYyvgYalmMBLP/9BKUps70kzyIvaEh5JPWzLy/T7CUUbWL77XaDTWtDDpYhsZQS6lOoax/BKKht30/PGPTmLfDK9/NwdJpM6h8nw8aBG+M4ZhuHwSZM5K8du3ADWBA4Ry5alE9QSYoh585qx/PBEzsp6I=
Received: from PH7P223CA0022.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::14)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:31:49 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:338:cafe::21) by PH7P223CA0022.outlook.office365.com
 (2603:10b6:510:338::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:31:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:31:49 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:31:37 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 18/24] iommu/amd: Introduce helper function for updating device ID mapping table
Date: Mon, 27 Jul 2026 13:29:07 +0000
Message-ID: <20260727132913.22475-19-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de813f5-5371-4c64-557f-08deebe369ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|1800799024|23010399003|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rMZXlH04B3XDw8lGjUheSqwGz47R2yT652BIH+14uHkSppsudLH63x9ZMCPwqvDZLJL8Ssvd3LT6SFH1pT6I9I3iiUm4DgqKSp/31RyvXNmhgLDB3CrAac6Fpr5426JRLWhtVml0vi5HbB+bueuGeUr4uymR+hvEbsNrRrWajg8R1/V8L6N2F3kcbORxvXgT767ImCHHViritbvoqT6qv6q35MZHIPQKdQwjzu9grSzBEgzbSLAUw/FQMQx6FLYEXlrfVHWXhM594/Ce552RhgQKPBa4r4u+BiY7jVqaKTz9jO9PduOQIA3VWAUGwMr5YqXsGv0W2/xCeQCOftjcpQuEZaoMRLzHPFbg1+1aj52aJKqWs2Lyn6PUXsqQtQjU93x0D8jVtLIn5Gq/gKAQEi2CW752SQR9WST+zbcU9mudHhoUM7nKK6uMu1s/dGGjTRtJW3vLmMrZvSV/ZhmJ9pX2tkt6in4VcRXe+2feOuhuBon0POCCSJ1VHe5T5jIy5C0Zzp5HjXKqAccEQMW6CaEpqjqL533WixZbFTbi9T8FxE+H+f5oT9yPElb5A6LIt3s7/NcGXguoj6EzI4C0Uf09CrB6JImvEbI0Hddm4v6C2ezZFZxZgnaUxS90tc0ozkQi9mBlutKcwGymqsH4sRc2+0n11SiGoEzvafrerDGgxhmW8Gaafm+R7XD2Ai0CwWiH7zta7kM3Sq08P14ZQw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(1800799024)(23010399003)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	InhJCh8xk1J9MzR/XieUkgcbC6qFYPCdo4/RofYSylLh2jaAg34BNTMNoRs0HMW0QRHHrgHc9xTHY+/t9zTfKGRT+7G+9Mg1PmbcVof5utISQbD8JOU3EjoodzVDRtV4iy6Ew0OgP5BJ/aVhlxbrvEypukMyUR71wGSGgal9uC5D06OiNvMq8A7mDtlmP7kjHDU8tGzzkTLimyUbPqYJbNYoB4BGQGxcIGAHbRDufvMUrSh8QL5OkJPjBeNfu7MzEc5nEZ0DeqH/p4X8P+lLo8mh6B3vuf+a2WGlhqSv/zoS5hTdlCKAdFHZlpqh2ddLhgzVTQABCBl9A6r9gb3y3d/jUmmYA9awJWH4/VV3RgpNeVe8yjnTNskqQH341sXa+b73bWdy837hvRNVBbj8ySLV0ER4wnxB2bIxxP6+v2c4LyX4esZNk92z04j3oszz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:31:49.5644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de813f5-5371-4c64-557f-08deebe369ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830

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
 drivers/iommu/amd/amd_viommu.h | 10 +++++++
 drivers/iommu/amd/iommufd.c    |  9 ++++++
 drivers/iommu/amd/viommu.c     | 53 +++++++++++++++++++++++++++++++++-
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index b6fd5ffc3b82..ca09a9856938 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -6,6 +6,8 @@
 #ifndef AMD_VIOMMU_H
 #define AMD_VIOMMU_H
 
+#define VIOMMU_MAX_GDEVID	0xFFFF
+
 #if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
 
 int amd_viommu_init(struct amd_iommu *iommu);
@@ -20,6 +22,9 @@ void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *vio
 
 int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
 				u16 hdom_id, u16 gdom_id);
+
+void amd_viommu_set_device_mapping(struct amd_iommu *iommu, u16 hDevId,
+				   u16 guestId, u16 gDevId);
 #else
 
 static inline int amd_viommu_init(struct amd_iommu *iommu)
@@ -45,6 +50,11 @@ static inline void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iom
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
index 1975b2932107..7e070f72f02e 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -136,12 +136,18 @@ static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
 	struct pci_dev *pdev = to_pci_dev(vdev->idev->dev);
 	struct iommufd_viommu *viommu = vdev->viommu;
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
 
 	if (!pdev) {
 		pr_err("%s: not a PCI device\n", __func__);
 		return -EINVAL;
 	}
 
+	if (vdev->virt_id > VIOMMU_MAX_GDEVID) {
+		pr_err("%s: Invalid virtual ID (virt_id=%#llx)\n", __func__, vdev->virt_id);
+		return -EINVAL;
+	}
+
 	dev_data = dev_iommu_priv_get(&pdev->dev);
 	if (!dev_data) {
 		pr_err("%s: Device not found (devid=%#x)\n",
@@ -152,6 +158,9 @@ static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
 	pr_debug("%s: gid=%#x, hdev_id=%#x, gdev_id=%#llx\n", __func__,
 		 aviommu->gid, pci_dev_id(pdev), vdev->virt_id);
 
+	amd_viommu_set_device_mapping(iommu, pci_dev_id(pdev), aviommu->gid,
+				       (u16)vdev->virt_id);
+
 	return 0;
 }
 
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 708f2c7496a4..eb3f5217d856 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -29,7 +29,6 @@
 /*
  * Guest Device ID Mapping Table
  */
-#define VIOMMU_MAX_GDEVID	0xFFFF
 #define VIOMMU_DEVID_MAPPING_BASE	0x1000000000ULL
 #define VIOMMU_DEVID_MAPPING_ENTRY_SIZE	(1 << 20)
 
@@ -40,6 +39,7 @@
 #define VIOMMU_DOMID_MAPPING_BASE	0x2000000000ULL
 #define VIOMMU_DOMID_MAPPING_ENTRY_SIZE	(1 << 19)
 
+#define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET	0x00
 #define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET	0x08
 
 LIST_HEAD(viommu_devid_map);
@@ -422,6 +422,53 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
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
@@ -436,6 +483,10 @@ static void viommu_clear_mapping(struct amd_iommu *iommu,
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

