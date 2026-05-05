Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011036.outbound.protection.outlook.com [40.93.194.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB99296BCC
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 10:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777975230; cv=fail; b=F/wXBhifEOEwrPywmA8UegpSZeO/TmXMS0z49Xytf4bDJpf7YqjitQi3Z9LkQRpD1hFFyNCq/nSXXC5Pis3i0tpdwdOEjwL9aJXloLoPYQV1prFIrVB4bXO9GuUHb35TcgQUx8Iam8j/uSL4N46WlsQsKcSys5ZL7woyNaGU/7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777975230; c=relaxed/simple;
	bh=m6hTBB1TUU2s0cPFGeBBkLwtvBU9JQMVNPJJ2Ps+rwc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aa3xkQlclUD0emBdgBasrBCEqR4NlvMZW2EYa9KpPXfu4HoxYAZ9DazBqPz64WlW15gEj7aS0uN97L+I81ylc8UXUCPYa0pF8URvgJfNpd/IoYsPiCfkDCpjmfsn6tZ7JfE82/1YJHrqH5gJ4NhlKVIDfcyk+5qRAsIj7oLZQLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nwRBsca+; arc=fail smtp.client-ip=40.93.194.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nwRBsca+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTAxpjMZ5vL2JPeJYveW4oZ5/ucvBRhe/qykOrGyW/K6GYmsEDzhwjeQOKtDHoEiDQ/dEAfZ/mYaXlh+DG2u9GfZecRT0lBRIIWadpqmYBSiq2poqlxPqP9cdnDemcp1Hi+9UPdr7x6iXC8u30M/5pSVInhyPpI2ltdMd2ZSYxPj5wlDwJqs/1xElVrQdhbxaCLUhDOgCgh/5k9/Y3St6NdlOW6H9uhegtOUBSPFGDZTlhuf8+p34XZUT7s+8Jh8/4qpvBLtmEQMfRNym5snWdhah1mNTQ+PlDUcpAE4LKbcHUHsJS5uw+esoKqmdgVbrF3eR1mdVp2Elmd6RXp7FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbI1Vdee0bLcN9TT7azSCfm51AsPxmC6Y/L3naGYvJw=;
 b=PYbWAkFbSDMqw8h9LuloEedBwCr3+3yX1Qg8HwKiLDKkq/CI1tmsmXSFzgf7A4ZBg5UehZefEJ9UYoTs5qLRH4q2jCRbZ7MYjYr6m2Rd7ZPSzZmYGrRHBhF5TYwUr7mVJdf/l3hCcdHfoO5PyE1pqWXadVaTG3m7FJFPmDFDRFdRqdtL3+Ni6uhE8ScypkEgnXQmR3jSw/+oJGU+5qtCC6N4D3v1pyIOhhW3iBw0ZjlxhsGaZpuEw0CJqdIrDgJBgBgtfAPeO823klqKsWktgLLk4dR558UVBrXTCcXDUyOP49RDisM+RDDgiRs+vZ75hK3sU/HPrh8KQ2RUs8HFzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbI1Vdee0bLcN9TT7azSCfm51AsPxmC6Y/L3naGYvJw=;
 b=nwRBsca+j/Cum/58NZgEUAkObv1nS8ojcc2aWxF97fkPNaXqczNpy5l+3ggSOxwWFviM9GzVMsxgvBB5WA3U+9sphKJZmYIqan5LLFLIKOieQDCPebc0kTHVo5NJo4AAvKmGvcsbqX32e3K2hHarcaOeF9qH74TV6qtwpM0vvvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7SPRMB0112.namprd12.prod.outlook.com (2603:10b6:510:27b::15)
 by SA1PR12MB7368.namprd12.prod.outlook.com (2603:10b6:806:2b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 10:00:22 +0000
Received: from PH7SPRMB0112.namprd12.prod.outlook.com
 ([fe80::f703:24e0:b20d:6333]) by PH7SPRMB0112.namprd12.prod.outlook.com
 ([fe80::f703:24e0:b20d:6333%5]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 10:00:21 +0000
Message-ID: <d92b42ef-8f9a-4d04-8c34-adbfb50bbb6b@amd.com>
Date: Tue, 5 May 2026 15:30:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Fix a stale comment about which legacy mode is
 user visible
To: Sean Christopherson <seanjc@google.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250315032148.2377902-1-seanjc@google.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250315032148.2377902-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0034.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:22::9) To PH7SPRMB0112.namprd12.prod.outlook.com
 (2603:10b6:510:27b::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7SPRMB0112:EE_|SA1PR12MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: c60165e8-9927-455b-4790-08deaa8d1eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xJ6GhzMzZR4JafYSB64fBpbHyyjzW4xNkiB2d950Ics1LJ80ZqcL8TcVABswpXke9pYtnVcqahIzqFELqKRMp2bVfxsJS58sVzwBWN2Db7Rpo7LHY/yGEuY7DEIKE+UoVZeFgqtXFb3EUWoXWDdTa4F/hM3NwBHWdxDliM1/HPtR1cmfyVoFt1AfGSjaqjNljTSOewE4URVJ3Qo7xQa+Gpi7ljxUBdetdfic8P5dYyx0U4SBGsgKwzmnrZ+6AXvVm8QBtpmTtML9p1KB+Fv/vYAGK2r3njabO45MoghFhtwUAs4MiHvWSbt78lTpGJ801E5oNUXXQWSpl6JRuGW69ebU4m2aNOoH9VzRlUv1KhqGdFq5lNJYx5cxhtEusrVHQnZzAPOeImwAHdklQ4zrLtLnxT3/udSnra7D+bVezwKdAy1Yxzi/QaSzKNBttdUEcZFC+4OZWFp818TXN7Va4a9aJvVqFAr0Y5VEE2XL5Da9MDIle7JD9k08EQbfYdDUfAu5h/f7+pKvscz/DlWbReVzzblLsIukDsQWorCvU585z+KpUTnBcZnt+jtdp7tVptEcZaFErS8+mQUQEdJWLmIV+KJfnEPiH4IDAyQ6Nng35q5hlX6SjYfYdNwBq1XxNNl8eVm1CONW8NKTtSLmPtCcDlioHDVxGZy7AOAsXwXl/veDZP0YdMWptSdyMM3w
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7SPRMB0112.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NytwZm14UHp1N2FuNUJQWUI1U2Q2SGViSWdQN2NNdHFUcnBScmpjQTJ1QUds?=
 =?utf-8?B?eUc4Rmt0QUVubzJzSkc3eTl1Q09FOWc0TEJOS25EN0NQQjRyZTM4c0RGTWFq?=
 =?utf-8?B?TUpQMktjZHU4WFgxK0lVY3hocXFFWUYvU1I1ZkxXUE16YmpQY3VjVDdzR3Z5?=
 =?utf-8?B?MTZMRnlEMnpON1orMW9FNEtZUEtmY3VzaDFkR0VTeXg4eml6MXo5Q0lDUy83?=
 =?utf-8?B?eHo5NVFBNWdhRFcwQTlwMzY3MVhhMDFnQnhiSURURGYvS3o5MWlWcW80V0lB?=
 =?utf-8?B?Tyt5eGJvS0Q2cWVYV0dVSWNGMkdFV2dYTUViTFl1YklNR2JQVktjMm9IYzF3?=
 =?utf-8?B?Vm01VkltazhVOElST1pJMHVLWHFRelBKeG8za3JDT3NaZ2F2ZllGYUZ6Rkgw?=
 =?utf-8?B?Z3Naa0RaUGEwQUZ3OG5YTUVUNHFFa2x3R05VVk55S1Zzdi8wV2JSTUZNSTFS?=
 =?utf-8?B?b2dpN3hoVmM2YXJiMU1rMVVUQml6RVhjZXlTbkl2ZjY2UW1PR1RHZVVnSnJt?=
 =?utf-8?B?NWFKRHZrblBVcDlFNmJNekY1TGJxWUZKTmQwcXJ0cDlMdFJZR0ROZmhOYWhM?=
 =?utf-8?B?T3JkQUxmZXlMenRzUEhVMmJ0bWhVZlQwWTNIYWR0MXMwb2FtbkxXMGJRNnVw?=
 =?utf-8?B?YjltdGRXckdPRGpmTmtoaitpS2Y0UFMybjU3dlRnWGxOdGw3WURTUXFIV2lY?=
 =?utf-8?B?YzZCUVV5ZjFPTURTNmYxQlBhcmt6aGFMbWZEWlRuZE9leW5NZlc1RmU5bGZp?=
 =?utf-8?B?MTNUaFprR3U2VUFhRE84Qy9ENWlhK1hTOW91SlRnRmR1aE9VMGFyK2l3bXdM?=
 =?utf-8?B?QXhscEZQeHFmTDQxOEg5NThXTldYSjV1Y0x4YW83WHRPUTlvTWc4UmQzTTRi?=
 =?utf-8?B?cGRnR0t2V0N3eXdDUExMZGJ3TERvT1NxWG15Lzc3dVVwNHc4SlVzNms1ZkMv?=
 =?utf-8?B?OXp5dHRNb0xOK29iS1FCS3ZwSnhTT1liQzQvNGFxK0dva0EwQjl6SE9FdFRB?=
 =?utf-8?B?TFJsRTdtUFlTaFJEYVNVL1hMT0JoQkl4eWtiL09qaklSbWoyYXp1K1JzZFBT?=
 =?utf-8?B?eDhsaDRkSklGMWpQV2tTbGVRKytIc2tBb2tIV0cvdlVlc0NoWGkwZXAraEN6?=
 =?utf-8?B?T2NtdDVwL3hIZlNWbTFzcGV2RXMzKzRLMjNuS2NFQ0FZejBvbGJUS0ZFWTFh?=
 =?utf-8?B?eithdnpaZm42SElvUHY2VGZITGlhcVFXaVBvVE04eUxPMnB1RDM5elZ0TkRF?=
 =?utf-8?B?QytpOU5tS2VjMFo0b3RBQy9la1R1MUZyUzYwdkN2SkJZWGVUTGcrSFB3UEdi?=
 =?utf-8?B?bEcvaFFmc25GMGlHMEZYTldyMUlWcThOazNLM0o3RlRtcmxTUDdnVEI5WUpw?=
 =?utf-8?B?d01IWGRXK01Jb0MvVkp1a1R3WFU0RUVYb242aGtEK2JSNFZNOUdhVDc2WWds?=
 =?utf-8?B?eGFQbEdCeU5pdGNmQmIvbnM1bHZQUitIQmhKUzRaU25rSUpndDJkaE8wRDdv?=
 =?utf-8?B?MVI4d0Z4WUREMXh6TUsvd0cxVDN5UWxxeEdCQVJISmFDVnh3MXcwbUp4TFdK?=
 =?utf-8?B?aWV6djJhcXJQdlRnZnl0cVNMM2tNWnZlRTNOOHB4djY3TFBFd01Gdmc0amds?=
 =?utf-8?B?d1A0RmFFMGVrU3lTQVZQMGo4R3Z1ZzFJc2JPR29rUnlSNHdvU0ZxYUVvVHov?=
 =?utf-8?B?dHQvbVFDRXRXSitCUjlRdDdrQ0l6bUxGU25jc0tJRTRGbGlJT1FMbWtvT094?=
 =?utf-8?B?OEVSTlNabFNJaGgyQ2c4bHY3cHBpdlJYeElHZGdCcGV3SElBT1kzYTlWS0ZT?=
 =?utf-8?B?a2tZaDdYM0oyQmlYK29nNjRDU0diYWNhbExmMFpVb1dtM1J2dDlOMHQycDU2?=
 =?utf-8?B?cE02NmpCTTl4RVpidnRPWVE5UW9DQkZJMVlWWk5ydHFGSmpsWFVPSDdURjJH?=
 =?utf-8?B?RW9BVFB6RmRoWEg0YnpUbWNBQjNNMXM4c3J5bStCcWI2bVFPRFJ3MWM1Q0c5?=
 =?utf-8?B?SmNBb1dndEt5RExnVXpndTgzUFVvQmplRnlZTkQvaVhVS3dSY3JzNFdSVDJi?=
 =?utf-8?B?VC9wSzM2MDhhNGxQVlFGY1UwNGpNdGk0dit3UnhvNDhxTGhxUFM0ejM5bzVl?=
 =?utf-8?B?amZYdk0zc1lDUDhRVUxUOW8vRHJUZk1hOStXUmlyK1c1Y0RacXNRMHRETFRZ?=
 =?utf-8?B?YjA5V0QwejJGSWR0Y2NDeE1QUElUOGZwNGxtbjRCVzRHeC9TeUpnbm45ZmtN?=
 =?utf-8?B?eHlIallMOHU4UHRNdVRWMFYxVEhUeUp4eTAzWDFURVBMZFNSb25CMUhoQ1dF?=
 =?utf-8?B?WHNKZVJ6OHlENWlWbDFUL2NxMTl0a3hqU2k5OHk0RFN2TnZMUDVSQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c60165e8-9927-455b-4790-08deaa8d1eb3
X-MS-Exchange-CrossTenant-AuthSource: PH7SPRMB0112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 10:00:21.9004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Bg7FDICDkkg30nxSL/r63MOY499G20scMfVksQ16MSG1vyOTeak+YMJdK348+vAOyav8Fg8ZFLApyQPKh2HlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7368

On 3/15/2025 8:51 AM, Sean Christopherson wrote:
> Update a stale comment about which of the legacy modes is visible to the
> user, i.e. can be forced via amd_iommu_intr=legacy.
> 
> Fixes: b74aa02d7a30 ("iommu/amd: Fix legacy interrupt remapping for x2APIC-enabled system")
> Signed-off-by: Sean Christopherson <seanjc@google.com>


Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

