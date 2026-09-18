Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AFB4A7C87;
	Fri, 18 Sep 2026 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789736993; cv=fail; b=Nf/Shu0cxY2U65ChmeT+J2slIk4UpUL7Hq+tshNHo1ugA+OQR2DoZdf9l5pLu+iENW75xMe0m6NFSVtuKTsGxVS9krlGEzwB7LrzDZ+Q2xzWry/iPp6sASvEGrlkzIZWOLn1925TMc910Vhq7ydhl8EspfJXh5VMhdFWYrXw3Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789736993; c=relaxed/simple;
	bh=l6cs9n5JsG+t3kFrW1VMpuxkGvcITHCnnZQgY9Wcaos=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a3flqKNHgDXUfV16f949iD8liSXUXj3cFGSl44ldxoPQv8Xpz1XuThp29pRBr9Y593z/J1XfyZquTRo6c97kMFrhX2U5WmqmlffJEvy0YlXjKPuH66SW17uZRTFxGHfgJe9KRM9mkln1oNwj55YmAMdvsZNObh1b2lETxQ6o3Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y9vJkgre; arc=fail smtp.client-ip=52.101.56.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y9vJkgre"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EdQNv6X/DZStbPVKH4UbTU2vBw/3+00mRz68KryfpAYuGRG9S1g51nFw6Bl+O1dK/6PmXn8MpPKsFrD3nWsMigCUCHYuPV4AAit2BE9Jl+j7y6/dqCDpxso2/mCMuIJ1UEDsLWsfA59zDZEfrV+xMU2lMn0pVYRLwGrkNB8WtVfCZYTHIlRZP/F3LItfbkdFrkn0Y3HS0MxOsoD54Jn8SUwGHsWmx0fBl1f3YLpI6zBPwbQNWYByPWJZ56Cjz03MbVcnC9B4BFAm2wzD6BOysyGBNpTcDCr5tJI0bGcVCcxl2Ip0k8BFcvX6aIrW2MvGH+UEPeGIiyF5pJcTh29qZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6KuzDJOd0tpDLpilxEYe7gANcKdJQd/aTNCRIv/CDc=;
 b=Ut3eyIr4wsXHOycPFHiby/ilKrpMJUGNF3vl4p5vktbm9JaL3mI9PPBkmLLaNWJ2zKjJuCvWFLNuIiOhALBC+3uMg3MR+gA038T3891xK/JY5F3DcTjfvT5xJcoIMAIYspFrbpCKDLkkZncRrM+hJfzrI6wzDDvDHhFjB6JUpUJhfWAdjYRvsuKkBXBMX5TPSZygT5tWn7iw8woHM0vgYzpjYqWNUku7m9vlILBGYKNW3PxcA48WNbtbwsAGMufolXJGkZEqzoXnPNg53x15+wu32PPAIY2FPsjqhS1fMd/yiLEocVdt3z0//6nGIs3NDG03xU4Chjr+rcmGq3CqhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6KuzDJOd0tpDLpilxEYe7gANcKdJQd/aTNCRIv/CDc=;
 b=Y9vJkgreX58bV5w30v8NM6yg5MWZlENa0aW1aivvYB84C0pkbVlXRva5T97tXw62Us/oOzB0NfTMP5LL88ggzle4IpNnjocWt92q2vMdtaif3GR1eyXthIfPbqGvRywxEHL4d11K6gUzKFbkgnaCEfVBtWb0jHl1PrF7OI1rn90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10) by SJ0PR12MB6853.namprd12.prod.outlook.com
 (2603:10b6:a03:47b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Fri, 18 Sep
 2026 13:09:37 +0000
Received: from SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3]) by SA1PR12MB999228.namprd12.prod.outlook.com
 ([fe80::4dba:119e:8e7c:37b3%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 13:09:37 +0000
Message-ID: <f6fb7f1e-a296-4142-9b77-64420edabe64@amd.com>
Date: Fri, 18 Sep 2026 23:09:29 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 09/11] iommufd: Add the vdevice TSM request ioctl
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 linux-coco@lists.linux.dev, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Bjorn Helgaas <helgaas@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Jonathan Cameron <jic23@kernel.org>,
 Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Samuel Ortiz <sameo@rivosinc.com>, Steven Price <steven.price@arm.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Will Deacon <will@kernel.org>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <20260917140159.1163281-10-aneesh.kumar@kernel.org>
From: Alexey Kardashevskiy <aik@amd.com>
Content-Language: en-US
In-Reply-To: <20260917140159.1163281-10-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY8PR01CA0012.ausprd01.prod.outlook.com
 (2603:10c6:10:29c::11) To SA1PR12MB999228.namprd12.prod.outlook.com
 (2603:10b6:806:4db::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB999228:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e6ad043-178a-4a7e-9e50-08df158617b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|7416014|1800799024|3023799007|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZeyS4r0XTJWkvcIBLgl9XMvA+gVkdu4znI2Yzqb20sZXA7Y3EfN4LWPqqMCNuvfTYFQCcFnADJY8Jb4rZ9KCVR9B1ebKns2iG4VKfJG1boqif2pahmho+/+8uOJSOr9zVw7OzMAqvYiMLvAmw0F5t+YSjEiKQ0Zu/g/3LTWJoekLj6UNVj2Z3c7BJGeo7VLAyr471Lp9ZdnYCGtyqgtfEcOwqBu3ewhYvyut3F87zuckqPhEDKuoxvnm9BhUfFGg1Po6Gms7dFfmLeySSMgaNA/G+y+rdimrBvhMhafHCYsPyh8CIXoEc/pIY+WIv2j0pS6mA90oCS7AfnSS32RyXOnKfnJJfbpvejah4k3Gyf7Wj+505CM6yqMBeXAjnh+gZ0A0NyGjYX9xjSFsWMjjYMRyjrTf2oVXyH6prGNInI/lzYshzadMagYPSLSJmfhnNejN1cHY6gF7uYD2RzXEDhW4Ybpqg1ugkLbVwXrgQE5ewt/5pbLKUUQCaiVT4Dr4DnDLBkYbSQbyFWwEkYxRnHccNWBl56S3OBdi4JktwJDxMNmQPLVUwfyz1rGOAc9wttHrDokFHeki2Wdxoyrr6204bw97LguUiFOhG2lHeVMgyp9kIlVHYs6BJUOB8msiPJSew2fktonSTPBc6kRqmJAan2ealatYDp2ieduXd3E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB999228.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(7416014)(1800799024)(3023799007)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE52RWIyZFVMUWh2azg1SkEvb25zcEpTZCtPdWF2REZqeHdDOUpRSytQZUkv?=
 =?utf-8?B?Y1VpOTJ4d09Mck9JZjhOeDhnSDJPT2NhU2s4bjNMTFpnSm9iVmhCOWhsWldW?=
 =?utf-8?B?b1VaSU9BZkdubGVmM1NMejRXL3ViR3VncnpKVzZhTmtvWDU5T2pyYkgyeC9G?=
 =?utf-8?B?U29vVGhmRkNLWXdSdnpXRkRIbmorZ0xmWkszZUdrRTgyNGNZSVMreXdZSDF3?=
 =?utf-8?B?d09CazZCdUhPaGJOd1F4K2VnUnlVTVU1bVYxSmdlTDRtZ3VYT2E2UUcvaHRU?=
 =?utf-8?B?d0phRzNtK05tMW9RdnpjOXkvcDVTa1dYeFhZUmNkanBmSC96RGlvT0tpYllX?=
 =?utf-8?B?MVVLYlV6MUZxRkJVMzkwNHpVMUloUzc3ODRyYVFlYzcxbnE3am15dVRIRklw?=
 =?utf-8?B?WS8wT0ZJMjdvZ1JGYzZiUXk1WHhTcEFRMlE5MlJrZTVraWx5ai9YVDR5RzlX?=
 =?utf-8?B?cE9HT3BvTW1XcCtsSUYwbjcybW44RXZMMVEvRUgzNmVnOW1YbzUrcFZSdkpw?=
 =?utf-8?B?MUdFZ3E0UWdtdE1rSm9HWWpKQ1UwQ0R1c2MzRElqc3d3MFRVRUxBWHhlS1hn?=
 =?utf-8?B?VDk4OGJCSVN1T0Z6SEpQU3ViRHhxendodk51cExwQ0ZraWhRNWtZeDJnL215?=
 =?utf-8?B?eW9WY0JGRzFjRWFTMk43dlpCcmsyYTc3ZGdNMm83cUpoVXBweWw5WXF0VE9V?=
 =?utf-8?B?cHMyQ2pYN0ZmeXFlLzVzWUYveUlYajAxZzQyM2lNU2c3VkhQWHVBSmFiZnhQ?=
 =?utf-8?B?dllBZTdsL1k2M1FqQ3FvZm9wWnpvZUhyOUQ3NkVLRmlKT2NEblhvV0E4cGc2?=
 =?utf-8?B?eHNVeE5xN2lneUo5bDl2RXJjNzNidktnekljSU1WR0M5NlJ5UU9vdk5sTC9U?=
 =?utf-8?B?Qk5laEdiVHU4aUI3NHJ5cFE1ckVydmpNUitPeDJzdlZMTW9pRDdXMTJoZlA2?=
 =?utf-8?B?R2FqQXR1ZzJ2WnUwbzQwMDBwc2ZDYzZ2bGxrUW9PZFB5LzV3NFNEb21SS3Y1?=
 =?utf-8?B?MWR1RUozTTBHNVh1RkZuaDN4N0JTVW05NFFYNFAwUmdxMTB3eHF3a0RGRTR0?=
 =?utf-8?B?b25jY3czNXlRbG1CRUVNWmhxVWYrR0ZKbUlCTk9mSUpzeGpOazdwaGxpcXZG?=
 =?utf-8?B?QllUV0RvUDhpVGI1WHNaM0pxNHlWMEtHaVUxQ2pWNTZYM3JuRUI0ZEpyV2xY?=
 =?utf-8?B?d2h5RmJGWDhudlJOUzREUGcyYlBUK3N4ZWNEU2lEN0lpcmtDb2tWdnhFaTEx?=
 =?utf-8?B?RnRKMnMya0JadnRBR0JtaTlIbktmbE5nbGJSMDdmd2JhZ2loYWcycHVCUmp2?=
 =?utf-8?B?QXUxMFEvaEFSS3BLVjM2ajIwVjVyV244WjlMcU5jNGc1WjNxRXYvTTVMUWtw?=
 =?utf-8?B?VkpiTzdTQWMzUWJ6Y2EvSkhFSndydkwxUlVoZUhrQ3JBWWVRTDNsbWIxWE5h?=
 =?utf-8?B?TUFXNWw3ajZ6bkV3RnRhaFdMZnJoVkp2QVpyc2FDMks1d3kyTTF0RHBJVUMx?=
 =?utf-8?B?RVNENW1IeGVnbVVsREZMU21kNlh3NVFjRzl2NmhjUlpNbENkR3ZtcExIamND?=
 =?utf-8?B?NkNLMk03bWlQck1KMWt3WFV3U0U5eExZL0MxYnF5ZlA0dnFhNFJOSWN1cWda?=
 =?utf-8?B?dm9ONGtzVEFHd3QzZVdQRVNLVndQVnJIK3ZOdHY1QkhOTVlZSklIc255S1pV?=
 =?utf-8?B?NFV6TWdxd3BhKy9aeU5RQW1vKzlTVjFtUVBSUUJRSG5iSU9Cak9BZlp1V0gv?=
 =?utf-8?B?OUIvUTN4UVVJTmZwb095UFFobU1PQXJ6YmQ2VWt1bFl0d3FUa3lyWlIxd2FU?=
 =?utf-8?B?Q21NOVlQbTcrdXY2V1BGdWFvSTNSM1VXbXdFY2oyUDZrSlE3MjVJb0RpWVZx?=
 =?utf-8?B?Uk9mWG9kMVBBek5vNEowcTFiN3NCOFp4TkhNOVZpb0ZZbTJLcUlpZklKNWVq?=
 =?utf-8?B?bERKaDVSa2NlalE2RVFjTHdZNUNiNDhWeGZMZE5CV2hpRVIxUmtQUVZTaWZv?=
 =?utf-8?B?am1MMjhNUFlLdVhUa29HZUk2VVBlVVVMZXpxZ1hHWWo3SVBWb0VHYnVicE52?=
 =?utf-8?B?WTEvbDVDcGJjYnZ3K284U0hXY2VaeWNXM0lIRWNsQ28rODA0T1R2VnRubENB?=
 =?utf-8?B?YkJTNDQyRUNCS082d3FFbWk0R21CSlZKbFpGMEZGc290OEFkZUNHVXFMamh3?=
 =?utf-8?B?QTZQckdIZS8vRHowd0ZIRGxRMVFHM1BGV2NpMnJRRlR6U2ROVW1zcGNKVU9D?=
 =?utf-8?B?aWRXOEdYWVRnTVluVG9TMi9QTzJ0UjN5THhqT3dXcWpJSVRmZXRrNytldHQy?=
 =?utf-8?B?cjlpLzVYeFY4VGs2RnNhOHMwSlNwSWhva1A2NE43S1JCTU9wKzZEdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e6ad043-178a-4a7e-9e50-08df158617b5
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB999228.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 13:09:37.8153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NgcWB1vFaZ+QS6IpKxc6684QnunhE0aKpOHt9KWnBiR0YmoLy8kI2bWWmPNe4vx2ErcljOSKHOFICr81bnGxzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853



On 18/9/26 00:01, Aneesh Kumar K.V (Arm) wrote:
> A VMM needs to forward guest-originated TSM commands to the TSM
> implementation managing an assigned device. The IOMMUFD vdevice
> identifies that device within its vIOMMU and provides the appropriate
> dispatch point.
> 
> Add IOMMU_VDEVICE_TSM_REQ to send an opaque request to a vdevice and
> optionally return a response. Define common operation and guest
> architecture identifiers for CCA, SEV and TDX requests.

iommufd_viommu_provider_ops already knows what architecture it is, why bother with these identifiers? Thanks,

> 
> The ioctl return value reports dispatch or data transfer errors, while
> tsm_code carries the TSM-specific result.
> 
> Use sockptr_t for the internal request and response buffers so TSM
> implementations are not tied to userspace pointers.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>   drivers/iommu/iommufd/Makefile          |  2 +
>   drivers/iommu/iommufd/iommufd_private.h |  8 ++
>   drivers/iommu/iommufd/main.c            |  3 +
>   drivers/iommu/iommufd/tsm.c             | 98 +++++++++++++++++++++++++
>   drivers/iommu/iommufd/viommu.c          |  2 +
>   include/linux/iommufd.h                 |  5 ++
>   include/linux/tsm.h                     | 25 +++++++
>   include/uapi/linux/iommufd.h            | 73 ++++++++++++++++++
>   8 files changed, 216 insertions(+)
>   create mode 100644 drivers/iommu/iommufd/tsm.c
> 
> diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
> index 7ed46c286c42..105a54ff89f5 100644
> --- a/drivers/iommu/iommufd/Makefile
> +++ b/drivers/iommu/iommufd/Makefile
> @@ -11,6 +11,8 @@ iommufd-y := \
>   	viommu.o \
>   	viommu_provider.o
>   
> +iommufd-$(CONFIG_TSM) += tsm.o
> +
>   iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
>   
>   obj-$(CONFIG_IOMMUFD) += iommufd.o
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index eae607eb5d76..0c67f2e1f137 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -721,6 +721,14 @@ void iommufd_vdevice_destroy(struct iommufd_object *obj);
>   void iommufd_vdevice_abort(struct iommufd_object *obj);
>   int iommufd_hw_queue_alloc_ioctl(struct iommufd_ucmd *ucmd);
>   void iommufd_hw_queue_destroy(struct iommufd_object *obj);
> +#ifdef CONFIG_TSM
> +int iommufd_vdevice_tsm_req_ioctl(struct iommufd_ucmd *ucmd);
> +#else
> +static inline int iommufd_vdevice_tsm_req_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
>   
>   static inline struct iommufd_vdevice *
>   iommufd_get_vdevice(struct iommufd_ctx *ictx, u32 id)
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 8c6d43601afb..4a42cda0e8f8 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -432,6 +432,7 @@ union ucmd_buffer {
>   	struct iommu_veventq_alloc veventq;
>   	struct iommu_vfio_ioas vfio_ioas;
>   	struct iommu_viommu_alloc viommu;
> +	struct iommu_vdevice_tsm_req tsm_req;
>   #ifdef CONFIG_IOMMUFD_TEST
>   	struct iommu_test_cmd test;
>   #endif
> @@ -493,6 +494,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>   		 __reserved),
>   	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
>   		 struct iommu_viommu_alloc, out_viommu_id),
> +	IOCTL_OP(IOMMU_VDEVICE_TSM_REQ, iommufd_vdevice_tsm_req_ioctl,
> +		 struct iommu_vdevice_tsm_req, tsm_code),
>   #ifdef CONFIG_IOMMUFD_TEST
>   	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
>   #endif
> diff --git a/drivers/iommu/iommufd/tsm.c b/drivers/iommu/iommufd/tsm.c
> new file mode 100644
> index 000000000000..2fb51a86c5ec
> --- /dev/null
> +++ b/drivers/iommu/iommufd/tsm.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 ARM Ltd.
> + */
> +
> +#include <linux/tsm.h>
> +#include "iommufd_private.h"
> +
> +static bool iommufd_vdevice_tsm_req_arch_valid(u32 tvm_arch)
> +{
> +	switch (tvm_arch) {
> +	case IOMMU_VDEVICE_TSM_TVM_ARCH_CCA:
> +	case IOMMU_VDEVICE_TSM_TVM_ARCH_SEV:
> +	case IOMMU_VDEVICE_TSM_TVM_ARCH_TDX:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static bool iommufd_vdevice_tsm_req_op_valid(u32 op, u32 tvm_arch)
> +{
> +	switch (op) {
> +	case TSM_REQ_VALIDATE_MMIO:
> +	case TSM_REQ_SET_TDI_STATE:
> +		return true;
> +	case TSM_REQ_SEV_ENABLE_DMA:
> +	case TSM_REQ_SEV_DISABLE_DMA:
> +		return tvm_arch == IOMMU_VDEVICE_TSM_TVM_ARCH_SEV;
> +	case TSM_REQ_READ_OBJECT:
> +	case TSM_REQ_REGEN_OBJECT:
> +	case TSM_REQ_OBJECT_INFO:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +/**
> + * iommufd_vdevice_tsm_req_ioctl - Forward TSM requests
> + * @ucmd: user command data for IOMMU_VDEVICE_TSM_REQ
> + *
> + * Resolve @iommu_vdevice_tsm_req::vdevice_id to a vdevice and pass the
> + * request/response buffers to its vIOMMU provider.
> + *
> + * Return:
> + *  -errno on error.
> + *  positive residue if response/request bytes were left unconsumed.
> + *    if response buffer is provided, residue indicates the number of bytes
> + *    not used in response buffer
> + *    if there is no response buffer, residue indicates the number of bytes
> + *    not consumed in req buffer
> + *  0 otherwise.
> + */
> +int iommufd_vdevice_tsm_req_ioctl(struct iommufd_ucmd *ucmd)
> +{
> +	int ret;
> +	struct iommufd_vdevice *vdev;
> +	struct iommu_vdevice_tsm_req *cmd = ucmd->cmd;
> +	struct tsm_guest_req_info info = {
> +		.op = cmd->op,
> +		.tvm_arch = cmd->tvm_arch,
> +		.req   = {
> +			.user = u64_to_user_ptr(cmd->req_uptr),
> +			.is_kernel = false,
> +		},
> +		.req_len = cmd->req_len,
> +		.resp    =  {
> +			.user = u64_to_user_ptr(cmd->resp_uptr),
> +			.is_kernel = false,
> +		},
> +		.resp_len = cmd->resp_len,
> +	};
> +
> +	if (!iommufd_vdevice_tsm_req_arch_valid(cmd->tvm_arch))
> +		return -EINVAL;
> +
> +	if (!iommufd_vdevice_tsm_req_op_valid(cmd->op, cmd->tvm_arch))
> +		return -EINVAL;
> +
> +	vdev = iommufd_get_vdevice(ucmd->ictx, cmd->vdevice_id);
> +	if (IS_ERR(vdev))
> +		return PTR_ERR(vdev);
> +
> +	cmd->tsm_code = 0;
> +	if (!vdev->viommu->ops || !vdev->viommu->ops->vdevice_tsm_req)
> +		ret = -EOPNOTSUPP;
> +	else
> +		ret = vdev->viommu->ops->vdevice_tsm_req(vdev, &info,
> +							 &cmd->tsm_code);
> +
> +	/* Always copy the tsm_code as response */
> +	if (iommufd_ucmd_respond(ucmd, sizeof(*cmd)))
> +		ret = -EFAULT;
> +
> +	iommufd_put_object(ucmd->ictx, &vdev->obj);
> +	return ret;
> +}
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index 66bbd6e4571d..c462086ff5df 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -3,6 +3,8 @@
>    */
>   #include <linux/file.h>
>   #include "iommufd_private.h"
> +#include <linux/cleanup.h>
> +#include <linux/tsm.h>
>   
>   void iommufd_viommu_destroy(struct iommufd_object *obj)
>   {
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index 7b906e0d6400..f16b82034be9 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -27,6 +27,7 @@ struct iommufd_viommu_ops;
>   struct iommufd_viommu_provider;
>   struct module;
>   struct page;
> +struct tsm_guest_req_info;
>   
>   /**
>    * struct iommufd_viommu_provider_ops - External vIOMMU implementation
> @@ -199,6 +200,7 @@ struct iommufd_hw_queue {
>    *                include/uapi/linux/iommufd.h)
>    *                If driver has a deinit function to revert what vdevice_init op
>    *                does, it should set it to the @vdev->destroy function pointer
> + * @vdevice_tsm_req: Forward a guest TSM request to a driver-owned vDEVICE
>    * @get_hw_queue_size: Get the size of a driver-defined HW queue structure for a
>    *                     given @viommu corresponding to @queue_type. Driver should
>    *                     return 0 if HW queue aren't supported accordingly. It is
> @@ -225,6 +227,9 @@ struct iommufd_viommu_ops {
>   				struct iommu_user_data_array *array);
>   	const size_t vdevice_size;
>   	int (*vdevice_init)(struct iommufd_vdevice *vdev);
> +	ssize_t (*vdevice_tsm_req)(struct iommufd_vdevice *vdev,
> +				   struct tsm_guest_req_info *info,
> +				   u64 *tsm_code);
>   	size_t (*get_hw_queue_size)(struct iommufd_viommu *viommu,
>   				    enum iommu_hw_queue_type queue_type);
>   	/* AMD's HW will add hw_queue_init simply using @hw_queue->base_addr */
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> index f38d6fcf9cc9..39bad60b4815 100644
> --- a/include/linux/tsm.h
> +++ b/include/linux/tsm.h
> @@ -7,6 +7,8 @@
>   #include <linux/types.h>
>   #include <linux/uuid.h>
>   #include <linux/device.h>
> +#include <linux/sockptr.h>
> +#include <uapi/linux/iommufd.h>
>   
>   #define TSM_REPORT_INBLOB_MAX 64
>   #define TSM_REPORT_OUTBLOB_MAX SZ_16M
> @@ -139,4 +141,27 @@ struct tsm_dev *find_tsm_dev(int id);
>   struct pci_ide;
>   int tsm_ide_stream_register(struct pci_ide *ide);
>   void tsm_ide_stream_unregister(struct pci_ide *ide);
> +
> +#ifdef CONFIG_TSM
> +/**
> + * struct tsm_guest_req_info - parameters for a guest-initiated TSM request
> + * @op: operation for the guest-initiated request
> + * @tvm_arch: guest TVM architecture
> + * @req: request data buffer filled by guest
> + * @req_len: the size of @req filled by guest
> + * @resp: response data buffer filled by host
> + * @resp_len: the size of @resp buffer filled by guest
> + */
> +struct tsm_guest_req_info {
> +	enum iommu_vdevice_tsm_guest_req_op op;
> +	enum iommu_vdevice_tsm_guest_tvm_arch tvm_arch;
> +	sockptr_t req;
> +	size_t req_len;
> +	sockptr_t resp;
> +	size_t resp_len;
> +};iommufd_viommu_provider_ops
> +#else
> +struct tsm_guest_req_info;
> +#endif
> +
>   #endif /* __TSM_H */
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 0425d452d41e..43ed082a9421 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -57,6 +57,7 @@ enum {
>   	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
>   	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
>   	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
> +	IOMMUFD_CMD_VDEVICE_TSM_REQ = 0x96,
>   };
>   
>   /**
> @@ -1351,4 +1352,76 @@ struct iommu_hw_queue_alloc {
>   	__aligned_u64 length;
>   };
>   #define IOMMU_HW_QUEUE_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HW_QUEUE_ALLOC)
> +
> +/**
> + * enum iommu_vdevice_tsm_guest_tvm_arch - guest TVM architecture
> + * @IOMMU_VDEVICE_TSM_TVM_ARCH_CCA: Arm CCA TVM
> + * @IOMMU_VDEVICE_TSM_TVM_ARCH_SEV: AMD SEV TVM
> + * @IOMMU_VDEVICE_TSM_TVM_ARCH_TDX: Intel TDX TVM
> + */
> +enum iommu_vdevice_tsm_guest_tvm_arch {
> +	IOMMU_VDEVICE_TSM_TVM_ARCH_CCA = 1,
> +	IOMMU_VDEVICE_TSM_TVM_ARCH_SEV,
> +	IOMMU_VDEVICE_TSM_TVM_ARCH_TDX,
> +};
> +
> +/**
> + * enum iommu_vdevice_tsm_guest_req_op - operation for guest TSM requests
> + * @TSM_REQ_VALIDATE_MMIO: Validate MMIO for the TDI
> + * @TSM_REQ_SET_TDI_STATE: Set TDI state
> + * @TSM_REQ_SEV_ENABLE_DMA: Enable SEV DMA
> + * @TSM_REQ_SEV_DISABLE_DMA: Disable SEV DMA
> + * @TSM_REQ_READ_OBJECT: Read a TSM object
> + * @TSM_REQ_REGEN_OBJECT: Regenerate a TSM object
> + * @TSM_REQ_OBJECT_INFO: Read TSM object information
> + */
> +enum iommu_vdevice_tsm_guest_req_op {
> +	TSM_REQ_VALIDATE_MMIO = 1,
> +	TSM_REQ_SET_TDI_STATE,
> +	TSM_REQ_SEV_ENABLE_DMA,
> +	TSM_REQ_SEV_DISABLE_DMA,
> +	TSM_REQ_READ_OBJECT,
> +	TSM_REQ_REGEN_OBJECT,
> +	TSM_REQ_OBJECT_INFO,
> +};
> +
> +/**
> + * struct iommu_vdevice_tsm_req - ioctl(IOMMU_VDEVICE_TSM_REQ)
> + * @size: sizeof(struct iommu_vdevice_tsm_req)
> + * @vdevice_id: vDevice ID the guest request is for
> + * @op: One of enum iommu_vdevice_tsm_guest_req_op
> + * @tvm_arch: One of enum iommu_vdevice_tsm_guest_tvm_arch
> + * @req_len: Size in bytes of the input payload at @req_uptr
> + * @resp_len: Size in bytes of the output buffer at @resp_uptr
> + * @req_uptr: Userspace pointer to the guest-provided request payload
> + * @resp_uptr: Userspace pointer to the guest response buffer
> + * @tsm_code: TSM-specific result code returned by the TSM implementation
> + *
> + * Forward a TSM request to the TSM bound vDevice. This is intended for
> + * guest TSM/TDISP message transport where the host kernel only marshals
> + * bytes between userspace and the TSM implementation.
> + *
> + * The request operation is guest initiated. The TSM backend validates
> + * @tvm_arch against its bound TVM architecture assumptions.
> + *
> + * The request payload is read from @req_uptr/@req_len. If a response is
> + * expected, userspace provides @resp_uptr/@resp_len as writable storage for
> + * response bytes returned by the TSM path.
> + *
> + * The ioctl is only suitable for commands and results that the host kernel
> + * has no use, the host is only facilitating guest to TSM communication.
> + */
> +struct iommu_vdevice_tsm_req {
> +	__u32 size;
> +	__u32 vdevice_id;
> +	__u32 op;
> +	__u32 tvm_arch;
> +	__u32 req_len;
> +	__u32 resp_len;
> +	__aligned_u64 req_uptr;
> +	__aligned_u64 resp_uptr;
> +	__aligned_u64 tsm_code;
> +};
> +
> +#define IOMMU_VDEVICE_TSM_REQ _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VDEVICE_TSM_REQ)
>   #endif

-- 
Alexey

