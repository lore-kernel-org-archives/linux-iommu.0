Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0323E44EF
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148735; cv=fail; b=RtohZ+mIymeR6fMuCFPeFLnbzjMN/NqQ5riLAqLBOfHaR7JCukJ7QAW64qISz+M8Ev1Znn0T1Wv93T3F9Mj+8b/2Vdui/99kCZoUrsji/CwaRuLHTYdHMxzDgeHaQjDNchFrit7BBSaFNauVPwdH968ciY9Dhw5daJcctV561C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148735; c=relaxed/simple;
	bh=7OmQYkkLStSHEWPZ9boHeZS/gi9y+mLn6QgV8PeWu20=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QD0hqIxqzuGnxTUmBOVAY44QPnbXbb2q4YJynQ1Rn2wJZmmKJvVUZp/yIdaPDU4e+RtmMDwwTR0L2VIBvHk20BNb09Iw9TmMTu1q/wz8LBKmRFbIGu4UvVAtpF4ghR8uW29P630vRzgmBMSH3PK5aw3vy04BAPc8YHjB+XXIhvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oXRAo8mC; arc=fail smtp.client-ip=52.101.56.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oXRAo8mC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tKT4g0xJMLOEtg2Vjynl0ypHR7phsYy4bLk2pFnOn2U04r0PK3662mb6Q6QP9M2zoFgHDWdfUotbKwvNxj/yMJN6jfQtP0NVU+WtA0Jow+dGZ1eCi0+0c1mCcDWyK+RqM8jjfD47opGxXb+BND86GNS5GsxZGG5zq7lKyRzGk8Ib6MDfxqfKT9qJVdBaNOagQifnCs+wjanyXJlh3Qwc3K3Tq6J0WulJCEyUeisn58pVO81xgRU037Fq4AG7C8NhEXsYWlWcYi4REYokqPkkTFRI5lf31v8E8Oh4Aq9gCizGbGrAU8K7PeI74yE94nyBxfsAGAJA7kI+zz06jDmMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=328/O8lrQtg7Ebp+2g9T3SYIww7/9isBOT9OtK1gUow=;
 b=TAZOKbR6d/FE+rxFsdzomvRCx/0T1HknpY9CVDGRzKcx3WTJxOW47u/NPRiX0WJ/UuEfs9HDPSRZluHD1GBFffst5HZkofvSVZcclEm3BlUvV3nhZ2ULsDQM2a26rOUloLvCrvL3TN9jdejdEFqzYNOSjUTCvGzcsnhEh45/BxwucXE651gOIJ70zaeFPL4gMpf7QTEAWqpBvwH8Z+TJXx5/LoT8iLiiCKt3z+xlQRqlg8tf6eyDMGOV/VJ1FHdVL48HFLG+K9UIEYMzaqXNXchSaDE6gMpPXivyOWV+m8eGxn1pqVtpsaYtdtOzme05E6AQ4cxNIHqpn0VpP4Ha/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=328/O8lrQtg7Ebp+2g9T3SYIww7/9isBOT9OtK1gUow=;
 b=oXRAo8mCMYwrjgTZAUHNqpWEOMX88JBJYzSXmFcJ5WDAyvqQOGM8z8+fQbby1fPz0kzvI3h99NxOmSDPkqyT3KMBYfV5ab7h0AAl3DHbHR6oRD4pf7UBOz/0EEJlbcybIzy21AZ+MEAMfwPWnir+2GrfgNMq0Fwf6w/jKHbn6No=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by BY5PR12MB4082.namprd12.prod.outlook.com (2603:10b6:a03:212::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 10:38:46 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 10:38:47 +0000
Message-ID: <889494cd-6bd8-4fff-b71b-59f6ee747bec@amd.com>
Date: Mon, 27 Jul 2026 17:38:38 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/22] iommu/amd: Add per-segment translate device ID
 pool
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
 <20260629153535.15775-20-suravee.suthikulpanit@amd.com>
 <20260707143659.GG220801@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260707143659.GG220801@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:196::23) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|BY5PR12MB4082:EE_
X-MS-Office365-Filtering-Correlation-Id: cef18e1a-134c-4957-96b1-08deebcb3d2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ePZ5QiJEVN7wOWoUx/jqYorE9fscMwfXdiAV3/KDizzGf/nezLvI/A15RlrMlmtKOX2mZwsAyF2sW+K0cU9kQUhAZ8GGA4Ry3DxrnbgJnUgtxZbWh6WA5SlkkV1Ol3pV0rPkSPwRx9ttXTk+aYF+wq2Dwb5eJLKzkvna4GWaMF/uX6nubLaifPHLkwWLSO6wAxCY7g2Todke7Wgs+QI509dltxmRKiAi1f/1qHUKxlwBFF8DxWmkPzD6U4CV0gZlENBE3kgptoQEIuGlvxVDh6ce0eLwLh9FgPxfUP6FU07HyptNu73Vc0OCX+BgeAlGbUtuYHQAJ3ElsOAghewz3jICZERlv/J++9jhxCBmwXovp9Zozxfytzuyg5LOq/xq+FlOeXIK940BZTCa02xmt/oxgHWUXiN2WeKjvrRNy/2AJRcfuErwpk3uzT+nLcW6ZkErBYmtvr2pMPSZVKzAlBhW8OI3V+UuWhuvOmG67MWTGIYgEDNzbMSrHm6CfNQT5onUyIWevmNiLG9x5NpkiIQw2sO/teKyM3HhDgRLB8+JUQZCuVayN5Z8py14AWwwHW93rK0bbYyQK+x0jo2JfFW5t8HdTWt6S8msPJzoL/UP1kTg5icuOIObKrDSAVz4zCjzG2KoZpKvkww3U/ti3BttYIkhVgu5CTuhdjndG6I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnQ1RTZNbTdxOUZ6TmtFQTZWbFdQaHd6YVdnS0FVTDFNb240SlZTWDZubDMx?=
 =?utf-8?B?SHJ6L1BrcnljN2R1YkRVbTkrejB6eDUvWE1HQnNPNXlLcHYrR2VKQWp1Yjcy?=
 =?utf-8?B?RUIvWEJzR0lDZVRmMm9FTHdzQ0ZoSUtQczdxTEs2bmZMMlRtbTExWXFBUHMv?=
 =?utf-8?B?c0NFclc1Zmd2NVVDa2o5NnBWUStvbEhFT2F6SGNLU3RoRm5CRDJNK3VMSXlx?=
 =?utf-8?B?K3NOQy9FM2Rzd3VvVG1IL2p2QzlBSG1ERmNYYWVqMU9WclpTdTE5aEE1R1Vv?=
 =?utf-8?B?Ykhjb0h1eVNKNlVmTEd5amJNSWZ6OHVva0lFZ2FlWnhNeUlldFNlZ0tKalkv?=
 =?utf-8?B?UzhxOTdaZGsyTlNFa0lDdzZ4L29zNjRMMmN2ZURKUm5zK0FCQloraDJEWmVG?=
 =?utf-8?B?QmVMN2ZjaHdvUVJOc3MzZ2RIVk8vRWNaMGdYdzdlRGtpajUvZTRYRVJGV0FJ?=
 =?utf-8?B?emlHRFhjQ3dlQkdOdzVRSzA0d0wwcGpXYjRRSTI1UXZ0dVBtc2VmNjFWYndC?=
 =?utf-8?B?V1dLcUdUNVZ0UEoxNTlFdm5senpFaDhFRC9kWVdYS3dSVFJXODg5NU92Z2h0?=
 =?utf-8?B?MzZqbU1tRkNRM0VKdG81QkZvclYzeTJIeU9JRlB0RFJWRnNMcWJXS3hHWk85?=
 =?utf-8?B?dFBpSlZoN3NXemk0R3o3V2M4ZmJrY2ZDckNNbXVWNDA5em1pcTdOTUJoVDcv?=
 =?utf-8?B?cVBWeFdUTnRaTHIwYmlDSk9qamp3cmVYR2pPamticlFEOEZOMlUrNTV5U09q?=
 =?utf-8?B?R0tlbldxM0h2QzllRnZ6K051MmdXVlJkeGFwbXh5T2pNM280ckwxS1JtZ0s0?=
 =?utf-8?B?d1BVakhwempUVHZNNHRJR1VwbTJEMTdZSkZ4c2djbkhGbXFBVjQ3dUVjekdx?=
 =?utf-8?B?NmRPSVAxZjVBck9hY3haM0M3WjNZREllTFVkTnRUN0lXTWxJRTZUYWpJbk15?=
 =?utf-8?B?dEZGUDBoQSs2RXZMNnF3ZEQ3Y1NPMG5BcDEzVVQ2bHR2T3Z0d1Fhd1cxSTdU?=
 =?utf-8?B?UnR6UzJmckR1QVQvdGp2WThIUmtJT1ZVMmdYN25yWnBJY2FpNDl4R2dkTUEy?=
 =?utf-8?B?eFBncnhzQTBZcjZ6SDhSUWw5cGJGVVRXa3VXK043cVYzYWVSenZDTjVqS2l0?=
 =?utf-8?B?ZnNtbWFKZFBUU0ZuMXRIck95c2RsaG95czFnVE9CYmlzYnNOcVJxYzM2aUNO?=
 =?utf-8?B?M0FrWVVZOTA1azRqSTA1ZUdCd2F6WkFNakpIaFFSbzYwVDVJMEZXOURRNktk?=
 =?utf-8?B?VkphMlNJQjdVV1U3MVZERVVYZ1BDb2czUWlteC9BSzhYYlIrcnIwcVlmL1pY?=
 =?utf-8?B?TzNOM3JsMXVIUFpaNGJDa2M2RlVRMWxLQ25Jc2EwenpaU01nN2FXOHRuWjlq?=
 =?utf-8?B?bm8ybmsyd2RIREFhRk5SRFE3Qml3V0JGWVlhVUdTck1FdG9FOHdZVjBuUiti?=
 =?utf-8?B?TUpNdTNvakdLLzlXRXFaQUR3T1ZhbWJod3h1bjZpcEpqMnFZN1ZRYWJrc0dO?=
 =?utf-8?B?MFNEWVNqM0tnb01vL2pxWStlbEZhNEVudHJodFljV1BSUG1jc2dsNXNqNXor?=
 =?utf-8?B?WU1NekJCRXd1cXlOTXFObXlWeUNBQmxLeVNvSFFBVE9sYXQvRjNzbSsyMjRj?=
 =?utf-8?B?S2YyRHZKZWdXNnkzeVBWUkY2aUN0TDNCTUNoOWVhMjgwbWNmQlEvc2txcE01?=
 =?utf-8?B?SnlwZlM3MVJuS1RkU2FoN1JhemtTQjcxWitjVUswOEtnWHdpSzB5V0xmZXJF?=
 =?utf-8?B?L1NSRGZhZFhKcHNrQ21pZlczTmVkYzh6b0d4c1dvQVJhcDlQVjNkdjBGMGVF?=
 =?utf-8?B?aCsrYVcwNTMwS2h6NHF3Nk8rNVRSd01lUG81T0l3NzllY1d5THdmbUtwL0NC?=
 =?utf-8?B?Q2FQNVdkR3cyWVNqczFuK0FBRGFqeEFISzhLY25USE5JWE5DYmJlQWduVDJ5?=
 =?utf-8?B?OTg2Y1ZJZU8rUXpNQXNleXBGYkRwanlxQTBJQnlJNjZFQmFnMU83Z0RDcnls?=
 =?utf-8?B?aEtrbjh0L0FNOENKQkJ6Mm9WQkhqc29ucDJwQW1hL3NYR2ZIQW56TXdQUTcx?=
 =?utf-8?B?M0pzV0dDRW9HU29aYXh0V0t0M0hsQXRuam8yOFFWanRTNHJ0czNDWjBaWnR6?=
 =?utf-8?B?RnpNVEZMTzdzNE9mWXVTbzlPaEVYL3B3c0JlMjNnUVM1c1QvSkpQblBiNjdp?=
 =?utf-8?B?dWpHVmVSWSt3amNrdlBkQnlGSkFadmdUeFllUThxMkZjaU9kOHV5SGM3bHcz?=
 =?utf-8?B?a2NXc0NLckZwQkl5ZjFKOElOTTRLNFd1UVhJQTJQR215WXRIejB3SFZtS0xT?=
 =?utf-8?B?citDVXNSM0daTGNWNjlBZ0ZYbUVIUUtMemhuVE52K2VOc1pmNlFtQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef18e1a-134c-4957-96b1-08deebcb3d2b
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 10:38:47.3314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nC0kqkVoXE1LDo1NeP1I9zw/wtbeZJtTkmnmW6LDM9UlefOOwH82GBvwfuaZVS7HiWow6PDvi/kuTmLKIff8Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4082



On 7/7/2026 9:36 PM, Jason Gunthorpe wrote:
> On Mon, Jun 29, 2026 at 03:35:32PM +0000, Suravee Suthikulpanit wrote:
>> Track translate-device-id slots per PCI segment so real PCI device IDs can
>> be reserved for normal DTE programming and excluded from dynamic allocation
>> for vIOMMU translation DTEs.
> 
> Why does it have to be per segment? The segment is encoded in the
> devid isn't it?

This is per-segment because the AMD IOMMU device table is per-segment.

> This seems like a sketchy design to me, is it impossible to atomically
> change the viommu used devids once they start being used? It seems
> like this should be doable
> 
> If so the algorithm would be simpler, just maintain an xarray of all
> dev ids, if the entry is marked as a VIOMMU and PCI needs it then move
> the VIOMMU out of the way and use the entry for PCI.
> 
> No need to try to guess what ranges are usable or not.

Thanks for suggestion. I'm implementing this in V4.

Suravee
