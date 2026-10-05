Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69018322C88
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228846; cv=fail; b=NbxujTGDEps/YoURhIuexWQiyrVZI30eVqVAAEJj2MGrX1n5lp/217ua3Otnx6EsXtjhrYE/CAKyH0iUYdRRNXpx9yEx+YBJBaETdyfiX+TbMuQ/j9TB4ME/lKjnGiZIT3Krt9a8inbKqdICj6GH+mT1Eh9l6NupxVt8qot2nOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228846; c=relaxed/simple;
	bh=Ii9wkk2Z/nQekVkgeOvzgq/xgCAw4aKE+mkK8+RhgB8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpg7gtgjUrmu6ImEJYFQ/GoA5MyAhgP2J12ygxEPcikcfR6kOS6mDuSejWLT7jEI8AjF0O6PcRCKTs15RMV35BsC3sSPbr4oHHn/eNA/45Sw3gfSmRY9RyFYA5O/5iYVUJh2KyydFk24CEST6KMIFFFQeWKwswD4CsRzEmf1kJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KWwctdZ4; arc=fail smtp.client-ip=52.101.62.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KWwctdZ4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbznhBRcPwo++JN1c2uHkWl7PlygYpfj39I11/7GzCRFv7YPSql82VQV5y6UTx7yHLo/5L378mNmSHmgbr6ahNbXnR0Y6wkwazPaIjMiKow3snwu6dWfAARHbQfGbaAYJh5wbMwLK5Gb0uv4Qy3WNlMNSioHImeHYkX3tP1oK6x6WbwyHIieGstegnQ0QMy6TWe15CWClWNyyKQFLgQakJp728MZxh3TIMzDzSq4GjcIqQSJ16iB1C4aG08WpIuvVlhUQvv8niIefUjLiOORIbwqsFe/XdNyVNzp5X6w5rQDYErAqF7YEMJVMGEt0eFXOftzG6lSfPpxFy2Zyb3VSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEPzGQk+7H2jVNYx4ygKDbFYWOCXZ1YNYIdDUk9CX/c=;
 b=HftYToSA1ae4w4EGUWRGTMNva4kOKiftdkkabL/UIJJ2seLnZkOTr+ioXa8A/EBLFZCAHDobuh4sbRxIiW1NszgKVcmlgFnJTAe4j0nnYcA3ZIy6uFo6npoGAOgOKp0JDpwhgUuhtcTOYUB8VdDrj74msKlUtVB/Zg2mA3pGQ7DBnPn4GQTgbofy0n8gYj6wPNGxAwW8UbP+e18ez8LFT6bnZ9nF0Be1IDx8TK65sPD7cD0MLPiviP6eus+X15zlzAtXhJTj4dAysFViavTs0qc0MyZ0HyKI7NhQ6b5aS5r8tyuFLHPpNXdwCaqnYTU71Ji58NSM6VK8GFLavn2zKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEPzGQk+7H2jVNYx4ygKDbFYWOCXZ1YNYIdDUk9CX/c=;
 b=KWwctdZ4wy8KJHlkZQQ/ekZ01BwQEQ5AtbT+Qzuzf5lnKtIYgrEfiWGI43NTvpVZAeR1FYq9/9a4P4WJPzrYNA8M9Eq6F8qHKHBzCNSaxTWHfcYroTqbv2G15N9AbnTNa6bqPx2aQ6oq+PONW8uvQwHumz4g9Z/8ObawHt9XjMTIULQoT+vUDxvCbZhCByGVjGFVo8V/txy4TTsBBIgvefpx3lT2MaeRIFbOy8nFWSdJaMvdm7ED2blVbLe7M/CSKoKhHCfNnhPDGEYECcgA1aJbgmxUmmDnoXosuOuun5W7Yi6CuDPlgMYgLjbKsWOnOyRfrtmQSIS0C1NfcBiZ7A==
Received: from SJ0PR03CA0211.namprd03.prod.outlook.com (2603:10b6:a03:39f::6)
 by DS0PR12MB8247.namprd12.prod.outlook.com (2603:10b6:8:f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.19; Mon, 5 Oct
 2026 19:31:35 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:39f:cafe::23) by SJ0PR03CA0211.outlook.office365.com
 (2603:10b6:a03:39f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 19:31:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Mon, 5 Oct 2026 19:31:35 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 12:31:08 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 12:31:08 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 12:31:07 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<praan@google.com>, <kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
Subject: [PATCH v11 10/11] iommu/arm-smmu-v3: Skip RMR bypass for kdump adoption
Date: Mon, 5 Oct 2026 12:30:53 -0700
Message-ID: <519cde2592cb31a42f77b38f663dab583dfbf41a.1791226953.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791226953.git.nicolinc@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|DS0PR12MB8247:EE_
X-MS-Office365-Filtering-Correlation-Id: c211bfda-9c8d-41ec-937f-08df231744b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|30052699003|23010399003|6133799003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	CnxSQ3K2jlc7n7Xd3xwqrjELqohHu64vZVp1GbPspOko7fn3AluYf9dS2gESNFe7RjP32bChzUKfeHarIZhvhfZzQ0sb8jEWWxLu+1NT4vsWJur19MEglKuLpI+HLy88YSjtF1C7pFl7+O79TR5J2qiJBb+zBvekpWvC3ZDK+WKC5ffu/I5AlxeGA9KjpjQqhVVEL5MkaA2RKFJTLXXx0EdIwfvvwI7+m7c4Z/PeRH3VnHLqJhyPrNXDQutUIKJNXpCeyA/lX1KzOAIruZZlmT6s1lDM1DM2Wqt9PjYE3N2fmIaykiRgA9rylfmGB6zVRA9LSEeruB4A0Ed6Sv3k2Fc/uPoHf62bjlhyHOg8ToGLgO7PXi5bCz9gvtsmDGmLzYHjsm0ma+RtDYErNH0vnlAvA+3uH5dhCjcVH9nS8SEU7obU8kFC61cuRalLinrtq8h+A5AzKqLwv+TPEEdKFge07KWSF3SYuFr0FwwUTe+fDY+ShSPgPL5J6QWSGm2mohTE73JiJYfpuYnn6895sw9AB5xnDG9O713+fMp/8VHYlByXOZSX7No8YpY0WCRqKnRKYJB22EMdVej/HfpYKXPV/TkR6sYKJlw75pQWZpmmZgvT9FaLQDFO6yF74F84UlXCeyO8BNKXo6WuiCqTRifT0wzv88slPbPtQuK/dTWsiArLexHggExoEDoW+KZ1uqK34NDvRTqjeXqkjQsqcQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(30052699003)(23010399003)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	orvNu/DbbDINzYCfuq/xFLdG/5MtQ2+paVuehBpuCRon4CpPVJvKbG9DFejmaurS2ExQDSmwVQG7EpbrIX6g0N36HbxozQ9VO8YRny5mcgsqXGnhXHZQZn6HSmDrujFMgblcd7sCF/eIxiQFzu+vhJ47j09y0Al5EbryHDkEFb2LIR11XqBcoyJ54l3s5zq3u429IrVMP0uRNRsI5oLEmsF6tbcQQuxcimpUH6QuLqRy+aRKN2ZyJzwOqkS5qXTfo7ZG0kJ5KZ238RpfUJPoYvqykKig36lwQWA+q4v2av/oZbyoxetXj07fULsrrAVSxCXr50Am56Qdrd7YEds8i6cDfxHD85OJ+iuuU6b5APDbhgysVcn87zttADhdDqcjscLoR0oTQBurlfZ45ChANhC7bI4/kv2G9wwhXSq/RZ9EQn+2hFFejiGGuA8cUxcE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 19:31:35.3943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c211bfda-9c8d-41ec-937f-08df231744b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8247

RMR bypass STEs are installed during SMMUv3 probe for StreamIDs listed by
IORT RMR nodes. A normal boot switches the driver to a fresh stream table
whose initial STEs abort, so those RMR SIDs need bypass entries before it
becomes live. This preserves firmware/guest-owned traffic, including vSMMU
guest MSI cases built around RMR-described SIDs.

ARM_SMMU_OPT_KDUMP_ADOPT is the opposite case: the driver keeps SMMUEN set
and adopts the crashed kernel's stream table, so RMR SIDs already have the
only translation state known to be safe for active in-flight DMA. Replacing
an adopted STE with bypass can turn translated DMA into physical DMA, then
point it at the wrong memory.

arm_smmu_make_bypass_ste() also rewrites the STE in place after clearing it
first. While the table is live, a concurrent hardware STE fetch can observe
V=0 or mixed old/new state.

Leaving the adopted STE unmodified keeps the kdump kernel using the crashed
kernel's translation. That gives the endpoint driver a chance to probe and
quiesce the device.

If the old STE was already abort or invalid, installing bypass would create
new DMA permission; leaving it alone is a safer failure mode. Later domain
setup still gets the RMR direct mappings through the reserved-region path.

Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Breno Leitao <leitao@kernel.org>
Tested-by: Cristian Prundeanu <cpru@amazon.com>
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 5542d136c1d77..78a24bca44202 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5816,6 +5816,14 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 	struct list_head rmr_list;
 	struct iommu_resv_region *e;
 
+	/*
+	 * Kdump adoption keeps the crashed kernel's table live. Rewriting the
+	 * adopted STE here could expose an in-flight fetch to a transient V=0
+	 * entry, or change Cfg=translate to Cfg=bypass. Must skip here.
+	 */
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT)
+		return;
+
 	INIT_LIST_HEAD(&rmr_list);
 	iort_get_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
 
@@ -5832,10 +5840,7 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 				continue;
 			}
 
-			/*
-			 * STE table is not programmed to HW, see
-			 * arm_smmu_initial_bypass_stes()
-			 */
+			/* The fresh stream table is not yet live. */
 			arm_smmu_make_bypass_ste(smmu,
 				arm_smmu_get_step_for_sid(smmu, rmr->sids[i]));
 		}
-- 
2.43.0

