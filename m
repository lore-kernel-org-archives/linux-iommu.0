Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922E87262B
	for <iommu@lists.linux.dev>; Thu, 26 Jun 2025 05:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750917492; cv=fail; b=VaR1cv+UJylpb5Gbxy2tO3rORaXRLn+0DUIjVFxKu4C1tYFpB444f4wRXJcG+3Ld620To1Wf2EUi41pMzFF3iQu5anlgt5IPBptHIBHvnr+vTSUaK1O/lARJXKBBsq5j1nZitC8S7PaaUDs7k6cCTFZiytYz1CD+LaQrfwFp2r4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750917492; c=relaxed/simple;
	bh=vedkQLonmz4LT4KU3/GqU23uDBE0Q3Lvu1mSFBJFJC4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ODmSER/tZurYcOJRz6Vv377gZ1VSs8lRuPukQM/l6G/BywvypuTcEtLtfVpVT97Nq4/8IsHQbb5uw6Mc9Qs/jLJpVK/p+00LNRIWxBC404fRGs2NvOcjoZPfmaZ01l0DVXs7E25tedLpa70PHlKiG15/mcvBE0VQp/sMn7NiR5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pj60bLTN; arc=fail smtp.client-ip=40.107.95.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pj60bLTN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmPLvnVV/GoHxhDfurJCvZdQr7qhiVE5ZaJ1HDhGCqcLhWNeYWN15Zc7xBcDtG8nPP+ccMysfBv2isd9ImOeBDbhCi6mulmrSNqJB9wHXR1MGGTHmnIZ6jWNdf51zVXzXyHX01jmT4D4oelb+dFpBH+VTYxCpIZNF+UfQEh0oioqTimeTmJuTdH4mI5pKoSwr1LggrdD2wGeySfvCprWMooCHKVIBbiDCFUJwUw3H9s/h8wwHj3RpeIa68lGYPlnFzBPnxQzMMTLjzG/brKxJZjPbH7H3xKTXDmsfVjqGXPaspiVZsWmuk/5L2IXqRTm1i+seIPvCq6g7Fxqdt0hsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULzzbaMqFvhAJeffd4JS3zeec6HXiwUjp6uqe34XlWI=;
 b=uBI39Doa/F1+qmGHHTiNDpcz57NPajx8x+jQkS5bjihGQqT9HYXwXVIXgoLU3SQI5HipaHDqiAFsF/yOacKrvOx+lq/PKL8T9CTH7hXIBj7K4MTom7YD96o/fbIVHl2zmCcPmG4yvIuIwlJ81KLp6K0Kr45cTuiy7GlATR1txB5AkJjXUxlzTNKdi+8/A6SlSsuyr677BgM4wbkiN23uQnGkjyrvmVJV9JFNC+W5idoKz1H90Qsad8DP7pJIWs113l/7puQ/dZVha8xxAiHns8JTYka6xzKFATOvhrpZowJ3xTGCZnlSclbigfWdUwQNVf/H6Z6li3KO42869TSOPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULzzbaMqFvhAJeffd4JS3zeec6HXiwUjp6uqe34XlWI=;
 b=pj60bLTNkMxlojT+MUsXb7ZN3xLN0VG2SdNr+/tv/rqPAAu27D4iakbESZlGBjZapWA/UuftvUTx2+daw9x+mIMi5TB8vSI1/v2zoUm7PYGHkfkubV8+H3AL33dPb8Bsa/tTTLdEJ9JZ2TMdgRkR7O/jSt2FYPVthsxXJQbMVpQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5154.namprd12.prod.outlook.com (2603:10b6:610:b9::17)
 by SJ5PPFD525C5379.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 26 Jun
 2025 05:58:07 +0000
Received: from CH0PR12MB5154.namprd12.prod.outlook.com
 ([fe80::9661:1085:5841:67a4]) by CH0PR12MB5154.namprd12.prod.outlook.com
 ([fe80::9661:1085:5841:67a4%7]) with mapi id 15.20.8835.032; Thu, 26 Jun 2025
 05:58:06 +0000
Message-ID: <dbec455c-74a0-4f91-8b8c-7b995c6e3e9c@amd.com>
Date: Thu, 26 Jun 2025 11:27:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] Introduce debugfs support in IOMMU
To: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 robin.murphy@arm.com, linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Vasant.Hegde@amd.com
References: <20250604163647.1439-1-dheerajkumar.srivastava@amd.com>
Content-Language: en-US
From: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
In-Reply-To: <20250604163647.1439-1-dheerajkumar.srivastava@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26c::6) To CH0PR12MB5154.namprd12.prod.outlook.com
 (2603:10b6:610:b9::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5154:EE_|SJ5PPFD525C5379:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb1dea4-4595-402b-90d6-08ddb4766b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVJQZ2pnNlNUQnJsS0ZjYUthMnU3Uy9Cd040ZWpIbDgxV25USGphSW4rR3pt?=
 =?utf-8?B?dkNEU2FKcHZNTEtTS1kvZ1NsenQ1VUZlWHdiZVdTOTlSclF6WTFQYXlpY1RC?=
 =?utf-8?B?a1FMb1JnVEs0L2VjUTR0cEtRNTgvcFZLUzVoaVM0UWpkRWNxNHM5QnBCRGJE?=
 =?utf-8?B?YUZIcmhaVWNHSjVuZGVwZzk4TC9aYkJFSnV4UFlycEJ0Wkk2dUVqRjdRUjhn?=
 =?utf-8?B?UGxWSklEMlJHcCtzUy9rQWFuRjU1U000dmJLWW1hSWgzM243RDJya0dpZml6?=
 =?utf-8?B?Vk1zck5EZ1dVaGFOSWJJb1I4WWVOTHZNRUNpbDVVM0Uxd3JTTFdveCtnVGZ5?=
 =?utf-8?B?dE9mMUxPY2E5czFINmt2VTgrQ1l6YnBmL2RCbEdtVnBXUnltekRZa1Z2T3BP?=
 =?utf-8?B?N3VYMmJNcDJtSUlSNWZ6VEMzbG9RU1ZXdFJZRGh6Nm52SWVaSGFRWGNPdFVH?=
 =?utf-8?B?clYyYktMNFlDZjZGVFJkaUVlZzFEVUtQaVIrbDl0UCtUbUhVWTdoeUVFVkRS?=
 =?utf-8?B?b1g1VUhLM3BtOTdvb09WT3dsYTZzeC9yaDg4aWhQMndSQnZ2dXFlYUMvSEwr?=
 =?utf-8?B?dVpGUVJoY1RyQ0dpb254d3ArUndqY1RzT1FJVVZ6NFo1bU4rNk1WR3dsckNh?=
 =?utf-8?B?ZEkwOS9Lc0Q4c09pOXBsazBSYkFCOS8rRVFRT01XRTdXRGxVcmtNY2VvZW9w?=
 =?utf-8?B?aEg1S0FpaUZVYzVpTStnWkFldHNKK3BEYUdlaW85bVZxRmp2N2M4Ykp3UTZO?=
 =?utf-8?B?SVE1NjBKcUtXcDg0TndZVEp2WnhuNzdDRXBRK2R0RU1qb2JBUXVSUkpia2Jk?=
 =?utf-8?B?MG1DU0FLb2xLMUVtMEdNL3ZsTmpjR0VZemhTMldqQ1lWRGRtNWRrSmRnbkk2?=
 =?utf-8?B?QUJ1dWtJcEZtSVgxMG9JeGJTSHhsbWR5ZFZTZGliLzlOWTJ5c0pvSDRpSG02?=
 =?utf-8?B?ZjFpNmtwSmhFVHdyYUcxZWdVd3p1cXVpSVRRNE5IUm1TckUvRmdjNjBLaldN?=
 =?utf-8?B?d2hNbDJMUElEZ0F3dUxqa1NsTkw2Rm8vWEoxOE9GYTQ5dXFPeCs3RGgrd0N2?=
 =?utf-8?B?VzVEQnpOTVVyS0MwVXdEQTMrUTRkdDhyQU5JcXVNTkdNUTBQWmN4TnN6NVVy?=
 =?utf-8?B?bEdzUGFwNjRIb3NsdGxNT01UU2xSZG1KT09TV2tHTExXZnBSQ3UvM1NYa1Fy?=
 =?utf-8?B?Q3FrMFJtc3FZUE5pZ0dHUlczMURJdVJqdlRFTll0R0ZDak9KemNLaHBVa2tF?=
 =?utf-8?B?OS9jS2dWUUZJZUpOMGtUZXpYSG84ajVnQnI0a1FRamp6V1BYUERNTlZxaXhs?=
 =?utf-8?B?aXFaeXI1emdXS3hVRHRsVm9td2NvcTdmc2xUSFdxdUZKQXNEKzB3MjNOeXdW?=
 =?utf-8?B?T1g0R3o3OHA5RG1GdXA3anNRcGZ6NmtCQlY3QnRKZDJydTV1Q0gwQnB6QjFK?=
 =?utf-8?B?a2RTOXlENnpZZE5HM283azBsZ2hRdEo1cWpXeG5qWUMycjRnbW0rQ0N6WDF5?=
 =?utf-8?B?eXlLVXZ5UG5JaGxoZjdLZ2VFMm5nVGc1NktkUGNhNkprUDl1TXhiWEhhYkQ3?=
 =?utf-8?B?WEpxaEwwN2RIaUlFYm50ZEx0bUQxSHFMcWpiTUMxdk5icG5FRXljZi9TVUpJ?=
 =?utf-8?B?QlloQXlOR0U3VmpqNVU2cEJjeFYzSVAxcW5aNjU0bmZtVi9LbXdCdEdFZElO?=
 =?utf-8?B?S1g2N254OWF1eGh0cVBxSWNuME4vM1A2eUk4QjJSK3lpQ0VEU051TFFDNHBG?=
 =?utf-8?B?SzJXbVFHVi9GM2EwT3B5eDVCRXRsZDltVlpjbzFvWlovVWJMR2ltalBrRjZG?=
 =?utf-8?B?RkI1cDROYzYrdTlzWE1BODlFeWVkRVpVQ29LWFVFSlVCSHNaN3prQjJLQXZs?=
 =?utf-8?B?eVhNMlN4akt3TzZ0V3NnRG1yd1NSVklReEVBU2czZUtPTU5sUU1UNXFpcHJ0?=
 =?utf-8?Q?L0NleQTxDtU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5154.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzBaOVRNQmt4d0RZZ0Q5cWE1TldRQ1hFeDBOOHVxcUhWNEl6S2NTQzBiY1RF?=
 =?utf-8?B?V0dna0piU1FIbWc1cDRuamtrUS9vWTZNZGJEL1YwVUtUTkZPem40K2k5ek9T?=
 =?utf-8?B?UHh5bjFUMXFNM2tLMWpKanBVZmxqdkdZRlkxUS9iR2p2bmhuN2pobHNOZUVO?=
 =?utf-8?B?ZGp5QlROaHBkWXAyd2pYRDZpMEVYN1BrK3QyelVHMzFNYWdUeUx2a1pEUFhk?=
 =?utf-8?B?MUdNMmhtMHNkaU52S2JLMmo3Rk5UMDRqUGg0cmg5MVorWWI1cDUyZ0ZKZGYy?=
 =?utf-8?B?YWU5T01iaWxuY0tqaDUvWVVCbjN1N1hPTjBUaTdsTGVEc1RGbExUNzNYMzN3?=
 =?utf-8?B?MVdsSUlxdzJYaHA0c2ZpL2NyZkFHUHZMRE56MVVYK3kyL1dMazJMTFhyeVVS?=
 =?utf-8?B?aUpSVW1NTnJCaStFdGQyZHAzMWZKMWJUajRJZzg0Ti9PV0tYTy9Odk9TWER2?=
 =?utf-8?B?dUdZQUJBUnVBbVdtRXJWcTlvT2lIK2QvSDgva2xGZkxURG1sZk5qWlZ6bHBp?=
 =?utf-8?B?QzhRa0pJUFVrSHhldWhHSmREcVNqbldMZ05LWGFCL2hXejhxemFnYloydDRM?=
 =?utf-8?B?YUIvQlNlVVZxZUUvRUJPYUxvMm9pcm5QOFJmdHF3VGNHcEFuLzFxR0N5K2NE?=
 =?utf-8?B?c1BiWGRTdmxaZ2doQjlnd3pkV0lOVFMzSmViV3dTRXhLSTh4UEZMUU5idVI3?=
 =?utf-8?B?eHl1VUM0QlZ0U3F6Sm9ONzhmbjNZbzAxWFJYZzg5YW8xTWZkYkFDUFo5Rnlx?=
 =?utf-8?B?aWJIU3NhS3llZC9YS1VKRU5VdlYxcFZaMGhQZEFlbGdvcEtaaHRIRkJzMU10?=
 =?utf-8?B?SU1LYXRVcmREUm15WFhxSEIrZWpLVkhNSkFpc3V6bHFCTFYzS0hOTlVXWVhi?=
 =?utf-8?B?S0dLZEpNbDNFS3dyTVo1VURsOHRHNWFDSEFSbGVYdjRKRHZuN01qTm5jUTFi?=
 =?utf-8?B?a3B6SWtpeUVwNVA2YXhrSW5LUlRWV0lzdDB0T2lhT0RSVEEybjdqN0hkNG5D?=
 =?utf-8?B?cnR3YUd4U2FHZVJ2bWdxb1FGSGFkWHg5d3E3QnA5VEJkL0MycTU5R2xTVjJm?=
 =?utf-8?B?TTl4eVhWV1ZIOFJHRGVQWVZldVVYNlROMlRSVzVTOFl2dXRLbmlYbVJmc0cw?=
 =?utf-8?B?R2VZeFVkM281SUxFeHhyRmo5bEdlZENaYzJvN2kzU2Y4Ym45Z2hUb0R1a3kw?=
 =?utf-8?B?VkZiQ0oyeEZNZmxXWkhKbGZQc1N0NDZsRThqRVd1MlF3eWRzQlVvMG1PRW0r?=
 =?utf-8?B?Rm9uT2grWkJHaEQxK04ydHhXckVhY2NpQmt1MmNEcnpXdURKeStDNEVFR0ZW?=
 =?utf-8?B?TWYyOUdpQ1lrY1VFcmU3SjFORnEvNlA4blFiOWRINldscGpKeGxPMnBZNjhW?=
 =?utf-8?B?RkExL0lsWThQaFdmQThmS2phWWdnbkppblpNeExpem02MDBGUjBxZXQ2ck51?=
 =?utf-8?B?TW5iR1llazJRbS9mMXFBZFBBclhOaGk1eVVmQ3NLU2p5a1VFdDZXRUlZSVlk?=
 =?utf-8?B?UllxY0tVVWpWbGlGTFRwamtSODI0OWlkaHVwV214dDkxWDcwbEFQekIyYU1V?=
 =?utf-8?B?T29qTmNNd1o5Y2tzeGFUczNyMHh3SXhmRDRkYUx1Nk1QNzhnelR0S0JtRTk2?=
 =?utf-8?B?Ulc2UlhGci9aYXJlSXljRFdBeTRNSUlIUGNwczhaTVRrOVdWTlpra01TLzJz?=
 =?utf-8?B?aTJZRmRvVFhsdjRSOW1pSVhKYnYyVVNDTWxWZG4wTnR2dEVCZC9ENjlBRmk0?=
 =?utf-8?B?SWViNXJSSTMrSDFMLzZQOEhUK0lOOVFVM1lWWUhkK3VHOVBrdUpTdk9QRUl2?=
 =?utf-8?B?VTkxUkhOenlnNzlYaXRFMFB0L2tmVzlEM2tCTS9FZnFXUzdZeHljUE43SXMv?=
 =?utf-8?B?Y2dJdkhvSStIZjFDYUFVQlNkYWJuM2VJRllUK1crKytwbzF5U1RBTFdYR1N2?=
 =?utf-8?B?bCtnS1Vka200bW5pSXBKY1pBU0g2RWJUclhVVllicThKc1RYdjlTaU9FOG5S?=
 =?utf-8?B?OTFmQnY3ZXI2aW9nMFpYRlN1cURjNTc4VHlsS3I2WlIrNllrT3JqeENZdFFH?=
 =?utf-8?B?TnJsMFdIaUV3WnN3SlltK2hzVkwyTFJtamNPeGh0MDNGdzdaMHlQNklqbGxB?=
 =?utf-8?Q?UCrmJR1r2Gg8VPMHgOQTjI+rG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb1dea4-4595-402b-90d6-08ddb4766b60
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5154.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 05:58:05.9161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zL4i6DKmNHufmd9sAy6ClxOEVc21bYCFK9B2NwuqweDxfQPNB5OJLCgk7od6P/OVJw4w1dSTA3JsJu1gTWXmMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD525C5379

Hi,

Just a friendly reminder to review the patch series. Your valuable 
feedback would be greatly appreciated to help us move forward.

Thanks
Dheeraj

On 6/4/2025 10:06 PM, Dheeraj Kumar Srivastava wrote:
> Introducing debugfs support in AMD/IOMMU driver that will allow
> userspace to dump below IOMMU information
> 1) MMIO and Capability register per IOMMU
> 2) Command buffer
> 3) Device table entry
> 4) Interrupt remapping table entry
> 
> Analyzing contents of IOMMU data structures helps in understanding IOMMU
> capabilities and behavior and debug issues faster.
> 
> 1. MMIO and Capability registers - Add support to dump MMIO and Capability
>     registers per IOMMU.
> 
>     Example:
>     a. Write MMIO register offset to dump it
>        $ echo 0x18 > /sys/kernel/debug/iommu/amd/iommu00/mmio
>        $ cat /sys/kernel/debug/iommu/amd/iommu00/mmio
> 
>        Output:
>        $ Offset:0x18 Value:0x000c22000003f48d
> 
>      b. Write capability register offset to dump it
>         $ echo 0x10 > /sys/kernel/debug/iommu/amd/iommu00/capability
>         $ cat /sys/kernel/debug/iommu/amd/iommu00/capability
> 
>         Output:
>         $ Offset:0x10 Value:0x00203040
> 
> 2. Command buffer - Add support to dump per IOMMU command buffer.
> 
>     Example:
>     a. cat /sys/kernel/debug/iommu/amd/iommu00/cmdbuf
> 
>     Output:
>     CMD Buffer Head Offset:339 Tail Offset:339
>       0: 00835001 10000001 00009900 00000000
>       1: 00000000 30000005 fffff003 7fffffff
>       2: 00835001 10000001 00009901 00000000
>       3: 00000000 30000005 fffff003 7fffffff
>       4: 00835001 10000001 00009902 00000000
>     ........................................
>     ........................................
>     ........................................
> 
> 3. Device table - Add support to dump device table per IOMMU.
> 
>     Example:
>     a. Write device id to dump device table entry for that device
>        $ echo 0000:01:00.0 > /sys/kernel/debug/iommu/amd/devid
>        $ cat /sys/kernel/debug/iommu/amd/devid
> 
>        Output:
>        0000:01:00.0
> 
>        Dump the device table entry for the input given
>        $ cat /sys/kernel/debug/iommu/amd/devtbl
> 
>        Output:
>        DeviceId             QWORD[3]         QWORD[2]         QWORD[1]         QWORD[0] iommu
>        0000:01:00.0 0000000000000000 20000001373b8013 0000000000000038 6000000114d7b603 iommu3
> 
>      b. Write device id to dump device table entry for that device
>        $ echo 01:00.0 > /sys/kernel/debug/iommu/amd/devid
>        $ cat /sys/kernel/debug/iommu/amd/devid
> 
>        Output:
>        0000:01:00.0
> 
>        Dump the device table entry for the input given
>        $ cat /sys/kernel/debug/iommu/amd/devtbl
> 
>        Output:
>        DeviceId             QWORD[3]         QWORD[2]         QWORD[1]         QWORD[0] iommu
>        0000:01:00.0 0000000000000000 20000001373b8013 0000000000000038 6000000114d7b603 iommu3
> 
> 4. Interrupt remapping table - Add support to dump IRT table valid entries in
>     "iommu_irqtbl" file. This supports user input to dump IRT entry for a
>     specific pci device.
> 
>     Example:
>     a. Write device id to dump device table entry for that device
>        $ echo 0000:01:00.0 > /sys/kernel/debug/iommu/amd/devid
>        $ cat /sys/kernel/debug/iommu/amd/devid
> 
>        Output:
>        0000:01:00.0
> 
>        Dump the device table entry for the input given
>        $ cat /sys/kernel/debug/iommu/amd/irtbl
> 
>        Output:
>        DeviceId 0000:01:00.0
>        IRT[0000] 0000000000000020 0000000000000241
>        IRT[0001] 0000000000000020 0000000000000841
>        IRT[0002] 0000000000000020 0000000000002041
>        IRT[0003] 0000000000000020 0000000000008041
>        IRT[0004] 0000000000000020 0000000000020041
>        ..........................................
>        ..........................................
>        ..........................................
> 
>     b. Write device id to dump device table entry for that device
>        $ echo 01:00.0 > /sys/kernel/debug/iommu/amd/devid
>        $ cat /sys/kernel/debug/iommu/amd/devid
> 
>        Output:
>        0000:01:00.0
> 
>        Dump the device table entry for the input given
>        $ cat /sys/kernel/debug/iommu/amd/irttbl
> 
>        Output:
>        Device 0000:01:00.0
>        IRT[0000] 0000000000000020 0000000000000241
>        IRT[0001] 0000000000000020 0000000000000841
>        IRT[0002] 0000000000000020 0000000000002041
>        IRT[0003] 0000000000000020 0000000000008041
>        IRT[0004] 0000000000000020 0000000000020041
>        ..........................................
>        ..........................................
>        ..........................................
> 
> Changes since v5:
> -> Patch 7/8: Use macros to fetch IRT table length for DTE.
> 
> Changes since v4:
> -> Maintain per IOMMU variable for mmio_offset and capability_offset.
> -> Get intrrupt table length from DTE instead of using MAX_IRQS_PER_TABLE.
> 
> Changes since v3:
> -> Patch 2/8: Print 64 bits instead of 32 bits for MMIO registers dump. Since most of
>     the MMIO registers are 64 bits.
> -> Patch 5/8: Update commit message with the need to add support for device_id input.
> -> Patch 3/8: Throw error message mentioning valid capability offset range if user capability
>     offset's input is not in valid range and input fails.
> 
> Changes since v2:
> -> Patch 2/8 and 3/8: Use single file mmio and capability for input and output registers
>     offset and register's dump respctively.
> -> Patch 8/8: Correct path for files "irqtbl" and "devtbl" in Documentation
> 
> Changes since v1:
> -> Patch 2/8 and 3/8: Use kstrtou32_from_user() instead of memdup_user_nul() --> kstrtou32()
> -> Patch 4/8: Dump command buffer head and tail offset instead of head and tail pointer registers.
> -> Patch 8/8: Fix bot reported warning on v1 patch series.
> 
> Dheeraj Kumar Srivastava (8):
>    iommu/amd: Refactor AMD IOMMU debugfs initial setup
>    iommu/amd: Add debugfs support to dump IOMMU MMIO registers
>    iommu/amd: Add debugfs support to dump IOMMU Capability registers
>    iommu/amd: Add debugfs support to dump IOMMU command buffer
>    iommu/amd: Add support for device id user input
>    iommu/amd: Add debugfs support to dump device table
>    iommu/amd: Add debugfs support to dump IRT Table
>    iommu/amd: Add documentation for AMD IOMMU debugfs support
> 
>   Documentation/ABI/testing/debugfs-amd-iommu | 114 ++++++
>   drivers/iommu/amd/amd_iommu.h               |   4 +-
>   drivers/iommu/amd/amd_iommu_types.h         |   9 +
>   drivers/iommu/amd/debugfs.c                 | 377 +++++++++++++++++++-
>   drivers/iommu/amd/init.c                    |   5 +-
>   drivers/iommu/amd/iommu.c                   |   7 -
>   6 files changed, 495 insertions(+), 21 deletions(-)
>   create mode 100644 Documentation/ABI/testing/debugfs-amd-iommu
> 

