Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE8545D936
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 08:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789115711; cv=fail; b=KJzYmaLFF5sNGR9jm0ESKsr/uFq0AQh3Jd8bIpMfZezhblVBKkZLvZmRahlOg5DdwIdLYmhyoFFJwgzaWj/LTnV768tsBRoeXoJVW40EOk534eRF8PS449K3QbJ8HzVFoGg+rNOba6CmpiXtclNtrbl8V1uU23LIH12+Lsb/fbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789115711; c=relaxed/simple;
	bh=1O8BHT2DRakiy7Gt5ZaJ3R81A792dwzcmf8DQZpFJHM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P2Rc3tV9yvQeaG2L8YKhQNDt0hEvt1HbzPqawUBoUTjeROJszeUPfOUeEfToZ7SB+z425007zNdt3NotvBpyMn0lMfbkuNaolcyCaEZxRoEkGITd4jb8ksy9HJPUN0FZUUsMRbn6fKBPzwsd25i09UDNAiSRLKnKJBJ8Znd1fBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eGeNC4kX; arc=fail smtp.client-ip=52.101.61.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eGeNC4kX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbZ1lZOnfJobUAJUEAcU7M8OkWMDfgwyO9VwFX7zioCVK3/uNcJrf410Sw07StWswqS3pIJjdlByo/rlu17j2FAWEGAfnr7B9lJtvQ0DinHeXpa9gP6TuUNHrQ29jVCl9KfWWRqx0OxmQKI+jgluqV+CM+4/BIJ4qPMpCtKlN77iWABwNE4Y+O09AkwbifiaPbdgmQPn/txrW0oSOjsN22VRxssV+aiSKz+SU1SrLRHijIaQcn8av0EubKEebZ4h4N0NhLSIv+473la75DQtUKZ8kYwgJy9G0fP2bhHmHQMOgzNn0II5aBh06NKN/cIzGXkTIpRRRspgeJladmDWUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJ5mnDK6DIYkvLduNFdAORAj08sCVicDDXj14qnlcG0=;
 b=MfWJBy7+EYH7UIIZR44dxXxyWj9qaVjr1lgnONWiEXaZ+qqpPWWnlWWhcgSZnmHC1e+5vmRxWEaQ5XzxtinMnSHN4YNq3+YdPibCDAKmN5MYY6W0kyhEEHJIaRJyklVOh4jKw/4KPb7IkWQNVObEZOhtji66ncH+nYjRr8tlTWKerP5Z5GPlekpEcdLS8ZY3PIJiQq1zjryJ4ydYPVielyBcgJ9Zl55EiuMZgvG+XZbllSgjayDn2AnlgWc/cbT+lEu/PD69KsOUZNWEyXJ7lL+CXf58/FitlvzrBY3qie4O0F9OLGJPW8jNLNXQhsR0a6H/FuQ50o8A+IFsa7zr8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJ5mnDK6DIYkvLduNFdAORAj08sCVicDDXj14qnlcG0=;
 b=eGeNC4kX3Qqf3vSKjvYxtFVzslekzBYXfMVrKUtjBfm3lxj4DOCvzbRyowuaW7gDRDjQEXQuo2rScEexqtSykjufhwjCYWPdZv95uuiyBLoJmmhUDYPtFv78natKceOCbgRk4HSIa3NwpE2cZudujW4ga+Yz1lO1A6GK/zTjukQ=
Received: from BN9PR03CA0123.namprd03.prod.outlook.com (2603:10b6:408:fe::8)
 by CY5PR12MB6381.namprd12.prod.outlook.com (2603:10b6:930:3f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 08:35:01 +0000
Received: from BN3PEPF00022BD4.namprd03.prod.outlook.com
 (2603:10b6:408:fe:cafe::aa) by BN9PR03CA0123.outlook.office365.com
 (2603:10b6:408:fe::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 08:35:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD4.mail.protection.outlook.com (10.167.248.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 08:35:01 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 03:34:59 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 3/4] iommu/amd: Remove redundant checks from interrupt handler path
Date: Fri, 11 Sep 2026 08:33:52 +0000
Message-ID: <20260911083353.4812-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911083353.4812-1-vasant.hegde@amd.com>
References: <20260911083353.4812-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD4:EE_|CY5PR12MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: a589391d-475b-4eec-35a6-08df0fdf9259
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CW8X8D890XZAysRrYcmpP1zgMFTCYb3qiD4rQxHV8NB2QLln+NHFgf6ZEMltAe14JRaw9zlB/au1U6pd/nAtian61jjYJj1VaRCI49k9svprf+FENuEvH7eTiN1gHOnKCL7YpkbSvF3eabrXVcjGLR/y8ubMthQ7Q0tlYdrJqsEU7yn+Ov5/EIEciSFH5VSWwRtX4g5i/cCkNxTaOwT4I9CP1cQCGCY18mPMHgalDrACNv1wQ2hlu5Z9e8xWd3/HtXt9Q2KZFTOTJwx46S+GsmmxfkVe15I89Z9Dg7lQHe+l27+gqpzqRfP1/EqmatRQ6VWkFrL8zMJLmCGg9mjIaPgj5/L4XD+KyjmeQTuXAmKXbyD02svEnCGQMvtTYdnWMO3hwBhK9keGoDJOiCxn7IK5Y66g8SaPWb7XsS9uUh4aL8uJzRFSmnhll14PwzSq8wu7W1hX0ajKV3JDMpWwwlZyFZcNooBAes18hWU2NpH3bYYry3IaW/4nzdqBxCnfnZzNQGBV/c9TGkRRbKwYgFg48MRONJoBEVDRgL5SM39OEpnwipx2U1Pei8Nz2NpeJPU5qq4cBDOLX7roSySAFJQibC1GUNzZXO11HPbxdZ+yk9Vjzk9i6NZ9bnqteu0OMUQs/MAPBTOUGG/sjp252NJcfG3gQXiGt2Th/V1obvQFvBsOEpIU7c71wztvhRC050L5VZgW4cxOIk7jz+B7eA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XrXeDsyts/PAIUBZO9/55QiIcg8Qlir2ZntvEYrI81b7Bca8IbkSWxZ3w9YYPGCxVBnT1aE6B599YNuVqVOeZKIohpbUu85nHgfWStLCTssA87BbFhfCpaRpxaD3ed2ML0kHGi0DGrg3xag66uztJZ0Ptr6TusFMhMc68pL2g4LHWo4llfFH23BHrYPm0lX/VqAJF0QnLid2+kuGuh20iiXPmXvkTbp9q4T/NlhKGoLXDq2C+Z2JVdziIqN5g8hDcw6LXIDsBGDlqgwulhH98vdAIw+lfaYxRRawNgyFwVKu06joCKTkbBLnvj3gJcEuR04PQAdjuDMLCwVkKI/yaMGSlxaSvcWclVB6D4Ir7WbBVKhk94hPqqaWl9MYv+gDQVRPi4YtzmG1Ib2kHqerCC6pdQQTgeoKToEGqRaZ3PE3+FN0jc8kJKF1VcLi29vd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:35:01.6899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a589391d-475b-4eec-35a6-08df0fdf9259
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6381

PPR and GAlog interrupt is enabled only if buffer is allocated.
(See amd_iommu_enable_ppr_log() and iommu_ga_log_enable()).

The duplicate check in interrupt hanlder path is unnecessary
and can be removed.

No functional changes.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 3 ---
 drivers/iommu/amd/ppr.c   | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5bb7d8cb506e..ed38f2328618 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1076,9 +1076,6 @@ static void iommu_poll_ga_log(struct amd_iommu *iommu)
 {
 	u32 head, tail;
 
-	if (iommu->ga_log == NULL)
-		return;
-
 	head = readl(iommu->mmio_base + MMIO_GA_HEAD_OFFSET);
 	tail = readl(iommu->mmio_base + MMIO_GA_TAIL_OFFSET);
 
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 76296079bb8b..2039a9dd71ac 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -165,9 +165,6 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 {
 	u32 head, tail;
 
-	if (iommu->ppr_log == NULL)
-		return;
-
 	head = readl(iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 	tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
 
-- 
2.31.1

