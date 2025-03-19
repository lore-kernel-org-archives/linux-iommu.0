Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D208D1D88D7
	for <iommu@lists.linux.dev>; Wed, 19 Mar 2025 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403067; cv=fail; b=ZklsFMGs9+kAdpj+eSBLuxQxVGm7sTnqw6OUEyq3bs5BP5NbAIIITbQ8g98lhrz8oQe1M0A1F8ucJjpoEU99sLG3Ip4H8ZNqg/Awv/eBVxUtomHHB/pvdHR7HC+KIwDAojDSBTFHU63FKPVodC8geKkpNRtTemgkXePKpYHO3pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403067; c=relaxed/simple;
	bh=I+HIQG5vjykBTgg5hvpXlQu3Imi4XHnRiN1McV5bxjQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q3HTfCoW4YvI1kD2jyMhU8TRnKngFy0+lYmlKb22pkno73HUmQfIeDsNurWK9nemWP92izUuglaxty2/LdlEan06Iw3lHPvp9xprCLCBGZbrKLGjKQHprHMWcTMc53jfeq0DqHKwqX85HdvJayggEnBSaUYJM55eVVkE2AkGlog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PQnp56FA; arc=fail smtp.client-ip=40.107.96.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PQnp56FA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5TN7DB0AGHSpevmJQjHUF/zlh614BQmeaXN5Bnm/lc3dXzmwyFsuWTOST3vt8z8Zp2Nx7NFJ/8TH71TvuFeWFkhRCLQq+zolM2o4C08j5WpMMbbpTnMGmaZHMTwsxaCCscCrG+Dw4l+8A+eLDdQ63EHLYs5Zheo3g6slj4h/0dJTDvSN0KGdPvyg7OTSRUVw8E9TX0zr8rTpG6/2z6Oic+jfIvfUzDoKcAEubu/caKUFldulzrWNefGoz/T4aG65b2A9mI8Nv75PxXK5EuzLZrxNi4eGNtnWX79RvAkx8zy1v5cpoc1akPxhkklEOV5SmxlrSVR7qI7xH9DWKyEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nk2YdUrKeGsWfa14at6Ky4FP0zbyxC+jxsy7C0nYGs=;
 b=K/0VyK5RuForyjDNIYRLFoM2U55I+epNHVfQ+y7h55kT2mOHzI2WNZovfUP2k1YFOvpC/rGWi4BGR/q5UEP1omszYF+rCiWzvxQzxe5vkdCNc1eQQphY2we0tlbSt/EGC10W3grM8XkQX3MXWyJEedylahYvGh4PrwmftSFrPYNMr/FZzOkkGaIwk2xpu9Gfg3sT/7CL4UhoARHcDBiXC6UUADtu8R7DHCoyLxAP2YsX0TPOHEGiZqxXUS9K2yiTaJCQysCHJnK16oAmbwe+72DTHxKdy4+5yun0DC58bT1ZPo8gIIOMoIsLSpHrVj6p1lR8jePz8IrzbRriP3xkcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nk2YdUrKeGsWfa14at6Ky4FP0zbyxC+jxsy7C0nYGs=;
 b=PQnp56FAhQLuGAFD7nqlQC++sz3y+Mfl9oebbdJ1bmVpUzx0TIPk/oV++EdWeop2J8wcJv7cTfxh5nMKBmvt+biGLsvYosQwYOdztTnr0ndRubLxn32W5y9+KlovL74GantaUA4SeZs1zxeWZrWF7OVggDUlj6GmQShXLlCAFi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.34; Wed, 19 Mar 2025 16:51:01 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 16:51:01 +0000
Message-ID: <f1b0721c-b518-4bf6-9de9-f09369b85d0c@amd.com>
Date: Wed, 19 Mar 2025 22:20:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/8] iommu/amd: Add debugfs support to dump IOMMU MMIO
 registers
To: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: suravee.suthikulpanit@amd.com
References: <20250317115830.3416-1-dheerajkumar.srivastava@amd.com>
 <20250317115830.3416-3-dheerajkumar.srivastava@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250317115830.3416-3-dheerajkumar.srivastava@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:54::23) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c216908-6364-4ada-5154-08dd67063a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akZQdG9lM3pKbmtZYmUvZVhkTGpGU2IzcjdlL1Ayc0I1VkZCTFFaVTM3NHB3?=
 =?utf-8?B?Y2R6WVV4NjVQaU9HaTUrL2ZvcWJ2YThTaVFKQTJtOTVWaDZRREhaM3hRMlY0?=
 =?utf-8?B?RjFDYXRBR25hTXd6dWZTZVFFOHIyRDJaNzY2L0N2K01RK2FLbE5LZGNLRFpH?=
 =?utf-8?B?Rmc1eWRuRjdTRkJpWkJsOEZjTXFLR21kOXNXdnVCdFBzem56eDNuN0ZQYXFM?=
 =?utf-8?B?dnZ4anoyS0EyNEVhQzBhVFZLK3laa095eElsN1N2c2dlTXFvN2VLOTNpdy9t?=
 =?utf-8?B?MkxWUkNyYTFFcmlHcVNTcEM0UkdZdmswMm0veDRNNWN2U2NOajNSaTRZQkh3?=
 =?utf-8?B?ak1ENXNQVG52VVZjbEFHYldlM1d1RlE4QVpEZC9Ra2QxdHc1NUxVcHVISDMr?=
 =?utf-8?B?N0ZPZ0hFOXVaeFAyemF6b0J1dit4ZS9BM0Q1K0hSbHVmMUk2dnM0V1NvUEZN?=
 =?utf-8?B?MVZTMm5uekdIR01HeURFMkpQZmt0QVlRM3VNN2NiZVR0YlNFYWIzQzZCdXQx?=
 =?utf-8?B?N3hQUHQ3dDJCTVZqQWw5ZWZnWWI5blQvdXMvQTJCUXN4TXFOSVpzakZDd201?=
 =?utf-8?B?NktSVVhCTlRtQVRDWkRWUjcxc0pLU0hVYjlpeTQ4WlhFN2I4S3hCVm5GMnRP?=
 =?utf-8?B?UTlnMjFNUjZtR3dKZmdSbjkxYm9PMlZUZmJudUdNaXIyTllQZHBUQ25MVmdG?=
 =?utf-8?B?ekNRYWhRdmlJQ25OU3hTT1lwbGZxU1BxTTBtYXVxdkZHVDlpY2FGUkcxUHNy?=
 =?utf-8?B?TUY0dXBLYVRzRHRzR3VVVDJ1V2JnVUhNUWFDaWFWWlFVWUtxMENjVmNnTkFJ?=
 =?utf-8?B?MzRpSkRmdytKeVFFRDQzYzBicUJtZkUrK2kwbUNISGF2NEdxdzRGMlhPZDhJ?=
 =?utf-8?B?RVVVWkx2YThWSUVTZS9sYTYxU0RTeDd1SVpzNlZPRnc1MmJOV3lER25qbTNa?=
 =?utf-8?B?RjR1QjhsMzFyUXVJNXUyNmtacXdBYlJjRUQxVmk4VmQzK3IzZDNhNEVMdm5z?=
 =?utf-8?B?aTMyOTBHOGZKaUhqbXpsbVpWK1J4YThZSC92Y3VoaHE4YXd0MkNrTzh6emx1?=
 =?utf-8?B?RzY2eFBwNjdaZ3VoSEhUd0dXYzlWakI2WlVROS9HdnhPTkxVKzFFbmtsQ1Fo?=
 =?utf-8?B?blBKd05kRDQwYSt4dHZBOEVlTllnZkhzalNYNHR5L2NoOGYxVWxUS3o1aW9a?=
 =?utf-8?B?SkpjVHBMT0FLL0tvbDlWMzJLaUt5TCtQalNrS1pLQ3pMNGx5UG56ZHc5UTEx?=
 =?utf-8?B?VEZVemhDTkhRNy93dmdtOWMydGNOUWdsMjBReHhLc0RreHFLK3Bxekd4SVU2?=
 =?utf-8?B?N1JPOXRsMU9YcVdnVGFVY0VLQ2wyZE9jdXQrZVFicEVITmNEMldIYmZxUVZX?=
 =?utf-8?B?TlVrYjhtMXZyaGRIclNHc2dTZmoycE5TbHdXTUt2eFF1b3h5Y2tHRW00OWor?=
 =?utf-8?B?a2NWWjYrMkdENHBaN2FlWkg1QXFCdmQ4VnkzYlFuQnJlL2dadTVTSi9ZaXNN?=
 =?utf-8?B?Zk0yN1RoK3dDL3N1KytrYko5MnhNUDJONlBFbUxicFRKcnFjQ0d6MHRGVjZJ?=
 =?utf-8?B?R0NKd2ltNTN6RWZMeWFPczI3cEswWGRtL0JKdm1aUHZqREtXdlg3bVd6U3FG?=
 =?utf-8?B?VTdDMEhPZGxHMTlhTnVsclhTMHJPYjBtNkdZV0lUUCtEczJnWGpXSnR2OGlv?=
 =?utf-8?B?LzFJRlFnT01XUEU0aVNZcUVhc0FrR2RhYmtrNnpaTURuQndtWDFNN1lNSzFW?=
 =?utf-8?B?MlpjaU0wSFAvNnR1VVU4T291RW9pU2ZmVno5RGpFK1BPbjdBZ2JDZ0tEL0hO?=
 =?utf-8?B?cFdBaGVzdnZnR2o1eXRVUmtGc0dJekxVVEYwNXNXZy9YNGhzVHRuRVVjZ3g0?=
 =?utf-8?Q?3PIpNbUngZJm6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlBOSzAxQnU0U0pvSnRrSktId1VJY0tzZ1lXQ280Wnd3VkxjTkZLWlJ3ODlJ?=
 =?utf-8?B?ZStoOGczYTVjMWdlVkpGWjkrakk3YTR1b0ZRVmQwYlZBTHl6ZCtiZmVId0tK?=
 =?utf-8?B?L282VWkxN01uaWdITXJMUitwd1d6ZXVKYkNhODJrT1BYVkZDTTZqOFlHUmc5?=
 =?utf-8?B?MEF4c1FvTlVpUlh0U1d0eStNWjBJaHU1T3haK0orTEc4QWJPUzMxeWpnUHZN?=
 =?utf-8?B?anZKK284bmdYWDMybkx6NC91cTNmMnRqWkE2dlhPcDdEcVlReW9ORytzcTNa?=
 =?utf-8?B?bWJFR3lsVDZSQmxBaWVVVmxQYkJXOGVrL1RMUU91SVcvbXJKVHdSc1RwUFFX?=
 =?utf-8?B?ajRTSUg0ZnBBWCtSdjk2a2l4SHMwSEoyQjhXa1VnTFBjTGNvNXl3MWl3UDFa?=
 =?utf-8?B?cGNUMVU4N29DaDl0YlNUWSt3OFR4SGF3aTdZMWYzQnd3N3M0MXplKzc3bnVH?=
 =?utf-8?B?b2dyT3VDWGlPLy91engwUllPa0NFUFB5eEcxZjVRZ1hML0pWVHh4cUY3L1M5?=
 =?utf-8?B?ODNhZVZKbWY4VXVsY2RGZVVnYW42VkRUajZrSlZSZnpTaWxuakNJVmhiSWg5?=
 =?utf-8?B?RVNMcG1CL3lob3NDNGY2UFV5dHBjdExoM1EzMG5nd0lZVFMzUG92YWVqNWl6?=
 =?utf-8?B?cThwcExFeGtyMEdpcW5aT2ZkSHVIK0ZRR2NVdFBlZ0dtMUtBcFZPWmF4LzJ1?=
 =?utf-8?B?SVkrTkhzWTUxamRpOXJNZ2FZVEJTYnJPckswZlVmSFpKSVJCSVF4TEo4NVpL?=
 =?utf-8?B?NVk5VTNzcWZXSWEwUmI3U3BqU1Z3UkFxamdrQksyekdGMURwSFdtVUhNcGQ2?=
 =?utf-8?B?UnJVUTJKSE5QL3Q0QWdRWUszUXl5cXY5azNlblRuL2hHUkVIV05tNk44d3V5?=
 =?utf-8?B?dlh3aTNmNWRHZXhFM0w0b2dUVXFYTEZ2RVNaQWVRNTlKVEZDeVRKUHlpQjBP?=
 =?utf-8?B?WUYrbVMzOHV3Z1pIMUdyWi9NZEdwcy9DMklpTDR2VmhWbFN1cHI4Tmxmbjd2?=
 =?utf-8?B?SklzVWJqUURpbUQ0RzVXSkRoR3c1RzlFeWdJeGg5cmNhWTh4TS9wQythTkFI?=
 =?utf-8?B?NE94eXpmUHVNR1EybXJtK0w0Y1FBZXNOTHlxQUt3WlBXRCsyVmdFeVFVS0NL?=
 =?utf-8?B?OHpPV1lTVzZGTG1aaDIzYkpkYmZlTXdGQjBTQm01NlQyRHh6OXpGOUtuWjA4?=
 =?utf-8?B?dm1hNDdxWk5OZmI0czhTTEdOdno5SnFIOUhlbkVpVUpsWStWYVlXOVhUeVJT?=
 =?utf-8?B?Y0M3MWRGN2FxOGUyMG03NEVhMGhaUi8ydmlYODcrRUsyOXkzQ0xzaFgwUDFY?=
 =?utf-8?B?QUNtc1A5VCs4emx3N254NHBWeW9NbVArWHUxQXFYM21aRFROU0N2cU9NWDRV?=
 =?utf-8?B?MXg1b09QbkVtdStoWkRpd0FWV0o0VTVBeXc2RU9KVC9QY3R5WDdLZDVDSFRB?=
 =?utf-8?B?d3FzbFd2YWlBQlg4dTVSWUFrQzZCQVFhdEV0cWExbzBnWm03YVdPeEMxS1Na?=
 =?utf-8?B?MkhzcElBQzJreHRkalB5aklvVjhpczE3bFVKRjZGVkhWU1RmVnIwL3htWWw1?=
 =?utf-8?B?VHRObTE1ZThVQUgxc2picDYvZHI5SVlYaWdEMTZHb1NqUUFBNHRibDZDakUw?=
 =?utf-8?B?VWRJQ3dYZ1JGc2FCRkkrVFhtc0tJMXAwbmwrSHZmUXlEdTdlQlFzbWdsRVd1?=
 =?utf-8?B?eS9mS1VnK3dyNmxPdXN4b2pkbDJsWGxQbjlVZG1iMWdKQ1YwOU8ydUpYN1lx?=
 =?utf-8?B?VmJPTmY0bWp5bWNBUHJzMXNhTDZsdHBqMXRIL1dIRzdlYUYwRTd3ZnF6OWpJ?=
 =?utf-8?B?UythR3RLcWczejVZOHJsTGRCWjZIYW5Kbm9mMGcvSzlDS3BnM1Y4eXgxbXBw?=
 =?utf-8?B?Rmx0ZTVHWmQ0WHRQY296akJjWFAzMCtYekMvRjBYZEdsRVI3aGd2M0ZRWjRt?=
 =?utf-8?B?ZnVkUjJoRS96NVBTTnJUaldaYkNabG5PdHdpUVIrZFZod3V6L3JMZ2swcFRi?=
 =?utf-8?B?ZTNFanpiaHp4VnRPZGZZNlZ0K0tqQUdsTHFRWW5qdVoxRnNKdjNINmwzQWVo?=
 =?utf-8?B?ZTJxQTJ3UUlHN1FodVZFeTJpclJaM0pHRkFXMDBoYXlsc2Mvc3IwaTduWE1y?=
 =?utf-8?Q?Q8pbuxoDmm6vlnkPmAuv7Kf5T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c216908-6364-4ada-5154-08dd67063a83
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 16:51:00.9073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ICCbbr/kTcGRnKWa+eEJfRRnBxi/OjtFS/sFKLBTI/50NmCl0Bgj0vO15tNNR7VWi7uqnFEm3buNU37BD2N58g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023

Dheeraj,


On 3/17/2025 5:28 PM, Dheeraj Kumar Srivastava wrote:
> Analyzing IOMMU MMIO registers gives a view of what IOMMU is
> configured with on the system and is helpful to debug issues
> with IOMMU.
> 
> eg.
> -> To get mmio registers value at offset 0x18 for iommu<x> (say, iommu00)
>    # echo "0x18" > /sys/kernel/debug/iommu/amd/iommu00/mmio
>    # cat /sys/kernel/debug/iommu/amd/iommu00/mmio
> 
> Signed-off-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
> ---
>  drivers/iommu/amd/debugfs.c | 47 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/iommu/amd/debugfs.c b/drivers/iommu/amd/debugfs.c
> index ff9520e002be..c61d52420c5f 100644
> --- a/drivers/iommu/amd/debugfs.c
> +++ b/drivers/iommu/amd/debugfs.c
> @@ -15,6 +15,50 @@
>  static struct dentry *amd_iommu_debugfs;
>  
>  #define	MAX_NAME_LEN	20
> +#define	OFS_IN_SZ	8
> +
> +static int mmio_offset = -1;


Somehow I missed to catch this earlier. Here you have global variable but mmio
is defined per IOMMU. Shouldn't we track it per IOMMU ?

-Vasant

