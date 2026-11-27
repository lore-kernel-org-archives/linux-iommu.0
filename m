Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795778903;
	b=NmsJ5oP4VMmDWIURSbpCSmwgRwkgPx81AJYRn+73XPekKgYA1H+bCpuhjDKfJv/2pCpE
	 /k3h04Fx+WCqYghNbCWZAK+gcgghGchY5CLuATgA9yvSH5q1ce8/EnCVSwg//NFUZarjQ
	 7ui7XxN8FWPWz3bgs/Lua+puSFeuoGEDZjIOSTvbyI3RF8AaVlUAQqYNPLr8mU3263on5
	 3+61EghxEPDxqXp3fcKDTRP5Qh5lEWZFZO/bzgu+FXZaT8azKhWQtj9J3YtA62fLXJYGG
	 Ms+knxW2Z+7yENO1T/s0leBIxej6S54ZrjotiJdPD9NB5f/M6oIkLLRU1oU3SbMWvig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795778903;
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
	bh=kDg++eU6Jovyv++L3kJuY1YiXNirY6T0tCjp+NkVtJ0=;
	b=Yy0DMJqpSneszgjDuALf9sd5UovNRBX5X8t7qIrChqaSJ52R+HDfsuqQ9zVAxg6Vc1xu
	 PFBK4RvVlssno8YIvEz/Paf3DQUBkWubEf/+BG11svEWMZ13YRXsV9Ng6uIJubWHtfyDh
	 puiZ/IW1Ovddr/xa8RF0bR1U8G7Zr9TJlQas68JYUZBy2DLyLL3ZVp93owKv/SKZBfwxJ
	 UvQNJLtJyF93CZoSdkcrpgIaKzgccWA1IVP5vqwgcX4Zpp7Rya52aiXuPGC88N4zvftSH
	 zPdo0PCJ611E/unaT1Yx75kwNxHmKqctj4/aamDWkOHXlnn9yXeNpyYGUkGrSTTGBFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vCn4Fn82;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.18
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013018.outbound.protection.outlook.com [40.93.201.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDBF606A32E
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBDBF606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vCn4Fn82
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJ603y55nDAYpPy3cKT1osVBPesOV9uGrUHQN2ZgZ8ooo4oahH+xp+zz1eNPpVynyw8aZqcWOWxeeeiOCg6T3OXZyiOmdjIBJr9l56hC8ztBRG5h87Zn3RgVyEqsgAMYzZcjpTFxRC/X68cEUZXCElBqT+Tj+H0m7Ao/QuQdE/dPCuJOW/Usbb8VhR9jLefUbLQk5w9jBaH8G7OT0gTKzBg64p7myWxWlEQJLW8sDLY9sQAPSFoRjnH565QtdY+nnLEFltakBHm2NH4LFYg5t21MZzpu2eKfyblgspbCC0ZOEy7zt1FyHIqOTiRPu/gQXWPZpi1SeQWBCwSnI2pytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDg++eU6Jovyv++L3kJuY1YiXNirY6T0tCjp+NkVtJ0=;
 b=bnE3hM0pvV3FrnhcU49czIEI053lnUBipHvbrowUj1oBtcxjcaVrk+FvREJ5q7QhqHLQQZFP49mnELSHG9iOOBdVIfLGKkX2oIs2enXQwjXjRFbCBmjVRLvArsi7RwJa6p9JES68UxJInzc8ZF8FwH397FeLlufc94ip/+Y352wuvc0Z1pUkIxJLVFRYRK7CUI/HWuSWMg2TxjKOp4sl+1EbMUzd8IFNNAxMyA+f1A5U4x9Ci6M8JJ/3oQ58eJ57TOBKFfWpU1z66pkTa7fHD3QXrHWQe5kZ4ckqY1etmYaK8/m1Qh4tS/cqwRXrASmBWk0PcRdM6u6zqPnitOho3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDg++eU6Jovyv++L3kJuY1YiXNirY6T0tCjp+NkVtJ0=;
 b=vCn4Fn823K31NPyb+BkgP6hegJcchJWyN+d7yiNCi3yPQOm/z2MtIOPqxzr35TVVbu8IFJ8enHhGi3wVd3HjubRujJyXoaPNrPnSDkZP9M90fvUXHTozs4kCfWs/oK7WepOAaFA1d/mWTPrmYTdNDIEUslC9XaWh7a1jRu9qk+4=
Received: from MN2PR08CA0013.namprd08.prod.outlook.com (2603:10b6:208:239::18)
 by IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.16; Fri, 27 Nov
 2026 11:28:19 +0000
Received: from IA0PEPF0000003E.namprd03.prod.outlook.com
 (2603:10b6:208:239:cafe::5d) by MN2PR08CA0013.outlook.office365.com
 (2603:10b6:208:239::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 11:28:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003E.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 11:28:18 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:28:16 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 3/4] iommu/amd: Log error message when IOMMU interrupt setup failed
Date: Fri, 27 Nov 2026 11:27:09 +0000
Message-ID: <20261127112710.208885-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127112710.208885-1-vasant.hegde@amd.com>
References: <20261127112710.208885-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003E:EE_|IA1PR12MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: d45621ed-e8d6-40f0-a1dd-08df4c798959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|10067099003|56012099006|261102123227099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	pxzxjfYnfznIsDJ3tQSc0xuttaaLd2BcIiDSciArhn57R0ZVlunTmEJIrJD3KReff2yOHlsEp7fW4kTT6gQ5gIHPmtZ2aHY66fG9ajbbCThyu+AOf7wB/WTsVrUYliKbaNpP80vtEEL79lTerelWZqbgTtsyt9h/UtGgktHlODubgCpblLqoNGZUEqt41VkfZeipeTj2W8rxlF+0yLuV2FtUh3LnePx+Sx71h7ZyBOT4uDlJArcGmcHCIvDBD/bFlLcDWcO+ENAp8ywNe6M/tY2d0aUXh8iCQEcJWJBehdiBZsdPm/f+ca53gME26qBjjVayQuHHZ3IbdkQysHeNWRY3tLG/ij0HAO1f7pPf5oZrpkBGJAjTX36fsQEHcekJGkLxFE+q+t4KVLLyjBkgD+b5sPxdbftL00EoQoWfN8JxcGOerAc3ao15QlqTfOJlHZe3OTLIRxEnVu/1ggV4B915OBAk0N7xslpnlZU0u/G5m1SNvaaAFq0atUx3mu/oCLeKH3bISVKMZuSPMlrTSlV3q5hC+IWpdhqo95oJULV368ZGYPui0QSdCEo/06DOtd06Rn95wMUEONCD8/eAMaLjZN55mQx546PowrNXyyPie4bjcuCO/1DljI+NuAwZP3MlgzcMvtcLS5hETaHIA/ks20IXP5wJebvPiiNhvF00L7DH6SERqym87mHbJ2pb7l5yr/8xIL5/v4OAF4N85A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(10067099003)(56012099006)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pwQ5PJ+HSBTcsJ8slBYWqq/h/pvph2bRLGyzWxjogRPTXuPB68LQszcx9BPxwFM7MHgCE1SaswVvuipnWpSaHf6yL5thYBRaV0NWbR9q94UPQD4KqB3KNt2lFliDr/aQvGCkboaTRXv+wx90MTT9lAKVqqC+RTDpMTfdoU4iWWJtMPqgc2UiyQOQizMYGvvDdxXZM6JjkC4AcojoGuTLQGcxWMz2ILujNLZ/l5WdyFTQEe50AU9W84aW+PxlYVQCSgNpC0+Jv9gEAQisVgOVgDSE9R45vCiIYLONRP+anu4x22EC8Cr62B3+WwPyBGYg8/6tXW6reB5vMT1znIZmFRokEUyfkzKoipV5Q2TseUTpd2mx2jXn7HkvMIa0iLQ8GM9c9TiThEkX/IQdnqEpcqRnz01a1eluehOrUVybUsnJfAAyPLSbrGbbc1vHL76F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:28:18.8577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d45621ed-e8d6-40f0-a1dd-08df4c798959
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031

iommu_init_irq() returns -ENODEV when XT mode was not selected and the
IOMMU has no MSI capability. MSI and INTCAPXT failures return their own
errno. The caller records the error and tears the IOMMU down without
saying which step failed.

Log the missing capability, and log the errno when interrupt allocation
fails.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index fb3a93480b40..f9258ff1c5b8 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2701,15 +2701,21 @@ static int iommu_init_irq(struct amd_iommu *iommu)
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

