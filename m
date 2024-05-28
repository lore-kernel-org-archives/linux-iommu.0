Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DAB13C679
	for <iommu@lists.linux.dev>; Tue, 28 May 2024 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716883815; cv=fail; b=i0YibURvHH8g+etO+EvjAbu47PzOBO4l4iBBwzyWKwC9yw63VZxzVkZllVkBqlyGnrxhXaG6MgeOmklqPwc/ytZZR24KbEKLhtWbtEug/lXo1yV91LnO9LdnfUhd5/V9QxXHPYU2prwP4vvaNQi7GOQC0Dd6i4Ngnc3MR0r3XGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716883815; c=relaxed/simple;
	bh=xH5s7JvwsiYQLh5gUauFhjPvNmck7XmBLAzXmVrg8tE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZxDDIWgE15+iKkjb6WJj/AhNyb86Y7qE4FERHGldll1uOzmYsDJnTmeoDgqSRjK1TmSKXqKjAeyeMeSAuGqZavNOwJ70viUicHtO8amt+lPLPbkJ/sRn4W0VCmq3Sp1PbxToz7AynSQda3hJ8XBuL7eq8AxqtLcvHYPaJHlSUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hIH4CT+V; arc=fail smtp.client-ip=40.107.102.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hIH4CT+V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEPu80oP9DPePzJAbAvvEUIm/e7gg8PPsUwZ3eEOCjQKX50noiUSeHHyC6lbjWjY9NmUwp8oHq8raTXb4QO/AF+BA0ONd+Q3M2YT2hF1Lp8TtCksBz8lO7ErTK3TidvAevT0+C0M/o4tghziit9z3l04/Pgnw0jDLorNw2WDYEbnN1T6mlngnT1vOLzFnVN0CuIAvzj8bUqv+jDfeL5lN7XU7Y0dPWuPxlz5hNMrreJcCAKCoCb0ac1Owd4YzRA/eDb8PTlcyljh7h0EM2wfU5NKUwfnTO6W5Kukw7ro6H/jTtfJduC5xYSkd21qGnQkKMwAM00dN6nLEkINU9Xb9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMyP21saEB1xdQavsR2dcpHJX3F77VNVbvhPlP2ZKsA=;
 b=WYGdDIktgHeK4g5heNtDEGQGG4Jopf8PVmfH0sEdzOqZLYswkKCxDZDrYDbLWfB2E1PAxdAYEtulc3Spn/4JZnOkd2MIJuv0Vnm0YT6Kyms8Op4Bk/QokvGgd24T6ckUtKv9pIbfHioMe82Ih1thqFlxJ1sJ7FhPC3lm7nmc/Hm3gXdoXSDNtNRszfbcVzZLjKO02szqvjRM8SE/mZU7lZwJ7Bofgl60F6dZ3YA8nzKQLu8qkx7lmYwEY6SdVz4WqwmoVYCky0ss6KF0W92XJn7G/9Wng23kclrQDg0YFM+7TmUUcvuV5dpB8pdOcMsW5Mg60yYdUNPe9eIUVf+Nsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMyP21saEB1xdQavsR2dcpHJX3F77VNVbvhPlP2ZKsA=;
 b=hIH4CT+VipqDnW4sVEFRMGa+aXNE2VUVWaO6OLpm8fd7o6me6ufAITersJ0b9S86Pu3qB+go0neHHwFmWosihbwk9Rt2ANMqy/zGunzzGt00yJbZa0T+yZB3CnPXPISDPRJSrZD9njnHSyN+J4zkEf19/zLatb+Fn5UMhsClBRd7dZpeOTwrDm8MZGsTHZXKxIElsnBGmW6Ttd5gnWT7giJ36W3a8t9BgiYuLmJKnATYEhdrSwFDjHdZuUze1N6nJXvmIlyhQmLYDV6MgO9RuhyvTzeIbTLtzTzA7PdSeH1NQiROqPz/FpuOIZ94dUAGmg8Z1pWWyDTth4M/nabSsg==
Received: from CH5PR02CA0019.namprd02.prod.outlook.com (2603:10b6:610:1ed::12)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 08:10:11 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:610:1ed:cafe::1f) by CH5PR02CA0019.outlook.office365.com
 (2603:10b6:610:1ed::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17 via Frontend
 Transport; Tue, 28 May 2024 08:10:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7656.0 via Frontend Transport; Tue, 28 May 2024 08:10:11 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 28 May
 2024 01:10:02 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 28 May 2024 01:10:01 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 28 May 2024 01:10:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: [PATCH v8 4/6] iommu/arm-smmu-v3: Add CS_NONE quirk for CONFIG_TEGRA241_CMDQV
Date: Tue, 28 May 2024 01:09:52 -0700
Message-ID: <99f9adc6cee080feafd838bb8e4c77f2996e1e74.1716883239.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716883239.git.nicolinc@nvidia.com>
References: <cover.1716883239.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|BL1PR12MB5755:EE_
X-MS-Office365-Filtering-Correlation-Id: 9849bc2b-6e5b-4892-9779-08dc7eed98b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ZedCstUqmbat1KacSeuNtvtatTXEe3JObRLm3Snl6+p2TQX2Xt8le8B75T8?=
 =?us-ascii?Q?8VQOPwvEhRZZ53E5fwR3/2V2O3t1/tWK/0WYc/WodZJq/qw+fq1GXNgYzTG7?=
 =?us-ascii?Q?BE0ZXHpM4DorVSeZ+mYB/X3YEsMlKzIBVlZ+lMwQn5sBdh+kAk+e2MhJDMNU?=
 =?us-ascii?Q?b+kHwa9tV3JE02sJxAZrQ9nyubCq/xaHBCi0MxC8loVNuHSXJCKT9DWVQ8gW?=
 =?us-ascii?Q?5Cqfymxu4fDROba4nDwjUJOO4kawKO8FS3AIMaHYeKhy3SIWKfBzGsiRRIwA?=
 =?us-ascii?Q?etebN+vhly+fhPmsHdULdm4DXvM4/6c5E9csdorcGtKsqUmOY+zJzhAMZ6MG?=
 =?us-ascii?Q?U0NZM7/Bvw/gS7i5DMRjy+9qsTd3D7HyV2A/4pERYoBzc9KcnQv+xqxcVLw+?=
 =?us-ascii?Q?NzA3a1fCykzxVz+gcMOJYFcEo+dl7eOAzl/iO+zOoF1TcHUApJCLaUR7V7bK?=
 =?us-ascii?Q?7iI8GwiDapa1RClNyFbN0Ve364rpzl7tSggfpV6lIpJTeoV8nsJKB4QzOMiB?=
 =?us-ascii?Q?7w2TWUaHxv3/wkpEZ5PZ2CwwT9qo1xgReY+0KiKpHThs0Yhx8h7SmNLSwvSZ?=
 =?us-ascii?Q?PpFmw6bfBkUprZHvf2Vz8MwFnZQe7Cv+4MFmaij7zC1ptBQ88V9CCfuLMAXw?=
 =?us-ascii?Q?EztaRpuHu/lsM405ixvZDqmgtz/ac+cxbUHzZKxockuRCAi2p0vUCU088ble?=
 =?us-ascii?Q?XdrSPaKy0b67t5sGdg9hbcCjyEpx9sbPL0+yujsQtmo37KmajE7GHaPZnHgf?=
 =?us-ascii?Q?unhOYUTFECmbrpw1ugQNWbuKvZX2Hqik0X2LIL96fIxcHyCAkpl6EHDfoBgr?=
 =?us-ascii?Q?r/Q8hMu+PWAiZs4SOkDwLGBOPfDU9Ttw3oC2Il2p/XQX3V8NkGh2mS2as2Tp?=
 =?us-ascii?Q?1f2SFfizvXwF5dOMSV/lcL/m5sIlWW5MSAmonJa26OUU9ieH0e9hOUEjc4ud?=
 =?us-ascii?Q?PX0S8RFzHok3OcNgaLciuZQsvELGpUdn4uvysaQcfF01ADoGMFPh0yAKjQ6Q?=
 =?us-ascii?Q?08or7v9zAOVyVA9ZqyclUG7q5LHNcpBfEQ8UQXesnkgafdakOyGu8TyAjb+1?=
 =?us-ascii?Q?V5vrkg7A2I+9dtF/Z9zkx6f3s7geDM/larcM8MZoRMxL5laHegnvwBjCCUdm?=
 =?us-ascii?Q?QdeEk2xygpkRXxvhjwZm4ffccK1stkKDGd8BjXWR7+uaYWH/ZW9A6C9R/Yp0?=
 =?us-ascii?Q?g7fopaPPMajZ9t6EWhKApqkS2KQKB8/5SNpkB3lwtcWTehJMCXKo3RHOkKDT?=
 =?us-ascii?Q?t45+tZtGkX2tNDxEfcVuNpLi/HoFXMHLlL+AIA9PP9KoPWIt42EKniXU4727?=
 =?us-ascii?Q?+FJUbVILFCcYwz6qlXIq0tvihNmCtXpZrHEbjkDOgBvsat52qkcvdCGaMEmI?=
 =?us-ascii?Q?JmfK3TsA4KpZCI3gvDQDKcdDz/24?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 08:10:11.3191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9849bc2b-6e5b-4892-9779-08dc7eed98b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755

The CMDQV extension in NVIDIA Tegra241 SoC only supports CS_NONE in the
CS field of CMD_SYNC. Add a quirk flag to accommodate that.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 +++++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c864c634cd23..ba0e24d5ffbf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -345,6 +345,11 @@ static void arm_smmu_cmdq_build_sync_cmd(u64 *cmd, struct arm_smmu_device *smmu,
 		 FIELD_PREP(CMDQ_SYNC_0_MSH, ARM_SMMU_SH_ISH) |
 		 FIELD_PREP(CMDQ_SYNC_0_MSIATTR, ARM_SMMU_MEMATTR_OIWB);
 
+	if (q->quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY) {
+		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_NONE);
+		return;
+	}
+
 	if (!(smmu->options & ARM_SMMU_OPT_MSIPOLL)) {
 		cmd[0] |= FIELD_PREP(CMDQ_SYNC_0_CS, CMDQ_SYNC_0_CS_SEV);
 		return;
@@ -690,7 +695,8 @@ static int arm_smmu_cmdq_poll_until_sync(struct arm_smmu_device *smmu,
 					 struct arm_smmu_cmdq *cmdq,
 					 struct arm_smmu_ll_queue *llq)
 {
-	if (smmu->options & ARM_SMMU_OPT_MSIPOLL)
+	if (smmu->options & ARM_SMMU_OPT_MSIPOLL &&
+	    !(cmdq->q.quirks & CMDQ_QUIRK_SYNC_CS_NONE_ONLY))
 		return __arm_smmu_cmdq_poll_until_msi(smmu, cmdq, llq);
 
 	return __arm_smmu_cmdq_poll_until_consumed(smmu, cmdq, llq);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 180c0b1e0658..01227c0de290 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -543,6 +543,9 @@ struct arm_smmu_queue {
 
 	u32 __iomem			*prod_reg;
 	u32 __iomem			*cons_reg;
+
+#define CMDQ_QUIRK_SYNC_CS_NONE_ONLY	BIT(0)	/* CMD_SYNC CS field supports CS_NONE only */
+	u32				quirks;
 };
 
 struct arm_smmu_queue_poll {
-- 
2.43.0

