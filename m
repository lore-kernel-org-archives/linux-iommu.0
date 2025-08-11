Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041A518C91F
	for <iommu@lists.linux.dev>; Mon, 11 Aug 2025 00:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754873465; cv=fail; b=In3yiESj+fgMSKrglM/M904CnL60xjf/iq3IukIKaJPa2i8Oez0M4vbH32QIBFsATVSMsBjAM96y9SH4b53tEwGZ3hoX9nx8atGY4BUZfEKM3IrSQf+sBD45RS2XJZ7zzxVrgDx0HhfRtchyiyOmdWJwrgJOTU5pzqYbq/cJpm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754873465; c=relaxed/simple;
	bh=EdsPOA9EQO3APwprMGTm1Ns3kzUsOOlxuFYwnCBjToU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqzcCcgk0Vq/gl/NC3g9e/6tHACmK3IYkmzi4f2hSLgzsU7U6MhPxODYf1VkDDYkruOfYXtPPwO9/UrynqFfZAry+TW8huIYo5fs2hs4kPPS0Y1xIzGytM5oZW2a+9G4Y5Fsabtgd5D5MtrmVdvoS6V6fWk6b6AvLG7wM7TO+ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=knvbJsdb; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="knvbJsdb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7GY2K07ua/ClUcF8Mt0jSH224n5FIK0qqqhYHE0CZsoDHKTaMG5LqYKratY8LoD6XX2S157Iq2FE1Oc2NYdKisD7cgAylPaEI3xEwx+2wMl+a8BPQXUYnGlsHG9ox4CaAGOrGV+97Nw5+NTAklR6xdnlJW3Xd9SC7ymOgahYiQRpWyV0CtPvjVGx2+Egh+5MOUxhLtibWJ/qL3YUukz8uCSPM+mK7jooO+pK19XarY5PE3X6kPGvS1aUi5QYHis+hS77bM2m6m1UrQc8QP40gHeKOXiHO/pLMaNoeDetTFh+Uw6ABrtBG8EINxgSHD0JCHrmZ7ZZmyoKH1sca5mZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8QeFn6PAVZ6dL8kyXWB12JzjTGB+tSQzB7fYiIvs90=;
 b=A1FYQDP1SulUKcmUExrgNuNbsFKvgFtTd/BOSQVq/1YiqIxZRePzCXm+DNaHiGpWS//2Vk/f0eccrfoqwXJREH5FfHY9wie8eBz5GpLAZSjx52rpMFowSGu3SyQkmQPT9HFXcKIpqovuxoZeY+T+/URrxU1KKGcPN+Da99NQRqrc4+Hc5dEgOcp6tIoq/PgZouUSB522N0MsI6xfRyYhKF64z5RutS5HA5uk0XE9F3l9ayQXzScz+olVy/P7BAgjke3+89kk9eDFn3mgGLX/qkxglEGS1tjdpt8BJB9eHlxLTmp/WJamN3Bn95uI8PrbLIoXtvgZPf8RV6It2LrHPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8QeFn6PAVZ6dL8kyXWB12JzjTGB+tSQzB7fYiIvs90=;
 b=knvbJsdbc0rAyEv5CRlu6Roc73a3NhDXkEb6Wv/aBnKFR02M5vS25uhrIw4nV3k3x55A3pxDNX74ACsNsh5nVlsYz1bN0tcYht1beg6Zrl4zHKuognpEBT+lUnWX+j5w0qbh0AfUsf1G3u+L2QityySBdRr58B62kbXSe3zTVn+1XQbsV3HTUAtdwzcpM/nz4YwqF53LyTXpFSkYHYQJL4LA8Z/4kl+Nyl1bM1komZvwM753L9P4wNVqZJUiDtoclu1hj0nPsiQWjNObrnBHQqyWkAd+d2Q5Ewn8+EcnI//Yf4s43wG+nn4krs421D8K9siJ5R0sNWlBH3snG2xhxg==
Received: from BN0PR04CA0198.namprd04.prod.outlook.com (2603:10b6:408:e9::23)
 by PH0PR12MB7886.namprd12.prod.outlook.com (2603:10b6:510:26e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 11 Aug
 2025 00:50:57 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:e9:cafe::1d) by BN0PR04CA0198.outlook.office365.com
 (2603:10b6:408:e9::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 00:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 00:50:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 10 Aug
 2025 17:50:43 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 10 Aug
 2025 17:50:42 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 10 Aug 2025 17:50:41 -0700
From: Shanker Donthineni <sdonthineni@nvidia.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Steven Price <steven.price@arm.com>,
	<linux-arm-kernel@lists.infradead.org>
CC: Robin Murphy <robin.murphy@arm.com>, Gavin Shan <gshan@redhat.com>, "Mike
 Rapoport" <rppt@kernel.org>, Shanker Donthineni <sdonthineni@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>, Jason Sequeira <jsequeira@nvidia.com>, "Dev
 Jain" <dev.jain@arm.com>, David Rientjes <rientjes@google.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Subject: [RESEND PATCH 1/2] dma/pool: Use vmap() address for memory encryption helpers on ARM64
Date: Sun, 10 Aug 2025 19:50:34 -0500
Message-ID: <20250811005036.714274-2-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250811005036.714274-1-sdonthineni@nvidia.com>
References: <20250811005036.714274-1-sdonthineni@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|PH0PR12MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 116dee15-1727-49a2-56fb-08ddd8712222
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mqxg1v35bG+MUHnj7igPo4Ua7vtc4rohRqgn/WIXtSFhwvTH6coMyS1/mxd/?=
 =?us-ascii?Q?inQWoxl1/B4+LPLZQaee9dBk1iufLB1tZgVxAC2xZDVYlqwoRLx46bSAOVZG?=
 =?us-ascii?Q?isW+08o++wnxYg5l7QuK9adMJSXj3ojxOTyT8HgfbwEaHFEwaPkRxCAn9GKu?=
 =?us-ascii?Q?sgW+o4LCalCOmGYWFGE1PHp9snp0MK40K+CphksmKG8mJOyxjAxLsYOOx+Df?=
 =?us-ascii?Q?IvqVXET0ZkQntbV+pUtTFOKpUwODanTsaGY9+SQ6VXC51pr8+AaGe+b67hSP?=
 =?us-ascii?Q?NhdpJPwc/M64RbnhOU+/fiRRN4WNGhc7reQULN8yAPYLEqR2tfk56eWbf72r?=
 =?us-ascii?Q?0w5ydl759+PtuUTo4f+lMgnsia7TEC3Dt8xgXZRgZMkmvA0J0idYju3Fty0r?=
 =?us-ascii?Q?HLnKaw/GOoS1yJ79e3cS5fXRweXvCWjmEn8tD7+eoPCT1qVpFQExgHHRdTot?=
 =?us-ascii?Q?pAVScm9/uP6UeQdECiVqsDtTcYjouPy2PbGRSTZBhuUnPPmhtNJ+3u2ABjh5?=
 =?us-ascii?Q?UquN1IoDOQqPNlNCZbVCh6dE0201gSwF93s5LNxt4EKEpZHla9DD0htuza95?=
 =?us-ascii?Q?e4uDK5fEHAK1Z7osN17mJQGg0e8RryqwTlqTMRN9e/5kBJfV7aLjqkzpdHmG?=
 =?us-ascii?Q?R4CXUtUNkheM0g9VPSuMXUPW7VWCXiIDRpKX0boRFZRBJ0d5HwPtiMfk4qFc?=
 =?us-ascii?Q?Fy1NhFHJgsR1/8qsdYeY+qkkt7QcDDkwIid2MZjcqHF+XInwHEs8r7U31SZ5?=
 =?us-ascii?Q?p0XL5FmnvYnd3FIAiQjymhTzwsG+e8Qv4VatqfFs4Tp41BuaGMqD4D1+/nMg?=
 =?us-ascii?Q?cVNcqr8meAOMsOil0LogP+LcFe75xpRdo1kD152aVSQbELQ9ZGBuhQ4nCFzi?=
 =?us-ascii?Q?v2qk+PRfKzZfZ9XlGWiMyJWl+wEKAR4ZufwhN/DIsbyvPBUjVzeyojChhZmV?=
 =?us-ascii?Q?z6hnK9XPYKOXYL76qmDQH4lxrcHPfLatGC9K9/Cm95fXfUPOMWzg2LT1Kx9a?=
 =?us-ascii?Q?DrBD2m6qBJ6Tk0qOd1aufvjy+fA7O5DvEf+aloVqHLs6kuIgsmWPA3J1wiyv?=
 =?us-ascii?Q?PkioZTSV3gJebvjWSwRjYUSnTAiWSmW0K571IRbUsWwZZLKoskqG/CjZQfKc?=
 =?us-ascii?Q?iEp6cBd4xJmiOl1blaoY6oS6gnMWJRaBgvJqCLey4FA7JlrFdD7ywbhaLUDb?=
 =?us-ascii?Q?S5PDQrXSBCB3c9j+vctAVFiF8lWYunnIscqTFRVyYn9k6HxbuR60vcftRe2e?=
 =?us-ascii?Q?qkgNXF0Yuu+JYWMrkHc25I/+v7v98Z+w13bd2LW8+UabnLHGbZ5f+i3icwpW?=
 =?us-ascii?Q?t+cHEc28iMNhUUHrVrKYTD+cIPftpEYt1blkpiJCXjQDo4oqy/3rh1i2OI44?=
 =?us-ascii?Q?hvuShGbjaVolkZAPEn9Nhzd8+A4x58UuMoRK25B1mLHj1TLtZoGQ3s1ExlGv?=
 =?us-ascii?Q?VfynPcVEXLCyuEUwtVsi9VvHhj2OZEWqas8A/IrBdoB2WV3xdITYTh02AB/s?=
 =?us-ascii?Q?exg3uL7v9pRB+5lk0lBe9VCwil0Aa/Z8HSm3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 00:50:57.0289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 116dee15-1727-49a2-56fb-08ddd8712222
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7886

In atomic_pool_expand(), set_memory_encrypted()/set_memory_decrypted()
are currently called with page_to_virt(page). On ARM64 with
CONFIG_DMA_DIRECT_REMAP=y, the atomic pool is mapped via vmap(), so
page_to_virt(page) does not reference the actual mapped region.

Using this incorrect address can cause encryption attribute updates to
be applied to the wrong memory region. On ARM64 systems with memory
encryption enabled (e.g. CCA), this can lead to data corruption or
crashes.

Fix this by using the vmap() address ('addr') on ARM64 when invoking
the memory encryption helpers, while retaining the existing
page_to_virt(page) usage for other architectures.

Fixes: 76a19940bd62 ("dma-direct: atomic allocations must come from atomic coherent pools")
Signed-off-by: Shanker Donthineni <sdonthineni@nvidia.com>
---
 kernel/dma/pool.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 7b04f7575796b..ba08a301590fd 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -81,6 +81,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 {
 	unsigned int order;
 	struct page *page = NULL;
+	void *vaddr;
 	void *addr;
 	int ret = -ENOMEM;
 
@@ -113,8 +114,8 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
 	 * shrink so no re-encryption occurs in dma_direct_free().
 	 */
-	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
-				   1 << order);
+	vaddr = IS_ENABLED(CONFIG_ARM64) ? addr : page_to_virt(page);
+	ret = set_memory_decrypted((unsigned long)vaddr, 1 << order);
 	if (ret)
 		goto remove_mapping;
 	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
@@ -126,8 +127,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
 	return 0;
 
 encrypt_mapping:
-	ret = set_memory_encrypted((unsigned long)page_to_virt(page),
-				   1 << order);
+	ret = set_memory_encrypted((unsigned long)vaddr, 1 << order);
 	if (WARN_ON_ONCE(ret)) {
 		/* Decrypt succeeded but encrypt failed, purposely leak */
 		goto out;
-- 
2.25.1

