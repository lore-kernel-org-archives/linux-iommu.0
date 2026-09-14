Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011030.outbound.protection.outlook.com [52.101.62.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55038399348
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411807; cv=fail; b=gG7ntwGmnLIgHJYA7UN/ppPofW3UUWWifBZqNZd7/7286fz9jh80kw9CT7gYD1heGbNY4Fqm3NbN97iOxjUNlBA6UdU4PY+CWpIjsRrXB1qcivpNo4e9WW+Dp62Vr3B7GlKnm+ryME3bUISQqH+Mui4dFzQH1B2ZVCzmOWm38mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411807; c=relaxed/simple;
	bh=w4fBCLy6HOcz8loU9QSBEAJ429e74kKShsfkt6Bbzjk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQTsvAkzRiniyJXu562snhATi9PDu8YvtWod1EdOrEYkR7zLg0pJ+JvoY/BZ7lznSjwChYQ5xAfPb6yGQWo7vKfzQ8WsgAK8LOPpnj7iy3XM4ZctlByqgHE3vC5If9VZkpXyIAeUYM1lP70ZsfSiv7PNMOd4opQ5XHNvDgc4aWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=crFOuTt0; arc=fail smtp.client-ip=52.101.62.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="crFOuTt0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuZgwaCCQ0dHJRcxkE44E7LhMoOIozU1XWlVU8I05xrdmWCgTGtIciWInCRjaD00jvt/eUA1mIleF1dDtF/v+tRzsJX7F4svXN+FxrdXvU0kqS9D/Ss6KJwf/rLHnQwE/T4RZw0+goS+HiZeWCHqJjNZSFz8V8wJA9wLh4GW7knfLD0BIomidh8MspT6i6oknrQTGG8qAxGI5RdYN6eVsBX+gZe1x4+bddhInE0JuEm+HzUBXOEZmmqtAJAz5ZDtefpg7N+OAchyb0XZUN5kpnrExwcH/+qcG4acJaLaA5xrCM8b8/hxTiSqx9fJHfurXXxqmHGcMCQ1O+6+ycrZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhmGqXLZsHfFLPv95rX0UuYHIFEOZ9jT1BBuCw33Ffs=;
 b=kUAwOtsCTEiDUU9/jiIsw3V97CcFg1Ver33efHrn4E/3nQysRh/iymnm7NMGgjPr+rv25BJgKR9AJb85NJsT1fLBDkyq7R4p1tcGXK6dLP2/iJ+7Rgxh5DwPqX1C0SZ/hv1PyxXwIgchgGQ7KwA8xiysPXffs50ln6zFCWFfBvrJ3NnYj6+qhcbyi4SjvuCai4ZXn0+U6+cudWl+FN0PmfW5ojeod6YtpH0Oa3y4WKpQA+cOIVKz4RJU/UCurCqaGg8P7P0dXllXnIsuCk0nyyu/745UkBb3NXwXeP8HDb9h0Osr+HfUlQ8GZbMId7o1msdcpHjnR7NAR3vbqA06lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhmGqXLZsHfFLPv95rX0UuYHIFEOZ9jT1BBuCw33Ffs=;
 b=crFOuTt0X1IaGSzt6mA1mCdp2VyX0ulkJJu38MjhmJ7pZQ9HNjZHKwzAsth1eMupkZxwFzbjqKZHg5cTso84UJxDU/nh6EQLzVTlPYzj6mItM/8GsXy+S2UnaPjWTfEXBKBPDQ6y85z14PqOE7JvZY8wf1pzz9qrWsrDth0CqkA=
Received: from CH0P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::31)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Mon, 14 Sep
 2026 18:49:54 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::12) by CH0P220CA0003.outlook.office365.com
 (2603:10b6:610:ef::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:49:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:49:53 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:49:47 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 16/24] iommu/amd: Add IOMMUFD vDevice and DevID mapping
Date: Mon, 14 Sep 2026 18:47:42 +0000
Message-ID: <20260914184750.222939-17-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: a04ad342-da87-4b93-4b24-08df1290f6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|1800799024|23010399003|82310400026|3023799007|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sMnLQKxuYbHj96671mLRWdeGEWsGOovfF/4j8y3VUeycHYygQVI2jAG2/mjLaj8EPe9DwSgXMYuq/00NOmhdqmG+xt1OwCRDqbSdfPz7lPd2MV3gzs/V5DACw3Br7jA8XmwCtRkJzGafUxQNhY0dBopo8KlzdUC9uYCjJ4uAKiVEL8VEJQ03MBiqyZT3iZpoy1VKz6ZsySnAxKhcpUK+A8Y40hD1FqRCdbB/slP97pFqIJeYlcxdI0kEtsHMHvqAh149uXUqJcaV2SYCoxX2I9vsf1BGaRsuckNfXIc0zXbOm709mNi+t6JnN0IKuMD2CM3LyaMxwaHMzZlMpWmPSuh9E6+qyZ3eTFFUjF5k6WrgInt7C0MXLOK3bYRK5wKOVHBnosi4xv7zxCF0pmVuVkR7M0T1Z/QgB56pollx/EQuiPCeSCrRE0KBpU1NSwNM2A2Fo9tn2FMCWCm1asAeqeLWA7qdbdnZKUdfc+kN2c2iBtimicJc6KFzw+8Ppzu2f38DLWJei1LRtCjwWJN3FqrtolsMOPcWWSkHKQq+Nv7ugwmqu2fFKpqjxuQUP51O8DZPGhUI5wcffNrSgTXErbxyiPTbOUy99w4ZRbvzsM7/rLMostdYqLpC2KGdvHkflXFX1mPYNkobScpUCzlBzM5HrPhmYG5yi67EwEjSKVzkfPuc0PRENGkE9fENAat+VlmuGz7r1wsZskKj49yBig==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(23010399003)(82310400026)(3023799007)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vgK1zmpvvXc5ePaejJxaRpV8Vv0IuUst/BeJUrqfe5Oth2qQva9xMw1LqraX5akNMLQyTeqkRyVX3viGh6spDYNXauvpTY8Kx8vejsM024KNKfsWq/5RLyYnTEk2YzFHvDoJ/3rXAKOizTmAPwyQajJ6zOonzVqnM5SzOK0r1Cdc83TyAOXiQ3kpDDbfDuCJfkBXiBxB2ibcVh4vE0Ja/4PtKGxV1BP/hQ8eTjzqTufX0hpLd0ex3s7njkbe+YIMy4DZANsY7yMI5f5SP369IFOuBWS5Spn0jOkb9ADwkEz1Cv0cR5zBulJm6Rt1HpmAJThivCXIjnA7fPC1IuIWXJunGf3AbRY+cwVKidpO47yFyd6jnfSncaDbpBcBw+1Z4grioZX+tfEXa12Fg/bjNE/0FfKwRVbql5YXtoJotQNWuohJBteY0YQvGndlG69t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:49:53.7074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a04ad342-da87-4b93-4b24-08df1290f6f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633

IOMMUFD vDevice allocation supplies the guest device ID (virt_id).
The AMD vIOMMU Device ID mapping table translates that gdev_id to the
host device ID for virtualised IOMMU commands.

Add vdevice_init, which validates a PCI device and virt_id, then
programs the mapping through VFCTRL via amd_viommu_set_device_mapping().
Get the host struct device via iommufd_vdevice_to_device(). Set
vdev->destroy to restore an idle mapping when the vDevice is removed
while the vIOMMU is still alive.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 12 +++++
 drivers/iommu/amd/amd_viommu.h      | 10 ++++
 drivers/iommu/amd/iommufd.c         | 52 ++++++++++++++++++++
 drivers/iommu/amd/viommu.c          | 73 ++++++++++++++++++++++++++++-
 4 files changed, 146 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index fc8e1378c7ed..07eaeeb72e38 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -547,6 +547,14 @@ struct amd_iommu_viommu {
 	u64 *devid_table;
 	u64 *domid_table;
 
+	/*
+	 * Serializes VFCTRL Guest DID map CONTROL0/CONTROL1 doorbells
+	 * (DevID and DomID table updates) for this gid. Those registers
+	 * are shared by every vDevice on this vIOMMU; igroup locks are
+	 * not. Do not nest with trans_devid_lock.
+	 */
+	struct mutex vfctrl_lock;
+
 	/* Offset for mmap() of guest VF MMIO; set after iommufd_viommu_alloc_mmap(). */
 	unsigned long vfmmio_mmap_offset;
 };
@@ -1113,6 +1121,10 @@ struct amd_irte_ops {
 	void (*clear_allocated)(struct irq_remap_table *, int);
 };
 
+struct amd_iommu_vdevice {
+	struct iommufd_vdevice core;
+};
+
 #ifdef CONFIG_IRQ_REMAP
 extern struct amd_irte_ops irte_32_ops;
 extern struct amd_irte_ops irte_128_ops;
diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index 580cad0f9f5a..1022ae20c170 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -8,6 +8,9 @@
 
 struct amd_iommu;
 
+/* 16-bit guest DevID index; not VIOMMU_MAX_GID. */
+#define VIOMMU_MAX_GDEVID	0xFFFF
+
 #if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
 
 int amd_viommu_init(struct amd_iommu *iommu);
@@ -20,6 +23,8 @@ int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu
 
 void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu);
 
+void amd_viommu_set_device_mapping(struct amd_iommu_viommu *aviommu,
+				   u16 hdev_id, u16 gdev_id);
 #else
 
 /*
@@ -41,6 +46,11 @@ static inline u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid)
 	return 0;
 }
 
+static inline void amd_viommu_set_device_mapping(struct amd_iommu_viommu *aviommu,
+						 u16 hdev_id, u16 gdev_id)
+{
+}
+
 #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
 
 #endif /* AMD_VIOMMU_H */
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 97de07d3ad10..5760b183ce62 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -70,6 +70,7 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	if (ret)
 		return ret;
 
+	mutex_init(&aviommu->vfctrl_lock);
 	xa_init_flags(&aviommu->gdomid_array, XA_FLAGS_ALLOC1);
 	aviommu->parent = pdom;
 
@@ -121,6 +122,7 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 err_mmap:
 	amd_iommu_gid_free(iommu, aviommu->gid);
 err_gid:
+	mutex_destroy(&aviommu->vfctrl_lock);
 	return ret;
 }
 
@@ -140,6 +142,54 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
 	amd_viommu_uninit_one(iommu, aviommu);
 	amd_iommu_gid_free(iommu, aviommu->gid);
+	mutex_destroy(&aviommu->vfctrl_lock);
+}
+
+/*
+ * Called from drivers/iommu/iommufd/viommu.c: iommufd_vdevice_abort()
+ *
+ * Restore an idle DevID map entry for this virt_id. Every DevID mapping
+ * table slot must have V=1 for both active and non-active devices. A
+ * non-valid entry raises INVALID_DEVICE_REQUEST when the IOMMU processes
+ * INVALIDATE_IOMMU_ALL. Use host device ID 0: that RID is the IOMMU PCI
+ * function and does not normally host an endpoint.
+ */
+static void _amd_viommu_vdevice_destroy(struct iommufd_vdevice *vdev)
+{
+	struct iommufd_viommu *viommu = vdev->viommu;
+	struct amd_iommu_viommu *aviommu =
+		container_of(viommu, struct amd_iommu_viommu, core);
+
+	amd_viommu_set_device_mapping(aviommu, 0, (u16)vdev->virt_id);
+}
+
+/*
+ * Called from drivers/iommu/iommufd/viommu.c: iommufd_vdevice_alloc_ioctl()
+ */
+static int _amd_viommu_vdevice_init(struct iommufd_vdevice *vdev)
+{
+	struct device *dev = iommufd_vdevice_to_device(vdev);
+	struct pci_dev *pdev;
+	struct iommufd_viommu *viommu = vdev->viommu;
+	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
+
+	if (!dev_is_pci(dev))
+		return -EINVAL;
+	pdev = to_pci_dev(dev);
+
+	if (vdev->virt_id > VIOMMU_MAX_GDEVID) {
+		pr_err("%s: Invalid virtual ID (virt_id=%#llx)\n", __func__, vdev->virt_id);
+		return -EINVAL;
+	}
+
+	pr_debug("%s: gid=%#x, hdev_id=%#x, gdev_id=%#llx\n", __func__,
+		 aviommu->gid, pci_dev_id(pdev), vdev->virt_id);
+
+	amd_viommu_set_device_mapping(aviommu, pci_dev_id(pdev),
+				      (u16)vdev->virt_id);
+	vdev->destroy = _amd_viommu_vdevice_destroy;
+
+	return 0;
 }
 
 /*
@@ -149,4 +199,6 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 static const struct iommufd_viommu_ops amd_viommu_ops = {
 	.alloc_domain_nested = amd_iommu_alloc_domain_nested,
 	.destroy = amd_iommufd_viommu_destroy,
+	.vdevice_size = VDEVICE_STRUCT_SIZE(struct amd_iommu_vdevice, core),
+	.vdevice_init = _amd_viommu_vdevice_init,
 };
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 06a21f14b2a5..556864eaaa0d 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -6,6 +6,7 @@
 #define pr_fmt(fmt)     "AMD-Vi: " fmt
 #define dev_fmt(fmt)    pr_fmt(fmt)
 
+#include <linux/delay.h>
 #include <linux/iommu.h>
 #include <linux/iommufd.h>
 #include <uapi/linux/iommufd.h>
@@ -29,7 +30,6 @@
  * VIOMMU_MAX_GDEVID / VIOMMU_MAX_GDOMID are 16-bit guest DevID
  * and DomID table indices (hardware mapping-table width), not GID.
  */
-#define VIOMMU_MAX_GDEVID		0xFFFF
 #define VIOMMU_DEVID_MAPPING_BASE	0x1000000000ULL
 #define VIOMMU_DEVID_MAPPING_ENTRY_SIZE	(1 << 20)
 
@@ -45,6 +45,8 @@ static_assert(VIOMMU_DEVID_MAPPING_ENTRY_SIZE >=
 static_assert(VIOMMU_DOMID_MAPPING_ENTRY_SIZE >=
 	      (VIOMMU_MAX_GDOMID + 1ULL) * sizeof(u64));
 
+#define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET	0x00
+
 static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
 {
 	if (iommu->vfctrl_base) {
@@ -439,6 +441,75 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
 	*entry = NULL;
 }
 
+#define DEVID_ENTRY_GDEVID_MASK		GENMASK_ULL(61, 46)
+#define DEVID_ENTRY_HDEVID_MASK		GENMASK_ULL(29, 14)
+#define DEVID_ENTRY_WRITE		BIT_ULL(63)
+#define DEVID_ENTRY_VALID		BIT_ULL(0)
+
+/*
+ * CONTROL0/CONTROL1 bit 63 (WRITE) is a doorbell: hardware copies one
+ * entry into the IPA-backed table and clears WRITE when that DMA write
+ * retires. This is not a command-buffer operation;
+ * iommu_completion_wait() does not drain it. A readq() of CONTROL_EN
+ * is also unrelated. Poll WRITE=0 before ringing a new doorbell and
+ * after each write so the table update is retired before the caller
+ * proceeds (DTE commit, unmap/free).
+ */
+static void vfctrl_wait_write_clear(struct amd_iommu *iommu, u16 gid,
+				    unsigned int offset)
+{
+	u8 __iomem *reg = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid) + offset;
+	int i;
+
+	for (i = 0; i < LOOP_TIMEOUT; i++) {
+		if (!(readq(reg) & DEVID_ENTRY_WRITE))
+			return;
+		udelay(1);
+	}
+	pr_err("%s: WRITE timeout gid=%#x offset=%#x val=%#llx\n",
+	       __func__, gid, offset, readq(reg));
+}
+
+/*
+ * Guest DevID table update via VFCTRL CONTROL0.
+ */
+static void set_device_mapping_unlocked(struct amd_iommu *iommu, u16 gid,
+					u16 hdev_id, u16 gdev_id)
+{
+	u64 val;
+	u8 __iomem *vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid);
+
+	val = FIELD_PREP(DEVID_ENTRY_GDEVID_MASK, gdev_id) |
+	      FIELD_PREP(DEVID_ENTRY_HDEVID_MASK, hdev_id) |
+	      DEVID_ENTRY_WRITE | DEVID_ENTRY_VALID;
+
+	vfctrl_wait_write_clear(iommu, gid,
+			VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET);
+	writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET);
+	vfctrl_wait_write_clear(iommu, gid,
+			VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL0_OFFSET);
+}
+
+/*
+ * Program the DevID via VFCTRL CONTROL0. Waits for WRITE to clear so
+ * the IPA table DMA has retired before return. Serialized by
+ * aviommu->vfctrl_lock: CONTROL0 is shared by all vDevices on this gid.
+ */
+void amd_viommu_set_device_mapping(struct amd_iommu_viommu *aviommu,
+				   u16 hdev_id, u16 gdev_id)
+{
+	struct amd_iommu *iommu =
+		container_of(aviommu->core.iommu_dev, struct amd_iommu, iommu);
+
+	pr_debug("%s: iommu_devid=%#x, gid=%#x, hdev_id=%#x, gdev_id=%#x\n",
+		 __func__, pci_dev_id(iommu->dev), aviommu->gid, hdev_id,
+		 gdev_id);
+
+	mutex_lock(&aviommu->vfctrl_lock);
+	set_device_mapping_unlocked(iommu, aviommu->gid, hdev_id, gdev_id);
+	mutex_unlock(&aviommu->vfctrl_lock);
+}
+
 void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *aviommu)
 {
 	pr_debug("%s: gid=%u\n", __func__, aviommu->gid);
-- 
2.34.1

