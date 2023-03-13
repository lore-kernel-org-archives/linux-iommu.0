Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F2B17D5;
	Mon, 13 Mar 2023 04:29:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQaW3b3gP41Eip6Oc5Q9qYKmPjjOlpvfyxmuLgmd5gVlcPWebbk5Hodk0BWCJo1aXZ5AZfaQWHYhiL9lIDAC/1SFmXiOYSmv0uzRZiOp/u8DIOPyb8MtiRg1RrMqnlkiNkRA9mD9jbM1WV4cbofThjvF7Vzd4DpV38IqIpH7DGXaIXwH3eQss+3otGMJA4hsQpVY2ypAkObdJZFo1aX+b+REBJhXZBboHVS8xv9nmBeakEflSaEbsX7SUFlZJxg/wJTRMJbc5R86g7M2/TKfuBTwOhXR7nSEyWwxakfnXhpuxWp3ZlzEecJzlTyZn4fTlsanIlU9TWqcuz0c2ugvFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oA0c7RXbZk4fmX7PS2pLejmJsiXOYZa5Fa8eKQFriWY=;
 b=Txlbnd5khgWKTvUlAduPm4ugtQmxh7wQAcFsMwqqI/p8PpqwtUYmEVr13n33Gry33JIzImKarTRTSl5px5/pIeECJorhEUbvCk4Nc6pOGtq7BSTYZpTZAg9x73ynbbi0hWpq9OMRkjEytOwWqdKeS2WjDoKZohjN+oR93nWNGp4WAslS44/BsuOBQKkuVupzSq2y9cepy2i8GwqTY2geBgiLN1BJNGIedhA96av429IV1kW3hQ7ff5wy9Vq0AdYIEMBjGsQow86InhK01gBKGP+CykQ27xCD33/RTZKV54Zskxv4HUnQyqCT2apQelW/YnLy9SXw8IBmW5iAfYRC4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oA0c7RXbZk4fmX7PS2pLejmJsiXOYZa5Fa8eKQFriWY=;
 b=YWbiBbQEFzesxv8s73yVdJQYBsRmf8Yhqzgg0N6kN2bCc/PK6dosjC/jHwegGvbFKIL/dsI3SVIVeXYTU7n12tTYEkPRXjbZZjB5wPKe25jPnF8pKeC2n7DFbGgmrtZaeA7cVjvadl3xRv3PqLA5SO2iwLrNxcGVq0c7FK16qMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB7103.namprd12.prod.outlook.com (2603:10b6:806:2b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 04:29:27 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::70b7:99ad:2e50:8cab]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::70b7:99ad:2e50:8cab%8]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 04:29:27 +0000
Message-ID: <855144db-5952-04d2-abbf-d821dd8ba25c@amd.com>
Date: Mon, 13 Mar 2023 09:59:12 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 1/3] iommu: Attach device group to old domain in error
 path
Content-Language: en-US
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 iommu@lists.linux.dev, joro@8bytes.org, baolu.lu@linux.intel.com
Cc: suravee.suthikulpanit@amd.com, robin.murphy@arm.com, will@kernel.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Matt Fagnani <matt.fagnani@bell.net>
References: <20230215052642.6016-1-vasant.hegde@amd.com>
 <0f6e2838-9d7f-dc2c-6e5b-0d02e239f032@amd.com>
 <c44b3f40-4b8f-8614-65f5-e78ded89c641@leemhuis.info>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <c44b3f40-4b8f-8614-65f5-e78ded89c641@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::26) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f5f106-c848-4be2-a148-08db237b881a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a4RI33rkudlIFaF2HgsBQymRgfKuWO14YnJdnRnVwL1aGP2hB4qmD4ty9NXE4vdWI6NLNeZhU5iSa1k1xyEkUWfJQvD667nUvFKHoeDvfm4HFG3UtRDDOM/YdQjhuT4NXnWgOSloP2a6OxMEMpZrCZ/CXunlnL85XXvHD2eorX7jZFW84nVIcVfemMmCGNDEAIl9RghgsyCcKO/8FKR+4LmiUKDNCeOn6qXehrojgBdOYFfB+z6v/WmGkdlRGxY9jF6d8rYvF9vFjZCg9daqITZ0NttntBl2LcmjXXrYBUKg7ME6qI/hzbhwVjmCdcu3eECiQ7UE5W+IyUlZentCBuOxGrIbeZf0cHBMTO129zWmA+px2KHu3IbvD7b7kiix0mljjy73wetYRMqhv+WCoeLaBUpDC/jdo4j7835MGbYpy0LHSwDC36aj4swjUFg/EDXq0S0R3rGM+l7Bn/Jh5W2WeHMXC0mxXDVdlebmMJNkBqROJ4ld8IKTHivYnFBvE7RRPpK+dBfIdYDnYwlNtjwzqEOq8NR72YJtTC3Yy/DRd7+ZarDvu8SV5I9JecOP2i2u1YWj/4WchfLAMxI+sZtcJ3rZwJHR19dPqdPYLozOkqMa3ozlJiTAaBixc9G9UmfuKD9MYVk8isPe3oLmscFNqyx0FGkFLzh1y+KqgmIRlZMlHl/ln1bSwC6zB9RzMQanK5+TXcgU4tJDQ24ZOQkC1JXoD8h7e78DaGNfmfi5hZ2xGWszKa7EtEyG/QI7LVQgcrBgZidsgkt1tYkBYA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199018)(2616005)(186003)(31686004)(44832011)(53546011)(6512007)(6506007)(26005)(8936002)(83380400001)(6666004)(38100700002)(5660300002)(6486002)(966005)(8676002)(66476007)(66556008)(4326008)(2906002)(66946007)(41300700001)(316002)(478600001)(54906003)(31696002)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTJRQmFzQUsxMWprMmRld3JXRUFEVVdUaTZkR2IycmRha0dtSER0ZitxLytY?=
 =?utf-8?B?NlIwblNPeDhZTm5KSzRBVnNjRUxUZmdOVGp2aXVzWGVOUnBaN2s0YjFXUXh5?=
 =?utf-8?B?Y3NFbHZyZXVvMm9lMXI5ZzNmUUx4cnhhMjdwUEJ1clZYMGJFVkp4MnpRbkcv?=
 =?utf-8?B?U0xwajZuOGN5VFdoblNia3dlbXFKRDZORGZESnV0Mm1IOFB0VkZBQUhiY25T?=
 =?utf-8?B?Tm82TGRaZXQ1a1dDdmhOUFNHWFlCTWJhb1dWMWdMMFR1cHk0L2pJOEI2K2dt?=
 =?utf-8?B?MmNZVTUyZi8yclR6YXFvRWhnOTZyQUNxbmNBTC9mODFhUXg2NC9ycEVoNVJ0?=
 =?utf-8?B?SWJXenRWalFuQUVCZE94akxWUkorbUQyUUwydFRIRndNa0RpM00yeUY0ZzBP?=
 =?utf-8?B?YnBNeStudXlZOGFuV2E0MDJ2bUprMDZVYnRjbWRVS1JJYnVhRThCSWdNQzZ1?=
 =?utf-8?B?dkxBVXVtWFBIOVo4QzBqaHlJYlNvTGcvMHF6YzAvcWpHbnZsa2lMZlBuZlNa?=
 =?utf-8?B?Wlg5OThiRnFRQk5OVkttQUpocUFwam5lc3cxVkJ3Rm5JNnM4UXY3dC9OQ0c5?=
 =?utf-8?B?TTVUaUhBdW5lbXJRMW9tWUxKMDJ4eEY3MU1EVnMwZTNGUnU4ckNTVURLRW1n?=
 =?utf-8?B?cUZzb2plNE5PUEdVVjh0SFpwVC9vbzdhWHJVdWJ3N2xGZFlmUWplOWI3TFJW?=
 =?utf-8?B?ZjZabFR1cGQxZzBDa1hCa1pPaUNuMUYxWDRWQjFNRW9CNEVqR0lEMWF6S2J0?=
 =?utf-8?B?OGdkQlpFSzRhcks2Y1ppeHdXNitKRXpUalNqWkk3NHJReHJxK1hkazZQQllB?=
 =?utf-8?B?cmFFeTNFbm5hbU1tamZDdXJQbk5qRUJleHQ0M002RWJRY3Y5ZkhXOVlvU0Rm?=
 =?utf-8?B?blZRaFpkR0d6SG9yem5DOUx6WGZqYys1bEt2a1o5aDhzT1RSQlZqZHZLZXU5?=
 =?utf-8?B?NXVqelZNdFZvOEJLcUtZUklDb0NucnhvdC8zQVg4N1FHZWVhbHVnU2V5T1BK?=
 =?utf-8?B?UFN1RGc0S1JmSEI0UTB6RlNQVjhBNXh0M0lzZzNnb01veTRUdk9OdXNQS0Z3?=
 =?utf-8?B?ck5tTm1XMnEvdXpSUi9TUDZQUCtUKzN2TlVnSzBscXdaL3E1dERPWDVrcXlY?=
 =?utf-8?B?VHlLR2ZkOFducU4vdkM3WjU5NmRRUG1hRWZob3BEaGVCNm5qWWZuVzVlTUFU?=
 =?utf-8?B?RFd4dnNhMjNqU0NDYzducDNiV3QwaXNLMnlMRjFOc3hQQ1I5QVlkSHFEekhL?=
 =?utf-8?B?cU1iVGZlWld2OHkzMXR0S2c4czBpeVZzV1ZZMDVUMk5sUVJtSzJNSHVJbGJ6?=
 =?utf-8?B?d1k1b1JkQ3A0c01NTm9XUmRIZTZZV1ppVnJmUEpISytqVENKWHM4a1lPSCt3?=
 =?utf-8?B?aVc0eXJIcUFvM2V2VFpPVjhnTFZFamdDb1lTdjUwRHFqQ3JPQTRRWEdlbzdC?=
 =?utf-8?B?ZVhtQjZxMUVmclpmVDRmNEh3TktjNjFCbVI4WGlXbjBHL1Bpbm55WWdMTU5T?=
 =?utf-8?B?cmNqZkNnNlZJYzB3UnRoV0VaSGNLWTgyQnJzUjk2NVd0Mkt4UkNxMjNYTTQ1?=
 =?utf-8?B?WnZJYUhlZGN1WFpKV1dJYjg5czE2dHBXWGZ5Umd6SVo0bm1PaW02Yitxb1lX?=
 =?utf-8?B?NW01cHN0V3o4M2RrVjZLbmkvWk52VDV2L2kra1o2aUVIL3h1V2ZFT2NoWWR1?=
 =?utf-8?B?VndwVjFzcGJ5N0gwUWg5SUVJTm1MS3FrQWpham5rdDBMUWdBUnk1NVhnTVRi?=
 =?utf-8?B?NHNpY3NKYWtiU1ExOTJyVzl1R2gvVzFXc2Y2THFiUTNsNXh6Y1c1eGhWQnhB?=
 =?utf-8?B?U0NoT0E2bkh3TDkvZHBySkplQW53YmZVRjhyMDAyR0NWMmlPMmJPUDI2WVUz?=
 =?utf-8?B?T3Bzbzk3cjd5WUh0YnpEbzhKMVVLNDJFZGZnMGxhdjI0dE0xQjRWWVhoNFgr?=
 =?utf-8?B?N2pjbjFsMDlxNHd0SWVrSGtWRi8zaTA2eWhJeVVic1Y3QW51WVdWU1ozckVY?=
 =?utf-8?B?ZkQ5SThKWS9Ga3krZE9wWUE0WldOeGxsRFRVbndpMzg2STNKRGZ6NVlhU3Rq?=
 =?utf-8?B?cktEOXA0YTdiaGVzaE43ZkJhM2hXQXphU0lvWjlvbG01TDNQalIxQWdRZXhF?=
 =?utf-8?Q?KaqvH2vYC2v4gVrELTBDU02+V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f5f106-c848-4be2-a148-08db237b881a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 04:29:27.5547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iwk/04S+Kwt5cPP18EnPsd54PM9K/ViJBuZBxXiJVMAUO3jHvcKswziXs/um3b5h9Z+Ve9WkV8qatsTABvfwZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7103

Hi Thorsten,


On 3/12/2023 8:12 PM, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 17.02.23 06:53, Vasant Hegde wrote:
>>
>> [+ CCed few folks from other thread (Bug 216865 - Black screen when amdgpu ...).]
>>
>> This patch helps to solve the 'black screen' issue we hit in upstream [1].
>>
>> With this patch we are handling error path gracefully. System is booting without
>> enabling PASID for AMD gpu. Matt has tested this patch and confirmed its working [2]
>>
>> [1] https://bugzilla.kernel.org/show_bug.cgi?id=216865
>> [2]
>> https://lore.kernel.org/linux-iommu/e17d1ee9-7383-6717-6f10-9465b273b1ed@amd.com/T/#m98390232691e3e55db7f1187073016436fd2176a
>>
>> Can you consider this patch for 6.2?
>>
>> I did miss Report-by, tested by tags. Can you append below tags or do you want
>> me to respin patches?
>>
>> --------
>>
>> Reported-by: Matt Fagnani <matt.fagnani@bell.net>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216865
>> Link:
>> https://lore.kernel.org/lkml/15d0f9ff-2a56-b3e9-5b45-e6b23300ae3b@leemhuis.info/
>> Tested-by: Matt Fagnani <matt.fagnani@bell.net>
> 
> Thx again for handling this. Matt now seems to run into a different
> problem reported here:

As i described in other thread [1] it looks like GPU needs to handle failure in
resume path.


[1]
https://lore.kernel.org/linux-iommu/9b688cbe-ec48-17a7-0e40-5734d58e102d@amd.com/T/#t


-Vasant

