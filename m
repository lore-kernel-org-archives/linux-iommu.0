Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DE9284686
	for <iommu@lists.linux.dev>; Wed, 28 May 2025 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748434790; cv=fail; b=toedxM8ikDKNae9Yn9fWEAhzhcIw2zwJaoy1J0zOk0GRySt6q75F1mDmQ6zf4BKO8dJc0OUhLoG3hy8MHy4zm5Z1ma7f1DlDHSc67RlUuvYS5Bw3OvCE2pKwu+8VCtj3xt1/pjZgcspj3s7aEU+cvy0G2JUCKflTpc9BoqWHHqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748434790; c=relaxed/simple;
	bh=PKnZUI0S1Hwcf2YefGW39tIgjICUneh3U+tHMOMwq88=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JgPudiCgCsdh9Tsag6B79yIfLf63rmaRkZi8CTBhQ5vz/Bt7hnnMw5eonXubq5F/SACuNCe3BV5dR4pthq+7Fi2dx0nRhFgYWg0S68DcUxKatDyBsp6972xeM6vc35yqd4NyZJrhrUfOV8qVg2vlMK5S/iOya9GXi+2vT/pdhko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P6YEZ4Bc; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P6YEZ4Bc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QwRUr7PcdZsU1Nv0s6RyUFn/Dhluq0ft73PDgY2lkUm7yKnRnBamATDG8m08WBcroM+M0mGB6x6vfsWZP1DVKsjJpHMGjGmhz3rAsVokXsBL14OlruSUsuYm+pVszhuDDleYkb1HbIkWZILR3bRRYaypjG/3/a8bKYdjfXLjAv8HY4SZl+cxKYYLlYzsbwUgNABoK0pxMVnzd7awK2nmzyugTTx7wsoBs1zhkoIAIL+jwBnnb74p8on9k+vrMPcJXmbUJ0PNMPySXKFNcVO19vzCwEKw+QOOq4Qxtbv//j2g7OUuj+ccY5OctrXK4UDzLL73wz7y4mQaGMdwb675SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ske/lFEp72WN1jFB08e2/mgg7xrqiFl83Lorzp0Lvtg=;
 b=YU/L5oZ8eSpgG+o2gPyrVEJA8j54P52Rs4Nh2e9lLKlkaFzVDfylEm93/mTYQP+MWNY0Sa+GRo3XQpgOwLf+w+mn2Wp3QApIzKlvtAaT9fr5dJM3ALo8kaIqvaCAtY27BODEVkxCwimJJrADIAPh/4tP2S/5rQxS2TuXhuoVtLTv/4tej39FT/uzL5nBWH3v25V57k06KsXXfp/f2VwmJ2LUXpMWW16+OJYRgdV0qJ0TnzsUW849os4mSRJ4YC48xoxWZ1o+YR6k+eVCQgBZidtNOGWqj3PkJYiwPjWqnGpSQ5wN+qz2szFuELzUM6E0hCxKiBLHFoxuhjga5lGoYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ske/lFEp72WN1jFB08e2/mgg7xrqiFl83Lorzp0Lvtg=;
 b=P6YEZ4Bc0VeOMvPA1uk74Va73KyJ4xTftDeEp6LQB5OuVWayBasq+55tRM7ol0WHnt6HbQ/nlwJXodLWM6oElJw7q17dbmpo8rxLGDO/v0XnkYOw/QQ+OCCKz63t/xVXmDrHX40qAP/eBWTItewMoBBTO3lTxGhY2a+S+bWd2dQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB8499.namprd12.prod.outlook.com (2603:10b6:8:181::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.29; Wed, 28 May 2025 12:19:44 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 12:19:44 +0000
Message-ID: <3b38fc9d-83c6-4db8-8a83-eb4265796b03@amd.com>
Date: Wed, 28 May 2025 17:49:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu/amd: Add HATDis feature support
To: Ankit Soni <Ankit.Soni@amd.com>, Joao Martins <joao.m.martins@oracle.com>
Cc: iommu@lists.linux.dev, suravee.suthikulpanit@amd.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 David Woodhouse <dwmw2@infradead.org>
References: <cover.1745389415.git.Ankit.Soni@amd.com>
 <6282a5c349812a311a67a8522dc5e4aabfe3ec3a.1745389415.git.Ankit.Soni@amd.com>
 <596ed125-c995-4e2b-824c-b7929c852754@oracle.com>
 <g3xrnjfs6zekogfohud2s7kdvphx43e6mdh3vfpllynrwokxwf@vvetz2j2nrai>
 <4f04d596-685e-4e48-9038-8aee6c927ebc@oracle.com>
 <lpbeiyyzoxuankxzgcms2iwkoydvj2vcpv5jftiy26nkslliwr@juykyxhdwwzv>
 <deb1603a-96df-46d8-9cb5-86121f334a88@oracle.com>
 <m5ageqedj5otmfo4yuld4es72esfmlc7vb5htolj5pcffurjl5@mi5xemcd4fgi>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <m5ageqedj5otmfo4yuld4es72esfmlc7vb5htolj5pcffurjl5@mi5xemcd4fgi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWP282CA0002.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1e6::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: d6433657-d2cc-4ef8-66fc-08dd9de1edad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGdKMDRoVU1wK2FnZUthM0R5TlZVNTlqN2NsSnh6VzlsTUE1SmNmSldyZyts?=
 =?utf-8?B?clovQjBZK0Ezc0IrS05kRW05cU1TRG5NOGZ3ZjM2ZWpOVmRtQTRQa2t1TUNq?=
 =?utf-8?B?eXpHUUlWVmFPKzY5QTljVGFZam1MS3BHaXRVK20yMndGVXk1VVY3Q2pFZWhZ?=
 =?utf-8?B?RDNocmZKZkhJV0dWQ0N6N24vdGduaWp1cVZ1QnBHVEthMTJ4dXlpdnJGaEJp?=
 =?utf-8?B?S2x6TnB1dUttWSthcW9xRld5T053dFFKQ0RxclROanZZdG03TWwzeDlJSC93?=
 =?utf-8?B?WWRCTU1IU1VzT1h3bjFDckw2cGJ4MHZweFBRLzRoMEo5bmY0NFpFS1ltYSsy?=
 =?utf-8?B?bllJRlBVN3ZlcFlFWG9HZmdRYVh0VVRMaUhhTyt1NGI5aXRkNk1IS2xSYVpX?=
 =?utf-8?B?clZGL2JSRFoxTVRZUCtkRkxjQ1ZVeEpqeXk1WkFBUzI5U1hzbW54UVUxMEJV?=
 =?utf-8?B?TGYrRitWRG1hZVBEbytRbUVsVkVSNzlKczdRY3NFd21lN000dFRISURMVkZL?=
 =?utf-8?B?L1ZGYnNrZTRLMC9LUTR2cmRsQmRCaFpyekZsdzdWSFJqMkFhNERBOTh1Sk1p?=
 =?utf-8?B?M0cvcnBOQXJYMUVOMlhiRnczbGZ5SWRxaUJXRWViT2lnSmRLQ0g2MGt1RFhx?=
 =?utf-8?B?dWFheG5jYThlU3g5dEFGVjNDQU9VblBUQURhSnRDd0NSTXFabDJncUF5TE1W?=
 =?utf-8?B?ZkU3VThjYkF3aDhWc0x1VFYyaUp6WGtJc3F2QmlySE4ySTRlaFFOWk9sOWRo?=
 =?utf-8?B?K1UxUndiZlRRTFZXV3lUNDVMOUppekpPOVg1SEdkb1N4MXZOUWFTWVVFN01T?=
 =?utf-8?B?Tk8zaXQ3MzdLUXBVZkZLLzg2TXN2NkhVSFA0b3laTU1zVmxFc3V4NVVseDAx?=
 =?utf-8?B?KzFCaDlMclJXMFluUUlQRXFXT0JqSWZSNmRlWkFRNEtqSmlZVFVEaWt0ZDFP?=
 =?utf-8?B?YlBjN1d2eDBsN1VBcmJUWlVza0NRbE9RYzFRSFBuSVpweDQvdGxwaUFCcnI5?=
 =?utf-8?B?ckozM1NhYTJQQjdCYW04bmdHK2hBTlZaL0pJSWhlNlZ2M2hpWmd4Q2k0WUEz?=
 =?utf-8?B?SWIyMnRQRG9yN1dRYW8rMHRsWFJ0WU5FYWJOd01JWkNQNkF1aWo1c0lMeUQ4?=
 =?utf-8?B?dVJxUUZwMjdhYWdrenJmTElMTXhnMDNYTHZwZW11cXh1U0E3ME15TDloRUNj?=
 =?utf-8?B?YzlHUmJJRzJiNFVOUG4xNW1aRGZGbHlqVStERzdPN3ZMU29PaUdHVFNJcGhi?=
 =?utf-8?B?bjJLMVhzN0tiTkxFQkVaV2JpcElVcFhYR3pVR3Q4WjBZTHpSUHN3OTVzYWQx?=
 =?utf-8?B?K2I3MzhUZ3hrYkc4SHJqM2Y5REVuTFZwVlVUc1Y1aEdLRjlZYlM3czZOaEpi?=
 =?utf-8?B?MElWQVR6NW9PVi9NSG56ZEZOZjhNWnlzNVlQVXFuSGZLbjIwT2ZlWGpTRDkw?=
 =?utf-8?B?UG1VVUJFQjcrS09kWXBORjI4bCtsK0VPUHFEaEdtUzVHbTlKdXFQUnJLSzli?=
 =?utf-8?B?clZUUFJrQlRmaUlHNkVxOGYxM1A3dVgrQVk4RlZjNm5Md0JhcUJEWDJPMzJa?=
 =?utf-8?B?Y0JDb1ptTHM2b3czM2ZOOUNIQnRGVXgzVHhTSUJLb3NtVXFPbGJXQ3p2bTRt?=
 =?utf-8?B?Tm1BbUlieXRNZEl4eTlZSEx4MjNvM0FoUkZGdmF6eWZ5OFNQUE5RU0RhN1or?=
 =?utf-8?B?NmhoSGxtNjQyTktFUWljQjdYbjN2YXNkcW9zdkhxNDAwZHhqa252U2VOa2Z0?=
 =?utf-8?B?bG1IVlFsQnppc1AyemYraGRwVkhCTnY0QlVzSWptd1lZbHJOMWIyd1lZaklC?=
 =?utf-8?B?TEJEYzFjUm9CcEIzNXNQbEFYZHEybmhqYmJmVTVFTE1vVTMzbm9tVENUNjJ6?=
 =?utf-8?B?TFJuMktVcEpvZUxhR2FYa1I2elNTcW10SnY0QktHZUZKdnUyeVkvSW1JdHFj?=
 =?utf-8?Q?ATP2H1hueLs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTRiNEJQUE0zRmF0a2FpSWhIaStQNVhyaUhNcWRKSTZ1Y1pqeDdQZE5MR2lL?=
 =?utf-8?B?cVJRcUZralk1bG94ZFZ1TUVWcVZjY3FTMmRJbDNpcmFtT0VyYXhQc1BCa0ty?=
 =?utf-8?B?a1J0ellSR01pTTUxTkJMbHhVL1Y2R2psWWZ2Nzd5VFdhRy9pY2o1REZJMlh3?=
 =?utf-8?B?YWtuZjljU1l3T05wTHJCbDJPbFFxQXBwSUJNQ2lia0RxMUlQZmFqVU43SWZx?=
 =?utf-8?B?NmZzVTZta1BoalE5ckhLMnFyOE1LWDE4Mk9EN0pFSFBURjZFTSt3MmFVWGxF?=
 =?utf-8?B?czFVdklmdXdLbUg4bGZBeUlqU0lDRXdLbU5HYXRHZzBVWVJkT1VvZ0xVZmtU?=
 =?utf-8?B?bkk5WEdUK0FXeHg0bUk5cE4rNDJkTDZiakEzSWV1ZmVYcFF3dSttUE9tSGkz?=
 =?utf-8?B?R29IbURWRE9OeGVwTW5CNVMvMkptc3d6SWkzRG9pSUlSY3Uyc2pSNnZiaHNE?=
 =?utf-8?B?ZzIwMEVIamxzVHhkQjZyTnIvZHFsVUxWY2hLQU9mbFhLOG1jampEcmpmQk13?=
 =?utf-8?B?KzhKNjFPUG9xdHZmbnRaZjltOHhXa2UyMWh5TDdqM1k2R3dhMkgzUitwaVMx?=
 =?utf-8?B?VE5vNDV1N0V1aHZWVitxMUtFcnB2ZDFtTnBaVXRXekh1MFp3Ulp0dUJwbXkr?=
 =?utf-8?B?d01JanBQR0V2NW81THl0NHJqOUhmTUFpQ2FPZEdJa1U1NHpMRXE3eXdIaDhS?=
 =?utf-8?B?SWxsTC9hNkxFeTB0bmVhNzJSRzgrT083Nk9obEpjTGovT1gvUk54OFBkRDRu?=
 =?utf-8?B?b1QxdXRORGd0OER5Q2U3WlJKcTFyWkpFNEVpZ1hVWHdkTkRzVVRZamxQTDVm?=
 =?utf-8?B?STdEeTE1MzRaT0pDT2dyeUl1SEtsc2Y3amJCU1BXakdzUi9oN2F0bTEvRzYy?=
 =?utf-8?B?L3BaVDQrWUxJd0Y1bTFKdUlhWXU1RFBndnpRc0psU2JlVUVVU2FNU1poQ09J?=
 =?utf-8?B?SnhEVldPL1VXeGpRYkVOVlNRZEtmanl1eW9wWE9Salh5cjdqNEY4WDE3dEZH?=
 =?utf-8?B?TUwrOEEvZzdhTFJuNnBtSnhWQ0ErVFFZNityNDRvNGwyeE16K1ZNTUZMSVlZ?=
 =?utf-8?B?VzEwZUE4c0pWMG1PdzhrU253eEkwUllCaGRvOFVtWEJvamVDYSs4b0Nvc1gr?=
 =?utf-8?B?QXZqS0hYSmdLUGgyQlUrNm5OTnRUUktoWW9laEs4L09zbGUrMGl6dnluTWd5?=
 =?utf-8?B?dWp4Z1BYcWJmT1hORGxzZDlCWVRRR0hkUmY2cHdWbWVCbWsvUzd1eFBwOENM?=
 =?utf-8?B?YkRTSGVXc0hDV2ZvVVoyS0dEWmg0Um4xcjJibXdid3R3TUs2SHBTeDZteDk4?=
 =?utf-8?B?SWtqSmt4bHlkVjBJc3AzcjhkUjNCQUNiZ0MrbEpOS3NiNStTREN3aTRSS2xs?=
 =?utf-8?B?N1kxN1IvQ2QydmNIRXJjaGNZdDNBLzNadmlPdjcyUjJwZGphWWtWN0lwcWI0?=
 =?utf-8?B?Sm56dXVjOTIzdzNMd2Iwa3V1aWFKNk5yV3d4bFEvQVJJMHlrUWlOaVcxM2gz?=
 =?utf-8?B?Mjc3L3o5eEF1RDFERS9jdDhQQUFDaWJqdlEzSUZGS3Ewa0hIVFU2ZGNaOURQ?=
 =?utf-8?B?OU94TE91T2R2UnlGTWNEL3NoYVlsQUhRa1dma0tBSFlqenFWb3FBU3MrcXVH?=
 =?utf-8?B?WHBuVTRabFZyN3FTUHBMUEdFOXJGeklBeWcwL09jRGlNclZsWE53b3htRkdG?=
 =?utf-8?B?WnVmRUVXcGJDTk1yWVZkeXlhTVBxUGczcDVMQytHK2o0MzJPTm9vNFczT1JW?=
 =?utf-8?B?M2VMbVpMd0tib1B6eUtiUUg1cUE5NzJpdVgxdTRWT3N3emw1S1hqcG5jZVZw?=
 =?utf-8?B?TzRrOXBoZE8vLzVQWGdIckxYNWliUmFHREdLOGhMQUNhMzZ0UllNcVppV0lE?=
 =?utf-8?B?T1pteVVsWjRmNnZrckVlcksxVjV5cjhoWXRWSUdDNVVUOEVTU2JtUFltMHlZ?=
 =?utf-8?B?SUNLRFArWGZnNThiSDNNMUkyVVFtYmhodElyL3Z2SzQyVUZLUDJFYkNFVGJp?=
 =?utf-8?B?VFJuaTdnZktLKzZ4S0NWQWNPZ3VzcDBvZ3ZNTlBob1hCYzg3NXlVUGQyYWdG?=
 =?utf-8?B?ZTJHZU8yZFlCVXkxTnp1TlpaK3ZSL3FVMXhQZmxRQk9zZUNVTGdIT25lYkN0?=
 =?utf-8?Q?0wXipjt64qifFCpyc1eZjhHuv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6433657-d2cc-4ef8-66fc-08dd9de1edad
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 12:19:44.2125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7hBshf8tmbN+wC/9fvH2KXL+vfIBMfZUvEA3bb+SAY7NhCQ++krP0RmRPg4t70Pl/sGzCw2/zaqgrWOWr45tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8499

Hi Ankit,


On 5/12/2025 12:00 PM, Ankit Soni wrote:
> Hi,
> 
> On Thu, May 08, 2025 at 06:03:44PM +0100, Joao Martins wrote:
>> On 06/05/2025 06:12, Ankit Soni wrote:
>>> On Wed, Apr 30, 2025 at 12:41:04PM +0100, Joao Martins wrote:
>>>>> With intel patch you mentioned above, it seems that it is mostly handling 
>>>>> "second stage translation support" disable, which will eventually disable dma 
>>>>> translation. And in AMD case, HATDis bit indicates host(v1) translation is not
>>>>> available, then attempt to use guest(v2) translation, and if both page
>>>>> table modes are not available then disable dma tranlation.
>>>>
>>>> OK, I guess it makes sense if HATDis is v1 only.
>>>>
>>>> My other call out was that when we disable dma-translation all together (aka
>>>> both modes), then we shouldn't advertise the IOMMU groups (internally and to
>>>> userspace) by not calling iommu_device_register()/iommu_device_sysfs_add().
>>>>
>>>
>>> Sorry for the late reply. I had cross-checked it; if the probe fails,
>>> then IOMMU groups will not be populated, and eventually, it will not
>>> have significance for calling iommu_device_register()/iommu_device_sysfs_add().
>>>
>>
>> It would nonetheless populate a ivhd entry in sysfs needlessly but with an empty
>> devices list (qemu diff at the tail end for how I checked it; it's only missing
>> the ILLEGAL_DEVICE_TABLE_ENTRY event being generated, but enough to check the
>> first patch with sw iommu) e.g. as far as I checked:
>>
>> $ find /sys | grep ivhd
>> /sys/class/iommu/ivhd0
>> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0
>> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/uevent
>> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/amd-iommu
>> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/amd-iommu/cap
>> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/amd-iommu/features
>> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/devices
>> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/device
>> /sys/devices/pci0000:00/0000:00:05.0/iommu/ivhd0/subsystem
>>
> 
> I was assuming, since iommu is still active for interrupt remapping,
> user may need info for cap and feature using /sys fs.
> @vasant: can you please suggest on this?

I don't have strong preference. But it looks like intel skips populating sysfs
properties. May be we can match the behaviour and skip populating ivdh entries.

-Vasant


