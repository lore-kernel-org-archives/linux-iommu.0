Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010032.outbound.protection.outlook.com [52.101.56.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE1C3CC337;
	Wed, 30 Sep 2026 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774922; cv=fail; b=fLjfUTF9Rk9/Fk6zGjRGp1+0gpMkD1av97ELLrlConAUyBwvY+d3nH9bF4GCdInQtNj2PevbneF1pLPcjaUrbFYO6Uhk8LJu3QT6AGuZrKPPEVEO7/O/EgzGC0qaCJEsylUSYw3oKxcpEpxZfFHtK349BONq1I5Em1Sy5rBfhDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774922; c=relaxed/simple;
	bh=XhZxPPqU20lzFY/m73rmYJQs69CsK+/04eqP/0br6fs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sW32cL93wAKE8KOnfgj8/qEs52a18AZrgLaM7eWVa0GaToxxNgk2dJlHWwiigpZIi7vrRz9eUNOk4SN35IFrxJ6fhtaUsLHG6sOeM5pH3aQ9O84qnJMu1unK4DdaQg/thQVaiknqZOWCUqzq4YnJ9vfDaL0o6EXGn22sefqkQkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UUcumPy0; arc=fail smtp.client-ip=52.101.56.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UUcumPy0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Om/AXhlv+eYfvST2nUSYFw3EbIPlAibP5rPai1paou5Ysx4cL7M0B2MUnZ617zQCH1tUoed1wtSKIBzmY2Bg9Selyui5Mo0Jch/cfO2OWe/JFBpeIbi4Hls/mxZB6z5k7ZP5Pasqh80OIt7kAH08Wb83TUnAeAi5E0OtBfCowmFyDq+2eyWtxqekFil1EIldKxZEYN+7F7mqWT+0u+waS1fibVarLLyf5YM8pp/wtShBL5lFvjOqWOgv5lscAVCBRn7yY7y9NaLPz7UW+B2QgAtRDLKLgiIjZDcme2COKQFXp0AuW6mfaY59FIp8kLrvwoayQ5Wr/J022ld6vo5t0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74QhCDiONqUPb6qDd6tt5fDxBlZNqldWFP+U4txlXBY=;
 b=M7VSRkAvicIdC+Pfqg9EdoalzKCkWBG0C1+xsWSEGGJ45sHXjGp0IoO/ZCgoorkq/JHOeqLDFt46AwAD9aP/ZbpzOZ90WPcSDFqnrenOOJygaNbecrx5GAB27c0tyQbJ2/2R2KAqyCyEFld3S8RTBAmjupqHP2vhs9Yw6T4f0NFy4dw4fzJnJ8IOuL1jJAXuDFtVgRlxWAeau2oDP303Dyj0UTjS+eF0RQECY5Qfis6cihY4R07Cb+A3Z/KfwHfNyFLCs5gRdAT8vHAkkK1GEJ8bvsji1q4+KrvvotXQdCIH4L6SwN1b4QPK9nx9o40lyfUh4XBbOOyx+YS0hTREkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74QhCDiONqUPb6qDd6tt5fDxBlZNqldWFP+U4txlXBY=;
 b=UUcumPy0BYvtdOojDqRMbxskHsPm5uBsBYmhtRJN2Cr5nP5SNAalBjOZBxdBot2ftdXNw/44+9FvJB9/EoYMhNWENVecNqy0f2YAS8+5Lz7xEjJoCv9r72zwVZDctMIKLkrzd6c1Hd2THfX0lOlhefu+2Ooi3cCPGb4GLgxGWko=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 13:28:16 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 13:28:15 +0000
Message-ID: <76d51545-47d3-4ef7-bb10-551c898c0968@amd.com>
Date: Wed, 30 Sep 2026 18:58:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 04/11] iommufd/viommu: Keep a reference to the KVM
 file
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 linux-coco@lists.linux.dev, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Jonathan Cameron <jic23@kernel.org>, Kevin Tian <kevin.tian@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Samuel Ortiz <sameo@rivosinc.com>,
 Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Will Deacon <will@kernel.org>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-5-aneesh.kumar@kernel.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260917140159.1163281-5-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::20) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|IA0PR12MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e1cff11-a879-4e62-5893-08df1ef6aea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|23010399003|4143699003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	izQplLg1FbRRBI/awiS0tUo/0oLxEP/UU79gs0aEtx9Vbi+XncugdKWkKafnvoZHPuSICoK8oC5vaFWg9R/x1q9sb5vT+1IQuyZyP+7YPuiSjZUn5A+eJKPI0UES3dJtNBs/0WKjg++sypdIXK8OdvBp0n7H4TQ2615q+82xCVcEK3BZNXYx3rnzH09KCa0aIebGocBRlxM1tl7I2vQ9iswgcSnUHBbBbPqWnmi/UAGea4hUgTXdsYiMfmJOb4mIKptL0Hnx1zoNbZxMTmrvBjm32ZbKR629VdzWDOa/j59BKbY2G+OYjmKO8fZ0xUX1UCj8hCT2yTQ+rz4HUcXY4363rKtF8UYIGDwCx4SYAOAA8meWYEXQOj6AdL8XhJW5hMYzZ6Ih/oHwpMXGuGcLr/eHwixIEo16eWO+bmPx/VQ4nWIG5uyMLnRs3MhzBIBU8uer0LmGoRrCp4H/NkQ8L0WRtBuMJZllBe6oiwNHTH61dV1nyDYXoCCAfIOfK9Sk6Ov9MN6ub+B57lrQaRy2sXbjnaFQQXUUAC3uyGlx+i6h3mK5EJvVOBv7d6kU+N9ooymceurnxPOZMPZWwx+aXaBx/FcJV2oJC3rHweDNqWQKB1luS6xg/Ok+IyRe09snbvyxVlglDvo4Kwaf5lsNIdEfSBaXz+pesSvfiFx00dY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(4143699003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVAxQVp0SDZ5TnZSMWJrdHBaQWdhZFh6WE01azJ1UHpKNWlacW9mUVdvRVJ4?=
 =?utf-8?B?S21wU2p2S1Azd3d6S3ZmQ0pYQlBBVjI0LzZlaFFYdjJhNk1YZnFNa09OVkla?=
 =?utf-8?B?OWF6dExiNHc1WmRyQlBFbWw3U3Fpc3B6QmJtN2p5NUM1MllJckQ3TXVXaDFp?=
 =?utf-8?B?S0lLczVoR1dYUmo1ejA0WFBhSklVRDBaNjhQRU52TUFJZE1nY2NmbGp3YTlX?=
 =?utf-8?B?V1RQSUFhNlFQNFM0TE56cFlBNWpqQzM2TlpiN2thdWxZb1haNHBUc3JERFNV?=
 =?utf-8?B?K0hjRytVaFk5Y2l4SWEyS0NWY0F2YXJ5WnVnMHM0OUc5d0NCWVBKNHZQaHZ5?=
 =?utf-8?B?WldNVVkxNC9DSXo1NTRNZjB0VlRPZG1naWNOWjVUYnVKMVdhMzRlZjgvVlhM?=
 =?utf-8?B?TUg0NnNEcE04akgxWXI1V2FUR1p0UDJxalRvdjJmaTNIQ0QybGN0TXBYVDBE?=
 =?utf-8?B?eUJyR2ZnTlRnenc2eU9Sb3dqYlRGZThVOUoxUU9QczlIcXFTV0tZbU5QS2s2?=
 =?utf-8?B?VHFBbE4zeVJCQkVQWVIxWVN2L1NRczVITjV6UVhBQ1VtMmFzTWxSdllFemI4?=
 =?utf-8?B?RUcrZkZ4YnRQQVBockVPT25xZ0tUVE4yVkFmM3VJLzVCZWpKSDVqdUxpTlZP?=
 =?utf-8?B?WGMxc2pMcVJQc1NnN2xIWDFTUTQwWDFjSmZwc0gzMmp1UURQQ251cW1aeVEr?=
 =?utf-8?B?WjE0endibVBuTGVOMzZIL2RtWHl5cm82UlBPU0Vua09yanlnVmxTUVNhRkxK?=
 =?utf-8?B?RXpDRHdLblJqWWtJeDZoNzc4NStxemZ0S2oxSXpNSU1JRGV1WUxKajM4bmRR?=
 =?utf-8?B?bktpUFEyL1Z6VjB5MjMrWkNHV01ZU2xGdjJpaHdJNlNIalYvMVl4aHI5b3dj?=
 =?utf-8?B?YTU3RmJ3Q3Q0ZnF4NVl5b1BqWXJIQVFsbEFLOXJMVVVPdWtVOFR1NDJpdHpl?=
 =?utf-8?B?WEZ2WVZXZjUzSE5xZWJGY3poVXBEaytIdGVJTk1ZNnVWTlJNVXZEUUNqdDRS?=
 =?utf-8?B?dlVheGFMYTdDOEtXblkzY3BJalpZL2VWeHZvdmRWRkhHYXI0V0xDNmJEUUFX?=
 =?utf-8?B?ZTNJU1g2N2I3dUdtSjFQSXNBcHFhbFp5Q01qVUY4ZlVQbWN5blhHKzE5MVNZ?=
 =?utf-8?B?b1k0MXAwcTNvcGZORzczOXNnTEpKZ3VKelZSaWQvN1JBSStmdXJmakZBT09t?=
 =?utf-8?B?Uk51ZWlXbVZvTW1KandibHRWTGFaNURQeTcvSU5pUkhvV0d2VWd3WlhSUFAx?=
 =?utf-8?B?RlpzaUtXMFRwZEtKMzZHVldha0RWSkwwMkJvbmFZSVFpRnJsZVAvUVdMZStO?=
 =?utf-8?B?eUtqMUh4K25GN0hETEswUTZMbDJNZTlDTG9ZT09EUXF5b2Q4VTZJK1VWV2RF?=
 =?utf-8?B?WElQUHA2cE9rdXYvdFp1NHpETU5NRlU2Y1o2YXhFZzUwcE90bmY2TVFPenZE?=
 =?utf-8?B?RjFielpKU01wZkJKdjRzR1hJMWpBTXdGZnR2N1NMNnM4L3BmOXpneUd1UGRa?=
 =?utf-8?B?L1k4ZXh1S1B2OU5GOWd0S3JrOEExWHBTL0RSdnpiNDR4ekc2dFVCZFoxUURN?=
 =?utf-8?B?T0dTQmNnTzdKMS93YXdYdWdZcEVDUy9qenlLVTdLYU9tU1IzM0pPWjdzWEhu?=
 =?utf-8?B?WGZzZ0FuYnltK1BUbEJ5VWt0RFRJd1NscHJ0UFlUcVAycWIxMU9EbzNKRldk?=
 =?utf-8?B?cmFRSzFHT3lpQU80bVlXYlJ1d2Fsdm9GcWcvRjcrYytESWtKM0ZVTnZRbkF1?=
 =?utf-8?B?QjdjRnNFMU9LTyt0NXJVQ0JhWUljNk9YVHJtRUg1MEc0anRvMUltOGd4OTdJ?=
 =?utf-8?B?dVJmZHpRTVFnKzE2UEZVUmh5THlTbTlITzlaTXlMQTZZU3JsUktDSTJ4VXFH?=
 =?utf-8?B?NzNTTjZZOS9Xc29tOWM1NC9HWkh2M2p3NmpGN1R1U2dTRVY3cGdvNThvUDh1?=
 =?utf-8?B?eFpDcVVMb1BhVE11Rk9UakNNOTFVS1ZXL3JETUU3MlczRWZMMXNiYXRQaFY5?=
 =?utf-8?B?UFFHa2h4MWN5dFlrSk5NZjVuRDlnYndKYVd5UFEvQUhCQmhKWGVVdkJlV1M1?=
 =?utf-8?B?OGd4cVA5QXNuMWVvclExSXNNYWRqTTZuSjEvaXRjNXBSdGk0ZTd5UUdpMmVv?=
 =?utf-8?B?bFpkaERscW9jR0U5bUo4MDV4MGxCL2cyNitMbjNLeGtzaWxtMkNLaGhadHB5?=
 =?utf-8?B?aVl1ZUtScGxjSXlPU29MVjRXWFlhOEdKNkJvZjRvV3JwRjdFM3NWOTVDbk9B?=
 =?utf-8?B?bWxiYWRJM3k5SEV5c3hvYnpPZExHZjFNSUJ1bm1ycWU0WU1SYzl5YytDZXdN?=
 =?utf-8?B?RU1ManpGWkRabDNXU2FQQmpmWHJDTlBUQnVpTmtkWis1QitSVWZWQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1cff11-a879-4e62-5893-08df1ef6aea0
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 13:28:15.3688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iurj37tj58EevPiOintDuUvsaWM93uRqL1FltQeaC5ysYWJiHLzs8TweBNVWkevOttCZ2lAVHsiHKcaeuAIeog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974

On 9/17/2026 7:31 PM, Aneesh Kumar K.V (Arm) wrote:
> From: Nicolin Chen <nicolinc@nvidia.com>
> 
> The TSM vDevice operations need access to the KVM associated with the
> device's vIOMMU. Save the device's KVM file in the iommufd_viommu when the
> vIOMMU is allocated, and take a file reference so it remains valid for the
> lifetime of the vIOMMU.
> 
> Release the reference when the vIOMMU is destroyed.
> 
> Based on an original patch by Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> 
> [nicolinc: hold kvm's users_count]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> [aneesh.kumar: Switch to use kvm_file]
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/iommu/iommufd/viommu.c | 5 +++++
>  include/linux/iommufd.h        | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index 4081deda9b33..bf5d58d55939 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
>   */
> +#include <linux/file.h>
>  #include "iommufd_private.h"
>  
>  void iommufd_viommu_destroy(struct iommufd_object *obj)
> @@ -11,6 +12,8 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
>  	if (viommu->ops && viommu->ops->destroy)
>  		viommu->ops->destroy(viommu);
>  	refcount_dec(&viommu->hwpt->common.obj.users);
> +	if (viommu->kvm_file)
> +		fput(viommu->kvm_file);
>  	xa_destroy(&viommu->vdevs);
>  }
>  
> @@ -76,6 +79,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  	}
>  
>  	xa_init(&viommu->vdevs);
> +	if (idev->kvm_file)
> +		viommu->kvm_file = get_file(idev->kvm_file);

Nice! This is needed for AMD IOMMU as well!

Minor nit. You have to add fput() in error path.

-Vasant

