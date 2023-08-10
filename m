Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F971877
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 23:06:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOeRT19GTmYJLZd2UXiEqBqQIvJvwst0oLRo6H4VW4bK/myVeZcvIO+vjHgiGwv0RGcvY/oyoyC1Q4FcCFnCIw3b91235TKOgXnlubZWoxpJLFhxs4OozchAISDBn0ZPBLI9jfQGeEYxyjD7V7tOx8X+1lXrz2rZLpYDFMyGb1vLK+Qo2gYc8xcamqtTXOdfWG7+ZBqKP4W5opNjCSLE4cPJGl6jyhQw2ifs21KD0LHnUSVsN+SSxFwq5qwvXx3Ul8vQd8HryX+m+KmJWfKIPCRA86Ub5rTIbxdZUr0RpROpqJvsDqWNZEFx3kUbuDYk0zcTPTMIXrJn6QX0Ac1rIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36unRIACdKRMheOPqN7RHP4zlJQQAPQLqYFPySj0yXU=;
 b=WHghLfTehvag1+g1CgkWy33ypJPG588I/SakS1a6u6cOGrgs01MLZhT0eSz/zLkynMhBSlS/8sHe4HlwMZTlIiXNNKRZ4JvuT9yIYSh0xG+SufKwVDqc6nFO7gHJH7pogL5AljsL4kzF2jv3LJW8XNQtMHEQmGU1S7FjZSYHQ0MJn7DS6XumblK4WqbU/nhh4j8uwPdHrYl1ttRecTA38XHJkQz6gdSuAsuqsFSJT+Q9I7YX10ojhukWVlFS7v+4J43SHLszKpXxpxDu6E+B0o16IphNzzg7v4AXROlB9L6+t7Mx+HWZZ7GyAVbEXSNVebquoujFxRvpsQGz/X6snA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36unRIACdKRMheOPqN7RHP4zlJQQAPQLqYFPySj0yXU=;
 b=2dNe8JJyyj4TpU4kLVS8JmzqBRIL8fcZ8mZD0DxVgM1T2n+b9N/jDcxkNsjcbnw4uACcuoqgFQaWN18bG6X1Y8kooCpSXWQp/afnSkmTQHpaTBQnC849FxucgOex/8cPpqXxZDVVjNQuicoY327eZzkCKXlfPvCTYDYy15JzlVw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 SN7PR12MB8818.namprd12.prod.outlook.com (2603:10b6:806:34b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 23:06:55 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::12ec:a62b:b286:d309]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::12ec:a62b:b286:d309%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 23:06:55 +0000
Message-ID: <bcd2749c-d4de-fa8c-c865-ac9ed184ea17@amd.com>
Date: Thu, 10 Aug 2023 16:06:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 01/11] iommu/amd: Rename helper function
 rlookup_amd_iommu()
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, wei.huang2@amd.com,
 jsnitsel@redhat.com
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-2-vasant.hegde@amd.com> <ZNJfLQTJhOgorIHB@ziepe.ca>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <ZNJfLQTJhOgorIHB@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0009.namprd17.prod.outlook.com
 (2603:10b6:510:324::17) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|SN7PR12MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb599ea-0571-4c26-7506-08db99f67d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cVKMuTtrDp7x0lVtFPJoZ7apd1YtMINk3xsEmj1nr4wSRrVTwjEeJxNN+7DRCBjjkk3I35+ryiQHzOYf8Qu0JAnhaqwZNdvvclFZA5io0CewPc9Sdfdbo3OkBIGHajADARhNKklE+sIqg+pzwTTmcE5IAp0BecuBjJKRbihOi3slIAIcqbAT0Qy6p6xy8VUsmAM4GELLx0bCJhQSx29bTbRJxivF9MoIxI2bsCVTT7Y2qb/NzKHbzoKyirL90ZhLDUUl7iE/6EO9dnAprgQzbPp2gar5XtOGOPjSv6/D5NU0Sb9GSVfn9ms7Ob6kYPKrk1QiraAWFKc3pnAKTSzM7gHUVU3Z6qzbOUDcfPHOMPrOdNjMXqiknO2o0JIO2mTho1Tlgltb3StBWHyA0VVAXwweOHx1tgYe5nkPVyQg8O/qpfL+QGak8xsfnMiscSILg42IgrExXVHpi7z1RssjJWJ0vn6hDwIAR1e6BMdwRM04KYRou0WohMgeF/9gGrF7A/EZMEryfj2OMd1x7Cm67nL9dzkQjg9oXHglwKAwtCscaVO/7garEI5MbtHy8qg1lJuOQVSDeogFi0KPjTBgxWFK+iKBBFqrVVtMXttP/FqwQwO7fd8aYobLNW3TiU/WjubP7fC7jF1NIMD0xo/bXA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(186006)(451199021)(1800799006)(36756003)(66556008)(53546011)(478600001)(6666004)(110136005)(66946007)(26005)(66476007)(6636002)(6506007)(6512007)(6486002)(4326008)(2906002)(41300700001)(316002)(8936002)(38100700002)(5660300002)(8676002)(31696002)(86362001)(83380400001)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2J0Y0dNSEtsTjRVL0xoSmN3dm9SM284dHdKVkxKcDJXRUVIYTAvbElDVm5y?=
 =?utf-8?B?ekNyN1NvQXRycE5ScnBVTzRtbENYN1luNGRhOXF6Rk1sdXdSUXJ2dkJzMy9P?=
 =?utf-8?B?S1Z6VXNFUDk2REtrOURGUWh2ZGtOR1ViYnVzWm9hdEhEQVhQdm5ya2N1NVlu?=
 =?utf-8?B?d3ZQN1A2MS84cSs3bTdzVGRGMlhqeGVKQ29UZFZDUC9uNkRMUUpnVC95OTBZ?=
 =?utf-8?B?TnVvcko0Nk0xRHRzbysvamRSTlBxU202dzZacW54czJ1cDU5NjBpN0dWa2ZS?=
 =?utf-8?B?QVlhQmxMTGZqMjNzMUJvZG9iZ0VDeGFDV0VDUldPSXRraE45NDZHUUlUWkRh?=
 =?utf-8?B?YWN0U3NpNzVWNzlQYUtyVElWZG53Tm9pRXltQWEveXJBU3FWTnptVUxvS2lp?=
 =?utf-8?B?RGh4MlRsSElnNTdvazVkU2tINjRtd2k5cXVZaEhOSEhTbVE4amtMWUVWUThP?=
 =?utf-8?B?c1lyenhnV25PNFBHQTNqSUxUSDFoTG9rU0JIK2RVaENjWDhVVkhhNVdlRmFy?=
 =?utf-8?B?aWZJUS9seUNyTGtjMFV0Vkh6Z05sR0JFd0RTblJWTUxqU0dBb1ZxQlVLeThG?=
 =?utf-8?B?YjRhdFZQRldyZC8zN0hEOU9KMHZ0cCtDVGNaOE9NR21ac1Z4RmFIa2N2TzFw?=
 =?utf-8?B?dmZSUC9RM1V2NXQ5d1ByUzhhTWVNUVEzeGd3Wld4TGcvYWhhTThtVWo3OFJB?=
 =?utf-8?B?VERweTk4MHlPZDlBYzFBRVVvYS91VlFkWldEMW5DUmhaUFd4MXMrTDNIZU54?=
 =?utf-8?B?Sm9rdW1NRlNBcUIxZGNzMDlWc2tlYVZsWEZzQUFaK3dRNDVSZnlvM3ZDcmg3?=
 =?utf-8?B?QjdmdFNrRHVCemN2RjJ1a2MweFZaSm9nUm9yaTJ1TGVxVTBONnZCZVAvZWlF?=
 =?utf-8?B?ZDUvOHljeXdCQktmdVcvaXRwaWlTc2xvWVBrOHBxcmloenVRNHFvdENwdUhO?=
 =?utf-8?B?dWpKZDlnaDBuYldxdHliYWpSd2t4VkpYMTFrT0QyQU9IbDBacUMzQm5iNUxP?=
 =?utf-8?B?MDd3dmc5bGxGVkJBZHMwUGwzU09UVHN6WUtCN0hLN29tMURDY01Pb2dHdkMr?=
 =?utf-8?B?T2RSMW14MGJlTUQrTUZaU3BZbmY0TTR2RFZKdEI3Z1BMV1hsVU1IUVFPL0xJ?=
 =?utf-8?B?aCtJODZkKy9DNzJuU056YmpUSkpyVnNjLzdMTTdscVFtM3JnNDB4ZXd2YXVy?=
 =?utf-8?B?blRiamI1UXh2dXgxT3BSUG5zL2NOVzMxNE56Vit6clZGOTkzM0lTMkpicVNy?=
 =?utf-8?B?d1FiR094WWp0enBKdmlDbmJNREVETHFJWHVqUVlJTG94UXRYSEtLUHBtWkFH?=
 =?utf-8?B?ZE1JdE5ISjVDSUx3VVJDa211dDkvekpOMmNSM1E1YmhsNUhOcDdwelhKRXc2?=
 =?utf-8?B?WjN6OE8vMGJ1VWpWL2lZSnAraTVRQXBhSEJTNFhFOXhnRWRXSC8vWHdQTENC?=
 =?utf-8?B?dnRQUkhVMlNiWXBGRzU2QW1PQkY3SDY4cjRraVo5OXFMSU00Q2JwNHZLa3JD?=
 =?utf-8?B?NTArbEM5c2FQT1hoR0hKQ0xzYkh3TElldDBQVWJMWVdheTdYeE1wT04wTk9H?=
 =?utf-8?B?MGUyT0JmZ1pIQ3lMeGdQelFONGEvWjNGT0JTVlk1bTBLUGNpWFpmdW9kL3JS?=
 =?utf-8?B?ZnNFZ0t4ZmtRcDN1b0VoOXM3RTB0dHVHNjBDdDNvZDZ3L1VWVHp2Q1huK01P?=
 =?utf-8?B?Ymx2VXYvQ2E5UzM4ZngzSUJhNll6MHNBb1BXU0EySy94dExBT1o4T05HVkNr?=
 =?utf-8?B?RFlGZFRmMzNjaG8rTUNaOGZoSk1Ndkx3ZGNjRklLQXJSYWZQV3pIRG8zRHpy?=
 =?utf-8?B?VzQ0MnhLcE1Jd1Y3bkxRVWRaMFhEekI2Wkdwck9yOXd5bm1ZZFJBRDNMZDlQ?=
 =?utf-8?B?VHExTC8wdWRJWGlHVmZsTk9mSVFFdEZaS2JaTCs0bWtWYXU0MnpTdFBLTkRV?=
 =?utf-8?B?Vm4xT05xYXhMRE00YVVpSjZCbHAwRkFaOGdCNmhaQlpYMFNucFBCNFNDU2Nz?=
 =?utf-8?B?R0JYN2dua0pMclllbjVWOXJBWi9xVmlJUFRRNm9ac1g5ZTI3anpENUtoaVhL?=
 =?utf-8?B?cGhWYS9mRldOQURlSHJvMHF4YmZzNnB5eEo2REY2Umk5RG1FR1UwMWpYRDNu?=
 =?utf-8?Q?YTHECrn6BHomonysX3wUEjRd/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb599ea-0571-4c26-7506-08db99f67d75
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 23:06:55.1015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UR8erQwA1HMYe+qhhTENJB5kB1kiCraM4mV4ob9hZtkG9mtYGYU0IMDcfLjWxsTKt2qsEq0CJsKnZI1U5OgVvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8818



On 8/8/2023 8:28 AM, Jason Gunthorpe wrote:
> On Tue, Aug 08, 2023 at 10:02:22AM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> Rename and make it available to other code.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>   drivers/iommu/amd/amd_iommu.h |  1 +
>>   drivers/iommu/amd/iommu.c     | 30 +++++++++++++++---------------
>>   2 files changed, 16 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
>> index 56996dc2868d..1471ab2dddd1 100644
>> --- a/drivers/iommu/amd/amd_iommu.h
>> +++ b/drivers/iommu/amd/amd_iommu.h
>> @@ -24,6 +24,7 @@ int amd_iommu_init_devices(void);
>>   void amd_iommu_uninit_devices(void);
>>   void amd_iommu_init_notifier(void);
>>   void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
>> +struct amd_iommu *amd_iommu_rlookup_iommu(struct device *dev);
>>   
>>   #ifdef CONFIG_AMD_IOMMU_DEBUGFS
>>   void amd_iommu_debugfs_setup(struct amd_iommu *iommu);
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 26e509ffe77a..77b913211c35 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -164,7 +164,7 @@ static struct amd_iommu *__rlookup_amd_iommu(u16 seg, u16 devid)
>>   	return NULL;
>>   }
>>   
>> -static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
>> +struct amd_iommu *amd_iommu_rlookup_iommu(struct device *dev)
>>   {
> 
> Er, wah? This is a really confused function. It should just be:
> 
> static inline struct amd_iommu *amd_device_to_iommu(struct device *dev)
> {
> 	return container_of(dev->iommu->iommu_dev, struct amd_iommu, iommu);
> }
> 
> Right? At least for many of the call sites.
> 
> The core code maintains the association of the iommu_device with each
> probe'd device automatically. The drivers don't need tables and
> searching.

The rlookup table is setup from the information in the IVRS table, which 
contains list of devices belong to an IOMMU instance. This information 
is used to for setting dev->iommu during probing (See 
drivers/iommu/amd/iommu.c: amd_iommu_probe_device()).

Subsequently, it should be able to use the amd_device_to_iommu() you 
provided as long as the device has not been released.

So, we can add the helper function above, and make sure to check that 
dev->iommu is not NULL before calling the container_of().

Thanks,
Suravee
