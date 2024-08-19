Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69B51448E6
	for <iommu@lists.linux.dev>; Mon, 19 Aug 2024 05:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724043924; cv=fail; b=KEJsNAAzkrapMwLUHy+9mF/HWRW41QSe3upYUF2olCUrSgWAlbP7D5e4EUE9SpwaS/42qt5XpQ0xzCnUmsSDkCmMxO9neRSxi2z3oL8ztkGps51xguMTP46oD4cbCSWIryG7CM6odz2bSa1j/KMjHh/lAqsKvDaJZQjJbjniJ9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724043924; c=relaxed/simple;
	bh=T1ar5HHWUPJz7KTOO0JYZXtE+mPEWE4WCqLLtLyM56Q=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=meTh6T2VnMapFwrSxgArPGN8arPfGyDb3z2VjvyOichU4ANT3Zl/yWfKrp7MpBHz4XysTHdBa2URFEERpjUCtodos9qMjcX+uyyKJQ/fTPVvv1vQlU0H807K4cQDxr9jSa5bOsNszvIK6G11lGacLsnMhFpOMLTZ3DZj120zSpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I8e357BB; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I8e357BB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DmJZgGt9o6fa6U+xBftQN9Wu8WdGapNJZ/ZXdhiMrq/9Q8BXr8lQHy4Rb1FqD+TV6COxVDtiaMH/nh5FISI6FxfS8MnVgQXoQGQKdAAk43pIE+kSK0Dn3IcgXpgNrvX3nnv8K4YOWlpoKfFn8fYcOtIdQKT3vUmMjSMEmgWAFBMX60VnufZF6BWEs6I+0KBBLQgCYvmB617j2ZYh1w0pdFzqOLXH2pgUmotptxZL3wnRdijrg9Bohk8JNEyRawHsdVygqd0en5o9sIBY9Lsl35n55GM6pvJhSwXqYxKrMPqPVZS9Ce0CJFSmEqt1Q/nslVN0fwLQdQuxqMiVaJgj2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIgxtut8REHaUJt7gXj8s8SJfNgo2sLPpNxfJWWs1Vk=;
 b=TbLoK4IylkSTxJV75tihYjaguLCh9okQJGLN4Hv0KpnApVEFzThBUtvaNKbE0QgfvYwAA1WgeFQyQ4EJTmiIyPuvX4eMwmNHsMHrt8FG/KLeAx9+TtA+NM0BL9COS+LuOCqQVFp7VuPZJ3oS4hIdAuvD4DHF2z+YiwVy86dyzqf/ai2aXE+0KBSTrMyImGPTzCBvALTDkOGvTNxPjL6kFvN+u69wSkhZB0pEWrTHoiZnUnr7GrxnkRVyA1YptwksQGfbFwsMCTfNq38+UHVZoHkVFfT9UkCHBgPzS2ltaPdk/H/cfzaA9FMaftUiMHaZ7NQGuxgCNb8UsJkgxZAmeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIgxtut8REHaUJt7gXj8s8SJfNgo2sLPpNxfJWWs1Vk=;
 b=I8e357BBpw8VpaDnwzKlPcOljDEo11z0lNwyJMNiTUd4usv4EMztbj5spP5qbhNIik8L5znW7nc3KAMhZmnhCD+EqJPkrwQbNw0qVGmVHguSXWdS8Zqb8XENFMlo5PXYv8AHey/c2Da1p+CbPMus8gWXUjLdI4okzdOrn2B4VADpT1jJt6QwKjz1LUg9QfnQ570caEBK0DoXbh1FiHnQCFXc57ZiXKcZPaDam1gK4XQoeJWrDj8zjDtnfZ64t5p/axvdoeH8j3Ou7lETB8yIcxhj+wBFyPVVyPrL0uMShxzMCGbAbciQ4/P5POLMRvhoVHF+qPsQzaFICXf6bsZ9hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5)
 by BY5PR12MB4273.namprd12.prod.outlook.com (2603:10b6:a03:212::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 05:05:19 +0000
Received: from CY5PR12MB9056.namprd12.prod.outlook.com
 ([fe80::9a15:4da5:cfae:f5c6]) by CY5PR12MB9056.namprd12.prod.outlook.com
 ([fe80::9a15:4da5:cfae:f5c6%7]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 05:05:19 +0000
Message-ID: <a3a6682d-b0c6-4c80-846e-8e0bb3f21397@nvidia.com>
Date: Mon, 19 Aug 2024 10:35:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4] iommu/io-pgtable-arm: Optimise non-coherent unmap
From: Ashish Mhetre <amhetre@nvidia.com>
To: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20240806105135.218089-1-amhetre@nvidia.com>
 <2696ea8f-1b36-4c14-8ac0-70803de2680c@nvidia.com>
Content-Language: en-US
In-Reply-To: <2696ea8f-1b36-4c14-8ac0-70803de2680c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0206.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::17) To CY5PR12MB9056.namprd12.prod.outlook.com
 (2603:10b6:930:34::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB9056:EE_|BY5PR12MB4273:EE_
X-MS-Office365-Filtering-Correlation-Id: 9608c93c-ddbb-4bd9-b253-08dcc00c8577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFg3V1R0VFNYc2pvM3RuZGhVbnJQNS9BM1F2NXhkbkR0OXVJbjRKVHpTM1Rq?=
 =?utf-8?B?N3FmS2xjcVkwUHZMajVvMjZvakNCakVuaWEwdkJ4SFJuWU1YVnpmRjE3VlNz?=
 =?utf-8?B?dzYvL2FtZGZYNERnenduZ3JwYjBuZjdEZEJJeWRiOW5SNzJoSVRScUpGRXIr?=
 =?utf-8?B?OUMxSGl6aEE2eWVlUHlVNFZjQWo0WVRaYitRYzFIbGdkM0xBTjRzWDJsV053?=
 =?utf-8?B?REEwUFYvbGoxc3ZQa1hzeGRWSWw4b0pLWjhOdHYwcmg1dU0rTGZJS0tOaUVk?=
 =?utf-8?B?RUJ1WCt1V2lsSGlxbmtBMEZWQUozSTArdTdCckhoZVdIejROd1pFZ3hOTEcx?=
 =?utf-8?B?Y1d0VC9RL3JscWJXOU44bTNQMXA0RVAybENFUUxUY1REa0NKcHRqS2xqVDNi?=
 =?utf-8?B?Y0x5OUM1K3k3VHZWMU04cGNGRlBBcjJ2Y2MvNFlnYU1RSFI3R0dyK3AvUmNy?=
 =?utf-8?B?OGZLdFF4MWcvdklmeE9MNHlQZEpmMFJ2aThqbkduKzhOL2Q1dUE0ajRyazlY?=
 =?utf-8?B?UnlpVTVVSDF1K2lDM2NzZ3h2YWlTZW9tQ1JRNXlwYnd5bFpaOUJLQmlBcXhy?=
 =?utf-8?B?NVhJbzFZd1p3NHJlYWRSd2NFNm1PQUVreUJJblNET3I3b1lOWFF1Ulg4TE4y?=
 =?utf-8?B?THhxVkJOSUYwS0NSbjEvalNOZ2cwMVc3U0syaHhUbU9waS8yWExPYUtySWdp?=
 =?utf-8?B?YzcvNUJaVjNBTnZwTkQ0c29nMFVCeG5RbldVR2IvaFI1LzF3cktPN3U0N2c2?=
 =?utf-8?B?SWg0cUY4d1VBM2hISGlHT2FtRWQxOFBEN09jL2h2aHRGUEJoNTV2emJRUHhh?=
 =?utf-8?B?U212cU96WXBQWmR1dnl2VnNHbUdocWZsNGs0dUxkR0JmeXpHZ1ZjUGZNUStZ?=
 =?utf-8?B?QjF6VGdkd0htcWdsS0Z3TUZyUURHODZ6ZCsvdlUrd1BHVGJIT1dpOE1hRTdY?=
 =?utf-8?B?WWM1RytSdHk3R0ZEVy80Y2JIMUI0WHZKeFFackVsSGF0cmxFVHRsOXdVTXpL?=
 =?utf-8?B?dW9HdkhHVERaOTVrRTRBcE9ESCtzcFltRnE0cldHSjdXRU13NXVnc3gzVVpY?=
 =?utf-8?B?RzRWeEQ4RFZWaUM3eGEySU55Qm9mSWcvQkh0Qnh1NjRPYmRjMGllTHIzM2Jz?=
 =?utf-8?B?eVlUVzVGVTErbC94NUFxM2diV2FoMUl0cUFHcHdLMFpLMUZjdmJOVDhsdG1i?=
 =?utf-8?B?RDJKUUhaLytRZjJNd3BaS2NUdWozWU5lbFpaWnhEOENQbTg5aGwzOGRkMzBp?=
 =?utf-8?B?S1FvMHBVNE5Pbmp3aFZvU0tqZEhjODEvbEFNNTNKUlRPL2lpc3VGS0owZGMw?=
 =?utf-8?B?REk3d3JtVUNsQ3V0V2J5RTZEank2Y2ZHdzBKeGVpOWkwaTFDSm1GWG5sazBi?=
 =?utf-8?B?NGF3NTNTZE5lNUNuN1JuRDFJcFA0bXA1d3ZVSHljWk9BWHA0LzhubUZDcnRi?=
 =?utf-8?B?bFo3bG5Pc3BtajRrbHlQM25UYk1ZNFoyeVE2cDQ0VmorSUJ0UU5IcEJuOHZJ?=
 =?utf-8?B?NjJoMjYwbUx3RmdJUy9kV2tSeWxtdXFoZ3NkRjMwb1l5ZXFURk5seGZSdDRq?=
 =?utf-8?B?ajBPL3B4cjd0cWRZdjg0TlVtbS9MUGU2ZlBoZm9rb1g5Z0lMQzcwMnNMWlEx?=
 =?utf-8?B?SFlyeUN0Q2syY29CZ0MvTFV2bUFpb0lrRzB3NzdqK0o0enhMTnk1eDdpK0pZ?=
 =?utf-8?B?QzBwd3NoZ1RzbDFUVndiL2o2NnlzZ3hUKytWYThCRmtiT3kyK25KOVBrRVZD?=
 =?utf-8?B?SExOOGtMMWVaWnVvMjBmcVo1NW5aV01DcVVLSmRLakZiUjFqeW85RzZjRlhk?=
 =?utf-8?B?eUppcWhpOVhEV3FKMDJLdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB9056.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1gyNTV5dkdoNC9qd0hmSURnSVhyMzF2Smt2WndveURJOXlYeGM1a0pwelZM?=
 =?utf-8?B?Y29GTlV0RXNrODkxVUhwdFhwc29qMndWaEk4V3o4VFhnTy9KdTF4bW5KSUgy?=
 =?utf-8?B?aWo5cUxITEJJbk1nZXhuQmZQUzFqSSthOXl6aVVkMGdJZlhMM24vVWNldCt4?=
 =?utf-8?B?aVhJYVZVdGNrTFJ6SFFnT3RpK2lmZ00rZ1o2Zkh4aXM2ZkMvdWJRMldoQXlR?=
 =?utf-8?B?RzZ2aHdQL2RlV0RzdVpuRjVDYUw2WklvVmNyNTE1dFZLRTZaL09DRVpVQVds?=
 =?utf-8?B?azhlUE9lUisxcFE2d3BlaUtiK1JQdk03Q3ZPL3FoUXJmWWRlSGljVkJ5ci9I?=
 =?utf-8?B?U0NSM0x3U3hrMWwvRnNBb3Z1N3p4NkhmQ2pzbnp2Qzc5U1hURmhXdFVmRXEr?=
 =?utf-8?B?MUNSWWZzWkpqZUVFN1JqaXBScXFFQXRBR3JQeGQxeTNvc1h2NkUxZUtORDhp?=
 =?utf-8?B?bmtJdlZiWXByUG40QmdZdDdwRWdLb2tQSEwyLzh1U0JRVFRTdGhJNVlHdExk?=
 =?utf-8?B?MHErYWxScGlnaC9GeFpCcDRRRTZYQUtvYnUyS3RUYWpBR3E1d2xBbitSQXZO?=
 =?utf-8?B?K1M2UXUrRG9BbHhHY1RDRzVXbnIwYTVtdnY5dElVcURBRnE2Z0V3VjRJdG1I?=
 =?utf-8?B?UUJlajdXZ1YzUEVCL3NBcDFVeGo1UFNwWTV6MlRoR0lCeEQ1dFkyM0J2Z0c2?=
 =?utf-8?B?bWhEN1RCYUZkNFQ4T3FIQWQ2Wm5qM1ZLK2VDSS9BLzRqejJsSzk4UUFZN3k5?=
 =?utf-8?B?a29xdDY1L1Y1UzRoRGtDK2xBSDdpUFdxTXFXNzZzb3NpU0M1Nlk3RDZ1OEhO?=
 =?utf-8?B?Ry91QzBQd1Z0b3ZKOEE5RHFtRFBoUURhUTl4d2JGcWlTcXdxbUl3TmRpV0Mr?=
 =?utf-8?B?RlN4c2F6Unl0UXduL1pNOTIzY0x4c0hXS1dTakVDSTU5bGpBRUtXcS9Fa3do?=
 =?utf-8?B?TmdpVG5xcWdLUGVPT1RlNkx3Ym4reUIyaEZOR0JUYzlWQnBuUnNqUy9wOHNa?=
 =?utf-8?B?SGN5WFZRTi9Yc0M2cEpvQmNIeEtFb1dLTTF5MmkxWGd0Y0dTQzN5TFY3cFpr?=
 =?utf-8?B?aEhNVTNxYjdpanNxc2N0TjZoNlBLSThqVkNZR2RXbzBVMXZsb1RnMlNESktr?=
 =?utf-8?B?ZlpDdWJrSU5VdHBWTDYyUHZjemZUSS80ODRJZDczRFVmbDUxTEJrYXJOVVF1?=
 =?utf-8?B?ekRrZSsvT2JWb3JKcm9wQ0t3eDFUNS9XVG5rTk9jTEtRTlFrYisvc2h0bjhw?=
 =?utf-8?B?U3hRdUNOVlFtS0xFMUVIMDJ0WUt0M0VNZ2tXMTdqKzZUdGFSUHJrRHFsd1JD?=
 =?utf-8?B?SzJJdFlyaWpEY1NxZDZUN2F2ZDAvMUxybm0yd1FESzBSc0Nsa0dwM1FwSWNZ?=
 =?utf-8?B?UU9uRzBBYTVjMnFNcUNoWUxmUWdEc2ZhSDNFcjdzTTNiMlVUZVd2UEVLd0lD?=
 =?utf-8?B?K0tMVDFTZlBUTU1ydkVhdkxlVGpzblFDUldvOGxXbTRJRjdLZWpFY0Y2T1Nr?=
 =?utf-8?B?WHExdzJWRHhPQlR4VmNNOFUwSDFzNzdjeThsQSt3eUVQbGJkcFYwQWIyYmF1?=
 =?utf-8?B?eTFLanlBdTR4VGVqS1lxbE9XM0haYzRHU3hIUjNGRUEvWXFnTnZZS0ZMWUNW?=
 =?utf-8?B?ak1BcU54WHdGbUErTUFGS2xzbFh3VDF4K3MvSmVNb2dvY2greERTdDJ3ejJM?=
 =?utf-8?B?K1JWSHRwRkxFOUUxZ3d5OXV3TVVCYlViMEdoaDU5QUtHS1pxWThjR2d4Wndx?=
 =?utf-8?B?SUFLMk9oaHZXcjF4cWlPNVNYdW1ub1NqMzJ5UkdaZTI4QkdqbHFyeTRpNCts?=
 =?utf-8?B?dTd6TmFTdU44ZGZiWDBuRzRpQVR3VGYxcmgzYTlaZFNKcWZpVjRIRk5sOTFi?=
 =?utf-8?B?SGdHQ20yMFJhRmtKUlBiUHozVkZ0TStiVFE3aU1IeGZoT3VZSUlmakJXQVZj?=
 =?utf-8?B?V2RseS9LSnhjTUJ5UXZJOStLUE45SVN6aXBpNVRiSGJLNjRNNHp5T1ZQVFll?=
 =?utf-8?B?dXBEVlFUS0l0c1c3U3lHK01JMkptODR5cjZwMGs3NTVhNTVTTVFKRGVNYkdO?=
 =?utf-8?B?KzdIR3FuRWpJajA3WGJzZU96NklRaGlaT0R4UTJrcWlRZ3FkSS9BNC9kM2Zm?=
 =?utf-8?Q?juNaZqbFdIh9LW21VYu9F3eY6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9608c93c-ddbb-4bd9-b253-08dcc00c8577
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB9056.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 05:05:19.4514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2F+AJZoOyE18JO6KFkwncsg8Jzi164Ck/QUUNFXZpEBg2fyzPpDv9IMjWNE9rBWdNlMhY1dMT0LKJZT0B3pQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4273


On 8/12/2024 9:53 AM, Ashish Mhetre wrote:
> External email: Use caution opening links or attachments
>
>
> On 8/6/2024 4:21 PM, Ashish Mhetre wrote:
>> The current __arm_lpae_unmap() function calls dma_sync() on individual
>> PTEs after clearing them. Overall unmap performance can be improved by
>> around 25% for large buffer sizes by combining the syncs for adjacent
>> leaf entries.
>> Optimize the unmap time by clearing all the leaf entries and issuing a
>> single dma_sync() for them.
>> Below is detailed analysis of average unmap latency(in us) with and
>> without this optimization obtained by running dma_map_benchmark for
>> different buffer sizes.
>>
>>               UnMap Latency(us)
>> Size  Without         With            % gain with
>>       optimiztion     optimization    optimization
>>
>> 4KB   3               3               0
>> 8KB   4               3.8             5
>> 16KB  6.1             5.4             11.48
>> 32KB  10.2            8.5             16.67
>> 64KB  18.5            14.9            19.46
>> 128KB 35              27.5            21.43
>> 256KB 67.5            52.2            22.67
>> 512KB 127.9           97.2            24.00
>> 1MB   248.6           187.4           24.62
>> 2MB   65.5            65.5            0
>> 4MB   119.2           119             0.17
>>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>> ---
>> Changes in V2:
>> - Updated the commit message to be imperative.
>> - Fixed ptep at incorrect index getting cleared for non-leaf entries.
>>
>> Changes in V3:
>> - Used loop-local variables and removed redundant function variables.
>> - Added check for zero-sized dma_sync in __arm_lpae_clear_pte().
>> - Merged both patches into this single patch by adding check for a
>>    NULL gather in __arm_lpae_unmap() itself.
>>
>> Changes in V4:
>> - Updated the subject in commit message to correctly reflect the changes
>>    made in this patch.
>> ---
>>   drivers/iommu/io-pgtable-arm.c | 31 +++++++++++++++++--------------
>>   1 file changed, 17 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/iommu/io-pgtable-arm.c 
>> b/drivers/iommu/io-pgtable-arm.c
>> index f5d9fd1f45bf..6fecf3d9fe67 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -274,13 +274,13 @@ static void __arm_lpae_sync_pte(arm_lpae_iopte 
>> *ptep, int num_entries,
>>                                  sizeof(*ptep) * num_entries, 
>> DMA_TO_DEVICE);
>>   }
>>
>> -static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct 
>> io_pgtable_cfg *cfg)
>> +static void __arm_lpae_clear_pte(arm_lpae_iopte *ptep, struct 
>> io_pgtable_cfg *cfg, int num_entries)
>>   {
>> +     for (int i = 0; i < num_entries; i++)
>> +             ptep[i] = 0;
>>
>> -     *ptep = 0;
>> -
>> -     if (!cfg->coherent_walk)
>> -             __arm_lpae_sync_pte(ptep, 1, cfg);
>> +     if (!cfg->coherent_walk && num_entries)
>> +             __arm_lpae_sync_pte(ptep, num_entries, cfg);
>>   }
>>
>>   static size_t __arm_lpae_unmap(struct arm_lpae_io_pgtable *data,
>> @@ -654,26 +654,29 @@ static size_t __arm_lpae_unmap(struct 
>> arm_lpae_io_pgtable *data,
>>               max_entries = ARM_LPAE_PTES_PER_TABLE(data) - 
>> unmap_idx_start;
>>               num_entries = min_t(int, pgcount, max_entries);
>>
>> -             while (i < num_entries) {
>> -                     pte = READ_ONCE(*ptep);
>> +             /* Find and handle non-leaf entries */
>> +             for (i = 0; i < num_entries; i++) {
>> +                     pte = READ_ONCE(ptep[i]);
>>                       if (WARN_ON(!pte))
>>                               break;
>>
>> -                     __arm_lpae_clear_pte(ptep, &iop->cfg);
>> -
>>                       if (!iopte_leaf(pte, lvl, iop->fmt)) {
>> +                             __arm_lpae_clear_pte(&ptep[i], 
>> &iop->cfg, 1);
>> +
>>                               /* Also flush any partial walks */
>>                               io_pgtable_tlb_flush_walk(iop, iova + i 
>> * size, size,
>> ARM_LPAE_GRANULE(data));
>>                               __arm_lpae_free_pgtable(data, lvl + 1, 
>> iopte_deref(pte, data));
>> -                     } else if (!iommu_iotlb_gather_queued(gather)) {
>> -                             io_pgtable_tlb_add_page(iop, gather, 
>> iova + i * size, size);
>>                       }
>> -
>> -                     ptep++;
>> -                     i++;
>>               }
>>
>> +             /* Clear the remaining entries */
>> +             __arm_lpae_clear_pte(ptep, &iop->cfg, i);
>> +
>> +             if (gather && !iommu_iotlb_gather_queued(gather))
>> +                     for (int j = 0; j < i; j++)
>> +                             io_pgtable_tlb_add_page(iop, gather, 
>> iova + j * size, size);
>> +
>>               return i * size;
>>       } else if (iopte_leaf(pte, lvl, iop->fmt)) {
>>               /*
>
> Hi all,
>
> Can you please review this patch and provide feedback?
>
> Thanks,
> Ashish Mhetre
>
>

Hi Will, Joerg,

The patch is reviewed by Robin. If there are no more comments,
can you please see if you can merge it?

Thanks and Regards,
Ashish Mhetre

