Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011052.outbound.protection.outlook.com [40.107.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64221380FFD
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 05:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785130813; cv=fail; b=aUarXnYzsRtAMdnmpNq7IKBXjoukoqafkncj62nM0ucQ2oT6tVv6zfW8nMHwpa+IhTDXuFnk0aEgej6lHZZyjbZNt8XgGu0r2MYBUZouFYK5PK8Escpe90btCPOulsXSRme+jd5fWLcWIK2hurGNmLir7F/ja5R/ouRWKDNQuJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785130813; c=relaxed/simple;
	bh=0AC3uwvWRHo+OGbxLJwcKt6ljsWM5/BREJjzMR466fI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HsnRV2ArPztKPGqoXC0Lo9XwG8KAjc4E+EYkewRvtUXz+88Vu1TOyL6NzY/eHbaearvAfGYUHpNs9bYEKyefX0a4/oFazypq7IH88BvGTBLfNbm75HorvQ0QShv2XL14vIqiQxlTZvFD4XYZJGbY9Ow+0st/HUkWEa0OEhcETo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SYcuPgZH; arc=fail smtp.client-ip=40.107.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SYcuPgZH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBDrEuRgF4ZIKT6R1rUZrUoiANMzefGsUnXHanG6QfP+/hL53l6nbfYf9ULRirxYcpXSFEgr5M7vgEk6IEKBHVuMXK+sjxvdtG5DVtQ6SxvayUlpGfAD+210XMpf2teo6pJlm+ULCtUpRo30l71cK89q+syGDVhSSME1XO/uiQpejFJBGKmrITi5avUSe1eoA3orlpZ5/mte2pqnfUGhHV5zotdc2mTKan9zePG1rMbtiNiYcFR171CsiXnMZb5RgLbbQDnP1p7NtdJO5vI5L8XQL7AWrsG06KzjCCFThrk1zSBYLotW3yxRih9caXcEnBDWCmkflUtSqtyVdXOBAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASU49ujemEKlbQ+j6pbuWBKl9ml7h6nFvBEEJfDB+oI=;
 b=aSn3uUJSkuOBE67qdEo+JLI1S+AhqAI+o1U08fBVBrpRJOD08C5VMRR6g5xD6fkLZyGyWzLGara7ZbcNPD3ceRrKqV+LE07ffB4NRzOR17FuykPlrmIfIwBMTc1XgiQPFIbiykz0LtCS9LET2VVYHNdOo+O91/QlX545fWxswFYroxNA9voB8UKPialhySok/A8etBd9eiuH62z13Arb7+EHOH8x7FqCQazlVpEfNjeq1IzDcIeDivGTxKMOdCZSyQaaEQm4O94TeQhaKnQXwvMBceUQHvqL2fCGcCmcmzyfRJWdS10a5h1/iO2BnjEdqV4uIr1NmQD3Me/O4/3XGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASU49ujemEKlbQ+j6pbuWBKl9ml7h6nFvBEEJfDB+oI=;
 b=SYcuPgZHAhEq346HTdKi9N9WHGU4Pcr7bNvbVLz0Juu31L/k2o9t/L7qUN+2Heda/gCgi9FI9sDVxMSGq6sXXzaYzu1CIaNNG8WXJ3EqoEzgr1G0K+9hcsm6jvxJPXj99/HFg2llPYGLsMcZ3P6rnhSBcNG7bKWi/U2wjIry65k=
Received: from CH0PR03CA0070.namprd03.prod.outlook.com (2603:10b6:610:cc::15)
 by SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:40:06 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::e) by CH0PR03CA0070.outlook.office365.com
 (2603:10b6:610:cc::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 05:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 05:40:05 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 00:40:03 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Wei
 Huang" <wei.huang2@amd.com>
Subject: [PATCH 2/5] iommu/amd: Introduce PPR_TAG_LAST_PAGE() macro
Date: Mon, 27 Jul 2026 05:39:04 +0000
Message-ID: <20260727053907.7622-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727053907.7622-1-vasant.hegde@amd.com>
References: <20260727053907.7622-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: f748d351-8142-4010-cc24-08deeba1835f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|56012099006|22082099003|10067099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	HydVzbGqqsUr52IjVbDHsuqqJhnvu8vMZUagcJYeXPi2kYcIiYCye7kSWjbRfkAwxZHszrE1n5TSmHt1NlOXt9qzc5hDsa1tWuoJQact2gX0U0oKqUWy/oibHShPQBWgd427Gn7mOphRSl12wksLRpajbWCWsMYHmvag1S47C684eGo2XbUBR3qxuHed1be9YPk1SGi7zxsLMzDULs83kO8Uc6B2yX0Ae5TLvwkfz42gT0yagPHih1WeqQ6p3u/Cs1afGW1IySFMtYOLGg6VZNbwdo7T3TJ8o+NuztniqKFDCwCWcPEPb7/+nSXqXYLxdqvu6RXysO1s7JBnujQWy8tWj6zZsMUL8biGaEz9kH2sNFG08k6GQE+uxvqCh3VtftbQQOP1un8wOh8uHqhw3/JtXp2n6VtiAJItNqd6pJxSghuDiHHwaJh9AYHCUxCLYXEk8+AZpk/cGdomEldrhVazU7C1UwmZ5pB+nFV+oZS14tkVrZ9cMV1Mh2HHUp0Dy0+/bTpmDkFTtsDVB0CqWSSM5FqXoIXOiyUVgL0T6ukif0Npp2QKN+Vaa9Lr+LOy6BnGkOLG8DaA1avbBif9Nx5Zr0ryxhYk+FOOVsxYRDUcnut22eZ5r1Lmg1Lq8XabSQRGzpLnA7MHS22wHjWuYhdDBHylQQmzXDzjxRlO65SXyTgYb8qFyOOsvetFvXR2X15tXuNhr9+sOCmG4Icpcw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(56012099006)(22082099003)(10067099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	reWtasnqVp4mr1T7YVbycc8gSkfj155OBT2XqLX1lgHPUGMVzjyFclbmNwia6MjZzXToD9NsM4BDHpUXJTa49sZsX9X0xVzo18Ki5sBxTV7BML5JXqKGOHfnSxgP87E+2mWEC910H8pM3kvN0R0DIHkQkSwraaWe0sETQtPLjFpASz7cd+EWAE5SK1zcCTXtruqBQfmBvg/Y+cWxmYrKuNZaCCs7wjnH8pdBZZFzB1nW6fsyuMfk5B+vprIgKmCDDZsEpL43wT3sQQg+/s4SGn0GLSoMwKn69Bd7xEF7pzvl8Wk9TTdqfbHMsIxPAzCusD3+FkuywnxZidP1Rqc97nlnET22e9oKEmw6eOSEQAbfXXKJsITDBNfyDNK7kMzatifpoi7DEH20FyHEQFtANO6HBLi2kbYunLPPLQJMiKPc4xph58rl1PVRiiH94Z2M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 05:40:05.9228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f748d351-8142-4010-cc24-08deeba1835f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766

The PPR tag field (PPRtag) encodes two distinct fields: the 9-bit tag
value (bits 8-0) and the last-page indicator L bit (bit 9).

Fix PPR_TAG() to mask only the 9-bit tag field and introduce
PPR_TAG_LAST_PAGE to explicitly extract the L bit. This way it becomes
easy to read.

Cc: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 3 ++-
 drivers/iommu/amd/ppr.c             | 7 +++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 3c292fdfa95a..a7aa9411b2e9 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -280,7 +280,8 @@
 #define PPR_REQ_TYPE(x)		(((x) >> 60) & 0xfULL)
 #define PPR_FLAGS(x)		(((x) >> 48) & 0xfffULL)
 #define PPR_DEVID(x)		((x) & 0xffffULL)
-#define PPR_TAG(x)		(((x) >> 32) & 0x3ffULL)
+#define PPR_TAG(x)		(((x) >> 32) & 0x1ffULL)
+#define PPR_TAG_LAST_PAGE(x)	(((x) >> 32) & 0x200ULL)
 #define PPR_PASID1(x)		(((x) >> 16) & 0xffffULL)
 #define PPR_PASID2(x)		(((x) >> 42) & 0xfULL)
 #define PPR_PASID(x)		((PPR_PASID2(x) << 16) | PPR_PASID1(x))
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index ad75d1f03451..4fc50e24f591 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -130,7 +130,7 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 	event.fault.prm.perm = ppr_flag_to_fault_perm(PPR_FLAGS(raw[0]));
 	event.fault.prm.addr = (u64)(raw[1] & PAGE_MASK);
 	event.fault.prm.pasid = PPR_PASID(raw[0]);
-	event.fault.prm.grpid = PPR_TAG(raw[0]) & 0x1FF;
+	event.fault.prm.grpid = PPR_TAG(raw[0]);
 
 	/*
 	 * PASID zero is used for requests from the I/O device without
@@ -146,7 +146,7 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 
 	event.fault.prm.flags |= IOMMU_FAULT_PAGE_RESPONSE_NEEDS_PASID;
 	event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
-	if (PPR_TAG(raw[0]) & 0x200)
+	if (PPR_TAG_LAST_PAGE(raw[0]))
 		event.fault.prm.flags |= IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
 
 	/* Submit event */
@@ -157,8 +157,7 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 out:
 	/* Nobody cared, abort */
 	amd_iommu_complete_ppr(&pdev->dev, PPR_PASID(raw[0]),
-			       IOMMU_PAGE_RESP_FAILURE,
-			       PPR_TAG(raw[0]) & 0x1FF);
+			       IOMMU_PAGE_RESP_FAILURE, PPR_TAG(raw[0]));
 }
 
 void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
-- 
2.31.1

