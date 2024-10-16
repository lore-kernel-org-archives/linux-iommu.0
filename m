Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EE92071F8
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 14:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729087655; cv=fail; b=HSh9DHzPpie5zK04dV6Rb5+MIhg+PRFpL+nZIaBII0tnkNT4AncwuCgmUHKfFAGUfyg6/Icp4Dig6GhR/8zaO8spwei1/+MjNiIi/kcbzdTDzX4Uw+UKl8UliyXDOu5B2K1Xm4Tq/Af9wcaWZpddFRTJRkxgnPoH1aNjFuxGays=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729087655; c=relaxed/simple;
	bh=AJK9k4gdS2mhz33u6MDztl49OoPIACfA+C/caVRfBLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nfx9QchcZgdmhMJSfIrmMmM3J/Wl3KiczwZOfLx5CgqHLxbwFx6elPTEjX8yjATNk6Dnw1guOwQL5ZZwZO04nOEB07KU+CiAxDCyVopEMX89s2f+D9s1yjDyihJ6FHHAtqVHJAz/bDEBvqpuP90izghbTV5Ycyj+H9HNMT1Sj2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W5O7KgOM; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W5O7KgOM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xgXNuYl35LygOH37tB4FuJMpK8tq7VtaupIl399qbOT/aVwfQrwzMVSCNJgkUlcfHM+M7iZLWptBNExH+fX4Ip72Ft4VDLGUn2m+F6ZM3nybYzR8nMdE3BAq8yxbUYNckOi2m3qxPj5/ijcISb6LiwDRWkGnOwDKsDHB5EVklWVjCHUPrYoruKw2/VFjnLgz0JQc7bpdoKpxstNrHlX2gUdEQRdOqXbg6X6bc67+KzFrm+BiNGxLL7O3tV+LZgzrMp/e9Qurkc1/UTK1LLh1fzIuPpkuM7QhTUyf4cF5HNfxSq1S7X+ioHov0BKkLSlTX0Ts0liuN4fvStV7biLL8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWMoCD/6zSnaT6RzVAsmI1xRHXh2/Yxnn0favkFnqA8=;
 b=OwFP4smTKmkRs1XV8XeHh7trMtdmk8FHTgff3PfiS+JToRO+FjbYqS1b2mdH7Zi+NhiZ2yHkZ86tWzTPOv2cJoP+/MtQMffWOGOB5jTkor3r1ORHXeDkmbTv5lR3pOO7I3yBuHFZoQHpDnLN/5JEBcWK1/2LtbTHi03n9dqV07VwjHqzsjKgGbsipE6LVZJAJDrpiIpZZVAFe6oSYcHUDibtQso9XHkrLgPGn7fbDmbOIc3o47WLOwT8cSqTqZNOnVEotD8p4NnQsNRQGYkps/hqYSHpsn3OwYR7h+dMjEOVm3Bj7ePRTD8Spl6XfyugrdYH+DAG/y3oKASnxv+APw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWMoCD/6zSnaT6RzVAsmI1xRHXh2/Yxnn0favkFnqA8=;
 b=W5O7KgOMY+P/glG5KLRFg4m47FjdviU4zi3nNkebOjX/yP79oF1aZutv+cNpuxn4mXyRwmcGW1Wd9T8adxZo/lYoBMDrWGKccy4KoROLaH0a2z5uNc+cevcO8keHg7JeTdcNNN73KesRKjSAr+tZfxIV6rQLQB1e9pvaLJGd2ROymswlTljFxVZbLO0Sj+y3gna1FjH1a973Md8oXpgWUAvLwhrknPHY3c+7jGNI1HGiitN5NkarNP0kt503Gk63cduZAk3jVPP/GISaaq71t5UhVVYD3e9y9GO/W6ES8TIXf7Gljs0yhmFKTi2ZsvUSYUa7CGjybUQ06kQFA7VQ7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN0PR12MB5905.namprd12.prod.outlook.com (2603:10b6:208:379::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 14:07:29 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 14:07:29 +0000
Date: Wed, 16 Oct 2024 11:07:28 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v6 5/9] iommu/amd: Modify set_dte_entry() to use 256-bit
 DTE helpers
Message-ID: <20241016140728.GN3559746@nvidia.com>
References: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
 <20241016051756.4317-6-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016051756.4317-6-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN9PR03CA0412.namprd03.prod.outlook.com
 (2603:10b6:408:111::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN0PR12MB5905:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd9724e-d606-4e1e-d578-08dcedebdee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6tus9M+ecR8T42U9rA17ns4o3JRtMl4VQ4C1GcWEDQp9nSsjDpfiS+d8IN3v?=
 =?us-ascii?Q?6WCikAp+FkyOxNwpYhiqegPuJ+kVjZ82vLm2z269mHNXB3b772dGpCRSgPdT?=
 =?us-ascii?Q?rBvqpzeHdZNXFUT+ZQHq8LR8id50YASUomftwGpXMEZyDBvSoTksvloql0uj?=
 =?us-ascii?Q?lPKFgZ4yLJiB+mrzXCmjjsRUJjhc3FODnM9ca50Hs/relVeAtnh9V5BOS7xB?=
 =?us-ascii?Q?95UmOy+l/q8EZrwhm2nVk3uplc2roy8ekrAxXyRMKAKIrwZo27UV9huFr/Jr?=
 =?us-ascii?Q?dZMrwG/jXtwdK0IVS1WlralYGLZEIbEyiM/6NLt+Khju34OwzPlO+seHk/Kh?=
 =?us-ascii?Q?DwPSvfhn/pqkhFdwSDUFQMWZ3o6rbssCrldF854SP+wZUUM2o++zVcl5d8id?=
 =?us-ascii?Q?hcjR5shBB7tyXTDzjUdG7RZcCiej9A2Fia9jhpbQkdpkDL+4N/8qgoOm/TQ3?=
 =?us-ascii?Q?RvgjIU+8QzeqjBLzLTxhB8ZIkCmC3leeRKOkRwOcpc6xV8//jePsPiV8AebE?=
 =?us-ascii?Q?pG2eEhiXxF874lbbf6kQ9VWXXHtXRMsuqVrXjkdur6xS3uonOY3jTf7cB8dQ?=
 =?us-ascii?Q?gMonEnDfZ3yl+2RhovAS5mK2aspunri0to5hj2FcpRwUwJMnqC5QzfzB4hCz?=
 =?us-ascii?Q?Kz39DP01VDPO0x/7eV6/S84huZ8Jg72dvsKldKy1QmUg1OMURe21XtCvXucQ?=
 =?us-ascii?Q?+WnpzhrHDkvDrO31+jBdwiACNGY6HzxcdloSkCDszm57bGue5a7QUpedEQ5Z?=
 =?us-ascii?Q?IWwj1vMkosNketih77P92cFr1/kfCBg80aDkSyLoDTsSLxvTX2v5h8feojKr?=
 =?us-ascii?Q?1mGd2d1aF+cFO6xaTBXYXfA49ZqrgGS93oUTvZjz01wmPja5/fVFKgucz5RO?=
 =?us-ascii?Q?tU/GpGsdxsgQ1SVpPNqgFqPCVrWelOJIUbtvm+QpuWAGwRSjm81l4Cuy6iDY?=
 =?us-ascii?Q?ho+NFqLwmuDFFGPY8WnoUAyCfYPbajOZeAgRrnq7+XFUaBl8kstxEMYHJ5Iv?=
 =?us-ascii?Q?jPpCvRpUJhdhCv65IxwUbVbDILDCq71i9X6V7S8xc1DeIYtfFLWjtY+fIexA?=
 =?us-ascii?Q?nQtXc8yqmt1T4J7+w3NDMdOM+fNElDS1On6WZqFpLyQhL2B6mWM0YdJ6c2fV?=
 =?us-ascii?Q?xXTYKtbdgceFU2umqBgfmwLBhdAQpmKRJZg78PeKhcq6nRkEvCXvihNfYubL?=
 =?us-ascii?Q?KQqkLdbegfA3oZbwdLef/+PS3LVqouJ6vKj7zXKkl/5EoR8eEbwQ/IQXhA4V?=
 =?us-ascii?Q?4CM+AvxJwOCHUnFgf6GchiRzGRuyydw1aNrX+MGRtA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DD8jpHhb2DgnEJDRicoMTdKv4HKwtYx6z8Piu+vTkYlVTsERD7xw5wE9FEG/?=
 =?us-ascii?Q?YOfwPNN/btDqSYbzBPS05X2MCsS7xI5zf3iBWGPDpWuSJKDE5XRQ0cm4HLb+?=
 =?us-ascii?Q?8UzFM2+q1ubZc7SVD7SVDtIZS3YPmRysDWsGq9tt4IQX9PkDzX6wWiacIa3w?=
 =?us-ascii?Q?/9bKLjagSpq1fsHj3oiZ6ezsO2LkLBxo0WwSPm0mGx0+rjA97/YlF3i0ZzLk?=
 =?us-ascii?Q?46EIy8iNBuR3SJeRg9yOqa2W7pwt5iXW2flEOa+hXeETeLKx3zdagSEuHc1Z?=
 =?us-ascii?Q?iYfHnTMaprKtszDjO4eWhjjvpnrrL642350Qnf9KM7QITc68ziIQwBrBkbhM?=
 =?us-ascii?Q?XeYmlHNNYZdqBx+gGDMRLJPDQiBGttlBB/qUIBcvtnTvx2SEZTCwq/IsXots?=
 =?us-ascii?Q?6PnzLomS3P4uiB8gKtGAMlOYtQyH6hf9OFd82xa9ueKKiBPRmdqoQNe8g5sz?=
 =?us-ascii?Q?VoKOIWFsTyIZedP5DCYehEjod6N8KrYLKh5VcwJNMMlvO0cOyCBVO5Gpy3vG?=
 =?us-ascii?Q?ps2mVT80A5Kg2GQ13uIpxHDm6n1xipV6qVR0f0QjwXy/v+xSRIROYD9NhrCx?=
 =?us-ascii?Q?TvDYjCqs9hmA2KvxEXrVVNJak3AaqgPsO5jU3xenYTOvAvdcKUMWJDbR3I3w?=
 =?us-ascii?Q?H6llOdUlFRg6x5XXplqNcmoqCzRcqHpYGgsYTRdmYsSXxXFKvmsLpIUZjatE?=
 =?us-ascii?Q?wJ1rYimtUObsIqMnskoKew+J47HZ7ac8ERXROvs4Jld4TnzraC80FJ6wLwp6?=
 =?us-ascii?Q?rqcH0LyURraD143PzFFNz3zcx2q85C1b/4BDCssNSmhh/kAmsDhnbADJQor4?=
 =?us-ascii?Q?CMcnzHYbe015Ir55sCAa2TfmGDM24k7QAwSW1OuR2JXIgThrIDLwreRXHuGj?=
 =?us-ascii?Q?NQXxGyD7vphmeZLD4g7bRCB50SwaD4yYYxyWpHZbr5aNws9TUMTQSvrMQIEF?=
 =?us-ascii?Q?2zFN5QMhFHW3SjURa3dp74Kk3WhEnUrWA7BrftZ1XrkfaAniZNVrkdYKoOuH?=
 =?us-ascii?Q?np1fzZzZN8GNQLzCdZhTU5fVNYGO8NkWoWwLBtl7mVI1crrvPY1SckmiWsj0?=
 =?us-ascii?Q?XPwud/5cAI3v4legYvKa81peoMJOl7+qiVPK+/e37Q9GwlQSPafSeMuhPeu1?=
 =?us-ascii?Q?gpA2KcYACAduiiXoUZJleH5cgGASIa8ja9eg5zaq3lsQjEhENzplkLjPLFY7?=
 =?us-ascii?Q?BzbmTq9EzrhYMxfhQSqEFFRRND9YYGhDjofAVceeS7pPmhdvyFZOXC8rUwnk?=
 =?us-ascii?Q?azCmoZrwHt9NoPYANMDl4LnboDAylmbEHmxns0KLAxMGS6qz+URB+BC+vZSO?=
 =?us-ascii?Q?i3ctjxq7Wsx5V9QhnGQnrbEPKzvY+C86d3MJap2c/z7wc7ZmBCs/RDMfgS1j?=
 =?us-ascii?Q?Gj7eHJNFTdjsgyClYvOBJnJ+Qb35QAMDh0veTWfLJ6HlHcmg67iR5kJ8yI8e?=
 =?us-ascii?Q?sb0YlIXT+/n4YHhJf7J2Anp737Exacs5oaTQPfQjrK5XJclgWxczZA4QBTH4?=
 =?us-ascii?Q?IWpvaab1whO5hKQ1Y+iJO1ay0XD2dx5nNhSlQob+9ycphQ2x3flcLNTf2a53?=
 =?us-ascii?Q?VmACw116NLwoGM17Lww=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd9724e-d606-4e1e-d578-08dcedebdee6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 14:07:29.4127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtZcf0r4SYPS8N+8PyHmTPcjP3rOjl/dA19/+yAi6A1AOH5gqEy0mtWdd3/NIPt9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5905

On Wed, Oct 16, 2024 at 05:17:52AM +0000, Suravee Suthikulpanit wrote:
> +	if (dev_data->ats_enabled)
> +		new.data[1] |= DTE_FLAG_IOTLB;
> +	else
> +		new.data[1] &= ~DTE_FLAG_IOTLB;

No need to clear, it is already 0

> -		tmp = DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
> -		flags    |= tmp;
> +	old_domid = READ_ONCE(dte->data[1]) & DEV_DOMID_MASK;
> +	new.data[1] &= ~DEV_DOMID_MASK;
> +	new.data[1] |= domid;

Also no need to clear, it is already zero.

Jason
