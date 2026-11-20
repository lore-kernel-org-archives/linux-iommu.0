Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795192705;
	b=gPWhanSEMExJmzr7MTLZW/WbsrsFNAJLg44tg/L3F6O9Qnlc3iUWjoUGmxGU7HFvixeC
	 AB0LkjR0PtnsFFuRZUmXDKBy8bFP/uPiSlPWXaBFpFFJuSUUm8emG3AM3yccd4oARJYot
	 eHvnzbqNhFffaLNZmRi2QGOb4KuNF5G7MThQzGSkXgQuxWGsst2DpvLFaplxjJP13dA5s
	 zPNPnZ447T4Asc/KXrPzNXgNzdcWa5h62+KCoVIf98koXbf4oxML5Imqy7EAn1z1gbCEs
	 ZOL6VSpVqM2RtJVTd9FRSL6PN0DD/5yw9m96lvRQWnGTHbcAChQhLb0I6C8rPe2ZsnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795192705;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=TQThoXxAY++q6uUlTk7Vtho7VATde3AuFTpdxXg8pEM=;
	b=PvLkyBjJn1iOBpWPisBnBYQZf5TRY7UyYnabZ7TtF0LTx82casKb1AToHZKWyqT82tQc
	 u34TBDs1RTfV5mebPsBZ+IUouC+6AtgG2nqh4JUAr/mtvtiRzjiZ3pEvJZv7mFTgRiF3k
	 8PqNB2yskY4B4EOguRu/LLc1yC7QS8ESFufGVKCax9Z090kV4VKXOPsb1sG79tn3EXUQL
	 7QQYy9oloYNQIxIhKweTYHInEPeEHxPMuvAsch4ZOWJPlP5OcDXF6G6ZhbqUKWHKiQ8jQ
	 OumiSWGE6qbSepjF28+Jb8LPSJ3P+327U0rnurlK/z65jcglqjJkIV53GvakIEYrBPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UobcoGKy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.38
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011038.outbound.protection.outlook.com [40.93.194.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A893960A2606
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 16:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A893960A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UobcoGKy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nuGzcdglFJ1SKtI90b/fXKHXdsAChvvEsLUOVRpKJE7wOgpRDzSgCV4mUy8/ICTK8WcCCretVexLxP5FNCICHCWKKr4vPu2jEl11oOeHF2FX+S7Md7FwDslraQ7SW7ZafGHdJRTcL3l6YNDT8JxuFUzVNISZnOVSex/uLV06341wDSlPqYbEImS4tnW68eolGHSbpiOAYZjzsfplmqa4EFVJZbUffVFSds17mAiSztowZabN1OjprjvR9vxYsKX6Pj+PjSfpxHIwXvtfK2E1+EtfGN9WJu9PCX+qIHpj4SkW0wWFmRN4yqlfLOZyY5naPhsn44NgrYFnQorb0z8gHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQThoXxAY++q6uUlTk7Vtho7VATde3AuFTpdxXg8pEM=;
 b=XOZKBxhr4mT4NwnVosOLoAgQa8+sUTxBG8DI8H28aA0meUn4cP8rnDX69b1SM2gdIZFNaG9hk2w9++lSsC8p4tmnvvLaf+g+hfz2zyYWlnybThlY2IT8x08x7mUNF2+fBuMo08sJViI5bEVoywHY2SKLWSuwkl1DkkEobHQExVhBmQD7ivgDRodBlbDDQmZ57fNKmM5jsB6sqDq0xgRWIMRndNT6ehvd4FIU6UJqAlAuFHjxWZfe0QgDjBuS+815mxiooCbwtGAwR5YihNJM31nKXXA3xXPWjZNTGooJZ/AkT1+MtrYdtLkKqycYvhVEjIltNzhUJAENh5KV3a08cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQThoXxAY++q6uUlTk7Vtho7VATde3AuFTpdxXg8pEM=;
 b=UobcoGKyo6JjnZl56E+P0kOB7oQO0vr6cueYzy8MRxdtyXwr6ycZBXdr7qqZg0iH+l+vSRXvoOgHrXzdch2xq+75/XZA+4v9IJ2R066YDw6bT1XTJNSec6DEEPpqq3BsHLQoUkHE6GqMwUjydS5G8eQRZZHE69zkhk8zzh3F6q0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by PH7PR12MB8795.namprd12.prod.outlook.com (2603:10b6:510:275::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 16:38:18 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 16:38:18 +0000
Message-ID: <47b7530d-85c7-4e85-a90f-3a100008b8fa@amd.com>
Date: Fri, 20 Nov 2026 22:08:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] iommu/amd: Drop unused global exclusion range
 fields and init
To: Sairaj Kodilkar <sarunkod@amd.com>, "Joerg Roedel (AMD)"
 <joro@8bytes.org>, Adrian Huang <ahuang12@lenovo.com>,
 Joerg Roedel <jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: Akshay Jindal <Akshay.Jindal@amd.com>
References: <20261117070654.3699-1-sarunkod@amd.com>
 <20261117070654.3699-2-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261117070654.3699-2-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0249.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::15) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|PH7PR12MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dfa5ed0-26ad-4df7-5800-08df4724ae84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|261009223027099003|261022075727099003|261026130827099003|261021123027099003|261022115727099003|261026135527099003|261021130227099003|261028144727099003|261021133027099003|261026140227099003|261021135927099003|261026121527099003|261022105027099003|261022113327099003|261021121427099003|11063799006|56012099006|10067099003|4143699003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	TcIsxWGI4Ls8bqjM4m2g+Qh/2AakZ+FnnqKe/Moep3eBtXTVOMsoAUac7CdebIQ88j0EOvhM6PcbxlNFQvWAyT8zCoUqcF+/kMj1JZ8MMn7xKq56kFzEgioLLAx6C+b7r1IOoyYDIn0B7Xo0hOiBrzkO7FJ6eFCzv8pnHWQupCnD2Sb6QtWqNEE8iUTw+dE/BL1OqSZkmyQ5d7vxKumKfGLKNPoC4qOQhk7KWXUSZ+q4seFAY0AJKeRkgf/er8WAij9PgkJ1ODJEwG7FSB209RWt0xypopfH9nxmTzKJTK+D5CkpW/PFdelZ5Uje3dHsj6g5P5CWGb814H8UeIhA8vZzvcIt9Nm5ZxeR71qVU5LoRTpekf9Rxfow5RhJDb8r+l+xYOVjy9huajdYF7qsY5ipiTJU+l2r5UGWS8BBrdU9x5BUjNPcZ3F+dvIyWcl9nAyy9hWdNAnlODt8yt+VH23gMOUXgdHh9VJCmjOGb6AwnqqbbcZ2M8za/CCQB20tCWcy7F+m9m6vklZWl8F7mljvfpKO7NqrFe2E+c9o+rJshU/CVHN5/ss1B32g7+eC0COUOTnfuTiMiMsK3ohzuh4JpOuz6sACdtkygvhs5ZuTlwdS7dbbslRzYY9PLs0Jlb52/y3ABw7W9zfNC5pEHXv7sdn3V6RXrnUNAcXEbWQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(261009223027099003)(261022075727099003)(261026130827099003)(261021123027099003)(261022115727099003)(261026135527099003)(261021130227099003)(261028144727099003)(261021133027099003)(261026140227099003)(261021135927099003)(261026121527099003)(261022105027099003)(261022113327099003)(261021121427099003)(11063799006)(56012099006)(10067099003)(4143699003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlF0TnN5d3ZaUVNzbktGdENTNDZ0Y2xhUk1oOG10eXd6bldtd01UTDM4MUZZ?=
 =?utf-8?B?OHRFSkhjRnNJZnVKa01lNGh5ZTJuWjNtdE0wMWxvWE40ZjQrTjlza1pzZ09s?=
 =?utf-8?B?QllRbU11dGNSa2RnaXB0SDZzUW82WGd1VXNQdGlRcnhrb2V2SzErMTNDbktU?=
 =?utf-8?B?NkJEdktHaXZWY250Y0Z6LzdGbkdXYVJaVVEwelkrSFNQZS9DL2pMVHBRVmt1?=
 =?utf-8?B?NURNNEYyanhGZFB3WTRkNkNIT0Q3V3d4VHV2WnZQaWxwWTZORjlKYVEvc3Jv?=
 =?utf-8?B?SXNmNmpVWlVaZS9DbFdzRGhVRFNBYnBtWlJ1ZEtXRXNZOUdiMmJXVDdhNGNV?=
 =?utf-8?B?bzRDcDB3RWp4dm1OaTdTYVpMMFFUejVGcGxKWVJTcXVQTkVwR1BaUlE2NWFq?=
 =?utf-8?B?YlptYUcybkZER2wrMWZJMXM3QURvV01IRnBjenpyUGlGWEtXQmkvdmFGSUEz?=
 =?utf-8?B?Qk9aY2JQSnhqVjNrbE9JdkhCR21WRWtMMittbm80NGx4Ny96eWJNWkFRcVJk?=
 =?utf-8?B?WU92VGZldjZYbnJsS0JlWkYzNlJLNkkwY3NKTGZhTVBJZlJzanpCVzZ5ME5t?=
 =?utf-8?B?REl2aWVkbHpRbkxPWXVKR2NUNkRNd3ZqWVhVdEJvUmNnbkYvcWp4ekNoSW4x?=
 =?utf-8?B?a3piS1hRdzc3eDk0cHRWbys3RHI0MzFrTS9kczc2VDUvaFFCcko4bGVhMXhX?=
 =?utf-8?B?MjVkdmMzTldkeXJ6L3NPeWZIZnpjc2JlMXBKUzFRaWhQUEtYbWZMZUl3MmQ5?=
 =?utf-8?B?TFcxMGJ5TGNZRWozUXVCejJzdUdvcWNCUUFvcDFsYlJHcjE1MDgxTXVpWFM5?=
 =?utf-8?B?VmFMRTBzSGVERFNCaGlnQ2JseThwSnpQNlQyU080VlRLZFhKZVNWSWkvVCtD?=
 =?utf-8?B?ZnY2eEVUZGtpL3FqU1oxQjY4dG9MTzB2bFhCUVY1RVN0RW1qb3g2d1VhalZn?=
 =?utf-8?B?T2VnOGNsdTQyUWpYcTI0ZklZUTd1WkJmcU5NT2Z5Q3U0N3ZlL0dJZG5pUUd5?=
 =?utf-8?B?VWtUcnB4QmhMS21RcnVSdXJsUjJHdFZOVmkwYmQyZS9WK3hQYzc1Ym05SEQ0?=
 =?utf-8?B?ZmtPUDZlQUNpZWxSMUJmQkZpVmRYdGJCdC9jK0lyUEZKWXNGMzRBOUF6ZGV5?=
 =?utf-8?B?Z2s2aGlRMXg3ZFgyS3B2S1F0eG41M3JVYWpOckwvRlduMll1ZEo2cnBBV2Vl?=
 =?utf-8?B?MHJSQ0djVzBqYkxLMktKSVA1dkp2UVpCNjR6SWJzMkRVN0I3M3JKeS9qaU1R?=
 =?utf-8?B?Rk5sbW5RdHMwWnVkcis1M1l1VzVCblpjZDR5b0hUOEVIbXZ6dVhlRnB6NjBJ?=
 =?utf-8?B?K1VIM0RCMXE3L0JpSFlOTmdwLzIxanBHT0o0QkFwUnBrc2xaeG9uNGtibEd6?=
 =?utf-8?B?L3Z5VzNjdkhCVkpJcWhRcjI5MzVvckJhaGR0aHN0Q3l6RTVCeWJRT3lHT2JZ?=
 =?utf-8?B?VFE0Q2NCY3hmYmlJaFowZ0ZwNHlJemFYaWM5WFNpNHFpaGlZWFFndTROTjR3?=
 =?utf-8?B?amUrY0owZ1Bhc1RIV3ZSV092ZVo4WGtrRk5McXhSQUp0V0l2M04xVlB5VkZP?=
 =?utf-8?B?NW1IN3NHTXNyUHdCSmg3UHpCSWFIYkFoaVBzMUdoblVjODNvMjljQXB0UnBN?=
 =?utf-8?B?WlhqbEJIaEtYQXVrUzBZdENNOVVzaG1LY1hYTlhHOHNjRmljbTNYcm40U3Vh?=
 =?utf-8?B?UVVCQmdwSnpVc1k3bWgzR25zSmMxcXNNamNPc2lGd1psTDZON0lnbTc3OXlk?=
 =?utf-8?B?czM4b1lmaUhKSUtreTlZbTNBMWd2ZkFIUVZrdTdBbVJ2N3Q2TklLaks3TlFR?=
 =?utf-8?B?ZFR0NE1UUnlwcHJFaUI4NUl3NENha3hVMVF5eWpkWndSLzg2TUo1ZGFvYjJj?=
 =?utf-8?B?MjJhVWlCSER5ZVAxbkxjN3krVWZJbUpQNWVEbHdKcWtuS3RicmZ1bDNlc2NO?=
 =?utf-8?B?OTV3Z2xhR0F1bmM2YS9PY0h0YzBrUERKZFJCS3R3YmxWTHpTUHh5SElpN1Ro?=
 =?utf-8?B?S2VDUzQrSzJmOTVBUldwVHZUNGFEVlZ4KzJHQTh2WitFdFZITjFNelVDdFEy?=
 =?utf-8?B?WUZLQUFSZ3FCc3IwNjJ3eHBrdnhXR1QrMXRMNlp3YjBxMU4yNE9nRHRqZUNl?=
 =?utf-8?B?b1ZoL29sRE00Y0s4Q25XVU1xVjRGbzZYa2RlTG5TUkg3dE4rbDdzdmkxVWZ3?=
 =?utf-8?B?MlhKcUZUVElDeGNZY0lwL1hQWW5BcU53MDlTNFc0NWpQUnAwMjdCRWp3WGFE?=
 =?utf-8?B?eHRjeklJeHArOVRWdkREZ3ZHRkZLMzlRN1hIa0dEU1U2N2tHRTR4VGdLVEhY?=
 =?utf-8?B?bW9zSnJGc2J2K2VTT1BXU2ZYZU1zWVFjcktEQUs2V1FtS0l4dXhvUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dfa5ed0-26ad-4df7-5800-08df4724ae84
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 16:38:18.4793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57RZCg0EmGGycOoDELavrmP/DgPq8Idw6V65QolSgmOrO3cWPahqm1SXA0hd4yf5dhHTJNvEgMpQbX3j9u08fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8795



On 11/17/2026 12:36 PM, Sairaj Kodilkar wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Remove unused struct amd_iommu.exclusion_start/exclusion_length, the
> MMIO_EXCL_* flag masks, and iommu_set_exclusion_range(). These struct
> amd_iommu fields were never assigned, so early_enable_iommu() never
> programmed the hardware exclusion registers through this path.
> 
> Please note that the exclusion range registers have been repurposed
> to SNP completion-wait store base / limit registers. So, rename
> MMIO_EXCL_BASE/LIMIT via to MMIO_COMPL_STORE_BASE/LIMIT instead.

Patch subject/description doesn't match the code. Can you please update the
description?

-Vasant


> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Akshay Jindal <Akshay.Jindal@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 4 ++--
>  drivers/iommu/amd/init.c            | 6 +++---
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 8241ef922519..678ceddd711c 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -44,8 +44,8 @@
>  #define MMIO_CMD_BUF_OFFSET     0x0008
>  #define MMIO_EVT_BUF_OFFSET     0x0010
>  #define MMIO_CONTROL_OFFSET     0x0018
> -#define MMIO_EXCL_BASE_OFFSET   0x0020
> -#define MMIO_EXCL_LIMIT_OFFSET  0x0028
> +#define MMIO_COMPL_STORE_BASE_OFFSET   0x0020
> +#define MMIO_COMPL_STORE_LIMIT_OFFSET  0x0028
>  #define MMIO_EXT_FEATURES	0x0030
>  #define MMIO_PPR_LOG_OFFSET	0x0038
>  #define MMIO_GA_LOG_BASE_OFFSET	0x00e0
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 8a410d4aa370..13c96feed64f 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -370,14 +370,14 @@ static void iommu_set_cwwb_range(struct amd_iommu *iommu)
>  	 * Re-purpose Exclusion base/limit registers for Completion wait
>  	 * write-back base/limit.
>  	 */
> -	memcpy_toio(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET,
> +	memcpy_toio(iommu->mmio_base + MMIO_COMPL_STORE_BASE_OFFSET,
>  		    &entry, sizeof(entry));
>  
>  	/* Note:
>  	 * Default to 4 Kbytes, which can be specified by setting base
>  	 * address equal to the limit address.
>  	 */
> -	memcpy_toio(iommu->mmio_base + MMIO_EXCL_LIMIT_OFFSET,
> +	memcpy_toio(iommu->mmio_base + MMIO_COMPL_STORE_LIMIT_OFFSET,
>  		    &entry, sizeof(entry));
>  }
>  
> @@ -1022,7 +1022,7 @@ static int __init remap_or_alloc_cwwb_sem(struct amd_iommu *iommu)
>  		 * completion wait buffer (CWB) address. Read and re-use it.
>  		 */
>  		pr_info_once("Re-using CWB buffers from the previous kernel\n");
> -		paddr = readq(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET) & PM_ADDR_MASK;
> +		paddr = readq(iommu->mmio_base + MMIO_COMPL_STORE_BASE_OFFSET) & PM_ADDR_MASK;
>  		iommu->cmd_sem = iommu_memremap(paddr, PAGE_SIZE);
>  		if (!iommu->cmd_sem)
>  			return -ENOMEM;

