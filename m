Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011016.outbound.protection.outlook.com [52.101.52.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903561A2389
	for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758048385; cv=fail; b=f7eEZx/3/0LdQg0cvfzsXfgazSYB58YRuoDxPBX+24sPsBPIG0lHzkdixAYfXyhW4Eoh9dKEpEFoV1zpgEsik9AeM8DGALpzQsDL6GSWi8tZqrCG4gzLNh2pWrsofj/BcFLtpZQLy9zUt3qkcgjgNV/HYuR3LG2i4LBorM6px84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758048385; c=relaxed/simple;
	bh=+m83GSOZJhhfO48czw+yn98WdevXGwCcHsgYhVwXxOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=msB0u1w+cGn2SFNYvh98+z8i3x9HLRwXEE6DqddoU7ZF79IR1bs/Gce2VLhT+F0+mk1q+l13aDHGFUPlcs0ArhxHVKT0PJtNYKuFld+D/QbfRpPvf6cl5PeoISIFRDf6oVzPxXFWejox3F1Dndaw//T0hGlN9/S/yaO253+GvOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CR3sfK2X; arc=fail smtp.client-ip=52.101.52.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CR3sfK2X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWh9bvSmlH+GZIjINp4lqo5WzZiUbXU5YzU7xMWNjwVVpbF9JtfidiOQz/FLzVG01du5VwO/cxxEgy4ieN1ZrlQfb2mQvz+F/TS2OqJRQ6pL87g2qcod543OuMH1U0xXdajRbJqioCNViF0rFYtDo2udTVZJL2DegJBit+4DluqHK+RDNX11aeVsfbkhjMp00dUdU+O5BLQJWFCwLKJ3pjmtva9+rBKIz++vTxOeFMMy65EXN6DqKBPtx/Udp9lPvm3kBRNrMz+hPElDdRHNcq9agmL4/x7BIRcYRrwkQohDfCasxc4Fz9VdS4QRFoYTGw2FZDAgrTzAq7NNBkmSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0l5C1YT9sZtDykp/atqZH+Fe36CKjFKk4LI3/5mm9YI=;
 b=Nqtjet6zRZkweV7d59CgXl2aDNxQnCtZdkwYzdA9jt9RI8l6EZhKOKWIe46JcmC4NkuwilQgS4w3l6FTz6XIqG2LPQvwx9WQzFwbpBNXgfXISIGfRZHCtDTrqxFSBpBEk5chjqJI51gvzq/HWFV1sBlv6WfQRBiZHU/u4jRhI9orl4PelDVvE56rKCpqwAwj6/tU41Uc+3nSQKDxUlMUfe+9yaTHblaoH+uuQaUlY+F+nvKW7BHiimAeKITiIZVPVZOgicE5YEPjuVyvSI4goc9zsxMqF/lhDm5LMCuetJi4TqBNajvi4G1JhHuXGbRCOVxyApxcsTZ9RxFl2aI/mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l5C1YT9sZtDykp/atqZH+Fe36CKjFKk4LI3/5mm9YI=;
 b=CR3sfK2X2eKJSNEnnPX5W0t3qVaaStwAe74EYGiGgtwkrve9SOP0JGr2/8QBVZmhJ+BsCPgUx4DbqUL04tvxesPYjgJAGCQ68WcKWWwEz9zPrVacLeGaRsUw2Xbm4bkhhNl91l1x3E+0jpZYC/JUZyabKb9el1eVeR67K/wCn3ncishKKVW7lxf+KBKmZf441Lyd0mrRuu2kbpXvxXB127naqtRIjquHJ8Zw8m/qkPUJ953IkPWOJsg/8FIjwvnkTLZPBNY1s6ISL9Z4V3Yep5uQoAZAc/zZrm7axYS/RYN+nAlEAezidAyo4xRWcc6/uUO36+RJbVeLg2VRC00HBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by BN5PR12MB9538.namprd12.prod.outlook.com (2603:10b6:408:2ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 18:46:20 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 18:46:19 +0000
Date: Tue, 16 Sep 2025 15:46:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Leon Romanovsky <leonro@nvidia.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v3 3/4] ARM: dma-mapping: Switch to physical address
 mapping callbacks
Message-ID: <20250916184617.GW1086830@nvidia.com>
References: <cover.1758006942.git.leon@kernel.org>
 <5f96e44b1fb5d92a6a5f25fc9148a733a1a53b9d.1758006942.git.leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f96e44b1fb5d92a6a5f25fc9148a733a1a53b9d.1758006942.git.leon@kernel.org>
X-ClientProxiedBy: SN7PR04CA0105.namprd04.prod.outlook.com
 (2603:10b6:806:122::20) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|BN5PR12MB9538:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1c6cbb-ec54-439b-2c19-08ddf551533f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HF4GMlG8cXx+y5Kf0IfHsJMSSNIBr29hV1Uvhu0h6UwMrg7cUkL/sr3RRVwg?=
 =?us-ascii?Q?E5AHKQ+iQrXkTPT1OXT1UQ+/MYyLhoxCwSCjUaWwC8/XdtJy7HjrvzZhcJ31?=
 =?us-ascii?Q?3VunAwG30DGtOAcWpselIPqTBcHSlA2dTG4gNzDYSADnu/W3XlRMzW+jeqJT?=
 =?us-ascii?Q?mlfHPsVBm5bhe+EiE0CsySkOIuwqhA3axdQo6IKWFJzp+LmS4MBIcrhpTSxQ?=
 =?us-ascii?Q?+WBHE1WoZS6EohO8AcQCCCCBZlp56cOr3MpOr3L2fCO3pLFpTXW/QK5JMAEq?=
 =?us-ascii?Q?6hJ/POOcE2L5Oo4qYRrO4O9Ez+vNV6GrRiDRoeIbTYjOVTtX7SXOoYW6VV9B?=
 =?us-ascii?Q?0Vn/D7E84QtTBLMKbve+MEVcpDkLQsuqXPLc/ONiZq9KVP2tAdoWfAQ8DdKM?=
 =?us-ascii?Q?tK+pbO8mw7nRAKY/GubmtC4J/QbQRlUCW5T/ETZ7f7VhEGAMrQDOVBJNqy/B?=
 =?us-ascii?Q?lOXYi2BBBBqQQ+CB3IrQKc9AUgr7YTigdQqOOWBai4e3VQg9s395VbZdjmTc?=
 =?us-ascii?Q?FJoSOqZf11GMO7jZ3XRmBA2qiWhH2CP8ZmiZTDjJQmjWRuDpuHRFNH56pBLa?=
 =?us-ascii?Q?at6roN+eer1IB9unp1/1kETukt4dz/WNX8Ds0JBOy6YB6mXLOtEwpL7l6KsH?=
 =?us-ascii?Q?cCVuqBx7fpIQsj2Rg8pOgN97aUQ4iG9ehFeaELxsajeTGJJc6wxRMThSIVNm?=
 =?us-ascii?Q?9E7f+nM6nu4rnZJNBN0+g0kBAbgc4kiCZRx0S2jbK6CEMT57EY6vvz4BNqyC?=
 =?us-ascii?Q?bZe1aroPMNY10ex0MfWyndwOEK4cctL6QlB8jPdWWr/yso7Yu/fvAqp20iuB?=
 =?us-ascii?Q?akEMbA32i9WESMy1klFYhX3DQoSrX87DOtZ+483R9he92/IkMvaPuEVgIEaD?=
 =?us-ascii?Q?6EmH8ojAHA+IupN0Bn3MJrwBBE6DmqK11Kxoah2Z512X1O95IRPlvpTtCRzY?=
 =?us-ascii?Q?zGlGuftKHTnYjUXYVGxsW70c070dwJOqLJtzZ3qBYlPHhJIYXt8bdeox89B+?=
 =?us-ascii?Q?yKKbHwYLwQXihAHMExXtUFjqsU9/lKbGoUAQQx+3tvasvEfVfsiLAdp/xE9J?=
 =?us-ascii?Q?rPT6reOMNhmPLI9AVke+wwADq8EaFqBCne2K0VdbPQKeK90JBCL9peSgvK2M?=
 =?us-ascii?Q?APYiI+5wAdMIjg1ljmdmdTPLIpxe9Ox5M2b1Co1V48OBOGjLm/yAhgdrK3YH?=
 =?us-ascii?Q?fPKBTx8OqD+yJei5TsTHOYzM80jWFuzAc+wx+exQq1mw5JFDGJNUr7ulcvsC?=
 =?us-ascii?Q?cd9Qj5vnYZZbGT3KZWR0XfGuoiQh9BQtU9IOCdB9brRMx8kWx9A8u78NRoAg?=
 =?us-ascii?Q?q/v/GRdlVSFwxhgQKlElQNV48AExpFb+WWMva5INHUdnCKmUqBK5uBgy2gAn?=
 =?us-ascii?Q?zXqGeUXgP61QpFgM7eP2cxncSnb3GMjHZdbnpKNFg0SeqKwW3kVKiZFoWW+I?=
 =?us-ascii?Q?OFLu07P/kHo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JLZP2Zmr4VnYXqmmvOfPIj51rwg7AbGobfBWifw/YFObu6tBPIA56BfLSrTZ?=
 =?us-ascii?Q?sAPNTDkHWprP+2oA8rqHSZpVStEFwshxySlDMdrqK0ZEse0NDzjhnPOtKh+0?=
 =?us-ascii?Q?qvu8VFdr1qowjDwCGqtSju+l3nUmkYHWDO/Tj5xddqpiTqPJZUrpF6j5dF3D?=
 =?us-ascii?Q?DBHtrlbj5dPuLd2NkpKlZSCo6y62vq0X7bQQZDLo35IkDgAYizCvc3OCEraZ?=
 =?us-ascii?Q?xRhkFCEw2t4IaP5EDr6NS30HpXvO2r0kA/UQVL3WHn5OU9eWcuJWXnlsoPqY?=
 =?us-ascii?Q?PSjBBDNE5DDcrrIyj0Nk3jWGCUujTPOo+E3waYzKMHPiZUCBnyINC2xkxtOC?=
 =?us-ascii?Q?CJVj4SKckuw01giMTG1cpdUizDEuWVaD8gJR0lrh8w1X4ndHc449bIMb3PUV?=
 =?us-ascii?Q?G3ERGlTH0+IwBe1naz7y2wYswAZ8A5vEeixFlFmE+LeHubS+De3LjAKC4KCI?=
 =?us-ascii?Q?Xzzni1XlvyVxppkPKx5CBylqxbN/eTwb9aZfEWvsZiD4ZjUpE+2tfRLRE03H?=
 =?us-ascii?Q?7TPPAn/Y0eMpqyo/Ex/te27mzKw7I+fK6FYrA0Sjm0Tf8iGBBENVkZiBvJ+f?=
 =?us-ascii?Q?GECF9uLXOJ+tQhAGCN8iAe5eAia0DQzapPsVoBs5qxY5zmeDRYA/LiFFHPFS?=
 =?us-ascii?Q?0VbY1aAzAbUP2gqDbHYOR5noASdkxOm0saPujtM2XgF36VKFt3zIg+OCGYRQ?=
 =?us-ascii?Q?xvwAioErE3v05GPBk6gnlwH24RX0hZTxIxsP5RYwSN8cFaN+bZaiQ5RhunnY?=
 =?us-ascii?Q?eaChhZwvGu3jJYn3qf8AmOgUIwZnfdfYqbiS54ENAutgeuQcBkoaiXX7GaWL?=
 =?us-ascii?Q?VguMGvs2mEmHzNx5d1wzZbDLAestx2pJzyFtFeKWlRaTxoBHs4141ZOH0mqV?=
 =?us-ascii?Q?89SjC71t9BkjI/HO+FstRb0QPkI8laDSbaKeNFdwd8PDCV19KOkvSYu9zS6p?=
 =?us-ascii?Q?XucAGimEQwMfgU1HeUtzBC9sOQlQ1Nr4rOJ5sL8zf5aMNwecS2mJPoVQbkgA?=
 =?us-ascii?Q?oN9qNKHzWlwDsRFZsnGSQy/U7FCC0Td6RXQRZx2UFsaJi2aHNsVZ035VcibV?=
 =?us-ascii?Q?TQ+9/7VovlX8ibC7m4X7EiCaKjN6fgdMyboFMBWtT2VD3bG2EX1dMBQ+oXnX?=
 =?us-ascii?Q?V2BIs3NwVoaywsc4CpoDjH+IqoqVd9OQB+jJWu/EABjmXDQEhiHaXM9r3qxm?=
 =?us-ascii?Q?9j+5rayj/VSbHXorjmLSBDo7VKhES+kDp/cBP2e0rRPGriRGssBncIUXY3Xn?=
 =?us-ascii?Q?QJmngNOFpeio1EfPi7/lssg6W6QsF4EfAYE7kM+teGL+jR+pWHjTlkyJgn5M?=
 =?us-ascii?Q?bdjXcnme6Dn+ttXlIWaJwH+6Qv6rEDiU3MDXXQKV/8aQuWRWBVw/JI64mNY2?=
 =?us-ascii?Q?YutIULbBNEvVGKcsnnTkIZqNw6xk6wwdlw4cxLCIlAgor8tEV7ai5leFQg9a?=
 =?us-ascii?Q?/btHCPncXbXQnp8K1RK748bpovdctjkSPig8wpmGnVDth/qTFbj/0QDgN4D/?=
 =?us-ascii?Q?ne0X5W66fL/zkBowEads8HraCDit1JmVBju4ySTuVcPJVuhJFuqdMrs5XJAI?=
 =?us-ascii?Q?4LjGatX9SokxVO5+7CONvPZ3Lg2IJzvrLBrxIq/D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1c6cbb-ec54-439b-2c19-08ddf551533f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 18:46:19.6153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxGDM5vP+jg9Xx/NH8xlov/YAm900WCn8KtSt0nqy4ECF/DPHWB8bZ2Ucn8vbMza
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9538

On Tue, Sep 16, 2025 at 10:32:06AM +0300, Leon Romanovsky wrote:
> +	if (!dev->dma_coherent &&
> +	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO)))
> +		__dma_page_cpu_to_dev(phys_to_page(phys), offset, size, dir);

I'd keep going and get rid of the page here too, maybe as a second
patch in this series:

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 88c2d68a69c9ee..a84d12cd0ba4a9 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -624,16 +624,14 @@ static void __arm_dma_free(struct device *dev, size_t size, void *cpu_addr,
 	kfree(buf);
 }
 
-static void dma_cache_maint_page(struct page *page, unsigned long offset,
+static void dma_cache_maint_page(phys_addr_t paddr,
 	size_t size, enum dma_data_direction dir,
 	void (*op)(const void *, size_t, int))
 {
-	unsigned long pfn;
+	unsigned long pfn = paddr / PAGE_SIZE;
+	unsigned int offset = paddr % PAGE_SIZE;
 	size_t left = size;
 
-	pfn = page_to_pfn(page) + offset / PAGE_SIZE;
-	offset %= PAGE_SIZE;
-
 	/*
 	 * A single sg entry may refer to multiple physically contiguous
 	 * pages.  But we still need to process highmem pages individually.
@@ -644,17 +642,17 @@ static void dma_cache_maint_page(struct page *page, unsigned long offset,
 		size_t len = left;
 		void *vaddr;
 
-		page = pfn_to_page(pfn);
-
-		if (PageHighMem(page)) {
+		if (PhysHighMem(pfn << PAGE_SHIFT)) {
 			if (len + offset > PAGE_SIZE)
 				len = PAGE_SIZE - offset;
 
 			if (cache_is_vipt_nonaliasing()) {
-				vaddr = kmap_atomic(page);
+				vaddr = kmap_atomic_pfn(pfn);
 				op(vaddr + offset, len, dir);
 				kunmap_atomic(vaddr);
 			} else {
+				struct page *page = pfn_to_page(pfn);
+
 				vaddr = kmap_high_get(page);
 				if (vaddr) {
 					op(vaddr + offset, len, dir);
@@ -662,7 +660,7 @@ static void dma_cache_maint_page(struct page *page, unsigned long offset,
 				}
 			}
 		} else {
-			vaddr = page_address(page) + offset;
+			vaddr = phys_to_virt(pfn) + offset;
 			op(vaddr, len, dir);
 		}
 		offset = 0;
@@ -676,14 +674,11 @@ static void dma_cache_maint_page(struct page *page, unsigned long offset,
  * Note: Drivers should NOT use this function directly.
  * Use the driver DMA support - see dma-mapping.h (dma_sync_*)
  */
-static void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
+static void __dma_page_cpu_to_dev(phys_addr_t paddr,
 	size_t size, enum dma_data_direction dir)
 {
-	phys_addr_t paddr;
+	dma_cache_maint_page(paddr, size, dir, dmac_map_area);
 
-	dma_cache_maint_page(page, off, size, dir, dmac_map_area);
-
-	paddr = page_to_phys(page) + off;
 	if (dir == DMA_FROM_DEVICE) {
 		outer_inv_range(paddr, paddr + size);
 	} else {

> +	if (!dev->dma_coherent &&
> +	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
>  		page = phys_to_page(iommu_iova_to_phys(mapping->domain, iova));
>  		__dma_page_dev_to_cpu(page, offset, size, dir);

Same treatment here..

Looks Ok though, I didn't notice any pitfalls

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
