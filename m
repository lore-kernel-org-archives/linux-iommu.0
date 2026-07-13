Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D66A273D77
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 18:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783967109; cv=fail; b=laIUhFzKKdOkP8UQaAqzo0x8eBixKX/nrHQnhR/ZK8SwyKWfYSsnlJES06CvXdpzLfwv0oDdbBiCXsEk1hN7mqFOSG3+8AsYBJ/2pFLRA3o4bsAasguUqTPddbGD1iF1Bmc1kJ6D6y0aLE0z1aRwQ414/md64SudA00QIbmwvro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783967109; c=relaxed/simple;
	bh=IQULhJOaQYV4b21LUgPfDBbxbKFxD2h7nM2ctIAuEZE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lk5fITg5I3WyOfFpqcklt+GQZ4XTjLw9RYqtonZs0NMyu1l2wIHJ/zp0acWahIAKIKLDnwAcVE9KsfqZXr7S+AS7HOGHJbt94P79dQrK6MOjjaNQuYMDbIM/f9N/aPx9+NkXvzkruaptI6OQDImVTErtpGfqnHuCrjaw5uV9e30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BzksnJhn; arc=fail smtp.client-ip=52.101.56.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BzksnJhn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXeLfCvRP3QMedywUnjLoTXzkoBrZIBhsgA6nJgFZ0lfCJvGNRM2mTqnjDqiLVfpNX5ZDfpqymEjLwAGUre7jpbTwnzbz0r7PnkiGnUHxSoEXyikhTHz+uOR7ERI24yeuxVfPhQRomL/qF0Oy+JKeWWHn5yu1s3E6obWaHP+XiZZzWi8k32Juklp2MR8ihMDWjXkqr74S/aDaelyAcctEgLHOjgv2D5xcUrn4dVXT8MgZ9SYTdUQbUkG521G/T2QDM+rRSDhqNraEM6FdQJ9AS/cceTlhSyIZVpCquI5ZzA9aFYHiAgYCxGVUAupP9vmurN1qLgbm3mr2XiY8EeaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmQMRHXU9VEHJytEp6REdkGxs52DuaILW9QwvlFa1Rk=;
 b=wLwfnxaeXVHg5ts3mV7wlQO7NhyjbZ9HBrYfa5z9b18XMzaCitIE98Qk0+HWUYoSUKsDquUjnLatibAz3GCSrnenOfUUeocwWmqNmOLnFjFzEYpndPxfb5s0kK89Gc487+oHe5VwA6Crj3dxqAQ10IFsdhKtgYo+uFFFceQp4FkhkMgC5cZqpl8wo8Cvdb3GAZuhyywUBPvmNCQ0c6LXYbJrgTZTwSM3LtRYYrFrvX6k261JOEjQHJQwNiO/13ViNNiRELWXAU/29Poc9jOIQRpOL8YJWwDUhOZkqS56T1MqT2YegkQoTKMSonxbwTe+kQZWL1pI+fi0yxYLVEfywA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmQMRHXU9VEHJytEp6REdkGxs52DuaILW9QwvlFa1Rk=;
 b=BzksnJhnAu+a4rSTNrmd6vZ1FlQW1FL2cO2ahpajVByqe6ER4iyRBvU61YKcOoqLuFMg4MrP6L0iQG/nP6IdoZHzGZOHF9Cv4snjvPnKQywE55yp0QMyCusKF5ZYUpKXoY+gAsW7WBn1nZ6395b8BZ3oPG2gWi99YEBDe6A4Ne+h5QqvYpLiIQdirWdiF/R2VLSBRxUEn499EZiSKIikwB2dNRi6VJho/XcpzWr6/3wef0wksFqL4O+Slwq+kuJq8/20tRarQHBvSnGLJpEzsVb2FEZF1UPPycOHIDSdXCbZS/ffNQr3ovqFI+g5o6l9zCiCGSiXxJdFdZdKS2FzaA==
Received: from SJ0PR03CA0117.namprd03.prod.outlook.com (2603:10b6:a03:333::32)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Mon, 13 Jul
 2026 18:25:00 +0000
Received: from SJ5PEPF000001D1.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::82) by SJ0PR03CA0117.outlook.office365.com
 (2603:10b6:a03:333::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 18:25:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001D1.mail.protection.outlook.com (10.167.242.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 18:24:59 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 11:24:39 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 11:24:38 -0700
Received: from nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Jul 2026 11:24:37 -0700
Date: Mon, 13 Jul 2026 11:24:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ashish Mhetre <amhetre@nvidia.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
	<skhan@linuxfoundation.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v6 2/3] iommu/arm-smmu-v3: Introduce CFGI/TLBI-repeat
 workaround infrastructure
Message-ID: <alUtYqO4HFOmVke5@nvidia.com>
References: <20260713111543.1462161-1-amhetre@nvidia.com>
 <20260713111543.1462161-3-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260713111543.1462161-3-amhetre@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D1:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d17381-28d1-40b9-b963-08dee10c0c87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|7416014|376014|22082099003|18002099003|6133799003|56012099006|11063799006|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info:
	onUS8FL5FdSwUatfKlJWDPZViNPt3vtAF5MgCxQ0zuotEqhAVmIgdYY/jPKal2TwoyeZ6KmqqXLEjS2kqip/ObP8RGC4hPzuWv65U8RTdzSRDcfE59kqho7fG4/Cg1SDDZpCLLbygdx3sjlRObu0BPw0jailo/v1p7mCkjTo404OxJLvFcbIvaclfORvVxFgZAS/Z+jw9WTIre/vr3jmhuHmwXq/LJqsVrNNvTgkUIKXFHasCYxAc+2ITQD80qjDw0N1S6W5kh3n1K+crwTvKddhd3AKs/eOdQQHbmthDeCaQ0p/kbDKo0IwWd/BbCaqanPNb5cVyIM5oTBOAKdRtvr7Ofc+vqS73Sek6c+Yyz36Gs26bBJ3FZOqUhT4YkZ1cSwTgTiF6kHt8S5MSwXL+zZ2nx4ZH4ypk4NmJIY9DoH+2q2IkB7QV9N/pqwRGMkV1uvojocFLBlHQaLWddRDaTnDR6FIDWh3ivelYR2h5x5u0Zdz3xqL11Xkp1gaN/zdKbXKDF+oOznY7vxcEgeGzjcJD8Cvnev5g3NFezxlX8KmIy24H3JGkvssQy40jR/VWFfvLmFSOfvVCqf7V6RdLTl9WGPjMkVF622lFUSyIecoDZ/l4ehOKcdg9gYFyWwI0KtP79oEvZQ1ccz2srbsUQ2q8HcPhGVupOKnd9Oi8PpR7K3Uabp8wzkXbvUYQ11xkA6Sk3BmMBsntourd/63SA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(4143699003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3iruRGlCwybYUeNZrhz0de6c6lWF9C/5syopf5GQFRcksSnhsZyRWU9MufFXTHnYvK1YUtKSEMYWP18oFfHfflk4uPrVdgiJK8St/yVdCPu9im9rRCVZ2xPv06DkLKnSnhmRhyc4DHjnPIstCTpwVktEeZyAcA7zsnVEHC1cwvCrwwEQGlc9e4mjTAy6T32SHL7fQYWeAaCTyhFs/AldFIt9ljxkVB48iIrL9EkTjb/OZ+L+TDbpahMcht5hiqSfgMZoe0+4YybthfSIqfWLc/3pLSdBcnfKwRWEfr5pdxz6rkpL/sdRGzDv4Ug+C0SeE0sCep0093UfFV500EBOfOpdegArVFkbCQMZKPZHINIcoC53OcQuikgnO+g5uw9awHTnjXaeP50NWgVS36vjYOpGjpiioaVmSHK0gkptTfVnCPCweQMwXn4bhlTllm8+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:24:59.8883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d17381-28d1-40b9-b963-08dee10c0c87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343

On Mon, Jul 13, 2026 at 11:15:41AM +0000, Ashish Mhetre wrote:
> Tegra264 SMMU instances need every CFGI/TLBI command sequence issued
> twice, with the second issue executing only after the first issue's
> CMD_SYNC has completed:
> 
>     TLBI/CFGI ... CMD_SYNC TLBI/CFGI ... CMD_SYNC
> 
> ATC_INV is not affected and must never be doubled.
> 
> Add arm_smmu_erratum_repeat_tlbi_cfgi_key and an
> arm_smmu_erratum_cmd_needs_repeating() helper that gates on the static
> key first and then range-checks the opcode (CFGI_STE .. ATC_INV), so
> subsequent changes wiring the workaround into the CMDQ submission and
> iommufd batching paths can share a single predicate.
> 
> Rename the existing arm_smmu_cmdq_issue_cmdlist() to
> __arm_smmu_cmdq_issue_cmdlist() and add a thin wrapper that re-issues
> the same cmdlist a second time when the predicate fires. Register the
> new condition with arm_smmu_cmdq_batch_force_sync() and add
> arm_vsmmu_can_batch_cmd() so iommufd batches split at every "needs
> repeating" transition.
> 
> No callers enable the static key yet, so there is no functional change.
> A subsequent change will enable the key on affected instances.

Maybe add a small note (better in patch-3).

Note: since guest-level VCMDQs issue commands directly to the HW, a guest
kernel enabling the cmdqv feature on NVIDIA Tegra264 must apply this WAR.

> Suggested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Some small issues; please fix:

> +static bool arm_vsmmu_can_batch_cmd(struct arm_smmu_device *smmu,
> +				    struct arm_vsmmu_invalidation_cmd *last,
> +				    struct arm_vsmmu_invalidation_cmd *next)

@smmu is unused here.

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index dd7475c50afc..eb8374cfce2a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -42,6 +42,14 @@ MODULE_PARM_DESC(disable_msipolling,
>  static const struct iommu_ops arm_smmu_ops;
>  static struct iommu_dirty_ops arm_smmu_dirty_ops;
>  
> +/*
> + * Repeat every {CFGI,TLBI};CMD_SYNC command sequence so that the second
> + * issue executes only after the first issue's CMD_SYNC has completed.
> + * Does not apply to ATC_INV. The key is global and is enabled from DT
> + * probe on affected hardware (currently Tegra264 only).
> + */
> +static DEFINE_STATIC_KEY_FALSE(arm_smmu_erratum_repeat_tlbi_cfgi_key);

Since we defined a static key, it would be better explicitly add:

#include <linux/jump_label.h>

> @@ -860,6 +900,11 @@ static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
>  	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
>  		return true;
>  
> +	/* See the description at arm_smmu_erratum_repeat_tlbi_cfgi_key */
> +	if (cmds->num == CMDQ_BATCH_ENTRIES &&
> +	    arm_smmu_erratum_cmd_needs_repeating(&cmds->cmds[0]))
> +		return true;

	/*
	 * See the description at arm_smmu_erratum_repeat_tlbi_cfgi_key. Batches
	 * never mix CFGI/TLBI with others, so checking cmds[0] alone is enough.
	 */

Nicolin
