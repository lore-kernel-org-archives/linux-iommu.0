Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794343854;
	b=bq24Eg7ueq70MPZ7CMirpDZM9436DCPAZ+SXwEHbU+vcphlY8P4w/bl2puyMqT8QYL7x
	 FGPK38MlN77WEG0KyGR2iorI75XcNEgV6jqhDdE2PCmj1XynKbuKd8CjDjhnUNoR81aXc
	 626csfEY4b7yj+pymhgIFH/QVYxBHYVh/DlJtUhnBiNrGMl73mCl2bszbsTnuKONFemz1
	 s/6duOpGfYvP1x5LDD8R9Aw19KYTcmbym1VTC6hSGkyGVpCA3dmzZ77ukPWGNkzYHAWhp
	 Qszn+C7m2x/Ao/hBl3ET9amGUGzRd1GMIjxGJEc3TwHHDA4jh6YPMreUM19pVJzJpLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343854;
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
	b=GazhssV3mEtPtS4Oj44gdswluq7tj4mGBWc4dLc37KqmrakyyAs7DczYG2jbAPpx5SUe
	 JuVUMdh+IiBQ/PgUBAmLqyKQQQMH0CAPnYT0MKaeAeD/c/qLve3+jVA6xHkqQSZjZfRIp
	 gQZySRK5fsiEMxkGLvglj+siXLIOjpHeB6Y30SsJCcGP7TWGNFveNhyrkkPZ3U0GttmYN
	 mutuspVfmWarjOq8QiPlHw3K+OHhHcLb6vGCRYs57lXCXBcbyaSlKNwiw09ogMfCGpvTw
	 aA2zWvqDogr5P1AWfvIoZLgjn1Gp+iMLT48Gb3KlU8lAW4G2OqKeGrQZHLHSPmX7qZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=STw2x4z5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.38
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013038.outbound.protection.outlook.com [40.93.196.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13036606A327;
	Tue, 10 Nov 2026 20:50:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13036606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=STw2x4z5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJNYEwQ/Vj+ujJX+/rCUx056F1ms9gQr8MV4iJGFmZW9a10/sDNY27vWv4DxcQFYNE0ZY89fejPy5AsUh8Vg/9UnwGPPGrIcLkukHpOEm5RnxNC44lhZh1oi1ok9U9dXlWWpt5BaGBX7shsCRL6rIsPXWCvsX9hLqBj+/O5rh3Tq66TtFePjf+FUMq6InQt4boP8U1nfFM6F2oYS1khgB4fW/1zw/DsOhgW3V8TXQOHJGRgRJZko90gNlDH+mQBfZxbBILAQvWOEdu+cbtH2BrMwNCadDj7R3jci1K/C/cuvMqkqzRueId0WMr0VFVD/wKxd9D6BQ0A/eHwGGKRcrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbsdfhqjFLljt1j9XKpzR14n5eX7CPQSs2eqVapLe3s=;
 b=ytC/PO7/aXUOH8XhL5uktEa2DfGE/W9jN1cFLI+FCWPpXZTs/Sknd4it6uNYk1DlRtiBrWvrPmg3LXbZ4GmLhkupF8rA6Mjr70FSjuS6SNpgPz3GJ5JGWCaBPzMEFl3dB8hNwMS9sJY2FZQ7m4HPpl8ED6L80jsgTSN0BO/6WD9EBr6nCatwQGOatNfuC7BSvhftchOMSDz7KVG1dAXc+zpjn8kH5r2sI4iPuFuI4M4bbfFlLqQ1PUVAntwzon5kZlx6HDWQOAJHYZFlGe61MYJeYjUAqbwgDWxrZ2lPKEB4iQBGVUAb5JgWPbsD+pxmQb7uJq4FH0TnQG48qJSKwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbsdfhqjFLljt1j9XKpzR14n5eX7CPQSs2eqVapLe3s=;
 b=STw2x4z5OPN9ZdkLb+jQeBun8I9nSMoMirCTy7pgyxO8nOwRiv7wejJJl1jylKKzJMZUbtA+THmxKKEoSJHba1XgW/+TVFj1HcpUmElZw7tVtBLpb5C2rpnUbnFbLlslcWKxBqw1+hccvUhGxHkCE1ryxbBg5ZPavWzLjTspHbzO67Vz+zfASjiQuQChl67265XggftJyTkZohcl3IomJ0uUBngaYk7O6iivZ3s4VmBgz1EC7BbAESzKeO/tz/U4OMriUCPCyPeCiYdAvsmJWhwKmLCcuF2xhFzTfAvUDqEOGaXpqxcTPpyx3WazqhBHqqsYXFbgaPSFPAFT/yv4fA==
Received: from BY3PR05CA0010.namprd05.prod.outlook.com (2603:10b6:a03:254::15)
 by DS0PR12MB999290.namprd12.prod.outlook.com (2603:10b6:8:424::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 20:50:49 +0000
Received: from PH4PEPF0000B610.namprd21.prod.outlook.com
 (2603:10b6:a03:254:cafe::3f) by BY3PR05CA0010.outlook.office365.com
 (2603:10b6:a03:254::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 20:50:48 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 PH4PEPF0000B610.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Tue, 10 Nov 2026 20:50:48 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 12:50:28 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 10 Nov
 2026 12:50:28 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Tue, 10 Nov 2026 12:50:27 -0800
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
Subject: [PATCH v3 1/7] firmware: arm_rmm: Add VSMMU commands and fields
Date: Tue, 10 Nov 2026 12:50:06 -0800
Message-ID: <efc402ba59961b271c2d7ce26f3b91d717f7392d.1794343501.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794343501.git.nicolinc@nvidia.com>
References: <cover.1794343501.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B610:EE_|DS0PR12MB999290:EE_
X-MS-Office365-Filtering-Correlation-Id: 599a366f-e750-4b14-1edd-08df3f6c4cd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|23010399003|376014|82310400026|1800799024|260925022911599003|260925021911599003|260925021311599003|56012099006|261021135927099003|11063799006|261021121427099003|261022113327099003|261102123227099003|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	2mJMRXFRm8/1tiigNYOGrcsafo2YHfTdCXZ5di0QkD1VRNlq4xQQrofFQduR1f7yDg3CdSxD0f+OiLTc4H+Uqx/qlB4YTPO00BlTFH0eDDXPpgKGllTjoSJisop95IfT8SNOFJdUPan91lUcnse1FCnTms59mF5YmvKRhNHnqELmGTrfyshI/GG1r5FIa4a6YBYd/6DE87+KPaHNioIZQzXdOY2/gl/dM5fevTxQiYMLq2v7dON7ruOkm7+rnxrWPGenWdSVUZODJwkdKCbU0SrkwBvzNBYz5ChbjXTwc8gq9yrhERjTFMjtrjdMUjdVHbLvWR0nw81AQHLJjXMC093KUgf0JqAiq04Khx98mZDhHY9ZxHox/bC4E/wAzEmSB4DKruH1kkeHJi0b14KyDuRdrX35FolOBdHp+qlTS+DIOR2Ks5Exf0s2Cz8LHMr7lkleSNkA+iO7xKeBriQdm095qExcWurYZj5CigHVmrAegtl0bKxxkcunlJTV8vYwjDFpgKRGWxv4lxVwCejVb78VhYMLyPje/SkEZ/K8CHoryt29puyzZHW+392dhEkY21pGT64ARZC7shC6pturoE1VzgM+7oURBbKR4yV5/f01OKX1HZhU6ohuebJnJcCrw/KlpwBWlODkYymovKzS0+XAU22ORVOzVkynNY6VWnRKd5c8OQnsZqgIjQDXbgqbhS+/CQIql7Hvk+ATCkRVfw==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(23010399003)(376014)(82310400026)(1800799024)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(261021135927099003)(11063799006)(261021121427099003)(261022113327099003)(261102123227099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jC7/ynIt+d3PxJTVezpJw9MBpmjCZYs9bslsHMl+ytZ5afCjES5XcKKt8Mtf0n3nH9PF3+406mky3jb1xkypF4Qy2hzrb/FZIdrz/RWYbahUuAVyrLfOTk3PrsDl85+ZhydN62qzjokWd4WGsOIbGIRhDXPiXMyoiwmrsMVzXtl9V/2lWXerHZnIxJ3VIlP8netdgoQIIPPKnCRiAfL45oMuIdsDMaF1fgFoVuIncuYdskPxnZ6zMirKj+8+GA4RPEdCcBp1fLkCNinDEUZHef5fLjT6Pi17fYMW3fZIZtwJlMztz4HxmvY+m6vYA7vmjZgKfxGy1HZ8aB2xbxxOrEFSkQMV3ZVAdSS2tHQkWDbfTH5XI5NJpmKlNek+4pIJquDhhsw9G7mLLIly+OrL87I4eHqRk9sV1J2s5f+dYQefif+OofDQroPTfiASRnPx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 20:50:48.7278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 599a366f-e750-4b14-1edd-08df3f6c4cd9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH4PEPF0000B610.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999290

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

