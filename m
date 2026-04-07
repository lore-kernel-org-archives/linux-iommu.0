Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazolkn19013073.outbound.protection.outlook.com [52.103.43.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A384530DEA3
	for <iommu@lists.linux.dev>; Tue,  7 Apr 2026 14:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573243; cv=fail; b=TceTyMB1zC474uFxVf0/QEfDnVZvJ6nC5+xcUYxk7CKRxVlA0EiK7aKgAxfxhJXu2YzqyHFRRbJBDchYtiXZZZmG5+b4F3tygr8YiHKqnlK4etjUi0RX42IEtPijq62DDi1zqVvQ3VVMmKuhAMMZpSuExk5VeuHeuINXe3YMgys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573243; c=relaxed/simple;
	bh=oLUYMFYcCHk2cucAiRnNawOLUpZqSd7GTNaBGNGwg78=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UPmAZ+ku4nYw9Bu7vFtj4uuFTexRUI30h317kROqt+xf+ZhpoIZ2j03quW2IFuiwejOTetrk5o6yp6+c5en3pjN1ky1uCKnu3ipzQo8Yxws1gXolO1vuI7nDAev5eDLcfJfzThfD3O1AfYrDG4DYJQzS6GURCwnn/FWcBcaMk5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=W0M54KR2; arc=fail smtp.client-ip=52.103.43.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="W0M54KR2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXkQ3YMFX1hSJlNsZTuPTm/rN0CLsyqhNs90QMk55F7fytjhUSPqOPv+mM+b8v10qDlVTtiCEGnLGGt3VjXtbZd8hnp23gXdZusEbRqGDQLo6N9T/o7+EBAg9Kry2hML/PvItOWUhq6EsqsRPSgs3Y7j/RQD6Aujy/izuWu7Mp5IpBcycaHid+IEV4uENQlVHFJ001tg3isjFtKrrMEGPBVxDuscKAhfNujwt82Q4pjFdLOz/CxQumoHdKuS0kE89WcFxibpbhpCmrp26fcnuuCY/Lzi/UURviWwckd/8Kbp6fZdfWspQ0G38Y0dhAhAzBbVpY6sd8wGVrmEMKEuBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3U0dpCe2y5KThazcOazROp26JIoRIiyxDMTjF+ki3E=;
 b=lIdKWut6vQmTSh4QW0EDaWDxJBlmvMZRj2scGHGR1HbYDJ0Hjhvx4C8YlNlwn5WqUSmeF2KGPAoD9JmZv12AyDL2XiMk3mHNBYeZArR0joDcTqbGsLEDvcJQWpyT+eGwBD2NKQMUZNK7oevQTKHgiF5WHV23YZbOdgm5htkHuJGk2DAn0P7Lu2QXbDF3u0V0KDrkT0XMS+0gwUBHLNC42EEIfAnUJi3/att7iOuaSD8KyhYOZjkLaB8P6d0SNAbHqBJ9HLsGDzYnqs2fJkK/6ocUvUPAHfNRtvz4hhChsDR+sSyunqWiwtbqhrh7/Tvw6HSwy0Ls59C7xdd9XtGzVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3U0dpCe2y5KThazcOazROp26JIoRIiyxDMTjF+ki3E=;
 b=W0M54KR21jGsARmzb6Why9bGBt1c8j2Sd57aXvLDNeMKc7R6Bo7+GDFKrXKynBxViVKXWb5aP4tqW7SMLweQ0St84ua1+c/4Uy0wwtRV6OdrUm/GnfHZ6msUnDhokCqTGyzc7YxVXfQP2ZZ+WC/OOT7Ora6EvSDrX8BOLZCGbQhQX2UKeqEQtaOChC0XOC2r6rXllo9Mm+Z61P34m2CaWTaBJw8x71M7MJWHuxCnVxIjbCLweu4FjJZz+/tJBumsE+vcNGQv2cfb0SaHg4SF1lIXvAACqwEBr3ZCsUV6mjwrmc1/uG9lPX0INeEFGUEW7dSR7qHGDbiOiYCa83YnZg==
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7) by TYZPR01MB5573.apcprd01.prod.exchangelabs.com
 (2603:1096:400:425::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 14:47:16 +0000
Received: from SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c]) by SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 ([fe80::c735:fab8:6e3d:6d1c%4]) with mapi id 15.20.9769.015; Tue, 7 Apr 2026
 14:47:16 +0000
Message-ID:
 <SI2PR01MB43931BDB7405C3DF4F8DC33BDC5AA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Date: Tue, 7 Apr 2026 22:47:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Fix a stale comment about which legacy mode is
 user visible
To: Sean Christopherson <seanjc@google.com>, Joerg Roedel <joro@8bytes.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250315032148.2377902-1-seanjc@google.com>
 <adQ7x0FMmo4FG26t@google.com>
Content-Language: en-US
From: Wei Wang <wei.w.wang@hotmail.com>
In-Reply-To: <adQ7x0FMmo4FG26t@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0003.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::14) To SI2PR01MB4393.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::7)
X-Microsoft-Original-Message-ID:
 <a6a50493-ab57-4048-8d6b-64ffc6d9d12e@hotmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR01MB4393:EE_|TYZPR01MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dd68dba-c03d-4fc5-2469-08de94b48f62
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799015|23021999003|15080799012|5072599009|19110799012|6090799003|7042599007|37011999003|51005399006|440099028|3412199025|26121999003|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmdWenRINW4wRXZoM0ZDbWJwbVFVVUVoc0xlUWI1Z1J0R2xjN2FseFZMaGVF?=
 =?utf-8?B?SjBDUFJLUW43YjVwNWcwNkN1YXhuUis0U2Qxamg5WWgwQWJFYXJpZ3BmbXVQ?=
 =?utf-8?B?emd1cWZZcGc1d2lMU3BScjFtU1h3RnVnUUJRaVJDTmQ3NDhrSzZPNmV0L3NH?=
 =?utf-8?B?dXgweitpTmY1ZjVzclFRaUtxdTRjQWZwWmZYcEJ3ZU95Q3FybXF2clJLUWo5?=
 =?utf-8?B?V3VBQ2ZJZXo2dTE4SFdiSUQ1dUVFNDQ1Rnl4Zlg0NExnNXF2U3R3anc5NjBU?=
 =?utf-8?B?L1QxRmQ4TjNmSlBMbm5MV0s5am14ai9nL1VpNjNIenduWWVKVWhWWUQ1dUd3?=
 =?utf-8?B?SGVpL2NqZnpMZysyOU5hd2dQQTBENWdKTkFieHZScGdxbkNBMXl0d0xrT2N5?=
 =?utf-8?B?THBZTVY2MkdNL0dISXZ4WXNERDlaaFZHamovaE1RL0hkak1hYVlCb01vczc1?=
 =?utf-8?B?MUp3L2NKMGdOekp2UTlMZHBobUMzSzU0VERORld5NjFLWkxFRWFzaVR6b2pm?=
 =?utf-8?B?d3lZU3lwS1BvWTZtMlM3WVhRQUhtWndlY3BGbklqN1NzVmFmaDJ5OFFURzl1?=
 =?utf-8?B?aGpHSzRBemViTTNIVkNPak5vSlRtenVuVXUzWDk4WkxRZjlTaVRxemtCbVYx?=
 =?utf-8?B?Tks5OFU4UFlUOFdCSEUrOWRyTU9BN0JKdnFiK1BCa2tsR1RYSTlxTExSc1hn?=
 =?utf-8?B?ZGtqdGRPN0V0OUJiUVFsYmNCc3BORzlHNFVONmdFZnVpa2NlV1MvWVBnY05N?=
 =?utf-8?B?RmgxdUc5WU9OUDZ0aFdwSDg4RWFSL0YwS1pWR3p6NFZ6c1BBL3hnSC9uejlE?=
 =?utf-8?B?M1hEWlVONEpWQldqQ1pkeU91RTg0aFlVNERmbVF6Wm50bDhyNllJMDIzcUZU?=
 =?utf-8?B?enVQQ0JtZUlaOGFRZ0g5NHBGc1plM0xtd3FOK0V4cmVlb0NlYzM0ME91N0xT?=
 =?utf-8?B?WGdtOHF2Y3RCVEloa0pBRXUxcmVnYktPOC9PSDhvWVlYeXRJakNqYXVyaitX?=
 =?utf-8?B?dHFTRHpnam9YS0kzVHRNcWhEVER0WHNyemxTUjk3MndodlAwUlY5bTRjQ05V?=
 =?utf-8?B?RTArdHpzZVVDTDVIZ2xQS000R25OQWxERTNJL2JJMG9FUFFIbjh5NUZrSU1M?=
 =?utf-8?B?cmJLVHBudXBhb09Lb21LOFBHcEdINWMxdW42MUxLL0tTUWdOYmZUaFpTZjNY?=
 =?utf-8?B?d2dhNWhxMEZVNjRZc0lsRnZhUzlkc3Q4TTRhUzgvdzZDTFNZeWR4Mkh1S3Zt?=
 =?utf-8?B?MDhVN0VYcld4emozRVhZSkRGQUh6L1BvRDFEZkZsT1k0dllSVVBheGx2aW0z?=
 =?utf-8?B?NmRtejRYaE5wRlZDa3IrSHJ3U3RVT3hYRzdmNE9iWk5FeWJMMVdxQWNYenZP?=
 =?utf-8?B?WTFNUG1teUVsOGc9PQ==?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEMyeTJDcDVSdzB1eVNxbE9UaEhIQW0rUjBWMEJQVUdxVHRUVXg2T1Q2L2Qw?=
 =?utf-8?B?OFUrdnVzT3dNNXNPNDZycUtkNldEb1N6SjRFZHlIS09pa1pkeDRSTGFsUUxH?=
 =?utf-8?B?NjM2WUFqYlVUcTA2L3JiZU52UmtxMHN2RzBJOXJNcCs0M0kzR21lMUl2K25Y?=
 =?utf-8?B?R3pBekxZbDJRcUJEV2tTQ1BBcjFEYjVFQWJadklJd0RZRUxPTGFXUCsvSGdr?=
 =?utf-8?B?Z3dzNnU5YjJpN3RWbGE5OCtxR0NDY3U2bjJZR3ljRTRDWk5kYytzMmZNT0RP?=
 =?utf-8?B?QTNncFhKR3ljQTdoK3IyaTNlS3lMMzR0dVpXYlBoVzFITnlxT3Fia2trcVhh?=
 =?utf-8?B?aHV6a2NnN1hQdVhyM0RkVmZmYlZaeUFmLzd2SmhSdjhha2o1SjlMTEhBZG9z?=
 =?utf-8?B?QU50K2tKeE5ZS0VjRDZsaGlXR0s4VU1ZSmt5ckFvbjlPQXltbUVONjBIREVt?=
 =?utf-8?B?SWVTOXo3SVYvNElrdUxqTWxnWnhKTnpjblE0V1cvSTNKdmorV0tsK0tFYWRk?=
 =?utf-8?B?QVBhKzlIQ1MvVjJ1aU5wbDNpZkszMnB3dkRMbDRRQzBpL2ZjVHdMczB2aCtk?=
 =?utf-8?B?QkdEMEZQeGRRWDhwNTd2ZWlZdnM3L3ZUZzBpUTVoekxLRjJ0d2s3b3dGbHdZ?=
 =?utf-8?B?d1JHUUtnYWV2VVJEeVY5VlpEUm1vVzhsWFJkU0sxNGpWOGloRlBOakxYNFYr?=
 =?utf-8?B?TFpybkRsZU9QeTV1T1lna3dXL0JSMXVCTmRUOWJrZHVPUERqL0t6cDlJYWVO?=
 =?utf-8?B?SzNjL3JDb1FKOFo1dVZ1dTMrQVZUQmZDMmhiUm9qejNhc2kzMU5mQTQwaCtz?=
 =?utf-8?B?ekdabm52d3hjOXpHUlZMdC8vRVhJQUNrTFpnRGVNTm5ZQ2Q5ZmFWNUVseTJY?=
 =?utf-8?B?L0dkN3kyVUdkR1J6Yy80dnZPS1JtdWtZKzBEclcydmlIa2FqeGJGNldYNC94?=
 =?utf-8?B?SDdYekw4U3ZSS3pUdVdVNzFkSVFqNnFwVTBDdEpibmJYRVMwV2xqemd0N1Ex?=
 =?utf-8?B?WWR5dFFrYm1ZdG5pLzJoUHlLK080Wm9BbFpNUDgwbThiQUtzbVo3YTM3OXh0?=
 =?utf-8?B?Q2Fhem9qRzVIV1RrYko5SmhKVHNxRnBJYjI1OHgrVGJmSCtCVVFHR29XTFFk?=
 =?utf-8?B?MVNxV1U4MzNKVzM3K1lvZCs1WnE4b3NPbW1ydzIva1k4SkVXRTZyT0lDaDJ1?=
 =?utf-8?B?bGo3YnlDT1pnWUNkMHZJVjQ2Rk9aQ1JoQ2FHbnRQdG1idE04aEZBNWNhMjhF?=
 =?utf-8?B?Qm5za25pRkhNR1FxV0Y2THZnbHdUUURTZ092aDJRQ09qVE9CWVI3M0l1RHF1?=
 =?utf-8?B?Y1VPMmV4OVVQZkYwdW5pTzFidGoyTnVyWExmK1FWTlFhV2pZcXFyMlhuc20y?=
 =?utf-8?B?OFhKZlIzQzFhRGIyMTlBN0daV1YwUnJZMWp5VElhVFNoZFFGdWlGMWF1ZHB2?=
 =?utf-8?B?T21VZGt4ZmpHWEtVZnlyeUFpWjlXRk1vazF0RTEzNkFnSDJRVVpDVmdObXRG?=
 =?utf-8?B?RndTSzRzK2RyRGt2ZUNTdzJ3eU8yNFNiUTV3VXp5RnB4MnBEQ1NCcE9GUnpt?=
 =?utf-8?B?TGYxSWVxcTU1VkgvcnI0bUdwZWxicEtsR3hmMW1veVBVS01aOHFCY3pPS0Fy?=
 =?utf-8?B?RFZqWklIQWlNcndCTDh0Mk41TENUS0p2a0lSbWUyTzNQNlNTYzdDVEhpNE5Z?=
 =?utf-8?B?M015dk1VZks5cXpJMGZybTNyejJMK2FMaUV6ZUFiQ21wanEzK2R3VERiNU5K?=
 =?utf-8?B?UlQ4NnFTRDBtQ0xVcWVva3pIUm4xd2pkL29BQ1daWCtCYURycTZqTXJjR2RJ?=
 =?utf-8?B?Umg1K3J5WEY1WmpWL2o0OE5tSXlVMUdEeTJHbkdhNHh3K0FpOW0wYTY4UlR3?=
 =?utf-8?B?SkRxaXJqd0NaNzErdkFJcDAwK2FBQ1RzWFZNa3c4Q3BESWN4QWk5dmdqczM3?=
 =?utf-8?Q?F8CuOHBYBe7g2RwKCRAK5w2oqyusHy3Z?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-3e488.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd68dba-c03d-4fc5-2469-08de94b48f62
X-MS-Exchange-CrossTenant-AuthSource: SI2PR01MB4393.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 14:47:16.0386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB5573

On 4/7/26 7:03 AM, Sean Christopherson wrote:
> On Fri, Mar 14, 2025, Sean Christopherson wrote:
>> Update a stale comment about which of the legacy modes is visible to the
>> user, i.e. can be forced via amd_iommu_intr=legacy.
>>
>> Fixes: b74aa02d7a30 ("iommu/amd: Fix legacy interrupt remapping for x2APIC-enabled system")
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> ---
>>   drivers/iommu/amd/amd_iommu_types.h | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index 23caea22f8dc..f7877abd0091 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -968,12 +968,13 @@ static inline int get_hpet_devid(int id)
>>   }
>>   
>>   enum amd_iommu_intr_mode_type {
>> +	/*
>> +	 * The legacy format mode is not visible to users to prevent the user
>> +	 * from crashing x2APIC systems, which for all intents and purposes
>> +	 * require 128-bit IRTEs.   The legacy format will be forced as needed

Nit: Triple space before "The"

>> +	 * when hardware doesn't support 128-bit IRTEs.
>> +	 */
>>   	AMD_IOMMU_GUEST_IR_LEGACY,
>> -
>> -	/* This mode is not visible to users. It is used when
>> -	 * we cannot fully enable vAPIC and fallback to only support
>> -	 * legacy interrupt remapping via 128-bit IRTE.
>> -	 */
>>   	AMD_IOMMU_GUEST_IR_LEGACY_GA,
>>   	AMD_IOMMU_GUEST_IR_VAPIC,
>>   };
>>
>> base-commit: ea9bd29a9c0d757b3384ae3e633e6bbaddf00725
>> -- 
> 
> High latency ping!  A year later, and this still applies cleanly :-)
> 

The change looks good to me:
Reviewed-by: Wei Wang <wei.w.wang@hotmail.com>


I think it's nicer to improve the kernel-parameters.txt as well:

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 03a550630644..68f7cdb606aa 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -459,7 +459,9 @@ Kernel parameters
         amd_iommu_intr= [HW,X86-64]
                         Specifies one of the following AMD IOMMU interrupt
                         remapping modes:
-                       legacy     - Use legacy interrupt remapping mode.
+                       legacy     - Use legacy (hypervisor-intercepted) interrupt
+                                    remapping mode. On modern systems, this safely
+                                    uses 128-bit IRTEs to support x2APIC.
                         vapic      - Use virtual APIC mode, which allows IOMMU
                                      to inject interrupts directly into guest.
                                      This mode requires kvm-amd.avic=1.
