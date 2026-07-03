Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B1134252B
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 05:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056737; cv=fail; b=gGhcZoasPG6zHg6/CAaS9iSmtgmW7eyviqDYqvuliBQgiU/YRUJtLaxaaPLWH9KNk50iAHiG9JI78EP8mvROCNbQvhH8a2gWKp+JSjL3p6YzZ4TCU7nlSt+bfcu9rcVmia0tKK5MBXo0+FUKG1+XqPD+SZ4T5TeS/MhqAAlvPOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056737; c=relaxed/simple;
	bh=hF9xfq0+xl+JGP+/zr8yaGJRhG6x1lW9LN48P/e8x04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEnTkvP33vM5MvBNBX0u2NuuZFhJkoxZzoR1UmDzw1ECnp6ys7XoV34KlIq9c4hOjS7czPsj3wXngH1NYoWoVkSV59aP9PSfXIx6WoxLoI0qH+840z+3UbcUdTAaTmjcZVPGe4/i4qkpoBKphhg3J/x9DEBMlSXZLeLDng+m35U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EpIiE3CD; arc=fail smtp.client-ip=40.107.209.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EpIiE3CD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qFbsY957bFLHQrqpQqpgqdTFMCvIWxB7sKJHS9aK6eBtx9tU26MluUxZOJeWLOHOm7yCzAERkeFC+bBg44v+KP2GkcXaSQdD7tGaAMltHN9icLOy7gGy2GDcRRIr3VWEkcJhglIGHj3mIQIjXYA75+kHrqTWbtKVezzlO5D/lrV3bARguFlsRZpNvEIFrvn+k0654ZtfvN5cKjAC7GTr8XIFYOQk/iQt0ePJas49VfwaPVQOgxNv+b16xDLjNA438vRD2PtrUch62i+S9UzSmX//oe94licmIuYio6uDwkZhn9BLRDlNknHUNgqZR394sfszKGVUhIMomvLPCkGYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+qyzeH3wgqhS4tfQFs30KyMUJfu37dqvW6aa7eWpvU=;
 b=ESG92xl1aMF8hcpiOUt7xWvsOSvccwzIBf/CnhSwoS99CWTOxD7XXWkQYqA+c6U2pRveSB2eHd6HzjV5pijLND8oRYCUUy9lXzjJAJcvW6B31+REghwATm68336uadaOdW2D5FXcnsa3eIUhYY6B6g3BE67FbXCCde1mhR8Vd+7ZcxCd71ubm6cfvNn1TR6gM3TBT6WpFf2VnAoaoovA9FRJqYF8V7NckQvJXHzk3Kl8Ry90PFogGcQWpn1v8A4UgchBrKR+xiORIL6CepkWIbvKkwssGaZXukIlwG5xt00F5s3Qv1ZF9CEf9M6Ooaed7E3dPVkP7ctABUbmHvUJWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+qyzeH3wgqhS4tfQFs30KyMUJfu37dqvW6aa7eWpvU=;
 b=EpIiE3CD6Ji3Tm5D2kt8k/4jjjQHuzDmrASKVT4tp+tDMhH/Qelxn9ajW0Q3p8QXAdKllnYjTb69FSj+seGUORuPeP0K641aW+r7ZPNfUJOq/agN8+r5n3SMfUDBja/LKev7RWKpmYj7UEgCuce9ARNJoGza+Iro9iWr8vw84blaG+T6YJNlt+PP5/jODGN6TYv3d+b+v5mjkLt4zlxiyu/E9RN+MS7Fffw+Ot5+LsZvmzGXqMQJKtvo59jRvtCojmuXYUrWGbu/wOxYE0c0JDmeFIDWH4l3sfkm3Im1uAzOVjDAY+NnsyT9MF7WuiKXXZZ2c0PyJ2dZh+Ory4HaOg==
Received: from BN0PR03CA0033.namprd03.prod.outlook.com (2603:10b6:408:e7::8)
 by MW4PR12MB7190.namprd12.prod.outlook.com (2603:10b6:303:225::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Fri, 3 Jul 2026
 05:32:05 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::3c) by BN0PR03CA0033.outlook.office365.com
 (2603:10b6:408:e7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.10 via Frontend Transport; Fri, 3
 Jul 2026 05:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 3 Jul 2026 05:32:04 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 22:31:45 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Jul
 2026 22:31:45 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Jul 2026 22:31:44 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 03/11] iommu/tegra241-cmdqv: Harden error-map index handling in the error ISR
Date: Thu, 2 Jul 2026 22:31:29 -0700
Message-ID: <25ec919bb10325cac02124babdf4034f2b9dbc23.1783054570.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783054570.git.nicolinc@nvidia.com>
References: <cover.1783054570.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|MW4PR12MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f3fe6d4-acea-4ffb-b877-08ded8c46abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	NjfDTg5u98lhPmtajh9x6wfe5jY92/GH0Ddxl1YSBZ27MRIj3WWp43xSaFBVP0EsC0DAye2L8eU1Mh7V+Vsg+WZjJOT8FreUBzEvIIFDa74Wecy7OXSXKIg9GDtJk2JjQ/6tojO1TSX3yfKc8PxiV7la0JuXSRTTy98cw8367qMtXr4l+WS7Xj8ehUqIGq0R+wp4EXghY9Z8jjwS95KegkUGB/n/6DYLn7+rIbau0L+hl/f9ijKfwex/vgRVo2dW5CiOcg4ZS56II1le7AeAodKAoXHRGBIt1o138SPYUrmwk0pVHn2wyMhZwEsu0DF74zJyjIFONQbGZAd1XceLBGPkUA98gbvtyjB2bCwd3fP6zGoy0q+fZb/tDmzYfeS+D9g1C9gIl3Lt4lvubrw9uu7IzMLxPtUTBdJ++ESH5HxsAgCn72hM7z+RVxZxjMmkyYUEND0+pKVDcfFkNyfUxO+XcFW+Z/TtHhtXeBYNaojbw1YE5uolHdY1izQqjwBUQg3SXmvDcpx83hotghXgjdSL9q71DnnPLZiy+3II9aLmQJGIWDuzR9t9ns6MeFn+LZyIqtnEuXrBPyUclkwROftc0NiexMN6s7AZvrwisPKgcFWWvP9OeabewAegc9Mj7sOdPFysS32UFEsH8w5yvuAkbhha6ZIXeu9jebpU48E/rbv0aIMdOn2HRcuY5Xxiv8zk7+eu2fAQXAZkNX4+rw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5YDxEJUZmrg4PBdDAiSbH83fxrPDGfVxKiZaMCZhfgcwNLdntMxp2B16TNXoNX/gVkPKZr+t8U0hyqu6Q63PS8GjmRS7nOlJSxnno8XSNqUNHELSAJMh1WNKVX9FnUD5PgrHfZ0TLwtfxlGZMM3LcWHqPDjmBPFYtDLs033PBvHsmqfqo6XGvhapFPWJLUqYcYzc5j7CM4Wx0nlqUmffAOiSAjmjw9MZ15t2GAXYFoCsMzrD/zT2gzQMGJKfRP4T4f8r5aiRl7hanzm1sEyO/viGTPIS5OH2BZ5ZRWwwFyeZj97RFiPVMCUFb3EAfkNG4eFW4GkI+v4tyX7FgdittNYMybUu8ko3r44N5dADB1vswHQZ/aTvu0UByXJAJzxIaa/IWcv6L9Z+jEcPpmWIRTuPnJ8vgG0lllLOYoB7hSVdTNMsrB7vhRDW6jFA9SSg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 05:32:04.7266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3fe6d4-acea-4ffb-b877-08ded8c46abd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7190

tegra241_vintf0_handle_error() reads both 64-bit LVCMDQ error-map registers
but used the register-local __ffs64() bit directly as the vintf->lvcmdqs[]
index. For the second register that selects the wrong queue instead of 64 *
i + bit, clearing the wrong queue's error status.

The index is unbounded too: a bit at or beyond num_lvcmdqs_per_vintf would
walk the read off vintf->lvcmdqs[].

tegra241_cmdqv_isr() has the same flaw one level up: a VINTF_ERR_MAP bit
at or beyond num_vintfs would walk the read off cmdqv->vintfs[].

Use 64 * i + bit for the index and clear the snapshot with the local bit.
In both handlers, WARN_ON_ONCE() and skip an out-of-bounds index. Only a
malfunctioning device sets such a bit, so the _ONCE form keeps a wedged map
from flooding the log.

Note that 64 * i + bit is not reachable with the current configuration as a
VINTF is pre-assigned with 2 lvcmdqs, this is not treated as bug fix but an
defensive hardening.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 5fbc1c85874a5..b89f021ba0b86 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -311,25 +311,30 @@ static void tegra241_vintf_user_handle_error(struct tegra241_vintf *vintf)
 
 static void tegra241_vintf0_handle_error(struct tegra241_vintf *vintf)
 {
+	struct tegra241_cmdqv *cmdqv = vintf->cmdqv;
 	int i;
 
 	for (i = 0; i < LVCMDQ_ERR_MAP_NUM_64; i++) {
 		u64 map = readq_relaxed(REG_VINTF(vintf, LVCMDQ_ERR_MAP_64(i)));
 
 		while (map) {
-			unsigned long lidx = __ffs64(map);
+			unsigned long map_bit = __ffs64(map);
+			unsigned long lidx = 64 * i + map_bit;
 			struct tegra241_vcmdq *vcmdq;
 			u32 gerror;
 
-			map &= ~BIT_ULL(lidx);
+			map &= ~BIT_ULL(map_bit);
 
+			/* A bit beyond the count means a HW error; skip it */
+			if (WARN_ON_ONCE(lidx >= cmdqv->num_lvcmdqs_per_vintf))
+				continue;
 			/* Pairs with smp_store_release() publishing it */
 			vcmdq = smp_load_acquire(&vintf->lvcmdqs[lidx]);
 			if (!vcmdq)
 				continue;
 
 			gerror = readl_relaxed(REG_VCMDQ_PAGE0(vcmdq, GERROR));
-			__arm_smmu_cmdq_skip_err(&vintf->cmdqv->smmu, &vcmdq->cmdq);
+			__arm_smmu_cmdq_skip_err(&cmdqv->smmu, &vcmdq->cmdq);
 			writel(gerror, REG_VCMDQ_PAGE0(vcmdq, GERRORN));
 		}
 	}
@@ -381,6 +386,9 @@ static irqreturn_t tegra241_cmdqv_isr(int irq, void *devid)
 
 		vintf_map &= ~BIT_ULL(idx);
 
+		/* A bit beyond the count means a HW error; skip it */
+		if (WARN_ON_ONCE(idx >= cmdqv->num_vintfs))
+			continue;
 		/* The slot may be published or torn down (NULL'd) concurrently */
 		vintf = smp_load_acquire(&cmdqv->vintfs[idx]);
 		if (vintf)
-- 
2.43.0

