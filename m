Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225A015699E
	for <iommu@lists.linux.dev>; Tue, 30 Jul 2024 03:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722311952; cv=fail; b=IbVzBdRzQ45apYnY/GhhslrXZ8/3FF9ys/GZi6k8bIclN33F0mOrp0w2SvnCymekDJHoQhcD6Qn9LRqwDH3/U8bZ9rn9ySvPT62VzUFyjQDJenvkHoTuSixMs5p6DM/3uUrVyLcsSNmoN/v4CSmES/+T5txPQ1WbYDEBnwEVMlk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722311952; c=relaxed/simple;
	bh=TwD6F1/04xU/O84L8PBn58osnYRY+BjqRj5JsMZN7PI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tBLTXyFNDasRzSAEvJfxE0bphnORqgFm4kMVapvGH3idehN8XShbxcPPPvETJdEyIPce1X7mxfZci9I3ozcb+YdkhwRXhy5WgOS7gWZgVLD3tn/UljlLT3nyabm8gVBiiWvXA7ndcEV33IpSSzUJagjnGtf6WwJ4OvGkdjG/Ncc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m/h6B8qk; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m/h6B8qk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lr9EzQnct66W7r335wqV17yP1WxVyinHTHcjJXFZaUzw43G92MqCcvN7XHv9UQ9sSFJi8nNDXEIsgtrYfka3XwoetdM/ekBMlMonu0l/RrKHa0XyAsX+Vl6/vywu3C0uuOZNiBhKUCxF3gTs7FvOc1iPYkHAxmg78dG07GW/JijHhNlJiK02bK9gbW6L/c8uBYoeBciN3kAgz1q60px/8STQonqAoa5w1S2Q37OyYTWkXZ9mxRCa1RBWAu+EE2CaQuGu4bQ75AADCFj8UhzgmzMIfsYK+Cip/hOqBA3tfjA+p1xG9zrYzyZ4GX483VBbePcTZZzXWfmEcIsSRwG+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwD6F1/04xU/O84L8PBn58osnYRY+BjqRj5JsMZN7PI=;
 b=IAaR2gReMAMplRjl101BRQ/IzobLBDz4U9YbNy/v27/+G+kHJ4ngmoC6IWU2dJ3MBF0oRi3akYcdaXKWOMQ/iY+dzREKR9eANhFlZljBIEtZhQcBvjh5+aib3rCrr16tRePFWof35NTgl4ae6l+qNZpBhGQ3YNRrWiYNt0Vkg/gyoIeLIHXLejKxzDMXObQZarqBMf+sqi9UUpuqmgSQFoxpCD7HplRUN7lip5wupPK3IPjDY2ZdxnMUXHWjpd1O2mTN368NY3c/p5JzBs4R9TJZVCcEDRHPMnSfXKL8d6c1kNh6ZgW56sA0zNL5nLKtb4WFFy7uYy6ZIoB/APJCqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwD6F1/04xU/O84L8PBn58osnYRY+BjqRj5JsMZN7PI=;
 b=m/h6B8qk3i548BUUPKuCFEsrXrCKbWkJqkXlPd0EseEfDRFeOnz4cT+RZcyYLqAyN+7GmhBBhIWmCYMEZALRHyOr+OTwMclTRSJUxGZZ9+jEeSC3364eNc3lzVdorFi925Q21z+TIy0DCkKFW8OHxkkupSYBl/HHXXOnCczGwBYaZs6L1J7ocsEbCfzPS0yVC6Vq7FTTDsrP8Y8L3rxEUwoMJ0504KV43WJpfoIGaPobZ/zIy3VqlvUMFbhVCxKQtw9kLw0FDBtyIUdsWrdf/A4NyDsAfyCEWg6giMQXZ2ZdcKzshz+Gy+I7zVnPF9zt4oEgeLKAyrMI11oha/6EmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB7426.namprd12.prod.outlook.com (2603:10b6:510:201::18)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 03:59:07 +0000
Received: from PH7PR12MB7426.namprd12.prod.outlook.com
 ([fe80::6fdd:1491:4d83:ac33]) by PH7PR12MB7426.namprd12.prod.outlook.com
 ([fe80::6fdd:1491:4d83:ac33%6]) with mapi id 15.20.7762.027; Tue, 30 Jul 2024
 03:59:07 +0000
Message-ID: <44596632-5624-4d2b-b734-75046daabfea@nvidia.com>
Date: Tue, 30 Jul 2024 09:28:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] iommu: Optimize IOMMU UnMap
To: Markus Elfring <Markus.Elfring@web.de>, iommu@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Will Deacon <will@kernel.org>
References: <20240717100619.108250-1-amhetre@nvidia.com>
 <7d572400-519f-474a-a664-82d142c71666@web.de>
Content-Language: en-US
From: Ashish Mhetre <amhetre@nvidia.com>
In-Reply-To: <7d572400-519f-474a-a664-82d142c71666@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0002.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::17) To PH7PR12MB7426.namprd12.prod.outlook.com
 (2603:10b6:510:201::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7426:EE_|IA1PR12MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: a82a94c7-a8f6-46ca-abe2-08dcb04bf5a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1ZtV1BlOWxxWVhUMUhzclN4d2p0M25zaVlobWttcmJvWEdCYjROUVp5Mkha?=
 =?utf-8?B?MGZyZE9STUU0MzZZQW1LZXBqaVc3dW9HQVZZcVNOWFkvVE96bVdMNkVmZkZt?=
 =?utf-8?B?akl3VmVveVZxcjNMNjY0UzFyemg1Lys3NEJDTmlUQzFZdXArNERvemt4U09G?=
 =?utf-8?B?cnk2VEdaQ1pReG1OSmdNd1UzVWJBbjNPOFpLeENlRG1iSkp1cjRVc2wvdkpt?=
 =?utf-8?B?YWx4emY3bHRaQ1FRZHQzMU5ScW1rNVh1SndDV0dKbVpCN2RnaThnUVVITk5O?=
 =?utf-8?B?SlRLNmRHY1E3SkxTOEZIemtBQVlrRGVaOWw3SGNOSStIbEpadTgra1p2eE0y?=
 =?utf-8?B?TnlCWjluK3ovcEdFaHJKNy9hSDI0T081Y0YwRHFYOFBHTDdZd1orQ3JMRG8w?=
 =?utf-8?B?NmtBRDFJZzBJMGdqMGc3ejZ1ZGUvL0FqVDlLSWV5aUN2Y2xTK01qOVNEWEtL?=
 =?utf-8?B?ZlhjUlhLQkw4b3BSN21EK1ZqbzJpU3V4RHIvZXd1UHdvQ3BPNmRraFZ4T1BB?=
 =?utf-8?B?Y0cvL08vbVEvKytkcTZLWHBUUG9QZytERDNEWkN1SFBtWDB5L2ZxQnFKc01a?=
 =?utf-8?B?YmtjOXhOc0ZtaElhVi9jMFdnc1BvaGtTWE1pQUJ2RlViNmFoa1VtYTlPY3dj?=
 =?utf-8?B?NFJBZ1dTalB3Z2tSVm1wUnBVQlVIV0t5WXpVUkhFRXA5OGMzdHovVDE0SEVV?=
 =?utf-8?B?WWhvNlg1NWxIRFM0d1h2dWFHNmVKTytHZ01hdGY2ZkZ2Ti9CZWFoc2xac21o?=
 =?utf-8?B?WUsxMFhuSGZ5NTY3WjV4MWxLWDYyQzAwcWFaMnV6NTVMYTB5ZHR1ZjErZEZH?=
 =?utf-8?B?dmFIaCtUWmFNU2ZxTkpPT082VlU5eEtrOFZGTmNhZ3dwWkx3WWthOVVjdklB?=
 =?utf-8?B?OUZnU2tSU3B2M3F6S1hqMzhLNkZ5d2NMQ25aeUdjZk9TMWZqRjVESGF3b2s4?=
 =?utf-8?B?V2NNQWRnTml5b1VhcnBpcGN0SHZZUGFaeU9YN1lDSER5MUpDRTB4MUhxTUoz?=
 =?utf-8?B?OVI4emNxTFh1cTRMbzdpcWZHdFk2NVovUU1Vb0dvcU12NEg5SFg2VWlrMjlp?=
 =?utf-8?B?REdMb3lTaGxnSVJrU2s4ZGJKcHV5MVg4SVhRRDlJV3J0cFVyRE03NWl6b1VE?=
 =?utf-8?B?YldTM2Jrb1ZUaEFaYzNBSXBFQ0tEaStpdzBwSnpEMW1VWE5VajVnYWpmSm5D?=
 =?utf-8?B?Q0x4UEh6NU1IL25FOXZuTjJQR04rNytCZHRDUGgyUEw0aDlPakFMZjVVTktF?=
 =?utf-8?B?RXA3cDhhMGcrb1FZYVhGbDhuM1dtRVZaY3I5bWorSkFFbW5md2ptNFJpaWl1?=
 =?utf-8?B?TkhyQmZYaHA3dU9vQi9ENjUzYXU1SW5XMEhaOG9HejBvRUpoVVJSTkNrdU0v?=
 =?utf-8?B?TFJ5MHVPZ1o4UVRXdDRFNE5qVWh6MDJMb2I3VCtOT1VsdzMzcGtCSjhSM1Vp?=
 =?utf-8?B?WllkWDZPMzlhbFh1ZVZMZC9sa1BHNW1ScXk2SFNoYjZJeC8rMEQvb3JqbTRJ?=
 =?utf-8?B?NnFVY3Jja3Bwb29XZjBTOGJxd2FMb0FJVGVwcHcweVAxSjdwV2RYZnBJbzlW?=
 =?utf-8?B?TlVlSTJRM3ZMT1hMVHVRSTZyV3pESTM0Si9Rcld3MzZJczY5cGd5ZzVjTUxC?=
 =?utf-8?B?L0ZCRmRwN2kvV0Y0MU82Q2lxa1ZwNjQxaWhlSFpYK2xmUkllNTFRbWJsdnZp?=
 =?utf-8?B?SkplZElSOGV4L1RLRFJTeHlSQ3JVOEtPQ0xoQVdwZXphdVJlZVN3aVNEbTQr?=
 =?utf-8?B?SGdrZ2cwNmxvM1VQaWRkMEhLNklUTmdOdTFpclpaV01wd2Y3MFQvaWlSMUNx?=
 =?utf-8?B?MUlGK0xaemhMS0xqZEpzZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7426.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2djUFI4L0d6MG5rSTc1WnI3eE0rdGJYbXZNU2N4aWN0Wi92aGxtYU9RY1lz?=
 =?utf-8?B?NWtwSnFMSEszcThLYkhLeUsxdVFTOWNvSlhJRTJ5SlR1L09SMDY0L2wrS2sz?=
 =?utf-8?B?bTQ1ZFJjenpXVUdUaEdEZlJjaEVMa1YzSGk2S0Q0Q3MzZFRiV3dhY0FLVVg4?=
 =?utf-8?B?NC9WODdIQ2lmSVZBTkxMZ0hJQjArREsrMTVPMFJSZUo1SXVkcDhYYlRCS0ha?=
 =?utf-8?B?bkpxWlhCZGp2c0FUMUsyNlRIcEhEc0c5RFRyMllLb1NuNjdZci9kUVZOL2FU?=
 =?utf-8?B?Yi8wTm9WcmlzQXBBR3ZwTEg5S3RFZkFiWGNqZEZ4YURhTlc1Z2ZPS0huVS9n?=
 =?utf-8?B?cFVaSGJmUEN5cURVL20yandsa09zUkJhV3k1aWgwQ2hnbFIydUJMRUNNRnVy?=
 =?utf-8?B?SzBnK05KQXh0WkY5ZzNhSUxEcDJXM2xBTGN4YUNMZ2hDZmtXK0FiekxsdzNn?=
 =?utf-8?B?ZktuL2xQelBGRkVyR1JIN2orbCtCV0xrdFVJSUVqQnU0Y0NaaVcxa09zN1I4?=
 =?utf-8?B?dGgxeE9yTFRGc1o5TDBkV01iWFNWcm90SXFMb25NM09maVdMQzVET01kYnd0?=
 =?utf-8?B?M1RFZ1VjU0xsQzBxOHVIbkw3QllBd0FPMitRUDNPMEt1T2R4KzdRSlBaUGZV?=
 =?utf-8?B?ZkxJUnA5R0JrQ2VjL0NxdzZmcU5Ob2w5Rkltd0h4bi9PaXlRQTZZb2w2czlq?=
 =?utf-8?B?c0lWR2NKZmdMQktid1JDREtScko3VTJNYmxzRkRTNFN6OFk2K2dveE9DL29X?=
 =?utf-8?B?aGRpbTQvQ253eGpJcmllenJWamlsQ1B3ZXdxRStQcWZjaXFDTkdmWkhyT2xE?=
 =?utf-8?B?L1ZnVDhpN3psMEtTMmhpWGpHMFRNR21DTEZXT0IrRkptaE9qa0RSM1J4S0hY?=
 =?utf-8?B?TmFMbFE5SVd0Y3p3SWRHbi9wQzBNQThiSUgyOWVhTExQODZZN3NqOVFQTGRR?=
 =?utf-8?B?SE80a1oxbllRMzFJWmxpZmd4RDZKQU1BMFZHN1lXTmMwTFhyU2JrTERmbCsx?=
 =?utf-8?B?TDBvZCtXblhNMzZpN0V2Q0hDcHFKbmdleXU4anRkRUd6RWlyOUJrelhwQmZJ?=
 =?utf-8?B?aVl1T290aFFnWkUyQzhKY1dadkRrWHRleExOM0xvYk5PZWFIN1RvL05Vamxo?=
 =?utf-8?B?WGhTL1Izb093MXNJSHVna1lnbllXTDl3clhrWWVUcFJCeU96SXNpWVdFRFFS?=
 =?utf-8?B?R1pHMGpZU1AzQ2JPNXVMbGZJR0lFL1BDa1BRMUZLeStnQ2NrcnBTWGtKWG43?=
 =?utf-8?B?bGk1RDhNMWRrMkJxT1F6akM0L3ViYU1qRUd6RDdlZ2RsMHdWMHV6SkRDeHZ3?=
 =?utf-8?B?OE00VHUyY1BHQ01BMzgwN1c3dWFIRFlLUXliLzBYNFFabGVpNXBCVEIrQU5w?=
 =?utf-8?B?dGlPM0YyVGpNU09jZWFMMitvWTBhNGZ6NjFZZXdBMjhzVXZ0My94aTNUSitp?=
 =?utf-8?B?bHBuU0lFajkrK2Y0ZnlHUXcyamNwNDNjQ2ppOW9qc01PNkVMQXh3R3RXRzhv?=
 =?utf-8?B?SjZQcUIxZXZKL0NpQk81R1lJSDJxd2VsdzUrR0xTcm14dlIvcjBwRTBVNmtM?=
 =?utf-8?B?SkxjYlE5cUpRbTBuQnlmcEpTLzV0dCtZbWRKWSsvY29ramdWa1VVWGNlYXcw?=
 =?utf-8?B?Qm04bExUanpadEo4a3lkU0o2NkFsWmpueUpJREtFZXN2ZERKcTVGQjZmTEJ1?=
 =?utf-8?B?RFZVM2VEUDhrc2xjQ3NuN3UzeFk5WHBndEZaNVlVOTgzd2xjSW9xS0loSmY1?=
 =?utf-8?B?ZGpUN2RjS3YwZUFCZmU1VVZQV1J2YUhtRkIrUTFBRkhpcEhBOWpxai9zc1dD?=
 =?utf-8?B?VyttVmp3MTZ4T3ZvRHZrTDFyeXhuN0FZd2dyWWpRRXZrdzFFRHI3eVloY1R0?=
 =?utf-8?B?Vmp3T1J6Zmp2ZUw4THdISk5DQ21tWllCcE96STlWekJwbEVUMUtjajFEOEJW?=
 =?utf-8?B?bHM5WFM0aGRyMG9LT28yRjV4eFRVVnNuSnJKdktNcitkQjByVjVvVHFsWXlX?=
 =?utf-8?B?OS8xUFg4bENLUWoxL1RXQmdZS0hIdS9mdXZ0SHZRWmV1Rm4wOE13MEpXaHpi?=
 =?utf-8?B?OWdGakdJV3RqeHBERURqQ0IrU2VpNFNDNlhlTEV6MWw5aGVRK05PakZkOTdj?=
 =?utf-8?Q?Q1V2UivZNnw5keO31zq/h6OVq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a82a94c7-a8f6-46ca-abe2-08dcb04bf5a0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7426.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 03:59:07.2840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHZsrN4abVB7o/16JWiQFBb8+l4psLRb2rhP3Rf5ubOAOtnCN1TrWeY9CrxQEezYHVhoWXhnVQij6xlS03u1LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553


On 7/29/2024 2:13 PM, Markus Elfring wrote:
> External email: Use caution opening links or attachments
>
>
> …
>> This patch optimizes …
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10#n94
>
> Regards,
> Markus

Thanks Markus, I'll update the commit message in new version.
I'll wait for any other comments and address them all in next version.

Thanks,
Ashish Mhetre
