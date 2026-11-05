Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793854469;
	b=jB9lpmU0oFgYUUqti/cv/FiLraMqnQWPGH/i9St7e1yIfUO8UJBJkP1Pm6hR30oYS3df
	 yCYE2Mn77wdqfje8oLjMwBShIYq/g3hrGbzDudp2BzkqJ05SsW/o5nM1UV/pAhKPZrSf9
	 n1YzftlrIuBoxAhwlH7YY7Az8ucvxRHWyvHwIOMsRZcZQ38DGp6Oi9YW3QDtobmTpjcI5
	 QYNyjkHwToaAogQgTjRFHClegRCpoxyPvqEy0rCvorl965b5zFeYksWNPvwNw/aXagNA/
	 SnBeP8woYoY27YObpbfBXSaGrMezrScFa45uEyoGBCxAbrvvSfl8Iawck+60ZcnTAGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854469;
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
	bh=2mLj0fjdax3kg02OwkBFW1EZpicGcdxu7ikAiG/4sx8=;
	b=URsd6AJ2ofNae1JYnW9mO+Y19Sa9jpYdL+jbtBkYy2n5znf/0tmQVDZMQjZPmKzC7x1G
	 Xpjxfjh2dFoDWkYaQhnoozIiF6cJtEOVm4M3P14XhOwfBDd3y3ZvrFY10UObWWL4P19HY
	 +GCaEFkt1iZfyzVYWNqkwq+SYsV+w9px9ci2Bqlepq61Kqt9T/0HM65Ng8JsbC2PaO5U8
	 dl6M4X9gNbnLAJswQsAyQl1OtLrCPqeIVbV5zUEAIXW61Ll9IDlsBp1pIcTiea8LKSJbw
	 D4ftt0s4UmNq0uV3PitXKXrzCn5pabY0iXci2tq9+sC0iagCg/GdDUHLV/Ib/aiLlOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="l6/dqSLU";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.52
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011052.outbound.protection.outlook.com [52.101.57.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101F3606A31B
	for <iommu@lists.linux.dev>; Thu,  5 Nov 2026 04:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 101F3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=l6/dqSLU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxeLJ4ftWW2JtGEKnj6Ua68aQ9EwX6I3W8eD5BLvVlHsadt7IOH1UODXn8xQmxejSGUq3VjXUsc7LScCTH4UuJF2u+Vo8CtqioUbpD45ZTXzNf0eY/cCUuEVHMasolD1cbl913XQdaQYWlDh7br+v5nX9Gw7/GCB0tuifqcLyCXMw8O7Q4A6y0rojoKuClhdEOIJzgWD6eTerEoz4xVgc07x7j5WqJv+tNgzIk8F+HIHLJQR9x4Is5qwRo5Zufr+D+UyA1QvhYpa7yBfPNly0fBZetYUqEthiv2+CGsBgQ9fuFPHtjiqnCtEq2PEBHtiitlutTIt1qVEJg3j9cf2MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mLj0fjdax3kg02OwkBFW1EZpicGcdxu7ikAiG/4sx8=;
 b=K1lw4JNQyKWaZwAznZDf5JhbxzmNlhrXD8N/gA/XDWByCzkS42/rY12XRko3KlTUqV7BJZ/g7Dvg7NOhBrEpTsr0977WBOipMxfrYnMfxYuj26pTNg/eVpTnM+3TH5PUIEZr1OhUlI6JqN3CkIzd2dKkey8KlVFuzUakcBSrUAUlYQQpBfq5nrTs9R+/LFkZeTvf3UKw+7/cdBmilrUz6HrMqXvpUnWZtjdkVtNw/g0vi2qvMPI5aNqnnbkaMjsgbQRsomMUADu5XbchNAkHHjQp67rf8af9E6OGFcPABWjeYZmT9oKSM8oEQKEcSBiusprbTnlwI1OD8N+i4vO4HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mLj0fjdax3kg02OwkBFW1EZpicGcdxu7ikAiG/4sx8=;
 b=l6/dqSLUzKKixNqbciH1kHt8ag+nq+fyzd8gw869CkeigWs+d6omh7Q3Hca4A7xjGrebAkKfQITt8lYbKpcikX8csDsxHZLeR1UgPFfbG8oH8igyynwdzgXsZn/FODYynO3UB9OAU7mrb/nB3HgQwPTp/kA78/ffEjybWqW8pto=
Received: from BN9PR03CA0208.namprd03.prod.outlook.com (2603:10b6:408:f9::33)
 by CH4PR12MB626935.namprd12.prod.outlook.com (2603:10b6:610:507::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:49:35 +0000
Received: from BN6PEPF00000071.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::50) by BN9PR03CA0208.outlook.office365.com
 (2603:10b6:408:f9::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 04:49:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN6PEPF00000071.mail.protection.outlook.com (10.167.248.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:49:35 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:49:32 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Santosh Shukla
	<santosh.shukla@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 05/12] iommu/amd: Restore an SVA PASID after PCI reset
Date: Thu, 5 Nov 2026 04:47:54 +0000
Message-ID: <20261105044801.399466-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105044801.399466-1-vasant.hegde@amd.com>
References: <20261105044801.399466-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN6PEPF00000071:EE_|CH4PR12MB626935:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0a9bc9-3a7c-4801-4da2-08df3af830e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|261026140227099003|56012099006|11063799006|261021123027099003|261009223027099003|261026121527099003|261102123227099003|261021121427099003|261028144727099003|261022105027099003|261022075727099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vMCaFBh5X3lAh5J3MnOB64Q+IYITZoXNxjorva6uP6Lso0iD/Y0rpEEvCrPeoGZlSgRzYLxSVvO3G4n9oJkRP4TWPr7FOfRAr01a0VlTvXx0ZZQJEbC3QvFmoPHSkEefCu+GOd8jJUpcTL+tV34pxL4rCFV8iJyKH9YlFlhkcOsXuzdjsNTO6nKvED4leenKG+dqRkf9WaKowVRQqj2H5ocnOSPBT3OPB8TZdaAG9av+x/ZgG54nXP5uOe7R2RIl4now1a9FUlu9nJdsPHbcMg+d5FeZ9i1O8qMBupoG2kZCCpWtsFgY+Ma+pXTkwW7w7RYoRZIvBtPm/QN7XzMg0skTwk2iHsSXGhO0mF+WNF0h/I1cJs2xERG3pKTiDEtTr/uTxwdOAS5y3GU5wBws3oo10DfImD4/PnNWAsCtse+1sT+cOxFHka1yrVHdWgSuO31hj799a4oHDKvAC9xbeubxLxOtV8wusMqAFLYi8FtVyOCepxh1C32G5rndWzsiefXKg8tDu0Tp80XgO/phxHwKWFvOoeLKlr9hQ7WG1nnfzVw+RvqxXBlk98RhNue9q+UOzXFJv2zkSdr68GRVD+tQ+PsNCWOKc4dqIqjc8MJgER4Gpg36wFzRh885VC5jpd8OIAhhKu9uI3Ss6tsOOvUM0TAL/xanbCJqMoPllgwOYMH7pm74owBF3kdR/2RLAWxsvM8fSVdi6i0VIGawKw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(261026140227099003)(56012099006)(11063799006)(261021123027099003)(261009223027099003)(261026121527099003)(261102123227099003)(261021121427099003)(261028144727099003)(261022105027099003)(261022075727099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	283gVoAbdGu15XY6aSK8aLzoP3uEoWD3PxFdFL8GwBe+kyu8cSuTiIVdUvVYw0s7e8y4ULHM+Ma0admLsrQCCMwNsiV0Rg3bWAzIPfxMJP2KcUTkHPBT2kr64kdoWYzknKyd6c3p2TxpQT3aQr0ML7/C7VQD7HiC+teYmrTP+jnn0brWHctES3sIGIMm7LDIC8Yd0OYEfLjsFqJU0jMd+LEBpDA1hD5rSal/bKfWIby3XKNhrh0YO1MF5RG5SQtk3Lv0GlHHlLkxNhWHeNWIF6tVR1DPZ6D4zZPa1zAyKdBk/o/e+rTSWnUSSgKQ+WtfFV34M6nq/QRZUHDer0AOh8Yuw11JKrxKch1Q/Nwqh8WewaB7M3Dbv02ANQxAlpEcEzKhjI3GQBzC4tizZhiw7F+NkDawb1VoVxcCAj8guPz7Zd3UIQ4tmX0FhPOeONXx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:49:35.6265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0a9bc9-3a7c-4801-4da2-08df3af830e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000071.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB626935

From: Santosh Shukla <santosh.shukla@amd.com>

pci_dev_reset_iommu_done() re-attaches every PASID with old set to the
group's blocking domain. iommu_sva_set_dev_pasid() rejects any old
domain, so the core warns and the PASID stays unprogrammed until the
device is unbound.

prepare() has already cleared the GCR3 entry and dropped the SVA
tracking record. A blocking old domain is therefore a fresh attach.
Replacing one attached domain with another still returns -EOPNOTSUPP.

Fixes: c279e83953d9 ("iommu: Introduce pci_dev_reset_iommu_prepare/done()")
Assisted-by: Cursor
Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
[Updated description - Vasant]
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/pasid.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
index 40be5902087c..87fd2688574c 100644
--- a/drivers/iommu/amd/pasid.c
+++ b/drivers/iommu/amd/pasid.c
@@ -109,7 +109,12 @@ static int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
 	unsigned long flags;
 	int ret = -EINVAL;
 
-	if (old)
+	/*
+	 * pci_dev_reset_iommu_done() passes the blocking domain. prepare()
+	 * has already cleared this PASID, so program it again. Replacing
+	 * one attached domain with another is not supported.
+	 */
+	if (old && old->type != IOMMU_DOMAIN_BLOCKED)
 		return -EOPNOTSUPP;
 
 	/* PASID zero is used for requests from the I/O device without PASID */
-- 
2.31.1

