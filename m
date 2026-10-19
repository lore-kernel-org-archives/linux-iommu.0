Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010067.outbound.protection.outlook.com [52.101.193.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72080484887
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392079; cv=fail; b=DBqG8z2nBdcJv6qFNOpjRU3NV4aeZyN3P0idL7EeSf1xlgxslKBMQL1PY0uv7GdlSAaXn7LjYruCUyl9k+l86ZarmC0kgQB5ggjSvAhUgkmN2GsBBidVhBa2oSs+p34S4o6aCdwCeC4uA3PKkODIKpXHJwXHlE+rjqZHF5REPgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392079; c=relaxed/simple;
	bh=EoeIg9BerCjAfxlXPqpfiCn3hEIDp6aphKeMTlvNYmw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nMJNEoIZkV+pOfOGeOKE7BVJkJvGz2gse/BCqVD0LOYRqqWQJ0JAvRPFRp1KJsa+VclCj7N9cd1b4ZJICVN1PVnECz/ZaZzcm65v1cor6Et6PSaaRg60hPNBiBAqLvcSFswY99Qiuabg8lDmxjBOw4k+L0iVyEKDS7xmxDW0ohY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q5mtzAGG; arc=fail smtp.client-ip=52.101.193.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q5mtzAGG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=le27xsUa3+tx/9Cw/YThxBjAyOc0EKITvKu7vRHJqd2xAG78Him5GRVww0vQx2ZgWQrf8aKQ2s+8M8JNWAClgHnvjmSLLsuhrk8Y/s88TzIQpjoLxFXS7vre1/CzZTUVl1V4UhoTiXzYes2h7pXLAqOzXJ4Zo8/PJAYkZWKcBIZlq105W7fJaW7PGwbtohRbc82fgmXH09cURkxM070XM76FQkPK/yz2iBvAmQ98I+XrtD7ROq1bQ8iCRoFunh+EvWI52l3FvPY3qb9cUZ82crVqZbwGJWtQ+HEY2o+X3i3bRwaF9D54X+Zp0Cy4eTdXH5DEIndb2NtzU3qNaiAj/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KWVH7szEP6zQ6aUzCW8g2bolzgihZ5FmJL9RN+gi4sA=;
 b=phbgfuBlNSxwAKSfiokS30r+vsFN7yaihoi5DsdXdJIzmbNOuJiSGHc/PR1PhNRhI22GGoPyDabsPojsnHuAhRL5PbFVubNplM1yZ5nnafAJNykKcCYlWMHdwhU02melQjr6r0p8UmFqIKjaTuTOrgZ0WmQyKdFg8O+GuDf6OfNYTl/JdpYx4Sxyjh3lfuUSxF1DKzTB7ijWOqti7hxKaYYbgfVJJ2j6Ry9iltAEJeK2owh9adCnFPLwISjCARKeVK5XR9izqgE5DoGBhvtMaPHWnTB252bpVqT/K3MmMVrEdYKGp3y7wgYtJVP0MQPFLPNfrnDoLiB7HfWfKaNx5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWVH7szEP6zQ6aUzCW8g2bolzgihZ5FmJL9RN+gi4sA=;
 b=q5mtzAGGzJ2QOJec126E8VjelXId60AjZOGQijBxFvwsJK9l5REb5vgyjQtbz8yEmrwZFNJ55kdopwMuzAYtbhKKWJd/WgoLj9uR6wevGgYXjyT/eOylDtW3OtgsBoKAXfHe/NurTcvn+VULMYOqs34AF7SXQZZeHUwHC2AtqkM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 06:41:15 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 06:41:15 +0000
Message-ID: <1354ad92-cb51-405b-8808-265f2f431f46@amd.com>
Date: Mon, 19 Oct 2026 12:10:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/24] iommu/amd: Detect and initialize AMD vIOMMU
 feature
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com, chrisl@kernel.org,
 wvw@google.com, wnliu@google.com, dantuluris@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com,
 guanghuifeng@linux.alibaba.com
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-4-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260930092344.5616-4-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0106.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:af::16) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|CH3PR12MB8403:EE_
X-MS-Office365-Filtering-Correlation-Id: d7191346-809a-4058-bd16-08df2dabf902
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|18002099003|10067099003|22082099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ZT5gX4gdTHmHTAnkxac+nCqopx9XtnmLcR8KEdFpJDx8mi1hpR06RJ/eIBbfkWBjmFEw4TGJNjZ0yGnWjVmAJKZlFor2qZEXYKlV3gvQMSCIGUgcYuC9IE9px2rimHagCR95ZX5UrPMMZhhGe0S8N34yiUsTd1Ezq/TwseVi2tnUWwX/MkuvFY5jfXMNhSC2tf9k1+unTa8ugkosQpETZEwlOmDDkhzCHVcjXHFpmNMXl4K9D/6XdeFSnWDPFTpW5sP17Jy9QuRsI5JXymAXZ16dskbpUPhx+C5rnSTI7Rb//ZYvw6PVGSDmjh1a+r0AzLUSz7Vz6AXBgI8TKqMiAeGHsB3d+qjZwXiMvjv7+rVPa83jtxDD3DUR+FDLLzT/bU6vKDRYVRWUfLIwbQ7Q/lxEPVYu5m0T6B809RsB1/zB9qHjxS9u6AsrksY0Af3AkFVymdSZ58PAAjsFLtIW6s/+qyhi2b7Zs+Nd4LefpfBYN6X3o72dvAVDaURZRp8T4Sfi7bUEtJxoxOxgzYa0PMkFTLmbYPcgJpu+FBkF+/n/k+rDb7KqcbnVPlWMXcFVN8zI/QPz+4UaMXihHd7QUkdnGrYNzbpDPewSa1d2Qakq6VoiBIkLS0ar3Nm2RINx+oa6T3XwGfB79lecZ057etaJdS8+w9WVzOZSxmEzvIc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHJiWnRFbG5XT1RNdnVWREhKWkJ5V3ZYa0ZWRFE2b2tuS294MmloWElBbjVr?=
 =?utf-8?B?WnFmY1labTRDYUhrMzhwcnc1RkhvcmFCcTFuZEpRbmlwdkFjVjd4MnU3TUJy?=
 =?utf-8?B?RUgvZ3RhTVlabnNxK2EwUVplZUpXbU5wbTlXSENwQTlzS3dodXNkdUkyL0pp?=
 =?utf-8?B?QTl0SUNaeno3T25tYURRQUpSc2VWelo4d3owSjBmbGpzMmFJdm5vMmRzM2ZG?=
 =?utf-8?B?ZU1XLzhrL0MvcHk4UGQwVkt5Y21QN09UVnhqSFpZdnhRNjJzQUYvZWVGVUE3?=
 =?utf-8?B?ZFBWd3dPc3B2YlpGdmR4aFd1R3FVcXJ4dHdBV1MrTzFOdlZjdFc1T1JBWHFn?=
 =?utf-8?B?b0JxNGxhK0krZHV6K29oelNySTEzSGJGbmtOQVpDb3dXbGN4Mkt0QnFmbzBv?=
 =?utf-8?B?T0Q1MkxWdlg5a3BhMVQ3RU1jelA3MzFwNGt1Mk1oR0duclAxdk5QYndibTZt?=
 =?utf-8?B?Ri95c2kwQlZiaFdQT09FeDhOTW1mSUFkckZBTlpDUDNwVkJseHhGT2tZcUJ4?=
 =?utf-8?B?R1ZrUnEwTUxWNTBIc2pYUkpRZlFkVWtWTTFOb1FONmhqN3BsbmQzcHN1Wno3?=
 =?utf-8?B?ZHZ1cHpKY2lCZWVuQjg2Z2haNUxkemt2MnlObno4bWxIWVE4cTJzaEVoV21S?=
 =?utf-8?B?ZFN6c3M5d0NPYSs1d0lSbENiK3RlcVozOWxCQnoxbEhmTEIzMEVvVUJ4dis3?=
 =?utf-8?B?OUNrbCtseFdCVkZxVWtmdjhpaHZrUktXcmlNTDQrU2lGVllJNlMxTHVpMVZ6?=
 =?utf-8?B?MFJ6MHNxeXZ0OEhTQjU3cDdaM0FyV0t6UVJOOXlna1l6c1RWbE5GWVgwbjY1?=
 =?utf-8?B?dlUxSkdjeTRIbUppZmJGeDNPdGJuZ2h2dkM4Tjlvck1WWFJXRXZHQ0ZRcXk1?=
 =?utf-8?B?VFVVcWh3N1JrQmxqeWlIcUpGZzVCVS9iK2RTN1J6VTArNktpeFVSVHVaL1V4?=
 =?utf-8?B?OFFhclhjM0NxSUN4K3BIY05rUTJINmgzMlJUaGFNSStkQlJLcXJTeUtLM0pH?=
 =?utf-8?B?RzE2ekFFbnUyOVl5TkprcndiTGNTdnFSZ2JDM3pScGdZT09xVnZQMkJ2ODR4?=
 =?utf-8?B?SHRVZ1hhcUhyeWFpL1BlaVNTeUtmYlZ0SlBYNFY5MldPeXhkWFVSYmJQQXJm?=
 =?utf-8?B?UFlmMnBmbWVWWGN6dG91Mk5PTHJRNlBHRzUyekJKZ3kweWFKeFVrQVY0cHhX?=
 =?utf-8?B?dXRZZmVBMkRKUFpOdjZ4eHprbkxBSzlIa2YwK0d1ZmVzaGFoRlhWdkVJbEc4?=
 =?utf-8?B?MGl6Sk1DKzU4LytHQTFiMXdxNjZmRUI5aCtTcXZhZG9mZzhyWE1rRlRjRVJB?=
 =?utf-8?B?Q1F4ZkZ0NndrS0hRWHNpSkJTNC84dEFlei9YYVU4QUVicnh6LzN6cVI0RE05?=
 =?utf-8?B?a3V1N25hRk1KcDRaTmcxYzh0eVk3dm5PYm0vbDN2S3B4ZDBpZWlXdlNCbkMv?=
 =?utf-8?B?Wlo4aVZWRWRyaGJaTnRiUUFRUElMaWd5MWN4WFBpOEcwcXRDQUpBTDZ2UTJt?=
 =?utf-8?B?NUhVRGFYd3ZmY25OMFoyUThjRkxjWldBK05Ba0VDZlRlRnI2YVpQZlFYNUZl?=
 =?utf-8?B?KytEOURHOUxETkQ4THQ3aGZZVnQvYVNtaHRrNmh2YkgrM21hRS94UjloUDAr?=
 =?utf-8?B?aXNNQjZRbXdzbVpERG1CNmtCRjYyNFZSYlpxOHQwbFI3WjgrZ25hZjNldGVt?=
 =?utf-8?B?Y0VPTzJtZFZPaWRXNHVwUWNUZWJwWThkdDBnbC8rQW5IQXl1d2hpRXR1dElD?=
 =?utf-8?B?d2lGaXRUdjNORk8ybjZGVFVWWU8vQnBNbDVINTRCQms4NjZpK2hORnMyUFUv?=
 =?utf-8?B?TWVCU3dUTEhUL0pONkFMY0pTRzNrZnpPTjFSa0ZlODJIV3FpYTNEVGRDOHk5?=
 =?utf-8?B?QWZjTGlNcE9aME5hV1VURUxPRk1xam1land6V1hyTytwL3NKek5DMWxpREcv?=
 =?utf-8?B?bWFHV1JzVW1pTnhSWW5rWGUxTHVqV0xIZUJ2clZPaVkwRGRXcUNGZXc0RzBq?=
 =?utf-8?B?S0c4UmFPTDlSWTZTOFoySlF1dTBjUUhYdWNWcmVodm5adDBMdW9xM1RWSmhF?=
 =?utf-8?B?L0RpK21td1IzTXdzVk8vaFZoQ3NxQ1U5b0pDRVFybWxIWXlYdkJ4RmNxVUNI?=
 =?utf-8?B?bjgySjR2QXRDM3hmRk5CVEx3Z3krdFZCS2VYL2p0SytZcHJiN1MwRVovV0dE?=
 =?utf-8?B?WHlCSGwySitoSkZsc215azRPRDhkZTdSNEhFeng2N0ZKalVZVmJvUDFTSFZK?=
 =?utf-8?B?N1RBLzNJRDltK0FJeXBZa2prMy93WnFCcnBMam5ULzVkYldHanlHblVGNkRW?=
 =?utf-8?Q?24cj3ta7PAY7A+9dIm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7191346-809a-4058-bd16-08df2dabf902
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 06:41:15.1347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECtRiYKY2GH2ZR5OQoRjtXucHYLAQTNcf9eCUdDM6oB/UFv1YgDJEDtMTqbQsh9BzrgcE+KovfiR26A1VrcTwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8403



On 9/30/2026 2:53 PM, Suravee Suthikulpanit wrote:
> The feature is advertised w/ EFR[VIOMMUSup]. Please see the AMD IOMMU
> specification[1] for more detail.
> 
> Gate amd_viommu_init() on this IOMMU's EFR[VIOMMUSup]
> (iommu->features) at the PCI init call site. Do not use
> check_feature()/amd_iommu_efr; that global mask is the AND of
> every IOMMU. Do not fail other IOMMUs when one instance lacks
> the bit or init fails.
> 
> Set AMD_IOMMU_FLAG_VIOMMU_EN when amd_viommu_init() succeeds.
> Log PCI names of IOMMUs that have that flag set.
> 
> Forward-declare struct amd_iommu in amd_viommu.h so the header
> is self-contained.
> 
> When CONFIG_AMD_IOMMU_IOMMUFD is off, the amd_viommu_init() stub
> returns 0 so a missing build is not logged as an init failure on
> EFR[VIOMMUSup] hardware.
> 
> [1] https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/Makefile          |  2 +-
>  drivers/iommu/amd/amd_iommu.h       |  5 +++++
>  drivers/iommu/amd/amd_iommu_types.h |  2 ++
>  drivers/iommu/amd/amd_viommu.h      | 29 ++++++++++++++++++++++++
>  drivers/iommu/amd/init.c            | 34 +++++++++++++++++++++++++++++
>  drivers/iommu/amd/viommu.c          | 25 +++++++++++++++++++++
>  6 files changed, 96 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iommu/amd/amd_viommu.h
>  create mode 100644 drivers/iommu/amd/viommu.c
> 
> diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
> index 94b8ef2acb18..e1e824b9c7b0 100644
> --- a/drivers/iommu/amd/Makefile
> +++ b/drivers/iommu/amd/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-y += iommu.o init.o quirks.o ppr.o pasid.o
> -obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o nested.o
> +obj-$(CONFIG_AMD_IOMMU_IOMMUFD) += iommufd.o nested.o viommu.o
>  obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 71113e860859..b2ae17e3df34 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -112,6 +112,11 @@ static inline bool check_feature(u64 mask)
>  	return (amd_iommu_efr & mask);
>  }
>  
> +static inline bool amd_iommu_viommu_enabled(struct amd_iommu *iommu)
> +{
> +	return iommu && (iommu->flags & AMD_IOMMU_FLAG_VIOMMU_EN);
> +}
> +
>  static inline bool check_feature2(u64 mask)
>  {
>  	return (amd_iommu_efr2 & mask);
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 704b4c8acdc5..688cd9240790 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -91,6 +91,7 @@
>  #define FEATURE_HASUP		BIT_ULL(49)
>  #define FEATURE_EPHSUP		BIT_ULL(50)
>  #define FEATURE_HDSUP		BIT_ULL(52)
> +#define FEATURE_VIOMMU		BIT_ULL(55)
>  #define FEATURE_SNP		BIT_ULL(63)
>  
>  
> @@ -465,6 +466,7 @@ struct irq_domain;
>  struct amd_irte_ops;
>  
>  #define AMD_IOMMU_FLAG_TRANS_PRE_ENABLED      (1 << 0)
> +#define AMD_IOMMU_FLAG_VIOMMU_EN              (1 << 1)
>  
>  struct gcr3_tbl_info {
>  	u64	*gcr3_tbl;	/* Guest CR3 table */
> diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
> new file mode 100644
> index 000000000000..864e7b283cff
> --- /dev/null
> +++ b/drivers/iommu/amd/amd_viommu.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2026 Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef AMD_VIOMMU_H
> +#define AMD_VIOMMU_H
> +
> +struct amd_iommu;
> +
> +#if IS_ENABLED(CONFIG_AMD_IOMMU_IOMMUFD)
> +
> +int amd_viommu_init(struct amd_iommu *iommu);
> +
> +#else
> +
> +/*
> + * CONFIG_AMD_IOMMU_IOMMUFD is off: host vIOMMU is not compiled in.

Nit: This is redundant statement. No need to have above line.

> + * Succeed as a no-op so iommu_init_pci() does not pr_err on
> + * EFR[VIOMMUSup] hardware.
> + */
> +static inline int amd_viommu_init(struct amd_iommu *iommu)
> +{
> +	return 0;
> +}
> +
> +#endif /* CONFIG_AMD_IOMMU_IOMMUFD */
> +
> +#endif /* AMD_VIOMMU_H */
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 8a410d4aa370..c80872ce0b60 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -34,6 +34,7 @@
>  #include <linux/crash_dump.h>
>  
>  #include "amd_iommu.h"
> +#include "amd_viommu.h"
>  #include "../irq_remapping.h"
>  #include "../iommu-pages.h"
>  
> @@ -2196,6 +2197,19 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
>  	if (check_feature(FEATURE_PPR) && amd_iommu_alloc_ppr_log(iommu))
>  		return -ENOMEM;
>  
> +	/*
> +	 * vIOMMU is advertised in this IOMMU's EFR[VIOMMUSup]
> +	 * (iommu->features). Do not use check_feature()/amd_iommu_efr;
> +	 * that global mask is the AND of every IOMMU and can hide the
> +	 * bit on mixed systems.
> +	 */> +	if (iommu->features & FEATURE_VIOMMU) {

Please add a additional check to skip vIOMMU if amd_iommu_snp_en is true.
Support w/ SNP needs PSP plumbing and not part of this series.

-Vasant

