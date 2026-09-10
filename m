Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC393A0E8E;
	Thu, 10 Sep 2026 03:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011271; cv=fail; b=b0pjb4k79792xz2RD9eeKqTqWAxO/4lflldFpoU6kj6UdN7fQrX68rodLei7S01joueazEoZyY8pxVf6NPima2fJWwQ4cbpkUDWq586fSa8OEsY4jnbAoyPo31QF+qkXCNjp0eASIQjnX8FaRQXczPUb0iNtGmmMlN+Jq+xp8eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011271; c=relaxed/simple;
	bh=nmpPLepvqfyD3x/9yBa7S1QHwUb5IveWlo7/GVfuLuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SzQ+x5phoXXzsQalTYW9KYljm/ps8HXtFE62iVYZ3EprkzpF0fz0ZzFePJnvXETOEZY2/V/dvg45gV2qcb7AXVfyMjjdHkaQ/hegJpypeyULWwG2a3YHDp6KXqQ6eyLKpwkwVlXkvxIM1XUbg8jV+3+ZXG/uh2yHGfU9IigbBgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ids9shPa; arc=fail smtp.client-ip=40.93.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ids9shPa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1jR7LE0CTApO7N28tTpr7+3tr761XamVDgqHylmPo5qFDOxJBCxVPDgDXkiCZGufQhsPRgayUSCeky99addD8h1g0gQ2ZivCkL8EbSpB+7ykCTCkGVk4E71aaqEljNrG/2vUqzcTdggolVXloCesulaIq6t70AJZ0r2PrWeVh0ig3hmcnEjpG7bDqWkRukC/sqVW8+OHItyOL6/kMllOzravC0revcXU3CoWEcht0s+k1qBkl22PO1d0emoEbJ1CQjsBTuz8t57xT+G/CELVcDsv455PAXoJ4jROAurNh0W5IPW5BcWko3HMFczebJ6f2PAmYCBqWmkRV1YWc4PPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mP3wOfzqpEf8iRTqZ3mT+eF2s4gZ475jaPm0o9mXzg8=;
 b=thhh4WPk/whdebf3hCBuzunPJTWBBsIP3dnS47IpGxm7DFOV56rBnBDcU3cknFhyE5zSLuLDEHMEuV1P9LN45X1rxEk7gPoIWkV/eRRejKHvdGJ0USPFHDcADzUn5EbzdUnMRdGaKgt29YfCWEhPqCiPcRzOFY3DnUzdrV93W7P0vvOSnKBRFF+wYK92kiDp6fjZlDNulv5bKvC2A4b2qrN1UhCyr9YJfQ+ZYyyOJ4Acbw4rDQUTEI2m37C2u2XV2CJ8XuVDE6zqjsramFj0Dx5mqM3m1vEwNIdCdj1bQXKtnvH2dMdBtqhshSWsLv/tTLziq+liTOujZ5y50poEyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mP3wOfzqpEf8iRTqZ3mT+eF2s4gZ475jaPm0o9mXzg8=;
 b=Ids9shPayTvg3qu/a5Mnh/YNnTjCenFqTe88/igLjS3eb09jAB7jz7gHZHYkn/BM1tBmzMsgSb663mcZoTR8XSn1AZVDVxckTJfxWI70FTciTTBAJiv9fpzxCYlgzsJCkcFcQq2qrO7CkzzMyPYk9WR6NuW9F15FBG3K/IiCisTvdvxcx+pfDryXFDxLNNgciYKfIfZLuyc/squbiqRGCr5h01Gw7Yq8oj3oxSB0lXsjC6oJy9AfEZUpfr7griy852qJ7ZifdH2G3nt6xDw+VUYubkn+eY/zPKPZ+J22yXPB70BcxDX6sD0/F+kzAUmPvh2/5Ayzw3v8wkdpWhUQ/Q==
Received: from DS2PEPF0000455D.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::515) by CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 03:34:15 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:92f::1006:0:b) by DS2PEPF0000455D.outlook.office365.com
 (2603:10b6:f:fc00::515) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Thu,
 10 Sep 2026 03:34:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 03:34:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 20:34:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 20:34:03 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 20:34:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
	<aneesh.kumar@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Gavin Shan <gshan@redhat.com>, Vikram Sethi <vsethi@nvidia.com>, "Anshuman
 Khandual" <anshuman.khandual@arm.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, Mostafa Saleh <smostafa@google.com>,
	<rppt@kernel.org>, Thomas Huth <thuth@redhat.com>, Marc Zyngier
	<maz@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, <kas@kernel.org>,
	Kohei Enju <enju.kohei@fujitsu.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, Ard Biesheuvel <ardb@kernel.org>, James Morse
	<james.morse@arm.com>, Steven Price <steven.price@arm.com>, Sang-Heon Jeon
	<ekffu200098@gmail.com>, Omar Sandoval <osandov@fb.com>, Andrew Morton
	<akpm@linux-foundation.org>, Jinjie Ruan <ruanjinjie@huawei.com>, Sam Edwards
	<cfsworks@gmail.com>, Douglas Anderson <dianders@chromium.org>, "Florian
 Fainelli" <florian.fainelli@broadcom.com>, Chen-Yu Tsai <wenst@chromium.org>,
	Huacai Chen <chenhuacai@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
	Pranjal Shrivastava <praan@google.com>, Ashish Mhetre <amhetre@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <driver-core@lists.linux.dev>, Sonang Patel
	<sonangp@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>
Subject: [PATCH v1 3/8] dma-mapping: Let a device declare that it reaches private memory
Date: Wed, 9 Sep 2026 20:32:46 -0700
Message-ID: <2190d81f2451668fa09d5f83e43e25540907daf1.1789010941.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789010941.git.nicolinc@nvidia.com>
References: <cover.1789010941.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2511aa-7a82-425b-703f-08df0eec6385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|7416014|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	A191XTttZT1/w9yKIV6bkxBpFr98Z2fyfcd/gsU1RcU8a3nF7Dv6sH0EF7QASFhW1hSRf1vY/3RuX1FmUeH1bRuKaL+7UZV3Jpc9zCBZAPvtkzsXoagCOAu5JGzhg2xst+N3idiZ1jtxvBqQjtjLQ209M4Jm0tpTHJKWCXtImzVZbHMDObKcTsbCKLL5vpl+K9eEWXwCMuKSZojR4vyIz3yUmysRETR8snP6r5BKV1afQQhk4La9n3j62AMG7B4xnsr32RQPUdMWjTenWDvIL//YgV+jKqlRzFiocPVkPeq6nU2xXnp4A3vON1N5rRdZFeqzLj1SXSEQ+UBWzfINQplpQCbGapTW6eDtsoVKuFZS3eAOiiJbB2k7bxoBoemSFK3shrsNExgNmYYELCNXqR4kZhHKt++L3SpBf7RE7kc7UnT+pV/4itDg7vqborj/pgkjmbzzGYVuXLc/zWnB3Cvl7WggXcERoqRMpsPoI8LSPE0UcAa/R+jhg0SFDfaa2xk0W6kaGr2pW8OvL5xastE0bNx11/YS+TmB3drAoT3j/dIaRcKz0fy27i2lB4RCNuSTgsURFJ9iDwrks+0pNXa3K2pOWWl0WhZru1DgRjzpxhdCI8lHTAIkK4s4VHKYGFRdK+TB7EgMXNBugocZuMGsaIRULsE9sczyDR6yLHNyyKK+1mJe84Vkr3eOamwhayDt/yY6a09mNVHtrpxgYw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(7416014)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LPqY1Lp9f1TZ2DSveYPEV2mWGaxY0aI++Pr0TpMVq0vfRIrfJxWREcnjm8QutmXgi5pgyWxBxl7+Nr6xp62EJo6iCTI78lavUZltRKoAT3TwYw7ONav1OInPUSeazunh/yTpV7cXT1i3zlV8JnnfKHZK7YnkTXI+rTwpmLQF05eBlxqNfdkB91mGpUVSukpHpQxkvMv2PxCIdoxqpPz/bM+n7yrLbba6vNoQSOUgwBkXpGh71kZfO/OSq/VQVJW9ag+Aqyaf0ww1VnL5NDqjAkfd+j/HZSwfFaEm8ADHRCtb1v777yQCJrLjke+02vwClcunphm5MfK+8k3makKhwaYphzRqC7ypcpVSZmy3E8u17NSlTBbJ+nSF/KDbyd9Swjrsr0IBsa6FsVNJWcFuYUuLsZ4vj9+RiNz2SUnprLXWVFafSdVUk4PRJl4a9aMN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 03:34:15.3802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2511aa-7a82-425b-703f-08df0eec6385
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194

DMA devices in a confidential guest can access only shared memory, or both
private and shared memory. Some method outside the DMA API will confirm the
device is able to access private memory through DMA.

Add DEV_FLAG_DMA_CC_PRIVATE and dma_set_cc_private(dev, bool).

The flag must be stable while any DMA mapping exists.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Assisted-by: Claude:claude-opus-5
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/device.h      |  4 ++++
 include/linux/dma-mapping.h |  4 ++++
 kernel/dma/mapping.c        | 21 +++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index aee79fd6b32b4..54ac6cb7f3762 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -599,6 +599,8 @@ struct device_physical_location {
  *		ancestor device.
  * @DEV_FLAG_OFFLINE_DISABLED: If set, the device is permanently online.
  * @DEV_FLAG_OFFLINE: Set after successful invocation of bus type's .offline().
+ * @DEV_FLAG_DMA_CC_PRIVATE: The device is able to access private (encrypted)
+ *		memory, no shared memory bouncing is required from the DMA API.
  * @DEV_FLAG_COUNT: Number of defined struct_device_flags.
  */
 enum struct_device_flags {
@@ -612,6 +614,7 @@ enum struct_device_flags {
 	DEV_FLAG_OF_NODE_REUSED = 7,
 	DEV_FLAG_OFFLINE_DISABLED = 8,
 	DEV_FLAG_OFFLINE = 9,
+	DEV_FLAG_DMA_CC_PRIVATE = 10,
 
 	DEV_FLAG_COUNT
 };
@@ -829,6 +832,7 @@ __create_dev_flag_accessors(dma_coherent, DEV_FLAG_DMA_COHERENT);
 __create_dev_flag_accessors(of_node_reused, DEV_FLAG_OF_NODE_REUSED);
 __create_dev_flag_accessors(offline_disabled, DEV_FLAG_OFFLINE_DISABLED);
 __create_dev_flag_accessors(offline, DEV_FLAG_OFFLINE);
+__create_dev_flag_accessors(dma_cc_private, DEV_FLAG_DMA_CC_PRIVATE);
 
 #undef __create_dev_flag_accessors
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index a3e880649fa41..8d23b983092e8 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -218,6 +218,7 @@ void *dma_vmap_noncontiguous(struct device *dev, size_t size,
 void dma_vunmap_noncontiguous(struct device *dev, void *vaddr);
 int dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
 		size_t size, struct sg_table *sgt);
+void dma_set_cc_private(struct device *dev, bool private);
 #else /* CONFIG_HAS_DMA */
 static inline dma_addr_t dma_map_page_attrs(struct device *dev,
 		struct page *page, size_t offset, size_t size,
@@ -357,6 +358,9 @@ static inline int dma_mmap_noncontiguous(struct device *dev,
 {
 	return -EINVAL;
 }
+static inline void dma_set_cc_private(struct device *dev, bool private)
+{
+}
 #endif /* CONFIG_HAS_DMA */
 
 #ifdef CONFIG_IOMMU_DMA
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index bf2651a70b7c2..11c127ad45370 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -501,6 +501,27 @@ static void dma_setup_need_sync(struct device *dev)
 static inline void dma_setup_need_sync(struct device *dev) { }
 #endif /* !CONFIG_DMA_NEED_SYNC */
 
+/**
+ * dma_set_cc_private - Set whether @dev can DMA to private memory
+ * @dev: device whose confidential-computing DMA access is being updated
+ * @private: whether the device can DMA to private memory
+ *
+ * Called when a device is known to be able to DMA to private memory.
+ * For architected CPU integrated devices their kernel drivers will
+ * self-accept using a driver specific validation. Other devices will
+ * have a userspace managed process.
+ *
+ * DMA mapping must not be active when this flag is changed. For CPU
+ * integrated devices the driver should self accept early during probe
+ * after validation. Other devices have this flag set automatically
+ * before probing.
+ */
+void dma_set_cc_private(struct device *dev, bool private)
+{
+	dev_assign_dma_cc_private(dev, private);
+}
+EXPORT_SYMBOL_GPL(dma_set_cc_private);
+
 /*
  * The whole dma_get_sgtable() idea is fundamentally unsafe - it seems
  * that the intention is to allow exporting memory allocated via the
-- 
2.43.0

