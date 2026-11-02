Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793596806;
	b=E/qcamEakYOIFJrEXjyPimrtCZFKnBVDOmCpCDzJwxXFB98A48+JQ2K9OE4s9Qp0bY2Z
	 g5DE01dXYKRcQrDTai6Xs6xzDK4rrHlphY/5v5L/MNS6dCUEqdeL6Y1cKSwMzOrO0Z7JH
	 zfK9lQEo+Ul+Jy+CFFtgRO6tNezaekEGd4U+sTJAiTvf12NRuq/lp295vIW/rA8QmmsiV
	 efTUy1gOgousCdTBsurrNN+2Y25+fTs5AQTE6jShxvXNSZo7kZhF7Jua6/c2qqKIkU+Bz
	 BH/uN/jzgotNh5Ay+dSqZik2npi4T3I86s/4MLFMKQzGPfC8Vt1ykPPo1S7Kr/13AMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793596806;
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
	bh=9jL0shEWjr8MFpwZdl5MGMgtbMwnxanO6FM5zgARG2g=;
	b=fHof2HiCnROP3YnfGCi6cqPiQG6TtmkNGVUGHAifE1SBzb7UTz4OhpJ/6Pn/TR4oqZzA
	 KBl9CLqpbNfsHPT6inDllnojaS8dFmB87rJ4qEnX0AHzkHOjdmF2rlfXFBoA7rfo5tik9
	 SxrG/S6blDVrJIY1ykJPzLAcYav2zUsi3DpBX+iXCWIRmLbFzqn/CUfq+zKiIaMOxGUeL
	 BhGcyxeno6xTYP/jIxDaQM8IRSpkW8B9Yh8q9d7IzKhlyDfHvBY6GHGu9MQJjOgbNYFpv
	 WoLDcw8fN16gB5jwOvq1vr5f97qVNLoz417pgwzTQvlPXRlHeUroB8zdM2y7aeLxYRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jGf8mtsh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.6
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013006.outbound.protection.outlook.com [40.107.201.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFDA60A2629
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 05:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CFDA60A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jGf8mtsh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rKo0W2SIwgDFd3iDAcvfTTWTk+11fpM3tBIBSjJcbGmyR7Lrzwiu41ng2MMFBt7Vn3hCd6Hbg6L6d49kt2XuEghKpTBdpZFlgqeGIpve1tn5fRrMV/i7I/32sHx66bSJEg/a5Qzu9aCQChvecReOgIhLePgfiLVodqEd+pz8Rp9Al9j30wMV2uq27Wf4WSKvhFpLjJTYKgZfLU/5o33OoWWJPKgZnIj4+0eNC0fFVVOkN7XHccTZGrfWizMAYyg9TXUJJ9eGKwBBGD+m92MWHEJULFXkcrMnqwmOXKsMSNHvkEjGU1uEO8GGv4BkHiN+HXhKY+cKPdZMJAp8y5owKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jL0shEWjr8MFpwZdl5MGMgtbMwnxanO6FM5zgARG2g=;
 b=uupJ55F3ZC7Yrz1CvVMx2DxW9FHSKcHG8bwCT/6LSl2WV5NXZeHx8n+sdZPji7pIpqvAmMboI0lMdEWqKsIreS0XILuxR1fL8kdXEVeDK3VTopXn+tAamScLdlC0bHiKwCK9uD7anSgrclN5lNCX/nWPH27eXALMDwJtGZJ7m9sKzybs1zGb6v3ujQDyjN5yQEE8yAqYUw0Kg6oxBMBIl7Kx0dCosK5gbDh10ffYKn3Pwh3WcnUUn2doW+kmy1pM1bOK1/G9Ar331nCy7OYYQq4opOHoAF8ZNQnQ2hJnaPuyeVuo7B8zF0JHmrfj89B8hl+UxpblvGFUlGzsA6uq5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jL0shEWjr8MFpwZdl5MGMgtbMwnxanO6FM5zgARG2g=;
 b=jGf8mtshoso4LCCg13ppFObu8M6V/uxhjHxffGozy+8oygX8e6dC9333NcRV3UVzn8x3G5DgGewawoB1W4+6+A6feSEFsDJtU+ZaqHxdG7vhDRhQ46VT21IklGgK0JhjB9UV0CBqThNEKIcxog+4vXGzMx7decobjFBwrYECfMc2TuUsPQyExd1WnrsYuMapBotZTBoGsKuozfRozXzlIBSx5WB5FX5I2IGd6Sv4j1+nfh4huqMY8Ibzk0i37ATsh3hJqvKxwQkYPdVpr7j+XnxPJbRP0+KIPhO13dBsqX8RQkAlsRjdL3fO+8eWEtJQQGVAhiwPIC41sDC8/2K0oQ==
Received: from PH8PR15CA0008.namprd15.prod.outlook.com (2603:10b6:510:2d2::27)
 by IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 05:19:56 +0000
Received: from BY1PEPF00026969.namprd05.prod.outlook.com
 (2603:10b6:510:2d2:cafe::98) by PH8PR15CA0008.outlook.office365.com
 (2603:10b6:510:2d2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 05:19:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF00026969.mail.protection.outlook.com (10.167.244.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 05:19:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 21:19:43 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 21:19:42 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Sun, 1 Nov 2026 21:19:42 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <praan@google.com>,
	<kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
	<xueshuai@linux.alibaba.com>, <john.garry@arm.com>
Subject: [PATCH v12 11/12] iommu/arm-smmu-v3: Skip RMR bypass for kdump adoption
Date: Sun, 1 Nov 2026 21:19:19 -0800
Message-ID: <22a06965287dd478ee92f8028ae8ac27e054555d.1793593923.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793593923.git.nicolinc@nvidia.com>
References: <cover.1793593923.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF00026969:EE_|IA0PR12MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: 203ebf02-25f2-424e-9ad6-08df38a0eeb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|30052699003|82310400026|1800799024|376014|7416014|36860700016|261021121427099003|261021135927099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|11063799006|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	BfwqoHVFBKyVynTgmopWFWAwJ8ynRUHTRiNjMdaOdTr5MQvP1mv4zx6ezDlo34XJEiuLUMLUcZHc0WVuTf2c/MzbiBh7hp56Pg5lwWzA/4F6J4BDYMFQGrxhYfVEr7YYhnjVe4xUoZfnu73yjzAHdWMnRnGYhdh0pegvCw2g86fIhRc7z5vrTIEDDh1V+QEorZed77DHsDZtsKILMnBVUd/iN8Pm9GfJC1ZDaZo0jXfZ0OR6kQMTBY9idDkfPdS5Yg8S1mfDyVjoG5dGffoEOKMHORCcEwUcJ+raropx32AIA8Xk8aDbfP0JLrge9gDMJCumtoKh4fnZBQnqevVL7uNM1eRnCzjixc61EdgA+OSyAvj8ckqfScowCrW6sTDxZ4x98V13rz59z0ojD0GhaZha05TPlX9NxtCQeAp7rqMsh+1EfedrKkBFBm9EBrYTV9+736RQUwEzw+UXE6D3MXTPqPIBwqmgLzCgC0BHctC512PfAzlE1VSA6qN1R2vLeEz7jq0+ixpydTti8DoC57iuETZ0KLaWEc2Z5mo3uz+SSVn1lcVfx39EtzsxpsAMnqjXAaJ3Pk+Jc6718RxSDR0jN5XAnvHraUhoy0vicPwjtyb3J6MxmyJps+phpegzYRrIkhaRBrEUgtoSzCaYOBwvc6kHtRMQZrM/nuvrLHWOsxDdPdEHbYIAtsmUBfMtV6dELZfW9GvE3EeTxs2B0w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(30052699003)(82310400026)(1800799024)(376014)(7416014)(36860700016)(261021121427099003)(261021135927099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7xMUVxd/bIdeM4tg/u3HWfAA6YZB99n/zbDcwowSeZaflLu4KZFdZkBv6pAAoqbHpy3yReW/vknqGWGVSU0TNdxnb2KLmo6D8WHkkxhgCWSc6Tdwrlr8OVmzFcGSqire59yJY8QlfkSYW1kw+YgWigQjmPQ0CTnmSZYA5PQdC1KrPiLcDfxrT+VNdkuS4FAlbJWgpjKq6u8Ez21G/5Nx+mONriOBa5je0RM/dqPf/pKGJx2iSt4NEIAl265TVIBqcMmvzLgr+PoDCxXxfXvRePmE9/7udmkzVLdlS72AmYNVDu0aTka7sgeNWU0wRPNYxtycqDQpbL+pb/uApxU7GLkvtndhxh1vEvT5JMl/IwIvBziF6iWYHltHKP+WX2rK7OjZxvWjzQrrbZDRSOUh260KKKzCvuuUjKnSA4EkS3+rLhshywmxk07ddswFfxR5
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 05:19:55.9994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 203ebf02-25f2-424e-9ad6-08df38a0eeb4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026969.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8746

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
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1c53c690a2b02..3696d11c852a8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5810,6 +5810,14 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
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
 
@@ -5826,10 +5834,7 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
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

