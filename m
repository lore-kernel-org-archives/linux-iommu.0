Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013069.outbound.protection.outlook.com [40.93.196.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0DA3AEF49
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860250; cv=fail; b=G9Q0T5aaxptW22Ibu6pjUowwSX5Kmws3kbA9rvaDFq4xPYIzOhutd+zmIoJA0zFUBDMIvPvKvxg8gXeMKln6cMhbl5xfoXTX8QX5T5SB91r4YTZe/ODxM+YR15WjHZstwAiIkCSUxm7aVt97UOuneiPh5Lx+gMKwVqf5cXh+m0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860250; c=relaxed/simple;
	bh=M/hqpqY9Fl2/6cGfs/ZJYLweqOZHlQCvyv+wby/JZuQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XrEuJVs6C70d8tSidKJaTLuRzMNq6JdACPgUChqXZnpUVN9ZJiyt5pMOZkaq1DxoZqkb4ne5ShT1s9+AWvNM/HZFAYvQC7KCn2uyyfcoKf+w4Aqjl0VEhB7n8HqAOt6h3aPva29xXSy3c84vk3aC3fw9J/Ixmco/jHb8veaow0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tsYyMvOu; arc=fail smtp.client-ip=40.93.196.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tsYyMvOu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9QUzrhL6fJpIyHqpY7uGkHYlUoQGk4HGsenKmRma4n0pe/6EbdD7eaIJXum2c0OFGk3wt8PjXqqQwJs2Gd/vaPz+3e7uWWUfGm1Bj5CwajOOJXytP/xIXGPYyhyHOppuj/+DFCpl1iiA6NB/1fcTT8QrKqdm9aRLC/Nt5QKw97a5hcpm9CjBquLEj9DEeRcY9NCfWn8J2/aFAVM7tjZaaqJck6TN1xKiX+e3bLHOiczO8L+/Vq9EAEvXaoCJGTraFce531iKhe/x2vB1YnmbBgrnUWVbaM0UQ54c5qFYs4N2BUyKqIAWsL2yC546hq1++KXmqMD3oT59/SvITWoAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2nSkQVxiJ+NQDFQyYsumVcBfO/I8vnH4Y3u1RCSKzQ=;
 b=GE8RqI3MZ5H7UfT82v0rbHg2LV4Xnjeb1oCrwl6N0R68e040e++QiobZQAXF+HAM2/pkFUdUkDGiMawjG8IAiJHx/hstJ1HELy6X7594gE5X6Gj+ASp2ZU7Go2uikeiJPH6LED6nnTH+ciz5rXTpi8CPTTVI6bvbP+tU9wtUlo6yH+NZsw+vyAVP/eoCSJHrTsEj/CScL2UreSHCgDY9Ayq9ld9VBOJdDGUnCz2IbiHpUg9CPuVxRRE0CHROr9+OcqnaTC/DHV7tlpRltC4Q/CgwtbmMzjmBMU3/qzi5DIbFENnHx2WYJAbbPOaxc1x56QxQzYr7AFK7i1PSa9faRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2nSkQVxiJ+NQDFQyYsumVcBfO/I8vnH4Y3u1RCSKzQ=;
 b=tsYyMvOuDADIwFqJeA9JlUx5yoROYyB6Hk0d6eI4qXva4jvnoMrglRiJTLGV6CS20gyCtLA8zmfvGP1y0HKNbNFwtgicR624TJ5kvRmHRw1aprX9y4eZdf2fkHpZbuemzVWfxPHXYUWhe7JbYl9rBlshofjmCMMsr6iPkKLZ+GY=
Received: from PH8P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::20)
 by DM4PR12MB7597.namprd12.prod.outlook.com (2603:10b6:8:10b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:44:03 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:2d7:cafe::6b) by PH8P222CA0014.outlook.office365.com
 (2603:10b6:510:2d7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:44:03 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:43:52 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 16/22] iommu/amd: Introduce helper function for updating device ID mapping table
Date: Mon, 30 Mar 2026 08:42:00 +0000
Message-ID: <20260330084206.9251-17-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|DM4PR12MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 159ce8ab-f19c-4ad3-d025-08de8e387f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	gSfbQPKhtnqod/NavoWOA9O95iAKBS7R97ZGKFUuvGvvClt9WSHSVs/9DbFbxZmJMZQf1pvFlIGe0Y2B4AaZe9aWWvgbNohfauicmKQPgk/tQwjLPT7+/1/SaCdbRCw/L9RRf10rFephogRydciylTqkgAUGQ5UgPDlpZW5K5osyGwzlnct9tULx7MhUcQh1qctsY51QC8TJ5frxShCP3jAmrewtiIqFRlU3c2WytIkYxmm9IRBFrln1s5ZKa7TU8ZDQc8dT1qYY+HW7QJdNwC7SxFtpPqxIUaNgeEv9t++Xtl/9S5Zz0h368c9C1jEH7d98CCI/Y8LcTuYuqJB/O4HzrklEYDM9+Y/6ucBDB1Qzz55+zk+zJJfC5DsBDPmyZsFP7Nyzpq8A27i0JslbYaOQ+ZtRVT8tNtPPik/mi3289sNRk/1i7kAyEsQLZ/Xyg1cE9dJ1w3j2D23jz/7hHGDZoddBnF/VNmb3+qhoZKAAm9XLJhzgwCrw6OGc2SlhBnNixuaPJPwBXwuHGs6M192J5EPj9U8tI142AYa8EZ6JAkj5noJO8lrxM+GGxEHkZ0gj66KDJlJjSyqwm6PUdhppmYjp+w4Cq/dVOTAF8J5kRCbU5zuLaCdw43U1yevABd4Zrd22Z2/HUTi/Fwlq7c9jX8lzUyDyArF2EwM1FJRGboDGYxIxPTsXga06dWPmCA7FmgmNNysrapcImIS8ISgcdX9m46hfzpqOkxzJc3Zl2NxPDmPfMiITLSWAjn2olhqzpFKOlRl+H36w7I3gzw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MEhfMDgZjFoqA2bOETV6bCnVHxxKsIk982MnNYrPjlKmUqbhRQPKTkpC52Jds4OjHLfU2hSwNqCeTAniET+ifQeiagOeZb2FJhF/DNP0Au/asH/fIc3bI1v8/k1sVojspTS3CU+CmWMXOnL29P90fYl4HwkkJdT9/6BYvOy/I0UU7Xb62jDq79CfBEzB62zl7VcZyKCZsvjKOgRkZhZJyxwQdSUAIsHIvMVuX/N7LpMK3tQeNg+N2WaC1+UzUP0tyZ0PehE3nkfd5sHGkO8MPgBRGjHNktJVniDwjl7Xg4fPMFWSAC7KhpKhgJzdRypKO0FZh7U7amaxEyNUcQcKLjMJaluDDQAv6i+b03ZYtVnWxNmrVGYAicT7vCVabtRUWAF+yFtgsafbBYPstaHd56lKvix79YILrAb2PKp7TLP4tWqjQ5MT6iliCJIJa5x7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:44:03.3401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 159ce8ab-f19c-4ad3-d025-08de8e387f10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7597

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
 drivers/iommu/amd/amd_viommu.h | 10 ++++++-
 drivers/iommu/amd/iommufd.c    |  3 +++
 drivers/iommu/amd/viommu.c     | 48 ++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index e1387d9ea97d..93e44f8b6012 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -18,6 +18,9 @@ void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *vio
 
 int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
 				u16 hdom_id, u16 gdom_id);
+
+void amd_viommu_set_device_mapping(struct amd_iommu *iommu, u16 hDevId,
+				   u16 guestId, u16 gDevId);
 #else
 
 static inline int amd_viommu_init(struct amd_iommu *iommu)
@@ -25,7 +28,7 @@ static inline int amd_viommu_init(struct amd_iommu *iommu)
 	return 0;
 }
 
-u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid);
+static inline u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid);
 {
 	return 0;
 }
@@ -39,6 +42,11 @@ static inline void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iom
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
index a047bb45aa14..685748a71b22 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -133,6 +133,7 @@ static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
 	struct pci_dev *pdev = to_pci_dev(vdev->idev->dev);
 	struct iommufd_viommu *viommu = vdev->viommu;
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
 
 	if (!pdev) {
 		pr_err();
@@ -151,6 +152,8 @@ static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
 	pr_debug("%s: gid=%#x, hdev_id=%#x, gdev_id=%#x\n", __func__,
 			 dev_data->gid, pci_dev_id(pdev), dev_data->gDevId);
 
+	amd_viommu_set_device_mapping(iommu, pci_dev_id(pdev), dev_data->gid, dev_data->gDevId);
+
 	return 0;
 }
 
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 80873bd62c52..28fe92ad9771 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -40,6 +40,7 @@
 #define VIOMMU_DOMID_MAPPING_BASE	0x2000000000ULL
 #define VIOMMU_DOMID_MAPPING_ENTRY_SIZE	(1 << 19)
 
+#define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET	0x00
 #define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET	0x08
 
 LIST_HEAD(viommu_devid_map);
@@ -352,6 +353,49 @@ static void free_private_vm_region(struct amd_iommu *iommu, u64 **entry,
 	*entry = NULL;
 }
 
+/*
+ * Program the DevID via VFCTRL registers
+ * This function will be called during VM init via VFIO.
+ */
+void amd_viommu_set_device_mapping(struct amd_iommu *iommu, u16 hDevId,
+				   u16 guestId, u16 gDevId)
+{
+	u64 val, tmp1, tmp2;
+	u8 __iomem *vfctrl;
+
+	pr_debug("%s: iommu_devid=%#x, gid=%#x, hDevId=%#x, gDevId=%#x\n",
+		__func__, pci_dev_id(iommu->dev), guestId, hDevId, gDevId);
+
+	tmp1 = gDevId;
+	tmp1 = ((tmp1 & 0xFFFFULL) << 46);
+	tmp2 = hDevId;
+	tmp2 = ((tmp2 & 0xFFFFULL) << 14);
+	val = tmp1 | tmp2 | 0x8000000000000001ULL;
+	vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, guestId);
+	writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET);
+}
+
+/*
+ * Clear the DevID via VFCTRL registers
+ * This function will be called during VM destroy via VFIO.
+ */
+static void clear_device_mapping(struct amd_iommu *iommu, u16 guestId, u16 gDevId)
+{
+	u64 val, tmp1, tmp2;
+	u8 __iomem *vfctrl;
+
+	/*
+	 * Clear the DevID in VFCTRL registers
+	 */
+	tmp1 = gDevId;
+	tmp1 = ((tmp1 & 0xFFFFULL) << 46);
+	tmp2 = 0; /* hDevId */
+	tmp2 = ((tmp2 & 0xFFFFULL) << 14);
+	val = tmp1 | tmp2 | 0x8000000000000001ULL;
+	vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, guestId);
+	writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET);
+}
+
 static void viommu_clear_mapping(struct amd_iommu *iommu,
 				 struct amd_iommu_viommu *aviommu)
 {
@@ -366,6 +410,10 @@ static void viommu_clear_mapping(struct amd_iommu *iommu,
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

