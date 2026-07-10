Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011071.outbound.protection.outlook.com [52.101.57.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F4F36A373
	for <iommu@lists.linux.dev>; Fri, 10 Jul 2026 04:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783657264; cv=fail; b=CE3GxxSb8Bfct8z6gULDESagw1R+NMQIAsBqNbHSK0kmthURLBJ74dkllihBZi2xYF+Wf0GKLc3eWm09dt+2bAUP3U/wOStx275c9VCbAn/HgfmrAIWwp6WVEv25El1dmTVdue7yo3s2h95SuWwWwf552uYeKFrIye/hbguVHXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783657264; c=relaxed/simple;
	bh=pjfaOOa2tr3QKU0anz9XRPfM/m2XFL3YxLbHfhiKetQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMGicqhYG9BpLkT/UyDyGgTz/ugE8gmyyTFuz58ndK+QhDov8MfXLulVNLi7RIPeO2m1LnMTkasNJozvRbd/TQnu625SExWeSXQK7/BpP+MZB6lKWhbyIJZIrAWz4t9FiwYqB94LXg8O6hb7dXvAqBFvoH8fz7COk/q9UP+jbFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e8pIYjyq; arc=fail smtp.client-ip=52.101.57.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e8pIYjyq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGayrL7ch+Sb4JdYHbMTj5r4O1AzkIJ7kQh20LL2q59x3VA5xSuQFsBC1f7L8EFwEguTQEt9b3qpZRy6msNutt2hhyXL08OWCyw3ouXhVBCjllKH96QuMOJFNpaeEvsTbwq1ATPtB51otkiJCinlQWPV9woLtJRJeC6yDTUOG16gLfC60LGiBbm6EKSXJMvK9VAEtmjLB7BcgtGtbp37c++/Fn4AEXTq91PLza0H3noT51LzGhj/AQKmse1xjyKUKjK10oy9m/+xMZFpacOrP1TFTeqXjUgIzq+TS9V+gj7BzTGDWypa5r5FfxsxM8W6mzFFBJdf6yiBX6VbwnRP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=887ros/S9hMoJFvMg14+NEGM7fiCxEdEXnvNBCKYcEE=;
 b=Xn7by+zVlMoX/DJn4LGhxKUj3+CRMCxmhCbnnYuUFkL1qkr6U6EuJF0rQecUROG0tTPEKNKjq2g0RZo/FHk1umULeP60x3oGYbKqcE3I4+bAQg2ukJiWHc5DW2W3vXQ6F4LaWbQ9U0Pkjx6Wlc022LeoJ2ikT3TWhuapJ15whKtWfBfVTxo9Xy/Io3fHklzSzYKSiO+uwd1UATRgOVQQKP19iq3g1XczDvtpO45lvXWkAfmb8XKWAzzq8t50bbG2bo53ul8Y/RJAP2BHXbnTPg0HPCBXC/+xPEnWLOOWwNbguoxnvRjX1zZBSXyf2OsnkEMjfTtKlBcFPE3t/78JJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=887ros/S9hMoJFvMg14+NEGM7fiCxEdEXnvNBCKYcEE=;
 b=e8pIYjyq8dRWBeUG1moXSN6w8R4d2qSNCPz/zX7BkmRKG9j/JvIAyi2TbMbWFl/ik2+Ax4yWXV0pUlKQjPogHNCE+dxSyexeu6KoXbpLRGFWNTd8jEhTz9XJ0nJeE5stlrRqpP8g+aT5fDgBDh/Jhc58nK5r4zpE7/cjH7dF/LF1NPcOrK9tsGScH8eXQKwpnVDZPJ1jB12JMDW7f5nYNVIewIYN8Lhg7DxfH9gPUVkvPdzp70iFxdlRfVzk0T/mAjOpkQD7SVFjus73ZXO1I6tV5AgAn6B/ITlyLZOVVM3svLSYxpD2i0vdqhitMe65K3es3amToHALZpIc+LGcsQ==
Received: from BN9PR03CA0885.namprd03.prod.outlook.com (2603:10b6:408:13c::20)
 by PHXPR12MB999258.namprd12.prod.outlook.com (2603:10b6:510:3ca::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 04:20:58 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:13c:cafe::57) by BN9PR03CA0885.outlook.office365.com
 (2603:10b6:408:13c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Fri,
 10 Jul 2026 04:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 04:20:57 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Jul
 2026 21:20:35 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Jul
 2026 21:20:35 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Jul 2026 21:20:34 -0700
Date: Thu, 9 Jul 2026 21:20:32 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ashish Mhetre <amhetre@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, <linux-tegra@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/3] iommu/arm-smmu-v3: Introduce CFGI/TLBI-repeat
 workaround infrastructure
Message-ID: <alBzEGd3a2MQTpt5@nvidia.com>
References: <20260709095613.831769-1-amhetre@nvidia.com>
 <20260709095613.831769-2-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260709095613.831769-2-amhetre@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|PHXPR12MB999258:EE_
X-MS-Office365-Filtering-Correlation-Id: 8661b920-8cbd-4647-015a-08dede3aa419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|3023799007|4143699003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	xbYLKaNPYXaoavu+rejnBb+ng+9g1F0cT+ZP7r4+CVxeKNG2eKUPQdxkZv3cho60Svq/t0yWUA0pb5xlgy+bGSd4QQRNhI+46LtPiNsrnQ+HPNYXRyiDgBZH+ZnUBiQQODeQv42xHf0e2d8asnD6XzsMIhxdNVGTOKrgtg8mkBAwn13smr8pjHs0tLV55rKm/Nm2ZEAwTW57IljvUR4gBoxkfJ8vtmahoUhTNCaYa7eZalZBSwjlzJk1gs2kD8sASFvoRqwngBQP8kn5kHe+wCeWSVxkKI8nlI/dxgnBzCLIEvEHJyN3KLvNwMrIOrNn1KCYwiiW+Ah/qu/nr/bNiNvKCSgP8D1TYXFIN2xpHPCqv2lwgVNdKiWniyVhkZJq+jwcWL+DCUymR3SMj8YdQHIVKSBg+S7E2UK45hR9NYxBlGBSJpigatuF4uwqRKLcxPLxewqoe3TBlK212hTcB8Km31ug9N+oVcklExl1zcALtYUCR6NTt/DoYzCXYTm2YUN3BwLzf5Dxl6jT04bycF54Jwp0tq51XFs3W8x6EuJijAszf0ezEx8k40cCA3cLFtWDsspqp1BJrGyASfckPef00ahCS0mEUmnJb3fmGffZKQHFoR4zMrw8CQTf77jO+TKC1ULCTcLZhfXkrSk/57kj182US8Ih0UudN9XL1IWF9Xv15swwcqKDfl7hF3CgR5kMhIKonSXAdCX0o/8EmQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(3023799007)(4143699003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/PM0aNX0o7sctiefxVJvqbkJYRsOnNuyR23vsyR0C87vOejSOFzxyk+jO9WJ7VbfvGr/8wNQuZoeFVbjeLJlhu5iF5IUkkxTu557NbhuvXxd35j5lOtPzr9p7QIk41m6s2ti9WwYmuTb/Qs5dYSI9lnsC2zPu11dwkfQONyAEfem85cMsHgSDUDlKMZS427z9nFSZdio1uxn6f0vE7vXyViFFEEA/LH0rFHFknJMTv/sP1CyXhi7e88w6UAhmZfu6MKA1t91++MNACmxkOYvBTB3hoNe7+k3+XvnPWG+8j5VEYtW2yE7+QMcD1cQTRQclAKJpzinMdxxMfhWRjWhK3w0466PlURAbcOiZM/5ktCyoXDICBOqPlMIG9hXsp1p5LK5VOhFGcqVI7Iua9o961JakmaSa2Kj5TEW71732sQy+0uVtEnT11WIgQdslwsm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 04:20:57.3894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8661b920-8cbd-4647-015a-08dede3aa419
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR12MB999258

On Thu, Jul 09, 2026 at 09:56:08AM +0000, Ashish Mhetre wrote:
> No callers enable the static key yet, so this patch introduces no
> functional change. A subsequent change hooks the DT probe to enable
> the key on affected instances.

Nit: once a patch is merged, it's no longer a "patch" but "commit".

Instead,

No callers enable the static key yet, so there is no functional change. A
subsequent change will enable the key on affected instances.

> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 76efe479e80f..15b9d0170520 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -41,6 +41,7 @@ MODULE_PARM_DESC(disable_msipolling,
>  
>  static const struct iommu_ops arm_smmu_ops;
>  static struct iommu_dirty_ops arm_smmu_dirty_ops;
> +DEFINE_STATIC_KEY_FALSE(arm_smmu_erratum_repeat_tlbi_cfgi_key);

It's an erratum; it should have an inline description, like the
one you had at ARM_SMMU_OPT_TLBI_TWICE previously.

> +int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> +				struct arm_smmu_cmdq *cmdq,
> +				struct arm_smmu_cmd *cmds, int n,
> +				bool sync)
> +{
> +	int ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
> +
> +	/*
> +	 * arm_smmu_cmdq_batch_add_cmd_p() can flush its current batch
> +	 * with sync=true and n=0 (bare SYNC) when the next command is
> +	 * not supported by the batch's pre-selected cmdq, so the

After a second thought, this "supported" case is not reachable.

When a batch is init-ed, it's given an opcode (same as cmd[0]'s).

If an opcode is not supported, it's init-ed with smmu->cmdq that
must support all commands.

So, adding the !n is more like a defensive play. But the comments
here would be misleading.

> +	 * repeat path must not inspect cmds[0].
> +	 */
> +	if (!n || ret || !sync)
> +		return ret;
> +
> +	if (arm_smmu_erratum_cmd_needs_repeating(smmu, &cmds[0]))
> +		ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
> +
> +	return ret;
> +}
> +
>  static int arm_smmu_cmdq_issue_cmd_p(struct arm_smmu_device *smmu,
>  				     struct arm_smmu_cmd *cmd, bool sync)
>  {
> @@ -860,6 +883,11 @@ static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
>  	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
>  		return true;
>  
> +	/* See arm_smmu_erratum_cmd_needs_repeating() */
> +	if (cmds->num == CMDQ_BATCH_ENTRIES &&
> +	    arm_smmu_erratum_cmd_needs_repeating(smmu, &cmds->cmds[0]))

The comment above is useless; arm_smmu_erratum_cmd_needs_repeating
doesn't give any useful explanation either.

Like I suggested, add the missing piece of war description to the
arm_smmu_erratum_repeat_tlbi_cfgi_key at the top. Then,

	/* See the description at arm_smmu_erratum_repeat_tlbi_cfgi_key */

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -1211,6 +1212,20 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>  				struct arm_smmu_cmdq *cmdq,
>  				struct arm_smmu_cmd *cmds, int n,
>  				bool sync);
> +DECLARE_STATIC_KEY_FALSE(arm_smmu_erratum_repeat_tlbi_cfgi_key);
> +
> +static inline bool
> +arm_smmu_erratum_cmd_needs_repeating(struct arm_smmu_device *smmu,
> +				     struct arm_smmu_cmd *cmd)

smmu is unused.

> +{
> +	u8 opcode;
> +
> +	if (!static_branch_unlikely(&arm_smmu_erratum_repeat_tlbi_cfgi_key))
> +		return false;
> +
> +	opcode = FIELD_GET(CMDQ_0_OP, cmd->data[0]);
> +	return opcode >= CMDQ_OP_CFGI_STE && opcode < CMDQ_OP_ATC_INV;
> +}

Maybe move this to the first caller in arm-smmu-v3.c? Instead, add
its stub here, so we can drop that DECLARE_STATIC_KEY_FALSE. Then,
DEFINE_STATIC_KEY_FALSE will need a "static".

Nicolin
