Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012021.outbound.protection.outlook.com [52.101.48.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7484427F8F
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062540; cv=fail; b=LTK13XcBooYrdeaIIfWd6sgIxpgijv/QDbVxHit5dwnC7AxDimGBvU+cAcuOskN+tMf0NA9PcIEufzdIUXngxUuQleR+4qdMqSLCY9dh4ay8pAZ0wIjWE8m9YapgQpoyoH10oMPG7zEOvk1WCipbD4526H84ZFYDiSMv/nJqqqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062540; c=relaxed/simple;
	bh=hF9xfq0+xl+JGP+/zr8yaGJRhG6x1lW9LN48P/e8x04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzpO/1NK1gJZCbAJuzLLFg6NxT7cVcD3lRVIxOiTxIT48rpbZjNyUj4p4TQbiDmtvxFBKSYw+/3snjZeoAAmbA8i8+2o+qJRxRrcNpt0JXrrUiwEzvc7sj5J2fLSTssGJJNVlYumsCEJr9tOP+o4r2VAqO/OUZnPwgryrEI08KE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FzYA80Yb; arc=fail smtp.client-ip=52.101.48.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FzYA80Yb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBIu3hcEBRlXUFN7xarBajy7V0NS84pi29wadhL2Qb65Z0p7tdwU93I/Bn9V6uM/RgQFYNqZc81nK41b2qP72J4Dl85frx1kx4z9gim27OVPRLyfEraDHT0ECVTfOmlSNCDPM2iLHcmz2knfa705UzZZrdjXy80J7+VaVOp9S0FjLluKEQZPHPLDzlWXbUXKktYfPch6+vXqUmbx/BgmOSi1JdBWVZRmARFs1Cs1jjc9Wujh74YWAU60LzBHRKHI8/4dU0TYOSdHrxNLZFuuHH/Z1MztMjMA56AqyinKxVmrq7zHVxyFbybH2f3CqaCai5U2OJqtBwb/+VvnfM2DJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+qyzeH3wgqhS4tfQFs30KyMUJfu37dqvW6aa7eWpvU=;
 b=h8bT3gxxd50yhPdFNA86sKxyZ3ITKdbXA/UAampUkwyn5l3nGLg9Zh7Fb34pfuYDgwP45ICjaRcy+sLSIRimZMWqmQWGFVBZLL7lD7saS2WJ+1cVCQub+t34TGyRdV+oti5+NQ9VFnZGtF7V2I/gPbqKDYyQbLCEEopbAB1vydpXQOiN8nRYA+8WYk96Wg9NRj4P75c+EHmK+rodSckckPOzrjIDOycF+bN7Rw8pDxaTMadQRGHx5H838DXE8WbG6bjSh1GcteVoC3RWVinJ9Y6O9UZSY4n6k9cv7w7dVd91qicpGFj7wB5sWxRIIjC56gtEvbEnEnd6IGN62KIAJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+qyzeH3wgqhS4tfQFs30KyMUJfu37dqvW6aa7eWpvU=;
 b=FzYA80Yb/WDGOyyzM9AOeZXg/5F2kHdN4XABx/dwU594CzvOv6+kXiiiC1q5/xTupq6JYXrg4DwfWVuAsssBVDc3guCvnW+F0wrHZ/STPRV+iPrWTCFT8AXrioY5GTKi/0NIadaTaq35QESVyz2ZrKYOw0TV7137FRL16wyZjdznaTqB5SJCnXP9yutXCMCM5IhcwWan2LN4RAO0JHOhjUdZsBjfTJKct2GkKxColxVaDeo+qJHFoIdrwkUvaJLHvqb7n1JHfuPexEURtwXzg0wqh1Xa6UHlE5PwrCk7ebatC04o+TZ1nXaf/o2VGnY0IyOqXiSLEph8FNaiXjfzEA==
Received: from BN0PR04CA0102.namprd04.prod.outlook.com (2603:10b6:408:ec::17)
 by SA1PR12MB999253.namprd12.prod.outlook.com (2603:10b6:806:4dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 20:55:34 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:ec:cafe::38) by BN0PR04CA0102.outlook.office365.com
 (2603:10b6:408:ec::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 20:55:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 20:55:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 13:55:13 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Jul 2026 13:55:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Jul 2026 13:55:13 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 03/11] iommu/tegra241-cmdqv: Harden error-map index handling in the error ISR
Date: Tue, 14 Jul 2026 13:55:00 -0700
Message-ID: <25ec919bb10325cac02124babdf4034f2b9dbc23.1784059577.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784059577.git.nicolinc@nvidia.com>
References: <cover.1784059577.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|SA1PR12MB999253:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c0f702-8787-466c-b2b1-08dee1ea3f82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	DmZ47Ku86Q8GHLSPxxZGvo85dP9q6U+Bnm6pSbT6ADU0c3uZ9ObDlt0lC/ia+0Z1CxdAsreRNZLron1knbZdTeU5LU/pX9dZ8hGolHCdwWt248IgUYzABobwUZHiongBeOMa5n3tk9kozvZ8wjPA2uBDL7QfWFguwjH3XiKlJQ7ixfQrZFxU3ME4lnIFAMWeSEUcpL1hqVbNQ6BBbkbPprV73BIKs57vhywIAWGwK84TTghXM9qxqjfruUcZqrSN3Akonm8+5OL1NlCPOeRdAP6APoufNIEcf9l1h9pEIZjx/cueJPIRDwUKxMtzARmuruw6Fm7KJq3n0KsP3DhKAXJQ/GV+y5oskAXURX1CzHskwggpZCLgOtuwbJ1T/NTW3ia2j91HzSDCLUcL1widxn1ztE6c8xuXyCaV7CnW2CHwv2L10lXiriCET+NztBjQPhT1dAFldranN8aGgbrebSAWC/CkL78JZjN5gIPjrV3nKJrO8KMJ4HltDaH2Ph338MjHnGJ84mESOdQcqMt/JEZXg41fwvMRLPg3ZxE6tKK8hdx9Smhi28K6pwCOHLvNTWGM/8F1rk6EySDij/71LLwWTLH1ItLswueLWzEw9ifdqvGhVTN/uXd9iRSpbbnKVdqc2arYqQLhKQ9CNvYirsF0QnJqsFfpDpMbN53Dy66Z2Dp/ZpHwjo+HXd/8dt8XsFJtiu/glQ1NEkqyqbF1/Q==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OkuN87A/p8bbxpELZ2xUPrWqJBiqr2xkmCiLpPlySIj8KBClJv04aVVVZ/9dIKYzj6g536oKC1MVn/snR7HfEBdxXN0rt0u7fBjLJvoSt2Y0RuVTTbH6kj2v6oarphWCWqT/ntRBwytnVAR+WCJVs5CxFLH6OZblSeEM0jTw9EeRSIRwJzBSAhQzn4NgCC1RJXtQcxjAVFsekY8JqlVsekmYytjH1H9Nxhgofpq8a7M3cJHAGhFOsi53Rufes3p4S5ljW7vRha42me63k+6NcY8EO/3RoAM6M+ZA50I2zn486kgeAYJ0HJeq/FhkD0yqGlQydgh4BgyRqUruMnlHvWryN61X47T/zXd0A8/vQe4eK+fWEYTC0L5HDjMEuAmabDLtZ7svXkBsp8PvIl2gLgzs0Su/jx1oeGhmEaMpT5tIBASo3y175/nFT7lTokRJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 20:55:33.5384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c0f702-8787-466c-b2b1-08dee1ea3f82
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999253

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

