Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794899259;
	b=q4EZOJNgzng9K4WJvUrQSJUUepxXRG/e1DbmrXLaGBdooEvUmriOfMSm/pbezjImBcgZ
	 2dVrEpHWXWwYgzVH+drkPAWy9McqxK3FPqJcf/rl3PI99KBWKPkVLYSK2S9z60ejORLuj
	 AZhN5gQDhdDUdSMRHol2BAjql6XTGiOItI7q597ul3SSbhsUrpE8KXIVqkSXG24aM2nr7
	 83Y9hlWoJ5Ap0A/FvfdCPZv6kAW096BYFa5A8Tykp51VAebKL3Jq8Et9acvyMPVyvO0yC
	 RNdhaGXVllpOXbFv9tJUqa/i/DoUvK8c2sxID7tIJAqNfTL9s2E8GydgD8iNz3wiLCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794899259;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=0BRl855Ng0MZ5d4+lc7Q4hAra7Vp29jOq6ZHebroW9w=;
	b=vWCozODQHCbnkvqaRevCkqGhuKX5NL1/Cm+1pdXd0AY5H6JBMIqaZJc7lJ53p2Nwdooi
	 LvXtZrzngRsJ8dWPQkmnOiVUlpLbouTMbRxa98ygRKDc0a4IPNkv1dfUhLRrREMf2sMWo
	 ahWd3KiY1saK9rLPLgai+1Ykew5y/hgphtoJ1hAye10aHbRkHuvB+6ZMCWZ2+B1qKhR9i
	 Hxb4vu551IS0O9+9Vksl2D+R0rUx2FV5fgYOiqQFNXRWh4RriqEpGnWn+Jx4+7LcPIJJT
	 2VuziuwYJ3YB2QJsBKKmuPpGkhDm8J1VhRGCP2d7J1BD6xt4S2O2sT+rlLqdknoRcjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KPyhtuY1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.48
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011048.outbound.protection.outlook.com [40.93.194.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC1C606A330
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 07:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BC1C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KPyhtuY1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDTd3PLnxrW0+AWvDdl1vAoJEpjNZOT9lOSBFg310IVTWUD6U6r/90Lvmr5unNugbTDkkCHyO5s30xlxG+gLr1GUfHbVfPOHWae+PBqDUniXQRNo9xzoHktNrw3nJ4oIBp4O7glrykmLEEWNo29CuxFb4gLw2PLQJbEXq9SWm9/koth1K11Helkp1TE3UTKeVg0vAd3JvwSWpDR0Okl8sV2hxh+Ipc2h8wzCe3vlGo7oxz/ayM3REt5m3qXX6ZTzYYUIZZecYd5OqGy7BfTxBIGJn9tTiNwbYZqzP4dI9RksrbMXL+RW+NXnE7u2GfAYilaIhFkIIE/YBEZd7vEKcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BRl855Ng0MZ5d4+lc7Q4hAra7Vp29jOq6ZHebroW9w=;
 b=fjkMRnJx9ofpw4KTlj11cfdeaOUrhsoFB+PB4NVcRVwWmI95jtrgYVcMuH1k6ghk/EWUO/cD9Bj5bZ3+UxmY/38lEczk6CwBKyoymCi9ibvNH9cvC3kj/sOVYpwAfyksVDLQ11SaZbhUPD5lxLE96ZHHtPWkmpsNndEogi9PGfBW/nybJ5JTrtSyrTs4U9d8XRNtcVK+DbdCopvUIvdBB5I9TqFW5y7SDU29q3bciYfwTR7BeTisl7SDpBreJLM+xjsxvaQ2XeaQ+ZO/EbpX2zfjKNVnP5TSmc79sXNTgBRdPbMS0na+w2HNtTVQxy0nLMONyzNwF6e/nDjlro7IZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BRl855Ng0MZ5d4+lc7Q4hAra7Vp29jOq6ZHebroW9w=;
 b=KPyhtuY11NtSM5BSsK/EZX2F+t0US5GOtIxZgZl86rk94xKpaMNhYV+/v0MO1fWeNtY2RTv/eDAhiIWJfH9aWE/t/r1MBJz6gqcCngNa4bumCApYcWu4ClqKS+D3Od4bNa6Er6OtelmFTQmSTgT771aEHMspzR65XHgU3elCSRM=
Received: from CH0PR04CA0109.namprd04.prod.outlook.com (2603:10b6:610:75::24)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 07:07:32 +0000
Received: from BL6PEPF0006C3DE.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::91) by CH0PR04CA0109.outlook.office365.com
 (2603:10b6:610:75::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Tue,
 17 Nov 2026 07:07:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0006C3DE.mail.protection.outlook.com (10.167.249.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 07:07:31 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 01:07:27 -0600
From: Sairaj Kodilkar <sarunkod@amd.com>
To: "Joerg Roedel (AMD)" <joro@8bytes.org>, Adrian Huang
	<ahuang12@lenovo.com>, Joerg Roedel <jroedel@suse.de>, Robin Murphy
	<robin.murphy@arm.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Sairaj Kodilkar <sarunkod@amd.com>, Akshay Jindal <Akshay.Jindal@amd.com>
Subject: [PATCH v4 1/3] iommu/amd: Drop unused global exclusion range fields and init
Date: Tue, 17 Nov 2026 12:36:52 +0530
Message-ID: <20261117070654.3699-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261117070654.3699-1-sarunkod@amd.com>
References: <20261117070654.3699-1-sarunkod@amd.com>
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
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DE:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: 108aa8dd-0c83-41f5-6ca7-08df447972be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|261026121527099003|261026135527099003|261026140227099003|261028144727099003|10067099003|261022115727099003|261021130227099003|261021135927099003|261021133027099003|261022075727099003|261021123027099003|261022113327099003|261021121427099003|261022105027099003|261026130827099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DrB+DuBWnMj4GqMS+ow4YFOXOwJBpkDJvnyuZcYBGz361kd4eNJ6wo8qTM5R3nvQHn7G9/p6OrOHv9HFhIGUXt6zWq1c6o3TZ0Kaqzjefwsgw9nv4e/XHnRJL16VbOQurlsEg9j42CxW0bjo/FHlqMUEZZunXLY5+TQt7IwHFQRGi7Ysuf5x623wzS1M9cCyNlMDrFr18DB86sx5zeN1aJkHjrsNBTmRJBteORshWq4DZ0Ug28IfAAfJK6DA9rFw5WrZyNXRcHS9LS3ZE2+/yIYDqqtZGK/H8TE7SdXDH+ITzTHbKcT/6LFt9RBRszoRiPB0bQJm6iRd40j12rS5AftgaURBsfDfxDY0iML0lzXEJoRFGIeVxpIIxhZ7lPCm/swJ3lD+ARZ6svXnS62pST8o0j5nxoATdoPXqbPuhl8LzWu98VYcT3Fhoi9qG5mNJizEoJnYoKbeVU9c6i/BWZ9RaeQgOoXj+6l4j4+f2Uzc/cwouJh3DsoEXnG6bjfccFzGEtvjv7BckMDr/9eXtqrJRNak7TrcRQDwzf9bPxaO1BNEBgMwwNBTK+zRqe1pJHz6UR/65Ked9R+WOEbhhrmrhoifIXiYbpEzngLsk11PLDsaE9s7EsEPQu2HmzidJpHlPnOigeghColkcznT6jxcgfL7trF4nsEPax97I+jDfRWsOa3z+S66qN9dgtQR1W8QxXlJ7sZNfZtHkfWlMw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261026121527099003)(261026135527099003)(261026140227099003)(261028144727099003)(10067099003)(261022115727099003)(261021130227099003)(261021135927099003)(261021133027099003)(261022075727099003)(261021123027099003)(261022113327099003)(261021121427099003)(261022105027099003)(261026130827099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m+6AKYwcQ7A6/anoJIlXak34Qi4QnpnFl7A8+rjS8+h8hDbNBeSK+nPOqFYIG4jWLRvM3F+rAn+0mFFuyGvf3ndAF2AsM4KDEVXwiBe30TPiH5XTMuruzS5/m3udYW9KqUymgJ0kKtQgW+1rH5EmMJib38R6Af1TFv5MAvmkqtCcUI55gY4lyVCVaBIUQ+SaRJtzvcvrzELfa0MdfmIwzu2YjYR4HY2dGKr/EORl/ajWYqw0Y9CDp7EK5InxZrP3fsEx5ubMgMh1aql8JZcJyUCgLd8eF7KkkRiWZlSjL0YyGjbaZqRjqgpE7ovB4eHX1sR7pNTLf29Nb0dB7qbql0oNe3nqNNpveuUhPbG4mQh4NvpZHEBCgZIxRBJ1XBr6zcQ01IFgJsK59oaqgeOuDLuzT5Y3WNGE9Y1TOpVjul1hOl4BWW8fOBXPzcrm617c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 07:07:31.6387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 108aa8dd-0c83-41f5-6ca7-08df447972be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0006C3DE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Remove unused struct amd_iommu.exclusion_start/exclusion_length, the
MMIO_EXCL_* flag masks, and iommu_set_exclusion_range(). These struct
amd_iommu fields were never assigned, so early_enable_iommu() never
programmed the hardware exclusion registers through this path.

Please note that the exclusion range registers have been repurposed
to SNP completion-wait store base / limit registers. So, rename
MMIO_EXCL_BASE/LIMIT via to MMIO_COMPL_STORE_BASE/LIMIT instead.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Akshay Jindal <Akshay.Jindal@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 4 ++--
 drivers/iommu/amd/init.c            | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 8241ef922519..678ceddd711c 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -44,8 +44,8 @@
 #define MMIO_CMD_BUF_OFFSET     0x0008
 #define MMIO_EVT_BUF_OFFSET     0x0010
 #define MMIO_CONTROL_OFFSET     0x0018
-#define MMIO_EXCL_BASE_OFFSET   0x0020
-#define MMIO_EXCL_LIMIT_OFFSET  0x0028
+#define MMIO_COMPL_STORE_BASE_OFFSET   0x0020
+#define MMIO_COMPL_STORE_LIMIT_OFFSET  0x0028
 #define MMIO_EXT_FEATURES	0x0030
 #define MMIO_PPR_LOG_OFFSET	0x0038
 #define MMIO_GA_LOG_BASE_OFFSET	0x00e0
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8a410d4aa370..13c96feed64f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -370,14 +370,14 @@ static void iommu_set_cwwb_range(struct amd_iommu *iommu)
 	 * Re-purpose Exclusion base/limit registers for Completion wait
 	 * write-back base/limit.
 	 */
-	memcpy_toio(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET,
+	memcpy_toio(iommu->mmio_base + MMIO_COMPL_STORE_BASE_OFFSET,
 		    &entry, sizeof(entry));
 
 	/* Note:
 	 * Default to 4 Kbytes, which can be specified by setting base
 	 * address equal to the limit address.
 	 */
-	memcpy_toio(iommu->mmio_base + MMIO_EXCL_LIMIT_OFFSET,
+	memcpy_toio(iommu->mmio_base + MMIO_COMPL_STORE_LIMIT_OFFSET,
 		    &entry, sizeof(entry));
 }
 
@@ -1022,7 +1022,7 @@ static int __init remap_or_alloc_cwwb_sem(struct amd_iommu *iommu)
 		 * completion wait buffer (CWB) address. Read and re-use it.
 		 */
 		pr_info_once("Re-using CWB buffers from the previous kernel\n");
-		paddr = readq(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET) & PM_ADDR_MASK;
+		paddr = readq(iommu->mmio_base + MMIO_COMPL_STORE_BASE_OFFSET) & PM_ADDR_MASK;
 		iommu->cmd_sem = iommu_memremap(paddr, PAGE_SIZE);
 		if (!iommu->cmd_sem)
 			return -ENOMEM;
-- 
2.34.1

