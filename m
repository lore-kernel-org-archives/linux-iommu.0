Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC1B22B668
	for <iommu@lists.linux.dev>; Fri, 25 Oct 2024 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858621; cv=fail; b=X9FwFRtrdxQ3PXPYRUq7B8AuIcB4tzyuylDX0aSLENlUrNc+lL/efS/m0yckim0w/iXReZcC3jPSWVafNNHgW8aeqSWYoPMC47N92jvUseU9u09FWsvuoja6d5QMLRPPGO3VgzhCPVioYRcf6kbeM1z+vnHBPh/OiLJzaQw9cu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858621; c=relaxed/simple;
	bh=sESh55FPDNJqlJ7Y8NoVwIizIelL1p4mnhfG+Ue5Ob4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mZJM8iK8gcQtiRO8/8LJUuRSrCqgzBI1EYE9Fd0vSRX2iOx3PIbUYkZmm1Vo7/0RraWlYzRI+Xfey74Ec2CTOPYGgnDaef4aCjAhj4PCFYE8eS4DC5EBbzQyHaRE4QCT/Mws1c2zBxZavP4q3Y/cA4JTbIkgfX2kmfYbauli71o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OxrcGT/d; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OxrcGT/d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W09FbfM/9Ermk3oChuKPT2OcIjdngqHPTWbkrUNnr7pWwGyB2e7cZBJDnHwX/v3CbUQ8OY1Wfu75wY20S9SY+Gz3FNTUxHLp+5rWYYI00PYMgCZjp6Ns/EkVQwKSsV/4yjE6qtjHab3WoeIMu3pBCa2j9JnRBrIXVkca4Ekcgb9ED5bvaoWjsyk7G43t/RvzoWQApWO1kWKyrYnRM37ypUxxVrGLC91tWIaFOVW5oII3e4zjXwJ4v+OddygqrBproO63EyS9iglFM25dGiNGbuQmBT/a4bOedQ2DKhMXdo9RJciNM+vgn0wlcmJwQytsJDBPO3RoadMOaJDXSs0wkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muCW8EE/thj61ytJPJUyEDF8RlaHmCTbxyd4EczLAIQ=;
 b=Z5hnWV7dNrmiWyMFBWw6on3iWXQlsEGRkyQ6OKb/6I5t/Ok3yasQOgpiv0peJLgrBuFiyIwAQxj4C6vJsYh6VwLv+y6Vae6b96RVAyM6+J8HUbfUQyhikSpxVFuRQOfMB9KqL762jDxGSU29c/6RO0RTn6r6HTfN8e47elVI2f1OIS7rKOFW5BpQCDVJ/8J2R7SF0aCy809y4tETdfTSaVZFyjk+cJVDqd6vtr+6C7sioQYAUfaZZjf+Lpmos6CaGNHGP2msRVszLJ2tZFyi15vUua+kUwmYwcsN9x2TZIkb6wSpPSrnOXDBTG1FAQoqE8Fp316T7bGP/pGIw/vO4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muCW8EE/thj61ytJPJUyEDF8RlaHmCTbxyd4EczLAIQ=;
 b=OxrcGT/dsLKsjC08B6Bbw1ewasZQDnpPi/J9sElKxgKj2DoZpoux9i6uZUVR4ZaSyWLo31iW8f5nMAE7StOTDBA2EwggeggqYm3u62FjYYjO9DC0wfdRg1jxYacpZ/VxHL1x/Y/VrOVfc6AWGEY4qbrVRBzdYcjWFg1yOrenkPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.29; Fri, 25 Oct 2024 12:16:56 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:16:56 +0000
Message-ID: <b99f2e8e-a23f-4ba7-a63d-b35bf2b831d2@amd.com>
Date: Fri, 25 Oct 2024 17:46:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/10] iommu/amd: Use ida interface to manage
 protection domain ID
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 Joerg Roedel <jroedel@suse.de>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
 <20241016053501.97497-2-vasant.hegde@amd.com>
 <20241017131403.GK4020792@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241017131403.GK4020792@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PEPF000001B0.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::c) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: da65a47a-a414-4b5c-67c2-08dcf4eeeaaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L281TmVFZHhPWFNLMEpvRjlyYnZ0RlpNZmJ2aVh0SEtHS2o5ZFdlb0pPN0sz?=
 =?utf-8?B?Z3pMZDZleXRyTkNTOW1SUXQ0VmYyVHpCdzZJMnRYc1V0V09MQXhwcTRXY2lQ?=
 =?utf-8?B?U3JhY2dmK3o5ak1kcDd1Zjk2Qi9QMVVZdWRraDNVMjlTZW4xMlhTTDhTWnJW?=
 =?utf-8?B?NmptOTJHUks3LzltdWVEblZUcjhSSnlYNFc4K0F1WDBHTUdRRVNNU0FJT3J5?=
 =?utf-8?B?bGZ0VlhCVFBab2dObklDaE80b2ZacUxBbGMvM0RSdkttVWpzb09oNTNTc0FF?=
 =?utf-8?B?Nlh2bWt1VjBRb1ZZeWNOd3pVbUVTY0wzdWVUdUNYRXhpaDJDRWRCSFVJR0pt?=
 =?utf-8?B?d0taYkcrb3ZUb0o0aERYUVF1ZFBndnhXamNER3RacjA1K3ZqSjZPVUhPcjlT?=
 =?utf-8?B?ZUhCQkRMYS9Ya09aeVFpb3duQWlZTFBzN1BPUVpqL1V5TWs2UThjOHFuSUVm?=
 =?utf-8?B?N2kzc2duWTliVXBHWHcxUHJvU2o2NEs0aG9DcklVV2pUYmtnUThHZmErQXFm?=
 =?utf-8?B?ZzFUNkt4eVh5RmNqd0hjbHFEVDQ5UTBEcXg1bmI1Y1I5UEZGdWtnbUlmR2or?=
 =?utf-8?B?L3U5bTZCQkozYUNXQWJXamxkUnlYYTdBbzIrNWpWd09LS2JnNThBWGxFTC9N?=
 =?utf-8?B?SGU0UXQ2cVFncVl5WUN3UFQ4YjRUaEwzeDgxN2ZvOUZXSFh2U1Y5K2lUM1lv?=
 =?utf-8?B?MXFqcUVyZzh1RWhXUWVIWVNxOU15WjJhZVQ2d0VpdVUxa0VnR3kvQ0RXRkow?=
 =?utf-8?B?K2xpbklWWUNsaVNyOGs5NVFKTmZybk5rREhRQ3o2ejZvd1dGem9KZmVubk43?=
 =?utf-8?B?TWk2UXZtMHRrMHlzZWpRT2ZKUWc0a05uZ3pra3Jmd2ZsWTFubGs3c2I0czda?=
 =?utf-8?B?M3U2bXRZU2NUMnZlcmNualIvbEpzV0FLRnoxTnd4QWd0eTVxbG13MTZabGth?=
 =?utf-8?B?a2s5VFh1K0FzdEhOTHRBQUJFYUpLTzVpZzVzWkdBVHdSeCtPQVkwUTFTdFJP?=
 =?utf-8?B?Sy94N3kxUEpZVEFDVjNycXpaTmlISEtQcDJXVEx5ZDdOYk9SNUIzQ3hSZWlN?=
 =?utf-8?B?cFAraDdGVDFYWDlOQWkvL2FKWTlnVHc2djF6dmVzKzlWTEppdXM3V0hWSDJt?=
 =?utf-8?B?Mk9sZXg1SktwZ2t1UjNzMndBbmxtd2g4aGJ1T1FWbzNmOWtETm5PS3FGcm1T?=
 =?utf-8?B?emtGNjRsUUxYNWZsOFVWWEFmN3BON0xQSUdDR2FEcXZOUC9NMDlQaVBZd0hM?=
 =?utf-8?B?MHdRY1BxL21jd0h0TU1EU0lhOGM1ajNDM3JBZEM2NkFHS1U3bzdSTmY5Z1pP?=
 =?utf-8?B?WU1hT0w1dWVSQWxkOFZ6L0pkRzNhUkVlc0RNUE1MelE2ZGhYV01nb0ZrS044?=
 =?utf-8?B?WUI0ZG0xK1pQdlZKT0pvNFJoclFtd25qTHJqY1I3bVRXUG1QKzF6dU92QVE3?=
 =?utf-8?B?TWJlK3Mxb3pqK1RDYmUzUjZ1LytoRUhTTU5sQW9LMk5mc2hBSEdnZ0o4Tk11?=
 =?utf-8?B?eVZiMFpGWEpwRXhxMXVhcTJVL2IySjBJWW5TTXZvdjZobU5CbWlPclk0eG5B?=
 =?utf-8?B?Y21vbno4UWVqT0NrMUtyN25sR2sxOHVqTTlWTkhVTmJzQjhPSnFFckVqcnJ6?=
 =?utf-8?B?KzMwMDF2MnNUY0I0OWtDY2N3UGVxbXpLN0RqdmJOYjJZSStIQWZodlkvYVY5?=
 =?utf-8?B?V2wvUE1YbDN5RTQ1cDJmWVlPR054djQ2SG9adjQvMEZtTXRGUnNiZFZ1U3Fx?=
 =?utf-8?Q?a5BYPDIcvgYQH2gTEZHel9R2Q352gY04xDdi73s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEltL2RXQVZVbDdlelhoOVdFUzF6dGw3L0hFNUxJdU1sUElta3RJWGJrZmYv?=
 =?utf-8?B?dkNCaVNHaHQ3dWQrZnpkRTdpZ3BOcmt0cGJvYStHeTRWWnJqSDkxdUl0UEtk?=
 =?utf-8?B?QmhYenJXdnNoaHl1NHJUZC9jWEk1OURaUXpZdUo0WVZUQ0h0SGt5WVpZN2NE?=
 =?utf-8?B?TDBwNk1wKzJGcHFvUFhwWkFhMWRsVm5mQ0pIaWZ3VUV0R3kzMkZtb2VteHRt?=
 =?utf-8?B?bmd6dEs1NllveWsrQ0Z0dnRoeGZoNG03ODREUDl5azB5QTA2UFBuYVpPQnoz?=
 =?utf-8?B?TnpDK0E5TDhNbWVFbENHRlNMTWZkTzIxSldaaytEUXZ5cGhhVzkzZEZjWHYr?=
 =?utf-8?B?dVp1dGRkVVg5TUNCVWkxbld6RkpseHJUR3hEd0V3OUlURTI3dkdyQVlwZGFz?=
 =?utf-8?B?SUZneDlqM0tRSjZnYzkvQTc5ai91M09rQ1pyQ01JUlJhcUFRb1lCY1l1am5B?=
 =?utf-8?B?TlpQdDE0YzlUZWNhUncwcmpCNmUvakhvdytaWnlaYUVIL2xFR3RFUmI0VFY1?=
 =?utf-8?B?bWZMeDB6MlcrQm9xQ29xWG1JWk05ZmExMGZOUndCMXBwTDF4bXUrVFJkUUFF?=
 =?utf-8?B?cjYvU0JwZmd0Mm5XUWRPcnNSZ0d1MUlmWDk4Z3ZvaGJtQTNvb0o0cnRoY1lI?=
 =?utf-8?B?eVU0czJRTjRrTGppNW1rR2xmdzFXTmlrUjJHV3JSV29QZUJheE1ScWhTVFJi?=
 =?utf-8?B?aW5ib2Z5N2gzVkJzYVcycTBmUEwvT2Yyb2Y3OWhTbHdiTUliZzVvNjJEZ2hS?=
 =?utf-8?B?NlJ3RllSbUl5cDRiNzZnRGViVXVLektFYWVxbVNBbmc4Y0FRTk9MelJzMUhx?=
 =?utf-8?B?SWV0Q2tkenpVTkZJNzRuSnpVM0Ric0NxZnBERG4zVnIzRDJRT25VUjZacExn?=
 =?utf-8?B?TlEwSWtla1pzTU5WSUlBWEt5czBkQWRpU1dDSFFUMWpKYkt3M3lPSnhHVVdB?=
 =?utf-8?B?WTVjeXVQM1FoM3JVMEtlN2Q1T1B0cEVIVzN2c1NWaU53c2thYXM1NmRvZnpq?=
 =?utf-8?B?TU9uekZ2UVVLcmdtRUxzUlZ0VVcxOG03NHVqS210VW5mSnpJM3RUVEJxVXZI?=
 =?utf-8?B?WElxVm85dzRmdmRsRmwybGdMQ2QycXhZMGhJdTAxN1NDbVRGVjBqSkpqNlFC?=
 =?utf-8?B?MEozR0tYY2s1Y21pSTloTWhmeUN4ZjFIcHhiQ2ppN1lLaHBJV1dHdFlvMXBY?=
 =?utf-8?B?emRnRkNIYXdNSnE1aUlocGhmRTZ4YVhUNWRqSW5jZEFWZ0tVL09zQTV3Ungr?=
 =?utf-8?B?UnE5bEx1Q3hOQjM0bnNhSjlGV2VQZzZhYWlOSTFSOEtQT2pjNHJ0bS85QVhw?=
 =?utf-8?B?eFVGMEVmV3F5akhGVTJQRGxNNXNJa3RXbm1UT3p0L1NnSzVNbk15MFp2RlNY?=
 =?utf-8?B?d2ZMNWd1MzJzQmNLWjJhc2xHeW1YRXdlM1ZXUnBlOTFMVEQ4YjRJR09uSWxm?=
 =?utf-8?B?T084NHlNQTNOenBWSDJHb0s1QnYyZ3NBcWpMNjJZeFIvSFNUak5ZdWlreWtz?=
 =?utf-8?B?dW1wM0JJRGlPeHpuRmFxY0xyR1I4RE8rR2ZmYjh1R3hJMm5mRUdlV2kxK2Y0?=
 =?utf-8?B?cStiRllCZ2svT1F2Y2hqeWJhYXFjY3lVajZiTEkwR1pyQjJjZmZJdDVJcjda?=
 =?utf-8?B?OVlRM1BnODBKcUI3YVlvNzhOeStSTnp0d29sRjhzUm9PUzNpcitnQWNrZlk5?=
 =?utf-8?B?bTZaeWp4WXQzU1NqcFRxU0xDYzlEaHE1ZEdvdUR1emszaVUrOEdtZUQrMWlm?=
 =?utf-8?B?cGxMaGxnckx4K01rdWtQLzBYeTFnREwybzgyL2N1UE5MM3FnY2gyaFcvdndx?=
 =?utf-8?B?Q1FjaGU5QmxSdmNvalJ6ZW5rSG10U0RvblR3V0h4Rjd1Z1JiS3lFcXh0K0dC?=
 =?utf-8?B?QllNL2l1N3JqL0w1eXR2R0Zpb2ttdGtJakxYTWlhbHRURWlrYk5TdUF5allj?=
 =?utf-8?B?NnZ2TmdxR3lRUHFWQVVGMWNhdU1yVVhCTW1QdDJheW1RVTZLOWpQT09IZHpq?=
 =?utf-8?B?Z1N3RFI0bU41NGxORE9TUkZRUCswdUtOU0RtV2VZL3ErK0hYVTRPKzRZRG0r?=
 =?utf-8?B?L0dXRTQ1Zk9VMDJ6Y09UczU1a053MDZ5RElCMGpDd2RuYnpHWW1ZSHI3c0NK?=
 =?utf-8?Q?nCSlkzeHzqGOOmRZSH145iUcJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da65a47a-a414-4b5c-67c2-08dcf4eeeaaa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:16:55.9378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmpkF/NqNeumxh9Oh8RUfASRNSqEjU4igzd6DLfpAaScOvArkHFKZxMIx+KC4PKTGJlqolrxKQv461zN6UwAwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007

Jason,


On 10/17/2024 6:44 PM, Jason Gunthorpe wrote:
> On Wed, Oct 16, 2024 at 05:34:52AM +0000, Vasant Hegde wrote:
>>  	/*
>>  	 * never allocate domain 0 because its used as the non-allocated and
>>  	 * error value placeholder
>>  	 */
>> -	__set_bit(0, amd_iommu_pd_alloc_bitmap);
>> +	if (amd_iommu_pdom_id_alloc(0, 0) != 0) {
> 
> The IDA interfaces have a min, so you don't need to reserve 0, just
> make min 1 in all calls, which is being done anyhow:
> 
>> +	domid = amd_iommu_pdom_id_alloc(1, MAX_DOMAIN_ID - 1);
> 
> Suggest to just drop allocating 0 and redo amd_iommu_pdom_id_alloc()
> to have no arguments and set the min/max correctly internally to the
> function.
> 
> Open code the special ida manipulation in __copy_device_table().

Sure. will fix it.

-Vasant
