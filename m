Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8C547A7D
	for <iommu@lists.linux.dev>; Wed, 10 Jan 2024 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w7P8q3Ck"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJfcmvvh1dsnrQmCH1X0uH7tt5tzRZo3nGY3OZTVNHvcbZjg5dmnC8JbrGMfXaChn1S+4EStFbUPPevzcPv5QftxMW8EOkd3o8FIKpllNt7IRu8xN6XgOn53caFKRdgTQJjgzZ6Pf6qLlhd3Cdg10xqNw203vE6GLYEEADChhF22a0jOykK4HezMllaYee467ZjmkQoaacFF+cETGjOnu9Lc4gcoBYnjgEesWlsJm0nSVUpORAtqmhTTTnNydqes9Y1uapW15dGU2y+Qn/GHEMTzf4BC5XtIxotN1CUU0ATGjkqceWU4yKVyX4WOqVHSVo8GVXAwM1piJ8SH8xlTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YzqgF+l9v1gW18jOZng1RqYRoUkXFIYEJaztiH7YtYU=;
 b=et31n0kEe+kv+5EGy3hXYf/Vi85Cu2lkCrFYrWUCM6UXBfd3zHAN7k81YjKc+nuRosK2yFzecAN5NnxBndhGjzD/01PfmBUfZxtwsSbqY2zgrE8/fdSBjlyvwm7LhcBKSPbScLSdjzKM3XmMlP2gEy1xYyI9g8QtX2/mw0OB6LTf79NIB5lFKRN8GM4GqlJ0JstbdchEoxFRSzHT4rhSFNlnHd2HYW3hfnx7wit77u4QYDFNfOG7hFAc/RW/h+w4UEYcDHarKTrXltaSK3PQezHLWuWCXg/08ktOHpPXCleYk3sQNXjUqF7obirOEa76c4VBBX41l2qQt9xKFf3V5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YzqgF+l9v1gW18jOZng1RqYRoUkXFIYEJaztiH7YtYU=;
 b=w7P8q3Ck3luvYZzTeAtYWeySkySxaJmTeNr5hUJlZx+BuZj6fPClE1+Q3X/DkAcqayARRswQunWhJfroRuSkqk+7db9EdEx6pdwuNlgdQGhp6ixIi3W/8c2MH8vZ7vWhC8/KRRcwt0OGeu0hAnXu2Ma2GSdRpscGtxR59VixNaw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.25; Wed, 10 Jan 2024 12:07:11 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 12:07:11 +0000
Message-ID: <6149a8a1-411a-71f1-395c-372f359a8dd0@amd.com>
Date: Wed, 10 Jan 2024 17:37:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 03/16] iommu/amd: Introduce get_amd_iommu_from_dev()
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-4-vasant.hegde@amd.com>
 <20240105182726.GK50608@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240105182726.GK50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::10) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: 92577b9f-c955-4ff2-1043-08dc11d4acd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ou2+bLdXUDDaNSNYkxPLQZlrd56Lfpn1OVTecdjmOwh04Xvr9grMpHpXeSGP/aTd0lqJdtNHaYMbDq7eZNwIOsr91S0aWIZ0yCBbCo4Yi4vZY1R5zSrVEjdOlvQLsVJCVDBSKJeBvv1i5U4bXK7/V72xkHjfBuNk/vNVEfQf8U3B7s727gMt50o+tKDfSIm5z5HOUGAC83rdYT37MS/nqrneg3FHvE017+bDzCp9BOFRmvQCH7Rp+5T2oHUFUJed8JmfxdFRt4wECD0H+CVplZ0XDcJfAQYmNpf80M5m4Ny1lHTKp4aPMyP7HS8t1+HIxcCbQWEDM17Vax1Q9w117skQR/6tR8Z4n5kq0UEQhCiLLBSAoY13D94lhQ1zSgFK6OkSlhZ8ChLlGHhLkP19iTk0wcZ1PkKDKXqK7+yEGIsqPmVyDjbvXO9C1bMMBSNP3U7nrleubbw93ydUB6Ws/p6gSQ7txqGP8ypsaMvcRvdARaxeP+w9K+q+fZOE/UN+eqJ6NVgxa1tbcHhuUJzdbVTJeb1bnDX6EUGY4r9QkE1hPnFBXvnk3+smZW8Iz+tKpc3Xs1qWWUlmA/7OK0LXUoPooeVSF/bDBmLpWT+8h6Q00SSFv3BWlvgK7waelyi4rzS5aDs/h55tFq5dLSKJnw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(31686004)(36756003)(6486002)(53546011)(6506007)(6512007)(66556008)(66946007)(86362001)(31696002)(478600001)(66476007)(38100700002)(8936002)(83380400001)(26005)(2616005)(2906002)(5660300002)(316002)(4326008)(6666004)(44832011)(6916009)(41300700001)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czRmdmx4VkQwTGllaC9vQkJSenRkNklUdzVxSmd1dUZuU1F3Q2c0YXRHTnZR?=
 =?utf-8?B?T2VqaDN3L0w5eHlnRkhjWE5WSjFDNUs4TGRvUTJzdDhJZU5tTDZLQXhVSWNS?=
 =?utf-8?B?TGMva01Ob3I5dXJ4K0hVOURHM2JiNkhjK21UY1ZsVlhFcGdsRzZXNXBqaDdT?=
 =?utf-8?B?REpLcks4R2xlWlc4d1BYRzgvc3JwYnNWekFUcDVLY1o3LzB2MlMxMGJ0bEY4?=
 =?utf-8?B?am5UZ2E1SDZpVXBORHczUkpVa20zTHFDZjdLckl1Tk43NHhpTUltSTVqcDd1?=
 =?utf-8?B?cXBabDE3dTNHRzYvak5OdlFHbnJzWnJiMG4rV3FUL0VpU0VzOEZFaFdIYWZq?=
 =?utf-8?B?VGs5TlBXTWZIQkVCRTlzQ093c2lYZHFGQVIva0wyUmRieThqRzZSKzBhVUFT?=
 =?utf-8?B?ajVIUVNsYjRnNWt2SzlJOStob3p1dXRSWXEvSUtycVNhamFRZVZIRWJuUGhk?=
 =?utf-8?B?SEJtdjVQOWJka2RHTmtUT2JZdkp4dWcxN0pMUkg2N3ZxdDBDanlHakFsRlJJ?=
 =?utf-8?B?aG51WFEvdEJibkxHdi83dExnQlZkNzFwNzFOeVc5RTZRVzYrclZrUkpIZ2N3?=
 =?utf-8?B?and1UktFWTJ4dVdCS2V0aFgwSCtTay9xVUhpOTRycW82cmdBR3JOZ1hNZ1Qr?=
 =?utf-8?B?ZFBzaXNOdVZFNVI2WEtMOTlFcUpZZXpLd21GL2VJRDFtUW8va3pOR0h2N3lj?=
 =?utf-8?B?eUk0NXN0TGxJdlo1RDRZUjV4cGNrUXdUWUlmM2tUYzM3eEp3aWI5b2hxRnEx?=
 =?utf-8?B?ZkhxMS9hQXBvRjhLTUFHdFZLV0UyMVZWTUpnQ1QrWmlnM1ZmTzltTklXVGg5?=
 =?utf-8?B?STZ6aVBibHY5ZGdtd1VyVXRWN1prc09Ra1VUUkowOGlFemxTQWF0MGV4ZFdU?=
 =?utf-8?B?NitBTXZ5eGhldjBKQUhsdC9vTS9MQmYxQTZ4ZE1ySnpsQ2ptTUZ4ays5TmdZ?=
 =?utf-8?B?WktUVkhhR2tLUDYzUWI0cGJKUUdwWmZtampiN2xTZUxEZythTTQ1NWJUSWph?=
 =?utf-8?B?WmN5VEZ2SEw4eWFsdzlITENRWjlXQ1p5OVFwK1VnT1BuVzZLd2RsUjBGR2tU?=
 =?utf-8?B?dmladUFtQmQ0dWFpYVAyaXZTV1hXUy9rUEJveWZxeDhpYlM0WGpVNVhvcEZw?=
 =?utf-8?B?Y0pGUlJSUUxpcGNzU2NFUzR1YWZwdlBWK3JnckZGc3ZMczBJSUl6ZUt1M3pV?=
 =?utf-8?B?OWRGQmVFNWFldDc1a2hTemlrZm9sZ2RkbzV4VmdlK29MWGptRGVLTHJLaitV?=
 =?utf-8?B?LzlhZ3BoZ2h2WHZva2ZJUDdtWlJtYjh1ZUN3T3B5eFBCREpBWkZ6dVMxNG5a?=
 =?utf-8?B?YUdaeWJWdEJFelYzNDladzkrQ0V6eGwzeWxPTGM3bURWYWcvN2kzVndnOXcz?=
 =?utf-8?B?Q2JXNG10ZFdqN0t4RDJSbit1SUlaRi96eEVva2JXODkyQkRuRzFLNlAwOStT?=
 =?utf-8?B?bWIyeDNNNUxGdHhWcytaQjFZYkQrSEY2VDZqams3cXQ3UTNXYXpXQUgzN3VR?=
 =?utf-8?B?OG85RmhyNEt4b3BmM04wa2dldncvWURNU0VxTWdHazRWcDMvcGNoQnNvYURo?=
 =?utf-8?B?THpoQUx2YnFySGoyZXNMU1cwbzlpbFd2TksyazQra1BUejl5VkxJNGI1dTRL?=
 =?utf-8?B?YlZHanZNR2lJWFcvZzhKRmpwZVkxMWdCdkczeUxzZDdib25LNFBXL2tJZWlk?=
 =?utf-8?B?dEI5TFZ6WTFhZS9OMWhBWGJCRWVOZlNhQ0ZhM3ZOeUQwMk1MNGxDWEllZ0xv?=
 =?utf-8?B?bGI0czg2VXJIS3FRa24zQkJzc3VVdjB6bk53cFZrUjRqTXJ1RkN4TktKN0tC?=
 =?utf-8?B?V3p1L1B2RkNMRGl3a0VxSTRvRkVaZU1CL0U4U1UxWTM1dm9QMHNFVmNUcFpW?=
 =?utf-8?B?bFB2TStIWUxybmhUbTVJQzdLSTlyMWpyWGhibGJ3VG55S1QzZVAzNnlGL0FM?=
 =?utf-8?B?OFprSVl6U2JRNkpaaWphdjMxVG0xRWhuNFhucUsrTVd2UlcvQ3I3eitWZ09G?=
 =?utf-8?B?cGZPcmlEcmNyRmp0aDBQUFhZTkJEay9LVm1zNUNJaXVCRkMxOEVWaWR4aFF4?=
 =?utf-8?B?QU9NOXhqbGl3azQrakZ6YVR0bnYyR2JGbjgzZjZkR0tueVBUaWNhaDFHL2tX?=
 =?utf-8?Q?KOVNpvp4maEx1pH1gcHWpPAEQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92577b9f-c955-4ff2-1043-08dc11d4acd6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 12:07:11.4265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JK6kvhsutgAaL63UJRkMQ35F8sgPDBQJ0jhSZtJtRjqrX7l2AOcoCIe6/0ToyvfzS+qpfIRO2OfSXNhgKusxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040

Jason,

On 1/5/2024 11:57 PM, Jason Gunthorpe wrote:
> On Tue, Dec 12, 2023 at 08:52:11AM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> And replace rlookup_amd_iommu() with the new helper function where
>> applicable to avoid unnecessary loop to look up struct amd_iommu from
>> struct device.
>>
>> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu.h | 11 +++++++++
>>  drivers/iommu/amd/iommu.c     | 43 ++++++++++-------------------------
>>  include/linux/iommu.h         | 13 +++++++++++
>>  3 files changed, 36 insertions(+), 31 deletions(-)
> 
> This is basically fine
> 
> But can you improve the core helper a bit so everyone else can easially use it too:>
> static inline struct iommu_device *__iommu_get_iommu_dev(struct device *dev)
> {
> 	return dev->iommu->iommu_dev;
> }
> 
> #define iommu_get_iommu_dev(dev, type, member) \
> 	container_of(__iommu_get_iommu_dev(dev), type, member)
> 
> static inline struct amd_iommu *get_amd_iommu_from_dev(struct device *dev)
> {
> 	return iommu_get_iommu_dev(dev, struct amd_iommu, iommu);
> }
> 
> static inline struct amd_iommu *get_amd_iommu_from_dev_data(struct iommu_dev_data *dev_data)
> {
> 	return iommu_get_iommu_dev(dev_data->dev, struct amd_iommu, iommu);
> }

Makes sense. Fixed in v5.

-Vasant
