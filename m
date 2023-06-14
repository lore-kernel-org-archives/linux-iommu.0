Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610F47F
	for <iommu@lists.linux.dev>; Wed, 14 Jun 2023 07:29:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIjPjDKS/x9iGOcqX6cW4wawyIk4bqrVFw1DKNfPbSmxs7aHMq9uBXYssmEwBLwVKaEQqsP+i476gISk71VmZ3lEa49MdHFZ9kOawofXzGEnxbcX0GdyQPNPxdShtPkC2tsfE9I1DKCEIfd9Q0QClIhkM2VuMuKUK+KE2p2vgVORuaUPw7YbqX3b0wf0278B5FbbCdTno3Hx5Lcl68CKKdYXvBhWxTxGlAIH1ahhxEpOZ331j2ergsZ0K6MQtg8jA8L3pclekM+EEouzA6d21+HNHa535KZeEesB8ktxOoDnIhUln9QBkMlzBz2sU02RVWufPL4OrvGSTElJq8q0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LC8TSf8fghV1lt6AmBdCTAJm0Qvxe3iVQqcxQxUw7RM=;
 b=V91mr7e7A71tOHYUbCLUHxcp9JKp0wUcw6yLwBW5FKHX3sXa0ixarps2NxlM23EdSmAan5nbleZ3ORCwcADZtl/ePuNPfr7JM5hacGCHD+9BfDUiOW8oK24l8pEzZchY8wdjWaXniKyQaNaJfhuhQjH3oZ90rQXiW4lffJk7asZsMoOUuSs6H5JiYfUP4IMNDLzHORG3v1YJluXEx/vmZUMpzXlQ5hHLcmOtXMz/w4UhlXzLmX/od9SHHSB6Tt0IV+lT6AdTtZpk1ZykDwBf4KGWE9uYeDi91Rzsum+vNSGvaIXRL3bv6LL1mcn9MeXHwfca7llLLso47gDLzRTzRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LC8TSf8fghV1lt6AmBdCTAJm0Qvxe3iVQqcxQxUw7RM=;
 b=nThQ9X8sKIeE+9hG/t/ctfd+oHcNj/TLClT0CcS0ZJQ1Vctx7hhGqcy2sJ6y7++8fpoD6f/qrJ0VenrWjmfRp07NxRcu30Q7j1QQcyrZHlixMbLG/QBzrCfkkOoUcrWEIA04cpLWrFxmP+z4iM+XipqXbQsi/UMelOlsNb2YrGk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.46; Wed, 14 Jun 2023 07:29:07 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::7cbf:236a:55b:2c99%4]) with mapi id 15.20.6477.028; Wed, 14 Jun 2023
 07:29:06 +0000
Message-ID: <da50028a-e935-98d3-a6f8-31e7a6a55216@amd.com>
Date: Wed, 14 Jun 2023 12:58:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] iommu/amd: Handle PPR log overflow
Content-Language: en-US
To: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 joao.m.martins@oracle.com
References: <20230609101746.6412-1-vasant.hegde@amd.com>
 <20230609101746.6412-3-vasant.hegde@amd.com>
 <6rz75f6nq3ia2bymqjv5alxauqqdk5ea3emfew7nkdjvxtv5ks@qwyzsbg3ckxr>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <6rz75f6nq3ia2bymqjv5alxauqqdk5ea3emfew7nkdjvxtv5ks@qwyzsbg3ckxr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0100.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::15) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: 8830980c-263b-4800-8416-08db6ca90938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BfTkrv2/WE4LwqqrFEAnv3r7ODCQdt24+MQ+tmF4NoC4qJFIDo/fwFfyWzmi3bV5HII3L2u8uC38synXavRKYoJiTA5aKjx8mZAVLR6S5RsyLDEQC098yijNBERSd53I1WM8eyxknH7U9O3DWjP1O5tSQgEjhjIgXqAkcguvBmCFZAxe423gs/MguUcywQfo9yEYVXToD3vRNZNg5Vswbt5SqyZ0R3pvRl1mXv1+yKEyBzx2l6p1ZGt6ZZaXnRtzBVRGq0zcQcYWMtgMCvjHkLeI6vk5JKt6qvD8g+ju4hlQze12QmRgYPUrUyBak/XQo4FDYfqjb46/7CNGAST25EMELRiflkpJN4hqzxs/pn0HQMwlQcNPD/pg1Iw7QfgjzV8S/AKh99PV/HcL0++8zlmw3gUIUFp7kWl7qhWDTXI15eWfpD8354X+nUF/Kmqy/txIRVgG6zbUAC+VSpGyrnf0Eq2LaVlQ6DjyKyiuOxvZyVLqb2rnYvLeD56VwwDuNxTlmdoGtMAFAB49x+bSqhi2bgWnys0B66WWFedF+aGlKttXtkulNtfVhZSVJzM3gV07Gl7aDmsV5vap6kwwMsZ85KnI1S809tFDj3P8c90PZO0I1qIvzJTIoS8g6Euq6ZtuLyxBwWRbuknWaIKJKw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(396003)(39860400002)(136003)(451199021)(83380400001)(6916009)(66946007)(6512007)(26005)(6486002)(6666004)(6506007)(966005)(53546011)(186003)(2616005)(8676002)(2906002)(66556008)(8936002)(31696002)(5660300002)(44832011)(478600001)(36756003)(4326008)(41300700001)(38100700002)(316002)(66476007)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHJUbzM2UFZRSG8wcHJuUk1MVlhsT0lucGViNnZhSjd6dWlaT2pjVXJpL3ll?=
 =?utf-8?B?YStDS2I3M2RZa0NETTlDeVBYYllpRmYzQjVuR3BPK3E2UXFacHpoMWEwVzZI?=
 =?utf-8?B?UzJGTnh0amRPTm81VVNJQzNxaHFuK0ZJcUVyNVZRQytyZlNNQ3pTZXJGam4z?=
 =?utf-8?B?aHZwSVVoRDJma3R2NzkxRHNGTGJWTDhxRkEyN25UQzhYRkdsNWxXTW82czNZ?=
 =?utf-8?B?QVAvcUtwQVhDdmI5eEFndWlRdHZZRzJ4VWNrWk1GVHl0SHZ3K1YzUkFvdytV?=
 =?utf-8?B?TjNIcS9pYnVXY1NKYTd1eWtBTnl0NG93b3IvWEVBNEJiRGQvT2dUU1JyM1ht?=
 =?utf-8?B?SnA1TG9IVXVvcm53Y2g5SkMvam5TcFJNeVN0SjFzQUVvMVdMZkRuRDY0TEZv?=
 =?utf-8?B?blR1ZVhlaHN1UGEyYW14QWFHeWlwZjVqcWsveGhvMnRaNG1haVNkWVg0SGI3?=
 =?utf-8?B?U0dsS3BGN3pKMXhuVTgyV2hqZzg4VGtzRkdnOSs0My8rWUFRUll5VlV3cGlG?=
 =?utf-8?B?bXNxVmZaV1N1NjZ5OVNhbWN0Q0ZOS1h4WVdETU1xTG1qSWJia0FMalBYSXZI?=
 =?utf-8?B?VEFsalRidFB3blh2OVJ5ZUZWd3Z5eUU3dVVJbTNZcTBJSUNhamRLa1UybkJj?=
 =?utf-8?B?TUtkUHp3SWNCWjl6N25hMnBMQXh4RkJkZEt3eGowS3F6WWs5K3BDVUNjLzJG?=
 =?utf-8?B?c2dMRlNJVUUyTDBnTjJESWs2VGdLamxwZVFKZ2RyenhTNmY0K3dNRk9BMm11?=
 =?utf-8?B?NlhhSTA5Q3VpSWVCQjVEVnVjb3NQL0hWTmtGNXV4NmVaMnZwaXRvVlQ4QUU1?=
 =?utf-8?B?UXVMWWMyZ2xGL1NZTFd0d2JwS2FFdTZnWENmZkJpN3Jqa2pDS04rT1pObURK?=
 =?utf-8?B?M1FzaTZHaFBLQ1R0VTNQWXM4bEpUd1VVdlUxMEFpaUR5ZDVveXljdm5mRno1?=
 =?utf-8?B?RzMrM2M3bWNuK3BMRGJEckNNMHBpQWV5L1k1cmVMZXk3VGwyelZGcWw4bk5R?=
 =?utf-8?B?RVU1TXIvNlREYkFpenNWekRBekhIczRwQkJRUHYrVEs5dHNTYlNaYXVVS3RV?=
 =?utf-8?B?K1lPV2s2NHJqQWxTWU5JNEdiTDBrQzFtUFRHaHZDcE15MGkweEk5TVN5R2Zk?=
 =?utf-8?B?WDhMbktacEhseFpLZzJRV0IzTmJaYVYzV1hVYlJTa0tVZHNvb1RKQXVleGRu?=
 =?utf-8?B?djJ5OHM1TUs1OTc5NUZKbVc5bCtQM3JTa3podTEvdGFuMkZLQmRSbm1RNVI5?=
 =?utf-8?B?ays4aXRhK0Z1dVJ6Yk9hbk9CVXQyVmlrbXNnb0VVcjIzdzlyVVYxNjRQc2Zt?=
 =?utf-8?B?L3lTZUhJZ2VWVGFDTDBEQk9CdkE3aUtYOUJrNUE2aGFYeTRoTnBQNE02MGtW?=
 =?utf-8?B?dVI3dmZ2TUF0cjZRaXhPRkNPN0h2dCtseEtpQThYU1Q3OU5VdDNXM3RFYnpp?=
 =?utf-8?B?K21CaVVmd0pxMlhGd3VsQ2JxUnQ3K3FjR3pyN2tiUUxONXUvTVBQZE5NSWZJ?=
 =?utf-8?B?ck1Sa0YyNXhKa2JYK0xIb1YvQjduMnFIa2RMejJGUE1penk5RUVJRDJGdFA2?=
 =?utf-8?B?YS9VT0U4NlA4NGZyVzJCcTRpQVdUZnNsdnJuZnRPSVJSeWtuYm1LQ1hZWVc3?=
 =?utf-8?B?dndqai9qbjRqZlFaalRxT2xPTWpJMm1KaTVrRHg4Qks0Zll1RE45MGdLYlFw?=
 =?utf-8?B?VjNJMXo4RURneHN3MW1qYitFellXUDRFVVhad2tKZHRQZGFiWDZ0N1F0Z3Jh?=
 =?utf-8?B?NzhBS1VSajJ2VnMyek0zY1FCR3RkdjgzdFFqQ2M2SzA3eDdPWW56cWtQY0tN?=
 =?utf-8?B?MkZjNWl5OWNkenZxMmIxaFZBOEZwLy96cGI0NnhEdjRiVVp4NE5XUGMrZ0dT?=
 =?utf-8?B?Skt1OW43c1VJbkoyalhQemxTUWloT2lpRjNyWnNtV0dCbVc0dlZYN29LYi85?=
 =?utf-8?B?Z0M2T0ZoOWZ0OXpMOTE2OXg0VjBXSWRYbVBRTjV1cnIzZ25FUjRROXFNWTdF?=
 =?utf-8?B?MkthZkhzNEM5VlEvY1k1eHJnV0VSNzd6RkNrd2JMUnJvV0JkYXRWOEpubmNk?=
 =?utf-8?B?NFRjODJaWlZtTk5aUTRheWw0TXVVNWVvRzhsdFVJbXBNaENuV1dvZHVrWmdH?=
 =?utf-8?Q?uuPqLbBc8QPhyIEmUl2aGKQxk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8830980c-263b-4800-8416-08db6ca90938
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 07:29:06.7189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2u6MiTJuqe/0vLlVn1ec8Rzmhx/BJFyp3H9+1uEKO8QbU+v90aNALzIhzd6j6eFJKtohylpWH9Cp6poeOJu6fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120

Hi Jerry,

On 6/14/2023 1:59 AM, Jerry Snitselaar wrote:
> On Fri, Jun 09, 2023 at 10:17:46AM +0000, Vasant Hegde wrote:
>> Some ATS-capable peripherals can issue requests to the processor to service
>> peripheral page requests using PCIe PRI (the Page Request Interface). IOMMU
>> supports PRI using PPR log buffer. IOMMU writes PRI request to PPR log
>> buffer and sends PPR interrupt to host. When there is no space in the
>> PPR log buffer (PPR log overflow) it will set PprOverflow bit in 'MMIO
>> Offset 2020h IOMMU Status Register'. When this happens PPR log needs to be
>> restarted as specified in IOMMU spec [1] section 2.6.2.
>>
>> When handling the event it just resumes the PPR log without resizing
>> (similar to the way event and GA log overflow is handled).
>>
>> Failing to handle PPR overflow means device may not work properly as
>> IOMMU stops processing new PPR events from device.
>>
>> [1] https://www.amd.com/system/files/TechDocs/48882_3.07_PUB.pdf
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> 
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

Thanks for the review.

> 
> Will the code re-org you are doing move the event log overflow check
> next to the event log processing check, like is done with the ga log
> and ppr log?

Yes. Its handled as part of IOMMU interrupt split series.

-Vasant

