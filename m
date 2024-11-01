Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FEE3EA98
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730473381; cv=fail; b=f6lFUzmxEFLUydMZy3Xvl7YxeDECh3ZCBDFP+MkhvTeUcY7LAWuU+WDLP2Rz0IwvbNIvc42Qd2d4sF1aDI11cfSfw7sDSjPcQfBHLbn1YS6FVXX2obUqN08VacOY4T1AG6uADiFRvaG7hU3c5YJSoiaBF7xuX5BlZpcvLuzz1LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730473381; c=relaxed/simple;
	bh=nA+tVPh6G2onQIDAaxomDmVKgSMxsksyMjfjIvpUskE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XQt9R1CxzPbDYVxS1/7C57Iac1HQ6ZDEHGJh5XjFNxrIDkF+xAt3xN4EbutNJoNYvGl9ofM08IkXhSsWgS5X7TYKg0q3+RWyJ4vvwnCNf5YEB02vOZI9bIcMHofJlLrKAOjf4tEupyh7d1ybIKhfyMcDJaqe+p4pPd1x7xoTdRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fRoRIJM0; arc=fail smtp.client-ip=40.107.102.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fRoRIJM0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xeoz+5X23eeBnfEdvDHPEcd0za8+siF139oQUGOT1di9Al4DTJ92ibM4in+7/8nbCQ3VEqTTHhs6uH5VI9jDrUI2a60pv+iJrCG+FsaJMnzoUh8yrF4CYSM+AQLefuRxCjlHsvFCuqr+qH8233mjTVPF+KLivQy8G72lyfkaHGkmCB3BH75rEk+/ciKN53d7KAzT15HMJtuWVsj/0qAPXLR3D63yzzPYPxOcgRv+Ybvx9T2hBjFL2lDFgCRcXth5S9iOMdzFJ+MGexpETqpma+C8b9Nk644VAecQZRpNbyeAi0hFRVyD3ygHZfu29oQClz0CWJieQBijeYyhtDC1GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RiHLaA9CY6go3rN2mT9pTePIVRdAm+7ojaNuGdu+kA=;
 b=kgsNWMDnZDTzvbFyWODxSiKWjsv7movRfNyxXGaqPEPR1dmBw8beQVddOCTTa/CSCkHV45khcjPGo3OOpCGM+ZY7lR8l8WwJHEI+1Yq63DWMjM3B88sEqIDXb1NmnpFdTFd3vIAZ2hlg+QPyO+5bhpNe0rMafb/jmgkjTNtKGujsKmc3oLITTMmC8zS+iXiHSxDRtDB2KpvX0FyclcLOTDOnUkmGWUnFITfEPLT9rdcCUp7cHeI1cb4FMN6PUmVyevai0IsHDUL6JUxHgnaHxNeeQNsBnuMxY9mc6rojA/7ZU1u6SJXuWhWhFq3YRkkbafzOgmffXmtsnAKW//cuLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RiHLaA9CY6go3rN2mT9pTePIVRdAm+7ojaNuGdu+kA=;
 b=fRoRIJM0f1Uy9JvwD94Y7MaOfIex4NQF0EeD7aX64ehp75X+ZlBAXHB5MX648SV3Z16ZSxpmS/GMNbM4bx+7ChAzovjinuORMtLoMyCb8G3v1A8gc9uiv7gmZCkxQrLqAYWclIiQV0ZQnmQF45upiKCz/0ae7yvAMyogjysfy7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DS7PR12MB8081.namprd12.prod.outlook.com (2603:10b6:8:e6::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.18; Fri, 1 Nov 2024 15:02:54 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%4]) with mapi id 15.20.8114.023; Fri, 1 Nov 2024
 15:02:54 +0000
Message-ID: <a1e63536-9450-4081-9a3a-dae387d939d6@amd.com>
Date: Fri, 1 Nov 2024 22:02:44 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/10] iommu/amd: Modify set_dte_entry() to use 256-bit
 DTE helpers
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com
References: <20241031184243.4184-1-suravee.suthikulpanit@amd.com>
 <20241031184243.4184-7-suravee.suthikulpanit@amd.com>
 <20241101121022.GT10193@nvidia.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20241101121022.GT10193@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:3:18::13) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DS7PR12MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: 76d43881-10dc-449b-af61-08dcfa864343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEhKMGFCZTBuVHBYZHR5bnplcUxYeXgybkFtbTgvbERFd1EwelUweXUvcGpj?=
 =?utf-8?B?NnJzcDFXNitpdTRIR0h6S2p0YjYxai9ocDNZa2cxeE0wOXNGMUJxQzhBZ2RL?=
 =?utf-8?B?RnN2V2pkS0VwSlA2VmtHUWFQaFhSMmdLK1Z6NmJ4WHM1bjZhMHlrUGNQNUV4?=
 =?utf-8?B?eEo5N1IzUkQxdFlYYWpYQzBXSXBQQUNrblRlOWZGL29yd05YWnNlTjIwNVZJ?=
 =?utf-8?B?QVRRclpEMXZXa1NoWHNsblN5b0V2Z09JWmhqUHFqOGhiRDRqVGV3U09GSkpn?=
 =?utf-8?B?UEZJcWZmS2NuUFVsa0lQNDlxdTZyWmpjSXF5aXAxNEdlQXcxUyttZ2hRVTFp?=
 =?utf-8?B?NVAxbGZraVpXNmVwc2lBbWhZQmdjRVJkOGIvZnJZQktuVHhaRGNPQml1NHRM?=
 =?utf-8?B?Ui9TcldKUW4rUUxHbFVxMXlwNU5PT1hPUEpjM0FtclgwR3R2NTVhM01xWEFT?=
 =?utf-8?B?ZHNZckZwa0g4NEtGUm1pM25oREg3bExMTm42S1hwMFd3bW5OMHF0eWM2VFNm?=
 =?utf-8?B?NmtrS1dhOWRJMjBoTURHaVlYWHBQem8rdHNEWHBvd1VaUS9IdkhLMWkrWUZs?=
 =?utf-8?B?NVRCSG9LYkVYSVFudlRCMk82cXlzMDdKeE5VYmduWWRQK0Z5RFZPUE9pSTZh?=
 =?utf-8?B?MG9ZM09TblJQN0VUSVpEQ1hNRm1zU24vY2IwMVRwcmxNcmF3dlBVaHQrSUlp?=
 =?utf-8?B?SEZ4MWNiS3loSUdQcmRsR0hTZC9qdnU4Vklwb1hjVFYxeWltbmhPWjF1dzZX?=
 =?utf-8?B?aWZod2ZLZkhsL2h4SkJBVDJBdlVwUE82enlxeEZ2aVR0aTVtYkZ1dHc0ZkhQ?=
 =?utf-8?B?YVZTSmtxNTh2Z1hNK0xjNHE2TGpQOHNNdVBmYkRjMU94NnRpWHYyVnpSWUVK?=
 =?utf-8?B?UWJ5c0plZm5SSkl3RUpDdzEyaTE2TFF1eDU5dTBPN0cvMDVmcnNCcGZqZm5H?=
 =?utf-8?B?QkNqSHNBV3IvUE12emllMkZqNjVlVE9oZHViRFJFaThjVzJlczZmK0thU1l0?=
 =?utf-8?B?TFdLUVo2SGVPQVh1Y1F6bmtjVkNNdFR1RERPek9mUUtmYzFOdEZvRjNKNDJC?=
 =?utf-8?B?RG0wdm92MTRYVXJrSW9SZDQzNnJ6RHJNQmVlcWw2eEgvVXAydkJTSDRJS2R6?=
 =?utf-8?B?TisxSDlZR09sc2hGVHRGYUdSSmdQcGFxV3BlRTJOdHBIc3RuRzJTWjRuZHNR?=
 =?utf-8?B?ZitkWFZ0QTIydFRPMDZSSVZqbi9UUUhPeHNCdmVvQmYwTmFKcE9pY0JDVFFM?=
 =?utf-8?B?QzFndlVlQmdmejl2TjFnVDIyUzBYR0JOYTdEOWZXeVBGY0JkbC9rVkJHUGVv?=
 =?utf-8?B?aThTbDRtYXNlQ0c5a2d0ZjQ4b1RaUkdYbjVrK2R0ZDFPY0hTYkFHS1pjTUdy?=
 =?utf-8?B?K3NDd0NZYkJXUitsV1kwTGl5ejM3Q2NQN3JPNWRaRTE0TENZS25maU1Dc3Fl?=
 =?utf-8?B?cUVKK0JVeTRsUFByNDAxbTJmbmJoZFU3RkVHVTlFc0hZYm85d2daSlluWmNJ?=
 =?utf-8?B?dm5BbkpQOG00SjZPQlVjOEswZlBtZFU2UDRNbGJUQkREU1oybjFaQnVJNS9v?=
 =?utf-8?B?dDZHVTYwUVVQajVpcmpvOU9sdjM2WU9lYUcrWU45YVlHL2NSMGJVaCtVYzc3?=
 =?utf-8?B?UXpnd2dKaC94c3NVVzNsb0NNc3RCVlRna1pVSGdyVXFncklLMmk1UWhIVktr?=
 =?utf-8?B?N2dSSEZ6c2NGcXFqMnQ1Sld5SGhldWNTVkN6NTA1SU1QQlYvRkR3cXhJMkMw?=
 =?utf-8?Q?VChxW8ycdJKyYUTdVCUGxRYMb74WDfFF2X9XNl2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clcxdHJSemcvVXU3bC9PbkRUV3RWNlcrL28yeTREQytJamVUSjE1dmNpTGJO?=
 =?utf-8?B?c2gxYzNIbzFoQTJSUEJBTlZSbWZmWER3NWh0czBHNXFTVzdGUDBqR1YwMzVh?=
 =?utf-8?B?azhON05xNWFiNC9BbjY1eE5oYy9QVVdDWmx5elV4bVNMTlp5V3ZPeUM4ZlV5?=
 =?utf-8?B?dEdwR1FoZ1l0TmlHM3VNZ01uTURpN2wzbk13YlJNaVlVNDRBWmZ1aG5ONWts?=
 =?utf-8?B?WTlzbE5TWG9IN0MwMFozRFppSzB5Sk82MDVabzhiaGhhNzVzRWNlN0FoeHFD?=
 =?utf-8?B?cU0xa1RobGhBV3dHbEYzKzZQY0RUWWhFcEZjQXRndWliWVpKbXp0TUFnR3pM?=
 =?utf-8?B?Z3dtRWJlclBOd1FyNURaUFBSKzlvQ0p1Tk96VSs5N3V0Z2ZEc1VSZFBKRk4x?=
 =?utf-8?B?eThrVUsrNUxhTjJsT29sQnE3NEtnY01pMUZwL0N4cXJkdHpwSWpYMFZmdEl3?=
 =?utf-8?B?MGswbG50YjF2VkNqWlBVR0hvYVlaYmg5WjhYRW04UG16SldkMmVOcG5GSDVp?=
 =?utf-8?B?NkIvZkRRRWJobFVTaWRGbXdTc3NmdU9udDhOSjV2eUw0RGRZOWFDZ29jdXRI?=
 =?utf-8?B?SHdQdk1GbDdZVUhKaGtXY0ZNcmpvUHJCa0o0ZUNHYzF3YW01REE1SytwVGhX?=
 =?utf-8?B?QWwzYzZmOW9STHdidmFTVlZHL0JubjdGTTNZWGMxQlA4d1JtcnN3R1BOTlZL?=
 =?utf-8?B?STRJUXh6dkZpZkdkZnBNdXhWWmFLK3QzRDVMMm9GWHhmcHdXYkNSUzdOclpR?=
 =?utf-8?B?dnp3ekxNamlnQjg4NjNsSGlvdlo5QzdQMzc5TDJLNE0wbS94N3BVaTBXVGt3?=
 =?utf-8?B?bktVNytMSkJrQWVNcnZsQmt0WVhOTXZzSHJmTjVlc3l6SVM3NWZMbDE1bHB5?=
 =?utf-8?B?UzdCVWhDZFliODRnc3ZXUmtMNmZjeUNtenl5Y3d6aUtKLzM3WVN3aVpSSnBJ?=
 =?utf-8?B?eXBFM1JnY0I0d1lEUUZXK3g5cWFDdjlCYXIxd0pSTXFZUHdKRngvU0kxcFpP?=
 =?utf-8?B?QXErQy9GNVBrNDBFZnVmakozZ3FwQlQ2RzVCcStRMmtxb1QzdTFTY093cEtT?=
 =?utf-8?B?K3RhQVd5K2JQRkplbjZDaE9sL0JLVS92SmNQdzI5Z2lxQVFsSUxHOEdPN3Vn?=
 =?utf-8?B?emgzdTFtUnVQQlpCNGxSZUxmb2FpSVl0QmlSUVVYVzAyVWw2eENrdTNNYzV0?=
 =?utf-8?B?enJZaTREWTVqQXZ0Z0xFQjRaSitlOTIxby9HK1I4cWVwY0RsNXh5b3NtbVVP?=
 =?utf-8?B?cFQwSHVoWm1EbTc2ZGdaWFZOVC8xRlFDeG1CSzc4ai9qTFRzekJZZXpnVjJ1?=
 =?utf-8?B?c3BnbWFvd0pBMmlDMXhwcHJHUEpBMHZxcnlvODVKR2x5NHJyLzR0VGcwdkhl?=
 =?utf-8?B?NFNGaTQ3ekI4cUVTVkQ5NDEvTGorZisrTzNPeUpEM09LN3pNbDBiRFArWEFj?=
 =?utf-8?B?WGhqbVpBTWZac3AyMEtnY2hvR2VoLzZiUExPS0RUUXloNVNNajhmMnJMRmVt?=
 =?utf-8?B?NzhycXFxQ2pyQjAyNHBtWjFGVmRRa1N2Mi9oUkY1dHZGaHBIeUJ2TlJvVWo4?=
 =?utf-8?B?STdXelRQTmlnaE9jVmNTV2FMVUxCdmxOaTZJRmhOZm8zdk0vMzZ2MHVmZmt6?=
 =?utf-8?B?eWFzdnpzTzhrbC9OOWRhS0pTV2UzZ05tV1VWVDZ4dXFBM1BsVHFRVW5YWms5?=
 =?utf-8?B?NjVnbHJjQVdoWUhuNTloYTR6M2NxVkduWVFJOEtPNTJjNlM1NHFlb2RQTlYy?=
 =?utf-8?B?SGdYcytFRXZYNXlmTThuSllxa0xVdDdTMG8vNXViZkRwdHp4R1dzMGlQRWg0?=
 =?utf-8?B?Y1lCV2dzTDIvcVpiYmJXMzdUaFlPZk5lUGFrR1U4bHJFMnI2Z2tCcVAwaUNV?=
 =?utf-8?B?NVhkNWU2MS95aWt0MDdQL3dYZG9MUEw1SjhkZmhoRXlKdU80K25JMUVMWDVi?=
 =?utf-8?B?ZkNiRkNnS3d3MWZxSlIvVjVkUFhpdFFKa2JJeDFrSUlVNWl3c09pbW1DNk9x?=
 =?utf-8?B?V0Z0MXJSUjc3Vmt2c0lHbmRYbTRIb1lSRWxqelg1bG5xNkc2UlZBK056QlpD?=
 =?utf-8?B?K1NCODlQS0ZYVXl3cks1alFhQWtoK3c2N29FbGdUWEwwKzF3QWx2dTQ0VDNV?=
 =?utf-8?Q?/BvUIaOPTRjewpvTW1WVOymzW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76d43881-10dc-449b-af61-08dcfa864343
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 15:02:54.5118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZxDKCTdlXjPFJjxjV2J2ohtOGgU77NGVhdvRMHqhDsGz32Xc41Lq3H5SMlrL2cfwXFkpryirowtsNtyxpnSEpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8081



On 11/1/2024 7:10 PM, Jason Gunthorpe wrote:
> On Thu, Oct 31, 2024 at 06:42:39PM +0000, Suravee Suthikulpanit wrote:
>> +struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 segid, u16 devid)
>> +{
>> +	struct ivhd_dte_flags *e;
>> +	unsigned int best_len = UINT_MAX;
>> +	struct dev_table_entry *dte = NULL;
>> +
>> +	for_each_ivhd_dte_flags(e) {
>> +		/*
>> +		 * Need to go through the whole list to find the smallest range,
>> +		 * which contains the devid.
>> +		 */
>> +		if ((e->segid == segid) &&
>> +		    (e->devid_first >= devid) &&
>> +		    (e->devid_last <= devid)) {
> 
> Again, I don't know much about this format, but are you sure about
> this logic? Consider:
> 
>   e->devid_first = 10
>   devid = 12
>   e->devid_last = 15
> 
>   (e->devid_first >= devid) == 10 >= 12 == FALSE
>   (e->devid_last <= devid) == 15 <= 12 == FALSE
> 
> FALSE && FALSE == FALSE
> 
> It seems to me it does not do what the comment says? Compare to the
> version I sent in my last email

Ah, sorry again for this stupid mistake. You are correct. Thank you very 
much for catching this. I am sending V9 with only the fix for this.

Thanks,
Suravee
