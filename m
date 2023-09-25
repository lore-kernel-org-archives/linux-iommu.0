Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A151C283
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 15:31:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPfsC/Nmzb7vqG8r/fOGnaeDspwWY0bXrq9mPEWw8IttLSMsjrRD1YBR03pDeqSp9ej6SAS2j0j+8rLf0k0uDU+yQQvA4aCQz+4KYUjivnqiBYEMG02E2AEwFmVOC8+6Io2aRJBK2B1kJgq4cmxZwW0Ffw+4JP4/RrLZzoTlI6sVpH3BvqVm935EPMVpPX5SOa4nwA20zrajDARiZzkQYS3QXUzjhTTlrCvjG0sVcos6QUG6xE+VxyUtVtRUBuV/sBmiPQJa8HsLNepLDkiUSRlaybPLwctxLbklryRMuwdYnhztwUSoTyms7zdWc5GUKKwv4YhTzDB9zOCUPlpgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l80py+dXmhLrhfQ+428QuTJUdj+IDuyfqvSVk7cZpgI=;
 b=mUef3jtnQteL+JTWMvkUf/U2js9QW4iSQt8DodaHt48VH9D1i1S54rnpOr/V9Vvv3D2iyyDT82IKYOFQt5TlOLGOpl/VTuZWKRLrBPoKxZiZm9S7unA5Qd/h9JNDMUhmvPFfq8a5CXU4nqrazmY6eOOBGbi7oQcwDhZX1UPKP2P4WXlFKiA8fD5H9Y2h2OkZmRhMuHBZw3TXa0R3taXuzje7Hl/eU1oJgkstoBsO+FHLx3HxJFkt/GUhJKGMFGthVuEO4YweMHg4DWhaFXZvnAlTds57+kGGi4ddtqbcBDyMbjs1ihqxkzdVuUyJYjGvq9hcx1JqkYOfWfatRsoNLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l80py+dXmhLrhfQ+428QuTJUdj+IDuyfqvSVk7cZpgI=;
 b=pLly7d7LBivPFDwau2qi3o6+q2684CPg8nUlcH6CHOaFx5NMzzIZZQVKWW2bMTDxYAT3lt2AfuPOXDejJlX5fwzdsD+kZlYaoSefTXM1Y6x+ppd/lhm9E0GYXQmhMO5tz6gjIxdE4pCpGCim0qRVTFgNg+eCX4npiUoSsaL3IMY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH3PR12MB8457.namprd12.prod.outlook.com (2603:10b6:610:154::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.24; Mon, 25 Sep
 2023 15:31:09 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763%7]) with mapi id 15.20.6792.026; Mon, 25 Sep 2023
 15:31:09 +0000
Message-ID: <3378be5f-1de0-a4b7-dcc3-4ad81f5c4585@amd.com>
Date: Mon, 25 Sep 2023 21:00:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Jason Gunthorpe <jgg@nvidia.com>
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
 <8d7a8fa9-020c-2b0b-1bfe-0957bffb198b@amd.com>
 <BL1PR12MB5144A7E4B810C58FE9208DE7F7FFA@BL1PR12MB5144.namprd12.prod.outlook.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <BL1PR12MB5144A7E4B810C58FE9208DE7F7FFA@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0182.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH3PR12MB8457:EE_
X-MS-Office365-Filtering-Correlation-Id: 212ce9fe-d5b0-44c9-de20-08dbbddc7124
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JnHVxoyVnxHE8FA9P9Gr2/+JdRaAfe5YpCf/doWUSNVuKEou8pUKcBqk2+Jbw9RHhHngztfR5VnMYpMlmvmJXTUeIaJPaakUczQhCu+0/0ZiuGFC9/MY7+ZLTRphn0ZTyT6Jiqs9DRRanSi6iZfYMUCil5q6EYvb3DsaefnsaMQEcgCT2nWa4tCVhZMSrHS1uuyPieDAY6Q+AahxSL3pHujnblHK53K61GebPhzBFiFuQvnSc4bmhZmrxWKXbSLrSx2uiPdAtHvckNgBj7q/qnQZMZ0bf74l/k6Y6eKrndEbttl4ycHBiZoHSZiZ/ClBKlJGcou33evWcIkakNS47xgkfb728R60Vot+UluO4ifQwwv4tRLuh6Iwc1Sc5Yr+Qh53istxfQhJxvuetgwS9B5U0V6ZJMyqly1DIXuW1SW1qeYn1APcfC4wKz/Wp/Z28NjnlaWr4p6Xfb+UL8xrqwRWKbQXNkdNNglzeyZZ8WBquVdl9wNE9XS8WEl9O27iDoZDpfOdkqSSSIIf+O55t1hXFTFsZm7Nfid9UmDuhrIwP2Qn8yP1hFjZMOlIlly27uzsNBwwNbwq/QPT5RDsUlUN8EnJVMdNs4a683LobKPzWpFX8Fu4aKkajR7x4PG+XmBZfU/UFXbkKPEbKc8cNQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(230922051799003)(186009)(451199024)(1800799009)(31686004)(2906002)(4326008)(110136005)(44832011)(66476007)(66556008)(8936002)(5660300002)(66946007)(478600001)(8676002)(6666004)(86362001)(6486002)(53546011)(31696002)(26005)(6512007)(41300700001)(38100700002)(2616005)(316002)(6506007)(36756003)(54906003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akErQi92SUFzUzYrV2JVQ3J2V3dXQW56bnlGSWl2ZzBLNEcweTgrZEZCOTBt?=
 =?utf-8?B?aUoxbDBVbk96STEwVTVSZXI1UVMxU0tjK0dxWUMySUxQM0V3YVlndzZMcGhv?=
 =?utf-8?B?NnJvQzhmVzVVNmxsdERHQ2dVT01naEp5Y212Q2VFY0tiNmZDZ214aE1GeEpQ?=
 =?utf-8?B?RW10VkgySm5DVHVaN3dwUUkzNzBYRGZxZ2cvZzNxQjNIdzJyOGtLbjZGblBD?=
 =?utf-8?B?VkJ3VW1BTjBoeTYwQ0hqSklIejNDMHBOWG5DM0wwL093eS9HczBrL01BeEJh?=
 =?utf-8?B?eHBhcmxYeGt6NEVHMUp0NGxxYUI2T1hKaVNhWk5sNm9GQld4Y2lDajIycnBH?=
 =?utf-8?B?V3NpZXhoOFpaUGZsajlUMDVtRHFOeklyNmJkRTFNWUpTdXg1L2lkcDQrYmpW?=
 =?utf-8?B?Y2tuRzFIU0Z6aFNtUnZYQWdzSkQ0WHdlcEhHL2cyWFQzVmpXc29zRHB4VnMr?=
 =?utf-8?B?U2RDU0JQaU55VTV5Y1VtZ1l1YmZ1eWM1enU1c3F6OGdTeFphZDEvT3dGMVlp?=
 =?utf-8?B?OG51eFp1QkFMVDVuU0VjME5LSEZKbkQvNjJOVVBUbUdoZXpVQnpYSFRqQjhL?=
 =?utf-8?B?dWZKV2JZd0VONGF1UEozaGdsMVdKeHozZ3BFTWI2WUdoNE9NM1FKdE9MVnZu?=
 =?utf-8?B?WkZtN0pEOEs2RGR6MkVXb3ZxNkVmVCtvb3dVMUNVTisxK1EyR01BUUFNenEy?=
 =?utf-8?B?U3hNdVZrdGc2RFptZXlkTTBaRE9uNVdiT2xnU3BZeHh6WjlyWVFxWC9sUW1F?=
 =?utf-8?B?ZVVIek9ieXJDWFo2MitDSTRMT2xydkZsZ3JrK0lvMGQrT0xkZXo4SlVsRUVB?=
 =?utf-8?B?RG16cmRIdUVNakUrZXk0OEJxYTRtUXhYZDIrOXZldHNnMXprV2JvbnVxSURD?=
 =?utf-8?B?ajluUWVFMGwxR3FZakNEWUFPaDhydDd3dlpBb1NaWStQTzRCazN4LzZSWURu?=
 =?utf-8?B?SnIvZUZtVTlSWHZxTDdzWEdMUVNPR1dSMldVelZrN1hJY1RpWFo2SnlnOGR4?=
 =?utf-8?B?UHVEclhZekZYMGkxYUI3R3pOVTR5bmN2OTQvbElxMFIycis0eUZObTFBZ0pK?=
 =?utf-8?B?cmppS2Nkc0N4aWtQK1BzbTVteVJ1VlFBLy93NGIzMEtEVERCQnpiR0Yyci9R?=
 =?utf-8?B?UWRTMkxhOGlVSEoxc1lyMlZUcnphYXhZSWI3QmhSZFF6R1JHeGRERkJoY1pn?=
 =?utf-8?B?VjFxR1NqYWpjZXUwWncxNDQyeEV6bGRWUVAwMHphNThWQ2xYYytoVHIyWHVK?=
 =?utf-8?B?V2xlWS91bS9RbHl5UWlUQkh6Vlhod1hSSmNlY3hjT3pQYTJIUGFFZU9DdFNr?=
 =?utf-8?B?dGtqaE9SV0NWSStLZ20zMUgrQzJoS29LQlhhQ2g1RDJPRmNXaGJhWGV6ME0y?=
 =?utf-8?B?dTIxNGFrdkdFd3NEcDUxU2w5Q0JPQi8zTndTdVpMQm4wREtCNGZRczIrMFpG?=
 =?utf-8?B?aVZuQXNldHp6VTNySnZsQVZtYzBwQ05FV21kemE2QzVNQnh2elBhUVpKZGVq?=
 =?utf-8?B?MVBBUFJETEJNTFdBZURVMWptdjh6dGxHdHY0UFlUdkNsOHY3dDhLbHFhbUxt?=
 =?utf-8?B?eXJ6ZCs3c1grbTdPRnpGQkRad0NNVXVBVVZRSFhGQ0NRcFZNNmJFYkRFYnI2?=
 =?utf-8?B?eXdpdHh3Q1hhN0hvMUxFUXdDbXpWaVYrajFDMmZlZDgyMERhN0JmZHpDb2k2?=
 =?utf-8?B?eXA4TTJFUzg2TVE0ZE1KQXZaT080ZW1lei9DbTFlOGRVVGRJdkp2ZjdQMHcy?=
 =?utf-8?B?OFY4QmtoTGF3L1lndEFqWHRzS1p0aUEya2FMNENKQjBHejFtdkJ1di9lVm1H?=
 =?utf-8?B?aVM5Q2VuVnJzaXZFK1I2bkhKV1NPK1VqNjZsNkdaSTluVXpDUkl4Q2gvT05l?=
 =?utf-8?B?Q2l0K3ZrVzJDdm1ET1lrTkYveXg5U2JIcEtBdXRicHBScE41UVRNSE1iREE0?=
 =?utf-8?B?eHRMMU1XbkxpY1RUZXg0UFNCc1B5VW1zVDBrdEZEUkVHY214WDlraTcwZ3hE?=
 =?utf-8?B?Q2tpcE40ZllnbFRKdDZwbmN2RHRqMWl3UHlHbVZucmw3b1hzRElwQTVTRDUr?=
 =?utf-8?B?dUE2M0d1OXZNZjVOTzJUN0JzWUJoM0xUYXJYbjdnTzFXVHRwb0VvVldiSjhT?=
 =?utf-8?Q?Sxg2v83vhllHVeeORBofkVl3i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212ce9fe-d5b0-44c9-de20-08dbbddc7124
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 15:31:09.5579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahbxmkCWb8oZWoDK4GZgomrn35XtshyIslE8oKGQQTc0g0yaV5VGKIELKje4Dt97A3MwkBN5kkZ0I3puX6dXQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8457

Alex,


On 9/22/2023 11:43 PM, Deucher, Alexander wrote:
> [AMD Official Use Only - General]
> 
>> -----Original Message-----
>> From: Hegde, Vasant <Vasant.Hegde@amd.com>
>> Sent: Friday, September 22, 2023 2:45 AM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Jason Gunthorpe
>> <jgg@nvidia.com>
>> Cc: iommu@lists.linux.dev; joro@8bytes.org; Suthikulpanit, Suravee
>> <Suravee.Suthikulpanit@amd.com>; Huang2, Wei <Wei.Huang2@amd.com>;
>> jsnitsel@redhat.com; Kuehling, Felix <Felix.Kuehling@amd.com>
>> Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
>>
>> Hi Alex,
>>
>>
>> On 9/21/2023 8:45 PM, Deucher, Alexander wrote:
>>> [AMD Official Use Only - General]
>>>
>>>> -----Original Message-----
>>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>>> Sent: Thursday, September 21, 2023 10:14 AM
>>>> To: Deucher, Alexander <Alexander.Deucher@amd.com>
>>>> Cc: Hegde, Vasant <Vasant.Hegde@amd.com>; iommu@lists.linux.dev;
>>>> joro@8bytes.org; Suthikulpanit, Suravee
>>>> <Suravee.Suthikulpanit@amd.com>; Huang2, Wei
>> <Wei.Huang2@amd.com>;
>>>> jsnitsel@redhat.com; Kuehling, Felix <Felix.Kuehling@amd.com>
>>>> Subject: Re: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
>>>>
>>>> On Thu, Sep 21, 2023 at 02:05:37PM +0000, Deucher, Alexander wrote:
>>>>> [AMD Official Use Only - General]
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Hegde, Vasant <Vasant.Hegde@amd.com>
>>>>>> Sent: Thursday, September 21, 2023 5:32 AM
>>>>>> To: iommu@lists.linux.dev; joro@8bytes.org
>>>>>> Cc: Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>; Huang2,
>>>>>> Wei <Wei.Huang2@amd.com>; jsnitsel@redhat.com; jgg@ziepe.ca;
>>>> Hegde,
>>>>>> Vasant <Vasant.Hegde@amd.com>; Deucher, Alexander
>>>>>> <Alexander.Deucher@amd.com>; Kuehling, Felix
>>>>>> <Felix.Kuehling@amd.com>; Jason Gunthorpe <jgg@nvidia.com>
>>>>>> Subject: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
>>>>>>
>>>>>> AMD GPU driver which was the only in-kernel user of iommu_v2 module
>>>>>> removed dependency on iommu_v2 module.
>>>>>>
>>>>>> Also we are working on adding SVA support in AMD IOMMU driver.
>>>>>> Device drivers are expected to use common SVA framework to enable
>>>>>> device PASID/PRI features.
>>>>>>
>>>>>> Removing iommu_v2 module and then adding SVA simplifies the
>>>>>> development.
>>>>>> Hence remove iommu_v2 module.
>>>>>
>>>>> Does this patch or the following patches make any functional changes
>>>>> for devices?  E.g., devices which supported ATS would have been put
>>>>> into an identity mapping mode previously Is that still retained?
>>>>
>>>> Huh? Why would we ever want to do that?
>>>>
>>>> Policy for the default domain belongs in the iommu subsystem except
>>>> in extreme cases, the AMD driver should not be doing random things
>>>> like forcing identity for ATS capable PCI devices.
>>>
>>> I'm just concerned about regressions in random devices due to a change in
>> policy in the IOMMU driver.  Previously the IOMMU driver would put ATS
>> compatible devices into 1:1 mode.  Also some of the earlier integrated GPUs
>> require 1:1 mapping for display from system memory due to hardware
>> limitations.  There were also a lot of sbios bugs in the carrizo/raven timeframe
>> because windows didn't enable the IOMMU so lots of OEMs had bogus
>> IOMMU ACPI tables which didn't cause problems when 1:1 mode was used.
>>
>> This patchset is not making functional change to default domain (it still puts
>> PASID capable devices in passthrough mode. 1 x 1 mapping). But I do plan to
>> make changes after SVA and invalidation improvement series gets merged.
>>
>> Couple of things :
>>   - If device supports only ATS (no PASID, PRI), then we don't force 1 x 1
>> mapping.
>>
>>   - If system is booted with SME (mem_encrypt=on), we force all devices to use
>> DMA translation mode and iommu_v2 module is not supported (no PASID
>> support).
> 
> We already have some quirks for some APUs where you have to pick between SME and display because the extra IOMMU latency causes problems with high res modes (even in 1:1 mode).

Thanks for clarifying.

> 
>>
>>   - If device is capable of PASID, then we force 1 x 1 mapping. My
>> understanding is device wanted to use iommu_v2 module (enable PASID/PRI).
>> There is no easy way to switch from IOMMU DMA translation mode (V1 page
>> table mode) to PASID support mode (V2 page table). Hence 1 x 1 mapping was
>> enforced.
>>
>> Do you see any issue if we boot these devices with V2 page table mode (it will
>> go through IOMMU DMA translation mode) and don't switch page table
>> mode during runtime? -OR- older GPU's always expects 1 x 1 mapping?
>>
> 
> All of the integrated devices I'm concerned about support ATS/PRI/PASID.  The issue is the display hardware on some of them requires 1x1 mode.  I'm not opposed to a 1:1 quirk list if that is the way we want to go.

Got it. Yeah. We will add some quirks before making changes to default domain.

-Vasant
