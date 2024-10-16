Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD7243146
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729055740; cv=fail; b=MFyKhtexBCuWuar0n2OQR9nnp4+vd3dejfZTsvbUeA+YJefwPoquHuQYJWBrY5c+3VExQ7OYLiYIdpNNFVXIqXNUns7l6xkmu68Ev1UUHbvvWjbLOcWmehYNMKZ8VUJQ7I3Cc17x6iN8dNklb4EbM0tn+uDK422+Ag7RpnhEHyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729055740; c=relaxed/simple;
	bh=I4sUOmYFzPV9RSGixYKfSTmeVJqxGmVmqNTqbipxwuk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lzZI4ElkaJKPw/uIiBpMnndLfoc9UqmKD6XlNAVSeRCdQV8fNyTY8+6J3RRmy2id9Qkv9mDxjizzn80cZPFHlEk2PQR8pJclT5FBly/2Wk9M3NcZTG4xayba759h1lDWMsZPKBX68o3gNn71RlwqrL4CiC7+c50O/r5duFfFqZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rYsNcNiZ; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rYsNcNiZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VW1LY2YHN4YgsTrbrrFHW0i1w9hcmddYTB9wjSfEy4zM3h3jo+Pq5dwvymvw61bXP3M7gG6emqbqDzLeMmoDlsLc4TU0xd3vjLOq1GPQt6yRuaMfHcR7ysDhRAtB3x6bO94fvxdZvBRODpW1PTqCe/hzFBcMXDUu0d1ob8WwQ0OzwTRKBfN631ouFMSahN9Hm0KN58WP6Qosb5SK0cRomKKpDo3aS6JkIsIvByoeUNzRASganqm+8jceK61aNsdJlLT/9taZWje6ybn7hPYILqdDa7hVqas2b4w4KWDytbxiugOdKIODBzkPBV1YVbC/pGZEdhWONbT9Y7kjFyFZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+UeyuIGKkbJcx2yTEhBHv4I/pHUAiE0F561bQ0t/9o=;
 b=w6IryXpuQHjMPXwgGNSUFlYfKPeZa4v38/KrnNfyDmWwpqbDlCOn4RmgL5JlRNOG+t+corWrTU26lZDs+HiSkUgAk+9qfKlhefLEwJxbRlyK5MGHBg3I+QmH2aOxD50t4/cECHeVQO/WTky/2o6TVPKC9wqcv6N4LH2mhbEEN2Fhml6KiwzdiIW5b+Bieqnp1XEvRA5PNKoe8hGTVgQrEiGMcX2WA9Dyuy3/RFISS9T8JQTB/OmaTGZedvrG7ySfW0WCqODkJeIhwjJ4IgY0UF839rybzLXle3OHsf8kasHLv7sZFkDDOtDctItMPc7bxzQee3c2/YbHLETd2ad9fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+UeyuIGKkbJcx2yTEhBHv4I/pHUAiE0F561bQ0t/9o=;
 b=rYsNcNiZXIQ/cBs/h+w6CwcWw75ej+FHnzK07lS68FbFufnQgl5/i8ORy0AkiTmH5DXdCvexfeZgiYCRx//J96yFKxYLU1y3UIwdZ4bxh3eew/kvpnOCAl2r+Y58eDXmBrq/3a2zTBdqPq6S0IpjjMR1EnXeC3VWFp8uEStpT7Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 05:15:36 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%4]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 05:15:36 +0000
Message-ID: <2f299f18-f828-4ca2-86ad-6f49eb2b485a@amd.com>
Date: Wed, 16 Oct 2024 12:15:27 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] iommu/amd: Modify set_dte_entry() to use 256-bit
 DTE helpers
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com
References: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
 <20241007041353.4756-4-suravee.suthikulpanit@amd.com>
 <20241007141756.GR1365916@nvidia.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20241007141756.GR1365916@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0243.apcprd06.prod.outlook.com
 (2603:1096:4:ac::27) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 26559480-9003-4d23-236b-08dceda19128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2xENjd3UERmT3VKV2lNSE5SaU56WXBGS3pldzBLd1lOTlMzeDFjMUZ1OGZR?=
 =?utf-8?B?bkZGSVJNZ240Rjdma0xXMlNiYTJ3d0lqTU9XRzJJYW4yTVlieWpaMFRvNzVT?=
 =?utf-8?B?bmI4a1ZmaGFZenpwQ0tIeGhWdXZxL1FXOVd3NzBYQVRBak9adDNIMUV4OW9R?=
 =?utf-8?B?dElUOXBuU2hyYXZFR0xuSXUwcHBrSW51RVNCT1Era2lYdkFKU1JKYy9ibndT?=
 =?utf-8?B?WGJvUldNRFBLZUc4WUJ2bFpyL3BQR1FGT0VOZ2JtL2FRV3BqWm1zdHVhWDhO?=
 =?utf-8?B?MDhYN0UyaWxFbUxjV3owdEFXRnA0OFBxczE2SVQzV3BXZHI2NEpINHBlOERx?=
 =?utf-8?B?U0FXbS83aW9VcnB5bXBDVzhCQzl4dy9BZVdjQUpraGNJaE1MTHV3dnh3Wnpn?=
 =?utf-8?B?dFlLRjE1N3lnS2xUZHEwV3FGd3lTQmFXSTA4VXJrQ09lZ3EwUlFnNWphdHlj?=
 =?utf-8?B?eG9HYXowVGR3Ny9jSllXSEVGMEw1UzZmeDE4NkZ1akVzeEpUcVlFdWJnRHRm?=
 =?utf-8?B?amhQL2syT0FVTWw0dElMSnYwSUh4WWlSK2JMa1dSajF1TXNWamlTMTYvZjZD?=
 =?utf-8?B?aVRvR2cxb2xMcHBJd2kvNDgzYXVlb1I4UnV4OG9mVUJRQWRITzYrcVN4cmNi?=
 =?utf-8?B?NEd3UEVSVWhqNElOUVRHaHl1S002ZTVEQ1B6QWpZOVlPdTB0WWdQSXIrZ2hK?=
 =?utf-8?B?NUkxaWsrc1J0YUZWNGFnMVRQY3dQOTVxcWkzcmI0TlpLZjJESW04TnpsUjVF?=
 =?utf-8?B?cncvNjU1Zldab1RoaWx3bHZjY2tPc21GM0tudkFxTzRNMk1JSlhYOGd1TWdT?=
 =?utf-8?B?Q2hSNDRucGprN2xVUndlQ1NiRnZDZHdTdkdCRVkyTU1YQXhNZVltWldITjdo?=
 =?utf-8?B?VUx4S0dKNG1XYW1iaUtlSlJlZyt2RytBQkhkSElMK2tSeGN2c3BRd2pUSE5R?=
 =?utf-8?B?NW5XaW5zczlxbmxTbEVaNzh6S3Z3YnNGVEFNTWtlM2lwNVExVDR6YXUwbzFa?=
 =?utf-8?B?NCtSMThuNVM1RUNSUHJwbmd4TGg3bDBGWmppYm5ydDNBTWlNOWZuV21nUTZV?=
 =?utf-8?B?cHNRVEFiL2kyVUlxSHR5MkcycjNPMUN1T21qQi9WUldTQlV4ZVFaTDlkR2Y1?=
 =?utf-8?B?OHhwNGNoNmdyZmlKUnBVdFFTcFZmVUk0RXdhWkQ3SUFEdUhQTzV2T1ZpR2Ux?=
 =?utf-8?B?TEM5MWFMNmo2Rlp1ZHUrTmkzMzFvTnFKRTU1cldSTVJuaXU5VVJySkdpVWUw?=
 =?utf-8?B?NS9aSVk5TFFGK2l0VTVDL3EwejVzb1dmdzRTRmFrQVQrZGJRNm9EbEtSQnNv?=
 =?utf-8?B?dzBsYlY3eDl5M0VCamsrWSs5K1pXQm14RUN0SG5DamNpNjZsZnYvNDY5MHR0?=
 =?utf-8?B?dkhZMTV5cHdVOExSQ3RPck80Q2Z2THJ0WFA1TjM2Zk5pSUtnY2c2b0FpK3hl?=
 =?utf-8?B?dk96dGtRY2NZYm81UTZJLzMyUlY1c2loQis5K21NTXkvcENtMkFWWk1ERERZ?=
 =?utf-8?B?U3VYSzBCMmJMSHFVcTRHdU4vNS9kTWhKcVZGZUdHMU44SzJUbDNYdVFPSWdE?=
 =?utf-8?B?RDdSaEpobEw4WXhEZXFIQU1BWFhqenJxN1lQc05tOHVYUVdrY29qNldtcTJz?=
 =?utf-8?B?WUh3amZkeWEyY09sbjgzdDJRN1ZiVk50VFR6Qk5NZzN6L3J4VFNiaGx3cWN1?=
 =?utf-8?B?U0Z2U0YwYUFpN1NmNmNlbzhkakI2R1JMcnlMbkNZUlhMU3BHU2szbzJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHl3Mjg5VVFtTDdoZ1phSmpSem1hb2cvdUl4NWlncUtGVG1RekQ2QW0yU3A1?=
 =?utf-8?B?L1RWVW5hOWZTUHVrd3A4Z3EyVXorSjNIYm5JMG10OThLckIwMnY2cjAvUXpk?=
 =?utf-8?B?UW5jNnZWb0FGMHNLRjlaRHdSWnNCQVdRNGE4cTA4YVZpL2ZUcU1YQkp1M2g4?=
 =?utf-8?B?TXUxcTcwYkZCSjFlczJMbDFCK1RBa0xxaklMNnpZcnU2Vm9SL0JMUi9CdXpn?=
 =?utf-8?B?WnlZeWJVdGI3aEh1NWo3TlN3UVBsa0tubmhlWWZuNUJBR1pLNmpCL1NXc0tW?=
 =?utf-8?B?endCOFRmNmYzdm5tR2UwOWtlUlM1SHJPcjI0NTd1d0t3M2gxZGV5UDZ6anlP?=
 =?utf-8?B?RjArTVZwV01mUEFqZUJ3a3NrTW5XVk5BT0Nyc21mZWhYMzZsSHE4Tk45YzVH?=
 =?utf-8?B?elpPQU1QRXVFL0dLR2ZzUiticXg2dTFiV2Y5RkIvMXQ1VmdXVXVJM3ZDU2lT?=
 =?utf-8?B?UG8yY2IxdlpQLzFrRlIyUWNobDJGUk1aK3RUWXBMZHpXOGlmUm90Um1Jc1NX?=
 =?utf-8?B?YVdqNlhEbUJLcGp3ZGp3cjZyWFRoeHZIT1dWYytvNndpTlRKM2xzNitSTGww?=
 =?utf-8?B?d3NOL1ZYVG5mTjJBeCtmdkxLMTJXMUxKUzFObGNKc1BQRHR4RUhpQnZwYVlW?=
 =?utf-8?B?dE0vWmoxUng1ZXQva1dNU081cUh6MlNkSC85d09BVmlja3FSczV6MVpqRXNn?=
 =?utf-8?B?TnhwcXp3cCtEc3J0bnRpaFgxdC9MUit1djJlR0hYSitBQ1VIY2w2K1hMUjl2?=
 =?utf-8?B?cVFleVRNVnhaNldiZ0dEYm14L0g1R252Q1cvcDNhT3N1SGJON2g3d091anFq?=
 =?utf-8?B?K1dtdmppN1JtbVBUeGlyM3E0RVU0bE5ORlFvSGc4TVI5S1RCSWVUeFM1ajdy?=
 =?utf-8?B?Vlk2K0E0dDlJbitwZVU2eXB4S2h6dWU3dkN4c0ZkcHVJWFNNT0ZQSHJFTUxM?=
 =?utf-8?B?ZnA0UnJTei90cWFwSlVXWk5CcVVPL01Yb0xyYWZrYWtPaXBWdE9BdUlwUXNS?=
 =?utf-8?B?aTNrOTRYeGMrV0k5c24reFlEUUxYbG45YnBlaTV0RUFSR1h3YVpjdTNaSHBC?=
 =?utf-8?B?T2pJM1ZJVGtpTk9nNWpnaHBMY0ZxamdvQUVkWUM4V200UGw3cGdjZzRyVU1U?=
 =?utf-8?B?K1VTeXg4VVlQWnBDeHJ3RFQ3dmltNGJBWm1ZemUxU0VCaGwxa1MwU2lyS0c1?=
 =?utf-8?B?MStualdobnBpWnVnNWkvWEd2dWZyd0xJU3JHakZQWmYvQXpUa3ZKM2MzYjFt?=
 =?utf-8?B?K0NxUTlyWi9WeEFTNVA3OGpXQXlkMlMvak1rR25EQnhnbm9wMlEzeWNubEp0?=
 =?utf-8?B?MVB0QVpUdFU5dTFRcXo0MTErMFMwLzVydWQ0VURnVmdLRFloWWM1Yng2YjN0?=
 =?utf-8?B?OVk3Yjc4R0NQcnhNaXZFdzQvR0FydXhVZDhENksvRDNjVERDZWw1VGN6YXI5?=
 =?utf-8?B?Y0RDRzZwblFiZzBuNHdTd1hJZ01GTlBMUEJpbzJ2akVPOU16a3hrdCtLVFJC?=
 =?utf-8?B?TmhhZnArUkxzSS8yaTlja0JQQ3BuZzhvQm9aalppSVh0bW10K3pzVTN4Q05t?=
 =?utf-8?B?Tk1UTXNWTzVEK1pLcnoxWlBjajU1ZHNaL1lKVnViSmhieXM2bjNlbk9xVk5j?=
 =?utf-8?B?Mnhha2RLNENWTUhiRTAxUjdzbGRRQ0xyeVNwcEsxQ3JCbHZKM1NETzBUV3hJ?=
 =?utf-8?B?RUZkZ1QybjNLaDRlUkhYUE9zSFVQd2lWeXhLbnMzdUxaaENjWXhFbnlyeG5I?=
 =?utf-8?B?QXpUM2JYL1JBYjdtOEVZQWt1bHBHbkFBUWhOVTk2NWJlcUdhZ2R3YlRpa2Zz?=
 =?utf-8?B?SlNzSmxndUFVVEYybWkwRklwT3VMTUxvZ1dhcVh5NlJ0RVBwYW81cnpiSTdX?=
 =?utf-8?B?S2NaZE5uRDQ2UUl4bUNNY2M0enVEZWZVL1AvOFJFUngyNjhIandVbjhXMWNK?=
 =?utf-8?B?Z2tsclcyT2w0cHpiRFpnUU1tNEx4am9OVTIyTCtZVlNjTUlzK3R6MUNFK01x?=
 =?utf-8?B?Qjdvc0EyczM1K2o3UVVUNDJnTjhFd2NoTEY3TGptNnBmSDkrUHpBQWRMTS9C?=
 =?utf-8?B?U3R1WjNlZWxmZTQ4ZnptbklDa1J6Y3ZSc3JGaEQzU1dFdytNQklMbUVjZXF4?=
 =?utf-8?Q?Qs0AFFDHPfiAmfNMeRSS/be8Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26559480-9003-4d23-236b-08dceda19128
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:15:36.1979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZwTcCMBcFSrCJsOWzga74IAEi1pfmPDGDS3n24cxqGo9+a3C518eFFdjY/fPvKN4PTmfx+RAhchcsBPluXyWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954



On 10/7/2024 9:17 PM, Jason Gunthorpe wrote:
> On Mon, Oct 07, 2024 at 04:13:50AM +0000, Suravee Suthikulpanit wrote:
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index deb19af48a3e..6fa2f5bb5156 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -1956,90 +1956,114 @@ int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid)
>>   	return ret;
>>   }
>>   
>> +static void make_clear_dte(struct amd_iommu *iommu, struct dev_table_entry *dte,
>> +			   struct dev_table_entry *new)
>> +{
>> +	new->data[0] = DTE_FLAG_V;
>> +
>> +	/* Apply erratum 63 */
>> +	if (FIELD_GET(DTE_SYSMGT_MASK, dte->data[1]) == 0x01)
>> +		new->data[0] |= BIT_ULL(DEV_ENTRY_IW);
> 
> Doesn't this need to be
> 
> /* Preserve set_dev_entry_from_acpi(), including erratum 64 */
> new->data[1] |= dte->data[1] & DTE_SYSMGT_MASK;
> if (FIELD_GET(DTE_SYSMGT_MASK, dte->data[1]) == 0x01)
>     	new->data[0] |= BIT_ULL(DEV_ENTRY_IW);
> 
> And this has a significant security issue, we can't set IW here
> because clear_dte must generate a blocked DTE, so TV=1,Mode=0,IW=1 is
> not an OK setting!!

I am reworking this part. I am going to introduce a variable in struct 
dev_data to store persistent value (during driver initialization) so 
that we can simply recreate the DTE from scratch w/o having to depend on 
existing configuration in the table. And it should address your concern 
regarding the IW bit during blocked DTE.

Suravee
