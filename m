Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFB737A4AB;
	Thu, 10 Sep 2026 03:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011280; cv=fail; b=BwFkJ51q+BqsZtCASwsVC9QhxlxJ3DZuYYYH3g2aPBltqZnH6IFNrTH80OC5myC3Ea1HSP2wfR5eR83jNXgwJDZT5ytJ5WfX24EFLHSv95+Vs+pmuxhemY2PKSlRayAF+J+Vj6Ms+SkVAEvukscJGrfIKE6M3rmFYzzuXSuRPKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011280; c=relaxed/simple;
	bh=rzbitRnpJAFSTXusz+GATdcHEZwdYGgyF+iJjOY6Gi4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EI8O/UmLY5Zk7FFy5nhv/3XlTU6u/YPxWu2HpFgJ2+7D++FfnIdkvihUtCu6O05WLk2qsm+QCr+6oRDaOwXzj94kT6GbUHhCD7bE839WTxJHpEBdgwIdOmxrCOC6lsyB2CuChYNGKp7CjjkrPjnthezm2la5npR6pBgNm5Ke8cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TVhVpuwp; arc=fail smtp.client-ip=52.101.52.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TVhVpuwp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dlSMxEE583HmzEa5kcsLxShoWxTTNXy0aG59Buat4DJbOEqK9MwFzRM0vA0PzkpKTB9Zhs33wbq87HLL4hJWToAjUIUO/a68HFmqEPQ6k3proVGYi1lJ5Q0LgsnQUTnGKp4oZqy3OAZsDWV04/K4LTHDmkZBjq0y2b3GkLt2FDBOFXDxEfj19wmbRlh6xS0SYfftuEAOU78qdpI2HWwdGLQKZgYbO3slN3ceV/90fNLB9VLnpEKwypGavtgNeJ1NRHclZ9EFPeEiBhGR8/P/ga7Ay5IdxzvblDaRVCdLVrNV8MXq+AOcesNqil/M52m34aPpZr+SWMbcWiQkIfYCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPsnVwapVkwHCRbG/3G5otIOKnbDmZl98XDmt9LMWU4=;
 b=OcqhquJbQGMGUl2ViKSuIgIeg5ALFkdZJBMX0PFvk1zodBcSv75EsveJPXzQioi6UIhEMdFVIIUEQ6blDk41wcEK8M/8ECQTxVxx5z2Gfe+lYyQ+YLuxULsOmCiVsC8iyukf5a25UGAtk1imIj2Jwn+siUFzCNF3ZU2aC2CikxHKZ5KlOLqnC8j9ZWK7A3S8TAUWjLp5jctGJ4VTFEz3IC/ZHY7b9oTSmNjvnknG4V0lrUyS6xbMbM7yWG9HcJYzoGUSHpn0+TByS95gmIn9wZZh2pRl977fJ/Zk/cTRU/fJUUcMvk0sjKsNT6Hx+280lcUkRefnJnZBJdUJmdvxgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPsnVwapVkwHCRbG/3G5otIOKnbDmZl98XDmt9LMWU4=;
 b=TVhVpuwpB8C7ycmi330+M57T5uZjP35nvp6ca/a/5ukKXdT9SYNRZTtjQtBWyhIgQCI1jXUvX4KHs6gDCm14vTHeAkkUwfMeciTBRE1xb5sV2P7jkngg9EWaF3G7WCHP1UMwe+NX3G+5bIhxCOsmWfa1GzAUYxzp6ot0MRB2nMISCuhpnzEjYVejHfafcEWtk6abkYQGwkzosiAs+f9gznh2ag45MjTplnD92Jv/GeOSEv9GZNjg4V3Y4Mq3X7oNjaxrjtHGvV9lQGIxTPcVZYzzCNtWUV/1eGRvZfJQgtHZtHo3JdkJzVuAFS5DYTD7VuZUlRTveXlTo27a1e0vjA==
Received: from SJ0PR05CA0202.namprd05.prod.outlook.com (2603:10b6:a03:330::27)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Thu, 10 Sep
 2026 03:34:17 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:330:cafe::7) by SJ0PR05CA0202.outlook.office365.com
 (2603:10b6:a03:330::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Thu, 10
 Sep 2026 03:34:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Thu, 10 Sep 2026 03:34:16 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 9 Sep
 2026 20:34:06 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 20:34:05 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 9 Sep 2026 20:34:03 -0700
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
Subject: [PATCH v1 4/8] dma-mapping: Keep DMA memory private for capable devices
Date: Wed, 9 Sep 2026 20:32:47 -0700
Message-ID: <abddd433493324a6bfdf8ba9710e96d90f0d1ccc.1789010941.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 022bb3dc-e09c-4dcc-5a39-08df0eec643b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700016|23010399003|82310400026|10067099003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ei9nHSUwrZ7wotiRfXlSGwXlAOrFjQ7V1Dc4nnJ5LeNLOZvixqlKzsRqVAn5LgC9bdwKG/hteuuhdW/Bbx3pOLXMt57wrs73MkDJVIeYua+npM0fuWoJqiqmLwy8mYynTg+q5WoX4hJ84mY0EGfQkp71ZOs6I/P/kpoWj8rvp6SWa1fqlzNiaMmsSKIob4RC5RFt7AhF7QoqYuqrcoxcaJfjgZryYvhhap+1hFfI3KoS7gNpih5nkDcuKQrRw24BxgqESOUbb9+WUIJZtZ//BH61BggcKhxEYux0yTz30uutt6who3J6Jp13jDS/u/I9yzJ18YohPp+l8HJ1sh2IifwQxXSvHfmKltZWLCdZFRLopNMctKgmAksavVy99j0KUPmCGEschdwVTJgzN2gFXiRWaInMFBME8H8FXmqJTWQeRZ4/87KNR3oN4Ya0Wnn/fE/x5rDPQqIJTHl9IpLpXYENUqP3nrl0jQh4uUSM4j7Qr5kxrdg5NSkeImP8IhUxMhhChPAW/gHIgsieN3aiE9/YCprNng+QeqJUSpr8C8LHkim6zmQ+rJrDP0rotIinJ3lE5vUYLIHQFzTNeJc0O2tBFg+3I0T0KcyplT+ogptGT6DzpQaVuKhSUI0IzAQy2SlJZ0l4AdzAGaSN4+JrBFrEfWy3caFEJhJUbDF8+PpF+ZbEjTD+pj5BiI7nVhyc0t90zeIQ+nAvLrArx4sjEA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700016)(23010399003)(82310400026)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kEdK22RZERh211hZ3xj6GMS3vM0XQz6gSWzST4irWBXaHUC5oqLYR7NyrZYSd8rFizig1k81NHhDrjp6x16VwBtmS6vZy6WxGifkb9U5t4NR6yl/k0+CHFi+DD87+EOwWLGP4KFQU9gXOLxnfTj1YjcYvt5t3sKsjwr+jZzutvg0Hgvk05bzhCTr8rYzohyuDzr0TKJuHWkbbpiomu+12EeXSwAml2dVpz6f5ob4CsIQEudmkvPIxqNSV0iJNengrHwKNvTQfVNTekyt8o4ea2b5Dgml/AGENcWxmIYyWcpEgSATNeeDiNKFdqfOiqsFfx+Hd9JNgpfDYX9veaDtufyYYHasMXp1aq0k8arnvnxW7Q7Tmo524gUYANHnjGS1tI96+9AFGm3VsH7bmUrQKA3HZ5VLY95o0qn4Fw/Hr+IAQmDodMtTfa3gqM8cwhI/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 03:34:16.6401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 022bb3dc-e09c-4dcc-5a39-08df0eec643b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487

Architecture code can require devices to use unencrypted memory. This makes
the DMA API use shared memory for coherent allocations and bounce streaming
mappings through SWIOTLB.

A device marked with DEV_FLAG_DMA_CC_PRIVATE can reach private memory
directly. Add dma_require_decrypted() to combine force_dma_unencrypted()
with the new device flag, and use it throughout the generic DMA code.

Assisted-by: Codex:gpt-5.6-sol
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
index da665ca22d5c0..fbddab9740162 100644
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
@@ -208,7 +208,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	struct page *page;
 	void *cpu_addr;
 
-	if (force_dma_unencrypted(dev))
+	if (dma_require_decrypted(dev))
 		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
 
 	if (attrs & __DMA_ATTR_ALLOC_CC_SHARED) {
@@ -368,7 +368,7 @@ void dma_direct_free(struct device *dev, size_t size,
 	 * If the allocation used decrypted/shared backing pages, restore
 	 * the encryption state on free.
 	 */
-	if (force_dma_unencrypted(dev))
+	if (dma_require_decrypted(dev))
 		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
 
 	if (attrs & __DMA_ATTR_ALLOC_CC_SHARED)
@@ -436,7 +436,7 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 	struct page *page;
 	void *cpu_addr;
 
-	if (force_dma_unencrypted(dev))
+	if (dma_require_decrypted(dev))
 		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;
 
 	if ((attrs & __DMA_ATTR_ALLOC_CC_SHARED) && dma_direct_use_pool(dev, gfp))
@@ -480,7 +480,7 @@ void dma_direct_free_pages(struct device *dev, size_t size,
 	 * if the device had requested for an unencrypted buffer,
 	 * convert it to encrypted on free
 	 */
-	bool mark_mem_encrypted = force_dma_unencrypted(dev);
+	bool mark_mem_encrypted = dma_require_decrypted(dev);
 
 	/* If page is not from an atomic pool, dma_free_from_pool_page() fails */
 	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL) &&
@@ -649,7 +649,7 @@ int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
 	const pgoff_t pgoff_end = vma_end_pgoff(vma);
 	int ret = -ENXIO;
 
-	if (force_dma_unencrypted(dev))
+	if (dma_require_decrypted(dev))
 		attrs |= DMA_ATTR_CC_SHARED;
 
 	vma->vm_page_prot = dma_pgprot(dev, vma->vm_page_prot, attrs);
@@ -798,7 +798,7 @@ size_t dma_direct_max_mapping_size(struct device *dev)
 	/* If SWIOTLB is active, use its maximum mapping size */
 	if (is_swiotlb_active(dev) &&
 	    (dma_addressing_limited(dev) || is_swiotlb_force_bounce(dev) ||
-	     force_dma_unencrypted(dev)))
+	     dma_require_decrypted(dev)))
 		return swiotlb_max_mapping_size(dev);
 
 	return SIZE_MAX;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 11c127ad45370..e7c48a925b7ac 100644
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
index ded7016a46a71..d08a3643ded14 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1552,7 +1552,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
 
 		/* swiotlb pool is incorrect for this device */
-		if (unlikely(mem->cc_shared != force_dma_unencrypted(dev)))
+		if (unlikely(mem->cc_shared != dma_require_decrypted(dev)))
 			return (phys_addr_t)DMA_MAPPING_ERROR;
 
 	} else if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
-- 
2.43.0

