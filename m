Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888203346B8
	for <iommu@lists.linux.dev>; Thu, 22 Jan 2026 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076423; cv=fail; b=UbSye6k2BMT/y3qKTHffhviRCakfpI5bHMrmfa1CPBvxX5DZBWFdRke+7c29cy30sit2QXPDszdYMl1vukJEI8i/8qHy7nFvV1hLsYicp3v7HLIPxX+9wIMOQtfNwiXn1bPDllZRmLh7x4XdNtJIxZp+1DQonop5TT5Uo79wFPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076423; c=relaxed/simple;
	bh=gQBob/Y90IraRUInrF7rPnKABbcDuwfCQu5YkyFx9Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XVrtLEy8ZLlGCe06OG1zATa8+BQoHiJQBQh1z9xmS7aKRHepJrOCQ8qtYi46v+WEQK5sgxXbV9+0/4+DbTk/Zo8MzhQYLcs0Y7PEJa3o4/p/+jTpB6XSZ55skltPX5oEVEu6FtnToves8rgaI62bg2WO1oVFu6DA913qI6KBqZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MDKKW02e; arc=fail smtp.client-ip=52.101.56.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MDKKW02e"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QyOUqmuNSq3tOa75vh+jt6Qje+fZ16BGvVegPKpFOY/CBoZx68rLUatoWIFr0WiAB6heCrSYxAgwBUZQCzFEo1aKJ19W2DqBn0NMwi4tbdBYnQB5Y0Oa4NLqlV3yFxw3w0XWaqw2y5w6sk7MUCZ9MeOat0Q9+A+aMuFucNS1l1BLSxJra4AnDUQ5O9vilavCL++Ew8Sr+Tog0HLGbcEh+AFGTUuCR8/XGkiKOYqw/K+nhaj5jlc8gWivl8LHFm2l1iwfHCw0MDZwXrhiI4TZZ+97q516TNEBYun8tcxQMRLzJFEp0NbvXrldKqi6K7x9y0CeadRwzAGVatDBbEFCHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ovLQqeJyqeuGLk0JmO8jvVPrGf6XCfJf4nc3LRW49Bg=;
 b=FSMnQSp0NislDj4AWOvvk9HWVtZRgbfZ/UPuwYDT4p0Ek/nfvHsZGp0pYZFv1YPIhm9p5qxvP7IxtXhAhcm1QrFGh//iN8oQu7RmSsNg5D7qJn+OVgtp8eIVdSwl26UdIUCz8vtOC02DfMr70aXXZlr7dq7dX/aXpQdi58scWs7XH/cdW+uPtpzkaNyXfQAhg3pAJu2XSfbeusAYnNDhwWakU5eYpwKjx/9+q++lJI5gfxkYV1h8amAUZU8vZF0lx8sVriwsjKX2Y2FG+33m/BENY2IuL/B+XmXjj4ri9Z2rNJRVAdHtCs74W09ZbKsS3Nun2KBHbzsn9bv5ISlBJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovLQqeJyqeuGLk0JmO8jvVPrGf6XCfJf4nc3LRW49Bg=;
 b=MDKKW02eqJcmLSDEchrq+7maTkTfxPdA6fqJmFGvHD7Ylx9Ll++nACN1hG3RsQj2kyJ9JCJVhUQuNyj567asw9PZxGfaHg2DU0HRvKwm1pQZ0CWN0pWPj/ut0Dq9tAUeQPPQn+UHk5voFyTZ7+MTnfme3yc0HMPZrgE7FlBRi4I=
Received: from DM6PR17CA0026.namprd17.prod.outlook.com (2603:10b6:5:1b3::39)
 by SA1PR10MB6391.namprd10.prod.outlook.com (2603:10b6:806:257::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Thu, 22 Jan
 2026 10:06:55 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:1b3:cafe::5f) by DM6PR17CA0026.outlook.office365.com
 (2603:10b6:5:1b3::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 10:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 10:06:55 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 04:06:54 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 22 Jan
 2026 04:06:54 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 22 Jan 2026 04:06:54 -0600
Received: from [172.24.233.239] (uda0498651.dhcp.ti.com [172.24.233.239])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60MA6qpE388587;
	Thu, 22 Jan 2026 04:06:53 -0600
Message-ID: <5e866646-1a69-4765-bdd9-b0713ec64992@ti.com>
Date: Thu, 22 Jan 2026 15:36:51 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma/pool: respect __GFP_NOWARN in
 dma_alloc_from_pool()
To: Robin Murphy <robin.murphy@arm.com>, <m.szyprowski@samsung.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <vigneshr@ti.com>
References: <20260112104749.4132641-1-s-adivi@ti.com>
 <aa4565e7-af59-483a-a875-5bd970c9c923@arm.com>
 <d27d0a15-36a6-4399-a904-b0163804298d@ti.com>
 <3a8f32c8-a5e5-4e6c-8af1-dbf0ff22b966@arm.com>
Content-Language: en-US
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
In-Reply-To: <3a8f32c8-a5e5-4e6c-8af1-dbf0ff22b966@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|SA1PR10MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e84e738-d811-4a05-d357-08de599df8d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YU9kUXB0SnFLMXU3YW9FU2Jhdno4eXZ5dEVJTmhxOHAzcnlrY0trYWwxeHpF?=
 =?utf-8?B?dFBpU2N4TnlhbUhQSG15YjhhVkp2YURBWGUwVDRodlVYelhHR2NZTElMRnRT?=
 =?utf-8?B?VjBudU5Qa0NiWTRsUVZ6L3JJYXRjemw4bTNoVXArdkZPWWJ1NlRDZ0xQbzd4?=
 =?utf-8?B?K0RmMXdCRXFwZHhnMldhUS9IVi8vN3NKVmVDRHhpVnZ3NkRkU2lvTEd1cDR0?=
 =?utf-8?B?ZTFiVXA5RlhpaW82SXlaQ0FkWkxtM0szcERuUU5NWHg5bmQyTkRobFAzQzJY?=
 =?utf-8?B?U1ZiSG15UkcyMkVzSy9jL1pnak9HL05xOTJYcU1qRk5NMFEvelhrclg3dkJV?=
 =?utf-8?B?K21FeEJzVTRISmNETFI1YjlXbC94clJubWlUUjVFY291SUVrVWVLcFBIZC8y?=
 =?utf-8?B?ajhoOGVBMndtWk9MQTF5Q2pHYkRwU0ZoSmZYL0NtelcxZE1TeUMwUzc1ZWha?=
 =?utf-8?B?ZGRSa3Y0ZExxMEVuUFhpRWRzclpJV0ZJSXV3Z1ZQVytLNU50YitnQVZxRDVt?=
 =?utf-8?B?bEpZNjJYb3NtbWdUOE1Jbk5UeC8xL09VV0ZzK3JZanBwUW5RMzNMbU5OUEpa?=
 =?utf-8?B?Q1pvSUlUWlpPK2Rhc1BQNGtiUzFrUXdXOEJETlBmZ2pQb2RJWGFJZmNIbExB?=
 =?utf-8?B?UDJyNmQ2V2ZWUFhtVHc0NGNqRnYxbngvTWdwM3A1QU82MnJCdWdaYzNYd0Zq?=
 =?utf-8?B?RE90TmdjWTRpT1BGbkt1ZnNjRXh0T3FpNG9qaSt1cnRLVGRRdDRrM3Q2azJv?=
 =?utf-8?B?T1NJdXlNeGd1QkpVTVczcmd5bHFKclpHalFRYS9QcmtwRmVyZkQ2RDM3dDFt?=
 =?utf-8?B?VHovM3VkM0ZqOWJTaVZDN0I2a3BtSUczTm53RTByZ3g0UzV5cHBhZXZPVjZG?=
 =?utf-8?B?MUsyOXBVa05kTU9BL3lmbHFQb1pOd0s5TkdnVGR3OGJpd1h2VnZMVjNIWlg0?=
 =?utf-8?B?OHJaNWNDclJqZUxuNVdaYTZCVUFmY0E4M3UwODRwd3VhenN4ZlZLTUxQbGNU?=
 =?utf-8?B?djBIanVZVTBhZDhnaTdxVmUxOVk2WlVXaFIxdDdiWEIvdkhyaTZmdlE5UnVt?=
 =?utf-8?B?dE5meThabzZlTXVrSksvK0FleElyOUtlTGI1ckd4TGRTYTdlUitwOHdqT1RI?=
 =?utf-8?B?ajFNRDRPcW95UmFCVlRwbHViZkNsK3RraS9ITDdVd1VTc3VibVRDSXZjV2Rz?=
 =?utf-8?B?SnNuYkZHV0VCU1RPNGJTcTVuOXFiTjZKc01wZVI4UGFWelczVDVrRytwaFJr?=
 =?utf-8?B?aDY4bHZuUzdaYnVWN1JGSUR0bnFlOW1vdEhVSDc4ZnFIYzIyRnVaOHlSTmdV?=
 =?utf-8?B?ay9wZjlNeDBsZXByRnZCNlZKaW85b2w2ZlVDK2N1RzMxZ21IbzNDem95SVNw?=
 =?utf-8?B?VnBhenBYZTFZZFQ5YnRkTmtDN3orVW96VldIM1hqQUVFc0FTYnhNRzV5dWtQ?=
 =?utf-8?B?Mjl0QmVzbmJGcWxQSlNBZkhUQTdjWFZLYlNmUmplQ1h2TTlVemxwQlk2bXhs?=
 =?utf-8?B?VjRBV3FiYTNMVXJ0b1hjWVZIemxVZ0R5b3pBUlVSNFVRWTdCVHhhSkNLWDdk?=
 =?utf-8?B?RHNsUWtBUFFVVkc5enluRU1wVVl2aDZvOC9xTXJIL3lKK1l3LzZQRGVMMEZI?=
 =?utf-8?B?b1RpVnF6eEViU0laVzQySnFGalExaE84d2V2VkRqaFZNRFQxdjBucUYyR0Y4?=
 =?utf-8?B?UjNyN3dXMGJvbCt5T1lFTnNjVTlINDhGY2NuWGpRMmFhMTNRZHFjNzE1NVRK?=
 =?utf-8?B?N1B5NFZmMVpxTHlRcmpGMlQ1NGJTb1FPbWFxWGFMajFtZnorbUF3QWZSWEFq?=
 =?utf-8?B?NmVtenJaK0RRcGFaOG9qdFBWRGFlNFIxa1lYNUlOUWtjaHp4dEpsTzlhWmlG?=
 =?utf-8?B?UGE4T1VTQm5GdnNVU2NpQkR6SS83cU1hYy9DWDBqbFRLdy9BWXZKU1BMWjRp?=
 =?utf-8?B?QlVXejNCYzBPb3FUdVR2VVYzTU44MXVXVDcxZVVxUEFmcjhLbEtYV1B3c2lQ?=
 =?utf-8?B?K3plVS9oOC8wcExmSnVERXVVTitxWVJ4RUNHMlRCdDUrVG00Nm1yVzRiaHNX?=
 =?utf-8?B?YXZMeWZVd2k3Z3p6SUVJZjBaZk9EV2MyMGg2ckwreCs2UWZaWmZMUVVqNS80?=
 =?utf-8?B?KzlpU0JLWjVsQVNoOTl1THZybWFqczExVkpEYlh5SFBtaFBMZ2MwOHNCeDND?=
 =?utf-8?B?RmJQaDBQMVZ0MmV1UnVodStRZkc0Q3dISFhQNGJhN0Fic1Vod3pyaWp5dmVK?=
 =?utf-8?B?QmR3d2hSbXRWQXl0aE9JWVQ5VnRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:06:55.1871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e84e738-d811-4a05-d357-08de599df8d7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6391


On 13/01/26 20:32, Robin Murphy wrote:
> On 2026-01-13 8:45 am, Adivi, Sai Sree Kartheek wrote:
>>
>>
>> On 1/12/2026 7:43 PM, Robin Murphy wrote:
>>> On 2026-01-12 10:47 am, Sai Sree Kartheek Adivi wrote:
>>>> Currently, dma_alloc_from_pool() unconditionally warns and dumps a 
>>>> stack
>>>> trace when an allocation fails.
>>>>
>>>> This prevents callers from using the __GFP_NOWARN flag to suppress 
>>>> error
>>>> messages, breaking the expectation that this flag will silence
>>>> allocation failure logs.
>>>
>>> This is not an "allocation failure" in that sense, though. It's not 
>>> like the caller has opportunistically requested a large allocation, 
>>> and is happy to try again with a smaller size - if someone has asked 
>>> for an allocation in atomic context that can only be satisfied from 
>>> an atomic pool, and there is no atomic pool at all, that points at 
>>> something being more fundamentally wrong with the system, in a 
>>> manner that the caller probably isn't expecting.
>>>
>>> Under what circumstances are you seeing the warning without things 
>>> being totally broken anyway?
>>
>> Hi Robin,
>>
>> To clarify this specific circumstance: I am testing a dmaengine 
>> driver using the in-kernel crypto test framework, which generates a 
>> synthetic high load.
>>
>> The driver attempts to allocate descriptors in an atomic context 
>> using GFP_NOWAIT. When the atomic pool is exhausted under this 
>> stress, we want to return NULL silently so the driver can gracefully 
>> handle the back pressure by either:
>> 1. Falling back to non-DMA (PIO) mode, or
>> 2. Triggering dmaengine_synchronize() to allow async threads to 
>> actually free up used descriptors.
>>
>> Since the driver implements a valid fallback for this exhaustion, the 
>> current unconditional WARN generates false alarms in the log.
>>
>> This change would align dma_pool behavior with the core page 
>> allocator. For example, warn_alloc() in mm/page_alloc.c explicitly 
>> checks for __GFP_NOWARN to allow callers to suppress failure messages 
>> when they have a recovery path.
>
> Oof, apologies - looking again at the code in context, now I finally 
> see what the bug really is: this warning still serves its original 
> purpose, but due to the refactoring in 9420139f516d indeed it's *also* 
> ended up in the path where the correct pool was found but was simply 
> unable to satisfy the allocation. I agree that's not right - we never 
> used to warn on an actual gen_pool_alloc() failure either way, so 
> whether we have a suppressible (and more appropriately worded) warning 
> for that condition I'm not too fussed. However, what I don't want to 
> do is go too far the other way and lose the intended message when the 
> requested allocation flags could *never* be satisfied by the current 
> system configuration.
>
> What distracted me is that I think the latter can be falsely reported 
> for __GFP_DMA32 on a system where CONFIG_ZONE_DMA32 is enabled, but 
> all the memory is in ZONE_DMA, so I was wondering whether your system 
> was in that situation. The other series I sent should fix that.
No our system doesn't use __GFP_DMA32.
>
>> However if you feel the atomic pool should strictly not support 
>> silent failures, the alternative would be for the driver to manually 
>> track its own usage against the pool size and stop allocating before 
>> hitting the limit. We prefer the __GFP_NOWARN approach as it avoids 
>> duplicating resource tracking logic in the driver.
>
> Eww, no, that would be far worse :) Just untangling the "failed to 
> allocate from a valid pool" condition from the "failed to find an 
> appropriate pool at all" one in this code is fine!

Cool. What do you think of the below snippet. I'll post a v3 based on 
your feedback.

struct page *dma_alloc_from_pool(struct device *dev, size_t size,
  {
         struct gen_pool *pool = NULL;
         struct page *page;
+       bool pool_found = false;

         while ((pool = dma_guess_pool(pool, gfp))) {
+               pool_found = true;
                 page = __dma_alloc_from_pool(dev, size, pool, cpu_addr,
                                              phys_addr_ok);
                 if (page)
                         return page;
         }

-       WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));
+       if (pool_found)
+               WARN(!(gfp & __GFP_NOWARN), "DMA pool exhausted for 
%s\n", dev_name(dev));
+ else
+               WARN(1, "Failed to get suitable pool for %s\n", 
dev_name(dev));
         return NULL;
  }

Thanks,
Kartheek.

>
> Thanks,
> Robin.
