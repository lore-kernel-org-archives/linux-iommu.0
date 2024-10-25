Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13B61D54FE
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729855398; cv=fail; b=ZoDMVQhtb4v7RhI/Yw+mB8D3DgyNPTYpvoIHxD+AAs7Vvhc5TgpCXmft9ymXZN1VGSLD9OEzy9sOmg5VQIO4FULLJTS5ECZbFBoVeWQpx+FZmAFaqg/GD22w9wX2wRIF4wMqj1lnDsfhYwE45c8T2S+riKci0q8Ujqz9gSEJosw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729855398; c=relaxed/simple;
	bh=XoGJoJhKa4x1ZumJlFyixYUwEsyKqav9O71KO7CjNp0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fCwTyixzvL1p8CzkcemKR1qq5/o3V9tfxMLTOm+eoZEDazqulGOvkSDNROm1jyyy7fFDN+uUuTfxSPGiSI5pkcWqLL94B37+UhMeptH5a6tEwIT7vA7iJJeabxgJZkGDQ9x018YDJc0B1gE9gjZ+m4fKD5kmkX0sWnASa14tOho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0Hq3xEBB; arc=fail smtp.client-ip=40.107.101.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0Hq3xEBB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0/oxKJ6eWuyVzsUu56Ucs81T3BKzhg1gdrQZFKobNjz7hfRi6gOlfRM/C+5lO3PjdqHcoOPwnYSudVQT2zCC/9AyDY7RHe/uuYXV5892SJYfK3fBm3DYvEVI7IXfqmcZq0Y7ZnOfj2JP+w4S/whxYD/OiwwtX6pT/xpkzoWSmw0KahU13fRjliQKiBOglY4lBeHgHW2Y7z9yDrt+qpO6nU/iX2eEko5yW8C+ohb/Z6en5YK9/ZLNTG4h/JZKbIIL9CLnbBvvVePFditwx6O30PUkPeJ9liuLzlVHbRSuVkQ53QuBcYD5xgP5cZ7/hG0f/U9m1r6UEK/mp8S9lOJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H22g6PN4O1u8+t8EAI7gm6YcjaK+ncXFQBTK/5tYpZY=;
 b=KbEiRvndojGBKU+4Qlq3oAIWmbNPqS/P9yAUv/3ZfF5g4k5+wwCmx+iZCLEHpe/scAHve3Dyv+wN19VYGvC1WHUT/bG6RhYdcDIYAsMT7ZkHQSAa5PYrD4kIzuZ5ZjYsLpFiPdXudrpQV4pDVj/bIrO6W/XzC3NTeOqZjGJ/FooUxgRSYWCF2Tpju7YAiiycHM6hSxslYx2b5wwWwHoE4l631Rc+YiRXS8RamaXLnDQGu2HIgyV17eKzFqEp+hjQ6wF9mMdXfnItLkCjSPGY6xLapjzv3aKk+s9JsT2N6bgC6li90jHAURAVDy7KcOL0Ef8b8ysh/IhNOZ7LOq2/pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H22g6PN4O1u8+t8EAI7gm6YcjaK+ncXFQBTK/5tYpZY=;
 b=0Hq3xEBBiNeYVFqmSMN4TRNI9StrYlItnpy7yE4KzVLOvmpnMmHGbnOczTxHtNXtYNlDtWjiT7wSP3Gc9feQWbAUCWl2AI8zQ7yP04A779GoWg3Qd+v/F0+YViqHiyzDNMiTlmtgfF3FBsraIuWj59wQZQEZ8LY+Z2Z+Lbrss9M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA0PR12MB8303.namprd12.prod.outlook.com (2603:10b6:208:3de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 11:23:14 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 11:23:13 +0000
Message-ID: <8e86f91d-c35e-4765-a2c9-296a5410e356@amd.com>
Date: Fri, 25 Oct 2024 16:53:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] iommu/amd: xarray to track
 protection_domain->iommu list
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 Joerg Roedel <jroedel@suse.de>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
 <20241016053501.97497-4-vasant.hegde@amd.com>
 <20241017131956.GM4020792@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241017131956.GM4020792@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PEPF000001AD.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA0PR12MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: c37a12a5-7feb-4425-0bbc-08dcf4e769fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ck0ydnE0ZXZxQzByMCsvaktwSzAvVUVnbGVkbFVUd0Z1QUFxUFgzMGprK2gr?=
 =?utf-8?B?NEVkdlI5SFlHTzNjbGlPd1pCdTNUY2IwT0F6RVFLeE43S1Q4elRhVnlCUjht?=
 =?utf-8?B?YXFzeUdyNVg2NVp1enU5dkpzbUswUkRWTHFEM3NkajhBMjZkb1M1RHRxMG9D?=
 =?utf-8?B?Zm9kUDl4R0Z0Mzg5L1dYV2tpR2x1cXp6eDRTdDdCVDliK0dYRUg5M2NZbHlT?=
 =?utf-8?B?RDZPVlRrSE1uUGVkTGxRYmZVTjYzU3lhMUszTjRibXBrNTZ4OFRIVk5LQzhx?=
 =?utf-8?B?Y28vU3lKRHprcmZ6MUl2dlFrUkhkT2ZnR2NqK3FIaTFHSTlXdWhCSDlCMmQ0?=
 =?utf-8?B?eTIrRUVPWmFqdGdKZ3Qydk4wZnlsVGxySDkySXZtL3pML2taOGpkWXI5WlNX?=
 =?utf-8?B?NTdtVVl3eHl2TUZINGJwU0w3WDhsalRYYUh3K1VUMUxsc0ZQU2s2cGhNVnNk?=
 =?utf-8?B?NnlXYWs5cno3dkp6dnY5NUdTZkZvY3pOR3hLRGVjMWsyOElnSU0rTDNESTNp?=
 =?utf-8?B?TStzNEFPd09zTjZwWDhKNDc4OVVrKzAwNGk0V0M0RFM4VVc5Qk9pYlNzUHdy?=
 =?utf-8?B?YnhPaSttQ1hPbWJvbTY3Tk1EZWNuWmVFdGE5THV0bTBMZlREVnhON0VDWm11?=
 =?utf-8?B?NUxFQXpvWmpvd1pvTmlOeWpCWklmMUxiMExmNGdXRFh3SWxwcFRZbzBKSEV3?=
 =?utf-8?B?U0JocERENXhNa1BIN2U3SkM0M3lQMjJaWlN4OGh6SWdTci9EYkdHdDEzbEFm?=
 =?utf-8?B?TnNYbWRZL2srMnlNTEd4V0FFZm9BcW45VHE3VmVydkFPQklMTkEwYUt6aWJr?=
 =?utf-8?B?VUFaNnFyaGl5N2RvZ3BRdnc0UEZEQjd5cE1Zb3BQcnFWcnl6V3NaRmRjZElX?=
 =?utf-8?B?TXJVRVdub0FUcThIWjBvWi9OWU4vV2ZQQm1ZK1BXMVpLRStuREw3d3pPRDJS?=
 =?utf-8?B?VVNYc1lmMzlLK2RQUitHTlRkUVdLTUpzZTNtNWNpMExIQ2VISDQyZHMzK0hY?=
 =?utf-8?B?N3FlK1JQY294Y1NXbFlUR2YrRUFuMG94WEdPMlU5Um1UM0pwTTZqRzg1S0sx?=
 =?utf-8?B?c2M4M2lTdWxNMjZNYUZjakdYbURza1FtSEc5Qy9NNnhEdUtiekdST2xwSHVu?=
 =?utf-8?B?LzdDalRxMkUwTExDOHZ4a2RiNytBL2pMT3k0RTh2aG0vTUNoSTZuSW10aWVV?=
 =?utf-8?B?YjBid3dJODFuMTYxeHRKOXBzbkI2cXB0ODlhNFVGWGF4dC9neURpbFZPb2pv?=
 =?utf-8?B?Q0w4UWFiME1FWTc1ZllNK3RLRTF1RldOdkhLU1JwQmJ6S1pQRlNWNkZ2bHkz?=
 =?utf-8?B?ZURrQmNBZmN4dy9HOEtYMVZjcndaMkMzcWQzWStHeTFpZzViNjkxVlRZYTVD?=
 =?utf-8?B?ZlpnRSt4bDRVODZFNzFQUEs2ZnVrajNUMFNhVzVNMkRWZW1EaEVVU0pLQjg0?=
 =?utf-8?B?OGM2OTlTcllkOWlQYmQ5TmJ5Mmp1RGh5WTBDbGpSVHd0bkVCMGU1Q1M2MlIr?=
 =?utf-8?B?T0NMbVp6REI4K1VwOXhIZ00rQzRvNVZUZHVIZUt1b0s3SFRyRjVFNERtM095?=
 =?utf-8?B?KzBUZ202RzRxbDRxSEZ5QldYZnB5aU1Ua2wwYkdDWEJIaGw4K3hzWUpIZEpN?=
 =?utf-8?B?VmovZVZPWjZoL3U2ckU4SUswbEVXMnhocUhobHNWM3hyRnlBdG5YK2FjZEFJ?=
 =?utf-8?B?RktSd2d6Z2hha0hLZXhzd1lZVGttODBZbGtOaklaQUJFREpGYk01Zlg5aURO?=
 =?utf-8?Q?h+bvWQfWUmk5atxW4NpfrsgnZID6cWm6b2llXfM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmY5bTNMTDNrbHBxay9LOHB0NFN4dndWMWhNQ0RSLzRiSW1ReVdCTkN3NzRM?=
 =?utf-8?B?ZHBPcGtnUG9Fbk5aWjlWQUp1ZEUyVkVoV2JpS2hMVmNNWDBwMVlMRTFka3Nm?=
 =?utf-8?B?aklBNUNleXBrd2Y2Sk9zSFN4aU1sNnVZT1ZzeFAxM00rU3hFd1lqcW9qWmpj?=
 =?utf-8?B?UUhwY0ZJb3ZnWGJOM2ZGSDZSQ2MzNHdPVmJQbnROOXgyL0RZcll2b3pDYjVU?=
 =?utf-8?B?bnM1OGJ5WmQ1N0EyTUwzTmNFQklMc0FPRlhLTExYazVZRzVSbnRNQzBoaG40?=
 =?utf-8?B?V2VjWUlPaXdQWDVtd295OFR3L2RNWjVrMTNrN2VpaWJxQ0g0ekpjUmZqdjVz?=
 =?utf-8?B?TUhGZll3dWxVdW9qSkx3bHRiMDRscTIra01wN0h5QUk1cUZQeE04Q0lUZmlB?=
 =?utf-8?B?VUc2b1BTMnBZMDFINW45ckVIdHQzMnFjNFRjWEVLNENlYmNLREV3Zkl3SGk5?=
 =?utf-8?B?SzFsVnAreXhNV3UxOWpnUVNHTlRQLzFGaUt1NDZBL2h2dXZFb2ZGNVo2NmNt?=
 =?utf-8?B?M1pQQTJwNlVTdmhpMHl0NzdqOXdJQkl3WEsvMUFDOWU3eThvdFNPb2Rqenp4?=
 =?utf-8?B?eUtydFQ2L0haQThJYnZKVmJFNGZOdlFxN0phMVhQd3F2ZWtncXBXOXozMkdT?=
 =?utf-8?B?YUhwczNqYkZSMXRCUm1pY2NHSWwwSWQvSys3eHI4WXFRY1h2R1hjc1RaRldF?=
 =?utf-8?B?aFVtNVlhNW8xczA1dGVPKyt5TWFKOENYbWV1dEJZamd3OVhjZlZpMndUMWdC?=
 =?utf-8?B?UUZBSHdBYXk2OFVoaHRTblR6c01xZ2szYTYrVXpLLzBDKy9OOG84UnI3NGwz?=
 =?utf-8?B?MnNLUVlqNXYwZVN0YSsvMUxRNU5MeDF0enBTS1ovSVdxVlRIZUlnR1gzSWZw?=
 =?utf-8?B?L1ZoaE9ycjhUcFc3Q3dTQ3M5eG9RdjRUUEFrTlA4WWFOREQrTDRDd1ZDZS85?=
 =?utf-8?B?L3Z4ZkliUWJNZVpRRnpSNzBZOSsyVDlLeEY0MmdvRExnNVpMS0c5WU1BUHls?=
 =?utf-8?B?ZElFbVdGNUpLTXJSbG9lMUNSZ0h2aGhIOEhsQWhRMTBleHZJZnJCUWMzSVp0?=
 =?utf-8?B?bUUxVC9sU0RUTTFOcE1GMXBoaXZmVzFqNFlRbjgvU3BzRHhvZTZTVHQ4TUk4?=
 =?utf-8?B?ODA1VTJJTzNseUJpQTRUUGhRNDlJQ3FsOHNqY3ZaTGx0OERLbHNWVURUZ0hs?=
 =?utf-8?B?cDJKOWhTRmRLNkJBVEZHZTBKZW94MWx2bFZUSEsvU3lBVTc3UjAzY0RFdE9i?=
 =?utf-8?B?WVhDL0JrcGJDdUlMUVpGZ05UMDJYUXd1d2MxZTBlTEpla0srVjN3dkdkVWQ2?=
 =?utf-8?B?U3daSlZWWTNmT1p4UVVYMjU0bTVzQTEzUFkwOFNMZnNmeGVxOTlnMGZlNnVr?=
 =?utf-8?B?ZmhBU2VQSjdEWTVmRFNVb2tCVGEvVUZBdzNLYlAzOXFiVEV6RG5aMFRlQ1I1?=
 =?utf-8?B?ZjJOdmkwSmFPUG1BNWpqNW5pZmtiUkFMcWpyNjFpQVJkcGllZVNqaFh1djZI?=
 =?utf-8?B?Zzc3ODBQUEVsZTR0UTAwRFFIdHZFK1A3d1czaWJTcWtuUlVRYmJhY0lkWFF0?=
 =?utf-8?B?eXUwWnNZLzRicnlKWFJSZzYxckRNanJ2c1JtQUdaWnhBQU9VbHhCNXRiN3FT?=
 =?utf-8?B?NTU2TUNyNUQxZjl3K3VxYlFhS3lSZ3FoQVEvZWlEN29vWjg0cmJjWXdTc2cw?=
 =?utf-8?B?STk5THBVM1c4WEovbHBZdlk4SXcvMUsrV09OM1hpTHJQWFNXaW9wdTlyZ0JO?=
 =?utf-8?B?OXBHVEswaDRzRGdMR0JFemh4d3VqS0pkUW9WMUo4a0pPTmY0R3V4aHd4TUox?=
 =?utf-8?B?SDlBVHpMckl0YUoxWWpFT2QzUSszVnZnRGhheDNyRjZvdEdjOUFmUTg5YjRD?=
 =?utf-8?B?SmFwU1dqQ2VqRkJPS3M5bE5SSkhVUytWTENtbEpvM0JNS3dKdWlwWTREY2Fj?=
 =?utf-8?B?UVhUWmNqbi9hY21hcDVFejdCVlQ1UGZFOTNVS1M2V2xETGFEMTZOR3AxZjND?=
 =?utf-8?B?Tks1OHcvaE5pb21aREQwdWQ5MWp2V1lwN3VEa1hMZHlWK1pOZWtkRTQ5NGdC?=
 =?utf-8?B?NUhDS3lWMGZ6NW16NlE0SXRtem9lU3pPKzkvRFZDdytYdm54NHVRRERVcUEy?=
 =?utf-8?Q?HY5t4bmZQ3pk0yXO5apKYNmJQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37a12a5-7feb-4425-0bbc-08dcf4e769fb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 11:23:13.5828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cjYYLGC1urO2zfFN0Y3VIp7jIZtBsevyueSFaZiwigSdAMR4TuGdfOp2TgpNvV6nrb4GM2N1yVcmssICDwiiZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8303

Jason,


On 10/17/2024 6:49 PM, Jason Gunthorpe wrote:
> On Wed, Oct 16, 2024 at 05:34:54AM +0000, Vasant Hegde wrote:
> 
>> +	/*
>> +	 * Devices of this domain are behind this IOMMU
>> +	 * We need to wait for completion of all commands.
>> +	 */
>> +	 xa_for_each(&domain->iommu_array, i, pdom_iommu_info)
>> +		iommu_completion_wait(pdom_iommu_info->iommu);
> 
> Please add lockdep assertions to all the functions touching the
> xarray, the domain->lock must be held for this to be correct.
> 
> Some of these are many nested function calls deep from the lock, I
> didn't notice a missed lock but I didn't check every path.

Sure. Will audit the code path and will add lockdep.

-Vasant
