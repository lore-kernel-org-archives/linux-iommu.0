Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793896395;
	b=GjPPT6oooQcCewQerbis68vlpyYdvTeR3TxZifR9r49ja0ULDmi6UTsPjku2L/mZBIpf
	 lOOn20v0DWQFii3mgWmj+EFYe6nw9UENGz9bWiaKED5DZdFnSIiJMWYzJ8+0H3dPkWgk/
	 6tvNeiKNcHqZePgIBOyPmhFw37RfwZpvS2SgouqvVzFQiNOArQ7xJquU6X3zthfxxipEV
	 RPha7mYuGzDtls+w/fFey/PV6U9P6Cg7mKvrPWvQ7uvMXZyHDR+oW4T7B5uLsBkqE3UKu
	 kSYhJusOgPYRvRBXS7NnkUDhM9sGl6Ly3giZWwasLqXJTRodhL9BBFys6ug8w/B1P+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896395;
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
	bh=/3+9URZQ/xlMaLjMOsvPWJUcSsuLhhgfIm1UAqQPGes=;
	b=F6GfnZBk/urxgLRxHOJrcQgHhXEKv53bJQRxwapwHeOVJ4nKOMESKxZhSKCkkEMFwRQ0
	 JQj9rD8V0ZTMVLagsoUwENaBFnAJvBbxkEVLxfQI5+COhzpmxcXGcfL5JssZADla8hTbz
	 bvYKnB977ZKdrXQZLsJRnKK+YY019xXH1G6lWl+PKSOIihZKfWupaCvbWS+nWosPenLEJ
	 E/ZrTic6PL5xzxlJrGKP6lsbtNxlz/PI84+Z9Y+lVhoSqUKUDWSptQve2fJcnKESDnJJW
	 r/moI9DCzN3NHT4WSHY7TsQVEnGpDD/xJG6yjdYVeEAheBChTbiL6KEE5K+zncqQSIQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BNzRcdJK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.69
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88646070383
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 16:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E88646070383
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BNzRcdJK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpvffndrDuRtYsWWOLJCkaqjplfwq8ArarQ2rgndUl/YJFe0WUP6fs0RZfA5dgLk65FYbwWFSx7kN6iuZhO66LqFivNbQudoR5edz88a+w3pANjbQ29go1Y31i6ah3oDAMFuSVxYmqvcDeRn2Yt48B6qKw2BS/3AsviW/rEGu1vU00a6dhV3X/i0gkVyq5lIQDUsBCUjMlaJnlidGEC19iYSw2E2Mfzr6551f8Ly3ObCPVXlFyQ2dDReHyFSgsg/uVsWKLPqqDO3bdWkusR+//ehkoYEREzG+X2HT/XzbwpJx0fUFDsotfbCsjIQ/qv3lxr7LG4TD/JMbe9JYTJViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/3+9URZQ/xlMaLjMOsvPWJUcSsuLhhgfIm1UAqQPGes=;
 b=wBiLN6ImJ80OiiC2459EvREMQ2kTMHSaFhKY+LZzUykUFkSI7KeaT08B177BpDO9bPb4S8yfH8i3hi11jFXNoupPpRDekdy1qkHBVWacmNrdVeORITx/UnTXoh/2z5EOCnQJWv0z0tSa08oa5vAlvFnQNsvnbgnV+0LI9QCy9a51pYGruI5A8N4CHVcPlkyxmvLnW+AU/3WKd3p11WgNLANYFAEKx1TOU8eCfOqZvv1wrsLpR0jU5fJUFbFJOUT/23E4GqWVAJi6EWvkgMeSJDgCRtosF3D3Mb+TQ5LiV5/8fWIMtnInpDKjA2UX/rBYcL5ye5x89C5LhBe2unnSOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3+9URZQ/xlMaLjMOsvPWJUcSsuLhhgfIm1UAqQPGes=;
 b=BNzRcdJKY7R7L7fklFycOL8qqjDi9pwwtXBfOYeJOqvJ1Jv5tlQ7OmxUEM9GSg5R+b+vc7VjnZjqmxbwPSF8YNAdYKfc9r65G8jX56EuY8DtqLtUwXZ8ae2OaLH6pScGEPTGsrM/x8AAa2PRHb4SIQ07TeqAJ8q/oy2XhS9CMJo=
Received: from BYAPR21CA0016.namprd21.prod.outlook.com (2603:10b6:a03:114::26)
 by SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:33:08 +0000
Received: from PH5PEPF0000002F.namprd04.prod.outlook.com
 (2603:10b6:a03:114:cafe::97) by BYAPR21CA0016.outlook.office365.com
 (2603:10b6:a03:114::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Thu, 5
 Nov 2026 16:33:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF0000002F.mail.protection.outlook.com (10.167.243.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 16:33:07 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 10:33:05 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>
CC: <iommu@lists.linux.dev>
Subject: [PATCH 2/5] iommu/amd: Clear amd_iommu_snp_en if snp_rmptable_init() fails
Date: Thu, 5 Nov 2026 16:32:16 +0000
Message-ID: <20261105163219.601561-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105163219.601561-1-vasant.hegde@amd.com>
References: <20261105163219.601561-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002F:EE_|SN7PR12MB7811:EE_
X-MS-Office365-Filtering-Correlation-Id: 3887ef55-3065-49db-fd59-08df3b5a78ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|6133799003|10067099003|11063799006|261026140227099003|261102123227099003|261028144727099003|56012099006|261022105027099003|261022075727099003|261009223027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	xqGXtcOt8FK1XwAF/hwqqugp2d4mt1JpeP6wDkDS3Sw9o7/ppUuBbP8FEAus1uSMrz/+om8y6yXsrajHK5kAg5+/J0uHpKyH/6XhDfSEEaeNup8c10JySsaFIYT5FDtqLrhyq2hGWvFaBX+qBLxVvQCZ41Wogzx+SpzKE2hr2frVNPlLI/K66tZjRQfIwP5AhNLyANy1v6Hjm0fjdP+sq6xPKUhZHe6njuttgY8pF3QHUGq3uQULcI/PIfHCQ7MZ6bjNw+QCS2lPd0dmPsoiRTROSzXKdBVQVeLaK8WlYA2q6tvI1ftqmPf+rUGmYUJa4SzAoqiWdR4Z1AWpebl0D2EgC8k8HHwejYCiE9Z6QOOzDyz9smqW+4OYLyN7SB1SvRpLptF/xMXJko/yuSB8+/2ZLIWfUrfzFAdkh5Aqe8PZpjlcSSi++nWLxwLL5/piuTgtV+crFh4rBpI0MvfgovVaOLaczZd0CF415YNY498dXIRj/nSmCsHIzOTa2/gSdtQRGOopa6K7RE4tiIcu5Y5dayKm78Hppe48zUkhXJZmJokn8btonujAaeuRjFzLMbYoc/P+OarzyBnFECT9HA1li0ECBi4JlcJsqhZr1VXe4pleh7OOG3Z62DtxDG0vuEjqM/AcTqq3Yzw3OH+X/eeal2zyDup9GVh7TE8ioGI0n2vPN79fI7daVyZb6A9wKzUVy4owPlfst32CDE+l1A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(261026140227099003)(261102123227099003)(261028144727099003)(56012099006)(261022105027099003)(261022075727099003)(261009223027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XOJArzLjrR6n+qutuc9g+rJ5wz42VuPiM0EnLd7mLCBzzx2V3BKrlNH4bFlkt+a2SUgoQGS3SUSQDkNuYzxTKC0TQnI0n2wI0Ua6xrmVCJi0R4LeTlQlCpF8q5emaOxrtVuHcWNnq0JnkLF8/DGtAIR48jEmh0NzL+5ZlCDVpC3uUBHTyiPaTDxhVB55L4XsjtLI/9eRFAH0mFqyUlD2Tlgg/LyZtAGD/t20qJFTRxI4/oyuhx8uy/E98xOBgOUU+CcP1bsjLYZClZ29Zf5TCRnXG3gQbbCc9c5mmyJ8oxJhoaeC7DzJ5udM7MJIJU7sPDv0c+fji5h7BwM+/BpHV4ExGm5vVDXeQxcjOwty0VOz8MHd9egZ8PM5XqjX3Jad69BsOe9/PXkhTulBGOkfB5q1DFrhS4ZqHinmsvakxvQtNrrr0QStgOdWerZkp673
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:33:07.2230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3887ef55-3065-49db-fd59-08df3b5a78ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH5PEPF0000002F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811

From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>

iommu_snp_enable() checks that the IOMMU can support SNP and sets
amd_iommu_snp_en, then calls snp_rmptable_init() to map the RMP table.
If that call fails, CC_ATTR_HOST_SEV_SNP is cleared but amd_iommu_snp_en
is left set. Later IOMMU initialization uses amd_iommu_snp_en to
configure the IOMMU for SNP, on the assumption that RMP setup succeeded.

Clear amd_iommu_snp_en along with CC_ATTR_HOST_SEV_SNP.

Fixes: 409f45387c93 ("x86/sev: Fix broken SNP support with KVM module built-in")
Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 0cb9aeb0597b..78c7079dec9d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3514,6 +3514,7 @@ static __init void iommu_snp_enable(void)
 	return;
 
 disable_snp:
+	amd_iommu_snp_en = false;
 	cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
 #endif
 }
-- 
2.31.1

