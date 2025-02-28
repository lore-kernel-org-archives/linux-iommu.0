Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FCA8F6B
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 08:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731938; cv=fail; b=FhAgOt/lJM72R8Gs1fU0LywLeCcH4jbA5e8OQ8/teplijkHQ3MpQb8t1RjlQLBNmgmrX6c2yNeDXe18Ggi47khPDntdQQjn77hNVHUVT6EVzroI8GcK0Olcjwm5Xg5zQoxiLQOO6Qc9IituHj7ZmGylOzK9z7KeREaoHL6wgb8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731938; c=relaxed/simple;
	bh=vFUcMXPmW45EHgC1Cbco7aVm7aMrB0iSkS0GcFlZnO8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YpYGipUjXcEZk2geh2lCZgxFnfaTBOLi8oqmuRepW8mqb88HhGTjG32mghN0ds6j33O872AccAMFj0lxh9zZv1/2fLxFKhew4SYltCvf6YPpYIZ1p9pPAIIG7pcOUddKazmMWWkYdEelOSxD/mqrwnqGZFERUWG/7zphANRBn+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zOylJM88; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zOylJM88"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SiRnaQ1mbsTznz8MJ0mA2rPeskiFE52LZcogGxSSvVrKrDs85s9BpnLv9asOzpRUOo0Y8fgxcrOecgxuGX6P8VEesUOIe2WsfrgeOFOv/JxNMQt+oj8RbYlhQRw5jFiSqogpIojUgxSfR/+q2qOHP3p6cL7Vr3FIR6t1O7Rz+KrV9kerVLlLCmoTVvqSqltu8N65nEF1+nkdiRDx4htTjqATjT9dJoVecO/pe/OKJsSZIm2xyj5fZTZMOIZpYyznEPG817JyrsxjHskYKtCi4PtdvRUdVzTMq2wCi93sas8E16H8XSWb0fcdZBgPW1/61qVVlsruuh+foDDyqtvbXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+Q8zBgvwBCTcQc1xPTmILcy1P9Z5M9NtahrZBGh3H0=;
 b=Bsy3YGrXFqiuUpGtg63Tdax+x9d9GTw3TFFVUN1ZYpbeSFdV+99WjWme5/kQE87l6Vx4eCb8rhSIXRAOUJpMkYzCdTDb1r4tIFv2BLfRV38puOYQxV5JSacJXlEbKDKSz+t2Sh2Z5M1rDHMRvUz7rVdPSKOZtkixsHi9wLT++Mb+J4uZj0MAhUN6hIPDWZKbUg3pl1lu0k2h4oQN2GdnVhDrAtMrFUQE6LrTk1hBRm6BNA/z1t3qe0Zjy92JowyzDyEeZeKef+gU/URzG98R/fUNBATvLb1LnNw7VemUJCW8jqJihAPPJyHpCl4yvVXv9Ick0hBp7A+dfaRjGHRBtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+Q8zBgvwBCTcQc1xPTmILcy1P9Z5M9NtahrZBGh3H0=;
 b=zOylJM88xf2rgCtt7hpcltQRGXVLc/IOrdDsceLQVgKksI0kCJzyGIMFDd+x2LuGrfJ8UiGoJcbiFmswgji7eqLWm4uJ36dmqGN0fyn00bfwXxkrkS9kn0JZ9Y2VA5bUnl1jp5UIb39SnQmB8cCWFVXtQWrKoTo37HP81aHDA7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.23; Fri, 28 Feb 2025 08:38:54 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 08:38:54 +0000
Message-ID: <200ea811-8173-481f-8056-a10e51b958cd@amd.com>
Date: Fri, 28 Feb 2025 14:08:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Robin Murphy <robin.murphy@arm.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <b630b6c0-a25c-4230-8abd-a48b7dc27216@amd.com>
 <BN9PR11MB5276B090C61D1F059538AF7B8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <cc4cf4ae-2d29-4747-b655-df841661b82a@amd.com>
 <26fa08c1-4a3c-44a6-aba6-a35a0f308bc8@linux.intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <26fa08c1-4a3c-44a6-aba6-a35a0f308bc8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::14) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 514a31ca-f310-4437-a3e4-08dd57d35578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajJKNWowTnBEMjR2b3ZGeDJQZExPVDBWdDUxY0k4NFZXek9rNWdhemg3MmMy?=
 =?utf-8?B?TUV6bWozVDVISzRrRlIyTjlEeUtsUTJkYXlMdVVYZWpaMThpZXRCdkdRdlkx?=
 =?utf-8?B?ZE8wdDNCSFVwRUpmSS9Cb0oxZnRXSmNFQjR6WDg0V0NSNTVTVm5LU3FCa0to?=
 =?utf-8?B?Q3owc3YvMmVORjdEaGVXMmlFZE4rNnpFNGl3M3ROaG1rVFI1V2pDSEV6S01H?=
 =?utf-8?B?Rk5pakpUdlhTa0VldzdINldtemY5UExnZ3dtRFQwWW9Jb0tWUW9WbUNwOVRI?=
 =?utf-8?B?ak9RY1lFeEJ2Q0FkcldxSlQyU1hGQ1V5dmcwZ09KU3JtamRTY2hYREZ2aG1D?=
 =?utf-8?B?bWdYV1hxSFlSSHpkTDRIRXgzKzBOYkRHWGtuZStGaXRRckk1SEdNNHlLaEY0?=
 =?utf-8?B?WGMwOE52WUFRZEl3dFF0QldOUzZUaStRbU1PYktscEFXdW9tQkJzbzV4eCtn?=
 =?utf-8?B?bkFIZlpUc2diUVJIWHI4WmhjWUlNTm1zUk9JRHludUVJRGg0cjM3b01hRzlF?=
 =?utf-8?B?SVFzL0J5VUR6bkMzNUNHZFdxZHg0eEs4QTQrT2ZBUXRwS2UvWTNxd0RrR3p4?=
 =?utf-8?B?Q1Fmc3BpRkdtcmQycWdZVHFNemVSVzhJYkQrRHdZMzRzKzZNcVVpTHBscHhn?=
 =?utf-8?B?eW1IM2JYc1FXUEZJYlpzVGk4czRjWGFramE1NWpwTDhqTTdyUVgyZVlRRHp4?=
 =?utf-8?B?bFJPN1IvdndGSFdBdktjY1ZDMXFQbTFvMXlpcE5BZVFsVTR2WmJUUjVjSUJL?=
 =?utf-8?B?S3BFcmRvMDBsWDRQcXp4cXlWTENtWjBLMVMyS3U2MEJCNVZWRW9HcUNINExK?=
 =?utf-8?B?aHA5M0tLelZCTTNoR2RWQVViUEpjT0FGMEQ2cWEyUnVFY0lhSzlRVHBEMlY0?=
 =?utf-8?B?T2Z6blhBV0NvV0dFcGllS1FVV2ozdFZFRG9UalpVWWVpVk8zQVRxcXhScE5x?=
 =?utf-8?B?Q0VQOWU1Zmw1WVc5cHJaS3puSDF3eVRIZ3BFb3lKQi91SDF0TEJJQk9RUkwr?=
 =?utf-8?B?dzlQaXN5Nzg3S1d6QUF2QnBLc0FCVVlMbGUrZHZrTnpwdksvWHhoRWlMa3pk?=
 =?utf-8?B?TWc2dlI4MHZvOWlRcTluQU5zTkVGRS9mbHBvMnVQWnNjczdvdERtUzJtOGcz?=
 =?utf-8?B?SFV1MTM5bUs5eU1mcmxBTnhhT2dFdTlGelVhd01kaHRnR0NkeStnV3FqNSsw?=
 =?utf-8?B?S3dSODV5UWNPUzBneEhzak1WUzBFamlnM3c3VHdwUU84Q2pvS1ZKeTArS1gr?=
 =?utf-8?B?c2JqMWp5K1p3Z3hKNlVKK0xpU1UwN01YV011engyU202QVJRR3hzZThKY1JY?=
 =?utf-8?B?Zm82R3FGeWxyRElSZkJwUkNGSlFFdmZOYzZ3RFVwckVNOHYvSUp6REppS0tv?=
 =?utf-8?B?MC9ONUpMakk2Ri9ieHAvNjJWays5SEEzQW90MkhaS0R1NXc0R3VnVnVoUGMx?=
 =?utf-8?B?cDJVMTJTdWE3NXJudm1YZ29BcmNZREkzVGpHK1AzZW5YQ1J6L3MxZDlLSFds?=
 =?utf-8?B?ZkZrcllaMjJrRXUyYUIyZGpkWlJvNzNCR0RDanlPVlNDakNqVXJHeitxNTdQ?=
 =?utf-8?B?S3RkUitQVFlUSHp3dXFpTDNXaFZkdFlEdTloSVQvTWdWWVJNNGpmc0FUd1F4?=
 =?utf-8?B?bi8zL0MyVlVkMkRCTmh4NHpUVEFpbHowb3RPRGhLbTQxRGtTRi80S1k0aEdt?=
 =?utf-8?B?WmVBRFA1dzlienhTWU1GZmdlK1ZFckFWSU5CcXpZWEVlWC9jb1hscUVWeGgy?=
 =?utf-8?B?Um5WSC9adUxhWi9TTUtEUHRnU0tKMWsvQ1NSeDczT3pPNmFkbWJYdldRb0pw?=
 =?utf-8?B?dGJPSFlhNk9SbEZyMjhKWnp4OHorbDY3dVZGcGV4NENGOFBwdXlMMVNzcXZO?=
 =?utf-8?Q?YorMxPaXpChq1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXoyVkhBMW5XZ1NHM0EyK2Z2ZzZqSWdia25IMmhvOVYzbWlxWk8xUUhiT2hB?=
 =?utf-8?B?MEZ0alc5V1NldkpIWFlsVnhjemRrMURCM01aaDNybmo3dXFoMUFTSmNhRGZw?=
 =?utf-8?B?ZzQxUG52aW5PRXV5MmpkZEFpT0c4M0ZUZkdzdmtlMGdkRDE5RzVwMlBpSkFo?=
 =?utf-8?B?dVRhV0s1WWgyeDdhNzZWM201M2VlY0xGbHlwVWxUY2FFdk9Na2RCcWJzcEp0?=
 =?utf-8?B?a0R3Z3VVdStuUTZRUG9XTjBRSGhrZGtGME5CY3ZOeWlJdWRCYmU2SnlSc3Rv?=
 =?utf-8?B?eEs1Tm1RTDZ3bnorL1lkNUdYMlJmVnRYUTdpQ0l0V3h6N01paE5ndThjcmY4?=
 =?utf-8?B?UDZuMldLZnJmZENpS1gzTm8vUXpGNlRhMWN1QmovSllEZVhRUWxWNlRtQW1B?=
 =?utf-8?B?NEpHenAwL01qTEVEc3hsNnBjNWNiVEpGQTRUbVFqeklBaXVGUTNvSnFnaVhj?=
 =?utf-8?B?QXdMamk2WUhzVHJoWC9rTkJ2OVZvdmdZOE9OQ29aWU4zWFArR1J4SFQ2VlBE?=
 =?utf-8?B?bWg5TWRsSDh0SWlZRVo2cmJnekdDdmhyN2R2NmpodzUxaXBXMm04NmMzS2Vk?=
 =?utf-8?B?N1VCZHNyWmFOWUE4RTFjalZoa09LcTBFcnlJcStlL1IxV2xlQ1pGelNNMHhE?=
 =?utf-8?B?VnR4UXdENFJxNlBlMGpmWVpUR3FLZlNDWm5NQzkyV2hLc3l2N3JOUXRNYWVF?=
 =?utf-8?B?K2ZIQlpFMzlMdW9zNVNaVGRvTlBqaG9PTlczcFpJSFRNQ0dBNzhFWjR4cHB4?=
 =?utf-8?B?ZHNHbGllV3ZnUEg0dmtWM1o2ZDJLNEdSYjJKbkJNZUlJOGRCU0FpRmorbmFM?=
 =?utf-8?B?cENnRFBKYlc5Vldza203cDdCcnRsK0pQeVhIa2tQSWpsVWlOakhxWWQ4MlNX?=
 =?utf-8?B?OG5rRVk1dzBqb2R6Yk44QXp6RStONVBaR1p0aVhLVStjaDBjMElVMFZNUkZy?=
 =?utf-8?B?UVNyeVRweTNSTGRkZXgwOURxQ1gwdDVaZWJKTkNTakt3SkpuUlowWHZ4SmRr?=
 =?utf-8?B?OTNTbHJDenRJRHpzNXloOUxtZjJxaXc2RlpJbitiaTk5YkcwVStVNXR2ODZU?=
 =?utf-8?B?R042S3NQbFo1S1dIaEpxL0J3VEp6NEgwU3lNaDU1VnlrV3NjbUZtdGhiRFpv?=
 =?utf-8?B?dSt4Q2dYTGhRYlFXaWpEam9TTmRtQ21KcFNXblBvS0U3WlVqQ055L0dWc3ZQ?=
 =?utf-8?B?TDRHbHZycFFHd3N0bzUwNUhheXppQ0Z6SG1TbHg2MWtSYlNKMlRXbENhMGhx?=
 =?utf-8?B?QUdrMWEvMmRkekRhTFE4N20zOXVwalFzeS9STkRMSk0vdGQyc0V4TGttbzRZ?=
 =?utf-8?B?Yytjd3U4WDdHaEoyUDFBNW5lN3ZIZ0hXdVdIN2JieVdCTGx4eVYxU2FTZTY2?=
 =?utf-8?B?cHlxbUxUMmh0SVNPME1HQmk3SFdiS1Zrb2FxVkpDS3lsd0lRN3ZxN2l0YU1P?=
 =?utf-8?B?MGVyemoxYWpTWko0YVFGTWJBUk9GN1Z2UVJLM3lEU3ZEb1NqLzlqU2VNRGNt?=
 =?utf-8?B?Q2xPSTJYK3NEMzFKN25ST1ZXaXQxY0FJbzl2eGJHWldtMTRJK3B3VC9MRlJM?=
 =?utf-8?B?VHBkQXJUVmdLcmZmUC9xQXVDWi92UmhFMndxcmpGdVRhckMyM0lPY3lMK2dL?=
 =?utf-8?B?UHc0OGc4U3pXU1JEKzhJSTl5N1RmYVY1aXYydDRnSlhHQXl0bG9LaFVEbzJm?=
 =?utf-8?B?ek1zMFJLS1p2dkhPVEtLWmI4eFBEemtIcjZJeG0yS0wrdVpGYkNCM2U4d2xX?=
 =?utf-8?B?MUpPOWoyMU9ISWYwMGdUTDFxQitobkdTcTJqK1N4OGt6QXU0QVdlS05EZ2NE?=
 =?utf-8?B?WW53YVBiZnBlZVBpTlpybHpGWm5FQWxMWnZVOXpGQUd2VnpnbFozN1FjNVdv?=
 =?utf-8?B?cWM1YmgxSGllZXlmWitQUDhFMCtIOXdnL015eUc1T2Zuc2djWTRzUzZkZjFI?=
 =?utf-8?B?NHQ3V3FOOFdDSVBUK2lmVTY4YkNOS21ZQnlObWdtM0ZST1NyeC9vc1VQSHVl?=
 =?utf-8?B?WXgwOENRdlRCZ3JnbjE3djkyYmU0ZGdwVnppcVpGWmJKcXlGNGgwNUpyWUNS?=
 =?utf-8?B?ZW5Da0tOMjRraHBlNnVkTHVTNGZSenpBbGxkMTZrZWlBUmxSQkZibGdKM216?=
 =?utf-8?Q?tPWJy7xufYwuF1xkSBT30ilAA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514a31ca-f310-4437-a3e4-08dd57d35578
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 08:38:54.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtO38p9JoMo2MFV4ckfZejccQhTuzmsRArIkSpzbP20ABCLlfLoBirGfrO51I8HVQKtSPAnOm6ckn4X10yhdlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859

Baolu,


On 2/28/2025 7:17 AM, Baolu Lu wrote:
> On 2/28/25 00:04, Vasant Hegde wrote:
>> On 2/26/2025 12:40 PM, Tian, Kevin wrote:
>>>> From: Vasant Hegde<vasant.hegde@amd.com>
>>>> Sent: Wednesday, February 26, 2025 12:47 PM
>>>>
>>>>>   3) TA is an IOVA and the IOMMU runs it through the full translation
>>>>>      to validate it. ATS is just used to signal non-present
>>>> Yes. AMD does this when Host page table is configured.
>>> Here 'signal non-present' implies to support PRI.
>>>
>>> But...
>>>
>>>> We need to consider various scenarios. For AMD:
>>>>    - Currently on baremetal, we cannot enable SVA and Secure ATS
>>> ... here it says SVA/SATS are incompatible. Any more background?
>> Sorry. I should have explained it better.
>>
>> To support SVA (PASID/PRI), we have to configure domain with AMD Guest (v2) Page
>> table and host page table will not be set (DTE[Mode]=0).
>>
>>    GVA -> GPA contains translation and GPA = SPA.
>>
>> On ATS request it will send GPA back to device (which is actually a SPA). We can
>> support secure ATS, but ATS response will contain the SPA.
> 
> So, the hardware is configured to work in secure ATS mode, but the ATS
> is not actually secure here, right? AMD's secure ATS relies on checking
> GPA to SPA translation; however, GPA is always equal to SPA in the SVA
> case.
> 
> Am I understanding this correctly?

Right. This is how it works currently.

-Vasant

