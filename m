Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13923019A2
	for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760126287; cv=fail; b=TSVLH2Bwo7kEX32rBqDoQyhGmI1qTFdVy40dqOnkpgFr+TOF06T6t5P6GE3bcQirVXBnxvSEfs53ve8Vk5EWFvdeL72enpfY9NN5+6T/J2BxeyCzH4Zd9gnUN2wc9hlsV/qyo6RywRl4uQ3Nix5OFkpPbpWexgZMdldzc8+Odo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760126287; c=relaxed/simple;
	bh=FOAVZwyPiSOEQy8ONjiEDUvg17cruY/++c7eKJ919I4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eQOJJKaEdcDNcAqSIiNXIGiB4ed0rivvXthZQng7ASUoOi0BS7mamlOqaG/2cTYKJ7ZREkwDxsj2Jb6tD3uwZ3+cgyAlAIUn2Ah0MlfRS9kojBQacY0r0ZsS8lTHGlxRHl7PwfT/m257OSUncf1cF3J94n2R4fzXZT4J6Fql2VU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mE/4No5c; arc=fail smtp.client-ip=52.101.61.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mE/4No5c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fm6QwENI+5rTlIQKq8FqKwxZva1meFj9fEgo1MZ8VWwPsK0IXI2erDqTC4EW1JwaDFVuTmK7bqnvIXt7lr1xN+KDy5eIgQn+aUWfK+Xe9+aOeNHO/zDs35gTO9vAMwBQA6aukSVkp3rtdxoKJez/d9WywIL1NEWZM+5SDf1Sa/TdJElcSo78FAfJScB03bL4Ka0qM1ik/cCrhAE3l4ODWZhlZnkGrF98QTRWnFgCQXtMxx2jyfe7HZWCW/g8SHjkhxck3GnjnhtS3uATp83z305Ghhk5cbovT7OLwMTfnT0OmVKw0X8vvdRc0N02ikQRLmH0E85LMtMoitgHc/xzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmalEKPCvda2xUJLYOxMBZ03AAx5LhcRWBLovA6Lnb4=;
 b=rb2NBfMDQ682tyHUwmswfNVITrE4uF6KdjYsKBoYxiCA5dvaW/yHp/SLilzCEU6uk884z2BmIMoV+vhSugdrGN3JWrO+ik8+AA/ouXZhQFNnaMaRTO2sN9OVvWuGmP7wN3m1h1vWSB8qXoqM6TdK7EhWpW2PXc9PHXifjVmAj1hoiwhZI4vc/ASklv1I64aFDEWyksc7jJ7YE4OoJLWpOLTsysp9JvWCCn8ABAF4pzCyCyGbMmSCmHfYYMW6Az4Cx1sq1Ftt3/8W/HSHOw1yltrFazQLhrV9dpHs2BaK4a+zCKjoduSPQ0VV8wP76ToT9uKErPq783lxvA0ra8DXoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmalEKPCvda2xUJLYOxMBZ03AAx5LhcRWBLovA6Lnb4=;
 b=mE/4No5cfa1njS5Y16i1ExcTNO6WOMYdEdbpZRKq5kn3L+79PiwEkWHzh2nnBBEbwAdVZ9xOkpltyT3Bie1NOWOiu0CCZO6O3evFrkJ0VTj+4yMNqcU0wOmfvGIo1rjTW/dZ5/cLPyQzLGF6VRVHw8AKtJpk4pOX5u9POG6f1Y0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 IA1PR12MB7517.namprd12.prod.outlook.com (2603:10b6:208:41a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:58:02 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%6]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:58:01 +0000
Message-ID: <12e27a8a-3fea-4d33-b0a5-4ef0b38a28b7@amd.com>
Date: Fri, 10 Oct 2025 14:57:59 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Enable PCIe ACS only if AMD IOMMU is on
Content-Language: en-US
To: Jinhui Guo <guojinhui.liam@bytedance.com>, joro@8bytes.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250928075257.1542-1-guojinhui.liam@bytedance.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20250928075257.1542-1-guojinhui.liam@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0059.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::11) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|IA1PR12MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: fe2657a9-c8fd-42b9-1b08-08de0837518d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVlkUmJMT3F1WEJLNGNMN1pIOVlMWmgzWjRlVlB1b0huZWRtQjh3N3RJVXQ2?=
 =?utf-8?B?WjJibU1IbE9LL1lOQUdIRTQ5NVdNb0VaN2JoSW45d0NMLzN3U1pIUFFMbmMr?=
 =?utf-8?B?Ynh2V0FJbGQ1ZThBKysxSWw5SlUvTWl2dGlTL21VcXJDR1dPZVJhWmd4Q2tE?=
 =?utf-8?B?bkd5dEt0RFpzc2J6OTd0OGQwbE5FVldIV1l2cCt0THpVd3l1R2J4R0RHRHdZ?=
 =?utf-8?B?R1FtNnViN0V0U3FJeERZaHFJeGt0aHc1Vi9rRmloajYyUllreGJkQVFQWFl4?=
 =?utf-8?B?NGdCSkVsZmp0L0VCSzVwNzMraXBISVRBVGNnV1lzRUdiSzNqVWlNQzFybVZu?=
 =?utf-8?B?bjM4OWxlYk80MmRpc0t2dDVOUjU1SCtlMEJycEhOSTdlNkgxaUZkVTJ3M2d3?=
 =?utf-8?B?c1Izd2RjMjF6VEY4bmhCNFZRR09keFU4cjBPNFVNeUdYdzgxaHBUVlNsd0Z1?=
 =?utf-8?B?Rko2RllXZUdrVXdaR0xaYmlzTVlkSzFldUhqL2kwTjgwSXVsbGpWOVdSSDVK?=
 =?utf-8?B?T1lrZ2l3WW5NYkNGMUVSN0hrdzFVc3J4RXN3dVFWT0FFbFFYQm1GQ1ZXdENi?=
 =?utf-8?B?a0Y3cTkzbzRyb0R0Y3VpK0t3dVEwQThOdWFUcnJLdG4zclhKdno5VVVKSENU?=
 =?utf-8?B?bkhCSks3QnUyb3IyMUt1OS9ValpDSStnSEpGeUpxNTFMZ1hqTjRLSWNQNXU1?=
 =?utf-8?B?SVYxT1FNODZkSEVxUy8zVEpKNjZNd3lTbk5LVmdmdE5DcUtjd1gxOHJEUnVi?=
 =?utf-8?B?QWFyVGM5K0ZKSmpEVWwwRGxnQmFZRkxpOXhkbm80NkpJeXZETjQrVUVxSmlB?=
 =?utf-8?B?Q0R1eXZtRVdhbjdKN0NrRzdhaDkyNmNtaC9BVW8xb1V0ZjBJdjZTYWpDcHBR?=
 =?utf-8?B?RnV0OWM1VDRVS2NydzdhZUltSU5vVU16SzV6dHdGZTNpMVFibFhxMXhoY0RY?=
 =?utf-8?B?bklrT0JXVE5NKzRMT21JRXdjNm1kaUd5V0loeG5DYXFWbDE5VDJ6NVhET3Ju?=
 =?utf-8?B?L3Z5S1A0TnRKaXlyaC8xeVkyOGlwNm14bHVqK3RUeFZSYlc1Qk40L0p0QnBq?=
 =?utf-8?B?aEpjQ3JVQ29YREozZC9sTGlDbGkxUkwrenZLTEkzUDVGcG00VnVYcVZ3aDl6?=
 =?utf-8?B?RFczMEZ5RStnRUg0TDI2eGcyd3NVcXppSjU4MDJCdGYyZzFKdUxudWY3YWJB?=
 =?utf-8?B?YUg0YitCa0dPaTBBVVA1K2NQZFlReWF5UXNMTFRwTVBwTkhHc2Exb2REam1V?=
 =?utf-8?B?QUJoVjF2RUdpNFJLRkNzZUNOOXM2QnpyQzVZemdkcWhsV2l3Zk5qcmRXUmFs?=
 =?utf-8?B?VzZnV082aGZyQ1FuYjNkclFsSDVFUkZCbHlySVM2MzFIMFJ2MTVNNExsVDZU?=
 =?utf-8?B?OURuMjliU1hsejJLU0VmMXZBY09abExZYXIrcHB5Z0IvZmgxL0k0OW54bDRZ?=
 =?utf-8?B?bHlmdGtVT2wxMy9hcmNLWWZ3eDM5Q1Y2emtlY3o3Vms1VHRWemV0azFaNm9h?=
 =?utf-8?B?M2JHRmZ5VUg0SzVFc01wcnBReTduZGE1WEQwcCthTEt6cFZMd2dpN0EyL2NI?=
 =?utf-8?B?eWhCM0lKWFRQWVhTdWpJaGNXMmQ3TlNjVndubHpTK2FwSGVxSjNFVjVTWXpW?=
 =?utf-8?B?L01qVUYyT29OZW5pMDRTQUR2L3A4aEhVRmpVMkxpVDdGRS9uSVdVcGZlNVkz?=
 =?utf-8?B?S0RoVENkcTRna1dPUHRnaUp6MG54TmhibXc1bmFmdERqTUZJbDRabEx5ZUw3?=
 =?utf-8?B?QmtzVHVmdjJqRzQ3WTZ3eUcwN0FJZXI1YnV6eVhtUGFVOFRaRmNXZWt1RnlY?=
 =?utf-8?B?TlpKSUlndGlTOEVWV2Q5Z3dXcTg0dFpRRHd6MUtkYmVtRFpmaUpUUmJ6eWd6?=
 =?utf-8?B?WWFWNGRnM1U4dGtHd2x0WkRWczBCVzlTOGZrVUg4cDhmaUJDalpSeHk4ZGI1?=
 =?utf-8?Q?Y93UZZZb1qDRILXAdX2BHV/wYh13hXwG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkhFVE1udyt3Y1R4TkJoZDdIVlNwUUpvMTJTRzB6MTYrNURXc3Z1WWJuRjNF?=
 =?utf-8?B?QWt0dkFoRFczYXFNT0h2ZVVDSWRJdEpxN3kzYUVaN1E3em1BL2w1SnUwSWRm?=
 =?utf-8?B?MFpKK2dnNktIUy90Mjc5TUFhRktEWXg5YWgvYkpPWTBIYUMyY2N3WHc1MDhY?=
 =?utf-8?B?YVlxZ3VnNm42czJVdGdEUVlMODJmTkEweU1TaHBkNXZJd093ZmxWL0FsYXNw?=
 =?utf-8?B?ek9LUUVHanJRbVJWVFRSSFI0bG5zbFBlaGRmQXEybXJxQzYxTjJSWW5LcWtO?=
 =?utf-8?B?SmtveC9DRU51ZkJCTG1oNThlQStIT2JGM0JuRHBQazJnZUkwRTdSY0hVS3hl?=
 =?utf-8?B?VWFXUFhiMVZWL2ZIODd5UXpiQmZYR2NsaEtTNThORzQ5Um00cU8wbkswbTJx?=
 =?utf-8?B?NmxPb21RcUx3VE1MajJEWmR1YnlXRjh5dllHSUZzMXlPRnNzTEVwQU5naC80?=
 =?utf-8?B?VDZqWXp2MnFXdXA1d0tqK2ZIMFFIa0NBcVRnWG5NNVcxVG1WRU1vZitDaHFh?=
 =?utf-8?B?Vk8yWmJRbmNvM3o0RkRmb0lOcVRsT2Y1VHBhaE8vZ2I1UFM3Q1N5cm9vazBp?=
 =?utf-8?B?cGlEMEVJcWJCSXlSV2hLWEZ6OGtnNGNWY0szMU5WY1JXdkNaRGFjZFpSYnhk?=
 =?utf-8?B?NHhBWUxvNk9ZU0FxbkZsN2lEZldMdTRmWjRIM0VKaXo5UnJOck1LWmdaZ2Nw?=
 =?utf-8?B?ejVhelh0QmdoMjhmWVR4ZnlqMVYwNnRITnNiTXdQV3krTmxkSmc5VUxJR21X?=
 =?utf-8?B?MWp0YktwWmNtdWw3M3ppTmpVY1Q5dnV0TDIwdlBqUWE0OXNOU1RkdU11b2FT?=
 =?utf-8?B?VC9HM1R3ZEoycHhyU2VSbmVnbDkySks0R2tEdlNHankvcjF2NWZYTFdlQXdi?=
 =?utf-8?B?RE1MMFZvMmNneTlzSFZXaGEvNUc2V2NERzRMcFJQbFViQjJ3QkI4a3BhcUtF?=
 =?utf-8?B?bWFsQytma3kxOW1GMk5jTWc2SXd1VklvMU9zbzNoMk0zWlBaM2xUYVlFaStE?=
 =?utf-8?B?emJxdEMzUGRrdzFqNmNnVWVqdnF1QVB1eG1NOVJyL2hSQmxkVkxQWEZFcUls?=
 =?utf-8?B?bTl2K2VMZ3dQS2dVdWJvY2N6eGJFUklJQjlBdTV6QUNPOUtoRUx6NzFudUpr?=
 =?utf-8?B?bGRkN1FlQWxsY1BYYjdad0IwYUJMd2VPL00wZmprall3elRXMHhQV1JaRmVx?=
 =?utf-8?B?NExZYzB4ajRpMjBEZTQwZFZRYkdnUjl6WjhReU4rOTVMWis4dVNGekRlem1q?=
 =?utf-8?B?a2UrUXB3NzM5WGNRV2JOLzhVUzR2WHc3TU9KaUV2dng0NU9ucjA4SithTzN2?=
 =?utf-8?B?Wng4RC8zR1RmUWcrTXlYU3lmaGhGZWdNNnFUMmJPMFU3NGI4dUhRMnFyQm9r?=
 =?utf-8?B?RjdHbWx0cmZhU3VMZXFoYkJCNTAxK0pUZnJ5ZE5hNmhWUmM3MkhtcGgraW04?=
 =?utf-8?B?VEN2c2lFODFBM0hYQjBtejhhZDRteUZ1cXQwTkE5UUkzcWc1WjJEYTJWVTRa?=
 =?utf-8?B?SlpxbWluenMxQ1ptVDdQbytlbjA4d3RKeW9TNElBaS9uTXJ0NnRDK1MvMkFE?=
 =?utf-8?B?dHllZldZRmZESkIvaUFWV2N3aFI4Vkd0OE44dHM5dWV1TEVGUEVqZDh2Ulp0?=
 =?utf-8?B?SFhBbElqUDBhbVJkbXVDanZJTmE5MVFGZ1NIWG9FaWVyamlLeDNsTmoyV3Yv?=
 =?utf-8?B?dkIyMFdnaDhXM3RqT01ER0FyWVZWSnRvd0I3ZDhiZUFpdGE5L0pXNlc1aGIv?=
 =?utf-8?B?MTlMNTE1S2VzNEVLUFRCUXdLR1NsSXV6RXZ5Rk9xTm91Y2tLZmwzUUtIeWJZ?=
 =?utf-8?B?WExmZGc4QWk5QU1KdUdYSDgwMy9KcHpTZHRYQU1KRWlNTFFLSU5lN2YzVDdE?=
 =?utf-8?B?NElEdTVhRmkwdmdRdG5zQktWWitRWGhNR2JGM08wM0NJNDdIQkpVL3dDdmRB?=
 =?utf-8?B?S1BhTlVRQkZSNWtTdmZ0MGVyNEEwNHRTeWRqK3JTTlFrM3Ztb2FJdkZuNU5y?=
 =?utf-8?B?TXNPWVJRblRwSEFTbzlxYlhzeXZpckQ3YVRNcW05WmFlNzlVL0tkb3FvUzJt?=
 =?utf-8?B?MmI1WkNzSTNnMzV6cy9jaTRXK2I1MGxLZTNHSURxV0kvZGUxOFA1d3ZMZmNR?=
 =?utf-8?Q?OfoC7iryMPmoHbVIuScnQhoBi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2657a9-c8fd-42b9-1b08-08de0837518d
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:58:01.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJu33G2i9hCBqq6qJ8Srj3XlbDyaU8LwOIdtL26X6X3kacbZ3+rSf+0SkoI4t2tol02ZdhWWtSNlcvOjEm7tAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7517



On 9/28/2025 2:52 AM, Jinhui Guo wrote:
> To preserve PCIe performance, ACS is enabled only when
> AMD IOMMU is not disabled.
> 
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> ---
>   drivers/iommu/amd/init.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index ba9e582a8bbe..6e9eab365123 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3212,8 +3212,10 @@ static bool __init detect_ivrs(void)
>   	}
>   
>   out:
> -	/* Make sure ACS will be enabled during PCI probe */
> -	pci_request_acs();
> +	if (!amd_iommu_disabled || amd_iommu_force_enable) {

You should not need to check the amd_iommu_force_enable since it is used 
only to skip a workaround logic within the same function. You can simply 
just do

	if (!amd_iommu_disabled)
		/* Make sure ACS will be enabled during PCI probe */
		pci_request_acs();

With that

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Thanks,
Suravee

> +		/* Make sure ACS will be enabled during PCI probe */
> +		pci_request_acs();
> +	}
>   
>   	return true;
>   }
