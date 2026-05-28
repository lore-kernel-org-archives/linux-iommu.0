Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012053.outbound.protection.outlook.com [40.93.195.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C338B3191C8
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945565; cv=fail; b=DkxqRQ5j5zjxLsgg6W+7feFlcqC/aEzMEJdVo8aDPzhYWKjLF+7WyPVGLzgSVdppEfv+hWuf95nkbG78imNeG5ywgANvN7Mrn7oWrBlIFyBH5hR8U5KbTMKI1NczEZ9JOdEZwlV0Vhsw6RYXjuNc+AatTz4K+78KLM6YlBHzM9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945565; c=relaxed/simple;
	bh=QoU/T0hmFSXYRNhpKeqYa9Fs3LZ+ruw7NGldAS5GUE8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iuRR1u5L05aBcOshLF2jt2HQjWGpvI3SjVoXnoENEo00vbUHADn5weA4DeVPj7PnTIewK/5ndiekL1NvbrIOD21X3F175RWRHOEB3XGrgL8CmKfcNHRZzE7aJFeMBaRFXzPZmgggJ+PxR32KzcStdd65hs3PxVrqGZVJo8rfKG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bbjMoSvL; arc=fail smtp.client-ip=40.93.195.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bbjMoSvL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQJQ4rg4SA5up3i7vLqAareKwufR1PlpOPt/YQU9trbTeEHxzmfxuZ4hYP+qFEfHQqJKICP8SgGVlPWlaZhI1W36oz/H82ccJj3eVKl00Wx+4Nm9zS6PBXHjj7bdwFFh/efmyGOl8vTKpH62fNHGpGzRnpZryvRAAlQUyc0LYY3YWQPRkSw4vyk3Yw5pYKdSkdsuka+fcOqwFr+3qVgSmzAm+EX93sCEBMFCzUt2k8oNTZq0YxWzRq02e8sA7ajVRk7OkS9GMRG9ek2N0xVG4oOEU/D4Or3Cf7hZdwGc7jSwEFk3syLP4YJ9G8QxAuYEuXP/PEF0SDp4jzRYcf3LnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEuNJU4aQLsY4xYV/WH761Np6oaBMqZQPHN1FkDZygA=;
 b=guwE0iIDJX7K3EcvtxDNIuBBFx2C3l8u84IimBBgZkZkoDxTY7tAZttaJ6MQ6XJ7LpF4PdaJNwV49g1Rep1YwGhh8CQeNmqPQrDVZKmNOs5riUa8aiRVHxfJP0mHm2X3E6kS8yheO/M8T3doN0+mAtNtkN2I7DoXEp47bWZS9v+MirV6f1ex5E5DNam36fpaDnH74Irwbh4rGfiLTaUI9XqJi7B71XYQdr63b+y7wN795o3q0lY1Z6bafdjqHJhye4Ou/bt0ziCiPOzzBB98PEEWTwC2QZ0lMg7Xg7jtLwkKQzSkB9gjrhB3V0LaVgsmmmk2I5N8Ty7dtBSqF/rIMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEuNJU4aQLsY4xYV/WH761Np6oaBMqZQPHN1FkDZygA=;
 b=bbjMoSvLXq1wjDBl6izSTgW31K2F6m8glFDUEqKvNpDsWC7S3DdnRKmc98CVqmXtk24c3/mh9i5Ru/kgZzLkBUstU63o+S8sBsez26ZPDC+5zLGJqMsHL39suBKCcfPhPpKdJd5C41C1UeOyd31PvHuRfo3gMZhyagDEAJ2UcyM=
Received: from SN6PR2101CA0006.namprd21.prod.outlook.com
 (2603:10b6:805:106::16) by IA4PR12MB9788.namprd12.prod.outlook.com
 (2603:10b6:208:5d5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 05:19:20 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:805:106:cafe::8e) by SN6PR2101CA0006.outlook.office365.com
 (2603:10b6:805:106::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Thu, 28
 May 2026 05:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:19:19 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:19:14 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 16/26] iommu/amd: Introduce helper function for updating device ID mapping table
Date: Thu, 28 May 2026 05:17:28 +0000
Message-ID: <20260528051738.596013-17-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|IA4PR12MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: fc93d1e6-579a-4624-eea9-08debc78abe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	tZ4zVsVKuS7S8yOzfBeUlbDctOKbQrlY9s8qmiemDi44w0GpvbUkqvZgUFaNVmgiQGp2oZG/De9gtGJeUArYQnzwotHLskcopOORfRdVV+fCm4ljE2gOiv0zBcm6mGh2Vdt1QMiasmBVCfk93bl+qgkbTP+2xMsmsfASD2pOjZAuE4Vl/3pssyTj81ShEvcUIGFGVvatj9E+w7qYuGu5pJPwFhcvHsQRvWlyEKvxg3dvLUhz353fpamzGfEtxCKI23defxyp59b8QvU6iOV/LDHRsvPf/ZVWfDDxAKrS2zYmMiacTXJJJyKAsbPonjq5+QArTIZy2Tt101zJrtLbBFMCFVz53XjWEPmGa9oiyS9pqN5QjOaW3OLWvWGbEfYgTn59ebcLtEKx47RWNqnINNXfq+VurTZmRgrBxc1t1GucWF6uULWnuGKxQayqX8gTfFgNgPYtmiUo16BsL8ZhCUYfmd3xNR1g+1YiizucVlD0StegKrgjyHIszj7Aiap3TUchENsMNTsNgdK77z9q88ytb5463sV7H7seMaS1+KnHOvEurXaFA0ql324OtwtN6hE6c6H1fqZQ9yFMFOy0HjFYh3dL0FvYqGwPi6kZuY0ep4epko6w1jAT40XoTBhzpT9wiIYLj5fTvgO86bB20utHLZCiU62nJa1pFjA8rQOzFM4iMy721IKm8lBonU3wADw0i9KcJB9unOBWSU1f6tUA/kD9TFXcZnlxpBK17p8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w/m4g25X7YJFGxJSj8KfmtL3A62ChjNkpYNVxNCYU0VrOFq9DwKgC7H6f3UthEv+2VcfAac9WpFbLhr6+8xK0CkC75rMzCMAhkZhE7e3Fcv/h421vJb7nlSEqpI+O+t/Oyin0Lme1dncAg0fnTrDl+ObRo23UcA4w/NFZKIbAAVmviCUET38iPIZN2zcmWpuJPOtJAF6k1Uo6MY49P1ch75FgNCgtmjJ5zJsa5kx7MMi6avzagNdZgR0BpFxJKGaCTESr+UNZ3ohVlxC+tmg2qIoKm3dBl6G/cgKvj8IavnpEWiEJ0KZHHeH7hHKA76zQvrigmzhPiPrCiu2DinjVV2xb9P5/55zgIVuCZYl9vr7wah05BwZ0crqOWS5nVcYkh6R5Ov02o5ea/vD3XDAhIwvVz7XFbZm2hch5kDYThv9/H7aPXJuRXiWnS9hyurU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:19:19.8350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc93d1e6-579a-4624-eea9-08debc78abe1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9788

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
index eb43d02371a8..6020f2caf445 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -137,6 +137,7 @@ static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
 	struct pci_dev *pdev = to_pci_dev(vdev->idev->dev);
 	struct iommufd_viommu *viommu = vdev->viommu;
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
 
 	if (!pdev) {
 		pr_err("%s: not a PCI device\n", __func__);
@@ -155,6 +156,8 @@ static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
 	pr_debug("%s: gid=%#x, hdev_id=%#x, gdev_id=%#x\n", __func__,
 			 dev_data->gid, pci_dev_id(pdev), dev_data->gDevId);
 
+	amd_viommu_set_device_mapping(iommu, pci_dev_id(pdev), dev_data->gid, dev_data->gDevId);
+
 	return 0;
 }
 
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 3f7c17d400d0..b3150f7bcec3 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -40,6 +40,7 @@
 #define VIOMMU_DOMID_MAPPING_BASE	0x2000000000ULL
 #define VIOMMU_DOMID_MAPPING_ENTRY_SIZE	(1 << 19)
 
+#define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET	0x00
 #define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET	0x08
 
 LIST_HEAD(viommu_devid_map);
@@ -369,6 +370,53 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
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
@@ -383,6 +431,10 @@ static void viommu_clear_mapping(struct amd_iommu *iommu,
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

