Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1C81B964
	for <iommu@lists.linux.dev>; Thu,  7 Mar 2024 05:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709789614; cv=fail; b=RaVZh6JwAA22eukfHjpWw8yjJu+H2PWdNtnZiorBYhQDcFKDbsctsV6NRdcpVSKMTdouHkVa/7HCtbJyrvQPmVYcbbrhIyHmFwPoBqiyIJjpqsrLTx1JUwcSOCOVhz2GpjqeWgbCwZ4aMvLxYLH9/aAF9muQgrwrpZ+BMB9wdkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709789614; c=relaxed/simple;
	bh=+Rtygnsf0UXv/U839we5TU/ELfkEA7hg1d0Dhs6Ze+w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lukUPlWne3VTbnjLgoiA80/pzvZ0e+ua0ICPNQV71eQHmHa3TdVPFiXbR9EfAKKfkVlBApC1GACe3rWNtCyboRS6Fz9U3Cqy2FZPs8BWHMO2miYM3ztGy+5z+V+5Si20P4wCbzOduqw18ORTc9kPTfhHYUTjO8nq3RxoCsefcf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2ZMRiQN0; arc=fail smtp.client-ip=40.107.92.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2ZMRiQN0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oE6utIROUIO+i5vaYz+XMJDk66tjfBiDGefap9yjtkAhuazHfYsYu6cXNZawElU8qUwVUuFyGsOqMWQl2EZb+jFOrMaIhhoP+yRiG0yC5XdcfmMRaE3+xij/0jCwanU5IqYJlgWugBvfVdmHYVxjykiCyffyH4ox5NfuXZcBnjQYUgkcMnfGZaN2dV2sU+axENHECYS/T6yc6Li/iTSTjGcH21JQBQvUl5fgm3294edqAkbe3oBKfPGrWyFxZpcy0OlPYSE8mfRb6bQDFeb6+aBY/EeejAHS4QouPrF2bhQMHdmZlMQ+EG0aVYM9SLgKqN/+HdZYq92Z7rYLp183Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qy77xDK2pqdzt+idHby5lDLV99V3tt2XYnSadMXTp4=;
 b=MAviU/ZWE7h2GIKCFPSYVPeChwu2glcJSHKoXYPB94fHUHaMpx3vXWSY/090aPIWY8xMmG3XXlpKPcSRUb/t5JEk1TglwK60jHXKUkOd8LVpNXx/YD0hSSTB0dgttUde1Cbv7jgHHvK0EkjxLtntUT4U4aRLwygSKR3JYlOLml34QGRUA9h+pVAd4PD7KXLLEW/WgxEBveGdHA83Uv+toOTn6Hz/GduLKNKRJ3nVhRdrauqpuhAlDh1ByLAgXM+4imW8G2Qpu9tMEZJWSRcIRpeY9XhboedAgVBo1wrH1f59eyCrjqgxH97K5ra66PSSP+/pynFVdax3l15Fi46BlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qy77xDK2pqdzt+idHby5lDLV99V3tt2XYnSadMXTp4=;
 b=2ZMRiQN0n4O1mIBPDjTa/WQP8HqEetUzFOdjvi033gOI9R12y7dimyfAFuTsCV4E5+mTAM/w0+fqUQiPUXNTffUhc0OWvcZ61rMzdSnYOmmaDE/fmB9YCHh9GoBap6pHHQc5I155xVwaF9p0pg84FAvPBLHPboSB85qzPMAr/vY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA1PR12MB6164.namprd12.prod.outlook.com (2603:10b6:208:3e8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.41; Thu, 7 Mar 2024 05:33:30 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27%5]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 05:33:29 +0000
Message-ID: <f6883c6b-86b1-9dfe-8ecf-4ae12c9352d0@amd.com>
Date: Thu, 7 Mar 2024 11:03:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: iommu ivhd0: AMD-Vi: Event logged [INVALID_DEVICE_REQUEST
 device=0000:00:00.0 pasid=0x00000 address=0xfffffffdf8000000 flags=0x0a00]
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, iommu@lists.linux.dev,
 it+linux-iommu@molgen.mpg.de
References: <f35330f7-ab03-4b27-b112-7a49eca3cd1e@molgen.mpg.de>
 <1c56ecac-496e-2b0a-a3b4-d9223a9924f0@amd.com>
 <dc1a5650-b23f-4aaa-97bf-14b33f367bda@molgen.mpg.de>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <dc1a5650-b23f-4aaa-97bf-14b33f367bda@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA1PR12MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: f28d87b7-e054-4ac2-fa7f-08dc3e681ed0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	80jCHogov9yQr2wllVYlp1kEgkqAdrsUgjF5SH7CbaK7Tq83MCu0cchjwaBCNIQaPE7H+3KNrJlJeGA448Jzh14tZOLGbvIsurUgPIg33oUuIoRo+5BXJlDNPrZ/9dX2AQh8KUl/7rCBRQS3cDyh9CcPIyU/WAqlSLrb3ijmQ/aUJdxFEyG4ODDBcJZIJKIAZmdUdxJko2Po1tqAsbbM4b58kDSaKF+6/5RgsSuifWQQOZcj5opTIX8fuRYw6lc/F7vTcLmJrBofTWHkbVxAqK8xIO61IN/1+ylTMqU9QAIUmfF0W+v3ng37mayWz2PX8MY1v61O4sSFzFZwyKSBfpc2cq/uN+vPfkjOZl1Y1a9HMgeyrGqxAGlZGFHIWuhFg5lrCQx++l+SrhHOfKp4CmVWWadLlaK9rPuqg5oqxPTesT+Y1r+dIuJalFa3PBCwsn/KZLKOspt0ZMMzMMAzdWVb3U7KJ6mqk0kFMIx8I33cw8JhpmRoZfUmyABcYyrjXF71coLPGhk3BDNZLUCYjLSONitmzjjtAXDIubPvtgXTjTmt1Tv2nMvjGbwZZq+/6Ic6RtUtc7o/LlI14b3HWVkwCeafuZ1CpTrYPtX+O6E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWdMUUZjQmgzalBCcG5xeE0ybVFqSDhOeFppcFVLM3hKa05WOStrSzNsZmp2?=
 =?utf-8?B?Ni9rUUltdENWVjhrRDFKeVlKbnNybmVEb3BRRXA3QnlFbVp4cW0vdlovbXBB?=
 =?utf-8?B?L0pZODZ3WldPUHBzZTMySTlPaXA4Ykc4Tk1CQnBoMlpiOSt0Mk1lWk1JSzYr?=
 =?utf-8?B?NDNVRVpUNTFXTlRqWG5qaXdjNEpTVG5laHBXZTNwSVRCV29uTnZXc3VLalJN?=
 =?utf-8?B?bDhVRThSRURDK0l0S3V6aGE5c2JpVnd3Zi9NT3h1UElNNElsYURoeGUwU1FU?=
 =?utf-8?B?RnFMZjQ2cVJWOFVQT3ZtdFB0N2ZBZ1JjTVhPY3V0ejZZc01WSGQrWktXNGcr?=
 =?utf-8?B?aEZORllDQSszRlRreWhuQVUwZFJEL1cxZk5JWnp2UlZpSmJvdkhnd2Fucjdw?=
 =?utf-8?B?MGRjbStFdlo2NkhZdUtCcXhLbDR6aTRrMG9adndIMHdobTRjM1VJT0YwSm1j?=
 =?utf-8?B?WlBIME80c0FzeCtYb0d5dXJuK0RMVXpkL3lqU204U1lCNGkwaUxrcWFIVXFq?=
 =?utf-8?B?Q08rNFFDKzcyakhjb1d3T1F6NEI0clE4YlNNOHNUU0diVTRDZFhJZDJ5NTFX?=
 =?utf-8?B?OUVOOXhxQVJjcU54UnJCcnUzenNDTEtuMHNaWmdLU1AvTElUeDRrRy9GNnFi?=
 =?utf-8?B?OEdudWhjZG9wSjRWR1cza0U2ZlNhOGhsTmNBVDBjaldpWXhNcU4vQjU4dkJx?=
 =?utf-8?B?bWVJMEVKSk5BSUZkODRYVysrTlJURXEyYmEyV3N5eEppZFRaSnZZZks1bE5C?=
 =?utf-8?B?VkdYamlaa2p6THFKL25KQzZhUUduNlBmdDB1b2YrQnl6d2tBTVpmUzYrS3Jv?=
 =?utf-8?B?MEVBcjZxQ3BoMis1OE5kY2ZZQ012emFib2F1clF6cmpzOGZYSzRFU0U5SHM1?=
 =?utf-8?B?N3RIMXlCdlJHeWw3Zjd5Vjd2NkR2WE55a2RscDRzRUxXdnZlVmxQN0Fobi9z?=
 =?utf-8?B?cDcrZEdKTzRnRnYyQlZFcjA0N0x4ODhXc0t5SHI5aGhzVXBDbzZleGpFK29I?=
 =?utf-8?B?cm94cXVuTUF5M3BMd2Qwcm9jMCtwZlJYVmVhL3djNGpRUUhEbWt3ZXhCNTl0?=
 =?utf-8?B?Mk5HTVB2MFRwWTQ3S1dYajhWS1h1N1NKOFNsMHJMNXFiY3ZiNU5zNkYwbyt0?=
 =?utf-8?B?SmRESWdYc0FCSksyVlBrQ3RXeWdDUURoNzdTdVZkMWdYQnp3WCt4WFFlZy9V?=
 =?utf-8?B?YXk2b3V0Qjdka281dzFURkVHby90bkVVdlhEdDFXMGxGOFVRRDBqb0ZrV1J3?=
 =?utf-8?B?TVJXbUNaem5mSjViUDNzTHJKSVlodjVxa3JicWtOQUg3VkV5SGZud0dLdENR?=
 =?utf-8?B?VjNOYi85YXErOW5DUzJBc1ZkR2grRndtSHlLMFgwNFVGbytxemhYcmpqYVRE?=
 =?utf-8?B?WS9YNXkvNXdJaHdJYjRVd1psTDdsUVNNTXZRMWNTYkRmclBYNFh2Vk92S2kz?=
 =?utf-8?B?d3RRb3ZlTkRQSS9INzdkaGxNU1VDbXNaNkZIeFBVYlJhYVl4S2V0OWJRc0tX?=
 =?utf-8?B?ZnI3OGdEc3pvUlNoSnA2TW91M0hZc0pKRDZzbGVSNndNNStsQ294TFVKNGZl?=
 =?utf-8?B?WGRFQVBibHJCS3pRbWJVM0ZndEs2WnFybExhY3EyN3ExbnVxSXZqY2xycG1v?=
 =?utf-8?B?Zm1PNmtEakR4ck1tZHBjaHdsUGkvZGpWWm4xZEZkS3MvM3dyRUxPdHBmYXF2?=
 =?utf-8?B?YytqUmlzRE5mSnhSRVZoVWU1TmwxUmdmeGJJeUVSWjBqR0g2OEhNRE1LQTlB?=
 =?utf-8?B?dTQ2Q0tYeHNyQ2d1NzkwRnY4SWlmZm04aVJyZmpKeDhORy9ESit6Q3MwUHdM?=
 =?utf-8?B?YUV6bE5hQ0lEYy94OE1Jbiszc3JqRUtHMU16ZGFGL1JuQmNTN0IreFVJL000?=
 =?utf-8?B?cUQxMWtuWE5mQ2sxd0tCS3l5b3JxN1h6b3RyY0xIdHNFS1B1eWUzeHBRdC9m?=
 =?utf-8?B?ZjZLLzE0N2pmUnVYNWdWeXZDNFVhdlR6cXNiWm9Vd0JDMDZYd2Njb2VpS1JW?=
 =?utf-8?B?U1pNN2duLytGS25rbzJORXh1Y29hZFJmUUtxYlZsakp1dE5yY0lMaTZsNzJa?=
 =?utf-8?B?WW81bUo0aUtVdGJWaFJLZDNpRmx5cDkxMVB5SjZYeFJrdTJha3RHVGlXdnVa?=
 =?utf-8?Q?DldZA5zblDAPHLkIY3s5bwHt9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f28d87b7-e054-4ac2-fa7f-08dc3e681ed0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 05:33:29.7785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g7qXGj1nksImLcaKqDGhksanD4GNBI9zl3un02tdY+SlOU+Km7iMe3bAFijAe+QMRR1tcuqNO++GGr5xq//Gog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6164

Hi Paul,


On 3/6/2024 11:39 PM, Paul Menzel wrote:
> Dear Vasant,
> 
> 
> Thank you for your reply.
> 
> 
> Am 06.03.24 um 17:24 schrieb Vasant Hegde:
> 
>> On 3/5/2024 8:18 PM, Paul Menzel wrote:
> 
>>> On a Dell OptiPlex 5055 Ryzen CPU/0P03DX, BIOS 1.1.20 05/31/2019, Linux
>>> 5.15.112, 5.15.131, 6.1.53, 6.6.12, 6.6.20, 6.8-rc6+ and 6.8-rc7+ log the error
>>> below:
>>>
>>>      iommu ivhd0: AMD-Vi: Event logged [INVALID_DEVICE_REQUEST
>>> device=0000:00:00.0 pasid=0x00000 address=0xfffffffdf8000000 flags=0x0a00]
>>
>> I did look into attached dmesg. I see there is a mismatch in IOMMU Feature bits.
>> This is usually a BIOS bug.  Can you check with FW folks? Specially I am not
>> sure why they have enabled bit 62.
> 
> Unfortunately, this device is out of support, so Dell won’t look into it.
> 
>> [    3.527391] AMD-Vi: [Firmware Warn]: EFR mismatch. Use IVHD EFR
>> (0xf77ef22294ada : 0x400f77ef22294ada), EFR2 (0x0 : 0x0).
> 
> This is a known issue with the Dell firmware at least of this version [1].
> 
>> You are hitting fault with device ID 00:00.0... I am not sure whether this
>> device is managed by IOMMU or not. Can you add `amd_iommu_dump=1` to kernel
>> command line and boot the system. It should tell us which devices are managed by
>> the IOMMU.
> 
> Ah, thank you for the hint. Please find the Linux messages with this parameter
> attached.

Thanks Paul. Looking into the attached dmesg, looks like 00:00.0 is not managed
by IOMMU. Hence we are getting above error in dmesg. This needs FW side fix.

-Vasant

> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: https://lore.kernel.org/all/e148d54d-6b5a-365d-bc90-b1bd4b0e694d@molgen.mpg.de/
