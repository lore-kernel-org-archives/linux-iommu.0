Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.24
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792781472;
	b=NcXUsNMu6AFS+nlrAAHpQoe7s6lb6YVUGOIQNV2frtHXZ0Ffpx7CIJRO16Ko5hriQ/zS
	 44NzkCfU7zO51kFhWKjsV9a894MbLlofdG8di9dEWQjS7nx2kaOQpKIWJ5lLggNRB9q9w
	 LY2XYoYrfLmKcR8lar1OlDTUyq5iHCHdcvtK4eBVatBgZseyQ3oEuFcy06RXH6LnkefNW
	 lxFxQo6SNhxxV6XFiqg7Pbg/cic0GAYtHzOWOvFuMcTa9RFfMquzgneux9QbKeMQaIz0f
	 ozmcsRNKe91+AC7Tm+tM21Q+Nd4w567Vv+3xyWp4C5gnK58JufyyWVhQeltrZdCse+g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792781472;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
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
	bh=MrBieMwx5FjVtLgMmcvfUBiUvgd9aVklelI3U+W/DtE=;
	b=uYg3W+BDNQbNn0IbeQxfesPR+tEl9pmtbricdQoRymyVDLLGFgZvlw0Kgg5fE2mM4Uwe
	 LF11K0VQ8U+fLnXlL7aHGUnkMZgMsARTvTvJbSEvJADQEz9u+NqftNOZTl1Pw8T5oHu9G
	 sr/zunTtD482rhCX/UPrSyUatnxumuA4cj+EYJMskQxk8t/Ob+KQitvDdOnHUeYkGB8sF
	 u7WVI5RU0fzz42ndEguS8ZjSzYNCJkjPop3OYeGka32QScPapZF9Yw7mzzUOH+tDqtZpG
	 5Ox8fImLXCDOe3yjoykMaz04OaCaHKn4c/GHgu/06ACCyHY8+XvUSZSzahtYGNYnheA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=T5AQ41Jx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.24
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C603A606A31D
	for <iommu@lists.linux.dev>; Fri, 23 Oct 2026 18:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C603A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=T5AQ41Jx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4ikfjbShParb75spkW1oBW13wFSzYaIpKWJ9BqHzz2Wnc+p4qDf34h5vLNKFMjU3qZiJwAaMWqvSQyCXgnQZLlHphiD8flgTCGU8qWTTBYzGRO2CElj2i5+jUrzMJkolG5jidEo1Y7b2LdPkDOV9jrNs8MEojIbHROyaL+gDcQNEOZB3ClFscGuNrKCqziiUJKfCXFpjeXHgeaYsD3xwgul3ikdtHkO21TwKqfgm3seXT1pRfrD6RHejlwOSJMy+VdK4aTMSnwf9deAFFqhx8g9s8/NSiy3ZTc3zHIW06RXeUQQTFY4of5YwINNPjMJQOmgmHZxPewwS4qgAty41A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MrBieMwx5FjVtLgMmcvfUBiUvgd9aVklelI3U+W/DtE=;
 b=hZRAlQ6k5CBoUiwfVbVb/JPbj7/XjVRGCFEXPBiCXc+bKk/MPGtg6KjjgBlqDiAQ6h+mbsXcl26XZZaCV3DLrphc09/ZoZb6vFth3kTy9CKE+gSoSOt2TTaJ1zBPxLw7RXUa2Pm2OKnClzJx3h8j2wACxW5+E9YB9mXZjqc+goGhr7I03Un618z04jZ1DczQtrCVsMNHqawAIUzOif4F8dMUoQxVBV3Iu+v2aP3ywsUAwafjiqSptalzOovF/32zx3lZud6LlilWglLexSswmkTFlWDqgmpC+aYXNv0hGw/lCpoH6RE/AZ5mFQEruc7i6qucqoHDwwdgbSA1RJqKww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrBieMwx5FjVtLgMmcvfUBiUvgd9aVklelI3U+W/DtE=;
 b=T5AQ41Jxd5wWOFnV9u/bAX144Yi0N1owynbMpT2emWAaQW3z/8jR1JGPSgR6MXqpojivSaGzoxio9TjAz967hV4WSKSqGq92f2po8w3LQp78RkoDHc5le7/ta+mhk9f2KVrk/U3UF0h0LwlvQqTnYitAX6UMJ9DsC6Xv90tPxVo=
Received: from DS7P220CA0112.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25d::9) by
 CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.15; Fri, 23 Oct 2026 18:51:05 +0000
Received: from CY4PEPF000392DA.namprd03.prod.outlook.com
 (2603:10b6:8:25d:cafe::7c) by DS7P220CA0112.outlook.office365.com
 (2603:10b6:8:25d::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.18 via Frontend Transport; Fri,
 23 Oct 2026 18:51:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392DA.mail.protection.outlook.com (10.167.247.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 18:51:05 +0000
Received: from BLRDHSRIVAS.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 13:51:01 -0500
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>,
	<vasant.hegde@amd.com>, <will@kernel.org>, <robin.murphy@arm.com>,
	<seanjc@google.com>, <ashish.kalra@amd.com>, <pbonzini@redhat.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Subject: [PATCH] iommu/amd: Clear amd_iommu_snp_en if snp_rmptable_init() fails
Date: Sat, 24 Oct 2026 00:20:41 +0530
Message-ID: <20261023185041.8685-1-dheerajkumar.srivastava@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DA:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d9d788-666a-497d-5581-08df313697a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|261021121427099003|56012099006|921020|11063799006|261009223027099003|18002099003|6133799003|10067099003|261022105027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	RQJpGJVKr0mWU6pMMQcnpXvWHFpiuFq3DU3CJI6SB8YNk1ncd6h6e469G8rn2EtCzFHQ0cv20udSilb8VUTKvlXrcDlwk+Yo6rZErh3x4QRt8SFCenFql0qLWRQdnNPX8N4UXRn27Zh6leDa7+e41yuV6GJbjOQz9tU16RrJWd1ZscjTu7gYAe+z9RWbVUsjvc2ITUDdBeZLXjQkrEIECAs/m/YgKATQAvRlOsjPUKiNtlp0VYNGDJrZhjvYi3vYKsFXbIr0//v7DnIImyltPRrOXf5+abum7F1k2I0n8zhBD4UMcr5PlFlYUoSZxtnLPu9fdp0uxFhqC1N2jX8Jx/oRCTI6Bf662gW8w24iMQyhV9uvYwDdORbtnx9Rov3dU7S+sVQOK3A39F6bi/PE+ERbZgXNPVY8S2nG4fC1wz18Yli4MTlVFxTJXhOK3paIICGhf7p8ZyUkwo0Z9jRV1qdx+Ch1p9pBmP1Dk+b+01owuXdCoNUjF9OCkeoou7jnWQVYveK1CzX2HEnI4lUhr/TWNPNLwIqu0vfQrpGJC266lYwqubyXpgdAH7cjyJFoKHJfYWkmJ+G4i+5Ai/ciyMdIFy0xxMsI5lM4pB6twVxg+jSdZh6SMP4BUIzKvCcXI5o1p76TbCOidufYEI8dYEUWDgGqdNcukdbuUDODYDJymBB60vKck3CUugxOaeFJwYlGn61Kk6MdPBXvIAiHUyN00q0YHKOFIvlEdv42X/ihM4kjInaanFrkc0y9OzxJ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(261021121427099003)(56012099006)(921020)(11063799006)(261009223027099003)(18002099003)(6133799003)(10067099003)(261022105027099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	09a/S65RQLQcuMTERfcI6vQKGjaNLGgv4TvNlwY2VXtxWVPum1jH2164yPdRukrn/Onjnkx9gifkFI6tqvTZGcFhiyf+Kca/HO2/D5KH3RT5E274RtbaoVCFB5Vo3olZ0J/gD/JRZN4l2sItXr/VTlomrjzILcZaxDsE2+mtqnKkTq+sXNBqvCLU4bT3bam+cXK4cq1gdz3S7hr16boksTqW3UCbeZVAlThPtMonftiuzidYAsOfnLAM+9GVO7zHgsunp5TtdVV1ndjmjYnVJNLTun2C5ePOIRGxpO2VaKR29Ra6SbwHweV8lAlbryCl54lu9BqD4TQyqzPZ9NehctPlnz6fIhrLZvm/Q5sfXwrqOdXEkdy7SAvN1UIVIWHzYRdvxJskBMoRWxPgGl7jZJ0fLAGGfj/s9MADO/cEsA/PTsKwJf9y5dD/Xl5fJFYp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 18:51:05.1071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d9d788-666a-497d-5581-08df313697a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF000392DA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203

iommu_snp_enable() checks that the IOMMU can support SNP and sets
amd_iommu_snp_en, then calls snp_rmptable_init() to map the RMP table.
If that call fails, CC_ATTR_HOST_SEV_SNP is cleared but amd_iommu_snp_en
is left set. Later IOMMU initialization uses amd_iommu_snp_en to
configure the IOMMU for SNP, on the assumption that RMP setup succeeded.

Clear amd_iommu_snp_en along with CC_ATTR_HOST_SEV_SNP.

Fixes: 409f45387c93 ("x86/sev: Fix broken SNP support with KVM module built-in")
Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
---
 drivers/iommu/amd/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8a410d4aa370..d413b1240294 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3445,6 +3445,7 @@ static __init void iommu_snp_enable(void)
 	return;
 
 disable_snp:
+	amd_iommu_snp_en = false;
 	cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
 #endif
 }
-- 
2.25.1

