Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C0E1F0E25
	for <iommu@lists.linux.dev>; Sat,  8 Nov 2025 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762623194; cv=fail; b=BSx9wpYp0R6JDzs6kJEMKhVUKWho2pVDKR+PW/Kv8q0buWUxRjJ1h45Awy81XiMT7VLgO42emaXpJGyz8L3YAHwwNXCagwApT/JE0/Pnh/AWWx/fPygBLos7SNx6F/VcO+3mKBrfCzsJ63Kkl6Du6/hhx9UEJ5FmijFYJCucbd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762623194; c=relaxed/simple;
	bh=d9218CwjLk6tVu0YkXZ7VPYn56KzqdFyyqcYh6HRiig=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gA1nwnP3+Pga3wURudxkKSy33/AagajjEMCh3eIhVysMAf1vJ/ZdtD5lWVpowtP/qtOMY/Ju1JjKrHA27o3KMbueVaLnEPE4Ygu+d4BUQLqGKm5pkLcunbirlgYRSX7gH/btinp2aTcjfBM8u5jLpgsLTmIAtlOirxjKyxZWcsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s6kijSS2; arc=fail smtp.client-ip=52.101.52.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s6kijSS2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bXZqgPNySVfH1YcmKj90bbdqfCIb+qUOYHqr7MwH4SFr2RzwlzULOZ9I1REprEIHZHhTC+OAYSDcTtVHMjrQpm+hQQp38XI12qDCOJmjKpVYbsHYQ3jKid7LlvJv10ejxQVwenkO4ug7Tp4zPLNfUhZM3QQg8ScI22Trc7EW866fh7muzoHfi+pe5vH0Q96pHR9dVC2RMzyYCYYPhvcmqe6oa/V+jtyD3c35dkPiLoCqNK41+zy994DXaYVUcjQGUYcqPPEKOdII5eCxp5F8NQM00robP+dtlwmKdB90heAW6asWkkBY36c5x6rPXNRTsdYD18sKD++Mo0ONUv+lVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P29lZTcWWwXa5WMGubNwbgPmtaFWsmnJWF1HckE3w1I=;
 b=SXWlBHPP4d03VnkN1LAdaLzBiiGjzcp3ziOMZezOGlms05TVVduksLwryMSHdDKaiHiAZyDu9LjUKbUpfYBHpYMJNfTlMTa9wCEzVdrjpYazNzAUUX1uPjGNEfBZIdYdF1KrwpJcNP6o7bQf3P7l0OT/A383jmZdCFvtYNhiQOe/DqaBeLpvDErQZTNEjf37ck6OvYeeq9VnefT7gGXVhcGmh2huqEFXm2w6IZhyhrCJcjHooIybkQUK85opX3DrMw6ByWRhBjt1GHVUybrI9ELJRZsX6taek6dW7HTt4TVPUZt0KHZRoHyARsWumREzqew5qL1bS/dZn0u8KOSG7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P29lZTcWWwXa5WMGubNwbgPmtaFWsmnJWF1HckE3w1I=;
 b=s6kijSS2tVbkIOUKEGjt6WGsC9aOFsMGJ/yi8igZhUATHF58Vj6h7+r6PTRGx1HYjsSxTK2bNlbxb1X+rq04uInAv0SVifEMCCZL4R/bdBgKOXUBuhOr6ni+10kLVcYqM75TTR9kqL9/EGkIdcQSSr6TiHtcZgowbifBAaAxkWY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.15; Sat, 8 Nov 2025 17:33:09 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 17:33:09 +0000
Message-ID: <76cccc9c-d351-4f47-a10a-7b8d21c51b43@amd.com>
Date: Sat, 8 Nov 2025 23:02:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/16] iommu/amd: Make amd_iommu_completion_wait()
 non-static
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, jgg@nvidia.com,
 nicolinc@nvidia.com
Cc: linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
 joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 iommu@lists.linux.dev, santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
 jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
 wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-8-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251021014324.5837-8-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0091.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 901c5c69-6d6d-4d72-e45d-08de1eece143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFJCbVBXeDFzZmRaSjl3RmZZOWlOQWZQTkFvZkpub0tIOUYxa3pGTXdFZDd1?=
 =?utf-8?B?SittMVlRRGc3aUVLZEVGUWxQSXFKcmhnMXlTUHVtR3k4ZFlUb2YwL3dvMStq?=
 =?utf-8?B?ZFhNa1JBSVk0ajloeHRpTDdFZ2w4Z3JzRXNhSXZUcjlWNHdmZTg2SGxieW5S?=
 =?utf-8?B?VkQ5UVZDSEdmalBraUZVZEF5eHVUNmw5NEVrRTB2aVhuYjR3dE5TVUVhZXFm?=
 =?utf-8?B?RFhWWUY4MEl6MlhzUURMWnFnYnBkcU42Wk16Sy83bFlhOXU1elQxTkJIYmpP?=
 =?utf-8?B?WlpPcWZLRFhqa0V4aWIwVkU2Q3V0bkpVdmJMN3ZXTHQ1bFArTHREZHN0WlF0?=
 =?utf-8?B?L2pubTVnVUlGbW85YUdmRXVuTjlueDhpeTFnYUtDRTI5RU5nakVUQVJ4MVZO?=
 =?utf-8?B?UzhJM1FqREdWaHg4U0NrRklJNitIeW9LMWV1eUNXQThreGR0U1ZzNTdNVVps?=
 =?utf-8?B?YVhobXlZWUhWMXBweFpXRStOT2F6WUVDZTJpS2NJUVlTdnhrMEFFaVNyNVlD?=
 =?utf-8?B?RStSb2QzSDNUVHRkRUsvcUlaUjVqSFNmQXdqdjhVZUZRK01IUDRxTGZ5VnJT?=
 =?utf-8?B?eTh1Uk1vOElSMGR0TEVZaHdabnlrc3ZMUXEreU52YWNZUFVnQ1ZNVmNIcTFh?=
 =?utf-8?B?bkI2bFNWcGFGVnI4Y0RGa29zZTRJZHJNUjJxdGdGS2h4bGM5OVRQelZsS1BE?=
 =?utf-8?B?Q2NXRXJSb01wMDFBTDdCWG9ITW52RWdiVEQ5VkFqSG94VzJUR1RnWFNFMUNQ?=
 =?utf-8?B?ZFNPV05Pb3BPOUpQN1hGaFlaN3lNZFlPcGZlVDdzMHovUWVQdGpnOG05ZHhM?=
 =?utf-8?B?UjdZWWlXM2djeEpBRzZjTUFSU0t5NU1jekNEdzBwcU5QdWpyblVMc2MwRmFq?=
 =?utf-8?B?T1M5bXp6NmlnVno4WlBidmo3L2V6UVcva1FOYThCYkhtZVZ0OWFEMFhHeWZx?=
 =?utf-8?B?RU9mRTJJWEpxSkttV1F0aXl1RFA1UjdaRlZvZG8rdGg2RGlVTFVwc1Nwai9M?=
 =?utf-8?B?T0ZaWkVxRzlSQVRhTmc5bnlYRmphc3AzMzBvTE1jZ2lXOGlUMHlCTTFhTEJo?=
 =?utf-8?B?ZUp4SGN5emhwSXVSR25LNVV2QnA4R3FpY2JCektEMSt4SHpXdFFiUzhoT09h?=
 =?utf-8?B?THhiZVhNZ21POGhxUU5tMmxRditsTFA4SWszcTRodHIvczhyTUJ0TTgrWWNi?=
 =?utf-8?B?aERyWmJIU1U2ZGkwblI4cUN5QklQK2JPVm5MczE1aFZFZW1oMjNvOVFSWGZB?=
 =?utf-8?B?SlE3amhyaEZQQmdzNWZORkJOckMzd0VZeDdtWUJCNTAxYWJtTkl0RSt1cGhp?=
 =?utf-8?B?ZncxQzlJK3V6U1pNR3lXVVdqa3grdmlYcTd2N2p5Y1hYQ2lzemZDOXViUXdt?=
 =?utf-8?B?cUJGWkdFRGFlWjhRaFNQYmd4WnR6NDdKQVZGTUlsZU9Qc2tzc0x3c0tPbURC?=
 =?utf-8?B?Y0M1ZzA3eDMyWlNzRkhmZlJ2QlI3NkpwbTFmRkREdWpBZ0VnbHg1MlFYVGNJ?=
 =?utf-8?B?dHNLMm02cFdFTHhGU2pJcWtER2J2WVZFTUZrNnprdGRnSnh4dHJHSG5yYUdr?=
 =?utf-8?B?OUNEdUNDTjFTQlI4bkNrQ3pHYnlESE5WMGlLMEhuYngvWkNud291blpZdjl5?=
 =?utf-8?B?bzRlc2FoN3JhN2RXbjZ2MmkwWTRadWdsS2lLOU9tSGNWanlIZHV2empVVG00?=
 =?utf-8?B?aEg5QnAzMmh4K2hLVjFLdEQzOXRHaGpKRnM4WDN2MnNCQ0xqazVzOGkyWVpr?=
 =?utf-8?B?NUhRQ2xNb1NvRHFmN2tRRUdKQWxsTHhMNkJYanBtaTRJQVFPZ1NEUVNXOUVE?=
 =?utf-8?B?b2UwOXdWdE5xY0MveWUwbVY4UXFCM1ZoajBMUytWbkt5VUc1Y1AvSlVrcUtF?=
 =?utf-8?B?MGJyNkVSNjA4c3JWQ1E0Um5Ob2ZaSzNaVWhoQ2k3eHh1cm53R1NuREJ1TEFB?=
 =?utf-8?Q?J7VKgkaV2ymNgBiDfj9+C05JeuYknpdH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXo4RHR2VmcxbUxsQWYyK2k5dkxVY2tiVjBJU2kyUkZEeER0ZzJtQ2tNNWcy?=
 =?utf-8?B?NU1CZFZQS2lvY0tTc3Y0NHNNc0gzT3VzZGVoZllYVGJQbEtqTjMzVmJMbHRL?=
 =?utf-8?B?YitqcE1LYk5rOENpRTFuT0V2dGo2YWNBUk5wV29ta1kwMzkzcFhuOXZSaGdo?=
 =?utf-8?B?M0tnM1FPdnpQM1RNV2pUdlBjN0VrNFdCWGFLeHdOUEQ3Mmp5M2ZpblkzcEhj?=
 =?utf-8?B?MzMwK3FzeUdBK0JUYUlwaXl2Z2RBd095NlhTMTJUSkhpZGVpODRTbXk1ejVK?=
 =?utf-8?B?dFN1QmRTVHZnTEdRYkRBNTZ2ZmpRN3Q2dWJHNEoxaFc3TXJ0ZXRrZC9KZmdY?=
 =?utf-8?B?Z2F4djlMeEtCNDlEY0FramNhNGFwU25zdGEwc3RKWWNFQ3NaV3VnZTdjdzdG?=
 =?utf-8?B?dWl1WVBpSkkvT054RUp5T3dsVmdweGROR09tK21UaUZUOXc2T2JleFl0YXdi?=
 =?utf-8?B?aTlHVm8wcVdQZk15bmlvU21UWTRJbWFUSjJSaDJpRlFjTHNDVnVoRDl1Ym1w?=
 =?utf-8?B?bk13NHRCZkpLZjlnem5KcGtEOVJYUzRaZ2xpMEx3RlNzdXdIODc0dlRBdHVH?=
 =?utf-8?B?bFdLU21oNjlvekVBdU5uSk1KeFZKQUtseisxTEovVXNMdGh0LzVIZUlQRDlP?=
 =?utf-8?B?SWNuYnphdlFtcEhKb3BZaGtkLzlLMS9TUk1MaFpjNWFoVjZBdXhCRWFkM0F6?=
 =?utf-8?B?cnNtdzRBTmlRb3ZleWgwdTBhamVHTE5SNEpNTlZQcytCMCs3cmlESGgxL1Uv?=
 =?utf-8?B?M1VRUXkwT1NQeWp5MzkyZDh5V240UGlaWElwc1lQazIwZ2V5VXROajJKZ3Bx?=
 =?utf-8?B?QjRKYmg3YitCTm1OQlJDd1BzUHJwZTJneHpmYU8wLzFnaDdPMjhxYld0Wm9I?=
 =?utf-8?B?UDlWTzlkdFFBNVlQbVE2Z3RFcVNzZE91REFLN1Z4NlNtYUxTbzFTSEN3Nk85?=
 =?utf-8?B?M0JYcEkrR1VhTnY0SnA5cXo1akpXN3FZNEhTYWVpVTdGVE9ONVdhYmdYd3lP?=
 =?utf-8?B?NEs2NTJLOUJzM29MSnRocWN2dE9ubHg3WjJIZzUwamE3UEE5SDJnVlZuZmNw?=
 =?utf-8?B?M2FHaXBJYitvRGcrTklBUWZRWXNtUEl4WmxIOXRna0p4SU9EMkVRdnNBbU90?=
 =?utf-8?B?UzRmWVgzdXNzTkZGemt0T0UrcEVySzhPTzRVcFF0aS9YaFFhU0xBeUREY1dU?=
 =?utf-8?B?SlhsWHpMdzdLMHdkYVR1NkwzSXpQSXpNOVQxTUpHVGtPcGVVSC93RllXbXo4?=
 =?utf-8?B?TlpRSi96a0FQMnF0bzk4YjFlWGg1dllZdlZsdDZ1eEQwZHZQQ3VwTWZWdU1j?=
 =?utf-8?B?djUvMUJWNkFMYnJpTUlhaUFJeTN3bVppb3JhM0pEbXlYVnpNSFJLTkg5S0J5?=
 =?utf-8?B?dktqSSticFRBbndSdVlhZEFjVFZHU3V5Qk9yV1VvQXVGTktxcjFWcDVPZGVD?=
 =?utf-8?B?WnU0Y05TT0NMSDNQbStSb3hqOVk5NVlRand5QzUzVjljTS9CVFRRUCt1ZFRL?=
 =?utf-8?B?d0lrTmFJcDlTaG5WY3BpVFpDV3NLWTdlZW5SSWdIT2duV2Q3TTZtNkpxV2Zn?=
 =?utf-8?B?bTIyRHJBN1Q5bVM0STVqTlIrSEw5aTRvSkJWUFVzTTFxMklyajRkSDVRZk1l?=
 =?utf-8?B?QWhNclFkMEVMYXNvYkUvUmczNzkyK3hDVmU2dW0xeTRqd2d5c3U4WUhYaThL?=
 =?utf-8?B?SDRTeWllenpxYUR1SGZjSE5FQjhLSDgvb2FYYUFJSmNraTU3ZzBaVzBZdmpz?=
 =?utf-8?B?ejErRWpxbTIzMjBXU0UrMFE3QmJBQk9zRVZBMnNUb3E2ZVVOdjRjSFhMUFNZ?=
 =?utf-8?B?aGdGb3lGby9pTDVQZDZkb1d5SWpIbE5CZHRqQ2w0cUlDSXpvMy90R0s3OFB4?=
 =?utf-8?B?SFhLNW9sNE53eEtUWmx2K0NOVEMrekpraCtUMSs4UlY1N1NCRFREV3IwcEVW?=
 =?utf-8?B?UUFSZDJXdG5nQUlsUmMyd0dtcmFwNEI3UjcvUHI4MmhzeThhYmxwWEJjSVhL?=
 =?utf-8?B?NlExYW1RNGtkSFlTWTFIUWdkMTJDNU95dFZtTGtZVWNvS0xwSGtSOXRFT2pv?=
 =?utf-8?B?cFAwb2N6c2J6N0FyZkw3ZGVvUXkzcldsTmZsRnlZeXVpKzJkYSs3OFVXQmNl?=
 =?utf-8?Q?AJzzJN5MCKqGVSGI/vcyy4svo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901c5c69-6d6d-4d72-e45d-08de1eece143
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:33:07.6875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAUnTGDi72qkGds2LEK7qzGNK+NoNbKjKPwyjqVi5momM1M534gXr5s4soBzssuy82XWSIPKP97CY35zezahKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475



On 10/21/2025 7:13 AM, Suravee Suthikulpanit wrote:
> This will be reused in a new iommufd.c file for nested translation.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Patch looks good. But like Jason mentioned in oatch 16, if we use
dev_update_dte() we may not needs this patch.

-Vasant


