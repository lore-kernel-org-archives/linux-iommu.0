Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795193518;
	b=VnERCTXa/n6TO69AmDXYzmIuhLs8xm/dcs7fIeCBYFPx/f7e06VTdv6CjfwfyfOPbo3q
	 rvjeLFpTEF4Bah77POYOUA9liDeh79DrILpiuFxSaL4w6JbqDNyOpaUNjDHFvdlA2VnHR
	 J+MvrhCpBANTUB2f7pdhg3xjQkL+a9ll1wt+NY9LUkDiNhb86vWbhZoot8nRlsb3M7pAE
	 TmkQbYsTRKzEd73Ui7xX/rYt9/+enTKEUDbPqNhNUxB372LPtSXF6uwkB9CIGcQOCSmdi
	 xzrlMeBmOdo5NOjInJSs9KR3fYaMHOmVLG4DTncA0Q9fyQyGGdQGkcMsArVY3m72zIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795193518;
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
	bh=jqo/ruL68hNNMThstbfOO6W3L2pWj/JlTla2sCW2SrA=;
	b=Z3Tf9q5Ch7bXlWcu9JmpQrWj/s+hk9GWCQZjMOYUz5cqStwx7B8gI9s0UUFIoCe9OZBk
	 Bc0GHt+uwi3YHzWVQYpJLvNPWOLEDVJ64yjK40J6Vb3O0+qCjvhsL6YwvzUW3WgC3cUWp
	 VzQ4zl/966ocuIAIDveAVDl6Wa4sLYl+bveJtcLHBs28gD0TfoSlVgZb6bsaB+CVhLyJE
	 Hf2Viz9DVshkyIJoSrQm+vcqjPRDqiQSmTE1qjWRuHhuZKMORaNJsnPjekrWmU+Whxk0Z
	 Dw+ELX05yYyJyUk0uGe+anlx1aicjLk5hq9Gf7z32g2HTXIu/Dw1neFBKsH0nkdBsJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Bdr4AIpP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.62
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F7F606A335
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 16:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16F7F606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Bdr4AIpP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsFeWa2RmQMIIGE5kGoh4Qw7ydW/RNGz4BgIy8IaNSAyg7dWEA6AUOid6kQURZEgf9hPEkOG3kYXC+oOS88cP8yi6X22BR47GpGL4rj8aFf879qEbNQlLALt/fumBpX1klnR+zHt8RUgTjL3p5a09kHCUTE2R+5TyjkdMbOJUMTXzeoDwbTWu25ps4ei/Ef1NpJUORp4HOhbxd1JhnG3onxYaPC9eJD46sDuvqy8ZgpkD1kZ3rk13bvrZ43KAin2lOt4sZx7J1CEqva4ioWWb1NQ4WdJc/OB/j9orwQe5mocve42aaP1ayuKW6ZnJJlEgFBLkjeChhuWDWzXSobA4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqo/ruL68hNNMThstbfOO6W3L2pWj/JlTla2sCW2SrA=;
 b=UolQDV+cTND8rnwmuX1ySK78xL53oZ/uCkcl+/yN1XAyhYjF3aWplJxSCTI1td5N7FHfKQ91FX9znGvmie9kiEF9zwO695Abvx5wWNtBYGDPbsOb62ZXlMbBNyXwwD6V9NcRHDTdixxkSm0P//daJoiSwWL3S72Gg55jmWF0bXcTRcCIpczGe4b8mcwBOggltWFl5Kt/UNO7h2acKtrsQt6Ufa/CMGK328sDkI6hbeLvLNJBryWAsRRMzACYK5ovoHVr3IZMhdfdSUb/DaSZ4XJ3DJhPjE3cH7xr40F19bEvD83sXZNEmVhqMuEGdya67Ei5C8wdGQNyvVoXy9y2jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqo/ruL68hNNMThstbfOO6W3L2pWj/JlTla2sCW2SrA=;
 b=Bdr4AIpPcVm3KLF6uPl3Bt7bOwXxD5myPAOKug45N9hJCJhwA4NUPfWQFOO7+DCFD2qXBcxakSXrRLJg5JHaZjT2M382UPyrlk/4IJVKASflxM5HYrl8ZyszH24fbbDNJyLPsLsqkeCPnGpzYPNK3vM+YRwaMwhkzC1RgRcsrKU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DS0PR12MB8295.namprd12.prod.outlook.com (2603:10b6:8:f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 16:51:54 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 16:51:54 +0000
Message-ID: <29610488-73c7-4ce0-9ddf-d0b56be10a19@amd.com>
Date: Fri, 20 Nov 2026 22:21:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] iommu/amd: Do not convert IVMD exclusion range to
 unity range
To: Sairaj Kodilkar <sarunkod@amd.com>, "Joerg Roedel (AMD)"
 <joro@8bytes.org>, Adrian Huang <ahuang12@lenovo.com>,
 Joerg Roedel <jroedel@suse.de>, Robin Murphy <robin.murphy@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: Baoquan He <bhe@redhat.com>, Jerry Snitselaar <jsnitsel@redhat.com>
References: <20261117070654.3699-1-sarunkod@amd.com>
 <20261117070654.3699-3-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20261117070654.3699-3-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0163.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::11) To BL4PR12MB9505.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DS0PR12MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dfc9131-a615-4c1c-212b-08df472694d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|6133799003|4143699003|11063799006|261022105027099003|261028144727099003|261009223027099003|261022075727099003|10067099003|261102123227099003|261021123027099003|261021121427099003|56012099006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	UHWpy/MD3ENxXtJ0rLlUFpzvUX79MP3zhs3HGP9NdsM65b+sgvkvNSZOmsNRaD+50k3mtF2dM/HLOGyUkzEChn18uyod3wSDAkM25daYwQfsubH9a5G+XJz/Mpn5a03x3AJ2JbgzXmSBLumZF6v4ou7reaQfOrkqQVRdrn5IOWiL6e5X7lHwMjHlahlZSOjjbYKzj4r/sDgBg0El8q5ud2JKjnaU8FK/0MOETN41MGUAOH9RDsOsbWvLFLNJuQYak0amURjZ/D25igYDQ/Ypr+puacCxRp5/JhyHYmuUE4X//g0wJhLQ2jgtAxOgz+Cm1asmPi53dfhkuYPwHudzvqfL+DYs3QcZpUIQ7BjZ5BSjfTEjHvgYxfzkP4UeFXT6RL4ZxPypO7DyahRs6BS8iPM56CBbRrq9YKz7dEwPI+4iptabI2t3EWR5BlJA3f6Hzg8SGXHVn2ogLz3eZ16jCTW/KtMl5xPr0Uukycwyd5+dd80qDFSimTITML5dtxmYj+4cwhMo1y1t3MkfDVcJX9B1F67vGK3izRadpkD/Et0Q1u3p9CYqrSaqSanynUTHPLeUQUf0QTg2dcnWXqlKu/e+Xgg8kGSpD4P1aGH7a3Ex5Nay3XqmYV3EPK7DjgNkAWcDfrwhAjNNkFLZQ85V/hViRQC8YX+jQbQzYVYtJQM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(261022105027099003)(261028144727099003)(261009223027099003)(261022075727099003)(10067099003)(261102123227099003)(261021123027099003)(261021121427099003)(56012099006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzAzMXhqaFF5eHJkQzBWWGpRMW0vM1dxM21GaGcrZm9pbmlEYStJVkx3a21U?=
 =?utf-8?B?NlBoSUZ3V2lZN0dGNlMwNmc0dytEZkVNTEcxWU0rMFNDYytUbEx0NEtLdGJS?=
 =?utf-8?B?L0x0dTVzZDVJMHJsL2UrYkxCSklFZ3BhelhVTDB3eG5LMmxHOXZFRUlmYmlF?=
 =?utf-8?B?bkU1RlJJdHpLNVZYSjRQQ2QzakttUlJqNCtpNGM2RGJDNDFqNE9sUEVKRDNX?=
 =?utf-8?B?dzJveXlUSmFKdWhhdE9oWUE5V1NUOHVVb3NkOVJTUHdlZ1FjV21kcW05Nytn?=
 =?utf-8?B?Z2N1T1ZwcE8rd1RHekJaWEJYa0hpU2p6T2FYM1BLYndSclFqMll2dnZISWVX?=
 =?utf-8?B?bmpSWXhScnY2MGp5Y1llUmVwSEJBL3ZPaGx3dGNscUtBN3Z6aTRJdEpXYUF3?=
 =?utf-8?B?b1Nrc1E5akNmclR6czJBWVB4RGtTeExJMDVjOGx0UzlOWE1uL0pKRWZxU1Ni?=
 =?utf-8?B?QUgzRFptdC8wUzBEcGlZNzdFczMzT3ZNUXUvVEdkR0VZbGVyWmtFSElscGJI?=
 =?utf-8?B?ZTAxZjdNcTZKdkU2NDBQelZkTkx1ZkFPaXcrVjBSY0hRcHBER2FDVmIyOWFn?=
 =?utf-8?B?bE9XZUJneE5JOFdlcDllUnd6bThHUlhTRFZ1UTVFTHBFSzhwRTJPSkltTHV6?=
 =?utf-8?B?bXJYU1dzMW5Dc0I0b1EwWGZjeFZRVk5xc2hCaXlTTEFHZjVGbEpkVEhkMUs2?=
 =?utf-8?B?YkEwajhzcnBVOVk4MVFremlodjFQTks1QnhDcnZmOVpCUW5nOTR2OVdVZElU?=
 =?utf-8?B?eFJ0U1NPdVAzQSs0YWNoR3YwYlpMT0c5bDRNWkw4RkVoQlBGSC9IZ2x1WlJD?=
 =?utf-8?B?bGg5QitVM2VvTmJnU0VQM2M2d3V4amc5MXRxcWhyOEJpODVXQXF1Qk56Tld0?=
 =?utf-8?B?MjQvaWg2a2FCbHIyTFg3UG5wekZWcnd1MFZHYkdkZUZUemw4aUp3MTlYUEFx?=
 =?utf-8?B?a3JHdUJYWEdWR2k4ckVYZ3BXNW4rY05sejkyUEY4N0NTUXFFRnRaczQwZ2Iz?=
 =?utf-8?B?ZmNpT3J2M2J4d0xaVER6R1lORFpjTzUvcXd0L3l0ZFVERDNCWTJJcU8vMzNE?=
 =?utf-8?B?WG8weW15alJKbU9UaDB2VU4xV3B5UWN2WE45S2s4K1ZxUVMyWDNBUytQY0tM?=
 =?utf-8?B?amVQcVlNZy95akhBYllvOE1IMkptcmJDUk81bGxWLzlGZVJsSW9PZmxXZEJW?=
 =?utf-8?B?OHUwK3lQdmo4L2dSb2hoclNuK3I2WC85MTc1elFkTG91UUJOLzNqQWMrZjJS?=
 =?utf-8?B?TGhzVHVKMXNYdGQ1ZUlXbC9KSERHa25BODdzYWkvMEkyQktSa3hrSW5MdFJo?=
 =?utf-8?B?Z2VrM09tY0I2TVF0bmtGR2xYaEhwN2xsVThGeU8zbjZPazd0MTZEb2hQUEI0?=
 =?utf-8?B?d1JMOFNxL2FYZkM1Y0dTYnRqR0pxN2JWVmQyZUVLK0lIRHZJdkFrTXhQVktJ?=
 =?utf-8?B?N1UxNUZ1S2V4K1M5dzFNN2ozSE9NNXZKY0VVcGdBbFdHYkIzWDNkOWpYNEdu?=
 =?utf-8?B?VTByUjRHN1BBN1ZlbUQ5ZHM3R01NdVlBNHhRSmRCNmZFQTdNcVBWOURuRGVT?=
 =?utf-8?B?ODdPWGxmSDFKbzVjRWR1N0lEUjNjR3JDdU1Md1MwQXIwSjVYVDBNSFpmWEJn?=
 =?utf-8?B?R0dxalNuSTdUWVZXVTN1SUhwSy82MW5FZW1lSHZta2UrSzRMZVJ3OWVzM2xE?=
 =?utf-8?B?aUZFTFF5NVRIa2FzSzFjUjM2R0ZJeW0wTlpodzhSYy9kWFZlUXBoTU91ZVd3?=
 =?utf-8?B?eWNkUis0WjNzQUcvL010aGlYMjcrOVZsNGc2cUFaTTRlb0Q4MDNXQmJXMFI2?=
 =?utf-8?B?TXdXbDhMekVsWjB3cHlxNGsxWEMrZDZUeHU3OU9ZcWpQQUhvR2ZzWkpWNVhv?=
 =?utf-8?B?WE9pZGtBalZuR1hkR09UL2FnbXArWGk0Yk9kZjBlQS90K3JKanNzOHhoMGJ2?=
 =?utf-8?B?KzU2UTNKN3llblpwZ2MrZXJmbHEvNTZMelpkT0FNZm1zWWF6VWhoYU1GWmVs?=
 =?utf-8?B?TDJSdjBIR3BiNkdwTStnR1lQWnp6MDE0T0J6UjRETXVkYms0TU40eVQ2ckFi?=
 =?utf-8?B?WmxCcDhDWDArU0ZLUnFVTys2NW12UWxXSTNNVlRxOGNZaXhPWk9lTGs5eHAz?=
 =?utf-8?B?dW9vM21ycDdZZFlHRm9SenIzZ2hpazR2eUd5Q2hTRE1PRGdWaW8wSHFuQVdV?=
 =?utf-8?B?SVh2N3U2aUZaMlJTdnFMRG1qdHowVUtUM29FMHhvSGFXK2w3enZrUytKRXJR?=
 =?utf-8?B?d2x0b1ZPZmI5amdmQ3ZxUlV0TStaUitwYjgrSW52RW4yazBNY2dsRUZReDNM?=
 =?utf-8?B?Wnptcm05TEZaL1pGYkZDODNOblVvdDFmWkNhbFJYN3EvaTlCY3JDZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dfc9131-a615-4c1c-212b-08df472694d8
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 16:51:54.4642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boSutke2x6GwtWJ98u/pULjDvj3zouQR1gXhZKI5Eh9BDzjAoUgEQR1HupiY9jm1NLtY9xrZr7e00MWj/LnVnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8295



On 11/17/2026 12:36 PM, Sairaj Kodilkar wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> Original problem was there could be multiple IVMD exclusion entries
> conflicting over a single exclusion range supported in older Linux
> kernel. The fix was first introduced in commit 387caf0b759a ("iommu/amd:
> Treat per-device exclusion ranges as r/w unity-mapped regions") and in
> commit 0bbe4ced53e3 ("iommu/amd: Fix the overwritten field in IVMD header")
> , where IVMD exclusions are converted to separate unity_map_entry objects
> in pci_seg->unity_map so amd_iommu_get_resv_regions() treated every such
> entry as IOMMU_RESV_DIRECT with R/W.
> 
> The driver no longer programs the exclusion base/limit registers and
> relies on the kernel to keep the IOVA ranges named by exclusion IVMDs
> unmapped. Stop forcing exclusion entries to RW-unity. Store the raw
> IVMD flags in struct unity_map_entry instead of a pre-shifted
> protection value, and derive the reserved region from those flags.
> Exclusion entries are now reported as IOMMU_RESV_RESERVED with no
> read/write permission.
> 
> Reject unity entries that grant neither IR nor IW with a FW_BUG
> message, and warn about invalid flag combinations and unknown flag bits
> 
> Fixes: 0bbe4ced53e3 ("iommu/amd: Fix the overwritten field in IVMD header")
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Adrian Huang <ahuang12@lenovo.com>
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> Reviewed-by: Adrian Huang <ahuang12@lenovo.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 12 ++++++-----
>  drivers/iommu/amd/init.c            | 31 ++++++++++++++---------------
>  drivers/iommu/amd/iommu.c           | 12 +++++++++--
>  3 files changed, 32 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 678ceddd711c..122eac81d4e3 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -368,9 +368,11 @@
>  /* DTE[128:179] | DTE[184:191] */
>  #define DTE_DATA2_INTR_MASK	~GENMASK_ULL(55, 52)
>  
> -#define IOMMU_PROT_MASK 0x03
> -#define IOMMU_PROT_IR 0x01
> -#define IOMMU_PROT_IW 0x02
> +#define IVMD_FLAG_UNITY_MAP	BIT(0)
> +#define IVMD_FLAG_IR		BIT(1)
> +#define IVMD_FLAG_IW		BIT(2)
> +#define IVMD_FLAG_EXCL_RANGE	BIT(3)
> +#define IVMD_FLAG_MASK		GENMASK_U32(3, 0)
>  
>  /* IOMMU capabilities */
>  #define IOMMU_CAP_IOTLB   24
> @@ -880,8 +882,8 @@ struct unity_map_entry {
>  	/* end address to unity map (including) */
>  	u64 address_end;
>  
> -	/* required protection */
> -	int prot;
> +	/* IVMD flags for the entry */
> +	u8 flags;
>  };
>  
>  /*
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 13c96feed64f..de8e4ba2ccd0 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -70,11 +70,6 @@
>  #define IVHD_FLAG_RESPASSPW_EN_MASK     0x04
>  #define IVHD_FLAG_ISOC_EN_MASK          0x08
>  
> -#define IVMD_FLAG_EXCL_RANGE            0x08
> -#define IVMD_FLAG_IW                    0x04
> -#define IVMD_FLAG_IR                    0x02
> -#define IVMD_FLAG_UNITY_MAP             0x01
> -
>  #define ACPI_DEVFLAG_INITPASS           0x01
>  #define ACPI_DEVFLAG_EXTINT             0x02
>  #define ACPI_DEVFLAG_NMI                0x04
> @@ -2636,6 +2631,20 @@ static int __init init_unity_map_range(struct ivmd_header *m,
>  	struct amd_iommu_pci_seg *pci_seg;
>  	char *s;
>  
> +	if ((m->flags & IVMD_FLAG_UNITY_MAP) &&
> +	    !(m->flags & (IVMD_FLAG_IR | IVMD_FLAG_IW))) {
> +		pr_err(FW_BUG "IVMD type %#x devid %#x range %#llx+%#llx: Unity set without IR/IW, ignoring\n",
> +		       m->type, m->devid, m->range_start, m->range_length);
> +		return -EINVAL;
> +	}
> +
> +	if ((m->flags & IVMD_FLAG_EXCL_RANGE) &&
> +	    (m->flags & (IVMD_FLAG_UNITY_MAP | IVMD_FLAG_IR | IVMD_FLAG_IW))) {

Spec says IR, IW, and Unity are ignored when ExclusionRange is
set, not that the entry is invalid.


> +		pr_err(FW_BUG "IVMD type %#x devid %#x range %#llx+%#llx: Invalid IOMMU flags %#x, ignoring\n",
> +		       m->type, m->devid, m->range_start, m->range_length, m->flags);
> +		return -EINVAL;
> +	}
> +
>  	pci_seg = get_pci_segment(m->pci_seg, ivrs_base);
>  	if (pci_seg == NULL)
>  		return -ENOMEM;
> @@ -2665,17 +2674,7 @@ static int __init init_unity_map_range(struct ivmd_header *m,
>  	}
>  	e->address_start = PAGE_ALIGN(m->range_start);
>  	e->address_end = e->address_start + PAGE_ALIGN(m->range_length);
> -	e->prot = m->flags >> 1;
> -
> -	/*
> -	 * Treat per-device exclusion ranges as r/w unity-mapped regions
> -	 * since some buggy BIOSes might lead to the overwritten exclusion
> -	 * range (exclusion_start and exclusion_length members). This
> -	 * happens when there are multiple exclusion ranges (IVMD entries)
> -	 * defined in ACPI table.

I'd say update above comment and keep it. So that we know why we removed
exclusion_range register and used this method.

> -	 */
> -	if (m->flags & IVMD_FLAG_EXCL_RANGE)
> -		e->prot = (IVMD_FLAG_IW | IVMD_FLAG_IR) >> 1;
> +	e->flags = m->flags;
>  
>  	DUMP_printk("%s devid_start: %04x:%02x:%02x.%x devid_end: "
>  		    "%04x:%02x:%02x.%x range_start: %016llx range_end: %016llx"
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 56262f6b1f70..7edaf99a1ecb 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3120,12 +3120,20 @@ static void amd_iommu_get_resv_regions(struct device *dev,
>  		if (devid < entry->devid_start || devid > entry->devid_end)
>  			continue;
>  
> +		if (entry->flags & ~IVMD_FLAG_MASK)
> +			pr_err("%s: Unknown flags: %#02x for sbdf=%#x\n",
> +			       __func__, entry->flags & ~IVMD_FLAG_MASK, sbdf);

init_unity_map_range() is the right place to add this check.


-Vasant

