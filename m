Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D4B39AD3B
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786349607; cv=fail; b=eYG+lUPeGnEQtEAp2Vh8iezWcxj1Sk+Y0dAbWcPm4ZiU6TnU/2gV4TeQM8coVD+z9099arZvjHUetgfuRbDwMR9u4Sd/zP5wfQkwlIWJGEiKAIUSuX86tYlp0NWAtDwvhZMpxpuwBOANg8r2caPCg7XrA5YDkz5tUpRdOVUp8cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786349607; c=relaxed/simple;
	bh=oMklM2NPu88zy6tKyuVmBpOFGNlOuulAYV8RfD8RLck=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UvJyYZcDS8TPLXFDpzeqsiBvQdql5wcQY1r6EWYBkkjgZWVnQ26/8rJcL07QlxywrpzgG+zAU52+2J9OPSn20b8M6k2IXnLpkVdf8sSH9oR5C/g3HaF+hZjkRY6TnI2Fd+4qWzWDjsgbHV5BRPNknGaRK5k93OJ4bOL8vIM/fJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CjxilNTW; arc=fail smtp.client-ip=52.101.61.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CjxilNTW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3oWzCMftEX32Fi8joBFB7VaGZrINqiz8/B12SVtP/oauMOCZQs4qyKcebAGbvKtcekAuRkbdn66cQ2nFQsI5ehEqflQDuHxy7V4P+WhRHoc1dWvmCIiqKn1Vo0EnwkUbA71DAiJX0MxQfFkTG48amMCqA86ByyM5BK3GFIAsG7gf7P23kiFS4xKtsIZBoRVVTBFjSYn6K/rhblr41JgsPik0fqAjEcEwGqvgAPXdQZ7ilgM6Ev8rdu9KfRttmHghiTGSAxkTR/a42ozanN+h5had94CC7UCihhpE8mrtvhRyoACJsjwhbDMphqac0MtDOY5zwKYsLHBJ0G9Ms72Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFIiYh7gM00l2H2FsTIClKumf92dRI1TMbNB8ShK004=;
 b=GKXxIgHCOsmH5ZCma5VWav/CJFOrd62DHf1wNCyz1z8aSMzYvDBmQXrlcQjiyVSykQwhc3Uf8unT6LqdbYCSOfL6QUzkl7Ksuh/TIC4wLZOp1elDZJb4oKgABocEAQzqKfaIwvArx1yE5EgHAqdSWWj1uiPlBNx1gCbCBADu2PfnwKtF/7ncZMK/0iBoJzVbVAm01lV5GdFWLJ4QtYstr+iQW3vIZQ5dekyIe0Aq7M4vUNGesmsq2ZrgDpb5cB7JeiWJ0y/O4zD00/OmrybG/8vzbmRNUM+e+ZgCuivtTocmxqZOBDNPl+TPJjATUK0zPEmfY5zR10emFJNsJVT8lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFIiYh7gM00l2H2FsTIClKumf92dRI1TMbNB8ShK004=;
 b=CjxilNTWxFBw9Nw3kOlAWF2sKEw1Z97RrWUjnmlQ/kNnW1H62cyEsPaG4B14nC7xmTKV6Q5SQh0TRRVDDBOo0v3SVDDDSTGBHGsBKkKqTYSgziFIrlDFxj1X9xA4BdffE/yulnwBOpNykFFdGI1oA/nHKirmHWEQrg1fRPo46zY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 DM4PR12MB6038.namprd12.prod.outlook.com (2603:10b6:8:ab::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Mon, 10 Aug 2026 08:13:22 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0292.018; Mon, 10 Aug 2026
 08:13:21 +0000
Message-ID: <13fe61ea-fa05-4eb3-9ae0-1a1de261ea0a@amd.com>
Date: Mon, 10 Aug 2026 13:43:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/24] iommu/amd: Detect and initialize AMD vIOMMU feature
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-4-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260727132913.22475-4-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0342.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:21f::9) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|DM4PR12MB6038:EE_
X-MS-Office365-Filtering-Correlation-Id: 083192f4-4a39-43c5-5a4f-08def6b73df2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|56012099006|11063799006|10067099003|6133799003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yw2Dn0h/gvrNiHvP49+O+afst7bV43+mIBp60edR8+NZ+vttzrIGw+uMWNJwmYYPpHQ4STwAOns2IgXF56cspNze4gAaRk1CxTteOx5flWKERdhnLnU+chNY7JdylkNVkvnY0uBj2SItgE8aLhBZkA68T1zALlTWIwt9HZC+denL4ILgGa1K/uAcKHqz5UioECzZYZxDPwtkOvlowc0y4E2CyYLlZVSewRJO35e3LU3KAR4x6tmOQNOVkVTl+g1FFiIVKU+yaQi70X1HMIWNk9k8eeTqS7Sr2YeqNmac2QksD3foMr8wDXCNLGcni+ePKS7wYgIj13mqJMDc1f5MjJdNsVkGC6CAPlMCkfkLk44YfTGQFZSnDUAhqbWBXVcnAkTX4fxcXcB2cTEwPUEoyE4guljUHtwaavFQjB8AECmgnFWTXRgBZgKuJR1LuBD5NNYY0KB/lzTfoUWRH84tA3E8uzR1vamLlJKbS1ULvotbL+wselmHtjTcph9RzURvb7i78AarGYWT/2pvugQN2QMAysYpRwyck9JA1Z5YJB7kAhkIdTBtSicyrw+7B05lWbfbKzCr6Q3rfuC3IJhq0QWHkHo+AtefQ/D9cJcroIDc97IzaZoLUWJC/4GfPKpfGTszHJl/lp0pZ7Q/m2Vx6XeIqXd+9BONlcyrPuLP+mI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(56012099006)(11063799006)(10067099003)(6133799003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bC9XUEFCSVFBUHk0WUt0NHJveWZxUHZDWDJSbVZ6aXZ2RWJ2U1hiejVRdnph?=
 =?utf-8?B?ejF4WTE2NUxpTi82ZFNTY3IxWTFvbitleXBxUmp1Si9Dcm14VE04Q0U0SmI0?=
 =?utf-8?B?eTMyYVU2NUcvY0o3Nm1CU3FmRFJiOUdscjZoV0dqSGRJaGZTcFRoZ0ZmQkcz?=
 =?utf-8?B?bCtjeUszL1hxTmRKcXZOMVI4cER4UnNsWllYNFRaQ3FnbHVLbVpQM1Q1NGlt?=
 =?utf-8?B?SW1oV0dCTWt2VDE2ZnNhcWxIYU5uaWtHVHlPM3cwakw4UWk2aEVhUUx2VE5w?=
 =?utf-8?B?cGhtVVZuTHFEOGtFOHVuK1R2ZnlOZjMyb3pUYkw0N0dIbDlwL1AzaTdzejRR?=
 =?utf-8?B?eDdmV3lGOUl0OWU4M3VzZjJmMzMwRVBNMmNleWVMc1NPY2taeHMvZEFzZFdx?=
 =?utf-8?B?eVZHK05sTDF6ZHRLRE1ld05vbEltT3RLdm1LNFRMS0RBRUl6RFJnR3psSnpy?=
 =?utf-8?B?QmxMU1VZQ2I2YUxsT1MxcVhGUWpLZVlnS3F0RUlYWW41TGoxSmN3dEM5R3pW?=
 =?utf-8?B?MTFjUU9ONFZ0TGhjYUQycnJLL2Fsd2F0MklmYUFCQXhwanVPZlg3aXo3Nm9Z?=
 =?utf-8?B?UnJpa1Q5dTFCd0Nxd1laQm5lMlZCWmFTWXZYNkFwT3JvejV2c25JNUF3SVpw?=
 =?utf-8?B?alh1WXU1anYwS3JtWDhaaEo3eXZFblJWWnQ1U1JCcHpoa1p3ZWRYcVZPaEZY?=
 =?utf-8?B?VG0xQndaaFE4NVRYb1hqSVNHSkc1aFVRYnV3UFRpR2FQcVQwYk9iVDRXbnlJ?=
 =?utf-8?B?UVhCblRZdTJsTjZERVlPcnIrV2N0ZWxkT0VCazdpVWIvTGt1dWtFNXJuc1lr?=
 =?utf-8?B?dkVFSkdGZmdKVTI1YWpFOUpGT3Z6WkNMZmdwbEJGUW5VUHJLakJBclI2NTNP?=
 =?utf-8?B?MzF4UXJtNlZ2UFoyY1FaN1hFRHNJNlFqNG4vejlMSTl1eFRXUC9kREI2YkdC?=
 =?utf-8?B?V09xVk4wS0I2dUlSM2RNeDcxOW9QSTZhMjFPaytsU3hUUEdURFUrYkJlMmY4?=
 =?utf-8?B?emN6ZENqQ21vZHBrRG5qWE1Zd3BKT3ZNZEdrWm5ud3AvWjJ6M1FDQ0pOQTk3?=
 =?utf-8?B?c1dZM3NiN04vMytGc3VLYjRYNUxRbmtGVkF1N2JsTlIzU1pXMFEwOXdUb0ln?=
 =?utf-8?B?WUpjRDVLejZsME5OdXo4ZVNYbHJjZ2x1VjR1QzRSVXdrTzRNbVIrWWNselVV?=
 =?utf-8?B?cWh3dFlmSmVkR2tpVnc5Y0lXOXQrN05qME1HQWxaL2ozeU5sa29GU250Vkha?=
 =?utf-8?B?TDdhajVpQmRrdk90T25QSmlTZDFIVmZWdk9YZisvMGo0aEdGVWZwNmtXVHhI?=
 =?utf-8?B?TTBvcXduL2ZDcWlpdFMyNklHUkNUMmZKZG5NQnFlSVp3NFU1QjVZYnZyS29j?=
 =?utf-8?B?OHFnUVFWQUNRMjVxSUM3emM5YzVmbHJYY3dMK0RuYzZWNXpMWU9Obm1ydXZD?=
 =?utf-8?B?cGo3Um92bVdtWWFGdGQxUURpbU1UQjNSRGw2cFFxMGJUUERlckZVYzZLNXZW?=
 =?utf-8?B?N2VvT2NvblVxV0QxVUVyR28xbzVra3crMWlFVEtzcC9LRGdpV3hieUk0SVo2?=
 =?utf-8?B?ZFlVZEl6K0J6dTQvVmZEY092dDZtczgvbWJMNzZ4WHQ1LzFOWC9sSTM2dk1W?=
 =?utf-8?B?UnQwTmJHUUoxL2k4cStjdERDZ2luUEczQUVVa0FQMG9VbE8wNUlTQ05QUWxU?=
 =?utf-8?B?K3IxOTdHVWRrMlVuZTc1ZlFtTnJneTF4VFlXUW9sVmRjZUduWkJ1MjZHeStk?=
 =?utf-8?B?NTVkaFNUdE9FNEZ6eTE3U0tMbEZWbjkxV25wbnEyMXhQeWU3aUJ2Z0daY0Ju?=
 =?utf-8?B?anJFZ083KzlIVnpZM3ltKzR0L0ttL0g0QTA0YTlTT3U5OURCU2FnNTF1TGEz?=
 =?utf-8?B?aGd3bEt4UkI4VTFvcEp4MnZtci8rdHFMbjNJM0kyWm16OU5vT2hwSjA1Y3Z2?=
 =?utf-8?B?TU9CR2JicUp4cVd4ZGhNK2ZyVU41R1A4OHlUZ0VXd2JwZVpTMUJJUWlCSUhT?=
 =?utf-8?B?bDB6Q1BSMlpRbktodEJyTnk1U001ZEt1eFV2SEEvM3VxS21vM3pUbHYxQUhQ?=
 =?utf-8?B?cnB4SHh4Q2psVE9veDZPMmM4M1B0OXkrdWJ2azV1NWNzNWFCVENoL3V6UkxV?=
 =?utf-8?B?YWNld25GZGJaTG1wSkwyUFRFRENhVW0yYTkwaStwTWFyZUhTdEhQQ0EwR3Nt?=
 =?utf-8?B?U2RoL0dSdUk3OFVlcm0wcFdWbStFZmNLZlFLTGVuSjRVSkVWS0NCZ0F4NlVN?=
 =?utf-8?B?TzV5Qmt6MXhZQ3RhR1dvREdDbDNzSXFSRnpjc0IyN2luSDhoVm11WmphK2FS?=
 =?utf-8?B?ZU5pMlY5d1grK0hWVkxYT1lYWjh4dnJ2WExCTFBVWXJIZmZxWG4vZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 083192f4-4a39-43c5-5a4f-08def6b73df2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 08:13:21.4194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyoX904ZyxwOhTD2I2MZANWAtqONL+wSXZTyC0AZbZ6YAPX3DGr2AnBCDDDzw/24ie6JQsAaY+7QY6gUU/GKrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6038

Hi Suravee,

On 7/27/2026 6:58 PM, Suravee Suthikulpanit wrote:
> The feature is advertised w/ EFR[VIOMMUSup]. Please see the AMD IOMMU
> specification[1] for more detail.
> 
> Introduce a new global variable amd_iommu_viommu, which is used to
> control the feature enablement in the driver. Currently, the feature
> is default to disabled. Once the feature is fully supported, it will be
> changed to enabled by default.
> 
> [1] https://docs.amd.com/v/u/en-US/48882_3.11_IOMMU_PUB
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/Makefile          |  2 +-
>  drivers/iommu/amd/amd_iommu.h       |  2 ++
>  drivers/iommu/amd/amd_iommu_types.h |  1 +
>  drivers/iommu/amd/amd_viommu.h      | 22 ++++++++++++++++++++++
>  drivers/iommu/amd/init.c            | 15 +++++++++++++++
>  drivers/iommu/amd/viommu.c          | 29 +++++++++++++++++++++++++++++
>  6 files changed, 70 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iommu/amd/amd_viommu.h
>  create mode 100644 drivers/iommu/amd/viommu.c
> 
> diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile


.../...

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
> @@ -196,6 +197,9 @@ bool amdr_ivrs_remap_support __read_mostly;
>  
>  bool amd_iommu_force_isolation __read_mostly;
>  
> +/* VIOMMU enabling flag */
> +bool amd_iommu_viommu;

may be add "__ro_after_init" ?

> +
>  unsigned long amd_iommu_pgsize_bitmap __ro_after_init = AMD_IOMMU_PGSIZES;
>  
>  enum iommu_init_state {
> @@ -2188,6 +2192,12 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
>  	if (check_feature(FEATURE_PPR) && amd_iommu_alloc_ppr_log(iommu))
>  		return -ENOMEM;
>  
> +	ret = amd_viommu_init(iommu);
> +	if (ret) {
> +		pr_err("Failed to initialize vIOMMU.\n");
> +		amd_iommu_viommu = false;
> +	}
> +
>  	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
>  		pr_info("Using strict mode due to virtualization\n");
>  		iommu_set_dma_strict();
> @@ -2281,6 +2291,9 @@ static void print_iommu_info(void)
>  		if (check_feature2(FEATURE_SEVSNPIO_SUP))
>  			pr_cont(" SEV-TIO");
>  
> +		if (check_feature(FEATURE_VIOMMU))
> +			pr_cont(" vIOMMU");
> +
>  		pr_cont("\n");
>  	}
>  
> @@ -2293,6 +2306,8 @@ static void print_iommu_info(void)
>  		pr_info("V2 page table enabled (Paging mode : %d level)\n",
>  			amd_iommu_gpt_level);
>  	}
> +	if (amd_iommu_viommu)
> +		pr_info("AMD-Vi: vIOMMU enabled\n");

pr_fmt already prepends "AMD-Vi:". Please remove it from above pr_info.




>  }
>  
>  static int __init amd_iommu_init_pci(void)
> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
> new file mode 100644
> index 000000000000..f4b5f96d4785
> --- /dev/null
> +++ b/drivers/iommu/amd/viommu.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Advanced Micro Devices, Inc.
> + */
> +
> +#define pr_fmt(fmt)     "AMD-Vi: " fmt
> +#define dev_fmt(fmt)    pr_fmt(fmt)
> +
> +#include <linux/iommu.h>
> +#include <linux/iommufd.h>
> +#include <linux/amd-iommu.h>
> +#include <uapi/linux/iommufd.h>
> +
> +#include <asm/iommu.h>
> +#include <asm/set_memory.h>
> +
> +#include "iommufd.h"
> +#include "amd_iommu.h"
> +#include "amd_iommu_types.h"
> +#include "amd_viommu.h"
> +
> +int __init amd_viommu_init(struct amd_iommu *iommu)
> +{
> +	if (!amd_iommu_viommu ||
> +	    !check_feature(FEATURE_VIOMMU))

If check_feature returns false, then return -ENOSUPPORT so that called sets
amd_iommu_viommu to false.

Also how about renaming it as "amd_iommu_viommu_present" ? Because following
patches defines another structure with same name. It works, but add confusion.

-Vasant

