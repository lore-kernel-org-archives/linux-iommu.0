Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4C07C
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 01:46:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cogBuPInpirJNlfDIINzL570tTjCRM2Wzn1jzZ+7VTKgVU5IJC1fqUzkzeXBT861Ad5iNfPu9RlSORnGpzqFavZ7+6BP1xp9yxM/vhEL75PASXR0H1z+bqoNPzgwve3NhcO8N2bI3o36tQoDQcy5o0LMKmZdRjCzAorWJbIeeMQFA9I3fK76xuRWv3OEgYrAdi0MxsOlEIXG9P5gzFPs5FS180BzRK2YZepUDd01mV1nm3d3luk9jb7Am4dXda4QXORzfORNRAsry+g/oh2TUzSsBP0TyuipbI3xCn/75V/h6/mZf1nCdaHG7bGFQ51N6xsUuM0E3I6bEZFIIERNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEuiDHLUYWmQk6FHSDumEXfDOspefVDbLM53rZYil18=;
 b=I8+2t79VW3t64y2rD6xIJ17CMxUHZhKMGNcUUItLtdkKnayJgHAFqveHfLnATLGkbVHzmAQUhaMgResO03VgKYSWmtU9Axlwlvjnl2dB3mxX1dcnIazQQG4cbFrIjYX8FQx4Za+FWoBmxR0+VjqzeKfCYNa+dUECdZ5wL1GRPLamfUOvTGoX+lW54VIIa/JMupFpodGEb/FkeL8xayTZurlpOOQHKfbcfpjjd4bevRs9ZUzbKPOcnyNA1rXS5smZzf8SNdjBKEabg/45ezFvpzhOLGe6i1yI6DVxS9QoVuYEZBUrT/h5rIJGtKHK5+kqdSl3pAp5NKpjCJTjMd65Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEuiDHLUYWmQk6FHSDumEXfDOspefVDbLM53rZYil18=;
 b=jHiDu+95u5xxaOasGfFTXfFHvA/yWzgYDNscS73/I6aY0OXRbVyF3epV0ArNiQ5Zb9MY0nGxwi72F/iJkx/VVw9vV2epYQg3PusOc/GefNcQ1c/mjstZh5CSKeN5asJalkuzZY53ILKAuVSY6VuIwb/LGJEXWxKQK7M1sv9YJLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW6PR12MB8957.namprd12.prod.outlook.com (2603:10b6:303:23a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 01:46:32 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::36f9:ffa7:c770:d146%7]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 01:46:32 +0000
Message-ID: <7631ac8c-dcac-32cb-3cbe-71a0e137c842@amd.com>
Date: Thu, 27 Jul 2023 20:46:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: iommu/amd: fix the address translation issue when do detach
Content-Language: en-US
To: Jesse Zhang <Jesse.Zhang@amd.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Philip Yang <philip.yang@amd.com>, mike@fireburn.co.uk
Cc: iommu@lists.linux.dev, amd-gfx@lists.freedesktop.org
References: <20230727095531.333532-1-Jesse.Zhang@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20230727095531.333532-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0042.namprd04.prod.outlook.com
 (2603:10b6:806:120::17) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|MW6PR12MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 493a5193-7639-444d-83a7-08db8f0c7801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z7UiAB4lVzkaO3e6iCfhn/DC3RTvAAJ3QPoS7vggVTUJgSYujeCURxpgv00eaZO2zBnyuKNLbWKV1LU/kEgptoBTh0EL3jvY9maWTdPsK9kALm4l7kYWeXA1iKFWKoJpno0KzwClCRUL3oues/ry1yb3onYgfNuCFJAG166BZxKTk+6B7Nv8ONaBJhUPl3wcZ8OF/pY1EYqPLi2tXEt5R/e3cT/pZq5EoJtHWixEDZ5r5Lingu7UzPLv8LgBnwv3GaP0OWSrGEJLhds3pmA/d+Ly/SEsNmtPPvPe/7EcBmJBJckvmU76msXjQzSMArvGjETgVbhwQduho8SCFsGFjkNL5ljWQWogmaJTZ9w5qNUIV17TbXUEW67ncuY15wm7quPFJV1z0wOTWDY47UMa0UNK4moEInKnUvBHiTmk3+1IYeaYD80wzukYtVYvpr+GSl8H33CqKTEY3wSLBQtd6Lbcn0L5irunPcAHNGLkYRmmh/l0oY2jQ+zhoJlVTaLuw3CqjHwQp62YlZB+FH/bOtMU6BN2gSajJdehA9vMAus5YLlRI1njwGwdzPtxJJYYWgmxDuqu6gyuMhFGTb0snBPSz7EHegbeD5GQn7wr5Lh61ePiSUk+sHAXYu0SeVtW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(41300700001)(316002)(8676002)(4326008)(8936002)(6506007)(53546011)(110136005)(478600001)(66476007)(66556008)(66946007)(6512007)(966005)(6666004)(6486002)(2906002)(38100700002)(36756003)(2616005)(83380400001)(86362001)(31696002)(31686004)(186003)(44832011)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnNYRmptSUw1WmtpVUFkbWYza1NHQy9kWk9Cd01VeVUwU3dVNklJRHh6ZHJ0?=
 =?utf-8?B?WWpmanE2NGF3YzZ0dk9maXJoeXhhWnZBbE54RzFOZGovVS9BMmtuVVA0NTRk?=
 =?utf-8?B?eVNrZHJBUndIRndiUU5GUkpYODdmTHg0dkNMU1BrdVJYaFpCL09WY2FMNXM5?=
 =?utf-8?B?aytoTitvNithU2kwUFlqRWtoNC9QNWdWU3JKdnpJaDF5c0xCQ2N2QUZQd2Z2?=
 =?utf-8?B?SmJhMEtsR2VMRTlKRHExSHlVK2FJdmU2MlFJNHlEdzRqbWU5ZUFhWEZjbnBa?=
 =?utf-8?B?TWZtcUNzYmxtM0VVaW9PSTZ3TnV1VWlsSXFteExOVDMyQTFUWVJTcnM0QTJH?=
 =?utf-8?B?dDVCL3NiMitDSEZpWlluWE5UVGtGeER0K3dWb01mb1N6ZUk0b2xSRjAyQlRE?=
 =?utf-8?B?TmpDajA4TWZLd2VUYWtKNEc5YWZOelFoSmY4VGJWUVJZOVBnTjZsQjJpVDdq?=
 =?utf-8?B?NHNzV1NaMzdIOWgxZHdOTnRlTjgwanhjb1pFektmR21tamkrNEJWckU0Tk5K?=
 =?utf-8?B?RDRTVjRzYzVwSSt1Y3Vnai9kOFIwTkFRK0pPUDhLMDhCTzQyMXFVSS8zdmQ0?=
 =?utf-8?B?cGJCdlpzbzh1ampZdndmcUYwOVBHYzhqMDFhL2hTT2k4RG5vN01PL2Y1bzBJ?=
 =?utf-8?B?dGJjaWk3cGgzd3JrSng3SzdNcFYzWFJDV2lEYlVKTy9lVURQRFo5Uk9PMWtz?=
 =?utf-8?B?cmM5Znh6Wi9wNENoRWZvTTRURDZsdzJ5R0ludHZJdm5GMlV4MndCaDRHY1Z6?=
 =?utf-8?B?cEJsRmRnZUdEaElJaVhCOTMzek5JRWgxRzZ6QXpxa0tibGhSNXlJYkZqT0s1?=
 =?utf-8?B?ZjhxQ0ltZk4zK2d3ZnN1cmM3WlFzUkR5Y0JOKzkyYkZWQUVZMjdtcGI4anVj?=
 =?utf-8?B?RlBPNkJhbExnbWZzRnByd3JqOWhvRzh1RWxjYmx1OUhuMVlYUERhK2JoSjkz?=
 =?utf-8?B?TUdzZ1JyNGFxcFUyWXRzazRUOEhYUTFldmNEL3pTdXp0cWpVK1V3RXQ4T0I0?=
 =?utf-8?B?UmNlOFBKMmg1VTZ1K3BndWFoT0NZaUY2djBQUHhReHpFbFlUNTN3ODR5ckVU?=
 =?utf-8?B?RWhCNXYyOUFGcXNKdnpkaitqbmJEM2xwR3dObThoekFrSnRXMkZEMXE1U1E5?=
 =?utf-8?B?djRWTmduaHlrbTdkZzM0M2w0OHhRUlRPVGFGVUZpejdNWEtPd3V3TUNHa21l?=
 =?utf-8?B?eVgvVnZTdXRyazM3bU00eEd2R29BTXZHWE9wSGxQZnRiRFhhUTNaSUVvakJ6?=
 =?utf-8?B?QS9yZjRJYVVxK0x5NjJOajBQR0twd0FwY2NsVWl6VE1xeWovVVlKeDZId09L?=
 =?utf-8?B?UG1KVDNpOENFY2Z2cGRNUkNXOXRkajdtU1VvRS9PYlViMnlBOVRsK08zbG1j?=
 =?utf-8?B?aG5VV0cxa2phbDl5SFpVTFgxKzhMdmZxTmlzN294Y1JnOThVeG5mVGxyanJB?=
 =?utf-8?B?SldDZmxQek1WNGIyNVZjK2llMGVXczRxZUxmb1RmQ1Zpd3RzQWxKTUpSVEtB?=
 =?utf-8?B?dTZnNlU0aDQ2WFZYQWlib0thLy9iOCtjSzM3enBGNWt6eFZFN0tSUS92K1Rm?=
 =?utf-8?B?MjJ0SERPRUs3VHF0R2w4QzY2Qy9GYzBKb0RtL0JudTh2OFVFRGJrRnZRQ01l?=
 =?utf-8?B?dllPQk1wbUI0cmhGVUlZT0o0WnNGaWg3V0R2TUVCRWk2SlI5QXFzSFhpbHBk?=
 =?utf-8?B?ZFNrT21LN3Q5UHRpZDl2MWhoWGpKcUh2a3pEZEh3QyswU2tDQUdZaldQSkpj?=
 =?utf-8?B?NkRWNGtuVmNzRUVjcVpiNTkzU1pSREJEeURKcWU2RWpmSG1LMFBxSXVINkpz?=
 =?utf-8?B?R0hIMEVkZVIxSVBlL1FvZC9uTzZZNVV1NzFZNnp0MzFkYWIxMEdOR3R1M29q?=
 =?utf-8?B?YUJROVluck9yUkpYMUVHVzlBUTNFZ1NpN3NVeVQ0WW1COGxtNFN4L1d4dVY2?=
 =?utf-8?B?QWFiUmtNODNxMTEycmVDN3E2NnR5eEhEUFBwQkhIRTZnT3JjUUtOZ0lqdHlv?=
 =?utf-8?B?RFV3cVJLSjhheE5ycVdPdmN1c1czeWVDc3NITVl0N0tzVFY3ZVZsZVMvdFNx?=
 =?utf-8?B?bUc3M3VTZHUxTVlLZmkvUXhKYjBQcWVEbytTdXRhZjBlTDRtYmVsMTRTaCtM?=
 =?utf-8?B?bzNiZUNCMzZxMDZYNXhXVzZ1dzJBUWY5bFBySE5rL2c4aE56TjA3ZzFnVnNx?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 493a5193-7639-444d-83a7-08db8f0c7801
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 01:46:32.4942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hbJNaNJqR74s7Fa6afLnBbubdxFQXr9LRUL/ZyUnS3yPaGg2vjEwVRJB/uJKNqfczWv6HiDl+r62yyQgkQuRxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8957

On 7/27/23 04:55, Jesse Zhang wrote:
> From: Jesse Zhang <jesse.zhang@amd.com>
> 
> iGpu driver fail to read/write register by iommu when start X.
> kernel: [  433.296634] audit: type=1400 audit(1690403823.130:64): apparmor="DENIED" operation="capable" class="cap"
> profile="/snap/snapd/19457/usr/lib/snapd/snap-confine" pid=12344 comm="snap-confine" capability=38  capname="perfmon"
> kernel: [  433.515795] amdgpu 0000:03:00.0: amdgpu: failed to write reg 28b4 wait reg 28c6
> kernel: [  440.195492] amdgpu 0000:03:00.0: amdgpu: failed to write reg 28b4 wait reg 28c6
> kernel: [  453.679611] amdgpu 0000:03:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706
> kernel: [  460.383490] amdgpu 0000:03:00.0: amdgpu: failed to write reg 1a6f4 wait reg 1a706
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2659
> 
> Disable address translation service, before detach device.
> Do detach will clear the page table point or pasid table entries,
> so all DMA requests from the device should be blocked before that.
> 
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>   drivers/iommu/amd/iommu.c | 21 ++++++++++++---------
>   1 file changed, 12 insertions(+), 9 deletions(-)

The reporter came back and indicated this worked, so here are some tags 
for it.

Fixes: 8dc1db3172ae ("drm/amdkfd: Introduce kfd_node struct (v5)")
Tested-by: Mike Lothian <mike@fireburn.co.uk>

This commit that introduced the problem is in 6.5-rc1, so hopefully this 
can be queued up for a future 6.5-rc.

> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index dc1ec6849775..6a2237bfdcb9 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1863,17 +1863,20 @@ static void detach_device(struct device *dev)
>   	if (WARN_ON(!dev_data->domain))
>   		goto out;
>   
> -	do_detach(dev_data);
> -
> -	if (!dev_is_pci(dev))
> -		goto out;
> +        /* Disable address translation service, before detach device.
> +        *  Do detach will clear the page table point or pasid table entries,
> +        *  so all DMA requests from the device should be blocked before that.
> +        */
> +	if (dev_is_pci(dev)) {
> +		if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
> +			pdev_iommuv2_disable(to_pci_dev(dev));
> +		else if (dev_data->ats.enabled)
> +			pci_disable_ats(to_pci_dev(dev));
>   
> -	if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
> -		pdev_iommuv2_disable(to_pci_dev(dev));
> -	else if (dev_data->ats.enabled)
> -		pci_disable_ats(to_pci_dev(dev));
> +		dev_data->ats.enabled = false;
> +	}
>   
> -	dev_data->ats.enabled = false;
> +	do_detach(dev_data);
>   
>   out:
>   	spin_unlock(&dev_data->lock);

