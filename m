Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794943335;
	b=h64rfhNdHl4wnbQZ3d+v7k5UzDCDtfutdhp1eb7fBHvXMo9PkSsk/2d90tED3i/iy3c3
	 o0xrIkhSWW7b/CUOvSXj9NX55gTulBfe9yZuV+iq3zE014c7D7eqXBvdpNHvVdWtuwPSA
	 HRYBUCbqpMeDaXGZ/VlhR7k2JWxivzAK34o/GCPM7rPHkpuU6Ii+wny1nWh94P3/H5EDv
	 4ZCXTc76ACnprbdc4rlRW1nnomXqHiIlpB5APvEVA27p7xz5L1kIOgmQGZ4D7i7eA7lzO
	 o+lZdV8GX9y+H13HjzdKY/xtjwDQtZry8oCG7acAyxn4C4dyYmE3GgNqtiaIayIWZ5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943335;
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
	bh=xtv5O2XoN+Qu2tZIzrmwB1Qj5vfAuqYe1ZkBfBagBe4=;
	b=M3x5zh3gC/V7d4z2nYZGL+fbd59+xv1gwPIbXnULGQrXqncQRaaJptS7Q8PIok/y3pln
	 qWQtWYZubD7HWFhgrBOupYCTm+p6ain62+ukNEndzvVq7CjJA84rKsKwB+hrt8r0Q+MVn
	 j9PPSRic0aFJUIOsLkfFlwcNc6Fr/3aCjdWa5iKv/6rxGsj8/togAq16HA/Bgo217WpxY
	 SHLb7yOFyflfel6gWeVWgLQoX4HEIcrJoeS9TkRVTuN/cp3Du/BwRNFZGZ6caZGhJl6sD
	 Dy65d60a7hTz/ZKWoimXg3z+UxOIcwqn9tWIaxempPOIy1LJsYB9O/8DH93djceCecg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="kAE9/4RP";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.21
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012021.outbound.protection.outlook.com [40.93.195.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D297D606A8A3
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 19:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D297D606A8A3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=kAE9/4RP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJLVCrw4f8DCiNeqyzpjasle8qaWDszsqnUhMWZtHgFRK4H3SZCvaIG49dSXsj1u/b6tMUNX1bvOOmVOA9FXmVFtQRwf4EH133SA/ODoTOu0FCVsAhfSUg2EYJmiS5Mn/zqTvpxbWFNmW5jCYvd7Fm/xqxB3gdS8whkkxWTzr1xFfnSFWKvG/ZGyHFEzGgm2axM03ux/9B768ML3w6cs5l/sIp02ONuWLkSCKLiZW2A9tCf0UuOcYW6Zy9uzUA5zdqV5b11GewBGMubgMe8n44hvXAep1h5JvstL5ZTF4D6rCgBTXDMX/DSZVO8SEyO5bbTkx8mQA+5/0Sl8DlitvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtv5O2XoN+Qu2tZIzrmwB1Qj5vfAuqYe1ZkBfBagBe4=;
 b=jBZ1BkITo8BEsI/aeD65ZMTBOAT+mov4nKGSZmUl1lGQQsvTKY9I9ybAkDhpL0femnaG7rPvsbX3TquPxAZgXfE2rmVqV6YV95L9vCn1VbDoOEqDYjUqBjgepBCtI7HiHtJm0iaTmbxajliEZu7SugpU/Xp2gNh962TOqk1BWe9azEwjn5vnYzezrXCHsGQAXUlT2rWINfETiy2Z5vXr2VSmvoqBZL14dPiXbmWjzXZ815TafMqPkpCoDID1AMRI1XqoVMxwBibZkI6TgL7Twz0lizuP7P3wEi7MDtOy806Xcj8Yp8Xmy8JPeSsmN2/mIuX5piAuNO8cqVTrFY77+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtv5O2XoN+Qu2tZIzrmwB1Qj5vfAuqYe1ZkBfBagBe4=;
 b=kAE9/4RP9ROn2lfAla1iWoAZzmDCLCxnvRAuujv+BC/dtcCyp7yUww1zgslKpUxgvgysYlrB4lP9nGe7LCjBWQlPRHa422qWLpuS8ywwoGyczOTFrDi3S66vpZFmTX5wJR50ij/T5+rZ+3GDFjC8amWmBOjwyulpa6WLdMoHMk0rRl9MKFFabZrDUAM57T8avS4yqVesZ5UK77Xx4g/FkYhp/+mx4TjaNgYddXRkKx7ZdC/2k+rgCnQ6q9keS1zV2RspX3f+wwOWUUxpN2++e1WoWdtDYZXy138qf2+lmgMBlo9OFAsbJwx4/v+ybqurkWdkyaGVyXUCG+1e7BHJXg==
Received: from BL1PR13CA0155.namprd13.prod.outlook.com (2603:10b6:208:2bd::10)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:22:06 +0000
Received: from BN2PEPF0000A990.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::64) by BL1PR13CA0155.outlook.office365.com
 (2603:10b6:208:2bd::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.4 via Frontend Transport; Tue, 17
 Nov 2026 19:22:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF0000A990.mail.protection.outlook.com (10.167.248.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:22:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:21:40 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 17 Nov 2026 11:21:40 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 11:21:39 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <praan@google.com>,
	<kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
	<xueshuai@linux.alibaba.com>, <john.garry@arm.com>
Subject: [PATCH v13 05/12] iommu/arm-smmu-v3: Add ARM_SMMU_FEAT_EVTQ for the event queue
Date: Tue, 17 Nov 2026 11:21:22 -0800
Message-ID: <c36250ad3e2b339ba623170939dcaeecb1dcb0ad.1794942324.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A990:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d1c4f3-a4b5-4c99-fd50-08df44e01163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|23010399003|18002099003|22082099003|6133799003|5023799004|11063799006|56012099006|261026140227099003|10067099003|261022075727099003|261022105027099003|261028144727099003|261021135927099003|261021121427099003|261009223027099003|261102123227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	e8PeRwv2lE0UI6IrCpOyIz+IiosxDedlw4MQGGNCCeAnUuvSgh+rasa8M9fccD/sVrToQ14exRmTrJ5fFSMAYxzZsvemrvWukrS2L/ZZ99br3TkAPNoszIfmZUgxAfnAhno7WA99C+8opYJ6dDR2jmvwBsAYrF/8/e169nU/iUQpX8vAZp+S8mwS01/rbcsyag8PUFK7fqUJrCfT0KCNYdIIuXx74ZPYrrJrW2QtmpdylNcvCCwSZHam9DHbHFPdztg7FosG0eluym51Jcatp5xXTwv+FVyJqWp2MnN6dyhskfCgQJwYSxlsKEIXK2hJeLONpb857quFf11MXRihRkCTiYNi3X7hX/SYDW5s/HU9OSmG1sra+iegVWhoWD3cKEPVLRl/vBaOnCjOawP7/a+A4DoAx15xkYqXDZB40dtsS/5HDiCaWLXNCvIPtxuFX1ZA/oF1l8Zn5qZZY/irdYEtg2gw3C8zkFvtO2L92/AGuuqc01+RuaQXuwtqIDcHQWneB6Qa49iKc2rZRApFr0DJO1Ve8nnhm41Q4mi1Op7uGUL1a6MuW8gU/2omGBquguPv52Y0fXsuY/7TzPN/XDOUEUtI8NsacSFH1unghO7xtmWlNiFnnLp+co2uyb4ywl1Gf3beg7OmW+r1nf4RFolYye4JhINqHyF877GZDBh1PmZ/eQw0+9eviD4zuyi31JVFvBoiGyBhsDHnXXonZw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(6133799003)(5023799004)(11063799006)(56012099006)(261026140227099003)(10067099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021135927099003)(261021121427099003)(261009223027099003)(261102123227099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZvzpWj4qqGAGVobTBXm3Q7M09kKtBXvp0xW+DYq3nMQyONVy+F9PmMPH5vMrniT9C0oaK6t+UGK0yx1wcjyDSqc4JCyXld+jjfzbEJsGJm5raPJRYx3VleTk8HbhbwOFiscOIJl7gHIXiNf3x5mLF9sIRZGKy/p3RaRrwtGMJI+WLWRzv1Os0SykbfBtimWa23/uSgTe7ln+D2uhBCtoF2feI7jI536LH8Y3ufa2wyC0rVFRCihQLuJuvKiHDwRqPaqQms1V2CYs6YNOrjZmugE4/XtFcGiRVqOTbKHvZVH/lhLE0gRzJxtykAIUPYYNQGuYJhTMeH+PIDdmzJICCgiy5On5lxQ/XKOrSgC50Qw54f4BQ4fCdnPGoIAIJlaTKHANsWQT1+5OsBJ9QycKhad0uQb9uTt2zaUKwUfHcigHDY/DXn2XSrrEHANwmv5S
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:22:06.3171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d1c4f3-a4b5-4c99-fd50-08df44e01163
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A990.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212

The driver programs and enables the event queue unconditionally, while the
PRI queue has an ARM_SMMU_FEAT_PRI gating each of its touch points. Yet a
kdump kernel wants to leave both of the queues alone, which would take an
is_kdump_kernel() test at every one of those places.

Add an ARM_SMMU_FEAT_EVTQ that the probe always sets, as the event queue is
architecturally mandatory, and gate the queue's allocation, its interrupt,
its MSI vector, and its CR0 and IRQ_CTRL enables on it. A subsequent change
will turn the queue off in a single place.

No functional change intended.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: John Garry <john.garry@arm.com>
Tested-by: Breno Leitao <leitao@kernel.org>
Tested-by: Cristian Prundeanu <cpru@amazon.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 82 +++++++++++++--------
 2 files changed, 54 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index f6892dd0e5080..74fc4a05c23f1 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -979,6 +979,7 @@ struct arm_smmu_device {
 #define ARM_SMMU_FEAT_BBML2		(1 << 24)
 #define ARM_SMMU_FEAT_HAFT		(1 << 25)
 #define ARM_SMMU_FEAT_DS		(1 << 26)
+#define ARM_SMMU_FEAT_EVTQ		(1 << 27)
 	u32				features;
 
 #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 36ca05418f728..4347e3e3b4a52 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2375,7 +2375,8 @@ static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
 {
 	struct arm_smmu_device *smmu = dev;
 
-	arm_smmu_evtq_thread(irq, dev);
+	if (smmu->features & ARM_SMMU_FEAT_EVTQ)
+		arm_smmu_evtq_thread(irq, dev);
 	if (smmu->features & ARM_SMMU_FEAT_PRI)
 		arm_smmu_priq_thread(irq, dev);
 
@@ -2384,7 +2385,12 @@ static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
 
 static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
 {
-	arm_smmu_gerror_handler(irq, dev);
+	struct arm_smmu_device *smmu = dev;
+	irqreturn_t ret = arm_smmu_gerror_handler(irq, dev);
+
+	/* Without either queue, the thread would have nothing to drain */
+	if (!(smmu->features & (ARM_SMMU_FEAT_EVTQ | ARM_SMMU_FEAT_PRI)))
+		return ret;
 	return IRQ_WAKE_THREAD;
 }
 
@@ -4757,11 +4763,14 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
 		return ret;
 
 	/* evtq */
-	ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, smmu->page1,
-				      ARM_SMMU_EVTQ_PROD, ARM_SMMU_EVTQ_CONS,
-				      EVTQ_ENT_DWORDS, "evtq");
-	if (ret)
-		return ret;
+	if (smmu->features & ARM_SMMU_FEAT_EVTQ) {
+		ret = arm_smmu_init_one_queue(smmu, &smmu->evtq.q, smmu->page1,
+					      ARM_SMMU_EVTQ_PROD,
+					      ARM_SMMU_EVTQ_CONS,
+					      EVTQ_ENT_DWORDS, "evtq");
+		if (ret)
+			return ret;
+	}
 
 	if ((smmu->features & ARM_SMMU_FEAT_SVA) &&
 	    (smmu->features & ARM_SMMU_FEAT_STALLS)) {
@@ -4955,7 +4964,8 @@ static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
 	unsigned int nvec = 0, i;
 	int ret;
 
-	arm_smmu_setup_msi_vector(smmu, vec, &nvec, EVTQ_MSI_INDEX);
+	if (smmu->features & ARM_SMMU_FEAT_EVTQ)
+		arm_smmu_setup_msi_vector(smmu, vec, &nvec, EVTQ_MSI_INDEX);
 	arm_smmu_setup_msi_vector(smmu, vec, &nvec, GERROR_MSI_INDEX);
 	if (smmu->features & ARM_SMMU_FEAT_PRI)
 		arm_smmu_setup_msi_vector(smmu, vec, &nvec, PRIQ_MSI_INDEX);
@@ -4996,16 +5006,20 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 	arm_smmu_setup_msis(smmu);
 
 	/* Request interrupt lines */
-	irq = smmu->evtq.q.irq;
-	if (irq) {
-		ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
-						arm_smmu_evtq_thread,
-						IRQF_ONESHOT,
-						"arm-smmu-v3-evtq", smmu);
-		if (ret < 0)
-			dev_warn(smmu->dev, "failed to enable evtq irq\n");
-	} else {
-		dev_warn(smmu->dev, "no evtq irq - events will not be reported!\n");
+	if (smmu->features & ARM_SMMU_FEAT_EVTQ) {
+		irq = smmu->evtq.q.irq;
+		if (irq) {
+			ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
+							arm_smmu_evtq_thread,
+							IRQF_ONESHOT,
+							"arm-smmu-v3-evtq", smmu);
+			if (ret < 0)
+				dev_warn(smmu->dev,
+					 "failed to enable evtq irq\n");
+		} else {
+			dev_warn(smmu->dev,
+				 "no evtq irq - events will not be reported!\n");
+		}
 	}
 
 	irq = smmu->gerr_irq;
@@ -5038,7 +5052,7 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
 static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 {
 	int ret, irq;
-	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
+	u32 irqen_flags = IRQ_CTRL_GERROR_IRQEN;
 
 	/* Disable IRQs first */
 	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
@@ -5064,6 +5078,8 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
 	} else
 		arm_smmu_setup_unique_irqs(smmu);
 
+	if (smmu->features & ARM_SMMU_FEAT_EVTQ)
+		irqen_flags |= IRQ_CTRL_EVTQ_IRQEN;
 	if (smmu->features & ARM_SMMU_FEAT_PRI)
 		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
 
@@ -5182,16 +5198,21 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		smmu, arm_smmu_make_cmd_op(CMDQ_OP_TLBI_NSNH_ALL));
 
 	/* Event queue */
-	writeq_relaxed(smmu->evtq.q.q_base, smmu->base + ARM_SMMU_EVTQ_BASE);
-	writel_relaxed(smmu->evtq.q.llq.prod, smmu->page1 + ARM_SMMU_EVTQ_PROD);
-	writel_relaxed(smmu->evtq.q.llq.cons, smmu->page1 + ARM_SMMU_EVTQ_CONS);
-
-	enables |= CR0_EVTQEN;
-	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
-				      ARM_SMMU_CR0ACK);
-	if (ret) {
-		dev_err(smmu->dev, "failed to enable event queue\n");
-		return ret;
+	if (smmu->features & ARM_SMMU_FEAT_EVTQ) {
+		writeq_relaxed(smmu->evtq.q.q_base,
+			       smmu->base + ARM_SMMU_EVTQ_BASE);
+		writel_relaxed(smmu->evtq.q.llq.prod,
+			       smmu->page1 + ARM_SMMU_EVTQ_PROD);
+		writel_relaxed(smmu->evtq.q.llq.cons,
+			       smmu->page1 + ARM_SMMU_EVTQ_CONS);
+
+		enables |= CR0_EVTQEN;
+		ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
+					      ARM_SMMU_CR0ACK);
+		if (ret) {
+			dev_err(smmu->dev, "failed to enable event queue\n");
+			return ret;
+		}
 	}
 
 	/* PRI queue */
@@ -5339,6 +5360,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	u32 reg;
 	bool coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
 
+	/* The event queue is architecturally mandatory */
+	smmu->features |= ARM_SMMU_FEAT_EVTQ;
+
 	/* IDR0 */
 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
 
-- 
2.43.0

