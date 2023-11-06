Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2060.outbound.protection.outlook.com [40.107.212.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA1018046
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 11:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wrz1h8D6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ES2zK9pdfzA/0WCp6tXyPkX63yuwEGiNTf+8Oe7Omp33XvWDxQcw29t8bLJQEPYhqo2+3i28Pp9GYwxBsZdzpaRyYpq8CItjVoUd3OQdRpKUaqsVb6LuBu5KJNVYhOBxX67FY3dEqkjbxKEcFG3ud8CGYxH2Lp1Nm60tBMuQp5VHq3JQeFMgI+r4nAj5G/egUdXu3mw/f67V6w+UvIEP2cScOLBiUsGtFrl7+j6rC4j8R8ESM/7uk1tEattZk9FvXhRRmuejcr764hviO5CKiri7Q8iMrNikTGwo8uyvLLFGxNooySNbYSo7rmOWNbUkMs3GtD3saFKhBgG7Bh4MIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMvLIQdKPc14XPIftyV+3f6HAMTwZ2KkQ4lLWLUQZao=;
 b=ElfthApc4dAjwNUokra+WMx9rmB7Db+qoNeOlN/uQx9Oj0ibfhFCDbQmp1M4lguPsOXA1Nb1vh1l/tbuHFBDZPrAGkZ1/tKGhfRGhWzeu8oZl5JS0AXHRexfWjIM0WnfvYGnqtJbHmrZD3hNIGl+wwE73LrZfG1kgfbZ3CZc+90BztDdBLVhe5uElib9ZkKoN+gegsiYAplpeV8jE3CJAuTMwklquTnYCrxFxzpORYAUeiLwWNjeTntU7HHDkNc8a+Edsf+X6JNwHo25qIPBGJsartAN4eMzkG4SI/dgbzGWw3oFg4cYfm6pu8V5Rqde2AXOe1qAU6CWEKFO/PEGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMvLIQdKPc14XPIftyV+3f6HAMTwZ2KkQ4lLWLUQZao=;
 b=Wrz1h8D6KTRwBDNTgcnMl7ocSEhI8HiNRC4oUtrO9TflAFUpZmY5EgPqNkV+CuO6TMTEuncoBCO8NXBcZ5Q5doF8em2HwJw8OgygcRoo0eeD5mJ9FcmTOX8beC7rotKKrwDmMIsgUqXcqCgg3NkA6JZ0E/SvQiE3B9WSn8sN084=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BL1PR12MB5207.namprd12.prod.outlook.com (2603:10b6:208:318::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 11:12:24 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 11:12:24 +0000
Message-ID: <5e95d78b-4c42-6596-c1b0-057e044197fc@amd.com>
Date: Mon, 6 Nov 2023 16:42:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 10/13] iommu/amd: Consolidate domain flush logic
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-11-vasant.hegde@amd.com>
 <20231105175559.GJ223197@nvidia.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231105175559.GJ223197@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0170.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BL1PR12MB5207:EE_
X-MS-Office365-Filtering-Correlation-Id: b9995718-37c8-4a6f-60bd-08dbdeb940e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h1y57thggxqbScIoT05Zg9g039W2l5ZlXvWdCTFtE4kOJxFrO+8eWjOmprbGuSiOluf9M0BDaq4AsDIgFygV9tcVYUccQTHKxExSK7fYFQwHRej88xolweY/ayCVgo/ZfnbENCrBXtoN6bnclSGvzI2mlQMqo5brPmt32xf2ylwV+3Zzz4f1gKgEPyzE7HD8a5wbDOPcBbEB9QhcP2W17M57pD7ZQugUlw0OBHLdq4UQ+lBSBidkHl/0yNSCpFKldtKUzDy/VMQALImOQBGI/OWbBcXcyoirC+7YAaJW4Cmj2hZXlzvhswM7RcZENKo10o7i7jPsIwjCGqhylkRGlItAJKpweCZ9ohtjK0Unl8I2OrLCpzByjE/b3vZ7WT/pfX9Ko0ChzMpxKjqg2TR/pvZTVJjYQ3bwgnQuOQw+y9QeGB9+7MqYM63D6MKp81KkvV/srUEHK30PdrYdZGHyhWoaDDV/dM+DFyfRgatNTRp1fzm0WxkLT+o4NDfVlio+KO8nPmrRQ+AbOJkj3LJJgODkcudHppltiIFjFBZvmmFqkKKRlMttP9IM/5eI8CnU90MGsIASW5tL+xaYpYJegMZ3kr6jlBuERDEL6S/d/Q4On8TJaQqWeWLNiO2hfIOo+4O209rYvetIWPuDwuPSIA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(38100700002)(6666004)(6506007)(53546011)(31686004)(6512007)(2616005)(66899024)(86362001)(41300700001)(4744005)(2906002)(44832011)(8676002)(36756003)(4326008)(8936002)(31696002)(5660300002)(66556008)(6916009)(66476007)(316002)(66946007)(26005)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUFyN0xoMXhHcVVieVVqOC9WK3pzQVFVMTl6enprTytwVWd1MnE4dnl5WnQv?=
 =?utf-8?B?TEw0L01TcEJDM2g4bEYzZmJUdndZWW4vWXJVaXh6YUZHSnJkVnFoekZZS1Qz?=
 =?utf-8?B?ZExtQTJETlZwL1prN29RNlM2bm84MExRWHdRSWhOWHpwOFQyUkU2V1NYYWdG?=
 =?utf-8?B?eTliakp0dzcyelA2d3VKTmwrSDJrY1FYS2FSdkRPUGJ3U0FlQW1jdnd5NXBG?=
 =?utf-8?B?ZTFaS3lCU0RjcGxTY3dVQ241RDVtb1VOVlJ2SFlwb0JibWJtUXRmdXR4bHhW?=
 =?utf-8?B?NEJPdzZDSm5kdXlFYkxTWWVaRWdMZklFZThHK2pHYzdkaG94OXlmQUpmZHFP?=
 =?utf-8?B?VWQ3d1JFVTNJNUx6QWRnelRReE1vZFAvWWx0aTRib2JKK3Y2L1hxQ2ZJcU1o?=
 =?utf-8?B?R21UTlhIL0JJQ0JraDdsM2FtL1UvbXVVMzc3QlROSXFYak1lTSsybTZtSWdt?=
 =?utf-8?B?KzdVNmEwY3pzQnBqZTY3dExrT0lxN01TYktWVk1wbU1xUEZkbmpHaGlqZlln?=
 =?utf-8?B?Y1JOZkdHcnV6VzVHUSttMkVuUnJIVzlKcE1weWFpcEtaejQ1RVZPQlRzMk5u?=
 =?utf-8?B?UjJocmZkQkxoU25tbTVKYnA3QnNoL0NXMy9NZWFWamh1NVR5MnJ6eTJwM1Fq?=
 =?utf-8?B?c09reko2Q2ZxUnN0L3JSdHNaVXhvY2RyWDdCNDk3VzdsR0djYUNZMkVLZWlx?=
 =?utf-8?B?YnlvWGRuaENTQzV2Qm1WdU9QaDN3dll3RjBxNm42RG5JdC9IV2JaR2NtK0VF?=
 =?utf-8?B?dkpta29SVVlJbmlaTHRCOGpPMTFaMEQ5VkxMNTlCR0dFM3ExU0lhdVRWdDEy?=
 =?utf-8?B?ZmswVUlzY0Q3aEE5WlJNS0VTMVZqTU1TZWxUTmVneWpSY1J5S29PenRhT05P?=
 =?utf-8?B?aEQ2eWp5U09RQzdEaEtYSEs4Yi85Y285NExUNFZKVHR6SGpzbm0reVdqWGNZ?=
 =?utf-8?B?NC9EU29oV0lhOFdvd1hRZzN5bzdhNlpMMDB6UVNiaTdFVTVFdHA0ZVlsbS84?=
 =?utf-8?B?YW9VSnl4dGVqblpEbTJKSmEyMGp0aFVhNkxHOUhsL0VVZzlWaU12bVJUWG9o?=
 =?utf-8?B?bUtQRWJpUjlZd2Q0eWdzVDJHTjV5NmFPTW5CQ1lzOHRKbXV0UzNlUDloTGdP?=
 =?utf-8?B?YzZjWVd1UHlBbWhYR3QzMkd1SlRvZEZ3bEpLcHRmRm4vUG5SRVd1RUZqOHgr?=
 =?utf-8?B?dExtQUpROWd2N1laUVBqYXlKcFRNNnlhek9tWldGcnA4c3VXY1BkTG1kQXRI?=
 =?utf-8?B?ZDRJYjBMYThtZVN6M0Q2SlpienkvMFRBTHlkZUtta0F2cU9tQnVrUHdnYy9v?=
 =?utf-8?B?VkxuYlpRMnVLUGl2RDRTWTR1TGR0UisrakxCNjgrc294ZXFVKzFXSXFjY3VQ?=
 =?utf-8?B?L1JvVVIxWE02VjluY044WmdSamZ0YW5EOExSalN4OUErL0R1dGtNcUY4dTRw?=
 =?utf-8?B?TjVDeFdhRTJ0cUJBTFJYUHVtOW9pK1d2UzExSkl1WGxGN0EwampScUdxc1VM?=
 =?utf-8?B?ZEZtMCsxWVVESEFTb2dza21ZdTN0SEZVbXpqSWFjeGVJZUhKMXRQbmRBb3dV?=
 =?utf-8?B?MHduSnh4MnlDQmQwWkhiUkd3eU5FRlNiMkNzRk5OWVI4cmRadW5WZ3JWQzFM?=
 =?utf-8?B?RzJvTGkveklGbEwvZHpQQ3dsUEtacHdnK2tmcXdDZW9wNDQrVTIvS1hYWWEx?=
 =?utf-8?B?UkJJczVILytndkJNOTEweHNZT3FramhsQmhmSHFMUHhrcS9yVzlvUGZFMnNi?=
 =?utf-8?B?VmdnSTI3WCt6SExjZ1E3MVlZL3ZMTmJyZ1h4K0xOYmdoMko1QStwVEs4amtM?=
 =?utf-8?B?V0pSZDBZNDRqd2pUWDlrREgxc1dhWWZzMTAxakUrTHA4d2tXbEFIV1lpeUFj?=
 =?utf-8?B?eks1c0d2aXB2K3NMSG1mazVSS2J6RzdpSEk5eXcxcVZNZ3Uzdnh4KzJsR0hn?=
 =?utf-8?B?bHRHM0tDbGJtbDkvK21IUFNpYU10WDlRcTQ0aCtJWWFXbHBGT0V2R2RSMS81?=
 =?utf-8?B?TTRGYjVHMTU4T1FQejZxTFRsWWNNWFZET0VVOFM2TXhxVkVTcHVyZURsSmQz?=
 =?utf-8?B?d0ZJYS9hdXNsQ0hqUmJpc2RORlNnTzRlL0pBZ0lET2lva0VDRGw5YVpoN0Nh?=
 =?utf-8?Q?0fOY0AvJw82XNTJm89T3m++Rk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9995718-37c8-4a6f-60bd-08dbdeb940e8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 11:12:24.5603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0XpDqf7A3anvO9lkJk22Wa8ILlmMJdz66NYeMBedCYVFKWci4tS4DH4H1T1Tx7wCHIcb3CLx9G5YJH1vNWvXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5207



On 11/5/2023 11:25 PM, Jason Gunthorpe wrote:
> On Fri, Oct 06, 2023 at 10:16:21AM +0000, Vasant Hegde wrote:
> 
>> @@ -1557,7 +1583,9 @@ static void domain_flush_pages(struct protection_domain *domain,
>>  void amd_iommu_domain_flush_pages(struct protection_domain *pdom,
>>  				  u64 address, size_t size)
>>  {
>> -	return domain_flush_pages(pdom, address, size);
>> +	ioasid_t pasid = pdom_get_default_pasid(pdom);
>> +
>> +	return domain_flush_pages(pdom, pasid, address, size);
>>  }
> 
> There should be no such thing as a pasid for a domain. There should

We do have default PASID (zero) when we boot in v2 page table mode.

> not be an api called pdom_get_default_pasid(), it is nonsensical.

But we have single command to deal with all IOMMU TLB flush.
I have a choice of doing all checks in low level function (what this patch does)
 -OR- add checks in all API path (like flush_iotlb_all, iotlb_sync, etc). If
that's what preferred I can do that.

-Vasant
