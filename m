Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6DF7B
	for <iommu@lists.linux.dev>; Fri, 27 Jan 2023 04:58:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B40JTG6Q82upk2OJVZmCUYdjtBlxjw4MVVZe33fvFpaMQZNU6iaH/kA1p15SIOAfcTO90NGItv5/H85Y1SH9bqcCWDboAzmM7TIF0I3vMFw4MwOPbsloadEAlw/KsD9pU83HPod0eE+ukPcBbOGKL6j7qoGB+yf2V/J02QPAoUSp31KSuGmJZNQYH1SWkl6mp6TIPeu3fHn2kSA6EQLVkP3lqVY+2Ti8zgs93zZg8K4VrI4iZL9GRacenet5F1NEthXqnYfUm7BlaKnnmljhL5Vunim9VuSANYdfu38tMjdv4bCCB0Ci1EdidSnD3Dj0x7dCPHc95ttOCc8DTxXjHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzssQ44nkNwcdN8Mn/7VuI1I3Oftoa1+Dkq4wdMzMYk=;
 b=JIy57Dtgv515GHh2DYXlxY2gW3Dez0WdYQ9mpSNn+V5It+DIyn81h7zBZJ22Adt/3/Ezf/V4HH1zTIfv7Jn7aC6041v5N/lPu0uyxln32+xVkJ50uxjLKKoYkykLEsnTshkbbTmT+n1mRM0RNVmDH+9nRirwXISWMojl4rQvP1wyQV20VXRr0ANKsHDmJpIkhW6IDNLkawGR5/K4u9LqIkW16eDhoDE7CYkJReZPkuSe0LgHVA8VidKZYxXhP98RYi87PRbyxUZvvJlBBzy7M+HmjV8o8Aai3JmRroNMz6oh4sbdy7NA7kx3ZnHuTkPXcs7ojmP+ZGvfRKEH0p+XGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzssQ44nkNwcdN8Mn/7VuI1I3Oftoa1+Dkq4wdMzMYk=;
 b=sDZZPKFrY8obakHXFDEkBY/6Y9ogNREp3Y6iC55doZW52G5PTNqRzCz4ZKcHSolzv+1xHL2LHYynffU136fAqDX3759SMMZGH2fHxDHzJRBNGJ7EL/cPh92cpkDnb3bZp+mNvHQA8StnbQ9WmnoE+9Ifj1k7eoxZd67C3t563eI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Fri, 27 Jan 2023 04:58:24 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::4014:79ea:392b:b4f6%3]) with mapi id 15.20.6043.022; Fri, 27 Jan 2023
 04:58:24 +0000
Message-ID: <30c597c9-544a-bb5c-62f0-6cba558370a3@amd.com>
Date: Fri, 27 Jan 2023 10:28:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] iommu/amd/iommu_v2: Prevent scheduling new ppr
 notifier during unbind_pasid
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 Daniel Marcovitch <dmarcovitch@nvidia.com>
References: <20230124104355.119166-1-vasant.hegde@amd.com>
 <20230124104355.119166-4-vasant.hegde@amd.com> <Y8/6QCuqK9UGJgi1@nvidia.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <Y8/6QCuqK9UGJgi1@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::25) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB7693:EE_
X-MS-Office365-Filtering-Correlation-Id: 15ab2cf1-2e17-4df5-5630-08db00231ebd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NBjSfarIIPlBy1UH4Bpx7xm35ITXBNPTlXkUmx2tmQ90XqvWEZR2lSfC7zskFHWx3nBUNVoB9JnSZiG+fG6NCxVIFCKLmyQE6ZYSZR4qaAGtqboddlOtzwPHiqpya4jwEkb1bilDYYbLjRRrc9Yt4scWhRvwV6vJuMKnIU4bbebc3pxOKiylM3Hq3QghSbjyufCe6sXvtdhqr13pXeZxSI0qd5feOdk39EmDoYdEdOmR8yhVopFj2gmUSm4OLMRT4uda8iNSTsPTyUfk2upPYOYgWf/WytrKOnWOdVc2uPvc8y+Vo3UrHmJleNsKUtuJZ6aE8dX5WBLSm8rrCaOmjSVx152pPxmJMYXT0/MeQd2Fj9TwtjDUXta44gouA1vRrnf2Pcv24gpsg7cy9MkTciy735LZ+xl0NLtAsS17gYQc9o9n4LC7s45bDbZMh2iqVpaKfbUbkKUrad7hEJXJqH72029QCO0kF4u7VJPDZVykr6BxFNvc3p5klrzT9o6EDIckDWnOsKQnj6DRmhrNEZ41RWb13Vrga8rHeCoE1jydKB2k4BzO7tJlyVWvd9mzvvOVx8Ste9PA0Bsffxkooxw5m78HsJx/2sioRuhnFSokb4P6RG79m6xhI1bM1Ii9dmS8/ck4tA4rBZN02ZnSj1d4Oh1WrL1/3oJIRsSQLu40zXvOdcSv2qbaHR8XERovZaipy77hiCN5G6SMzchTicsJONbKSNNWdWDnROZJ/pI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199018)(66899018)(41300700001)(478600001)(2616005)(31686004)(6506007)(66476007)(36756003)(6666004)(38100700002)(66946007)(53546011)(6916009)(6486002)(4326008)(8676002)(31696002)(6512007)(66556008)(86362001)(316002)(186003)(26005)(44832011)(83380400001)(2906002)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUNCNURVaWRvK0RRYnBhMXh4QzJTWEVZenc0K25ZL2VNc01DZXJRNC9rSjR4?=
 =?utf-8?B?azNjVVFnTHZ5OXI5K2VRWUphK082Z1BlUDltMU90R3VZa0ZvUzUxcE5VUkx2?=
 =?utf-8?B?Z3o3N005TytFY1QyNzk3MnFQNzZRLzdQaXNhQnVHelI5Q1ZjTUVtRkZma0F3?=
 =?utf-8?B?SVE0Q0dwNFRiODExZEI4eW96Z3hFVThJZlpQakRUNStUSFY3cThNbnZWV1NV?=
 =?utf-8?B?SXBaUzU1YlFCd1krQlZCbkd2ODJRVytQVGdONEpaTDIyS0V0UVRYQ1VYWmZL?=
 =?utf-8?B?ZjZ3QkVTVkZjdi9TTUpvTmpBcVBOdXdYTVA4cWJOdVIraTV2TEFQRm1wd2M2?=
 =?utf-8?B?RW0wN1lWblFkanhPcGkxanJHcjhOcTZaOTEyVGdVRWVjK3pQQkQvQm40bUk0?=
 =?utf-8?B?K05XVHNxemQvajNPcS96OUhYT3pjN2VzS3RzMHI1UUorUGlYK3ZQY0p5RmQ0?=
 =?utf-8?B?VlcvR0RTWXYwUUNDYjRXRkhpRUxkK3RNMlFGODRUWHJGZnl1YVVDQ1RhYWdy?=
 =?utf-8?B?dTI5bjRiYThMbFM4Zkd1Zm1sNFFVSmxvcDYyRWlKQk5KNlhQSy9sdjdvN1lB?=
 =?utf-8?B?OG5aSGxmY3pZc3pjQkhGY0Z1SURhQUw0YkxGdU56aXJpcmFXeDI2OVpCMDFx?=
 =?utf-8?B?QkR0aUsvcWJMYXBsSlJ3V0VoaExFZjBJUGUwMVljVTg5NGUyb0oyMi9vc3c0?=
 =?utf-8?B?bDVyaVpJWjdpNHIzUUJGVlFLbUtCamwwTjEzU0p0bU1rVGNPZUdOQTBEZ2Fs?=
 =?utf-8?B?SkxMWTd5VUY4ZzdNQk5KdlJLaVNwTDV1MXNnbWhpYlV6ZjRMUi9Kb2tiZ2Q0?=
 =?utf-8?B?TkVRU2JCMThLVHdJdFUvYzNSdVBqQmJKUHZ6WWR6d0xkb1JvT29IV3lJRVlU?=
 =?utf-8?B?QVc2ZlNhN2d4dHlxRm1SaS9YMGZiRHlNNzFKZnhQRWJoWG5BTmVMM3N6R0ht?=
 =?utf-8?B?ZzRlQnpZUUEzaGVRT29DbDVXWEpQUWRLd3BjNWp2dXVDaGxXSDd1bjJpK0FF?=
 =?utf-8?B?blhTOHArODRUanU1WERMRFVDc1ZOQndmNDIva0lhbnkvRk1UWEs2ZkZ4Y3JB?=
 =?utf-8?B?UWkxTzNmTGlVRDlaSWsyeEdSVWhsbENBM1NzaUhHdVVCbmhKa3VTY2RGeTZ5?=
 =?utf-8?B?OHBqeVpSTGUycDB2Z3E5eFRkY1FPVDV6VU9KL1NMNXhwME1SYzk2ZFV3WW15?=
 =?utf-8?B?Zmo4WGZmRHBHS2Evb2JtQ1lhQ0ZJYmFPYlF4VUtJZEFTZnZHZm5WQWRIdmQ2?=
 =?utf-8?B?Z2krdUxYQ05OTTlYeVdZT2U0eGZVT2pVUEZZN05EMVdzaVBDd2pabDFSd2gw?=
 =?utf-8?B?cS9KS0NXZXlxOHRNKzZOR2d5VDAxTU93dEQzTHNpbFNZdUd2bHNKR0lZUHd6?=
 =?utf-8?B?eSt5eUJpK1Z0VG96S0JJa2RraThxa09UZ1loTmNBTUFFWXY0aGZPR3p5V1lM?=
 =?utf-8?B?bE50cG5XNW4zVXZXRlNxa09CakxMamJNdHlpUms1S0x2U3pnRWR5dHlERXFq?=
 =?utf-8?B?VER4NURsdWg4TzJLSHlRb1BiV3JPVHlyWlB1c0FLQnhCTVBQWXhYWmkzK1Z3?=
 =?utf-8?B?T0g2NGpkYmFWY0FNK0FQTmFnWHJaVFFuZWhwTUJIWEh1bWg3UVRITVVKM1BW?=
 =?utf-8?B?U3BVdGN2UGZxYURqczJ3V3p3MVNFdjJGcmI3Tjhlbi9HMjR5cmZSeE1KVVVo?=
 =?utf-8?B?Q2djUmZuOElwMm5mZVJ1RFpPMDFaUHk5OTg2S24yd0NBWWpQRFFoUXdBWEV5?=
 =?utf-8?B?TVJ2UW4wVmlvcldyRWNaZXdwaENuK2hhME9kK3phN2I3aVRYbGZrbWJUY1VK?=
 =?utf-8?B?UmcxL3d6MjcxOW5RamNtN3p5NWxRZjVNVkJtRXhjcGZQcU4wUldtaVhxZHpl?=
 =?utf-8?B?d3FZeTVLRzkxeCtuZ29TNkNoclpXZHRhWnVPTEhJWXpaM3ZQZkx4Q3NybGlr?=
 =?utf-8?B?ZzFidk9yd2pTWmtaZWQ5Nnd5b01CcDZMZWFVVUpSMlNsNy9xdDdlZzl5WXFZ?=
 =?utf-8?B?bmlLdDdHeG9zMnN4V29mTXZGSTJ3OFdJWjhxWnloMDZ5OERFM2hvbFVpNkpH?=
 =?utf-8?B?UndxK3FpK2Y5UDlHMEJzVHlIcFpya28rNWNGRVRvYnBxMWhGYUdNb0VsRFRF?=
 =?utf-8?Q?HMW8A+dbuJBAMC+mf4iKdHUJq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ab2cf1-2e17-4df5-5630-08db00231ebd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 04:58:24.6700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQc9D6PMVoLCO7vw6nKseD+CrD0TBwn50j7eyFzqT/cV14D4v5Sgns2p85ytaQ1eg7jS+sLbBoEQuf0NXrcPMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7693

Jason,


On 1/24/2023 9:03 PM, Jason Gunthorpe wrote:
> On Tue, Jan 24, 2023 at 10:43:55AM +0000, Vasant Hegde wrote:
>> From: Daniel Marcovitch <dmarcovitch@nvidia.com>
>>
>> The pasid state wait_queue / ref_count mechanism allows unbind_pasid to
>> wait for all outstanding ppr requests to be completed prior to freeing
>> pasid_state.
>>
>> However, we are still missing a mechanism to prevent new ppr_notifier
>> being invoked after refcount has been decremented to 0, and prior to
>> pasid_state deallocation.
>>
>> This can cause unallocated memory access.
>>
>> Fixed by changing ref_count_inc to ref_count_inc_not_zero to ensure no
>> new ppr_handler starts after pasid has been unbound and NULL (invalid)
>> pasid_state is returned on zero.
> 
> It looks like this is prevented by clear_pasid_state() which will NULL
> the pasid entry under the spinlock before an attempt is made to zero
> the refcount?
> 
> Though maybe that is missed in the free_pasid_states() path?

You are right. We just need to add clear_pasid_start in above path (something
like below).

----------

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 264d9aa447c2..15f4d4bd1f63 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -336,6 +336,8 @@ static void free_pasid_states(struct device_state *dev_state)

 		put_pasid_state(pasid_state);

+		clear_pasid_state(dev_state, pasid);
+
 		/*
 		 * This will call the mn_release function and
 		 * unbind the PASID

> 
> Also this whole thing is just begging to be converted into an xarray..

Agree. Makes sense. We will look into it later.

-Vasant
