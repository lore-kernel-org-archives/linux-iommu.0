Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794943338;
	b=uI8Nh/aSl0/G7bbeOIWtO/CC6txXBOjjtcxNQwDJq2boDCOXiniDUlUL21ml0F07IAxL
	 EkAgu4iVk2raRHmXNNdMUcDQmfZfWtHJ2c467b0/5HS8QcHvqvP1ES17gFFB9sPPPthEw
	 im7nW9L/r9WMYXitmVt6uteFDby5wantC7ZqESmnZO3rZcIxeV0V/fLqsIiDyWwEeGjI0
	 b6DnF8u4Wu9NWDriBnTnSityfGa8RypO673WVhsqKIqJhOP5163ZrN7Q7/xPdAksSj0sF
	 HaYcetXLDD2WaH40rSD0PaVJiJUbwMX7dgvP6PkP62uXI8M9O0JVtm4WftYFtpbc4xQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794943338;
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
	bh=NoaRM77SkpGQSLTsXAkslK7Qes05iRGHMTNuptGOVrc=;
	b=NP7US/M8JtoAzlxRlFiALIGXZcAk0eSJLxALxUbdqs7vJ+YfVlSVb/2/7XmlPBta3rKQ
	 qGeJw8yDyellnlpp5DY1aqPsVR1fJQCnN1diKkpZpQ0pkB49q2EqtHiBsmWafp0XNESeu
	 ih4/ZjUXd/xGJGdl+5FBU/W8i9CtwVNv955K7b7+Z7jy7OyS6xSy2pdaieTAvggAwJc45
	 pTGo0L6N/SzgKaXKdaqM8uu5LFqiKqi9YrRfeze21j2SSnr4p51a1GDH/a0z3CG5r+ZFA
	 CNCz7jJdHKjvDpDdFkYsGrXp9t0m1ZTLSNhPIEOXVRB69yUMKE3TR8cPfjBx1sQtjyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rmIny4Pp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.67
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013067.outbound.protection.outlook.com [40.93.196.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFC5606A89B
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 19:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFFC5606A89B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rmIny4Pp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGG0RNUrg3ULU5yOgzQeoao3BjZ3D23FT/rDY93hCauW3z2gl9Qvdw4YEa6j6F7ZW68v/PxAnM4YDG/x/Qo+I5Ct7YtI0/eSPYPB4hsMeQODhfQJreDPE7+4ka1isS8FG9uUPJjVfVMpUq1Pbj3dvTfY7oX3V8YvJfxle3NYYbVaObTPy/o5XKJestbAK0gyafem0naR0ePl/Yrxin+aBe3PrpJIJ5h7oYYnRNR8vw30nKJt6UiPx0fGGaTnn12F0wdOx6Q6LFfi48pGDH6allikuRv/OCahSmvHqwXW+g9+bzhNPebW7c1vQnDXxTFzFJphDGy4h2RFYQ4aUYDyxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoaRM77SkpGQSLTsXAkslK7Qes05iRGHMTNuptGOVrc=;
 b=eBhPv91IPDcEndD5iUy2lLvPCllfGBumlUCgfL/yMqJMB3aeux8SMmxxMB7LaIyb0sZacuZQJ77xzuWXwll0OiTwCZGY+v7hADhTBoQSDGgHZCVeYXZrDziIHCKqIC5Q9jZiTPkrMMIvzeThnS6cDoGokjdIPm4PfE0qPuj8kqrvxCijAo57Eyqz27VBKht5d8vuRKZBeSOi4K27QC8rWhnIpP3IHhVdV+nUAh/1iU1HEtgaUNT1x11MTux1KfxbIXIMsjL0umnGSFys2lyCnKrRJMRFJazj7Fj8uKh2E8V0hGVM6STydyRi+xU6NpXUKz0KKUrYnEgRBnQrzafccw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoaRM77SkpGQSLTsXAkslK7Qes05iRGHMTNuptGOVrc=;
 b=rmIny4Ppk4/kdaN8HG6KkKQOBx16k/MqKU2pjMtlo79SHHw9hpfIb1lOKSP8yHILehwuodO+4mCcGQKOd/KHP964e3NY1yzlVm7U2pxXp1Qm0m2Fh7yho9EKSnfQQnte0BlzimTazOD8A9VlOmAfgYSgaHcqhmq1QBH7XrxlB6d2sfOLhyje29vgfd+NG26LWzSpvRzYyjsYVAdi7VxxfU8nxoZ3mA0d+YCi49EwRmDwle8MleDVHW5xXvlTGQt7ZFUhnxhm/0+cOUkyMo9tuh9uHD7ONeQGubUibBF0JNbhOmle8tB2CmSMO+9pxO5R2iLKdGaHcAoxSHHTwuJ0gA==
Received: from MN0P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::25)
 by SA1PR12MB6917.namprd12.prod.outlook.com (2603:10b6:806:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:21:59 +0000
Received: from BN7PEPF00000096.namprd03.prod.outlook.com
 (2603:10b6:208:52e:cafe::24) by MN0P220CA0007.outlook.office365.com
 (2603:10b6:208:52e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 19:21:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN7PEPF00000096.mail.protection.outlook.com (10.167.245.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 19:21:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Tue, 17 Nov
 2026 11:21:37 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 17 Nov 2026 11:21:36 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Tue, 17 Nov 2026 11:21:36 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <jgg@nvidia.com>
CC: <robin.murphy@arm.com>, <joro@8bytes.org>, <praan@google.com>,
	<kevin.tian@intel.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
	<xueshuai@linux.alibaba.com>, <john.garry@arm.com>
Subject: [PATCH v13 02/12] iommu/arm-smmu-v3: Init the vmid_map ida before the stream table setup
Date: Tue, 17 Nov 2026 11:21:19 -0800
Message-ID: <861ac68481df5de6f24913ed6dc94112a9ba1066.1794942324.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF00000096:EE_|SA1PR12MB6917:EE_
X-MS-Office365-Filtering-Correlation-Id: 1feb3d13-5f8e-4b3c-e7b4-08df44e00cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|23010399003|22082099003|18002099003|6133799003|261009223027099003|11063799006|56012099006|261102123227099003|261026121527099003|261026140227099003|10067099003|261021121427099003|261021135927099003|261021123027099003|261022105027099003|261022075727099003|261028144727099003;
X-Microsoft-Antispam-Message-Info:
	m1xGKiTDu1iYNjKBIoK2je4aRYc56yDcyoFESfnU2baUWQDdZ7o4nO7XHd+21F6X/PwpJ74UZV+D2armHzh0z1e06ipGYBNVCbTQe57KZI8jj3I3XpYe/ptBdMK+f4WfJGjJohhhDck31mDATrNc8yyW9/g7n/PXOko794KiSrCOz6Q9AB1Ed68W7jU+vatr+QiiLtwcNoPB8EWWLDcQp+9wvh9UNFZsQYsD6RX3bRSdqluXGZ6B5qQZfOnvxCUcIXkCCqlLggdb1+W0ANm/qIPBmDGvU5/52lZazOPahbLasfgrnOFUIraNVrDBNnABVgejdsJoB3ZIV2rx8j3RDpcaWJzrtXpeVv6MwXmdcQ2r52J4QTAV1GuYciHeG/X7xViC7DjtaJAcrn8EaFgkLF2+hnqiZvQaFNvkEPj5wN1RvPoDyJZ1KT+HoT5mgeGUxzzqjS3BrSE1R7hc1JdXnsXo+l7KyAzWtGbTUwjvGUlbxQtaFc0bNwkp2xs9UGlGqKfAJeZiLKEAKlLu9Li2Ptgt10/8GMjXI4oD5xHPKsSj+oBhElaZum2hrsRXJ+MNPUimJn/tPYNNRyXW09xmjlgx0mp9PpSYqeGQ/9yr6oYeq5HNuuf2aLGp7It73aPR45rDTXAaDbI+EhQ3xv/2YIhotKxxsVsphvLZC9LcTiCDn0+9VEhJT8GNOMlxk5SRMyigRDhXet3QziK0s0q9Jg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(261102123227099003)(261026121527099003)(261026140227099003)(10067099003)(261021121427099003)(261021135927099003)(261021123027099003)(261022105027099003)(261022075727099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q0JXaxnCQqrozpk1nby+cpP+F7J84p9awFe90Qiu/4sY7c+QKgBoxy+3yfhGCklw5EfUgACI8+6FF0K8JAtZK45jOJcZmy84pKsfEWsF/jFTcy5CaoBup9+y0uu8ghkVlGyNDLeQHuYUzskpggiK2qOx6leD5Plt6lFbOawm+79VatxbnE4xJqZlx1AjKikU23Vrzs0x8yxPnoajy45deKPIhON8UxZGEMgDFaluTngVx9k9MHar/IfY0UZ6xQSxgciRzC1aTaKtT/yDbpgA7KNn4OhSiS18ed5a98p2kfFXSyO9RL3lk1hb9xy90szf0m+iIGDAYjsUuzv29O7CwwzReHwrtAVvCvH1jkKJnNGEMEy/6Ewvw1h72DeIli1Ic8b/ROJI/vadUcw0Xb0ujpXzizSZ03Un9dp4s3HPhw5mg4O2ifnU3yNMt0xsAq9U
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:21:58.8520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1feb3d13-5f8e-4b3c-e7b4-08df44e00cf4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF00000096.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6917

The vmid_map ida is initialized after the stream table setup, along with
the devres action that destroys it.

An upcoming change will reserve the crashed kernel's in-use VMIDs in this
ida, from a kdump kernel's stream table adoption that runs in place of the
regular setup and returns early.

Move the ida_init() and its devres registration to the entry of the whole
function, so that the ida is ready by the time the adoption path runs.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: John Garry <john.garry@arm.com>
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

