Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793677818;
	b=Ls0G3qbEGo0rSi0M/8Le1VfHR44pxVCpYeFSyIcpCque93UV+Iy0O6zWeM4KQxN37FsJ
	 6EltJjJwK0gUSMvQpLXb8Wc6DWeZein67OCVIwXDS71/WwcP3HCnZEEDD+6wCf2JLsbZP
	 a84c3oSCFzBwBx9COWf2YrZLvNSDgXFmoXbzeYdKOR8F8uG9WbLX9xjpZ+rZad+/ljaPw
	 H4iAFRKKy5YDfJgv4WGu4Bs0BdGwH7Jfgkochu8nWjBfw6/KQAnEJjrkFN+FlybzlDMqm
	 RQsCosvvAP6wxdyB/oR+V/xtcszM0cKN+Cz/+eFhUPAA5+nXjP6C8YMVMYC5fCCCoxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793677818;
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
	bh=TbsdfhqjFLljt1j9XKpzR14n5eX7CPQSs2eqVapLe3s=;
	b=hmnGjvDHYMCg67e4rGJWKgE7UNFLgRyhR/RgL4ZubKwY4Lk6L4bkA7ifs+A6yHKE7GVj
	 44qpBC0hNljq6V2QJ2wise+mpu1tc2Ke/7ndRZNPb/xlWs01t39eImzmo4cawXeLzoIsB
	 Q3CCf0lRt5sDvM5XgqkkapIRllhu74mRo2xsM8Q4y/VI02IR4P2zJBrX3/mvoWj/saLow
	 XtEEKBaVODCdLpCPV+bGVhwKj8SsZi5Qd9nB74uz5wAOVmVN7+6IRbcFH/bQoMl66g5kz
	 tlHVhwASm4f0ghyu1Hub5csWVRZ1hqL3VpDsXlr8hr+vpDuWJHbCCWbBQ4Zbsa4b+HQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="c7t/Tdov";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.43
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010043.outbound.protection.outlook.com [52.101.193.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9182C606A338;
	Tue,  3 Nov 2026 03:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9182C606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=c7t/Tdov
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmqnbhCow2zsC8o7gfozfsDsqJoi/o9wnRB1zp3lX2M7t1GswmElyawjiUDGIEEMzLKzO2DC5RefTy4q/0SbODgU4UeUFlcyA87wIwADlsEpuAcMvf8FyBsRYwqmUtFBR1ryZ1e5C+MqqiilKggLH12EOcg2cJujQoEP4rCrna7NqN3qgHWbPSVdpYKVIzBCFIMsoDpt8orY/7W99ApbLXZ/yNswTV24fV/eQECR0AntVagYUEQQ2pP3+2K0B0yVCS2o2isAI7DotFS88XU8WLR+N5OffwCvnCkC8AVKHViqcx42WI64xlf5Db3Tf9ybRgFggx2PpOi2bRX2UDNabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbsdfhqjFLljt1j9XKpzR14n5eX7CPQSs2eqVapLe3s=;
 b=wXtl/fCykZyg73GAykI/tR/Mb5m0YB6kTpYZHoJFvvR1rGVD6BSQTglwTgLekJAYQlDNldkZYwYAAPOq40kgbB9iO3MjvmZPs/g6R9kIsHtnjhUiBysF4SYLkapxihzJWqY32lwlgj5GRhewPG27WIFUFWBTkvmarUdwZe1vWC1mtGIFv7We9711C+Ss382f5KUDr+qW+AxFB9wRx02MComkPNMED3vckutLEhl5sxox8/Ep6TmG4fYKZt5bcgEuzjSsihgtzJQjY7HOT//YpzdHbxXPIMFmIDZMThX4dxU6nYXtVjinSCpOx17exes9ZXSsXHUmx4ESUjMHXkISrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbsdfhqjFLljt1j9XKpzR14n5eX7CPQSs2eqVapLe3s=;
 b=c7t/Tdov4G7pkPlmolnY2G+eJpp3LaHGJu8176ytfIWA0SlF6A159+SD94ZMoREMUIxVpKkrQUIQiU++PT6pR1zvUnAbH5ZUi+d5Gyd5IUSW1d102G/jSZMaEe4ee87TUpIl/fiPPxCnO5f6jFuXcpZfZmfSid0AJrQJM/8+QihlO6EDIKSOmeoz/unCpXr3UGeGGKw/a3mHtwZ6W9IcgTDUxXmzcgyzNO9r3TrzID4RGmivdAdfneigPAd+F5Ni52XJAUHJl4Sc7HfajHe1zIVd7F+BrtAPyaxh01UeH51gT8VrNiML9o07D+n0izc4EuaPl7l1FBs92tnfbO5sxg==
Received: from BN0PR04CA0100.namprd04.prod.outlook.com (2603:10b6:408:ec::15)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 03:50:13 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:ec:cafe::87) by BN0PR04CA0100.outlook.office365.com
 (2603:10b6:408:ec::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Tue, 3
 Nov 2026 03:50:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Tue, 3 Nov 2026 03:50:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 19:49:58 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 2 Nov
 2026 19:49:58 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Mon, 2 Nov 2026 19:49:57 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, <rafael@kernel.org>, Danilo Krummrich
	<dakr@kernel.org>, Johan Hovold <johan@kernel.org>, Marek Szyprowski
	<m.szyprowski@samsung.com>
CC: Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Pranjal Shrivastava <praan@google.com>,
	"Mostafa Saleh" <smostafa@google.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <driver-core@lists.linux.dev>, Sonang Patel
	<sonangp@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>,
	<shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 1/7] firmware: arm_rmm: Add VSMMU commands and fields
Date: Mon, 2 Nov 2026 19:49:44 -0800
Message-ID: <efc402ba59961b271c2d7ce26f3b91d717f7392d.1793676742.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793676742.git.nicolinc@nvidia.com>
References: <cover.1793676742.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 9129096a-a5a3-48ed-c955-08df395d90ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|7416014|1800799024|376014|10067099003|22082099003|18002099003|261102123227099003|3023799007|56012099006|11063799006|261022113327099003|261009223027099003|261021121427099003|260925021311599003|260925022911599003|260925021911599003|261021135927099003;
X-Microsoft-Antispam-Message-Info:
	+4Vpo6cIAwkQc4arcpQi4pme84rGhdC35uQ10LTcORQJFjwRsM2Ky8NfkfAxT8RvHkghdovntyqjDNtOfBPznFWSLZPUDyJgaCyTqSjibuo1qcW2RzTSBVKMToyazJ9qdH1mlnx7YX1ZFbmvjZ+j0gjsysQiO5goapRIcQ+HpNQwmqgfuVOMDZqtOMImKGfacsgPefKO1jdVd38XbgKTgvecjChuI1bUZ6J7bmPmtDY0qX47FMbn9Zku8I2D2c+7PKT9EsnRYwjd9v5FZMG1kV+LXSSPNGgUW3tETMwdhgQpuA4yExtZdnQ3DIczNSebbSDhlq/ggZ8Y7/GN7C1Jhiusgvp64mahH2jytI6lh0by9Lpx3+1dp5AwobOoQJUrhTCe/3pRydf+xzMz450OmhSWKgJzm/qbnnqauhbHgym5jnJNQuf84dS5LHJWW5IuiyXY1blNYLJkbDAHz+aGDdJCgwZe4jHgPoUgulKt/BSGUgfZxPNEp/CxlJPlmgIYmdQeHa6Xff4okXSb50iXfzY3ErDzL+Iw4DSPWZ6j7UNTgMrpGNu6LvM5eiO5wdCW3RgpLROoA7yeItrBznYgIMpEUKIu3Vv9beQ14xKHyXOKp6oiBCAPON4iOzWRup8XtdUJ4NAovfzuvzC/AfHGh1J9r4UpVl6LuMW/qpWEAsxZyK6FSlA+RBvGVuLe6JsaekWRJhXcHoo9mmRYHcXx2g==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(7416014)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(261102123227099003)(3023799007)(56012099006)(11063799006)(261022113327099003)(261009223027099003)(261021121427099003)(260925021311599003)(260925022911599003)(260925021911599003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	24dXDSpXCqNG7nCaXBw7QzqWL6H/nz68oyfxkgcME2Lt9t4mjsN270bRK8P2PfKzAKOptPLHyBCto//preHu2yI/PM/k2Cy0xBe57fv+/h2CvHHKTsyq1iTdn58ayfoJl9lFnd4ajWbpb5EZsQLpyu66N+iCkV7G4vjRhURBBFXM8oZ3eanuGWENmcXAGMr4ND7AroHiqB8c+D6AqE93mdHhR8x8ziw49LiSB0icwQ0h/h8e5sD5ZcKvtamxpYp6HHHH+pmNbpNDwop8GOn2wCLwnEN2iDbYv25+XEdDxFXTPqA0k47N8VfR5rqbCqCn5rXBkGdC1FwZfTRwpefPmyLOY6nQNBeTXNX1jWBV/aEm1OnJvYRywEfKFZQRX0Usa34t1qvZEzrT5vTEUve0kduN4aVuuzoP3c9ApuraDtR2ke6iUQ6xJN0GAfBrV8m9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 03:50:13.4312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9129096a-a5a3-48ed-c955-08df395d90ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567

DEN0137 2.0-bet3 adds the RSI_VSMMU_GET_INFO command and replaces the old
RSI_VSMMU_ACTIVATE command with RSI_ARCH_DEV_ACTIVATE.

Add the command IDs, return codes, SMMUv3 device type, and helpers for both
commands.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/arm-rsi-cmds.h  | 29 +++++++++++++++++++++++++++++
 include/linux/arm-smccc-rsi.h | 20 ++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/arm-rsi-cmds.h b/include/linux/arm-rsi-cmds.h
index 3f7a6a833993b..a1836b19c1556 100644
--- a/include/linux/arm-rsi-cmds.h
+++ b/include/linux/arm-rsi-cmds.h
@@ -236,4 +236,33 @@ static inline unsigned long rsi_attestation_token_continue(phys_addr_t granule,
 	return res.a0;
 }
 
+static inline unsigned long rsi_vsmmu_get_info(phys_addr_t addr,
+					       phys_addr_t *top)
+{
+	struct arm_smccc_1_2_regs regs = {
+		.a0 = SMC_RSI_VSMMU_GET_INFO,
+		.a1 = addr,
+	};
+
+	arm_smccc_1_2_smc(&regs, &regs);
+	if (regs.a0 == RSI_SUCCESS && top)
+		*top = regs.a1;
+
+	return regs.a0;
+}
+
+static inline unsigned long rsi_arch_dev_activate(phys_addr_t base,
+						  unsigned long dev_type)
+{
+	struct arm_smccc_1_2_regs regs = {
+		.a0 = SMC_RSI_ARCH_DEV_ACTIVATE,
+		.a1 = base,
+		.a2 = dev_type,
+	};
+
+	arm_smccc_1_2_smc(&regs, &regs);
+
+	return regs.a0;
+}
+
 #endif /* __LINUX_ARM_RSI_CMDS_H_ */
diff --git a/include/linux/arm-smccc-rsi.h b/include/linux/arm-smccc-rsi.h
index cca881ddfdbab..fff0073622153 100644
--- a/include/linux/arm-smccc-rsi.h
+++ b/include/linux/arm-smccc-rsi.h
@@ -37,6 +37,7 @@
 #define RSI_ERROR_STATE		UL(2)
 #define RSI_INCOMPLETE		UL(3)
 #define RSI_ERROR_UNKNOWN	UL(4)
+#define RSI_ERROR_DEVICE	UL(5)
 
 #define SMC_RSI_FID(n)		ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,      \
 						   ARM_SMCCC_SMC_64,         \
@@ -190,4 +191,23 @@ struct realm_config {
  */
 #define SMC_RSI_HOST_CALL			SMC_RSI_FID(0x199)
 
+/*
+ * Get information about a VSMMU.
+ *
+ * arg1 == Base IPA of the VSMMU
+ * ret0 == Status / error
+ * ret1 == Top IPA of the VSMMU
+ */
+#define SMC_RSI_VSMMU_GET_INFO			SMC_RSI_FID(0x19A)
+
+#define RSI_ARCH_DEV_SMMUV3			UL(0)
+
+/*
+ * Activate an architectural device.
+ *
+ * arg1 == Base IPA of the architectural device
+ * arg2 == Architectural device type
+ * ret0 == Status / error
+ */
+#define SMC_RSI_ARCH_DEV_ACTIVATE		SMC_RSI_FID(0x19B)
 #endif /* __LINUX_ARM_SMCCC_RSI_H_ */
-- 
2.43.0

