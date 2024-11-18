Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAA5610D
	for <iommu@lists.linux.dev>; Mon, 18 Nov 2024 01:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731893094; cv=fail; b=gO3x+uc+2BQ9kllOeFeYTYSNWswgkrraeEEGvoacFsWONgUndRuSbTmo07N9v+Bg4V7Ey/GbPMpRWhEqVbx54ei/1tnsB8KEyaI95FizfR7uRmUJat4EUUVYxyks0lXTxqPFA3DepDZ/TW01Na8p9nRBhTMQYXmCTUtnvpVM8ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731893094; c=relaxed/simple;
	bh=EG18PgSdMj8pGNmvALKubgR5SPGLKC8MPkdsRi5OIHE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rfq1i5zBZS7KiCbX97f7zv3+3gYOx/eMH6W1HeERLoJGoe+Zuw6qcglzT+FqZf/Ek7o3ngybPlpMl1qGxp2Y5OW2aB5bewTjP+va1LpZJEg6VxI0ttCmXHu0MtKxJQDj75ehLmFBKjQJCpt4OMoT1sE0Z5WvGyFGY8MxoAOvxFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ONpIvEEU; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ONpIvEEU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0hT3124yDCLalKGqOd7/l7nxd0/qkdu4f3FvIpxmcznHjn+CYno5o1fF9FfCioW+pyfl9pOomjkBsGrchmWepg3eobCr+jftYY5Y7XAXgJr5tqva3MZd3BygBf/T4wXQ/bDFZtg6kYEQzyNMMavhsrdzBulsQ/HoAQ4dcclGKNw981Q13EsoyuaiLQY7Cr0S+aNFd/wYKM9wD+g8INtP3u0PlatAipGVexdbxe2hCir+FTf+7y07MWq9y3b8l8Z5Crk5197LvUmuFaZ1WrF0XK36X//ogIPByBm2p3U2gw+6anEwpfDizGJFe+82XDwoZssrwyIbKDyZBgUHPuYRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZLIQdikZDCCVrB9zNVLp/vY70RaaIQaheimJwzYxUI=;
 b=SzkcJexwGAEVycmOe4D4CU10CHXPmPZhET5Vi4HQjFjmaw06d9O8/ZRBGqi39IRi3Cq4aYZk/1m3ezoFbQyP8uusfwbMeb3hrSzMH0m5gREv1BR6Eh/XtM1RH4He/9yinyab1BYVwmvuwS24ZXRxZq1HqBXUjk81pXtL225C5n7u7sJaadNu4xsxArYFMGfW6jGhY8Mu9W03A/yRp3xErMrvMkOFzGfcwEglcTLLyoBooGdNzbLgvKek4qzwvZSqWURidfsmKnJLCHLLWvAnlxGo/hA+/gzXWhuJjCSdOdkMrMrAVvt6dNhfN2Y8/ZeVLEnnksq7h5WJqDtPSv9D1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZLIQdikZDCCVrB9zNVLp/vY70RaaIQaheimJwzYxUI=;
 b=ONpIvEEUZC89ktcyUCYN7GqnnFzoYOhTPr0L7AEpZEUEiuNLcsn2yDNxijvBLykq+vuWjGW687U+JOcUo8S+dV/BfntRMa3oPQdKURMQdQzg8R94ByzD/rXapHxvihS2GjWXPpFFzsEE/RJe+435vmZgyyg9hhzJqXjR8i4O7Zc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CH3PR12MB9171.namprd12.prod.outlook.com (2603:10b6:610:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 01:24:47 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%7]) with mapi id 15.20.8158.019; Mon, 18 Nov 2024
 01:24:47 +0000
Message-ID: <95807b05-d9f8-4e18-aa52-f40c2e45aedc@amd.com>
Date: Mon, 18 Nov 2024 12:24:41 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH V7 6/9] iommufd: pfn reader for file mappings
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Steven Sistare <steven.sistare@oracle.com>, iommu@lists.linux.dev,
 Kevin Tian <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <1729861919-234514-1-git-send-email-steven.sistare@oracle.com>
 <1729861919-234514-7-git-send-email-steven.sistare@oracle.com>
 <8f2fadc0-1872-49db-83aa-314352adbb6a@amd.com>
 <7788773d-471d-48ad-9f9c-ddd5671b26e5@amd.com>
 <2bbfb5fa-20e5-4935-b52d-73b5186c6123@oracle.com>
 <5ff5b402-95c4-408a-99f0-2f6ea4e617b8@amd.com>
 <20241107140821.GE520535@nvidia.com>
 <987fe758-de45-44b1-843c-63f3f82fd864@amd.com>
 <71e700f2-178d-4847-8266-af285fd5f524@amd.com>
 <20241114161723.GO35230@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20241114161723.GO35230@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0133.ausprd01.prod.outlook.com
 (2603:10c6:10:5::25) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CH3PR12MB9171:EE_
X-MS-Office365-Filtering-Correlation-Id: 37813ae2-c46e-4055-ae7c-08dd076fc9f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkxaU2NYR3NQOFpGZVFoUUFQS21uUFNFTEhzM25xQXhuSGErSXlZaWl2ZUg0?=
 =?utf-8?B?K2tGTUNQZ0s2dFFhc0p0VS8rR2JiaWdsNk9UQXR4Z3dlNm84UkZ4ODZndlFG?=
 =?utf-8?B?MnJMSEF6NmE0WDNLN2NYTTRhdzZTSk5YRVVRVGx2bEE1T3FLYTZMRnJCVlZa?=
 =?utf-8?B?d3IxRnhla1VWci9oUUVhTXQ2MVNkd1llV05VZVJtWS9sVHZVOU5xdzZzbHVY?=
 =?utf-8?B?bTd1U3FqcTRBc3c3bTJiWmpQU2RGK2pOYldJeTd6RnY4Q2ZxeUE1Y2d4bzB2?=
 =?utf-8?B?aFFFSkduYXQxdC9NZ2JFRnJBNkFjb1dCUkQvc0VUSDRpU1JGM3lVYnU3eFZU?=
 =?utf-8?B?dXhKT3czSnpoWWE4WVJYdnFYa0JIWW90Z3pIak1SajlQcUF4VU1xQk1tOGVj?=
 =?utf-8?B?T3hGTDJtNXVaQ1V0N1Q1WFY4cm5mWlBuVVppaGxQQXpHVFk1NFRvTW4xSG16?=
 =?utf-8?B?dkNTYVh3Tmc2aEF0SGtpOElseEpISGhiNzlETjN5amN0UG1STithb25mcDky?=
 =?utf-8?B?MlpkcUR2NXBvcnQrekxwdlB5RzlCWlN3aGpvL2J5ZDVpbXVvRUxNSlF0VG1L?=
 =?utf-8?B?Qm1sRVRvYnJqbTZWVGxYamVoOUpwSEtncWpremRDZml5a1ZsY1JOMjFGWlBl?=
 =?utf-8?B?bTVpZ2cyWHlzRWR0TGpqY3RNRlFLK3dwTkI4Snh3d09UdTZHellPWktHdlh4?=
 =?utf-8?B?UmFGOHN0akN3SGdjVFI2alNhQy85aUVJZ1MzQkY2MjdKVjFkTHliM2tGdEZZ?=
 =?utf-8?B?MW5uUHNUeDFONDBOeEQ0UnVOZW1odlBsRGV4V3FSeEtHUmx0NUU0WTkxSlM4?=
 =?utf-8?B?THpXek8wQ2cvbzhacThNckhmSG14bk9WSHU1TDRLV3RQbFphaE92VHQrc1Iw?=
 =?utf-8?B?NEZIYVQxQmlLeEdQaElvVmhKYUdZVTZJN3pHNmkrSVE5TVdXdm9kencvSVIr?=
 =?utf-8?B?SzFYRzNLdFBvV2hLWWlwZWhrZEJ1WlFCQ2JYWktJLzdLanlzbStTWlRLczJP?=
 =?utf-8?B?RWhOU2V0bXFNYXZaMWhrMzhCMk9TdWcycUJ3cHdsK2ZkendLTDlUeCthbmFK?=
 =?utf-8?B?WmFwQnZ5NkhQU0dFNi9zVFZ5NVVkbnN4NkZYN3k3OWNBQlBSblFpbHZSWEJG?=
 =?utf-8?B?WmRGUUdBZGtGNzVhdDlYUmNxMjNjWFhwTVcySExQM1E3UmpCdmRFMDFZeWp5?=
 =?utf-8?B?d2RhaG8xdUZZUEkreFQ0RVp3RElGTE5SWW9GT1M4Q0MwUTJaWlBTTnlkeXlu?=
 =?utf-8?B?YmVDZWRrQWE4cERkMWptQTlZRU04ZXNuNWZOeVI3ZHNpTk5tK1JrNlY1NHpo?=
 =?utf-8?B?cksyZVJsdTdoOWRDRCs1YWNKb1JNdVJkSm9SMHRqZ0ZpeE5aTURRcEh4aHFM?=
 =?utf-8?B?WW50WmgrR0ZGL0VUcnM4LzJFdlNVL0Q3NmJqV0d3WTNiVTdCNFhIQklBZFF4?=
 =?utf-8?B?ZmY0UzFiWTUvVmw0eUMzbnQ3aW55UkloUWNlZEZra1FpdVl5ZldjYStsdUdS?=
 =?utf-8?B?dUk1UW1Qa2hmOTM2cXlZVFJzTjdLaEMvOGMxTFc0QTNjUnp5K2tmQzNLeE1m?=
 =?utf-8?B?Wk1wQXQvUkRmT204MGJuY2ZoMHVEZ3dNRkhTL1BkN1JpbUtxOWowejV2VEVT?=
 =?utf-8?B?ZDd2ejd3akZQV09JcWdZTEltSGRiZ2hUUjBnWkpVdzR4TFJFckh5cm5URnY3?=
 =?utf-8?B?MUo0cU4rc3JWK1V4Vm9rZGJMT0RYWU1Zc09FVkVEL0Y3WnZJU3JiaTYwREdt?=
 =?utf-8?Q?L31CUtZ+nvLn3FSUVt02Eqm7Tm231g8ZHoFZwEp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGlxOVUwdjVNaHlySVhUQ0xyMU9lQXJJSFNkd2wwNjZjVUtpMEt0ZFlRMjJC?=
 =?utf-8?B?MzRYTTk3bkxlUU1uR1g4aC90MzMwUjduczlZS3diRi84SkwzN1Fuc2I1Q1Jt?=
 =?utf-8?B?UzZzbXFQNkdQWVlWYnJ4dFBLQzJxZ0NaT0RDWFpDOEZTcWQrc29GeDNkYUZL?=
 =?utf-8?B?bC8wVCt0UEFKK2d6d2JsMCsxMExxblVvR1Z2QkpPQmp1ZmFjdnZibTNFRW03?=
 =?utf-8?B?cGxaZ1ZVenM4eFl6YnBwUzQwU3J5dHFLTkxab1VHcU83Y01OeVZHU1oyck9w?=
 =?utf-8?B?cExra1BYdHQzdVFZcTJwYkF4ZnIwMmoxSkJPeEVEcjdkTWxiT2lMd1NpVDE5?=
 =?utf-8?B?dDRjQW1GdVZQN0ZwWWFldjFXRk4yM3pNN2lZTmkrVU9DaW5DaEVvRjZaQ1dV?=
 =?utf-8?B?NHR6UHRPWDZnOCtyckNEUkhrNkkyUjdxSTY3NGJUOVFTOC8yL0N2QnVSb3Zs?=
 =?utf-8?B?QVNGaGtBcEswb2hHTVNpZzRhdDZzRkhDeUNQRTY0ZmUwUDcyTW5DQ0wrZWxm?=
 =?utf-8?B?VFpWKzFaaU9KYzFVdWxxT2ZmMjVFMFhMSjFoeVpDaTFWQlJDaWcyUVFPcnpQ?=
 =?utf-8?B?TXNGRnYwOXl3emhlQ0tuSm9oNWxON3RrME81WExPNjUrWmc4Sy9DVjcwU2t3?=
 =?utf-8?B?VWZHejJZNGdLZXBzYUU3bUZhNTJDeFhTWEthU0Y2QVhETXRTZm9kYUxKbXRm?=
 =?utf-8?B?ZzV5bm9EclZoTzFScnFGb01xZEZTWVVLaWc4VTAzQmdSajhKK0NQSWwvbHls?=
 =?utf-8?B?OWdqSUdVc1pNTnpmUmlnQThPK0NwKyt3NUZtUEt0cHA5NEJjeUttZUh2clhp?=
 =?utf-8?B?RGFySm82b3F0RkJNelVEZi9EZzdOaURHTW5sV0U4aU5qWDZSak9oRGs5enJ3?=
 =?utf-8?B?RVRNYkNobStlOUlHMFdkRW02K3RZcXNSaFJjVjc4WCtDRGJpTlg2WW0xdnRr?=
 =?utf-8?B?bHJPWUk4T3g2d21rd3VVMG5STXl3ejI5ckJ2OHZHK013S2VnTzJOaSsza3li?=
 =?utf-8?B?eWhIRnhidEpkS2paOTRlUDZjSTVzWGZEMGpUV3BCazYyQmticzdHR3JPSGhR?=
 =?utf-8?B?c0M1SnZhTnZzdmFoOU5OYjh0TERiL1NJNWIzLy9GY2xKQnIraCtCQUc3VFRO?=
 =?utf-8?B?dkt3aTkvU3RFV05scGRwQkp2bEsxdVBCY3MrZENMcGdnM2NpZWwwUUROenY1?=
 =?utf-8?B?UWpWNzc3b2VpRzdKekpmTnZYVHZReHFjYXozL0tVTG0vOFUwRFoyRnhSWG9Y?=
 =?utf-8?B?SGowVDFBVVJVMGFxU0RubGErRWRKWncvdERSdWQ0VFJmRUN1ZTJtZ09mV0xr?=
 =?utf-8?B?dFpqZjVkY1BGdk9YemV3bjhheG04TVE2M0VrNllZdDF2S3JmZUhETzc2VmR6?=
 =?utf-8?B?RzVpY2piaDlYK0xNVmhyY1YwcGFRT3NWSnRsSk9BbVJWc3VoSVA1UTRnQzJ5?=
 =?utf-8?B?NjBIR3p2YlJiTXNjREkwemkwNzFrNFVTQnJqWFBoaWt2Wm44T3o0ZFVSMzY1?=
 =?utf-8?B?RjdhUnNXQkFrQUhraVNCNkQySWJpOHBpZ2RqSVcyUnpQbVROamYvbWhUQ0lu?=
 =?utf-8?B?T2EwRE00RTVWTmFaMU1KMml6WFJubkZnbmZlVmZzY2FTK2E0dmRzWjVIR0ww?=
 =?utf-8?B?cmNNNiswLytGeU1sYU94VWRwZVFNVlRDVWE4eXh5bFJNTTNybEJUQ2NKbjkr?=
 =?utf-8?B?OWE2N2dkdy9MZGNLdk1HNjlaS3BBS3c1MjZqVWlNdFl6cjd6aUJqa0REdll6?=
 =?utf-8?B?U3ZiZXBrNitmK24rVi9JMU9wNktscE9YTGdkRFREK3lPYUUwTllPRUlId2o4?=
 =?utf-8?B?QnJORHU1d2pXMko5U0tzNTBYd2Z6cDR1ZVZtRnpEMk9rV2ZIVnNxajNvakd6?=
 =?utf-8?B?WGRQWDUwYUNabjd4SlYwM3g3SmMvaDMvdXk3aG91SjZsNzZha1dEYVRQR1ZP?=
 =?utf-8?B?UENkQStObGJMTGt4REJwc0hBZ3dOcVppME5EMTR1SGpsUWFJc1JaYnl1WWhG?=
 =?utf-8?B?THEvVWYvVHZpZjV6NjlrNCtBRDJaVHlaZWZHNmdYUGExVVFqSVltQVpJZmx0?=
 =?utf-8?B?ajVCMExWcUd6d0JxOW9yYVNjUmowOFJId1lXaEs3QzU5MXQ2RjZjQUx0akl6?=
 =?utf-8?Q?R/joYvXY7P83wzrpyFjqdmumO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37813ae2-c46e-4055-ae7c-08dd076fc9f8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 01:24:47.0878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qf9Wa+u7e0jggjoidZSwuHIeKOy9283kCtatE+G1nDkcQ7Mir40Ht2pkkHSncL7FT09zbAl0ZdORiu1rShGwCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9171



On 15/11/24 03:17, Jason Gunthorpe wrote:
> On Thu, Nov 14, 2024 at 03:03:36PM +1100, Alexey Kardashevskiy wrote:
>>>> I though KVM had its own private interface to guestmemfd?
>>>
>>> At the moment it is essentially this:
>>>
>>> folio = filemap_grab_folio(file_inode(file)->i_mapping, index);
>>
>> Turns out the complete sequence is:
>>
>> folio = filemap_grab_folio(file_inode(file)->i_mapping, index);
>> folio_add_pins(folio, 1);
>> folio_put(folio);
>>
>> so then unpin_user_page_range_dirty_lock() => gup_fast_unpin_user_pages() =>
>> gup_put_folio() work properly.
> 
> I'm surprised given how forceful people were that pinning should not
> be done there. Please confirm with guestmemfd experts..
> 
>> Later on, hopefully, guest_memfd will developed ability to mmap() and then
>> the existing iommufd mapping API will "just work", I suppose. I'll carry on
>> the above for now. Thanks,
> 
> I think that is not possible, the entire point of guest memfd is that
> private memory is never mapped.

It was like that but recently the approach changed to allow mappings. I 
do not think the interface is finalized yet though.

> For the AMD case we still need to program the address of private
> memory into the hypervisor iommu page tables, so the FD path will have
> to used to make that connection.

Right, using it now in my working tree, with this new vdevice thingy 
https://github.com/aik/linux/commits/tsm/
Thanks,

-- 
Alexey

