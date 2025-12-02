Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011011.outbound.protection.outlook.com [40.93.194.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550BE2BD01B
	for <iommu@lists.linux.dev>; Tue,  2 Dec 2025 05:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764653036; cv=fail; b=qo8lvo6DiMDpmjFvDhjnJr1/dE2WJbLorpOQ6dg7/gn9GfBiN/wiUUMX62dON6CIoME2jeNdRK2usBJ85mqGORTOwlsX1/EETVnDmGC2ibkUYxRqdlJ234snHFh4BCj0+2YkD/GA6cfkl1DPA9nBco41+ZTm4xSp78XCsDsSjtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764653036; c=relaxed/simple;
	bh=jCY9QT/Ce8ygJeAyVdEzqe5MVy3cKMLVB3mtrHFftsM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M79PjhQZ+fPUmQNcywTcxLnWERhJa8MbI4KcA7snPoWFXK1LHB4e3hrr27Kqq5QrC7prWTER1yXiqP9Y9gm5gho7hwfcpxr1z0UDvfEvOF0k9nvNZSwbQAlQIGIc+Lv4MDmcNouBZTcdyNZo+TNJfqL0OE5JLmLXzzEbK7iCkV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gy6fQviS; arc=fail smtp.client-ip=40.93.194.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gy6fQviS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DczrRE/Wv1hW7h8ZbFKYbrTdH5ke2HrwID2uyDkozNWNjw3ZP80wwMz3VMaQj3EUNZxnAvrNkaanWSNjNFyPohuxE3vDHdYEST3Z/43+XopD6WjD0U92XGyILjvIWn/QBMRIAJ+cPb18c8jihXwQcONy4djxsDnOYHw6Nc9CnE4eLt3FLALTnm7yBlsdH7w6xB4nDt/d3XVgR1rjj3V0B6UfUi0nRgwmepjofSfHdYJpq3+1vFkJ4wL01O0oqw42ed/NCnbps0VHmODV2lYEjWduJ2S8vOQznVqsG4YzaJEtSAaBH57W2hjU0+NeOGjf0bfvXM9EgknC7TLLxOtIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykd46a2GBqIZSEvW+dYMw+RDg57opFgA32aTs/XmKAE=;
 b=UI6YQyu0ucIL/ueiiLRvK9MkaCuspJNg8RfFfMeoryx+t+aX9vybQAZ9HeMRiKiGydUk5kJxgPsSdNspbQEKcSxiHWk2hqbxrRwOVLrspCWU9It5XKcVvwCl3BHSuuJMrV/QylgL7Ewb/PN/koQA/juXQV1UoKnyNYYlqPg4CIrC1mcl3bfAqqWjPFjeHnkle9oEeKJmXieK96WAG7EC5Ox8vIzlwJXU+3uL753eXMAaCj18CDAQe7TUrneKlHBhY32LWllRMQXfP54WTuZlM5ZmZvTj8eq67Rb4ozeJyge2TKWlwHuQuXhnWGP/moP/4qBJf4XDRufSrZpbAlPK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykd46a2GBqIZSEvW+dYMw+RDg57opFgA32aTs/XmKAE=;
 b=gy6fQviSXdd2eQeKAarB76qBo3jKLtQoqwljN8gL2w/Km2shnRjZnYL4ncl3YdEx5UwBPLiy7dhH82h0X1Ja9dG9WlxZLG1Tgf7FVT1zACiHz7FwHi1Afot8G5zvAGnMxbXfaBdO8YZ8XU2fkxxHqJQYCUVXtfTg40wT5971sjI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ2PR12MB8691.namprd12.prod.outlook.com (2603:10b6:a03:541::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 05:23:52 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d%7]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 05:23:52 +0000
Message-ID: <53378d7e-8456-4885-aa55-9d43003810c8@amd.com>
Date: Tue, 2 Dec 2025 10:53:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] amd/iommu: Preserve domain ids inside the kdump
 kernel
To: Sairaj Kodilkar <sarunkod@amd.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
 ashish.kalra@amd.com, will@kernel.org, jgg@nvidia.com
References: <20251121091116.25663-1-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20251121091116.25663-1-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ2PR12MB8691:EE_
X-MS-Office365-Filtering-Correlation-Id: d99ffa15-fcda-4c9c-97fd-08de3162fb02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHBNSnY0ZWw0M0JYaUFxbi9yYUhEenNpQmZNMFBkS3M3UHRxS0JUMlYranFv?=
 =?utf-8?B?TWVIQ1owRzJOSUZZN0FzSVpQbVVTZWV5MXVRTDRtcHJnTGRnOEh1dTZWQVBk?=
 =?utf-8?B?bzFEVk5pZ1ZGRnlCdnBONENnZzRyc2VhM0lQSXMvYU1DdXd1YXJVK2hNQkQ2?=
 =?utf-8?B?VkZ2TzZOQ3FjWFlYMWduSjhOU1dCRXR2d0M3Q2xFS0JGenY3QW5nUE1GQy83?=
 =?utf-8?B?bkF2VEJHNlBpZHUyS0NGY1RpZFFtMjFnU0prT1VxZ2JpMzBTTFBsZG1PcGNj?=
 =?utf-8?B?TGpmOFVDNkpqY1BYYUNyNEo4NUUwQnFiQ1NRdkZUNlo3QnVSTHk0bG9TN2F0?=
 =?utf-8?B?MGpybXNPOUp5cmVnS3lUYUZrQll5cDFUWHAyamcrMWtLMmdiNHcxVDlsWWRs?=
 =?utf-8?B?WXQxK3k1VnBoMTdyTysrRCs2THRnL1hvcEsxdGViV2IxUjkvUmtnSHE3dWYw?=
 =?utf-8?B?ei96NWtxZWVNbHFMU1R2Ulc5NWxOdGViV2dua294dE50RjRBMmxDZm55Rjla?=
 =?utf-8?B?eENFY2MrWDNGekY0aGNwVjZYWlRZWVFTUk05ZkFYYVpjMnFyN0JEQzVvY2Iw?=
 =?utf-8?B?RWZjT0c3MTEvbDR0ZnFRWHU4OUNyRVRnbVgwTnNDKzFZWDN6LzFvZHRPOTJy?=
 =?utf-8?B?SkJ3TlYyQjZ3aGlRSDFEL2JFVGtSNlVZTDNYS0kvR3NWUW1OVFNWM1QxNkhl?=
 =?utf-8?B?Smc0S3IwMkFMTVZSWlV4ODcwalB0VzY0RTZLTmtRR2svR1NsVGREcHpSanEx?=
 =?utf-8?B?cHdIK3ZqT0hiQm5LYnl0ZUpZSlc4RGZhWm5OV1dWWFpoOHF4dFdjczYzVEEv?=
 =?utf-8?B?RG9CUENLWEJCTk13OFBHdWRKc2hWMjBrSFZuaU9lU0tBMGFvbXlseEltSlMw?=
 =?utf-8?B?RnNEQ0VSZlRZWnRKTFRnZWgxUDhRRWpWTE1xOTdwNWMvSGNXYW1YSDNUNTVD?=
 =?utf-8?B?WlVqS2o5Ym5xdmNBUkNxN3Z3aGQrdys0SWtjVXRCNFUrR1QzZTNaLzRkWkRJ?=
 =?utf-8?B?NnRzMjdlMG5KUE9ybXhON0Q4YzJMNituK1VLVU1JYTZSSi9BUytxVEsrejZh?=
 =?utf-8?B?czExNllSZ0JrakFLaXBLOFQ3aU1VL29BQjYzZXBUcVdpUTVjU29zY1RhOVhk?=
 =?utf-8?B?b3AvaEZFSlh2bENjS3A4MEoyWmlkZWZ5ZC9SUG43cm5yWndJWXA0a0JDNlg1?=
 =?utf-8?B?S1Z4SElqd2hDL0JWOVB6bkVxbDZ4NkRDcXNFa2c0MEJ0Qk9WMG5pakxnaCtV?=
 =?utf-8?B?VXFVcU9WdEJRY3o5WDNpTkpmaXJFT3hKNnhvclBhZHkzRHZjYUpHZVcyUW1M?=
 =?utf-8?B?cGlqNGdTMGpWaUE5TGhLczU4QnFaU1owVVduT3ZxSUdsbzVGZGVCM0E1NWtJ?=
 =?utf-8?B?b0ttUTdJNGFMSGdYY3JTM3FJSS95bmZlMk1UM0t0WXhneUtGVk9aRUppbkFq?=
 =?utf-8?B?Uk1paDg3dlU5YzZqZ0xpQUZTUzljUXhPR1pmR29nVjF5TG0zL3pZN1BZMEl3?=
 =?utf-8?B?QS9ncVBlbmxuK3FseDJRbUg3Tk9FREhBNHJGdWk4dDVpWHZTM2pySmRRM1Nw?=
 =?utf-8?B?Szg1ektMRG55UHNhSktzaHBGSitIRVQ4aEhzZ2F5TnhURHR1TlFkWEx4WlVs?=
 =?utf-8?B?UXpOeW1vOFZ2M1VoYklsdmYzR2p5bVB6djRFV2ZyaTVUL1pnL0M4MkRHSTdQ?=
 =?utf-8?B?RldMVUpvNEszUWlZb05CWUw2R242SlNRb3JFVys4MFpnVWZoemI2TEdQVGlM?=
 =?utf-8?B?RzJOcnlSbTI1S1V5SnEwN2s4bXkvVU0vd3cxMkIzaGJaOVpkYURpanRHekZJ?=
 =?utf-8?B?eUJybHBPa0VrRnlIR1AwaFpVMHpXTjNPUXVCdUZFTDVlLy81NHFFYVBJbnA3?=
 =?utf-8?B?TjlPRitKeHBqbnBRTkdEZXozbFN1cFQ2RlhGbE84bEpXRTI4ZHlRdHUrWEJy?=
 =?utf-8?Q?j0aIhP669t3ODS/NIpLNdt+jMPFAXJ3O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnlJWWpSeFMxaEZDUlJZNVNFV3NGUi9QcnBxNkdMQjJhY3BFZzUxYkJXRmlC?=
 =?utf-8?B?Zk93ZTl4SUZ4ODB3a3g5ZUVuSlZvR1I3aWpXVURXWmVwbEd4ZURNTEh2Zmti?=
 =?utf-8?B?bnFGeXBaMXpsVlFQUEZ0REJrSTVsUUU0eDFTL2w5WjFWOW0veHRGbGVRdGNB?=
 =?utf-8?B?WDVMT2ZRZnNiK0w2SFpkZFl1dUk0dGdQaWlvN29EdlhWNlU1VzRsVUdJWlZj?=
 =?utf-8?B?WGVUU3pQUU1jekl0NVYweFFyR0gzS1FYWmN2Q2FVbjRYVDcvNkJBREUyRFln?=
 =?utf-8?B?Y1MzcWN1ZzQvM1ArR1FQd2ExSllBWVcvYUZVOVFlZFRaQWI5U3ExNXZ0QU13?=
 =?utf-8?B?V0s4UnNBcnZLQzRHb1VKUEZsWFFacFlqSVU4eGozM3BEVUdld1RxUzZrc2wr?=
 =?utf-8?B?VUo2VUdFL3RJb0V6cVJwcGdNRnBrZjZVMFBsWWpKYkpTTitJSGR4Y2QwN1c2?=
 =?utf-8?B?VldIcnpnOTF6di9wSzBxN1F6NGplZzZTMklZelBNLzJiUHpYdVhLUU9MTTJP?=
 =?utf-8?B?Rkx2OVdmMkxFRGJxejBxclBGSVJmeks5YjA1TW0yajV5QWlJZnpoVWVYTURR?=
 =?utf-8?B?ZnRqTC9PTmVHOXNFSkJjcnhYWXVmR29tTGE1Tlp3L1Zibzc0L1JOdkpCUzlW?=
 =?utf-8?B?eEFTQk45V2NpUVd3SGppdXlxOElrSDJnVHR5OHBPQkxMYlQvc0VnVVdtMnhw?=
 =?utf-8?B?QytqWWJUZmNWcEFidGFwRmQ1ZTR4ampxbG4zYldZbjduZkZpTjk0M09MS3pR?=
 =?utf-8?B?bS9SKzVPWE5lMFdlTGNCRFptd3p5MXdoZkREQzVsdlMxY2pqd1RBK2c3Slgz?=
 =?utf-8?B?TG13Lzc1Sm9QMmRzMWJwWVVwYUhRR0ZRT1djR2hTK0J3SXlFMW5YWmE1emxn?=
 =?utf-8?B?SmVWdHB1L1FHUWZPSDA0QVprWmIwVTIxRi9RTFhPS2dkd1BqYkF4OVY2WmFT?=
 =?utf-8?B?ckZyY2hTYnJPdG0zNktQaTNpb09VbjFlMURhM2Rrb2dFRHhSc1d2QThqTmtT?=
 =?utf-8?B?SWFKZU9QZVp6alVlNHlEYjNlUW9nTXY1dWRrdzdiejVFN1lPd2dMVWVtRkdQ?=
 =?utf-8?B?NWRVUVZqTUNhSk4rMWhSRWxubHNCY0ZuUUc3SzBWMnY5VlRmSjdUYXQvTTc4?=
 =?utf-8?B?alFjaGlBVVlJNnJJMEx2bEN0QXpVRnVkekR5L2hnVGRNc2k1VFZMMjFTR2No?=
 =?utf-8?B?TXgrbkF5K0ZDMjQ0UlNqZE00bCtlajJXQ2FuNDFDRVozMVZxcFQvTFBGV2JQ?=
 =?utf-8?B?dllaQWR1V1BkL3M4ZEpyVERNZTZ6NEFqQ1llL3JxTTQwWU9hU0NvQ2NsTkdK?=
 =?utf-8?B?NGNuZU1IZTZSbytSTWk2UVRDT2dNN2xLbUlUOGRVTC9wbHd5VEZVZys4Vyt1?=
 =?utf-8?B?dHI4ZVdheE5PcEZ0bG41V2dta2xzUnNKbC85Y25XTTV6MDlIS2t3c21NNi9D?=
 =?utf-8?B?VlcxeW5WbzlsaTN5NFNnWTFBU1ppVHlDZkd6dnBZNlRudDM5RVQ3TFlIQ2dL?=
 =?utf-8?B?YnQ4N3ZDekFqTWNHVDBkcjlQN0VBZnNiRCtYZzQ2c2c2L3ZGWU01WktRZGFN?=
 =?utf-8?B?TFFWUGtDZUNCQlhWUGZqVU40Z1cvZmQwUVI4L1pwdkdtTWxMUW16NVBoNVhX?=
 =?utf-8?B?bDNJNk1ldDRWQ2pTTGlhUXVHR2xnbjAzVTFsKzA3WHpQYWxlZnNpT0ZXemZH?=
 =?utf-8?B?NFI1SE9WbHpZT2ZUNU9RcUlrRDNhZFloNTlPVEFENk9ERUNDa1BrQXVNRVJC?=
 =?utf-8?B?TXZIOURFRkIrTGxORWV0bndVNnp4cDBTaWM1S2F4VmVaN2p2S1V6aE9UazRq?=
 =?utf-8?B?Z1ZLelZQNHNWZXVuaTJKSk16VEsvMTYyY1hCejN0ZHVwZEQvVmhPaC9GVjFT?=
 =?utf-8?B?ZGs1amI3L0xVMmR6WEZDVEZNMHRSY0tQY25WV2RLTFV5R0J3blRYVWdTNFRX?=
 =?utf-8?B?ei9UdmNBd1NhVXNORzJvSWdJMHRBQUE0RXQ2eTRzNkNvMTVwVDdJTEZtaW1w?=
 =?utf-8?B?MFV6SldHa2Fxclgzc3pxTGx0Umo2OHYwSmJnZDJGalQrbi9lMm5jMXhUT2dW?=
 =?utf-8?B?WHIyaGxvTHkzbS9UOEZJUjBJU3YxTnZMdWJ2eW03UTJCU1h3V3ZnSVBJSmFG?=
 =?utf-8?Q?Qxw4kGkVnNmpilFMoGrcVSjJc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d99ffa15-fcda-4c9c-97fd-08de3162fb02
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 05:23:52.5491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSTFVBBYsDkqz1CjSxP5Z9KMN4DxQrbtd2Ru7TiJO1nBI1A+h+5Ot0Hm8z+opR2rGDb+KmcNcIVNm7eaAQXxWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8691

Hi Joerg,


On 11/21/2025 2:41 PM, Sairaj Kodilkar wrote:
> Patch 1: Reserves the Domain IDs allocated by the host kernel while reusing its
> 	 device table inside kdump kernel
> Patch 2: Cleanup around pdom allocation

Can you please pick this series as it fixes regression (may be for rc)?

Jason's suggestion are valid. We will address them along with some cleanup in
kdump path as separate series.


-Vasant

