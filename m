Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932B3225A2D
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744008806; cv=fail; b=cI9AWewSgHfvihlG3gMIRS98YV3kFBn+HnIc+Y2hiB8Q1Fee2CyNLntk+qoRGd0ZPOFLT1ETW70SrwiP1L7Mqu6JkwtC1It93ta/vPzOaSkhX0OX7P8gkUZxNNSFyDt9WUgpkTRN0ucgmdK3MpswmSvGM2UtZUlEx/DUJzaQtnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744008806; c=relaxed/simple;
	bh=a+zQzBmkuH90nf6brKneH/Xs5gJpBz4Ht4HhwVPMDUU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=avqrVDPB7dUklYK80iRYrW/0uk8w7zfhfaNBw1vn/kj4Ib4wLOLBbmpQKk10LxSWcGiCcRiN2xChO8sr29F3NqVz9Fg5TR3dqXlYqpg+ONElkZlz9vVOjkVP4k5rE96U5cQBD9OA96XnzieRK8jLJxgmpP2HmSrycQ6ezcJ633w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bxd4062r; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bxd4062r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxsrbIIOa11c3NhWitcOnTysn2Id0ETRjpgo2JgTq5TR0PWKpl6Uejw1cFZcwcc/NpuXB03CkqzGU3/k8P36zbGtBf1ytKs5qqYWENrxwc7wkHpmL33gLAuM6NJ1/KWGZuRgmsVzd6Egqh8DYT71DTGYnciqHr+HGe/KBnO4MoJX2ywXF1puu1zGPUvGbGkh2R0FTsWOJb0rNcEZx+B0/xMejpFFvdpz04cpZBd7jAfNF7svn3AEvm9btk6omJEAj1o3io5WgoCnx8s5Snufqmj+QViGGD1G3vYjewoFykgs4BjULuulVPEc+KqB6jJn9ARGHl6TzrLcGawKzLlXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJx1eT51C0Pi+Bm3SGoaJ8vn6/Qzgj2dGukHQAuFEwE=;
 b=ad9CmszyznOQExqR0br5hFelZyu518Ny70/tlWdkewT/uBGn5xZmHJ+B9OHz95ZkeNmXIFcjtyd3Kr0cUrgB1pPqjEtTlknxnDcN2hQUb2zqyCRRakU8AJwINxeCs7ybGsFvVBZWHP9ocGRoL5PCRtvNkE9Llti+2QukcHEaBK9NsbSzsQa9aibWF6SkLIvy599rI+hk/AhVB3EQSg1SxfW9bYTt9icJGYfGT/GN50AE1X1qC5useoFgO3lxD24PA6xIoMfgmmGXp9EebIaPIp0wU2LzX0CA9m9MSIDDD56aSGiZooz9060LzdY0V0nwK1n2EE27PjVMaP2JtxM2OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJx1eT51C0Pi+Bm3SGoaJ8vn6/Qzgj2dGukHQAuFEwE=;
 b=bxd4062rSF9emvFvTJdnejROAEBG0k4nB6MaP+a7M4x/EbxIe6ojAPDNgVuPRcC0mfCmdOvb/+KJmRW2fDv4triLyf+VEJeNCroaldEXecyxeBzOAC/atFql8Jo+Hy9HQIEOmI6gnD9z5Na11ukbgKdZUCKDrlkbBDuj4IV/bfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.46; Mon, 7 Apr
 2025 06:53:21 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 06:53:21 +0000
Message-ID: <e9a21b33-b240-447d-bd72-8f1c4d21e302@amd.com>
Date: Mon, 7 Apr 2025 16:53:15 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] iommufd: Fix offset handling in folio subroutines
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>
References: <20250402014408.2760300-1-aik@amd.com>
 <BN9PR11MB5276D77DBCCBE909083B6C738CAA2@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <BN9PR11MB5276D77DBCCBE909083B6C738CAA2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEVP282CA0049.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:203::9) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: ed848160-e8b5-42c8-0818-08dd75a0e24a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2pKODNBbW14TUFFNkhHV0lrL3ZRN25QdWNaT2FuQzZiS05ZalAwZEl2UzVw?=
 =?utf-8?B?MkUvcTR1bC9Mb3RiRDNka1VFOHdocS9MK3FwYmcxL3J3WnJqQkhnaFNxc21S?=
 =?utf-8?B?VEgvWFdvN1VWb1g1Qk8vaitTVVN5RkJHejhFdm9ZN2V6K3dmRnpOUlYwcDFN?=
 =?utf-8?B?ZzZ0VTVVdFhFSUUvckFiTGkvdlhNUDJGWWR4RGE5Zm85bytNeTJFNSszd2lT?=
 =?utf-8?B?Umd2OFNnSFQyM3RXTEd6bmRRSUZBUitDbDJlN29na0pESi81UzVVejBhaWxJ?=
 =?utf-8?B?TkJDSmNtb3B4bFR3aGU3WEF5N2h1a3NXNTloSGltallLbVRqYzczQ3lDY21V?=
 =?utf-8?B?V3l3SEtiUWZnbVJtc0hyWU1UcDhld3RQc1RUZnBxMWZBaXFweVZINGNJL3VI?=
 =?utf-8?B?WUg1cTh1SWY5aHFndkVVUFdqWFpIUEZ3Q21EcTl4ckVHY3FPSE1iNjFtVUhH?=
 =?utf-8?B?K3M3S0c1QzZCUlBNYTZCckVwb3poWGdqRjJneGpaTDByWm04Y1lwSS9ZNHZQ?=
 =?utf-8?B?ZG10TnE4Y1hBaVhxNWQvSTlUdWVGcEdsejNsU1VENjEyV0tBc0Q5Z1BCZDho?=
 =?utf-8?B?dmM5YjArb1NhTmgvYmxzcjhudGM1NlQyZnlldGlSazgvNHhwWVJRbGkya0ZC?=
 =?utf-8?B?eTkyVFBxS1BDVThyL2JFNjg3OFp4UVowSDFQOXlCc2FkZkxYVTkxcm9jTFlR?=
 =?utf-8?B?aTdobjkxWVJtaXVjV1FRMnh1YlZMN3pBSzNkMWRBbTRvdmxNc0FMTk5tdmk0?=
 =?utf-8?B?bDY5SU1MTng5SHhqMUI2OXlJWEYvVm45MmRnL3ExbENONGswSWJMeHd1eFdI?=
 =?utf-8?B?RzgvYmRmZkNFNlhLdXZTUFEvMGNmRHh6aTJ1ZGRRdXpSMnJEdXN1clRNU2xC?=
 =?utf-8?B?VlZCa29NcVBYZkN3ZU13RWZWdUg3MVl2SDBESll0UzFUVTJMM2Q0RTcvS3pK?=
 =?utf-8?B?MThsQlE4QmNSTk5oZUh1bmtOeC8wd1ZDYllnYWN5NzU2d1ZLVWpCK2V3d1oz?=
 =?utf-8?B?RE85NE5zVWVsWjkrcDRxaGVBbXhSZ25tOUhEZ0o1OGlCaExKK0o3dWtLRldu?=
 =?utf-8?B?N3IrYVFIS1ZnY0wvSzZBcStwV2h0ZWJJZHFXeXdiUHNNWUtBakI0N3ROanBH?=
 =?utf-8?B?NUFqUkIwaFRQL1JDTGZXaHFrQXpLZUZtRDh3UFc4cXZtOURPLzduKzlrVHg5?=
 =?utf-8?B?ek5LZW1DL3NhMG5qdHJ6L25kSEZIYXVPS3dDWFJ0c25RWUJONFYrdnpFT3pt?=
 =?utf-8?B?SVhBN0ZVckM1SFBxWEY3OUNmTG1WMkIzcGRQWStuQTRVVVlpeVFaRWVMS1Br?=
 =?utf-8?B?TnM3TWxBeit0UWoxOHFBTWtrOWVKUTBzaHQ2amFETTluZ0pBM1I4ZDJPcmF2?=
 =?utf-8?B?eVNsYjNCOHJVdDk0b1dBdllaeVJGODU3QlhYOU9xaWZxdFlTVllNQSt4b1ZO?=
 =?utf-8?B?bFBnTzh4TVpSb1o1TkFkUnVWTkRCeHR6bUt4emVrRkFoeVNRQStrZndWVWFD?=
 =?utf-8?B?QTY5OVJrNGh0OXpsbzc1OW9Kak9WZ1paMHNFT2VhQkF2czJqK2dhL0I5NUtT?=
 =?utf-8?B?WmRSTk9rL3lFZlFkSUtFbTNRZHRjWEhyMmJMSXNYeVVjeWEyaWpaMXV0RVc5?=
 =?utf-8?B?MkMrSDc1WUxUTHI1czhwanRVUm8rZzZLMEFGMUpkS2diMHpsTVBMTjlUVnpL?=
 =?utf-8?B?RnhyWHJKc3RQclZKSTUyaWJqTUQzV2U3ODM5TjdYbUNtSTBhKzFmdmZ0THBz?=
 =?utf-8?B?d2sxbW1QQWJaa2VvRjh0RXpMb2dBbUExcDZIYWt6cFJ3OGk1OUtkK0t2ZkFZ?=
 =?utf-8?B?eWQ0UExHWWczZkZlYVJETXBBbUN2RE9BbmtiKzgwZmlLQUJoa1U5R2Z6OE40?=
 =?utf-8?Q?pbyGoLofwRm+O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFNNcHc0anMyWHhaSUJ1QXJTSTdRYnA5eGdpdE52Q2F4elozQzhaaFhQOGxu?=
 =?utf-8?B?bzJHaTNDaGN1MjJ2OVNpN3EyRjR3dU03SFhZanZSRnc0anZhcFFLNW1VeWx6?=
 =?utf-8?B?U25jSjhERjJyaitQSkdNbFkzMlA2M094anpwRDl6c3c2YzBrNGFOTlJlY1VJ?=
 =?utf-8?B?Sm1hdWwzNisvVEtWREtDcGJTL0s3TnpDaDRxQkdESi9RT1lHTXQwdVBMRmZH?=
 =?utf-8?B?Q0N6UlpGNkh4Mm5SM0ZlV3p4OE55Mm11RWhNZ1RWS0RCVld6QVVPRnF1bTJU?=
 =?utf-8?B?Yk1idVNzT1pWZ0Yvd1lmOXNjbVZKR2NmdGtXRmVBZlJQSGJpUTNrYkE0ZTI3?=
 =?utf-8?B?amt4cjMwZW9rYmxLVVFjK0g5Tk1XUGV2RnFnQThEbHJ2RzBnZ0dnRkl0TG52?=
 =?utf-8?B?N3RYaDJQREhCclQzVHlCOFVIRnNqRVp2WWlYVTBnSHVjR3JwVGVKL2o2SFBn?=
 =?utf-8?B?bUtxeVlmTVN6enVWRXJaK3h3cmY0TlRSZERQMzNZZXJJZi81R2xicmtaTWpK?=
 =?utf-8?B?TEpINFVNL3R5NGNGay9ycDBGUWJmalBQa3FPdVd6WG1lc2dMVW5NdEMvcFhP?=
 =?utf-8?B?Skl0UHdzYXBwWHIyMkZzN2FSbStRZXR6Y1JuZnNhbW9oajJRSkxGSHpVZzBE?=
 =?utf-8?B?ZE9heWMremNlWk9WdnZMS2YzODgyVzl0QVNlRkFORm1FbUh3eHVWUk5wK01T?=
 =?utf-8?B?aHV0YzY1N2s0ZnRacmlBenlnR1B3MDh1VlI0VFZiTVI1VzhjS0ZjdUNlVm5X?=
 =?utf-8?B?TWNycmdFUDZkaHlFaE1SVVBhT3VMM29hTmdxaFBjRXZWYldVRmp5M29HTlB0?=
 =?utf-8?B?Y1hLUGVEVVV1Uy9haFdSWWhHVHgwcUVjLzRtU2VwZTlhRi85WEJiT3JCME5Z?=
 =?utf-8?B?UEtDeDhsdXllZk5mcXFEYU83d2JsblpFQkxJYlFuR3N3dnJuK1lDSWFTV0FZ?=
 =?utf-8?B?QzRKQ1NKdlRBSWVWakhaR0o3NWkvdGZPUVJta1ZOYTd4U2hScUFFSHR6UzFT?=
 =?utf-8?B?V1RvRmk5cEV3bVpzZ3ZpQysvYWlhdzBYR2QybDh2MThhUXNTYmlMdHpIbFBG?=
 =?utf-8?B?WDQ4QXBKNlJpM0RDajh2ajlOaTFSeHJnR0xDUlJGM3YwTEVRVnhSY1A1R2xT?=
 =?utf-8?B?V2NYQWJEU1c1bmN6R2owK1cvK1Fma0w0RDlhaThRNEgxaFF3TFFISG8xeGoy?=
 =?utf-8?B?bkdneWMvN3VLQ201VzJPMldDcU94WXJZVWUxc0xub0tJY0ErdElCUWxZeGg0?=
 =?utf-8?B?WTdLVFdIT0NnWWhob1JFZ1BYRmt5dDY5elNSc3NxbFVhSlFLRmE5QWVzdEZr?=
 =?utf-8?B?QkQxbGt6bzVNOEtTTnZlTlRZZVpEWXBkTzFFWEszK2RaV3hMSW03MkF3dm8y?=
 =?utf-8?B?bXd6bkNmQ0lGeFZJNXZDajRJVEZpa3FhblpwdmhpVUY2d1krMExHanFSd1d4?=
 =?utf-8?B?QmVQdFFOTllaZDNheGtycXdibHVvb2hoTU11a25ZclNyNE5Ea1RhbzhEMzRC?=
 =?utf-8?B?REVZM2EycDd3UVR1QktkV1JseWtrbXFoSHFZK0xVYVlpOE9UWkpPditaZi9o?=
 =?utf-8?B?ckJpZTJQR1NxZGVoV1c2Ykk5dVFsblQ3cjhTZHJjb2RMNGxINkVoYUhvaUZR?=
 =?utf-8?B?L254eGVsaTdLVko4Lzl2OTVqZmloR2drL21GZ2xrTHRkZ0pScm44SytKcHdz?=
 =?utf-8?B?VExzZ0pmWHZhZW9jTlVpSEErbGEyVFkwTENvYmdKN1Ivbm16WVpXUmQ4T2g4?=
 =?utf-8?B?aVJJUTk2Y1hzbHhGaHNuZTA2NmpsM3poTi9RMlM5aTNDK05rbFdmZ05KRWNk?=
 =?utf-8?B?UjRQaU9EUEN0NTVYOW1PWnZpYU5nL2c0Zm1FSWxnMlJpRmdhTFpndDNwZFhN?=
 =?utf-8?B?cFd3U004cm8rWG5PK3l0Tm13S0FuRGY5dkY2S2V6bHFWdTFETEdMZW9keHE2?=
 =?utf-8?B?SUFtcHdWTVdSMDIxZC81eVVCd1FNUzZHZHJxVWsyYVFNWXd5amZFaU5PSE1t?=
 =?utf-8?B?T1BPbm5LS0pHN0Vvb05nbTFoeU5BQ2pWYjd6ZmJkeDhVSklXdzVNbGI0cjZP?=
 =?utf-8?B?MXNQd2t5RlVCWkZpS2FGV2Mram5XSlgrV1U3dE5Zc3AxRHVwbzlCQit5ekdh?=
 =?utf-8?Q?hmmUGqPyJqQSWKN7fxbeZV+6Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed848160-e8b5-42c8-0818-08dd75a0e24a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 06:53:21.0073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aMPLgU5gdXdyhgJoZP5lEDOpkH+pIQA/CzZRj0BVRE19L4jfJYJSAI74SKxd3sHZ3/07TES5JbwVismbdAAzAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805



On 7/4/25 15:12, Tian, Kevin wrote:
>> From: Alexey Kardashevskiy <aik@amd.com>
>> Sent: Wednesday, April 2, 2025 9:44 AM
>>
>> The @offset from memfd_pin_folios() is pgoff_t and is bytes, not
>> a number of pages as batch_from_folios() treats it.
>>
>> Convert byte offset to pfn offset and use that.
>>
>> Fixes: ed9178fbfd4e ("iommufd: Folio subroutines")
>> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
>> ---
>>
>> Found this when tried mapping a bunch of folios (>64) with an offset and
>> the first folio was used for all the mappings in the batch.
>>
>> ---
>>   drivers/iommu/iommufd/pages.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iommu/iommufd/pages.c
>> b/drivers/iommu/iommufd/pages.c
>> index 3427749bc5ce..6075d11691a6 100644
>> --- a/drivers/iommu/iommufd/pages.c
>> +++ b/drivers/iommu/iommufd/pages.c
>> @@ -646,8 +646,9 @@ static int batch_from_folios(struct pfn_batch *batch,
>> struct folio ***folios_p,
>>
>>   	while (npages) {
>>   		struct folio *folio = *folios;
>> -		unsigned long nr = folio_nr_pages(folio) - offset;
>> -		unsigned long pfn = page_to_pfn(folio_page(folio, offset));
>> +		unsigned long offset_nr = offset >> PAGE_SHIFT;
>> +		unsigned long nr = folio_nr_pages(folio) - offset_nr;
>> +		unsigned long pfn = page_to_pfn(folio_page(folio, offset_nr));
> 
> pin_memfd_pages():
> 	nfolios = memfd_pin_folios(user->file, start, end, user->ufolios,
> 				      nfolios, &offset);
> 	offset >>= PAGE_SHIFT;

Aaaaahhh missed that so there is a bug in my variant of 
memfd_pin_folios() for gmemfd and sorry for the noise. Thanks,


> 	user->ufolios_next = user->ufolios;
> 	user->ufolios_offset = offset;
> 
> pfn_reader_fill_span():
> 	if (!user->file)
> 		batch_from_pages(&pfns->batch, user->upages + start_index,
> 				    npages);
> 	else
> 		rc = batch_from_folios(&pfns->batch, &user->ufolios_next,
> 					&user->ufolios_offset, npages);
> 
> So the offset is already about a page number as batch_from_folios() expects.
> 
>>
>>   		nr = min(nr, npages);
>>   		npages -= nr;
>> --
>> 2.47.1
> 

-- 
Alexey

