Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21501DC997
	for <iommu@lists.linux.dev>; Sun, 29 Jun 2025 05:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751175775; cv=fail; b=cHhBbUE4y+03lyQacrpAEv/j99/bWM6gRp/HXB5ditam/n25jpMTtjz2BGbWfXlybMrYu7LxoGJyk6+oYlR3rqkKUccis0hHBuRiq2Rb7kVNJKaVzmNHH1Z4Oxxz0G9GpjqFQmJBp9M40GKsgUmo3EtH4FzHLRVELXNkguPa3Ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751175775; c=relaxed/simple;
	bh=PNkeHGCI2+EkkFYC2KZriBg7ps4AcRL3s0bVejqQyl0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c0T1hf5jDg3LEwAYWGZ03uaHme4//gPvH7r8JN4avMPptJLS8EeyYc1xfS7U78RPfOIR9yvpDMKXPtcuSoyU+O9D0QuR58kKiSlVQaaWgWWalN1RGgV9JI+rZhGBeayHAJsJjZEyIO5WU0exdzduAOcIK2v1I/h6q5TpdYKVXhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=chzoPw8r; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="chzoPw8r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMjEcrkH1e1RrZGLvdUEmuNxL+QKiaGX3Tt5cGy+g19NYyVpWp141GpLQFQb4qUlCDr1yVNwRpcNaJaK2i3dvGKCYuLAKyGwBz1SZYwylComnuu/nrhrmBv7ORPArjUs0pAlgJz8smXpi4gP5o8DDDSmhXFFPcAuQdqg1Qt6XM0RYwTbcIZ50pdOsLxnT9y2TR3DGYt6d8Su1Ms/UstJCMjdN9qMrZ0kFV6tvV2upmVZHpi7ZReRtSVDSCw+SPwfIbkt6xDemNdiDhn8DV78lXS+YMbUn392ooIft6J80150HeYc3szwpCYpTd3GhK8de1WytkbkGFn0pHWFYwhoKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdFi18ZNwDlGYl0MfF5O2uoNR3I9/6tJ0ic4lEuwcXA=;
 b=HPUiyBFO7QnviBgDBorHL37xGeH4oud7E1dv4tbIIDVcLddpqIjlRWYt0LtibcJyRzxfemV0nyyGI+JoRGAnhjIiXu+jV1Ya243Y5ymswa/feW3Lx+GVvJQ0H9S2nwQcPwtrt5+x8Zrjn7yoeJGcH5QnJu930A5mosA6EmaTqMtiy7IERbtbkFoMOo1ZoZuDPKjOM1GuErk3Wa7CBICJHBto6xV+bJNdbMYz9Oqk2+xjLQ2Vb2pLnza9kkxpfhiLFL+zrlRrmASRtSJNzJmptrgc2MuCykq/mhUt5GL0NNQ4Hxk+2LY0FaTzdyKRTIwzQWVL+DufKvg87O+mY7IivQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdFi18ZNwDlGYl0MfF5O2uoNR3I9/6tJ0ic4lEuwcXA=;
 b=chzoPw8rinkFCUYVojjcXlpAgSfrhMmXVASRL8JAq4bexlxXLY6MuKQJJGyAIXxQYUIXYyjaUqF0zQka2+LLgWvLoQaLJ/+zFBocijcgbZtrIKSEIIOE+RHUL9Gv4BAQIEAPALcW6LEtdKIZWny3NSNX+vS2AWjLdIiGzkztUAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA3PR12MB8812.namprd12.prod.outlook.com (2603:10b6:806:312::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Sun, 29 Jun
 2025 05:42:50 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8857.022; Sun, 29 Jun 2025
 05:42:48 +0000
Message-ID: <6f70ae62-0f5c-4620-a9a1-4720ac995b08@amd.com>
Date: Sun, 29 Jun 2025 11:12:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/8] iommu/amd: Add debugfs support to dump IRT Table
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250604163647.1439-1-dheerajkumar.srivastava@amd.com>
 <20250604163647.1439-8-dheerajkumar.srivastava@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250604163647.1439-8-dheerajkumar.srivastava@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::26) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA3PR12MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: f500a75f-d5e4-4484-e010-08ddb6cfc78f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzlCYnpHZjJlWjhSTThrd3RpeHdHb21qZlZKVHpEVmRqNldwbit4OXI1SVZw?=
 =?utf-8?B?SjJxUjNLN1JMd2pLMzRHdm0vK0psc1VkczIydDBMc2JxaFFVM2xxTlV3VzNJ?=
 =?utf-8?B?VGdSMzJMSVkrYjd5Z0FneGdtalMrT1FveHlwQzcvVlduT1prNWo3QldkNldM?=
 =?utf-8?B?L05aeUIxa2FValpRTHY3NUdtTXlrSXhYbmlYQm5TYWxVc1ZBcUFEVUxzZVRH?=
 =?utf-8?B?eFgxOFpxelUzS09zQThZbXEvUVovb05jWk5jaVUwQmxoNTNzVElrL1dMRXIv?=
 =?utf-8?B?eVZ4c0VuV3NWWi9RVkR1QVJkUlVDVlJtTlhvaWVyMDhBK1NDZkNIN29sMHdq?=
 =?utf-8?B?NzRyVWRmLzd6dUg2ZDg5T3ptWHRDNU9CejYvN2NNT2xLOGtia0hGSmJCUzh5?=
 =?utf-8?B?dzlpdzFuTmp0czlqcjJrcHVteDlsSGlaZ2VCRnkzSUpDc0lGZDB6SzV6K3lN?=
 =?utf-8?B?eGJrUFQ3SG5CY2ZZOGJ5N0h6ek1YcEVhajZwcVI1SnVwUHFOWWRBVWp1MWsw?=
 =?utf-8?B?ZEJZblZCMy9mS2FSd0t0aGJrTXhxamJUaEJCN29yVFlzVnFlbzJwa0RESldV?=
 =?utf-8?B?Vk8zNWsvRmpnaDZTZ1Zma1FDa1huajNhdmpPL05Ob21wRm1keEdUbmgwUmxJ?=
 =?utf-8?B?a3hhOUFUbGEzRjYzRGxrSjlUaWpQZnRCQmRiUkp6OVVSNnZORUEyV0c0bDVV?=
 =?utf-8?B?eGx6RG5zRm9zeE9zWGtCTmFpNVB5RXpoNVlKbXpjM1VyYlFjWUNwMm51Uy9q?=
 =?utf-8?B?NlE1MktlSXhuTGZ6azdaUWJnZlhJaUhTbnZSM1lJaVJVRVV1UmRJMzZ1TnhZ?=
 =?utf-8?B?NW5TejZER2tGMmJEb296ZHVWN08rZ1h3TEVLL1RnZmQzeEdLbnUrZlRxdHZr?=
 =?utf-8?B?cjdzYTZOQ2RLUFVkL2E3NnZUUUovK0VKYmtXSnZ4Yk1UZTZUR3ZMdEtiQWdS?=
 =?utf-8?B?bFlPNXdsaDN0QkY2OU1nTExOdmw0N1hKb2czMi9ic0FmR3lQMFhQRGIwS3k2?=
 =?utf-8?B?WnhiaFF0VnZDeHR2a0dlWjBMekM2d1Z4cFB1NFFGNzVwZFZTTEJhUUc5VE9I?=
 =?utf-8?B?cmVSNml2QUY3aE1CL3B6cVpBdVJCYVlGempCRk1WRDZORVFwempWYkRHbHZF?=
 =?utf-8?B?WHNWWkFXV3VRNWpLVys1bzBsNExrMnhuYUFiM2JYcDVoVlVkUzdrVXU5Mmx3?=
 =?utf-8?B?MnhhS1prUFZCcjZNZlordlQwMFNZSFlsRXZEd04rdDlqaHg4VWNRaGphYmQz?=
 =?utf-8?B?aEYydTNDOUE4dDM3SjNnaHYvTmhzRHhQM0diYzRoS0s1ZDZKSFBad1JzQ3E1?=
 =?utf-8?B?c3ZrcEhKV3Z3a0FvUVBlT1JjRDkyWmpGU2pOQytRZFNGUm8rQncyK3IzTTdC?=
 =?utf-8?B?bEhIRlpiQzh2SVhWVnFGZmVQSkg2cUdIT000YzZONzVMQWlFT2tNcWRqNTNh?=
 =?utf-8?B?MTZ0VjY2cGM0NkN4RGp6cHAzdXNIOWg0QmJreWFZZWVSRW1ETlBFMHVzVlM3?=
 =?utf-8?B?b3pqSTdHY1lnUXoxWlJnSFFFckwzcEZ3cXRja29jb09rNStoMnRqdmtGdUE0?=
 =?utf-8?B?R2I1TnBFcUlxcFBjREtEZldWRUR0RmxHTHEzNkVIWGROTHl1UnhTei8vNTR0?=
 =?utf-8?B?WVFTRzFsdEdKcEwrL1JVbExzU1FUUG0rU2dvOE5BaTI2YlJkd2JSeGU0VVY3?=
 =?utf-8?B?OWJLakZCVzU1aEtSeDVOWEgzUjBnYyt2K050WnZRZmgvajVXNmFST2Z3WDli?=
 =?utf-8?B?TUdSdjlnZzVLS1g0dUdyUjNhd245Y2huYlpFckdvVDdoK1d1V1I0Y0Zzeld6?=
 =?utf-8?B?cDVvYmxycVRBanNaWHFEVDZlMzVtd1BKRzJTZ0NUMC9Vclh4TXBQQkVGTzh6?=
 =?utf-8?B?Mnh1cHJ5YndibGtBMVd3R2diakl2enhjU0NJaE5CSDliWWNRbXl6T0JCcXRv?=
 =?utf-8?Q?jV3gSgCNYv0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bG00THUwUjFKMHFEYkprb1lIMy84b0h3OTIxT0FmUkxpeEV6SEY2a1UvWk9l?=
 =?utf-8?B?bkJSQXhPbzdRSVhzc1JTdzlaZnM1a0RFRFV2c01rWURZaDFhMHJEK3lJU28x?=
 =?utf-8?B?Z1NPTVZ2YUZua21xSXY5aHM1OW44b0VCU3R0Y1c3dTV4TE16SHNVd0J1TDVB?=
 =?utf-8?B?Q2MwV2Y4SFU1SXJKRDRBVGFBb215a0NZU3h2QjZuOGRVV2h5dEEvMkJCUGFp?=
 =?utf-8?B?QUFGSlJrWThWUm9QZzRaY1psa0lZY21SME5CdUVPeDFUTmZSMWhXYWtOYm9o?=
 =?utf-8?B?YUtnSk41c0xaQWhpOUFBM3publgzcHBrWXpZU082V09DWkwrS2Uvanp0UnZV?=
 =?utf-8?B?bU54MEJlRmhnS0ExYzlIQ25xMEhUdEFBU2p0OG44dyszR2lrYU4yNzUrbER1?=
 =?utf-8?B?RnFRSFU5OEVZenlESXF2M05mQnJoUTJOVkE2MExxVUJ1QXduU1YyQ3ZCYzBK?=
 =?utf-8?B?Yk0xR3RaVTdpd0RZVkVjV3RiOW1KL1NhMDl5S1RKcTV6bVg0STZlUGE3TTZi?=
 =?utf-8?B?alJLWUhRQitJcDk2VDhjdTh0WitMekhTT2FyOXRwNWR6VUJFY0pETFBkdEsw?=
 =?utf-8?B?eW9HWVhoUEU4OHRjRENtL0VlWFV2R3c4L0pubkR5aTl3S2dKeUxIMVVaNmQw?=
 =?utf-8?B?TFJ0RWQ4NlpydzJXYWpCM1hodnA4UEd1cFVBYUF0QkxLOGprdW84RnhaUmgv?=
 =?utf-8?B?NDZHYjI4VWZ6bm9TN3Bvd08xditQZUZEeEptY29XVkpST1FQRElRbGZldCtj?=
 =?utf-8?B?QTcvYjNXVm8wYmRaSy8ybXpXeG04MVlZRDJzc0hpbVpzczgra0swelBJZ3Qv?=
 =?utf-8?B?NjFOQjl4RDFMR1Q2UEJpWGI1RmZrdHl4eURZeVFaU3dPczFsNHlJbVQwd2Fz?=
 =?utf-8?B?STNPbFhORlZtanNtY2tEZEJDcS8yeVFpa0FhZFExdkE1TTFiR2tLNDkvVURp?=
 =?utf-8?B?TnVkSUNTRHlyU3lKUXBjbXk0aVF5eldRVEhQSXlrZWVldk5RQXZ1TzJSZC9K?=
 =?utf-8?B?S1Q4WkdKTTI2MUMvcGk1YUpjeU9kQVZadjMxYXgrRE45TDdRYjFuUVd3VGU1?=
 =?utf-8?B?Z2YrYU8vYUFJc2RSV3RBVStEcXVEekNubG9XVVZRNlJRczVKQmo1enFzV1VY?=
 =?utf-8?B?YUpoVTFjcGZkMHc5YkczRUZWY2NSaE55NEV2clZCTmJXSTloRkhGdjRIbksr?=
 =?utf-8?B?MUtuZnZBV2xzbklXRkNPb2h2MFZpRjNxRmtuRjA1UG54bktSTnpUNUxZeEh5?=
 =?utf-8?B?WmZWRXdYbk9WTkppRDc2ZUROd1RZYUt5NFhqT2Y1Z3BLY29zUVhheitTNE8y?=
 =?utf-8?B?b1NoSEhsMVluWnJUcEJjVHV4WFFNWDdqK291dlJhVWQvcVlZLyt2NlJNRENz?=
 =?utf-8?B?d2pTQk1PN0NSREF4ZlhjMjhQWkw0TVB2aENyYXVoaVZGVHVRMDZIaklnTlFO?=
 =?utf-8?B?dWhQeEl6Z2RNM2FlOVBBYWN4UkJHcFpQRkJmUkdtdG0zWGo0cDhMbDhYVEI1?=
 =?utf-8?B?OGlhbWpPMzRHamhEZVFSTG5XbUJ2aGdtcHRCNEJtam01R2hxMU1ySmxBUkhy?=
 =?utf-8?B?TmFBaFBhVUtXbXRQZTJOTFh0b3duZVZYeDJOUDdHWUF6K2pSMFZrYkNiWGVO?=
 =?utf-8?B?aTRGZTE1UjhoQmNkaU9iTUxzcGxCYkNPZFphcmsyNlNXaVdZamRaOUgwY1U0?=
 =?utf-8?B?WHFNN2gzWFhkSUpMUmYxb1RZSmFHRlFiOWZzR3AzVlYrMW5RMExDdzFXdWFo?=
 =?utf-8?B?NnVFY1BUUzNZa3BEU3UzV1RqK0JJY3B0dlhvNE9ZVzN2NDJ0VEFxRlZPNmVa?=
 =?utf-8?B?VDhaK3VseGJ4cHQ3NGtkRnBSUEJvbjVwcDFSTlYxcjAvZXlRRDBVcDBzdFI3?=
 =?utf-8?B?SXRPOExFNzBicGE5aHJPVVEwalpCMVRzcFQvMC8raElLYkpVVTcrRWlpVGF3?=
 =?utf-8?B?cytmc2ZZMnNzRE1PQzNhUjgzTy9hUGZpMGNmcktVMXVNc2FENkJmTUwyeFdK?=
 =?utf-8?B?LzVqeHU1b0szMnM1TU9xQjZmWS9IQ1VOQkZaSFptWW12My9ueHBMY1hsR2pP?=
 =?utf-8?B?NHlNL1d4OUlkM0hPcDBBYkJyeGVFVjI4eE9CYjBoS0RSdTRZL0swekRMMnhz?=
 =?utf-8?Q?XFl19GawKZ2eWr2JJq5n6vPF3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f500a75f-d5e4-4484-e010-08ddb6cfc78f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 05:42:48.3405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w03QIzPN3TfLeUoKSDoXk0bvdUFiWE9mlxyuiAUeRBbBIQ5Zxivsa9c0Lkn6bxu0ZkIBI2Nzbs8SjNuY8CpYBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8812

Dheeraj,


On 6/4/2025 10:06 PM, Dheeraj Kumar Srivastava wrote:
> In cases where we have an issue in the device interrupt path with IOMMU
> interrupt remapping enabled, dumping valid IRT table entries for the device
> is very useful and good input for debugging the issue.
> 
> eg.
> -> To dump irte entries for a particular device
>    #echo "c4:00.0" > /sys/kernel/debug/iommu/amd/devid
>    #cat /sys/kernel/debug/iommu/amd/irqtbl | less
> 
>    or
> 
>    #echo "0000:c4:00.0" > /sys/kernel/debug/iommu/amd/devid
>    #cat /sys/kernel/debug/iommu/amd/irqtbl | less
> 
> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> ---
>  drivers/iommu/amd/debugfs.c | 108 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
> 
> diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
> index 38d3cab5fd8d..7a056ebcc7c3 100644
> --- a/drivers/iommu/amd/debugfs.c
> +++ b/drivers/iommu/amd/debugfs.c
> @@ -11,6 +11,7 @@
>  #include <linux/pci.h>
>  
>  #include "amd_iommu.h"
> +#include "../irq_remapping.h"
>  
>  static struct dentry *amd_iommu_debugfs;
>  
> @@ -254,6 +255,111 @@ static int iommu_devtbl_show(struct seq_file *m, void *unused)
>  }
>  DEFINE_SHOW_ATTRIBUTE(iommu_devtbl);
>  
> +static void dump_128_irte(struct seq_file *m, struct irq_remap_table *table, u16 int_tab_len)
> +{
> +	struct irte_ga *ptr, *irte;
> +	int index;
> +
> +	for (index = 0; index < int_tab_len; index++) {
> +		ptr = (struct irte_ga *)table->table;
> +		irte = &ptr[index];
> +
> +		if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
> +		    !irte->lo.fields_vapic.valid)
> +			continue;
> +		else if (!irte->lo.fields_remap.valid)
> +			continue;
> +		seq_printf(m, "IRT[%04d] %016llx %016llx\n", index, irte->hi.val, irte->lo.val);
> +	}
> +}
> +
> +static void dump_32_irte(struct seq_file *m, struct irq_remap_table *table, u16 int_tab_len)
> +{
> +	union irte *ptr, *irte;
> +	int index;
> +
> +	for (index = 0; index < int_tab_len; index++) {
> +		ptr = (union irte *)table->table;
> +		irte = &ptr[index];
> +
> +		if (!irte->fields.valid)
> +			continue;
> +		seq_printf(m, "IRT[%04d] %08x\n", index, irte->val);
> +	}
> +}
> +
> +static void dump_irte(struct seq_file *m, u16 devid, struct amd_iommu_pci_seg *pci_seg)
> +{
> +	struct dev_table_entry *dev_table;
> +	struct irq_remap_table *table;
> +	struct amd_iommu *iommu;
> +	unsigned long flags;
> +	u16 int_tab_len;
> +
> +	table = pci_seg->irq_lookup_table[devid];
> +	if (!table) {
> +		seq_printf(m, "IRQ lookup table not set for %04x:%02x:%02x:%x\n",
> +			   pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid));
> +		return;
> +	}
> +
> +	iommu = pci_seg->rlookup_table[devid];
> +	if (!iommu)
> +		return;
> +
> +	dev_table = get_dev_table(iommu);
> +	if (!dev_table) {
> +		seq_puts(m, "Device table not found");
> +		return;
> +	}
> +
> +	int_tab_len = dev_table[devid].data[2] & DTE_INTTABLEN_MASK;
> +	if (int_tab_len != DTE_INTTABLEN_512 && int_tab_len != DTE_INTTABLEN_2K) {
> +		seq_puts(m, "The device's DTE contains an invalid IRT length value.");
> +		return;
> +	}
> +
> +	seq_printf(m, "DeviceId %04x:%02x:%02x.%x\n", pci_seg->id, PCI_BUS_NUM(devid),
> +		   PCI_SLOT(devid), PCI_FUNC(devid));
> +
> +	raw_spin_lock_irqsave(&table->lock, flags);
> +	if (AMD_IOMMU_GUEST_IR_GA(amd_iommu_guest_ir))
> +		dump_128_irte(m, table, BIT(int_tab_len >> 1));
> +	else
> +		dump_32_irte(m, table, BIT(int_tab_len >> 1));
> +	seq_puts(m, "\n");
> +	raw_spin_unlock_irqrestore(&table->lock, flags);
> +}
> +
> +static int iommu_irqtbl_show(struct seq_file *m, void *unused)
> +{
> +	struct amd_iommu_pci_seg *pci_seg;
> +	u16 devid, seg;
> +
> +	if (!irq_remapping_enabled) {
> +		seq_puts(m, "Interrupt remapping is disabled\n");
> +		return 0;
> +	}
> +
> +	if (sbdf < 0) {
> +		seq_puts(m, "Please provide valid device id input\n");

Again same as previous patch comment. Please add proper description so that user
know where to input devid.

-Vasant

