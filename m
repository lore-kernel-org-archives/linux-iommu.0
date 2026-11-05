Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793852683;
	b=Yr5Lh/bLQwcKOWC5+v0p9S2ErPXLNg6TV8e0mqsvWHUYzKrmLp5GGkoigXiXOgegLAr6
	 uD5yarMVHrDHh9cVjIqbTaB10fV62J497NnPTg2/ViauKcDZXkSmxgEZqrO6tuYoXYSUA
	 PogHCFpWZyZojfdsrIh6S/RoB549WMLXYjLiVsSckZXgRRPbQwE0tAQ5sHyUdU+4tt+xX
	 KQVmLHuJGftOxVfL6i3fxaRSV5Ga67V+XMSCwfw7Fi3KKlduAsWKaFuE3cF5yLYun8RiF
	 eVHXTPVhtN2fNifJKRaprM/Pcm5cYn8iteIK3KeBknS5m15Kxf2HJz7dWUx+KiQRSNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852683;
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
	bh=sX38QOJ3KojwxJafZfHVhSDAcNwaV66cHDYweipduJc=;
	b=116HjifZEFSD4KfihmnyWOnCVP5WvngJZ1sqQTB6qhE0Fr9VMmAwQvTrJ5fpOTwL12L9
	 pPfDbTMtnp/9KMWhjVyv+Uhz/SVCK2a0tJRg/9jF0m3Zb2357Kpy1ROqV7/VJ7sMHvpTi
	 MWXl0AAVJLxhpDnVQ2RtfpN1RwUVjS3BHm2cVvZlOQqOJM9RegPbkfW7eemgAeEQwAirg
	 fO+eekxCjGgOF5UNGnzMGdq8IR/cYdM3QPF6zBjHDZdpj2UUOC6NqsA9Zpuv2NKun03JD
	 vvGiyGyufk9ml2vEyI22jYFuio+JL+lxZLqZiI5li3rsaaVTHj5Bm1VJ4fl1ffQrH4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Jdp8dDnR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.12
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010012.outbound.protection.outlook.com [40.93.198.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E722D606A326
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E722D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Jdp8dDnR
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rm5A9K/zJNsHne4KYYCBr9n29fPoNuhDkviCUy8ORPJut5CKOk6epWJpgfjN/jbGwHUXEYY9ft/nUu/urfnzxlS9UjFz3dayUQxfS8holMZS+pV90FXHICOPdTGNyhBPrPza1CjZRVxGau2aNuhD7lQSoHPVyIut3i+82S/jQugh8kBNbhbKm0GggMcpb9Lb57VPqImtjGQgTLVI3FxaA9p5cXOe14sk3jgJlTe2ZX7PJ44aLE17NMBsZ/JpjEKPAaRSOzngc8Bf7O0XuapSZ+USuydoQz01ZSPWofH5SF0EWJHP4advSivHaWcfpCpJrZ63Ay3C/KhD6bbDHOUKPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sX38QOJ3KojwxJafZfHVhSDAcNwaV66cHDYweipduJc=;
 b=d1VgIrlhjPl6KKrUTr4kb9mrWfCmF+qKs1wRufmwk3wZ6ZxcpvNQdMCzGUwnaaHIm3TQNkS9RXiq6zOH9eZCrYDkK6g7ps8541TXT9Fyu/UD9VqSLISzczG6GS9DtByjyhv1TEQFa85rrnZRwFHVWm8l6NXYfugH56HOU2a4tNYZo4ML+nV3Nb2JtgIankvrWxlWlfgUBb6NkDK0VWRtIKZx6KFsUvb6zWC1dKh7oZUm89oExUbhg3ad84SvpcsM7Ja6LZbygGLYr54BYpYNtdIruhJDf07H4M9fS2mYxBCtfbdMBMOn0+co8eHhgAMASko7p458lP4fXdlYrNcxbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX38QOJ3KojwxJafZfHVhSDAcNwaV66cHDYweipduJc=;
 b=Jdp8dDnRzT+BgFxpH+vk7ivO21bhIYpitJ2I92OzPJln3TQW3l+ysRkCwvuWqVJ+rXZviThtZ/CjD4126+nTxnr/lY+TYbi+rglINXqJR/DiMQ9fTaXVFIXRShTR2LMD5FpIJVAK57hgy55HFgmIilcNyPlPA8+ovydF3sA5Y1k=
Received: from PH0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:510:5::24)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 04:24:39 +0000
Received: from MW3PEPF00001654.namprd21.prod.outlook.com
 (2603:10b6:510:5:cafe::43) by PH0PR07CA0019.outlook.office365.com
 (2603:10b6:510:5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:24:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW3PEPF00001654.mail.protection.outlook.com (10.167.249.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Thu, 5 Nov 2026 04:24:38 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:24:32 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 5/7] iommu/amd: Free the level-1 tables of a two-level GCR3 table
Date: Thu, 5 Nov 2026 04:22:52 +0000
Message-ID: <20261105042254.399163-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105042254.399163-1-vasant.hegde@amd.com>
References: <20261105042254.399163-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW3PEPF00001654:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0fdf3a-201a-42b7-c2af-08df3af4b488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|261022113327099003|261022075727099003|261021121427099003|261009223027099003|261026121527099003|11063799006|261102123227099003|56012099006|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SqmR8zPB7BMvRhbyL+ZUeAQk6O222XQ4OiGjEDf0efFg2bm7jLrEmdKFTBvhl9p8Tk7IA0pPyPDl6PxNgqFlChXs9AlF7oiBG/AnCGDEuWBBVehsFH+kd6XnPWLD1nC+aoE72JuiW5xVMqgqmECwG2Q1uAcBFg7MsuU2K805+iYrgYm/MeAn+ze2/bnSdT5b3qNP7m7h8iCF8qTthfrkWcZNolJqxn1BMSf7Y+p/tZekAO2zsRBuf6jQInn4JD37SijopbWpCPLFHo6JLJ4V47mahgU0t3cWPh24tBPXM8oqT5imc69omY/j4TRCHGoi8lGRCnNuNB5QGybzEFbJovOobd/6SDTz4D4nMlKavU9/0uPw+XozEcpuIYtaLplH0flGgLSOVdpb2Y2EfrkJ1outjk+ZIfcTzt3DLeiCso10rzYT3S60gFfL13zeaVRN2VtXsVaTwBkOTWQDNm7lGjGKBN9n1Eu2tnJwR1HM+f06Mwp2Oy0MHFfNsZbfsjUvZX8bnBd0wM9f4Z2HYY+jnV5B1gk29FN/ZsC9v27Qdo2LyQg8ux69tX6dreakk+tvUrXhKRopXprm7hTWoDfUkjMa687x0jiZgw0/QZgiVYOoiRT+a2PYtjuYuqVRw0UoydkJhBEa96+vrVk4rtNdJcas/V+CEwtM81NYRpiA8RHGOp+GKgf2Pm6QzZ6bJlRCS6ZqODqh2w3cFkCc8ILvDQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(261022113327099003)(261022075727099003)(261021121427099003)(261009223027099003)(261026121527099003)(11063799006)(261102123227099003)(56012099006)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JVUk7BAKBAAHA+EpdZOt9NMt/8CqEyzhQ9fTEV/3OwWgI8dV3Lgf39wLvuAmzX8AZQ1kzt3bnl6b+rrg+rmIi6Hp/hfLOAlsJtU8WYCSMKy3I/MvfXSL5qbuwup80EEl9jDm3SaOPkvHPU4BXIgMElTTkBKaHK3bJB+X+VcUqKxbZrVvqT/N48JsGWfEJEgMVAqnlmAXpsOo1nY05jDfQDgGJ8h6IoQt0rMLmZkJNv8emy1dz8MCmHWjWKklbjK706EDRdaT60N+kcG4o8tZKeXeT/SfDo27zW6p65HP5TU3QZDsNKcLdolR3H6+PzsGIBoyfZp6yteX2yKkU5cO+KUWBiqbQiKkyoMjXz/Wpj4tpJkqffCRdzc7NJsf3rOT6QsVyKHGiWZBhN3TSH5+hfzfBKmIFSOvTy0lmV5/jAkgbiTriTRcOfzYEwCFBaTp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:24:38.3835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0fdf3a-201a-42b7-c2af-08df3af4b488
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW3PEPF00001654.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276

free_gcr3_tbl_level2() frees the leaf tables under each level-1 table via
free_gcr3_tbl_level1(), but never frees the level-1 tables themselves. So
tearing down a two-level GCR3 table leaks every level-1 table.

This is not reachable today: PASIDs are limited to 16 bits (PASID_MASK),
so setup_gcr3_table() only ever needs a single level above the leaves.
Free the level-1 tables too, so the table can later be grown for 20-bit
PASIDs without leaking.

Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index a5fe524b5afe..ed37d924fb4d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1934,6 +1934,7 @@ static void free_gcr3_tbl_level2(u64 *tbl)
 		ptr = iommu_phys_to_virt(tbl[i] & PAGE_MASK);
 
 		free_gcr3_tbl_level1(ptr);
+		iommu_free_pages(ptr);
 	}
 }
 
-- 
2.31.1

