Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.5
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794943343;
	b=H3V5uE4RQJ+ZfUP3p57Toj+HUL4lvo5AYW/LP+5tL3dpBXyRWjIerkN+2y3Vb2qZZUiJ
	 lnHAuEvDpkV79AyUGWNPptZ+8fl8EFtFXtUMj8s26EvYWW1DGYYqXVHFtual5SpEZhvJe
	 qwKQgrjHrP8wTO5sfhTwd8SoMr+Mv2GU/72TLcNVWA3xY+DPWdgNtjPmT9zpUeMDGptBC
	 h1lNZ/6JwDmDZOG0nt2DGXznLveZAoPiU3cJnilk6BXwvI4M9wsIBFud6z1FHWvCSEUIC
	 Qk+XzeAAY2n5XGI89PPFmVvCZQx6z2d2f5y/onmFwg8uFM7HcxW3Y1WTVrOLkMJ0kkg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943343;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-NV-OnPremToCloud:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Y3G1Semc7elZqukfg+hbH+4DS5ypKEDxsdCXcqYo6iA=;
	b=CgDVLk4d4C//2KsHmeUhwtVZnA67uyiHq1zuBNO/5WHuHxd9z6UXhyqvngiNbrgfbcRJ
	 sW+gZnwA3XnC6zoAL8UBduPf7bhwjzeLdnFLJNeOcrO4NOa1jabElGY7lGthOZm4Acddu
	 xjgmto7vI5Vy6v/WtfZ2V3wr8/yfDmPINV2EBLwW62Xjme3mtT4A1RqAKaIgWkmpnMX8w
	 rGfcwV1wZYs0FpWjC6dEUUO+QlM6WdObLz6/ReJf3J20u/12QX0IM2bR2DFjgVPnb434N
	 mMnzzTUndqKsbxGtcx+wdUkdP4EN7b8JzN5BSkhPNX70z8K79sItq0ckQlqppP11z9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ma78HAAc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.5
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0E660A263A
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 19:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A0E660A263A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Ma78HAAc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmNVQmj9XeLW272wQISDeAgxW31n+eShf1H32XAcl3o9Lta2IXIQCd8oUUKT/zON12yhYeHqpe0lu5VvBAJE/7v8rzaJi/nnueP+2dj8pGpDIxi9MWfkS9ynfqwgZl0SkVfYMhDBU0UdhKMpawIzzZiWLtJBCcX+dDA44yth8jWFPXGl0I563m1YoWte2OtOucZsKcGfJKUzCs6AEm8tYDaRtuBEfYPhPHL6m7kCv0J9e3KfTczZa+hHJLUKzbPuVUViwaBDfq3kYqpsPETRUL2gV8+DLpc1JUrCwnyBpmCE9DBhVBdeozWhJZziHuhliYpgs09lBvQ/NqFDKtZMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y3G1Semc7elZqukfg+hbH+4DS5ypKEDxsdCXcqYo6iA=;
 b=oTcW1uz145S5fuCIz/SW3k0kwzvERjVxLHarnMheE052wHdQasqNJcwfxRaXxmNBDn0MaQ2m3ltvHHfZ/Hv/hfaP8G/PdokYkIpx9zRY/PymEjLkifdJaj/wxZGGnW+hf3GRhzUUeF4AQ78N1x36pI9I8n49QsWE1muF6aypnAfPQOyFNQR0tFgiHq6BnRCX9d0d5Zxz+WoxdGCRSiYk9Kh4QnXFXFH2qjzjj1xu+hRSjhy5+Ru3L/Uq7fd4lzT6Fok35AOvN7jTma8fBw75Yiv+xw1D1VxkDquIWGtbb7qONSPICLoWnemQSv989wq7RgkWkAu5l+sRYMOe/x3dUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3G1Semc7elZqukfg+hbH+4DS5ypKEDxsdCXcqYo6iA=;
 b=Ma78HAAc/KKlvIrNcEZibmJG0t2FGasAFBMKygRR3PbTPV8/U8/bUmEvk9tiXK+D5yDxBzNuXV44HR8V06nhY3frBlMDEDxbd003TYqkbRjITrLSxCPG+F7EW+AwFJ6R1a4sdANiDAfa1pd1PtFhYsMQveNSmRKWb28u5h8q9f2xq7TN1x9kiWqAca/LzyhPvWtuV9v/lQdBAjzDFROhR7wMsAgWbj5v9QFJrHUVTfj+//CvTj314iZCggZE4A8JHYTo4r0PruETbWzfwXZGF9hRaggpQI0krNUBtde2/w9jlxufYlgfHtXgrOSDjXX+A4ghXT2L9dGa0bqcMHHmAg==
Received: from MN0P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::28)
 by PH0PR12MB7093.namprd12.prod.outlook.com (2603:10b6:510:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:22:12 +0000
Received: from BN7PEPF00000094.namprd03.prod.outlook.com
 (2603:10b6:208:52e:cafe::73) by MN0P220CA0013.outlook.office365.com
 (2603:10b6:208:52e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 19:22:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN7PEPF00000094.mail.protection.outlook.com (10.167.245.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:22:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:21:45 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 17 Nov 2026 11:21:45 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 11:21:44 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <praan@google.com>,
	<kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
	<xueshuai@linux.alibaba.com>, <john.garry@arm.com>
Subject: [PATCH v13 10/12] iommu/arm-smmu-v3: Retain CR0_SMMUEN during kdump device reset
Date: Tue, 17 Nov 2026 11:21:27 -0800
Message-ID: <2e34a7975c8700643b1f83ea34aac7283cd4b4ab.1794942324.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794942324.git.nicolinc@nvidia.com>
References: <cover.1794942324.git.nicolinc@nvidia.com>
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
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000094:EE_|PH0PR12MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 3872317f-f084-4f3f-afa7-08df44e014e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|23010399003|6133799003|261009223027099003|18002099003|22082099003|261026140227099003|261026121527099003|261022075727099003|261021135927099003|261021123027099003|261021121427099003|261028144727099003|261022105027099003|261102123227099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	rrUfDs08rYiZ1fmAhh7vcNcsp5n/zaou4ZqcimUXCvvCz1wzSUDljA8lAh4tXLp8DP5Jc69IP4sfwgIO52e4mUkw+rVTYdJo7wC2Hg7IBaooNdXA8dWqRKIqATZ0xeHQIeQfBvGxp/6fH25f7NVj/cNbH75rFnXlCV/nFUuh9cn3DDOV9okBRGhbwe9nBYNE67f4efb/kgQ+QY9VCY4Fo3bypMi2yYk9kDBo19DJSV325H0Tt9Z9bD1REOMBZ4UusFNOSfxURd99D7UqxXrLJ3jgDF3mTtF+2PTVuqC8Hz65IPZxukgOR3c0VovnFhbqPVqLpS9ffoyEA71UXX8cqZgfc4jDXZJK2ls2n1sFivXUWa5EqTkV5gEH6mckP4/HLzoLMKLQf4IjYIV4cY8w/tcJ0rhqKSbWfg9BQdRyD/6vtYoR7PDyW/shDN9OyaTz0aelA8lLwIVr5+8IPCRtGd/DHGwhcxR/vScoFgmS03pGeFTyHmTdjZpKq55Z490uaQ81Iom0z7gEU0mKgVkjC4TGClnFHszFfbqynDWGdqqoiBrjZzguf7G7+jxRTGrKXkdgbN/NR/tdn8EADAAFJZgQ1gQJ8xl2IcgD2kjqRM5j7EwzqifsYpXCAjcPqYLRK31EY4iVbbCwOJproLt+Z19jz3Vxk/ZuZVgzLtDNUzoeehnryBTUkFgPQ3sjJRrJpXOXKr3IV+A90tzqZpTX1w==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(23010399003)(6133799003)(261009223027099003)(18002099003)(22082099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021135927099003)(261021123027099003)(261021121427099003)(261028144727099003)(261022105027099003)(261102123227099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rP0KKgZy8jDbt7hUNKo6paMdOHXL87cgOILY8o37mMyBms4weQRNm1j551ciTkSJRAbe+HaAKk5sMjOe5S6LfHM0Y9cIlmG6lJtmSZB38A/zk79bW1g0b6F4Vg/PFE9HuyjmWvBnf/BkTvZ+P05ZJD0gjJXWYZG+WUXYXAS0XkrBrZ/9X9R13r+UT3fCVUwiY5GStr1SSoL4YCvW5kIi0LFArmdiSts3OF/FwFCscM4D4ZZIiLpGRyoJtkRBTqzwy5IyaC5NhKEvYQD9XHi/brj0RDBOaNGVKsgOHQ2+SeI9qyDxelnOuv1HsJ3k1mRI8OH9NQ5yQ/wjcKk1EP/dKAKo+xkIQ/xXccCQAqP5t3NvsOfOOYG6tkt3ByYlhBC6dj77BESluqUhnvu8QkQQb5SZDtLZSLT+6TRZRJZ2iwg71Kr1DqI0jl/kRfmKVpr9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:22:12.2964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3872317f-f084-4f3f-afa7-08df44e014e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF00000094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7093

When ARM_SMMU_OPT_KDUMP_ADOPT is detected, do not disable SMMUEN and skip
the CR1/CR2/STRTAB_BASE update sequence in arm_smmu_device_reset(). Those
register writes are all CONSTRAINED UNPREDICTABLE while CR0_SMMUEN==1, so
leaving them intact lets in-flight DMAs continue to be translated by the
adopted stream table.

Initialize 'enables' to 0, so it can carry the retained CR0 fields in the
kdump case, clearing only the queue enable bits. Then, preserve them when
enabling the command queue.

The retained CR0 keeps the crashed kernel's ATSCHK too, which selects the
fast (0) or the safe (1) mode for the ATS translated traffic. Switching to
the safe mode would start checking the in-flight traffic against STE.EATS
fields that the crashed kernel never set up for a check, aborting the very
DMAs being carried.

Clear latched gerror bits if necessary.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Tested-by: Breno Leitao <leitao@kernel.org>
Tested-by: Cristian Prundeanu <cpru@amazon.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: John Garry <john.garry@arm.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 57 +++++++++++++++++++--
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a8832a2c40037..4609f64cdb92a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5150,10 +5150,39 @@ static void arm_smmu_write_strtab(struct arm_smmu_device *smmu)
 static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 {
 	int ret;
-	u32 reg, enables;
+	u32 reg, enables = 0;
 
-	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
+
+	/*
+	 * In a kdump case (set when CR0_SMMUEN=1 and !GERROR_SFM_ERR), retain
+	 * all the live CR0 fields, e.g. CR0_SMMUEN to avoid aborting in-flight
+	 * DMA and CR0_ATSCHK to carry on the ATS-check policy, while clearing
+	 * only the queue enable bits for this kernel to take over the queues.
+	 *
+	 * According to spec, updating STRTAB_BASE/CR1/CR2 when CR0_SMMUEN=1 is
+	 * CONSTRAINED UNPREDICTABLE. So, skip those register updates and rely
+	 * on the adopted stream table from the crashed kernel.
+	 */
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) {
+		dev_info(smmu->dev,
+			 "kdump: retaining SMMUEN for in-flight DMA\n");
+		enables = reg & ~(CR0_CMDQEN | CR0_EVTQEN | CR0_PRIQEN);
+		/*
+		 * Disable queues since arm_smmu_device_disable() is skipped.
+		 * CR0 fields are independent per spec, so the queue enable bits
+		 * can be cleared while retaining SMMUEN=1.
+		 */
+		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
+					      ARM_SMMU_CR0ACK);
+		if (ret) {
+			dev_err(smmu->dev, "kdump: failed to disable queues\n");
+			return ret;
+		}
+		goto reset_queues;
+	}
+
+	/* Clear CR0 and sync (disables SMMU and queue processing) */
 	if (reg & CR0_SMMUEN) {
 		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
 		arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
@@ -5183,12 +5212,27 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 	/* Stream table */
 	arm_smmu_write_strtab(smmu);
 
+reset_queues:
+	/*
+	 * GERROR bits are latched. Read after queue disabling so that unhandled
+	 * errors would be visible. Ack everything prior to re-enabling the CMDQ
+	 * as a stale CMDQ_ERR would halt the CMDQ and new command will timeout.
+	 * Acking SFM_ERR is defined too, although it would not exit the SFM.
+	 */
+	if (is_kdump_kernel()) {
+		u32 gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
+		u32 gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
+
+		if ((gerror ^ gerrorn) & GERROR_ERR_MASK)
+			writel(gerror, smmu->base + ARM_SMMU_GERRORN);
+	}
+
 	/* Command queue */
 	writeq_relaxed(smmu->cmdq.q.q_base, smmu->base + ARM_SMMU_CMDQ_BASE);
 	writel_relaxed(smmu->cmdq.q.llq.prod, smmu->base + ARM_SMMU_CMDQ_PROD);
 	writel_relaxed(smmu->cmdq.q.llq.cons, smmu->base + ARM_SMMU_CMDQ_CONS);
 
-	enables = CR0_CMDQEN;
+	enables |= CR0_CMDQEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
 				      ARM_SMMU_CR0ACK);
 	if (ret) {
@@ -5244,7 +5288,12 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		}
 	}
 
-	if (smmu->features & ARM_SMMU_FEAT_ATS) {
+	/*
+	 * In a kdump adopt case, retain the crashed kernel's ATS-check policy
+	 * captured above rather than forcing it on.
+	 */
+	if (!(smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT) &&
+	    (smmu->features & ARM_SMMU_FEAT_ATS)) {
 		enables |= CR0_ATSCHK;
 		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
 					      ARM_SMMU_CR0ACK);
-- 
2.43.0

