Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793596789;
	b=2S2a9d5eMORkSB8wh/DLKuEwO+4Lh3zPBAGiakNIFMeTlFXP89D5tdbbKXiumOMl02xW
	 RP8osPYsNAfdNdXkJTvpdVyAi0R/BXJIys7DsMoWnNaw3EvjAjPPsh0cnYYWyxmaD24dB
	 Fmwn0YcyC9dMQRQhrQ2jmILrpLEh2XLD4ehLz4Eb1pI2XH34R0QmbFKBLvbdYoN0ifBPx
	 KYhYa+JKoUyPFA3wABbuOeukP8wCsIf/WLAROByqe/2nsRoYH82v6sH/WPlIL3cEA6H+q
	 smHwfTEBUrcHzpliX4XxgVTyuIlfMpJ91v8gGL6cWyjpU0QaRFEe2j+BcqPCQr3QJEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793596789;
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
	bh=Kv8ugP3uvx0dlOiIe/NDQwiGl8OmZ15QL6mg9S2sBKc=;
	b=TvwI7go+fJfV7MpgAeWPT5ha7E+PCgdlsuuDejdwvb9yfSQrH7KPReNMrcnVvgAisc74
	 11zBA0qLW8oP70czYZtvb/VycL98aRJ5xDEdAHS4ci0hdlnXyYoEL2B8CIQrL/L9aIYPv
	 1vjHLdjKMX9qxuiea8FdsQF+6xTu4eqNj1uSy+jxFq1euDShyQAi2syUep9Jdpwwv1R0k
	 rZyRaf8tJqiiH3uo9B3/yDWSWzsnyssqLyfeUuiRu/cdeuP/Zl6bni1logNa6FwOWTo6x
	 BvQxkkFU4WPCYw3c8DYnaesTt5eDy+CyKW69oKWmfkfnvRbpk4zrdwg/u/suwj5eiMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=G9GmSmO5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.42
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013042.outbound.protection.outlook.com [40.107.201.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F439606A33F
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 05:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F439606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=G9GmSmO5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Neaw8saJU5mM+icENOVdctSoW1wRdNAWQfif0GFhxzM2iaPuZ6c8WGZfOPGgLSfTHioC8h/9RZVEyTNHPJkcRI7bTdRvkiwbUgoTCAphgiKQY8LqQTgVuIX5aRlxUSLILlb/5tgvyLBvR7qb7p3uoJgkV0MuWtLrQRb7VsEXuZCVXDTrwjEtdcuQl3pXdVgKaQmQDKyP01DqBIB0O9R8vtHTOGYqdk8Cj7w2c+JvpMT8UNHpXlD0INrugDo17K/6SgvXvsP7b85aXFwn7TdV90N6dvj62xRGaGLQwcHHw16uRcVpjFbHkHtb7VWpYoIMJQsslD18+D7daj+oH6qypA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kv8ugP3uvx0dlOiIe/NDQwiGl8OmZ15QL6mg9S2sBKc=;
 b=IDWnkGVkvdENpa/V0jz5Bn43dbmGH2oueIJU4LyRMiP5XdGqwQesN+I9TmKZZKLmavw8V5GH4Uu2r/4iUJRY9DqrI1p/sR6LnNsyCtYop2EoxPxQ4lzkh8Qp4ckT90JYlJOwCJe25J6XoQDZYY3Am2Za/drWIa7OfTPWRQQN/03VtGDZFRvaYgE5D0ACaCWSCKBZZgLgyc7HK7NolDEXna2tHUzZRivjgY0pY4tN/ktRoz2Dg0dzX3h69ys77kOqSnL+ovAP0F/B3H4+Sti/EI0HRq8b18s3eStRA/YyeIfgXY2PiIVhTSjr1iSGRW8+lCWoirbjD4dsxMbHlKIllQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kv8ugP3uvx0dlOiIe/NDQwiGl8OmZ15QL6mg9S2sBKc=;
 b=G9GmSmO5Ifbrd5I5aaZbs/ZfxNWl7alwf5R0o0gs9hMDCV82rPPzmgWgOgi3RImoceMo3FHhc1OQ7Csl2FqKmtXq5Nyh8YSg05wYevCqj8LwGzVyKDst3ARiZNFb6OfZhKCsvlASI+TGm8Ug09IC7WFfg/lRmkEdeugVf1JEPl8jPN05WGKiG6EHSbdtMB6Uzg9vjHeEKbkKPC1W0pwYaPpMqkdfQngABkMMzgaUk39Y/GmhnneQOdsnR1/zLbLdIav3oSf8ueLTpFPUTTNFcbvc3p0iQt21dbkJrrmuL7imnaINqz+Y0OQol0Dsw4dPWZB3ie9CnVgSSZ+it78k1g==
Received: from SJ0PR05CA0085.namprd05.prod.outlook.com (2603:10b6:a03:332::30)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 05:19:43 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:332:cafe::8b) by SJ0PR05CA0085.outlook.office365.com
 (2603:10b6:a03:332::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Mon, 2
 Nov 2026 05:19:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Mon, 2 Nov 2026 05:19:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 21:19:31 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sun, 1 Nov
 2026 21:19:30 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Sun, 1 Nov 2026 21:19:29 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <praan@google.com>,
	<kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
	<xueshuai@linux.alibaba.com>, <john.garry@arm.com>
Subject: [PATCH v12 02/12] iommu/arm-smmu-v3: Init the vmid_map ida before the stream table setup
Date: Sun, 1 Nov 2026 21:19:10 -0800
Message-ID: <5c764fa56a42c0631101f2fb3741e6c010cdfdd3.1793593923.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|CH2PR12MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: a1a4cd70-37b4-421b-0739-08df38a0e726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|261009223027099003|261028144727099003|261021121427099003|261021123027099003|261021135927099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	8KUFi4f9iGgXdbWM1GhKc13HbkFdvi1j81JeDSUynkm+9C6Aj5x+QWVWpYun0ng16wIe+c1A0619aum6mVemtWb9aMi5Hj9SngX5Wv9ZkLCghWfZDY+nan7sSZV63ayKbNyaD/obyLcYjAvy/BfCZm+ih7CdzEg9wnm0fOZdov7LA+TuRNa3zHCgxqErmgHUrxNBSoLp5R8kzPyyzUFtyytpdHtQWw4zWBebr/rqv7lkBsNqRubb1AreEjsHgz8o5hqf6bPsi7RLWhbXEFV10DCJOaoaecU3cfyaRTSzKGz6X3uvi/kc+xh2Fllx/pTKRLAfu6OTwb7KoDHU/fzcaJLwxCE2W1FZM61hxVC1I3NLW3mNmewzu8tkgC9eoMry+iGp2eqpvkx4+wO9lYHapgZQFBnA6dnmgL/8iKdbchI05HNAEglvgPgggkTvtqqAh2Cl3Jbl20iXrLMwYYLxRC8ziPjH3tksVF0PkHGX0UAc0CZB0Rl1VNeYsIpd4aVDjQnrWiCf5R6TYJxz2zWrv2ZPC83gaSqxrZV+Gw0GJXhinYHPCUULGOT2hkhs1oJlaWllbgDUmXYSir5Zm/AlO096TeVJm9qPcpZg/MtVgY2ygOYKu65b1opgn+wdD1tzAQXsnLhOWOhl0biClQPIgo/M90BEYDj9BedNnzEEx+foE3JUejmTs/DBzvItsbPeS4uEff/QMJAqy/uszsgF2w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261009223027099003)(261028144727099003)(261021121427099003)(261021123027099003)(261021135927099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GRTLM23N3RIGpCHNov26p1vnCYSokJLVI3lTLv2xJ87Iu8KhvbSWEfmOft6pjVQkNQVfhlJf9j1Ngdr7fojefkQysLyHfkItdp3nRXCkXsDSO9NRe2JdyvDmtr0aAoPRP/dlD/sBwA9iCHdFFLRCWwCpZnkxNEiXW0QVaCQOqwU8j0/WdRod3DCkql/rzKEuvKrHa4CfGF3ukmxVxorRzN5Dms0tmQQER/B0JtZ7ydL6YLgB0ubxGMmxhXQyGEFXW8ZFVCbfQvXFgvqtmU/IPRYGFfkaslaRlMPBau08QvPWsO8ARw0/TiwI2/m9vzgcLqrLjB6Z2/s5AcFST+8gUKP6XI9Ba2VJIOFg+OgHkLoWA1/+icRgAl3vFcd0J0KmrTykel5w+k1ybX6qmQ1KpFXQS4shgRIAPw5pXNAEk8xmcfFNNZlsZSVOjMR25Omk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 05:19:43.3476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a4cd70-37b4-421b-0739-08df38a0e726
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200

The vmid_map ida is initialized after the stream table setup, along with
the devres action that destroys it.

An upcoming change will reserve the crashed kernel's in-use VMIDs in this
ida, from a kdump kernel's stream table adoption that runs in place of the
regular setup and returns early.

Move the ida_init() and its devres registration to the entry of the whole
function, so that the ida is ready by the time the adoption path runs.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Tested-by: Breno Leitao <leitao@kernel.org>
Tested-by: Cristian Prundeanu <cpru@amazon.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 6d4520c473086..5cabbe5652dc6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4842,17 +4842,17 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
 {
 	int ret;
 
+	ida_init(&smmu->vmid_map);
+	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_destroy_vmid_map,
+				       &smmu->vmid_map);
+	if (ret)
+		return ret;
+
 	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
 		ret = arm_smmu_init_strtab_2lvl(smmu);
 	else
 		ret = arm_smmu_init_strtab_linear(smmu);
-	if (ret)
-		return ret;
-
-	ida_init(&smmu->vmid_map);
-
-	return devm_add_action_or_reset(smmu->dev, arm_smmu_destroy_vmid_map,
-					&smmu->vmid_map);
+	return ret;
 }
 
 static int arm_smmu_init_structures(struct arm_smmu_device *smmu)
-- 
2.43.0

