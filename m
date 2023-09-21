Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC598944C
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 09:49:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kM9Rx5Ki4AeWioW/b/jz68tvrcUQX9dShas1g0nmr5YyAVa+jZSrfE5kstzGLR9p4u71P3IdQjEtPPRblbNi5E7SNxHj8D/B/zJB3tbVyf+i8h0RLOoF7O07zHSFb/IdgjPwjJxjmZpIXC9Qb1d0wv/dQEPEnJS4dE/i1XuncKZoPgCwzZM1Q4iC7hyO1vkyGu+7DRBkjM2ZoUIYjdGuGLJXRGSGh8AVY7UoY7a871Omfn4WYHj12mbLTfdeZ7GeA/KVCWk6pNh8hLsTDnb4rWQJKQZmgPFXqTGdHvDhEuYoImCJ0y+whucH2f++A7PXUhubj72GxR190l6t02ndlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gujfaj7E9zbDmqH0LE2PwRQLPow9w02zd/6Puuw513I=;
 b=buaNSjY2GedcD/YmWpN79zSHq/Ol7dQ7DQbd921NNJPzMvo4niJ1POLjPRBy/cXApzmBbrOEnq/3NpX/7INk/WTsJCZ1yn/yeAs086c6aBzJiHNtoFxt1tYVgYClQYgY847r/u8l6HBNjxEXl5WO9XbiXYcTypUKm5l/bSspDVdHCV4Qquk6Fiw7k/3iz9pc8g/yoGLF/bDE5iAG1URLtWa9byBdgJwuzI8PwUsjjgme6TFwNUDeDsG3EnN+/TtV91WNcac3Mq15zQH4W/9LN/RIp8iAykwdu0Aik98T57OJZ2aPQh5j5xWqa3xiiGz7+cxCOf+gwSb14+j6RH/c4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gujfaj7E9zbDmqH0LE2PwRQLPow9w02zd/6Puuw513I=;
 b=A+Y01pgYf3MWrWs9pfITFAQ7TiEx5dNXCI/3QeiLGDSXHzpegO00HV6PcyNVwCJ43bCq2zNacd+cXdSGjgxs33YA2KzRABVGbltF1P8Dayt0w2UPSd3zrC5bJ6JN9J/ceot3DD1Xbq0NY+a4E9/hFDSCjmegiKf1TjD4BC8Bx5g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY5PR12MB6250.namprd12.prod.outlook.com (2603:10b6:930:22::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.20; Thu, 21 Sep 2023 09:49:54 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763%7]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 09:49:54 +0000
Message-ID: <04e44120-61fb-3aa1-50b7-8a9ac01cea7f@amd.com>
Date: Thu, 21 Sep 2023 15:19:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 00/14] iommu/amd: SVA Support (Part 1) -
 cleanup/refactoring
Content-Language: en-US
To: joro@8bytes.org
Cc: suravee.suthikulpanit@amd.com, wei.huang2@amd.com, jsnitsel@redhat.com,
 jgg@ziepe.ca, "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20230921092147.5930-1-vasant.hegde@amd.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230921092147.5930-1-vasant.hegde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0077.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY5PR12MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: f1552deb-e4d7-4d74-aac1-08dbba881b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vURokxhH6X3K29IcP/O6UGBmPuiwMDinJ4LvdlfuAJN8VOJpYoaJydtW3tGfUCGnqEVbostN+lL20VrItU0O4TfCIkgqcbtPmdoNvlmkgorMFsrP6jj4vjnp6PIf2cPk6+lJN6UxjzN2nG89y6NTWPCa2Z1v+0sqcxqMopJzyWR9cFH+tIry2J2ODYs80lW8kWhSuAIbUs0X4/YuEcT+GpWCBb7ywHkLz4tDkPsE4ZBbC4f4mO5PD2ITZq3mhZtYW6uugENR4VHIVaokmiHtZbV64jP8WPlKaoCHjQ23OlvHocNlJcSp/oY/lbjfkvXO34wi5m6bkaeG6j7HHVDTFcW4oKc86WkSrg/xpaai7PfBhSbmd1lAhDDaAkeWFmkQBp4RCmDEHVnumjJu/QCGunp52A5oJDfj5U23CH/Hklpa5r9OFZRIi+Ae4NiRqCFku48J9OUKsK+Hzkj5cv/Nc2nNEEpsVcGfd8uixLaMxyJ4E7XTc6gWVnEuEY/jezhPdaWAsRU2H788eY9gL+UuHOibGtsPDntay+d7CElJuqzR/LHGirDpdmxb7gC51b1hKNxXmPALFUpUCXch2UplGYJSf4uYDSUxC85R0Gur0O+6BOPiHmWhCqXApsq6F2Ga4e/Y58CKvaVkZw1FW7saZYf+e2Se1zVXM2VexykDsBGZnuGeK14BPLUV0MS77WIS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199024)(1800799009)(186009)(31686004)(6486002)(53546011)(6506007)(83380400001)(6666004)(38100700002)(86362001)(36756003)(31696002)(6512007)(44832011)(26005)(2906002)(966005)(478600001)(8676002)(4326008)(5660300002)(8936002)(41300700001)(66556008)(66946007)(316002)(66476007)(2616005)(6916009)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDZPWVN4S0V4YzQ1RUJUTzJnLzM1OUhLV0tLazg1L1g4ZWQ0UjVWNDBNSk5Z?=
 =?utf-8?B?eHZMelBKLzJXZ3JqQWIxejF1L0lvVzlVQXgxU1ZKRCtCRnVqRjVxTmFPSGlM?=
 =?utf-8?B?R2JXYlFmbUFBWHEwSE42blpKUzBkTlZqUVhXVi9uNXZBdklQelYvQWlscVMz?=
 =?utf-8?B?aDhyZ1lJV1hvYUFrcjhseGg5TkdEbnlxWHArcHNlZjlWY25oUTh0eVg1YkdD?=
 =?utf-8?B?b2tTT3BzOGhVRUZxZWc0M2s2N3V2NnorK2JieHZvOERyK24vZ0JTYSsrdncx?=
 =?utf-8?B?VkM0d0hnRkpmRkVmSGprTlZ1aVRYZ21NUjlWYWRESDBrcU42bUxtTnhRL3Bj?=
 =?utf-8?B?VVZSZEt2Ui9RRFhrcE9oZ0dvUWN1a3NPbTlvUGY0bDBjalZ4NXFGSXF2YXd6?=
 =?utf-8?B?cG1hdVhFTGZreFJqcmZVQi9MWjhXVkRwL1YvUHRDTVJFZW5GeXUvWkdmWVRQ?=
 =?utf-8?B?d0psaERTd0NBWmtOb0RoZ1VVOWVGeHJsNjBEZ0NhWHR3QUlFbi9lR09aMWpw?=
 =?utf-8?B?ZVFEcFJxdGtrV2NqQ1E3Yk9yTFlHeGx2SEZsUkQ3K0o2bTJ3MkFwOU1XQXZL?=
 =?utf-8?B?V3psNDliRisvWGx3NExVWjhPc2ZSTHVqaUk1VEFrMURYMnN4c0ZkUjRTam5S?=
 =?utf-8?B?YlgvWThIZDRGemczRUxlMDlNOFJYZmFEUGZlQVptNlhIT0dsVThHanFpeWtH?=
 =?utf-8?B?N3dJMlpxQWUzTHJZK2l3eEdKSUM4WUJNRXo4SDdseGUrK21VcnhodzAwTnJp?=
 =?utf-8?B?cGZQYlpZdXQ0WHJ0TzVWNzlHVVNmL01oTDdnMDJjWjBMYjJkYTVIUWltT0FS?=
 =?utf-8?B?R1lSRk43TWloUm96bVZwYitKSndVRVdrU0V1a2xOWGNLNjc3ZVZDSjAwZHRj?=
 =?utf-8?B?UkJlQi9kS05QQjNTVS9GdGE4aHBYTG4zT1RZSDNxVTBaQnpkQnFFVFlpY0pF?=
 =?utf-8?B?MjB1V2ZseVlTQWREb0RVcnVIT3YvRVVscExpdGoxaVJ3SGVHZFdYY1o4Ylpk?=
 =?utf-8?B?M0ZmbGg1MVh0c1oycEQ3OGlzNEFPRTlMV1BMWkhIUEQzaytDZTA2cmlEc2Qw?=
 =?utf-8?B?VmZjSGVBam42L1cwQW0rczNDZG1LaWVxRGZxUnFlZ0JBVjhXWEoyeHRqQTFs?=
 =?utf-8?B?eGhNcXRDSVBCV0s5Vk5BZ21CSVhORUlWVGd1U0xPWmdFbHlyZFhZVEdpQ1Ax?=
 =?utf-8?B?b1UvU2hGcTZocXl5cUNsMEQ2K0IrNWxIOUlvYUxHbVBtbjZpbzB4RitBRDg0?=
 =?utf-8?B?cFc1OWZoQUIvekhFYWdPUjNsWEFGOVhOa2FsWlFkWXoxZjNBK3BoMys1YUhG?=
 =?utf-8?B?Y1JrVWJDRjF2MXlieUlvczN4VnAwYTFvV3R2RG9hcExpUG5SdC92TEhFK0xp?=
 =?utf-8?B?eWlFTkRaQmZISXF5R0tzNDVtNEpDUzRzMFhUQ2tVMzIrQTNuOFVPVEYvWUpS?=
 =?utf-8?B?SitZNlJnRDFCZFkzdGp2QmxVL21ZQjMxZmVkaWpHdWZRTDROVkYyL0U5aVRn?=
 =?utf-8?B?VjZhWmNzbVdXWnRDNUFhaGxZVExDcXlzdHV6clYvWjRPei90ZkVNcXhjTlBk?=
 =?utf-8?B?RWw3Y0tacmFicGg3SG5Fa0VxV3k0L2Z1RlZLc0xKTkU0NGtPTjYvLyt2ZDF4?=
 =?utf-8?B?T2swY1lFSW83eS9zMHRjUHFwaW1ndEFqL2dOVUlDamZSY2FvMlhCVDFRcEMz?=
 =?utf-8?B?cVM4OExUYnNrbG5LZ3dBZXVnZE1iUUNSaWQ1ZlhYT0M2WXRKV3RpUFplZXJZ?=
 =?utf-8?B?UnVIMGMzbFZPbThBcHRIc2FGOXN0ekllQ2dxckVqVUJZTmRVUTd1dllsT25Y?=
 =?utf-8?B?UTlYL1IweFA0b0krK2h6Zk1CTVJYc0tiRlB5SCt4K2ErbS95YlNnRDZOeVZa?=
 =?utf-8?B?NTNqakoyVmNTTzd6NGppTDJRZFptVXkwdjJTcXEycXpVNkhrT2ppMlpaR3RV?=
 =?utf-8?B?cHZLMHVCZVZZY2ZLcHh0cU1KdXFCcHJEaUJtOUN0MmNWcFc5aktkK3YzU2FF?=
 =?utf-8?B?MUNmUkljRDlZVlZnMHNSRjJnMXlDb2grVTJMUllTbnRBdTlxNkN0SFBTZjhG?=
 =?utf-8?B?MVg5dG9DQkovazFNMVJqeWRoR29Wd2xwYVlud1B5MUl1eTVuSFRvUGpPM2Vs?=
 =?utf-8?Q?l4aPWt1/KxLvw74WCTdd/KXps?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1552deb-e4d7-4d74-aac1-08dbba881b7a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:49:54.6358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TE0TFKBqqoHkpbjMlQfiC8lfBaHjq8Xo61p+G1zcU4P86FF9Xkd9pVsp1tYH0rfyIlHc/soaF5K6x/0dEUi/9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6250

Hi Joerg,



On 9/21/2023 2:51 PM, Vasant Hegde wrote:
> This is part 1 of the 4-part series to introduce Share Virtual Address
> (SVA) support, which focuses on cleaning up and refactoring the existing
> code in preparation for subsequent series.
> 
> It contains the following enhancements:
> 
> * Patch 1 - 7:
>   Clean up, refactoring and miscellaneous improvements.
> 
> * Patch 8 - 9:
>   Use global functions to check iommu features
> 
> * Patch 10 - 14:
>   Modify logic to independently enable PCI capabilities (ATS/PASID/PRI)
>   for devices. This allows more flexibility in preparation for SVA and
>   IOPF supports.


This is an independent part of bigger SVA series. This particular series is
tested independently and it works fine. Can you consider picking this series
while we work on sorting out Part3/4?


-Vasant


> 
> This patch series is based on top of linux v6.6-rc1.
> Base commit : 0bb80ecc33a (Linux 6.6-rc1)
> 
> This is also available at github :
>   https://github.com/AMDESE/linux/tree/iommu_sva_part1_v6_v6.6_rc1
> 
> Thanks Jason, Jerry, Robin for reviewing previous versions and providing valuable
> feedbacks.
> 
> 
> Changes from v5 -> v6:
>   - Rebased on top v6.6-rc1
>   - Added Review-by tags
> 
> v5: https://lore.kernel.org/linux-iommu/20230821104227.706997-1-vasant.hegde@amd.com/T/#t
> 
> Changes from v4 -> v5:
>   - Changed dev_data.ppr from bool to bit field
>   - Reverted sysfs_emit that was changing existing behaviour
> 
> v4 : https://lore.kernel.org/linux-iommu/20230815102202.565012-1-vasant.hegde@amd.com/T/#t
> 
> Changes from v3 -> v4:
>   - Dropped patches that were touching iommu_v2.c as we will be deprecating
>     iommu_v2 module.
>   - Dropped Review-by tags for the patches which got modified (mostly the
>     patches that were touching iommu_v2.c code).
>   - Introduced new patch to use global EFR/EFR2 to check the iommu features
>   - Pass enum to set_dte_entry() instead of bool
>   - Used DIV_ROUND_UP instead of loop to calculate gcr3 levels
> 
> v3 : https://lore.kernel.org/linux-iommu/20230804064216.835544-1-vasant.hegde@amd.com/T/#t
> 
> Changes from v2 -> v3:
>   - Removed fallthrough from switch-case
>   - Added lockdep_assert_held() instead of comment on top of the function
>   - Moved macro defination (PPR_HANDLER_IOPF) to the patch where its
>     actually used
>   - Use helper function to allocate memory instead of get_zeroed_page()
>   - Converted boolean to bit fields
> 
> v2 : https://lore.kernel.org/linux-iommu/20230728053609.165183-1-vasant.hegde@amd.com/T/#t
> 
> Changes from v1 -> v2:
>   - Dropped GCR3 related changes from Part1. We are reworking
>     GCR3 management based on Jason's comment. We will post them
>     as separate part.
>   - Addressed review comment from Jason
>   - Added iommu_dev_data.ppr to track PPR status
> 
> v1 : https://lore.kernel.org/linux-iommu/20230712141516.154144-1-vasant.hegde@amd.com/
> 
> 
> Thank you,
> Vasant / Suravee
> 
> 
> Suravee Suthikulpanit (8):
>   iommu/amd: Remove unused amd_io_pgtable.pt_root variable
>   iommu/amd: Consolidate timeout pre-define to amd_iommu_type.h
>   iommu/amd: Consolidate logic to allocate protection domain
>   iommu/amd: Introduce helper functions for managing GCR3 table
>   iommu/amd: Miscellaneous clean up when free domain
>   iommu/amd: Consolidate feature detection and reporting logic
>   iommu/amd: Modify logic for checking GT and PPR features
>   iommu/amd: Introduce iommu_dev_data.ppr
> 
> Vasant Hegde (6):
>   iommu/amd: Refactor protection domain allocation code
>   iommu/amd: Do not set amd_iommu_pgtable in pass-through mode
>   iommu/amd: Rename ats related variables
>   iommu/amd: Introduce iommu_dev_data.flags to track device capabilities
>   iommu/amd: Enable device ATS/PASID/PRI capabilities independently
>   iommu/amd: Initialize iommu_device->max_pasids
> 
>  drivers/iommu/amd/amd_iommu.h       |  28 +-
>  drivers/iommu/amd/amd_iommu_types.h |  31 +-
>  drivers/iommu/amd/init.c            | 116 +++-----
>  drivers/iommu/amd/io_pgtable_v2.c   |   8 +-
>  drivers/iommu/amd/iommu.c           | 442 +++++++++++++++-------------
>  5 files changed, 322 insertions(+), 303 deletions(-)
> 
