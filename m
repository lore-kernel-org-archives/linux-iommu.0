Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8674D6AB6
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 23:31:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmR1qSWuCYpx0luhZWebv5Z0rE/PlrSO6AAi0MA40g+2VKDage7IUXd6PmujDk2lc7kyIvpJvRRRveiegJHVXmGYqpYkqSpbj+fF9EvwJjEa66tkASyG5TT5qf5o5B4UmQcoOFmZuU8ixaL9FDzx5u04wxQZ7CajAJinizpq5++cpWMwBv4kjaKK8viUd/6Nk2W3/2iWjrWxadNq29lGVnqngwvVgWroLxllsM8R4M6dmIhP4VsL0YrsciVFwxyIh9iCfqAADHGmrqYyG2wXM3g8MsDtIp/uxVVTFFMjOn6z5trDGX9wL7g8aL21OeQAsQlqeuDEVtBfdZZRIWOf4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SENGa2cyNeZxVPXFD92BmTTnSy0DftDoIKKs2ufQkUM=;
 b=MT/cto7fQ8wM2m0XxQfEbK4S2kW0WgttJXB08Quj3lncfTJC7CaEcdqRzxacJYAFvCEc1IF5NG05zakk9QlcxY5mmTi/kAPcMxKJg05BJh2XG3ki6zisdTcSTOaQL6m060TYzmaLF+PCwbQpNNRPOj+6tnp6U4/gYGUGcpjHT8ISoUqRrpysGqDp4aO9dNpa6sIo+9qa2fF6fIK+PnF4xH4KxN/BQw6jYSM/vMdPM2jsDVch1mDbvWRZAng3fVvRuJcWgiHD4+ftHb/BNPHYqAV6vy5AX5etmxiTT288oDKaM9RmxEK1Fqqom2FjaW8cL1UMe/mz0dlixcmSshiKqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SENGa2cyNeZxVPXFD92BmTTnSy0DftDoIKKs2ufQkUM=;
 b=ULJshL1lTY4y2pRPIvHXfNegoaJymkZQSZf4Ge2nspp9Y4I+JPhXzLlPUjUQbygD2kCU0DzXEwGkvHibSK6OHdQbL3BoLeVmqvOqLsfs+LjVV1V9oosl6qhCx9BCcyBhf34hzDcV3iXC3OCqdQh1nwOyiVOxOUla7JGwDbTZubs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DS0PR12MB7631.namprd12.prod.outlook.com (2603:10b6:8:11e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Thu, 10 Aug 2023 23:31:35 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::12ec:a62b:b286:d309]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::12ec:a62b:b286:d309%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 23:31:35 +0000
Message-ID: <711073d9-ceb8-b2bf-2d5a-1ab522828dc0@amd.com>
Date: Thu, 10 Aug 2023 16:31:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 03/11] iommu/amd: Introduce per-device GCR3 table
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, wei.huang2@amd.com,
 jsnitsel@redhat.com
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-4-vasant.hegde@amd.com> <ZNJgCMx976H+SqtX@ziepe.ca>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <ZNJgCMx976H+SqtX@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::13) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DS0PR12MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: ae942285-961b-4ca7-fadf-08db99f9efd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C4EsE8+MtlEf5WNmBiJ+H9fnf9rbF8+uIyF70frzjCcI/FUBB18jNOG8T1IuvH3aduqx2OKViaP9u5hxtJSOqB+CurWswKV9kr4ZiZ1PVJ0hiUwm1RQavb0T6qsSumaW62dEeTHEG+AHLbpLDP/ENMw7EmhuiqLIgz2b//vQQCED+8hPqhNEwynWEgCfG50+al9/JNW1dHhvQwLejzvtA4tfHm9nb9VDtzT3bgZKZf1DlBRTG05rYXT3Zg0O3QmkKKH335facANaTT5ePKzKvpuLXqrDaiFAtPQ8QRfNIVZKxFc0RIBrN81hF0AqD8dgkfgLmpGC5fCE9B3gn6VPivsEdgejErb9HNQlzwQT6j+/wRSXKyBgKODlG3BzzKP6rcEsVVkb9SwsG1WYqA5Qp4csle0YOI+0YCQqDY6jRcpvI2w5HW5kiZcCkGWfDi/g4NdZeMAzXDvynjBeu5hKovjCckJ/yjrLxAVFE+bZNbRYVQaK/79Tg06VGjY6b74m0gmgKGVmXgpkbG2YDQKulsLKOgPSeSLvmUYtJpzU7TK8EMA2Rs8QIRo3zSzPaSNoTX8HENTrq6hs7U3jey+Ek8ZXrQweJM+Iw0XGzK/bTR4OaL8lq9B/y3NHyRfbvJuqsrdvfgirrjbLIJIlnfGNpQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(451199021)(186006)(1800799006)(478600001)(86362001)(6486002)(4744005)(36756003)(31696002)(38100700002)(110136005)(4326008)(66946007)(66556008)(66476007)(2616005)(6636002)(6512007)(31686004)(2906002)(26005)(316002)(41300700001)(53546011)(6506007)(5660300002)(8676002)(6666004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzljNUthNHJpSGQ0WkJHY0libHNxTUgwZTdKbXdKNzJTdzJpR1R3SVN4bndl?=
 =?utf-8?B?UGt3Zm8rbjFabnIvOWYzZVpXN0NuemFOUHozTFRPQlM1MWdsNjlWMnp1STNo?=
 =?utf-8?B?Rld5L2xXZmdPTE1EdllhbXM3dWZLOS9TSTlEaVNNUTAwZWVEZndTOTN2WDZ0?=
 =?utf-8?B?THRiRTMxNGhCa2hhWnBPWi8rQ3VvcExxbkJEY2tEa3kxRjMvSWNFY2FvZ2lL?=
 =?utf-8?B?K1hGaW1vWW82RytMRDFEMkNBWFJSYnlGell4bzE5SXZQTldWNFBWS09TNkxj?=
 =?utf-8?B?YXF4MGJwY082dUd2d00yNlBhUldUU0RMRW5xekNTZ3FTRnltSzViMVFmZmdF?=
 =?utf-8?B?MFdYQ0tSSjRRUXNwMUc5QTlNdHkyWTZIaGNSTzkzQ0JIaWgzQ2Q4b3JPMzJ0?=
 =?utf-8?B?cnBXWE1lYUJWNjNEQ2dUNTRZZ05iUkZwOGVZaUZLWlkxVWdKK1Q0QjF3SHU5?=
 =?utf-8?B?cnNPMGZNKzNpZk9Vb3orTXJOMDdlemVMRTZKZG9ja0tEWElVN2dDWXoxQThw?=
 =?utf-8?B?Q0kwRjFJTzY3WXE0c0plb3E4WkxxTEJnZWdhOWRiNUVFbHBPYWlyTGRaVHht?=
 =?utf-8?B?STRVTTgvZjVDemJza0kxbTk5QmhhWmVUa1BOcE5OTG1NVkd0KzJEWHh1TnBH?=
 =?utf-8?B?b1pHK0JvT01PYitnVlFNRzM0dGxzUnNSTTRUZDBVdXVBTE9la1F3YUdOZzV4?=
 =?utf-8?B?cnMxTmxrU3NaWjR4OXZhaU02UitkK0h6WUwyS2M5U1JMOUdjTUJJSWpzVDVU?=
 =?utf-8?B?YlgxVXpRS2JoSDdGUHdlb2N1VlZ5NUMraWtjUXRoZGdGV1IyaEJ4cjhqZ2xw?=
 =?utf-8?B?MmxaWmFWaGJnMVN1UGhIZmpFcHdCM3ErR2M4RXd6akVDOVQvR01vMnR0ZGFL?=
 =?utf-8?B?VlBBbTlKa1htSitEbmpTTkYvSWpsYmVjU3o4MWZEZlNwbURpUWdjMEJycFkw?=
 =?utf-8?B?SVkvS290Q2toVUVFTEFOUVdrNVBCOFhLcmNQSnZZZ3RST0xVdjVoTHo0QmRP?=
 =?utf-8?B?Um9iVjJOdGR4ZzZNU1hWS0pkOFlZYVBPcWE0L2MwazR5UCt6aFF5ZkhjS3RP?=
 =?utf-8?B?Nm9xNnZxRHdDUlJ6eXZPQlJwUDZDNm1GQUM0MDZHN2xqSjk2NVZWWThBcWF6?=
 =?utf-8?B?QkR6VjhCaG1FREZlRG5zTVFtbytBZlpEdkNZYmEzRkJFaDJvbzVCSlVaVks2?=
 =?utf-8?B?RnVUVzlFaG5LWmp1UEE4ekVIbGE5bDh3ckZOV1pLS1V5dS9BZFhYUFk2MUUy?=
 =?utf-8?B?NkdvRC85S0lxVlZEMlJvWG1tdGNlQS8rL3Q3WmVIQkVSNzQ0QW1jTE1mTENV?=
 =?utf-8?B?aHhoMVhpdVBKbllMT043U1hPdnNWQ1ZUQlBuRmFxVy91SmtNUmhLMlBDRzFY?=
 =?utf-8?B?TWNMR0QvaTAzTjlnYmRmYm0rMWM4amlRZEdySjFLUWpVS3Z2UHFvdEdOdUF2?=
 =?utf-8?B?aGcxUDc5QWlCWEp6di9GTWJsMlJhdFpLOFZmK2FickQ3VVFDdHZHQkdSb3Yw?=
 =?utf-8?B?L3NsU3FoS2lSSlRyMm1jUEVDdW1Xc2JsVG83bDVuM3lpbkVKTzBodnJ2OTJV?=
 =?utf-8?B?cEEvWjRnTWlESUd4akxGK1JNOU5hZEU0eVdFaEJzT1ZsWitYREVVazlJM3RH?=
 =?utf-8?B?dE9UdjN1dHU4NkYzSFcyR00rcGtsVXh4VTkzV2h6WGVxdFRiTm5LZGVINmxG?=
 =?utf-8?B?ZUQzbXlubUs0U0hTL1gyZzZBNThnNHB0bDgvOHUycWF1c0lscU8xYVpOWmFN?=
 =?utf-8?B?T1o2a0xoUWsxQkVhdlI2NTVUcXY2R2E4OUlhWTJqdDB5ZmMwT0JIV1RJOE9K?=
 =?utf-8?B?bFZzam5qTU84Z2pvd0wyQXJNU1JNOWZBVldaRXBxMHZMVHRtbGhUSjVObG00?=
 =?utf-8?B?UVZ0Tm05SDEvQlAwbmIzSVhyODk4Q2FqWThBQWdxNDhPRTZ4cXpwTlNhSXFt?=
 =?utf-8?B?OERVMGdRSStabi9qZUdIUmthUXNadi9RcVN1eTE2NFZBMHNramd4eWlxNEVL?=
 =?utf-8?B?WkJGTXp4UHlhaDl3bTZZVFVYT0pac25xY3BhSGMxVnJ2Q1hySzk1TWRCR3BD?=
 =?utf-8?B?UWFuOWdHcHRQcU82aW56eDFzNURIRmxQelpMb1NoNTRWdVlGQ09YZlRIamZs?=
 =?utf-8?Q?MSA2cdB3k0n8t7CCaXdrKFI+N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae942285-961b-4ca7-fadf-08db99f9efd9
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 23:31:35.4543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLKFEt3R7yhuBEG1/Tf3Ut5pWqjaj+z3ipUNTUo8P4DMUhWMoaMFrAUdVGcd4T/PKtfR3r9CIgC85F/0M5pwGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7631



On 8/8/2023 8:32 AM, Jason Gunthorpe wrote:
> On Tue, Aug 08, 2023 at 10:02:24AM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> AMD IOMMU GCR3 table is indexed by PASID. Each entry stores guest CR3
>> register value, which is an address to the root of guest IO page table.
>> The GCR3 table can be programmed per-device. However, Linux AMD IOMMU
>> driver currently managing the table on a per-domain basis.
> 
> Why do you call it "guest"? There is no guest here. This "GCR3" is the
> root of the PASID table for the device. It is used when ever PASID is
> required even without VMs.
> 
> Jason

That's just how the AMD IOMMU spec refers to the stage 1 table (a.k.a v2 
table). Agree that this is confusing, but that's just how things being 
defined in different architectures.

The Guest CR3 (GCR3) table uses PASID to do indexing into the table, and 
the entry contains the guest CR3, which is root of the stage 1 page table.

Thanks,
Suravee
