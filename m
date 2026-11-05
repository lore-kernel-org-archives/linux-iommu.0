Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.55
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793851305;
	b=4Uiqe0ISEThDHnKAjs1Ck907vpFW6p6BIcAFrSKw/4+p1LLOXRZR+U+40xot8XzbyW4S
	 Y7FncNAm0Ca48Vg/heW8ExCEcdI45akEotwOW0vzGhJOxRUsOe5hQRi6mVxRa1TDCtkMe
	 gsoXLnAtvFnJaekJINv2nJOQAiVNV8UyuIm/iWBgZdK4u6tMdSX5F/h0WdTC2geYlBezH
	 3UWI8wsT0lHLDXldcofKDyu00Xj/Qy0eFbwkxvKImKAGnxCYsUEqHEvPCvoXmSXUHGt3M
	 5AYFZ1br3VVMJoeisGbnLVqA/3rI460Y66xYhMcgnZey9EJNUeK+6L8/PM1MfSq4B0g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793851305;
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
	bh=34d58OfbalK6t4bee5UglYzLNTEKlRMxE0pF2o1kh3U=;
	b=soEoYxkSfns1rTkyBnC0vWL/fQ7MJIEoZYQXO11fm1i+KX6iONGn8RcK6IXfgSiBMdzc
	 SrcRzWj1Xvg4+fiTSAy2WAH0xzoO55nvPCVvInbwnWTP5QEQxVueZbgMBD5f0SgHebIb/
	 Lrvk+2FG8yEqnbQe8ZAI6KmJ/udd/TJWpjF1c4tDiS49vxC22WPl4Elfgbxih53U4q5z8
	 uFYeEkxJXqosFvu/HvL4vhrOEJzhs2VJEjMNzEN9s7doi7Ko3THd+XZzk/IdBtW1j71eU
	 6QNCWQW7gUAnZri1Wu63f1SE39f91GlwtXoUAHDncE3gs0AMCQp6WCIz39aGI063HLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bnqouMZD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.55
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE94606A31B
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FE94606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bnqouMZD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIZq76he06XVhsXEtz8P9tk7n/iO6pBt1h1Ifye4dlLaNtbsTpgGKbHsNySpys9sKgFaqpoGnRr+NcCZHVdJSllPrJ+hRRbzCDCGHjQhAvGHJF9MThvqJk+eV8ov9FdIb1Zc697hA5hPifktdzMV6ITVqb47pBG7OHNEcVf26f75MaDKX5zmLNTB/X/xm6+hZmt6lOw/DeQiFtF/xqnEU7ijv3D2a87XP7gKA2wRBtMHn1NXrQtlDV5ZaV1LfA8asT0kU9eK5DDoJaJDR58bTgNlpxq8TCNus2QgGO1DQLY9Rf5KQiiuRM43A0fKFgR0qlE2sUN+D0eWJsnXCak6CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34d58OfbalK6t4bee5UglYzLNTEKlRMxE0pF2o1kh3U=;
 b=EStXDnUbxj0JoaAQva6C7ctknxYaLRz7b0EwcWuQo4j1tXlP9IynUjDggHOzt3axdYJpRMon+vZt41gg7sCNnknPz2t0/6lJ2p5U8kxZ6oe1qMMqBOeP06Ftmujy9ErNB1kFVW5Zx5brQ7KSecF0Y17Yy6qXLFqC7b1JtD4TWAZ644+5f8nC1VGg62bay3ErDnMBScKvl6QIcWAnmzYvktJXJQJD6vCC0V2jyzIIOzlPXmaSKKNX1UFzjG0FPdEKzKvg9lKnXPIlveVgxseU2aD3yxTx8y9TkyDb03KfHgu9tRjUy6O1FUdPTa+NuT25zYVzZ0Y+LNuHP/CrIzJBxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34d58OfbalK6t4bee5UglYzLNTEKlRMxE0pF2o1kh3U=;
 b=bnqouMZD4rf5EcFZHzYaI+NM0bxqsmLb6hrYoz+uucC0Af9+fWFw0rjAfosl58vX5Rmxc1bHNUtiL/a+z4mNV28ROVM1JB77mFqQeY/a8ArJaJb8MkBoAblLxNXTlRPCX9c0KnAu69fDjXVxs0SAag08yrCGWygCe/FRegmxbQI=
Received: from BN9PR03CA0911.namprd03.prod.outlook.com (2603:10b6:408:107::16)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:01:41 +0000
Received: from BN2PEPF0000A895.namprd04.prod.outlook.com
 (2603:10b6:408:107:cafe::5a) by BN9PR03CA0911.outlook.office365.com
 (2603:10b6:408:107::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Thu, 5
 Nov 2026 04:01:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A895.mail.protection.outlook.com (10.167.248.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:01:41 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:01:38 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 4/5] iommu/amd: Log error message when IOMMU interrupt setup failed
Date: Thu, 5 Nov 2026 04:00:15 +0000
Message-ID: <20261105040016.398718-5-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A895:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: d2131aa6-91a7-4794-ba45-08df3af17fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|261022105027099003|261026140227099003|261026121527099003|261102123227099003|261009223027099003|261028144727099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	pKI8wn5lWofSXZitYW67tFwcqouf8ZIG05ir2Z0402nnt28kxpQ3MwMwj9FN1UF1pZbsYdwlrz/zytvwJS9lpYA9cdUNXxaysGdpT+z0GOPSEBz3jsZFAj4ljcB8V0JiD45o9HhgTxdGpdEqJ0Vv4VIVnmuqgH/kcw23ct6zAZEskjE84upn//5Nv4qFNOlhEs1H4XvFXqAnb8WZ6ptSaS4wpMq+zXnT18um2jVOJFg8sPYJXptH9XlIkqhXZ/nuzQYpS2ZSq7bChBzD+w5Ngr0LccyWbTZnGKScbI7CSnpiglFsWKkPfdNOserdHzw2CHiyo17B0P/AU8nwa6mBkrKGzCdHnBUEfo9nw+D8bQiTZxIpYYMSRU1qf0eI4mcYbK/cAK5/xiuT6NxDTmFmQKlG/jNps1Zv71DrRlUgTKJCdfb7lpczl+SRtyW68PHOi2QoDmnTDQmI11AD2J8ws5Yno1S2KyeC7FLeBw9UoomlN7X1SC+vZq6PRz2xhsTSNq84m2Kyaxdt4e/i5nkcLx/dh5rpnnFp04qAQEnKiY6yjcq/YKlraKAC/6GEXmk/FItVleN8yX23G1xFSyER01ynSUB6UcicAYUGs58ng9uOviieSyXTZ7w3+4ZgINSR5bHcNowpsMLsN1I+wvA8AzZiV3P254CPmVcB4kU1dppiXesSxy88KyO00y2YlCQj0WyWWuwIPuIyjRLzYOmZJg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(261022105027099003)(261026140227099003)(261026121527099003)(261102123227099003)(261009223027099003)(261028144727099003)(261021123027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AINwiUuQ6hjHGpJo9B7XN/qP8xhmrla69zC5p1sequWKR05CvaAlHd7u8o2HxYV+zFGC402dIa99W4vQNpcM8NWGbjQwbPslkSBrcUYPJB0E6pa3b0xc1I/2R4gwbnERRoSuJ74NDFupncKdQV0FBVr5FkFIsx/9vcX+k3nCcXEP3pCViVmEqXZvMo3mO2PIZALl8gwXcuzbqwDKJWBc2NS2RzrlOAZ7+VCi73ivqSBWKzxcjc32hFyuRRvX70YvBdDtJgprzqbaeyONFcaqlosAKs6tmkMpXJw2TfrNb6AbhIKXZVCypY/SFmdjKb59hskXjEweBfIj6lL/725V/CSJOvsT+FTx5Myy5IhjfzHxHY8VqWN09xJUDM+3WYS+u93avu+DQgYMtyUhvIGk9UwTodA88jhHjHzSrLX4D9/F3V/bSs43pO04cunma6bJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:01:41.3096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2131aa6-91a7-4794-ba45-08df3af17fad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A895.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374

iommu_init_irq() returns -ENODEV when XT mode was not selected and the
IOMMU has no MSI capability. MSI and INTCAPXT failures return their own
errno. The caller records the error and tears the IOMMU down without
saying which step failed.

Log the missing capability, and log the errno when interrupt allocation
fails.

Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 9cb61c2665cf..d967544baa6c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2641,15 +2641,21 @@ static int iommu_init_irq(struct amd_iommu *iommu)
 	if (iommu->int_enabled)
 		goto enable_faults;
 
-	if (amd_iommu_xt_mode == IRQ_REMAP_X2APIC_MODE)
+	if (amd_iommu_xt_mode == IRQ_REMAP_X2APIC_MODE) {
 		ret = iommu_setup_intcapxt(iommu);
-	else if (iommu->dev->msi_cap)
+	} else if (iommu->dev->msi_cap) {
 		ret = iommu_setup_msi(iommu);
-	else
-		ret = -ENODEV;
+	} else {
+		pr_err("IOMMU%d: x2APIC is unavailable and the IOMMU has no MSI capability\n",
+		       iommu->index);
+		return -ENODEV;
+	}
 
-	if (ret)
+	if (ret) {
+		pr_err("IOMMU%d: failed to enable interrupts (%d)\n",
+		       iommu->index, ret);
 		return ret;
+	}
 
 	iommu->int_enabled = true;
 enable_faults:
-- 
2.31.1

