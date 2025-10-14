Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA80A21ABA4
	for <iommu@lists.linux.dev>; Tue, 14 Oct 2025 02:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760407749; cv=fail; b=e6Hj4oEMyeeKbgwqKXR/jLFBgwNwGaG98pErwW+oONTsNCt8LU6JL5jqMCV+Ggl6BfvpUEO/f3rMKntDVse0CejExthNe3WtrvbiOESw92gn81sNTorM9qkN/9RVFn6TCr1HN42XI9A9cbjwHD3uwYUZX9/7vzHZUrGK0xJYtCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760407749; c=relaxed/simple;
	bh=aTJfRk1xpPZSAEtBTRDqyJY52gCKQIwnUF6btLz56So=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m6lr4Tzcb2Qt8DsJBWZ5SQP1Nsi8/6SrWKRetCOxcNlDv/74GCdV83qJUm7uywXzImCynn6mQ2NNNufH6cBJBsvd/5xE0U5OmwKZVBG+JKB48Qif4YtYJ9lRMEzxmUKjjmuICXrBGnqPKnuF5ZDocVc0Zua5ARIW/3mGlq8mav8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iCEcpi1X; arc=fail smtp.client-ip=40.107.209.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iCEcpi1X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9GFhgh/hKPJ8mnFXEds6O0/wslG0ZUJZgPemQuWuPiLsWqabzHsr+z9vK6WE/FkvA8l20LeB7CoksJhzUeED6ODjDOzCkVciVwLPF4uvmuzfqEW3i/Hx8fTheK0qJy26lr8+HKI9Kc5Ro6zs1FBM1Ff9eP3W2hX1FH4+AlKEvPplPGkElK6d8OM1r+hBFD9A36EYqD1KVFfcZG0i1mjPHgnyhgQxuJPd7JhppcHTCPwpWrY+/c8KvykMJhlPv1RYCMgnvYOSHElISPJPpdZZr3Tl12DUOXhSOyR2hP4sebkmj0m2jEcjYcoZRQzvNDVAj2rE17z9gSTJwM7TUtU9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elGoh3/cBDdYqoVRbgh/HWBOkpzFYl9K/1IvhRcIwVM=;
 b=qf/MwbEx9fWEnlFwfPsJ/yf4djrsEl+62a1w5BXrGS7GcCAKXq2zKpLwqMrZLdAM7zlljMOlAQIDYw7Dcy8Fsm+nbY640va/v5YIGPytthNFqFbT7MqH94CrusEjfN2mS4sFezkotS6y3NdwKLZ2D4hcDHW/brkT6N72sWMuG+jbLKzj1ggF9DenoRd3H5j266fY/vCuY1rZX7Y3TyXa7AMRudsNv+zPUTglOxVVBXO7afLcA7jm8DcuM5Mi0aiC3bJxGDd/JcWA2sWbKS24fEktgifr90mmC8fJ5jwvU/Aiq1NUClifPrED1fotT0YeKefZgIbYUvX9L3GKEvrubA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elGoh3/cBDdYqoVRbgh/HWBOkpzFYl9K/1IvhRcIwVM=;
 b=iCEcpi1XtCvc/knL8/INLx0nbz+Z4qHfOpC/Mwe+4BL4vQZ2tL5ia0NpgGivH8GI9My48nm29LqtfJlT3p6+Wfw96/duHC1JRjV4BbIh6cJ97OYnTrmITJrrnQGiU+V3LAMv5bEkId7baZ0SI4i49YrpsVUPUGM3363+Wn6FJsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CH3PR12MB8186.namprd12.prod.outlook.com (2603:10b6:610:129::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 02:09:02 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 02:09:02 +0000
Message-ID: <a55fd4b1-09ad-482d-a8db-5b500f31ea33@amd.com>
Date: Mon, 13 Oct 2025 21:08:56 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/15] iommu/amd: Rename DEV_DOMID_MASK to
 DTE_DOMID_MASK
Content-Language: en-US
To: Sairaj Kodilkar <sarunkod@amd.com>, jgg@nvidia.com, nicolinc@nvidia.com
Cc: linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
 joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jon.grimm@amd.com, prashanthpra@google.com,
 wvw@google.com, wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
 <20251009235755.4497-2-suravee.suthikulpanit@amd.com>
 <d062e8c8-fe8d-40a8-bbdf-0a8483c23b03@amd.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <d062e8c8-fe8d-40a8-bbdf-0a8483c23b03@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0043.namprd11.prod.outlook.com
 (2603:10b6:806:d0::18) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CH3PR12MB8186:EE_
X-MS-Office365-Filtering-Correlation-Id: b855bce8-4972-42ad-7cdf-08de0ac6a4b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bHErSlRkNXNIZ0FISEt3N2x3d1RiNkhpRFFXZWt0RjhYM0xpTzRrNURGNVYr?=
 =?utf-8?B?VE5nRDVFVURwNXBrcnU1MFFEQmdFZk1ieUQ5OGJVK3VNcUlXYlNaTjZKSEl2?=
 =?utf-8?B?VUF4cVo3RXhHNTZUK2tRVk1jYm9BVS91RG9ZKzVnV0NGb1hMMUYzOE1pK3Jr?=
 =?utf-8?B?MytkT2tZS2kvNEdtWXR3RFZHZEpDeG41bEhWa0lrK3JpYTEwb1JKMVkwVCta?=
 =?utf-8?B?ZjRrVjEwdG9BUlBwSkQ4OURIaXMxYTRtaEdvV0NVYU9Mdmk5UGZiOXpUR2ZH?=
 =?utf-8?B?YVZiaWRGZGY4cUw2ZkZvdHBhZVBIYkZZdk0xV2VtaG5qOUZaMWFGa1U3R0tu?=
 =?utf-8?B?VkdwRnhsZGsyK3hPUi9PQ1NkV1VNQjlpbDJETTZYcWRhRkR3OWFHckRhZC9X?=
 =?utf-8?B?NVpGZHdiTmczSGZLb0dIRW5HOFVZVkRNTDNSQjVlR0NxZWhpL2pKK3JiQ0s3?=
 =?utf-8?B?T0grOUpjcyt2V1BQNWxBWER5M0lUU2Z1NXJmRGV0Nk00TCtOWk5lbHFiUE5N?=
 =?utf-8?B?dlBBQ011cHZiYklkVTZhZFQ4SkhoU1lNdEZMNkNrdGVBQktxcFJFV0tUMitt?=
 =?utf-8?B?Yk4xVzZadEtLMTh3NzlsZGxQQlVCalRUWDFqMmZ3NjM4MkVBb3BSWXJzK3dG?=
 =?utf-8?B?S1V6RStoNmpCMzQ0VzVaWS9BSUMzV1FrZWwzNlE1cGRIQ0FsbUpWNFFQN2ti?=
 =?utf-8?B?d0JnMHZqbDdKdFc5OERpalQ1Q0pYM1l6dlBwbUZYSUZFTGZyaitkQmwzUDN2?=
 =?utf-8?B?akM1UVZ3VTliZ1ZndmFocnEwWFJJMGRMNERKNzNOZUxyNklyL05NZ044ZDV1?=
 =?utf-8?B?NU16b2FSOW5tRHpQTDU4dTJ6bkZmckpsaEg4dWtzditxSktKRjBKR3dhS3hq?=
 =?utf-8?B?UlhVQ0R3RklwYVd6VzY0QVZyM3pJdkR6Nnk5UnZEaWpma05tbTJCbmlBNnVF?=
 =?utf-8?B?SzRWdEdTNTRRNEdwUUNUQ2ZMK01MTTU1STU0eUMwQ3JLOUR0TUVPY3l5bkNp?=
 =?utf-8?B?ZzhtWHRjaXhlU1ltMXgrWTlpZ3FvdW01VFNOYitzdFZVSGVSOVJpTFVIdUQ0?=
 =?utf-8?B?RzdwVU03bXI2N3NaL1lSSjAydE5QWEw0aVRKc1p0aGxjeUpwOW1rOXJhVXgz?=
 =?utf-8?B?YUpBQ2JYbnY0L3hZeGhlQnVvajhPWHdXUkQrOXlWSzgwYm5SWDFEc25tZ2Zj?=
 =?utf-8?B?WW1HY1k4V2dqRWlGQUwrVXJxMU1IRm1hcER4U3BRRWp6WnVOb3ZNTGVENXUy?=
 =?utf-8?B?VnRyamkxcVhORURlNEFhUTVFRHpmZkRJYlQ3MjhWZ29IeDlNbUcrQUs1Z3RH?=
 =?utf-8?B?ekJNSzFLUWc4bVprSjNYRGpPa2JhZDRER3U0RGd6bUtZSTB4dk9CMWxMZ2pI?=
 =?utf-8?B?bjNNTW5tL29vU2pnM1grN1YvWnl0blF2cDZSUXNZdDkwNERWUGtDalFadzhG?=
 =?utf-8?B?TWZoT0hKSUxnMGtuWUUxMkE4V0JIaGdZc3FhOXFDYm9CclBTTXpldkdoL1N6?=
 =?utf-8?B?YTB3OWF0aGVGK1lLZndBanN5SVIyR010K1pUOHFvSVgwbkViNktRSGE5NzlJ?=
 =?utf-8?B?b2JYQ3R6cmw3QWFjekRWWWdnWW5XUW1wQ0h4NndzYTdyNzl4ci9RODUzTWJT?=
 =?utf-8?B?VEx2c0orUU1KSXNOc01GT1c2eVIzZExPdksxRjUrSHU0U3QyMzArR2gvaXcr?=
 =?utf-8?B?VlJXcU1IQVZDTVk3d1VHRTF4WlozWU5tdHBQb3NhMWUxSFRUV0RRV1pSRVJv?=
 =?utf-8?B?VFJBckZRTENObnJ2MmNEZXhiNXp0ZFdoWk9RcERtUjdMRTZuaUw0QWg2RGZY?=
 =?utf-8?B?RmJFSlNLRHdkTzlVaStRQ2lydzcraWdranFzOWpXcTRZZVkxcXFWOU5XQ2xZ?=
 =?utf-8?B?VXVDMU9IZWt0dHdUdXhmajdGMWFMTUd3Vm9LdU93d0MxTUltY09BNCsyMEJh?=
 =?utf-8?B?cFJ5U1hJTUhmajlmRXpzU0I5MHlaVk9mMlQ1ZlBnY3V4a0EzZTAraG1RNUQx?=
 =?utf-8?B?Y2I3YjU1djdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXlxS1BoaUpiY3RKRmUwOUR4aTdEY3Z2YmNsN0FiaGkrdURmeHZvbVZQMjI0?=
 =?utf-8?B?c0RyWTdBdzJpMVVrUXI3MjZaNmJ6WDFXSUFzMzR5aDhFdjh0V2JqN1laN3Ba?=
 =?utf-8?B?cHErQ05VeEY3UzJhTTJDenIvRHpzdGp3aGZER201Tmp3WkNZamdXQm5Mc2Ns?=
 =?utf-8?B?VGVReVJaQ2pxdmhtYlM2alVJRFRNWkNET3BVUVd1UEdOcDdkVlVnR00vck00?=
 =?utf-8?B?R1dMQmthZWx6anRBZ1F6WG1HVUg4R09CQzdNQUNub24velZGZzUwRTFoMG50?=
 =?utf-8?B?aG1GYTNXVGN0d20rUmkyK0hJSHNJazQyUy9rS3NrOGQ2MGVRMzlmdyt5OW0r?=
 =?utf-8?B?UlNCcys0d2lNZS9KaFF6WTBHRFp1dTFOVnhoaDdqUEdaMkdnL0VPSG41VklH?=
 =?utf-8?B?b3oyQWNyTTJzdFdwS0Y0QWJrdGxzeUJ5QVVjY2orNkpPSW1VdmNSUmF6YTZJ?=
 =?utf-8?B?cHdsalNiRTJxakhRVi92OFBTcEJWTlUxeUJvTmdVRUVtcDNhV2s2cVRlQ1VX?=
 =?utf-8?B?MzJYeUkzMEN0TmlRV1piQjFGSjlVWS8yNFcvVVFZdXNmZXpnMmtyQW9HVnpo?=
 =?utf-8?B?NDBjZGVyRHdpWlk3cllnK2lzVkFjRTVpOWIvWW9iVHFrYnAvV3lnT0pUbGU4?=
 =?utf-8?B?dy83U1h5K3ZNWkgvcUZ2QWlrWXg4a1A4Z2hZY2tOM2tIejV2VnpFMGJmejFa?=
 =?utf-8?B?ZGczVENNVGZKT0lxQUtPT29jYU5ySkZTLzA5NE5VVGExV2grWmR0NUc0RklP?=
 =?utf-8?B?WWI0MW5QcWtYMUk0NWlPTlZYYVhPWmVkRVhTeER1NXUxNC9MVEN4N2VSSTNW?=
 =?utf-8?B?TXBaWjREbDV4Tjc1NUl4anp2TWY4ajNSOVg1ZklUaEcrSitPT0tpSUJsZUpH?=
 =?utf-8?B?YVVEY0pFc1p4Mm9GQ08wWmRjY2NsRzJJeG0wdmZIZTA5V0dDcmVQdzh5elM4?=
 =?utf-8?B?Sjl6UkM2NVd0YysyeVFRTnhGREJRNzVhSDUvZDJLNTJWZi9kOXRGVE9oajZV?=
 =?utf-8?B?VHh0TmowaHlzWnhUbFllNXJ2SHBud0drUWNXbFFNVzdHRUl6WFhpb1EvMWZx?=
 =?utf-8?B?bFNXazRla3dhaXZ1U3hoSUlYckNZb3lEY3hMcTRpZ0JiT1EyUCtqRGEzNlpM?=
 =?utf-8?B?M3dUU3Q1ZHpZbmJxOTJ1VEZreEt4ZjRqNU5Gd3ZhYkhsMTVOUmtkRVBDZmpm?=
 =?utf-8?B?eWRDS1pPdE1MTkt1dzUrSEx1aUgzUEZwRUswTlAwTFFISFo3NWFIRGRFeDJh?=
 =?utf-8?B?RnB2NTh2MlduOWZwY3ZaVlRJOXF3Mi9Xc0l5NFdTWnpZamFhRFRVNW1hUkJh?=
 =?utf-8?B?dzM2bkJ6Y0c5Y1k0VWtuKzZ0NUphektyazdIMjdHSFVLWWthZktlK1FYbmlF?=
 =?utf-8?B?cW5FU09yOWRzd0R3S2M2WVpOS2pQSzZ5RE1OUW9qZ2NEZkxqVHpPWkgvb3Ns?=
 =?utf-8?B?TjMxdFA1aHpPRDhCUDdteVlwRnpPejU5SnkxbW1mTmJsL01LMGhVNllwZEJX?=
 =?utf-8?B?Ty9vdGwrbW1XSDN0dkp3WlpTNXZYa1d2eGo2L2FLcHNjZGZqNVh2QkYrOEs3?=
 =?utf-8?B?eHU3ckhaVmpEbHl4ay9XNUNMRTlmQmU3b1U4dVRqWFRsalo0UVl1TXF0elhQ?=
 =?utf-8?B?VHVTMDJxWHQyakgwbCszZEcxWHVLeDJieVBuMXlveXlUeC9kU1dmK290d1Z2?=
 =?utf-8?B?aDM4WWFxejFJWDlaTkdRcG81cUZSOHZmR1lQMFJDcml2MXRNTjQrVyt3WjVQ?=
 =?utf-8?B?bG5jaVBtRU5UQmphb1JkQlFjTmgxc0F4MzBtVzRCeFdxcjVlYnpmc0dUUGJs?=
 =?utf-8?B?THVGcG5YbUVFNUEzM2p3dm1hUkVhQTZ4NXlmRjY1ZVYvbVYyb3ZrUGlQZENJ?=
 =?utf-8?B?eDZFU0N4Q1lPV3k2SGx0Ujdvd3FMdWpwdytjRDhBeDVsTUhZWFBUZmV5cFpX?=
 =?utf-8?B?UjBEMnNBRGgvNit0SCtmY0lodmJjTjlqRVltUitMbHdaSzEzNEdPVkFCUDc1?=
 =?utf-8?B?b1hnbmFmaHVIYmR5NlNDMXhvZEx1MWtDek9icmNlT2xndHhaeXFSWGxTYlo0?=
 =?utf-8?B?TFZhaCtJWnllU2FxVkxCdTRMZDcxTEFsdEo3VXE4RGF5VThUVDA4citJaG40?=
 =?utf-8?Q?LWyfjkZNvfwju0GnJzaqobKjQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b855bce8-4972-42ad-7cdf-08de0ac6a4b6
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 02:09:01.8751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eas+Hkvz54Jjry4ZiebwQIOyRQ1jEtoemS3O8Z/swPf1aHFZjNBGYB/rZFZJkxQbnNwGGaJw4lNJXy0uOL5K0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8186



On 10/13/2025 5:51 AM, Sairaj Kodilkar wrote:
> 
> 
> On 10/10/2025 5:27 AM, Suravee Suthikulpanit wrote:
>> Also change the define to use GENMASK_ULL instead.
>> There is no functional change.
>>
>> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>> ---
>>   drivers/iommu/amd/amd_iommu_types.h | 2 +-
>>   drivers/iommu/amd/iommu.c           | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h 
>> b/drivers/iommu/amd/amd_iommu_types.h
>> index a698a2e7ce2a..556f1df32d53 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -422,7 +422,7 @@
>>   #define DTE_FLAG_IOTLB    BIT_ULL(32)
>>   #define DTE_FLAG_MASK    (0x3ffULL << 32)
>> -#define DEV_DOMID_MASK    0xffffULL
>> +#define DTE_DOMID_MASK    GENMASK_ULL(15, 0)
>>   #define DTE_GCR3_14_12    GENMASK_ULL(60, 58)
>>   #define DTE_GCR3_30_15    GENMASK_ULL(31, 16)
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index b57a6993179d..a9b17d31a969 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2094,7 +2094,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
>>       if (dev_data->ats_enabled)
>>           new.data[1] |= DTE_FLAG_IOTLB;
>> -    old_domid = READ_ONCE(dte->data[1]) & DEV_DOMID_MASK;
>> +    old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
>>       new.data[1] |= domid;
>>       /*
> Hi suravee
> Please update the replace the usage of DEV_DOMID_MASK in
> init.c:__copy_device_table as well

That logic should already be removed by the following commit in the 
iommu next branch.

commit 38e5f33ee3596f37ee8d1e694073a17590904004
Author: Ashish Kalra <ashish.kalra@amd.com>
Date:   Mon Aug 25 21:46:15 2025 +0000

     iommu/amd: Reuse device table for kdump

https://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git/commit/?h=next&id=38e5f33ee3596f37ee8d1e694073a17590904004

Thanks,
Suravee
