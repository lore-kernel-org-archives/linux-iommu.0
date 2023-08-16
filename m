Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4F9D52B
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 09:53:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwOoPdbjDVRxk/pKoq9yr//V7ddsA7aouxJi5jTtCgkjAugoNeRlqgZjNslNGnJONvUkzQmujwDrRmgjd8VWctS3J2KvKdmWH+hV0TATRCyb8it/A3jynvELiPSgerfRDaomOfcVCUAyhTxnZboeYtg+QTz8ThTpoDz1rykhwjg+kdybOiJn8HRktZuUCOs0gYbEbO83a735nXDYXcJ8tTUWoAs8DixgQvtp+4pLla0OtPmY5qYLo8EfTfO7Rwz9C3skm9hv/y4Tu6isf6Wu5GBbkj0Ou3qnoKMvekeedWleeYep2udYdvRThkUvagFT1Z2GQV8i7da4waErzYg7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+juB0/vjvULa9nEp5KwT8RYitPBA3Iq0hWQkdLf0FXo=;
 b=XilPimS48qTZZwicIKUkMieQi2q6EGNAP5L9U3HXHFbhycA/UFZNF/Q1hjABHixFjamw+H6P9dND6unPxI73NhJ6IJbgdbSttsxbgtffa3W0QQGhTCKsq3xA7lWJ+yPYhCyT70HDQSkq8czb48vS8tPFwaXHvbuI/AxQimj7yCkVKflQwXuCgfSHHHkfrFssViPEpxCnp/hZNfAeR6L+Nl7pkhl3JfFEycf++VXUgUtExVOoAmE0+Nmos860iKOIqpAEi2seAI3KJb64ZAQ6rNWt8oIVoyQIPLE2gdx7MxwDMjCjklPEkdCFr0uFuKilkZ0cwitDnRnpdVCaJdMOKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+juB0/vjvULa9nEp5KwT8RYitPBA3Iq0hWQkdLf0FXo=;
 b=DZyvMwYH7kRMdwV8pzt8JFbDEq2X5Su0+TYlP5B7JObfLzWaARNp8qydlfeIQIKvJEC7f8IxE21Ri6bunRpZK2cAmb7fH4FEw4zmUc8g5asCwQHK6pM+K8i5kqr/qy7CFmF1rtPeYxqTd88jG7sEOyInKsOW1x2iqh1yEHLOaKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 09:53:05 +0000
Received: from IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::a7eb:9a2c:edec:83fe]) by IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::a7eb:9a2c:edec:83fe%4]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 09:53:04 +0000
Message-ID: <1542effa-52e6-af81-1f9f-9403afbdb094@amd.com>
Date: Wed, 16 Aug 2023 15:22:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/4] iommu/amd: Remove iommu_v2 module
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
References: <20230815103255.565295-1-vasant.hegde@amd.com>
 <20230815103255.565295-2-vasant.hegde@amd.com> <ZNuPJmi9sdRPVVVL@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZNuPJmi9sdRPVVVL@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0063.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::23) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6043:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d3b953-20da-44a8-f0cd-08db9e3e95f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VOGxtKI32RJSDoiywH8PXnFiXPUwDpZfnTvtV0vlNKfZepRxc0sPfilaId+5Mrysgrq+VmqaEwLgcEMYd2mfKmk5QbGWTUn/Ft2mn2zkZtvJDkEyFoyF3UzH+MkWfN15XGRnbRKfsxlwslexMA7FJu2uoP7T6Pp1ihixbmP6QeRyUrrFMOI+/fFhSWW5vi0wzbQmxdE7dHkSlJJal1E3aA2gaBi8b+okyiZlbrvR7m9I1FLKjySXQkTVmhnmgEi6cbNnUJexynXewFxof97mfPMLzN1DOmK/zvVP1Wpf7Ixm91DmkxW/gkGMPVDXO1OuqeYISk/t+OKo+Q1pXYW4gmXexUQ0RYhOXYLpezLYUbv8x7pVHqWfXV+dlpTuqHhzdkb1RF0xYMm2B3kmgKN9Oz8f8+qjson5QJAKeqAz6FHJOVIt+sdWljyXKwyjO9uSF8aLNvmlHtB5dZ/4J+KGOtgcMMkwThn/Xm4qVOOJEWyKl+iEs/DLZF6l/Y3lrCuD505rtK3LHfl8sHmVRDx3Uxp/ycyf0cDGJ4XvmMQBkz+b9sTIoTFfWZ705YlkLZYQNTV+UTyG+cPoWHDNUomh3ZEhs4OJ/6zyyd1ikLsYrnp4Wiwa+szqk7cEDfINXOi0NM20DRiZ39HYsjSsmQCCIA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6043.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(366004)(346002)(376002)(1800799009)(451199024)(186009)(54906003)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(44832011)(38100700002)(8936002)(4326008)(8676002)(31686004)(2906002)(83380400001)(26005)(478600001)(86362001)(6512007)(53546011)(31696002)(6506007)(6666004)(36756003)(6486002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXI1NExDVDdWOVBqOU4wL1hYbDM0bFFMUU1GVmtrbWNNNkd2Tk1yajJLaWNC?=
 =?utf-8?B?UUM1TWo1MEVQQUlCdXdGQ3VzZm9QYzErRC9KcmJucjNxVWhZSTNTcHVqa2dq?=
 =?utf-8?B?UFBmVklkeDJpd0JyN0UwKzBqR1ZCQWJUdEFnZUE3M3M3MkErTVB0V1djNHBt?=
 =?utf-8?B?dWdlZU5PR0pvYXFKWjFnYyszMHJsL3ZPQ2pQNmlpRGp5M2syWHFZTHErV3lS?=
 =?utf-8?B?RlF2SU9TT0xUMG51eHZLdVBRS2czOVNqb2xqb0NyK1NDNkVSTWxRT0RzTDc4?=
 =?utf-8?B?a3ZLaE9nMTNRSEpXUTExYk5FbVBYZFhxR09GeEhUdnFKWFZSTlhpbWpUb2o3?=
 =?utf-8?B?TWxoMHFnazRTVHZ6VEs0Y0ZuU1YzTi8vSDIvYlFpcTRIUUlLMzN3Y0JzOHNz?=
 =?utf-8?B?czd6RGVMREgxeFpBdHpscUp3N2VzVWtHampuZlI2SlZqTlJiMU9YU1hjVEMz?=
 =?utf-8?B?dmFQVEY2OXNyQWpHWllpTFpXdDZETkdUeU15SzBTSTloTEswajgrMDluZlRR?=
 =?utf-8?B?bGRsQzRUSlREOHRQY0o2TDdEdmtwWGV3TC94T1dRUUdxSlNKK2t6WmJndXFU?=
 =?utf-8?B?ZVJLT0dkNWZZdWQyOE16SEZteXpPWHJLcEFjcW5scWQyTjg3YkdPY09RNlcr?=
 =?utf-8?B?VW0wK3lmZ0hCbnJBakRUOEpqV0c1TnhKUlB2c2cyN3djUFhYVE8rYThQRXJj?=
 =?utf-8?B?b2ZEVmZ3UTQ5eWxLZ1ZlMWxGcjhOY3Z2MEorTnQrTHRoK3dGN3paWTZXaVNp?=
 =?utf-8?B?UmM1RWREdzhDTjNzUnFHRXB5NTNqWlF2Q2VqUElzVG1pSWRxTlpHQ0tPelN6?=
 =?utf-8?B?OHhEVjN0MC8vKzlnY3FiVDZudCtHc1pCMTBtV0ViY1lIbGd6OHBYaEgyejJa?=
 =?utf-8?B?NStwMHBuV1VwYlhyR25yY21MYll5UFFiTXRtMjJrYklCQzhXTUlPQ2FNUm5W?=
 =?utf-8?B?Si9tSkx3V0FKRlhBeWw3dFo0dENNcXFtVWxpdzBpOURlYVhxb1RIdTZhN000?=
 =?utf-8?B?eDJxWkVTMFJTNUN5bWptWm9UajlaZDU2ME9Pc2xxNW9RckRIR0wzZE1yZE50?=
 =?utf-8?B?MmpzNk1MSVN6aFhKNXBQVzU2a0IwcWY1UXhmUTdzZlZyZkpHUnMxazRRU0xE?=
 =?utf-8?B?eDErNTRUTzlINmUwK1lhUG5vekM3NjRQVjJPc3dNeFpBMmhVVHhWSFZPTUFS?=
 =?utf-8?B?dFVwQW5Lcm1rQjRBUWZ1QW9LdmQvODNpUjRHV0tkbTZaV2VmaUd5SGZTMDVJ?=
 =?utf-8?B?WWxQMWh1cTNvNkF3NlJUZWthUEk5UEZLc2Z4UmVDZ29sL1BhVGhOb2xnNnc0?=
 =?utf-8?B?SXIwMzdEM2wrVW1mU3NScER0K0F1SHpYSTlMaERhbHhheDhnNFpjN3Z2YUxi?=
 =?utf-8?B?elR4Ukx3d2FXdnZYbVB4NXk2OXY4cmFNdHl0TDBUZW9lMDlPbmJaSzJJcnVk?=
 =?utf-8?B?MkpMQnNMdWRIM3J4eVJlRWg1cWQ5TXNudHk4emJIUm5zc1ZITFlDSzRKdTlp?=
 =?utf-8?B?RWNsN1RWQ1RYclkyZ3pzTmxuTmk3MldoTFVsa2tHa01DSW44YS9sUy8vOHZB?=
 =?utf-8?B?aC9aQ2FEMCtTcVRLTFRnc2dJdUZCenJtWktlazNyMTgyU0ZHTktUWXZRTDFW?=
 =?utf-8?B?QnJONzBtQ1pva1FUT2hUUFl2R05CMnUxSlg3b3lUemtpbTJBR2NvZXZjV0Va?=
 =?utf-8?B?UjZOZVNoQjV6cmtsUHVBZ1NvbnZaTE5BTGRFaDRZb2w1Y3FYNmNVaVZzQnhi?=
 =?utf-8?B?Rjc2N0NtV21qSHkycHU5ZEFtSkMwVXhwTGw3TXE1clRROGpWd0FHb2pveTRP?=
 =?utf-8?B?WVJjYUg3bitMeW5tUVBLc2ZGMVN5ZVlMdC9GYVJXYVFQZFE1UnhUS05hMW5P?=
 =?utf-8?B?ckdwbFRma01JRVRuRTRNcVBUWEdiaEhqbEZxaXhWRWF1SFc4UEowdU1HSXJB?=
 =?utf-8?B?SjQ3Q2tOZzlabjcrRWpWeFZCaWZPOWNQRm5ZOGxDaTJWZE05SHdkWjRyb0NB?=
 =?utf-8?B?VzZrZExxb3R0NjNvREZrTlY5Nk52d2FUMVZ5cE5aZWg1czJERjZaSm42QUQ4?=
 =?utf-8?B?aFdaN0tOVGxFdk1CMkJ6THdzNTFWai9uYkY2bHlWUHpoQnVQQkRQbENOSnZZ?=
 =?utf-8?Q?+sOVfOM0ERWux2Td+U4A/9CEa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d3b953-20da-44a8-f0cd-08db9e3e95f1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 09:53:04.8698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VHLceUP6IRsRDR5Sib7fovlS0tc9yx95E9+t/h1g0QZ72sb3kaU41/Pbg8wK7TOH4N9GOvoZdDKGQjGRJmgfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229



On 8/15/2023 8:13 PM, Jason Gunthorpe wrote:
> On Tue, Aug 15, 2023 at 10:32:52AM +0000, Vasant Hegde wrote:
> 
>> -int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
>> -{
>> -	struct device_state *dev_state;
>> -	struct iommu_group *group;
>> -	unsigned long flags;
>> -	int ret, tmp;
>> -	u32 sbdf;
>> -
>> -	might_sleep();
>> -
>> -	/*
>> -	 * When memory encryption is active the device is likely not in a
>> -	 * direct-mapped domain. Forbid using IOMMUv2 functionality for now.
>> -	 */
>> -	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>> -		return -ENODEV;
>> -
>> -	if (!amd_iommu_v2_supported())
>> -		return -ENODEV;
>> -
>> -	if (pasids <= 0 || pasids > (PASID_MASK + 1))
>> -		return -EINVAL;
>> -
>> -	sbdf = get_pci_sbdf_id(pdev);
>> -
>> -	dev_state = kzalloc(sizeof(*dev_state), GFP_KERNEL);
>> -	if (dev_state == NULL)
>> -		return -ENOMEM;
>> -
>> -	spin_lock_init(&dev_state->lock);
>> -	init_waitqueue_head(&dev_state->wq);
>> -	dev_state->pdev  = pdev;
>> -	dev_state->sbdf = sbdf;
>> -
>> -	tmp = pasids;
>> -	for (dev_state->pasid_levels = 0; (tmp - 1) & ~0x1ff; tmp >>= 9)
>> -		dev_state->pasid_levels += 1;
>> -
>> -	atomic_set(&dev_state->count, 1);
>> -	dev_state->max_pasids = pasids;
>> -
>> -	ret = -ENOMEM;
>> -	dev_state->states = (void *)get_zeroed_page(GFP_KERNEL);
>> -	if (dev_state->states == NULL)
>> -		goto out_free_dev_state;
>> -
>> -	dev_state->domain = iommu_domain_alloc(&pci_bus_type);
>> -	if (dev_state->domain == NULL)
>> -		goto out_free_states;
>> -
>> -	/* See iommu_is_default_domain() */
>> -	dev_state->domain->type = IOMMU_DOMAIN_IDENTITY;
>> -	amd_iommu_domain_direct_map(dev_state->domain);
> 
> Since this code has been removed please also add a revert for the core
> bodge that was supporting it:

Sure. I will add patch to revert this one.

-Vasant

> 
> commit 2380f1e8195ef612deea1dc7a3d611c5d2b9b56a
> Author: Jason Gunthorpe <jgg@ziepe.ca>
> Date:   Fri Sep 9 16:46:31 2022 -0300
> 
>     iommu: Fix false ownership failure on AMD systems with PASID activated
>     
>     The AMD IOMMU driver cannot activate PASID mode on a RID without the RID's
>     translation being set to IDENTITY. Further it requires changing the RID's
>     page table layout from the normal v1 IOMMU_DOMAIN_IDENTITY layout to a
>     different v2 layout.
>     
>     It does this by creating a new iommu_domain, configuring that domain for
>     v2 identity operation and then attaching it to the group, from within the
>     driver. This logic assumes the group is already set to the IDENTITY domain
>     and is being used by the DMA API.
>     
>     However, since the ownership logic is based on the group's domain pointer
>     equaling the default domain to detect DMA API ownership, this causes it to
>     look like the group is not attached to the DMA API any more. This blocks
>     attaching drivers to any other devices in the group.
>     
>     In a real system this manifests itself as the HD-audio devices on some AMD
>     platforms losing their device drivers.
>     
>     Work around this unique behavior of the AMD driver by checking for
>     equality of IDENTITY domains based on their type, not their pointer
>     value. This allows the AMD driver to have two IDENTITY domains for
>     internal purposes without breaking the check.
>     
>     Have the AMD driver properly declare that the special domain it created is
>     actually an IDENTITY domain.
> 
> Jason
