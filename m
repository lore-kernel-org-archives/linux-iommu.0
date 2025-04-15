Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723C02749C7
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 04:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744693115; cv=fail; b=p+lQlu4LrmZLQb8nCc8hXAyHkvAdOkWgXcoU38XEEumdcp/R2/i8kIc0EHvlVnbWTKWc3LeAByn8uagbeini+UsPrEPvasZjx3ve6Z6Ucu7bAJvevE847N1i+nZTS9bPkppCj9lIWd7DepnHMJTgv+CpzkFGb8IRFhCn3LJ3hC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744693115; c=relaxed/simple;
	bh=eWV8PmbN6yhcZ6uLZHL9GwIUbcagzor8ATwfAYLlCbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXecicg0jlscnCLqOU2l4tcrptZg6FkAvxFasKm0U4qRiQo6vFi48ouier8yI/hp/rr92XcXO91zXigi717re26F69IuUXLq/9/NatGlchx3lzYlYHT5kYnrt71t5aUp2pg5JWq6DF2bZz/G+kbBlHONqMqFkAXDS6+zPDw0jKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QTcAJk3X; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QTcAJk3X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=keIzn/PHoSluQ0XZzQdsMfIk9ORsXwmgs/NHkJ2QzNIT3rbPBC4j6zlq5FztAlUoJ/YKjPcGVQ4kiAI5L/AEQaeWKkWcrrIeEQfAa63m4xvQdpREDJ8o+fCj+pyYjACPoe8my6jO/qQmlD3Up45AxTMjAVRGO2C2VidiKVVXYyeRHjdrqZxKlRCUUdXliFhs86r5I8TLo19hlt0P777gPUs5McEPWLr+xaqCiWUXFPNJivFvg0XCs5a0Ug9mGPBi0M45Qqsgks11NqbMn6Q5sYILIJ2QDc4zvMrIcRYJu7Yqy9YdFy6117ilb2L73rdobI+jv2cVrktWikKpv1p1Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GCqDJH1kkCEcAFWw9l9byvMiEmb80U+yERkuDuiHP8=;
 b=sS4xfqecuCWjAEJZPA72s3TFVpCdvoIGtp7hAKNc9cM0cRTu4bzdiXS65+g5Phe+MlRjKfn+oh8aQ3H61UZttZLX+W+n9Pn/hrLIUOz0hiVR87+st43OdgTp5yz7GfAUDbCSUw4letjSpwnDQEKmPhE1yfmn0rEm1Km1sMts/OHy1EQ/RhY2iJ9cJgAYYiHw2xYArSLWU/z+YiV0iln3XTTe+6+8SOzfcvGZpFFqmU/WT08pVAcmAPlIFuzQF6tYd/YdE5JpwlbbNC9KCut9bRvyX6fiCPoKTNEGy6SkziDGqtvGUfPwIGYw/lFiPDJbTl+x98FiHXRCOdkkNtdW6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GCqDJH1kkCEcAFWw9l9byvMiEmb80U+yERkuDuiHP8=;
 b=QTcAJk3Xw/uxG9NFbV3GwuJ3oSLtBThnKQFrxG3fZST/C08mBQAxCmxCmupTyzvltrTuQUmkTTmGzn7py7wIOkSdzyr3x6KTN41+J2lnb/N7r/sVQEKpYPJ1D8yTLYQoOCEVelFDQGV8mEdrZo+jdemJNUhY3E43hlYEqNQtBUOMmRUooJKaOl/J/RJz10zFLMINuSrP6AeywcpZNQyUbXPq1sOYvUneEx4ejgRuLg+6o0PiRAYUC98v8IcK+LXriFZtGB+JTjp+O9XJt06xFk4pwBsVTXSogRPBVJ2nvblKbEK05kTfZ5B2bkAdqQS/tPyNDkbYVeD0/iyxJuavCw==
Received: from BN9PR03CA0240.namprd03.prod.outlook.com (2603:10b6:408:f8::35)
 by IA0PR12MB8748.namprd12.prod.outlook.com (2603:10b6:208:482::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 04:58:28 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:408:f8:cafe::63) by BN9PR03CA0240.outlook.office365.com
 (2603:10b6:408:f8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Tue,
 15 Apr 2025 04:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 04:58:28 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Apr
 2025 21:58:14 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 14 Apr
 2025 21:58:13 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 14 Apr 2025 21:58:12 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <praan@google.com>,
	<nathan@kernel.org>, <yi.l.liu@intel.com>, <peterz@infradead.org>,
	<mshavit@google.com>, <jsnitsel@redhat.com>, <smostafa@google.com>,
	<jeff.johnson@oss.qualcomm.com>, <zhangzekun11@huawei.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 04/11] iommu/arm-smmu-v3: Add an inline arm_smmu_tlb_inv_vmid helper
Date: Mon, 14 Apr 2025 21:57:39 -0700
Message-ID: <95acc4e15f1bc6ee7f08635f5c68d7cea625acd2.1744692494.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1744692494.git.nicolinc@nvidia.com>
References: <cover.1744692494.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|IA0PR12MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 516ee6a9-8f8b-477a-e185-08dd7bda2957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700013|82310400026|3613699012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+VwbYETChGeoLtT6gRWUqwc6Femg7GVCNeFM3DPXQiw0icyAD76EDAaWCWbX?=
 =?us-ascii?Q?NaF0uAEhH/oqXO3YdZgeHSDJ5DX01mU7/p7WPG5Wl2hJ9lHaQ+GlGUdr3Nj8?=
 =?us-ascii?Q?STf7KisIL4jSGnvN3uWAYopv6W3Q6WYTbC66fJTDWOhq31U0pyCsUAnqXMiK?=
 =?us-ascii?Q?9iH/8KOvwUXeGp4u5qnhOD2JjPzg2zWAFSEMcx7RbQyGASrnnhMNsdasr8Ub?=
 =?us-ascii?Q?bPNG03AqlQu0L8ajj65+IOKLgXsooz3pc04h0WQZV8zCe993UTGoVDgdMcsP?=
 =?us-ascii?Q?ZxaogGISKEt/z0bMic5QZvwx+bv4xxIqCuYKOsV7tAuVeGQ1h6G3YGF/X+9d?=
 =?us-ascii?Q?j8UVHQ3S1G/d+5JCQu7X12vIcd2uPo8lRAORxtZ0MNyvEN386jLN5STADTfH?=
 =?us-ascii?Q?MQjubFZFXvKFNscd5vybQVZOWoWNBK9XVGS4qGZempvEve921Sh9UcjouiqJ?=
 =?us-ascii?Q?5cTHredtYiYTq7euk801g70RSuIjX+I2NhT12otqjPl4vav6hIkEIdZJg9lx?=
 =?us-ascii?Q?TRtqDK/2H8v6jy0MplpgaCpLqu6ZWBjaaGEwmeZjAYloH3lU+HQRIgJ2LSdh?=
 =?us-ascii?Q?t03XUAVD6yt6r0iwhKnqOlLMBFHp0Ele/al9RaeJ+jigq7XA4flqiWQXeYLA?=
 =?us-ascii?Q?YC5pvCsaKO4cNLAIf3/P0kpSLCLbbbS6/D3Z/RcgAGjG4G8dJ0qQBbkmPCPM?=
 =?us-ascii?Q?CEHAwd6Khf5F+quU5kzOvL2pm9VyhUWGOwmiYUwnD08VT0G+lmzD9NzHv8me?=
 =?us-ascii?Q?WLMN+Om85/y6geGc/l0RNYN6lS2Pj57tZz4BTefX02c5yewrIPqFb7oh4wqk?=
 =?us-ascii?Q?qyHuGrgRbwRAOnj2k9oVP4NYaUl5tpzZ0G4IR8VA1xx7nupKpy5zlPS1sL0e?=
 =?us-ascii?Q?NKwQhxcfLIsb4KhsfTnRgGmtvADICJqfaXk8tQkxFcEF8d3RtbX59q2A8GvR?=
 =?us-ascii?Q?3ZFzEKhzY1jCy3igxLkopIi1Xr72Wxr3n2BUbKmK2NHKiHHpKZEZdOaDfMRP?=
 =?us-ascii?Q?DW4yNsQ00ebEnmmnNDF+rbJymWaHxEy7VCFU9dhkDYf80D5YA/XF1/hwrxxl?=
 =?us-ascii?Q?nSLKrRKSKvQ2cIh+hxiib08z0fIhNG1xg9hKFwCz/ewQxuXS0iihXYukN0hD?=
 =?us-ascii?Q?R8L6MQ+fB2s2DXkjmvZqYR24qFcI3pZhYFsWQpZrSLGqMpqB04NltZqVtzq0?=
 =?us-ascii?Q?6o+uGcl2sCCVNimQNEahUj8rkFoAHZg8fJeOdSqiRk2H02M97P0ej/Qto1WJ?=
 =?us-ascii?Q?gxI7Ga1c4j/W2K0pA0dcnEVR+T+QoBfV8faqU6/M1c5S7LKdcnB1NN530nbP?=
 =?us-ascii?Q?vBYte1LvpYpZPPWEPvmSvky9wGKbn3Qf5p+6QZNxpyybmz0LnGNBRJWvfjGX?=
 =?us-ascii?Q?h9O/jVbwCh7+E6aKqjFgra53NJ2vK6AetoiTFps+1uFCJuA8IkhxE+S+O2CQ?=
 =?us-ascii?Q?+c+c4N35c2ZP+8BtikXIdEmtkg3Hm2hUB1ZVkgmhJPSeye2PvhHPVkZD+Ez8?=
 =?us-ascii?Q?fkHW2rjY8PVbz0JVtqYsDTYSjpBd3zGHH8z1s7+MZTG+M3mT2TcYzjri72PJ?=
 =?us-ascii?Q?eKPCkoMTcCv/y8C3NR4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700013)(82310400026)(3613699012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 04:58:28.1159
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 516ee6a9-8f8b-477a-e185-08dd7bda2957
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748

Both arm-smmu-v3 and arm-smmu-v3-iommufd will use this by passing in a vmid
from s2_cfg/vsmmu.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 10 ++++++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 10 +++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 4f3f4a40a755..2f8928971716 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1009,6 +1009,16 @@ void arm_smmu_cmdq_batch_add(struct arm_smmu_device *smmu,
 int arm_smmu_cmdq_batch_submit(struct arm_smmu_device *smmu,
 			       struct arm_smmu_cmdq_batch *cmds);
 
+static inline void arm_smmu_tlb_inv_vmid(struct arm_smmu_device *smmu, u16 vmid)
+{
+	struct arm_smmu_cmdq_ent cmd = {
+		.opcode = CMDQ_OP_TLBI_S12_VMALL,
+		.tlbi.vmid = vmid,
+	};
+
+	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
+}
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8ad249f7dcbf..bafe7c7c2769 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2247,7 +2247,6 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_cmdq_ent cmd;
 
 	/*
 	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
@@ -2256,13 +2255,10 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 	 * insertion to guarantee those are observed before the TLBI. Do be
 	 * careful, 007.
 	 */
-	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1)
 		arm_smmu_tlb_inv_asid(smmu, smmu_domain->cd.asid);
-	} else {
-		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
-		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
-		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
-	}
+	else
+		arm_smmu_tlb_inv_vmid(smmu, smmu_domain->s2_cfg.vmid);
 	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 }
 
-- 
2.43.0

