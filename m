Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794343858;
	b=x18TMetufWkY/xszg4J+szJzJVbMPEDJLE7XfujT709NOqyMyPLwRZ9v/3OEZZ4zxmnA
	 0X2saYp27xt5u9yULu5Ndedtts1fUrBgojmfZFO5N17L0wBSSTWyBhwj05yxbu/tz0iPe
	 1jzA1FuhPFo4gP9y6hB/Cc2p0Shwc1vUcTlJPmHWzJyJV36fAK9NUXriwpOxacwlU6o4G
	 GMGTvNJWl0r+5Z1QO+G60IBiLDHsUhz03SyVEN15IUvwX/qp9dnQdUAT47TsLnbGDruC0
	 NpZhR++qV9p9iOxNh2Oleg9k39ZZQvPK3XZ+VCn8oCCaVOiD1DxBmvy8NtwsIFL61Mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343858;
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
	bh=u6+vHmT07KshcJ+OxxIvhsg/SXYJvgtsYwC4RqKlRL4=;
	b=meFztXF6LCmyANVwhwXj+mhSF9BJ70LkNLx8UWOX7znZ8Lc5WnHW3CaEHzWMBCsocUQT
	 aPphBylHKGVU7IdUh0QQw83xehR21nGhquJ0EPZx8gv8ebCMNhcZseKvLuenkBKkcH6Rm
	 0JbhuFWZPzjxq7xc7KAs0iulyW/oFD5iAfdOw+c1h7PM4O1L3aqMVbvNmdtt68Y72vRdY
	 PKJbs2XwAETemQYnhgwExLw076PcnEisllOK5044vDUw0wE3T/2c+ZmFy1DYkDFRzdUEq
	 hHPl7tBNFCIliF75BgNHqjQNj5mu5H6Pk5iM6j+2xQGXirzhcxattB3lavMQcWUyN9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uB7cFS4h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.43
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C06606A320;
	Tue, 10 Nov 2026 20:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35C06606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=uB7cFS4h
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lr+RnH0A429Uhk/5tVVhev1rpFZpFE3BUEvlOYFxtYZ6MjUKStBf/j4+rwMuuM5BCHaYkTCMLEX62EwfImFi0eErypK7jiL/FMMlwXVYLoDEZAWFzcHMiKkCg1Um4yOk/1XRbFOCOSN+JkPpP2LQ4JC1d8Hfe2RAWb28GXTmccYpUVwCPTcKWmu2LE9IEwoCV9SEPq6Zf6m8DBF5ZNnPD5+oXSXszb/m89uCXNHtlDWWFVd9ebv0FfiyELhojHN6Hp1v0Y4ER9+usvRQ2SgHWmX0SRv+RCNKnOfMrr8QDvWcnz5Wnz3pS9QN4F/iZP3EKADVApk5QZYniu9uulsAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u6+vHmT07KshcJ+OxxIvhsg/SXYJvgtsYwC4RqKlRL4=;
 b=YI3hG72Ia19au731H/nwtqtr23g7m8OOsv47hx4w9GRe5R4OfH+tbZchn81tbOdV4Tg2pA3+4bvf0Td5Y57FceWArxjU5S3gDF7NgGOK/h20KvDSAZI1HVOAcKKHOuFjAWMczPQ0lAX0tydHc43c0tTUs6gHbDHvo6+9+ifFsWYYnQhVuG4GL0P8Z8Tdnp9noOmgTIk9rYIiHd6wq4PP7rQc4e33SAhLfSVIeJp9CtI7h4xZkuXZbsEK++yVbyctkVarSXAD9NMUtYyqx+tS7bwooGJ603Tz/wZmsgZnr9HfLhksmh7FcB8+18Nl5JjxAYcCnijiegh67qP+oxNbEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u6+vHmT07KshcJ+OxxIvhsg/SXYJvgtsYwC4RqKlRL4=;
 b=uB7cFS4hU4xoeEsx0GPg1fRsckCBIVnLUM310MlHZVI9INqmIoERS+VlU8F8+B+PJ9vQqezmwJL521jQ8DOcFiRDltXQ7wWIHvoKkzXBLuVWNip4DnZkxH3sE0kpDgoXCrbLSbbaiD3y5F18XNVu5Oa7f/Hir1Gy2F5lO9/qLRNkfku9PRmnLoLUTQPa+hZF5LnzCjhP5Qq0rwFFHhNc4le3OdweGW9kQ5QjjGCEt6dB1It8/tyrpQi6dtfTM11G7hDPPywmk+v4HQktYp3Tpbv2PyjjArxdCLRkkPQKX4pWiuRbttyZW1Ktw/eXa6UGDkmj5GK/6bUlR8BSgFrZsQ==
Received: from PH7PR13CA0002.namprd13.prod.outlook.com (2603:10b6:510:174::6)
 by PH7PR12MB6695.namprd12.prod.outlook.com (2603:10b6:510:1b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 20:50:52 +0000
Received: from PH4PEPF0000B60C.namprd21.prod.outlook.com
 (2603:10b6:510:174:cafe::1) by PH7PR13CA0002.outlook.office365.com
 (2603:10b6:510:174::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 20:50:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH4PEPF0000B60C.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.2 via Frontend Transport; Tue, 10 Nov 2026 20:50:51 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 12:50:31 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 12:50:30 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 10 Nov 2026 12:50:29 -0800
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
Subject: [PATCH v3 3/7] dma-mapping: Keep DMA memory private for capable devices
Date: Tue, 10 Nov 2026 12:50:08 -0800
Message-ID: <6618391e4f7809e25400b414be63a8a35ffc9758.1794343501.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B60C:EE_|PH7PR12MB6695:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c917bf-f219-4a41-5695-08df3f6c4ec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|7416014|1800799024|22082099003|18002099003|261009221727099003|261009220027099003|261009221227099003|11063799006|5023799004|56012099006|261009223327099003|261102123227099003|261009223027099003|261026121527099003|261021121427099003|261022113327099003|261021123027099003|261022075727099003|261021135927099003|261022105027099003|10067099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	oDoLnK3MyoTJtn9Jb/+z/2w6F2vv3bhlvGHBqZzAzvHFlkBgCK4CEYw2i5IJYk0BMr1pssNdFrW1Q0AUHTOh11K7Yp/TW0mL6PrLW9k05sQtsQMa5E/j2AU+B0cK5vbYIVw7MCKLXOi5LVGuI0NSpYv/djID+IQenTvVyh8j//otPJgpnO2W6D64RQozwJaTVWI6Q0iDMMsmIhKV4kUOBLIFDETkhn4QbApczIBLlgooIYzno1L/ky3rU6DL+w4D54sRPjtNa4ghCcA7tARevA6ZpALFpixpUVpox7SZhmBnsnnPlswqZrrl1g1kWM4D8b+w3aQpWs/P2nov1APwZSUSJb7JuPtKfGO1j4+MSVCAAyorrB2K8V3+nFstyhGmWI1hupvr8bluf/fw6xIHNBBWk8gz3JqIWL0K/OGUszSooRn4z6c1SiCmS0jZaDjArXI48QTyrCKv4KN4XCm0LdyoFC5YdUfmQLkIHyQ4plEmlmCW8KMP7dgRH5pnFTB1wRyaSKkEShemAALrlnAqOS4YOobH33mhFUOo91hPeAZ+WR6szuaf0yOG/Trl10oGrcnzTbkcX+qlw0nT04CX9U01uBiYPazd3bwryIzfLbulb0LqRJ6QtliXA+PnikWDs3MVRey/0AWaFzgYR7Z6ZjYGunAGpIJuwcM66YdNl3q9g+xgQjsZBQgS8mXDtbdYwRE1qS0WQ3gEgbT5mdj/bA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(7416014)(1800799024)(22082099003)(18002099003)(261009221727099003)(261009220027099003)(261009221227099003)(11063799006)(5023799004)(56012099006)(261009223327099003)(261102123227099003)(261009223027099003)(261026121527099003)(261021121427099003)(261022113327099003)(261021123027099003)(261022075727099003)(261021135927099003)(261022105027099003)(10067099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8j3rOguUX3M7/2D6bw6kYB/rnirDbP8N5VsNg2YrjEVV5s/4cuOurVVOa+A+2h9VIzFLEeZN0XAqKFmlxhAICb6UWp/F0CEPPzZSCNJl17ewnSzJOPms17ecgHiXYtanMEMYGWVUrqEuWGBqsAK7hLGCYapsVazFcWIfTh2gu3IARpCFy1IMFYzOwmU3DAU5qaOobxtv0FuB6vOaxYFIGBOaZivVcVo2jujol7oqlkPhjwYP98faYZyI4qT3TepRUBpJvXIKCvQ5krIXeYgX13FkEpiQDICO0zcoRJguBhbA5ytuop3wKalZ3l8IxzfF46kNijyaPFX/cK+YLLxTfR9n6Ll3NtuhniLVgsX7/UdjWrPIRD+GCzQv5XRV6qACgU/N95cH1AharonsYUqbMl+IpyLB6EIuyf2WmI1uBKI8amtrMB4IuKdUnUR5+lxc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 20:50:51.9588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c917bf-f219-4a41-5695-08df3f6c4ec6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH4PEPF0000B60C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6695

Architecture code can require devices to use unencrypted memory. This makes
the DMA API use shared memory for coherent allocations and bounce streaming
mappings through SWIOTLB.

A device marked with DEV_FLAG_DMA_CC_PRIVATE is able to reach the private
memory directly. Add dma_require_unencrypted() that combines the new flag
with force_dma_unencrypted(), and use it in the generic DMA code. Also use
"unencrypted" in the local variables that hold its result, to avoid mixing
the "unencrypted" and "decrypted" terms.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/dma-direct.h |  7 ++++++-
 kernel/dma/direct.c        | 21 +++++++++++----------
 kernel/dma/mapping.c       |  2 +-
 kernel/dma/swiotlb.c       |  2 +-
 4 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index daa31a1adf7b0..9d548e545f7a6 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -134,6 +134,11 @@ static inline bool force_dma_unencrypted(struct device *dev)
 }
 #endif /* CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 
+static inline bool dma_require_unencrypted(struct device *dev)
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
+	if (!(attrs & DMA_ATTR_CC_SHARED) && dma_require_unencrypted(dev))
 		return false;
 
 	if (is_ram && !IS_ENABLED(CONFIG_ARCH_DMA_ADDR_T_64BIT) &&
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 25e9a86835fd3..29ea832b9f0af 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -41,9 +41,9 @@ static inline struct page *dma_direct_to_page(struct device *dev,
 
 u64 dma_direct_get_required_mask(struct device *dev)
 {
-	bool require_decrypted = force_dma_unencrypted(dev);
+	bool require_unencrypted = dma_require_unencrypted(dev);
 	phys_addr_t phys = ((phys_addr_t)max_pfn << PAGE_SHIFT) - 1;
-	u64 max_dma = phys_to_dma_direct(dev, phys, require_decrypted);
+	u64 max_dma = phys_to_dma_direct(dev, phys, require_unencrypted);
 
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
@@ -72,8 +72,9 @@ static gfp_t dma_direct_optimal_gfp_mask(struct device *dev, u64 *phys_limit)
 
 bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
-	bool require_decrypted = force_dma_unencrypted(dev);
-	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys, require_decrypted);
+	bool require_unencrypted = dma_require_unencrypted(dev);
+	dma_addr_t dma_addr = phys_to_dma_direct(dev, phys,
+						 require_unencrypted);
 
 	if (dma_addr == DMA_MAPPING_ERROR)
 		return false;
@@ -226,7 +227,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	struct page *page;
 	void *cpu_addr;
 
-	if (force_dma_unencrypted(dev))
+	if (dma_require_unencrypted(dev))
 		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
 
 	if (attrs & __DMA_ATTR_ALLOC_CC_SHARED) {
@@ -385,7 +386,7 @@ void dma_direct_free(struct device *dev, size_t size,
 	 * If the allocation used decrypted/shared backing pages, restore
 	 * the encryption state on free.
 	 */
-	if (force_dma_unencrypted(dev))
+	if (dma_require_unencrypted(dev))
 		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
 
 	if (attrs & __DMA_ATTR_ALLOC_CC_SHARED)
@@ -452,7 +453,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	struct page *page;
 	void *cpu_addr;
 
-	if (force_dma_unencrypted(dev))
+	if (dma_require_unencrypted(dev))
 		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
 
 	if ((attrs & __DMA_ATTR_ALLOC_CC_SHARED) && dma_direct_use_pool(dev, gfp))
@@ -496,7 +497,7 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 	 * if the device had requested for an unencrypted buffer,
 	 * convert it to encrypted on free
 	 */
-	bool mark_mem_encrypted = force_dma_unencrypted(dev);
+	bool mark_mem_encrypted = dma_require_unencrypted(dev);
 
 	/* If page is not from an atomic pool, dma_free_from_pool_page() fails */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
@@ -665,7 +666,7 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 	const pgoff_t pgoff_end = vma_end_pgoff(vma);
 	int ret = -ENXIO;
 
-	if (force_dma_unencrypted(dev))
+	if (dma_require_unencrypted(dev))
 		attrs |= DMA_ATTR_CC_SHARED;
 
 	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
@@ -814,7 +815,7 @@ size_t dma_direct_max_mapping_size(struct device *dev)
 	/* If SWIOTLB is active, use its maximum mapping size */
 	if (is_swiotlb_active(dev) &&
 	    (dma_addressing_limited(dev) || is_swiotlb_force_bounce(dev) ||
-	     force_dma_unencrypted(dev)))
+	     dma_require_unencrypted(dev)))
 		return swiotlb_max_mapping_size(dev);
 
 	return SIZE_MAX;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index ded585b39fb92..cd405309358e7 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -673,7 +673,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		return NULL;
 	}
 
-	if (force_dma_unencrypted(dev))
+	if (dma_require_unencrypted(dev))
 		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
 
 	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr)) {
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 2c57b49ac7c06..29ecfdab22957 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1550,7 +1550,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 
 		/* swiotlb pool is incorrect for this device */
-		if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
+		if (unlikely(mem->cc_shared != dma_require_unencrypted(dev)))
 			return (phys_addr_t)DMA_MAPPING_ERROR;
 
 	} else if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
-- 
2.43.0

