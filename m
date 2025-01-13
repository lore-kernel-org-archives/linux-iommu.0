Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8127F1C5F0A
	for <iommu@lists.linux.dev>; Mon, 13 Jan 2025 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736800295; cv=fail; b=tDHlUk0oW8waDLIEXcmuiwefmL4wAxTUDUcKClGUPnzpbLM3Unc+7Z+yxhV4af/dJ1Yg/tuMs66Wh0VA+h5Y5JxkiLsXTjqfFNTbhzAHb5z/ytPEvLHbSTBiMfc3m9f/1q5W2NLrnpfC50qxsf7okAXSH+ZjoWcr54qUQ69Dlyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736800295; c=relaxed/simple;
	bh=42Lk0tlYB4GjufNmcp9mBr7muCnaA+nZHFCZJsZkqqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uyhRb1iXRyxqcFQGSU/5tCfdZS5nH/cWNFI+ELoF8yqL8fcKVYJIOu6hUZjM/8rki4hwLTxu7p5eOilDGI+AZKMMfNOINKtQyWama5czZpTb2nDnu49/bw4pFebBMhjLR3RM/CzefdqvqX6pdvF7ndMFDvnTxTtI2yJrLXQW/2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iwsjgBXE; arc=fail smtp.client-ip=40.107.95.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iwsjgBXE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzQII6Rllr2MIikOGK1UaBWXNlUCBY9rzdBAEf7V9rKQS4k6PMG75W5i3LLFKnVh25OWKTbpq8scm5Z1XUpnAGjtSMiaRZ9f5bTB4oOFsxzYkfoSekHzpvKKNxuLp8H8rJUSacylYpVI2FowCWJIi0LZ9z2441SDw98hrv2V0gGan3Gij+uNyqUJtRlni0cH+0cwwERLgTS4cCDtbFZ+Sxo7kSFw0sMdfQE2PxExZbpDidNpVcNbH+nnzFA8SqMA90CVsFrzJsXHRns8qvgRa08g/Z2PDz0YA33zLOwq+HT0ITJMySqtMD3wo2DTwGKoH+saFmJuWQ5kapVQSATpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tNj+k0Q2s2hrFlopZTdtgEtBISBSEHfK+QT3sUXIRM=;
 b=wQlgYicUR6eEwxq4c/fRQ6t4SJhUB+tFZhEuCR2VsyXt/Id9CpnQwuAvNIf2d0+OQmWO2C+j9C2UUITq7Q3GrSJHtxb/krE5bFjNki7BWiy4lTLHwSJlLBpbRU30lYM7YaaAjTaEQ0Dw9BZrQHCrKAATN6WlOvybtp4sq4ECBSmmDnsKc7dfoI3M4/l4vx8IwpFYMWuApUp7feV4tuchd9NOVaM1aqiWpu/KeGz1L6/a5q6FdPmzyo6sic0SzT8/LqmodKEcv2aXP1oHSXKU5or/9M56kEjUX+ZI8TVAYmCE1pWO3dEclNQH4K9ZoSOBE0tYkPXQx+UVLp0mzqoPmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tNj+k0Q2s2hrFlopZTdtgEtBISBSEHfK+QT3sUXIRM=;
 b=iwsjgBXEJxqA/aSK2O94kLtAXi3XPv4zDMKDl763AdHComimg0iXAIggNzg0R0JbhbNNWTCjQqlQSSCHH6rUdceo4+EDaTEk16ci5Sr22qJqMzSQ/vs4tdYD7BEO/Fp1lj3/OLhJ9Wqz1pTaZLlVSbFH4uJsn08nJEkhKjWNq2U3RamiX2BEcsu1ReLZOtka/iTnLTkqQvR15+ccPMCFKbuwdf6t3Vjx0a+sppT7aYCJpn8d3gAUcDqiLaRfrtAUY2sCk+d0o8Znj2zwh9dKqp6ZEobqPUqElSqWTuaRdLlVilSi/rCXfP3rA7JOA1H0yjDCiTk5jLL7ZrdfZj4xBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB8008.namprd12.prod.outlook.com (2603:10b6:510:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 20:31:29 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8314.022; Mon, 13 Jan 2025
 20:31:29 +0000
Date: Mon, 13 Jan 2025 16:31:28 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	eric.auger@redhat.com, nicolinc@nvidia.com,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	vasant.hegde@amd.com, will@kernel.org
Subject: Re: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Message-ID: <20250113203128.GY5556@nvidia.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219132746.16193-10-yi.l.liu@intel.com>
X-ClientProxiedBy: BN0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:408:e6::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB8008:EE_
X-MS-Office365-Filtering-Correlation-Id: d9f70abd-a67f-470a-fd09-08dd341142ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7K8J1jHgW9x6MYGAO9OO1RDToKuPikq30J/z+VT94/M/DxmKknznsHiGzD0l?=
 =?us-ascii?Q?awE5yB1Uq2fl8e0Jvj9Wb0a0kQQ5E6hqpOcyJ7WCpPUFAUaz+tRk+ACwWtyW?=
 =?us-ascii?Q?2PaMYsrE7g4U0HEylBYBKb9vI7EQmCB+5vP+2LDJJQhVtILN3OKGn32kShhK?=
 =?us-ascii?Q?TdKdGA7t8Eu4TKBpfFsUe0s04ofiwg4BximfGABzBjaN1xrJX03/DJgOsukw?=
 =?us-ascii?Q?nipi0FCISizYYnitTwinN+xWeb63CqChIc8UZD0bUuuAKXn7O1XRGPXhgIWi?=
 =?us-ascii?Q?QnReChA8ruHiEfdivscdveBr4HwbJzpLIbOfTT/7VBwG01iLLPZiFDBLc809?=
 =?us-ascii?Q?KeBlGSjus93I6BAYmuUNEW5JVwq8PUTn/OTYUTLKmf0sa0d8US1hRFFKoNgo?=
 =?us-ascii?Q?wQlBEk1s2pRCF1n+hPPC81FGo8fgoihuvaqfO1GtcY9xYKhIEYFZ9+5LTtat?=
 =?us-ascii?Q?8KQ1tKx6iSt7CgSfjC4BtrXyYcq1RDlXi34N2EQHVow2g9si7OiAEOtwpp3Y?=
 =?us-ascii?Q?9iEL8JhEAzmX9N4wtvUkBhjsJ2p7/f9bEk7FOTSfSwnt9RD6TsxV9Ygsvpmu?=
 =?us-ascii?Q?xRDnZMs4fCZ7T4y3Wjg0DU0RXSIaqVoamDsZgFRk0xWbnzaDjO9aKRjN4tAw?=
 =?us-ascii?Q?4GEbxW20EtA34UP+BC9J0/irMHDivTkZd7RuZGvTqh/69JljzFdTDCmR+iKl?=
 =?us-ascii?Q?kL7hRqmMZTIImKxa5b4DsI5PckISsi2XfzRl1TvvoEPEW7yijUM2HisQploM?=
 =?us-ascii?Q?5e9Foky8lEuW+V0jaECW4GwhW14d7DWBC2i6AOHppSFBTUFvEUYtJLcTye2W?=
 =?us-ascii?Q?G3Teb46bq/VCBYm48jzaGHWKZNaKXBfhXzy14plrz0zy8Je5w1UrQyaZWuBN?=
 =?us-ascii?Q?n1t9z49esbtlXIvE1CQ8xFMuoiW8B1hvcZ3cWUJMT98899ypsYLnT48lcD1u?=
 =?us-ascii?Q?6kDzGlIRfe1l7Ewc1UEFmsFaFgcEYNSP/kNulJk2Zp+ENYkW+5+dmzm78feH?=
 =?us-ascii?Q?oJfCq5n0hEmKPv3Ln7jLU06PbNKv8YegMay5qFAYEeyw1O+G729SI0BdwBOl?=
 =?us-ascii?Q?t42oKkHt7YZ7/e5sCtlhbqwHkRKy0qCgCNmm2IHWpdEEiLeJ4ULIDv8QgG0L?=
 =?us-ascii?Q?KLF1G4ZtGTUsfssovX5c0AEj4HTk4xARv2/x7gLn5rNvkK6+whDxSLQQpub1?=
 =?us-ascii?Q?21HntHj4ZC3i3k2sOv2Ah8ApIKGxgvPBxpqqvGHaLf5cdl+9uRITtz34WxW4?=
 =?us-ascii?Q?Qphxcf7OmV9jUap3DBwbH4qx9L+lkBkRdnngA7eABZaBZ6iuhVYjh43lL3Hs?=
 =?us-ascii?Q?oAXfFc7s8o0B//3TRy92xMbNoWB+pZ4aZSvXVfCNWgRFU8l4TJvU9MCHHECz?=
 =?us-ascii?Q?KFfDraLp/uSYc/ZqV1Ewfv234z7C?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kf7NFKI7iuWVF2O4g5U++uK3UxJGz9K6WMLIFmNGB825cvhf5yRcgxbSR3YL?=
 =?us-ascii?Q?Kk7RwrDbkxsKINopR2OAjpJ0xCOhcDs7EHmMMkaTL5gmHeWwdKmU9+cBD79F?=
 =?us-ascii?Q?52SxIb9M45LQJ9S2eIm0OHQSg4pAEdBgJDRcDfVNGWO2a5s30GNxJ3C9iAXf?=
 =?us-ascii?Q?gWzK4TKHCd60oNaKQawtmkdro6C2NywVrn73yG/UQjiCuEPaazCCjlzH1z3D?=
 =?us-ascii?Q?gdjWR7IwXXK9pHK4M8dgIb7vMqYbm5mWIc+vAit43jnX4t1G7MSB6uz0nYIA?=
 =?us-ascii?Q?L15u7diu6kL98JLV6BVlj0pA/tVYjWAhgcrdYP6rLdTC1wb5bppnDGkbWbNQ?=
 =?us-ascii?Q?8Vjqmh+Apde4ueL4PlDvaSGwHRA7mVcs8raCDgCySV3gmYe3KlLICwKEPP3M?=
 =?us-ascii?Q?QN+FMgtIjUmmawSoFwczJ/xviiHEdsaZEEdXHYHnI6jru2L+z3Eu4yJ9TI49?=
 =?us-ascii?Q?V4adhds55vlKeljvmpKo9TkxwD7ic52ZQ0k5tcdLAnLV3cqwy++9FtCRVdQ1?=
 =?us-ascii?Q?1XzbHivseWZsaiU6I4l31kQQld2IyjFFLknfgt7zJ7YXycs8Ys2tDW6CuO6c?=
 =?us-ascii?Q?DKYeDC6BfHw/X5CmSl5YPTw+X0QOk9sF3wBYOAQdu9vk1ZjqHUwAndKCTZKE?=
 =?us-ascii?Q?nBQL4G4yNvbPZdmwubveCtwa43lZEW9BHKEn+dZ5gqe23PCunLzwnvdXNZ8x?=
 =?us-ascii?Q?JMrrIYw357g+T6BfzcYjXMQ0kk7aMlh27ghVbG1XG3h+h9EpLySJReXh3tLL?=
 =?us-ascii?Q?5NWneDsgKHvdMS430M1EowVraLhHqnDJk+TSA3ruCThOC+lMmavBUAqEpPK1?=
 =?us-ascii?Q?0COnWtpDF0SV/rgqy4xFiJjfdsg6nn7yIsboNBzqqUt6Pdaro6yludpDyW/A?=
 =?us-ascii?Q?kKEsG7pJY0oDL3MZZmmKcQmjWS4DwjKmc6eFu/b9NV5zbpEsBWUqaRi7t5Jd?=
 =?us-ascii?Q?kjcz+1cRK0YlaBk6pTMWzNQrvspNWGu/wrQex7jPE4M/1BIfCtRHW10pGCR8?=
 =?us-ascii?Q?s3QxFuaPLezygfXlIukgLrNbrCQAvByFAMA2xKhzwFSiXJWhkH0pHfvvFg7Y?=
 =?us-ascii?Q?4sjn6T9lcLQiDMfQZN1D6NQBcPb3yd03bTcGDrWgMuwJIAAVzc+zN9wTSl3w?=
 =?us-ascii?Q?PqrMVuBamzbW+rLVKfaR/t+R7rgC/PFeEi67wIEWPt5S8iPGMITG9GeEmMKO?=
 =?us-ascii?Q?kI+zzNQGvwZmiLVHlHGialtvHreBBiw2iSTTclOZzZjsZmMDL6x3UXUxwPkd?=
 =?us-ascii?Q?T2UtVx5ejycCVz2YHzJsWbZSzlTKhA1uNaqE/Mm+pKV6HgMSgQM1QkkkmtEF?=
 =?us-ascii?Q?bBHPJ9iqECO/mKeNTjRP+9Te3Ef0gzqyhql5u7UYLe5m/HaQLkzg5dvW8JAl?=
 =?us-ascii?Q?coCOTr7tI/w/dWhEAsx/SqBS3YNGZ6u/mUWzRjuJNiA4pIvM7QlRioRlgqgV?=
 =?us-ascii?Q?GnqcS4B1mSWSl1KCpyolJHfxrvSpUW0CODivxQu8t+BwdW8u3GBGzc5AwkOT?=
 =?us-ascii?Q?WEkKb4t9ip1u4L1qZuJVgREX1wi1HYj/VFdEacgUO3p6zOztH42AEweSQBc2?=
 =?us-ascii?Q?m/Yx0Ye98WwUIDOHSHalJvTF4gJb/gqzE0p5ATXU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9f70abd-a67f-470a-fd09-08dd341142ac
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 20:31:29.5859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xRVqGN+y2Op3yjPG/vLLSzUkR5YtpblY2hIm3LW3LO5vnkUL9njUng+de46cj2dr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8008

On Thu, Dec 19, 2024 at 05:27:41AM -0800, Yi Liu wrote:
> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
> index aba92c00b427..6ac5c534bef4 100644
> --- a/drivers/iommu/intel/nested.c
> +++ b/drivers/iommu/intel/nested.c
> @@ -198,7 +198,7 @@ intel_iommu_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
>  	struct dmar_domain *domain;
>  	int ret;
>  
> -	if (!nested_supported(iommu) || flags)
> +	if (!nested_supported(iommu) || flags & ~IOMMU_HWPT_ALLOC_PASID)

ARM and AMD should reject ALLOC_PASID when combined with nesting, it
cannot do that. So it would be OK for intel to reject it too

Jason
