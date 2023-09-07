Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEC6136B
	for <iommu@lists.linux.dev>; Thu,  7 Sep 2023 07:15:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOaOB67pt1yZKNCGUnTT5fTzDKAcDOtiHb7uYo5aDa9HkKtKFY7gAv/UrJUbvLCXCODZgu8ZG3G5KgMQ+Fuy7vQH6OheJYBYzGyfCVIdNpFm6PvFrMpkMmlVRIP5fiN58JqSMhL7iPD/Zc5Q+8b325v6xM+3GiAn/uMWZnKZf62cGNENEHOa8vGblE9cyXnpQVFIw9NLGmUnuJVkKWs460d91Z2zSUt27lvwpchNL5irO2yANo++oq8GTWeg9DOuiQRlutZ+HTSY0nf4cnD8HkS77k9wzdcL0cAny1uAhtiijQT88JpvhpSEvU/vyrLZ3GU76hNAci+4VGMOrtEolw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PmAOPp+e6b3kaU78hK/RHMSCnWX0EwABxNUi+84Qg3I=;
 b=hO4/08o5zS/mUeaQanfzLLDvBMAzWhdpaTY9UOKZBvpp1g6AVGr2BNmc4Od8AVjqht6beKcgD8TPRYBt4aTeNuLvV4rhows90cCFahd0iKxISF+ZWOoowFno5LJQSrBhIBSW1P0nYTwTAkv3+hx9pPecMlnbAFfSrIj4WWbcfJRr84DnTBGpXZO7/OnU3fqXG38EvBw/wgOXQe/vbprPJNngoL316IGvFa9pluh3R0zUliHdlsiUh9Tmlbuibli7FDDuVX0L7Jk92oKVr92MDlZdpu52bioLTrQ+SUBz6OoJtNYLSuMUDy5+YgiS7HMDtmy3ZUuCeSnmQdYZzbuPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmAOPp+e6b3kaU78hK/RHMSCnWX0EwABxNUi+84Qg3I=;
 b=11006czcyMuvRmMf2FAcOqGEyl6hBuzKzwLQhMApODAtU4zf1enJluEhJHlikYaorXb4Dmwleakuui+RW+AMOPSpO75Aa42NUjRLFPPSXIvwMRLb5Pi7sFtIliB3HHogAOam0RS1/XH9x/UcRWQ6ND/7+zPtwcdKeBhKu6EoWfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CO6PR12MB5457.namprd12.prod.outlook.com (2603:10b6:5:355::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Thu, 7 Sep 2023 07:15:11 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 07:15:11 +0000
Message-ID: <e1e3b265-c39c-3288-092c-4293b7f3b83a@amd.com>
Date: Thu, 7 Sep 2023 12:45:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From: Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH RESEND 04/10] iommu/amd: Add support to enable/disable SVA
 feature
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230823140415.729050-1-vasant.hegde@amd.com>
 <20230823140415.729050-5-vasant.hegde@amd.com> <ZOYljfDOgbzVeBeX@ziepe.ca>
 <cbf043cb-aa4e-ff00-5d13-7b09ceaf0986@amd.com> <ZO93zPITePX52FaE@ziepe.ca>
 <7f231d1c-30d8-d30c-8cc3-82179066909d@amd.com> <ZO/U6WfzSerXUaj7@ziepe.ca>
Content-Language: en-US
In-Reply-To: <ZO/U6WfzSerXUaj7@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CO6PR12MB5457:EE_
X-MS-Office365-Filtering-Correlation-Id: 6513d502-c03c-42be-ea33-08dbaf722ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hbgk0dJItWbNAdQwuAXvf/znVvOKz+M3lP55+fs8CUqNwYkukPAq1XXR9UvBrcwmj59gB8VLuDKBf5EpyuqiBaZAf3TAqTIYezn5Ic7OQAAeRsBvSw/I7g50H62Gk7VH40qiFbLW0jQzvPfqAtd47JvouGXRS11g4Q28EcijB8Dnp1xcS8+2C0POHeXzFolhJlKb56iDx38xAQItf5SDPs4UXR/UnC4VUR8aIxPJ/88O3wpAISvC0upsT+Nzs+jRLX4MUMs051dB/JQAjmKiJ72GPEl5V1n9iI3HMHk34Tqavk1HhMc227SAM6qJGTRA7+7y+q7dzufIaDWG6laKgdPEz5T8FugeI9lJBiw7U+uH/4WPtjXcAzbR3JSCt+YGRVw/FWst/vVsRCJropXUOs/M3dzBh2K3eD4NKVoI/p0S1BGjpae5+PKztAo2ln3hlK9sROHxWCCYDttGh1r9owIPCQEhG46r+3ewFWGc/hSSBTs0vyeJ79CWYUaGaNGLbHmGZ5eAN6xrup4sdlpb/UmwM95bhV67mwkjT9r0iCjcRB3A2d9Lu774X8TxpDSVmPAT2BRu91bQoI/T7asAEizOKQ5YUK4W0nSjLUNndAqyLSoMi0TQzyvSpAoqo0Qsmm7eYYoC9LwHxpppPWSl7Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199024)(1800799009)(186009)(31686004)(38100700002)(86362001)(31696002)(36756003)(6486002)(6666004)(6506007)(53546011)(478600001)(2906002)(4326008)(5660300002)(8676002)(41300700001)(8936002)(6512007)(44832011)(83380400001)(6916009)(316002)(66476007)(66556008)(66946007)(2616005)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW5aNmpjZGUrSzQ3QVRRbDNCL1k0amsvaENrRnVUMVJYSUtjRW5DNjlwdnJP?=
 =?utf-8?B?L2hvelBFWC8rK0dwQTFZU0NkRVFwUVRONXZ2YXFIMkZRR2Z5WFk0STFlMzMy?=
 =?utf-8?B?ZnIzVC9hR0xGYUcrcm1xR1J2UkVqVXU1MkZPc2VRSGhFcjZUbzgzb2FncFhI?=
 =?utf-8?B?SmF6ZmhERms4UVJXWmFrUElFeCtIV0t1T1BzeVFCR0dsbkRUa1pjNS8yczBm?=
 =?utf-8?B?LzBwczV3Ny82UUl4SXh0YXJ4ZDR0OUI3N2hLa280SVlrck1mY3dVd3BUYi9l?=
 =?utf-8?B?NGxDTnBTUFpKbmxUN0NKTEpmdng4Q0NTWGxkMnlrZ2UvYWs3eUNTTXkwdFg0?=
 =?utf-8?B?UVE0V1c1SjRtRFBHYkRGL2psOHYwSzRNcVhpTjM1NXA5eVVOYWV0SGNGZW9N?=
 =?utf-8?B?b1IyamsxMVF6bFZ1aXhWTDFpNkc1ZXdlbzZySFpkT1BtalFJTk9kS0xpMlhm?=
 =?utf-8?B?ajY1MGpvQWF0bzJJSDlrcFZUbHU3ampaSFRaWkZ2cjNGS0dVeWdWSHJCMlN5?=
 =?utf-8?B?RU5jMmlocC9KaExPMzZuRjhmS3Vqd2JyQU9XMUpzamNBeVVQT0JDa1EraERh?=
 =?utf-8?B?UUlyWXFNRnlGZTBHQ2szaHhkUExTald1UXlKN252OWlVeC9la2tzVjRhM1ha?=
 =?utf-8?B?Z3RWa1VnZXNnUndMQW84aHl0WUk5UDBpbUsydDJjT0NvVE93ajZUMDJtMDU4?=
 =?utf-8?B?ZWtjZHlRVFlBRjRsMUdLMjhiZC9HN3JLMVNPbXdQbUx2VkN5UFdxRFJkWDBx?=
 =?utf-8?B?dTJsVUVUN1VXN1Q5S08zSEhFZjlSOGtQRVg1cnh2ZmI1b0t4Zk1yRk12VTdX?=
 =?utf-8?B?VzFmMWJyM1JKWHkwcUowMHhJT0s5WXpHK0hucXl1cEgwTThtUmdlaXd5MUZy?=
 =?utf-8?B?OXVSclF1T256V1NvZ2ZMWDBXS3RleXQ2N3lVTGhzU1VGUUVoR0VWMm1pWGdv?=
 =?utf-8?B?eWp0K1p0QjR5VStXenh5Vnk4OG5ncC9vZEtJZGZ4ajc0T1JkZHE1K0hZaTJs?=
 =?utf-8?B?Vld0c1lDWFpSbzJHM2VsblhaZExyWFcxd0hPWW1zUUozWnpSUkJ6RHYwTjdM?=
 =?utf-8?B?cnhwdTNac3RvVTRpZkZXMVFpc29tby9YTlNiTm9tTHBya2xXUStzSEcvbTRy?=
 =?utf-8?B?bVp1Tks5Ulk4Z2svK213bk1Md25lL3ZYcCtlSkthMTZZTmtwd25KYXE4VG9m?=
 =?utf-8?B?YzdqTTZUNWhpTG9CTFAreC9leWNXOHMxWDdqZTdhN1d2YXhKdFVvUStISThy?=
 =?utf-8?B?N1VqbWZqd2E0NXRaWjg4cjA0VFZvaTVJMEFvYWhWVlowUDNFVk91NktzNWhT?=
 =?utf-8?B?NFZjMjR4SUtMaDJTemROTHZ6R1FrazFCeUtBSVVUTjNteFNIRnZrNDRLL3lv?=
 =?utf-8?B?bU1MZklnaEJhUExUT1hjR3o5QnU4M3VEaUlYMzgzVllZcnBmdE1vZEZuN1ZH?=
 =?utf-8?B?aXJzVVlmd3UzVnNibUVjSUpmUmxnam5TRWlwTVR2aU14YTdkV0xYcEtkUHVC?=
 =?utf-8?B?c1dxbFJVWGNxbThPMUxmcEhaZHR0bytSMjNFMXRHYjlaUlEvWUdwazc1N3RE?=
 =?utf-8?B?UWFObEcwcSszVUdLNGJoQ3BwdXpXMTJoWXo4WlpBUWtJOWtsdmJmMHhYUzhm?=
 =?utf-8?B?NVlEZGR4YUt0SFcxRFJrVlpPV1RNdjhPdm8xSFNSUW5ZbVVFaFJjeVoxcTdC?=
 =?utf-8?B?dHJtcnI3UDRXNUdZNlhXampaYUE3TnRKOEJvbzN6ajkycm51NVMrRHNYR1Uz?=
 =?utf-8?B?bDhLakgzdmoxVmtWZ3EzR2RIZEsrb29DQlNyRGhvbjRaMlZsa21WUDJ6c0tB?=
 =?utf-8?B?OVpLRGRNYjlITkpOendxdGhCNy9IdmJUYjYzcFkwbHN1VmFkaXRJUEtlTm1W?=
 =?utf-8?B?bmt4V2NGSWJlODNzbzNMbzBQamFyNDVaUlkxNjY0ZXFyKzZNd3lJQlVYSENY?=
 =?utf-8?B?MC84QkJVejBqdThVbnBjaHNaQkdxZ1IvYnRveTlaM2JLakVLd1ZRWU5lanpS?=
 =?utf-8?B?NHNBQXc5Tjh4WVhQYS91UXpvQlZlSWtMeWNXUGNBb1ZweTFXdGZ5NjZIWnNP?=
 =?utf-8?B?aXVxN01FZjg2WkV1d0d6UXZURTB0N3I1dEhsL204SmVWQnBmUUhRRTByeVRa?=
 =?utf-8?Q?/4Uzb0K2nMVTW85oL2PdM3W+P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6513d502-c03c-42be-ea33-08dbaf722ca1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 07:15:11.6238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WdEmvwe8+A1AmYAaLjiLLWLRTiQ6a/C31xSMLGwHvxh/naOW0UGsZIXk2w1TkG8/2jSa7TCZidu0S5x702Idg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5457

Jason,


On 8/31/2023 5:16 AM, Jason Gunthorpe wrote:
> On Thu, Aug 31, 2023 at 12:30:21AM +0530, Vasant Hegde wrote:
>>>>>> +int amd_iommu_sva_disable(struct device *dev)
>>>>>> +{
>>>>>> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
>>>>>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>>>>>> +
>>>>>> +	if (!iommu || !dev_data)
>>>>>> +		return -EINVAL;
>>>>>> +
>>>>>> +	return amd_iommu_sva_gcr3_uninit(dev_data);
>>>>>> +}
>>>>>
>>>>> I think these features are a mistake, you need to implement them for
>>>>> now but I wouldn't touch the gcr3 table, and disable should be a NOP.
>>>>
>>>> We need to configure Device Table Entry when we enable/disable SVA.
>>>
>>> The DTE should only be changed by bind/unbind of RID/PASID - it has
>>> nothing to do with these APIs.
>>
>> Above functions are called during enable_feature(SVA) path. Not in PASID
>> bind/unbind path. In PASID bind/unbind path we just update PASID table.
> 
> I know, which is why they can't change anything about the IOMMU
> HW. Only attach/bind/unbind should change HW state.
> 
> I intend to remove these APIs once ARM is fixed, so please don't start
> to rely on them. The driver is doing something wrong if it is changing
> HW setups outside of attach/bind/unbind.


If you intend to remove enable_feature(SVA) API completely, then you help us to
figure out how to handle below issues?

1) During attach_device() we don't know whether device is really going to use
SVA or not. So we want to start with minimal GCR3 table (that can handle just
PASID 0) and during enable_feature(SVA) we want to enable GCR3 table that can
handle max_pasids supported by a device. That way we can avoid performance
penalty if device is not using SVA (extra GCR3 table walk).

Note that to keep things simple current patchset configures max_pasids during
boot itself. But we will fix this once this series goes in.

2) If we boot with passthrough mode, then during attach_device() we are not
allocating GCR3 table. It will be allocated only when its needed. That way we
are not wasting memory.

Do you suggest that the driver setup GCR3 table at the first PASID binding to
the device?

-Vasant


