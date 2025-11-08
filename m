Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012005.outbound.protection.outlook.com [40.93.195.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99E82566E9
	for <iommu@lists.linux.dev>; Sat,  8 Nov 2025 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762623605; cv=fail; b=KBMSE3oKXNvGwomkjBk4oxrfXnEPIOO5oLib02yLdBMm23gmVWHPLGjD/AWyCJJS0MxPOj9hkfrbH7GJdF10IJTVTXRbwoIxCB96BkKyNwGkYygqVLx71qmgEqNkWFALBEQLbklFhQLU+E2knpkb9OIBWpHMvNTMuVtMDadhw84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762623605; c=relaxed/simple;
	bh=Dsky/xp9Kqx+Xxly/Ys5i9Oll/e5qwCIyLyg9sfyV64=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QGQHN6WWqrTpV0wEtUKtgMk7Hw7gF33e/pwhwWbGdwLIZyyKN2gQPVVtVvZULU1QRbzZ9WOrSNpCT+OM67B/pStnPcCdtvz+Lmgj3gCi2D7fm9euZIuWiEMsEirlqeH0JqnCEJOi95b0hiaQONczn2fhDayjJNubFOCYPPZFsEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YUzThxpN; arc=fail smtp.client-ip=40.93.195.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YUzThxpN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnK+YoSF+AqfHJp6iqX/1AvswPqZxuzUvPYYhJbtY/zzOlcz+a5M6WF4hIdLOyPBIMMA+bWx1xBcLYeDxhIw6Ea0BQdbfwGN4cxbLR1KeJv1FF9UAOIaiEaBFJJCkZnGBUe0KDBJRG1BkzMuXTt6jac35m0JcU40cI5t46/D4o2v+fDX4b35SZMykR2hHV7uTrm/ajJyUa/7lnrbQ8fYOKXhXcKCecQt1LFIsH5Dpj31KZ028XESm0giuBUHAxZ7ZXZOBxWp0C3qLfOPYyoIi8HLxCap5hGLFWfpy35gMwcv8UNmYxJoIQYPVE0usEexOIhiXWxwfg9ZRfsklUhR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbhSgv3bO6CxQJuBP1YX5PtxGEpQJ1FG9tEmET+iFUs=;
 b=gvjuhoj/rVqMb9qIUrjnHTonTCY6ylM6X85reTsNNQ+GjvYC0qdy0w+COfBqPZBZuI9ICj1Iao0ZTjHbjjGu0sduakfZAfRUzck96gcgt0lbGZjMkE43amsW6Msau3zkF95sn5Fo52KwlI6fRt1Yjd4lBFR0Qhqo3YyLCJnF51v6Ys9qq6ruaNWNQncxH5cSJ3CXFXHIatnNDkmdflSbe2PkuF7e98tVGd+l/Y27nwZGTSmRWc4AHVYqjEg3x1PVLBMDgenPH1T3wWBW2UD8jxaTnxX/ugjnj4urch3wzFmvQTk+HjjtX/3eXtXXykOGEcUq1GqAnhg5pMNffspPUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbhSgv3bO6CxQJuBP1YX5PtxGEpQJ1FG9tEmET+iFUs=;
 b=YUzThxpNZ6IjPfKp6ZjWv/Q76m6svDURT1hSaqi+KgY8erV0gc5HfMpSY3JlJpUeq+xqIgoPkBwbGzonckUunioQelImlEErsrxM5iDgCFU2CysZbG/Edb8h509a1M8MG6mkI9tKbg4Bg3DJo4Y9idIZ9qhPiHKCvxx0v3kKqLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.15; Sat, 8 Nov 2025 17:40:01 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 17:40:01 +0000
Message-ID: <99cb0f7a-0d21-4071-844d-893b230b7038@amd.com>
Date: Sat, 8 Nov 2025 23:09:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/16] iommu/amd: Always enable GCR3TRPMode when
 supported.
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, jgg@nvidia.com,
 nicolinc@nvidia.com
Cc: linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
 joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
 iommu@lists.linux.dev, santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
 jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
 wnliu@google.com, gptran@google.com, kpsingh@google.com,
 joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
 <20251021014324.5837-10-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251021014324.5837-10-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::34) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 504aff47-d633-4792-6de5-08de1eedd7a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1grT3pJKzZwQlg3azE0MmVYWkVNY1NmYmZFZGtwTFcvajAxNlNoZFhrbUh1?=
 =?utf-8?B?TVNNTjlvNVlTSmE0ZkVWd2RrQ1J2b3U3Q1ZBY3BVeU1jTFQyNWJrRVZyb2lw?=
 =?utf-8?B?blh2b2JrY0Z4TmNKSEt4YXI4K2FTbnllM1ZkdzhvUnNZdXlneVVsN1FTek1r?=
 =?utf-8?B?RnB1SFFtZXRRZWY0UGRvVGNhN0xXRDQwN21PcVJ3bzhQZkxYVjdsQ1lPL2dQ?=
 =?utf-8?B?dlpEUFhFK1J6Y2UxUjNyNTNuRHROMW1rem91VVR2aW1sNjhKVFZzUitqMFU5?=
 =?utf-8?B?SjQzb0pLYUIxVFp0bTZhTDVmeHpCNFVieE94NEtZWFBtYnJHc0xUdko5RkRR?=
 =?utf-8?B?djlTR2VrbWlpT21rcmN0aStUQTVtRU9HbmEybjI0MERibE01SkJVL3Q5elRM?=
 =?utf-8?B?TEFPTzNDRG8vQktlb1czUCs0cWphUzY4OEJJV1RsZHhGbzh2dlY4Q2VCamNF?=
 =?utf-8?B?SkhjU0ZSekZUcUVTeC9yNEV6QTJJeDU5MUR3NldoRTIrU0NIbVkyWWJHZW9x?=
 =?utf-8?B?eVkrM29hT0tyRE1HZVRCc3UzSUtuN3NlWEI5MWp5K1ZXM3BXMUpEcElmbDI4?=
 =?utf-8?B?dkNzNFhia3RxZm4xMWc2SG0zdjlMd010VU5TVkdBUGxtMTQvQ1dmeElybGNX?=
 =?utf-8?B?VkpDK1hPQWxGbWhDUmN5VFphaDYrSGdKd3cwdHdjOVRmdUFMaS81T3VLNVQ5?=
 =?utf-8?B?V3JjYkNRcnhsQ21sNHVhRUlIenZnSElJTENLemNmQ1J2c2dpSGx2bFMvRm5Z?=
 =?utf-8?B?aERsY3ZrbWZnRm0yUFNXQzNvUFZtd2NLdFZRVllZYmJma1VtZi9GRzd2Mm1N?=
 =?utf-8?B?L2dlSW0vTUd0eUdaeGxHckZLS2xCNVFWaUs4S2dmZXR4aE9kcUd0b1pBUUI0?=
 =?utf-8?B?NkVXdnk4S2RadkxodC9DSzRDV2Z3N1VFa3lNYTZxbXVKVHM4a1hVQVQxRmpz?=
 =?utf-8?B?cUhoSllhWG5VczViVGNEZzg4eHpEczV2b2tpcFBFMmYxZ2dGZ0FNTDY2Tldy?=
 =?utf-8?B?NnkyQ1Z1U1hPVXYwcldLK3FsK2JkMGFhMlRwT3ZiM2tlRHBqaEFzRllCNUs4?=
 =?utf-8?B?VWNaOVVHbW9hcGZZTDE3cDFzb0FFM1o0ZVZURmNZbCsyaGR1UmVGbzJSWlpw?=
 =?utf-8?B?MWNMV1pFZStkcEhoQS9MVWZtekd4ejVhbDJ3RTU5KzNoTmlUcmlGYUFLWldN?=
 =?utf-8?B?Y2tHOFluZzhRcjNyYlJpNVlaRzBPMjlSK29zOUgrd2xkbDdEbzRUbXFmZ1Q3?=
 =?utf-8?B?ZHROM2c3Ujk5RVNIQVJQZVpTUSs5V3VpZ0t1ZzZqMmdUOUhpRGJFN1M0cnZS?=
 =?utf-8?B?L2ZVTFpNRjZ3VitlTk41Q2dqWVdpaVFmYmVQOExPNGRTZTByU3U3VWtYNnov?=
 =?utf-8?B?YzR4QXVkK1FpQU54R3k0VXFXcVppUmMxc1JMUWVuMmlmcHE5ZFdqV0Rza2hr?=
 =?utf-8?B?L3RoWWJRblJmcDFlSzdYd3JvSlZQR1o3ZzhsdVpzZHFhMlZ6cVlMdk41WEpw?=
 =?utf-8?B?dEljVmN1NER0YTltdlEzbTQvYytYUmFFUXJhZGhsdFB4ZWhDbE5oeGZDMjBD?=
 =?utf-8?B?S2xJYkwvRjMxTUZxRmRkbm5JeDc1VktDeHd5WGl2QVpOU25Qcjd6d3RySi9Z?=
 =?utf-8?B?b1IrcEVZdFNFQ1FLVFhQMlFQRUg0Y0ZMWmpDTC9XeEE0a1gyb2l2aGNYSDNt?=
 =?utf-8?B?VHNzcjNEQnpqbFlXU2kzRXJMV0dOa2QyTDZWRVQxemZJSHJGOG1ZamVOMW9V?=
 =?utf-8?B?aWVGMGVJdGNZRTBvVHdRVklNREtZOFlMTWx3VEpkV09ybHpuNmYxd2t5bjVZ?=
 =?utf-8?B?RWRXUmwxR2tlMzZ2dXNLcGtueFpKd3VqSTBxNXg2R2lFWFJ1UE5zZUJtU012?=
 =?utf-8?B?d3REczdHNUQvZjhHS09uYVhQS1NycFB6ekJkajhJb0NCREE5bTQwZlZOUDZO?=
 =?utf-8?Q?SRBQf6SgAwq9KkgYym0b2Fn5k/s53YrV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QlhhMS9aMnZUNllrWEVWQWRjdSsrQk43Rk5NZE9WM20xekhJSjRscWJIU0ZZ?=
 =?utf-8?B?a3QwcTFsS2NjSkQ3bGNqZS9PNVNLTlBTdFBaOWRLUW5ocW1QNFRMLytpZFZi?=
 =?utf-8?B?UENuQi9JNlFJRnVNaHZiUzhUOWlqY3hqdEZwYzVFTVI2eGNGNXZGSEN5a2RS?=
 =?utf-8?B?L2pCUFYxa0VmYS9pYTVOWnJGZ3BvUVZ2VnZaN3MzTDFEZ0kyU1RJUkczNzZO?=
 =?utf-8?B?NEt4S2pvVDdPaktzNlk0Y0tUUEN6b1BSd2d6eXZVVURQL29ZcmlCSTBVZzEz?=
 =?utf-8?B?THdBb3ZGWHZtdWpOU3FwTGkvcXVzWnVsT1FwOEw2bjNDdWVrV0dISTVUV29Y?=
 =?utf-8?B?ZFFkTmZpSU4yTVlqUy9XdDBPeWV5c1RLS2tNdVhqSlJsb3pnRWQ5MkdacUlt?=
 =?utf-8?B?MCsrZldLLzZQM251ald5eklobWlvWThnYmdaZjdYRzlyMmFvLzVCcndrVXh0?=
 =?utf-8?B?T3lySE9pblpGVlZxVjA4VExaOUM3LzlFSTd2YXdlUDBBZ08vUyt0YXN4NzA3?=
 =?utf-8?B?UG8rY3NUbm1HenA0Y3pDZkFYWnIyV1hwWTZ2bklpMzBHM3ZSLzNNNGx5cVMr?=
 =?utf-8?B?UWJpbnU3U2ozTDdvamI0NFpxZEh3L25sb3A2S2orckN4WTdCbzYxaFc1dFpZ?=
 =?utf-8?B?RS83bmtrRGJsNytqNXQ0NGUvTXQwOUF0VUJwaVd5SWhhb0hMSHIvL1pjbDZC?=
 =?utf-8?B?Y2t6bXYwdGFQcTB3OFV1alFaVnovWjhmbEFMVHF3VDhFei9ESmRwd2NRajlu?=
 =?utf-8?B?UXltZDdMdzZkUHBOeTc4ZUZVUDJvbndGU3RyQjlFN1pQQU50aGY0N3dNZWFT?=
 =?utf-8?B?dGUzM1hvSStqVE9ZYklBd0J1aUtDWUxXTm1aTHhTNHpUYWRQRE1MVkpUd3VT?=
 =?utf-8?B?LzFxVmZWL1F1aWl1dDNranptcFlYVGMzNjZiQzJySG85QVh6Mk5HSmVURS9h?=
 =?utf-8?B?Y1B0M2oxN1VSSlVwdGFodE9rcjBuQ3BGbldDVDlxTUJNbEI1SzlleW50TDN3?=
 =?utf-8?B?bFhneFpGalB6VXNHbXBlbm11WUtzSUlrVENndzZSQ3ZEVTNkZUVneXNUNjJk?=
 =?utf-8?B?Q25KSGVheVZlckJuU1lhaWNIYlZ0b3plS2xrOUpRaVdxOFJxK01sWDNGRzhi?=
 =?utf-8?B?L1VUaEtkL0Q5emV3Rk9RWE1pSGFPdjBZdTFsamsxanY1QUg1SFZLT3Z5bTZq?=
 =?utf-8?B?ZGZZS002T3oxem4rNjNZOC9oRUh3SHhGUGZyamhqVXNKMmZ6dFozQmNtczlY?=
 =?utf-8?B?RkVQbmVERGFTNVl1bDBUUnFEVDFSYk5wZVRuR2N0MWJRSi9vY2VlMGQxWjZq?=
 =?utf-8?B?RWIwOGFCY2t2bTZhWlV2aGN5WW9PWHBrWEgvaUN4YWQ2YUVsZ0MvMmQ2S21F?=
 =?utf-8?B?N2krSWt4eTY5YWlzRWlQbS9MUHVESjlEWS9salUzczNBaFJuK09GdzlXTG5p?=
 =?utf-8?B?MllJL05tYzNnbm5tczRENTc0YlQ5VGxvSGFlWGhyK0dEVDlDV2tCdFBzbTFE?=
 =?utf-8?B?dWR6SkZPOUxyN05Vb2F3VUpYTG9zODFPM0twNUFrODAyMmxETzR2NXpJWlN6?=
 =?utf-8?B?SHU5REoxbXVtcG5vSVJ5VDY2UUhhb2xnNUVpUnJqak43Q1ZXdllVWVVEMXgr?=
 =?utf-8?B?UnR5RlBYM2ZrMUZjbk9oOE1aM0tNNHNaY0dyRFcvZXRqbDZETENpVFlUakhR?=
 =?utf-8?B?QnA2Z2hveXZFUkVPVmNrNjR1UXNBMXlneEtNL1B2bDFXYjU5Um1COUF3QmNC?=
 =?utf-8?B?YWY3S2h2VzNRRUVBTGVDejRoL2NaR2VjK2JLUmxyanIyeEpaZC9VdXNiZWNW?=
 =?utf-8?B?UWsvaC9VYW0zczhXSythclg1RGhKa2lJci9vWTJDekhzRmwxZTV3OG5UcmxK?=
 =?utf-8?B?MjUrRCs4ejVsRXNiWEpyc3ZuaG5YMHk3WTZUYlVna2gxV2NQd2o5Rll0RWly?=
 =?utf-8?B?ZUYxR0ZrSTNBS2s2ZGdkQktucVhkUXZpR0lVNjBlbXdrY0ZiRXFKVFlqUHBE?=
 =?utf-8?B?cDdWVDZoTFVsYVVRbzR0Y3BGNlpaVGtaZ2tiaSs0QmJHQzRIclFyZUl4bG5q?=
 =?utf-8?B?SklFeTkxWjRGcUhkd1lla2VEWXUvTnI1UGdCbk5WVUlPVCs1MHM1MmJoL1Q4?=
 =?utf-8?Q?e8Lonc0aKgyDM/b6OG2O8Vqo2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504aff47-d633-4792-6de5-08de1eedd7a1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:40:01.0676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7dcA6Zxz5fhlNbdJB4gpSBkpWgssUH2/8DnwdzmMXSSNoETO+2/9ZWSnsyUnpZLiwdMH7cWhb3wyuKwzRQktg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475



On 10/21/2025 7:13 AM, Suravee Suthikulpanit wrote:
> The GCR3TRPMode feature allows the DTE[GCR3TRP] field to be configured
> with GPA (instead of SPA). This simplifies the implementation, and is
> a pre-requisite for nested translation support.
> 
> Therefore, always enable this feature if available.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 1 +
>  drivers/iommu/amd/init.c            | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 556f1df32d53..9226edd8af69 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -185,6 +185,7 @@
>  #define CONTROL_EPH_EN		45
>  #define CONTROL_XT_EN		50
>  #define CONTROL_INTCAPXT_EN	51
> +#define CONTROL_GCR3TRPMODE	58
>  #define CONTROL_IRTCACHEDIS	59
>  #define CONTROL_SNPAVIC_EN	61
>  
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index f2991c11867c..c45a4bd89569 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1122,6 +1122,9 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
>  		return;
>  
>  	iommu_feature_enable(iommu, CONTROL_GT_EN);
> +
> +	if (check_feature2(FEATURE_GCR3TRPMODE))
> +		iommu_feature_enable(iommu, CONTROL_GCR3TRPMODE);

This works for now as iommu_snp_enable() enable is getting called later.
But how about moving it to iommu_init_flags() ? Also we should probably add a
comment here.


Not for this series, but may be we should rename FEATURE -> FEATURE2 so that its
clear that these are coming from EFR2 register.

-Vasant

