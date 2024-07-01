Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF6614387F
	for <iommu@lists.linux.dev>; Mon,  1 Jul 2024 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829742; cv=fail; b=eGxP1fpeKmuVzWeCWmsnTpnwILrC/ADZw+d1EFE11Z5KQ37ulOexW3daJwtjDBd0JgEccRBwZlixvwuKlDXPiNQv5QVrhD0G+ctSPVN23kls+iI0RqLthpUFJUiz40yUaEALAm8VanotRXJB/kuocs4SJeG7odBg4Z3rPuhXmbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829742; c=relaxed/simple;
	bh=PHntMlErcPXQRszaXyESMWlhH23yPJrn+NgaN6bd6cc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bg1zwXZHjG5iYEg0abS4QuevY3bhkNc4fBzUEMCP9iVfKkd16dDb1IrpeL7QI/KbRJ942YzzF+EcIchkadT049hxPwN5CmyAsqS7DPs0btwCv/mTr/UUXd2ITTaXLJMBXwy6e4V0ut+LRvjVkraHyQ+JI6EJsNq1dDaPzDFGCTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UPPwZ5Nk; arc=fail smtp.client-ip=40.107.237.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UPPwZ5Nk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmknqOvI/KTxBdr0SCCa8/P/7nggLakswQEOVcFURBJuKxqqK/0VPiHUvEMlq1wMIUhriImc0wbWhItSP65zTyCAUDT2cRNR1EsgX94xEEO6RITW4m9rB65xqjeTJuC0xDLz92N1p+l1QwW138JuiRwp0lsOurgLR+S7cA/mY6gPdCl3/KyinfFCdRdWk4dbN4Dqfq/fAS8+/3obrr/ivvlfKBPScAoillAccYQo7xcfFdtadfsHeh9N9ru9Oq4J5V3s2XBqNGOHOCbNzb+eBHCwOfgTvaX4RB8t7BTFhr/RMia00HiDigXTNleksbR3YEvsespFYfgzvTxhrKsMeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJCqFVa68cBl2SJUFPa9TvKxDXSC5Mt88o8oOGUTUCw=;
 b=V23Lwjm3oMMepELiD/X85vuiJ587JuusgpVWf+kTPYsmM2PEDLmHKdvVe7djJn98Ki/xsMfPdiCsk6TcHMciZsvYll+x9wJ6j3g0tvWcO6wA+JNNmYEKNxcnT7bZbBSaO7hZwAyoZ02/NlD1CInfsoEycRfVocqTdbOh1MIsfg+u6KNlDHLz/dDS81XuN1VQsC8A6rCWaKxSjV0p2pGUisyDPkZ48bFvcE4rbZI61Tt1VNeR5my3fQi3Ci7cpEt3rn/76MFgQ+RXUzyScAMQANTAOd0WTvYvt4R3jSRo00N8L2KZYwHiYYv9bxyqhlfa8ZsQbh2WBrcXvXiTK+COyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJCqFVa68cBl2SJUFPa9TvKxDXSC5Mt88o8oOGUTUCw=;
 b=UPPwZ5NkAURBOVVvaBYm16IqbWanfz5Pi3xFWePSHdKFjX1VgWiQody4+RG/lmS6qewHOUHK1cx4M3zZrLAGjuGJXbrgq64XKeqUYgwZpHPiNzO0qknIr020g7WZ0CTfNTV99JOz2xu2ksAGt/ojiLXuKw/Z0GwhpDsjNN9q6VU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Mon, 1 Jul
 2024 10:28:56 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 10:28:56 +0000
Message-ID: <bb95c5c6-3441-42fe-a862-d1b68bb0a325@amd.com>
Date: Mon, 1 Jul 2024 15:58:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
To: Robin Murphy <robin.murphy@arm.com>, Baolu Lu <baolu.lu@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <ece72a5e-e4fa-4fe9-9d03-ad31d7a4b212@linux.intel.com>
 <903594d3-00c3-42f8-8003-eef30f110510@arm.com>
 <73e03875-cb36-4846-a3e5-c715a4c23869@amd.com>
 <a232872a-be56-4806-a3f6-09c889fa777a@arm.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <a232872a-be56-4806-a3f6-09c889fa777a@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0010.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: 545e9f11-6f43-418a-f346-08dc99b89c58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVgwU2NvUU5mZVkybDFQYmltVUxNdkFoVVhIRWhCSzJidVdLMmpzN1p6dlRo?=
 =?utf-8?B?ZWhORloyNWtmS0JNcWU4cnU4Ujd2WVNZcHBxclJtbEd1V2xDSUlIS1JadWNj?=
 =?utf-8?B?L1pRQkdkeUFPQ1BUaitvQlF2QnpWNVpjaWsvKzlYQWRpbUxSZndldmZBQ1Jh?=
 =?utf-8?B?NHFYcS9CaHI4YVB3Si9MS1MwL092OTZjVUI3VWwxYTF2L2Z1K2lMZDcyakJB?=
 =?utf-8?B?RHAyajJickJrcDBSWG80Yzc1Qlh3N2RBdmx3Z2c2ZmpmRkJveXI3Rnp1aEFH?=
 =?utf-8?B?RE1mUEtsYm9GZTV3Mks0TkZiK2U3OXNIRUZIbFR1YTdidHcwNVJsVGJpcHZB?=
 =?utf-8?B?QVZKYjlFNTNiRlo1SEZUWmplbkNWOUkvblB6QTY4SzEwV2JZKy9rWkRuZUFy?=
 =?utf-8?B?UUV5RWdlRE16Z0pLMmJHcjlZODZoNmFiQ0xDZ0lIc2tqZE1zRG1mOXc2TzBp?=
 =?utf-8?B?NDlwTFpMb3ArYmJNWlRpd2t6VGlGdXREK2FkME4zbE1zdEtNa3VEbHR5TU5I?=
 =?utf-8?B?a2JPOHM3SkxaY1hYT1dTUjBpY1RPRFJ4SmVsTUppKytZdXVTY3BYeFhLTFRu?=
 =?utf-8?B?cXZEQld5OXlWZkVSdnJ6Wkt1ZFowck9TWllMK2N6WHJ2ZXlFS2RmdW4xbXVZ?=
 =?utf-8?B?TGJOd0YxRnd2M3FUUTd6M2JobXNIdi9hRm9VQkdWbHVtV2dWR21VbTZFcjJj?=
 =?utf-8?B?b3lhVHJ2akFNWVNvT1FEVXpBZWtPYmRmdjI5M3dwTDZFcFh2NkdJTURhQWhX?=
 =?utf-8?B?OVQ5djFvRDRpRDdNcEs3SzdyaGdGVzFod3hETDVzMHFMYzA4cjVnUG5WYzNt?=
 =?utf-8?B?NnFmZGFHcEMwaS9KdENqejVSU1RNT1Era0ZObFA5YjJsWmhBQy9HVmRGNTRy?=
 =?utf-8?B?VWlDd1djUU9UZW1YQ3U5djRiQTh4R2NnVHhVNWxHOVZlZGdqNFd6bGZjNDF0?=
 =?utf-8?B?MXdIL29GOUplN1d1bDdjWmFYSW9rZnVxRzFQZXVtbUZwU2JJQVQrZ1Y3ZDFD?=
 =?utf-8?B?eXdwekh4aVlHbHZOS3QrbWVJNkNPV3BZYmZLd2JJYW1KWi92bng3VUpzTEZo?=
 =?utf-8?B?d3U0eVFHZVlxeDhhdjZ1akg4ZndCeXkwakFQZkQvWk42UFJZanRFNFd5Y2NX?=
 =?utf-8?B?ZkdsVVVIQk1BUmxQaTZQc1RjMkxqQXlkWExwTm1pOEYzdkRVWEpPeTZvVERz?=
 =?utf-8?B?MlowNHBJd1AvS29xRjFMYWxCVXlUbG1CU1RNcGt6UTN1bE9rcHBhVVlQdXNW?=
 =?utf-8?B?eUw2amR1MEhDdndIdDJzMGJBcjZQRXE3SE0xT1JoaFB4aTJrQzlSM1NHMkcv?=
 =?utf-8?B?WXJqSmErWTYwaDJ2VjlmbTBtbkNIdTJLZWZBbDkrakRQNWQwOXpOOXhzaW9F?=
 =?utf-8?B?cGErWHBHcCtNNzNtVWpKdGhLWFFpaVNTNlNGcURVN1hiY25HTHNCMmN4MVla?=
 =?utf-8?B?d2tLQjRYczI0UUxocnlBa1FMR3NZaHN1SG5MbW5RTDQ4RFJTaDFBakh3b1hi?=
 =?utf-8?B?QTIvZGZUYmlMZ21OaG82ME9JZnM4TW9mdXY5LzFSSS8xSWNvRVZYRDgyZkkv?=
 =?utf-8?B?c01DVW5RMytsL3ExTkR4TlFPTVg2aDZHbVZia202YkFXNW1zd1ZRNUlOTE5R?=
 =?utf-8?B?TU9RaytwQ3JiTVFFV3UxeCs4WThOSUxGS2U3VGY2bUw5T0UwZjVBcWVhZlk4?=
 =?utf-8?B?M29LSDRGZnFpbWgzcG5kYkVSM2V1SllUUFJDdVZIa280di80b28wVUUyUmpQ?=
 =?utf-8?B?Z0JkcEtQdXJiL0p6b3drMkM5MlNsSUNaYlEvQzcvVjIxWDl2Z2tYT2dndC9U?=
 =?utf-8?B?UGpXVDZ3c2Q4SEtJNVpJdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzR0NE0rUWx6Sk1wT3NFblhBTUFFbDZiZGVLYnp1VFBPbkZoKzgxRzAzQk5t?=
 =?utf-8?B?WEhLMU1obUZzTjBLd0hWNG9IdnZ0dGlPWDBKanZGU1ZWeWt1WDhMdEZuQUE2?=
 =?utf-8?B?dnM5djh5ZThkVXdmQmQwc2M2aTRGYmRTa1ZjajdQbWxBUnlwSjFVOTM0QjEr?=
 =?utf-8?B?UUxVbnRHa0dWdEovVFRCZ2Q2Slc3VWFhUktoKzVtd08xUWJCQ2VoaEo1dXRW?=
 =?utf-8?B?Tjg0V0MzeWdKaGNQMmEySU9NdEQ4YkNpU2ErNTEvaDdJZ3d0UkNPS3l6TDdN?=
 =?utf-8?B?Q1BiUDZjblJGeEpTYzdFcVZnL1FwRzlyVEhic0pSeGxiT2Vmb3Y0OTgyMGNN?=
 =?utf-8?B?d1hpTDJJc001a1I1czJIL0FiQXRhN2dkTXNxTW1EYWJVakI4U1Z4RHpHYU0r?=
 =?utf-8?B?ekdHYzk4blBObnJPdW1uWEJLYjVUUkw5cHMrdnJVTHEydkh2Z3pJMndUSm5n?=
 =?utf-8?B?dU5COUtxaWxlOXVwbUFTNkNuOHhTRlBER0RVd3YvNThuVGQ0M01jOWtIbUd2?=
 =?utf-8?B?WjM0aUxrUmRHNGFEV1F3dmtva05OZTJxZVZSbUR3WjRvME1IbENsQjR5UklT?=
 =?utf-8?B?TGNuVEJvVWdHaGJQWk9Kd0J1OGZYTW44S2x2RWl5cFFOT3BxNWNKb0poR0Ni?=
 =?utf-8?B?V1FWTGRZQngzNUF2NG5ZQnNYNFZZc2NMcVcrLzExUVB6eUtCZi9tZExObjNq?=
 =?utf-8?B?MkFYSCtmVFg5ZjRLOWNtdEdlY0VDclBBSFExVVNpVUZnVHNITnJNOVRibUhC?=
 =?utf-8?B?SlJsdVhsQ3UvcWlsZXNUaXVhU1grYjdvTHE0TTNSSWZmUzVmN2dRbExXVEhm?=
 =?utf-8?B?MmJna3JvUUNLYXcwUTRoSlUzQnZZUGlMR25Dd1c4bnA1by9helJmenh4UE1p?=
 =?utf-8?B?Q2FOaHBVWWRmVjlWaGFZdk9HcDdyVkZCanBqSnY3Q1JqYWZOZ0JSTkMzU2d2?=
 =?utf-8?B?eTRQRU1pdVFDTnhJNWFRWUNDR1BMWWc2bUJuU25jaVB5MkozbDhWeFZnMTU1?=
 =?utf-8?B?TC9KU0hmVTlyNlVIV09nQzlJeThRbCtLcU1PTkdDRHJncStSdWN3QmhEVDNP?=
 =?utf-8?B?MVhKRmJPaFBjZHZhU2x0T3R4eERQbVNib3VoeGhRVEFRa251NE9sdjhLSmlQ?=
 =?utf-8?B?T3k0bXc5dU1JdExiSmloSnppdG5nc3VNaVROaVJXQmRtcWJLcE1DNlpSblFT?=
 =?utf-8?B?UWVwSFpkay9OYWs4cmc0ZFRmWFdqUjgzbnluOWtveXR1MVRCQzBIOUlHNlpJ?=
 =?utf-8?B?ZUMwaUlWQlpUWXV1elFPK0pQMzN0MFRaZlo1TGtLM0M3Rnl5Z3FOcm1sN0s3?=
 =?utf-8?B?UEFyTUdaak9CQXp0Q1phdm0reTdhRGE0RjdIRmZ1dExDNjZNK3dwY2czbUt3?=
 =?utf-8?B?NHpWN2F0UTA5ZUZzMktuYzk1bzEzQTN1dDZNR3p6anZLUTJTT01zMVZyZ1lC?=
 =?utf-8?B?cThtRm40VkNvSE94bDVqUUh6Mkc1eHNic1BGaU1VV3pKTGVDSC9LRFVxUEVN?=
 =?utf-8?B?ZlZqVm9nNlg3NURZaGF3TnZsQkZvUG9LanFwY1hiVUNVaDNYQkJwR0pvUDNv?=
 =?utf-8?B?MW5EYXUyMHRNQ3VhdEZjNmVqTmhlT1lBUUpLVXZFaThIL2ZyNnRjOVNLZXl0?=
 =?utf-8?B?Q3FtLzZXWHB4R1hVZHBMMXhxTlRsc0tDR1J0SEUwVW5ZamprbEZ0bnFQNm9D?=
 =?utf-8?B?eUV6VE1RYnhvak1kdWlBcXV1MjQ5NS8zYWVXZ0lFU0dmeC94T2xiVUdhYk9U?=
 =?utf-8?B?U3R3bnkvdzA3RE1xWGhZYmgzaGFhTjZ1N0dUb0JPQnhKdjJrWkZSL2I5Y2Vl?=
 =?utf-8?B?Yk43aXI0RFMrZ2R0M1JuTGw1Wmd4bXVob01Pb2lZb3RKK0NuZ0I3dzYvcU9v?=
 =?utf-8?B?K013ekJ4M1ZpWmYwZkM3bzN6bEtpOEhLNFlaZ1VEWm5ZbWpzOGdaTHd2TWhY?=
 =?utf-8?B?U1lTQjhkN25nNmR6QXhzQUxjTExacUkrQmUwRVF1amd5ZGIrQVg3bHJHcytl?=
 =?utf-8?B?ek5udVYyMmE1ZU1RQUcySXBaVGRwYlZQY0lVZVMwOGpaVFFNL1pzRXMwazhE?=
 =?utf-8?B?dGl5Szlqd2JMblFzRHczRVAybUs4THJlazA2S3QxTXZPS3dWb2R6QUlrRWtB?=
 =?utf-8?Q?a2xPIHcrv9zNb0bBLSCCCfbUU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545e9f11-6f43-418a-f346-08dc99b89c58
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 10:28:55.9558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6D4bZxBWzqZKQZr8ETO8xSjpS0EUSfm2CuWFhad3NBpSTlCYV5mkhwUC95w3Nb5jNByJ5dE5icUGZ6bWBIzcaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032

Hi Robin,


On 6/28/2024 11:28 PM, Robin Murphy wrote:
> On 28/06/2024 6:08 pm, Vasant Hegde wrote:
>> Hi Robin,
>>
>> On 6/28/2024 6:36 PM, Robin Murphy wrote:
>>> On 28/06/2024 1:23 pm, Baolu Lu wrote:
>>>> On 2024/6/28 14:43, Vasant Hegde wrote:
>>>>> We are working on adding domain_alloc_paging() support in AMD driver and came
>>>>> across below issue.
>>>>>
>>
>> .../...
>>
>>>> Add an allocation flag seems to work. It doesn't indicate any type of
>>>> domain. Instead, it indicates the required iommu feature.
>>>>
>>>> Something like
>>>>
>>>> #define DOMAIN_ALLOC_FLAG_PASID        0x1
>>>>
>>>> means the allocated domain requires PASID to support on both device and
>>>> IOMMU. If the hardware lacks this support, it should return failure.
>>>
>>> Yeah, we could do with something sufficiently general, as we'll also have a need
>>> for passing pagetable-format options through to drivers to be able to replace
>>> iommu_set_pgtable_quirks().
>>
>> Sorry. I doubt I understood it completely. You mean to say:
>> Enhance iommu_domain_alloc() such that caller can pass any special quirks they
>> need and then pass those quirk flag along with the other flags we need (like
>> PASID support or not) to indivisual driver? So that at the end we are remove
>> ops->set_pgtable_quirks().
>>
>> Is that what you are thinking or something else?
> 
> Basically, what set_pgtable_quirks does currently will need to be known at
> domain_alloc_paging time in order to convert arm-smmu to the latter properly.
> You don't need to worry about the public interface for it just yet, but if we're
> going to start extending the driver-level interface already then it would be
> good to plan ahead for what other domain properties we may want to accommodate
> callers requesting. The things we have as io-pgtable quirks today are definite
> ones (and those would happen to be OK as simple flags), but it's always seemed
> like a good idea for callers to be able to indicate their preference for other
> things like VA size (or even full domain geometry), even perhaps specific
> io-pgtable formats, such that the IOMMU driver can make the most effective
> choice about what it actually allocates.

Thanks for explaining. It does make sense to pass enough details to individual
drivers.

-Vasant
