Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797631F667C
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010588; cv=fail; b=PM3/uxt8mmNIsLHCdaQVJDkOLl5ocZuCeymVBxWxSQS5pOt2e6YUVfv8xnK4Omzk7sbkcgydL8v4vb3Cfth8mCcTL6NEqopYTv4nYUnot+YnGXiAAXrALJ156LNkKpm8G66U3qElg5VaH0i0KRKwLTCZ6MvejI6aT7v7WQlFD+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010588; c=relaxed/simple;
	bh=xrF7WSJDDd43/t5FXdlJy2exm7L3TMJxZ1++FZXQ8WQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X1sXOgZ/xOTfUeCEhXjjMPPGLz6ULzcZGKDoRVzjZTwqh+8Nn9hxNw0V65mMN73pW+//SDw9OwoWmXP8/38DHS7XpuqD45jdLrYILJ4sfPuqscpVXfDs8g+6geMkQho0uU1hXLWcaSlJgbpGmG21W5FxCy+z83r/OaJtD7Orn2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m3KV6niJ; arc=fail smtp.client-ip=40.107.212.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m3KV6niJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUPydAX8YF9EjxOalU66SR0e3CA3GtK34XlxROef0NrK+zmi84aTjOqlfUSh2npOABskP1VCXor0L9CWjHM7qr/aO9HdrOQwHwNstm0/7qSiOwb3H2CiIHG1BcwGd3Im9Y+prcPjDOW9YVBKmNdwaW5phDymgMnDUz/Ep9AbIuDnEHhqy3cGvITGdYdHInEop2ZDFuStNqxMTj3khse/texjWQv8BgiXn/EJA8yyCd4n4/btYwjcZTv0T+WSZCNtFQQfbkkxW0ejgYVIHRt0gzbxqS2u8NbxSvQShuTmC1YAwrjXHMT0EGMvM+faQRlvr1GH3QQ+fV2dN6/yRflH+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8sql7LBdGmrxzv9+rRSf/mRU4xkiGF9JzMRHEq1mWM=;
 b=GwnEcS6VCJk0X1YSGh8BG4SGdJDdKgYyTWTnxZDhHEfNjqlaXu2vwF8NgsyWBVWHdFm99HrnzkggvksWx+5Y1AYfVXrwHcu2oGcY13nrbTxcPXC26yOgRKq8vBUFtcw8FXgr86Lfqcuvt6p128Lg8igmS/u/x9orBE9kr5fk8GnxT2ne+vasHe+ZMgNMp53nA3VyvCTlLlfi0TQIlK5+osNgux25Y85BL1/07mwatLqc1Kpcm1DOBWG6EFC7hXp6rccSSOizZKwNrgz3NF47JequcovmWDPRaHQVh/kFQ9JZtUHFvd4LNwMPSlRBOmQuscfqomeGPIoIDYXI8U46mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8sql7LBdGmrxzv9+rRSf/mRU4xkiGF9JzMRHEq1mWM=;
 b=m3KV6niJ5x5z5Et2ZZ4wOswpO0QgmZ3Zx3MSD3NDXUt5UMqaTVQidmLhmB4vzvK9xagUuC+PUy8UmvIgGHtUccXi+XJtyNqGyxu8nzT9ZNoIRa7vrvYK0zQyePeuxxZpsUElk9jOcHRvqSCzMoE0mYxvPDPaIY0Q/32qpCTqMvE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 by CY8PR12MB7514.namprd12.prod.outlook.com (2603:10b6:930:92::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 16:43:03 +0000
Received: from IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be]) by IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 16:43:03 +0000
Message-ID: <0a59a31c-4082-47ec-bdc3-ebdfaf9eba8b@amd.com>
Date: Tue, 15 Oct 2024 22:12:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] iommu/amd: Reorder attach device code
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com
References: <20240910065812.6091-1-vasant.hegde@amd.com>
 <20240910065812.6091-10-vasant.hegde@amd.com> <Zw4rfyNCm6tgjdYI@8bytes.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <Zw4rfyNCm6tgjdYI@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::11) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6043:EE_|CY8PR12MB7514:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b685df8-17a9-443a-b4e6-08dced386f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wk5SZThKenorV2lkaGtmcWU3UEZUdE91US9tU0lidkU4ZmV6WkNSNCtHSnRJ?=
 =?utf-8?B?eFp4Vks1dVNmbjMzdm40SDUrQWVPWkJiVnArZUZxRXhTQjRVN0FjTEl6T2RU?=
 =?utf-8?B?cndoTmdiN291a0FMdXNscWUweXhMdldzOU04L2lLK3VadDJiMGFUdUNSUDgr?=
 =?utf-8?B?N0lUYXI2T0M4VGhIRWJkbWI1NjQ0NHhtQWpOcGNWYU9tdDdNaGpnWnF6UUNx?=
 =?utf-8?B?ZXo5OFdSN0MwUXlzZlNYakpNbTZtbjltM1h6R0dDTFFEOXZFVGpEdVZjL1dI?=
 =?utf-8?B?YWljUjNHeTl6cittZnUyNDNKWW9IcUZkRkUvYkVpaWxrMjdCSmphQkJ0UXNs?=
 =?utf-8?B?SE5wRGRyQWZQOGdBNWQwMzNZK0Z4Ky9FakFWOFo0THhOQmhETnp6TFl3aytw?=
 =?utf-8?B?OEFielY3OHdHQ01aUDJDYUNjQXd6a1RJdDhtMDlQOXk0Z3dpbHFONDAzQWpi?=
 =?utf-8?B?U2dnMHRuejljcG9nR1E4QkVDRVhpbVAzMjdjNER4UTcxNmkzT0plalRFMURU?=
 =?utf-8?B?aWUvakNZc1NnN1ZSNTNvWmp6ZjBHZGd0bk05UFVYTVJQNHV6TWxkMHVkMVMy?=
 =?utf-8?B?c1VEWGZobEdNMG03ZmpWTm9KNUZUT3hsWllwY3VGMkJ4SWgyVDhIZHNMNm1B?=
 =?utf-8?B?clcxWjNENEFXYmg0RWt1NjlDQjdhQWRLcUUvb2dwcXVNT3g0eU1mK2FuWVdF?=
 =?utf-8?B?RksvT1NzV2dmem5Ma1hsdURyY0d6anhFNi8xcEZWR2RzRkN5dENKQ08yb3pW?=
 =?utf-8?B?RXJQY3NEZHdEUWFMeVQ3ZFo2djF3MFE2blhyditvekdDbDBtQjVEYkFmaGUz?=
 =?utf-8?B?MUZHb0lJTkF1Mmw3UVU2SlJmdGRaNnAwYkI1WGFmNTQwSWNqZWNlcWZKcm15?=
 =?utf-8?B?N2k0QUd4elFoZkhNdEpramJSR2NPUUplR3hUNllQRHNaZG5lbWlpWXpiOUNS?=
 =?utf-8?B?ZTlYNGs2VHEyWkVxK05ra0tmL3FVZ1BYSTB3MXBVUmFrNGZsWnhVVEI0VzFj?=
 =?utf-8?B?QzlMcmc5SXJXZXI2TCtzNUhLbFlGS0RNYzVlNytNaFpKTWozRlFiUUZaU2R6?=
 =?utf-8?B?dzZYV1l6blgycVJKQm43YW9IakpYS0dZNFpCVCtUTDBsK3lZSU15TjBUblVm?=
 =?utf-8?B?RWJFa25LRXppS25xM0gxUzFZaERJWjlyN0YzOHFwY2wvNXNweSsxKzIvTlpS?=
 =?utf-8?B?cUpUOEQwT0NhTnNTT1dYYWZyOHZjcEMyT1VFTU9wZm9Dd0VINVFHcVhXbyt1?=
 =?utf-8?B?THdPRnp1cEpONkR4YnlyN1BHdEtXVHVyZkw5dW5FOE80cEpUZ3V6ZHd2ZVgx?=
 =?utf-8?B?T3hjMUNBRTUra2gyUjY3bVRFUEVvVkVvNFBkZE9PMmpUWHJOZkE1ZHhRTkZZ?=
 =?utf-8?B?NFFpZGNBQzVNdmlSSGF4RU05TmlTZ1FJRFpyQ2V0cnJmVVR2Nm1KYmNOd0Vn?=
 =?utf-8?B?SkhIV2NhZGR0cnBoU2k2QVJmdDVxYTUzR2lpbno1T3RBZ09jb0drVHhBMmJz?=
 =?utf-8?B?Rk5XRk1iRTRMQzZsUi9kNlh4TlFYU3cvcWkxTmE0OTU5UVQ2WERkQ0tuVmF5?=
 =?utf-8?B?bEJyWjNyT2RQQ3IyQmlUMEVybU9SL3dZZkxjWjJWS3pTN2ZCM3Z5OU15NEpK?=
 =?utf-8?B?ckM2REl3aXlUcnlzcWUwRGxtbHZYU2pTdkJZMW50cUFKRm9tL1ZodWhWc21j?=
 =?utf-8?B?VDdCSlJpRFB0dklzM1I4akZzSXRlbStKQW1uSTBLc3pGWmJHSHpLVTBBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6043.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlQzeFFTWGdxYmRrdG5rL1pMRHB6cURROGZVWk04ZVRFaFVwRmtvaW5zcy9B?=
 =?utf-8?B?RkF4SjNYUTE2MUtQRG80M0xjLzFRMmR6MkV2ZW5hNWpYSnpmTjdONkQ3Rjkz?=
 =?utf-8?B?SzdtZjY5SDBUOEQvMy9sbW1veE8rRHBYeVowbmV6L1h1SlArTVNMazVIWUc4?=
 =?utf-8?B?RE9IMmRUdEN3ZXZ5QVlHR0cwTHdxWkUwcUtMTjNOaGlsZlo3c0RlbDlzd3Vo?=
 =?utf-8?B?UDVTWGlnMjRyUEhUTWs1MGR3VFFST25xYmdMTnAzelJ4dlU2dTlqTC9aSksz?=
 =?utf-8?B?UjZET21oalFUM2pwN2tJcHU1ODJzcC9uU0ZpUlp1Z1Ivd3lNV1loTWZ5RTAx?=
 =?utf-8?B?Wkt6RDZ1blU4Y2JyS1VjL1ljUEtpQTdxN2JPV3NqRmlKemZ4TDNTL0JaMmk1?=
 =?utf-8?B?VlFZcDE0ZFpFbmtYK2cvKzZwb1hKVHVVandLc2JKZXZCSU1vcy9MaGFmeklr?=
 =?utf-8?B?cHRmVkdraTBOSXk2aTdsQmh0RU5RSTFHdlliaW5jRjk5NWxnazhWUXlMVkFm?=
 =?utf-8?B?U09TdkE5UlpGanYxLytNOTVreTNYelA2SjN3Vm1qYnZKUGNTR3FSbG9weWpM?=
 =?utf-8?B?Z0UvYnRlY1I5WDRzWmd6cmxpWEZOSy8zd1RaNVhJaEkxMTBEYkMxTU5KZUtn?=
 =?utf-8?B?TG85ckJqZHJsTUE5bmFGWkNyTkt2R1h1L0wrcUtMZi9iMWN4Sk1VNXhLMEpV?=
 =?utf-8?B?aDdxbGxPWGp1WjBHRkZoOWJ5Qyt2YkdQWGJ0VlZBVDJhRnNxaUxKTmJOVG5Z?=
 =?utf-8?B?eGlMYVFRYmd3ZERzbXM5Sy92RHZ4UzlYcVdCa3F3NzB3dUdOMkdWdElpeGU2?=
 =?utf-8?B?dWZJYjlUMVRBbjM1MVd4Z0x4TGx2WSt4UWxzZFFTdzNuR2hJRUxNQWxTb3d0?=
 =?utf-8?B?SVQ5RUFXUnBpN2w4UjcyQXNuRVMxdjI4M092MzMvUytFdy9qRWk1b1Q5dEp5?=
 =?utf-8?B?OGdLa2pNTU0wQ2ZyQWtDTVR3SHJjemhUdWdRRGQrdHVOVkdRYzgzWHBkam9U?=
 =?utf-8?B?SnF2eE8vUTU0MXk0T1J1WVZBMk1hNGNZcGNmb0d3a2ZwZGw5VlRKMzNJc1ZQ?=
 =?utf-8?B?NEhMS1NhNCtGV0IrR2FuZzBIYnVkaUg4RjFwRUpXNDczeURrRGNMa2F6ak1E?=
 =?utf-8?B?UlcvSm5xZ0RyTWtSM3lvS21NZFpaT0pmeWJqa09WcWVhbWFtRjkveWhHZzl5?=
 =?utf-8?B?MFFJaFhORHdSOGk2UnFORjZqcHpqOUF4V1A0NzY2NmxXbWhnVXlnc0tsbXJU?=
 =?utf-8?B?eFpoblBFeXo3ZFVqcG01RGdzOUZ4cGxUd0drT0REN2tmQWNpY00xWFdLbWxW?=
 =?utf-8?B?WGdlbVg4aDRkTXh2ZEc0cnY1elZ5cTRLMUxYT1oyT1J0R0FHVjhPeFMvNVBX?=
 =?utf-8?B?OGRpNHJERkZHZlZzUUU1VDUzQVh4UGdtZ2VKSlZRN25qeHFzQ0dSTjU3Qk5D?=
 =?utf-8?B?bm03amVSTUdpVFN0THQ0czFPRVV2Qk0zbWk0cTVmNkREOCtYdmxQYXh6NkJ1?=
 =?utf-8?B?YnFQNTN4K0RtQldZR2VyOXVPanhHaGx2Z2JyeVNHQXE5NkN1V09NUzVOOW5i?=
 =?utf-8?B?WUVOeCt4MEowMXJqNmo1WXBsd0dnQVowNkd1RWxISy91cUQ3cHhObkNkOUJ0?=
 =?utf-8?B?QkdQMnJITzJRc2VPY0V0UzhFUFFuV2dQS1VGeENJMnBGcVpsRkdLSElIM3kz?=
 =?utf-8?B?b082bXNhRVdpTmxvRHVJSzhmaXRYem51ZjIzNWxsVlB6dkhhWjFIU3pSMWcy?=
 =?utf-8?B?bUtOOTRhZCs3ZnFvT1NNazV2eVZ6Ym5BeHhZWit2dU9XdUVSblQ3V29sOGZV?=
 =?utf-8?B?UHhPYXc1UVN6RFc2NnlWT1VDb05IZVlFUVRnMzh5c1dqUHBKMFNucVd3d0R4?=
 =?utf-8?B?YlV0SGxrRlVwSGlBSkVYREs3ZDdna3FwN1hIM01YTHFPTUlKV1JtQjdyWmlG?=
 =?utf-8?B?emFZWEtQL3JjTGRrUFgwUXBmUFlSY0VFYjNkMFM1MWlFMml5V0RIdnRaM2Na?=
 =?utf-8?B?TG1xYU1GL0xmK2RacTR1OWJ3TXhzYVlaTk1QM2J6R2xXK1JDNHRqT0wvRDd3?=
 =?utf-8?B?SjVGM2tocXRudG1Pa0xwZFhjaWlGQzRjeGcycmJyMGY0SkJ1T2pLQklHTEp5?=
 =?utf-8?Q?K/rT4m7ESEdGT+cm0/7j6RZo8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b685df8-17a9-443a-b4e6-08dced386f9e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 16:43:02.9824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AEmdU/NTPx282LoM+ftm0R+AOY7iGXuTwOBQUFLqGTj7yDmfvwDFuenR7DQ+LYOFVTl8AxFsdkS72DAI0m0LRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7514

Hi Joerg,

On 10/15/2024 2:14 PM, Joerg Roedel wrote:
> On Tue, Sep 10, 2024 at 06:58:11AM +0000, Vasant Hegde wrote:
>> Previous patch converted dev_data lock to mutex. Move PCI device capability
>> enablement (ATS, PRI, PASID) and IOPF enablement code inside the lock. Also
>> in attach_device(), update 'dev_data->domain' at the end so that error
>> handling becomes simple.
> 
> This patch description lacks the 'Why?' part.

Agree. I have updated it.

-Vasant

