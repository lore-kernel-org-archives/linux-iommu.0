Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA7531A061
	for <iommu@lists.linux.dev>; Wed, 24 Dec 2025 13:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766583824; cv=fail; b=BC0TaidHA2SsSCbvF97V5Cy4yUvcuf+vA4XZzYpkz2yQLGg//mK4+P9ereIdyxizsde2xDQeZ7wpnJX7rO6DSvP81bYYbjOTY6nE+X/dAfuQntDhlymy0HIng+EE9QmmTPnNC7WiAQ0OAWdUBNtuThvTgVFAe5FrNMh3GaqMZlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766583824; c=relaxed/simple;
	bh=7ubJvTwB8Imoh+BGBeNwFXVJiXSbKodDFW+QThqyv7o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXFRYBbJ4dCHULb5xZIJCdq41lXs8e0EyuQVIzeiHOyaGxuR+yay/a9yjMyRu1TTlvOft/ICjXtAgStNmw5GrynNUedZk/0Mh2jQNAa1BmSt4hlvfYpEtuzVRYIx/UalG+HVsbqGin1n36FXJCbiUF4h/LN+QxIWld4n+pIToT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GG7ME68M; arc=fail smtp.client-ip=52.101.85.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GG7ME68M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwKGSrc8SmwMyL+jVk+VikUeHFPfQ18HWJiP1IirTUime5pkGTGBMIMCBrWCB3rQl6ug3EUlj0tjoDu9IeeQYdMQCi/zRuDcwAeaAfC4JacXwQKMHuYmtAIyMzHm0R3XHF0OsEJN8aQu7anwrdxjtJcu0IMgXuonfFiUSM+ElJGIiH5T0BHpW/wh0p9VABMNTTr5Vd7LydwRzMinjp0Q4agCuHjZRPurw5/9Rg1DaICRkb9oP2DwxaPdVxOrh7RAwq9EFVtR/gSZzrQiqRbjvUiP2PMseAuuynFYNxUeVDDpp7V0HS2mxfEjbqd9H1e3dMeMzO8yRy4ubw0JLbhi0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OvZUeTQyCwxL9lZwmuhN4MQpLWhcByurNXsfPb2TKtU=;
 b=OXu+tjNud1vtTSgY09xttffGABZLO2MkKa/o9I9quHihjMfvJUYPG1Bwr8helN9lhP6lMoguwZnCIQTS2KfMKgL5n1uzP2MugT9kLBjf6nOu/NrkuzL5Rwh8pDqvEx5F3V7hXrfxLKCFNKWPKvohjb2Lcys8LtIl4EtGssjtKrM6VRoEhYQV80N7VmmYwx/zQXS8OCHlo5vFBENlhrS0tAFN9ldfQ+wM5KPc6CW/GpW20z2yeyys8LQWzpydrumNCi/gx1iZL2Ud7SpHpKOw8WV47JWGlHJvjGVEN+11S9fzPYgiM0fNKDy71UmoK/Ndo9/Y32oUc1m7PG+eBP86Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OvZUeTQyCwxL9lZwmuhN4MQpLWhcByurNXsfPb2TKtU=;
 b=GG7ME68M50/CjuDbp7Llna2Ojkg+K9J4ZtC48NmzfXt5M9N9tq9xG3Qnfr7SoS/AlKqvCgEeZ8KJiB7LyILYvXIdzIQkk5AHXU7sDOthDuA/TDlkl8oJNYEDdVzyPbsBc0FTgIlD3xsK+5YJPcvKfF6rFTo39UjY77fpG7BDvnA=
Received: from PH7P220CA0084.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::7)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 13:43:37 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:510:32c:cafe::cf) by PH7P220CA0084.outlook.office365.com
 (2603:10b6:510:32c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.11 via Frontend Transport; Wed,
 24 Dec 2025 13:43:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.0 via Frontend Transport; Wed, 24 Dec 2025 13:43:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 24 Dec
 2025 07:43:36 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 24 Dec
 2025 07:43:36 -0600
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 24 Dec 2025 07:43:33 -0600
Date: Wed, 24 Dec 2025 13:43:28 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Rakuram Eswaran <rakuram.e96@gmail.com>
CC: <joro@8bytes.org>, <will@kernel.org>, <suravee.suthikulpanit@amd.com>,
	<robin.murphy@arm.com>, <iommu@lists.linux.dev>, <dan.carpenter@linaro.org>,
	<lkp@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: Drop incorrect NULL check for iommu in
 alloc_irq_table()
Message-ID: <f6xrnx56thysevryr35bywkthidt3zvxb2zt4ry5ttp5jc4vfp@5ibfyv3672bg>
References: <20251222171009.44670-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251222171009.44670-1-rakuram.e96@gmail.com>
Received-SPF: None (SATLEXMB04.amd.com: Ankit.Soni@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 64134126-96a9-4bca-ded5-08de42f270ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I4UoFBGDCnGYIujs+FPkoUWLHeT+I/zBIYcc4cAA/vLpceslq/WUNfWO1aih?=
 =?us-ascii?Q?sQoNca90kRmyfn6VRY0rOxcNYzvwEnnlm4W1CwlceYJqIeBwNCXf8r0lfhXB?=
 =?us-ascii?Q?/vjrtLujcDTDlM1dy5Ol6E8EoX+lqK3EeHAqWwOmVBXgEnWJlfVuhZ3O/z5U?=
 =?us-ascii?Q?HHxniPP9cUpJaYDYFZu18TWwKfUSIR8io3Axi45a/6xuj7kBp8RLF71IZraG?=
 =?us-ascii?Q?T0sOpxi8TsAd2K7UajoOobJCLAj4xumPWreOx+rva4UJcn9NChjyhlCDVEMh?=
 =?us-ascii?Q?wVfAIWxhNB9EcTyaqQOrdFFjwy38WmKMImtRJ2scBd16VMVWazHSt7MIomBe?=
 =?us-ascii?Q?Bf5ZYB9gxp3yIqVdPuS4uSUKDSk8Vs321FKmA4//ToQciSVaqrq4OP2YA/d0?=
 =?us-ascii?Q?+PqaqFrXUbBM8tYkPupDnTlc+dzedZbdgImNesz2vHEaFuyWyIU0oY0i0n4R?=
 =?us-ascii?Q?Nf/hUnwnZNuyLZxg0BusDSu+MhshnWOQ2Dh2YCzlHfYR4NPnA6mfjVH0dbB7?=
 =?us-ascii?Q?SmodNm+QeY+8HJSTHYANyk9he3ZLwpoV9hPkk+9bQWDm8As4LUiGHTQs6OYt?=
 =?us-ascii?Q?y/+7OLEUKsphaH+oiBAjIyY3wxtniwsNS5ZmVzAxv9I0M6K5GCcC748dLz7p?=
 =?us-ascii?Q?/XOQKvUrZMIzYj+xeHybn/0o6Im8GfbreGwIkTVHuVxHhRr5RlUvNQBS1KtC?=
 =?us-ascii?Q?OhXcivakcltGKu96ldkU+IUlB9lrXEYSown8PWdMHw/GKTL5tr9vm+PEcwzt?=
 =?us-ascii?Q?AJrnoRadGVxyD0/pPq9QRUXXcPgf5c3BSnWxgJ67O53bhclCL5a54O1FK1hQ?=
 =?us-ascii?Q?eEUH0c+fvxumk8c6O7EDLPsmOLZHL2/16GL3vFx9RFLyAvEshUd9r1WWKnuh?=
 =?us-ascii?Q?CDjGz8a1nxphR7RNSnik2iiWe3TRAfFarUHdRHWwtz34MXMkj6J6Ns5msfbq?=
 =?us-ascii?Q?gjGYwxWgWcszUIbPO5fA4qLCUiJTULZFrQO4OoP6t3x+iUm0rR5BsSV4NIR6?=
 =?us-ascii?Q?rekfCEUvJ3QMVnaaV/Gr/GmXEI+gjxckySnovo48Gk3wjymQBLcChnegx+bE?=
 =?us-ascii?Q?mxoP+iy7Z8cPhL+2k4DGQ3hhiCp2WXco11XRqJ5yfr2n26MV2QHWvYv43q/i?=
 =?us-ascii?Q?MKPpl6bv13rkv8jELqeJsMtavOIlMhyelo1E91ZJEXvu5ouMRdvlYmc3huWD?=
 =?us-ascii?Q?LT299gdrEAe19U3UoUayH9vBpJARw77qMAfAveg1BO3gLDqXK2GcdLSxE39f?=
 =?us-ascii?Q?ejrofdo74W46RkijRjlTkae4EIGmm8l3efuN65S2cESTFi+GMfJYfCirYCnD?=
 =?us-ascii?Q?zVU8FXSJZ4rfZPXtAfIMqaouKCkNFXnBcj84oeJpt+5aib+QOiun5MwpnrYc?=
 =?us-ascii?Q?WvMBfUnvV0rX70zdyER+IUB/365Fhp+SwBamUdZVIs+qYsbpLIMcaPDio4b7?=
 =?us-ascii?Q?XJ2kk+jVNSCGKZPKE6CAg6mOYgZWWe/fv6nydYx5Ql/pm9Zf1GTL4pzshxgn?=
 =?us-ascii?Q?3XyCHZxksdaUIAziUvvaSailbykqDgvyprDPgtn5Dokb5MbD751D4bU15sN/?=
 =?us-ascii?Q?DSvjTn3xDEJOh/ot480=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 13:43:37.2412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64134126-96a9-4bca-ded5-08de42f270ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797

On Mon, Dec 22, 2025 at 10:40:08PM +0530, Rakuram Eswaran wrote:
> alloc_irq_table() contains a conditional check for a NULL iommu pointer
> when computing the NUMA node, but the function dereferences iommu
> in multiple places afterwards.
> 
> All callers ensure that a valid iommu pointer is passed in, and a NULL
> iommu is not expected by the current callers. Remove the incorrect
> NULL check to make the assumptions consistent and address the Smatch
> warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202512191724.meqJENXe-lkp@intel.com/
> Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>

Looks good to me.
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

> ---
> Testing note:
> Compile tested only.
> 
> Build and Analysis:
> This patch was compiled against the configuration file reported by
> 0day CI in the above link (config: x86_64-randconfig-r073-20251215)
> using gcc version 15.2.0 (Ubuntu 15.2.0-4ubuntu4).
> 
> Static analysis was performed with Smatch to ensure the reported warning
> no longer reproduces after applying this fix.
> 
> Command using for Smatch testing:
> ~/project/smatch/smatch_scripts/kchecker ./drivers/iommu/amd/iommu.c
> 
>  drivers/iommu/amd/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 075125f0f52b..611e3ccc93d1 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3240,7 +3240,7 @@ static struct irq_remap_table *alloc_irq_table(struct amd_iommu *iommu,
>  	struct irq_remap_table *new_table = NULL;
>  	struct amd_iommu_pci_seg *pci_seg;
>  	unsigned long flags;
> -	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
> +	int nid = iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
>  	u16 alias;
>  
>  	spin_lock_irqsave(&iommu_table_lock, flags);
> -- 
> 2.51.0
> 
