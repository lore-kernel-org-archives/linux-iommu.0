Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ACB3009ED
	for <iommu@lists.linux.dev>; Tue,  2 Sep 2025 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814248; cv=fail; b=HHFAeQrtbRZg+IPd4WhglP804wJNbYt4Wv9S8N3Uo37jaeEomzoec/6ReKT/vqlbjAmO6A09/EFVolASE396smN3oyUIMPFhH0a1qMI1mJmbQyenwnbNL8HzFndOgxKAfZLtxz5boiY/nSpPu9SLS5QmBI/rsc7nrvnMwZ5yDjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814248; c=relaxed/simple;
	bh=mWy47yojSEvSD+N2Ew0di7VK9HxpnKwcpoRejSHyrEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S4PzPcSGyjKImcg+JIqW+06cRJH+fiWSDWffgJTDOC/OFU0dztBYrbdL4BpPxk0sj9s40lB5mC/a2/RVBnzLyfNDmly5lFbQI1iDhfg+sCvg+UYFP3InDyCbECrIpfWd4/h+lqA2eC4511/Z9JVfTELocFLrRbyeg7Hhcl5/u2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lvAWk9Z+; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lvAWk9Z+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcNQ48VkpE3B5+NU/00US+rmzcol5sWugMzpmhRdAjactYpZxBAfAbDBhvAM2Ay8a1HwweauLybLKkobDLcPsv68IYnhs85Abl+1MGj4XRDF9Wb9ynp1wm82hQOwasWUpgOYSWcYAl2sub8/pu6AYQ69ltc1j3XAfnsrFhKs8VBtB0bd6cifU2x/cfa0wqUXbik4yeYC3qIhHVdnedF5+0CEdTvmgJhilQqJMSYxGDDF8IWhTOqfj6UCZlDchyvkID6rvKTBQBqAgQ+8tt19ZH8zI/CLp0h+aOzO9oSNFwtppZnOAdlLkU5kTkxEBQN29P7/z8U2uRVbQmp4xocPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gJFh3vnnzSXdAE2x88uob5lILUFpteMByMXiqLcYgw=;
 b=DPCn64SNPaKjw9lihMW0vaM4WNv/UUUSCGZ4gfDVugZ6ihiQSuewF+FW56mM5zt4r9ZDEhu5/rN2voHDGQUnJ6mJjuWePY6BbmG+TrcvYPVorKB1NBV2rB/mT/9KagD3OW3kfnqkCfR76xhz7e9wVbdlrKVcKpzH3xLlWijc8O1kQCxwJlF1GWUGL3h56qCVWvA1MK9veeAWV4uTRDL0uZIwDp0vIbwdSQSXPW/diCok6SL8BUJwApUX4lLN/cvuQjP8EtMljQEojV7gjFhYjIyPZoS6jdvq1CbHDcmHZPuUiYwOTvS/m8IkwTdxc2A2qw7Of+Qndro1P96XacfErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gJFh3vnnzSXdAE2x88uob5lILUFpteMByMXiqLcYgw=;
 b=lvAWk9Z+DBGszMnP/TvrYuZeHsuoCM3eyOr1kU4bpG46fsTxZeAB/VjWvuaRAG4If0H7ehkcr+0KMiQYkdIYA3euI5cdwckVQFLRRhh8mmUU3ZTNNx57jwzy+tPVEmIqCsbYNJvdoDsS3ymF2GMoQhRPbSSTjmPtdtY1beToO2wFdJ492/33h4Ee+D076F+g5NJBPk6CoSyura7ER7U9AmWg8mXkvTYuqj7Cc3XKHidFIWcvhN8JeYrkBd/7cPMlIPhqtk/Qk37eQ/geiZ8127ws6Qmy+kyc/lJOQk3e1Qu8jJsw4nlJk3zAY5A0mEMCuICa9hVX6a7fRPWtfLl2Jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB6991.namprd12.prod.outlook.com (2603:10b6:a03:47c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.29; Tue, 2 Sep
 2025 11:57:23 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 11:57:23 +0000
Date: Tue, 2 Sep 2025 08:57:22 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com
Subject: Re: [PATCH v3] iommu/amd: Add support for hw_info for iommu
 capability query
Message-ID: <20250902115722.GD186519@nvidia.com>
References: <20250827162309.50401-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827162309.50401-1-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT4PR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::17) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c95501-ece4-4748-2f55-08ddea17e0b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j7U7gslXO4Tq2Q+ZPRFGkrV1Wvhk1U2InlNJ0ex4sr3SCsyCklaLomkk67Br?=
 =?us-ascii?Q?Z/o1CqkIIhrZTHMNb9bi3P0VkWlvVwVLjJDSMEoYoazgSpt54FkjQ9xJOP9n?=
 =?us-ascii?Q?u3gD6XC14NmclfYmDVVdZi07WVb75Ln8gut0+ZlqPZ8uCD4LOms3lxG7AKqY?=
 =?us-ascii?Q?VbAE9gXrSDG+mHMprUb+cJQdFGhDqHPKAy4yUW96cMBgDracMIHTYeyveO2i?=
 =?us-ascii?Q?GvXkomAWa3+o3xl6Xm4F9S9l5kw+/6gi5o10vRgKO999DFC2KzOfqlDlA0Rk?=
 =?us-ascii?Q?RIK75joeCnDAdFxj+F/oBh4rGJU2g/0kRdTdN5RVRsBXaNU54SQzESmOKX3S?=
 =?us-ascii?Q?AsH6tknWE0Z9H/9iuilsje0HgBm3uwu6t2uA3ZcygTsBApf1lm4EfkWqdOkO?=
 =?us-ascii?Q?5J8pt993e98kfVF+5jswyAGS28IO+ZiwyIQxTdCyjLUoUvKE1o/ycJR/Ot/p?=
 =?us-ascii?Q?YaVofeShrXjMjkI8x1eakgYLYVHf5IPk+lbASAKsjVRmr3Uh/nZD68xKv8VZ?=
 =?us-ascii?Q?gnzfF7A5VJD/T5NPftZvqARM9xNivw5tTqjUWAiVpfBt1v1+fzGd4qrkEjU+?=
 =?us-ascii?Q?odhyYa+BkIkJGpUOKzack2R5FgG6yUD9UA0fEWzfm3ekdNM0g5rOiG8X/lau?=
 =?us-ascii?Q?Z8OPSJZPg2nikE0NaP6KWouEClTVw3m5rAgzAPpnhZX8dXDa4l2jeilBNasx?=
 =?us-ascii?Q?JLsAbrnaFDgzk5ZtiygsDefjKJJhsmTn+fX4BZZ0fmfDSdm0PivwboPpqOU8?=
 =?us-ascii?Q?nWeDxjI1rsdXI0z5hp/dhNYoPDJ/hitB3Jg3BZW9kBwpd5raXEFcKUVyMrrU?=
 =?us-ascii?Q?jxG2vndFMGRnncb3q2f1Y4CTKU2ueiO5m7z/ODVVBnymW6q96tR/xokW4v+H?=
 =?us-ascii?Q?fD5WE3kzHvG6021Zzs0Bl5mhHDkVA5ZJeDLOG9IlBKyJfbCx5UAMtppY47vg?=
 =?us-ascii?Q?qHfWsdX4KLMvLbWkbCPFgo7njmQHiy74zSGtKxw3YaEtGjMICpspwf9Zgyt3?=
 =?us-ascii?Q?c9pOqmZ/zZ/NYel9Tv31JpM/9wHS6+ZW0AtkN9+cMk0Ryf/s41Lq5+L1/2sP?=
 =?us-ascii?Q?7Ld4zCAVh6227P6IIO0Dt9kj+yaciQCq2HBW+eoWuzPE+ylAgcZ6+02hpulT?=
 =?us-ascii?Q?8jxaDS/KiS+KUifUCUKGaocUPjJtD8xRlCSOoEsW2G7b+APuGj/z6Q2p4H7Q?=
 =?us-ascii?Q?3Eoe4+3YyRnZpaH63UYYhBnz8aQfzraZ5CpUduZLINCj1gywaHFDLyWiru6b?=
 =?us-ascii?Q?AcmjStff/2Xnl0Kl8uXOXaJzPC5OWY9NFQiN+VzHA62B3frdSUJ8K7i/oqJF?=
 =?us-ascii?Q?u+Wd2yYmy1L60xU1lJBbBGnCmJoYvdUIjoHf0SeTGUp++g0/mExOthHd9nyI?=
 =?us-ascii?Q?aljo91jzbAbs+OKDxOVNJmDSdx0E0rG1k6uIfDfIYgTq8Fh8OtZS7ModFZ0j?=
 =?us-ascii?Q?sAzU1xKWQx0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7ESUvw66YQB0Jc/SyetwGQiBH0pUeRmv83IhacPBaUkf0zQTve8W8NfgpID5?=
 =?us-ascii?Q?9fZxvj45w/H9KBWAAfMr7fgfbGpqKZlurUPjt7EEMnSb5wzRH0sO9ZaYeEV4?=
 =?us-ascii?Q?fRadyqONKlsvh9YsuA+/gfkrAIT8Xdr+QgSqrCEYLMwrDrbA/k5mrgeIae26?=
 =?us-ascii?Q?ob1Xp2g0F4nsxz+IXm3tLrD34CDy/blGGgSz/cKqvMQu7FBHzdBQJXTdcyEE?=
 =?us-ascii?Q?g/6lJUgdyNISFE8yDjT/vMFk5ZTh1GZlskZq2RvEPZ4Iie+u3tUhL5dpmnk9?=
 =?us-ascii?Q?VDVCiy+mp51vc91DQ/FyOcZ1Zv/f668Z+Rascsw06TVcx/EN2CNVMiAdwHxn?=
 =?us-ascii?Q?hVQGC/5Ha+jpehppwAU8B+I6F3idnjVwfJ8ASV27dy5wqCgQJ8K5oDkcAYtU?=
 =?us-ascii?Q?0mdZchCUjBZOAhpC/jpAAfaLKguiLgB0BM781CVahRPxTNs+MLwkrZ618YGN?=
 =?us-ascii?Q?xojU+py7qv24E86cryYzlo/6oCdhy6INQY/vaUSJbLUGWsUoeO3bz64iDwf4?=
 =?us-ascii?Q?CWEc3OuhuKb3p1lJK+YHSCIZJqAk8zdFmWt7ZggZLZdUnuOKS+fqZL+yJvAM?=
 =?us-ascii?Q?pg/+UHW4aGnUO4wewsWdGDWFEBuGQ6slULXMcuhbko0k5zW6/PHtuLyEOShn?=
 =?us-ascii?Q?g7AiATvG2rZoDWo1Dm4QVHqLSXN1/gZ2KCWi7TNz+HooZc9VK+0vK0BqoIbM?=
 =?us-ascii?Q?GTtBhuQBDGz6buSoaTwyKbGodNnU2T99Fd7WCBISvF6CqUZpWOJgPCz6RMxx?=
 =?us-ascii?Q?/z3AyejaHB3fAeGuHeFaKhSHdxLz8NB03nXfrSIL25V4dI5LgVwbxORZ3QOP?=
 =?us-ascii?Q?ksm6P1FMIofUcL2yKwbM29JVvLQzVlXRGheG8WoBJ68H2B+nNIN+5pjyTNAX?=
 =?us-ascii?Q?md4fWyAZ5nK68MZM/13BQ6tdF4mfModjr9yR2J7DDGasY1vOLdoC/m10CR5l?=
 =?us-ascii?Q?d8uQgbizeWtZ5eauzGZIptKQ2Fkm8+tJgP4lShHTS2/iQf8MPSic2eomkwIi?=
 =?us-ascii?Q?a5mL06AWGGCKDcu0YXxO/W9cTjp4zBP93K3+vLYufVej6Sf+EiJc+2xNIRfs?=
 =?us-ascii?Q?KroocBUc2yLuGuJgrP5wQY4+lD2LKWHV3PWdEn6W5X2DUsbHtr/pB7tf7l1l?=
 =?us-ascii?Q?tegHAvXLoMpifJ0MlndxDVyzOEmqXqN+fsgd27m0eubg0BHqsbEzKF2wIWOZ?=
 =?us-ascii?Q?KVqLrIdOeTrheRyip8UqKv2Rtdw9QmIOmOzcL4lvfWb/t6h/w1WljLqN1D7S?=
 =?us-ascii?Q?6o7nCHMID2Z4Ez2U+8uNAwho4JQjO8QF6g8NjzFkz/cuD3oxfKMc+JzoenXm?=
 =?us-ascii?Q?7CVUXBerE5QNQ84HCBJurzCAQltGgEjFe5FEGGsMo8XBop5sKAfhUhEOPe5y?=
 =?us-ascii?Q?iL9FyB5wvmRQiBV6faXKP9VT+u7NG+qAZpP681PBnWx2KbwAe6XjN7jXgESR?=
 =?us-ascii?Q?fZyZPsJXp3ThSx4jL22p6Vyejira5Qh96/2ECydWhDnIHpbj/bIDNMn4Uj+x?=
 =?us-ascii?Q?fw+Mj+Nc7vJnmdBSyy1MIQplsdawQsFrPqgUBRlW9UyuD96uf1cBDE2OPrgZ?=
 =?us-ascii?Q?gP0tX1KZYbxRjJ35IPU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c95501-ece4-4748-2f55-08ddea17e0b8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 11:57:23.3740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fvqr1u1yZiQyqhjBR5ZsEQXjeEQ8DAKv7NuiDvhDTmKAwRgFjKcNVEMNxF/uUFro
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6991

On Wed, Aug 27, 2025 at 04:23:09PM +0000, Suravee Suthikulpanit wrote:
> AMD IOMMU Extended Feature (EFR) and Extended Feature 2 (EFR2) registers
> specify features supported by each IOMMU hardware instance.
> The IOMMU driver checks each feature-specific bits before enabling
> each feature at run time.
> 
> For IOMMUFD, the hypervisor passes the raw value of amd_iommu_efr and
> amd_iommu_efr2 to VMM via iommufd IOMMU_DEVICE_GET_HW_INFO ioctl.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Was there a reason this is not part of the other series?

> +obj-y += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o pasid.o iommufd.o

Part of the point of another file is to not compile it when !CONFIG_IOMMUFD

So you should change the makefile and add some header magic:

#if IS_ENABLED(CONFIG_IOMMUFD)
void *amd_iommufd_hw_info(struct device *dev, u32 *length, u32 *type);
#else
#define amd_iommufd_hw_info NULL
#endif

> +/**
> + * struct iommu_hw_info_amd - AMD IOMMU device info
> + *
> + * @efr : Value of AMD IOMMU Extended Feature Register (EFR) reported by hardware
> + * @efr2: Value of AMD IOMMU Extended Feature 2 Register (EFR2) reported by hardware
> + *
> + * Please See description of these registers in the following sections of
> + * the AMD I/O Virtualization Technology (IOMMU) Specification.
> + * (https://docs.amd.com/v/u/en-US/48882_3.10_PUB)
> + *
> + * - MMIO Offset 0030h IOMMU Extended Feature Register
> + * - MMIO Offset 01A0h IOMMU Extended Feature 2 Register
> + */

It would be good to elaborate on the bits like ARM does for
iommu_hw_info_arm_smmuv3 and where some of the bits should come from
in other places in the API.

Jason
