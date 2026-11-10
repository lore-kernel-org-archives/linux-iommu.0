Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794343862;
	b=XedxslzVGGNQzuDrDmTdbR4OOrccJdVwQ/3ZE3lLO09/3oWkEMHGhEAdRWKMacvXxWlm
	 wI1Ucc7lfMaq6JZriDEJYM2IgTLWFqQWntSXWKc/Dk5YWVMOMqPTKPvmgs5H7hATXQiwH
	 FnTz3PhcCYz1gtBIswn8YdaeAhIywagIhpuRjpo7XGwY77lr3+yYjfoDj0Wbec3qgy9J6
	 c/tXIN1kxZGTh/8QGwHBenwcLV6raEFFZ8oRJ044SC15+RX0Cv+GEfIN+PRI0veskWaMu
	 6J4WH8dnpcoUhN7OGzYgRieu33qUc560XETMDnP5Ylg1dsxAQUa+em9kp938Bs3DY7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343862;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=8Z0UWbkx6cMvBmCo/niUNMkpInRYlHGYOHDEPOR74co=;
	b=2guoJLR6bqT5v4sxQuta6dUbwm1vTFXSSURwND/eKmMaGgIfo2UIxCDdiHXmB3eeVgBo
	 aFbCC39r1QI/xXV7ne6trzke0LRiBScYB2G8KgEW4bQdCyQ2SVSCwe9GKiI78R7L/85GG
	 w97dqGo+ZhCGG1T4fbS+BDUUVijs7vaepa0eJ6Rxyfabz6lUcfyuaOYgfX0YB0xE3dr9u
	 op9O2t6UbuKoYqlH8Zm6+0lhnxC+2YKOIfmFchcRIzzrkyaDyiuLKBPgpIyklr1FYmtC+
	 LSTFL5QY3huu7/o09o5Is9/oe9akztWYvjGnv9HRsMXURr48xeS7Ig1/fH7Mg0rQbjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lcWk6oMR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.9
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A5606A321;
	Tue, 10 Nov 2026 20:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B70A5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lcWk6oMR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=slKreg44ByyFZxKXI7oaRNaPifnrP+7cUm0DunNRuIyB2MlaG9ECwnkKqlnpKWHB7LHX+pE4wo0sCvpeN27KqArHgRkkbDZ/jxZCmInpldILpTZ5NqyIptk3eHyuys4FxZDEMRIShXKuANFU4ZZK9K/fG6pv7Dh3fmsPt9pORonE4rHjdBgpP+A1PF9kkxn/hxngDTaZ2Vue0vfpWtr8PxpWw1WKtC32efIghrnN9RSaqOWVH5Eiit5Rvp/tpe4sdXlnKfNODDFxNuWQ/WqorghyPRyK9lm6wPaa3YUrkN0k+btgIzC0lc/T9kr8HNHdxQYmMmLGpiGFqmyLwUfnbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Z0UWbkx6cMvBmCo/niUNMkpInRYlHGYOHDEPOR74co=;
 b=rRogsPrFYsSkhp4aaQLw7whCCBHBdt04WL/RcWjVyE1OEkPFBgSTnHCIoyCswCoFGj8/p5YN2PJTEqLv/Pxn2a3Th30Z+FG0gLy6vnfOhFxkb88PScYqfwPiVdPgX/38T6ozUnH8CPyPljL/48pwAZ8TzicqP9/yjDl4/kLpgK02mD2vaV7cKb2K5RmAli4mE87fFZ/APes1TmvGduVsdWyIosVu8zLnMPu+zIYlMXlhGYnECkA7uvx3qYasEHfYLONenZfLpCx5CcQcuW5nMG2ID/jgC2tNNbHPqkeV33I2dtoqHUz1Y+MtfIwjYtyauwTdoD7G8c7kFmBl3CY5Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Z0UWbkx6cMvBmCo/niUNMkpInRYlHGYOHDEPOR74co=;
 b=lcWk6oMRydJNoF+oaOlIOqboJROo/gI0A8vYLzhtC6OpoaUAiUWewMknvL3ds4Tx71B2y48tR60DRBjkduqWaa9KRqPjasjKn0hexWUlogM/qEHgcJs3a81nC6wd4ypyGIaQQ1ykttS9PhRSYnAyrxfU5lGg0VpfJ3HEdVIF7zxk0/WAxqIfej5DRpkg/fivsrA2UCG67YbopPkYgyYyvZVT68O10rYlsi4l8rsCNlCqyyAPqLbCnpcjXuzqJKPKwvqzMEf4oEEXzn+2oIhpJ6NIFEdlonFenmpvxYHnBsogun0CuFrc64LuUTHxmAdDUQHlOckJwflMHZyu355YEA==
Received: from PH7PR13CA0007.namprd13.prod.outlook.com (2603:10b6:510:174::17)
 by SJ1PR12MB6073.namprd12.prod.outlook.com (2603:10b6:a03:488::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:50:51 +0000
Received: from PH4PEPF0000B60C.namprd21.prod.outlook.com
 (2603:10b6:510:174:cafe::f) by PH7PR13CA0007.outlook.office365.com
 (2603:10b6:510:174::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 20:50:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH4PEPF0000B60C.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.2 via Frontend Transport; Tue, 10 Nov 2026 20:50:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 12:50:29 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 12:50:29 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 10 Nov 2026 12:50:28 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>, Johan Hovold <johan@kernel.org>, Marek Szyprowski
	<m.szyprowski@samsung.com>
CC: Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Pranjal Shrivastava <praan@google.com>,
	"Mostafa Saleh" <smostafa@google.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <driver-core@lists.linux.dev>, Sonang Patel
	<sonangp@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v3 2/7] dma-mapping: Let a device declare that it reaches private memory
Date: Tue, 10 Nov 2026 12:50:07 -0800
Message-ID: <ffc1666b3d45b11511ac4d720b6aa77cf4fbcb76.1794343501.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794343501.git.nicolinc@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B60C:EE_|SJ1PR12MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 84d11fb2-128c-4a5e-357d-08df3f6c4e05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|7416014|376014|261009220027099003|261009223327099003|261009221227099003|261009223027099003|10067099003|261009221727099003|261028144727099003|261102123227099003|261021123027099003|261022105027099003|261102130727099003|261022075727099003|261021135927099003|261021121427099003|261026140227099003|261026121527099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0ICvlwWkQ2c/Y7cEoTgDzeV/aIyNmp54kvoIlfoD35B83cnN9DNQn0ND2DYA6B+SN/wQEzJSmInRdt/pMQsuz0gB6Fdmv5aVBZBbtHClbGlpjfjej9bpmJ112ZshchgjdTbtqj4KnNR0la8GSnLCp0zw1g1LQiPN9dPSJxyeuhi8QwZu3djOusPPJuWha8i9dTxczrWcVNkyiCTgM3clDg2PWhLEfpCQXexysiOyCiyViFXH1JLQd1qXbxGLmeL0cJFCbIsY9povgBqLoQfp4AfevUANgUHAeRgudYrhny7PchHMyN32/qXkzwvmtYuEOLQXYSQRvsNbxAin5v1r7dWO6RVRsYPdWNMJQmzkOjnqKbaC4KwLnH3CSeLmy4hotzIr3Uy1V8IQQ0Q3f4lcahPkQl0ylf88f1pCSEwSQPJloEA9Nd87Qii1sp9WoT9Qi0k16iwRxtIcwDsz8N1UG4OlsBgf7+SZFD6wp1+9qO86Rzbd5ujs3unsIb5oegha9nsSjCpwgrvUVLwiZuUtc3xGXS0SczTGSsuJyB3FERCYh5hdwCL6Pmi93NH90XAnqvS3XbgSV3yn7sOGbqlbTinCs0giR2sQhj8ZNsNeOt/gcPkNmVrkKLMNnif5LUgaG07UX3YOOYfvHOcszyBptjAcjq7Ew6IS+43FwHif0axLXYEJGcchdFgIWAlVsh0/REchbprZapXxmTtCFj53SA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(7416014)(376014)(261009220027099003)(261009223327099003)(261009221227099003)(261009223027099003)(10067099003)(261009221727099003)(261028144727099003)(261102123227099003)(261021123027099003)(261022105027099003)(261102130727099003)(261022075727099003)(261021135927099003)(261021121427099003)(261026140227099003)(261026121527099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VwBEPYJ5JaMOocgF2c7UjogaDL7mD7HEV8rRBsBaoZaaXj+25X88zQSvzYL3irb0CL4/7/icHA5N4G4pA20oearl46tXbdeY6/pSU2JPhstOJ8RECadueZzKcP9H0a7ZCjLPjUB1n6KpjJVoJkqJkW8FSpYoMBCwJX1tIviYFT8svYdhoI2HVgHFYKhKY34YPnnk3LTnVQaw9DbNmcMI56NKrX5uKCr1XRR4dUmSnviElFuDPVjGUvKlXLSJU/LG1a5/HQMdJmd2ElT3kjzpbd6xryCnEZyzaYDjWUsWw17Op1c3xWODdyaoKL8mVKo4zTf6KmBa1COttaOBykXSYbPfeIDj48aGL5ZNruZAYn+7fKVGghK52UMiOIpTUPc0mcLvCvLbwVmMBD8DaC+v4sdNvUU6p4We4numE/7+PBci1b1hLj/fv+XWkYCmr8so
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 20:50:50.6895
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d11fb2-128c-4a5e-357d-08df3f6c4e05
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH4PEPF0000B60C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6073

DMA devices in a confidential guest can access only shared memory, or both
private and shared memory. Some method outside the DMA API will confirm the
device is able to access private memory through DMA.

Add DEV_FLAG_DMA_CC_PRIVATE and dma_set_cc_private(dev, bool).

The flag must be stable while any DMA mapping exists.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/device.h      |  4 ++++
 include/linux/dma-mapping.h |  4 ++++
 kernel/dma/mapping.c        | 21 +++++++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 429e39f647cf9..01d7877d0b571 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -604,6 +604,8 @@ struct device_physical_location {
  *		ancestor device.
  * @DEV_FLAG_OFFLINE_DISABLED: If set, the device is permanently online.
  * @DEV_FLAG_OFFLINE: Set after successful invocation of bus type's .offline().
+ * @DEV_FLAG_DMA_CC_PRIVATE: The device is able to access private (encrypted)
+ *		memory, no shared memory bouncing is required from the DMA API.
  * @DEV_FLAG_COUNT: Number of defined struct_device_flags.
  */
 enum struct_device_flags {
@@ -617,6 +619,7 @@ enum struct_device_flags {
 	DEV_FLAG_OF_NODE_REUSED = 7,
 	DEV_FLAG_OFFLINE_DISABLED = 8,
 	DEV_FLAG_OFFLINE = 9,
+	DEV_FLAG_DMA_CC_PRIVATE = 10,
 
 	DEV_FLAG_COUNT
 };
@@ -834,6 +837,7 @@ __create_dev_flag_accessors(dma_coherent, DEV_FLAG_DMA_COHERENT);
 __create_dev_flag_accessors(of_node_reused, DEV_FLAG_OF_NODE_REUSED);
 __create_dev_flag_accessors(offline_disabled, DEV_FLAG_OFFLINE_DISABLED);
 __create_dev_flag_accessors(offline, DEV_FLAG_OFFLINE);
+__create_dev_flag_accessors(dma_cc_private, DEV_FLAG_DMA_CC_PRIVATE);
 
 #undef __create_dev_flag_accessors
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index efde0e5a58dc2..3cc38db4a7490 100644
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
index 82e701648d604..ded585b39fb92 100644
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

