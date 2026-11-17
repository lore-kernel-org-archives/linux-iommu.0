Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.20
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794943345;
	b=sHc3R1qt6os3S1F+iOdkPXPyyKTOonPWpu0ddyKarNQJFbeWvc2OZpnFOaKdsX98VXPN
	 9Xd/NhhFHwXeIyS2JrIoOUKWcdC6NrCR3VuUgXEzYj8uiP5jjVjG5nY8r4B3oG3zlVMIS
	 heWSgfeqePUCLO6gN6WbPLagW0MWmX036N12B1XXsAeaGzupY2zaRja2DzbIWil6oyd1u
	 WaSzr1nXr5zYrAZjpLkVtd6tbPyFxh/ViZ90sDGyiQYoDEnmd+cRCQmV9gFB04JbCE956
	 50uFRXPBaEH7QLhzVe1svB/MHPKVnmIRmJkRY8dnzaN8aYkOfBR09Gx/PXsilKUKfWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943345;
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
	bh=IEwyVioPIpJh3riyFyphhj9xuuZUb1w2nnWWEmr2kq0=;
	b=Na7AkuNgFAq7/kY0iYxd3T5SqZfiefYT4HitROgaDCQV+x6uRxBf4n2718rd3SbKG2vt
	 KxvVtPFn/QZpX2LDllo4mX8+T/aExKvN86aP9WpvEDrM61Z5pAMz6dfcMyyEwl4mW23xl
	 c/kIGwoOJTZbDbC5wHXz2UN3r/I/Z7aUw8pH7nA0es/tDWvozpFqyIr8JarSdJsbLvsqq
	 AgU8MBz6l9WS8MRKVAj+HH8dR5IShPlrxs6StCRQRLwhGXNfBrPFc53QR1NEwhW+kcVox
	 OHK6d4DzLKbUMAHiR8CB7FKxMyr87MacRSXVb/6G3WI5sZVedBO9U2l6UP7ZK3xt0Tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=s1NBDroO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.20
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011020.outbound.protection.outlook.com [52.101.57.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE48606A891
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 19:22:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFE48606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=s1NBDroO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oIfWn/l44llYnXh3g90eve8ddqoXBRHdIWr1Wf0V/G7jp6bv6tRAlpw1SE/T4rS8EJu4NR2FdaDM1BXleXC2LT9oP1Kf7RUMmeMWD9kRcJEOgbH/QozJa7Co0I5SRiiO0kNJqM68aeD9hVpKvm8as5y37ldkHfFqj7vRMlglTtQTZjlaONBkGPLFKnvhSrJliMVGFioa0TRS/NQ/jixnyVocB5WIH6J+Zm/9ZsdED8Lgu5kIAA3xsFwjRHooFJLzzmQ8pgtSANz0/JbvD7JAsUSVwfAP2+gbPbFwVeQPhTmEnMW7h9q/AL/+KqboQ4t2A8OWqOx4VX7x04HyC49GkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEwyVioPIpJh3riyFyphhj9xuuZUb1w2nnWWEmr2kq0=;
 b=wOXng+6Re7L1mKNUlu8tE/TVzhi3K7/YkSPIn6i+x0i5itfzI3XmtHNZdPnQyPDUsNN/3w5+nB6JDn6cl3L/A+j0ghuLMYuoHfbtvpKtc3M53nnE4BEqM4+K88J+BjhstfEVbqmcsLTXGWtMCsf0ydunNQe7vO7n/Yv5jUhG/yL+nk7SROC8VbGmxu7p3uNqYFEZrHSUfygCafwMSaFmKjwe0rABCLYWEd6GBHfyTw0AEkvmWXjdk1vaN+iEFIdppd43NYaw0uYK0vR2BeVUam6CTcGoGLav5xceeeR468K8uu80FRt1R5V4NkAIHX4LusHtME8GyjblpHz52k4Bxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEwyVioPIpJh3riyFyphhj9xuuZUb1w2nnWWEmr2kq0=;
 b=s1NBDroOiiCiLaPbbw+nwDjN7snA2z55bKfz6gbRs7sl3OrX2a2E2WWBqqR3V1UrJU4hr2jIyh75Uvgo47aqkJ2b7X/KsxPG8AplSHHGb2RNie6D933UlkDCG+SY/kgQDZq+aCk61MxXncgJOSE8p1cXutLvNMct3dRSFZf+EGgvsb2qwLBC4N9WosgjVdygiytWG15WN3FNXaILQ8kCxsucjZoi0vW+jPj7G3yFjKizcBu/RTeGvdWL0+encDX9x+6Z4jcCD+m+xJ1vwcmo55QUjtemLV9rIzh8Q8AXKjIJY3FCdftuFEJgqiIO72SRwMMIeK5+67NnGFuRU5KCww==
Received: from MN0P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::28)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:22:08 +0000
Received: from BN7PEPF00000096.namprd03.prod.outlook.com
 (2603:10b6:208:52e:cafe::29) by MN0P220CA0013.outlook.office365.com
 (2603:10b6:208:52e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 19:22:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN7PEPF00000096.mail.protection.outlook.com (10.167.245.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:22:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:21:41 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 17 Nov 2026 11:21:41 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 11:21:40 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <praan@google.com>,
	<kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
	<xueshuai@linux.alibaba.com>, <john.garry@arm.com>
Subject: [PATCH v13 06/12] iommu/arm-smmu-v3: Disable the EVTQ and the PRIQ in a kdump kernel
Date: Tue, 17 Nov 2026 11:21:23 -0800
Message-ID: <18d4af36159eede07e37588b8d990c47a64f918b.1794942324.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF00000096:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: f1edd3d9-aa0a-4b48-dcec-08df44e01226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|36860700016|7416014|376014|261022105027099003|10067099003|261026140227099003|11063799006|56012099006|261021135927099003|261022075727099003|261028144727099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	fJc6KsTBzmUKRg3LgnYNrnrPD7X6MsgJPoyRGBN2oXlvKtO8CKTLYLbyFQ1Bo4/gB33n5sY8ciqPezI5f9gk+PMoChMHafXQXWBB487wfEJ4zQpCb/Hhp0k/hbCBB5ihEMGJlGCq5Fm2sTsyHeprqxDvORsU3xSv6ui5kinnbt2eCOqyCi9VW+VujUnZjSB/PtJeS+2FYau1va/aFrRLGKdL8ibbVkvPki+c1PVNOUazHQ8C78abKR2aePxBCwECAY4naF/EqEDeaganF+iojuBS5FAVt6/znzmpBRSNkFexSNEu5KLHlVeiXRKh8HdUeKwETPMhjbWG1uy4V+OdUXehjok0A+iXbzQn/BbpCSNKSpge+b9E+DaflOyeqcNqdDfsbVAJ16DHxZSo8pRF/PACtezoNr7Ol12t4JepY8TJ9FQ50AGbQ8urZIL8ql+wnGsmHFKAyZlfVDNN/qE2Q8GGJQ/eqZmwH4NSrmdZF1Ttjs6Uqf25X9/F5py7ZnDG5pKUu9mTQmZhcfN5A3mhjym4RTTY4p7uHNrK56mfufPdF67EWDFqztLLj9h4wTcN/fkLlsSR1Ck2LPsEkmqdcazrkde2GtLQOkpgW6uF3hiL8+HEvRStWaKLErnevoFp04tNbXrAN52gEanDj/hwiaPbhX16y/7D5qA2Ul4z3YQxE8kpFXppE+/5yJQxIx5vqi0dMHxTK0sm2B3E/I0bJw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(7416014)(376014)(261022105027099003)(10067099003)(261026140227099003)(11063799006)(56012099006)(261021135927099003)(261022075727099003)(261028144727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NSKur6OFWox8dwawXueazaayPCTG1plEgCrFua91N2SIJ/+KmsGeZRWe9+lZBw6ccQIVLxeHw9xc0OYNIPVd5RhXc1eunRyJLkZYSy2NSgJRZ1xbHnqWfl7CJTSRtIoMW57aaGDWeHQOdAaurQYYYcu5t1AjI4CEuLZzdoLmVAQ0ttRqf8jfPxr81H2ukh5pm9aQj3cHiqbge3l9Ub/gs26wpza+vagKC8Rf/teTkWcsQD5LxSTdpnv9j4fvIKwz+ZqIM94vWFK558VgDdaK2wZGAD1+aXYaFfTUI+Xn2Uiz6dQ8JANj2WpFxoChBY+1ME+2zv5vZAvyKDkP+1gDxCR0mbMj7gxxtLZvaayrVmzd9VbiPr4wdx71JYt4dZPovFj7SMZwSU+nLMYOg2THJ/zWkD0+dKZiGQlLUDyl4eOGn/LUqRC30J5+9LYlVn/J
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:22:07.5971
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1edd3d9-aa0a-4b48-dcec-08df44e01226
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF00000096.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738

A kdump kernel cannot use either queue without potential problems. As the
crashed kernel's CDs and page tables might be corrupted, events could spam
the EVTQ. Also, there is no way to serve any page request that would arrive
at the PRIQ.

The reset routine still enables both of the queues and then masks the two
enable bits back out, having already programmed the queue bases and taken
the interrupts of both.

Clear ARM_SMMU_FEAT_EVTQ and ARM_SMMU_FEAT_PRI in the probe instead, so as
to entirely skip the queue initialization and handling in a kdump kernel.

Suggested-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/all/amiBagGKn-Aym1DK@willie-the-truck/
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Breno Leitao <leitao@kernel.org>
Tested-by: Cristian Prundeanu <cpru@amazon.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4347e3e3b4a52..d137c78c99c0c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5249,9 +5249,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
 		return ret;
 	}
 
-	if (is_kdump_kernel())
-		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
-
 	/* Enable the SMMU interface */
 	enables |= CR0_SMMUEN;
 	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
@@ -5578,6 +5575,15 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	if (arm_smmu_sva_supported(smmu))
 		smmu->features |= ARM_SMMU_FEAT_SVA;
 
+	/*
+	 * A kdump kernel wants neither queue: the crashed kernel's CDs and page
+	 * tables might be corrupted, spamming events, and page requests cannot
+	 * be served. A disabled queue discards new records without raising any
+	 * global error.
+	 */
+	if (is_kdump_kernel())
+		smmu->features &= ~(ARM_SMMU_FEAT_EVTQ | ARM_SMMU_FEAT_PRI);
+
 	dev_info(smmu->dev, "oas %lu-bit (features 0x%08x)\n",
 		 smmu->oas, smmu->features);
 	return 0;
-- 
2.43.0

