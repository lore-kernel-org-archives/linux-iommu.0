Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85A71D69B
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WcXESu2T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCZJrGIg7HABe6VYqX7KwCmeBxy6mPtY3oXOhfxt/XcY7OYOB3jZoQRjqc3i/ehf4A6ylT+OAqxCqwPDVLL50UnDAWwLYy/PNP8oR4I1OyeuwT4G9sWlBZGCm+MQVu4GLRUQ7uOGhdLmVcsNJLdYs9ExNPqs9+MHtCKl42RC2DUwWXiKl66lx7lXQBqdz2qMdGCZJuki2/bNaGIvaCjOVDaJpkq3WQ3kPDexnoAJiq6iqlRtSh0wcbgiiIo6DFNcl73sVOogSt3ROH09HPxk3OJXR06RYaJLvPhdI70rmZNIHOq0hjAspBpi1fQC5uqgO5B5gabfJwh5dmfQBvpSsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iriy265CiqZda4vJK0RsXGpSzefwLqDUwgwQJ7otfJk=;
 b=KtKLWKakLBBDG+vT6m+Fhgi7+5j7q9qZnaxdPeTZ+EjZaPG5Ps3AXtGuo8RwIP8P1pesjvD0BLBCmxSSYYUBdjTbM5CTLpr/XBdZiZFJa4P3ttGWNzMclvBqAgwbcn2zSP22nFsvC59maKS1uIpof9XR5wPllLKg2w60XGNucpJsWzbukuw7VDSCyKPHqRedMXvXakzG0c5vQSXILJ6Ns8X5iZfUtyJsQZCWQgsQwNwAaK/jTxuP2WYmcRZetHNmpUOXuvzkA23kaBc3aq0b2TJVi/oXSzSfph+FQXcEgUB59QTR5j4UOfDC0rCUq8FGV3BV5lPw/QehWzstelUfdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iriy265CiqZda4vJK0RsXGpSzefwLqDUwgwQJ7otfJk=;
 b=WcXESu2TVaQpri/eeqfbFUoo5fzS5I/ooLkJfXv2fARDd5RqyMw+1zmmX6Vdi7pS71ZG1+UZsyTOT++zAIC9iVlC/hmgJlcKWVvVIGTY6zjEyRYInNvbpOuLHOIZd2E84NmIuVtquU/OXY7M907PDsYIpUbEkKA6AIWLeYA6Kvc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Mon, 16 Oct
 2023 10:18:59 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::726d:296a:5a0b:1e98]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::726d:296a:5a0b:1e98%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 10:18:58 +0000
Message-ID: <d38a1883-d254-d1f7-82bf-a7c90b06993f@amd.com>
Date: Mon, 16 Oct 2023 15:48:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 00/13] Improve TLB invalidation logic
Content-Language: en-US
To: iommu@lists.linux.dev, joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com
References: <20231006101624.5912-1-vasant.hegde@amd.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231006101624.5912-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0075.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::15) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d90102c-498e-4119-c295-08dbce314f71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U4Wa7Y2hC8JPaPX/e7Ck9nvPBIGo8U3VSvL3xDIPxhM/Ixm1yyI33XSfZo+fADVBWaTZVY+Pb06ru1ug6fQEMiinQotmSjePGJZMYoyOzJ4zUmEXuAfpKIVBeSCD70PDSGMmgfGFs0tRg59b3J7ajkze2Z/AgP75D/gOmN0pzcJFOkrwhuQ81T2+Qt5FUM98djMtp5ebJqmuNRx7OqF3a9Lwit+oxRyEzDTcSBvv4qivfsrjxFI8E0K5BdDjZml7Ff3oD+ni85VF3Jb8oc+I9GroXYGXzwz4gUCR3viH5uHjGp3mrkGSR4YCqh0jPRYwYAti86LXAsHce7AzZHQ3ut29Y12cpY+FdH9OzJ/mBhlqZT+KjwRY0oa4xKxJFRX3+ZzkkVghcGkfu21x7uPMyexmHI+xhioz9PmR9MzKGluL18kao1R0SQVwLmmHJvI+gHlBax+EYqd48pmGMiTjfcUnhcIByYaViTu4InxX3XoUBdsUfEhHtTbaht6y0Q0tr/HZN7k6DIA6mzwN78BXLKjKQKB2m81H5pFnUoZMPpfQm+DycFohXgPDZcsusCuvQEBrGUlS8M52neE2jMrcxDH3PLzVRxNJWR3PC4zaCmzj4mAotHgkaIquWoHCwKE8XHxVYwWYVvv9cpniR1AE1sU5Hx/9x+KNwE9CotrQ+UM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(31686004)(6506007)(53546011)(83380400001)(26005)(38100700002)(6512007)(31696002)(66476007)(86362001)(4326008)(44832011)(8676002)(8936002)(2906002)(5660300002)(6666004)(316002)(966005)(41300700001)(66946007)(66556008)(36756003)(6486002)(2616005)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEM4VWdLaW15SEtycEF6QnBEYk5iVHYvcmp3QlY4Zkt6dkR4a2dqdW5IdXYv?=
 =?utf-8?B?TXB2UzZabTVhN2ZZWDJweDV2RlFLOXhZbjNaeWdKZzdNYTBHVW1MMEZPOFlz?=
 =?utf-8?B?VkRvSStGWXU1YnZoeWlFYlc4WlRuSDJKOUlxdmg0SE05c2xnTUY0eS9Qb0pC?=
 =?utf-8?B?eHdwcmRvcTBEVVcxUFgwc2hselk3WUJRT3hMM0R2dGRsU3kwUURXdnJCUmxw?=
 =?utf-8?B?T0h6OUxSMnJpbDBSWFA5djBuMmtHOE1HM21ldnl5a2w5RzZrOThOc3M2aFJN?=
 =?utf-8?B?RVFEaFgxR3B1aVN5c0lPelZvNzdETEVXbG4wc3djMTY4c3pPNUtyaUJ0VytN?=
 =?utf-8?B?aUVESDVsQ2g5SHYzNER4c0xvMFk4dU04blFESEN0OHdIZ3FrWFZMbENqb09Y?=
 =?utf-8?B?MU9seG04K0hPdE1lYXREWVljNS9UYXJZbm5YWkJ2OVpWcFFOZ3JKQWxzQzI1?=
 =?utf-8?B?R0M4R3oycHJ1YVU5elVNR2ZSdGo5VmxzUzNkTGhpMWhpaWRVaDhQWWFYV2l2?=
 =?utf-8?B?QmdtTE11VHpHM3JmT3MrazBYR01haFRZYUp3QndXSGlXN1I2dTN1N1pHcmJu?=
 =?utf-8?B?QUxicW9QaHpGalZyeXlVdkFTY3NLZzhkVEdlamZUaERONHFGWE5seUoyeC9O?=
 =?utf-8?B?Rmx2bWo4b3NId0JLMVM2cDlOb0wwUmZDMHduSllwU2pIa01GT2pnelRtSGxZ?=
 =?utf-8?B?dVZ1U2oyRWFCUllQayt0eVcxMTNzK24xTkw3OHpvT2x2bDhHQXNrN01xZHVv?=
 =?utf-8?B?akd0WmtjRk9xWUhQc3JwaHZqeVFRQjk2SXczK3gxWDlRN3ZtYkNlV2xpeGl3?=
 =?utf-8?B?bzBlWDhWNFk3ek1RMVlYeDkzWXhCMG5MampDbVIrendybG5PWmNEUHUweG9E?=
 =?utf-8?B?ZDczK0cxakVyVDJhcFZzbFdwcGJpcUthV25wMVlHR1Zobm1MSVJTMlorbnUr?=
 =?utf-8?B?REpwaDBWUy9aeGdBUVpVUml6NG1MVVZQbUQySjN4ZElLWHpKNk5mSThVMCs1?=
 =?utf-8?B?eGxLcUhWbjVHa2kyc0lpV2hXdlk2RXAyOEsvQWYyV1Y5cDJZODlQUklaN29N?=
 =?utf-8?B?Vmd5bTFzeE5kb2JQVmFtdDdYL0xBa2RvS1JPUGFlZXJHekpjTThDVisrTUpN?=
 =?utf-8?B?dzZIa05FcVExdkhHOUJsdGVLSDZUOWd2bndCUDdScnNHVmFuenU3bmRCMk8r?=
 =?utf-8?B?RFYzOU9pUjBXcytYS3pqTjBZYW85Skt4R29MeEJOSVNIZ0p6WEVMdTU1MzU5?=
 =?utf-8?B?dDVTVVpnMnVoUlhaS3RYbHVaVkM3RW50dldIRmhsdW41dkt0RTBwaGNZaGQ4?=
 =?utf-8?B?VUI4aGZqRVhVTm9VVkhvaUFDSmU2cXR6cnZXb0xXaWQ5Yk5oOFNTMjNaRmly?=
 =?utf-8?B?eWdKQjRZV3VVZStEektySm4wYWdRUmZsKzA1Q0JTQS9hcFdzSzRnUVMrRFp1?=
 =?utf-8?B?amYwdEZTUURtVXhSSXhJanJpalFjb2FWZlE2UHpiRkEra0lhbUF0TTZWOHpj?=
 =?utf-8?B?NHl0MUtoSVF0cFdRbTZxeVMwMHlob2hOVDcwb09NQVJuZXhabW1LTStYRUpM?=
 =?utf-8?B?M1FKcWkvcE9XZ2xXQWhjTStXcmxkSnZUd2tQSFMzc2lCcHRDbStlcWcvTWVF?=
 =?utf-8?B?akRISzZOZVl3cTF0NHpMS1dEd20vKzVxcDF1eE1xUDhpWkQ2eGVRRGVBeWMr?=
 =?utf-8?B?cGpJK1lSaEh5SU9SSmd0WHVxOEl2a0llVVdKbEpQUjFza1FJak4yRm5YcS94?=
 =?utf-8?B?YlQzckVtUjVkQ1E3ZFUvckxsL3VONjRwUE1sV3A1RTE0aERpazAzZlp3cjBE?=
 =?utf-8?B?blk0NUJkUU5uYStqUWpGeFZFdGlWNDBMeDdZNkVkU2NVbTBGcTlvTUtJY3pV?=
 =?utf-8?B?a25HMEVNUDZ0emxJbUs4TWxNTnR0cGkwNWFBaXNhWk43Qk82YUJZMWZCaFNY?=
 =?utf-8?B?M3BmM1d6cEJuamxoUGhIWTkwK0dKQWVvL21HSld4ay9GNzNZTGROZGhOR2lz?=
 =?utf-8?B?cE5FdnBuTkFldFJmczJRczdkYy95eXhXRFljbU81TmFlUXlwL2pFRytDeFg5?=
 =?utf-8?B?QllySHRBSWlhMHdMSlkzNytURkttcG9GOUJNVUpwYklOKzJ4eWFldnVUeVNu?=
 =?utf-8?Q?QSy/wRw3caO3qd+khHXK/utoX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d90102c-498e-4119-c295-08dbce314f71
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:18:58.8463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gu7MfTMK7DtImXA2nZlVnN5Pn0pLov2VE+hRolf/PM/YlhXvp8dNsvDLjjIbhJYrqTH2MU2UjdU/9na/kbEgrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570

Hi Joerg,

On 10/6/2023 3:46 PM, Vasant Hegde wrote:
> Current code invalidates single page and entire range for the given
> domain ID. IOMMU hardware supports multiple page invalidation.
> This series adds support to invalidate range of pages.
> 

Ping. Did you get a chance to look into this series?

-Vasant

> Also consolidate various invalidation functions, remove unused functions,
> re-arranges invalidation related functions.
> 
> Note that this series doesn't add support for PASID based invalidation (except
> PASID 0 for v2 page table). We will include necessary changes in SVA series.
> 
> Testing:
>   - This series is tested with v1 and v2 page table and it works fine.
> 
> This patch series is based on top of SVA Part 2 [1] which in turn based on
> top of iommu/next branch (Commit 8e5ab3f54a10).
>   [1] https://lore.kernel.org/linux-iommu/20231006095706.5694-1-vasant.hegde@amd.com/T/#t
> 
> This is also available at github :
>    https://github.com/AMDESE/linux/tree/iommu_flush_improvement_v1_v6.6_rc1
> 
> 
> Thank you,
> Vasant
> 
> 
> Vasant Hegde (13):
>   iommu/amd: Rename iommu_flush_all_caches() -> amd_iommu_flush_all_caches()
>   iommu/amd: Remove redundant domain flush from attach_device()
>   iommu/amd: Remove redundant passing of PDE bit
>   iommu/amd: Add support to invalidate multiple guest pages
>   iommu/amd: Refactor IOMMU tlb invalidation code
>   iommu/amd: Refactor device iotlb invalidation code
>   iommu/amd: Consolidate device IOTLB flush code
>   iommu/amd: Consolidate amd_iommu_domain_flush_complete() call
>   iommu/amd: Refactor domain flush global function
>   iommu/amd: Consolidate domain flush logic
>   iommu/amd/pgtbl_v2: Invalidate updated page ranges only
>   iommu/amd: Remove unused flush pasid functions
>   iommu/amd: Rearrange device flush code
> 
>  drivers/iommu/amd/amd_iommu.h       |  12 +-
>  drivers/iommu/amd/amd_iommu_types.h |   6 -
>  drivers/iommu/amd/init.c            |   8 +-
>  drivers/iommu/amd/io_pgtable.c      |   5 +-
>  drivers/iommu/amd/io_pgtable_v2.c   |  10 +-
>  drivers/iommu/amd/iommu.c           | 417 ++++++++++++----------------
>  6 files changed, 189 insertions(+), 269 deletions(-)
> 

