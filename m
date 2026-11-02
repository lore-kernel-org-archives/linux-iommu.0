Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793596805;
	b=SDKMKaC9jsAmUjk4sOYnqx6fuEgjZ3+N69nHVP3ov9+g5EBVjNokbQ0ukGi7FLuR0gqY
	 7TsHxRSyesV5VVk63QheCKQa19J1qSoHN8ZfjsluZCMa3HEQodp7ZQ+YiwLZWuf9irHME
	 nCVjwDU1hv5jDM/cPH5I6i0sUWFPWsSP0GPRmTfFkvrcfIlFs9nu1AXZD2tE+dNIel/oz
	 4wvU/FHH5pvQLTaRmL1GVfbT1IH5WoyOr0WbZsBwytdG0x4eGEaogt3d3A86BmQbx6Muf
	 PNec05Vzn3o29gvlahCOhFqUTmIcBU/KI/gOd9iWTTQWGvJcbx4NODfTRnBPiFjOHOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793596805;
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
	bh=GyaW8cKSCvgnBre4vU5D2ynqJt+96uflyUIRP2q47HE=;
	b=GyykNQfoBQdhFDkYaGmnLGNQkdoVNO1FV01/L2BwSyw/h+1rYqBH5gKvNVcLxPiMJNic
	 H5OZ5NOLBxqOBrpy4B9k53qQLikYuxbG2LGBO0i/Y6qc4DKKNA30k/5FL1p27KfJOQ47I
	 +xPEOuLLeDTQxezWsnwirF2B2xv2+9ec5yUS4jeXPcE4Jdm6QeVGmIJynfuxcNRwTds66
	 7fpB8LVf0w0co0tBYXXElXTQW34OfnHYlxBlTHFcVbZXU5RnyjVR24DELFfk/xvWw4/s8
	 qhvlf9107OwfSGQx5OKBxI7eB2CmeFXm/IB4hTpbuWu2iTqhWppUEB5Vp0omqys4cTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hs0y98uK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.46
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011046.outbound.protection.outlook.com [40.93.194.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D8460A261F
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 05:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2D8460A261F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hs0y98uK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUV86htsIQBhs+jMl5W1Dwx/NVDMSwY5xCkJybQZ1vlnNigXcRJW4s0b9cKJeVQVXp/oD+YnCVOu1EECxSd3w7KrjURZ6oD//lHhWNbny+keLllnP5344qt8Z/kZarVIom7MniYRopQKOoYk27+k2/r6H08CJDuLIL1Ebo5TysgCaI57h3wxs2wrMdHWxAK7b7cGUZn1+kVqDAFodaDyCTjf0iCiZYPmMPzCtobl82w1pzaCejDo7RlL6dfRfiCxWZ3VLWfyXcci5CNqskbjUIOoEqPuU+esqiPykxV6TtwtfWvZ95rZdxoXhcghGeZHDwc3uWOu1/L6jHYvfEV5Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyaW8cKSCvgnBre4vU5D2ynqJt+96uflyUIRP2q47HE=;
 b=DaCzsrqEbb/pMHmsXxc+43VZjflLWAHVv1rQ9x3KXMRKWg76BzJ9BAOoVm9hsllCo/XVJevf4WZVgRVhCzJC8Qbj3xmUoTPIvq4qTzc1smosnifFZYgCMGcizIfqn0GOLkj41bxR7J4SFJaKJ16kaqdfsuzFR9rKE1cIxbcYaAE612ctWnpsGHjEpAawAAG08X47F/tGpUWxNrTEDJxH6/tSW4L17r7PfPu75CAKWn5KxVgP/Q/1THnENZ7jd1m7AUgG+P8YONuNUDQ46Hc69EuCavVpwETApgVixopxQ93jw+ATO/Ae4Pe5Q0cpTzHSghuHXaiTwEQ/TS+0Ir8FQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyaW8cKSCvgnBre4vU5D2ynqJt+96uflyUIRP2q47HE=;
 b=hs0y98uKVSTb1z3xg5khUGSbRqxG7MLA3MidN1XM+eDpi4O0XerrO5l0MVEv4WnaLtY8FTnI/XzUqpxz7ToZhWKPlqGxl0A6o+bg5u9BTpfuO0bulCNenraX+k0ZWR5ErBa5jBRQ2jLmrqrbaD2Y3wyvhjbXAkByapmhh2CbQEvOxM+CRH4Rki6mHxMet0CE+aMY6uqsWFvTUjj/3kix6VdAL5/GA5iacCbSMK/mrsSkkvPv7YW/12RjDUt5MzizpvqFr6TyLBiP5iWOIeNdygHgxsxdqyn8Uoi2ehm5PhZ8jt3L0shlcRvXvdcMqtYVdhEyleTtl2sSKfuCDoYLOw==
Received: from PH8PR07CA0008.namprd07.prod.outlook.com (2603:10b6:510:2cd::16)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 05:19:57 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:510:2cd:cafe::53) by PH8PR07CA0008.outlook.office365.com
 (2603:10b6:510:2cd::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 05:19:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 05:19:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 21:19:44 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 21:19:44 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Sun, 1 Nov 2026 21:19:43 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <praan@google.com>,
	<kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
	<xueshuai@linux.alibaba.com>, <john.garry@arm.com>
Subject: [PATCH v12 12/12] iommu/arm-smmu-v3: Detect ARM_SMMU_OPT_KDUMP_ADOPT in probe()
Date: Sun, 1 Nov 2026 21:19:20 -0800
Message-ID: <12d498a18dc5a40c4e251397e35f995544730482.1793593923.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793593923.git.nicolinc@nvidia.com>
References: <cover.1793593923.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: e784ee16-6a3f-470c-c790-08df38a0ef34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|7416014|261021121427099003|261021135927099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261026121527099003|261028144727099003|11063799006|10067099003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	o7zg9GOuPkKQvnI7Mg2AMvUAttR3ax0LrUm9xgEZEfDm+kn7qXw1DlNFJrxNAoEgfZ97su+2D0hqZAxaoC0jfR/EHZdBHVuGbi8JEey2HObRHYatvdbjyHazQhJhqmBMEKFiP1ZVkCKaoPSnvhjQGpcVAb/a8QmAgYwB/MHJ6K8/1DkPy+Db5yQptsGW0Wg0AG6w95Nd3Cg1Y3Hso8EG2DuQs2dEE0xXhlbjkby/sRj6IiKO6tzY2XJKGSniil1NwaAle7NCVK0X9Zjrz0TJ2xX5Y8UiO/bd6oOnPkk9cQNCukTVqKcOSNbgPc6LT3j6bQvCdAGw/xPyNFPQeffXALLeCBFAzebq4Y0cUkq7aE3egkX6OK7WgtpW5upuXON03z+hPo8GSiO5u1YOOousKRYDehySyNKDL+btNqsrvbQBSm2h7429sMB6eGKKKWPZoyXkBKnUAb1tl3wXpBJAqP0hIlRKvnYW2OuvglNCLJUUVAXn7EloGxAmzkU0oHlXqglb5EsnXUCVzAEI6fq9EKaoVF6Kmt+A8UuXFc6WvcmoPzhSQdsd7OmyvVrLEckt1xrkkBUKOI7Udzebdvrq1w0sFxwRrWWIF9GzCtXNSiME1udI04UQsuqotGqZfW5HdsJgcDCwhf1lwA+NBFxMZPd6GjD/EgyvZN23HoLCo/CaA+UCr5nk6lWMyjF0EeOICLoeMh1Wtg36DslJBely6Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(7416014)(261021121427099003)(261021135927099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/KzUGXaOe+UDXjirEeHHxqXurQ+XpQfbVFBQv8zlb3FqJGHqu9Pjk0LI3q45NOZe+RqZpaTFvWb8NHj1qZfVVyYmhPzbhVk9FR8GlKG3Hs3nf7MugIKZljVg/vFFIjCxs1NB29KBhLlkRfR55gNiEbLv/qCxuDE3j4ORv71NIvKCQwl8Mxr0xTmS5spvQqB6KCLJIxi9ph/ReVl6Xni2zwgV9FH7mfdY2iS3noxQ+zddHhqXlt2kcKxs2ie9IPYiMbfqFA1C5+KP8tBHVk1HkOoDstKSW2HaXFo+Gb/S8gvpSuoHs0Lsmqh12vmCDTPqi5JDmdthMBtJeJOswZ+JfwmIofydcJslmlccCU3mIa5sM362m19wTbyrDzOkL01DibcTtSDT/szNoIt8ifWN5OR1IkNGlwKLVQupFT4S+OrnqURxayae0uh9ygefD7iB
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 05:19:56.8654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e784ee16-6a3f-470c-c790-08df38a0ef34
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522

arm_smmu_device_hw_probe() runs before arm_smmu_init_structures(), so it's
natural to decide whether the kdump kernel must adopt the crashed kernel's
stream table.

Given that memremap is used to adopt the old stream table, set this option
only on a coherent SMMU.

And make sure SMMU isn't in Service Failure Mode.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Tested-by: Breno Leitao <leitao@kernel.org>
Tested-by: Cristian Prundeanu <cpru@amazon.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 ++++
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c | 27 +++++++++++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  4 +++
 3 files changed, 36 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 5b2f6caf16c3d..25622f9e14201 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1344,6 +1344,7 @@ int arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu,
 					    u32 sid, phys_addr_t base, u32 span,
 					    struct arm_smmu_strtab_l2 **l2table);
 bool arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master);
+void arm_smmu_device_kdump_probe(struct arm_smmu_device *smmu);
 #else /* CONFIG_CRASH_DUMP */
 static inline int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
 {
@@ -1363,6 +1364,10 @@ arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
 {
 	return false;
 }
+
+static inline void arm_smmu_device_kdump_probe(struct arm_smmu_device *smmu)
+{
+}
 #endif /* CONFIG_CRASH_DUMP */
 
 struct arm_vsmmu {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
index 2ab913f033515..da157e6620cf4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kexec.c
@@ -705,4 +705,31 @@ bool arm_smmu_kdump_is_attach_deferred(struct arm_smmu_master *master)
 
 	return false;
 }
+
+void arm_smmu_device_kdump_probe(struct arm_smmu_device *smmu)
+{
+	u32 gerror, gerrorn, active;
+
+	/* No adoption if SMMU is disabled (i.e., there is no in-flight DMA) */
+	if (!(readl_relaxed(smmu->base + ARM_SMMU_CR0) & CR0_SMMUEN))
+		return;
+
+	/* For now, only support a coherent SMMU that works with MEMREMAP_WB */
+	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY)) {
+		dev_warn(smmu->dev,
+			 "non-coherent SMMU unsupported; reset to block all DMAs\n");
+		return;
+	}
+
+	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
+	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
+	active = gerror ^ gerrorn;
+	if (active & GERROR_SFM_ERR) {
+		dev_warn(smmu->dev,
+			 "SMMU in Service Failure Mode, must reset\n");
+		return;
+	}
+
+	smmu->options |= ARM_SMMU_OPT_KDUMP_ADOPT;
+}
 #endif /* CONFIG_CRASH_DUMP */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 3696d11c852a8..80a20e2d922dd 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5641,6 +5641,10 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 
 	dev_info(smmu->dev, "oas %lu-bit (features 0x%08x)\n",
 		 smmu->oas, smmu->features);
+
+	if (is_kdump_kernel())
+		arm_smmu_device_kdump_probe(smmu);
+
 	return 0;
 }
 
-- 
2.43.0

