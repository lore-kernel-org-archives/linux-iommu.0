Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF8843A7EB
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784108818; cv=fail; b=RAMXpncwTJpoiSTrwa811fL+q70rmYzVLv6PkVaTN78Y67Nwy+bN7gkIFiEYRsr7jpJdQHzfI5IsWkWuyPZTr5A/JD+kih/NGl0+IWBxg2YgwymZnJNmzbQW0528UiB9rVxLxnlPnEJS90pz+iy7CyR1sdSOPohFKA6UAzECUKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784108818; c=relaxed/simple;
	bh=EVw30pnH5LhbwxArHHXVyr3GIeH4BxPVBWglGAoW+Dc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QOKETl5TwDUt4eDwcaxkpKHzzViJvCASxECgkCIqqInFzgQJpEzC0AzqVBF7P+PUAM92xcQWtnHYXZSJyUlV35Hkm9TOYMfSYoDyY4CDnVEygs3wRR6BeqvnEzgoyq5V+oBszusCLDBIJOu9Rf3kBlU0ssFEocW4fBZBnK/mtDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wWynOmgv; arc=fail smtp.client-ip=40.107.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wWynOmgv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihnwxKPFsWy8Q8FsUBP0X5Bm120vH96fL/pzuHm8lxLw2u02fbL/RpMS5NvOIUBfLpAbqtAJqXcHlZagabpoQkGTcJYrmnNL1p+wzpgmeJeQYOcFdZ01ouZ5f62zq6d5Yf5nJ7DdPUaBcPOl+CLj9DGKgRjZaeTTQDdwJSUOBIJvsDZRI2+cqso6GLOzrCXIdeYGE3DWv8Phy/W1pNLHvTqmpQyg5gwN3hvMKE0sUN33uOjIA2og4Xu8/Ok1ebDX97/N965LHoUWEnzUtclxp/wBwdwID0yJQZoGbJMvt7dMuKhFLYIwWyAmaYkFK8vy98nkQHwSaoXJ8PTkd9TdoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlFqJf+SawCaGJRvMwIsbdvdNdptWsMWO8itwAkbE1U=;
 b=kofF/LFYu87FeLfPbcbpSXF6WSrrLb54o7UzCUcUWev+S/2xyBa7tx2SBQz6B2I7kLa0+dO8SXj/2hVkt1+yd6RlM3gm456TFbU0t5y/L02Y6IfBlNv9E6BKZDQ8cQi6sGdgxnVOQ5EiYTH+4YKCEnAliaCUCS7relN52DBs2CBHSpmU4LIpgWSL17geeoF/61ZeesrZUFqYRij2I2fOFqHAGgLhe5GEuRZqyhc8OII5/qDcBrppcNJ5fV8iYAS7Gv/D/NhB9hDA7cyvSmeCMrQ5mN9fxJ/JVNznvoc7ZyhR2Sos54DK+cqIR0jCU9jx3LPKXwJSgQeEolIO68xxng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlFqJf+SawCaGJRvMwIsbdvdNdptWsMWO8itwAkbE1U=;
 b=wWynOmgvi+RIGPyqU9H+AJ/AczEJaDT0kmwYMefqzUmLoS4+VRT9LW296nw9qFnYBjM1UlKWorRUsLk+LHmTZ9DMqGqAx+aZ2+I/kycF9zsD/hrL0m/042uGAVx4uYhN/b10cn5mxRfO/5vPBqOt6bLmlScFHXZMqNx0HoOQnIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 09:46:48 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 09:46:48 +0000
Message-ID: <912c78b9-eae6-441d-9db1-aaec33cf96cd@amd.com>
Date: Wed, 15 Jul 2026 16:46:38 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/22] iommu/amd: Introduce helper function for
 updating domain ID mapping table
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
 <20260629153535.15775-18-suravee.suthikulpanit@amd.com>
 <20260707143250.GE220801@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260707143250.GE220801@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|BL1PR12MB5732:EE_
X-MS-Office365-Filtering-Correlation-Id: 7332c3ed-a886-4327-10fb-08dee255fd2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	27TIlutibUwuqhtQmJgs/sznJFAy9WUN7gPUE7R7aLbinSD3918wtBgQGH2eDmDqcsujZH56U7gSothAKxfOi6F4CvkBv4jyXHKSXh7sgYxOj3vDb3Li5rrVPCDp3mdObfTFytgNEocEhJhEcXR1WhVhkUPWQkvqYLMW561+QfhaZYeYcLwNyngIqBzvng15WJ/YpR1H96pMXpqGDyI2kk/4vJCxo4WA5Loi2TQpkWIqjdoaNG9pJu5RIv/DGea3DoSZ4L2rhA1Q4qXyh3PtZvsnOdSOVSTVa6ynIPPw61JgWeVKmO+S1CYhubuHqIT/GP0sn9tAzwg7bKMquJ3csy3KEYctE1dkvwCI6EGKk4JSeCpL0rISn2Hs6Kt7p4S780JURTnOCu7V+ZIyjtH7oWkG3YitnMh9KQ9va/BJ+tsiDtORn0jPm1fn/pwyJWcuo0fWKcusVyib02H1iEXyXhOpuFu/afoHfnhnQjlwxV+8/nZuqTaNXXdrbz/xy1u0ZGQYNczWPDZQfHW+5DuDGKRrKXHvsTtnJOVFbYkafsT+Cah2/Q77427QLuJ8dMrFI7AoElUFiI7P4venhiTQUNK/RnK/7/z0KqNxnnj8EOUNGiYvXcvbQ6LXgpXwZMyeCim4r9wmPSzLKBcbyJPT/aD2HKa6Vh+K/N2YTwXf7jE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUZRUlBDemhwNVh0UnpLRTJXUGFMSXREeWNRZWxSckZBcHBsYmVMQjBoa2pn?=
 =?utf-8?B?SnJMYnYrZGdyWjlNSVIwb0NLUGpDSFFtbWFRMVIvam1lMzlNZ3U5TGVRRk4z?=
 =?utf-8?B?N1NVMDV4bzJuT3dMSTNObWRNelQrQzUwajdVTlZqdmF1K2pqRXdXRGp3QTV6?=
 =?utf-8?B?YXd0SEE0NXdseUZPNjQzRlhLZDhpWHgxcUN6emVtK2FuTkVsUnZsY1JQYmRy?=
 =?utf-8?B?ajIxSDBSWXJCK2VQYzFpWGJ4aXBBUDdkVjB6RForWXFHalQwOHBtMHNwc1I4?=
 =?utf-8?B?OEYrVTdZR29ya1FxNWxXUStJbnpaTWt2Z2MrakZrR1pmRGl0MEhrTUtWQzlE?=
 =?utf-8?B?LysvRk5QOXJDVGd3MnVVbndDZWhESHNRcFpxcWwyWDMyVzNvT0dhZVRGNWxh?=
 =?utf-8?B?N3RlQTVYNzhvNWRZb3BTNWFRQ2hiZnNsV0c2U0VkOFRZSFdVQVU3cnkwQVdK?=
 =?utf-8?B?K1VkRTM0TmtGOWo3eTJ0Z2JNb015TGRTSU5tVEFZTGN6RWlNMnczVDEzY05C?=
 =?utf-8?B?bFQ3YkpHclJZVmFQQVJSUzY2UDd1RzViMktZN2RtWGFDTVV6L1dDS1gvamhK?=
 =?utf-8?B?SEdWalY5UjVpTjRkOG14Sjg0S28xYVhpRmJ4cGZablZTaGpkNW0zT1o2d1B4?=
 =?utf-8?B?WHlLNTY4S1BHNzRYN2ZmWFlJaTROaU8zek1sNnBSVDVnTERKeFN5Qmt6N1Ax?=
 =?utf-8?B?OEU4cVdLZktWN2JaQ3lKNWdqeUUrbGJ5RVJNQkR3Zks3OGdIYm1QMGpMWFI2?=
 =?utf-8?B?OVF4UnBMSUxqeG9oVkZ5U1p5STNQenkwQzRoLzBBNkZFT2RLYnRnZzJnZ0Fm?=
 =?utf-8?B?ak8wMksyb2IyL2JSQThvZnd5K2p6UGRNSkJ5QTFseFplNGpGS1BreEVKNmFS?=
 =?utf-8?B?Wm5odlQrWDdiNFIyZXpva1RnYzFZclAwdk9aUk5nSnNpdEYveVd4a1lUOWxr?=
 =?utf-8?B?UWg5ZzZZUHpBbVhWdnR3N2JqaENqVVF0YTBGL0t0TUJrajQ2V3I3c1JDS2FD?=
 =?utf-8?B?bDdyRFh2RnJVaU5OVlMvUWxOdHFaQ2lUamppS2ovaFhkWlJoZnN5S2RhbVJQ?=
 =?utf-8?B?STk2L0U0Z09NUjAxa2JnbG9zSWZkN2xXUU8rdmx1a2FmUWdIQS9NSmxuSWl4?=
 =?utf-8?B?MzVIbUNySmdTSGRxeENQenNaaGxVVWY0d1VXNVM4QU1vMG91Y0xCUkRXTSt4?=
 =?utf-8?B?TmNVZExwSzE3bVpFU3VNQUlFUStoM0dKOGRUQkRQM3FRQ3I4VmVYenlYc1ow?=
 =?utf-8?B?Z2FGWHoxbVJ3ZVlGYms4b3pTN3V0WnlsYUROd2lkay9YVE1BZmZrb1E1ZVZT?=
 =?utf-8?B?N0RRZHc5eEYxQVlrQ1BsajVyWCtEYlZZZGFiRng4dWY2UjdZb001cHFubHJM?=
 =?utf-8?B?NGJhdzNyOGNlMmdlcTR5WDJvY29pZWdKMkhkK1F2amh0UUNGcjBRZEtFdmpy?=
 =?utf-8?B?QTFCQVlpTmJIQ2xzQWpxM0JmRWJmY0ZtVUE4TFd5UTVWYnVMODd6Wkc1WDN6?=
 =?utf-8?B?bnZ5L2pmOTRONVhzSkN5U21McnFjdDg5bUU3c0k1L3hrV3Iyb1kxU1V6dFpk?=
 =?utf-8?B?V2UzeXUwNGtHSGZZQ0NINSsycmRwdU93SEJmSk96aDkvYWlML0dGbzhOOHE2?=
 =?utf-8?B?RDFod1c2UG1DU0NXN0VqVythTkQ0QnhKcU5VUzhHWFdONG1jd2RMT0ZkMTZ2?=
 =?utf-8?B?eTVzVkIvQmpMNzVmaFFXOHJJaUFkMy9JSHhHWjdiaUxJeFhTTmpXcDJ3Y01Z?=
 =?utf-8?B?SzRhNWtabzBMN1d2eWcvM0hUUWQzTEZXZ1RDZ2xDdnlueFljN25LYUhHTXJq?=
 =?utf-8?B?TGdDYm9EUUxiWDN1eE04NEJMeGpGMFRubGE5dXVSc24wL3o5dEl5WE5jTWNE?=
 =?utf-8?B?WXhhbzR6bWJXT0hwOGpzb2FHdmRGeEJtQm1uU1g0ZHB4T1lOTFpyNTZtc1Z5?=
 =?utf-8?B?UHFTT2x4dCtFdkNQUDAvT3F6OXJjUTNrU0pxclBWeEJMR3JmR1UyQy9TbmE2?=
 =?utf-8?B?WThTQjV1NkJCVW9ZV1BCZHgxVkZxdXJJakY4YUdHME00MklUcitRWnVPalBS?=
 =?utf-8?B?ZEJFc3I5ZlI4STlVRzRNZE04V1RQQWFuWDNYRHJZaEdTZmlhTHd3R3ZRU2Yr?=
 =?utf-8?B?M0wwZ3B3N3B4WE1tR3pkZUtxZHIxRW04MVBrRzdza3lBa0xDZE9NYUl0MjVP?=
 =?utf-8?B?djREbXRSdVJhc1l2eFBOY1dMTmUzNjU4NzIrVU0zUnAvOWhxVytUYldPV2g2?=
 =?utf-8?B?Y1JEZThBZ0tCK0dZMEw2WUkwdkdVU3BsaWErZVQ4WjU1aWJlbWNGZjBHSXp0?=
 =?utf-8?Q?gOHYKXkJLHA8YZzN+D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7332c3ed-a886-4327-10fb-08dee255fd2b
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 09:46:48.4372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ce9B+QhpWFh7CVb2JXmN6lJVhvbpJ7F8opE9XECtxU6NCcLUxtAY0BTK5aeJmER+nGdqHOVhdAVljbCy46RImw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5732



On 7/7/2026 9:32 PM, Jason Gunthorpe wrote:
> On Mon, Jun 29, 2026 at 03:35:30PM +0000, Suravee Suthikulpanit wrote:
>> +int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
>> +				u16 hdom_id, u16 gdom_id)
>> +{
>> +	u64 val;
>> +	u8 __iomem *vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid);
>> +
>> +	val = FIELD_PREP(DOMID_ENTRY_GDOMID_MASK, gdom_id) |
>> +	      FIELD_PREP(DOMID_ENTRY_HDOMID_MASK, hdom_id) |
>> +	      DOMID_ENTRY_WRITE | DOMID_ENTRY_VALID;
>> +
>> +	writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(amd_viommu_domain_id_update);
> 
> Why is this exported?
> 
> Jason

This is not needed. I'll remove this in V4.

Thanks,
Suravee
