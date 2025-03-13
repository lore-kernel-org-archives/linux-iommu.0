Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC151D54FE
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 10:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862322; cv=fail; b=btJ/ioZ3YKoCiM9PqxWFb4jTjB/BxrrxirolUFuNtOiEaeHCoAaiqcx6WEOshb2DwxBgXmoBdLpIKUaQ64wHkhy5TbOyfKAXziz6/rOTDaYOH7iIDBt9Y0dZkfLfOMICuCijyX5j8C+QjIBsB6zlxL6QAJuwtotiSQUDui9KgfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862322; c=relaxed/simple;
	bh=/xXX4Kzzl/W838Q3lcnY++QoUXnbs185tITjPT+ejKg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CjEpzf0g/+zY5ZPnHLMnfIZ9mBRCNh1PRqI8+l+sBAU2T9ZonbMlO9VOdB6iB9JnJWjJtIwwvf4SxImR07boB/4J50hMcMUh/pSDmLZYqWxxQ4LWG55A6tkdziV2kDCNJr5HQHuqE6n6CrFm0xdmLQrAeufcq70siHnv0lydygg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FrdyyJRC; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FrdyyJRC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cKOPIbOckxRQuHA9ATWB9ZoK7vFnblksLwxnbQVI0ZyKRqhlucdvUQn7wxvIMYcAiQPSsJpr4p0thec2jCgXmHBwte9+2w3r0X/pIqYzy9rmQO0Hf4cUlwfQzAo1LHhRTm2Bp4/VKtUotGftLyFbK75zCjbBIaclQqcSCIJdJp5NeBIjjytfIbGcbS83e2bqF1VM8Zm2rICBKRd5WbUYwfSylESxtD2GwdxPpyBgxI9cbfaUVlvAgcQ6qgS0+hKp7pV+kaSL7OHi9BuChmaqQkaqZyGKkgwIpu8qgtrp0X6MnGqM1rYz5Z4ioiafcHMTziAEGaLTRhHSyGR60N+tpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbatR22a86gGVfIwvc+SLezXINjiSRmLSUt99V5+XyU=;
 b=n6YTCZeNDKZGQjT6Rll+z3P5SVPhsAbwG6f8mYbF8SO/5T+qKw+ZZF14WiefLwsnOBAukGR1a/3KsXIPaHVXXYPZonDUWE/gWQBcrAqA0gC0YeOcrhjBzxz8tB4C44GmK76AIS0z1xK5j2O5/K6u7tMBvSUVGA2+GjEUIRJlRJcv1uXxOKnzblRbLDyBzjV7ztMW9Wg9qRkl4qyY5w2Ok61PRaCrHE4f/BHnbuH769ZGktUtINF01C4quMH05RA/vNpx20m1NIGn+2Qk4QucLw7eaGRhXtscK+Q4PCY00DKqWILg1zK8xaSf/VetOm13K5IeN8yZV3Zwo/n78myCpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbatR22a86gGVfIwvc+SLezXINjiSRmLSUt99V5+XyU=;
 b=FrdyyJRClFtH3+2UvPqt33uK1RxAIDEcJ/yUXr0BvDd315bP5NDzpFzyg8ad76c82Xov5tAYYpHoZ82+wXBt0e6eChaoaWrkuB724rYcUDpRoUqSMwKqEIHQKoM8bwAqTsZgTskEZS/avFHNJwAAlYew52A+0rjythtIjfn7H5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 by IA0PR12MB9046.namprd12.prod.outlook.com (2603:10b6:208:405::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 10:38:37 +0000
Received: from IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be]) by IA1PR12MB6043.namprd12.prod.outlook.com
 ([fe80::73e4:a06a:f737:e9be%3]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 10:38:37 +0000
Message-ID: <014da701-dc74-4082-98b0-378da8ebbfd0@amd.com>
Date: Thu, 13 Mar 2025 16:08:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] iommu/amd: Add debugfs support to dump IOMMU
 command buffer
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev
References: <20250206060003.685-1-dheerajkumar.srivastava@amd.com>
 <20250206060003.685-5-dheerajkumar.srivastava@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250206060003.685-5-dheerajkumar.srivastava@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:21b::13) To IA1PR12MB6043.namprd12.prod.outlook.com
 (2603:10b6:208:3d5::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6043:EE_|IA0PR12MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 74296bec-1625-4c03-1fe1-08dd621b366d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WU91a1FtSFJPZk0yQitqNGtZSGl1MHFPaGNqSnBQZTNXMndndnIwaEY5MGUr?=
 =?utf-8?B?L1IvZENlYlI4NDZZODlsUEpMendIR0k2WTZ2SWs0VU9WV09veTl4a2JnWkdm?=
 =?utf-8?B?VUlvVGVKa1o5NE4waEhyM1NpY2F1V2M2ZkgvY25YcE1HQzlsUEpFVjJTeTlq?=
 =?utf-8?B?bmZxeDV6aUpUZDFCWDdrVTZ0bWlPOVB5bGUwUzZybUY5MFpUMkZ0OUZMU2FG?=
 =?utf-8?B?WW1wbGUvT3ZRZXZLeHpzYUxyNzNCbEMreHZWUHRpa3VQcTllaW1kUXNsMHFQ?=
 =?utf-8?B?VG5pZGU2dHZHR0RTcWttbS84QTZ5OEdzUVlDTXRSWEN0V1c4SmMrekFTNk5p?=
 =?utf-8?B?ZHhuR0Z5dSt4Y0F1dEdocU92OE85UFVYNlk1WTZWbDZHVVBjQ3pZbThzR01U?=
 =?utf-8?B?OEl1bU12QzJyaXp1QTJFbm5CWlNrblF4NXNsdHFsQXdXK2k5MURDY2loMk5z?=
 =?utf-8?B?OXY2Qi9CK1ZrazZXM2o1SDUvbEVrL2RVWjVNR09CY0U2S0plYjVDODNKTjY3?=
 =?utf-8?B?bWtmL1ExUEl3cnpzckpvTmttdkowejZveWFaSXE2cXpjcTlKcmdWdXBnSkY3?=
 =?utf-8?B?c0dMeXFoZHBxanNvOGxMMGxxd0JtM2s5NUdKMWxOV3JieU44OEJJaThVUVJ1?=
 =?utf-8?B?My84Y0VsdlVlZDhVUDJyb2FYQWU5QXRoTThUZ2dSMGlXMGZqMTdKR1RSVE54?=
 =?utf-8?B?c1R5bG9RSUdqZERhZjUrTlY2eDh2YTduZnQvQW1nWWxtQXRDZ0dGOEFLdE5J?=
 =?utf-8?B?MDFVY2RoalkzdWlXSkxjdmFoTkUvUUhrVmFSL2prT1pXeTVNaFlIYzEvSU1o?=
 =?utf-8?B?YTFNb0pEOGJ2bThOdldKZEFObVpWQXl3Mno2T3Y4R2s0K2VMbHcyM2g1MlVU?=
 =?utf-8?B?SE5uVXRhMkU5aFZrY2g3MU15VEhUR29rdGdqNVpLVmVMeUEyVEEyZEI2Q1lV?=
 =?utf-8?B?WTFxcGhiczRkNDg1Q0dLenNCRDBYVU5HT0dkMTJ4WEpGMUwxZjViMWtwSjJR?=
 =?utf-8?B?T3NNdS9XQzB4bnlZRkdkMjR1S2hxaVBjS1haRVJDbldFUU95VnI1cmFNSWgr?=
 =?utf-8?B?TEdBN3o5TUp0aUY1Qk1oOGY4bmNmbUR1eSt2a0l0dmNSVC81SWpvY1lBak9Q?=
 =?utf-8?B?aWROVDdMK1BXZXFuUW03djRtNDVDQk4rVndKUWdFZi81TFRvWVFIUmdPNkpB?=
 =?utf-8?B?MklYSzFldlA1MFBDMVE0WVdwSFRPcjJidjhFWXUrd2lzTjE3ZEoxaTJrcFFa?=
 =?utf-8?B?SHdsY2NQNU9CU0JGV0JFZVBrNFliZXhEakJlT3AvVy9FMjI2N2U2WWtRa3l2?=
 =?utf-8?B?RmtWZlk3eXN2SDJiYmgyOEkwRmFmaWo4TzNXUHk2TUZjNGZPMG5UaEdqcm45?=
 =?utf-8?B?Zldhb2FUb2c1Ty9WcURzSU13bmVuUlFWazRJaHdOZE9DTHlUbGRoTGhKeThj?=
 =?utf-8?B?VmdiR3Z1VkFhSmlxT25obnl5TVE5cUR1MzRoN0Z4eHZWM2lPek1vd1V4U0s1?=
 =?utf-8?B?WHFhd2VFZ05hT0lPbE1ubkN6QXZoNXI3RmpFUnNZNSt0SklmVXFLQmwyR1pG?=
 =?utf-8?B?aUUrNnUrNkJUVFlDSnM1djl6ZFlwRkpyRTNPcHAyTzQxT0l1VTMyTU5xdzhL?=
 =?utf-8?B?cVhrLzdqc1NxanhUYnNiUmxoblhpdm9aR3pndXZGTVVPdjBWRXJlZVN5MjVl?=
 =?utf-8?B?cE41UzFUam1CZU5TQ2xoN25PamN1TjVTVDhSeGdNSE16UjFUZzlPNjE1K0Fl?=
 =?utf-8?B?QnRsNURYNEV1OWNBbHIvVzFTU3RkVXhod3JlVm11ZVZFZmNDVlpZV29Ub2Nv?=
 =?utf-8?B?cXVVZHR0WE1zRElVeDUvdXdqaG9aR3p6UTllRUh4Wk9QYU5RQnBLcnN4RmUw?=
 =?utf-8?Q?Up02IWZ+f7PO6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6043.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDZyK0l2M0FteklNZUJSSFlVRWF6Y3psaURPT1gyRjV1ODVpU3lCYVFhdEQ0?=
 =?utf-8?B?ckRUd2xXMm5QMytVTmJMU2V4QTUxMUhIZXM2YnV0MmFIRTlXSXNodk5QbThE?=
 =?utf-8?B?REJtWTdiM2JGVEFENURUcWg4N0ZtWTlPVWVtTnJiNVhnQWREbGptZC9iSTc2?=
 =?utf-8?B?SWFhck9FRVNlU3lZZzZQZElhUWdmUU1JblI2cTZudmJpQjRXaGdIazhJVjdY?=
 =?utf-8?B?clBrelVzRGxwRkY5Yy9VSzVFSnVIdmt0UldnWjl6bExXcUJuaU5QTWlmMFJB?=
 =?utf-8?B?Y044M05oSTJuMjdjbjhhajFnRlpJRmhxZ25QWUNYNThRUzIrc1VRZ05Hcnd5?=
 =?utf-8?B?VXo5cmk3S1JEaTJRU0lhR3R0ajBPUjdHYkVad0g4d0l0WnFoanNnb3BrK2oz?=
 =?utf-8?B?M0RoMmYydnBkWEhEOUc3RjRORmtMRjc3Z1B5d2lMSVZCcTdBaW5CVWNDbTJB?=
 =?utf-8?B?TXJEdGxvUDdLcmdMSTVWZkpPelFsUU1ZTC9vYmFCY3d1RnZTaVkwUzlRM25o?=
 =?utf-8?B?QmZoUlRsZUlDZ1BaeURiUDRWY0szVTNMZnRzd3ZBWWQwZlorUEwyNnozRzRH?=
 =?utf-8?B?NjZPU2xFcUkyY3Y4MXAxbUNtUVFkRXEvbWdPZDk3RTZ1MzIyWFBwSGVvOXZ6?=
 =?utf-8?B?YWJVclNNQjhHVmllOGhoVmUwVytkRlNNeXNBQ1gzSEZTakxNRk1HSVJsaDJG?=
 =?utf-8?B?WS9ES084WDhPaHBDSzlwNGI0ZkQ1QzB6Z2dKL0tjSEFpaEt6eU9zbW1PWC9M?=
 =?utf-8?B?U29VM0FZR0ZUUFdBMWRuTXdxaHRwVTdvak5qa2thM1l5Wkk5dXNuTTE3NGFF?=
 =?utf-8?B?YjVSR0ZkOENrMkw1d2szUkVFZ3FySHhUUGpTdnFoSUFWRktXN1BhcWdiYUlC?=
 =?utf-8?B?ZTJUaHhaWGJEWGFOK1hQZWF6aFEzUFhQcnZlK3lqYnpJWHlRSzBaM2lNMEdr?=
 =?utf-8?B?RW1pQkJlN3RDTDNhb0tzZFFiNTNiTWpCV0RkMEx5V2UzblB0RlNuWEZUcW8z?=
 =?utf-8?B?VVQ0MFF5YTdTeitmMExDdTluWUI2cHRBS3ZPdStUaVMwa0wzbkV0T2luaDRS?=
 =?utf-8?B?N3BmWk0yVXZIRzdJVTl0bkJJTVFJTlVLZ2I3NWJyMERzSW9ud3NOUGxxOVpF?=
 =?utf-8?B?NzFTMWdMOVZEa0lBNUtXSnJSUzZVV1I4SnhDYzl6UHVqdWVvSDE0OWVBQXgz?=
 =?utf-8?B?Wkdhbit1Tm82NjdkWjlpdlZObzZ1NEZhL0owMlp1MVVYR0xuMHh0eWM5SnNy?=
 =?utf-8?B?TnZGTUxXWTBpSC9qbjR6SFEzTXBxYnVRV2Iwc0F2VkdxeXdLQ1g3cm44U016?=
 =?utf-8?B?VFBkV0ZoM2MxaHg4eEJvN2dnd01XOHA3NEhKdmJaU200a2I3TFQ3VmRvUVdH?=
 =?utf-8?B?U013aUJLWGpNK0Y4VnZZK3ozQS9jamFXMDJEVWlZdld0blphcWswY09wNEhE?=
 =?utf-8?B?a2tmZ0hYdnB2WUlpNnhDWlhJUkRmSG9aNkluRUpDTG41a1lKME5DalpPTHQx?=
 =?utf-8?B?U1FVMnNmcUlqWmtTbG5LWjJuejN3WEdNTXFkZEk4NllCMFdQazRlNmVLUTVq?=
 =?utf-8?B?cXVuaVo0dG9zMWdvMDVIRU5DNnppclh6NFFndXZGcnlhZm4rM0wyb1pwQjB4?=
 =?utf-8?B?TFREeUpKMm9uUDlqTWQ4a2syZXRJeUVBcnZKOGoxcENJSy9EUTJPNldGQTNC?=
 =?utf-8?B?RHB5UTlsQXdTOTJuNUhzWkt2cmVuZVRLZ2Q3VTZqc05tOHBDd1pjcUl5VGIy?=
 =?utf-8?B?dWliaXJSRVNadWlXTEVKS2JoR1JCT0Z6RUY4RjA1bmZ6RFdNSEdtV3hFbDZq?=
 =?utf-8?B?bDBEejhzUnFucm9FMm4vUEJPTDJJUUt3K250YjQwekJxTXZMc3Z1RzRIWm5P?=
 =?utf-8?B?N0NJRDNmYlUwVlVjek1KUTJMZGdCSTJIU29qdHVZOHJyV2NZNHFUN1B0NDcy?=
 =?utf-8?B?VVAza2tkSndXRDFTb0J3M1VTQWxQYTRPQko4cVUvK0tmNHIya2NBOENzR3Bv?=
 =?utf-8?B?QXgrQmthZXU5MlBOMytRbFNBUk9lZUVuYTVSeU9id2lBWUlnR0N4Y2E3ZTlL?=
 =?utf-8?B?eGJENFM1QjNjcVU4c3RuaXZzV0RrU1RlQTlPeGtIbG9oa1UzcVl4eUFPSTJY?=
 =?utf-8?Q?JOCeE/NvTwZb6jsIG4eSQhPT1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74296bec-1625-4c03-1fe1-08dd621b366d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6043.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 10:38:37.6348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35241F+Dch7DzU+XoJn0GLIPReJ3NUVeoQdyPvcKJzDOJFevCqCGX9oBghxeMq7iJZSMVy0V635RSsu24cZyhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046

Dheeraj,


On 2/6/2025 11:29 AM, Dheeraj Kumar Srivastava wrote:
> IOMMU driver sends command to IOMMU hardware via command buffer. In cases
> where IOMMU hardware fails to process commands in command buffer, dumping
> it is a valuable input to debug the issue.
> 
> IOMMU hardware processes command buffer entry at offset equals to the head
> pointer. Dumping just the entry at the head pointer may not always be
> useful. The current head may not be pointing to the entry of the command
> buffer which is causing the issue. IOMMU Hardware may have processed the
> entry and updated the head pointer. So dumping the entire command buffer
> gives a broad understanding of what hardware was/is doing. The command
> buffer dump will have all entries from start to end of the command buffer.
> Along with that, it will have a head and tail command buffer pointer
> register dump to facilitate where the IOMMU driver and hardware are in
> the command buffer for injecting and processing the entries respectively.
> 
> Command buffer is a per IOMMU data structure. So dumping on per IOMMU
> basis.
> eg. To get command buffer dump for iommu<x>
>     #cat /sys/kernel/debug/iommu/amd/iommu<x>/cmdbuf
> 
> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  7 +++++++
>  drivers/iommu/amd/debugfs.c         | 26 ++++++++++++++++++++++++++
>  drivers/iommu/amd/iommu.c           |  7 -------
>  3 files changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 0bbda60d3cdc..c4ca6d9c6b51 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -892,6 +892,13 @@ struct dev_table_entry {
>  	};
>  };
>  
> +/*
> + * Structure defining one entry in the command buffer
> + */
> +struct iommu_cmd {
> +	u32 data[4];
> +};
> +
>  /*
>   * Structure to sture persistent DTE flags from IVHD
>   */
> diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
> index dc5fdc905754..bf718e7258c5 100644
> --- a/drivers/iommu/amd/debugfs.c
> +++ b/drivers/iommu/amd/debugfs.c
> @@ -103,6 +103,30 @@ static int iommu_capability_show(struct seq_file *m, void *unused)
>  }
>  DEFINE_SHOW_STORE_ATTRIBUTE(iommu_capability);
>  
> +static int iommu_cmdbuf_show(struct seq_file *m, void *unused)
> +{
> +	struct amd_iommu *iommu = m->private;
> +	struct iommu_cmd *cmd;
> +	unsigned long flag;
> +	u32 head, tail;
> +	int i;
> +
> +	raw_spin_lock_irqsave(&iommu->lock, flag);
> +	head = readl(iommu->mmio_base + MMIO_CMD_HEAD_OFFSET);
> +	tail = readl(iommu->mmio_base + MMIO_CMD_TAIL_OFFSET);
> +	seq_printf(m, "CMD Buffer Head Offset:%d Tail Offset:%d\n",
> +		   (head >> 4) & 0x7fff, (tail >> 4) & 0x7fff);
> +	for (i = 0; i < CMD_BUFFER_ENTRIES; i++) {
> +		cmd = (struct iommu_cmd *)(iommu->cmd_buf + i * sizeof(*cmd));
> +		seq_printf(m, "%3d: %08x%08x%08x%08x\n", i, cmd->data[0],

Can you give space between words so that its easy to read?

-Vasant


