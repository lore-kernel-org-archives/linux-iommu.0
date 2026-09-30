Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3DE47C11C
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760356; cv=fail; b=Ffe9pLBMfk34ncb4aObgZhRR4P8DGxmi38Ly2gLz8+wz5dSVtsahCPTYBjHl2xcRV3ssjd+slJaR8FoW/gjLqWFzC1qPnySu5l+on0HfjNBHCdQAoRprlfUjwb1QXZRqS6Ibbj+s2J9kMCHpwCwlJHMiujcJgGUiSycG0bP6yAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760356; c=relaxed/simple;
	bh=p7M0LuNsrFsb7OhwZjHOOpXtYaj/e24jP9mO6Jqc6z8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2ZqEVmd047BWg4WWvbGr8xkIYq9IOxiQs37XfxVCIzF6dKsRrOP1UXnZa7a8G1a5FTtPWCmYYjqzBMxATvuWP8tMfxHChMMs0z9I0bpTSHsNuPhQ+U+M8DNUB4Bl4veYhj11B5bM/vfyTp69YE/kJY5dtkXLJ/dBN9fdKDaVzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SIP1Or8C; arc=fail smtp.client-ip=52.101.53.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SIP1Or8C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckpBHZHl0r+Z402hiYeb3hGM3ahZmJZEUKyzCtLdtmDFb219sFB5e6Ocq5LLVG8Pbo4YbGMkbk6IFpZotyFxXSho9a6Bpd+1MiBsaMnZtBdGBlhoHHq6RHHq5btJAlCv+P0qGZP2H6Iqa6PEXFaEJuRV4+WHJzUTg4CKIuNbgwNM36l335teGCEJqJmZ1sBqKrCd5LpE13IgNjEFJVFLDtRgExqNwegyazkYQPK5ZDjyFD3gHY2ptWQnKMBGvubUbKdDrGvolDRFLoliLpQkhuJJTcLaIz8KTrylU27GzKdTnYj43frlyPEHgovstOFWWKrRQ8XfxsNbGcIYRS9DZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aMGTS8CCBYNwgjty8Y4gwyBsaNEVdLk+XONMrGJ2/4=;
 b=HnSVm/EDjyCAp7wvyJnNxUTknRVhZa/OXONCam6qPQjfok2zeGQGqHexdi7FQqJQ1tKaE3UCHCimmyNEL9vGH8MEcn1ch34/ggX7VSj/HxO3mE4TxdFLMJSTLTNo6ZukLC4Uozcjkv5xjwugHsQT084fjgRkmqmtZZmlTnVF4GhRYGDRcuCuQI0lMce60CcwfLbPTGldG8lCRZi3vpwK/dfE5rQULwk5u/3SnHaGcIamdNzVDHx64gwh3CkIsbIeQYDooIIUa0vuo+QIjIe0/TOuvz//1786Jdvvkya08TbAvsq7REnZURJ+5o5i9yjsk1dWL2kAQj60fgGje3A/zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aMGTS8CCBYNwgjty8Y4gwyBsaNEVdLk+XONMrGJ2/4=;
 b=SIP1Or8CdtPvI+mVRbe0CaeEfn2FI1yVkoYCtQQmf3O9YzBcbkfakV2R5cQSa6ux34w4BWDofhlmruy88ELQAzHTP1XJoy9Ufay3755G4ti63lN1W3b7NqmwU3G0WVq0F3Xu/5ZiYLz+QwC/3yWboo/mFYy9GYTyMRXXCj9+pWw=
Received: from CY8P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:930:6b::28)
 by DS4PR12MB9818.namprd12.prod.outlook.com (2603:10b6:8:2a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 09:25:48 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:930:6b:cafe::1c) by CY8P222CA0001.outlook.office365.com
 (2603:10b6:930:6b::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 09:25:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:25:47 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:25:35 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <chrisl@kernel.org>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 16/24] iommu/amd: Add IOMMUFD vDevice and DevID mapping
Date: Wed, 30 Sep 2026 09:23:36 +0000
Message-ID: <20260930092344.5616-17-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DS4PR12MB9818:EE_
X-MS-Office365-Filtering-Correlation-Id: 94dd72cf-f8ea-4108-8ccb-08df1ed4cfc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|1800799024|36860700016|7416014|376014|3023799007|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3PGsH0gg8wuUud2MrIpR0q2kVcV8btGRtGlsRMuwKE0f9MPO7kdZenC8eiQ7/L8MvbOQ/EfVi4iecZWd1NyTBYljoHwNzj7/CDJzSYiZCQqyS8uBP2JvPiWHp/XnNkTrauXFGsVu1ogdD9smxBJQcQ8z3TGQTJdefnI2XvgRlHDOTAc4F7/1QfciQsczA9YHvVWlztioIYtDkQ3Iol/0AzbGAtXqUrrN4KpdFnVfOFSeibmmt4triJtecm3hgORk9w1kUUbimRdGIbcMJH/m+NxCDx5/0cXeChGYnBT5XLBJRjbMc66Q3pu78UQzHQq78w3il9J191Y3enpLfRqyjIsOQuNax0zQzRc7wlyZPGex4CydHlYmQ4SermOfFFNtaG1zI8dHsH6cuQpioLsJprYXp8oxZP02hrBGZoeqF0EB02VSuJJFziPjmCMVYrXtsomzReFvYR7v6ivwNdbiVb14ntJjeRudPKn/XSyybnsgC468DQ721q8kEojn+IQP4uaEdNDhYxJLjB47umNQgZF/fZi79BG8FPRnjYX1FbU4O9eRCEM9LK0+YiybstCRVta3UITo/9gdELF6v1GTA5ZyPoGZWUa4806FPWJXXCHCkOUtfNb8iaYGAtUp8GQvJ8ABHtkwtY6eq0T9vbGzhlAXsJSRz5hUZNiBRa/g+DnPAnVpUyUacVnCfJf4KIsXe5WV5v93IWxxRlIJv7ct7Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(7416014)(376014)(3023799007)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KaE42j1S4Fw1AV5nHyJtoPyaxFynYud6nmP3fP7dNZQW86RtZ50W418nWxMx4OEgAodBokRBD6TWvWnAZ+TVgP2JdmeyGlZSD/b9TOw7TjX+6uZx7kML2Z5iPcGEG8MKlvsecC69OoPSadHQxMhOCGKLYwRKK5W2BHO6a9dGphY+JZOKSy2IEieiqV/gc1JV88OGj10v5JVohKNRuSwCe7SZBZKFLJDqwukeCmuj5BVWLYQkpm6WLEfgRCH8AaMNieZj6t381uS/AyU4fe2GVeHTcJrbCI8NpWx5mJCp0cW6bGFYzRJiXaGHAiYjEtyuipeQ8aZ8ifSqtLdSLoXfDoJU0OK2g35G0m3ZogmbOO6CuhSIHY1ulrIL7c4Ecmi8Bw4ggRFw5LN1mlgscd8nZyq3/BXS42pLFMIfHbr0ie/Vhngrm5pQejMqaP7ikeo8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:25:47.7420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94dd72cf-f8ea-4108-8ccb-08df1ed4cfc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9818

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
 drivers/iommu/amd/iommufd.c         | 52 +++++++++++++++++++
 drivers/iommu/amd/viommu.c          | 79 ++++++++++++++++++++++++++++-
 4 files changed, 152 insertions(+), 1 deletion(-)

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
index b160c70f3804..e263d63afe3d 100644
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
@@ -448,6 +450,81 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
 	*entry = NULL;
 }
 
+#define DEVID_ENTRY_GDEVID_MASK		GENMASK_ULL(61, 46)
+#define DEVID_ENTRY_QUEUEID_MASK	GENMASK_ULL(45, 30)
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
+ *
+ * TODO: The driver does not support QueueID yet,
+ *       so current callers pass 0. This will be
+ *       enhanced in the future.
+ */
+static void set_device_mapping_unlocked(struct amd_iommu *iommu, u16 gid,
+					u16 hdev_id, u16 gdev_id, u16 queue_id)
+{
+	u64 val;
+	u8 __iomem *vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid);
+
+	val = FIELD_PREP(DEVID_ENTRY_GDEVID_MASK, gdev_id) |
+	      FIELD_PREP(DEVID_ENTRY_QUEUEID_MASK, queue_id) |
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
+	set_device_mapping_unlocked(iommu, aviommu->gid, hdev_id, gdev_id, 0);
+	mutex_unlock(&aviommu->vfctrl_lock);
+}
+
 void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *aviommu)
 {
 	pr_debug("%s: gid=%u\n", __func__, aviommu->gid);
-- 
2.34.1

