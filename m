Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EED963E
	for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 05:53:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQ128g6luB4vIgpDHLZOVgIUo6PRybxJNWks6+OeuMvr67TVnHQyYB8+9betF35UebBljzcCAymWt9hg4XPB6WXkGxWG2eR6uyTiw9yVB/X7qB1mXPvS5U/Na/CISHVniBh0btX+kwJubkveEKUmo/hWEWrdVQj5JCADv/5FKDWZte9oIqjEpWhhnB9ileDpud0LcX03il1fNCs0H5/nBihfYDZIMWMF7/qKUsljfLOo+Cmt9+Kmvc19R0LK6nkoTrcsU/fQvYPB0dbtij2ahe4UNyl8fx2FrYV5jeC/wla+AxrBo5esE2+1Bk4Nr0C7qzlwJySOvf86oh1/GBVJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyhVEYD0GKnzPd/ZhI1rEVng2geuHQLYEL/vZwucG0Y=;
 b=e6QJAn2lez85JuycTgHc2QIGOoFPGZrKmdTBaxQvR970E3wfYbcbZSkveG7cRv3Unlgo58aPCT43YCJU3wLVSankSz0ROsSHFzX9ayXgnRHHLQJuhcXBzexmEZVa7TcQ28pLs94o8fcYGl70VSasToREjRr5oxxQ7y1g0uL6CGC7B75hLWgodzt2SQmv/Y4CCBfrQTauJnnUYpiR0rxRbzAKxEYjA3RnaT19Nd5GcKuLVy9P2WcHm1bsu+tgUo13zzxb0NdtWg3bYGQ7Qi1EzlZOxYJIYqrOaE206Xxl+Xy67xxySEXOJNeSmCq/kyTB696K6gQX8osCPslYRtJvEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyhVEYD0GKnzPd/ZhI1rEVng2geuHQLYEL/vZwucG0Y=;
 b=Fq3giEErFluPZxKUu6tjyNE6UXWQkL4NVFZQjcc5ojg4LnPBW0lQnfCIP2Da92hvbYZH+Gzg5eflx2o2Z8h8KuVvR13PU0yY2IW7BX9Q6QXJQxPG94F/jlhWxxo6+UH3oY4yl5S3NA1NuK+IE1jTotcTeD8nydwfjYPtX0cAkm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ2PR12MB8184.namprd12.prod.outlook.com (2603:10b6:a03:4f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Fri, 17 Feb
 2023 05:53:49 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::56d2:cfa0:4e19:40cd]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::56d2:cfa0:4e19:40cd%4]) with mapi id 15.20.6111.013; Fri, 17 Feb 2023
 05:53:49 +0000
Message-ID: <0f6e2838-9d7f-dc2c-6e5b-0d02e239f032@amd.com>
Date: Fri, 17 Feb 2023 11:23:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/3] iommu: Attach device group to old domain in error
 path
Content-Language: en-US
To: iommu@lists.linux.dev, joro@8bytes.org, baolu.lu@linux.intel.com
Cc: suravee.suthikulpanit@amd.com, robin.murphy@arm.com, will@kernel.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Matt Fagnani <matt.fagnani@bell.net>
References: <20230215052642.6016-1-vasant.hegde@amd.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230215052642.6016-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0205.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ2PR12MB8184:EE_
X-MS-Office365-Filtering-Correlation-Id: 07470eb1-a055-48ea-146a-08db10ab5758
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wY/u43pJQW3psPbHTImsH2HkgpCaTeZ6j63qEg63nJGOuHirHdYFoU7olcPg6Ylingcx5wdlPWUwxl5ML2lWxivE/xLiX/ycjIMrbOky5GlXplHaROjtrh9RbE8vsLVyjLQRbIke1uXba66SGBo+x80998qh8JQOAiRAE2h9PQgHjEF6kAntniNI0wDtuEzkfqKpK+JvkmrUtSNkN0mr8KmfhDkd1jnW04n7PVi0bjRYzjQ0TWvjRLZBLx+K8oSDHcNMI9jJSNCw9CUV2MFQao7s+60JavP38mY8rKsE1lT8SEBtks9Gf05D4PS2XEoBAFWOetIRaZiCqyMdmKW8BnL8eS9Oczt1UHwbvAlJgnHCB9RJFRrH5tWv3eKP6w/GE6q4fbN0E3z1+1XMAt83jrttYryhppK184j5pnDnn/GfrpsCsfYTwuWdnsYkhis5fZFJnHzJQZYihaZciXsEKfxiOoB05YQOtEJI63nER6d6zaKWVlNK//6QEf3rcRY391Kj7UX4CiHE2SanNjBgDaAZIf/29xv8qr3qG+loS9INhZ+ieO33vUvxV5z+DiW0YLHcXnpJJSDBcHVKDxpyhX0pg0x1hu8cXqT8FPsEewx6v6pmIYP16qOjD2PCbbN9X2GUjHWDtkTh2da9Lc+IL5CKfOMOH2Y5oC9IOU+LtbZgKZ2aTvRF05/Bj93XLmW2ldiJ1jBFd35pYa7qkTCf6sdvaPPjKM+OUifWRoJ8BTiUCg9A7C27wqlI/7AsDP0fWGN4x9kGMUONUeaEoALkQw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199018)(86362001)(54906003)(31696002)(186003)(36756003)(2616005)(6506007)(6512007)(26005)(83380400001)(31686004)(53546011)(2906002)(44832011)(66946007)(8676002)(66556008)(66476007)(4326008)(41300700001)(5660300002)(966005)(478600001)(6666004)(6486002)(8936002)(38100700002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDFqUndKT2ZZSFRaaFdGdFljRnhOVVhoNy9TUXBTTllpWHZjdzZGTVFqNFF3?=
 =?utf-8?B?N3U4Z2Y0bHNPR1RZQjlaeEdJaDF4SDI4UGluM1d3RWVUWWhpTzNIZkN6Q1BP?=
 =?utf-8?B?ck0wekdqVEN1UHVValFSSll0WSsreVJXeFVwT2FyWTZnVktBanFpQ2ptNDRt?=
 =?utf-8?B?S3g2ckNFZEpYSHAvNnFlRVJpeTh6Mnc3bkRRQjJWWk93ci9ZK2YzbjhLZFdF?=
 =?utf-8?B?OENuRCtydnFLeUMvakNuSmhyZGZMS2p2T1B5VGx2aVlrbXZhSVl2ZVY2dTVV?=
 =?utf-8?B?R2hzVHJ0eitiS0JjRHZiNno2NE5qcU5Pbm9ucXJ5ZUNKTE9PdXB2RWFKSkwr?=
 =?utf-8?B?THVvdnV0WmhVYmdWeGM1d29RaUF5WU0vVzgrQlE2SzBLR2lMRmU3MW8vckZt?=
 =?utf-8?B?WFZUQ3IrM0NPL2h4WjFZRFpUSUREUy9zRUxjQWZUNjhTL0FBUlhkczRkNzlv?=
 =?utf-8?B?ZXF4dVk4SThpcnR1OWR0amZsamtBYVhOaTJ0REpRQ2FHeTFXNHI4LzI3WEhk?=
 =?utf-8?B?c291N0szMU5KWkdISmYvTHNNVE0rNmJuOGZGa2V3ZjhVUXBHSFlkTzIrSnov?=
 =?utf-8?B?dGJ0UlM0Z25MT1dtemFOMEFocnJaQnNUWm5HdUdaZy9lclRIWEF2YmRsWi9F?=
 =?utf-8?B?b2ZOd1NvRHpiK1hUeDc5NjRDMUlPeElFVVkyN3V0MjNlMkFpUk1FQUNFelU3?=
 =?utf-8?B?UklhQ2lJRnQ0L28wMHJ3L1l6aHExRW8zNHgvVUFiU1FhK3ZxVmJHaVZOWDBN?=
 =?utf-8?B?dy9PeCthWjlONERONUZML0pQWGsreW5oT0FCeUI2LzRtUVR0VU9KNEZNTVhi?=
 =?utf-8?B?YTMvYmlGTzR6M2N4cURwYnJOeWNOMmk0cEIwZFZoRitNOEJ2ZUtXU1RFQXFI?=
 =?utf-8?B?QXhIK01Nd3NqZnY0R2RRcEtKNnBGUDFRYkZUWFNVeFpRVG5kUUg0QXk2UlVC?=
 =?utf-8?B?Ny9iOTBmMmV4OUhKNzJuWFZPUy9kYmlBV05jZlhyakpjN2JnSzFLbEttVzlF?=
 =?utf-8?B?Q1V3OWRxSUNKZXhMTkR4Tk5RdUdCcmxNRHlKQUgxVzhjbm53UkpaSzR2SFhF?=
 =?utf-8?B?SWo5dEk1RWtoR21MTWxwZ2dGTHF2LzFtVWFYS2RXTHQyNDRjZEplMU5SWDNv?=
 =?utf-8?B?WkRCd3I2OVFWcHl5YjJoL2lMUHpTek51NGErdEhRNE51Qis5U3ZFVFVCbGVB?=
 =?utf-8?B?bzl5OUdMNjZnOWNsYUFnWEJkVkJVTkc0WXNIbERlS3V0dTlLc0dzMTFqZUd3?=
 =?utf-8?B?Sm5INGpLTUlocmczNVJ5QXU2Sy9QRmxoYXRnbmdUM3FRamg4THV0Z1dEQzlZ?=
 =?utf-8?B?Uzdna1c1eDh2R0tSdE1JNnhwQ1FoTXlLWm5NUkJ3cGp6dUQ3cEIvT1pzMGh0?=
 =?utf-8?B?Ni9tRWZzTmErMWw1aE1lNU9VV3VoMkZneHFWWmlxY1k4N3pmdE0veXRwczV5?=
 =?utf-8?B?amVkaUhSSnpSOFROK1pMM0h2a3RTamUvalVpSlJSdk0zWHdQOW9BbkMrQVFv?=
 =?utf-8?B?TENkWUhsTllnZjdTdExkYktTMm5Rai9hdzBkZ01MenBSaisrS1E5Z0J5aXZS?=
 =?utf-8?B?cGFMYjd4dUtCdXVpVW04RnRzRXdUN1JMcTJteWQrdjc4cGtzcEk0Sm84Q0l0?=
 =?utf-8?B?OG1tUnduVzBYSEUwcnNWWjFWR25iTEgyTEhQaC9OdlV4QTBZalR5SmlDNytK?=
 =?utf-8?B?ZWRRSVVTWENVUXBIZkhTN0hTOFpwU3FJUnNnYXVHY1ZiT2F3ZmVsTWtKTXdh?=
 =?utf-8?B?d3ZpSWFhNGdlMTNLUnVjbHRvQW1vM2o5VmZldTVvUXRMSVVGdzRFMWRvMDdy?=
 =?utf-8?B?ZGZzWjVMU2ltWDF5dzlubGI4emhZczRDVVhTa1NzY3V5UWxuZjZ1bDdEeGtI?=
 =?utf-8?B?clN5dStJRmVUZVlEb205WUFDWjdYbnJZZzhKOE1QOXZDazg5QTVnRTRjT21I?=
 =?utf-8?B?WFB1VlFpanZDT29jWS9ici94WVRBYmtqRG96R0lCTHVmaTlYY1dZSTJXRUUx?=
 =?utf-8?B?TXhVbXV5WDN5Sk4zVEpEM3ZvUVc1cU9LekZiNUg3UFZ6Q3pPWXBOVjZDUktL?=
 =?utf-8?B?VG9MRklhaFVnMFE0Y0srMXREZFBqVGlOZVh0dVpuOFJRR1hiZ3JNcXpXb0JT?=
 =?utf-8?Q?+hNxpVKZCXWag6F0stEj1qtxV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07470eb1-a055-48ea-146a-08db10ab5758
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 05:53:49.5930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3uWAcc/WabdRXjn3k0UqDqaK3YWJZgX3Al0j3Qj4ChiMV8BHa20fXwk0vl4hZqDvmvbNa24dBWkZKMt1Fy8jng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8184

Hi Joerg,

[+ CCed few folks from other thread (Bug 216865 - Black screen when amdgpu ...).]

This patch helps to solve the 'black screen' issue we hit in upstream [1].

With this patch we are handling error path gracefully. System is booting without
enabling PASID for AMD gpu. Matt has tested this patch and confirmed its working [2]

[1] https://bugzilla.kernel.org/show_bug.cgi?id=216865
[2]
https://lore.kernel.org/linux-iommu/e17d1ee9-7383-6717-6f10-9465b273b1ed@amd.com/T/#m98390232691e3e55db7f1187073016436fd2176a


Can you consider this patch for 6.2?

I did miss Report-by, tested by tags. Can you append below tags or do you want
me to respin patches?

--------

Reported-by: Matt Fagnani <matt.fagnani@bell.net>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216865
Link:
https://lore.kernel.org/lkml/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/
Tested-by: Matt Fagnani <matt.fagnani@bell.net>


-Vasant


On 2/15/2023 10:56 AM, Vasant Hegde wrote:
> iommu_attach_group() attaches all devices in a group to domain and then
> sets group domain (group->domain). Current code (__iommu_attach_group())
> does not handle error path. This creates problem as devices to domain
> attachment is in inconsistent state.
> 
> Flow:
>   - During boot iommu attach devices to default domain
>   - Later some device driver (like amd/iommu_v2 or vfio) tries to attach
>     device to new domain.
>   - In iommu_attach_group() path we detach device from current domain.
>     Then it tries to attach devices to new domain.
>   - If it fails to attach device to new domain then device to domain link
>     is broken.
>   - iommu_attach_group() returns error.
>   - At this stage iommu_attach_group() caller thinks, attaching device to
>     new domain failed and devices are still attached to old domain.
>   - But in reality device to old domain link is broken. It will result
>     in all sort of failures (like IO page fault) later.
> 
> To recover from this situation, we need to attach all devices back to the
> old domain. Also log warning if it fails attach device back to old domain.
> 
> Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
> Robin, Joerg,
>   As explained in previous version [1], I still kept the changes in
>   iommu core layer. I hope this is fine with you.
> 
> [1] https://lore.kernel.org/linux-iommu/f2151603-de54-7717-60f9-748e9205139e@amd.com/
> 
> -Vasant
> 
>  drivers/iommu/iommu.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index de91dd88705b..e3336a11b6b9 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2124,8 +2124,22 @@ static int __iommu_attach_group(struct iommu_domain *domain,
>  
>  	ret = __iommu_group_for_each_dev(group, domain,
>  					 iommu_group_do_attach_device);
> -	if (ret == 0)
> +	if (ret == 0) {
>  		group->domain = domain;
> +	} else {
> +		/*
> +		 * To recover from the case when certain device within the
> +		 * group fails to attach to the new domain, we need force
> +		 * attaching all devices back to the old domain. The old
> +		 * domain is compatible for all devices in the group,
> +		 * hence the iommu driver should always return success.
> +		 */
> +		struct iommu_domain *old_domain = group->domain;
> +
> +		group->domain = NULL;
> +		WARN(__iommu_group_set_domain(group, old_domain),
> +		     "iommu driver failed to attach a compatible domain");
> +	}
>  
>  	return ret;
>  }

