Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012054.outbound.protection.outlook.com [52.101.53.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A71330F7E8
	for <iommu@lists.linux.dev>; Wed,  5 Nov 2025 10:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762339858; cv=fail; b=CrvNuOKqi21+Cre7Wu60PZQ6J8JssyB9PFueVy7LfzVNAR3DgemuZ/kEF9r9yXlUXZFibwPjk2NHGHKPAcy46dULFiaqujC0z4OSW6WfB0EzAI2+evQoGCFiH/tJhaSUEaBKsSfMW8gaWORTMpe6O2tAiucBq1juNI99XkHyZyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762339858; c=relaxed/simple;
	bh=JWCdYocUjlIzkfGRNnIeNwo2V31jNTX8Mwt3UQLBgzk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QGpja0oQ8aKfmC2SHsk4CEj8lT3jgcimn0aitduKUUSQdrg1LI6fXVqTveo7obeFNoHCxSPFK1fJqf2ytLQO/r461jTzVRycDL566juD+2BsSY3rwOvTsEW9YlGP/Svn4Q4ppoPDH66vLLkm6CfjCQOXtx5F8Y0ul75Z+3R4s9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wEeAO1eO; arc=fail smtp.client-ip=52.101.53.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wEeAO1eO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpyDBXReeJRuSyY/6UY3skvmdygJ0M8S+5GWXxIEIHvQXQO+oUEn4Drqi5BuuzOKCQd7bFuRvVanqb9ez3TV8z2pjxdIQLKFmaUtWfUc6wrmAVddPtWw7oqmmlwfikZvreX6CMd7kbec8TSTpS6LLNCGiGG1OQ4s1X8RaXK66nsgM5W4Wuh1Ydld7qq/caA7YXChdlEZ74nQTA9hxhqQXT8V9hallMEB/qArrs3AsLRFf9fJ5ocTpuUV4Bw3Wal+odLtVAN+9Kz9TOcKuFiZw162iKovxg3KJfS0DuQoSbxe84GkjL+5Csg4jGVw1f2yNXKgAy4KFds185N+r2tXGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xs8+b3QtAIbDv7MWdhCDshOa5bgqkNYsU8aSxYhWy7E=;
 b=YBeSEo+Uq4GGA2MWgufGJr418AsU/fm3NIjH7SiaLVfLJRpgpF4oWJ2YnmHOAPN5qkYsVqBlBGjhs6MF2LyAgGRhcGQM6uDiY8UFv6jbb1GJPWNlMg35nNpVEWoWcefMd6gzGwg+1W5gZSceko2W/MKXtGVS6TvzUCKxZ7EKRTELvFbr1ba/1HVxNpDi1Y3nDVN8lPKw0MC0yORLewtBOBG7bhHtxROw0Z7CUKHL8IhtlnuP34jNUcYggF3S9wGQpk/p/SZT7CLcYbEWwJlykDgDuqXx7Cp6BBRYGOfHRCAFPYmOEuJOp2SfyyzhNlyEB8LD9olsxbNZe5+vibZ7JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xs8+b3QtAIbDv7MWdhCDshOa5bgqkNYsU8aSxYhWy7E=;
 b=wEeAO1eONvakbJ0swbkoYLEgpUL5by+LxtCraMZ5/3Mawvw65yhbHJSaLxFMmfepCl33XNvuTgUE/mqVhcZzVrxhkt6raY3a8ZkkdZENLC4G2QMkyA8JAFvVb9NuZwdbi7s1HFkT67uZAx8fzizP+Ch4pXIHRHTCwiuoI5glsec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DS0PR12MB9727.namprd12.prod.outlook.com (2603:10b6:8:226::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.14; Wed, 5 Nov 2025 10:50:54 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 10:50:54 +0000
Message-ID: <ce25701e-87cd-4e9a-aa5d-c1962ffdd3b0@amd.com>
Date: Wed, 5 Nov 2025 17:50:44 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/16] iommu/amd: Track host Domain ID mapping for each
 guest Domain ID
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
 will@kernel.org, joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jon.grimm@amd.com, prashanthpra@google.com,
 wvw@google.com, wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-14-suravee.suthikulpanit@amd.com>
 <20251022200819.GE262900@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20251022200819.GE262900@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096::16) To
 DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DS0PR12MB9727:EE_
X-MS-Office365-Filtering-Correlation-Id: 623b67f1-3c8b-49de-624b-08de1c59315c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzN6cXdJUS9MQ3cyZ3dweUE0dExEZUJCMzhxZFlPNFNuRjh6OHhmYVR2MjQw?=
 =?utf-8?B?d1FXRHk3Q0x3Q05WbXB4T3JOS01mcVZGY2tpV2plNmx5ZjhPVDI2UWRyLzNS?=
 =?utf-8?B?TWJ2d0hJbHVvMlVFT2Y2eHpPTTRHNEF1bHVWcXNQbmJUUXRsT0RyZ2FsOXhk?=
 =?utf-8?B?YnN1akorNWcvVERjSkR0QkRFa2lxS1RFTWQyUjRCcUwveDF6ZW9OcDBMazNQ?=
 =?utf-8?B?YlhpdkJHUDIzYnI3cW1kTDNpbGpIdlJ6QXh1Si9UUy9NSHJLZFU4S0ltQ0s3?=
 =?utf-8?B?cTA3Sm1Uall0bGplYy9ldk1vQVl2UUZyaVh4Y0xlR001K1RiVjh4MFcxQWcx?=
 =?utf-8?B?S2tlU05rc2MzYXJ3d2tIRFJ0c2ZIRWdQTzV5VkYyU1pTREFkUzlaZEhXemdW?=
 =?utf-8?B?V2tKOVJGUUQ2OHQ0UmowZjBVbE1ZTjNDU09DZFlaNzMyM29oajlRQTRCZmtW?=
 =?utf-8?B?dmc1VHY0dEhvZUdpZWdGaHhwUVRoK2k4N1U1bmNFelFlZnNkSjkyRzZaYkZ2?=
 =?utf-8?B?YTBPQ0J0NVlrU0xxMjhZUXBmSjNkbnZpNmI3RmVIWWNxd3lZVFFtS0VzM0d0?=
 =?utf-8?B?azdYWnd6LzFpbzdRblZvVEZaVmxVL1NDb3NJTkFLYzQ3dHR0T0pSbTFQWGdY?=
 =?utf-8?B?K2FyY0lkeFRxK3dsbiswREtrckFhUW9MYTBPNnBzYUUwWCtCazlZb01TMlJG?=
 =?utf-8?B?OWVsbnkrMjM4ZWE0NzFyMEkrMG1NWWdCbTBWZ1J3RWhmb3FkOTFxUGdON091?=
 =?utf-8?B?QjRveW9TQWx0dGJWU1hxa3J0ZzFXRjJEd01ZSXh4LzFNRWtkTEtUZ21kUFlp?=
 =?utf-8?B?bWFpNytHTzlVUGwyZG5INHBvZmxkUkpZSzh3NkpIekV3QmdyZkhqUEdxMFVO?=
 =?utf-8?B?bGVIcHVzODBRcEplRW41VUpFWmpMbC9HWlE0R0ZCSHpuTmFTQjZzenZ4cnkz?=
 =?utf-8?B?OVZvVG1VNFNCNTF4RndYK0h5VnkzYmNmWk5wcUlJenZGc2txZ2JCcVE5b1VT?=
 =?utf-8?B?OFhDMng2ZE1sOXZjUkNyOFIxY2FLNWEwZFdic1VpWSt2SlV1QWZOVW5hSXBw?=
 =?utf-8?B?UVIrOG1kYVljU2FSa051bTZtUkNVcmQyUElkdnpvNUFrc0RIMHErdFY0dUUy?=
 =?utf-8?B?U05FYmN0Ry9oNkNWRzFKN2NjRkhNKzdlUGdRSURIVEdtMGJnRVc2WTdHekZq?=
 =?utf-8?B?dkNJUWFOVHhyQjBzTW1zZ0xkTllXbnZzK0ZaK0lrOW5UYnkyNkpTVVZuVVB1?=
 =?utf-8?B?S3lsa3Z0V0FuUmlzU2JNM3ZpQ1QvZDJPTDQva0YxK2pMQWR6QVNNMEw1Y2pa?=
 =?utf-8?B?WFBUWVN3S2kxZ2ZaVDBIY0RKOU5FWEcvZyttS2xtaGY2VzdTRXkwMXFWbTBu?=
 =?utf-8?B?TisyNytyczVab1dOejN4QmJrVG5ydVpZRkZ4ejBPbGt1VHdLRFpYMFpObng5?=
 =?utf-8?B?aW13c0RWZFA0Y0FPbU9yaUxCK2QyWlJuZkc1VEhmRHV4L2lONVJpeVpmellx?=
 =?utf-8?B?L2xQc2pSRk9tcVhrWGxqWmNzQUVQd2dTVjQzclFWTFJMc0FkTC9waWhlajlx?=
 =?utf-8?B?L0d2M0xxaUpTSDc0bVBlUFpOVGVzY2J5UUYyNFdRcTNvOTNWY0Zib3NEZ3d5?=
 =?utf-8?B?UXFFTW44bjVFdnRpanBXaHFYcE5hSG02VTMyR3BvKzBmREV3clNmb3l3Qzht?=
 =?utf-8?B?dWp6cmtEM3JVOGNNRTNTK245SDI1MUl3bmRRRDZVVG1ENGo4WHhqMHZOamJD?=
 =?utf-8?B?aFdiYnRiQ2F0bXBSSjhXaGdvdTd3NFk2amc2Y3h3Nis3UjZ3a2dVZmFIOU9y?=
 =?utf-8?B?Yk0wN1d6bUNGNDNJc1JGZlRjSXpCUURVcW1uNTdqSzRZUVljdTZaYTUyNWNQ?=
 =?utf-8?B?TUNuN3hQeWZBbnRvVmp5M0MrT0liaDNON1luQktVNWlTKzZFalBHanF0T0Yw?=
 =?utf-8?Q?U7ojtSgK11NZTReOS0T2RJlWDU+TG2d0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aE9lQ2VqZndYOXBiYmU3YjF0ekxoNllFSTJJUXQySllSajFlMlBJQnEzSHlx?=
 =?utf-8?B?OG8wRlVNSzNmZDA3ZUJVOGlpTjlCNzdqVmIrYTB4SGNvMVdta3gwSWdDS2Er?=
 =?utf-8?B?OC9sQlVFeXZBODNQK2JpT3Z0SEx0b1BMNjdjUU5jRm9Id3VWMkdoTGZ3Z1or?=
 =?utf-8?B?cFR5OUpHZTBjNEdPTjJlSE8zb2F2a1dXZi9iWXAzTGZ5QkVMUzdZSm83UFBU?=
 =?utf-8?B?NzJhck10bzd0NEQycXlxc243RnRnM3IxVFBFZ0NQVVhudzNleVdzVkRsS0g4?=
 =?utf-8?B?eERCazBudy90Y0lqWTI2azZQSHNoTTQ0MktrR3Z1V2t2VmU0VSszNGY4Ykxj?=
 =?utf-8?B?U0M5MFM0Y0ttWGlPWDN4V3dKOStmdzhocUt5bVo2cTFsODVGd2hWTW94VU1V?=
 =?utf-8?B?eTFXcnVaNC9GOS9Wa2ZNbEM0S01zYVZxL3N3d2VlN00zOWZOQ0JoaDdycmlx?=
 =?utf-8?B?M3h0dHpWcE90ampER3g5dlZiNXlwTjl6YU1SSVp5Nzh4aVlaWXFPQWdQR3h1?=
 =?utf-8?B?eGsremdUS3d3eVJRVVhpdnk5ZDQxNEg0TzdoVG5NbHlUeDF6OTlSemhlcjdq?=
 =?utf-8?B?bWVxUENwc1pUOS9iKzJpVEJNZWIwU0l0cFVuUmR5TzY5QW00OE9HNWkyMXBN?=
 =?utf-8?B?Ri9xSDVzeVF2MCtqU0x1d21HQkhBUWRPTkV3VzNyaEhhYUNjZU42OFRGZk5t?=
 =?utf-8?B?bUMvZ3NkMStnREdWUnlsM3R6eU8wWlpiVmQwU2V3NHJxODl1cFRHZmtPZmlN?=
 =?utf-8?B?c3ZKKzdZNDlFc3Y5R3oxQmtLRGdNVTBEbkRkOTlhYzNvVVMwaU1GUUpma25R?=
 =?utf-8?B?Y0pDZGhXT1krcXljbWVhODNYZEpkSWVJUjYvZlI0cnpQSW5yOWg0SVN1ODBI?=
 =?utf-8?B?MVhESEMxNUg1cE5Vdnl4Q3dtV1g2bzBWUFR5Z0JHWkFpdTd6Z2ZlMkxabWVv?=
 =?utf-8?B?VFNQUnNNYTFjTXY3a1V5ZzVxSVpjWWphUjVrenVUUHZhdHhkRnBNc3A2Tndp?=
 =?utf-8?B?bWl1ZEVaVzFSU0x6YStsRURjQ3EzL243YzVlQkV3a2NJbVMwdTcySHJtUVo0?=
 =?utf-8?B?aFRITldmdkJSbm16c0xFRVVqdWlDN0paSnpkNldjaVJYRTNiU21mc2RJbTZ1?=
 =?utf-8?B?UUM4WlFVMlRvanRyMXM2WFJhRnhZcDJPcGJRNUcwemdWY3FmM2l3dGx1RG8z?=
 =?utf-8?B?WUczdHMrZ0xrNGJEUktyMjVHVlJLS1JxN21meGlwOEZFOUphK2FnYVBZSDRy?=
 =?utf-8?B?OW8xanhDbXlEd2kvVStlZEt1VXBBZ2ZReUdUUE5QQTZtQjFWVGZUZmJtMjN6?=
 =?utf-8?B?Z3oyVVMwMzhCTVJnbGN6aWFDdVkyQ3R0bWtKY2NjK0tzOWE5UFdxdG51M2Nh?=
 =?utf-8?B?RzlSQ0dOUU1QS1JoS2EzQytwdjYzSWdaVFI2LzFWMVdHUXp4WVBIVVpscTZZ?=
 =?utf-8?B?OG9tRHZKTUpxNWhBSzUrcXNpc2J4ZElacjBMMUUwSys5MXZocnBkYWpheitR?=
 =?utf-8?B?bFRPTjZuRmh2OGNJaXRWWEYzQkMzSVNwMzJrNkVKSnV3UDBHVTlXaFpXemNt?=
 =?utf-8?B?aHRzeFpVRUN0c3ZqTytWK1Y1Z1hDbkcrcFYwZXUxSmFJZEx0eU5UOWJPMlov?=
 =?utf-8?B?Z2lGMWp1YXc1UWVCaVMyTE1YWFl1c0xiNVFPdFlHQ1VEZ0ZZTlRmTzk5L2oy?=
 =?utf-8?B?SkEzays2Qm9tZ200TmEyMWlGN0Jtd3kyejhGdC9UQnkzd29PSWxmMkY1WUh0?=
 =?utf-8?B?ZGNzdGZSalRjSytseUhTS3BUVnN2MFdqdWpxTndTUFkrZ3puNkl3b29oamxE?=
 =?utf-8?B?TUtsQmN0dHVtTXFDUzJld1NkekdZdkZLZ25lblI4VnZKbm1QYWFpbGtPQmp0?=
 =?utf-8?B?cjltSTJPczdiZWxGUmpCYkpEMENiL3YvaythMHZ2RWN2MEo2RGxWTzVQQ3Qw?=
 =?utf-8?B?N25JQW81ZlZuNkpHL05Wa3FFWlVrcFZMbmVhaVJadE10M1BaaXZZY1ZKL3Fa?=
 =?utf-8?B?ZURROFpwajRMOGdST0tQQklaVUlCajF5V3oxb0RTSmZIb0lZVk5QeWpIYmRY?=
 =?utf-8?B?V2hXaE1iQkRwR3RWMTQ1MnBLb3JUWVBkaWxHMUloK2U1K2FGc1BLaGRJZHhm?=
 =?utf-8?Q?VpBLqt+GsJ71THbhaGnKcdq2W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623b67f1-3c8b-49de-624b-08de1c59315c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 10:50:54.1969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFr3hADaTSCFBsK/+3qfAGbxji1H3xg2BgtMto9ISLqxuE5oS9w0+wEokFn7H0ps/auDuXztCSeoxqA+ek35lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9727

Jason

On 10/23/2025 3:08 AM, Jason Gunthorpe wrote:
> On Tue, Oct 21, 2025 at 01:43:21AM +0000, Suravee Suthikulpanit wrote:
>> Each nested domain is assigned guest domain ID (gDomID), which guest OS
>> programs into guest Device Table Entry (gDTE). For each gDomID, the driver
>> assigns a corresponding host domain ID (hDomID), which will be programmed
>> into the host Device Table Entry (hDTE).
>>
>> The gDTE to hDTE 1:1 mapping is stored in the nest parent domain using
>> an xarray (struct protection_domain.gdomid_array). When invalidate the
>> nest parent domain, the INVALIDATE_IOMMU_PAGES must be issued for each
>> hDomID in the gdomid_array.
> 
> I think this should be stored in the viommu..
> 
> It is a small unrealistic detail but very pedantically the API allows
> creating two VIOMMU's from the same NEST PARENT domain and if someone
> did this then each of the VIOMMU should have its own private gDomID
> number space and own separated xarray.

Actually, to support nested translation w/ HW-based vIOMMU support in 
the guest w/ two VFIO devices on two different physical IOMMUs, it would 
require setting up two iommufd_viommu structures (one for each IOMMU) 
and share the same parent domain (single GPA-SPA mapping). Also, AMD 
HW-vIOMMU use a single domain ID (gDomID-to-hDomID) mapping table per 
guest-ID. Since the table is indexed using gDomID, it requires single 
gDomID space per guest.

In this case, it makes more sense to store the gDomID-to-hDomID mapping 
in the parent domain since:

    1. There is one gDomID-space per guest and there is one parent 
domain per guest.

    2. When host issues invalidation for a parent domain, IOMMU driver 
needs to issue an invalidate command for each hDomId used for the same 
parent domain (on each IOMMU). We can't do this if we store xarray in 
the viommu. Otherwise, we would need to store a list of vIOMMUs per 
parent domain.

> Allowing two VIOMMUs to share the same hDomID could be problematic
> because we don't know the PASID layout is consistent.

Not sure why PASID layout matters here?
>> +static int iommu_flush_hdom_ids(struct amd_iommu *iommu,
>> +				u64 address, size_t size,
>> +				struct protection_domain *parent)
>> +{
>> +	int ret = 0;
>> +	unsigned long i;
>> +	struct iommu_cmd cmd;
>> +	struct nested_domain *ndom;
>> +
>> +	xa_for_each(&parent->gdomid_array, i, ndom) {
> 
> This doesn't seem right.. There could be many nested_domains sharing
> the same gDomID..
> 
> I expect this xarray to have a struct like
> 
> struct gdomid {
>     refcount_t users;
>     u32 hdomid;
> };
> 
> And each nested_domain will go into the viommu and either allocate a
> new gdomid or ++users for the existing one. Inverse when destroying a
> nested_domain.

Got it. I have new code for this and will send out in v5 soon.

Thanks,
Suravee
