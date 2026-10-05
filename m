Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9922E3672B0
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 06:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182520; cv=fail; b=Aa+5ym3/RvbGfgIsgrnhKsJ1UXcDg1I0yFIcs2kqFzd3ml/fqES0m41RqDX0pWM9sEM0fiVm7pihoc3f5SvklS/We8R0Y7D3rxO6+JGj7f1swy7JgRf78/DwuhkcIewFvXgKsTO/wErqmzr9adcMPvzKVkxxyqdGSvzG7iDu1ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182520; c=relaxed/simple;
	bh=cDFr5ulJeorA0c+2w6nb7aLnKUHXGW7pGnGGrpfDvJY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZgp2pG5BQ0xzC0IEzRur6qyxaB0ZUaE+VDapKehS8RR53RE92ZkV4qQTycigeTJGdUs1Q7tORyPkihmw1xEqvCpsRe3pAhyZLJftdeuEcx9stfbYEEKoNF/vFRGtYHO6DCpFpDdINV7cr4lzLHsgzla0Q0KAzY386je6HU7x3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vcB7wK6A; arc=fail smtp.client-ip=40.93.195.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vcB7wK6A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/3fTvv2U/VQxLdUdEn1p3wqXedYWDlaCnarvWxSkQHSLrG66OhAP5Wyf85vhfnEBJZzVQziRt8JQ+wquFgZpBruR0D0UK6zMguYINba4NCcwLu6PRIlnzWFZSSKmL0IUq3SEWD7s+JwTFX7Kpb2uFLvhwFi0YP30RqIWv8c5yWuZC4wk6UvDr+VH6SVct+0yqH/mbyny/uWxbWEp+D9cGXPKCBvClHhJ+01O3agwZnayxXZpr60sbRZkOXM7EGlibs6bmy244z1NMq1QcF2G5doXKjHmeRzDM97+2+1UtA+C8DFfLsD+2El5jmWZo+JX5iZktyOdYq9X5vWMousBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mA2YmBigx3vseu3UCbTYobXKNye8/2XxuVoEM4j/9BI=;
 b=PsZwd369pBItrqbgMvapXtNkPjRTNETn6w/XxsqaDlstcBQwk1niiFpFxC0kCbEfpisGZRIIqMc0uEVe7vjEGKC0V/MCxi6kp/pD1jcgBC6Ua3EZyqM6uvNatexgy6UAP1jVJVpSjcmNb3eiOE7fxYAgPxxai1u7k0CGd1xW/EDlvG9KWAnM1qhiazGFcDbLqKLnZ+lVgpdXCl/odzWz8b4AOai44rP73Wylz+N1RY/i+BlSBJcKI0Wh/tjGTUMo+QvzG9B5lT1j52kRjqbJU1Ny0jB0c4mMXauf4uz6959UP8SRP7Vow1r7quhUwQ7A5DFNgIriY93BNILlQaFTww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA2YmBigx3vseu3UCbTYobXKNye8/2XxuVoEM4j/9BI=;
 b=vcB7wK6AW29MZsOyZzQLXtB6aeMPdZebciJL4p9pViGPyyfbz9SL9mdsifjwP4HWSqDTls/aP/F5WtZSc4S88uMh1lE03ZxWMSuVgz7Ed3BT3vMYaU+IOZsTsqx/Krq+q0E2BGa7eXUp+zst3UG6a99Lh6Q9GwDcv9ek0Ff9pDc=
Received: from SJ0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:a03:33e::26)
 by SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 5 Oct
 2026 06:41:48 +0000
Received: from CO1PEPF00012E5F.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::19) by SJ0PR03CA0051.outlook.office365.com
 (2603:10b6:a03:33e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 06:41:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E5F.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 06:41:48 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 01:41:40 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <will@kernel.org>,
	<jgg@nvidia.com>
CC: <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
	<robin.murphy@arm.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, <pasha.tatashin@soleen.com>,
	<rppt@kernel.org>, <pratyush@kernel.org>, <skhawaja@google.com>,
	<praan@google.com>, <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
	<kevin.tian@intel.com>, <dmatlack@google.com>, <vipinsh@google.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 3/7] iommu/kho/abi: add AMD IOMMU live-update serialisation structs
Date: Mon, 5 Oct 2026 06:40:13 +0000
Message-ID: <20261005064018.1558-4-Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005064018.1558-1-Ankit.Soni@amd.com>
References: <20261005064018.1558-1-Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E5F:EE_|SA1PR12MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: fd0f74c3-012b-4449-e5dc-08df22abbb20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700016|23010399003|22082099003|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	kkx7bzxffQrtHqivLBHJ1rtmxCR6o/rM5QD44HFdznKHaTvKzVx/pHtQcyGe013RycIJbJS2dP9rbaN7Jsq4Q043KNhSX/682c9vl1M9NKAnWip3/SdrUCtR5aPZqsyAq5ehJWkbuLhw1B2eV4kzOyhAlHiXrL+9QS+eQJ5/oPpQdLraeKuMqOwPU9lpINxi0vH8oaFB8wkfTHgTNS91mKZLnTVnDctBSz7/DPS6tQB81dpkYaseWvMRbQFR/YwY1OeIp82s1VXqrfrqUJfkPLQNacehxVZbnR3KYty2rY8OOFYccwWvR6v7KuF4L5aYPirOfRs83jVPcqbQZpxtGcRheLefUZiJaysUfd6LTJsmJe/4dFQL2YDUO/SJgF+DNCTf4cqxFjSolkN6YmsC+GDR7kshp2yrIzGIPKlK7vuK25kkmrwCjmo+sKoF7KYajGq4rHTMAL7El7oQCWT2TqIn63mUP59HW734y7SMVNu76nAJ7vfhOYeccXqtaYMO++FV9R9PUx6/rrVp4P2ucCZRm1hBmT9Y5cL/nIjcxqLGQxhY7g3BZ4+dVpSDyPaNDBUXjnaHlGzDl/juVYvEXxDj4UfTX4C0BdULyMau9Vkc+BSoHEqWtKMAAewHgJE6TYerlO1J9u0T+sl1p4v4WWkSjD3xJoN7YE4FIQaAq7z99/6bPbJC9+g6Rc4fcjkRPP3hfkVBmlEI7svBCX2sTA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(22082099003)(10067099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IljHdb6fZgSKeoZiICekzwCgD7sTb44XYuXZmUm0B0eJbJTcNT4MlVgMmUkxlfnIRYbx7INS8Vq3NwNtD5InDvgwWAT0JPo0recBQc8rWoZL8lR4V9b1KUonKWutUiStaSu4b8A+dWwkU9KYw5ixYX9bL7g60fqQ1fdAZqdHEvqOhLsBhF6HA3vF0EUTVH9W4CNS/QmVnqSGLzvkxDBua+XnDFSnWUDwYejyekB3GbxNw4tcSSLCygL2ftyUZBU/UEQAmfjgCXjILVGaa9UfsFRdCQPs0xLseHTt1XXnqhUV/R50HDbgq6TmueWELBxV9urSaWi6xykdCP+z7Q5rIdDRq3Kr477YzisDQWOMHEVUcidojVk5NVCDXQvTD//3CUuDoXaNkhTzUt4gEuTrU9QD/TyS2wBQiuaOFLvPUPG2NBzeLGNMiDLB0O7zqwSQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 06:41:48.2803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd0f74c3-012b-4449-e5dc-08df22abbb20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845

Describe the AMD IOMMU state that has to cross a live-update kexec: the
device table of a PCI segment, and the domain ID, page-table mode and
GCR3 tree of a preserved device.

Both structs fit inside the existing unions, so the layout and the
version are unchanged. Assert that, since growing either arm past the
Intel one would move the array stride.

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 include/linux/kho/abi/iommu.h | 70 +++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
index 308cd83fd3e3..5cbc8b3589ed 100644
--- a/include/linux/kho/abi/iommu.h
+++ b/include/linux/kho/abi/iommu.h
@@ -8,6 +8,7 @@
 #ifndef _LINUX_KHO_ABI_IOMMU_H
 #define _LINUX_KHO_ABI_IOMMU_H
 
+#include <linux/bug.h>
 #include <linux/mutex_types.h>
 #include <linux/compiler.h>
 #include <linux/types.h>
@@ -75,6 +76,7 @@
 /**
  * enum iommu_type_ser - Type of the IOMMU being preserved
  * @IOMMU_INVALID: Invalid type of IOMMU
+ * @IOMMU_AMD: AMD-Vi, whose per-instance state is struct iommu_amd_ser
  *
  * IOMMU type is stored in the IOMMU HW state to differentiate between various
  * IOMMU HWs.
@@ -82,6 +84,7 @@
 enum iommu_type_ser {
 	IOMMU_INVALID,
 	IOMMU_INTEL,
+	IOMMU_AMD,
 };
 
 #define IOMMU_SER_FLAG_DELETED	(1 << 0)
@@ -142,6 +145,29 @@ struct iommu_device_intel_ser {
 	u64 max_pasid;
 } __packed;
 
+/*
+ * Page-table mode of the domain a preserved AMD device was attached to. These
+ * are wire values with their own numbering rather than the kernel's
+ * enum protection_domain_mode, so reordering that enum cannot silently change
+ * the handoff format.
+ */
+#define IOMMU_AMD_SER_PD_MODE_NONE	0
+#define IOMMU_AMD_SER_PD_MODE_V1	1
+#define IOMMU_AMD_SER_PD_MODE_V2	2
+
+/**
+ * struct iommu_device_amd_ser - AMD specific state of serialized device
+ * @gcr3_tbl_phys: Physical address of the device's GCR3 table root, or 0 if
+ *		  the device has no PASID/GCR3 table.
+ * @gcr3_glx: Number of GCR3 table levels (0, 1, or 2; see amd_iommu_max_glx_val)
+ * @pd_mode: Page-table format of the domain, one of IOMMU_AMD_SER_PD_MODE_*
+ */
+struct iommu_device_amd_ser {
+	u64 gcr3_tbl_phys;
+	u32 gcr3_glx;
+	u32 pd_mode;
+} __packed;
+
 /**
  * struct iommu_device_ser - Serialized state of a device
  * @hdr: Common object header
@@ -150,6 +176,8 @@ struct iommu_device_intel_ser {
  * @dma_owner_token: Token to identify the DMA owner of this device
  * @domain_iommu_ser: Domain and IOMMU mapping
  * @intel: Intel specific serialization data
+ * @amd: AMD-Vi per-device state, valid when the owning IOMMU record is
+ *	 of type IOMMU_AMD
  */
 struct iommu_device_ser {
 	struct iommu_hdr_ser hdr;
@@ -159,9 +187,18 @@ struct iommu_device_ser {
 	struct iommu_dev_map_ser domain_iommu_ser;
 	union {
 		struct iommu_device_intel_ser intel;
+		struct iommu_device_amd_ser amd;
 	};
 } __packed;
 
+/*
+ * The Intel arm is the larger one and so sets the size of the union, and with
+ * it the stride of the device array. Growing either arm changes that stride and
+ * needs a version bump.
+ */
+static_assert(sizeof(struct iommu_device_amd_ser) == 16);
+static_assert(sizeof(struct iommu_device_intel_ser) == 24);
+
 /* There are maximum 256 buses, so maximum 512 context tables */
 #define VTD_PRESERVED_BITMAP_LONGS  DIV_ROUND_UP(512, BITS_PER_LONG_LONG)
 
@@ -181,12 +218,36 @@ struct iommu_intel_ser {
 	u64 context_tables_bitmap[VTD_PRESERVED_BITMAP_LONGS];
 };
 
+/**
+ * struct iommu_amd_ser - Serialized state of an AMD IOMMU instance
+ * @restored: Whether IOMMU state is restored. Guards against double-restore.
+ * @mmio_phys: Physical address of the IOMMU MMIO register base.
+ * @dev_table_phys: Physical address of this IOMMU's PCI-segment device
+ *		   table (struct amd_iommu_pci_seg.dev_table).
+ * @dev_table_size: Size of the device table, in bytes.
+ * @pci_seg_id: PCI segment ID that owns the device table.
+ * @efr: Extended Feature Register bits (struct amd_iommu.features).
+ *      Compared on restore; a mismatch is fatal.
+ * @efr2: Extended Feature Register 2 bits (struct amd_iommu.features2).
+ */
+struct iommu_amd_ser {
+	u8 restored;
+	u8 padding[7];
+	u64 mmio_phys;
+	u64 dev_table_phys;
+	u32 dev_table_size;
+	u32 pci_seg_id;
+	u64 efr;
+	u64 efr2;
+} __packed;
+
 /**
  * struct iommu_hw_ser - Serialized state of an IOMMU instance
  * @hdr: Common object header
  * @token: Unique token for the IOMMU
  * @type: IOMMU type serialized state belongs to
  * @intel: Intel specific serialization data
+ * @amd: AMD specific serialization data
  */
 struct iommu_hw_ser {
 	struct iommu_hdr_ser hdr;
@@ -194,9 +255,18 @@ struct iommu_hw_ser {
 	u64 type;
 	union {
 		struct iommu_intel_ser intel;
+		struct iommu_amd_ser amd;
 	};
 } __packed;
 
+/*
+ * The Intel arm is the larger one and so sets the size of the union, and with
+ * it the stride of the IOMMU array. Growing either arm changes that stride and
+ * needs a version bump.
+ */
+static_assert(sizeof(struct iommu_amd_ser) == 48);
+static_assert(sizeof(struct iommu_intel_ser) == 88);
+
 /**
  * struct iommu_array_hdr_ser - Header for an array of serialized objects
  * @next_array_phys: Physical address of the next array of objects
-- 
2.43.0

