Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012052.outbound.protection.outlook.com [52.101.43.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9713633D6F7
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049779; cv=fail; b=cSD7k8cmyab7bgMfKCssOr9+LjRWuNxkUro2A7bX7hkACnaDZ8ZfyFnqpqWMhG4UkwiTDYODK6HuBfyqMg9UfmmWBVL/Oix/xko/eZFWK11uwvEFtiN/4yGLB6gkHHxPCWDTBqt+/Cvp88zGQNDqpinPCQKKUKSsy5pdanU5Fg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049779; c=relaxed/simple;
	bh=1Ag/TbJcvAmGvTB5DGH1k3zDWZFeBofV4x9Tjhs9NT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KMxsDojQbfET8VHNty+T3O8AvJtv2/nwbo+QacfrebQawN0FNEngeO+7rrUK29voDN/6ehoonEXIcr79BMNaSdiCQgti6mxmhUMlkpGbpvzGZmcuDcAoaqnHiSZ5fFE30YkvXXFg5gQ3oSM6pN/wVkn7KtWjGUcZq7/ixy8u9NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HTjd0bp/; arc=fail smtp.client-ip=52.101.43.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HTjd0bp/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCiBYl3zBFI3hpNh3Eb0e55you3lBhlhrZjTnsoBHP85VS8epastqfruG26HM1Oj5Zo69L1Y7bsLYLe0w/Uyit12x6pugQULjFhuTU7MJZBUWxUNwG94Xz+D2rSr9awTCUaYjmTvZiYKQ/udnBTyXwy7wQGtxP+HsE+CDhSUyzD9lLqtKswstx/bgeWgy4GTtir7FQdEsIdDPKSFqx3W53/tbmT0r+eavWw+47QpH4zfs9kW1SVLssszRz645zbQW4ZlbDGqJaoVtVX7TeeOcry20KUQDQKLKnAabuxr59yQ+PaqkqVzBlblt9hnRahvGlvj9j10j3YPHD8WAwqvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XkbCccT08Zzu3yFIZ/Fy+ALf3D6jeJ0x7Zlws4wZNec=;
 b=cMVjAcfQV2VhON6PYfSLtgQHw0ztooyS28lMfGzeNdjj8ayneF1cXPC0TKefxeaNlBEcdRkw9/A2HW2r2NKDCm54pZ68WEnK07u9/MvRqjPwXlV6HTtEIl7kb2ea0My3Smjm+nP6AsIhwGAJHDkSXtdZUlTVj6LMwN8CG6HNaU2R+jqO4NYks7Yk9uGSOcf4NvDVBQGdaicjown2sWsVYo3JKG9b7ZEsZ2bEyP905qzedPrFV9HiN4VLtbB34oiEctg7JppISDqMVumt1sAgNiOQfKTumqAhX8jDoWT5CBn8C2wUwjrzgil3z/3kjbLDz5DFUFj7AKUMGB4bulKf8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XkbCccT08Zzu3yFIZ/Fy+ALf3D6jeJ0x7Zlws4wZNec=;
 b=HTjd0bp/l4vyOybCDZlV4YUabo9RzuU+X4d1QpqB8+PQnurLb2UjgMZFeWfCAxnD649bfM0ejOY7yUKqNuIXv0UbR1nw/4op4uTBPZXp7zDZxYJd72xdhmcj78KAXOLFB7dNO/khiKRnKMiJCqYemzw6JFNMY7sHruwkta1z7z0JtjNdVvMK/SEwBNtaenyVo0H2sQrebZocX6T4ncRKIOq2tGL2oS61vgEva6VZCCMclxBdFUWW+aVJYejtUl9HrxEjDJ7xInG+wj/kbYhqf3dopvP9S2fMqaFRsIlDhxDTxgMMQWIBY8Soq1gIYHirWNj2WdrZwXkdt1nhOLoQ2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY8PR12MB8243.namprd12.prod.outlook.com (2603:10b6:930:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Fri, 24 Apr
 2026 16:56:15 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9846.019; Fri, 24 Apr 2026
 16:56:14 +0000
Date: Fri, 24 Apr 2026 13:56:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	joro@8bytes.org, praan@google.com, baolu.lu@linux.intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v2 1/5] iommu/arm-smmu-v3: Add arm_smmu_adopt_strtab()
 for kdump
Message-ID: <20260424165613.GC3444440@nvidia.com>
References: <cover.1776286352.git.nicolinc@nvidia.com>
 <af5fb880e771bc31ba42644ae5570e1fa208217a.1776286352.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af5fb880e771bc31ba42644ae5570e1fa208217a.1776286352.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1P223CA0039.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::10) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY8PR12MB8243:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0483c5-01a0-469a-527d-08dea222651c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2T3Oo3nrISJi6kbXFwAOlQlGy8hfpHJaGFLPaFZThfdgZAoDZ27ksijRqtQHu3McWvy2dZVCiWFThuOjj9N9p4sI4HRTN0Q/7j6JFfKCOA5QvYaob+8YVIblnmAzjtlRwGTofGOiiEgK0o5l4rqNJ/Olpga9auCgjXwg0k9WNlrBySPsNhLDP65ZDiVEFJ+Zyu3fo04g694cWTllIRq145ZK9qwRGhZKPI6OO860A5+3V3W2dqq2HV6yGwS9uyep+XXo3yhfwNLLBLH9KbZTqkSQnV5bIOyMkuSHW+wV344PfHuagFJasbMVj0brViBr4N31KM2F697ilTApqROzNBwsXaz/jaC0xXFET88Nc71DG93rqbiZMvemQO9BqPIvzIg5gjOnunmeAdsSpvNyhlMLnkv1kEYsUPPW7lSxkzDPUGVG8xZDLYHR9ovNLdA1yBH2Jd/sRTCgucJ5RARWPYsXHNHDhn2lfouwmdXovWNdPQXqXxtSss62mtOLu9E+3Z9v2GZepvt+4DW+FA03ceJkJDk9PtogPCAaEQvcEIMb1GPGMSV7DFC81/UTK6q0y/YXgBQRLREuz3p3nf8rhREQmhAk5d6FV6O6rxj48deMEfGAHlC5Ci9cImGqh71eVC2gQw8vTLwPkHxC2HSsh/GZfMKFqJnvh3F6QBwyx5SEn/v4BWg+K0LB3InTb0Cf5Yqvnw/sAqUCOpyvklaVFscM5yFuYHbiA4y6ywujw5M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KMJNu9rcULx0XXgsbm5i3y/wWD3PABh2RBybsLvDPxvA19fHPYNU7GKuYdH8?=
 =?us-ascii?Q?mOpI8KhTWHW8dRTKAUqTEwLixYo3ZspYTNsfr8UX5PjmZyPLswFKPkhzeA0M?=
 =?us-ascii?Q?JoBZBFYOTXR07JNtLt+T3u44q7HTAgPcNaaWY7+JGlzxj1qqwU2q0vHxjNnB?=
 =?us-ascii?Q?En1+KA0TJbKlRJraNER5daUmGUwmwVlX1Z1xF76gMdSAA+icx91cfwGe9STU?=
 =?us-ascii?Q?pQRzPgBzlxOVd8zSXqbwbiv1nIyzJlMQfzOYo9S37p7coVS3fRqcP7hEIsNW?=
 =?us-ascii?Q?gdiNxOvuhUriWHfeBcO6ek+5qtg+LZ+ujusxi/AhaEufU/DriulR7kKjZpfa?=
 =?us-ascii?Q?y+GaLWPqeXOaBe+/7kAw3nQTy/tBYVAZeqWYvJWZFOM1xbFy43YMFRFyGeek?=
 =?us-ascii?Q?6viQYYUbadKu2Yu4UlnJxBB7TbVCuKvbRZpkbY2H83kQLg2zgMpCifbOnSoq?=
 =?us-ascii?Q?eqmBct712Hq/+zxROoqlDcO+1uDY3n4lZYJe+xNxNqaABUvZ0aRtYazebOf4?=
 =?us-ascii?Q?N+2rZImUYZ+T68zElfEmhN9Jy/ecYqgtq7Q/UWNgtf7PfnSM9vWDjyHgGzFQ?=
 =?us-ascii?Q?Tl6ntMI1xhIU3lIw1mAZ1XH1x1AG/3DdsP3xuYeqkMTrvunTjHTI+dPR4KUs?=
 =?us-ascii?Q?yHACcaOGbOzGxF+cLHXkKmMfxjKwKE/ETB73i9AWJKfY39RnYaEaAdlsG7Gk?=
 =?us-ascii?Q?HlO2pcs8VED8ijFAIPRp4y7SHgGNGd0OXeM2XIaZrt6oaeDHJ3HiC3mJOYD6?=
 =?us-ascii?Q?iiwJhEbww+C6DWBTpUum3ISbw0n/PB+Qez0nDMyhSFAFh3D86nDjL+ej6qcx?=
 =?us-ascii?Q?7AAOGn6NNFC/ZPUvgpYbnxH2FhcQRPPu9KoUbC6DwdsFQqDImxd4Wkhb/niD?=
 =?us-ascii?Q?4+gZ6gDm6XgBUk2E6Z6tDjbalSuTt0NB1wXlOhvs2KmNAUTU9w8ypYeFyCcd?=
 =?us-ascii?Q?+xMLkC+mPLFCRrCMl2fWLG+TXBqkAKZbiDmTUwyzaB3lR8RF7uRA1VLmnKwt?=
 =?us-ascii?Q?4LH46anRT34tpPQc6EjzDTmMWwSOXPg1bCA68qY5vXJJ79NaR4ax8mKsWZ81?=
 =?us-ascii?Q?VtDloC3T7tYHPnprKPpvPc7PBG3r6EaRuZ2MuA02uOHW7e7HMCITSzupTG7a?=
 =?us-ascii?Q?L05ghMYOjpdt8wiV0tY0703LNeZLW/arWQy49qsOeHh7GhJC6rdXnLIb7js5?=
 =?us-ascii?Q?EHr6veEd1/JGayMZA1BZbUNUzMoB+eYwhImxAqwuAKLKNw/Y0Ly7LxuNsOFK?=
 =?us-ascii?Q?hBtwcOrBigLQo3EmdtUadrFt0eY19/IjXzQoUjFcMvrn+zlDKRnkC4wNDEC5?=
 =?us-ascii?Q?qp2ht4rmBozgWoK3N7DoEyYAPKG1nv/uhzG9MnFwWZJJJkDAwPf8EN4S5Mfy?=
 =?us-ascii?Q?HoYz5JDHSbFEJHVqyqugrjel4rb72iQbTXsEZQ9yZCqm9CMPRjTL7XsIlFBf?=
 =?us-ascii?Q?NYKmzMBCG6WfEqcyQT/7dXKYS3NIJLDa/W5me4mKZ2paHpbMw6kx/LPNAKy5?=
 =?us-ascii?Q?k2ct7W2LRFOP0+3mJVDdDj2DSqu5SZmf3QeisUwK44BV2wFpe1FiNRx7xm0A?=
 =?us-ascii?Q?HDXSLaxBJRyfDBICZjS+oYnjO4SMTeD5VaTb2gLGw+p9vwXGbng4XASCV1W6?=
 =?us-ascii?Q?KdjX4IGt3iNrB8yL1i+X0IbLNycH5yhZQJ/g0aCMdkvzYiX5KFhH1Aj+1P4Y?=
 =?us-ascii?Q?hjJP7f5bqvlS3i1CUOEvIOyGADcVxwFoNY2JhHVDpaUxKIBa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0483c5-01a0-469a-527d-08dea222651c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 16:56:14.4257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCzoZL9W3Cv/luyarjWjCh9mfOZjbkl7m/UNm2Mj9g6pXbo/3Klw3d06jtdVdbpl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8243

On Wed, Apr 15, 2026 at 02:17:36PM -0700, Nicolin Chen wrote:
> +static int arm_smmu_adopt_strtab_2lvl(struct arm_smmu_device *smmu, u32 cfg_reg,
> +				      dma_addr_t dma)
> +{
> +	u32 log2size = FIELD_GET(STRTAB_BASE_CFG_LOG2SIZE, cfg_reg);
> +	u32 split = FIELD_GET(STRTAB_BASE_CFG_SPLIT, cfg_reg);
> +	struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
> +	u32 num_l1_ents;
> +	int i;
> +
> +	if (log2size < split) {
> +		dev_err(smmu->dev, "kdump: invalid log2size %u < split %u\n",
> +			log2size, split);
> +		return -EINVAL;
> +	}
> +
> +	if (split != STRTAB_SPLIT) {
> +		dev_err(smmu->dev,
> +			"kdump: unsupported STRTAB_SPLIT %u (expected %u)\n",
> +			split, STRTAB_SPLIT);
> +		return -EINVAL;
> +	}
> +
> +	num_l1_ents = 1 << (log2size - split);
> +	cfg->l2.l1_dma = dma;
> +	cfg->l2.num_l1_ents = num_l1_ents;
> +	cfg->l2.l1tab = devm_memremap(
> +		smmu->dev, dma, num_l1_ents * sizeof(struct arm_smmu_strtab_l1),
> +		MEMREMAP_WB);

WB shouldn't be unconditional? If the SMMU is working non-coherently
we need to map it NC. Same remark everwhere

Jason
