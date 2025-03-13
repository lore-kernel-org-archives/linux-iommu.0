Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D182E3395
	for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 05:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741844523; cv=fail; b=t9jmxKZPheWHviDIrugLKRn98Ixv/uCVgQOXcTg08ocbAeAymynCwBDn82hK+6m4748wR9fGj06j3zHSKpJ3pTQBLkg3TD9QR1SG55qYALmFYHtLiKjJ0Z3TksIaEqH8tzvXmDrJAsHiFOF+qq1wbFCQrzWNqrVVZxT9AnFbAvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741844523; c=relaxed/simple;
	bh=VfH2mnOuIYql3UjvRr7Aq8tWJtuUfg6enfxMu4V0JCw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kf0kbfFaq5YD8KyuLBnRjP+y4+/1/bmUp2ZStShR8Vollq6Cyj3GqwOVhnuPECFqt3JzzOLK9RQx2k5q5eDZF/sZz4VJHHcMgM4hpt8/XNBX57Uxa3azk/2SU5S9aeYOrPl8C9aqYhRkIwt2gmMfTQrZ6Hv021aSESIzXtGyqWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BVvXFbVY; arc=fail smtp.client-ip=40.107.100.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BVvXFbVY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWiEqZY2am+JGsgLksLmDS2GBATLjMWA+ou1sjsfz+98cZ5noTO/lnyKoE5u8WrthP1ugz8u81+W7MsW9yqi0G03+GMJSOgXZLk1KwI5qc9wCN7vcWhrUAeEgmGej/2WM9a76jJ6Z9csyFYwrhNAfhVotlir9Ln8jWBs9lc5GHTRhpQG03rFog6VhZ9r0D66HzIXyklz4fnrZE9Zid+oEVnAwyFqOhcBgFPEy7qgRGDQzEQm5Mzw9/T6hU5obwuyET9F/oRdbjyB0GgPKSyEHbh0MX3UvnIkwwpUbXOpc3qyYUbv+1pyB/LkX2lRCrEPzftn+PHolKdB0IUsCrasMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMREqKCJNs0Tr8MOEa8Ok0vQZ4qOsid+0HJJPs9d/94=;
 b=xEi+T7bhKLmjTNkjTR92Tbjcdq3NMJtOsxoBBvs3kKlFl4EOuJ93lHpWZGzJszgTDcC+6ENGA4af+jXRB+fi/AdbHV0X8OYzrPxdhdV2pgvIVgf1xuWhe2ghnIX3nu+JIL3dF8qbTBTY9JKDfzcQQKS3v+u4LS+N4+OqRT5L+PMHzyouxGsIfchIzDRJrBm/aUHQTWgJ0uLppPheUdJ2BLvZgiQV71nqpU/8aW+abKExqi8FabEO9rBiVM7P+gENUogEQWjus35PgVhi135ezI5/Rff3nbtf8og4i22K9Vez8EpORs0CYqei6pr4/4vSBIEUx4evmei61QU+fN+Y5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMREqKCJNs0Tr8MOEa8Ok0vQZ4qOsid+0HJJPs9d/94=;
 b=BVvXFbVYAppXPV/1nJG3OWvtmiS3Fj8/r0AIVaxFi3Ux2xf2Lz+4cOoVmNaP0OvfGA34CTGmHwOuzA5+6dSd5vinS5hTQJnjol0QQaKG1IhVczDRrniCMQVa0j5aRPMzNoI2BfTVI9vev2JPeCI27x3/0VDJbRGfr8GMYJ1DfZc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ0PR12MB8616.namprd12.prod.outlook.com (2603:10b6:a03:485::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 05:41:58 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 05:41:58 +0000
Message-ID: <432bf54b-d0f0-4640-9afa-6df363bbe9d8@amd.com>
Date: Thu, 13 Mar 2025 11:11:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] iommu/amd: Enable support for up to 2K interrupts per
To: Sairaj Kodilkar <sarunkod@amd.com>, joro@8bytes.org, iommu@lists.linux.dev
Cc: suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com
References: <20250307095822.2274-1-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250307095822.2274-1-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0096.apcprd03.prod.outlook.com
 (2603:1096:4:7c::24) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ0PR12MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a4682cb-ec74-41eb-97b7-08dd61f1c54b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czlsNGc2VDU3RTA2UVpTR0lDZSs1ZHVXS01kSDRjcGlRV0t4RWVEOXlReEhq?=
 =?utf-8?B?L1FNeVV2SkxQVEozbXBCVWlreTdERW5QaFZVc01xRlVGY1RienNxTnhJU0FK?=
 =?utf-8?B?MEJ4em8wQVpuMlRzcVcyU3YwR1hIMmFldU9ab3I0UW54TEtSNVFPdGJ2b3FM?=
 =?utf-8?B?OHJkRXdseFFkYTd5NWZZQWQ2d2hsZ0hUZG02SVhOa2E2eGdUdmhDUTlrU3FF?=
 =?utf-8?B?MStWdFBwaWpHRXF4M1o3ZkNhcm9kUG1mcVh2a2hrdkd1TGRtbm1DNzJ0THBK?=
 =?utf-8?B?aUMyOHZOZEt4VW1KVy9uSXhnSXdHQ3k2V21JV0NrUTI4VEZDeXl5V1kvZ3Z0?=
 =?utf-8?B?Q3FUWnV3eGpVaUJSK3pocVpIRTNDdXFkMlhJa3JtSnZCZHZsRlppODA4b1oz?=
 =?utf-8?B?ODUxNmgxRjRHQmIxZE84cVl6ZEpPZWlZbVdBUEplcUdhZTVYcU5GVE9FYU5E?=
 =?utf-8?B?VENqQkRSa2hYV0txVjd4dG9sQ2I3UVJscDY2RWlRRzVqcndCWFkzbzFJTEZm?=
 =?utf-8?B?cFhySFRKZGdMbTZqdzN3MTFWdVdYR2pPc2FwYWdNNkNyVVlKV3ovdHljdDdG?=
 =?utf-8?B?RitxWTVlRmgybXk3OUNYdGFFVnk5RUNCWVZMSUhKWjdvWWlJb29TYTVqVTFK?=
 =?utf-8?B?M2Rzb1dIdXJaekw1SHByTGZva3NhVVRFNEJib3VERzQvNno1L2pLcENsdlgy?=
 =?utf-8?B?SjQzSVRHQ2hEV1RVNXpFblNkRUFkM3NwbUJ3emVNbHRYcGNFS0MyZ0VCZi94?=
 =?utf-8?B?VnVKOVk0OHlsUUo1TW5XSFprWlIwVXJ0Y2ZtREJaTTRNN05xYy9DYXhvV21w?=
 =?utf-8?B?SFh3a01Lclo1b29FeGVHMFNvRUZHNENQZS8xbFViL3plSXplcUJJMWNLNzl3?=
 =?utf-8?B?ZjZXNU55Y1VqeGFpTkFxaUVmb2k0T0psRExBNElBZDlKSjQ2RlpqRFFHR2hJ?=
 =?utf-8?B?c0FoU3JGYTZNb2VnRnR4SnRaallwVGNKR0dKYVFsR2tMS1BueEtBZWF0akFq?=
 =?utf-8?B?QUoySUFCZUVpTVRzVTRkeWwxSWZkRk1pb3Zpa3p0aDlYS0c4OHVEN1pEc0N6?=
 =?utf-8?B?NzhWU210aENKNzFpRVJJTm0yMjZQS3FtcGlqbzdjNzhWaHNwdXNFaFRyTlNt?=
 =?utf-8?B?UWhTTy9RR0NKVldaUG9OMGdPWEw1bWdaMGhJZHNjOTNGR2RrQ2xBaXV6aUFn?=
 =?utf-8?B?VTVBdDh0Y08yektJSnFLa3I5Q3JzaVQ2WHV3L1QrVzVFU0tJRXBtQXkxbFVE?=
 =?utf-8?B?SkJPdXU0NjBUOUVrSm90Z25Zd2pUNlErdzdQaUpsU0kzem9UeTBOK0R5Ny9W?=
 =?utf-8?B?eElpYkl3QW1LRmk5d1p4a1lDdVJPazY1STBJalRndnd1V1BMd25Ic1NTUGFT?=
 =?utf-8?B?RG5GdWhmT2w2cU1vTHJpYkJkNG5QbjVodjZiU2dTZkxFS2tWbnBaS01RUDlw?=
 =?utf-8?B?bWJGYVp0MS9XcTRWY1NlVkNrYmppcEhYVXEyVExIU3lsYkVxaUJaTUcxMHNP?=
 =?utf-8?B?VDFqMnY2NjE4V29seEJvUlNKWjNHLzUwYkFNdlMyamQ0OUEvZ3ZxM21jV00z?=
 =?utf-8?B?TnZCKzlkS21udnZCdGlVUGlPSHN2NjFQT0FCdWVCb1hvRmoyUFgyczdMcTlw?=
 =?utf-8?B?SlhLc3NDNzBCV3M1bGl4d3RTaHVKb3hUZUFyb201M2V3UTYxTjB6cFRUTDhV?=
 =?utf-8?B?dm05VUgreFcraXpuSXZLVU5pbFlCQW81eVk2Mzl4Uk4xaTlaYXVGaGNOQXE0?=
 =?utf-8?B?d21UZDQyOUVtS1JWcys3Ulh4ZVdZd3lHTEtlN1poK08zaFZ2YWZXdzB6M28y?=
 =?utf-8?B?TGhQMGhyanRCN0NXZnYvbUIxY2J5MkRYc0YrUVZORFp3dnRwODNDV1Q4S0lV?=
 =?utf-8?Q?2aigoVZsAbTwX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0MyajVvc21UaHJxZFozSk1wMGJ5UHNXZGYvZXVpQmJ5Z3dHeGlROUNtd0du?=
 =?utf-8?B?c2pIdVQ4alZoSnROU3FvZGY3c2RpM3IxLzNkNDQzY3ZzU0s3UmlYMWpsOExr?=
 =?utf-8?B?K0lTb3Q5bGNFWkNFVmpzT24vak1MQ09mYlp0YlR0WEZZWm9LcDN3czBYcmtN?=
 =?utf-8?B?cmdsa1FiYzJpaDEvRGl2V0I1SzZGem5iUlZlOTNCaG4vQ0U2YnlwSXZ2bFBW?=
 =?utf-8?B?d3pYTTFSOVBYZmNkcmlXYjE1bHF1MDN1endyK1Vidll1b1VzbFpvWmFSdm51?=
 =?utf-8?B?TzhDUXVOMHRteEt3S0dyUFZoSnlhT3YreVBuSGZzVWlXanp0bldnVWlSSlFx?=
 =?utf-8?B?UFNDOXlaQWFRbUpxQUhxS3BRUGsrUEw2UkZUbWpYQXAxck0xaWIzd0o5b1N2?=
 =?utf-8?B?a2ZNVURHZVRLQkcrRzd3YkxPRE5Oa0xmNnAyd0tXZzROTk9mYkZ4YlpLNTlr?=
 =?utf-8?B?eXM0N21GL1h6S3MveFpqeW5VOVMxakVCaUdTVTJvK1lSSHI0NXIxZUR2aFkr?=
 =?utf-8?B?SVpzbTRZWWlvZ0d3VytxaEJidnFabWtCTXlVbmlPSElCcWVKT29Sb2lJS2xl?=
 =?utf-8?B?WCt0L1pQTTJxNWlCSktDN0wrYWhVdFJOcGdrSlhncVZ2bEc4ck1NMFR0dHVu?=
 =?utf-8?B?ekgvN2l4anh6WkI5djBJM3U0VnlqZzFra25CeGJvTVoyMStqRHNLWVUyUXNm?=
 =?utf-8?B?TEx6aEM1ZnVVZnY4UUJwY0xhZlBEMzVlUXRxSVhYWUlBZ1NqZ1gzSGZmQWRM?=
 =?utf-8?B?Ykk0aVB3UVZEcG1nSHBRcmxsa2tncVBaN0J0U1V6VTc4SXJnWWttOG9zRTRN?=
 =?utf-8?B?c0IrWnJ4Y1QyZ2FGdEFrWGxvM2F5Ym0rV3Mra0JETGRtaEVmYVFBUHF5TkhM?=
 =?utf-8?B?akd5NHhaWG1VbXM5OGtjYlVxV25DWlR6aUR3ck8xL25jeWJNYk9KcmlBeDdq?=
 =?utf-8?B?TXIzNVlYd0lPRVVsc2JMcUx2eUlwQ3lSTDdhS1dPK2Y1S1h6VWp4cjZTYlVt?=
 =?utf-8?B?T0RoYTJSb2hmbEhGemYxS0ZPbGNJbUN2aEdlZU5kK3dWSFVYYlpsZ0ZRRHpy?=
 =?utf-8?B?ZDFMb1VxQ2FuTFFEUkRuKzJmd3AzU3VqUDhqcTlzUE9FOW80anRRaXRKRnBZ?=
 =?utf-8?B?TUIvUGRqbituSFJmdjUwNjM0VkhnQlhmTGVkNjFsYy9CRzRtM3JqNkE0WXJW?=
 =?utf-8?B?Rjc5Y01IOHJpYkhKTWlheEVGaXJnOGlUTkdKQ05RZWVXeUIzRFMrdkw4eGFB?=
 =?utf-8?B?QndyYi9PdkVpNGJLamM5TFZFenY5YkxtandyVUM2R2phalI0amo4UGJuT2Rm?=
 =?utf-8?B?M01OT0hNbmdlWTFpWXlqQ2NzVXIvNnp6MTQyUHZNOU9xU3h2SERPUElWMzRl?=
 =?utf-8?B?QUpIcFZGREZxTTE2TG5ZZHNKVDRYdURKSUhkZXo2VDZUYm50QW43YVRyMUNX?=
 =?utf-8?B?VGlWYUI4aW4zWGx1bVAzK0pvSnRMaWlldWZXSEZDMjVCNFZ0UTQxQVlKOHpv?=
 =?utf-8?B?Zmhvam51eFFaVG10d25aTXdDOEkyU3RNSFNjUGEyNi9wZjA2WTB4aGQxVzh2?=
 =?utf-8?B?SUVweXI5RFA4K3lodVBPWE11ZlpadkprRU16SGl2b3R3R2RLU090WXd6YnpY?=
 =?utf-8?B?ZVdQWVc0RmZ1Vmw0UExPMExKc24vS3h6UmtieEpTTTlDdjRzNzhidXdtQ0Y3?=
 =?utf-8?B?cUQ1ejRKeVN3ME0ySnQzTEgrSkdJTnpQaGs2dlZmdEw1Q2cyNEVvRldkTk1a?=
 =?utf-8?B?Nm9PVG5lSkV1VmR6T25TT1BFYUpRaE13RFBkK3pwMFhrUlBocE94U2lTTita?=
 =?utf-8?B?cVhUQm82WE4zQUU3RDc3UVBHVUpVbGRzb0ZEdURwZXp0OHhpSVMvS09HVWxR?=
 =?utf-8?B?UXB2UVZCbzdCY29xVERuZ3VuSThsdWtSODkzL3haWTZuTFM4eHNMdGw5VFFP?=
 =?utf-8?B?RUJLUFRtV2NUbjVkSWpyV0FvTiswcFc4NkhOaVdSRW1lV0cwYWFKL3FWaFor?=
 =?utf-8?B?elZxWTlSQytQcHFLaks1em1HUUt0NjlLL3g0OEpxOWtUY21ac2IrZWxTQWgw?=
 =?utf-8?B?QjVLN1BMc0RsdUgrWW8rQVpKNUx2VnR6VnN4cE1abFB3Q05PTWNTOWFINWdp?=
 =?utf-8?Q?aKDeqAmuAVwaoYq6y22lGlRL9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a4682cb-ec74-41eb-97b7-08dd61f1c54b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 05:41:58.5068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4Vzxi7VdglTPi34WwJzcoCDJa41hif+wpTkU8n2Ibi7vKy/hwC715AM2tWotIZL/XqojtOpRathcZSU+fpNbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8616



On 3/7/2025 3:28 PM, Sairaj Kodilkar wrote:
> Newer versions of the AMD platform can support up to 2K interrupts per
> function. This support can be enabled via field NumIntRemapMode in IOMMU
> control register (MMIO offset 0x0018).
> 
> This series adds support to enable 2K interrupts per function on top of
> v6.14-rc5.

I have reviewed/tested this series. It looks good to me.

For entire series :

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>


-Vasant

