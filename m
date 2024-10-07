Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537EA1D47D2
	for <iommu@lists.linux.dev>; Mon,  7 Oct 2024 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310682; cv=fail; b=WpgLDQHKEtG/kKgshHIuPYq/XK5J23I3eTS8lqHGl4eVwLm0ei/ErR52bM0Dyj3c88InHjTD8AEUNxCF4WEyZK5tu7ZHI1P6mBWmwx9CqxMLX9of/MD0DBerkO/RhxO77ziiQQkBxXr4ECWwzXp+wAhvNjxNLXlA2fLpNxXZPR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310682; c=relaxed/simple;
	bh=Pv4q3tqbynjM8wxGDSLdkWdfrtADkUqCOwPqqEH6nJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JiBQy1qgYjfQXTV0M/zFFnXPOoFd3MfRAiQ+SDPtH6+/D6/Mx9nlzN8hU8f7HZobWKdWZD0gHLEgpVJjU6fr90xqe7fgU+d69Q+efnSxixM7zBZ24EPbku+VgcfzP+t3IR8gODmr5VNH9nlwAHRjEfUqyw9f1s+HnF2aN1evY2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q/kgg16o; arc=fail smtp.client-ip=40.107.93.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q/kgg16o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZlA53Jf7TBFjYd1Hhws//kCgH7gEcY2lfpUWmdrzw5g9kSTrMGo6MXfQS60rYAD6U8DRPsgw51Vl+yM4t5c4GxjyT5UmOEs4fnmONc7co0kyttdjenT6PaTfBSiUgHQEpXrc/o6Dp9J1j7EJPh1YmrA9l/aTKbEoMe7izm5I5I7mxRYAo15vjlUff+Eh+ipB1sZz/huf0Ygq7rKg9Z/GAuHeW7IYD0r+plNapj4afHddsXeU4bUfj51BVAFiOC5Xx/Ls1+LDqZq3puZ49RjzO7kOjwb7E3BJ1hoMrFTsaThqIO9sqw806LAepWWOCNmZSL6LNjl88JW1c8RXxKB2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mng4UjfIxyWwNvhtloagYXSGhO9AxzCxxVq6abEiXaQ=;
 b=jXHTd5ixQhXFfOhDBUUomvc+hJdU14jpRiMb3qnOdGUQOwB8chG3eqD52YA2iP+Pdz3G8LbYJB9f0nneAv5OULGpUIgLChzwgb8kmv0cPAh6VCw1n7PT/fjYniJpkyhqlnJLDUGPRg82X6jZxkBBCD60wgt9twwbsf4Cj/xm5b0XcEBPQZ8LQ56IvlQNDjDMUXxcgJ+GWuxdpWvsKrkQ/A4gkjRO3a1af9URM6j9+25BD1DfexEUUsgfQpAwDIe2GA8hIZj9I6WZpmaBFifGsDnePC0GM3BxZu0kMdafb0MXTzVxpg+u/1uCLBnpqopUbtXvvUNXinTvEaLVe6yj3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mng4UjfIxyWwNvhtloagYXSGhO9AxzCxxVq6abEiXaQ=;
 b=Q/kgg16o2xIpfxjITQa97qYN/xiKemH+DjgMlV2I0tVzgarvrriRb8LM4i6O8U7eSyeN9XWuDrN1yVUuavpaEWxMwoU2boSCoiU0OINYQdSJ4BV9LPtb+m4YBR8kWW7qYR0KdYsptiIrJ4PrX28NTCsDsFmxyGh7d2zm6MpLWG1IM6MSyDe0ZKsgrif/06LMjPSifldgNuDcjvgxiahNv4CgIWfybac8OY8+zU4elROs52Fcne5swxjjZtgylfVv1y8GlSRHQhDKf9AVEd3aQ26HXLo5BbaWzOBWQw3UoaFFrWYtQ7MkIJhPNGSgBnFvksb16FjNZrSX4iSYyiNmxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 14:17:58 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 14:17:57 +0000
Date: Mon, 7 Oct 2024 11:17:56 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v5 3/6] iommu/amd: Modify set_dte_entry() to use 256-bit
 DTE helpers
Message-ID: <20241007141756.GR1365916@nvidia.com>
References: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
 <20241007041353.4756-4-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007041353.4756-4-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: MN0P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:52e::10) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e46b006-2b22-49d2-9804-08dce6dad7ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fsn1eP8UEOuNIswex1xhYtzN+QjOhJtcdmFhXq9dqMu0crz90RhZzpz5+A4+?=
 =?us-ascii?Q?ehN3uY3ty1SenjqMlFFIz0T0unQnCwoFy34oWYzzJIKOJIYUdu3tyq1Tn2IV?=
 =?us-ascii?Q?QmyzaVN/ytIA/D00CaWxj+/pcS6do1u4Kj4cDSafNWM6N5Y/z/IWpz8drIBb?=
 =?us-ascii?Q?wfdxvlPC+qRR2NoLokvncVYRPOTW1tmOtPYiij1miHPc5HtEb504z6tWKs+w?=
 =?us-ascii?Q?3n+TDKvmt2th0Lu/j1L4GCj7eWQ8jrm1Q6yjJmaAtyWGzfrGh2Z8yxBpaCum?=
 =?us-ascii?Q?+P9umv6ZCr684xZPT7IVg+6wHuy7HVMyiBccRd6pOHEmNO7itoq+2w8YhN88?=
 =?us-ascii?Q?iRAIRZpXYNM/7S8x9WqzMxyzH077TeAHz/pggTkFFpNTF1q7/qtx0jlwXf6j?=
 =?us-ascii?Q?xqeoifXTwVMorbxWdTUh8PJNAEbdhKby1BWEzc5iQOg/gxH2olOn6YIyLRQf?=
 =?us-ascii?Q?4/F9m3V4ORnrJaEWG2YWoTyo8AK0W16xU2EFdzvgMFR4dHqNLbDJHZtozNiv?=
 =?us-ascii?Q?H1sYGEtqphGHq0/Eznb+tV5oYBdClFmkrdccARpZ52Q18gG42Tl5RYkBG7GH?=
 =?us-ascii?Q?CXLh1hgz6Qom+dRxZpOfSsz35Zau8R8M3soa+G9sibwR2smQEh41mJrCHiWd?=
 =?us-ascii?Q?fqeyaHyNrqabiO/VsGVRbQga3Eef0EJdJRlBapMMOjYb0322S+bkUI3Tq5RJ?=
 =?us-ascii?Q?qerSggNHMKTSrNr0lY+Pl8cKNC7uF+SpNCG5+UWFUPqqeH8cQHZaQjcbVdKd?=
 =?us-ascii?Q?4c4ZejiRrmDHhFJ4HVo/pPPgoRowDDJT8+Jt/gidcEzzIrowJTOvxxMUbSnG?=
 =?us-ascii?Q?26docvyYH9jW+9FAqbxRo5KfjvhQq4ikAvBJ9KKOgrNMCxp9xa9QjMyPMhYT?=
 =?us-ascii?Q?DNsD5CP+Tr38pi0jm6Q3VTki/X/3LB4vr3r6aqW9NlpVGKUgdTdFUjSRk8Qw?=
 =?us-ascii?Q?/3p+QOekPCG/LhNr8zlHBMiUo4PVT8B7ogcdzUu74b+NCmaoVJxGHlBY4+TQ?=
 =?us-ascii?Q?j8McWpGN/ZlmVo7SeN7immdiyftz2/THyT2B5ghKdTUi6lg44AwwKW+7HFzt?=
 =?us-ascii?Q?f4qWCYDddvDCOKIq4shlBWcW2gTi9V06OjzOIIndCvzZHFE87SaUN29NDjDU?=
 =?us-ascii?Q?7HeusdUU6I1y23xJ7Tt+Fn6YJq4RHwJPcQxK8vWcWnVHpNnxWsVS+VbJKG0G?=
 =?us-ascii?Q?qrkQCd93LamwHVhkV+D9LtoOvUeYEKb+Hq/lw9lKeTdkSPD1QROLra2EtTBw?=
 =?us-ascii?Q?MbG88NkzHKUDj4VKB2Q6uoh0y6XoIztafGsa5pWQfA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3IN+FP1XfK+2TWfdvSV8rGWUhMAau+o1aUEBzh4ZTAlVEGRKtFh5EAohwCy/?=
 =?us-ascii?Q?zElqMbSGSmPNpghyrgdIEgnGM0VQV900whtl93tv1imBeN+wz+Fe4UZiMoEa?=
 =?us-ascii?Q?o4aCj30+AP0t52Q4Cr2c3QpbKVhzWQ1xgO5k3YfTiWySGdU/OE5mkeWVKxl/?=
 =?us-ascii?Q?NqTR/UeHZbigEdB67e/j0EtKltLgst7eia/KRPhj0AwAgfjqvxHRBmyzbtjY?=
 =?us-ascii?Q?FuJIPvv3+LAxYFYs8s59XClZwurt8CmNuI2q8bG5jQukIx9o5VFsxVeTrgA6?=
 =?us-ascii?Q?qx/X9fiQeJyYliw+leh7io/vPbOSXBgFdOCDR+atARyPtZduAhy5c0fax11E?=
 =?us-ascii?Q?LeuFOtl7JHATpvgfejZGVJooGA9g7mpgao4TTqeSySc/PFRWzls5jPyxbs0u?=
 =?us-ascii?Q?EQN43NcMCQ0EYPl+vg8nXLicOy8Pq+19/W8ceymiuk88KO3x0PmCNA0T3K3Q?=
 =?us-ascii?Q?S3NpqnS2RPKX9AycP9cl5q8OIg6wg50eK7XG/5EgzEDuFHwmEvsbmYa8luet?=
 =?us-ascii?Q?VhFONXNIIF3tpG2AHgglV1dflVZXlZq38VFkl6eR357daYGrmABFlvIN9Zq/?=
 =?us-ascii?Q?NdCGzWPsHJHbbwgzGoOg3vIoCSYHCQ9OJsOBhKZYJ4QYunCcPhJYBe6lFMVM?=
 =?us-ascii?Q?9MDrFZXQtgZ4wp0zq/TF9nTtAE2Repoz/Sx3r4UCTJm3xWrzNqdhaE43/mT0?=
 =?us-ascii?Q?V04kqrCpEoXksv4p9TBqNFp0OmloG/8IY6JtesAveFFYKulAb6iUIP0v/Bt6?=
 =?us-ascii?Q?tS3jC23ViDcwoTykG1DUVo1wlESKf63AvCg8s7geiMx0emGvSztW2gHmxACJ?=
 =?us-ascii?Q?SjL0v/oIC7+9F+CynhqMRyKx4n7HPYzhpU7RaHEQlpyErCQsE8ULUZ/r9tpN?=
 =?us-ascii?Q?Gxwtn1v8ZIfbYLoykrEnc9Egny4MzK2zHGsnxmJUAO4blDtb9vbii+xtVs65?=
 =?us-ascii?Q?3F8byZ4SpQHgtjJcXiBHMOxI79mAhx4i3TDotUM+9mH3tn899/9TIt7LfsCV?=
 =?us-ascii?Q?ascSaxEl9bhnI2sgnr1vxPxWy3CHTgsptPzpTe29QAeVN54+Q8mzABLu6Kl0?=
 =?us-ascii?Q?3R1JQY8FT1XEDKUWYR2tNiiuhal9XLBsUMZPgQwzA7aYlF4ERXXG0lPmlPpK?=
 =?us-ascii?Q?kJSjHHnMzHEiBy7gbtoeDWGtSfcX96+QKshdiK3pOs24O5yFz7OUWQqLjlo2?=
 =?us-ascii?Q?sNQdcO4IcZldrGpD73cV1MT5BFkqgEU6u6e2pW3R8Sr33ekEEiAuyOKdnI6Z?=
 =?us-ascii?Q?9XZWlpV3aZlf10ANza+Vw8H/59f8lIVVH+BeHv36Qd+glLx74CRE6zYswXPj?=
 =?us-ascii?Q?9fJLlsekSdF5uSulNEtSXS9OjX2rTOC+j3qBEctzBtahdOKFOcfe3Zrbh2HA?=
 =?us-ascii?Q?C6TXFeBTecW8EF534fgYwp/K5JTH4K2pIKj2yR9VT61w9REXxWtAAYhesmiz?=
 =?us-ascii?Q?V99Jx5B366d/JKZXY9HAs2Y3A+uK10ssSTeWLFjBC3JoC1KdGZ4VZSc/C9do?=
 =?us-ascii?Q?N3lbz82wDF4ApAGCSEJaUnFb9sgOoyXOzgxYOOVeR4RJeY8b7RhDZF+0FgPz?=
 =?us-ascii?Q?3bt2YNYrrfnFOo0LPyE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e46b006-2b22-49d2-9804-08dce6dad7ca
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 14:17:57.8714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: frGpm2aG8iDGsTSIwtW+A9newjTbbf+SZbuJekEV51Q828W54f2EpA2XQwm16Qm2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009

On Mon, Oct 07, 2024 at 04:13:50AM +0000, Suravee Suthikulpanit wrote:
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index deb19af48a3e..6fa2f5bb5156 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1956,90 +1956,114 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
>  	return ret;
>  }
>  
> +static void make_clear_dte(struct amd_iommu *iommu, struct dev_table_entry *dte,
> +			   struct dev_table_entry *new)
> +{
> +	new->data[0] = DTE_FLAG_V;
> +
> +	/* Apply erratum 63 */
> +	if (FIELD_GET(DTE_SYSMGT_MASK, dte->data[1]) == 0x01)
> +		new->data[0] |= BIT_ULL(DEV_ENTRY_IW);

Doesn't this need to be

/* Preserve set_dev_entry_from_acpi(), including erratum 64 */
new->data[1] |= dte->data[1] & DTE_SYSMGT_MASK;
if (FIELD_GET(DTE_SYSMGT_MASK, dte->data[1]) == 0x01)
   	new->data[0] |= BIT_ULL(DEV_ENTRY_IW);

And this has a significant security issue, we can't set IW here
because clear_dte must generate a blocked DTE, so TV=1,Mode=0,IW=1 is
not an OK setting!!

Jason
