Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A837DAD4B
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 06:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759990959; cv=fail; b=ZrG0XIIKto/df3ojbgf0O9EzBKFBrmZnbJMH07ZqvEYruhnIMqqPzDS5cVUENoaF+y7eWjuUShQQfFPAQQTN5QgfQszEpktKAYA8pDzHpdVPdIqsAuSiM+AeaDN1GZeRmQcJZe3NepHB91EO5fzwqskHuPTjiWm5Y18D773uWiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759990959; c=relaxed/simple;
	bh=qY0aDF+SKshSoiBR1qwMRqQR0MDtN/n/sCDUFdpShdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BFw8x2f+8x9hNUETF1fEknOGZ/sBiMKzSTHBhneuoB1qGfEPp0Fen6fGzrIuWONKQ3hSz6ExajnzIADvT8itVZXFg9g0xDApjbaWim2o3bKuRGSN40U3nO/P1ojaDBegxlfsQjziSHKZsxwo3ZGBKl/8DU1HxIm7GZjkYpLINEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e+Z4uv9i; arc=fail smtp.client-ip=40.93.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e+Z4uv9i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nS0nnf/x4WRDd2Iyr7RruM+UHcHEU/zIEWqWimkhnXc3nmz8SMj0+qz36Uhhnxzv26OUNpehxkyZhwklLc6ZN0k8HXo52nFhT9Snw1kvSaa43V+pW2ZbIWdt90uNbMIBaTJKIPvEAXgr254NFC8sUvoKkkVkAeWY8XeS2o0ehDTe1vR0oGlZCnyNuB1BfTv+qlnqe5un8FXg3FjA11nz+pW6e0qQY+taxu82E3JO8KRWu2u0A45zjER33cLySn4fjHU7cUM7d71EqwOk0o9XNQ2NaXGS1w+rvzdd2SO65aaM/PrqshyDL7skULYCKKjpyEHWGzSuYPpZMwCQMby7ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EJW+GtRPfJ0810p+Bh4m69BN4MpCtwea+DFpvDIYRw=;
 b=CGuKUndf2oqygnIpGc944D8i2p8XOm5mj44hcFhz22qAxNvz3oK8NGjWF6uAWxOSxli+i+mgTopgJg9QMaBog2ij1wY/vlHAUbDrMQlU35COnfve639jtqcMMxNkGVl3fXXx0tBiSpibKvt6KzEIf06tqLQ2jUUhfNSLT9eXAbzyckzQbQT7wmwYw9Hm6yXnv43c2H4qVj9XupQnpp4qB6bUc1Nc2ct+rrq60lFkVIYXJrU+sB9VqlUHGC+n2x+c003nqY2OO7ThTdqkVOrKwTjMmczGvb6n0pBb+I1obJkT4Yr45ocw4hswBmzFLJ3eqNQ2tN/HR59tTC9UgK+SBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EJW+GtRPfJ0810p+Bh4m69BN4MpCtwea+DFpvDIYRw=;
 b=e+Z4uv9iM6kjKbMcvUfMBD0d4idy4lBz4tSQNWQMW3lQsNnTjz+lXACAm8ysyuRF42peAfjT5ox6i1HVCfKiRlvRE2ZqnIK7Hc9dp2uR3E0d7kPO0Hn8K+/KSxR4iSmPdWfrSvy6xEsWoYkHYlmxk5ISbhApTpAafzYP0uZolcY=
Received: from SN6PR2101CA0006.namprd21.prod.outlook.com
 (2603:10b6:805:106::16) by SN7PR12MB7275.namprd12.prod.outlook.com
 (2603:10b6:806:2ae::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 06:22:34 +0000
Received: from SA2PEPF00003AE4.namprd02.prod.outlook.com
 (2603:10b6:805:106:cafe::18) by SN6PR2101CA0006.outlook.office365.com
 (2603:10b6:805:106::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.6 via Frontend Transport; Thu, 9
 Oct 2025 06:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE4.mail.protection.outlook.com (10.167.248.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 06:22:34 +0000
Received: from [172.31.35.81] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 23:22:28 -0700
Message-ID: <bff5f16e-ea25-4c59-96de-8002373f17c0@amd.com>
Date: Thu, 9 Oct 2025 11:52:23 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/12] iommu/amd: Add support for nested domain
 allocation
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, "Suthikulpanit, Suravee"
	<suravee.suthikulpanit@amd.com>
CC: <nicolinc@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<robin.murphy@arm.com>, <will@kernel.org>, <joro@8bytes.org>,
	<kevin.tian@intel.com>, <jsnitsel@redhat.com>, <vasant.hegde@amd.com>,
	<iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-11-suravee.suthikulpanit@amd.com>
 <20251006144936.GS3360665@nvidia.com>
 <fd4341ea-869f-459c-a3be-a98cd1c8ba4b@amd.com>
 <20251007233931.GD3474167@nvidia.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20251007233931.GD3474167@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE4:EE_|SN7PR12MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: f65727d8-8a99-40bf-a851-08de06fc3bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TmR6YVNOMDYzUkFxUkxOQ3M5cFUxS0VITXM1QTZVMVZ4NG5LaWpnSElXcy95?=
 =?utf-8?B?cG8wYkswaHcreEY4SkF1ZnVidEtnZS9kdnZSVWo3c0VSeXZOSHAyR3MrR1Z2?=
 =?utf-8?B?T3VEcFN1eXo4ZE9VODVjVUFVbXFHRmJzM0ZjMEwyUFdWZmJhYTZHQUhKZ2Mv?=
 =?utf-8?B?NU14SlNKMXlxdkp5QkVYVURaTFJET0drMnBMZURCYWNzbVFPTTNGeXpKMjk1?=
 =?utf-8?B?eEtKRURHUVQ5RTVsZC9YZEN0b0thMnVSbGtGR2MwWm5qdzFlWWk1SXpjRUZj?=
 =?utf-8?B?VkwwVW9sbDV1QkJHbkpCR2NlWnNxS1NoT1JGNWRMbkdmRzM4YkMyVUpiWktO?=
 =?utf-8?B?Q1NGVjEzUCtLT2hhRTkrQjd0ak5XN3ZVelpwS0ExMjBWU0hVaUdjdlRlbG02?=
 =?utf-8?B?ajdWUkNac2ZHcHp1elNPbkFudFlhWmNvZXFwL1hEaVBLKzhTRW96V2YyclFI?=
 =?utf-8?B?SEFjaXNWS3dYdGNWdzFLSGNOdTRHZmZOeTBQQnR2UENwcjloOUt4VWFkeXJ2?=
 =?utf-8?B?TjlNQlJQUEJReEcrTHNOazNzMlRhT1Z2M3VXcU42TTNnUjluUUkyVytZSDVy?=
 =?utf-8?B?dlhIYURuNC9vR3pTeUpSMVZlWmRvR3VtV1NhWFFEY2MwZFI4dzFlc25wN1Fi?=
 =?utf-8?B?VllRdEtrREgvZmtlTzdLK0IyZnhLYm40RHZYKzFKb0MzenFPM1ZsMVRJR284?=
 =?utf-8?B?Y0x5eFVFRUtaM2oxUnhzWmFrSll0TmZpUDUvUGRzaXhuUEFSSWZoeVVXalB2?=
 =?utf-8?B?ekhOVndsQitRcjIvQTlCdXZhcmxFWDVmemMzR1dOVy9lN2c0STJYVlI2VzB6?=
 =?utf-8?B?V0xhQ3d1c3d1RTZCT2lmckpObU1ZMUlqL3piRE5qeEJYcGlXUmJXcXBuaUdw?=
 =?utf-8?B?REVuWnJVMVUrZmw1Q0Y5Yjh2S2hBUzIvUXNWcnJJMHN0T2JQVmdmNmlUbDEv?=
 =?utf-8?B?ekdnTEVxSFV6U3RQQWJqR0szM3JaSVg5a3VoYWtYa1VsY2hmM0lRelJKc0lz?=
 =?utf-8?B?WnJTTW5uZ3NicDNqbmgxc3M2aHpneGc4VE4zRGE1ZCtGRkVqNlR5ZU5KMDky?=
 =?utf-8?B?WExCMmgwQy9VVVVQMzllaEplN2E3YW1lZnpWNDlCV0xLL3V2eElKeS9zTHRS?=
 =?utf-8?B?d3Izd2Y0d2hvUGhaUk5sMk1ZenN6NlJvdEFTSitaQlpuN3hsbWtWUTMvWjZy?=
 =?utf-8?B?UVowbUhYNFRjcW1BdWViSUNsTUtiNDVUWFUzNmNsaGdnNnR3T3NMZVRnbTNJ?=
 =?utf-8?B?U1czOHcvT1FrUUJ0eXlsY2ppQVcxVEFTUDc1SDNDVGxXNy9lN3dGa05US29S?=
 =?utf-8?B?Q3JEY3c1YmhGYTg2am9qclVreHFMY3Q3TU4xN0YzYWNSQXR4OUhkaUpqZll0?=
 =?utf-8?B?eEFHcFl3Sk9jblpES2o3SG5jZG00R28yUEVsVFlBc2dERlBMSW9zTllSNkMy?=
 =?utf-8?B?RlUwSzJqMm5VcFRKd0wyaGlyd0tINnpwZGxRR0svRDdDd3hXZVJOZkYzVHY3?=
 =?utf-8?B?NjU4REZLLzNMRndpWmxGMndRaFkwZzUzWWdhNUwwY1BON1FhUGdrdk5zdmZ3?=
 =?utf-8?B?Y0lLLzd2dGsrRFA0VXRiRHlmWHlQajJ1dlpDbXVUOHp1YVZHTGhjU3hqbFFK?=
 =?utf-8?B?WHBZbTZ5SzRNWmJDeGJadVc0dkphQ2djWGdacHJwQVh2L1JoR1JVcUYweXNF?=
 =?utf-8?B?bkxyT2ZMeFVoRmtCQ2ovZDJETWdaS3RySnNmVGRVYnA4d2VjT3djd3ZYTGRW?=
 =?utf-8?B?ek1KTVl5cWZFcWJnejlVR3NrWEJpTm85Q01Ja3hVYkZ1WGpZaFl0aWMrTysx?=
 =?utf-8?B?UmdYYVF1dDdkQ2g5MUNUNnBLN3lRc2pRcjByeEpWUFFQeGFCaGZYcmhSeUdR?=
 =?utf-8?B?Q0U5aldFZkhNS0ZzTnF3YTRUeGJ4VmZsYTBYZUkydWw2Zko2RUZKbG5oTUIr?=
 =?utf-8?B?YXJ2MGpibVBIYTFaWTJEK2tyVFg1aXgrdWc2Yy9sNStodnEzcHN6ZXNJQTRY?=
 =?utf-8?B?RisyYW4zMWlMaXI0dHhoYXRJY3drU1RZbkVid2dGYlNOM2VkalJYMEplK1p5?=
 =?utf-8?B?OFp1L1lReWpmazJiY1ZrUk5PR00wSEhPekJqU0lsb0cwcElmWHVoSi94Rkt0?=
 =?utf-8?Q?EfL4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 06:22:34.0471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f65727d8-8a99-40bf-a851-08de06fc3bfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275



On 10/8/2025 5:09 AM, Jason Gunthorpe wrote:
> On Tue, Oct 07, 2025 at 03:36:58PM -0500, Suthikulpanit, Suravee wrote:
>> The gDTE[DomainID] field contains guest Domain ID (gDomID). The host IOMMU
>> driver uses the gDomId and guest ID (gid) to index the Domain ID mapping
>> table, and store the host Domain ID (hDomID) in the table entry. This data
>> structure is required by hw to translation gDomID->hDomID to virtualize
>> guest invalidation command. This will be part of the upcoming series to
>> enable hw-vIOMMU.
> Sure, this translation is part of viommu
>
>> This ndom->id is the hDomID, which is currently allocated per-device to
>> avoid TLB aliasing i.e. A guest w/ multiple pass-through devices w/ the same
>> hDomID (same stage 2 table) and different stage-1 tables with same PASID.
>> IOMMU would use the same TLB tag, which results in TLB aliasing issue.
>> Therefore, we workaround the issue by allocating per-device hDomID for
>> nested domain.
> But this is what I mean here, the gDomId should be 1:1 with the hDomId
> and here you are making it 1:N.
Hi Jason,
The guest will only see V2 page table when we are using hardware vIOMMU.
Since IOMMU driver allocates per device domains when it is using V2 page 
table,
the mappings are still N:N and invalidations will work similar to V2 
page table mode in
host.

Thanks
Sairaj
>
> It has to be like this or you cannot manage invalidation.
>
> Given this series is not really functional it is OK to leave a little
> hack I guess, but it is worth noting how it is supposed to work.
>
> It also probably means we should see the viommu series pretty quickly
> with a goal to merge them all together in one cycle.
>
> Jason

