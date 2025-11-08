Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040ED253F12
	for <iommu@lists.linux.dev>; Sat,  8 Nov 2025 17:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762622825; cv=fail; b=qV3M99HlSyeqHNKYSmEw0xAyHjUiLPMoYJw2RB2RSm+s5oBLIn/VmuXk7Zmh0Z8nJLsiuKzKBkuP5Ol6dH50FKNq9sdGUfFCFJ7jVeOATyfeJCllbfzeYEeohVelvds9cPRy2Jg/Zc7dVPtQWmGciJgxamSwIkkzTz28w8L6iF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762622825; c=relaxed/simple;
	bh=3f3yQiuWs0OB08YV8tmuiTXkBzRsvFgvptELvF9fuHo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nRQUVz1umOmmMYstRe1iJCpvz13zBYKfrASJjOBZ4t79rH4QpXvtyem8zb90b6ynjZoautDghNt3J2UA3l0u1xU2ZhkwcOCYvkZpp+RBhzbRDJgPGqbPU5Zgl7W4bo7s8a3tnQL/gNHsgG9+25juFNfMKqPOlsmwBpQMXjxzMG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NQnnGN6T; arc=fail smtp.client-ip=52.101.62.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NQnnGN6T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orO3QufnHmAjWqEB9Pva6mvjPaWX4uvMIG7jDzusMgFDkDXK5XZWJ2yk9obo/noJly6StKYRDJx+6VdImgyeIZaX69o4iitSZeIkj9wjbZoogHVfW9rzMOHinvt5Why4h2Jgc1fhcykri6tXdoBPhHZk/erd0WCdP0+Er5jFesDy8eD/m/mEsxBT2cmWY9ZFfnunpse2Afglw0+Xeno12pN17olp276NCbsIHFgWZRoxSG+kbR6lamFGmvDt8u3VylpflvNxH2yqz/lUIKfCCLs9Wdn4uxkI7tMeIBY6nGikK6dPlddNNyZA+/rvSeiTMpUxxdPHoe6/jCpQdN+ebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zh3J0+oevAWAZaSg3VP73AL33hnnlqY0xXPkC+ogiww=;
 b=I3C+QAM9HOIYsqmReZ8JqtjNtbwcEISuN4Pcxi9GDaWk+yxU/cY78Ov3guth4W5kC2Gg95DYYaEJYpYpn2RGzAaUTkdERf2FE10VdrvUltHyBN60y5mNrpXivd3DIcwdNmWckGHGWBWiqzuHD0MEAKq/NpukP/+SgBJAnH++KFp7HebjKkOb8ppjKqbbw2g64dnyZbeOwqh7YAKHsUO86z8azG1GPdiys6TuixM/4O74KFkSnIHV3IR3ZX7CTsmfMgR/+Zdj9Ub4ZZB7U8O7gB8qTmiKfgWTCl9MuhwRSM8xLkL4BMjL4CIy4LAMiKnHx8VuxNVUFCgqKMTQFmEDjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zh3J0+oevAWAZaSg3VP73AL33hnnlqY0xXPkC+ogiww=;
 b=NQnnGN6T7ov0S5uxtGJKCLtflv/OiBdWYGOSj35IQKGV+fdsOmzXOeKf8QJWoTj3tkbOpLilX2cCdNcJjcY8SNRpzi+tnJYm+fAytmLrf+feVTQnQWRkmoN0EtXCO79/B1o0op0S1BhaxjJwV9hLi2x9CMR63jZM5HATSiGnVAU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ0PR12MB6992.namprd12.prod.outlook.com (2603:10b6:a03:483::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Sat, 8 Nov
 2025 17:27:00 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 17:27:00 +0000
Message-ID: <18588165-9b95-42c2-b0eb-371c06b0edeb@amd.com>
Date: Sat, 8 Nov 2025 22:56:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/16] iommu/amd: Make amd_iommu_pdom_id_free()
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
 <20251021014324.5837-4-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251021014324.5837-4-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ0PR12MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f5df06-2cdc-4321-6640-08de1eec0678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTFwdjhncCtCVCs0SzJieXoyUWs5SEZTNVBrVmpUaVVUTXVyM3RYMXNqRlpZ?=
 =?utf-8?B?SEVvOVpsc0ZyQVVHYzhRenRyYUlFNUI5T0Voem11amhvdmRXcDB1T2hYRTRS?=
 =?utf-8?B?RGo1Y0dOdmV2bFlhMVJ0MW1VWHp3Q0xlN09PRnM5dlRMa0lMZU95L0cwNjhi?=
 =?utf-8?B?Ui9XTE1ZblBJcjg3T3IrbEQrWGI5WllMUFowVm5CbUZVclZRN0I1cnJlS3ky?=
 =?utf-8?B?Nzl0WEZRNHhzZ2huWWxpRHQreUc3MnY5cGNhVlRueWtnZmcxTTcvL0xIR2dI?=
 =?utf-8?B?YnBpN0MwRDdPNWVTWStsbmZtdC9GcmhKdHRiR0hpK0lpZmpQeE5yMmJLS2JS?=
 =?utf-8?B?THNET3Z4RUdHa2kzWGcyaC9JS04yZWwxdVRUQVlHOXMzY3dRVnJxN3VEZkhl?=
 =?utf-8?B?MExGRTJUYjJKVVVybUcvcDllMEhrSVQ1azY4aVd0SVl6VVlVSkZTNDNnSytk?=
 =?utf-8?B?dkRsNUowekFLWFJZRjVkd2szWGttczBTSnpVOXY3M01TQ0xSMGgrclNVaTNr?=
 =?utf-8?B?ZWN0QTFZTVUySGgvT1FkK3QxcmpMQVV2bmZrSm1uMWtjU0FNM0hodHZLRGhU?=
 =?utf-8?B?bkc4SEF0VmkwTldXM0Nma3Q4QmtDQnlWdEFJRlVQdW1zTVhhRXp2VXc5Q0V3?=
 =?utf-8?B?K1FUOEVhZm5qWnA3QUlWNThaR2hTYnNpTEo3UytnMHBmeEtYejFFdnZOZWti?=
 =?utf-8?B?eFBCcVJ0akdFTm5zVE8zT1o4RzdrQ0FFMjJRajdyM1ZibDMvWnJSWnVvdjdz?=
 =?utf-8?B?VnM1VmtNS2t5MlpPVVRmQWxMMWVmOFpocHZRRmEyb3E4WFg0Sk9lVTJncGcx?=
 =?utf-8?B?SVU0bkxraktuOEtvaktPWkh3OGRsbVM2cVdqazI1VS8rTmVxejk5eTFUQ2tj?=
 =?utf-8?B?c3oyY0t2SG81eno0S0lLWVJCZEpmSGJLNFM5UUNIcmhLWkVVcjJwV1g3ai9O?=
 =?utf-8?B?T1BDK3ViYVZtMW80UVRHb0UwQ00wOFFtKzJCTWlQb0lJRTNwK21WY3JzcWZI?=
 =?utf-8?B?Y2NJMnZud3FJVnhUMkNLbitrT2dkYlA4R2xGQ1RLVVZ0Y3VZRnNkdm5CeENl?=
 =?utf-8?B?SXBmTHI4STFZSWNqZE5KWUxZRlp6MytFS1NPM1NsRE9lWDRvVkJ5OVV1Szl6?=
 =?utf-8?B?OWtqb2xFbjdjaXN6a0gzUmNISkJTRGRHWkdIbTE1K05nY0VsbnJmOUhGYWJY?=
 =?utf-8?B?VzNVanJUSHFTQUtYY21iL0dWblh0dm04aGhMc3BGWUU5T0pvakw3YXdvaDBV?=
 =?utf-8?B?VHRpUU1ES29TSGwvMEMvNFBCSDRvN1BOTEE0U1AyT3F0VUNGMFA5NkdoSmdu?=
 =?utf-8?B?L3hSaXVFQ1lTb3VqNjFiNkszUEdhQ08xdFE4WmI3ZEpwL0lxMVJzSDl1b3RP?=
 =?utf-8?B?NW90VzBiNGFsNS8wMEFuWFBlWUppaDhjcVhSMEh2d0VLR244bVB4ZHNTNzFT?=
 =?utf-8?B?SCs4ZktyQUpyaVFwL2JPR05UYWROT3hwT1B6QmNhUHhnc0tYZ2xGLzBja3hZ?=
 =?utf-8?B?RXZZRjhuam5LcHlsbWtEV3gySmkrRDJyNGluemJzOVlZWEtTL24rRGpXdmtK?=
 =?utf-8?B?T1Rhd3hxWWlPV3BBdEJhYmdRdUhqb0U3ZURpdWVpeGppZDkxRENCODhNbnFI?=
 =?utf-8?B?R28vVk9sUEw1UjdueFlWVlJzN0ZVUlptV1ZIS2JCZW1zdkM1WmYxYkVCdmZZ?=
 =?utf-8?B?MGgwdmNZWllXR0RqRndOZEc2cW5iejA4VTdCa1dkV2kwT253ZExCT3hFeFR1?=
 =?utf-8?B?dEpVZ2g4dnBnSjBjbExCOTBnNmpFTUx2SjlhTkY4YjhFMGdROUtjSE1iYVJx?=
 =?utf-8?B?Y2dra2w2MzBKZEF5Wm5DZGFnbU5tNUJKOEZXa1VVeDZBLytlNElkL01Yd2s5?=
 =?utf-8?B?dGJoeW83RGhIRUJFdnJtWTQ3NFJrWVNUNDVkbTNUMmVjOGU1RUNxc052a0xK?=
 =?utf-8?Q?pbdyqssRZET0cV74I75eZHB6XNe1W7Mj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHhkc1c4c1FnbEdLZ2hQV21FUkl5akg0THRTbFByYjdTcko0bTVsYlNsUHNE?=
 =?utf-8?B?eHpuVFJyNFE4U1JlNzd0S2lnSUVNc21UNlFvem9iM1JFZ2x5L1JTYTBpaWhz?=
 =?utf-8?B?MkYyaTNuaXVUVDU3UHlzR1JmZGY0OUFGa2F4aEUzUTQxbVNaUGVOS0FkLzFZ?=
 =?utf-8?B?M1I1WUNrb09NWE9wb0x2WlYyVUFMaHlVNDhGazVabnE3M29scjhVVzJIODVS?=
 =?utf-8?B?SVVYeHJKSE1paVRUb0FSR3JuQUIxeDBqQmpQVDRFSXdSNTJ6R2JYSzVNUmpJ?=
 =?utf-8?B?R0M0M2E5YlZSV3gxbnFEZVh1elMxR3UzdkgxcUhOaS8xK0w4TXowek5teGh3?=
 =?utf-8?B?RXMranN1SWdnak5oTEpYSVE1bFZIcitBbHlCOXRGS1BOYlZ1YStpWTI5S0lP?=
 =?utf-8?B?djRRa3JQbTcwSmcrWVM2K0ZQQk1IRVoyZisyNlZRWjc3M0ZFY0ozbHRIUmJK?=
 =?utf-8?B?VExlZjlreWdBai9GbzRFVzdJZkFkMkNUWGd0aTBDelJmdDhDcWVFUWUxaUFs?=
 =?utf-8?B?dk9PWGRHMW91L3FmUjl1OEdMQm9XRjBaaW1JNVg2aEtRY1JNTU9yUThvVGQ1?=
 =?utf-8?B?NE1qeHZ2c3N6MUlEanpYVzltQ1lVcmVuZVBOOUIySXl4SGJudjVLU2V3UFE5?=
 =?utf-8?B?akdRL1JoUmh3cnFjaDF5K2xpQUp6R3Q5TDQ2aTExTGJ2UUszazJTOGJjbFlN?=
 =?utf-8?B?c1lUdG9PSzZ5UGwzTm1aaHorSUpZdUlsWGN1c202V2ZRQUhxYWNlUmFXWWNo?=
 =?utf-8?B?MW5HNERwcHpxY1hMUFM0L09MOTF4U1I4Si96OEdJOVJKeGtDSTBMcmFCL0dr?=
 =?utf-8?B?UjVSZFZJa0E3elV6ZlZwVk56U2x6RFIwMThyMHhPZENJdHkyZmJnUXFERUto?=
 =?utf-8?B?VE01K1dIRHVIeldCSkU4NkFIVGpqUkJ4R2dSYUo1U1hCVFRJWFdyMXl0VXp4?=
 =?utf-8?B?dFZKcUN2SE9SOVorMkEwZFpQUDduVmloQ1Jmc21zcnJEL1pGckU4T01XU2Jh?=
 =?utf-8?B?K3FlaUU3dGpoTmcxRG9TMmhtckFXbSt3NUd1SXZ3T3ZQS0p4QXBjQjlXVmQw?=
 =?utf-8?B?LzN0NUlHYlhwSFd6bmppMEFoSm81QXIraUxsaGVaZ3lUT0dHTWYzSjV3YW1V?=
 =?utf-8?B?Q2Rub09kVjBHemdqUENqc2l2TWVDMkgvbDlncEpWRTZnSFUzb2xKZ1RnZ0FZ?=
 =?utf-8?B?NnNTV2J4U2lFa0pJbS9vNkN6TUhqb3UxcVNmOVNmaHg4RVZpV0FrU3RWcjNu?=
 =?utf-8?B?enVqbSs0VVRaa1V0SEpWQWRUT1hJQVBrbkJxeE5pUHlHbHplazZFTG9acjFN?=
 =?utf-8?B?VDdDY1E0KzJhZGpkczFkWG1DMFNBdDlEQm1RdTlpU0x5c01hcGxPbDZKV3Bs?=
 =?utf-8?B?V2FMeDdDOXFDQWVOL3QyKzVHRGIyRDArRm1OWHgra2pRT1JnR21Gc1RhUzdH?=
 =?utf-8?B?SkRuTEZWbm53WEd2OXh6bTd6YXVlZlgvanFGSnpqWXU3c1RVN0RiclYvZHFr?=
 =?utf-8?B?MVhnNkZaLzhwbW9ya2h6QmZ4clhCUCs3MFR3MDNuSGVtQ0FKbVVrSnZBUjJO?=
 =?utf-8?B?UmZoSlZISklpQ21UcXg5djdaRW9PbTM3NitOQkp1TUU1MnhablJOVWJ4ZUNy?=
 =?utf-8?B?ZklCU21lT1lra1BOditGZTBNL2dwTGZrODBvU2M5c3hybXA4bmdNdlhTMjlZ?=
 =?utf-8?B?bFU4L1U1ek9RMUFlTGhDL0EzaTdmWUtRYW1aVFlWUWxSejRnMVJBamxDWnRp?=
 =?utf-8?B?NGdMcy9PaEdQcFBhY3FBdXJQSUxNS2lFc3V6VmVvZTZreXpZaUpjYWtmWkxy?=
 =?utf-8?B?ekJvVWt1ZXM4WEpqNVd3a2NqcWVIUkhmMHFsbHN0SHM4MEF6eFVMb2tMLzdk?=
 =?utf-8?B?SXViT1VkSnBPcC9KcUlkSTM4Qk1rU3I5SkVlNFoxbW4zYUl4V3V1K20vNjc5?=
 =?utf-8?B?aWZ4TFdTSXUyU0Npd28yM05qRGFza1N1R2dpWkQ5bjF6VjlXUUtxS0RyQzlr?=
 =?utf-8?B?RDMwUVV0T0FwYlp5WDVZTFFCajJ4a1hOVTlTclB2eUZyZTM2NEl5Uk9WL0l0?=
 =?utf-8?B?UC9TRlNPbnFDK2hRTWoyV3NwK1VURVZxeGxMRVEvcTZSVFJPR1dHY1l5cjNk?=
 =?utf-8?Q?J007scaUdp6uSRB1oUm979aHp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f5df06-2cdc-4321-6640-08de1eec0678
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:27:00.4286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YQCxirVMAhmXYwF5BEGHS/LUebtVpeyicF8Rna30v6r4P7bBVpn7NkcrGOHtOGnDeliz4OZInIupyQs6nnhfDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6992



On 10/21/2025 7:13 AM, Suravee Suthikulpanit wrote:
> This will be reused in a new iommufd.c file for nested translation.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant



