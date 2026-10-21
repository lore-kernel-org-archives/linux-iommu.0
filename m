Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792560704;
	b=GFJdvm/rgxLSAKQXjOVgBIFeKHtIHPZhgDGK0xR5CrrauuOKvMZINqwYUB5qQRWUhtYK
	 Ge3vKZ4UzYdYAWoePg8wR05bAgB4GoCGvxmHQxFSgYL/FFNYcGwI4mNUhf+8WLDd5Decq
	 Qg2y9qUUahKvuWln1KYefBKQj02qbA9TgsJZqE7l9gAUKZvX7hh9mi20+3bgL0s3/uczZ
	 8vBtnepo8gzILgkWsiTXwKyrQM6bKJ5og7fs8PlY/oSqZKEJugShrlOJo+a8p76r0pA10
	 TQPQOx/izB5bVJ27nEwE9BVN3r9NS4OpmwHP8ocREJBDBmpRSQpkTAKf5SzW2s7rL2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792560704;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=XammzzagCABMdTL9gcROoa+U/JSRXBVCNoduIxa0M6I=;
	b=vuiurEXsgnoXZwo+x39qXFGc/Xo1WWpIHmvPT7GC/2H+RrPjmaqmL/5a4S0bHrVXJVeE
	 dD007/XcB37vwZsA7n6uluqYIIWJVy+bXh+xyDj7HsehK6U9rzwfFFUn9ZZMbqhD5BrkL
	 +wBpAFVxnQSxJMTV0vXyhqBYzk1h9+S6T0jJ9r5IC/9nxaVnLxoxbfMM4y4fckUrabJM+
	 awnf4IHM8Qvp570DDLxYBI8/xvYzN/07WVKXAU3m24vZ33+zHtNTuZuUZWXabwit1Mxy3
	 k2c4jhP7xaivNawfoUQsFyG0VPBrRl9OWRCvbJ3f1ESVYIqx+7ULBbFJF2/6RcMCN0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aupJ0v8A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.17
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010017.outbound.protection.outlook.com [40.93.198.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18D7606A31B
	for <iommu@lists.linux.dev>; Wed, 21 Oct 2026 05:31:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E18D7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=aupJ0v8A
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ayNGN+I7xlG/k5BD9I5kiDfkuySCxi6uGGSt4B+Nn0FBudd2q4+/9pEi+I4YJeeRRiNBr0p53DrIVuCw3aEtU4fX1aX5/5H3jtU3UPL9yFAQU+UTDY730+eJK2EHNYd63Di5wxuon1klMNYjKIxzlmHrxhnQFB0ur42RyLqY02rH0GI3bGSNNMMJGp4h1rSSHcaq+vtsuXMmguOTN9/c7nnx4RNmjJ7R37+ZSp8bo1ujvRbi2IAl6jhaHbeGSv27M0+IZTkAjTEsUPXxsfC6m/fsmXuwbwL8/Z7yKwT+ply5LQMIFd9/3Q4volpwb0RSg/s53jCihwji2jG0zO2dmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XammzzagCABMdTL9gcROoa+U/JSRXBVCNoduIxa0M6I=;
 b=LUYBiixPoAuvgwq2SQwvTBbQiXV1y4VLisV67ngVppostJhb2gRR/4zw1p0qyCrMXwfTzHGo5jr7xEfBnCl2xR7WRNS9v9C/mCn5er4AHk3nd1sxYLy14BQSHVl6BDzpGC2VVxA+P6G58G6OW8U9t4ZzUQGH+QLyNT+Fd6XJjfq4IxPXPmNdUCndkLWqPau0kAMo5vA3Brtr4Ivf82D4USvbutjjvuVV47OcqhhCdoLYkxB++Kkc1Xeu1R8h8LKDStZzHndcaj2hyAnpJEvNWswRhR8455BCywRXN8K5a5SkeVhfeGC+GPZ7JWD+c24qw9ZQPbW5e612o2SlJ2fKog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XammzzagCABMdTL9gcROoa+U/JSRXBVCNoduIxa0M6I=;
 b=aupJ0v8A0MHh50/bN0lxj8PP/XkknHdvRW38/jAJ5jIqYhkppmJ+Q7NSf+N5Y5O4CVKuXnEYTgWGoUY4K1gD24YPoaWMF01nmFVRJd1ZPFkMvjnf9wq3bekYR6QXkr4tEKPt0zcBppSveiVtrVo10Pqg20bqT43BBbyH4ML+Cds=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 05:29:58 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0522.017; Wed, 21 Oct 2026
 05:29:58 +0000
Message-ID: <c165468c-6961-4ad8-9ce5-e0f0e8d57c1f@amd.com>
Date: Wed, 21 Oct 2026 10:59:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/24] iommu/amd: Init and clear vIOMMU DevID and DomID
 maps
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com, chrisl@kernel.org,
 wvw@google.com, wnliu@google.com, dantuluris@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com,
 guanghuifeng@linux.alibaba.com
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-19-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260930092344.5616-19-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0152.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::11) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: 3beebd25-53fa-4914-8548-08df2f3458b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Dkm5GZtUzSSUL+M48DpTvJ+p8AE0WkZrkg3EBj0a6Eos8Tww5wb9Dip8AQTieagZEYW48kRo+Nj6qr0hUVOm6rG6Ff/Pxho8dz2DvUFAbu3vGaEASMSwtwGLVzZyPLzlWXNOwHeVJXwnpLlQCr07ZGNxVOZIuc10tFkw/5zkKFiDiPF2ZKpM72+mmSjE2kMPIJOy7P9RtSAGUK5r2QWK3ZruhXLiB2WLf9iWZf9y6y/moANrzfBUCHnYFmbTT0CuHPb2Z+KdpzBIV3tizEmSRekPesJ/ejhYYt4jb4W+SyAgV5zxyDWXXiS+ouULTuLWmWTUSLX3sKn09W1veq08fC+QXOZCFaRuIFEzhhFvdIlwSM1ssmzyCcHhU4snV6x0Zfc2O2JbZLs2i75wt0LnXY4F+Zu3AAPeI4mEsji3RpD7tJ2jM7JuIjpChAms7H+vlzZDcNdj8kxy/F6w5jo2J/wWYCZfc3DMc5x3P2zOLVrTaKcmie2PabOvlWH6gtqfvWiLCJDI4RTErlg6evgnSejVo/k2Qye6itCcitz+NeQkxSCl/B0rnthK5ELvB8iqC4gcH/Av5UBdQAVUD6CCVXuoPjp68aoL91ao5SvjOIOTB0RjNpyPneP2u5IuwEBmsinCwU9WXtfQYSK8EdcHCioX7fD6t8NZ4TlP3lqKphg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnpFd1c3WGppanE1L2VHYUZuMTVpTDVUbUdndi91aDZmbEF3K2lNaituSm1n?=
 =?utf-8?B?aG1NQUM2TzhlMEllelhIbkJIZTI0WUtKUFI4NkZaWmV5Z213aDExaUE1SEFx?=
 =?utf-8?B?MFhaNXl6WlZuNUtDOVZCNDA4aThsM3Nrb1gzSzRnMlFBQmZ6TU9Wb0UySEta?=
 =?utf-8?B?WVhGSGp1dXRwUUhOVGE3QjBVVjk2aExyeElnL0J1RG5WWmR1VzJIeUpsMzkr?=
 =?utf-8?B?cjNhajIyVVEwTXBhNGtlTUwwOFoveTU2eUxHcnlncU5HU25aN2VYTjJObjZ2?=
 =?utf-8?B?dzdqNGlxUU16SU9IaTV3ekF6T29kWGtYZitSM2ttK0taTW4yU0ZYQUc5WndU?=
 =?utf-8?B?NExQakR6ZFNRNE9zcnAybVRRY09xdGFQU0RoQ1pacWhGRXJFWlMrNDB1eG5T?=
 =?utf-8?B?RTY0Y0Z2d1JzeGNwekRXVHkxZnRzTTZmanpCV21KRDZ0QjRTT2hLWUtvakE4?=
 =?utf-8?B?UTFsKy9QejRhRVBjdk1XeWowWUtLekt0ZEdWY3Y1cnVZTjdTc0xFZHVvdFB0?=
 =?utf-8?B?N0xoblZBYXlnakpNK0JOYkRaa2ZnMHh1TFlpL0V0NHM3MW1ONzVTTHdkZkZH?=
 =?utf-8?B?UVJkT01hUVV0S2FlTmJtWmJqcXJ1a3JPVFFRWjZGZDZoUVRNLzEvNWZQdFhZ?=
 =?utf-8?B?MG1kdWUvSUNaSDZrRGFoak9GWW53clV1Z2JLRU1IL250dDBmYkxaNHE2OC9x?=
 =?utf-8?B?NE9sKzZRUldvam1sYnJ6NTF5Z0xmL1M5VTQyTk0vNUhDdk1jbjVBR0VGSHBu?=
 =?utf-8?B?OHJWMGtES3VSUmVWRzJjektCeUdTL01EYnYza0pzS3VmSFpUTjZYMHJ4RW1p?=
 =?utf-8?B?Q2had3B0Ni9nWVJmNjR3ckFqTmFNWi9ScGRoTFAySDE1MVo1V3RQMTRPcE9j?=
 =?utf-8?B?aCtQQzF6V2FhSzNZekVsWnNsb2hlUjd5Tms2UGIzc2o1UzVPNnFEVkxibWNV?=
 =?utf-8?B?SHd0aXJTcWl5TkhIaEZmT00xU3k3ekJUdTljRTVPOHpHbzYyR1VKdk5PY1Zk?=
 =?utf-8?B?bi92Qm5GZE5wOG1tbmw5aGdncW1RUVJ3R3Zic21RYTZYbTVFUWVnUzljenNR?=
 =?utf-8?B?eXVYUE5mOW1xVmZzYkNJOEEvSGpNVnNlTVBPajFFZU1hT3Nsb1JadVYrREx1?=
 =?utf-8?B?REZ4YktxeWYyNTBVVXVtZ25UUjZOYjYzSE9GUHgveXRTVkRGRkx3TVV6OVM2?=
 =?utf-8?B?eVdFNGxwOWV6OHEzZ3hvNExiSnZHekNPc0xaZWtRS2dWeWpqc3dxZS9aZ0Zh?=
 =?utf-8?B?T1lUdkphSnUvZEJCY2dEWStGRHg0VkRCZTNyWktEYW4wUTVnb2FlTXBUSGY5?=
 =?utf-8?B?YzFtSHNQU1lKdkpnem0wWU1HdEtyZGIyeStOY2pBeHVia2tTZzlrdDJ1UHlH?=
 =?utf-8?B?M2YzN1dzcTJ3TE0wRUtQajE4ZzB2MnpESUIyODhvdFRyQmsrMUd3RGFvZjNS?=
 =?utf-8?B?bFYyTkg3UDdWRE13bnhKK0c5NlI5TUJIUzMxaDNsRFptNy9OMUFKUWtEckdC?=
 =?utf-8?B?TERqNDZteWdnOEVYQ0tFOVo4cGVXWjltQlY5eXpSdmxPRzlMOE1oZzBWNHNT?=
 =?utf-8?B?ODFzcGxDWks1Y3k4am4yZ1hLRFo0Vm1iMVhJOFFSOGpxVGp5Q2MvNENJenh3?=
 =?utf-8?B?WWJWUFV6ZzRZaDMrckc1RzRKNEFEY0Z1b3VrL2pEbmVHK1Zab1RpR1VOYTR0?=
 =?utf-8?B?UkhtSFhJUlhYcmcxdmZlaWVmRnhiY1E0SXJ0a3I0ZC9UaHZaeDRNYm5uSTI4?=
 =?utf-8?B?UEswQXR1dGdUSXFPQzZhUUlWeDdGaC8vZmF4ZE0yVUhEZ3hUejRTaFZzN0VL?=
 =?utf-8?B?cTY4Vm9odk9WM21GcGZBQmloektsZXpqSXFCY3J6ajlscEpyVE1xai8yYWdy?=
 =?utf-8?B?SkVGdHNOQnExK1kveHhRSlJBb2JlUk4wcWw4V3Y1b2dFR3kwV2VmdnNMSW1B?=
 =?utf-8?B?YXQvS3h0a0NZN3RidktWWGU5ZEhFM2h4ZDlIUFJtN0REaEVzVmpCU3RUd2pt?=
 =?utf-8?B?R0MxTGZUSDRxa01BNlBiT2x4YlE4MFhLV0syVG1iYjVydUZudk1tejk5eTNZ?=
 =?utf-8?B?R2FWcWZFSm9XeHFvV3RvYU1rek83TlpabEc0VjA5dzMyd1RxS1ZTdUtZZnM1?=
 =?utf-8?B?WUsvZEYxVXJkMWIyYlM2OVF1RW42eFNMRDU0VS9pZW1nbUpOdktjNHlzVkJ3?=
 =?utf-8?B?ZzZKZlNFY1cwTmNaMHAzanVKUjRadEQyak1Va3FLdUQyQ2VCYlZLMk5HbHZN?=
 =?utf-8?B?cGR3WVJ5a3JFSUI5YTFYdzRGL3owSTZHZEFTMWdUWXJHTHJiVnFPYUtrU3pP?=
 =?utf-8?Q?jQupzdjFAMa14iTfL5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3beebd25-53fa-4914-8548-08df2f3458b6
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 05:29:58.6141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfW0QUKNzRh7HdcT8Q40yUpDe+7lEduWuSwrB1KazjJBoeF1/o00nw7BTKbE0wdpXbf69VGfZhYDn6E9U4BZ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338



On 9/30/2026 2:53 PM, Suravee Suthikulpanit wrote:
> Before using a vIOMMU instance, prefill the mapping tables so hardware
> never sees an unknown guest ID. Map every gdom_id to the nest parent
> domain ID, and write every gdev_id with hdev_id 0. Init cannot be
> scoped to IDs in use; INVALIDATE_IOMMU_ALL walks the HW table.
> 
> Yield vfctrl_lock every 256 doorbells so the 128K MMIO loop can
> resched. Attach cannot run until viommu->ops is set after init_one().
> 
> On destroy, drain CONTROL0/CONTROL1 WRITE and unmap. Do not rewrite
> the full tables: that would start 128K DMA writes into pages about
> to be freed. vDevice destroy and nested_domain_free already restored
> idle entries.
> 
> Skip VFCTRL access when CONTROL_CMDBUF_EN is already clear, matching
> viommu_priv_unmap_free() on the same uninit_one() path.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/viommu.c | 90 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
> 
> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
> index e2275d6b7442..2f299a16d113 100644
> --- a/drivers/iommu/amd/viommu.c
> +++ b/drivers/iommu/amd/viommu.c
> @@ -7,6 +7,7 @@
>  #define dev_fmt(fmt)    pr_fmt(fmt)
>  


.../...

> +
> +/*
> + * Prefill every guest ID so hardware never sees an unknown mapping.
> + * Map all gdom_id to the nest parent domain ID, and all gdev_id with
> + * hdev_id 0 and QueueID 0. Cannot be scoped to IDs in use: none exist
> + * yet, and INVALIDATE_IOMMU_ALL walks the HW table.

We don't support INVALIDATE_IOMMU_ALL inside guest.

> + *
> + * Drop vfctrl_lock every VIOMMU_VFCTRL_PREFILL_RESCHED doorbells so
> + * the 128K MMIO loop can yield. Safe on init: vDevice/nested attach
> + * cannot run until viommu->ops is published after init_one().
> + */
> +static void viommu_prefill_mapping(struct amd_iommu *iommu,
> +				   struct amd_iommu_viommu *aviommu)
> +{
> +	int i;
> +	u16 gid = aviommu->gid;
> +
> +	if (!viommu_vfctrl_ready(iommu))

Why? We will not hit this path if vfctl_base is not setup or command buffer is
not enabled.

> +		return;
> +
> +	mutex_lock(&aviommu->vfctrl_lock);

May be without lock as no one  else will call this until viommu_init is completed?

-Vasant

