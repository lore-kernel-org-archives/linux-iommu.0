Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2067.outbound.protection.outlook.com [40.107.212.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E766A34
	for <iommu@lists.linux.dev>; Tue, 10 Oct 2023 06:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2kektjQ6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxh9hqCZ1Ws/bzBr3GXQfnzZ8hK2b85XqHuJPWJCUYw5dxAQrdyIgmGN+CMJ2rqOZs1iYrKaP93twzOl6FnmVUXjONtE5ZOocrh6qrCsnXw1DpNqkKKind/6IDNiNMSEFkBIL+9EaBsY3PKGRZXmzX2C97qHA4qfLG8JAfTbIR8QfJft24+Bsjsh9z5L9kCxSsUPh9uLjWpumAUs3beLyihSJnao+iruhOW6X/kSHq1UL6Us9PVzxCYh8OHsXblSvuH0mZulj9Hny5vYhXmfc6q09koAXsV1dbfZvc2qIGcLXhBcpyob8+dQoAL3lnQDHaOvmdVMmoJj884ZczYwtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4dcri14Ur5fVGkRjmKH9G81tt2sa1Fkwo6n0/p39eY=;
 b=G3odK4m11QvU2uRBnKmd3I4BYcBvcUnYH6YqZNwJjXOVKDWE6KGjZA7lVv0hPYc1awLbIBGzTUov1uD31WkZgClpe6xLovaYONldrRfVPKwv937WXhKaL0K9A8/3C1CboAw6k6+mIpIs3RP2pbWWpIKDlQQcSRfCpdrfu827qkjXlFDhmzGBofQAgypF0E54SBciA6QyN0XuLCWXXdwK0qypvxpErCEk+g/6ZiWW3Y+MDvipItbj8+DBOsFUSP3G0qVAQ+AgLCytaq5GXN7Zku0PdasiomM2m16EaLM4274v8ZgM+lRKBfdBsC/m/LLvQ3YdbkmvTueS7gK1iI9rjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4dcri14Ur5fVGkRjmKH9G81tt2sa1Fkwo6n0/p39eY=;
 b=2kektjQ6oqvrRteyzpJhX9P5LDvVPcV414hFuXSxAFRJWbTOHiNCxPIAsKL3pdrB9ZikvxBEOq3OKWUL6SOtIxp3z7QqAx79Mq+zC5xF6DR8RqtH+g2qd/aGH06KBlcvxDQZXAestKjpzICKX1HpD86jnyCxaoRubnCxO1kwDQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.38; Tue, 10 Oct 2023 06:03:04 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::726d:296a:5a0b:1e98]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::726d:296a:5a0b:1e98%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 06:03:04 +0000
Message-ID: <497df4d9-2203-ad36-a5d1-97570b327a49@amd.com>
Date: Tue, 10 Oct 2023 11:32:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 06/10] iommu/amd: Refactor helper function for setting
 / clearing GCR3
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230816174031.634453-1-vasant.hegde@amd.com>
 <20230816174031.634453-7-vasant.hegde@amd.com> <ZQHRTwYN4doUte5E@ziepe.ca>
 <0d47919e-cc2c-d151-f020-e2090fd1c287@amd.com>
 <20230927164523.GO13795@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230927164523.GO13795@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0138.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::23) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ed96b92-7abf-42f8-6914-08dbc95690d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tGs8FzX5oDlZPzbgI+8wIgBtYFFJo5yNrzPkAn7JsYk2NTxu9A22kdDESqAeXpOAq2mUeSkLZ072T1yRL+4ooMBNnPc2OTjtG6wHPFpbAj+SFi9fEkurxGsFzbuaZLBiMY0dp78LVIi17XtwgjsQS7cX14AXCwnyIRN+gwzz8RN1DEjSL/m8DKmEX1nLT6kyK2ia38oIWKIP4mcoyQgtWFZWTwad6KLZON7a5pR885yWX9uuUv51x+PjjYYGtNBQylJyLYhuUg6n0rm2X0AG/kfa0aatHNPoVPb6i9cJyCL3ToqMebLouysgqckDlZTA3qbDJ8xaUoABpd3ukTNzTI9tQ48XRJTThcMxGblfkFt9+a24r14S3MDhF0bYesa3RVMa3p4opfuX/Ja0bYT8lprqRgH/lWUN75xaFJVpxEWrOcNDB1g6VC/uzuUw3QvV1rLJz7JSMFt4S0cyrCd9QnbIOyrpdI2indQZaWVnaQu8JlbxNPfxjcWH2bBOrF3ch0qkiYSyvTmxZ8bHU9URq0t3jm/P+WvzUHWQ06Apm5B520NYiy8F8Fm0wyZNwbU4oMWGeBrgZfQb+EzHnw95EBj/33m7oOhh3gXfvq91L9/JAOnNF8GAvDJihuOJCnwvP1mMa4P07qBceQ5hf0EEuw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6512007)(31696002)(2616005)(83380400001)(6486002)(478600001)(2906002)(41300700001)(31686004)(6916009)(66476007)(86362001)(316002)(66556008)(66946007)(8936002)(8676002)(4326008)(44832011)(36756003)(26005)(6506007)(38100700002)(6666004)(53546011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?elRXdHhUeDN0Mk1KOURhRGlGcTAxd1hYQ2J1RHEwMXJpS0k0WmYzYWtPdHRv?=
 =?utf-8?B?LysxM0R6VG1sYyt0N0RtT3RnY1phZWdCMUNGaVl6TWpiWUdSWGFzVVFVaUNO?=
 =?utf-8?B?TTB5ZGFxNi84NmNiVmc5Tjh3K1E4dGJxY1l6ZGFSTGw4SFBrTGsrWE1IampJ?=
 =?utf-8?B?ZUN5bDE2c09sMi9YK2ZFME9va3N1aGpPRW5uTUltZjgrcFU2MW5NQlp1NjVW?=
 =?utf-8?B?cTZuaXNWaGlZcDZ1eGZZSGE4OTlFdnV2TmpvK0I5cVVvb3dtK2tHblJMYzJn?=
 =?utf-8?B?Qmg0QnhVbDFsVE1lKzk3eUhDZnVMaDI5YllQRU5WOVB6bnEzVzJWcittUXhl?=
 =?utf-8?B?SUF4MXd5dkRzcXhLUDJEZnNuL1p3d09ianFOUjRldFp0R3l5Mml0MHNYRWZ5?=
 =?utf-8?B?L01ORzZmbTVzVGhTd2tRRzlud21aVlIxRXh3dWlsVE95YU1UOEhUNTVvb0VI?=
 =?utf-8?B?VDFVLzVUdmlYQ3FxeTJYRU1mTTI3SGtmYXFiVkVYeStwY2trZ1VwOVY2cGo0?=
 =?utf-8?B?VTRGNTU3UzF6RzNCNjJUR2drVzJXamJWOVdRYW1TbE10VS9mK0cwWWUrczFC?=
 =?utf-8?B?V01odXFpV3N4bVJOVWtQYU1Ua08zQUJrai9wd1BobmNXWGFva0xmQXVDWGVX?=
 =?utf-8?B?b21LQ09NWDRUQmxPNXVKazhPd3Y1UVVyY0pUczNQTE8zT1M1OHkraEQ1WDhZ?=
 =?utf-8?B?N2JZYTlYdnJ3YXZxRWpzbWYvVlZNb0ppbGlqc1hLUmYrcmY1UDhJUSs3b2Y4?=
 =?utf-8?B?a05kakZPeDRjNzZ3MXFMOGp4MjNUcStBeWRCWkZlUFIyWS9jYUpLK3ZUd1FS?=
 =?utf-8?B?OTlacDNmWWYvL0kvQkF2UWdYK1Y0b0M2aWJOcHpaQld3Ym1tNkZEdnJ6VzVj?=
 =?utf-8?B?SU1QV1dVWGU2V3JkTUlQcGtYRXVkL1V6MWE4VW1qK3lMOEgyMVZsUnFyQlAw?=
 =?utf-8?B?Y3RQZ2Y4R0l5QnFxd1hoVHM4YncrYVhQNnBBVFY4emtIWEdCbXRjVkwxcFZj?=
 =?utf-8?B?NVdnV25wNTBjQnRibFBZNGFMa1RUbnBNeFNKK1E5djllZnFicmxkVkhxRGFB?=
 =?utf-8?B?RHpFU1Q3M3N2QytFQlRpSjRIWUw5RVJzNUROOG5vUUl3SFJWUEtYblptOUJt?=
 =?utf-8?B?VFNhYmpDcUdzZFlGNmJUZkczTTdDZ05BUG5vMU4vQmhQRldHaHFvaG02VEkr?=
 =?utf-8?B?QnlVZVZ6L2hhc1FrZ2N1SG9ZNWgvZlNOYUY3QmMvOTdSUjVIWnQ3RTg2MlBU?=
 =?utf-8?B?d3k2UzhXK3hJWENZbmpOaWlQLy9XWUVvdjcxNVYrSkdrMlppR2djNFBXSE9h?=
 =?utf-8?B?ZnU1ZWtOTngwZEF5b0VLV09HenlqVGVRRllWMnpWRUwxbU1Ja1E5WEc2SHli?=
 =?utf-8?B?Uy9mNGZVcURiWExkMEw1YUNPQmN5Qk5aR3FUYjBkSHFZb2FiZ2hEYWVZR0xj?=
 =?utf-8?B?YlhHeW1xdVZKcjh2NDkyeHFha0JqYWhQNVphN1RKQ2x4V29wUkhHTlRmbllo?=
 =?utf-8?B?YVVYZkxhOWJkdHk2SkNkUW14NEVhMEdPMldoYkxzaGJaV2xESDQ0MFBKWmlq?=
 =?utf-8?B?TTJUQnByVGJKVnNtb1RuZXh1SDdseVFsWXFmM2x2RnVXaVFjNVhUVDU2K0l2?=
 =?utf-8?B?Z0lrZ3o3ZVduUHB3NzkxckJlOWNwVjFaaUVRWTNMQXJBTDRJRUVoZHo5SHhK?=
 =?utf-8?B?Q1Baa3JyWFgwSWRVUjdXUnpZMi9xTFVhSzZ5eklwaW9pQWdKQ3FTYVYrRUhV?=
 =?utf-8?B?M2lIZ2VEUDRDb0t1UU4vMDdmWFI4cUZoSVhzbERNUHpVVEZYYkFQbDN6aG1i?=
 =?utf-8?B?a1RudEpnZFFQQTk2aDRVTE5tL0tzWXY2ZEhFUi9TMUdoMXhWeFhkSmJiSURY?=
 =?utf-8?B?dzBXKzFmOXNRTVBpa1RDSC9kSzhJL01PcGF6b05CYWZLemtrUWxSVmJEQlho?=
 =?utf-8?B?NTFQcmgvdTZhdDNJTTI2YXdPaWZkM1JEY1J5T2pWd2ltMEYrbm1sUTRQQ210?=
 =?utf-8?B?VUszL1lXc09CdDRGRG96WGlKRmlrQS92UWVrdXBsd2FOcDY1amxKd2FzTVF3?=
 =?utf-8?B?SlpvY3NxTVRaeXl1UnhQRWlCSHFQQjdQVE9xcURLRi9kRjBWNk9yV0JSWVpM?=
 =?utf-8?Q?8tQZtPy1Ii1mBGwK9UMJn6tkt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ed96b92-7abf-42f8-6914-08dbc95690d2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 06:03:04.0761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YcfFW66DLLfe6uvVyFQYqOi59jNI3QuTDN0mNTCfQtawiS2C+Q7Z5eGP0jiUqwZ9j6e+XSZrR78mnFRmPBNdZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165



On 9/27/2023 10:15 PM, Jason Gunthorpe wrote:
> On Wed, Sep 27, 2023 at 11:51:20AM +0530, Vasant Hegde wrote:
>>>>  	if (pte == NULL)
>>>>  		return -ENOMEM;
>>>>  
>>>> -	*pte = (cr3 & PAGE_MASK) | GCR3_VALID;
>>>> +	*pte = (gcr3 & PAGE_MASK) | GCR3_VALID;
>>>> +	__amd_iommu_flush_tlb(dev_data->domain, pasid);
>>>
>>> This flushing doesn't seem to make sense to me, it shouldn't take in a
>>> domain parameter.
>>>
>>> I'm reading the spec here so I may get this wrong but.. It looks like
>>> the IOTLB cache is tagged by (DTE.domain_id, PASID)?
>>>
>>
>> Yeah. It works, but name is confusing.
> 
> How does it work? You haven't explained anything about why does it
> work.

__amd_iommu_flush_tlb() flushes both domain ID and all devices within the domain
for the given PASID. So it works fine. All these functions are reworked as part
of invalidation series. Hence this function is not relevant anymore.


> 
> Nothing guarantees that domain->id is per-device. It is emphatically
> not, it is per-domain. It happens to act like it is per-device when
> using the DMA API, as DMA API does not share domains across
> groups. However iommufd does share domains and so this is not a
> correct assumption.

That's exactly why I have been saying for SVA I don't need per-device-domain ID.
Current code works fine. Anyway, I will add this support in v3.


-Vasant
