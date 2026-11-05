Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793851290;
	b=Sp/xxipp0hoJf2Jo7P87coj+TmkxIBxpe9/6qoVqq5TfUFTsU6FFb8li5U37Kq+UA7j+
	 xfTRdbxSNcAca4QIrdCNMYvv6thFsed3cVzdz/gAG5kIGJja4QsN2vJLhdiRT0ATgV0dE
	 AUcqjzs1UbF4d4W0IYYMWC7b0X1p3hcHcr0e4l8mfunkXpebgss8N/ovkD5ctWaG3DbpV
	 FpIk2I8U6/Khi4qZsQUpmk9v6Wip8KihI4NtacuQBgQwNmHGAvrO6qDIKDgLgHRypmnJF
	 LxxPsjof+9AACynDvP5/m0GzY/llYJZkxBEhmV2Twkb0DLGVUYWBCjSsRz/NpbXE6Cg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851290;
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
	bh=haHpX03BfPM4eAvgYhlTKD/NDhBv/dKzssTljxGxX/U=;
	b=yDKXg0OgT+xWeQ4JkI+sPKslVT4VBzzBykyeCbDgjio890XTFQMDXNRjWH8pDR2EFj0d
	 TPxXisBwXaxkBENgawAp6WdqYNffSPERbm4W5MoNXNsVy7D7TeSx8FSNFwOerRlBH8BTv
	 ALoRtfntxlB62M0RRM+Uc0DfRp8nKoDCTyidj3YSqfoqufGr76/MzNiFjLxxNXNwUvr9i
	 h6bVqxgrfsjHZIQMsZfLqODzeM8EFe0qFXPDMKcjBa1meEGhY9KC+Sy1Qa3Ju/vlF89Q9
	 MDJ5/Bb13r76EiHcfXYDX+3YatzgjyfheIeqKNVztVY8UdhLgmbl+DX0almOrTtFs2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3V+XCp3F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.6
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010006.outbound.protection.outlook.com [40.93.198.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3751606D804
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3751606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3V+XCp3F
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpI8dHaYoZ4/88EZ54TTmS/JJa3TKnUUbM9/H9bFVkXe0a2NiDEB0ltBuSNsHMSZEL1vWCZpyU1vCW/VO5HfIVcvqprL1QGCMfuDH+UDL0Y8duIo3ikvTAqTen1xd/4ug4LWQFHrhxoucfFcIj99vDuND35VT6VU/0LHcmLsiuK88oAvsTVKuds5JiqsOxW0fq6rT+nr2H42SNxN2iFrEx05g1BAi6FWe3rI3YtS1Tj0nE/m8Iu482gGPL5pHJLK8/7aQZIwFXvuK1US1RtqxMaX7VCdBb3V4g5KlFC5BKMcEWfeByciiNiO2GoAOk3A4CZo18VV6pd3ol0sX2IBbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haHpX03BfPM4eAvgYhlTKD/NDhBv/dKzssTljxGxX/U=;
 b=TW6YKH+emEyRnxAVqJKxqa3GOJLKXQBwdlWk9cWL4cf5uuTpaSc/Lp2OA14FyNZW6ugaJK0YuH8hrJ2ZYqPMvcZ+Fbm7KgnUWp4H4C8I+ZO5NWq28C/v9kNOFyRAN2Qqxa+HJ75NMPqKiWaq7tt+x+RPGwlO7jWowW2pd7IfYRvm+neuypKHY1PYA2Ykj4BBvYdoCpNRoygE9kvy6zHAdiM3+DyQ7IcLWvsMiE4VwDmubDwNHtrJxsSurNMpOCDCgsMRZ9VnSlpjeIYRZVSsb+4fZtavIJjqfNAgIzB8JEuf5Wj2Ilc3QYCpGILBjk3I5l4RgQqGKxFEo40bw6l0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haHpX03BfPM4eAvgYhlTKD/NDhBv/dKzssTljxGxX/U=;
 b=3V+XCp3F0NqyGo7WCTgWDPC12OaZSlugc7xKMAjNYW34HwYcd5HNHECgDy0jPJ4y/TSJjeRP54RIo0il2Q9FeHxY5OwIaVFmu6KeQAl3YRrWlKFnMzyS2hQeEtlFxtHaFYkP2ml411mWhv/vkFKmnAwmbJOXuI1z46mF6VV0stQ=
Received: from BN9PR03CA0602.namprd03.prod.outlook.com (2603:10b6:408:106::7)
 by SAWPR12MB999292.namprd12.prod.outlook.com (2603:10b6:806:55c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:01:26 +0000
Received: from BN2PEPF0000A88F.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::3a) by BN9PR03CA0602.outlook.office365.com
 (2603:10b6:408:106::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:01:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A88F.mail.protection.outlook.com (10.167.248.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:01:26 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:01:23 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 3/5] iommu/amd: Select XT mode only when the kernel supports x2APIC
Date: Thu, 5 Nov 2026 04:00:14 +0000
Message-ID: <20261105040016.398718-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105040016.398718-1-vasant.hegde@amd.com>
References: <20261105040016.398718-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88F:EE_|SAWPR12MB999292:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cdb2116-3c5b-4513-dc1a-08df3af176aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|22082099003|10067099003|18002099003|56012099006|11063799006|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	7yGxMeqT1rlVcX2SgEff4oojqh3DHKmbF7K3d7h3RmDFH7wah3CLdjByKnb8g6G9Yp68OanioqRFtdMYDD5Aup4gLWj5nogOtJK/ZbMPCJBeTbMqUZF7hOZProDwlAeBPisdYIjnWE9PUYUrKpPjPEMqdAkKFxxc1cjS5CZgYv9uoVAJdOyAYQTE6JJnEp8sPPivGtHiW3s951ke5eCwHQWMO89oopSjZDtcv1H8I4/eVPSXPmKv381Psg5BiM5SLkBeFgyQZWlHeSSS80EEl1nUmQ3+7g44gEy+CjJfWuQDBUrjLJ3XGCIrz/h7t2wy81RJ1pg7OYDgv/K063G/v0ULBgbQGpC/1GUd1jh40WuLHaPXOG1iMmy3+hVPOFy30eMWdxknBvnQDsLkMW/LzKSOWo6AIAuzJYJ4m+XrayaX8/oviAazDWNGvik9iaZZaGJLMvZmMsnDmcX+pyYeASgM7zkk1InLVr/isezyJPHH53uiFYIXS8CNLiDQL/3D3tz+mry/SI78jC3nhUAwptgKYGHeDwek8mZ/mKtKEmwbWex7sQBd7Op4OzzIR1STOS7C919t3ZGMiJgojFBl0h+I+c48COjohXA8+Yv/VzZcLWgp6dwmefZLlJidfBcNIpemK5Jo9lB53pyPrW/asE0ySocdcnWgg/Wt1jsz9auqb5sPflyxBTeCvinUP8zOLCJa++wxfxGvXnYxO6YynQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(22082099003)(10067099003)(18002099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4Q3mKkQ0nz3k2Q37mFUs3J6WzxsjirqC7JF1zvRGb9jtmna2gOwFzIdFWvl6h3ia0N7p6d6LPe1QYWTG4s4AyxOKGx8e39lXmTLAczKGHmK/Gwq6FA/0LW4nE1Nnk3rAav7n5gQht3c/oEg5L06bokjd4rAv0PNtyMI0x6P3/VqL6q58bJKuQizp2t+0PoCiN84pe3nAxTcLxKTQduGyP297M2ifcTaH95iICnm7b2txKpw3RfPkYsSLVKrlxhYSmqF50aLwPq4IV2I+cH1qeO1bunzT9Tvz4IAbpEC2Rd9sNxUgoDL+T3PH0ADxbFOgp9Mtr4xLlkgRjy3CQOX7uRWTxbiUtanE37Iu/z3JpigDchmmYH5SsOPdMx5/x3BztGx1txC9n0aNj7iWKBvpSYm7jKh/ARtbnlCf2ldEqaC8DA4VaITXjy4fYRbBY2Q2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:01:26.1931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cdb2116-3c5b-4513-dc1a-08df3af176aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A88F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999292

IVHD XTSup means the IOMMU can program a 32-bit APIC destination ID.
The driver treated that bit as the mode it should run in, so it enabled
CONTROL_XT_EN and allocated INTCAPXT interrupts even when x2APIC support
was compiled out or disabled on the command line.

Stay in the default xAPIC mode unless x2apic_supported() is true. MSI
remains the interrupt path for that mode.

Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 877122898e05..9cb61c2665cf 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1948,13 +1948,17 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 			amd_iommu_hatdis = true;
 		}
 
-		/* XT and GAM require GA mode. */
+		/*
+		 * XT and GAM require GA mode. XT mode programs 32-bit
+		 * APIC IDs, so select it only when the kernel can enable
+		 * x2APIC. Otherwise stay in xAPIC mode and use MSI.
+		 */
 		if ((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0) {
 			amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
 			break;
-		} else {
-			if (h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT))
-				amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
+		} else if ((h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT)) &&
+			   x2apic_supported()) {
+			amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
 		}
 
 		early_iommu_features_init(iommu, h);
-- 
2.31.1

