Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011005.outbound.protection.outlook.com [40.93.194.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6331731E83C
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 04:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786421651; cv=fail; b=pxX0z2eSm11OE2xSAXjqM0uAS9WWJjERW3CGvpP6bsnnBiLfc+bJLszisWWzjaHRDQ+OtGktRQMrTHP4KJZRsysRdn6+HbiDQbvv/Kv/Ya09chJs2puDOTQGoNmiWZnFnIbRFmnYeKdo+luPtLC2sc4qjw+U2O0tYGmOXgCkYYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786421651; c=relaxed/simple;
	bh=Iw6kEbQ97WXZgDqFLbMSxwv1d3rQmo57Ly70DZgesdY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iUOPrSxmaHwb8fkKmq9YIxl/ISwdcON6dgT/nG/DNHvBkvS0ZvoNSryPk7U/TqP7XQJeEdzCk/sMORsN99X9y5kyMl8kiVN9qMLjIRMuyb/xe1yh9FttGXVMc1SQK5XaqJqSdLZK068lQTiW0eNvZgmxlJoJsWcqxPIzLvv14qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lqYNWY9Y; arc=fail smtp.client-ip=40.93.194.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lqYNWY9Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GiJJ4FJOdr5dYmDFOOWgJIMhR0whuZGlDPnWs7sdMczpPn79My/VXkx9b9DPPMJIzyrwZbyg7hg/orUu1UptsGVRN80ZQo63bQbndoirzcTyDZ6lonFt9JrvDFjfdhaCfZ85PixeVUVgD5Ya7NgDAizXpyxBXd6umUkLEepWz42N4YQjc5X32wuZkc+tQVYQv2Oaq2fz1JcjjCePZ+gCz8bmimDiKb4v10LDhsCsHrZWHypDsFk9TB5MCx41ehQYXCzZWvi8nkXhYTQY2w4f5LrOV0OApwqcg4yrqf8dL8iwudDG7f9jyTfXvoU+ynZ2pQYgg0JXoblMdJGsCgtN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoaAbPatMxyAmprjrrB0C+FYQJDO1KUdXdv+0maFAE0=;
 b=qC846BvBBX4dztItCdv9wJ+LFzYvus8zHTZHN6/4jMtiT2BamMN2YDvNTU1AdlR8aP1Rkvvk7cxDL0fa9ZWGgNx8LFcrQ3ymZKoUlRjgeE4Z4z82v3knJCVuB6N4JQqrPbHDAJ6AQPH1vMbszEBBSU2ymjQHNmwN/PsME9FTrixWZaFXGR1MUSPWlJ5P0aP4fwaGr4Xdroam81SR2kx/5oTyvEJyv+MhLp3M0xZJEjsxPXv41pd3Q/HxFmYpW1UW7bfysJ1ngHMQlOm4w7XEcQgQ+Ya//zGoFyMkfIpMvfO6Y4GILW0X5W4DsWNmXHCTXuvZK/ztlZbbLY6+kLbfQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoaAbPatMxyAmprjrrB0C+FYQJDO1KUdXdv+0maFAE0=;
 b=lqYNWY9YrYW4Ymt23VCqV7D9cyYhGUDh6Jn2h2ThJXKHlbXZDEejXJBTjh9CgnoTlx1crqr/1CQDWDTE/4e6BXr60RBmOVFZYR03DkKDs9UmWnciys98BUUg77coZONpJYEXNp7IKcZQpHCxIBZqnTMg+yGerFgsPNzEQMvymgE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 04:14:06 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0292.018; Tue, 11 Aug 2026
 04:14:06 +0000
Message-ID: <b8c615bf-f30f-431f-bb36-9ca8e8eaa146@amd.com>
Date: Tue, 11 Aug 2026 09:43:59 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] iommu/amd: PRI related cleanup and fixes
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com
References: <20260727053907.7622-1-vasant.hegde@amd.com>
 <anmDjtzU643WcHnG@8bytes.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <anmDjtzU643WcHnG@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0239.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::16) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d44571-70ed-44a5-2a44-08def75efbec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	Nu3BcCuCAY1H7J/Lojljf0/gVinL75N/ssG0YZCCgeJn/OXoDlFNKpgJB7ze0d/9+LnIzZx6Nwul1iud+VOQ57BWXyGX/d6Wne2ZkAjtCTA2rh4Ybc3LitqPrFwswebWmF0fHJTxRjL0X9fgmOoJI9Qr0hSRxAFRbttIyARm1jg6Zm32pZ+JEBIA/obKV8WfFYnqShxcUyDAQh4sN8ZIT1s3pGiLw3jXPHrp9sk+1N1aeJiMA0KgdRlTq41dLV1FD20+Nr7PU1JvrSZ6lCZd8waJCxn7c5bNB8ZLDg2jlpNjsL0X0uBuueP0n6CqRIuLqq7pD2tSxYN2TCgipEMjS5NRsDdGt4atRxv5VIjmkqzHbHAN8gHQenBy2Yh4XAc35u06eS23nBUMluUSbS24Y1RJ/y9ag/ep3TpqLw5gFQX7p2jcbwTSY0wgqgssCwHwx7JIRkSZPB+MAqGkXJwxtlmB6ncY2W+IuLokIQ3oxdRqEloXD462JgzjP9UuRhYzYBGCV/jdi1QhLLqhCR/cm4+HzWKLQQui/sAOPfjnQVOoabhL11rE7rRQP8z0tsWy1sh/3J4qmYjm6PMYUdcJnFwV7ka5IXrwIWnK9m4hPw7ZsHnRY6XVBa/Gfuh4yQuFdlAI+PH1bjjjSL2g8fs+D0hC7/5lY0G9KtB2QDAqrew=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTlqR2FQSTJONlVYMWZWQmtqM0c5c0V2eFlDdGpjS29NOWdEL09aSHRFdnIx?=
 =?utf-8?B?Sjc1V2RQdkpwbzBqN1FRWkx6dzlpVVQ4RzQzdXlLc0Q3RlpkWDBWRTZaSXNi?=
 =?utf-8?B?SjBFWTBJaW5SY20rK2gyRDlkckZIbzVyNDFaTFhRMHRwM1ZYREErakNMWTls?=
 =?utf-8?B?YVh6Z1J2ZnJVWDRWblhtc2ltbWZDMm93MDI4ZXpUbTdaYXBFaWgrWWpjWFlB?=
 =?utf-8?B?M3pPRWhxK0orS3BKWWxFN0JEbUpacEdYY3FsNlhyRzdoT3BaOTJHTk9OZjZw?=
 =?utf-8?B?TXJRNGFaUFI4aVY0QmhSdlpGQ0RwN0RoLytmRFlkQWk0WThUaW9WQWZJWE9t?=
 =?utf-8?B?cS8yNGtpazNBZnB5dlZybElYbmZNRzlKZDJFV0swT3R1ZTBMdVBUOWRsOXR0?=
 =?utf-8?B?cmdqRDJxNVpMWFhuT3Nnc21obFdFcWZoaFZrS0xoNkJhVnFSQkJHRXBqdTdW?=
 =?utf-8?B?cmV0ZDd6SndxWk1IY3Zsd25mbGhwZnBsOWdSOVlBY0RSS0NuSE1DbWpZNlhO?=
 =?utf-8?B?Qk01NXk4emtQYmQvemlQcHZiNFhGMFJMNzExNDk1S1g5UFduSjUzb2ZWNlpy?=
 =?utf-8?B?VWR4SU1NbFIvRHJWeUZ0bTNLTkFqeWlFYmpEWVlFdXNsWnBBbzcvRHFBQk5Q?=
 =?utf-8?B?QmVyR1VZTUMxZkNlLy9jYk1sU0N6Qk9EU1FMamJiTy94dmY5SzR3RGl3dnFI?=
 =?utf-8?B?bmJpVXU0R2FrSXdQVnRPcy82eXhpb09DeVNVL0Znd21zaytPMDFnd3Z6cHNT?=
 =?utf-8?B?UHlZRVAweTZpOGc3TVhXRUJkSFpUamRxbDAxTGFpNFhicHQ3aGQ0enF6bnRG?=
 =?utf-8?B?WTVBYUhHUHFrWFF3WnF6RS9kcHVnQlR3dkVzMWx5TjZxdDJiQ09lUzYvVGly?=
 =?utf-8?B?Y243UWtaS2lRM1JUdllydUo0bVo0a0gvcmIrV1dDYTFwd0xubnc2T2FGQ2Rj?=
 =?utf-8?B?bGtkcXF3MmxncFpZdnNJd3prcTA4ckNqcjBmTmFiU0E1c2p4aW9GdTJkR2d1?=
 =?utf-8?B?a0tqT3BoajhvOUYyN2N0N01ibXlEL0pyWUVFQnR4b0RHcThLRWVHUko2aG8z?=
 =?utf-8?B?RlVCamU3alEyNWpsa1lxamQ5YjNwQXZFUHBGbm1vSWNyRFMvY0ZCNElCQXJr?=
 =?utf-8?B?bk1JREJxbUNVUFZSakhTdS9XVUdrT1dSeHlLa3FyQmlDNFFGTCtHQzdmalcw?=
 =?utf-8?B?Vkp4dDg5NVluamFxYVBNdFdMM1ZMSTluQlV0Z0JiU3haSWpQdys0WWFBcWZS?=
 =?utf-8?B?bm50cERKT2k3bjdHZGluMExLZ2pULzhNN2VjZkdSNkljWmJETnM0RlpuZ3BQ?=
 =?utf-8?B?S21xcm12bVMxOTVvWS9rQjhicjdJK3RQZldoZlhEb0pVYkw3eGFZUmN3QjVX?=
 =?utf-8?B?M1QxWXlDOG9ibWtnanZmMXBFVUJSNWovaDZ2cGZ2QUtjeW95L056SFBJam9S?=
 =?utf-8?B?SStqZFdrQnIrbWRDVmMvVUtmbmJVVnkzcVorUzQxOWxKY0xrdnFxMStabS9p?=
 =?utf-8?B?eGpOeEFuN2dJT0tYUHVEZ0JZODd6RVpVK0FzMEpMQktBNm0xbDlRbkJIU21k?=
 =?utf-8?B?UEJvak5zbXQrOE1kWFJaYXFwWEhMeFc5cThoVFhPWHIyU1R2aGxoZzB6bEpI?=
 =?utf-8?B?Z3FsYkFlVFlMdkVEWk5CWTBOWXNDU0c2NXQyZjQ3YURueEYxdVRndEdRb0lx?=
 =?utf-8?B?ZVJoVU5LK290cDM0SUp6citROUtCVU91d295Z1Vxa3MyVnZiZEdnUjY2dXYv?=
 =?utf-8?B?ZUsyeVVMQ2dRNXc4UGZyOEdLTlF1MmVUNmNtNzVYelF3ZmErWVhJZjRtU2ZB?=
 =?utf-8?B?L0RRMlM5aUxxTFc0OC9qaFcreVBpMzBVTy95c3hsTGl5WisrdkZMNDFBRHh3?=
 =?utf-8?B?SzBiZkp0TEtYeVJrVjRueEd6UUNONjhTUVFHak5hNlh2MjJ1cml2NkVNdWZR?=
 =?utf-8?B?ZUU4UWNxd0tCMEJCMGtwUEZhOTNrQ2NSZlVBaG9Zek9KK0RjMUx0TXU5RmFH?=
 =?utf-8?B?WXZoQjZiU3BYK1dkV09ySy9GdDlsN1EwVVllTHltNGJaVWdxS01CU1lyREQ3?=
 =?utf-8?B?dFBvaVZzMkwvR0t5V25GWVlYd2NFd3Zsa2IxR0JpQmZBUi91SGlkVmtzdSta?=
 =?utf-8?B?elF1aG9wYkJiaXVnb0xHN3RxT3EvVEk2ekVvTlVwcnpOWmlLNWxSVTRvQVVk?=
 =?utf-8?B?dDYxalBGOVFzbU1TYmpiTmVpM0RzN0V0andwQUllQW1FQVJudUJNZ1hJN2ZP?=
 =?utf-8?B?ZU82c1M5b0JlbngxWjhPOHFTMXhrTXlPcGEwZnFzMnY3NUlEdGpwNXgwQVg0?=
 =?utf-8?B?QVV5NVV2NERtRUVGVytVRk1sZ2xvR2RxYnJRSjYvaFRNVmREL1kwQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d44571-70ed-44a5-2a44-08def75efbec
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 04:14:06.0664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BrSVAw4luJMtmTvGyxyV/4X5Edql8FrwPqaFWvIUsnE9wRbOwKboiPmpSMmorVLIrCiK4ChxcDMDtajLqSVn3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830

Joerg,


On 8/10/2026 1:25 PM, Jörg Rödel wrote:
> On Mon, Jul 27, 2026 at 05:39:02AM +0000, Vasant Hegde wrote:
>> Vasant Hegde (5):
>>   iommu/amd: Fix incorrect device ID in invalid PASID error message
>>   iommu/amd: Introduce PPR_TAG_LAST_PAGE() macro
>>   iommu/amd: Fix missing CMD_COMPLETE_PPR response for invalid PPR requests
>>   iommu/amd: Rate limit INVALID_PPR_REQUEST error logging
>>   iommu/amd: Fix GN bit setting in COMPLETE_PPR_REQUEST command
> 
> Does not apply to amd/amd-vi branch, please rebase and send for inclusion into
> 7.3.

I have rebased it on top of amd-vi and sent v2.

Thanks
-Vasant

