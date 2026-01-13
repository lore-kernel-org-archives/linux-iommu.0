Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010018.outbound.protection.outlook.com [40.93.198.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA47824397A
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 08:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293969; cv=fail; b=tKTvn/7BnujSOWlLtRouj4L49TAneB1Q+jY5ebcK0VDRodH9JimvOMwdZTM6iQi1eTDtG3249NOFYsJTITELMylf0dOiV8O0Q8AMVg7pqdCVuio6YG4CpPoyxThPhaid4Lw0p9bkpZy4FGbYHDaCL4tZR1D+m4rCK6uxNB0qB9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293969; c=relaxed/simple;
	bh=suFDhiM7arhC9prIWekR+lS7QfmheQUEJI51H5b/Vv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qjRGW/PAvtRgYaYXXRsQpP26h59sfKMH/YFDWO0c1hmYppNBJ6+u+JeBmu6jiIVhcizCSJ86NMjSoTq6xFHBPXc7+OLPcsZLBNmdP9Q9o122i4kvn6ldtBITiVAlnYaJmKxsshPIL56Mivw0DEgZ48D4RVvO9sVRKOQNHPMl0L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZT4GgEbq; arc=fail smtp.client-ip=40.93.198.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZT4GgEbq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMEApaCKRdFdqseDh8gFbQHeRtglpJnuJQIJ+WvFWo/X9Vh2gQkWkN4C3L2Z//ibnPSMYYZ+X7qGBLNmm2Yn+35mwuVxPWUhxVuLkyxme4RV9ow7rnUueDfYD+aFwTk01+7w2Pd7DAn//8q0vZQ6XcD16tfNcAS0vKCU4NyyRxHUQ5R9rv8Bqvc8BxIfhRXhLJZVXCeiUy8dcxm5zjjLq7cYEeaX9Rs8LNHyA/4Muly5UCw2P1kqsSSZHYh+okKV9dURPzom215l7BqcoREQWl03ORm35A5XokPAIQjqxwe7vH1xur1Ib3E56NXFncO/dpA5HQMC8stDNXktkWaxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIqGbv0AojcSh+eoEJSFun/ATQyorYAm4N2Cqlc/1y8=;
 b=LmBAUS+uuiwUejarppQeJl5dgl4NAS5xbp/9ROdrYn8Ubk35q0r/bekd9CNEx+wP5Me5gmGGu7ac3LfX0HgBE1megLE2XpDFsC8xoUh97db5jAHXmsmovtSE5OcHiHkOXpwTS01y15IPx3jZSQx8ygx8M2zxqsex6tLkmJmh2dAa94EhXZ2Sx5Yhq/tfLUs9+5zVEaRZ7MWN3RRTEOJHojMfjFphyNBGKon4bzvmFTxoVAB226CbzV7x4RordxmJuF7Gehr6q1gA+HHDsve2qvLXT6IzGl7wwLtlOwaU+L+OK0LW7X4jElg9VjExlMMeH6eaQsvUw2dTHmbsOjZWvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIqGbv0AojcSh+eoEJSFun/ATQyorYAm4N2Cqlc/1y8=;
 b=ZT4GgEbqK3gijhOB5AwaSzhaFSNyoBHG2X3kQRdS+SWM8KCiVOIrtR1YeOrnWP2XxqIZ22xKJLcdALHOyjBktVS9NKlI4FbYkysy8Xaa/VhAZsqO4UpckX52tg2QNLkRPsMY/qBn16jst6t3TK09y5869nJRHRvqC8YI+UEve1c=
Received: from BN9PR03CA0268.namprd03.prod.outlook.com (2603:10b6:408:ff::33)
 by PH3PPF350708D76.namprd10.prod.outlook.com (2603:10b6:518:1::794) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Tue, 13 Jan
 2026 08:46:04 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:ff:cafe::5) by BN9PR03CA0268.outlook.office365.com
 (2603:10b6:408:ff::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 08:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Tue, 13 Jan 2026 08:46:04 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 02:46:03 -0600
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 02:46:03 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 02:46:03 -0600
Received: from [10.249.138.8] ([10.249.138.8])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60D8k0eK1864294;
	Tue, 13 Jan 2026 02:46:01 -0600
Message-ID: <d27d0a15-36a6-4399-a904-b0163804298d@ti.com>
Date: Tue, 13 Jan 2026 14:15:59 +0530
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
Content-Language: en-US
From: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>
In-Reply-To: <aa4565e7-af59-483a-a875-5bd970c9c923@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|PH3PPF350708D76:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f47579a-a7be-4f10-426e-08de52802fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|34020700016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2VLeUtHbnhmY25VWEl6cWFvVDRWMVF3SFNJdmFqSnpVSitNeHZQOWlDVC9q?=
 =?utf-8?B?N1oxWmp6R2cyQzdNS2VubjhmSXRGeDYvY2YvbzJZZ2JqQmVPdFpOcGJFYzdq?=
 =?utf-8?B?OXlmNmo3czFBTDRSbGtOQ2Q3WVVKUk9HT0FRb2dOVnZMWDR6OGlLSStvRnE0?=
 =?utf-8?B?VGtBUm8raGoyZ1dpbTcvRUcrU1JKR0FwRG1TTmpYQzltZjdEa0ZoL1RtamY4?=
 =?utf-8?B?QVpROWNEUDREWkhaZ1RvUlh3eGlIdUU2RXJOMFFwSE8rak5Va1c1a1pHY3cy?=
 =?utf-8?B?SnhPZ1RrMGMwVUpIaHpKU0FtbGtveUdjdkJzUmJxVzZIWk5GWUlyMDNKQVhR?=
 =?utf-8?B?NDhtemxnZis2dDJQSGhEaHBvS3lQMlN3NjY1UlhnSkhZTVBvMmExRHU4VTRi?=
 =?utf-8?B?Y2d5VEhjNXk1aVR5azRDZUZnTSt2cUJ6ODZsUFRZS0UySU5lTjNEZy9jaFlw?=
 =?utf-8?B?eWl6K2h4SlZjU0pwWWdOSVJ0RnZyZFFIL0pnVzRjL05xWWhmZitGdkQ1SnpR?=
 =?utf-8?B?aEk3YmRoUWtxK0RZSmE0ajVXOVdFSFVVeXdqRnNCeVBXMWx5NXg0MWlkNWRi?=
 =?utf-8?B?Nms0NDVRdTdxa3ZOSWR4SnRxQ05rWE85OE1VRFV6dmU2L1N1S3Nudkxtaklz?=
 =?utf-8?B?bjljellsRld4cW5SZUJtTzZYaEZoK1NUbS9Ccm1SZzVneHh3N01QeVhiMG5K?=
 =?utf-8?B?SzRkSlR1QVM5MVdHL3NabFNoQ2dMeCsxSnJ5NTloQmkyN1l2bkw5RURUZ0VU?=
 =?utf-8?B?TWFUcUVuaWFXSkJ4M21uLy9wSEgwV3RseWZ0b1hic0hyejhibmVycjYzNlhz?=
 =?utf-8?B?ckxDK2RIWDVXazJyZXlwMm9ld09mdERHNC9jdWl5SUk3RjJkV2k2MTlsbnRx?=
 =?utf-8?B?Z096NndpM0ZGNXpXMm9PQVhpZXVXUUx5QllNRXdXUEo5V3l4WXFNWEUxaXVD?=
 =?utf-8?B?TEZQbkpscE1zZWEyaFBVRVlkOVdORElhVmdSR28xYStiMENTU0kzeWZhR0l5?=
 =?utf-8?B?Y0VsTE9TV2NrVkk4Sng5Q2NUS2NNc2lXVEpxNVhwbEY0SVFYcmRaMjJLTkNM?=
 =?utf-8?B?TUl0NzhTRmVwb0dFMVREOUx0bUFsMUgrMTFCZUNhVEVtRTRGWm5XR1RCMEpQ?=
 =?utf-8?B?ekVqUGxDQ2pPRTZPdDl4R0wvV0pjZHkvdGlCSXBiM3ZKYXl4ckIvM0NUTmh2?=
 =?utf-8?B?KzdrTzVtS1BYNTRCT0szN0xNekFVQUU2alRka052K3dxN0QzNmRFSFhmZWxz?=
 =?utf-8?B?emdRaWF4YmMzb3d2aS8vb0ptVTVXOGxWdUFSYXNBT1JHOG9ibjZiY0R2WGlu?=
 =?utf-8?B?SG9wbmRlYXdoTys5dlgrcGhSQ1RYMS9mNkp6L1FvVXdYMGp0UFA3QjMzcnll?=
 =?utf-8?B?Z0RVVlZLVVV5eHBUcmFZeWRqYzhMcS9lTTRpcG5BWWxUK3A1QU9GaEJqemdZ?=
 =?utf-8?B?aEgrZUtZcUkyd2lBSnE3cjErN0puVkE0SGhCRk5TQVZDdzkwVlRIL3JYdVdx?=
 =?utf-8?B?aDgwRlNITFVaTUloL21hOTl2SHVsUFQ3cTlsclFaZTlBYlVVR1QxZ3RZKzFW?=
 =?utf-8?B?WUJQWGJqUitRTUJLWjVzamYvVTVVY3F4UkRGWHdaUy8rM0V3ZEFyK0hhTjV1?=
 =?utf-8?B?NktMRnJxN3d0eThrY3VxbHJNSk44WkcwZm1adTN0WWowRFJGV3RtSVAyQmFI?=
 =?utf-8?B?Nyt0Tm1HTjNaME9icTI1WUhZdG1TNFlwQzczc0dqUnhYMTRKK3lSaE1IZDhK?=
 =?utf-8?B?b0ZHZXRrNlRMMGt1R3htamZGaW0weDFvb040ZWJ5VThGV3RNMGVta3VBSFNr?=
 =?utf-8?B?YVFkOXdtRkw5aS9pRjBSbFlFODlEdDJyd1l6OXNCbjJIZXhwTHB0eWVoQ3Rl?=
 =?utf-8?B?eElMdFprbVI5bXVFYWNYbjA2RWRQVTFaT1hsMmtodlFkclBjRGpDZlBESGtz?=
 =?utf-8?B?ZHRlQXRpTW4zRkRhQlpEdlM3aGEzVzBmbjMvNk9nSjRyZ3g3ZGZvdXdxalU0?=
 =?utf-8?B?WkJacklqWURod2MxQWZIT0FKWHZEY0tLaDgxQUZWWHV2OHprZElOVmQ5MlJZ?=
 =?utf-8?B?NjBzRFhEV2d4TU1FNTdJVDRoMGMrdFo5ZWdBanMvWGhHeG1aaXZBZXdzb0Zo?=
 =?utf-8?Q?IEGA=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(34020700016)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 08:46:04.2758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f47579a-a7be-4f10-426e-08de52802fc5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF350708D76



On 1/12/2026 7:43 PM, Robin Murphy wrote:
> On 2026-01-12 10:47 am, Sai Sree Kartheek Adivi wrote:
>> Currently, dma_alloc_from_pool() unconditionally warns and dumps a stack
>> trace when an allocation fails.
>>
>> This prevents callers from using the __GFP_NOWARN flag to suppress error
>> messages, breaking the expectation that this flag will silence
>> allocation failure logs.
> 
> This is not an "allocation failure" in that sense, though. It's not like 
> the caller has opportunistically requested a large allocation, and is 
> happy to try again with a smaller size - if someone has asked for an 
> allocation in atomic context that can only be satisfied from an atomic 
> pool, and there is no atomic pool at all, that points at something being 
> more fundamentally wrong with the system, in a manner that the caller 
> probably isn't expecting.
> 
> Under what circumstances are you seeing the warning without things being 
> totally broken anyway?

Hi Robin,

To clarify this specific circumstance: I am testing a dmaengine driver 
using the in-kernel crypto test framework, which generates a synthetic 
high load.

The driver attempts to allocate descriptors in an atomic context using 
GFP_NOWAIT. When the atomic pool is exhausted under this stress, we want 
to return NULL silently so the driver can gracefully handle the back 
pressure by either:
1. Falling back to non-DMA (PIO) mode, or
2. Triggering dmaengine_synchronize() to allow async threads to actually 
free up used descriptors.

Since the driver implements a valid fallback for this exhaustion, the 
current unconditional WARN generates false alarms in the log.

This change would align dma_pool behavior with the core page allocator. 
For example, warn_alloc() in mm/page_alloc.c explicitly checks for 
__GFP_NOWARN to allow callers to suppress failure messages when they 
have a recovery path.

However if you feel the atomic pool should strictly not support silent 
failures, the alternative would be for the driver to manually track its 
own usage against the pool size and stop allocating before hitting the 
limit. We prefer the __GFP_NOWARN approach as it avoids duplicating 
resource tracking logic in the driver.

Regards,
Kartheek

> 
> Thanks,
> Robin.
> 
>> Align dma_pool behaviour with other core allocators by checking for
>> __GFP_NOWARN before issuing the warning.
>>
>> Fixes: 9420139f516d ("dma-pool: fix coherent pool allocations for 
>> IOMMU mappings")
>> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
>> ---
>>   kernel/dma/pool.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
>> index 26392badc36b..f63e027b8a27 100644
>> --- a/kernel/dma/pool.c
>> +++ b/kernel/dma/pool.c
>> @@ -276,7 +276,7 @@ struct page *dma_alloc_from_pool(struct device 
>> *dev, size_t size,
>>               return page;
>>       }
>> -    WARN(1, "Failed to get suitable pool for %s\n", dev_name(dev));
>> +    WARN(!(gfp & __GFP_NOWARN), "Failed to get suitable pool for 
>> %s\n", dev_name(dev));
>>       return NULL;
>>   }
> 

