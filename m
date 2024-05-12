Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7031918E1C
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715529306; cv=fail; b=Q4xBklMAUJUYHMezCBcAshk827jYKKHyqJgbhUQkScSTBxhOUpRVOFKnuDIugLanAqlNAhZis6/JOBYowjUxwsF07Dzwyl07fXjP3GyKNP+GD1QfBXao76fvxdoH2Do3dbT8ThKWy6nsj6IdB8HCKhn2vMHa3yNTza4eVynj+xM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715529306; c=relaxed/simple;
	bh=hGek5JPwID0Q8uvUFSSvGUWjtoieDbN15D8DeYJWM2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UZnB4gMqI1SNReRk3VuMsf/hrOZS0O6RFQiLU5l4/ieiQFfNBXTs6HGz2pH8HvgrSjT6gPpbOXla7kGwjCdqBnMW3PtvpUYRK8/FfuB7GCWFOBRFzkmOt6MYEqdZ11HWpV+ZbRVxLvKlsYuDhXkPpcQmQLCIKB4W8IoBbWcWhdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rDRoY4Id; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rDRoY4Id"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amZdULF8Tk/zB4Ctxe7+Vg/YgGMYbFqy9Yn3YsMZcGZnDx4xA3h0l9FBT9vAuuy9bdE3WuTWtnsoa+sm9jzVpyzUzBVBbZnfaLOmv0xOcpCd+8S4hEMDv0Izax8OiN7k5w29UdpPar0FqExY5sXR3559lIsiBL6RDv9AKMU+5J2uqVr5sjNw+mu52zG4gCX2OKITs9BCxJvGX+R574QYEfLOGb6rZPXJ0sA/4ifI51CYBKbr/mhUfypH4bHKqNSZvZ3s8zn3Egf9I4FkYbcR0t7vl9dBGjzzcsib7S+UVydHVEl0FUJS0eDqMZc79SZVtG67AeB9gsCBwdZXXB2cQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiwIMmUzuDWhhO0d4XMSrE9saLc5NuUBEaYCSt4Jl1k=;
 b=GCio22TjvgbR/MtUUvIGpSERulnZN+4L8NoDF/BdUkKmQ2Ep8dgh30m3ucGqO6R7CvIAeIyRR0HXbMeJuNdZXOguijGrdE2iCev9EKyr03oNE/aXMwNwUUuchMLXfx4Q2yEMdZEBNRih05HdMq+URyh42OJc4WcU5R0b0WwFfzRvpmH0G+46oxh4PqUXAWbGzinXIpMnzqQPWOZoO0wLZqzIwalzkQ008AlTBaz3oloT3pC/8hgCzf8SMWPIaQmhv53p4rdV7d8IhJ0NYF41ekY8Ugd1CkCswlcut0kQg2wWpi7ULZCNiTL5ndXWL5rO8BKBYbtXqAyJivr9oiGSkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiwIMmUzuDWhhO0d4XMSrE9saLc5NuUBEaYCSt4Jl1k=;
 b=rDRoY4IdVW6K5YRFHOX4woapcCFATEv6V0epup/jO1AcetuWEB5bfDV6yCIuFzlWkmIugvUxOJxGfiZbFfkB7yw6A3FnZUcTUEPAdWrrk2y3FQnydOaahMpU4CSUV2SNCxuhR0PDbCHYqZPQbs2Yrk0yl3uFGG+pSGXn9HC47r6HaOmSQ06s9pbYdKO15cMGkEx26rCVzFuwNzWsic4WkcNW/KNK8UxFkGHutwyNvBAMOgQMPr9BH4DSASfKSt6BvT19cms31jgMI8CJ/HMM3h+PF0/XjngLHhHNSJTCDKzWP186I1OmspO9/PG2xIedKc8eCHpNRbLZNzBugRVy5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB5859.namprd12.prod.outlook.com (2603:10b6:208:37a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 15:54:59 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 15:54:59 +0000
Date: Sun, 12 May 2024 12:54:49 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 5/6] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <ZkDmSe5XPTbMb+q2@nvidia.com>
References: <cover.1715147377.git.nicolinc@nvidia.com>
 <9cf877a464c359b44e87b375bdf2962d2670f0e2.1715147377.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cf877a464c359b44e87b375bdf2962d2670f0e2.1715147377.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BYAPR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:40::43) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB5859:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f37406-50a5-4ace-d3bc-08dc729be05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C9HQmQd8rOnHB1wq25mgaqG8OQ1JxcNO81BBUs2VQdXTEWPoN+P8kcyv/3iU?=
 =?us-ascii?Q?xVcZlpC4t5UwuaZzLmZzZzyh3mvCWLgtMf1ceYqCy6YjXsowiBeMiE0T/QFJ?=
 =?us-ascii?Q?xyCGmuneen6EoIlv2Sla51ebMh8EdYveXorVgxShU2f3pld9gufe7rARKoLK?=
 =?us-ascii?Q?o9iDiHice4MoM6ZGwkmZ1csJH0tfHffuiKtZ9uRUr8quAJjXxdXrBNz1dctX?=
 =?us-ascii?Q?nOL0E84ocUakCbOldrLLM7FdFDqCUgeAwEl1lojdgPfm6a0PGj5N3UNwyHWq?=
 =?us-ascii?Q?4JnAWmP2O8yqIjPm77+RsvGftsxafZkajPNXnOadkko/suedk01zgdqFHjYO?=
 =?us-ascii?Q?hG5dostMJRYUg+RHUDsv+ZKJcSTVzhVffxsnH8nntkCrFTthscuVucLpXB9k?=
 =?us-ascii?Q?myg4JGCYZ/qMGq9FzMLpT5m/r3ULtvoMpRwbUm3tkN27cRe3jEq5q7pKfuLR?=
 =?us-ascii?Q?uxLtKU72ZGpdElPpQaw6WZie7kR182NrsNGWInCz8QdfMmtt/u0df1S6BZA5?=
 =?us-ascii?Q?mux3Gwv3xOfe4xeld1cvrI05zMfhzqm6aSFB6u36frda57pHJ7YY/aJlUAlS?=
 =?us-ascii?Q?VxSogNYYiJPieXzvbYckoYQ5cA8IjX+V1sdMdCig7s5ue2fUKJz08zB+c2Th?=
 =?us-ascii?Q?MT2E9Ls1I0ZQUwm5tY6kgxWiT+nwAb9NEZRwqbW8JFMHgQtdj1Ok14nDzyrF?=
 =?us-ascii?Q?J2XIahQ9UYX8lyX4GwVygOKz9K123MM/UD+5IM9x0lL0TGtGvWYyvcJzthMT?=
 =?us-ascii?Q?rBlKoAjN9RWNJ2Kxhxmf5mr4CTLid0bxSjLny7WJF0q+L29hnFCWzDBf2iSe?=
 =?us-ascii?Q?PxrLs2MsTvfQPAX2C3mfQyKlHs1MHdyDqcrDR5+BfZAUo9fz4ztvuifFCywH?=
 =?us-ascii?Q?/gt4SaBowlQIfh5ORe7Y0U0ZEnRZO4h4VJaa1UrmVKdlOjzjFLUvoNJrRQqt?=
 =?us-ascii?Q?9JQuQP1BaEirL4hO7X5NpmT50LJkVIUTLgElHSRfOQ4GVC93DLdrpBbP1PKq?=
 =?us-ascii?Q?Xm/H+PQUUYBfCwocSQ5C8k/wRBEcxRjd2ptBl/l0tWN28v641uZHBE4EAFXr?=
 =?us-ascii?Q?GjQDmqZOeJOweK695DrZ1f3F3gX8gXOZ/ShJYiDAWf2panOgsT1FZVaKXSSK?=
 =?us-ascii?Q?n3sXMr+vLhg46FPLRqC5fh98mD2Rb2NlTNK8s4xbJUEb+b8gicdAh0+UELbT?=
 =?us-ascii?Q?AVwo/ftC1g+AjlukzCguvLqsPX2Hx6u4THcXuyJYNDCPXS1WtKiYqSzFVeWv?=
 =?us-ascii?Q?FrGaVR/HHWJfiOXcerY/9WoGFiYMjJoYv5deY8lDaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C7pSxQwvtZqBf23Ot6oWoL2M1yJunh1pO9WQUNuatO4H4LjKvRCMN8BHgRQx?=
 =?us-ascii?Q?wsYmMM1uD1UgI4kOOZFXvofxlB5VZ427cRq4473K319XSCDzQJh+ll4eLpgn?=
 =?us-ascii?Q?tEIUicBeLukmTQLZT8RWlS0PcFCH7HHQL8g2wD/WIY/dlsXg+mXMs8FZfaJD?=
 =?us-ascii?Q?Fpu5Ipnawpvj1S7+mrSuOLGOqrr5A+e5ne205dCbl2Vr7Ra3xolT+Xg65umD?=
 =?us-ascii?Q?NN9YKNJ6QLhIV7EG85I3VytvDMPjOjYgaCTaz4MDFsSE58GyaSiI4k4/UVGA?=
 =?us-ascii?Q?OykU0ChBQIZaHHURET2BxQjSpZCCLjZPIO7auq8r4+WWWWHvIA7Joy8HEzNI?=
 =?us-ascii?Q?5pHSGXtbb3b2pjcWRZ9ZU2nIirR0nQlfadf4QyG72MTK8zv3k/K1iLEi2bRS?=
 =?us-ascii?Q?z29S+J8kp226AObEHp+5wci8K3DWFseTKV38OiqsOxRwdc2rEYUE6Voy5Uj6?=
 =?us-ascii?Q?6hf0arMX9B4sTt5LRMtfFQ1Djl0hnKpiBLFHiHTwRVwcYr1/5Vh4q6qziuVe?=
 =?us-ascii?Q?UjxuRKtKf/A9deYsuMeAIqSLtx46oc8SjAC2hGeXEw5VpyPg1VAlu6xw5r8l?=
 =?us-ascii?Q?5LvTutkPg8NW6kTsHIq0ybB3lwe8DAXFRwCC97ynG1n5SNLfQBI17JN66hkt?=
 =?us-ascii?Q?iHyMHOH0s/qo2dvQeWvXatH+yUZfSpUmxsI7t6OWxknkdfNf+LV4Dw0EVt5W?=
 =?us-ascii?Q?ky+6FzbnewEEoM2Czs+eTKwMZV+JUDGnYb0BYt14DKcwcmTt16VqcHVPJWoX?=
 =?us-ascii?Q?IQ3pw2whVqX8IwVDN4Xj/sXxNOq7ADR+9pSY6fEs5wO9sZ7o2yvmXcR13Pd2?=
 =?us-ascii?Q?g6ZCTyY+91cW++mJR98IB8t4AkObcvOeXU74Z9sqX3cgwuq220P0h8wep8/4?=
 =?us-ascii?Q?NqjCFynNoqb8QXuwRir6W3KJyx6pY1lnpEplEi2kmjTlLqnMhYXjmhpc/N/F?=
 =?us-ascii?Q?GRdCuQpmPbcAltafsSLs72ljYeYflrPEbAuFrsD8TbJaLLKX7j5albpIdzSr?=
 =?us-ascii?Q?oQ37grnV60c9X77Fo9utvuWkKN/B0oDFlWdNj6LAtyGkjsK159r54JoHhnTL?=
 =?us-ascii?Q?Wf1nRCGCvFvTw7gUUCONxdsk6f9npA/ucczT8nRMq3qkk4tUgyRVsJ7EzaOI?=
 =?us-ascii?Q?Crbv+/5k66u7LwZ2WhzSpzmFiVQIkHiSV3gq8WMBdNROa3TiX9TAPqw1MV/l?=
 =?us-ascii?Q?lIUOxz+tAH/hEQNlsZvtT74p69zbIwtSHQlN8zFLJYvqnCD59Hj6YIKbviuo?=
 =?us-ascii?Q?iQKxCyJfX9rqRZdgg+kF8i4eccVsa8z1bcGDihxEiDewXekgfA/0K/v3WisP?=
 =?us-ascii?Q?imO0BjsKIUx46IVRq/6rRusbx/RI/NPzwNPA01HYxmFFRihN1sa2/lnVdNdq?=
 =?us-ascii?Q?lJ4gNjo3NfDxzg6fMS45Rz/0+K8jxPgc1C4epgdFG3EhJ5r4GWgy6UzJDRef?=
 =?us-ascii?Q?AS8DcagZ3PtcjRmU43StieLYIuocdoymC1LDrd+WwJmzobpjyyzoN8oNTNRa?=
 =?us-ascii?Q?49mBvdyRhCfG/NFnLWsaDuOvCn5j6dzodhR06p4Xepu2fjagaf+A/OZIzWnu?=
 =?us-ascii?Q?eYM7AYdQtzNVaMOgxCpLqHpITHW7V6TrSqds1G0a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f37406-50a5-4ace-d3bc-08dc729be05d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 15:54:59.0667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cSsziKbiFLB8hTmy73fTIPzkWGlO7ukPXsJYSN0CAlhpwfUrBLvR1/f+xmMA6ugG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5859

On Tue, May 07, 2024 at 10:56:53PM -0700, Nicolin Chen wrote:

> +/* MMIO helpers */
> +#define cmdqv_readl(_cmdqv, _regname) \
> +	readl((_cmdqv)->base + TEGRA241_CMDQV_##_regname)
> +#define cmdqv_readl_relaxed(_cmdqv, _regname) \
> +	readl_relaxed((_cmdqv)->base + TEGRA241_CMDQV_##_regname)
> +#define cmdqv_readq_relaxed(_cmdqv, _regname) \
> +	readq_relaxed((_cmdqv)->base + TEGRA241_CMDQV_##_regname)
> +#define cmdqv_writel(_cmdqv, val, _regname) \
> +	writel((val), (_cmdqv)->base + TEGRA241_CMDQV_##_regname)
> +#define cmdqv_writel_relaxed(_cmdqv, val, _regname) \
> +	writel_relaxed((val), (_cmdqv)->base + TEGRA241_CMDQV_##_regname)
> +
> +#define vintf_readl(_vintf, _regname) \
> +	readl((_vintf)->base + TEGRA241_VINTF_##_regname)
> +#define vintf_readq_relaxed(_vintf, _regname) \
> +	readq_relaxed((_vintf)->base + TEGRA241_VINTF_##_regname)
> +#define vintf_readl_relaxed(_vintf, _regname) \
> +	readl_relaxed((_vintf)->base + TEGRA241_VINTF_##_regname)
> +#define vintf_writel(_vintf, val, _regname) \
> +	writel((val), (_vintf)->base + TEGRA241_VINTF_##_regname)
> +#define vintf_writel_relaxed(_vintf, val, _regname) \
> +	writel_relaxed((val), (_vintf)->base + TEGRA241_VINTF_##_regname)
> +
> +#define vcmdq_page0_readl(_vcmdq, _regname) \
> +	readl((_vcmdq)->page0 + TEGRA241_VCMDQ_##_regname)
> +#define vcmdq_page0_readl_relaxed(_vcmdq, _regname) \
> +	readl_relaxed((_vcmdq)->page0 + TEGRA241_VCMDQ_##_regname)
> +#define vcmdq_page0_writel(_vcmdq, val, _regname) \
> +	writel((val), (_vcmdq)->page0 + TEGRA241_VCMDQ_##_regname)
> +#define vcmdq_page0_writel_relaxed(_vcmdq, val, _regname) \
> +	writel_relaxed((val), (_vcmdq)->page0 + TEGRA241_VCMDQ_##_regname)
> +
> +#define vcmdq_page1_readl(_vcmdq, reg) \
> +	readl((_vcmdq)->page1 + TEGRA241_VCMDQ_##reg)
> +#define vcmdq_page1_readl_relaxed(_vcmdq, reg) \
> +	readl_relaxed((_vcmdq)->page1 + TEGRA241_VCMDQ_##reg)
> +#define vcmdq_page1_readq_relaxed(_vcmdq, reg) \
> +	readq_relaxed((_vcmdq)->page1 + TEGRA241_VCMDQ_##reg)
> +#define vcmdq_page1_writel(_vcmdq, val, reg) \
> +	writel((val), (_vcmdq)->page1 + TEGRA241_VCMDQ_##reg)
> +#define vcmdq_page1_writel_relaxed(_vcmdq, val, reg) \
> +	writel_relaxed((val), (_vcmdq)->page1 + TEGRA241_VCMDQ_##reg)
> +#define vcmdq_page1_writeq(_vcmdq, val, reg) \
> +	writeq((val), (_vcmdq)->page1 + TEGRA241_VCMDQ_##reg)
> +#define vcmdq_page1_writeq_relaxed(_vcmdq, val, reg) \
> +	writeq_relaxed((val), (_vcmdq)->page1 + TEGRA241_VCMDQ_##reg)

These still need to be trimmed to only the ones being used. I still
think it is a bad idea, maybe a middle ground is to wrapper the
regsiter coding

writeq_relaxed(val, REG_CMDQ_PAGE1(vcmdq, XXX));

Is still short enough and safe enough without creating so much obfuscation..

I didn't notice anything else in this patch

Jason
