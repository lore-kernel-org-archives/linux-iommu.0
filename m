Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A911B653F
	for <iommu@lists.linux.dev>; Tue,  1 Oct 2024 04:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727757104; cv=fail; b=gTmIUdjFe73YMB7Kh9OsM4ANj5vA3gfqDkCVpJrtcFoN5tOttsEI5wASguQ7SmOnR8a+BhsKVOig6umFb4MT4OzJNuD7Iw7jmgfSBTwNSwWPERtzh/7Bwj3xayExuukCQCPue0DLVHtFVDeXwLxwTucAN9P9ffeu2Fni64D7N0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727757104; c=relaxed/simple;
	bh=xV9PkJwSwsneI5GnShvki0T0NdNgRbcEeSC+xG76hU8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jtQpxtdW3hdFcsrWAw9rIUO/6D8GTtWBY7VFPkhBRTWwKsYVxKFCUwYB0t4djUG24znGhrExo6vuHdDqJpXmDsZQQlDSIVYdwN0cIj45smLKNDRyf3LMBS0nJduUisRTj0pNMSSVjeUtXfqg/eLQzYDEw3Ik1y6i7J4h9yXpJ8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tLAoq8SV; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tLAoq8SV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5KbZiEJwXkRIyvVvVvWrGQif4iOQpTptQw4Sz+2lycAPX6XsgtL8OrOuuOcBx2v/nZgG7mRxmecg/OiTAzWAcSc1pXHMWxCh32wpwCUPPyROaQ8LV/K8gUeEahlwdRdobtSlLVUkOpf0N+kMoWQBp/xgMDzRXoWSIvdFWUruLLL0b2nrlETPyq+obJwFdiOaVhFEDmn1HbA5EKcGXS2gAa++QzfKmm98Dv1nKuofytOYpgFVSH7oTX7s16aTH2+Fy+3kMml2pGUXIfJ/PkVoQzbKv8rLpZikmpjFNxCWk4QJjh2seUSe6g8/b1S1f8YmeZMncfhlyeQ11cphhZFVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wn2L1DuRUrntrPJjIJJYFoIAGWrsv/v1wQowxm3kL5I=;
 b=rQy0c+CGEtko6rdIutIkPwM2nHwhGBNQggKE/muwDZKHXDpGy+Wc36NzhTMktw9+CD//QDBNatoFOYNNBLLQoYAxhdJ8j2SRLNJtEe8fN488eHYFnywslckR5xKsUNWdwV7MuolbK9WOxs1qvkwh6nQFgr3Qhfftl1qO9NDxbD664xAcGR6qv4flYg5zNjgOIdRs+EJ+DwcUxfGqLOJRhKdE7jfMPqvuDXcbrMFkLNdl303fnB88T/iKwUM0JpJWamZs+SmsMqpqeiehteBJnIgprzmH0k3KPlC71OrSvqiXieoZ8LrkuVjvwDolEngIh9l6pyrcqmAwh1Ehz6wj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wn2L1DuRUrntrPJjIJJYFoIAGWrsv/v1wQowxm3kL5I=;
 b=tLAoq8SVJKyPonkXmFZLPnE7k1J383V2y4C2ex1RAIGUCW1sujTXe08yTbMyfLVQsSBs6VktPimXLm40MauTFBPXUak+20ozHtNdgWfjIhdP4ekXUJNkPOjBI8EmuVd2GPFlZDHm4slwVnVccarv9mxBATq3ILdjEvyxOakT0p0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH0PR12MB7789.namprd12.prod.outlook.com (2603:10b6:510:283::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 04:31:39 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 04:31:39 +0000
Message-ID: <71b99515-6810-4b43-bae3-bc2fa7eeeda4@amd.com>
Date: Tue, 1 Oct 2024 10:01:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] iommu: Refactor __iommu_domain_alloc()
To: jacob.pan@linux.microsoft.com
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, jgg@ziepe.ca,
 yi.l.liu@intel.com, baolu.lu@linux.intel.com, kevin.tian@intel.com
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-2-vasant.hegde@amd.com>
 <20240912210207.4ba164c2@DESKTOP-0403QTC.>
 <d092766e-bae2-4dd0-b274-69fbf5c27971@amd.com>
 <20240930105523.51fee7c1@DESKTOP-0403QTC.>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240930105523.51fee7c1@DESKTOP-0403QTC.>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0196.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH0PR12MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: 435afbba-5aed-4c94-6152-08dce1d1f149
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWN5Y1FRTkdrenFCeWhTb0piSEZOMFhHc0YyeVVIeUM3TkNYUkxOZzdOclNZ?=
 =?utf-8?B?S1lYQzFBcHh5M0FtUTZNbVdMeElzSzBnaHRRMEdRdkEzNEVORmo2a2g5VW9W?=
 =?utf-8?B?QThZeVNmckV4eFE3MkQ1T3VOdklIY0hHWklRbWlTV0t0TWJ2K1EzZSsvY1Ru?=
 =?utf-8?B?QTQ1Vk1EQ1hQT2lPTWlnc2ozWDQ0MG9GQjUyTVdWdjFQWFhyc2UzRVpQY1lY?=
 =?utf-8?B?K0FRdktTcWVRNHIrb2llUFFGeUlMVkNmV2dHTGR5QjZ0YU5qM01jMUhGMTg1?=
 =?utf-8?B?aWxNN0ZSY0hybG8zU3I4dVJGYWwrS3g2SkFHZ01XVXlYTVoxRDZITTZaZTd1?=
 =?utf-8?B?YjBhbTlFMTV2VWpka3FlaFlmanducll5WW5PUjlzTzFidmtsWUZwQVVpMjE0?=
 =?utf-8?B?aG1JZjg5eitWZVlYM21uajhFOXV2WDVjM2xyR2lhV1VFbFp6NGJXbmYyNm1M?=
 =?utf-8?B?MFFtSGJuOW9VTEZkNFlZOGZkZFhBUHhZMnBCWTBpakh2VE1BY2lCYlVhbDMv?=
 =?utf-8?B?ajY3Q2dxT254NXpobmo4ckNKVHJLNDJQaUh0Uk1tTFhsMGVLSjZxbWRVNExy?=
 =?utf-8?B?ZjViSFJuM0xxZmdRTUhlU0xVb0pXRjZJdEhmcG9MV2lSNUFvZ21SNHdrVkV1?=
 =?utf-8?B?bXd1YUtaK2Y2S2F0RG95Rkd3SlZiYlVNUElSRFFFMVgrM0IzdjhEWWEvRzNC?=
 =?utf-8?B?ZFNmNWh3bTRTQkFVbkt2eGppTDU4eVNlR3NHZDZNeGZPemI1cXByNTFVelBG?=
 =?utf-8?B?b0UzU1M1c0ZNdjFVMGN3cklSZUtZNmdjdXZ1TDJ1Smphd0FqUHlvM09yQnpt?=
 =?utf-8?B?RjJ0S3l3TEpadUJNUzQvam92SzZsVWFCWmF3cGVwNjZTWC9RN1oyODZ4Qkpv?=
 =?utf-8?B?Q005UmZRenE5WTlIU0hlNEJRME0ybTV0WS9JNjl6YkRsUCsxRVMwTXlRWE9K?=
 =?utf-8?B?M0l5eVZlNWI3aXNXRkFMbDIramx5THVkYTRrb1A5TWEwSTVTdlluM0xROWJB?=
 =?utf-8?B?MmVMbmFjeDdvTmQ3QTRrWDhzU1M4RC9XTUVYQ2R0NXRBZ2VRRUpjNnkwYkpB?=
 =?utf-8?B?YjdNaVI1cDFxMmZheUJhck9aVUpSOW1pRW9jbEJRS2M5TVNoajliT1dvU1dI?=
 =?utf-8?B?bk5MR2N2ZzdVa3hOd2JHTkk1dE5DNTh0dDdsdzZHMjMyODE2UWtOR3hHT3F1?=
 =?utf-8?B?a3pwZHNybmNGSCtKNCtxY0JBekFmL3pGZnVnYlJkemhNUjBaOHJvQmcwU2RS?=
 =?utf-8?B?WUEwcUliOGsrNmptaUlBOXB3ZHdwWi8xMDlod3B1UUxaMDFPRWFkSjRqYktF?=
 =?utf-8?B?TG1uMVp1RENhRFZ0UGdKaENJYWZZVFp2cFBLcnlWQllZbEw1NS9HeGhJWGNC?=
 =?utf-8?B?NCtGeGhRbUtMQnVhQWN5UXhaMkVzTmNzUTc3dWUvVDdHSUwyYU5kY2VHQy90?=
 =?utf-8?B?NnNwcVExSVVFSGNYc0tSVGpTQmduVURiOEFGOVljNGYyNVIwY3pQT2N4OUNh?=
 =?utf-8?B?dnF4U0UxaHZ5YnVIOGU2MFlYQU1kNSs2OVArUzRkVjRlRGhBNTBLeGVmZVZp?=
 =?utf-8?B?ZUJlQlFxSytiWTg5aWNsSEhDeWhpVVpuN1ppSmY1ZUNxSEsvMW5TQWxqenho?=
 =?utf-8?B?d1Bvb1krR3NGcEd6bHprOGxHTEdSNGFoeFpxZ0VvRXJqaEk2VTUxVExnZTk2?=
 =?utf-8?B?YUswN1pkaGRlLzk4VHFZaXI1QUlSd01kUmRmN2ltUHg5K2VaT2RRNUNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0Ezc1BWNHM4dUpud2Rvc2FtTEQwNjJ6TmRMaFQ1Tk16dytPUDNuTGtMQVkw?=
 =?utf-8?B?RE5BOW0zb3JsanFBbHlUZmhNOWZ1RHBZa1ZRWGVQTFA3Y3dsTEZKVGgyclBv?=
 =?utf-8?B?bXY0UStOdmJtS2U2SGE5NUs5TW5tRWlyY2swQnJTYkpYUmwwaDFOK2Z4WllH?=
 =?utf-8?B?dExxSEkwVS85MmNTSlJWR2hZSWJiQXJHeXlXdGxGV3krc3JRdGFVSHhBVVpQ?=
 =?utf-8?B?Q0V2Y3ZnQ0Y0U003emoweG5JaCtGUnl1eTBER3lZbFlqUGRjeXovazYwNzdK?=
 =?utf-8?B?RXF4a2gzTFl2MjFXSUlBTExra3RrdkRxZ0x1UVJ2VWxVQXhzWmdYQzFQcnRj?=
 =?utf-8?B?RHU5bjRKcFlRdUJtU25NVVVnV0pqRWpPSDFsdG1FR3NOUmRLUWtMbnJkcXE5?=
 =?utf-8?B?QmkrYnFwb2pUU1daaTBIR0lFWUJUbm0yZGNwSmFnS0R3OGp5U3pzSEFuTTNG?=
 =?utf-8?B?YmdzU2IzQldCa2ZOZHF5VGFvM2NJbjUwWWhkZk1aRE1ac0FJeVJDSEo1cG1m?=
 =?utf-8?B?RDhCTDFQMkRRQVhva3RJczZDMTJvSmlNeVdubGV2Zko1bUtORTB2cGpKTHZz?=
 =?utf-8?B?K1pwTzVXMDl3RzdxUU5wU3Ezb0Q2UzB4VW9xeVBwL3FmSFAzOWI3VXc1OEY2?=
 =?utf-8?B?UEhGQ1ZLV3BjcitTSnVLbUdoTXFobnpsNjB4SGZGc3lnNlRIOHYyMDJPd0Jq?=
 =?utf-8?B?VVA4QVA5UDBOWWQ0ZVMvUysyZENoODN2VXZ0ZU9FQTMvMjE5RHo1STRvbkcy?=
 =?utf-8?B?MG51UTZmR1FrUndnUlQvZWFaY0V4aVYyMWR2OUFmMkFNS1BkV0g5Mm4rbGJs?=
 =?utf-8?B?VS9pK2xnYkNUcFZlais1M3VEaHAza0xrcHp6RWd3Yy9vTWhtRUcydWF1cjlr?=
 =?utf-8?B?SUtCYjFHdGlBbTFhblZ2VCtaK1Z4bHptd0haQ0FBZVgzcDNXcWs2VG54UFJo?=
 =?utf-8?B?UUFNWWUvUnNrcFBnL25wYVR3N29YdHI3VE03ZzB2d3BoZ29CSmYxZDdFTWxB?=
 =?utf-8?B?Q2lDQkhRVXV0eXI2L2JNQ1RKMTFUaGNyeWpFdi9GYjlZTFh1MlUwWVdBeGNs?=
 =?utf-8?B?WHFEZnptSlQvSG5NNWpWcTl6ZXcwRHRoOEdsUVptSjk3ekttTTZqSjhONFZj?=
 =?utf-8?B?djZXMENxTDBsdldIWjJGemw1U21Qc0xnTk9xYjhxSndXcGdVd1RxblRPZlY0?=
 =?utf-8?B?dlpPdnpMVVZOUnlEMDhpYU1aUXFVcS9BREl5Zy9kc3hFSEdLcW15a2JLdHpW?=
 =?utf-8?B?bUZIWldZQktISjY4T3d6SEFCc2h3K2x3ZEp6bGg4aHovdWFhQVZYbzBSelhn?=
 =?utf-8?B?OG9KM3A1SWQ4ZmJ5ZitRYzJIL0JEcUtaRUtmQ1JQK1FtYlFFbVFYWTJleXRa?=
 =?utf-8?B?SzYvZngxNC9HU205d21qYXEyT0NqNFpDbmhTczkvOUlmSGVOQVVxbmN6YmJk?=
 =?utf-8?B?VXpCUmlpdzFsYnlSbnZEVGhEejhxaDQ1aHJ2Y1Z0R01zeFpOQmxkSVR5aVJv?=
 =?utf-8?B?clZvZ2tnRVA0OE9kMFo5czBWa0RHbXA1SFZyZGNkYkFBczlGdHpBQld6Q1BY?=
 =?utf-8?B?bjduNm5MazVPd3d1UDFWbm04S0kzQkk2Y211LzRMcFhKR1ErMVIxQUsySXhL?=
 =?utf-8?B?ZWJjZ250RCt0ektKU2oveUowMXRWOUlhc1k2TkpqWjBQVHpKekZ1ZXNJRDVT?=
 =?utf-8?B?M08yNGVldWVzY0FtSFNtUnJMbGhKcncwMEpkR0lSdGlPbVBZMno1a2FBWVJU?=
 =?utf-8?B?M2FlcXZnQkh1QW1LdnJwRUV0ZTNTaDFza1E4QmJjVHZnczFZaDRSYVhGSlc2?=
 =?utf-8?B?VFg4SlQyM3Z5MXpkWEp6dVlqYTJkcE5PUnZGS2dOaVE3MHVDNm51c3hKTkFR?=
 =?utf-8?B?MDV6NHNvNWpYbWpJR0tXVE9yTUk1MzB6Rk9BMjNMNmtpSTcwK2pCZFI2cEMr?=
 =?utf-8?B?aEhPckpLOC9wSFIwcnZLb1praUdVY1R4QmpxM3hwYXdHeUFjU3JBcnVUK1RZ?=
 =?utf-8?B?MnpTVjN3Yk11Y3RiKzc1bFNCazRNSWNGOFh2VU1vRlE5eXBaSkxscE9QSExN?=
 =?utf-8?B?WjdzNUxFOW1lMmxJRFJSZ2R3ajdDa2tXc0cyeTl1SGx2Mm16MXVXaEl5aWFN?=
 =?utf-8?Q?qHXkqMUpgavhv2//J7DGXhuBY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 435afbba-5aed-4c94-6152-08dce1d1f149
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 04:31:39.5376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FxonZ6GEIVSf+wB4x7aO2ZjGrrOF7nCo/omcDjSAB31py/09nHU1tc99Bjhttr4Itup2Pi5UGW4qLO4BW8T7Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7789

Hi Jacob,

On 9/30/2024 11:25 PM, Jacob Pan wrote:
> Hi Vasant,
> 
> On Thu, 26 Sep 2024 15:47:48 +0530
> Vasant Hegde <vasant.hegde@amd.com> wrote:
> 
>> Hi Jacob,
>>
>>
>> On 9/13/2024 9:32 AM, Jacob Pan wrote:
>>> Hi Vasant,
>>>
>>> On Wed, 11 Sep 2024 10:19:04 +0000
>>> Vasant Hegde <vasant.hegde@amd.com> wrote:
>>>   
>>>> @@ -1962,27 +1978,7 @@ static struct iommu_domain
>>>> *__iommu_domain_alloc(const struct iommu_ops *ops, if (!domain)
>>>>  		return ERR_PTR(-ENOMEM);
>>>>  
>>>> -	domain->type = type;
>>>> -	domain->owner = ops;
>>>> -	/*
>>>> -	 * If not already set, assume all sizes by default; the
>>>> driver
>>>> -	 * may override this later
>>>> -	 */
>>>> -	if (!domain->pgsize_bitmap)
>>>> -		domain->pgsize_bitmap = ops->pgsize_bitmap;
>>>> -
>>>> -	if (!domain->ops)
>>>> -		domain->ops = ops->default_domain_ops;
>>>> -
>>>> -	if (iommu_is_dma_domain(domain)) {
>>>> -		int rc;
>>>> -
>>>> -		rc = iommu_get_dma_cookie(domain);
>>>> -		if (rc) {
>>>> -			iommu_domain_free(domain);
>>>> -			return ERR_PTR(rc);
>>>> -		}
>>>> -	}
>>>> +	iommu_domain_init(domain, type, ops);
>>>>  	return domain;
>>>>  }
>>>>  
>>>> @@ -2965,6 +2961,14 @@ static int iommu_setup_default_domain(struct
>>>> iommu_group *group, if (group->default_domain == dom)
>>>>  		return 0;
>>>>  
>>>> +	if (iommu_is_dma_domain(dom)) {
>>>> +		ret = iommu_get_dma_cookie(dom);
>>>> +		if (ret) {
>>>> +			iommu_domain_free(dom);
>>>> +			return ret;
>>>> +		}
>>>> +	}
>>>> +  
>>> nit, if a user changes default domain types via sysfs and the
>>> current domain is already DMA API type, i.e. DMA to DMA-FQ, I think
>>> it causes an extra round of iommu_get/put_dma_cookie() compared
>>> with doing this in allocation time.  
>>
>> DMA -> DMA_FQ will just initialize flush queue and exit. It will not
>> enter iommu_setup_default_domain(). In case of DMA_FQ -> DMA it will
>> do new domain allocation. Am I missing something here?
> You are right. No extra get/put_dma_cookie there.
> My other concern is that this change made domain alloc/free asymmetrical
> in terms of get/put_dma_cookie.

That's correct. And this should be fine right? These are internal functions.

-Vasant

> 
> Currently, we have ftrace like this when I do:
> echo DMA > /sys/bus/pci/devices/0000\:38\:00.0/iommu_group/type
> 
>     iommu_setup_default_domain() {
>       __iommu_domain_alloc() {
>         intel_iommu_domain_alloc();
>         iommu_get_dma_cookie();
>       }
>       iommu_domain_free() {
>          iommu_put_dma_cookie();
>         intel_iommu_domain_free();
>        }
> 
> With this change, it will be:
>     iommu_setup_default_domain() {
>         iommu_get_dma_cookie();
> 	__iommu_domain_alloc() {
>         intel_iommu_domain_alloc();
>       }
>       iommu_domain_free() {
>          iommu_put_dma_cookie();
>         intel_iommu_domain_free();
>        }
> 
