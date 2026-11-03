Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793723144;
	b=fbH8Ch4QoFi3+RjeKGI2d7NyHEVdnnpxU2WY1IFYj2Urp7OMLUhaAoZtwwFtrGiY8snn
	 H2VDtodYCKhaUpBt4pcwLf+JaIvAqVtXVW0lHTmZEyuKzKl5qxOX64m0xUcBrDranScTN
	 y7ezzhWgyQxIK+1WN88pzB4z0DP1AK3k7JDjIgPjCQlmp9irlXVg1Cx2MPok9cqDMyD3v
	 JoUx1CxLmcrMvlEq9Y72RHLSrh1GXYFk4HwDFWaqjkZ2V6Jja23126pftY9hcX/shj+4F
	 9C5pTtAIYo8J1xjjaJjGVNbkfUIFYVonLMfJ/lBfOAALSJK7HeFVLeI43NKyWHiLk0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793723144;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3im34LmcRYA+cSiE+sBGk7UdCBE4SoKxb7+/feltjdY=;
	b=RY1OBySsIgVAfiRwPn3Wh/8QK8a0LvwjrZCb80pozYQ1FqDQjGQUIJX8bJ93ZxUf5J2s
	 ls4ttEQZLoWnrcMWqOBYuz+bOYamMucJuuh1OVdwepsN0hABXgnd/hpTc6cwxm7PwSa1h
	 eYCM4qKcM+Aq/DZzIp3jEF/NDsuq1mx1U5TiVjBfHez1E5/eC7cubr95TuRbXClwsjS23
	 ygB9mYW+c1wmen+5In2KGsCtDkuVHEXZF58prgzUOMF6M4E511LZa3Jwy+GG6WYzySI82
	 hAZA/LyvFiov7XTfO4xnnJUyctDnyw0p5sRI56gG0w8vSMzdZQ9UKdgOfFQxlnPLb2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oSQtlEHv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.63
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B893606A33F
	for <iommu@lists.linux.dev>; Tue,  3 Nov 2026 16:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B893606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oSQtlEHv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZ/CP4lF1yI/NWFk8EF6P4c9PHdgiz+tCW7wiRCgCL/ZapCGKfTBBgiKESCMVZV0rhNoctZ9rLvi2gWQoghhMhN4AsIKAwNPkWpnUACZDXmhkJZVzoNnuLjYtiIl4/SYx4lbDd8YA+wK8lJYVYBKgZCuQJNP5nBpvXPCk/7itbPikceVlgf6Xz9MWdKrzehAoD96LVNDdNZaDP9Rsiae05/XIOwlV3bfWzC0lNba1EV9rOX3Y7Hvawq+dFlRlB+f1oLWU5MgY9Yf2Z4rT7Q/yMJAwxzUCr7T1H+XLuYjt5/5f8kwtlVcnjdOBiL2MKt8HEE0/op+3WTRiW1+KWORMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3im34LmcRYA+cSiE+sBGk7UdCBE4SoKxb7+/feltjdY=;
 b=vjInhPqiHu37AFiPgGAWMJF3Lnpn9GqtFMtwpHt2rMSSTJ2nyzPZ5rJJ1ZTHIV/yOS9wf46Ru9xiEU6iWnkQEn8/CRCdT85y8L0fMgAg0Zza/KvZPWluYzsFbJZXqbjmZKcNYxfTiW6eKJ89gK3XntCUsWiFQPxsng+S4tuEiY/Yo/N0wIabB8KSD9gBusYagekdTe1F3v5zXoMIMvP3MS57TQ73EIQeQqRCLsLR854UKg6IxhgHFQPxDyTFcdHFCLa/nOth8zOzvgPvD1EqjR+/878nsS8s+kba3UKqa23CX7Q9cvNzhN89hEG1+s5SwIBrrt/LP7Wx6O1zvc5/KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3im34LmcRYA+cSiE+sBGk7UdCBE4SoKxb7+/feltjdY=;
 b=oSQtlEHvSDAkssEUG0mB1C7bPYGWQy6IHpAsL07JYnQ4B+RfCTLPpm6LBq68+xztF8E6BNN4Tcdkr579kWjAJxb7Bc9ofiPjg+4UPIvLV6vOBAXn28io6sHjxf+p7a1E1y3fgOTwl6kFUz9dsvUqm5zjHPAjKKq8UfTAlPZuKgU=
Received: from BY3PR05CA0045.namprd05.prod.outlook.com (2603:10b6:a03:39b::20)
 by DS7PR12MB6189.namprd12.prod.outlook.com (2603:10b6:8:9a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 16:25:19 +0000
Received: from MW1PEPF00018894.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::34) by BY3PR05CA0045.outlook.office365.com
 (2603:10b6:a03:39b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 16:25:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00018894.mail.protection.outlook.com (10.167.249.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 16:25:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 10:25:08 -0600
Received: from xhdradheys41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 3 Nov 2026 10:25:03 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <robh@kernel.org>, <saravanak@kernel.org>, <akpm@linux-foundation.org>,
	<david@kernel.org>, <ljs@kernel.org>, <liam@infradead.org>,
	<vbabka@kernel.org>, <rppt@kernel.org>, <surenb@google.com>,
	<mhocko@suse.com>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<baoquan.he@linux.dev>, <pasha.tatashin@soleen.com>, <pratyush@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <iommu@lists.linux.dev>, <kexec@lists.infradead.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH 4/4] mm/cma: drop the duplicate alignment check in rmem_cma_setup()
Date: Tue, 3 Nov 2026 21:54:29 +0530
Message-ID: <20261103162429.2053989-5-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20261103162429.2053989-1-radhey.shyam.pandey@amd.com>
References: <20261103162429.2053989-1-radhey.shyam.pandey@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00018894:EE_|DS7PR12MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fe01bd-8512-4efa-6e98-08df39c70d3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|7416014|376014|1800799024|36860700016|261022105027099003|261021121427099003|261021123027099003|921020|261026140227099003|261028144727099003|11063799006|56012099006|22082099003|261102123227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	epst9tIK9Nw6Flg9AL8MdPpXv18W7619t7mIdXDosX4vle939uBUjZQPbpfv6Frp+qD+7BSO0ddR+F5qjuMn5R6HqbNlydD1v5IyaZCJgu+OHE/CX9jTVYZ3jxuDQRsahnnI92oLV8Aq66ap7qtbyvnd8Zh6TgxcxDyxTtAte2UvOHfPKYMI6Gnrmd7rwWCn64nUsEfmseAUR8KMuZhfS6pjmlXVGodMGpXGjNS8ziVobmtH+p7z5QcSXauP/7b0QsjgEM8bIPJgXAzALFdN/Qh3nAdqQ6p+ksR12wJy1qFMDnuEdLAoHTYYzx05r+HI+aXwJPOoIItvwal79OmUkyZ8bFjc5Go330jXyh7auRShYZquN6WgDvAsU1ioBcauV+P8vEI+2P+NN13xKhfAhqrGsXs9VBfdw/AzmxyGSTuJH751ZUaVgAkfsEUgXZGvjrNZlt5qEH5CNU19+SG2Wyn7quM/9k/VH2WV69P+CiiElwvO9JvGz/29yf2K4JX4N71EqWfJjdw8RlCSSt1Ur5m/8MxPj7O5ktKe/CAqPzEUjUpXrJ6J2flVinnvIBIZ013Xs55GwMsxqZ4Jn0FgABKYPKAmKcjipsJgo3d4jGi27hgf9ZuWm4sxN7ZensiCIeFhQ+RlWnkNZlipqie9QzLNVGceVzf/dp1VWY/6bJsapXSybpSSPfuE+x19aaPZYII0JSSIKdeUpNwXuv5cmG4W+VZRVc3HxOtyv0f25CSEbSbeyLjlim6GbUZGP4pa
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(7416014)(376014)(1800799024)(36860700016)(261022105027099003)(261021121427099003)(261021123027099003)(921020)(261026140227099003)(261028144727099003)(11063799006)(56012099006)(22082099003)(261102123227099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zDh0DEnEi7HvHxB5stq29M/5hR5i/o7prngSgh/2Y2vfy90PFxmh88zHzoepdI2Wf/ARuFGww7eKgAXs9pfM+mr+3kpzgdg8uEgqPOljg5MND0DVfhmLkSosCHj1SHtW2yfyp1774g9Nre5GS34XVJ8dK6x3mI+CFz4gkXGaqOtZP6wN/gPCxJ86BhnPcokwS/sG1GjKHXO9g/IUEPWCGYwuRvhz7i20S3E4O25aezr1QQAYjoaiY3Vhs8d+OW6Znrgshw9sBKhWD0p7B+1kK7zBpGknG1ZWOxtI1wp+mkDv1mmc6jij4pqxEuUzmN2ZS3DBRFJF5jvytu6ayRiOKnr7m6a74gwNHkXImHrMdqqcRFNiWwMx1g+LL3E++SPCTrKuAjM1F4olu5CHzo93UvX3Wdp8JcWKUfFt2DO9UstktkBF0eP+m5ztEx0M3bYd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 16:25:19.2118
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fe01bd-8512-4efa-6e98-08df39c70d3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF00018894.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6189

cma_init_reserved_mem() already refuses a base or size that is not aligned
to CMA_MIN_ALIGNMENT_BYTES, so the identical test in rmem_cma_setup() only
repeats it one call earlier. Remove it and report the failure from
cma_init_reserved_mem() instead, where the area name is available: the
message now says which pool is misaligned, and every caller gets the
diagnostic rather than just the device-tree path.

Suggested-by: Mike Rapoport <rppt@kernel.org>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes since RFC:
- New patch
---
 kernel/dma/contiguous.c | 5 -----
 mm/cma.c                | 6 +++++-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 90937dc7c627..14450cf0f832 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -552,11 +552,6 @@ static int __init rmem_cma_setup(unsigned long node, struct reserved_mem *rmem)
 	if (ret)
 		return ret;
 
-	if (!IS_ALIGNED(rmem->base | rmem->size, CMA_MIN_ALIGNMENT_BYTES)) {
-		pr_err("Reserved memory: incorrect alignment of CMA region\n");
-		return -EINVAL;
-	}
-
 	ret = cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->name, &cma);
 	if (ret) {
 		pr_err("Reserved memory: unable to setup CMA region\n");
diff --git a/mm/cma.c b/mm/cma.c
index 3231a53161cd..68dea7070d69 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -326,8 +326,12 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
 	}
 
 	/* ensure minimal alignment required by mm core */
-	if (!IS_ALIGNED(base | size, CMA_MIN_ALIGNMENT_BYTES))
+	if (!IS_ALIGNED(base | size, CMA_MIN_ALIGNMENT_BYTES)) {
+		pr_err("area %s (%pa, size %pa) is not aligned to %lu bytes\n",
+		       name ?: "(unnamed)", &base, &size,
+		       (unsigned long)CMA_MIN_ALIGNMENT_BYTES);
 		return -EINVAL;
+	}
 
 	ret = cma_new_area(name, size, order_per_bit, &cma);
 	if (ret != 0)
-- 
2.44.4

