Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3A0482FF
	for <iommu@lists.linux.dev>; Mon, 11 Aug 2025 00:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754871864; cv=fail; b=ok8GLRZ4gaaQBiEFffgn2g8dwE6XYa4La1qXgYxGc+5JdMEJfq3vR5tthSBjGNNC6oJmD3b/VfdN9u/w1XE3PEgk0571bOn6wLdcijqgQF9lcncPwpLnrytZttFqH+ChtDpyHuEqpc7CS95a30AhPGyIc/SUa/gJmBlv2a6e8A8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754871864; c=relaxed/simple;
	bh=EdsPOA9EQO3APwprMGTm1Ns3kzUsOOlxuFYwnCBjToU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CmtRDGEfjlqTd/q/hWC1Y0ABIzJp/QJr8yqNgQilQCcBYLwMHn0lRDttSJN3jLH9NtFmwcObYf4UBuVkCYoHlDCeGAO8JBUBm6Ywyq72jwjq6+1SX0zDFBEEXdWigC6m4YxPfH6k4V52xUrt5F3yifvMnO+I25W9ZqXV6qs6O/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m4DvCOJA; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m4DvCOJA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rtfGkCFtq7Cd5G7rConXTF4/TZ6mdSihmRW6lO4LMWvW7JrxgyzJ0dE6Wf2FSPWeY4IHD6YvNHiXq50IjP6XK9GYtC7hl/7yH8e+68St2jrYV4Ww+OBSzC33ydDy6hM191NEjxlzhWws1kXQsp93TfJq7Vn058nccSe968fhqUQtMc9oklUTMZFBE2nJvotst8EUXnEBkReZnGMJ3DDL4vC9B5Q2/SBDn+D3YkF6GfCjJPPjzdCw5n86IhYJy+RdJ68+sOk5/X8BhG/xFwj8ZHxkwM0CuHwv4la6yPGijXMOt/CZTeFtUHpbN1PmtRTB+1zKzzeGNafqZetACT543w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8QeFn6PAVZ6dL8kyXWB12JzjTGB+tSQzB7fYiIvs90=;
 b=zG/0zqra0ECmZMGa4K4dzYDzv3VFajrRftJcdjPqeejwHUrGjk4GuJRzpuqPqHXySsD7qKy287FQhvI+hD05cxlXsAuLO3Kjh4p8zlNW9X1m5KZ3s1yVqGFEfg4vxfQTZzDAPH5vmYpeE9s1/7Dz4PANGVzCiyEhQEk3z6fRBGqCxPQg3sMiaLxnBpGZnlAouDBAzEZRSDS+v3c4jvodY5A3jNBITEA15aG1IpsUdOPsz2FHy6453HTzwEvDVN+0Ia53B7M60Cahbx/YuwSKPelS43nK9HEtkCbIdZfhX07dz08aDHZvmVGAT3wBowgWKYamyTgSfH9GIkIZHNEYbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8QeFn6PAVZ6dL8kyXWB12JzjTGB+tSQzB7fYiIvs90=;
 b=m4DvCOJAPUJf93y7b0nty6i/P3ob97D+F23I2wXveNtpZfH7kot8CIDnFxVa+QJk8KhFlQM0MozzEL2CMXqZvHBjWdn9KrgzWukd/QOmU2Q/BMjBnqLkO08FQ+MpXjd3NnE+2t5m7lW+X/mteeF7KWTo3p2XeAPZCADSmqeB57MdXYCVhEnPLh9DHukJkun9sa9O1hBjJLfqaF0sflfLAKBbtWAHtBL8W/aolb94WEiIZitxCtV84LYMsfnHRE0X6Mh+AWouDqFElmj7nK1UJubbBzKjHxt/EFDIwan+H48h6BnfBNXwKRsQz4kE39vItedDpDE1eEej1J1uPa2wlA==
Received: from SJ0PR13CA0065.namprd13.prod.outlook.com (2603:10b6:a03:2c4::10)
 by CH3PR12MB9169.namprd12.prod.outlook.com (2603:10b6:610:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 00:24:14 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::94) by SJ0PR13CA0065.outlook.office365.com
 (2603:10b6:a03:2c4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.12 via Frontend Transport; Mon,
 11 Aug 2025 00:24:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 00:24:14 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 10 Aug
 2025 17:24:05 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 10 Aug
 2025 17:24:04 -0700
Received: from SDONTHINENI-DESKTOP.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 10 Aug 2025 17:24:03 -0700
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
Subject: [PATCH 1/2] dma/pool: Use vmap() address for memory encryption helpers on ARM64
Date: Sun, 10 Aug 2025 19:23:56 -0500
Message-ID: <20250811002357.714109-2-sdonthineni@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250811002357.714109-1-sdonthineni@nvidia.com>
References: <20250811002357.714109-1-sdonthineni@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|CH3PR12MB9169:EE_
X-MS-Office365-Filtering-Correlation-Id: f7376631-4c05-41e3-f1e3-08ddd86d66b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9enZ6f/rriiLlpzcvcRJNI9pxPynjty85fOQxVFmL4RUjCOi7O1Hdx45rKeH?=
 =?us-ascii?Q?VBobEX9LQvzro9vqLvIdwalmvK9dM4pRy1pbreeID74JWEbJKVhsfA1mQrLK?=
 =?us-ascii?Q?1rs6p70qdBiT31wavy7ICV2psTDNcacAtjXv1Vf+XPXaWWOyMP1pYFJ3F+/r?=
 =?us-ascii?Q?jwXvtgR//UJOZlkPioUVkTXva+kC4VeT1rdxvdN3g+Nm9sPc3zj4ZKKJmAAl?=
 =?us-ascii?Q?TiZZZl1MdZaN8NMU6Rk64qXp3H08jkIDwF53dzxNnBdP02mvyuFPPWD7MNzr?=
 =?us-ascii?Q?EMP9rZKyXgijBRyR5hF2a1OEYReCxiz0w6qMob3y8rvhAv+kL6EhoVsDPQgf?=
 =?us-ascii?Q?5D74Q9Sxxso49qLJbZqh3e7NaailFA7EbmhqPFrlP6SxZPbkgkdV2DGTnStf?=
 =?us-ascii?Q?MPJNg6yaKZ3AhXBR8jf0Y8+QBoWBMRYqud1k0tT2bomeW97oxRA7kxJY/wNB?=
 =?us-ascii?Q?Fp4Zaz+dXTugvd/CtGgGCV8dKN/I6ZCACic73jx8K+iHR0CaWUoMOn5UPgGe?=
 =?us-ascii?Q?VyXKlFLKORQRFeDUZDXZYOxBdzfjmXWEzYKKSJQDLA+HsxzV/zZgTugZsAOZ?=
 =?us-ascii?Q?Yy3zac7u/vschzkHRt1vY7jMDcFRA8ZFu0CaINGooHGSvNYUs4zfNlbj/JG6?=
 =?us-ascii?Q?zvk0uJL4R/oW5ijq92YgeKnvJHCFggpZu4yx3W1fvhS06ZSGZJkKeNEAY6ZA?=
 =?us-ascii?Q?Slmd7W/CCxCamt5qtko+Geh8rW66dq0+MH5zHqvIwHKeBRMPH22IZ7OmYnoL?=
 =?us-ascii?Q?JwuI8vLKVCn/PDEE7nekYctyqoPC0w+lkBF8/MdWJ7zeLtGAtcr/FzEe369z?=
 =?us-ascii?Q?yE9A2hollf+ISYQxztYLfezZf4gP2L30A5/okVT0kAY13MTE8n+BcuiASJhJ?=
 =?us-ascii?Q?dIN7hfR14h31f9oOr/FIMO/s7nMBKDRrih1LR7PusK7PVlQ0LRik3ygqZ8Gn?=
 =?us-ascii?Q?ZXvSCumtzqfjeESdv4LcHZq7K3+zg1qQa6tSI26teD1P0LPqZcsKdr4mwRf4?=
 =?us-ascii?Q?+39gCgmvnyH64+hw0m0sXnIBG4Gt8OOMX3FE3f2geKXLv+n+xrX+teaBgLkD?=
 =?us-ascii?Q?CVQRZ+h1vRVeFtJrJfq/5jnYJYDMpaez6ZSzNIaksRO8fHKCyPkP6TX4+TQ8?=
 =?us-ascii?Q?30QOnholzUKWL0lmvqnd9ak7sCqhUfs1Bz3Tj3kKJESDzgexctBVTptnKZKk?=
 =?us-ascii?Q?Of+3DHCSkkN0Dz1WBkRId1uulQIAkisCsa3pu+oCkP6FtiVojlMXZUFRiq9t?=
 =?us-ascii?Q?hsnwUez8ENsgQrJy0nIB1kscRPJl9mZal7OxFYCTkoPBT8Ip/mHblIX79jn5?=
 =?us-ascii?Q?KQt8vRusNAbr1LHHCPe9oYK1okY7lJaqayya+nzGTJiL59+8dQs6urACmvDg?=
 =?us-ascii?Q?UdCSKCbE8qMnTRUcEVTy485uMF5u8loMbROPacNTt9Rn3uGDrjb57QEwnxeI?=
 =?us-ascii?Q?ajZXoPcw6MQ4JmnlHEj6dKMVxO6AEf3kbpS79trpIslI92+33jSdpq3/sUUX?=
 =?us-ascii?Q?Le5So+hWYV/U+OKqZNQNiTjGKRAzajjepDNz?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 00:24:14.2431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7376631-4c05-41e3-f1e3-08ddd86d66b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9169

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

