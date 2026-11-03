Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793677819;
	b=1xjUqo2x/swy05cTnoFRqPyvnBhj5HxLZRa2FbtMW+GUUDRPr//laSEKNVZUJOwCwTX1
	 BPtLa/Lz0RPcwmSoO44H31rk5SU3Zdjjx8MxsF33kqbd/Wg4VeEWUzrBsBH2u7ifuGORG
	 9fJj52ZHY1UVWkY+3Rr/w7DBNk0agwxivBO8D7bpDq5L77N/4tN0h5O7Cc6agluIlbFNC
	 2BAaeDaVKzXF2F8cTRI6ImjpWzsDidL9cwSb0MM03RXXgIvSGvsk3JJPzzcBZ+VIdIB/f
	 ApYoIByvCZNDU7D1PoL6/1axyw2b4dFDiscokJmEm5Eexmc/fVs61BoFM7EPLNBqrag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677819;
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
	bh=ZZDnWIk/OscKtlJi/oN+tFvlCNG22HgcEg1/0TSAbGM=;
	b=qnBzx57KOYOFdHnSO5DHX7FKxuQo1EJfOMLzUjMwGGGdO/al1LB0tehViBSQnq1GO5Og
	 pLX9Z/5FjZIRpehJ/IPrJQnRecpJP7T/lJBXYCpX19SntET8FZazsZ/G65BhxlU/zsrmF
	 K9XKmVDeia2bNzyks4RZOq1Omwww51QRjFxy1+sDhfJvLe0mAO0FJI3G0/CzbfeRE28ip
	 iBs/07rNliG9JEJnxglgLejhy+cgRZ5I/v5R0v8e/LmXC0PNZbBO7Q2QUYf2CRRig08rK
	 7yG0VTmhboSPJHR28pDfDlBEa5dMfa8uSgzdZdxBlyyARd5dZDoWh0G+PRhapzaZHlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="I/cDy0xV";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.39
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013039.outbound.protection.outlook.com [40.107.201.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79502606A33A;
	Tue,  3 Nov 2026 03:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79502606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=I/cDy0xV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FORQQmYFXfBc3RPy8ZCiLBjs+OCxu6x5iNFuDK8oqbDpsMnzsOSq2OAzHre7wC4/7Q+0AZh4CHQvglvUyS4yqjxH6WuIZ3jpXYO3gkz+uFJEo1/u4apRkM1BSfwVYdXDEMqS0UH0udyOzqamCDarTz9a4E8gJZHKUCAH74b9wrTtN64eInyAEaHLfYWU9t8O/Nzznr2UU/RCIZshnJfk2wwRiToQ4wUQn/PiMZEnDdMcXe3gvHvmDAR+a3VXWnkdSSiNircaHBu8J1q2VM1ogrQzt6GXeUoIWTO2WcozcZzuEAMurTTKw/+n1hW0BNthSh64tN3BW5xdxK+ShtVPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZDnWIk/OscKtlJi/oN+tFvlCNG22HgcEg1/0TSAbGM=;
 b=TrGTx2h682TJdAWrd3eZxiHvHjjZaorUCVS6MB5w8laENCeb4gFUi5qHBkclg4e04huS6qqznfc+ogixdXoBlyrrbRzXJCkjfHLWMegukjZfRJPM8oFhV+phoQ4TbbvyiQCjuOccZXeUl/GEgpABRfgBTUmQ8VbWmNVu8RjOsVY/ye62bssw6HqJUsLIq0cZPwdqu7loD9/qM3TkfetpP6U4iNIJv1vz8if5nHz3K1C9eMVW0yXYL8IDeIFmO8hbC3XFZzWe+MzXdkZW/4snAzQsYydQKeOTM05XMR0jXy5So05FtuPyIr6eHW4b6aVL2Rop7c81dBdoHJcRkPA9nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZDnWIk/OscKtlJi/oN+tFvlCNG22HgcEg1/0TSAbGM=;
 b=I/cDy0xVysnK2P4EDDknisgJG5JLSjJ3Lh2KIWRWCiTGjcYHswwAR+RRhxPuBCts6QW9jXRn3Z5FQr+zcXBigXxmMwLSU66mfFVIb8ysHju71dmBkBIYwm88pwyX3XGDP/KjSQigaK8cBr7LpfIeooJqGoF1hwnEYgm9o5llr2qhrflgqQT5RjMu2nFBRGp7j3z2LOhVIB+TvewqAYIF5ooh3p2lCR9gAUJQoD4K98RxOX9BTerKPD4rXTTF7dvMSAzrjw8zkTKcAy7gaCQcRc+M64BcdKX3XDeaxwqtuA/6b3NlJDz1cfi5VdQYlYajWwhwkYTWMcMB8VX3koNdtg==
Received: from MW4PR03CA0110.namprd03.prod.outlook.com (2603:10b6:303:b7::25)
 by DM4PR12MB6471.namprd12.prod.outlook.com (2603:10b6:8:ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 03:50:12 +0000
Received: from MWH0EPF000D8952.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::3e) by MW4PR03CA0110.outlook.office365.com
 (2603:10b6:303:b7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Tue, 3
 Nov 2026 03:50:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000D8952.mail.protection.outlook.com (10.167.249.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 03:50:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 19:50:00 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 19:50:00 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Mon, 2 Nov 2026 19:49:58 -0800
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
Subject: [PATCH v2 2/7] dma-mapping: Let a device declare that it reaches private memory
Date: Mon, 2 Nov 2026 19:49:45 -0800
Message-ID: <0697a7ab3e4c4b7703428644444fd13f8dbfccd9.1793676742.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793676742.git.nicolinc@nvidia.com>
References: <cover.1793676742.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000D8952:EE_|DM4PR12MB6471:EE_
X-MS-Office365-Filtering-Correlation-Id: 16455f8f-a235-46ed-e54e-08df395d8fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|23010399003|10067099003|18002099003|261102123227099003|22082099003|261102130727099003|56012099006|261022105027099003|261026121527099003|11063799006|261026140227099003|261022075727099003|261009223327099003|261009223027099003|261009221227099003|261009220027099003|261009221727099003|261028144727099003|261021135927099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	FyvY8FE1T2MugWc7LfvFJJET6gOq1qkE2Z5l0iNHCX+0Xeo3eOFQKxstRgIGJyxurMxcZLUi9NhDG4tOxDlWBqpHd/Mt04odywqUe9ITwhYp7npU+4A2YGKTfhMu61fsejAe08W/9HmHvbFzUPZn35w2bNnV4SuJM1e20EZuxu0cVUR7HGtqj63JLhfboE4pDW74wB/CdMxsBC6r2uF+MgrAgvF4N+0+nJg+gMUC5Yt2nQoEPckH4+G2TNa7gKjQZjR1nyxmL9xsoSsnfjFvm8mLx4SKsBUZALnuFcjgycLwdXt7AUSTlY9AyEqpfAGKOlKUVhk4WyZmxrJb8+Myulcc4VwUqAJ+6N01v8kTyq4taj6MOtfRm6rv7I09JZdXRu9cVYKLM4hpKIzus5SJgzq75GdaP84T373PWYgrvzgOFo3e/YH3c+r+ZzUxYeFcnnM2iwBZcN+jRKaxuuoetfdXYhC8P6v0+xSEewNEyViQGQnw2e8QQtYr1PFcJN/0N4lTlXcuvsNlgeU6GdUHgVOGpZakyrc8ExQU6eOeIAgrEbKnp0+4XinsqVWiPpYXHmxGzIND+PJMtpKWqTrenig3PmxbnDLbcDlb+ph0ajYfZ0/GqoFG72fQZl3Gxhn3q2V37gnjW+BRhCBnyKRYoRA4BQaNBw1pz7xfTZp1G2D9PnqCMoyqfPS1vs1fxzgBhK1rZKOp+mTlDQL+qI1UWg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(23010399003)(10067099003)(18002099003)(261102123227099003)(22082099003)(261102130727099003)(56012099006)(261022105027099003)(261026121527099003)(11063799006)(261026140227099003)(261022075727099003)(261009223327099003)(261009223027099003)(261009221227099003)(261009220027099003)(261009221727099003)(261028144727099003)(261021135927099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sD+o9ltW7zGHBiiFDaMqeHDnrLogrn9MA977JcFjazzz9uqrPgQFxIKNsqk7FUXOMSWBROn0IVrqH8k00e3t1DQG26ktLeKd6tZykJ49GuCRisQuCwSStjRww/DyfT26dg62brXhd47llG6aBDrtMQ6NHxCQ9lOEwLIZ4pSyRbE6VB39KzgXohasI3uirwuKA8/oqVAdR2l9YwziTSltpeeP6RnI40ATQ/d8Az6auRfIXD6rTw6Uo56gSMknZrj+xvb/OB0yXGCMCTdpdLeI6EgWPMHhCFtkmo8Ziojt1yWEn3L8cKCJppyS6WHbTp2y4H5I1nVjpy8X7a/sCQe0dc3360Og8YCZ6JYGgEKbXRoTFIENu+FoXQdzCAbM6g6A7rGU/H8LMffzD5PLxi9Fj8QZIhJu8i25bdrOeUqSUVlA/F0btC4ZDVhNL/MzJzP3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 03:50:11.4747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16455f8f-a235-46ed-e54e-08df395d8fbc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000D8952.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6471

DMA devices in a confidential guest can access only shared memory, or both
private and shared memory. Some method outside the DMA API will confirm the
device is able to access private memory through DMA.

Add DEV_FLAG_DMA_CC_PRIVATE and dma_set_cc_private(dev, bool).

The flag must be stable while any DMA mapping exists.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
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

