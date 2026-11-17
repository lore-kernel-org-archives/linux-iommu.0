Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794943477;
	b=jSErsyfnotZsQXhRq1H1jiE1IH0HSmC+14U3K8HIo1xRYdw++yyxMMr6z52pleop/qMX
	 bjz0wp/6YD26YwVfO7ZFOGFRd1f613NvnE1DOKInNj4uFx1rxp2nI5kbXGLAR3U4j/6FY
	 nfPJb/ySfojT9g+52XyyxXCldahAikHKEm+aEMgULP+bXEC3mBGFlgm6guGiWxTiaG3ZC
	 BazFL7L1c/zBPHWBFxV4PmuoEO3Twwhi+5Msq4uNpycVzYjldO/eQTEFVrq5YG06weSf5
	 QD4YYCQzPdchDf2pLqtN6y7q2o/u+GA5BrbAz/AbrOCIhHj0sUj+CYyTtGmCoumRNSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943477;
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
	bh=Fxzu2TSTBpGL467kVrULEZa3VpbfXQgCTHWiw68PbBo=;
	b=m2IoeG9KsU15W2vAGoAzhYl6Gh7yeMUciJk0q5ikxlr/K0NrfozsP3PF4NebcgC0Pkpo
	 zOWmBmPrtKuKZPtuoKKcAC/JwZnYzrUmxkyBL8VZZPMMJeRWZA/Ga4vyFAsAytb8ZS+Xt
	 TQuokOUilathsqPFIfyN93OMNFb2R9MKkTJK/+NuNs1/UfUp7ZiKKw48aAyGGWFv6pTD/
	 JLXC/GbRX3F99kg/iSzkQlyLSRLiV9zNEg219+ob50hY75AKOJdJW4vSxWUaexQn5HydM
	 BLKlwV/4EHyQgPR5yZKXBsnkw0OGbXq3iuQueA8eWKvjM9lASu5E3RQe/F/q3crot6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=L3FT9Xek;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.53
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011053.outbound.protection.outlook.com [40.107.208.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD9E606A32A
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 19:24:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AD9E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=L3FT9Xek
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=droonobD8XeEkkVWS57BLQLbP2rF0kOPOGRivNgHx/anDfqYMv7qfbOZ7GZo6kgHr26aDqDwCR+ivRkOIQVoX4X2ZmtRn9+m0EEk3M/UzDFdlR+m9ts92GRwFhI3I6sBAG+mm9vSOgTF4R7Um/5RtNpqGmOQL6DkufqjVVGMI/5F5OhqHhfAqOuLBQC3chvfkEfajc1z7prja0JsBFk3gijOVFMk5irDLO4W01sMk5s7wb8nrnqbWDepNMap4keU15ORjBZ6V8UnfKZqFlMpoiei+79H7Rnj7TTIJMYyGVx/SbYPfbNT1sCvyZHXyQqS2NGV6Kt1QgvbAY4zrgP0oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fxzu2TSTBpGL467kVrULEZa3VpbfXQgCTHWiw68PbBo=;
 b=y3uZOOgEFtswrXE2wmqqpJ+g7efjRvjQ+S2TtPN3o4MKEIAsNlmf61zH9+m1apSXgH1N8tYPink45N5DFNK9ErJIs0jSTvm2fH+DwKlMJPFOWngn4JuaXzayvvhH24NS/S7xpgzPq86fjj90/bJcJWbWiOf+zVojhUNarW9RDwbPjcbtXUQi4KJ/cbMqjJJeiqEcrMGKDwZ0XKeDNc25xh9wM9oNMxnTkJ6VuEZjsDdsJEsRkFbN8bLfmfd4d81dnHfsRykPe6y9OvTDAf4L5DRT6UoTWN0DhLD9BAFTe6vZb/O0fZ29yr8PrxmapCYu8MtF0WuxeWfKrpUipt/zwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fxzu2TSTBpGL467kVrULEZa3VpbfXQgCTHWiw68PbBo=;
 b=L3FT9XekEADR2xh5UFjplLDp1q0CC0LPCwROe4nagT/9Pg29cl5YA1GJz3NCzEyN5RRKnhUOw4ft3+h8ewvZyrAwOD1Yl6teSB1tCBWPxlB8bvScEyd/uESE53K2ELEs0DQxU2W6yDqAQ4ISOXQGIXKupOx24Zp/VZ5EbVYqEtoVJoQPBgzQWSokTpf3ruEQi8AXulKZdN1xujlH2OTabUELpGmik7yISBXubKKS0Tm3tt53umsq0sDUqeqpFLda1hvXIHjzlY1pnQCUXmWNxAe/kmMeTeDD53AJuw72rDEEMr6BeX3muBk2ysZgGV5rthHhOHxE9sn/Ad2AHHBcfw==
Received: from MN0P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::10)
 by CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:22:13 +0000
Received: from BN7PEPF00000094.namprd03.prod.outlook.com
 (2603:10b6:208:52e:cafe::ad) by MN0P220CA0017.outlook.office365.com
 (2603:10b6:208:52e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 19:22:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN7PEPF00000094.mail.protection.outlook.com (10.167.245.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:22:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:21:46 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 17 Nov 2026 11:21:46 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 11:21:45 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <praan@google.com>,
	<kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
	<xueshuai@linux.alibaba.com>, <john.garry@arm.com>
Subject: [PATCH v13 11/12] iommu/arm-smmu-v3: Skip RMR bypass for kdump adoption
Date: Tue, 17 Nov 2026 11:21:28 -0800
Message-ID: <a6754841a1bbbfd39100ef0577e04f19f16e1e11.1794942324.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794942324.git.nicolinc@nvidia.com>
References: <cover.1794942324.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF00000094:EE_|CH3PR12MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b6aac2-7299-4899-0b75-08df44e0158c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|30052699003|36860700016|7416014|376014|18002099003|22082099003|6133799003|11063799006|56012099006|261022075727099003|261022105027099003|261026121527099003|261028144727099003|261026140227099003|261021123027099003|261021135927099003|10067099003|261021121427099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	liokrxCsFNW+8oCzd2Qcrg0V7lK3pR9tmHV1dcEP2pBg7IJm5QaosT2iA2TFTxEwogn7EiPmVGEgy0eoIBt+/+7fxktkSwIDc/X/UTpk+exNTIWmknxY5eF8M26jUg/QuCTiGpdsBjKzOuc4RXCkq+DmORKHalnMsG7b/Ll/IQIVCYeVYEdl1nKugat+PUU+knhaiprIvQosPR5yiWp7mpNRkMWQow0axQ6NU+NItv0WWMJ/dAaIubOd6ZCUtvtc52gwFFXW4jXUy2WiLL7jClNcPyuPdq79m9iMxhDfAeL160op8Tk//nvQSTbH0dZoLLdhikbVjjkBPZ0ozcMDDJ92oAW2QKSjuFfO6d/0UA1JZsoclRYBCVLb0zXAVAmsiAi7g2n1ZfvhJWdElD2ehBVy6AiOYBf1biDjaCqDNi0n/Ff68JoYqohJtkE7mE+pcMCNt2fiE1F7C8K9gNWEYYaze80tDQQUYQh+wB9LwNPNKEL8+jWa5uHrn+mOj1VlPps0g41PSn7ac9gUVl4fWyxYvj7U92fZ0KdiK5nP8meDLKjjEiFAmcAJSnVAnkd6PW9ZJd04Y5gTON1NK97W82sJNHSqZqiuli3Du/wz+TNsZutkieUO9YPUAcvgHT1r3x/n7pbcR8bOxJR4kNlVOcU+foGVR9ercdR6ugXJjrmGuqaUteCzf+sOy9mnTxBMMK1mf7+1y2S2YnHnY1Fa7w==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(30052699003)(36860700016)(7416014)(376014)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021135927099003)(10067099003)(261021121427099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5pxT0gC9u7AxuFj0axz4jIeyE28bvv10SZKd0R1UkUUZCv7gnG5ZITCJubr67STeFs1ExHidPitdBExSSqjUNCGGtBGOAVXICHtuBPhqgC6diVyay93ZQ8fT296SGL2C55vkKoW4VpIkM0kG3NVDl0hIugWLcqylBn7U1QZL/CClhzDC3mMPVm/ZLBRExQXgFsnSh5lpuvCnmqMklSeL9ZdSCY4etkhgcRLNnlTB3MPROADH7v1xw/XqD5/erYHuVMx4QKrH5kP0R3Grk6huOIay8rWkzB8Eej6SpsaTOM2lFyBIOVzVeY/ScM1rDkpHTYUCMAyRsEkm9UtoAP6PFiRtawdVXaDdAUmLxD0alkQKY2XXMyyWIlmk7k5VXdvXCZCV6smE07FB+KFiG1aF6mxvyiUGqw6TdXQhz3eu6oLQlYgT20ieOlDabfNL2PRY
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:22:13.2943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b6aac2-7299-4899-0b75-08df44e0158c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF00000094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025

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
Reviewed-by: John Garry <john.garry@arm.com>
Tested-by: Breno Leitao <leitao@kernel.org>
Tested-by: Cristian Prundeanu <cpru@amazon.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4609f64cdb92a..a2687855a1e66 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5815,6 +5815,14 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 	struct list_head rmr_list;
 	struct iommu_resv_region *e;
 
+	/*
+	 * kdump adoption keeps the crashed kernel's table live. Rewriting the
+	 * adopted STE here could expose an in-flight fetch to a transient V=0
+	 * entry, or change Cfg=translate to Cfg=bypass. Must skip here.
+	 */
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT)
+		return;
+
 	INIT_LIST_HEAD(&rmr_list);
 	iort_get_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
 
@@ -5831,10 +5839,7 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
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

