Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010066.outbound.protection.outlook.com [52.101.193.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F301A369D7C
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 04:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780028026; cv=fail; b=WCGk9ehHGVyVqPm5jyP9LEWWA5mdFX83T9K7qk/gim2wee4q54y8Qd6ahhOnb21mMNWxIu74/1Mogq+EDwrrfVhb/ErJ6OJzRp91nEjQ/zrzx9AJbPsfeRtwq7xAYA7gJUWY+YjQBTnXV9uTglLfx4AlUJlfqWf3oJHyof2TDNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780028026; c=relaxed/simple;
	bh=pFxphNP5VI45FPB9Jq6KTHLXiuROKDm/CCMnHsyVFVI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ce5lxDZgc6U9Ho0SoySc8hLbMJHzpbFy2hsw4IoNyM+IV1btz4xWb3fV6BpFhKGWHXSBrZbX8d4v9KLQZHEPUJATWGJYWlXMjVax4h/nJptfI0236L+ewAV9JKlIOPFMAmlh/SCMXaxpNozhNsTmC3D7LAq0kuND87BQj8vtcdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eRPsQYuX; arc=fail smtp.client-ip=52.101.193.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eRPsQYuX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxEeZWolpIta/IkN1UbTk3F6QQzJynGVgwTJdYkfv5sJ1HH3+mN1vDRQHyHT6HBRqnkBtMSOLHUC9QadETfBCP0/KagVw7kdJpIvRAsS9lZ8fB2nGrWHXGuj4FMU6Eiv7FfUkL6i8iQgzLDdvpAvbncvYNMIcT4urG43bFP0NkiGdBKJZavxB7syL/Zru3a+8gXISIqXw/eZw1lyFy8SiXJcwGk2PnVjBXnSy02ZKYUdf6KqlW1YRw5aUiuhkCr5aE6g8xMmy3MKUB/ItNJxHkPudlCuxl/sckgZEQiZZkDgx7VqqcJGOI32YkTv2bnl+Xs8cQWQ7+qfKm+f0MQGUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xxXXTe9Sj4Bt48PPjWkM8CgL0r6mbanIrOWoVzi8jgg=;
 b=C+Swmu+ODllfY5DZrbsIAuA6msEcAg8FxX0fFXc9RQg9C0S0/Co0lJkHvEoZk2Vie3EgiM64SRNLNoerjmFF7wr2WGLLF1RmdZ3PP1/LbPPJCLFlvaULISB546xTn3UheXVFPZeT+KUd87+sg2kWsioQL3J8Ide+mnNsieeWH3OQpXufKiPwwMYycsNxMAGUt552PNFvtxDPlOHMwrinB/PtFrNwZbTJ+UDS6ecQssNVGvu4Mhis/1aQBA3ta+wPw73HFsyXJ4PnD8O+lYNsThNzWabXv/o1p17llmrfRSjlsYtKYh5iWABhr/vKmkRA6/20t7/6APB0ba6jq92Kag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxXXTe9Sj4Bt48PPjWkM8CgL0r6mbanIrOWoVzi8jgg=;
 b=eRPsQYuXaXoIq+qOFZzrJcgb3g25OEzV2ptk0b2JKePgOsiV6n+Wnc1R1ca4kkuUr/Uxg9vw1L8ue0oSv2VjsOAw6/4vMVAJ+C8m78kcs5AvvSVG/QjTEArMYW7jTOkvwou3gzPfGXAaoJtvuvykIJQvqG3v+saXN+Ayh27x/tY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 CY3PR12MB9680.namprd12.prod.outlook.com (2603:10b6:930:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 29 May
 2026 04:13:42 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0071.010; Fri, 29 May 2026
 04:13:42 +0000
Message-ID: <b9721658-874c-4135-b1f1-a302e4aa6a31@amd.com>
Date: Fri, 29 May 2026 09:43:34 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] iommu/amd: Prevent SB IOAPIC from overriding IVRS
 validation errors
To: Wei Wang <wei.w.wang@hotmail.com>, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com,
 thomas.lendacky@amd.com, aik@amd.com, jgg@nvidia.com, kevin.tian@intel.com,
 xuyongwei@open-hieco.net
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <SI2PR01MB4393DCD4BF7E79CB63066D16DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB4393E6509A349AD67BD79BF7DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <SI2PR01MB4393E6509A349AD67BD79BF7DC5DA@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0007.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::12) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|CY3PR12MB9680:EE_
X-MS-Office365-Filtering-Correlation-Id: 181117a5-9922-4536-a04d-08debd38ab0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|22082099003|921020|56012099006|4143699003|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info:
	rktFt905CS330qG2BkjQbRK5qDR595WBJtdnVnCnx329sywuDh4acn8Bc+WcXHXLBoMY8COvADO+D6XJnYhm0UHShT4cxLTI/CbQ/QXRhNc1J/qf8LWT9kFMKkBFRihVVokWIBYKj7s/aW5Rrcd+RMrnxhi0Z4jjBrLO6+GN9ejb4B3s5M0kZZy/F0Ui9WECjAh+H9CHhfhpBtv9PdBeGKBhCHoMq6BtCXmbBP0VM0x7kN83EcAzCfJg6u0/VIGS15C2RdQpUVogzEWx/p2EP3Rys2539SQ9WIrhxlhqQLqyzl08ptCGLZxTWwDKFvRsZN/52+vKZJ4rkMSiZE9yqnWqZc/+cF8W1d1EwFL5TjxgcI2C09YDCRvadXfkHby6bgz9IcURsRWO/7ndLkSmdMGkaPR3CkQiAiYYds5TwNLMPsjNSr39rQH68+FBC5FvKJ9HdZen95LceNuT2RpaIDp9pI9uGqVNCzpZsPuv8xxCwhz4W0ZE4vcaJxdNo+6qiBZ3UFosHJbLZUoF+Qdmjul8DaTeme5sl4bRSmLoAFG64fcuDVoivcjVOYxBP5Az4nTPykbjIy2n90qnS3yOG1Q5ivhVx5CAiIK3W6/bKJhhDmdBhHP3XjYBt1I5dcWZqVRnzrm+MyPyOYf4d5gQrzKjK0T3IY480ccSFxR9MjvqP1BHUs8G+8LhmilLtGUeuQav+JJjrutrTCqig6CNanckxMsK+jQig7ObS4ZIBa9imetlK1qY3g5IMC27h+M2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(921020)(56012099006)(4143699003)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzFLbmxnM1B4ajdlc0lYaUtQOGk4eXJIdjFrRy93dlFjQ0plMEI4ZDExaFZR?=
 =?utf-8?B?NHdXUTIvbWNWZXVsSzJHMWNxVDlkN3pHYTZxWEZHQjRFYjM0ZG1lRHIwZVBk?=
 =?utf-8?B?K2RqSkpTcjBqU012eHBnY1JSTGtPV0lqejFOTWtsS2hvMGt4djFCVDZENXFJ?=
 =?utf-8?B?cktTS0VnMThLb1BGdXpXVVFhR3pZbUtGblAxK2hkZHA3K1ExYnNsaEZQeExk?=
 =?utf-8?B?QVFyRkpWMXRSUUVzbGV4M05UNitZYXVTdUtDaVpjTXI1dkxXUnpWRXErVEdt?=
 =?utf-8?B?U055Vy9ZQ0c0aDU3MHpMRkRJdytSRVhCUHlVdkJ1eXFtQ2dCUHBiUC8xejAy?=
 =?utf-8?B?ajdIaE9lZmc5WDlsOUlsaEo5QW9uaUxJY3ljUElUaFNtSmUzMEI5dWROVWF0?=
 =?utf-8?B?aUtBRXJkSmlGbjZQaCtVMzhoUW1GM29XeHNBY01UYTJxSTEyTXdqcHc0QTJi?=
 =?utf-8?B?N3hzUEVWUTlQOStkNVFodXdnbDlRczRaZkg0Sjh5ZmcybXkyZStDUjBKTGFp?=
 =?utf-8?B?UG5ZM1hXOFc2SmNhTE9mVWdUQ0tzMjNuMWc3S0RFcENuSzlQQnlJS0xFa3VT?=
 =?utf-8?B?eGNBTDNHVVBFell3a3pROWcraDZjU2FDZFFhWSs3bE13R20wQ0FCK1Zoc0xs?=
 =?utf-8?B?UEJEaXArYUdJZ1d2MHBKMHNWRi9QMlAwaHdYdTJDUGFWc2p5Y1cxS2RreTNy?=
 =?utf-8?B?SnlMejhsTytwMXhmVW1SVXpjb1pERjBpcW93bTVqcFRxV0FRT0l2dnpMMTkv?=
 =?utf-8?B?YzJjbVUzbWI1aWJTaHh0MGI2Nnpuand0eU4zcFNVYkl6cm9RMUhRWjQvUTgz?=
 =?utf-8?B?dlFOVXM2SVdhbUl0YTErbDBtUHhGRkcrdkNsQU8zTUxPUCt5YWZyM0lubjlQ?=
 =?utf-8?B?QWJIWk81YjRYRjhZMjhZWUpNRzhNcVNQTVVhbExCc2dOZWFTOGdxMUxBdGZp?=
 =?utf-8?B?MWRwd25TZXpNTDM3QURFeElwNzYrWWtieDA3YjErU3ZYZUZXaVdoUzIwMjNj?=
 =?utf-8?B?SHpiTUQ3VGorWHJSUHd1VDQ5YkVlOXhmeHNvcThIUzZqV3YraUxpV2JhTXg1?=
 =?utf-8?B?MXA5MmFoUFFpT01mRjg4a0laRC80eTdaUzBZMyt1U3FLZ0VBYVAvUWI4c1k3?=
 =?utf-8?B?ai9JbVVzODNIN2lRclBNaHJTQnpnZkxrMytOS0MrbU5COXBFaEs3enNsRTBX?=
 =?utf-8?B?T0NyVjJETFRucEVqNkxrWVVaYk9tbCtTN2NWTHZKdzVIYXBLMVQ3OEJNSEFY?=
 =?utf-8?B?VVp3Y2tuam9FcEpwMVpia0ViQ295REIrMnl4dHRTcXJWMk1xTlFYTmpLaHVt?=
 =?utf-8?B?NWlpZVlRODhHa2lnRmNvUjFYOFl2R0kzeEozZ1hzTTJuRC9ZSVBkUnEyTGxj?=
 =?utf-8?B?SkVGRmErU3JiMDlTQ0pvY1NPQjVyajdWK2kwazdQL0hXZ0VCY3FoeG1UUFZB?=
 =?utf-8?B?S0IvbmZBRXcvdUsxRnR4eWYxMDEyNkFHREJuZWFVazVBak5HNHlBRnVBbmJw?=
 =?utf-8?B?YVp4ZzN3RkJiZ1hrSWRTRkRJdUUvMGtzSDFOV0o1VDl0THE0eHVRYnhUeitU?=
 =?utf-8?B?dloyQUZUUXpFdlZJUHpibzNRNVlyRXF1QnpDSFR4b1hkNHl6cnZQSTI0bkhq?=
 =?utf-8?B?cisyeUU4OTdxSFNTT0pLdXpHdUJWcVFDSUc1clZYTG1JOERZNDc3Qko4MjMy?=
 =?utf-8?B?SjZHTjlGVXJLVmtUZytkTHJiVGIyeXgwSUIyQkIyb3FvNDNuY3FMbUVmV1Rq?=
 =?utf-8?B?WldPaHRUemcvRG1hSEJMTFNBOTRORGJoOVpzZmpkMTVLemRpRE5hc2JaTk9k?=
 =?utf-8?B?VFlFd3lKUm5XcnVEcWgyZTlJN0NETUxSeURTa1VmTVd6RTFMVjJCdnlhVDVX?=
 =?utf-8?B?VjlodkV4UVhtcStmRU9vb2hqWlBTZkFsbi9kWGNKMXZQVUljNml5NGlUT2ky?=
 =?utf-8?B?YzExaThxRDRuVWpmS3JvUC9YY3JPYUFJMGdSRUt6bWUyT3NDT1RtbEJIM08v?=
 =?utf-8?B?YlV4dHFXK3ZDenhaTVJhc0RqQjRPa0NyZk0xYmd3QkRxdjdCTzVBTkY5OTMy?=
 =?utf-8?B?b1FBc2VMekc1QVdqcEhTRnd2ajN5a0Q3Vm40a1ppN1lZTzlORldhSklkWldu?=
 =?utf-8?B?UzhJVXAxQ2E1S2dPNCsyZ3p4Q1BrU2VnVTdvMDZPSnBKOFlXL1J0Vk1oZmVs?=
 =?utf-8?B?cDh3SGlEZXlwT3NjZnJVUzhoU1RmbFQ1SDVMbEJVbW1iaEx6T0pHb1Voek1h?=
 =?utf-8?B?M1hvcFJicjdjamtpR09sa0xiay94YVB0dVZvK3RRSHU2ekVDOFhCMWZWUGlP?=
 =?utf-8?B?OXJxeHBMUUJRNEZZMFJ4QWhKRUNSZ1hiWDlJRzZYMHZrL2dXQVRJUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181117a5-9922-4536-a04d-08debd38ab0e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 04:13:42.0708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EuBdI5lxiZ4EL1bkgtZz24AqyxK6nbdAD2H9Sa1iaRcrIswTvey2dKi4he35n9rR+KVHNBLkNnQI6ohlfhtLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9680



On 4/6/2026 9:10 PM, Wei Wang wrote:
> The check_ioapic_information() function validates IOAPICs against the
> IVRS table to safely disable Interrupt Remapping (IR) if the BIOS provides
> a broken topology.
> 
> Currently, the validation loop contains a bug: If an unmapped secondary
> IOAPIC is encountered, 'ret' is set to false. But if the Southbridge (SB)
> IOAPIC is enumerated after it in the MADT, the loop overwrites 'ret' to
> true.
> 
> This bypasses the validation failure and leaves IR enabled. When devices
> attached to the unmapped secondary IOAPIC fire interrupts, the IOMMU drops
> them due to the missing Requestor ID, leading to localized device hangs.
> 
> Fix this by initializing 'ret' to true and only toggling it to false
> upon encountering a validation error, ensuring failures are never erased.
> 
> Fixes: c2ff5cf5294b ("iommu/amd: Work around wrong IOAPIC device-id in IVRS table")
> Signed-off-by: Wei Wang <wei.w.wang@hotmail.com>

Thanks for the fix.

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>


-Vasant

