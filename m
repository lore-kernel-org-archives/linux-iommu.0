Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793677820;
	b=JG+YhkEfenPjhv67uWGLXwzri00THxgVd9GiA2v6xMV2KKUB40UA3F751/gD9JbYzqLn
	 wrCx29zsG0f6Q4Kz9QtXjDAivekNuRpNvfxljyOqeDMkMMPa5cYDn9QDwrJu7cy1itG2Y
	 /uvbKRlqHUsufR1yCofTiqOLgqXJe7UWs77rctdyvo/9SOpLnUKnHt/MaKwFWp56Ww+Ef
	 GsS2WgbZeTgu++xW3eyd9/p6DZP8PwQgZZUHD4kdSgcJW72NyxWicBO6kDFvEgd/OSq5v
	 4QNdXbhqxQGIbcxD2bJFILyeYW59qcmaaQRf9/nZVq/zPgxvWHMlB1o7RwVe1GGpYXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677820;
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
	bh=LiFZncE3kiMciw8nuHVJunXl6r+N1QQAwGpAzwmYzr4=;
	b=hZ1AjujrW8Mk4Pae8tz8zV/PoH4NdHzQqPrvEy74OIPZ8o0gME+fJJ8rMGpoXMoY3NvE
	 v+W4YU83Q6razHhzoB0XPrQs0Yuh8O/zrbETxwIkJcz2fs56x522UHk/6CRUdoYxHiZrB
	 pgH8gJocDyoiC7ItQ1tfuX2ME94tF7FQyNMeJdxglmHK6ayJIbHYpOexmRAVEnd6RJz/E
	 GNBSkjcfmxU6TJe3pqruVJJSCt39dEMljbfAIO4L4muntHH3XS+F5oFpnlfIyFYQ80+Fl
	 QHVlXcDxZmsu40c1Vs0jdSMqQiVZwg79WXlJ2fuwyWMBiBEFpIZG6+66vX859tN3SFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SE0JoPwq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.37
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5BF606A33E;
	Tue,  3 Nov 2026 03:50:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D5BF606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=SE0JoPwq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjkJ0OvtV35RNSo93Azpa4NVX1r5u9bfRMq/Qad1dPjb5H7Z+Qb/+cxlibvij8MmJWLoMYU8NlEZpRfe9G537UOKRawORqZlZUmnIDOB0yxejC4cdXs3QDtJoRKQPU9pgq+1dwEhDXqMJX9RjHXSLdscQFIEdU+gW4spCE4ElmAHWc+taFUouxqfOH/32RzL28ASAJ/IYbsDtArzlI7pLN+UuOlecIF/3Bk9o/j0Ib+p/fPjuwBeLgy/8OE4UP+qga0c21M3BfMpXPYrTxnmPv3w6TqD5OictFOZ0zmh2y98PU5rietLAXidmc5FJQBRglWzLcBUdxyc6Wp/Wa5ltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiFZncE3kiMciw8nuHVJunXl6r+N1QQAwGpAzwmYzr4=;
 b=WBEM+3n0MgEcE1pab8tqj8cyMTcMyl8fkFwuewTE5clvn6R4IJa4/hqPGQSFMcfAMjjRWQlAblKNtmP3TQ4UEBLGeDA0+EOc6s+AjzF2dQ/Enhtp8ky2ylqUvTn4HC6KVxzcUH91rgJ6WpTkWYzZnWld5etwDD82zPSSH6ueHhJJT4SvXlFvkwqjFUEbXvIFMNrUv2PJRTSVhZRqo8UTCQ2lnmb343RmZmSykxmisHJvFNRtK32S2iuocFyG25sCtlrbxypj7iPzIbn5JBtWUgbQFhjoxV/+1rvRM1JuDc7P41rtoPfEhmMsF9FIz+1uwSMFO/g7O/9yEn/LPi/JKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiFZncE3kiMciw8nuHVJunXl6r+N1QQAwGpAzwmYzr4=;
 b=SE0JoPwqplVYyC0XysFYce38xoHiw5DDV4O8NFmvTxaXchHlyNP59GPgK1y0OeVKO+sQU1gtdVJ1umGpNWd1Tw6XrDnGtgVfLejWGg7EmQqCVk+tQncIr5BYAASkWu163mrSvUIXX1PWGny2Fcy5vo/9PktbDXr5+tsniTrcL/bB9lbophZADLkMr9lx/Se01o6Cy0J1lhPlcxgnQG+gdYBnuoeFtyowPZ2XYSnhACtEAVoNyZvX9si3PSJG9sxc5lVkwJ8gHBoRAVX6QWGkV/KZZ377fGMbhGMrmInMGoennhpKs3P6eDobqKo2snp6KdRW2sFqRKw/FUXywXyCyA==
Received: from MW3PR06CA0005.namprd06.prod.outlook.com (2603:10b6:303:2a::10)
 by BL3PR12MB6595.namprd12.prod.outlook.com (2603:10b6:208:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 03:50:13 +0000
Received: from MWH0EPF000D894C.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::86) by MW3PR06CA0005.outlook.office365.com
 (2603:10b6:303:2a::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Tue, 3
 Nov 2026 03:50:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000D894C.mail.protection.outlook.com (10.167.249.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 03:50:12 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 19:50:02 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 19:50:01 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Mon, 2 Nov 2026 19:50:00 -0800
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
Subject: [PATCH v2 3/7] dma-mapping: Keep DMA memory private for capable devices
Date: Mon, 2 Nov 2026 19:49:46 -0800
Message-ID: <a2a5fe1a1c4d8c99d96874a166f77996d51f3cb7.1793676742.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894C:EE_|BL3PR12MB6595:EE_
X-MS-Office365-Filtering-Correlation-Id: 04a0f43f-cf4a-4ab0-17a8-08df395d909c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|82310400026|36860700016|11063799006|5023799004|56012099006|261009221227099003|261009220027099003|261009221727099003|261009223027099003|261009223327099003|261028144727099003|261102123227099003|261022113327099003|261022075727099003|261022105027099003|261021135927099003|261021123027099003|261021121427099003|261026140227099003|261026121527099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mGtV4tgAyM5IT+ipVqvreF5vgOPa+YHYCOzXuQnTU7w2LyqbaiueRBsYx0c65y863IS8DKzkKvcMRF2MYt4CbMgQnEplUIUT5I2B9gfrYejLy2M6Fc0s3q/+/2XyiSx2QmDfGKoOvqtOgL6bRSJwSp2CkhV293MtNpR5PRca025uI+9k3wIBRuW37b5UectYEdr8LQVBIqrlkc3XH0Qv67OGsKq3jxI7TXsUyx4Rbr1u3n+8f8x2Si1LAHPWRQrhHaVTssbCfP6iQ5oEd/qKluaVIRmW5ackD0pbAWT9raXghymW6annZUgd6kjXtLh5cvjiH9HBUcxGM1UqJWuwKEhpV53ShshzLRVf6oJRQl4BN4uPpX6yTDXF9uFwEu+MhQbafr7uIvsvA9XQuOklPWBIsDojRBEl6X/VfFBrH4u5P54A+05LI7sOiPOFyEddVheEqt7H3JXCR9Cn7H+Kr9uNreqhKRG/b0wcgLefaE68Wo9y9xOt7AZp0ZRXBiWQcJvzSeqMkXmh9DeDx+cAqJTqKHAtznwJrVsLxH1UmOV6vCPAkhVeniIua+xqSbSfwUtbsINPhHUCsADzxuLLU38UjWPz5+WoVkI0KdPzgo2a6Ukb40Po2HzBabtEFHeIWMMBLA4VP9alq3GbOBkxk9yW89aEW8LvBEemhMu2+UerLAFXvQ+wMKV7/uNpWwT7nL5d8NHTWvDkpC+5yMtDHg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(82310400026)(36860700016)(11063799006)(5023799004)(56012099006)(261009221227099003)(261009220027099003)(261009221727099003)(261009223027099003)(261009223327099003)(261028144727099003)(261102123227099003)(261022113327099003)(261022075727099003)(261022105027099003)(261021135927099003)(261021123027099003)(261021121427099003)(261026140227099003)(261026121527099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xmQ6gczGd0jvf+S5LfZxbzketfQyRr2z3a6kiSKqOt2tC/TH60LVdI33KH4XXlAL1Akr2AWKnoGamWsKGQ3ZcD+wdqLy4ULSBNfu4Bj6CJtt6Sy6wH+O4k2NeQ3PTOtPkSLKQ66F/pqSKJHUMGy4rqNHwgs1Ae7a4zuxa+OBgj4p/3n2oFC8qdsUhmS969vcKJXCBgUmQ6r8Q9eGFSHEKWYBijeq0iUWdu3jFYxSMGNlOwSyV70qDpYfbC5xOgCVYjSVrB4TnctpLz1hpHmTO6UEPyqwA0t65rgXPRCCeB6w+xxVpexKxsvACWFa5rVf0eODIo7ZTr8rx7/Qa2gKeVoRD5xuTEHemQ25e7FK+cwk8JSH7XbpmSOyj5hf0t6G6c/3UqTe1snpCXwNLst+iF+nAXgdhJBADKn65aNVVs64jAt23aRd6k1IoiCCSPtq
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 03:50:12.9803
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a0f43f-cf4a-4ab0-17a8-08df395d909c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000D894C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6595

Architecture code can require devices to use unencrypted memory. This makes
the DMA API use shared memory for coherent allocations and bounce streaming
mappings through SWIOTLB.

A device marked with DEV_FLAG_DMA_CC_PRIVATE can reach private memory
directly. Add dma_require_decrypted() to combine force_dma_unencrypted()
with the new device flag, and use it throughout the generic DMA code.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/dma-direct.h |  7 ++++++-
 kernel/dma/direct.c        | 16 ++++++++--------
 kernel/dma/mapping.c       |  2 +-
 kernel/dma/swiotlb.c       |  2 +-
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index daa31a1adf7b0..fb35ca27941cc 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -134,6 +134,11 @@ static inline bool force_dma_unencrypted(struct device *dev)
 }
 #endif /* CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 
+static inline bool dma_require_decrypted(struct device *dev)
+{
+	return !dev_dma_cc_private(dev) && force_dma_unencrypted(dev);
+}
+
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
 		bool is_ram, unsigned long attrs)
 {
@@ -146,7 +151,7 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
 	 * requires unencrypted DMA addresses. Treat it as not DMA-capable
 	 * so the caller can fall back to a suitable SWIOTLB pool.
 	 */
-	if (!(attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
+	if (!(attrs & DMA_ATTR_CC_SHARED) && dma_require_decrypted(dev))
 		return false;
 
 	if (is_ram && !IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 25e9a86835fd3..b3b9ff090c590 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -41,7 +41,7 @@ static inline struct page *dma_direct_to_page(struct device *dev,
 
 u64 dma_direct_get_required_mask(struct device *dev)
 {
-	bool require_decrypted = force_dma_unencrypted(dev);
+	bool require_decrypted = dma_require_decrypted(dev);
 	phys_addr_t phys = ((phys_addr_t)max_pfn << PAGE_SHIFT) - 1;
 	u64 max_dma = phys_to_dma_direct(dev, phys, require_decrypted);
 
@@ -72,7 +72,7 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
 
 bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
-	bool require_decrypted = force_dma_unencrypted(dev);
+	bool require_decrypted = dma_require_decrypted(dev);
 	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys, require_decrypted);
 
 	if (dma_addr == DMA_MAPPING_ERROR)
@@ -226,7 +226,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	struct page *page;
 	void *cpu_addr;
 
-	if (force_dma_unencrypted(dev))
+	if (dma_require_decrypted(dev))
 		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
 
 	if (attrs & __DMA_ATTR_ALLOC_CC_SHARED) {
@@ -385,7 +385,7 @@ void dma_direct_free(struct device *dev, size_t size,
 	 * If the allocation used decrypted/shared backing pages, restore
 	 * the encryption state on free.
 	 */
-	if (force_dma_unencrypted(dev))
+	if (dma_require_decrypted(dev))
 		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
 
 	if (attrs & __DMA_ATTR_ALLOC_CC_SHARED)
@@ -452,7 +452,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	struct page *page;
 	void *cpu_addr;
 
-	if (force_dma_unencrypted(dev))
+	if (dma_require_decrypted(dev))
 		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
 
 	if ((attrs & __DMA_ATTR_ALLOC_CC_SHARED) && dma_direct_use_pool(dev, gfp))
@@ -496,7 +496,7 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 	 * if the device had requested for an unencrypted buffer,
 	 * convert it to encrypted on free
 	 */
-	bool mark_mem_encrypted = force_dma_unencrypted(dev);
+	bool mark_mem_encrypted = dma_require_decrypted(dev);
 
 	/* If page is not from an atomic pool, dma_free_from_pool_page() fails */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
@@ -665,7 +665,7 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 	const pgoff_t pgoff_end = vma_end_pgoff(vma);
 	int ret = -ENXIO;
 
-	if (force_dma_unencrypted(dev))
+	if (dma_require_decrypted(dev))
 		attrs |= DMA_ATTR_CC_SHARED;
 
 	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
@@ -814,7 +814,7 @@ size_t dma_direct_max_mapping_size(struct device *dev)
 	/* If SWIOTLB is active, use its maximum mapping size */
 	if (is_swiotlb_active(dev) &&
 	    (dma_addressing_limited(dev) || is_swiotlb_force_bounce(dev) ||
-	     force_dma_unencrypted(dev)))
+	     dma_require_decrypted(dev)))
 		return swiotlb_max_mapping_size(dev);
 
 	return SIZE_MAX;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index ded585b39fb92..0252473edd0b5 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -673,7 +673,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		return NULL;
 	}
 
-	if (force_dma_unencrypted(dev))
+	if (dma_require_decrypted(dev))
 		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
 
 	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr)) {
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 2c57b49ac7c06..ddfc4533934a2 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1550,7 +1550,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 
 		/* swiotlb pool is incorrect for this device */
-		if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
+		if (unlikely(mem->cc_shared != dma_require_decrypted(dev)))
 			return (phys_addr_t)DMA_MAPPING_ERROR;
 
 	} else if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
-- 
2.43.0

