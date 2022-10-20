Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971763D60
	for <iommu@lists.linux.dev>; Thu, 20 Oct 2022 14:50:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmlqZUZJvGGqH7R0qmSZ44337QTdYsWp6JDTxL/px1GH0rb7d7o0B2Es2l1iCkqs6PgwtUckQ01eeKnefHAh94cuhUN/AhcXvdrjCVJugs0//zbVRbMb4Wb+HjI/REpVxA42xYrKXgVkH5fsn01C/OUBLStmFhRSNCktBbqILlmk7+mZik8Nxhqtnskc3IgrwxiS/UDC13wb2NiOSvWQLyQrqoGMwv4jN1g5Up5xaN8BOGrp2O01PDk4s8iWdJy8rBNTe9ot4pGAQNncNUtMAaiYzPMPXO0AbSsyYO9bBgnpIkMT3cKhGi+9VgQmWl5X05eg1/8R6Ht2Xq0CaDk1nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKSpyQ7cb6chs4nHSbz52WnjLoC4u7TnK5KhqpbJbCE=;
 b=YK5bOwHsUbD2BsP5KdFOTADD20IuZCvt3zBPo54tQI9Rw4exJSxLmWZuvrxZo+BGYSO7ds5/m7aJgzR0mneCcFhqdTtj8x3QMhkoBw8HRBRGBTLYFF5VVFar5tNiL6dmkLnkGa/DBRhDCjwVCsd0LwSuUCBQqYT52Wf6JhLtMw5NY+K5m5HP76bDf9qAtUsc+Q96SrZPAQ78uU74cl/INbKXRdL0rTX23Fx0a24+Z6ylPNDhLAOS0/kfy8B2iKkQ0AW9SE2swc7pdoVWjuXmSzLHoocriSnBmCACjcMogBWo0ojVRU/XwnX/7vgJWx3w8qGUicQrWRKVA/KH9u8wfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKSpyQ7cb6chs4nHSbz52WnjLoC4u7TnK5KhqpbJbCE=;
 b=sxx6eSZyHNZLAfcLCYyp+2tl7TTMG8aBTc+ZF00/GvmTIYIsFS21YiklN4KTeCFtnN9su323A4WfoYkFSkqQYNOOc8xIWcHHK42E3NjfjN3GQc6Ud6ucCzdyMBR1fKoT5wIeWOWZag6EYwjQpC7kbPxyqaDCk1mpjubcpr/Nnr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH0PR12MB5468.namprd12.prod.outlook.com (2603:10b6:510:ea::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.34; Thu, 20 Oct 2022 14:50:01 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::580c:51f2:b715:17cf]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::580c:51f2:b715:17cf%5]) with mapi id 15.20.5723.034; Thu, 20 Oct 2022
 14:50:01 +0000
Message-ID: <2b8a5923-99a0-5d8d-6a11-b316a5583151@amd.com>
Date: Thu, 20 Oct 2022 20:19:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC PATCH] iommu: Handle domain allocation failure gracefully
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 joro@8bytes.org
Cc: robin.murphy@arm.com, suravee.suthikulpanit@amd.com
References: <20220914144424.7356-1-vasant.hegde@amd.com>
 <1a5195b4-eef2-00dd-1b16-806d662148ea@linux.intel.com>
 <9c10ed06-9326-4fb5-7af1-973d6094465a@amd.com>
 <0283328d-7854-2328-e526-29f00f5a2737@linux.intel.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <0283328d-7854-2328-e526-29f00f5a2737@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0199.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH0PR12MB5468:EE_
X-MS-Office365-Filtering-Correlation-Id: 65dc4ceb-a13e-45a3-13c4-08dab2aa5dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Zr3M0UtICRYJDkxWXF3zhOAkJLJkhprsiC2TfwEzuptBPJHdT3dy4pYFg0P4F4qVqjkNGlRGtULYknsFGZvEXzyaLWm0gyDLqX2cUY3hP2RfMmIY16RzncwuZD1B8r3agFw5Neh/HE//e1CtIrh40MXXfQyFfJAHLJ19nHfJ+3fg+4zYIFwybq0pq0Tm0SAe38JtGJTb7kTOjg8Ia7+chVsEPgxa967W9j1O5QEBSImyxvVZs0MMpfDqNTCg8/fWPAgoavKjvrmILjEjc18yV+Ym7hM8q37ub/KrhG3IebhpcTHXrXOyvfQs6CaDqMsePTVwB/PcHwH/Rf65pfroDA+6o9OgxC1lSMOwnbtykjL1HhrecltnXvCdyl4yqOeWrZG3zxAs90pw2//G8f8F+J3EON2+boA3iwOUecgh7lVRyaMIWTYw0I4Pqo/8VOvbcE9Gshp6EsgKLUibJf9aTs0gyIQiSG+UsdmFwfA6VmT8g5sNL6qsvrUAOxflfMAvS3QqOUtJST5uBhIaJd1e0hzv7aF1B8wMsjIOS52wIhQDfRLX5xVCbPkqOxZWRf28eZbSJgFqjTUwOivabLjhJiQ2sOSZH5pkR4xdZowLBfHAzsWIWYQe6C+GkouccVuDCx7KfRZnZ/BAeP4gzBeYvdYz95DfhTM+LYkHa8QTTyEVhk/+fymulYYsuk2pGdQn4FObC8Z/etCY8faqpbD/RnHZSKM2W+a/OMh0UEPNZ3puPFcVC1WvNqldGFRNRCVG1/Na/vapgt4xj2J65bttVHNiIsYYRzuhKldmNGCH5r0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199015)(31686004)(38100700002)(478600001)(6486002)(6666004)(6512007)(186003)(8936002)(316002)(41300700001)(83380400001)(53546011)(66946007)(86362001)(66556008)(31696002)(36756003)(8676002)(44832011)(2906002)(2616005)(6506007)(26005)(5660300002)(4326008)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGNPZVFVbGo5QUFzUTh5bm1jSERXdEZDS0RiOXhuMGF6TkFrMkpOc0dYY1Yy?=
 =?utf-8?B?bkFHdG4vdlE1bUoyKzJTb0JqUW1lRk5tbzlHTGxjK0hXemMwMEMvSFhtMTU5?=
 =?utf-8?B?TEJ1M1d6NWk3ZWVBb2xiaGNkMzR6SXRCRE1aVHp3SXJmWmpxNlVYRHppb0hs?=
 =?utf-8?B?amR0Z0o5R0IyUC8yOXA4QnNKTlhRdm5YZWNueTFTTHFSZDVacnlvdzY5OHJF?=
 =?utf-8?B?NndkVno3WUl0NjBsTjcxNTBZUmkya1JRS2NPOThSRW9TczNlMk1kV1BGcmh1?=
 =?utf-8?B?MGtXMlNMSGg3QlNwSGo5UVoxUkZKWXFnNGU0eHZTeHYremcvUmdyeDVEMnEx?=
 =?utf-8?B?ZjJJcXdIZmhySTdlbXNLV3dQenlUVU9zM2ZBc1gwS0d1bXdBa2RFdTZiUlA4?=
 =?utf-8?B?ZU5uUk9oNlNwU1JMdXFhRHJZVmY5andiZ0I0TVFLbVVpc1FvTkZsdTF3NmYx?=
 =?utf-8?B?K0k3SDZRbGdydHh5U09nUmhLZW5CcWNRbzdBOFZtUXdMMFcwV2hTOGwwbmgz?=
 =?utf-8?B?THI5UTdYb1NrRE9qS2tlQ1pSdFNxeVB1ZjR6d1R2NEJlOUVUNC9wQnA1TzBl?=
 =?utf-8?B?NmRKWVdNN014T1hQdXphYXBaZzhnVmRoS20zQzNNZWlDbU1xUVBUeFNYQ0ZQ?=
 =?utf-8?B?TmFlclRqaDVtMi84TGlEQ0d2OUFES0Nia3FydmNXc0ZJRkw4Yi8yMjU2Ujcz?=
 =?utf-8?B?eVo0a1IvVUt1MGNlaGxpTkVoY2tHSk9KVURabkJvanQ0QkZmS2dyTE5hLytm?=
 =?utf-8?B?RGtkM0FWbGMvQnhNcnlCMXhVTUFYc0o4d3lMVmdIY29XNEVXT3ZZOVVmYVd0?=
 =?utf-8?B?S3R5RHdVbTA2aFlPcFZKdUVodGw1Rzgya2tTSnovQzBGdmF5UGVMV0xzNm5r?=
 =?utf-8?B?YXBpWGdIMURkZExGck0vOURHTWhjUVNKWm5pb1hRTVhQTkFZeHdOb3Fkckoz?=
 =?utf-8?B?TXlVWXlKZG9PaUQyNE9RNFhIRCtJdmFkaDhRQ0cweFYvNmVJaWFRdHJ2Zmdq?=
 =?utf-8?B?bmxaWWVzSWpNcDdOT3MyVnQ4TzJDMWVEL1NjaTBvNWFjSzAxUkxTRVZCK3ow?=
 =?utf-8?B?czI5K1krcWhJYXhqSnJTNEhFTytXOVdpcFpIaCsxbGZITTE4NHhuZ3NoSXNk?=
 =?utf-8?B?VGRvbHFRTjFGS1I4enhPVkVYQ0RHTFJDV1M5SXUwYnlVOXMreVhjNHYzZ25E?=
 =?utf-8?B?QjdTLyt1d2R0RzM0TDBncHhIY2F6VGxnU012VTNQUlpaQTFKWnhXOWg1OWtB?=
 =?utf-8?B?b1RFeEE2bEYvVDkxak8rVXhieU54c1kzZ09nT3FnczZQVVFxaU1GUVhrU0cr?=
 =?utf-8?B?eVA0TFFvZVU5bXZjOWVxS2MxK25UWFM0Y1ZwUTl0SnFuMlJrNjhVb2RSb1E4?=
 =?utf-8?B?ZllFcm14eGlJeUJ0RGpXS2NNQnlVMVNMYkkwdnVPNEl0UVBtTVRtRFQ3VVYw?=
 =?utf-8?B?bWt2MDI3M0laODM3SndrRXFWamx2VmJmRnRXR2lmcXNCRnA4bFRWRkFjL3RR?=
 =?utf-8?B?ZDVGN3FybGR3T24zL0x3M1Zab2xaakRvRklEU3dCc3J6bEhodC80anoxU0N4?=
 =?utf-8?B?WGxBajcvamZOOUc2Nyt3ZElDcDYzNys0YjJqOUNvbU45ZGVUUEpFT0QxUHhk?=
 =?utf-8?B?N0VMdG1lYllKQWVZUjhtTThDdktzYXZBeFdlSWc3MkNPYm1hbjAvQS9nSWV0?=
 =?utf-8?B?cWZpd0N5TlhBTmFSZklkamdYU1FtaXYrVFo2MDl2RkVhZEtuSCtyd1hRR0JX?=
 =?utf-8?B?VjJNOWtsUGtZUzNDOU1PbXd3amxCUnk3NmxnUll2Wit0Tno1MU9BcFNLSHc2?=
 =?utf-8?B?aE1VVzU5L1FUdmhZTDBXcUo3SjE4UDZBeDhvbDR6aW9pTXhqeklhMUZjcm84?=
 =?utf-8?B?V2NLL1ZodU9CNWx5Tkh5eWV0RXRZT252aDdjWnJ6OEYzTU5kZlRTcnNOaCtt?=
 =?utf-8?B?VHlwbEFwWUk1SHpDUU52dy9IWFBCOGp5WjJNQ1F4eWxVUVFXTWE1eTdHSmIy?=
 =?utf-8?B?ZDh1aUZPK1loOGlLc1JNK1QrcHNkalB6bG5iSG1nTFp5aWhvR0drTWhqNzFI?=
 =?utf-8?B?bjBQbCt4YmdiRmx0OGxDMnA2Vy9xL0tUQnArcmJpdkFucmtVY2I5cDliUTJV?=
 =?utf-8?Q?4QmJoCP/oJMANMUnYottUGRTb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65dc4ceb-a13e-45a3-13c4-08dab2aa5dda
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 14:50:01.8540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: keZnCVjLAFD7dOQMKYSu5afe9TANYkmPzNC4fKOnLt6brV37fxndB6CyPKfu2kQYwqZtjP7UFY6ZJXcYFHGfew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5468

Joerg,


On 9/15/2022 12:58 PM, Baolu Lu wrote:
> On 2022/9/15 14:13, Vasant Hegde wrote:
>> On 9/15/2022 8:44 AM, Baolu Lu wrote:
>>> On 9/14/22 10:44 PM, Vasant Hegde wrote:
>>>> Current code does not validate domain allocation failures. This will
>>>> result in random failure at later stage. Hence handle domain allocation
>>>> failures.
>>>>
>>>> Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
>>>> ---
>>>> Hi Joerg,
>>>>     With current code whenever amd driver failes to allocate domain we hit
>>>>     failure at late stage and it became difficult to debug. Hence I
>>>>     thought of adding this fix.
>>>>
>>>>     I see that in commit 6e1aa2049154 you have intentionally didn't check
>>>>     the return value. Looking into drivers/iommu/* it looks like all
>>>>     drivers has domain_alloc() callback handler. But some drivers (like msm
>>>>     - msm_iommu_domain_alloc()) allocates default domain for certain type
>>>>     only. Hence I'm not sure whether its ok to handle domain allocation
>>>>     failures or not. Hence I have marked this patch as RFC.
>>>>
>>>>     Let me know whether this patch is fine -OR- is there any other way we can
>>>>     handle domain allocation failures?
>>>>
>>>> -Vasant
>>>>
>>>>    drivers/iommu/iommu.c | 24 +++++++++++++-----------
>>>>    1 file changed, 13 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>>> index 780fb7071577..e8a1e7fbffb9 100644
>>>> --- a/drivers/iommu/iommu.c
>>>> +++ b/drivers/iommu/iommu.c
>>>> @@ -289,18 +289,21 @@ int iommu_probe_device(struct device *dev)
>>>>          /*
>>>>         * Try to allocate a default domain - needs support from the
>>>> -     * IOMMU driver. There are still some drivers which don't
>>>> -     * support default domains, so the return value is not yet
>>>> -     * checked.
>>>> +     * IOMMU driver.
>>>>         */
>>>>        mutex_lock(&group->mutex);
>>>> -    iommu_alloc_default_domain(group, dev);
>>>> +    ret = iommu_alloc_default_domain(group, dev);
>>>> +    if (ret) {
>>>> +        mutex_unlock(&group->mutex);
>>>> +        iommu_group_put(group);
>>>> +        goto err_release;
>>>> +    }
>>> Some IOMMU drivers (s390, gart, tegra...) don't support default domains.
>>> iommu_alloc_default_domain() returns a ENOMEM and the probe process
>>> continues.
>> Thanks for the clarification.
>>
>>> Above changes this behavior. The probe process will always fails with
>>> those IOMMU drivers.
>> Right. I am wondering whether we have any other way to check the return value?
> 
> The __iommu_probe_device() treats ENODEV as a special return value which
> actually means "the device has no IOMMU hardware, go ahead with other
> devices." You can check with Joerg whether you can play the same game
> here.

Any suggestion? Is there someway to handle error code?


-Vasant
