Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92A863C3
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 10:07:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kebZEA37MNW4tyRt6kE8DGfgsEpf4gi3bwcbVfojHHIYdPd7m50k4px4yFzKvjv/J3vqguJO7bmCT226kM1YW+T1uFk9cwy/Wjf0DQC9vJqgIljheIjMc5WhsFfoholJvcJ404Fn9sgdZAuayucivcRt8V7bvlNctHYr9xYfyxHAjRirb1a9SupkH6JYFWOREkY4u4B3pwrWyWNLeNb6Na6Y00sNYwpvxVoGQdsl5RvP94P7GDDVolmIx7gC1WF495RaBsVCk4AqMNWy+ivai6MHU641IKNPsBu4cHCq0E5ilQD0xwtJMtRLnWLVSAZ/kLQD61bN2sqL9Hte5yyitg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbtSbzqxKBXM2jjcnrjm6wuWEV5rIPGroaupkoiYbXE=;
 b=QmYD4SKwtl4SExEZ32aLH7xe3OQzJDn2cSrgmP7qEozvW5a/rWu0FihYdLgLy1hCB/QRXbJb+jSQySo89AnlsvUDDE0LC5aP/2SF9uehW2/R9N16opgZ1iLWF1GJW7sALiShifObNtmkpzo1+6LJ4yS64ADnIxL+4dE9CQB98TNHB7n8BlneZi79F2+5atHrs9rcE5+nqomNGJlFJwlEwV93zy4HHr6+wes9bEphIW9kPrdXih5g4EeMQmprbqHuinhp8y8Hr8gmrdQqzgRNUo6lZYqKLCBk8aJq84x4aG0Vbi6vl+sjcj/LRAYfruGRnzJrn7SItu3XCg/jMHQhsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbtSbzqxKBXM2jjcnrjm6wuWEV5rIPGroaupkoiYbXE=;
 b=iBfTpyBBdVnYmb9CSSb4JbS/EIJIuumHl4Y5neHaB24MVweLC5EQbonCYhXV35bdGIHV2dxTVBeO1xgGVvaaEo/0nKuUB1IpzjxrfIqgHiRYs7c+q0emtAAKFfhKG3gnAQFZ5tb2z4Jp9fDmkp18nVl6kxJThFOsVTfG82vP7v4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 10:07:38 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 10:07:38 +0000
Message-ID: <f08fc678-0bff-1e3a-302d-f673c952462d@amd.com>
Date: Fri, 11 Aug 2023 15:37:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 06/11] iommu/amd: Refactor helper function for attaching /
 detaching device
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-7-vasant.hegde@amd.com> <ZNJhw8RRvJZ+R61y@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZNJhw8RRvJZ+R61y@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: baba0b9b-ee02-43b1-645d-08db9a52ca4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2PVqCzwNhTiWQhVtGAMi2IdxXtdNt3Mwju1dSnHHz794DyN5Xl+Rw0KyONtjOSKDZevM67y3dz+fSs7qdsl5mtayhFlAvX1qqMB1xbaNfLVu0CDz4ODoF837jjTMn7NvfffFt9PHcsGE/f55O2AQTfFhh8Olumtx/w1fHoJJ6munqInE3PGJYxIRDQ2FzJDSDu5UuIUxaC5ZKHXXRHUE9bbFAxLx1fM9ExYe6pGEYNb7gKVleXb/Kgla95i8Z8xmVXEOLhTtUgJMzE48QarxFYW35RiogbKP9bebZo1v/DNKIcxz23u30+Csue5+ZosntYB8YtlAw3cIvZtB6BRxdYMuhonjxtHnJnfrqVbQtsoPwbBVoC0tium7aDIvs6HB6FVSGJOfDrnul5RANNdWeZWfKciaOqu/HYMHeQI3kGFRV3yXcZgmeElEX4jUEm7do0k7Okq41RGJTGzsV1VIIOs52VOWTShXS/w/DO58X7cmOv8/EeSyUbonkPPesA7X9USqXJJ7o2XcVkWiF4z0irar/Z5+4GJwgUsPjufT1UTkfc2bvodL6GePta4MrQBLWy2tFXSVhDcFjQsSQ5hIDs5egVdJC2TSLCSEXm9ck5fQ93LDx9xAAPoYihcuwwCtWoYrOuMviJKjk9Y9uoqJPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(1800799006)(451199021)(186006)(8936002)(8676002)(26005)(6506007)(53546011)(41300700001)(36756003)(83380400001)(2616005)(2906002)(38100700002)(31696002)(86362001)(44832011)(6486002)(6512007)(66476007)(4326008)(66946007)(66556008)(6916009)(6666004)(478600001)(5660300002)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWpTSDAwYmFsdm16bStJVEEyWkV1a3RVNWpuYkRyeUFBK1kwVWVrQWdHS2pv?=
 =?utf-8?B?OGdEMlIzVVY5ZWpEMnlZd0F4OXc2SVo4RGZ2cU9EL1hQZTRFZXEzOTVJTHZi?=
 =?utf-8?B?Qy9uZzl4cTRCZysrdkVoK3pkZUVXRDF2Y0RMVWhEelBUZHd6ZFk4NGgzSjU0?=
 =?utf-8?B?a3BaSHZOQmEvOUVsdTRXYUxVemFRaE9JcjRlZ1Z1TTEyeGlQQUszTGJMd1dY?=
 =?utf-8?B?aDc4YXQ2TDB4QnlKYUhkZm1ycUVUNXlnUk5QYjBqcUI3bXZ4R0ptS21HVmQ4?=
 =?utf-8?B?SWkzOVZ1aVkzcmNpYlZ3SGxFMnhwSGxCYTZsS1hLc2NaSUliL2VsdWFqMEVS?=
 =?utf-8?B?WHg1WitERjFLcEpzcUE5TUdBbEpYNzJhOEc5L0xEQ2pGQWFjWVl6eVZDbElV?=
 =?utf-8?B?L21Pd0ZYMGhuVjV5VGExbTB6NTdrSHZjWjFFcHF0ZTNvbVZpN21jalNmSUF0?=
 =?utf-8?B?R3pNb05rODRwZWgvSndBTkRCbDVzd2Z6L1E4dTdUMnJUb0EwM2g3ZkVyZzBB?=
 =?utf-8?B?Z1pnYktCeUdudVFRaFBKallad1pIdXMxdkxhVFVRSlRWdFdWNnpyS2hPQVhz?=
 =?utf-8?B?cXlndjg1RmxlclE0QzZoSEN4ODdNZjl1RTllQk1OSHVXcmFKOE43Ukh6MS9h?=
 =?utf-8?B?b2VBa0R0ZWtQRmdrelIzTU1Qa2hjVkNIak9wWkRuQ2xDcjdpNEpQazJINDF6?=
 =?utf-8?B?YjByV0tSYjZOK0JPQTV2WmZxYk42aUJZYi8rUWhqWVEwUk9wQUdFbUM4WHRh?=
 =?utf-8?B?c20rY0R4WmRYWlFyZXdpeXZCM3JVUnQrcXNjTnVNTk9oYzZXRkFLT3VYWjV4?=
 =?utf-8?B?cER4UXdtQkttWnVreVo4Y1RmVEVIVFRNM0RTdFJsZE4vYmVzNHRZUERiYmo5?=
 =?utf-8?B?WDFQeWZ0TXNtWHZweWZ5WmxmY1JDNFlRQ0o0S21XdE43b2ZxQnNjaGNOUE5a?=
 =?utf-8?B?NURrM1JpNVZ0NSsrRUpOalVZd3ExUDFvUjJRYUVvNlE4Uy9ya1JuRlh1dGd4?=
 =?utf-8?B?bTlpdWNPTXBlbVRpV3o0S09tT2UzYXk1QU52R1hmbzFoVzc2T2xkMHFRcTFZ?=
 =?utf-8?B?TmRrVUx3WThuREZTeDVnYkhpN2hGbGkrZkRXZHBmR2ROV1QxVjVHdFMrZGM0?=
 =?utf-8?B?ZXFaKzE1L2hScFpHRkt3NTA2U2J5ZTFFS2NHT2JtT294VWVzcUxNZUFVZzN0?=
 =?utf-8?B?aGZBaHdRWlE5U0oreUhwVUc5OG5nd1ZRWlRZTHRNVFNGV29UN2xUTm9JYllQ?=
 =?utf-8?B?NFdDbnRINkNUV0xFWCsveFprbUErci82M1RLL0d5aTB4TWEvZlphWWRINXBt?=
 =?utf-8?B?RmFpTTlBOVFicWZabTBHc0tjWGw1aDE0c04zaVlnREpwdFZFN2IwZ2FTRi9n?=
 =?utf-8?B?TnVtUDhhL0pPbmljdnBYdStlZXdQMzFnam5zOHlDejZ5b2dsa0wvdmg4K3FC?=
 =?utf-8?B?NjJrS0RMYXE5ZkFESVRETUJKdGU0TVZ4T1ROb0NMWW1mZ0JERldvaTZqdE5E?=
 =?utf-8?B?Zkw4SUFaUHRxQWNqaHlwdTJ0ejd6R0NUMEhuRWhJMmpzSGtyWjRRd09zZ09y?=
 =?utf-8?B?WGxwYUNtYXpRK2duUTloRjdlZHNXSUR2ME5HYXMyTlFHUCtrSWRsMFRnVnZj?=
 =?utf-8?B?cWJQR08rNDZ4c0xZSnNjOGNWQnhCcmhIOWtTZklXR2FGbVQ1Rm1jNDU3VHlB?=
 =?utf-8?B?RFZFZFh3akxTcDFHYmpnNEY2OXczQzN1VXJOcW9aajlsMUlWVStHNzhTeGF1?=
 =?utf-8?B?eG1VMmxmVkVrWG9mam8vejY3bk5DTDVQb1c0R2VybFFxZU1mOFpCMmxabXNv?=
 =?utf-8?B?UGU0SjMrV01RYWlmdHZpeTY5WUNqUEpXTkQvdzhYdExmSEQwcDNxd0poREhM?=
 =?utf-8?B?RHZvc0VxdFl5aU1iaDU1MnBLWEhNdzZwZC8xSUhQUTVtdWRHKzQvVElVMVFP?=
 =?utf-8?B?UXdQazJMN0hkWEVHL3JNYmMvMktFU3A5YnNoSGQrczZ0N3luY3VzTWszNDNX?=
 =?utf-8?B?KzJ0cGMrajc2Nmpib0JnbkxMeFVlcUFJdjNYc21pR2JJcXNTZUV6YW9wbUFS?=
 =?utf-8?B?a3phRk1IaHZjSks1RzVEMmVncVlQNkJzdlNIcWJ2OWc1RElGU1grbVFvbzJO?=
 =?utf-8?Q?zeKvAZ60sQOnc59jfmEiWxJm9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baba0b9b-ee02-43b1-645d-08db9a52ca4f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 10:07:37.9732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArT4Km4BOlXXc+G5I5n1y6OLSvWw+6ce+aWjg+lTRCQ8QRuuKMoXldhCft3mU8rQytlucu9ruWUW0h3Npw7Fkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654

Jason,


On 8/8/2023 9:09 PM, Jason Gunthorpe wrote:
> On Tue, Aug 08, 2023 at 10:02:27AM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> To use the new helper function for setting up GCR3 table.
>>
>> If system is booted with V2 page table then setup default GCR3 with
>> domain GCR3 pointer. So that all devices in the domain uses same page
>> table for translation. Also return page table setup status from
>> do_attach() function.
>>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/iommu.c | 54 ++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 50 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index cc42732820dd..4fed3fbe069e 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -1821,15 +1821,41 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
>>  	amd_iommu_apply_erratum_63(iommu, devid);
>>  }
>>  
>> -static void do_attach(struct iommu_dev_data *dev_data,
>> -		      struct protection_domain *domain)
>> +/*
>> + * Note: This is currently used when booting w/ amd_iommu=pgtbl_v2
>> + */
> 
> I would drop all this commentary about amd_iommu=pgtbl_v2. That
> command line option should be removed.

AMD IOMMU can boot with PT, V1 page table and V2 page table. We need a way to
tell what page table we want to use. Hence we have these command line options.

-Vasant

