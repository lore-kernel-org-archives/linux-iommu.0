Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013000.outbound.protection.outlook.com [40.93.196.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6799A1DB95E
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 00:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780446671; cv=fail; b=Qhr/W+BBJhmR6ci9u9v1w2i2JjoJ5kwCPUzr1UrQ/n1ytQCNvAjFlUC/9QFrDPFKF2e4NexgsvXsvz0DqYoJ3uh3RHx8vMqFNKWHLh7lgZOX0SGYTrA+KD3ZzBWnyvY2IpLFRlSuSaNovoJcnyhYl603O33R6csbII24nc1c19o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780446671; c=relaxed/simple;
	bh=MUJ8BVx6CJDX6a7UlDcw25miOXqZQIQYvTgMO33Yuf8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kWnSFg0ML2h1+cPCLshYjrA6B/5dTxUe06shwrdwvJX/5FyP7K8q4wEkWf2BH4/Ruf03mJ4nnzWF9jZP7C1GffNObfPKu+F1u/4H73LRqL5dxKcuLQ9fwo3T2UvEZSizSCZpTPxvblgUEMJ2sjZ5TsE1YoeNyMNGNIOgz2ZFWXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FEaHTn4N; arc=fail smtp.client-ip=40.93.196.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FEaHTn4N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gg191iNrgirlycxwUeCyxBgtNKNorwLp1YuuaVHSypvQDUtWW9OVelfXI1lYv3ywRlexLtn10fSXtlqfqnLOZO12+K5kWfhiI6Dq6Ir9hja68NyfmrNG2ZxVJxO4PfbBN/1i4oxdB1YDq5mp6ITPAQDsGjnHNMnMblkF1dxETl2Wv4C7RKdJ4iEat+OydR7s7Vkyb2U8JkCmHOmE+zi0ZF+mrYVp2a5/RGI9+dC6ck6RI3st7HTWhG8hBNaEORKuysiRR5lc7Bk77PrDOzNNNGjcOdq5t50Byl01FDAOWmxwG2Hy8oAwAMCo4S1j7hrIxOmvDYOwTe8EaugM76CftA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2rUhUaOAEqkW272M7gEVGR+Yu4hOJ+LEbW/zL5Yg5xs=;
 b=MoK3eeYCOgVZDDKxh4/KNFtvOzBwgSMTiv6ezT1aXxpmAjjpn/aWOoG9aoyKk4hOF86mYQIsaCifDABN9kwZtNiUybmswTOV+wlUoa21oXPyjlGgqCk/gcBzg/EM69lsMHRcQXNLApVy6cxq8uvQws60YVJuxShHIfnTjcNC4sKBMfRbMv2vcpap+xQeznAY/TJgxh2XlpkPzkUr2tF5NdG0T2ZqxAXEyPwLjUBiRoyQ3ThFF2O/HYwY45evQqn1Hkciii5+ERw6Rw9Xy/fM2RanQUYJNthQK2rJ/Ub3Ea/rGK+5nm6brNRHA2xjFeRqPvhsmz9v+WF39ZmGEcVwdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rUhUaOAEqkW272M7gEVGR+Yu4hOJ+LEbW/zL5Yg5xs=;
 b=FEaHTn4N63UsnoSTpmUpTpi5dPrIkob7v8bulei2MvjjIFaDr2GMIR6n4ruo/ErO5csj7KFQqSpymCOA+WjNLffqUQw68fbCU/aCDT1pEP/JGm1+8F/M2pKNudbRuO4KWbstTgi+QVl7ZjgnWxjCJ4WflNyDAup8cIH5MdL7J0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSSPR12MB999236.namprd12.prod.outlook.com (2603:10b6:8:374::10)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 00:31:06 +0000
Received: from DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e]) by DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e%5]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 00:31:06 +0000
Message-ID: <b906f204-f751-400a-999b-e18cc75e9502@amd.com>
Date: Wed, 3 Jun 2026 07:30:56 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/26] iommufd: Add hw_queue_init and split queue alloc
 paths
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com, yi.l.liu@intel.com, kevin.tian@intel.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-23-suravee.suthikulpanit@amd.com>
 <ahjabc5FruCGlfwE@Asurada-Nvidia>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <ahjabc5FruCGlfwE@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR01CA0058.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5d::14) To CHAPR12MB999248.namprd12.prod.outlook.com
 (2603:10b6:610:2ff::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSSPR12MB999236:EE_|PH7PR12MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a145c6-9d8b-4779-ba35-08dec1076640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|22082099003|6133799003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	MtX51rt3BgCzzWDKZHj6j0Q+BBALird/SAu6GtxpIZG3pFH4IgtQA+PsPjyiyigjgdE86sof6wMKFg39Rfo6jGJp+uD8oU2EkRpIbrxCQ6KV/ZarzJ+7OLDK1wtZfsbP4OpGK77xtTy0YTXSddAzQY+YTGe+9f8G9vwU181t1TAqCB66yH0uRsQkRvFNiULYnVJD2oJgRBoSrHPqsS3yNwAwQvfCtiFAWG6s0KX9/1LeHNlAPF1gwYqeqKjVO8YqKOmgN8NtF6oaNVWLtbfKHP64/ZkJ3KdhacFGT1+75NgfLV0yHJHW9l0YaJPf/qFNCVf5ejcp0NP8RMpZfrh+pMoEqvXSsckuB/pyMPENOR18IJ2UO70mOHwbQd4CdDl+bzRXSh0Wpci448nYnphrdTvPKS7/btMdTZs7n+iflqwzaDm7v7seD7y6T0MjsCibiJizI9GVHFj7eDWAZm9HvlgoL2F7w6XW59anZZLNuBLssc05LOE+J/wgaNgvUO5iidlDhKB3xpa1n8Cz3+GsGHK8CGLkJHEpmdVG56mDBnxK1fWA+MBERFj6pfgtTg5RyAal4jLVSEDmDn4DLIBoQ17a8siQZH5BvkFItYdPHkaSCCJMfRgJ0A8XyKuGQTVveCPKBk1DZj3IBCHSImLAVmDb8RDAE6Y7cOBjE4nSGAnmrDIA55rAla5OI7Q4VubR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSSPR12MB999236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(22082099003)(6133799003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SktEYzF5dFNOUitkNXNoRVhGQ1k5b09acEswVnVyd0pBV2QyaVhnenFKTVBi?=
 =?utf-8?B?NmkxT2h4dzR2Z3NVNHhSd3ZsSm1pYzNQMC9QU21lYUxraytvZVcyRW5iWm9R?=
 =?utf-8?B?V2E5VDJWOXZBZCtNajEvRUJwYVBXb0N1Y3dNenZpdU5semRhdE15SjdyQ2Ez?=
 =?utf-8?B?Y3ZLVklRM2N0dWUxNGxhditnbUxWYVphQjN4UktKVmYxL3QwU1V3b0V5a01t?=
 =?utf-8?B?UVJUZmxKbXlDRkJzRVJyZDFpbmVRZHI0U0FSNkRmOFlWNWdwaGlyVlh5ZWE5?=
 =?utf-8?B?MmFibGdOTEdacjNTMGNpeHBTb3N6U0hCUnU4TElsSUxZMUtGQkJ0V1JHbXp4?=
 =?utf-8?B?SllCUzlEQldqNk9uMmYxRS9Gd2d5Kzd3Tm5TbkF1dHpYTWZqcVRDRUl0VXh1?=
 =?utf-8?B?QVFlS0gzcmVnRU5JZklCOFlDYXZQc1o0eWFMaEhwcUdEQXp6MzEybVU4bkVj?=
 =?utf-8?B?VEdXMnlRMjNzWElCeWVYMTJuZ2dTQzl0d0JDcUNMa0hlc0JGNE5TTER6NC9R?=
 =?utf-8?B?d2ZIYm9md01RSkFUQWJVcUxiTENDSVBkWEVVYXVvN3lieHRIT0RhdEFKS2JY?=
 =?utf-8?B?TWlneXhrZXNJcTJtc3pDaWJsMlkycVZYb21sTHN0YkRDc0N1eEZjTGxHNVM4?=
 =?utf-8?B?QkxWS3VCaE5jZWJoaTIwT25iSktZZDhmYlpMd2ZwbnBNQVk1bGlTL25pakoz?=
 =?utf-8?B?RTNzUWJ6NG1xK1FRdjcxV2h1ekhzMmt6bEVtUHhiK0FmNmFJTllvT0lGSFdU?=
 =?utf-8?B?ZlhFZDVKQjBXTGYwLzFwbWxuU0J6d0RJMXJrUklQN1pMVDlMbTZJU211MFpI?=
 =?utf-8?B?Ni9zdk1iTURYTjFHQitmU0tvbjVaM3hFdXFCT0U1TnpWTnlaazF6eUVmMUhh?=
 =?utf-8?B?SmVBNlJxRXFvR2Z4aG41L0tVMzlKVEdEdk9KNTl4M3QxRnJrcFc4czNRTTRY?=
 =?utf-8?B?STBBUjVmbVpxZkROajZaa3FmRWxSTlZKVFpITG9uQjFRK2Q4MmY1SUl3WHZy?=
 =?utf-8?B?UVNQNmpHbVdFbGlaZVBCVzByY0lCWDBuNUxZM2xtNVY3eWlJbjhYWVZhdzNs?=
 =?utf-8?B?QWdqSXcyT1d1MVpjamNadTRxWk1INmVLdDIxUG1OVjZDajk5ZnZXYmNjVitD?=
 =?utf-8?B?UFFjcE41Ym00cTlFbEZKK2FxTEdPTTR0K2tUUXRlQUNoanJvUmFNSlhCUDh6?=
 =?utf-8?B?RXZnd1hPRDkzV3pZSjJKUlhsQ3U2V0FXTG95dVBYZzFaSVVqazZCbEUxVHhP?=
 =?utf-8?B?ZFcxbCt5dGEweVZNckFxZHJWOE10dU5PcFlKRDBwMi91eWNTQzQ1VUtVK3Uy?=
 =?utf-8?B?TXZIYjgzWGsrRFlFa3M3MUxjSlh2eStpenErS1dqdkZDTFFDMjhmRnVwd01W?=
 =?utf-8?B?eklQQjAvRlo0Qk1tL3pTS1FTakRnOURFT3Bqd2tBd0VLazNWVnRhZllzMFlT?=
 =?utf-8?B?YjhJMzdoYjEyMUZXWGRRUmJwbTVQS2VwVDRpMERENjJpUXZMQ2hQNVNyMGs3?=
 =?utf-8?B?SlZvQmZROS9kT1lpUHBXY2Fzc1dhb211cEY0dHlHV0NYRVZ3N0x5MGVPaHJR?=
 =?utf-8?B?cmxJalV3OFhPSkxuWVZDVFVxdExlRk9UcDltcnNHemhXTjZOOHhDZjRUM21x?=
 =?utf-8?B?YXNweEpPRnpUcThKMTliekdMWVZpT1FpWUlCTWN0WVlmTkg0ZzNHVlJ0NlJk?=
 =?utf-8?B?Z0N4MGdtSGFNeXBnMDM2S1M0VUVXMWc5dXBBdTJtWnhITjBYbVpOYVNwQVQ5?=
 =?utf-8?B?Zk0xdmppSzdyODFOay9KenF4N2ZrQlk5YWdsWjVxVlNmV3pTaTI3dVh5MlAw?=
 =?utf-8?B?N0RVMVcyUHlQZmtrQlRSZmRzd1RSaDhmRjRmVGliaFZqVGtmYk1XTjRENWl2?=
 =?utf-8?B?VnlKK0duNnd3OHJBUUdDSWs5dFptTlBKazJwcnZSemxxLzlsbGdDdjFCS0c5?=
 =?utf-8?B?Si9SbExaaHRhMno0M0NpM0hHbWMxSXpBTGVhUExHS2RlTHhDRS8yNHpUeW9p?=
 =?utf-8?B?dEMwRVdpVThJTDljN3hYTk5IYUcyWVhIenZFcVFjb0l4SnI0MkU0dzZsVi9w?=
 =?utf-8?B?RVhpVjl6N3lxUVVraVpFWE45aTdwYnp4ZFVKOTc3S0o2V3hZU2IxNmV1V3h3?=
 =?utf-8?B?L3BBUUtRTXpzUU0veTVTL1B0VzY0L0pRR2VvN3pDWE95UDVLVWpKeVBZbmVs?=
 =?utf-8?B?dUxvK0l3Z3pzRW9ONGtGY0MxK1hWS3RvK2RJUXFQZkY4NVFZL2Z4MUREN3lo?=
 =?utf-8?B?SUxXSkppNXdXbzF1WldCNkJ2bVVmNnFHV0J5YWgzbFdSMmJ4eEJjb3dYaFBX?=
 =?utf-8?Q?aAJ0w4g/XknNS8TbK+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a145c6-9d8b-4779-ba35-08dec1076640
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 00:31:06.3898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2jCLYAC2zuOVvC7NUM51ENcoGPnZaobhfxLZF0ojjJyYu4P0f6d6Ncd2+3QRzJa4OtGRe0VpXrhatoszWi4bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594



On 5/29/2026 7:14 AM, Nicolin Chen wrote:
> On Thu, May 28, 2026 at 05:17:34AM +0000, Suravee Suthikulpanit wrote:
>> Splitting helpers and dispatching from the ioctl keeps
>> one uAPI while making the contract explicit.
> 
> Why split? Those two new ioctl functions look quite redundant..
> 
> I imagined that the original ioctl function just needed:
> [...]
> -	struct iommufd_access *access;
> +	struct iommufd_access *access = NULL;
> [...]
>   	if (!viommu->ops || !viommu->ops->get_hw_queue_size ||
> -	    !viommu->ops->hw_queue_init_phys) {
> +	    (!viommu->ops->hw_queue_init_phys && !viommu->ops->hw_queue_init)) {
> 		rc = -EOPNOTSUPP;
> 		goto out_put_viommu;
> 	}
> [...]
> -	access = iommufd_hw_queue_alloc_phys(cmd, viommu, &base_pa);
> -	if (IS_ERR(access)) {
> -		rc = PTR_ERR(access);
> -		goto out_put_viommu;
> -	}
> +	if (viommu->ops->hw_queue_init_phys) {
> +		access = iommufd_hw_queue_alloc_phys(cmd, viommu, &base_pa);
> +		if (IS_ERR(access)) {
> +			rc = PTR_ERR(access);
> +			goto out_put_viommu;
> +		}
> +	}
> [...]
> 	rc = viommu->ops->hw_queue_init_phys(hw_queue, cmd->index, base_pa);
> + 	if (viommu->ops->hw_queue_init_phys)
> +		rc = viommu->ops->hw_queue_init_phys(hw_queue, cmd->index,
> +						     base_pa);
> +	else
> +		rc = viommu->ops->hw_queue_init(hw_queue, cmd->index);
> 
> and then it should work?

Good point. I'll clean this up and send out new version.

Thanks,
Suravee
