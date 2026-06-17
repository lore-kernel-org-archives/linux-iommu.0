Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181FF380FCD
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781684487; cv=fail; b=NVi72ir35eLjCH1wdXfetwopoEDx/0fmmSuLjA1GPHwy4CFCdELkEAoqo0A6FIGw7M4feTQr5UP67mEk/5dp+xnlJn5xDIr+onrean1m3+hhi+3QugbBzKlwbnhAYQkZTo4UMM8iqRAWy2nmJ25c6Qiud+0jh0LF7BgJdNx6j60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781684487; c=relaxed/simple;
	bh=MYmP14nx/Q7AZdT2E3CvsONdIbwVJ3/++NSrVk+ieXA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uunVQdqrIC+nKyevpaG5oJELEsyfC73Vv8bwgy9mgCmGuC6VxeNEFBi+HR1Z+qXgJ4x0dnjoJeRvJ/TEBziavCRmDxMXpG0GXUSnaiGqAAW84Y6cY3g1dVRNjdRSDCjAr5p0bDZ8+gc1GRjIihvahknlya1RY2baoVUuKP1fIPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NKf1aQvV; arc=fail smtp.client-ip=52.101.61.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NKf1aQvV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bronxYYPLz06gshWwPtWQZ4ff3AOySpRVfRErFAa5jhPXviiSXDySMGyMhA40Lb9xlLA4WoMxq+tMbOMUSjqMx/Ukgp1phD8b0LrWGcBzvznlD75cAQE076VR8TBq/zJWZk3HnrrreRt/XXeXZxG/11bqXEwas574BukThIM5NMl2adKRCOPm2nuG4qg1BmIbnKPWvy+ZkkHZuQ6CQkBMGJpQ33hc3I3SR8l6Kck3Iz1oNkQdvElCqBaHRuL0RlGkwG/PWRWiLuSDQTgQZbhNS9ewBNBxYu+pKL8XhTEDcyFmgSed0D2Q3Pl53xYTKSud6y33x0j71Gm1I+h8UOEDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfKG7DT7d65FmAhKzUxOIITksnoWOx05c8whHgTjFJM=;
 b=i1Yhr02ONBek68/so7jD4CKC3NajSRmvQ30j09LUXcsGCj7ubso8VeJ0qnVSwXg6nkVCp1k9Tm2rpz8kX2+Q+pBZCLu12F+txBxHUb0IhKYWb3Nz9fquVElVgCFmp7YIrRhKEmds7BbkMi3KHGuAZ+6QNt4p/gf66PongJ++YqcAI29C/Eq6v+UQuv194yfz+bDkb2swRJoNmMys9VXrJhcJ0/QfF23e81jpqEgUrXOH53dogYdLcKH1DnRksqaLIrV+tUt1MCC+gbAMiK3hv0yjkpwJ/EPZ6SLvGUDIvGKHzrzCLaY2nJ0hYiQOw1xfMWn45ZDSXpmgWnVY1FB1Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfKG7DT7d65FmAhKzUxOIITksnoWOx05c8whHgTjFJM=;
 b=NKf1aQvVgLZlUsLpJdCSRHjrjAncADUVZfBJ9looAPFRuvIcKMuZwcGdtx+3SquZaPvsMJzY7mQ2s/ErNjcFeC/lfwjwtOcuEsPzJe5OOvjyaHqSUyeInSlRDMbMHTJq6zlReiUE6HMIC9P2/xSxKf8+PiJ6UpTTTM+0ftyX0+DUhWJcE3JQmKpmjPVAbTRcmYZzq3egaWSGpkQuwfJAeNLLkvXREOnGNZL/OxCaY2cfzju5QXxinWj41Xrx3CZ6Dw+Hrr/Rz3xt1E4QpDAEloKOIcJAtwLl31o03OPCjCJy10ZRy/jl5gQMIkOK4QR5cRzcVKAFbMXGfepmwaoaWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by SN7PR12MB7881.namprd12.prod.outlook.com (2603:10b6:806:34a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:21:21 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:21:20 +0000
Message-ID: <96959efb-051c-411a-810f-927943d5491d@nvidia.com>
Date: Wed, 17 Jun 2026 09:21:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] iommu/arm-smmu-v3: Tegra264 invalidation
 workaround
To: Nicolin Chen <nicolinc@nvidia.com>, Ashish Mhetre <amhetre@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@ziepe.ca,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20260609073204.1760077-1-amhetre@nvidia.com>
 <97b4dcc7-3ed3-47eb-ac38-51fc2dfb6480@nvidia.com>
 <ajIoc+ek3S1Vycxk@nvidia.com>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <ajIoc+ek3S1Vycxk@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::8) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|SN7PR12MB7881:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f7266b4-9d3b-46db-3433-08decc496949
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|10070799003|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jai/SVbM55Aid6PFZbJdKaEMyDgA2YdoGM6B+Qxvx8Hv4BTxUDuwFn2R8dumgQI1URUH7NIKs1vvq6p/qZ2etQ1L6ZhJ07HI6bO2vBemt53aBKPeHJyEsDhN0u+Aso5Cxgoqm5mu5j2q7Jy/JUwZfCRAa5wfmpeoTygPGkJL4i58dx/QEFsFNvFahgkN7nnXibGvU2A9kT9ndsbpQkLkS0aebUz706wDPg/P1AuVT/CLZmMkpeN4Y5+rP6cPmPL+v296EK9hQIk6WJkCDqfLInEwWxZOynQfl4Aa5E8U3q8Pjsx7XCM2yhSMPWeqOH44xIeEvx16kSywTIdYWGcqyCBcuOl/vjc3hhnPVrCep3hsAjAjtyqYBH0OtsUleJ9DGhdgnbbP3pN9oJmcZTCiarwfIUTRX3HUsXBngIxtJPErJPcgH9UtLFuLbvic8wZsS/TtgPY4qyZUsSVjQX9Hgv7TXn6HRCHL+A16Z+N+PmPCKge2abCtHvGj3z1+OpaXwBsQ6c9UedsE7luq7GEJg01ZVIdOT5k30a5M8OEZUs86kZBhkl1OrQavXlXu0V9EzFLePCTw/PHkbxGQ7kS3UVejqp8FAlx6AmGnUd5Q0piQNLFwLPbZSI4+4R6OAUOlVKTK8JpDc9wxxJAzC2pqrW+g/bmI7D4L9F9UjjO4p61rnQMOXfIBZsscchPfQAonWpgTooLqC/gkqjuGSZocSQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(10070799003)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDFobVovM3RKM2F5anVsZGxEdjNIeDFnR1hqYUxRTStEdmgxVkVrYW1MZFRH?=
 =?utf-8?B?UHRSMEN5NmhtVWcxSS83dVpEQysvS3pmNVhDampQV2R4YVpqVmh1RWx3MFlF?=
 =?utf-8?B?Qmt0M0F0WC90ak41VjNpZStmVTVQMUYzU01mb2EzUkJ1bkxLMDNOUUMzaTJJ?=
 =?utf-8?B?VzYveEVmTGtVWVNia3c2N0x1cExEcTZ1bDJFQ3l0dlBFL3RWN2sxMUljYk9I?=
 =?utf-8?B?N1dpeWkzMkg5Q1ZVMnF2aXVFbXkrNytwS0c3aVlac2NYWTk2bFJwMmw4RkVy?=
 =?utf-8?B?Z3Q3Y2diYnJqbHlpOGYzWXl2dHZSRHE4YW40aWV0TG8zUHhGL0x1ZE5qQ0J1?=
 =?utf-8?B?UjROc0IvTWd1cyt6ajdvYjRYZnJLeVVucjJDN1R6ZjN4ek4rMitsMEp5L2tN?=
 =?utf-8?B?dk5RRms2aHlDdjA5YThCRFBwWWN4RVU2WVlrR0ZUV1VFendKaG1OS25DZjdw?=
 =?utf-8?B?aUJFRytUaUxaWWJoNzh3NzRyQkVJODdwdXpFYjhEUVBmeElwZkhpSHhVSmRY?=
 =?utf-8?B?MjhVUUpOMlZFR2dHUEQycHAxcjhEQzF3VDdjSjM5dFlxVGZWQWo4NFNMbkUx?=
 =?utf-8?B?NXNnajl3UkNYOFl2ZDZMdXZxcVZuUnhyU2l0VnZMWHN4WXRnV2JJNExmZXhV?=
 =?utf-8?B?UG0zZE9ZcjV1ODFrRkFMRSswcWVNN2hxRkRpNjRlSDMwNkNrYVNyVWhzVitx?=
 =?utf-8?B?MHNadkRMQ1RJVi9DaUtOaCs4Nm1aK0MwTEJrSU1SSExtd3QxdHgrd1YrN09a?=
 =?utf-8?B?NThBVmNTNFNrdncwVS9oTjhpaEhNZjl3enZ1bUpsTTd6YmFEb09LYTdaWnEr?=
 =?utf-8?B?eERSS2F3NXlGQzFCT1gzRDF4R25OaXB6cHQ3UDY5Q0dDNUZpNUVNTTlYdzgy?=
 =?utf-8?B?TGsvNzBoa05Fa1AwTGFEL21sWTlSNDVnbU8vLzZvcXNOVjhqZ0lUWDQzdmpj?=
 =?utf-8?B?U2pIYVc2M08wWitFaDAwMkVQblRoWThZQ1Y4emVKTXVZNjNueC96UnF6V0hV?=
 =?utf-8?B?OFRFYldJQTBvNktVMzY1Z3BKR0dGc0wwVlRERVh0dUZ6MUtRWnN3MUt4WEdz?=
 =?utf-8?B?UDhlTmN2UXE2UDVyNExpSHAxYzh0MWFnRFpFdDliRDZVbGN0cTM0WnFBWERj?=
 =?utf-8?B?ck90bG1iTzQzTUdJR3Npa1E3dG5abFNMeDZXYmcrbGRLcnRpTXVkWG1XYUpU?=
 =?utf-8?B?ODNNdmtLVFdJOTNYc2xIOXJ0REM5Q1RnTUdVNmV2N00rdEZ1cW1xdjhuR0lY?=
 =?utf-8?B?NWZIUC84eStRaVY2a0VvMDZyTldIbUZLWVplMzBYbDRhRG1TOHFrQi8yUVBt?=
 =?utf-8?B?TUxBbFY3SFUzckxXK2RBT01xT1JPYTRVaTR3RlVSaXlld3J5eHQ4TVVhNDRt?=
 =?utf-8?B?dllKMTdSMXdScmlYY0VKdlpIemxvbGsyNzd6bmprMENxd0krdGkyOXB3Z0ov?=
 =?utf-8?B?cThWT1NJZ1JxZHhNNXBnRUF2ZE9GVnlzelhPT2VEOHlRZWRzNDR3Wmp2KzlV?=
 =?utf-8?B?ZDlrb1NzbG9FQzdmVnQ5cTRQaFhTRlRsd1o3S3laUTU0R0tWUTNiWVd5YnBu?=
 =?utf-8?B?UitROWFGaHd0UFRqei9iaWVGOTlmNW52TG1ISTEvSmtjUXE1RU91b2hJY2Q1?=
 =?utf-8?B?SmNidEozQmVjYkU0NGhKTExLc2ZReVhDNUZ2OFpVTmYwY0swM3ZrQjdpUmNH?=
 =?utf-8?B?bkc1M2taeGFnSmd2dmt1K3kzdGRYYmdmVjBJTWgvdFhjV3UxZkVTUFFWRHlu?=
 =?utf-8?B?dVFkSUZEdUd1aXEweDNiTXR4b25pZFc0K0ZCbkluSFlGaEpSeFFmM2c1RHhL?=
 =?utf-8?B?Ny80bjZjR2g2UVB4YnJlVmp4RUJQaG5IS29Vak5UdjRlOGR1NUdEMnlhZ3Ju?=
 =?utf-8?B?QkkxNElBMnR6UTF2NDJLVzZsVG1LRFNNcUpWL2FPMjBXUzRGRTdXZXhST1J5?=
 =?utf-8?B?U2g3OGxla1Y4blZDdVFiUXNrVGZsem1xdFlHOGNWZkpGekVCVE1wMXdDQmVY?=
 =?utf-8?B?RDd4LzIwMHZsc2Z6dElBRS9sNzhKUzB6ajF3cUtzaFN5WHNFcnZIUDBkNm4w?=
 =?utf-8?B?M290YmZmMkh6a09qNTIxL3FRb0ZyRGFwSnpqSnFFOVNHdjhlSGxsWUlZTzht?=
 =?utf-8?B?MUE0SlJockxZUGJjRnpLSHYxUjdpQmc2VU5jSW1IUDVMVGFzZ1lSUUsybGIv?=
 =?utf-8?B?VXFOemd5VTNnVzAzSFRWZ1lRQWRjRUNmMWxvdi9pejRzK0xld2NFdGQvM3c5?=
 =?utf-8?B?a1RiTnd5YmFiSmYwdHdlNTVYKzRYVk1YWC84L0FKU1F0SVBHa1RFWGZZRmxp?=
 =?utf-8?B?U3psUEtmdDQ1VWxjSUtoT2huVlNLckRyRFJIZmZZSWRzaEtBb2VBTmxHR05G?=
 =?utf-8?Q?XRJq839zsTcEOghi49BxrQ27+mh9RPnfQXjz12Rr/hTYn?=
X-MS-Exchange-AntiSpam-MessageData-1: GOMeniGzzJb5bw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7266b4-9d3b-46db-3433-08decc496949
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:21:20.6556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQQzNtmptC1C7VMV9EfpVFKdYPCUBX2PH+TC1yffNjKuNX0nRwnrqm6WbPSzBgxthP10eTg5WmOb/VzNupf3tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7881


On 17/06/2026 05:54, Nicolin Chen wrote:
> On Wed, Jun 17, 2026 at 09:28:10AM +0530, Ashish Mhetre wrote:
>> On 6/9/2026 1:02 PM, Ashish Mhetre wrote:
>> Hi all,
>>
>> A gentle reminder to review the patches and share your comments.
> 
> https://docs.kernel.org/process/maintainer-tip.html
> 
> "
> 4.2.9 Merge window
> 
> Please do not expect patches to be reviewed or merged by tip
> maintainers around or during the merge window. The trees are closed
> to all but urgent fixes during this time. They reopen once the merge
> window closes and a new -rc1 kernel has been released.
> "
> 
> I would wait for rc1 to rebase and respin.

Assuming that they need to be rebased. If they apply cleanly to -next 
after -rc1 is out, then there is no need to rebase. However, definitely 
check.

Jon

-- 
nvpublic

