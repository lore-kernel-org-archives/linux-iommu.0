Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D78613D8B3
	for <iommu@lists.linux.dev>; Mon, 26 Aug 2024 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663493; cv=fail; b=Nb4Pk+X7XG6sYIBamwOUaIW9Gkem0pRNskXShLgiadfXtXlh7pDyL1WAJX6FlbZtKodAwm0w7PcQ2l/QbrgmyVozXiSZ9Py8aXVbopxCpMSYQdiO9MVz1SazJ7kMu2Tc47she+7uHI07YvWcNrYuSBUNe9cHcBtPNrGPGD16rjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663493; c=relaxed/simple;
	bh=GYN2ulYMbmHdUBX27Jtzg9DzWk6LDTI1ZyKnBBj5nPE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q6mj14vXV5JxWTjwzWtgzHjC+I1U6XlXF3NtsmixYfUmq1sgJFpXBzt4oGfe7yAx0PWg6ofO8izrGhAbJwrnppO0fNSxKQg9X87rIexjW+HrOXD5Aw5x5Q+RTLvokIUInZQ8No083SgiPdCb8pNSXLKuUf9PJZdYktzIOGnHuxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q7hLIsIL; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q7hLIsIL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isiYbVG1t1RB2qfm9lUhlek4lolbpdIyo+o9IJ7TMAMncnR0gUySr2R6xsy6Oq6t11HzK0xR9pwwdHXfZlUXsHstmkw6jX60ny/zjnUBh+c64+wxgSD0KV9CYIIFw1lvE7yP8kcemGkgk+HHdAeUSUsw2KAbhqwP7noJAjG4xufbzEKrXFG1pKXa+Zw/Zgp7B/I+ZknmTf+aKQ8UY+GxTBJrp3WI+SL0TxrBPdsSt6zaoNX4epwGhQxpJNCaFZOtSO/pxJFPv1UEB+HSe6hA5+iwF5oUfFb5Kmhwu7QeM8gSHHuJRWueSXiSoxFSbQAHqelgZ4/lx9d4XGdJnEDicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4yGqf0Og3CqY0/J2EvjjnMlgMDvclmrmK+98wDiVPU=;
 b=iGzjxk9zdegJr5S4SVKNaAPTZk5JmiyhBH1wT6l30Sj9eOuy2pB+DRQf2POnwmSq7U/PtIU/2ESWOGW6wvCilpgySt0sZmGV1Bk3c6t6uEFxd248EexP6eWYT5QbeJx/zM5EdcaR49RwOUCKceXY9wnvi0LoMbES7243TXgEzbKhdO5n0+cOW2PZPxb+OTBBHeusqNH5pdlYjYD3mfyfxNoPu5xFD5mqNjPxWIqJIp2CyFQZLS9PgTqOKrf0n13rFTTj/Rk31l8NzMBgNipAo2fSsPWZGYSV+jOib3BSzaBJjq7cE6URLGoDiC4ucw5+MlKPr5sMCBZmWe5EO7RI+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4yGqf0Og3CqY0/J2EvjjnMlgMDvclmrmK+98wDiVPU=;
 b=q7hLIsILcdZvI73GbvCTMZjspIV4zG04TMXyol5FWmWrxBv7awEggQdq/WIUlk81kLO7b10vN27RZtUX4NJElfGpisHS/KK5fJZPab0mhl9WIThPGhaC57PnO3X/l7f/of0/TLKuC95qYbuQCqZYIf1ZgMdjpPMgh1TxVKr5z5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Mon, 26 Aug
 2024 09:11:27 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 09:11:27 +0000
Message-ID: <0f80d53f-ea8b-4f16-acf8-aa1c99966dfa@amd.com>
Date: Mon, 26 Aug 2024 14:41:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Move PCI PASID enablement to probe path
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240816104945.97160-1-baolu.lu@linux.intel.com>
 <6650ce02-ac85-4cb6-941c-cc7e8b6effc4@amd.com>
 <92b55591-e106-4366-ba5b-0588af50770f@linux.intel.com>
 <635b24b7-632d-4046-b82e-6ac6976686c9@amd.com>
 <0e807eec-ce51-42e2-9290-dc90c4210888@linux.intel.com>
 <20240819123400.GU3468552@ziepe.ca>
 <4d9c1513-8062-4594-a06a-c9f179abdaab@linux.intel.com>
 <72e59734-431e-4eb4-b27c-44eefab3dcb0@amd.com>
 <20240820135153.GW3468552@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240820135153.GW3468552@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 12abc817-4e3b-42f9-8e14-08dcc5af10aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUNLRVJIMHJBQ0FXRTVxRzFaUmJjM1A0SExNNDUyZTFYWERPK045c29qUU1h?=
 =?utf-8?B?ekVIZTA1bFF2bFFIMGh2VmV1My9jVzhYNDlBYmttTHFLdlphaTVoOVBIN0pU?=
 =?utf-8?B?VUtvYm9laVpueXd3Szh5MWVucGxTMHYvU2REamdubE8wOHYvaFUvd3JCQVNv?=
 =?utf-8?B?azd5RTJ6cUNRa1JWbWZ5MGRieVpNa2ZSRk5MMUE2dFZWZTlKRi82ajFKd0Vy?=
 =?utf-8?B?emdpN1FNN0tHUy9aMzd4MTZrL0FrZHZ0QVB5ckJ5eDliV2lXWG03aGp6dWJZ?=
 =?utf-8?B?bjZwdlJxdFY5U2FkNmF3Nmc1UDdhczVOWExKN3VGOVpxUHBqenQyM2phZ0Rj?=
 =?utf-8?B?NXptLzQ3NXRmV3RhMTBiV05ZV1BUYTI3a003WXhKeGJYN3c0Ym1POWo0NkJJ?=
 =?utf-8?B?UDJ2VzdDTVpaVksxYkFRSGI1Q01TVjk5YWhxbkRkWUcvdFl0eXBtUFlBTUwv?=
 =?utf-8?B?RHF1RVRiWFQ5RGxrSnVSM25ZZ1lwMUhLWkRDYkdOb1d6RDFLcVkrR1l4dGg3?=
 =?utf-8?B?NzZYRGs1ZFBaN244QnZPLzQzR210V2hOamNWSGlreUhXQmVaS0RnSmNOZ0pl?=
 =?utf-8?B?aWtuTWRhZEpKQjNyS0R5L0tvanRXL2tadVFXY3RRdFF1dkkzb0h0bW5sSkYx?=
 =?utf-8?B?UDQ0YVhtVE1OOFNkVm5FWHBwOW41S0YyVFJHWXBvSVBsYzJDS1BJZjJQTHcv?=
 =?utf-8?B?Y3VRSS9jWWpWNWxrTk1tOHFFZjhIOEhqQVd5TXIwZy9UR1RDVUUrcTZncVdF?=
 =?utf-8?B?WHVlakJad1A1QVVCOTlXOFpWanAyckRhemNyb1hxY29JcUF0S21jWDZQcTBN?=
 =?utf-8?B?STFFUE00YUVrMXdTRXJ6dStkNWZmTWc1RUlBT3M5aG91LzdIWDZPUHE4dWRk?=
 =?utf-8?B?Qitxd2tHYUFTaS9KYkZhemNIc1NTZFNjSHRleDF4eDlXMlRCeVlHdFUzcTRG?=
 =?utf-8?B?MWliUkREcTc3cTg3K2o2YWlKUXV6SjBrSm1rbkVWU0FOdlVndXJlb3ByNkYv?=
 =?utf-8?B?SEhKSHFOMzZyK0dVRFpJeEtaSlV5YUdIVmZNUWk0S1doZUZYQVY3eHpmU21i?=
 =?utf-8?B?YzArWkR0RkdMMnlVMEd2dXRiQ2RadkNDRW1Ld1E5eG9UbENJR28vcG1SWFd5?=
 =?utf-8?B?bjl4OWpGY05EbkFuTkZidk8rS0RkaTZtNmtITkYrUjFJb1I3a3I3OHVrWmcy?=
 =?utf-8?B?M21QV0RxSWg3WllXNjFjN205VHNnNHRQTTA0NDNydXZUbHdDc3d5ZVRUVTlC?=
 =?utf-8?B?dXFON3Z5bWZ2VlFhbmtGcy9qMUFVd3k5dEpmNjlwRkEwYndsdk96ejArSmJ1?=
 =?utf-8?B?NXB4YkRYR215MmNOWW5talZqRXNCcFlac21sQ1NwdzV1NlcxSVgzSFlra05u?=
 =?utf-8?B?NGpFaG15YnNDRGtyaW5aRGUxanFqTHE3VlpxWGFnbXRSaXlFQTVma3lkZkFr?=
 =?utf-8?B?ZkFLTG14bEN3TW5mSXh5ZStNdWh0b3JsNFQ4MU5ybmZLd1Y0cHFySmJxMU82?=
 =?utf-8?B?SmtWK1IyN3o0RjJNQktodkljL2hNQUZKTTRTdVBXSmFTWllJcmd5RmRaWXdw?=
 =?utf-8?B?U29LV3FScVlmVVN5SzlsM1RtbGhHYzVLQmFSOGdBRFN6N0lsdmpjVVYxOVQ2?=
 =?utf-8?B?TUNMbmtycFRNbDJxWFphVTBRMTF6aHpDaEt3NmlTUGZ1c1dHK1NVaXMyWk1j?=
 =?utf-8?B?bE5MOTJDTGRzOUt4aENlek5palFqdXA0NWlQb1FNM05XR0VXNGQ0VGVWU0pV?=
 =?utf-8?B?cTBoT2xtcDNLSUtxZ1BvS0tZVHl3NEM4b3FBUnVXZkc0S2RMZkdwL1E2VWFW?=
 =?utf-8?Q?BZe3G9ttgwU7YjRytCigOsTu66FPJcE1klu0o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDhNOVp2NGp0bWZGeU02dE5XU3N0elpVN3BUSjQ5U1ptVXVHZXJhdDlDdzJY?=
 =?utf-8?B?UHQycW56dEpJZWY1UDBQdTJOSlRnM2RJWlF4T0ttRGNtV2tBYVEvRGFnbjJC?=
 =?utf-8?B?dEJuOFZmS1pIbUp0R1hMcHpNaG8zNWhJTjcrdUVEQ3BVdURjdFNLTmVOdGcy?=
 =?utf-8?B?OVR6OEthOGVVSjF5WGtqTjFmOGd4azUvQm5IcTBnQVIwcDJLd0llOGI4MWpU?=
 =?utf-8?B?YmlJVWtXUVIzejJVNWt2TEdXamNYVlBkeTJBdVN2QXZEL1VRTE5YeFVXSStY?=
 =?utf-8?B?SjhVT0ZGOVFzSTRQbW5GaVN3dFhVU0ZBem5SY1Z0ME5BOERQWTU2ZlZjVnRI?=
 =?utf-8?B?TDJ3ZGppUXhGOUNWd0pUZjdmMW9oYkFhbHZ4T0o2UXR4NGl6VkZER3JGM1ZY?=
 =?utf-8?B?MUVkRVJUU1l0ZllNMm0yVEdhRm9oKzh0RDJQVUR1UlZ0eE1pTVczRHpYMlhk?=
 =?utf-8?B?N1ZocFlaYk1rdFZ5SGhzVGhjRDcrbzlEbjg2VGZTeG56bTVvZDFHMW5qZzM0?=
 =?utf-8?B?cXFqaVRDSkU0L3BRNDdpdEw2SWdWQmptTFdhb1FMcGthcHFab3pkK0tndmh5?=
 =?utf-8?B?YlJIMzl4SG5wd0pTK25EMTdseS83MkhSaEpZL1h2akJYeVNVcjU3dHB2bzFN?=
 =?utf-8?B?QlgvSUNJaXBNQUd3ZE96NEF4Mi9KUW5qOEhrUnBSQWtFa2xTQi9NVHFqbXRP?=
 =?utf-8?B?VUFVQUZkbVc3ellwZFBoVmZBd3VSRUM2L1JmZVVoWFJHUkRZS2NJc1RLcG82?=
 =?utf-8?B?K2FodjlWWjBuUDJaVU94QklFYS9IU3Fabll5ZzViVnJtZWNlRWR5SjQrOTZE?=
 =?utf-8?B?cDBTTzBlbDU2SWJlRkdWODlYZmZWZlZWV09yMGhQaWZFdlRsWHdadkdNTW4r?=
 =?utf-8?B?dU4vaStaTGtwZUVKQTlGdVl1SnhOVVd5aVJ0cnJrenVKL2drNFQvV1p1MjFq?=
 =?utf-8?B?QncwM1VhOFlHZDU3Kzdtb3UxbTA5ZVMzMGRndU0rTlRNb1AzSWJCMFlRQ1VW?=
 =?utf-8?B?UHpoWENMWHhaRDBkSkxXNGg2Rm1uTnJiRmVtdGErRTZpUzRyRHVSKzlxQ0xE?=
 =?utf-8?B?NEhjS21pTXZzbmZOTENCTldhNDNMUnRSR2tuK1Yzb0FXdkxVcHB6NGZkVEVy?=
 =?utf-8?B?dEw2d1piZXZlMUM2dWNxN2MvUEZsK0U0ais1emZ0OUxyYkM3aWZScVlCZXhh?=
 =?utf-8?B?clBDRk1laFVzWUN5RElwNUlpZjlJdXY3VDRicFZvSTdtUm9qVlJTR1RGU0JF?=
 =?utf-8?B?NGxGcjEyRUZtVDVYYktzQUdHTVlYbHNGSWtuK1JxVVVBVElwMDBjMnU3SlNj?=
 =?utf-8?B?OUZPYmk2a1AzeURBYUJEb3o3VVJvWWN1bEcrSHlubmtiSk9FREVuSWYvR3Vs?=
 =?utf-8?B?bWE4ZE1oYWMxeXg4K3lRVGdLVWZnMXJ1aXliRE1hci9HcnpMWWZjR0JjRW9m?=
 =?utf-8?B?VmhGVmtGVHk2aFhwUmg0blFWRWV1WU82WE40SGE0ZmVYeEswRGRpUDZzallt?=
 =?utf-8?B?c0l2dXVzZGxPaDlwckhxSWdlTzhWUEdJS084em90Y3FyaWxRVy9seGI2VHFo?=
 =?utf-8?B?U1l0N1UwWkF2YWlmUjJYcDREbStNamFVQ2VkRHVXV2pMQ24zSFFiNGZjNzFr?=
 =?utf-8?B?ZWFxR3d2MVM0ZHJ6MEFyWmNyLzlPZ01STlJ6TUkzVnBvcmdCSFJsSTBTaDA5?=
 =?utf-8?B?ZEZkV0ZrOU5HSzdaaC81MGxHa1hNdU8raU9rTU1TTmszSVZka1VoYkplb2V4?=
 =?utf-8?B?eGx2RkUzNExvRVo2OVhSWjljT0RNU3pVcWNCMGtZcmw3TDJTVDN2SytwUkRN?=
 =?utf-8?B?SVFFcERQMmtYZks0NStDY2x3dTh6YjAxaWZkMHF6cVNsYkNvdmpOdlVPRmtq?=
 =?utf-8?B?M2o3OUpVUU5VTWZjdGx3bGdCUkQxcVd6YU13ditscjhUS0xsZ09nWXpSaHBn?=
 =?utf-8?B?MW1RWmYwaExPVGhRNUVFcmgwQ0VHZjBoNjhiSXJENXA5K0dFRVFxVE91UUdY?=
 =?utf-8?B?WHNNN1lNdG5JcUNjZ2JySzhUNzNKM3d0RURPR2QrbGR3Q09rd2J3MHBERllk?=
 =?utf-8?B?cVRxbGZXWVFidjNJOFZaQjFDOWxjMTlCa3dXQkU0MjNLL1UrN3JBWWVSUWtm?=
 =?utf-8?Q?zWP3BY5lohuxoWbpWloIRufZC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12abc817-4e3b-42f9-8e14-08dcc5af10aa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 09:11:27.2199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Ti/JUO7PLGA3+XzWoOjf8p9dRpVg4O1+gZlnJfuu8/7aJ1pxkPX8w+eIKRfrKbY32K/BfLXwg9IeZXCJC8mNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507

Jason,


On 8/20/2024 7:21 PM, Jason Gunthorpe wrote:
> On Tue, Aug 20, 2024 at 02:00:08PM +0530, Vasant Hegde wrote:
> 
>>> Some architectures, including VT-d non-scalable mode, doesn't support
>>> ATS translation and translated requests when it is working in the
>>> IDENTITY domain mode. 
> 
> ARM has a similar issue.
> 
> ATS enablement should be done when the domain is attached in those
> cases.
> 
> Arguably you don't want to turn ATS on anyhow for pure IDENTITY with
> no PASID because it is just pointless.
> 
>> In that case, probably PCI ATS still need to be
>>> disabled when such domain is attached and re-enabled when the domain is
>>> detached.
>>
>> Does it make sense to move both PASID/PRI enablement to probe() path? something
>> like below :
> 
> It makes sense.
> 
> I don't see any ordering restriction in the PCI specification.
> 
> Notice that PASID does have a specific called out restriction:
> 
> 	/*
> 	 * Note that PASID must be enabled before, and disabled after ATS:
> 	 * PCI Express Base 4.0r1.0 - 10.5.1.3 ATS Control Register
> 	 *
> 	 *   Behavior is undefined if this bit is Set and the value of the PASID
> 	 *   Enable, Execute Requested Enable, or Privileged Mode Requested bits
> 	 *   are changed.
> 	 */
> 
>> [I am assuming ops->dev_enable_feat() interface is going away]
> 
> Is the plan
>  
>>   - Enable device side PASID/PRI during ops->probe_device()
> 
> Yes
> 
>>   - In device attach path (ops->attach_dev()), depending on IOMMU, device and
>> domain capability configure the features like PASID, IOPF and ATS. That means
>> ATS enablement is still done at attach device path.
> 
> From a PCI perspective only ATS can be changed at this point..
> 
> The SW construct of IOPF can be changed during domain attachment.
> 
> Everything that is PF-only must be setup during probe_device only
> otherwise SRIOV VFs will be broken insome cases.

Makes sense. I will modify AMD driver to enable PRI/PASID in probe() path.


> 
> See
> https://lore.kernel.org/all/0-v1-0fb4d2ab6770+7e706-ats_vf_jgg@nvidia.com/
> for this concept applied to ATS.
> 
> This means probe_device() has to do:
> 
>  - ATS properties 
>  - PRI
>  - PASID properties
> 
> At a minimum.
> 
> It would be nice if the iommu core code did this setup in one place
> immediately after calling probe_device() but before attaching a
> domain.
> 
> There is no particularly good reason to have this coded in all the
> iommu drivers.

Yeah. that makes sense. We may have to adjust few things in driver (at least AMD
driver). But its doable.

-Vasant
