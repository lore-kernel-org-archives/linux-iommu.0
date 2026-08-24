Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011035.outbound.protection.outlook.com [52.101.52.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4503DDDDA;
	Mon, 24 Aug 2026 05:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787550746; cv=fail; b=ipOa1csWa32nTBK35Z6Af2BWXC6/m9eRN5RQp8rj/tbhGJho1do7Vp+hpN69iAQ24X75sDtlSEEK6C+2jeORVNrR2biBkghakG+f8YrtTo9DQlP9dKChxIGGdtyu1aFzLsYeZCKRSt9si3E5iVnMoa/AUrKaF5lEphgDvGbHDCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787550746; c=relaxed/simple;
	bh=GEM4zJBBUTM07rVlpSEngavzNbcqVjPf+ULJrTIhGD8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fCM8QZeyTa8Qr9WP9vrLakdy1Pkgfl+YKSfQfWfk95sjqcd0zEZW9UucivFYtGq3X60SJewom8m4FDgHTUV7lLGl87Ql27vWApV0SAcPEqZ9mw9x/3YH/7dpRJh3tGSALZa69IyeEQXCx6U03aPwj7Kw+Iiuge1tzvDXBc3PqSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OnTN/65R; arc=fail smtp.client-ip=52.101.52.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OnTN/65R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MO4hOmi1PHBVWwhuj+c28NxDMEJwPngMcfUlgZjhYcyWAecFV4aaFmRcr2cZVZuOZOcaNHapllBysAtfSZ3MAl3yzs5S7W1pgf+U5aT/TssDwbqWoOIsKN4JK2ZhHywtGqabWKsOqPKOzxcVMH//oQ+WJfrRuqDbJwa2b2lYoJ5ijYsLBdYpDFGKJqC/ORwe67KSKSv5qUjhTP5UxhZnfv9yB4LfHD3SwRNXDb0G9o1p30ijHQtrC/tgG7P8CwoFdIzUSXeZ8FlTnNAKfQx409NWXWn8n9xAq8IFc/vxNySCDlRDaN+02u3XSBQbJCftNbIdn2JE0vh0IxL6MoP4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5btXgu68RpLLumWSXaY0XzYZb4hFoK6YxINYeNA30m4=;
 b=G8N/2TQ54p+oT9d/aHvdJ0qZilmEH/6qyl6VayDwPEsxLI9JJlLbDry1xfoSjaPZIvqiCtBVvvA3KUSOTD5waKhtZHVCSNxal0BcheXaxFW6JTWQzBshfrp1ps/iN92ueLCDJBqH97vex5bPimP18UONyd6P4HCeimlCpned/hWQch27xMKLWoZNI9H+kIaveWkASsIMwAJWhpI0cDGfTf/h/xxTsRszO1TsmAZXhpzI1TeVug0Rk+v30JYMbX/Ifii9fw0KkJcsDopLQjE/ij1bcKvAOFTeVBMP1hmyc82j+6sfLgFAmW7NKSGFWcY+St0Q7aOmnGHsUDTYy2mNaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5btXgu68RpLLumWSXaY0XzYZb4hFoK6YxINYeNA30m4=;
 b=OnTN/65Rud6YNymKfIYH1Hp5hfCnTWGbY5+4oZnQ+d+SsigzHwgVpQyuMgmlBpR7PQNJPz3lU15CaUdWcLCz44cuFlkekyu165u/HGvnkU0iL6QhvpBydDaC+994j9cm5TObUVtia2OyBxvc/EckhBjNs6+OASspvho7sFSCrcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SA1PR12MB8968.namprd12.prod.outlook.com (2603:10b6:806:388::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 05:52:19 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 05:52:19 +0000
Message-ID: <905c7511-d7bb-4ca6-918f-71846e436062@amd.com>
Date: Mon, 24 Aug 2026 11:22:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] iommu/amd: "Fix premature break in init_iommu_one()"
 causes early boot hang
To: Andreas Juch <andreas@juch.cc>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Robert Richter <rrichter@amd.com>, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <07b2d390-f7a0-47e2-bc2c-eb0853acf52e@juch.cc>
 <aok4Ko0mpC4fdGPg@8bytes.org> <6a61edf7-157c-4069-a1c3-78d1138b061c@amd.com>
 <912b9d43-1205-4753-afe1-60cd149679b4@juch.cc>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <912b9d43-1205-4753-afe1-60cd149679b4@juch.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0077.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26b::13) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SA1PR12MB8968:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e629dc-7943-4372-6f2e-08df01a3dbd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|4143699003|5023799004|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	9N95fT46fwvPNJD+V1m1tqk89VeQbmRtDWP7976TxdS+qV0kVyIMIFYNcR96hX2RUNvoZ2HrJioom0q+dIY4+08Xt4XHxfreu4Uss9oulc8Tgw8b4tfX1u0vuAbeWAevWDsWTcNf1rvbI5HYuE0qNDnW0ey7tj6z5U65wBiXiii7ZMFSP9O6QyuuI3trGjbnhDqxAbMeYcFUMTp5BcPefJlCLXnvtLYxXpgrqn545k+JdGWc50C+bM9ngL7z60TqtEmfxj5g1XlQCZU6AKpl840osrM8fpc9RuJe22nmHbz1P+Bht6p6gTFHQE3mWWy4hu6PK1FPIqC/wLeHWdt18vpBrkxWqkClGC948+V1PsnoXlgojJpHks2dpc7x3kLAm0zZm12JzDGK57ZeGVEfuh/erHWTXeXARAJwYbnCRytbI6uZMdXllS4Qu5XHIJyMoYFqlyXvZuZ0C16O78uZF6h0U3SmocJgmSDL2iGFdDtUtvPBSFT4k6yguDGjIS95zU4elg5ZdN5naDOxtDWIAEsLM1hTPeB9QjQgHim5/NU7Cq9fmvDINSUMTAAsIcjl59gJL2QzvnGO53vwLjR6RFpEqgQ6btVVpgluRY3JBd4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rk9oYkRSQTM4OEs5c0FId0RzS2dOYzRsU21ta0FmNjFzNS9icEJKWHM5L2FU?=
 =?utf-8?B?STBCMi9DOE96amdFZ0V4NW41RUtpaUVSSW14eWFYQzdoeDV5Unh5anZ2ZU5n?=
 =?utf-8?B?QVgyMXEvUlR1UTB2Um5LWFRxdjVFTXYzWEhFTDIxUURMdE9tQTNwNnZpVjhJ?=
 =?utf-8?B?eURNTkV6eGg0U2d1aER5OEd1WVNJMjB2S2tRV3lkcHMrS1V3R0ludGs5ZnBx?=
 =?utf-8?B?QWJPbkVwc0Rmd1lUZVV5Z1NpcjFjVUlJbmZsUHZhVFhLdmxNam9HU2l6bEZp?=
 =?utf-8?B?eHZUN3Z5ZlFTTm1qNUJjWFBEVjhyREFOVm9FUXZMNitFNVZ6eEpXN2dKbU9M?=
 =?utf-8?B?NHVWd3lBMmZUNkV1Q3UySXQ2QTBrZnhSeE84QkhUQTgxazkvM3JIQTQzUzhk?=
 =?utf-8?B?Y1p1dEJETHovSkFIQ0hMOTUzK0tMaFpzb3dQSlJyMWJQWmVNc2ZaUEhvMDhZ?=
 =?utf-8?B?TXhUWm5IcWtzY0pMNEcrMHBTb1lZQXhnemVXQWRsSHJuTDQ4WjFQa2FwN1Qr?=
 =?utf-8?B?aUNsR0s5VHpHSmluc3hHazFtQ3NzMitOZEdJcHAxZjFEekxER1pVYTUvTmtp?=
 =?utf-8?B?UXgxMFBJcTFHK29LdGF1cDZzNlZ3OW8wZlNQRGpWaG41cHNPM2pNSjRRY1lT?=
 =?utf-8?B?YTAzRjFKT1oxeE5zS214ZWVUdXZBNnd1NmVZMkVCN1pHYUlwVFJxMXZSUUFB?=
 =?utf-8?B?b2RRakZSRG1oNS9HVXN3dEZqL2xhMmlaeVdmQlJpOG4yL3RadnBlbzNxNUVk?=
 =?utf-8?B?T3FzSFE1MUdaanhmWkM5dHBvT0oyc0czM2Vxb3BSQnUrSGRIMGpUQ3JKWEFI?=
 =?utf-8?B?UHZaZ1NWV2MvUEd6Z2ZSZlZaOWhsNERBejVzWktFays1aXc4MVhiaGdNVjRq?=
 =?utf-8?B?TVVGYWh3SHVJQkphVGU5VmlteVEyajRnMVpHcyt4dE5xMUdVL0lmcGpsUlpq?=
 =?utf-8?B?TkgwOUxnQUFnU3dXdHRBVFBCNWxLRlVZQkszTjNEWW9ucEhIK0lKcnh1NXUv?=
 =?utf-8?B?QmUxc0VPUDB4OCt2RTFoWk14K1NQWlo0cGQ5WjJhTkhLM014a1pQZHFpVndi?=
 =?utf-8?B?YkpiYlYwSm9uOUErRG5BOE1BaUpPVjlEV2dKekRMNEVaeHV1L3JoVUhleEQ0?=
 =?utf-8?B?QzJXQzJwUmh1NGlCeHNadVgvL1Q4elcwdFQvWHB6MUJXOVJ3bFZnY3l4VWF1?=
 =?utf-8?B?bEwxcUh1eUM4NU52cmlyRjB5cEYrdWtmUmVwa2FRaHhvc2w0eWpuS2lWNFVP?=
 =?utf-8?B?Ymo5UGJiNDMyRWx3U09nYjNrTEJjdy9WaFFveDdPc0RjQTM5OW5UZlMwdGlR?=
 =?utf-8?B?VlFwTnNwS0Y3bUc3cUhmdkp0Nzd0Nld0cjN1NjhKM3E2ZktMQ3Q5Z2Z0cjhP?=
 =?utf-8?B?NlYxWFNsR1Zua2lqZkt3MStwNEIvQ2JQNjFzL1MrcWpPQmp4N0dOUk1kcDlw?=
 =?utf-8?B?cnRuTzI5RXJRVmJTV05lSmpmVGJSMXpuRm4wcGhQc3lSQVpvaVNGMXMxVXJn?=
 =?utf-8?B?Vi9mT2V3NzFnbXA3bFNsN3FxRlA5TWNXMlBQMmJnQlMybWFVeUNQY3dpcS9x?=
 =?utf-8?B?N1lsZU15UDgwWUJvaGJRdVVycFpLSjVseGxZMkEvTVB0VFQ2Tzk3Nmk4d2x0?=
 =?utf-8?B?Rjl4MndiekV2KzNZM3Z6VXZ5MG1xTi85Zk5Hd3NEMmJ1bmFQbW82Zkg5VEJt?=
 =?utf-8?B?RURWeVNXMkpJRzhWSVFkbEVoSk5HeWZBWDVpYnZSeUtuWXB0bFJ3Vk9CNUVz?=
 =?utf-8?B?Z09QQklIT0s5WE41Q3JCNjliSU5FUHBmcFA0MUxVSFpoNWpQbnBTZHhQaGNJ?=
 =?utf-8?B?dDNZZ3NhTzZhcU1FM2JYMTUwMkRZY0JheTZLTWJSV1lJWHNLR0RaelVXQU1q?=
 =?utf-8?B?MkN4MjNNRnlEUmdERzJqcFNFbW5oRHVGL0g4dkxRamR3SzlIazNLdDVqU2pR?=
 =?utf-8?B?V1pPbXlxeHl2Y2M2VHFUSHU0MDVRbFRjVVJ3Y1UvT3ZDVkgzSXU1VXdjVlhS?=
 =?utf-8?B?NzdIclk2bEp0MEtiNXJrR3V3NkovL0NiQkJFMVVzYXk1L2k0UGR0ZzVQU1FW?=
 =?utf-8?B?dzJsckhOaXo5MVdnbTRrM01vT0toRFdzSXRlR0RiTmJrR1owQ0lOdGZGdFJ6?=
 =?utf-8?B?THNCUWY2dk50dDVaTEUwekI2Ym5LcVhqN3ptVkZGRzI3NHFjemt3Vk9ER1Jp?=
 =?utf-8?B?TGRSU2d5OFZkaTU4NVNqQzFjaW9CdUJPbE12dVZPY1FjMDFOQjF5aHVhV1cv?=
 =?utf-8?B?dXpZVngzNHIwODljY25nQk9EYzBaQUNtZzZRVk1LaG1ZeVI5YkprdWJOV3VG?=
 =?utf-8?B?MG0yY1FuN2FaVVk2S2RwSXNPUTZ1bEVoMGdwSzZRcFQxZG1YcHZEZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e629dc-7943-4372-6f2e-08df01a3dbd7
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 05:52:19.2544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gTjXT6t6mjGBwLaWhBzkMT1B9Fk4PRudLNPzHB6ozKrPpsPS82tlF6b8wPeHSarQTeWw3VEfNG9hwjUrNdRR/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8968

Hl Andreas,


On 8/22/2026 7:02 PM, Andreas Juch wrote:
> [Some people who received this message don't often get email from
> andreas@juch.cc. Learn why this is important at https://aka.ms/
> LearnAboutSenderIdentification ]
> 
> Hello Vasant,
> 
> On 8/22/26 12:17, Vasant Hegde wrote:
>> Andreas,
>>
>> On 8/22/2026 11:19 AM, Joerg Roedel wrote:
>>> Adding Vasant.
>>>
>>> On Fri, Aug 21, 2026 at 11:11:07PM +0200, Andreas Juch wrote:
>>>> Hello,
>>>>
>>>> I noticed that one of my NixOS sytems failed to boot with kernel 6.18.40.
>>>> The
>>>> older 6.18.39 booted fine. A full git bisect of v6.18.39..v6.18.40
>>>> identified
>>>> the following commit as the first bad commit:
>>>>
>>>>    dc266f6c4e2628576ab33042b6b2a12480220026
>>>>    iommu/amd: Fix premature break in init_iommu_one()
>>>>
>>>> The visible symptom is a black screen immediately after systemd-boot. The
>>>> machine also remains unreachable over SSH and leaves no persistent journal
>>>> entry
>>>> for the failed boot. A reset or power cycle is required.
>> Interesting. I never imagined above fix will break some system!
>>
>> I assumed below dmesg is from good boot (without above patch) and did the
>> analysis (code walk with below IVRS data):
> 
> Yes, that's correct, it's from the .40 kernel without commit dc266f6c.
> 
>>    - EFR advertised by IVRS is different from actual EFR (read by IOMMU MMIO
>> register). Its worse because IVRS advertised few features like GT/PPR which is
>> not supported by IOMMU.
>>    - Without this patch we would have skipped early_iommu_features_init() so
>> global EFR is zero and then init_iommu_one_late() set the EFR properly based on
>> actual IOMMU capability.
>>
>> Only with this log, its hard to tell where exactly system failed. My guess is
>> driver enabled features which are not supported (like GT/PPR) or we setup 32bit
>> interrupt remapping table.
>>
>> I believe above patch exposed an existing bug with some other commit.
>>
>>
>> Ideally we should properly fix late_iommu_features_init() and use actual EFRs.
>> But for now lets fix the regression. Can you please try below fix?
>>
>> -Vasant
> 
> Thank you for investigating! I created a new branch from the v6.18.40
> tag and
> applied your patch. The resulting kernel booted without any issues!


Thanks a lot. This is like another band-aid fix, but I think it's good enough
for a stable backport. In my view, we should prioritize the IOMMU
MMIO-advertised EFR over the one reported via IVRS. However, that would require
much more extensive changes and isn't a good candidate for stable.


> 
> If you need any further information or testing (for a proper fix later
> on), I'd
> be happy to test patches again!

Can you help me to test below patch (just apply this patch and remove previously
provided fix patch). I want to make sure that prioritizing MMIO EFR doesn't
break things.

-Vasant

---<---
commit aa5f50f1ee66ebf7a219906a4df6aa2b7cae9717
Author: Vasant Hegde <vasant.hegde@amd.com>
Date:   Mon Aug 24 11:12:27 2026 +0530

    iommu/amd: Prioritize IOMMU MMIO advertised EFR over IVRS

    Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 69170146d442..0172db87b1df 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -2153,9 +2153,11 @@ static void __init late_iommu_features_init(struct
amd_iommu *iommu)
 	if (features != amd_iommu_efr ||
 	    features2 != amd_iommu_efr2) {
 		pr_warn(FW_WARN
-			"EFR mismatch. Use IVHD EFR (%#llx : %#llx), EFR2 (%#llx : %#llx).\n",
+			"EFR mismatch. Use MMIO EFR (%#llx : %#llx), EFR2 (%#llx : %#llx).\n",
 			features, amd_iommu_efr,
 			features2, amd_iommu_efr2);
+		amd_iommu_efr = features;
+		amd_iommu_efr2 = features2;
 	}
 }






> 
> Thanks again!
> 
> Andreas
> 
>>
>> ---<---
>>
>> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
>> index 69170146d442..7a5b78beb352 100644
>> --- a/drivers/iommu/amd/init.c
>> +++ b/drivers/iommu/amd/init.c
>> @@ -1930,19 +1930,20 @@ static int __init init_iommu_one(struct amd_iommu
>> *iommu, struct ivhd_header *h,
>>               else
>>                       iommu->mmio_phys_end = MMIO_CNTR_CONF_OFFSET;
>>
>> +             if (h->efr_attr & BIT(IOMMU_IVHD_ATTR_HATDIS_SHIFT)) {
>> +                     pr_warn_once("Host Address Translation is not supported.
>> \n");
>> +                     amd_iommu_hatdis = true;
>> +             }
>> +
>>               /* XT and GAM require GA mode. */
>>               if ((h->efr_reg & (0x1 << IOMMU_EFR_GASUP_SHIFT)) == 0) {
>>                       amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY;
>> +                     break;
>>               } else {
>>                       if (h->efr_reg & BIT(IOMMU_EFR_XTSUP_SHIFT))
>>                               amd_iommu_xt_mode = IRQ_REMAP_X2APIC_MODE;
>>               }
>>
>> -             if (h->efr_attr & BIT(IOMMU_IVHD_ATTR_HATDIS_SHIFT)) {
>> -                     pr_warn_once("Host Address Translation is not supported.
>> \n");
>> -                     amd_iommu_hatdis = true;
>> -             }
>> -
>>               early_iommu_features_init(iommu, h);
>>
>>               break;
>>
>>
>>
>>>> I reverted that single commit, built the kernel again and the machine
>>>> booted, so
>>>> I'm quite sure that I found the right commit.
>>>>
>>>> System information:
>>>>
>>>> ASRockRack B550D4-4L
>>>> BIOS P1.10 (06/28/2021)
>>>>
>>>> I'm no expert at all, but my research found that the following information
>>>> might
>>>> be relevant:
>>>>
>>>>    journalctl -W -b -k --no-pager | rg -i 'AMD-Vi|AMD IOMMU|IOMMU|IVRS|IVHD'
>>>>    Aug 21 22:24:17 kernel: ACPI: IVRS 0x00000000BB062000 0000D0 (v02 AMD
>>>> AmdTable 00000001 AMD  00000001)
>>>>    Aug 21 22:24:17 kernel: ACPI: Reserving IVRS table memory at [mem
>>>> 0xbb062000-0xbb0620cf]
>>>>    Aug 21 22:24:17 kernel: AMD-Vi: Using global IVHD EFR:0x0, EFR2:0x0
>>>>    Aug 21 22:24:17 kernel: iommu: Default domain type: Translated
>>>>    Aug 21 22:24:17 kernel: iommu: DMA domain TLB invalidation policy: lazy
>>>> mode
>>>>    Aug 21 22:24:17 kernel: pci 0000:00:01.0: Adding to iommu group 0
>>>>    Aug 21 22:24:17 kernel: pci 0000:00:01.2: Adding to iommu group 0
>>>>    Aug 21 22:24:17 kernel: pci 0000:00:02.0: Adding to iommu group 1
>>>>    Aug 21 22:24:17 kernel: pci 0000:00:03.0: Adding to iommu group 2
>>>>    Aug 21 22:24:17 kernel: pci 0000:00:04.0: Adding to iommu group 3
>>>>    Aug 21 22:24:17 kernel: pci 0000:00:05.0: Adding to iommu group 4
>>>>    Aug 21 22:24:17 kernel: pci 0000:00:07.0: Adding to iommu group 5
>>>>    Aug 21 22:24:17 kernel: pci 0000:00:07.1: Adding to iommu group 6
>>>>    Aug 21 22:24:17 kernel: pci 0000:00:08.0: Adding to iommu group 7
>>>>    Aug 21 22:24:17 kernel: pci 0000:00:08.1: Adding to iommu group 8
>>>>    Aug 21 22:24:17 kernel: pci 0000:00:14.0: Adding to iommu group 9
>>>>    Aug 21 22:24:17 kernel: pci 0000:00:14.3: Adding to iommu group 9
>>>>    Aug 21 22:24:17 kernel: pci 0000:00:18.0: Adding to iommu group 10
>>>>    Aug 21 22:24:17 kernel: pci 0000:00:18.1: Adding to iommu group 10
>>>>    Aug 21 22:24:17 kernel: pci 0000:00:18.2: Adding to iommu group 10
>>>>    Aug 21 22:24:17 kernel: pci 0000:00:18.3: Adding to iommu group 10
>>>>    Aug 21 22:24:17 kernel: pci 0000:00:18.4: Adding to iommu group 10
>>>>    Aug 21 22:24:17 kernel: pci 0000:00:18.5: Adding to iommu group 10
>>>>    Aug 21 22:24:17 kernel: pci 0000:00:18.6: Adding to iommu group 10
>>>>    Aug 21 22:24:17 kernel: pci 0000:00:18.7: Adding to iommu group 10
>>>>    Aug 21 22:24:17 kernel: pci 0000:02:00.0: Adding to iommu group 0
>>>>    Aug 21 22:24:17 kernel: pci 0000:02:00.1: Adding to iommu group 0
>>>>    Aug 21 22:24:17 kernel: pci 0000:02:00.2: Adding to iommu group 0
>>>>    Aug 21 22:24:17 kernel: pci 0000:20:00.0: Adding to iommu group 0
>>>>    Aug 21 22:24:17 kernel: pci 0000:20:01.0: Adding to iommu group 0
>>>>    Aug 21 22:24:17 kernel: pci 0000:20:02.0: Adding to iommu group 0
>>>>    Aug 21 22:24:17 kernel: pci 0000:20:03.0: Adding to iommu group 0
>>>>    Aug 21 22:24:17 kernel: pci 0000:20:04.0: Adding to iommu group 0
>>>>    Aug 21 22:24:17 kernel: pci 0000:20:08.0: Adding to iommu group 0
>>>>    Aug 21 22:24:17 kernel: pci 0000:20:09.0: Adding to iommu group 0
>>>>    Aug 21 22:24:17 kernel: pci 0000:21:00.0: Adding to iommu group 0
>>>>    Aug 21 22:24:17 kernel: pci 0000:22:00.0: Adding to iommu group 0
>>>>    Aug 21 22:24:17 kernel: pci 0000:23:00.0: Adding to iommu group 0
>>>>    Aug 21 22:24:17 kernel: pci 0000:24:00.0: Adding to iommu group 0
>>>>    Aug 21 22:24:17 kernel: pci 0000:25:00.0: Adding to iommu group 0
>>>>    Aug 21 22:24:17 kernel: pci 0000:29:00.0: Adding to iommu group 0
>>>>    Aug 21 22:24:17 kernel: pci 0000:2a:00.0: Adding to iommu group 0
>>>>    Aug 21 22:24:17 kernel: pci 0000:2b:00.0: Adding to iommu group 0
>>>>    Aug 21 22:24:17 kernel: pci 0000:2c:00.0: Adding to iommu group 11
>>>>    Aug 21 22:24:17 kernel: pci 0000:2d:00.0: Adding to iommu group 12
>>>>    Aug 21 22:24:17 kernel: pci 0000:2d:00.1: Adding to iommu group 13
>>>>    Aug 21 22:24:17 kernel: pci 0000:2d:00.3: Adding to iommu group 14
>>>>    Aug 21 22:24:17 kernel: pci 0000:2d:00.4: Adding to iommu group 15
>>>>    Aug 21 22:24:17 kernel: AMD-Vi: Extended features (0x58f77e022294881,
>>>> 0x0): PreF GA GA_vAPIC
>>>>    Aug 21 22:24:17 kernel: AMD-Vi: Interrupt remapping enabled
>>>>
>>>> And the output of the decoded IVRS table, captured by `acpidump -n IVRS -b`:
>>>>
>>>>    00000000  49 56 52 53 d0 00 00 00  02 e2 41 4d 44 20 20 00 |IVRS......AMD
>>>> .|
>>>>    00000010  41 6d 64 54 61 62 6c 65  01 00 00 00 41 4d 44 20
>>>> |AmdTable....AMD |
>>>>    00000020  01 00 00 00 41 30 20 00  00 00 00 00 00 00 00 00 |....A0
>>>> .........|
>>>>    00000030  10 b0 48 00 02 00 40 00  00 00 50 fd 00 00 00 00
>>>> |..H...@...P.....|
>>>>    00000040  00 00 00 00 2e 8f 04 80  03 08 00 00 04 fe ff 00
>>>> |................|
>>>>    00000050  43 00 ff 00 00 a5 00 00  04 ff ff 00 00 00 00 00
>>>> |C...............|
>>>>    00000060  48 00 00 00 00 a0 00 02  48 00 00 d7 0d a0 00 01
>>>> |H.......H.......|
>>>>    00000070  48 00 00 00 0e 01 00 01  11 b0 58 00 02 00 40 00
>>>> |H.........X...@.|
>>>>    00000080  00 00 50 fd 00 00 00 00  00 00 00 00 00 02 04 00
>>>> |..P.............|
>>>>    00000090  5a 4a 29 22 ef 77 8f 05  00 00 00 00 00 00 00 00
>>>> |ZJ)".w..........|
>>>>    000000a0  03 08 00 00 04 fe ff 00  43 00 ff 00 00 a5 00 00
>>>> |........C.......|
>>>>    000000b0  04 ff ff 00 00 00 00 00  48 00 00 00 00 a0 00 02
>>>> |........H.......|
>>>>    000000c0  48 00 00 d7 0d a0 00 01  48 00 00 00 0e 01 00 01
>>>> |H.......H.......|
>>>>    000000d0
>>>>
>>>> The relevant part (after decoding with `iasl -d ivrs.dat`):
>>>>
>>>>    [090h 0144 008h]                   EFR Image : 058F77EF22294A5A
>>>>
>>>> I'll provide any required details and test patches!
>>>>
>>>> Thanks for your work, it's very appreciated!
>>>>
>>>> Andreas
>>>>
> 

