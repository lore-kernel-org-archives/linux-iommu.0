Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B13D82
	for <iommu@lists.linux.dev>; Mon,  5 Sep 2022 11:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3KaQWnPlj8YGMTudKG4yoS6JDl973raiAdTXyPbzALgKl3j+PvZ83/6uCMy0p8Yf3wz5D1Chlsfowv/9xXcWWLA40iy37MmaBp+DJJ/xUOLVsYR+TsRgeUlTjYbvaWn4zIgdKzrXpeevAvPTyFFJ4OUoFNVfxRXC3kwHKw3v4lCrPiRyxQCEZb2bFB3auzVLMia7w3XCed9JkA95EDj4drBWZntohsTflHUY01PFKeevuoN7CstTiEjU/XndvUMcREWK+ITaRAHrNhkWyUhl1Lj4K34igdsmLivkbPE5LlZO01F+Y21UjZ1tHjeBLxxCq+r/T+SheUbB1wn/ancrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6TltNsSEYmzUGAooi13wj64CnGmKYqWg8D0RGr5cmo=;
 b=DBmO3jNp3Tieuj1/fxsPHRCc7D1Uw9oCB5jEYl7CDl7WYg0X/uT57X0NZgUOAoJS83PIibR4+4UzD1QGlFx85YDKY+B7nBlVJlTla2cVoUzkVTooGvxRNNE0oHQ5uvGXHKGIK/j6vxPCjEXU88RwY5eiapQ5bTWVgOs4d7JW/8FNQFdSHLnKrpSnrFprgRfEuVoejJhF3/61PBLbfGpxfDWgPqk4nl7vqYYQ7CGCudRWj4quQrL1KfAmylyehY25PeBKRlnoPYxH7jcNTx7xpNVAOa4Stw+xpktsufXRw2yrddDGA7UL06FhuyDMMaadbkMRJmYAGmtdWTDEadMnxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6TltNsSEYmzUGAooi13wj64CnGmKYqWg8D0RGr5cmo=;
 b=byg3kdv+rrFk6KpbE3C8Y630VTzduXHGROyXrlWkP9+1p2+R6BRKfC7939sg6f5VfHZOx9Iw2m7OMTWYgg+0cayOrLwvzyZ9qWsf9TvqHNVPcF/hWMFeXUw01opvn6qLVmt/pmswGt03/9fTRZOZDQbJNzzK8jZ71isg6ZscVOQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN0PR12MB6078.namprd12.prod.outlook.com (2603:10b6:208:3ca::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Mon, 5 Sep 2022 11:39:52 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::9ccd:c887:5b9d:44f0]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::9ccd:c887:5b9d:44f0%9]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 11:39:51 +0000
Message-ID: <77d2ea43-9752-b5f3-78ef-8cdae944eee4@amd.com>
Date: Mon, 5 Sep 2022 17:09:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 0/9] iommu/amd: Add Generic IO Page Table Framework
 Support for v2 Page Table
Content-Language: en-US
To: iommu@lists.linux.dev, joro@8bytes.org, robin.murphy@arm.com
Cc: suravee.suthikulpanit@amd.com
References: <20220825063939.8360-1-vasant.hegde@amd.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20220825063939.8360-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0066.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::15) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3939e27d-f539-4cad-dc53-08da8f335866
X-MS-TrafficTypeDiagnostic: MN0PR12MB6078:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YN/kRmYwLtjwhlzo33Uoe53HG3gSbBSpcFCadUvD5ImscJDgnOmJITGN4BZp8JL8mWUzCDeFAP77MuGPwbHRND2/CJnve5OVUltnT/OXVAGMuzYdbRezbUIhI0Yri/XRjzreAOXx+dV8rn6i5fGhV7rt9qwqbNHIkBnFU2X0wG+8Nz6h+NVUXiUSCLhJePQwnaOjoOrQs+horO6ClK3Eux22KRhqYlPdXQA/gUpWGP+tdn36ZDrsZGxL0DYPsHbgVrVOzGQg4cmcf+NK9FdPfW5ievGHW/UiY+YXlRv4AKw5/x6QzDnCbcFPd33cyQy8lBCv21k17brym5PyVQbMs12tgb4twTzy/fFYcSSt7FaAEK6FOxqK14zclICfRp1xe4dJg4m0Fa8zfNvdvCzFGKg0XUd3UezggRtanp03Ffmzrhlx+ofNh0u6qb20q3VcvsmNrbY3UkNtEHXovVAYtT6xWdAO0pg4HxnHr4rAuWyw4DP4aq1xkbDNABXmnybflwYO6oVAwspmAiWn/zcnJ3HqiSuCZ+M4pD7v65YfxJLCIw/+r8mgmsrwBLMvPgaA0FJfw8C4yIxZeV4lBYMwV2n3BZMqo78usNBfXanJ0epifQHD5U+7IpqXlGglMtTO28i3Ry0+AAzdwSE2ESQkbpqLNE69J0sGEs97KVK9fssm5nNuV0ilPBJOMnDu6halF5OqifQx3yjG2oZa8nCI0b6/iF7nfWZQiv6KozX3gtGLe95bd72T+9UQltOHXlop0fxY+0DNa9Y8t0LRJIxPRHpfipUdATxjlfQUezBMlVRMfkrWJPd4O51j1XXcAdYhL4ophXDxVeXuwHfh4+a2mJ6RYQ3z1l8BjKcT1d5W89uJKgBHHu+VHwJJtuVwvw6bSnAuja4QC2C165tUPUuKELNUgB/6hUGknautSrpaUdg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(66556008)(38100700002)(2616005)(186003)(83380400001)(44832011)(66946007)(5660300002)(8936002)(4326008)(478600001)(2906002)(26005)(53546011)(31696002)(6666004)(966005)(41300700001)(6512007)(66476007)(6486002)(31686004)(8676002)(86362001)(6506007)(316002)(36756003)(71600200004)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T01ld3BDVTR0YVRKSlJ2S0t1WVlrYnE3Y2MvTDFCdFlQK1RHd0VJYm9yRjd3?=
 =?utf-8?B?NkYzdHFKNzVMODd6YXBOUTBOWFJnU2lhTlMxaWZUUEsvcmFySWw3MmJwTUNL?=
 =?utf-8?B?SzRBa3ZnRjNyWC9aaitWdUg1cGdxYWh4Rzhtc3hxK3JscmJZbDFYSGk1ZTBC?=
 =?utf-8?B?dnJuYVVBeHZ1dHZTSGRRTXdsc3pKa0F6dTRwcGkxVjRpSVJ2V2dpdTV0d2Vw?=
 =?utf-8?B?ekZYQy9EWTVGVzhtZnBzYmM3NmZacC9RaWluby92TkxxUjRPUkFTY01PVnpa?=
 =?utf-8?B?aVMwWitqMk9ZNEFma05pdDdPUi9UNGFIOFZTL3BhYzRjWklzN3E0b2VRY3ZH?=
 =?utf-8?B?cnNTMm5JdnVVdi9oQW16ejl1OHlHZWliV0JlRGVNQmJUbE5iRzZZT0dPV0dG?=
 =?utf-8?B?a3ZKWDdtMEowM0VqdFJOeGR0WGZFTy8xRUx6eVphQ0I0NlFza1VrM010aVM3?=
 =?utf-8?B?N1hKVEppeGxXR1MwdGJsZDlMTEFpemJTT2V5VUQ4Z1RaS09FcnRtalhGcVFn?=
 =?utf-8?B?bjVWOXFzaVMrRERoWVIyTmpxVFd6MWpMM3ZOOG1leWx6UlVocWlDbEg2dHVW?=
 =?utf-8?B?UEVFWDVTUDNMczl6dUU2WjQyUStYL3RacW9mTm9QMzBidHk3YmNoOVh4bWF2?=
 =?utf-8?B?ZExOblo2THFlbHRLcXlrS1lNQkNsVmdzRVgvOGVIUE82MFp0LzhwSHRtTjlJ?=
 =?utf-8?B?b01MK3ZaM3N6Y2szYThKMUFiUHN6cjdEU3pvRUdJakhlSWpFdm95WVJpTUtz?=
 =?utf-8?B?Z0ZkK3FLcGdFRW1iaEZqOTBVK2xzRncrRnVFQ3JtZmdQOTVHQ3FPSUdxNXBK?=
 =?utf-8?B?WWdNdHVwUG9kdXR1bFRDQWw2VUEvQkFCNjFrK09kR3dCSGZpNWFYczdML2pB?=
 =?utf-8?B?Z2k2a096akFpNlVzalJ1YXI0ZXY5ZWRuTXpVeFVwWEhUcnZNQm91N1BMRGZi?=
 =?utf-8?B?a3pDaVVic1UzWThxTHZ6TWMvK2p6YXM4NVBvVFI2SWFmYTB3Q2pvbkxxbUdG?=
 =?utf-8?B?eFZUQTFESC9NZHVmVnNFRlA3ZS9kVlFna1B2d0pNY2RoaExRcC9VcWxpOGI1?=
 =?utf-8?B?U0p5SlRjcUJ2SkhEV3BMUnh1ZHNDRnpZOWFBQVdhRmF5UVFndXB4Q0NSdEN2?=
 =?utf-8?B?LzBLelYwbXBUV3JWZWdMWUdOY01Zajl6cUxvdHJGQWorYmdVZnhmOVB4RzVF?=
 =?utf-8?B?c3ZGNGVNNE5MN3RSbE1YMmlOOTlHc3NObGd0NWNCMmRWQjZPL0JEK1RCTEs0?=
 =?utf-8?B?U2w1TkxHUTdMOU03MUdIQnNEYVBTMld1N2JqYS81VTJmUGpaYnQ5RHJ2K0V4?=
 =?utf-8?B?eEV1Rml6S1JER3Z2WGt2OGp3c01jc2c3S2RPVVFpMG95SFJCQjRpempBMXRp?=
 =?utf-8?B?MEh5NnhKeXlzdWp3WW44dlBpRWV1NTByV3VKaklic012TnF1ZjErV0pOR1FY?=
 =?utf-8?B?ckFvYzlVdTNNOWJzbFg4ZGZrK05RTGs1UjZmQyt3RDFnWXdWcnF6TzZQNUps?=
 =?utf-8?B?RG5rK0FKMFFtZm1yZGpiNUkwOFRqWXovSGZ3SUFjS3dQUFNyOEZ5ZFpQZFZ5?=
 =?utf-8?B?VnEwSkRPM3JIME8zZ003c1ArdjdKRnE0NkNJUlV3RFFLbWgwaEI3Mk5OM1pQ?=
 =?utf-8?B?RVhxSzUzZFZCZXdZZ1NIYmdsVzBxdzQ0MFNMSjd2aEtPZUxSM1R3WGJWSkpW?=
 =?utf-8?B?N3Q3VjY5RDdkQ2ErTEoxWlBuOXZuMTJHcFN2NUhRMVJtWXdzaVpXRmJlZzMr?=
 =?utf-8?B?eXJac0xaeWxPSTZUK094S2NiSnNFUzFqVTZNZmJDL0JoTzNwU2VjdlhXR2E3?=
 =?utf-8?B?QThpR1Bob1BZdWpPRFFHSER3MFhMU1psVzZYeXBxQlgxZjB2RkZzRXJrK21x?=
 =?utf-8?B?S1k0QkphMnd5SG8yYmFOOFdzWlF4NXdBdnBMUXJLKytHTkRzdi9qa3BDa0hn?=
 =?utf-8?B?WlRuUEVPY0p1MHNzZHc3OURmdmpTdTlMcTdQZ0lQV1lldWpFNGZkY1BLUnI4?=
 =?utf-8?B?Q0I0a05MYkZRK0x6dTZCbk5qQmhSV0Y4a2RoTWRrUFJjWXRSVmo1L2xmNVEx?=
 =?utf-8?B?OFlmczVDaU5SdkZ5NXc0YUhVaWV6NTlTdjNIM0RTdm5WeDJTdi8xMWoyblFI?=
 =?utf-8?Q?t8UxmwP2Q90qjF3xw6JOQ3mZa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3939e27d-f539-4cad-dc53-08da8f335866
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 11:39:51.8711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCGquU5ajsFBJYm7P7OSON43uHsfZtrShn3QNHmuOPjbjMlIuucKHfKtPgkz7m/5aoapCgd3kJOc1Ml5mPQBVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6078

Hi Joerg, Robin,

Ping. Did you get a chance to look into this series?

-Vasant

On 8/25/2022 12:09 PM, Vasant Hegde wrote:
> This series introduces a new usage model for the v2 page table, where it
> can be used to implement support for DMA-API by adopting the generic
> IO page table framework.
> 
> One of the target usecases is to support nested IO page tables
> where the guest uses the guest IO page table (v2) for translating
> GVA to GPA, and the hypervisor uses the host I/O page table (v1) for
> translating GPA to SPA. This is a pre-requisite for supporting the new
> HW-assisted vIOMMU presented at the KVM Forum 2020.
> 
>   https://static.sched.com/hosted_files/kvmforum2020/26/vIOMMU%20KVM%20Forum%202020.pdf
> 
> The following components are introduced in this series:
> 
> - Part 1 (patch 1-3)
>   Move AMD v1 page table to use [un]map_pages interfaces and minor fixes to unmap path.
> 
> - Part 1 (patch 4-5 and 8)
>   Refactor the current IOMMU page table code to adopt the generic IO page
>   table framework, and add AMD IOMMU Guest (v2) page table management code.
> 
> - Part 2 (patch 7)
>   Add support for the AMD IOMMU Guest IO Protection feature (GIOV)
>   where requests from the I/O device without a PASID are treated as
>   if they have PASID of 0.
> 
> - Part 3 (patch 9)
>   Introduce new "amd_iommu_pgtable" command-line to allow users
>   to select the mode of operation (v1 or v2).
> 
> See AMD I/O Virtualization Technology Specification for more detail.
> 
>   http://www.amd.com/system/files/TechDocs/48882_IOMMU_3.05_PUB.pdf
> 
> 
> Thanks,
> Vasant
> 
> Changes from v2 -> v3 :
>   - As Robin suggested added support to use [un]map_pages interface (Patch 1 - 3)
>   - Removed [un]map interface from AMD IOMMU driver
>   - Updated v2 page table to use [un]map_pages interface
> 
> V2 patchset: https://lore.kernel.org/linux-iommu/20220713053034.12061-1-vasant.hegde@amd.com/
> 
> Changes from v1 -> v2 :
>   - Allow v2 page table only when FEATURE_GT is enabled
>   - V2 page table doesn't support IOMMU passthrough mode. Hence added
>     check to fall back to v1 mode if system is booted with iommu=pt
>   - Overloaded amd_iommu command line option (removed amd_iommu_pgtable
>     option)
>   - Override supported page sizes dynamically instead of selecting at
>     boot time.
> 
> V1 patchset : https://lore.kernel.org/linux-iommu/20220603112107.8603-1-vasant.hegde@amd.com/T/#t
> 
> Changes from RFC -> v1:
>   - Addressed review comments from Joerg
>   - Reimplemented v2 page table
> 
> RFC patchset : https://lore.kernel.org/linux-iommu/20210312090411.6030-1-suravee.suthikulpanit@amd.com/T/#t
> 
> 
> Suravee Suthikulpanit (4):
>   iommu/amd: Refactor amd_iommu_domain_enable_v2 to remove locking
>   iommu/amd: Update sanity check when enable PRI/ATS for IOMMU v1 table
>   iommu/amd: Add support for Guest IO protection
>   iommu/amd: Add support for using AMD IOMMU v2 page table for DMA-API
> 
> Vasant Hegde (5):
>   iommu/amd/io-pgtable: Implement map_pages io_pgtable_ops callback
>   iommu/amd/io-pgtable: Implement unmap_pages io_pgtable_ops callback
>   iommu/amd: Add map/unmap_pages() iommu_domain_ops callback support
>   iommu/amd: Initial support for AMD IOMMU v2 page table
>   iommu/amd: Add command-line option to enable different page table
> 
>  .../admin-guide/kernel-parameters.txt         |   2 +
>  drivers/iommu/amd/Makefile                    |   2 +-
>  drivers/iommu/amd/amd_iommu_types.h           |   8 +-
>  drivers/iommu/amd/init.c                      |  36 +-
>  drivers/iommu/amd/io_pgtable.c                |  76 ++--
>  drivers/iommu/amd/io_pgtable_v2.c             | 415 ++++++++++++++++++
>  drivers/iommu/amd/iommu.c                     | 117 +++--
>  drivers/iommu/io-pgtable.c                    |   1 +
>  include/linux/io-pgtable.h                    |   2 +
>  9 files changed, 584 insertions(+), 75 deletions(-)
>  create mode 100644 drivers/iommu/amd/io_pgtable_v2.c
> 

