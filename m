Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023139.outbound.protection.outlook.com [52.101.83.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBDA3E2741
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775754075; cv=fail; b=QVK8GIiDx3abVSvyqUqJW53G1qJBKHBw16epo2foQP2lDdME7PfYFL72GGTWJQP5vCQzi4Rz8BmByN9iU0L+tEfX70AvBGwjMltbwHzYBGyX058S5aUIxsO9RKFJsy0bC/TbYDK/HkIAcT8OCHy1NInUvWzzhW7n8ZsHzKumV44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775754075; c=relaxed/simple;
	bh=FbgTYjq0LK9Esrdr3ID66qY2ZE4l6ZbfCRX0hkSZ6hw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WwhVx1dnRf1qJ5oU0h33WMDgIKqJ29wHZ7QDPJEENcZnVops7FUoZEbRF0p2tojMh+PO/1L32EZIOC7VCZ6Q1RXPzbo11GG76qiNGmyMPAWJU8t/mxvssqJmLVil8DF221igS4ZkGjiuwNpExuowPuP8GDgRKbOmRSbSSVNEwtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=MPZDc0qB; arc=fail smtp.client-ip=52.101.83.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MPZDc0qB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qt3PQBHNvDdJIMNjeAkNeEvT49gauECWYbJAFOKU4hHBd7T4Lcx1QOD9g0cmb493Jioet1OrIn5mukR35sxVNBHtK09mmX++HsTX5EEEu52bI63p65oslk64nPurvpj+trd2vM8FxHPx0rucl7NCM1UKYseQB8QQ+idsRzwCOSN36EAASTk3i5U5wmh9r6fod9AJLe9w4v5aD7FcKt5HEht/9DJvveSWGNxRaF+DVE3Ubc9ek9tBDxNsLMGRzRE/pBc8dWOEXpmHrrunmtn4wKyAsv2+AMWT4uUHCts0XMdtU6C1g6EeLaf8HPWRwFPQUPQUFXz+/HSl/8oho8c0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxZ9UmALqnND/FgezynOOrYxiBr3M9+B4S8G36lM1pM=;
 b=vP703JNgMSpaFGWsOo/8WbTFIqtUp3YFMBsuJf6dIf6xApmgr8KuVQYgYaAeacVZkdYFpzHPMgXLc7vQIsebmEhP/4UGOpMiiCk0ehr/CD8LdgumCNG8r9JRNkEZkmC3OH7j/pn0mcLjQtD2tsR06GjM/vJBqx8N7k0HAPj5e85FmUNUDy2BdT30RFQSmOx+3xd4IKxKQt7T0yaDFt0Zm6wP9PQyGZ31LuDSjZgeiY4nHTAqEyz7TM2zJxpvUdzBssDPzc02BBgR0I/PYVKjFTjvoar0QpnaGrs8dThML4mqgCOK2oUhFm5VmsFrcRC7oWXzDVWDqhPS+/Tukg01Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxZ9UmALqnND/FgezynOOrYxiBr3M9+B4S8G36lM1pM=;
 b=MPZDc0qBpbs+XlbDKSpj+6J6ic1rNmGorE8TVoCHE/3xMJgJawx86Vyv+TXRBEO+4r/c4XCQbw5HR2Cg8V46nH1tKusomzpWtUkhkhopQ3FcniYk/5LtJrhZH9El0fg2hUNyCo8PLzo6VOWU9koEiNSDZ1tQ7nfhG3SScDjAe6OMmvgpT6qexZ6mg89jAdzwFbhX+x6JSfI6GM2eyawKkZ6LWKExmOs/8XpAy6LjMyPdZXr6C+KmXDxSnjDkvZxylp5G9fAjnq2ya9YK6MgQpEjcV6yb/+C5lsevj1LMfnwaY6lCTNBi4Im+kZOa1VE9cqq2+HQMgUSOsw/YvtYtCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20) by AM8PR08MB5762.eurprd08.prod.outlook.com
 (2603:10a6:20b:1c6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Thu, 9 Apr
 2026 17:01:05 +0000
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a]) by PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a%6]) with mapi id 15.20.9769.041; Thu, 9 Apr 2026
 17:01:05 +0000
Message-ID: <1ac7d4b7-c0a7-4e23-9d77-28c737c8a8a8@virtuozzo.com>
Date: Thu, 9 Apr 2026 19:01:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/generic_pt: disable GCOV for iommu_amdv1.o
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Peter Oberparleiter <oberpar@linux.ibm.com>,
 Mikhail Zaslonko <zaslonko@linux.ibm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
References: <20260402141012.1437095-1-khorenko@virtuozzo.com>
 <20260402141012.1437095-2-khorenko@virtuozzo.com>
 <20260403160729.GC2551565@ziepe.ca>
Content-Language: en-US, ru, sr
From: Konstantin Khorenko <khorenko@virtuozzo.com>
In-Reply-To: <20260403160729.GC2551565@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0035.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::11) To PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR08MB10708:EE_|AM8PR08MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: d11e445e-e8a5-441f-7205-08de96599681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zq6ExJOzKt8caPgwwfNxrZwuTd0MDlmqdIa7RhHdiIPFhWCGbj1hwtEasZlT3nuiCYVS9aYViU4PEyF2bfOuX9c2JQ9a+KMgG9H66duvISBI7RNZHFuBoaBEOywUvBTUpjb+C2aJ00aSvgWlxSSxCftzkx6tmKR++DDmFHrDLA/Twr9XdIQufmZfEM05BRNrm5uO+NG9x+qjDJ/WRAU6Y/A8Ms/N2K8OoKQHRNOs9sYZigw5inXYXDYvy/8Iq2chu128VKu8o6iNvMwft1oRDfYLbcpcqU30ydsBXSypsggJmvVoYI3N8jan08Du0OVTB7qcEg+LYJpHloSYciyYm8RtvythZIemySRmKeU95C/947eK8gEynefIFxXpeyPdfkN3c5T7QwOARSh8S9+nmaj6QXknD8jhEV7ex/9SXLr6hNe2igfJ2VxlpWskg9m/w6mYlU1nGPf6jpK/agIy/nZ9GZ8LAXAXkTZfRLvbFg44eog8JVkS1vhkZyaf8eOUzterdU81ecfAWvh/hB9llyQvyOG2pq0FMgqpng0BQOlMtipDulOOzsCoWRKOmpTyIjoaxlyxxd/U0bzFLnQAKc0iXfhSomgInHCKOrzJzP5kwgpPDliRcDsl+F2G2y97jlZU0OFEdnNT6ESahoAqePBUuB2HFpDn0itNqzOG5lMnO/4pDCJ2oI/vDve5gWvEsbUfwvfMi3tTdXRurTIc7e9NZ5ysYJx6DcMwc/aq+90=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10708.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3BsOXJsREFpOGROL0VHeE5OYk1VUDN0RzdSN282QU1BSE1hSWZLNDczblhG?=
 =?utf-8?B?bzRQNTltQmUxVkRpUmh5Mmw2SlZaUDB0bFNOUUdYUXJNc2xQM3RlN0hMd3hq?=
 =?utf-8?B?WjVRZ1Iyd1FpWlpHc1M2Nzl5TUFEK2FzWm1NSURhNnN2MmZlVk1WN05Vb3Jj?=
 =?utf-8?B?ZEQxSFFtNzl0emw3eENKRHNpNkdPVzFnNVFVNExxZGNKQkZjd0tDR2VHTEt2?=
 =?utf-8?B?eUkwNXJQT2Fobnc5clFLajlPTEF0a0NpNUVLK21sWm5McVVGQzNjT3dyODk5?=
 =?utf-8?B?TWJrcTl6b24rZjFVajN3dkVDTEhWc21CTjArVlJkZHVvS3NPTVVqR2VyU2lt?=
 =?utf-8?B?MkluWkQvQ1RBNHZTK0Z5M0lJVlVUU3YyOHRNd2VhNklTRGkwMzRZMHV0RmJ2?=
 =?utf-8?B?MEZmaFcxTFBBbWkyY25uM3NrVzJPUFE3Rk55dmg3SHZIeU5LU2t5dlJlM0xz?=
 =?utf-8?B?VStuYzhsWVY3dis0Yi9HcTRuMkhIVWlEZnpUSGwvT3NTVWFzZm1zc3p4MU9X?=
 =?utf-8?B?aWhHdHZQZlZKMTVoWEdxSnBvUWJYVk5LVE9TWkZ4QldweFFGTmtNNkRqSjBU?=
 =?utf-8?B?bitaZU9OTnVUUHh3U1lOc0F2dDU3UVN0d3BqSlhXZXVUbGJaajJxVmtzZEUy?=
 =?utf-8?B?UXlLSjE2M1ZoSSsvcjEzenEzQzlEZmQ3SHNKeUhHcWlkRHljOFRXdU5xYyt5?=
 =?utf-8?B?Qk1iNytWMXkxU2dTZ2hnRnlNczFKSHBFdEcyU20xTTFLc1QrMkcyOXdob0Q0?=
 =?utf-8?B?djZ6K1ZzTHRoMXlBTU5jcEJPZk01ZjVkNWFldmhOd3NsQytPLzc1d3pUbUxw?=
 =?utf-8?B?dDI3VCtmZ1BOZEdwNHRGMUVFTzI5QjBwZ0xWVmNFQWVsYkVTa1IzV0MvcHV0?=
 =?utf-8?B?VFVMWjNDZGR1dGxWUS92a0crZzRIVXBCODBoWlZEazl4REhIZGFHVTQyR0Qx?=
 =?utf-8?B?TEQrSzdmUWZxb0Y3d2lmSy8vSlc2YVZxM3pFaDRBTVZLTThCaVZhb3N3OGVw?=
 =?utf-8?B?ZkkwYWkwNUFOM3dicG1CbStEbFVUS2c3dkdyaVRSMmFESHlSK2RId2RRdHN5?=
 =?utf-8?B?YkJtam5yejNSSTc4d0lqa3V1V1M2dnI1SDNQa3kvZ2llK25tSjFteEErM3di?=
 =?utf-8?B?eFBzQ3AyVDdCMndQOGF3TzRvNEtZbVRnOENuZllKOW4rd3ZkVWRxb3pTS2FX?=
 =?utf-8?B?dndHWE5FN1IzYXFnY2VIK0gwMDZIditEcE9mYTZoYnYyaUZQT2JZWXIxR1Z3?=
 =?utf-8?B?eEs4Tk1lVkE1dUpEYTBEcnBwUUtsYTI3R084Mk9tYWR6eks1eUtldzE0THJi?=
 =?utf-8?B?WGJUT1BLRjUxNnFoc05sRTFOQmRITGhMYmNlVFJ5QzdobkxlTVRiK0h6UzR4?=
 =?utf-8?B?K2NydUlNUEhLNGZUMWt0cVVIZFJDTUlRb3ZhT2ZSd0VQdzdTaHZiVUYya05p?=
 =?utf-8?B?Ty8vSVRmaU5QYUJGVHA0bTZwUjZFa1hpWlNJQmFEb3BzUGpyQWpKN3dxd25T?=
 =?utf-8?B?dDVYMkRFRWxzSVZxazFpR09sRHg0ZXFjREpGS1hGalg0eVZHRm9oUlhkQlpJ?=
 =?utf-8?B?eXc5NXRwaDZqOUNxbkhwVjl0dGNrcE9KN0ZodGlpbHpyMnZhVEhVNW92cGZW?=
 =?utf-8?B?N2tCWGp5aHZxaGozZmxKNGZZVFdycmhQTUJLb2FpR3hwT1UzcUQ3TzA4eUUv?=
 =?utf-8?B?Y2hrb2JLMnhmWlhnWFFlRExZemZCMUFYYUhxTlluU1drK3Q3WkNvZkp2WG5s?=
 =?utf-8?B?UlZFdEJFUFdCOERPNlpFamRiY1dPR0RCeURjRFlNSzUyOWRXTlZycHNHNE9u?=
 =?utf-8?B?UGQ0akh1anVnaVVoZ3NLbkJKUWE1Z3ZKd0JpenEwdnFLWXVUUEJwRXhjOFJp?=
 =?utf-8?B?bUk0YVRxL3NjdGZLY0ZjRXJKMFpJa2dnOFlMS1M4b0xlMXpjNmhYZ1MyRzEv?=
 =?utf-8?B?QzRZb21MVmdKdEtXOU1TZEg0SzY0eHZSU3I1bHA4L29hZnhhOHZ6SlphUGhP?=
 =?utf-8?B?eE03YWw1Q04zRXlCbHdYbEZWblkycnlQOTJhQ1VGcGN5TXpuemM3WWdlY0cw?=
 =?utf-8?B?U21MRG1wTDRQZThHNEhYbzlkdHJ6TkNPVWp2TFZDN0FjUzFzREJSSGoyejlX?=
 =?utf-8?B?Z2x1VzRXd2l6L25mVVBPT2hNbmQ5SUlXS2dkaVpmMmJESjRqeGgya1VoNGgy?=
 =?utf-8?B?MHVUTnlCdzg4ODM5Q2wzMHlyYjhoTmtjSXNaVE1zbU1zYzhFa2l3cEFUNlJL?=
 =?utf-8?B?bktPTjJmYVVKODVZSHk2VGhJTHFHdEpNTlBISi9tOTMyNkZyUGQ1cFE0UDVV?=
 =?utf-8?B?L0ZFYXhPeWFpV1RKcFNZRWR3NEhjU3B4YWdza2VPTGtqZ2RXamtYUT09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11e445e-e8a5-441f-7205-08de96599681
X-MS-Exchange-CrossTenant-AuthSource: PA6PR08MB10708.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 17:01:05.6047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: db+wgFFaeYOHL4qQXD6grKeHQMPftupIGYODOPSQLhU+bNvWYDWtt2lhyPdkJavSklfMA+yAw7pgUjmkScSO3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5762

On 4/3/26 18:07, Jason Gunthorpe wrote:
> On Thu, Apr 02, 2026 at 05:10:12PM +0300, Konstantin Khorenko wrote:
>> With -fprofile-update=atomic in global CFLAGS_GCOV, GCC cannot
>> constant-fold FIELD_PREP() expressions inside deeply inlined page table
>> walker functions.  GCC creates .constprop clones of the inline level
>> functions, which get their own GCOV instrumentation that prevents
>> constant evaluation of compile-time checks.
> 
> That's hasn't been the issue here. gcc gets confused where it thinks a
> value is constant so the builtin_constant checks inside FIELD_PREP
> trigger, but if the value is constant then control flow leading up to
> it excludes that path ever happening.
> 
> Somehow gcov is breaking the elimination of the impossible branch, and
> I think this is all just compiler bugs.
> 
> Also, I thought this was fixed by adding the always_inline?

You are definitely right, Jason, thank you for the hint!

Sending v2 with __always_inline.

--
Konstantin Khorenko
