Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1728E134AB
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 08:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbOrJJzq+dwraw8S6t9PwR/HiLU663hte306a9jPD3Yxa171Yn6RBQtg35rbNupmgm2ZL9g0Ev1/plFZaIAHcIRCDkpF13s7KDuA8wAJAx6o/ivpOGTUQtAes139L+FxJStGD3DKrMx0DtYBoie889CUzABPhUV3AUUQplcUr0nynvUmJ6mUiLbZyP0xTPX3rleB6Wrp/x7acE2PEL4lQmjvJara2fLItSicwN5EAYeDoXwxg7VRH9ScUwloedR4dyYerTeYD+SdGrqf1PP9JZ+gsfp8BXPPbL1ML5kg8dTt7LN9QjnuBatsdihTN7mfj4Fydj8wuzRJB/fRyCAuyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dLRDRY4nScsUuvGRMYGAC4RrMJEpHNO/NV2dIPTmFk=;
 b=BbwduxFbu6qUsY+Hwn/HT8uZfmaYxF0thsKUW1PogeSS1HNv0f8Y7IawXeLCt6LYjlam5Uts7y3oaTaITJlYuZvKRvUWA2YYfV0JSzFvVw6HavAnmKnCsYqBL/wgK/Z8J7WBP7QLykBIdLxnADsD/JwtvyhYZ+LAmHn2qZLek5+T2JFcEHBJAP0DB/AvbF4nsvgVMdBDYe53/jGQvmO21LmlZBMhR9Few5fCpFhlmc38xrlIPYYm/qANrioGJvqljVLjZ/A1nvf7qL8jrnkmbc3p9zhYLAnVldYrhhE3L9cuw9ZBDOIGWm00O5dpdS0hDkh7iS72URZXh2mzipZFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dLRDRY4nScsUuvGRMYGAC4RrMJEpHNO/NV2dIPTmFk=;
 b=aAvuQ4S6xw4ijRgt38u5jJl3SCVJjUcyjEjcpTklz6Uqmivd0gjCiXn0RJYJ1bGDVyAELiMwVZ3b5c8M78R9Um7YEGpHe24hDwTmRQMkFfmNFY+wuhVk0PglobJ03oI07WSlmvIznV7U454BP05RXEjXUI2VWe/d72GkxsJxx0s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.28; Fri, 22 Sep 2023 08:52:25 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763%7]) with mapi id 15.20.6792.026; Fri, 22 Sep 2023
 08:52:25 +0000
Message-ID: <f738e94d-1c1f-94e1-c4e3-752671af3c90@amd.com>
Date: Fri, 22 Sep 2023 14:22:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
 "Huang2, Wei" <Wei.Huang2@amd.com>, "jsnitsel@redhat.com"
 <jsnitsel@redhat.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921163154.GO13733@nvidia.com>
 <19c7c139-b002-384f-5766-b87a8013029e@linux.intel.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <19c7c139-b002-384f-5766-b87a8013029e@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: cc256436-552b-4f50-506e-08dbbb493d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9To1PtYRkHjSX2mf+Y80VwVo+eaKEl/oZys36QGBKkwLPcuGv+VtEzgWsc2t4gs+TeatS7wtXm9J/J1RGGiiLDTuUr6j2ZQUKcIWQAcKj/OGqLZQi4SaNd8on7rU1ul6dlJTV1WJul+FsCWbiAAOtkMtL8c+h9t61Ub7XlfvExw3GiPvcKBqM0dla9Ln0xRzPL8dhlgo42RXqiQFhwSE3dawSfQ2TPSHvl3sqIhX1M9DlFKJsP3uzKzXVW3Zw30c3nADDbT5aSlHz97zHajN3TnpxlmFDPPbTKEP1vb0AxJO1nzrKHzTH6bpegg23Hb0HrW1ekRmmDCMbhc/IS9t5vuT5a8rwKufsUEf+8gBhXHydnmYlSHIIjPEalf7/8/32+0NB1khmfafmAjlyW8JJBdlisvDrfiPClRBlHNhaTWXt/wCeEPgy0lDHqIdf1TMv8fZDUELHPpvSxSj+n1hf/dD3CAKxD7pZA/yXv/scbEhKi/zjQ2TlnWnY0Y3qJVJfaJ+YBl3+j4UmOFeeWsGWwjiNJG4durKiaqLNmZIOqELSwwPNwQM2QuIo3rg3hdhbyTIxN8SSLprpNQ6yRFeaov4mGZbWnfCdkL5QnZqzY+kOQ7uHPDCZRFP11RRhakE9YCF+zxsqaTYb5WDaCr3vA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(136003)(366004)(186009)(1800799009)(451199024)(6486002)(36756003)(6666004)(6506007)(53546011)(5660300002)(4326008)(26005)(83380400001)(6512007)(2906002)(478600001)(2616005)(316002)(66946007)(8936002)(8676002)(66476007)(54906003)(66556008)(6636002)(44832011)(41300700001)(110136005)(31696002)(86362001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WmlsZXB6ZUtuL3lNYWpiRlJIWXVHRTA5aTVzSEFHdFZ0QmdrRUtlNzQ5K3Ja?=
 =?utf-8?B?QVFoaVFRaTFvSTlCZDVoK1k2VTBPRzd4dUt1WjIydUNWZWF0ZGszWC8vNWZH?=
 =?utf-8?B?Q2hUWnFZaE55VzJqMUU1ckVOMmJMVEI4azBnMURkV0VkRHQ0RjhKa2xBU1RY?=
 =?utf-8?B?alBkTi9SNHNjdWtJL0ppaWRYYWlNUnQxSW14UmY0OGVDNGplWE5iY1VBVzNE?=
 =?utf-8?B?a0x4aWlqNU5jczJQa0llQnQrdjZITFNmYzk2QVhRMWZrdDdCMktCcnNiWENa?=
 =?utf-8?B?bVJDdTJXL2hhbmtoQi9xelBQTzlyR0psRjhsN015VG9xT2UycmhtSkZaL0dv?=
 =?utf-8?B?dnlVY1pPejYzSlN3YUZQbTlyb3dHMnBTM3BCdGE2elhhSWhYQ0RDNyt3ZmZR?=
 =?utf-8?B?L0Z2WjFUTGdRUUFsVjErQ3NnVjVRbkt3N1ZFbDNuMTZrU01WeFJHOFhGY1Ez?=
 =?utf-8?B?bjZ4STlmQm91dnJjTDI3UFVlMDZ5alhiK1RNZkVaVjFhSTVIZWRkNXBXVkVN?=
 =?utf-8?B?OVpiQTA3ZFZEQTN0WGRzQk1BbUk3ZEc5aCs0VlpuV0hFanE5L2hDM3BVU3hM?=
 =?utf-8?B?RERiNENUZUFsSkN1aGhGVjZ6VXRmZE1DVnltdEtrSUw5blRZbGxXanluS09T?=
 =?utf-8?B?b2FBZWZOOVZIOUJsSUswN0p0aGZ3Z1IzdTRLUGttSTRMVHhjK3ppd1JyeXd0?=
 =?utf-8?B?cFlVZTZueGc0MWN4bnRtOGtOazVrQmRjZzdGVW5kZGFjUTBPSXdFK2M0dE44?=
 =?utf-8?B?RHBBWG9JTkUvaERKRzV6dTNqdUV5WW04dTRWdktzbU4yVTdoT0ZHUEtEeGh4?=
 =?utf-8?B?cEk3WG02enYvYkVxNlY0OVJSOFRKRVdpdUhyMFJ5ajNjVUNUcFdkVTFGYzRG?=
 =?utf-8?B?SHl1NHpTc1BoWUxwWW1qYWpaNTFQQ21sdE52ZWRZbHNscDUwOGtLcU1JQzBt?=
 =?utf-8?B?OGpiU0swdmdPUjd1WGduRFVXSlBSZzhEWmZRbzlIc2t4cXhGdk1pcWwzMnZa?=
 =?utf-8?B?d01lYnZJaXd1eGg2a0g0cGg2WCs3bEEvVmFuNWF0NzM5MURkMlltdklvMUZx?=
 =?utf-8?B?K2V5M0E0UUtaRW5IM0V4d09RaE1EYkNOL21Ma2ExUUNwR2dVdFpvYk5RekYv?=
 =?utf-8?B?UW5JY05acDNBVnNNczIxYUpZaitaVjlObnMvRDdNb0VEbktRVTJOQmswUkhm?=
 =?utf-8?B?YWR3VnlVYXBoZFNlMGdLVEx5UlhWSGpPSngxaVBaMDlYY1p4Q3AyTUxGQXNs?=
 =?utf-8?B?M3d5M25uYWpzWTJTdGxmS1phdm5UK1ZZVCtORUhTdGRaR01veVpUbjlTSUtK?=
 =?utf-8?B?WE1QaTFZcndNQkFhNFFKaU5VZHJJNFF2K2pocVZXRkZ1VkdvQjJyeThBUkxt?=
 =?utf-8?B?Z3o3YzlCc0FMWjRZYzdhODI0MEVmeW5yNGwzZmZMZ3o0RkgrUzdWSXRqV1Nv?=
 =?utf-8?B?VmlpbTBjWHJqRjFDdnlPTWxEbUJVSFB0ZmZPRnI1TUxZbEtvaFlyazE5WjNR?=
 =?utf-8?B?UTh0TTc1VmFHYXRwOEFhclBCWGdhbjN4STVRbUNIbHJ2ZGN0WVhkQ042MkY4?=
 =?utf-8?B?ZTZLbGUvN1ltSUJWNzAvdEVnSVdqSXk3dE9pYWJiZnRxbk1UbVVNTi82UEZR?=
 =?utf-8?B?cGdNWGdsempXZjU4UFM5Ty9XSWxSd2NCaE0rN2ZrTUlPNlVpN1B2TlFvZVNx?=
 =?utf-8?B?a0RsZzMySlN4V3AxSGRtSjJ2NDJMUE0xNWtxa09CTGV3WlpmZXpHM2FWRmxs?=
 =?utf-8?B?ZUNSTGZyemlXZ0dyRU8wbjhIc2JaRUdtMlNDaDhMbWpGK1JhMVlOSjVGUmVU?=
 =?utf-8?B?YzlTcGNXaU9GZFBKU29uWmJZL3pyTmpQNkhmWGhXS21SZndRMGtiVFQ0SEJ5?=
 =?utf-8?B?Ync1eHYrVmR5bDR6cWNlenFWV0plTm5ia0I3US9UMyswd292c21PM2RYQk82?=
 =?utf-8?B?Zkd1S2Vma1lGN3UrQzFBdzJRM2hRU3ZUM0pGRDBkM2hiajZWTldTZCtHRnVK?=
 =?utf-8?B?SWVrNTE3ZEhBVkYyS2p1My9nUVFVckkrYXB0ZDlDdDdBQ0NCRGh3TU1MQ0VE?=
 =?utf-8?B?cmMzbWhETklTRXJMM2ovVDFUMTBPcVhJa3VHYjFNSndCRkRkdUdxdnN1NHcw?=
 =?utf-8?Q?ZEepnwSw3c44fn+lnPEZ+fWeR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc256436-552b-4f50-506e-08dbbb493d62
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 08:52:24.5665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: baKfeSvPWUdLJ5l05Iru8MwMpOyHdlLUJWf4UmDQQZO900Gh09nFToK1SWmrB1dC3Es3pYUacvOpbX+2P7BC3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141

Hi Baolu,

On 9/22/2023 7:53 AM, Baolu Lu wrote:
> On 9/22/23 12:31 AM, Jason Gunthorpe wrote:
>> On Thu, Sep 21, 2023 at 03:15:42PM +0000, Deucher, Alexander wrote:
>>>>> Does this patch or the following patches make any functional changes
>>>>> for devices?  E.g., devices which supported ATS would have been put
>>>>> into an identity mapping mode previously Is that still retained?
>>>>
>>>> Huh? Why would we ever want to do that?
>>>>
>>>> Policy for the default domain belongs in the iommu subsystem except in
>>>> extreme cases, the AMD driver should not be doing random things like forcing
>>>> identity for ATS capable PCI devices.
>>>
>>> I'm just concerned about regressions in random devices due to a
>>> change in policy in the IOMMU driver.  Previously the IOMMU driver
>>> would put ATS compatible devices into 1:1 mode.  Also some of the
>>> earlier integrated GPUs require 1:1 mapping for display from system
>>> memory due to hardware limitations.  There were also a lot of sbios
>>> bugs in the carrizo/raven timeframe because windows didn't enable
>>> the IOMMU so lots of OEMs had bogus IOMMU ACPI tables which didn't
>>> cause problems when 1:1 mode was used.
>>
>> That is a fair concern.
>>
>> But we need to root those out and fix them as narrow quirks. We don't
>> want a driver to have blanket ATS == identity configuration, it will
>> harm other legitimate applications.
> 
> I am interested in the policy that an IOMMU driver would apply to ATS
> when the default domain is configured in PASSTHROUGH mode.
> 
> I have considered the following cases:
> 
> 1) PCI device supports ATS but *no* PASID
>    In this case, ATS only means a TLB cache in the device, and it does
>    not make much sense to cache the 1:1 mappings in the device. Even
>    worse, the ATS translation requests could probably cause I/O
>    congestion in corner cases. Therefore, the best choice is probably to
>    disable ATS on the device.

IMO we shouldn't enable ATS in passthrough mode.

Today AMD IOMMU driver by default enables ATS (even if device is in passthrough
mode). This came up in one of our internal discussion. I intend to look into it
ATS related stuff in detail after SVA series.


> 
> 2) PCI device supports ATS and PASID
>    In this case, ATS is required for PRI, so we should enable it even if
>    the default domain has been configured to PASSTHROUGH mode.

IMO we should enable ATS along with enable_feature(PRI).


-Vasant
