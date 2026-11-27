Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795780664;
	b=y92ZvB3JovAoyGqWIj67yo81fmKzHwaRuMmObt/Ak/TPSjPkD2Z54mBCAGs6RJ+HjFth
	 4rQ2BP/Q1UeDp2i1y3+PGQ+xinhFZUHrZrRac3ckI4eo81zMLmU3yHA9aQLm/raP3LieF
	 xNAqOawIskUWrmOE5ocFkkTces2p4Bjb8pI+e9O/TtaSj7V8Pk8JA4zE+U6inEmgQqVyv
	 3zj1ajdEneBWrOG7PGsX0UDoiElz39/kCwTnx4r8mIPCgHLZugZwLgyNS3UkmMbxpcWoe
	 Mrl/D5VnwRa0bjEYKfDN+mcc2xlq700YmOgromoLoIP3rIV8FSGcHpU2oBAwS7XeL1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795780664;
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
	bh=9Cd4cEZsWwykS7P9VjAgV7YXNhAPFV73LKry7pOKaH8=;
	b=s1Vl9oxgI/QogNCF61TY2JQEIVfNVN5zWSW6BDaWz0OrkVdoJRvgnQIEvaUpD3PFY79t
	 lha5LukJcDphBof/mVYgR5UOTLE666oKcNIn41JOjQmB+VmJmrM2CIO/ysBII561L5odC
	 zjN7Fy/alawpriVwuT/Z9z+TYmnLAoyb/gIrvl3Qh/2+Y9lUTMIDr3R2SoTotFSsbScko
	 WSaggP/2vi0TCs6LDSItoMOly0HXJqm+h2ixz+JZ7f0s1uSf0dc5DNdaJVl4HwqNcygLA
	 ZuyKBSqzdOgbuDqxbtNfTLdytqdkr3/aUmlWCDLRMAhWX4NQvoiZdA6ShAyzVRv2KXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oOg+Z1LE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.35
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011035.outbound.protection.outlook.com [52.101.57.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA7E606A31E
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 11:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECA7E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oOg+Z1LE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYsE/MCpvA+W/1RujN8bEwRfjsRFIM43eP8mhULWJ2ziPXxYfnDimY2hZsB5WemecG+dU3B7KrdffYOhGs4+XRXpVrX9papJ7BAdVzTBVfiuoRqpcm8H/ZL0+7tco/ogQsXr6J+ya3Sc/SXhnk+Q/9RE+NYIxC+GbmG1FBIScrSBMmn9EoIoHR4x5tw9DAkjq9NboDti8wjlSxiPS+nnRjbJ9Jfub/b0mDIHFH7kqz/00Y5CBhQYrIwXhIrLNAxZ6/5OYcO2xRa87gQcr7CZ0UJISEw35D1iIYlIjjTf2I9dwVSRHqC22YDW0I0xQTkfknOx4juyeuWrrice7fk5dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Cd4cEZsWwykS7P9VjAgV7YXNhAPFV73LKry7pOKaH8=;
 b=ClVL8Ihi+AL9qoAckXZmXj3edeCqifPPQTcG772wNRRmitqc02B0YG3bMEnWiFLhKDXKwWLrKsPrMD0FVKBFmGXp2hCoS5Ti080ixFveVOoNSjqTLmQXU7Q2Cv2pC5CZFNwn2gI3yhuwMfE7i9mezxGsleqdo6IhYMkwA5/hlJyELP+iwsWz5c2vO9sPXnKLRTMzKaFfQVFRzcq8KgQUOa8l1wx5cZOyQF6jsakmpE13zKJJ+4Es/vNba8T0HrV9VEafGFg1T5FH7h1A107OqfxdWyS9qLBsCtwtoLJ9TvirnwbhXnvkoQsct9pR5EgLhsY5iMFJLA3WW+808jlYTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Cd4cEZsWwykS7P9VjAgV7YXNhAPFV73LKry7pOKaH8=;
 b=oOg+Z1LEFFT98Fr1v0LxJu2bGfU9IGPhMrlOf9XCtIwYsPukR5jPIZ1WbeT9nLQK9ZXFa+1Z42iv73ut/wNQvL0NOSojhBtQ0ZG7KQGQAsc5zkKf+so5wDfQZTDC5116RyQ1z7l6obLH4ETjs3a78XR7LC2FheVgBIdDpYw7kzs=
Received: from PH8PR21CA0019.namprd21.prod.outlook.com (2603:10b6:510:2ce::9)
 by BN7PPF0D2C72F0D.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Fri, 27 Nov
 2026 11:57:39 +0000
Received: from CY6PEPF0000004B.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::73) by PH8PR21CA0019.outlook.office365.com
 (2603:10b6:510:2ce::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.6 via Frontend Transport; Fri, 27
 Nov 2026 11:57:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF0000004B.mail.protection.outlook.com (10.167.247.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Fri, 27 Nov 2026 11:57:37 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 05:57:34 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH v2 07/12] iommu/amd: Complete an aborted PPR group only on its last page
Date: Fri, 27 Nov 2026 11:54:42 +0000
Message-ID: <20261127115447.209792-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261127115447.209792-1-vasant.hegde@amd.com>
References: <20261127115447.209792-1-vasant.hegde@amd.com>
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
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF0000004B:EE_|BN7PPF0D2C72F0D:EE_
X-MS-Office365-Filtering-Correlation-Id: e434d304-8981-4fba-f49b-08df4c7da1ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|261021121427099003|261026140227099003|261021123027099003|10067099003|261102123227099003|261022105027099003|261028144727099003|261009223027099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	sLxUXxzPu8Ii//tdO0KzQBfcHt7zYZxeZNKQa3M56IvreFNifTaGw8cCHRWbyw5YQCZ/MBA4v0VKobiKya+2a8lmuVw27LMGANsTEMI1oy5lPgpmuyeejJD9EGeoxCwPEBBvoi2mLb913WshV7+r47JTlEzEZoJKXSvQrk1Wrir5Y+xvmxtriv7hPTVcK1EcokPzwACjXyl+hGpss3gGdwKVXjRT5Qkq6veM2j8f0hytDBFWuKMlAwDhcdPi5kiopSLFRiKHSVwhOtR/z6s5vIH2o0z5q0iI59QcHeN/WRuV6snF/p0CQdg7I6aTTiOrM7G5RJaUkPIgu/d6GlFDna/M/lF0a12P/UTrWSyQMB81ItogYV2OKvyilfnhCitO0U5yYbLSgnULZBGBxUb0wtn53lFmkZqutfMOgSKFzCeDSAMq9GJTxYCHBswnQGcYgPR5gwaSkTQfswxnB2U9vVoVnS1nL4uCrfWm8sQQT8yA5qx68WYSv/h8MQ/GDtDoYz8Lj+mJ3oF0jRWikGc7EfAOYX7yoK8qIzHwdWINEdXLAozMhf5z6RAHPsOJwWs/vKufg6QdSVFMKkNYH9Ajc/MgmYo66F6+N9Kud68k4fYk0XqE9OEUa/ShzVXoQdtvh5sXQWgyrAh5P2ZMvfvPFHSJRy9/6xqmxhJ/1dN56u07Nv5jOf8kzTNJPN+7zOlm81A1ZdFXXm4fXYh1gLMcwg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(261021121427099003)(261026140227099003)(261021123027099003)(10067099003)(261102123227099003)(261022105027099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IO1FZHuS2tEjAZB+HIUFFH/1+Ejr/VpjmXuoYELghtI8yhfw5nglXWGkOHx5RLJZSlESuLjmyaZbeVuTAaObd/ViY6Q61CAVIVkJllKf8cDza5WkhCf+tMFNP6mb/zsTrK0WEyvX+7mCZOlayFq2BmW2gbycCLDla4QgaLiivxDk4pE6kwwaRQHxRVXsAMBezBiXgPPoOT2/EV2Mce5ZuF3lmA4TNzBipi3QA8ntrAc1c6AbQwn0clU4zNK3uyy26K2XlzEUjx2l5WBvf4KD6199TkMbZgB2+AREZc3bbh/MOuKkPCroePd3tB2LN0fFZgeMNG1NvUm3Ij0vflVbIiC9ce2aCmmFlz8HCDLB0QNjKBhr8rq3dNHF8KFOs5Zs28VnAQTlBDmxHwlMHdiHxEEEh4aiLvCyl2fWl7LgzGp30no2GjsR8xeJe+xSg5b1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 11:57:37.7020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e434d304-8981-4fba-f49b-08df4c7da1ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY6PEPF0000004B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF0D2C72F0D

iommu_call_iopf_notifier() sends COMPLETE_PPR for every rejected request.
A group of several pages then gets several responses for one group index.
A response for an earlier page can complete a newer group that reused the
index.

Respond only when the request is the last page of its group. A request
that is not the last page needs no acknowledgement.

Fixes: 978d626b8f1a ("iommu/amd: Add IO page fault notifier handler")
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/ppr.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 7d660a81df3a..20ad2e46b240 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -174,10 +174,17 @@ static void iommu_call_iopf_notifier(struct amd_iommu *iommu, u64 *raw)
 	return;
 
 out:
-	/* Nobody cared, abort */
-	amd_iommu_complete_ppr(iommu, devid, PPR_PASID(raw[0]),
-			       IOMMU_PAGE_RESP_FAILURE, PPR_TAG(raw[0]),
-			       PPR_FLAGS(raw[0]) & PPR_FLAG_GN);
+	/*
+	 * A page-request group is completed once. Responding to a page
+	 * that is not the last one sends another completion for the same
+	 * group index, which can complete a newer group that reused it.
+	 */
+	if (PPR_TAG_LAST_PAGE(raw[0])) {
+		amd_iommu_complete_ppr(iommu, devid, PPR_PASID(raw[0]),
+				       IOMMU_PAGE_RESP_FAILURE,
+				       PPR_TAG(raw[0]),
+				       PPR_FLAGS(raw[0]) & PPR_FLAG_GN);
+	}
 	pci_dev_put(pdev);
 }
 
-- 
2.31.1

