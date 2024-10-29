Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9512B187FE0
	for <iommu@lists.linux.dev>; Tue, 29 Oct 2024 10:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730196416; cv=fail; b=eJjSKA8WQqYKnY7rQCxxXW1PJOn7jX6kU/ssO+u4gZmkOXbbtSrlDI0svraN/nndBcpW89n17nE5MW0SgVORJJUNRweeAr873jhS27FxiTQe5MwmmCBvxpXCtbTxaSlLQI2Btf16h2A9O0BPxDs8xgKL3JnQ/VHkXFyfQ+nfqTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730196416; c=relaxed/simple;
	bh=wYghCXdNbTye8jF6IA9HF7cHF1V07gMy+U66FIanO8o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nl9XVWTi3vT62DW+797eaO72lWDY3H66Bogq+L9O7Kw1cLLsZPNbGb/Eu8js28Gz3kqZ+CkoaPyMU9Md7JfEGDawhAaO7/gXyq2bbL7t8YxFXFy5YcIlZ9TGfCuMu4JZ77WAa1iSNng4haZCGzXO1043UxWCy0TtM5XHoPoFkTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IT9oQkC+; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IT9oQkC+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5/bFZfU8d8TqVlTyzno4ntoJqFbQegXK4VIuYadtL4wAupRj9FdFUF94rKayZhd64H/pJI6tvMiSo6pZGa4PZLokO71e239IzkbkA7GJBhUdJhcbfsSYgVEknv9b00xVyZ7U+pqcTTyWlmzYhg4Uv+uXcq1eqlUjdtSuMb11YcITSS+9xRYTweAsM+4RHoRM8ulp9XIHAufb5uC3sqScH48jb9+oq39ExIxRgGOY+y8C6eVxkuCv/FBrDXGr1uFVfs9C4MeH0GLjQn1D+TIdB0fvp1/Kulsl+/9pB1RGOE+msM6sSFfIm74frThW68HOabsBokOHPsCszSdWLygbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/7FG2FyGFXHTJRzLzf5jnF5CYFa7uQFEQZ6booReMk=;
 b=Cc1lz3Egqi5ac2IH/7nPm8xBFe2fskpFHlcoljwh6IVmksraN0JU+7Tito3NqFbP/kUka2u6l5p4w4BFJSOXz63W/x5MWwXV9XFkUqD6QgCoecSezQPi9EQWUWIe5PSSEWM7ipCqaPUi2YLNr16m/PYE/HG2b6it51c5tQtel+L+8T4Z9891GCotwLS+TkHYXDkEa56GSvt6+vuw2nwpEtFhNjShzM/oFu11smexHANgEhl3CLSOGNiJWtpaXc91j3ydXAUAnhhmoQBfeHUmoe4/b21O3xSwXV4xr4TFrw3zZruCTQcS1/84LUa1WowYrJOstmfVadKEcWChlNEr8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/7FG2FyGFXHTJRzLzf5jnF5CYFa7uQFEQZ6booReMk=;
 b=IT9oQkC+Ms8a7YMgwo7b0HzyT1h+GeTbyZV1mpFWGO+jW45AjhTfuj3m328R549Jt12781K9Ceq11hz99FOkstwqp1SMRn6rhTtypxqQIgxp4JaoPi3xE8DSgIrzmbWYgEBM679e69mmc0LXexy/fITXAeR0G8pc7QphhC68Rwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB8417.namprd12.prod.outlook.com (2603:10b6:8:eb::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.25; Tue, 29 Oct 2024 10:06:50 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 10:06:49 +0000
Message-ID: <ad8bc41e-e6cc-4a91-8cef-6aaf06703cdd@amd.com>
Date: Tue, 29 Oct 2024 15:36:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/12] iommu: Create __iommu_alloc_identity_domain()
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, jgg@ziepe.ca, yi.l.liu@intel.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com,
 jacob.pan@linux.microsoft.com, Jason Gunthorpe <jgg@nvidia.com>
References: <20241028093810.5901-1-vasant.hegde@amd.com>
 <20241028093810.5901-13-vasant.hegde@amd.com> <ZyCtLXeZxhNHTPbX@8bytes.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZyCtLXeZxhNHTPbX@8bytes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0101.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB8417:EE_
X-MS-Office365-Filtering-Correlation-Id: b966ce2d-bfff-42a4-b3e7-08dcf8016755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SFhLbThjRnRNeFFaV2pxejFJY3RXTUxUOUpXNm5JdWJ6WXNBNDBvTTRnNkh3?=
 =?utf-8?B?UVFvellWckpVSGRGVnJSdHhEakphTFBpT2lsenF1dnRwWHVBMnlNOTVFbi83?=
 =?utf-8?B?RjNVbFlSNW4xRmszZVlqQUFvS2EyTGNtOWRsMkdBU1NwVnB6T0xhaUlYd29R?=
 =?utf-8?B?V0l4Q3VXenhucjVuN1V0VjdMTWU4K2lOWkIzQVNubi9SSmNiMTh3R0FuUHUz?=
 =?utf-8?B?dXAzcFVFNHVMTWZNVGtNbjVDbm9rNHhmeFlBTkhiSG5aMTlETFBnZ2RIRHhB?=
 =?utf-8?B?Q2xzSmowNUhaZHVRYmptQXJvT0gxVE9aS3JGNlRzV2N2T05qWmdRWkJmQXBx?=
 =?utf-8?B?eGFMRkdTTlFtc1pzcGJsZkFrMmhkc0pxY3A1UjBjNzJucStuUzlmS2Z6WlVq?=
 =?utf-8?B?M245NFFQVjFmOUNxSTk5aWdZOXF0UEFrY2QyQXNxdG1TYndTci9GSUhMeHBE?=
 =?utf-8?B?bGlGTWlLdU1KbUdEemlhSkl2Q3Z2YWZWRzIySGZzR2R0WWVvM053QnB2VU5y?=
 =?utf-8?B?ZUxOT0IxaGIrVDNQaEpBalYwbWd1R0hqRkRoWEFiNWVKbjJWN3gveGkwTjE0?=
 =?utf-8?B?a0VFVVNYL0RhRjcxYTBvamU3ajdkU3FLRHpwaEduRGhMVCtVaTdLUlBGRTJh?=
 =?utf-8?B?SUhSZXlDOWlSM3J6YmpJMjhmMEE3UkhBVlZTNnhwRmFIL0p3bEVQemJlUHNz?=
 =?utf-8?B?L01Lak5GV3RoZHlCN1o4eWRuWGpuaktrRTZPYTdlaG5ZcEU1OEE0SmZ4ZGtM?=
 =?utf-8?B?MXFUV0hvZWdHYWVod1lOaHpUcGxnUEZQVGRRbFV0dndPVk1aSlg0bWlHYnVL?=
 =?utf-8?B?RXFTU3BVenY3V2JCMVIwRUxLNnZCMWlJc3hjN1NrRXhMcmcySjh1anBaY3Zl?=
 =?utf-8?B?V0FMdG1WaTVNbG9rdW5KYitwYmJ5MXNTWTUxR1VLMEVKRHNMOUJxSzIwMUEy?=
 =?utf-8?B?TjJOdVRpZU9lWVhSdDJaRmhkOGZDNlVjQWRsbTZNNWZiZXJPZjhXWTgvb1BL?=
 =?utf-8?B?TGlDVnIzbkV5azRJbGI1SGg2Q1FGS2N3RUxxMW4wSjlaZlQzdmVETW9yR1FR?=
 =?utf-8?B?RjZiLzNIUDM5L1RyL1VCMm9pL2psZzNSbm5nNlpOMU1NdnUwelFsd3duSjEv?=
 =?utf-8?B?QVk4YjJyd0haYlNlOUlyajJiaThRUkozenBRZEoyYVBMVWVSRXRtS2xPcWpS?=
 =?utf-8?B?bmFuM0lVRkJKRDNHWVZvWmhNV0xUMi9HelJhcUdtc1V1UGJMNFdHUWxtVHFO?=
 =?utf-8?B?SGx6MkNudWdrYVQ3cnNVVnFWZDNUb0UzRUlkSlhqL0ZjalhjUUlRKzVkTXY4?=
 =?utf-8?B?SUhiQmF3Z201RTU0R21sU3lreVBkNTZRem9ON1RLMFZjc09RQy9rR1hyTmdq?=
 =?utf-8?B?c2hWVmdPRUpTVVRsNDFaWVZOQUpjYkQwVTdQdzcrbGZ4NHNkWjVYUTRCMTJh?=
 =?utf-8?B?T241WExrc3Q4cjNNejIvN2JMWk1qOGdNM2ltQ0o1WlpQWEZ1V3N5L3BwU3g0?=
 =?utf-8?B?R0U1L3BmUDh1UUx1Y01ReGF4MVJXYit5ZnZycFVkb1IwZFNpWURaT3VqNTdT?=
 =?utf-8?B?ZUh1ZWVqamhjK3A3MnFQTnBmYitPSUdBaTdiWXVVTHNGdVJZbFM3OHVHOSto?=
 =?utf-8?B?b1lKMGRsNXlVbStXQzV2cVd5WXc0UHNZKy9OZE9IVUJNTTViL1BFemZaMUN4?=
 =?utf-8?Q?Xg2oDJAkRrK8zwo7qcCw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MlVHTlJFMk4rTHBYdVorYmgybVAxRjFUSXJWL01Kc2FGTzZJSktNZnZ5ZFJu?=
 =?utf-8?B?U3Z4aG14alJIeExnK0JUSHkwZ2xxMjAwdFlVVGNiUTdOZzVnTG9yRzZ5Q1Jt?=
 =?utf-8?B?ckwvK2pxajhHQnhPZk9xRjZvYTN4QUVoeGpaT1F4WXF1MkUrcGlCOUExYWkr?=
 =?utf-8?B?VzRXMjk0cENzdGJnZk5uVVowRXptcnQyY1phSXJsamNVWEdESTl3bDQzRjdr?=
 =?utf-8?B?T1J4UzNKc042anJ5eHZhdmxYem1LOEVhOXIzeEtPaitCcXMxNisvU2tkSndx?=
 =?utf-8?B?VXJ5Y3UzVCtyOFNnRDUxWGp6bzIxRXRqbktGbFBRSHRtV0hRaWZjeldna1Ri?=
 =?utf-8?B?S1QzZDJNZkFSVDBHcmdJRDAyZUhoZ2pWbHFQWXltV25oYW53bWdrY2RSQ2pY?=
 =?utf-8?B?akorWSsxSXJkL2xQcmRsMVFDM3djejNjUXlKK2FuTkR0R1p1ZnhyUFNyQU5o?=
 =?utf-8?B?Q2Z5ai9HUnorUHMvTjRwY1BtUW9ZYi9hNGRLOGRwUytPZWFMbXpnT3preFRZ?=
 =?utf-8?B?aUNmdHNvSCsvckFvSmUxTXVZZjY3emtYQXJzcDJOZDdTdHVRaG5wTmlKVVNn?=
 =?utf-8?B?N25WbmJTYkM5QXVMb1l3VVhKTXJ5a3dlY295SklJSUxPNjZ1RUdldzNITnNK?=
 =?utf-8?B?NXZDdG1FdEdyRjc3bFl0T3VQUU5JTlgyZkl4VktQWUdZMDFsZ0F6VW5LZ1JF?=
 =?utf-8?B?enlSSEoyQ1J2N29ZUUc3Yi9NUWxpTGhoZjJqb1NnVWJWdnFCVHZWUjE1dExZ?=
 =?utf-8?B?MjloL3R4dW9QMFBHUjI2YkZxTHlDZnpMR05jRSt1cTdDNW9KcG1HN1U5SVFI?=
 =?utf-8?B?SmY3YlR5SHVaRGNrai9BZi9TRUZpc1Z6MEhiWjFJU09qUGMxY3dxTU9KUjNQ?=
 =?utf-8?B?cElFR2FVWHNpbzRQUE9VVzdVMUVCME94QWpLYWpEa1ErRlh3d0FnbGRIYXhp?=
 =?utf-8?B?UEh6cHhyWk1TajQzSVdyNHdKS0lnUWtIZnZnZCt3TjRNZUNXMDNuTGRuNjJq?=
 =?utf-8?B?ejhqT2dOQTNQU2pMYitUSkFCbFZBYk5ueEUwcDAxeWN2SUVlMTJ2a3BVVy9Z?=
 =?utf-8?B?UU04VXNBVTY0Zkw2VjFzNnFKdXMzeUVvOXNQMTdHMm9wK1ExVDR3N0llaVNh?=
 =?utf-8?B?YXpHampWQUFMK05wS3JvbXZlUU5vbHJVUUNPTkIxbnQyOEhLK2F3Q2JMVitY?=
 =?utf-8?B?WlBKVDhXZEtGeEhHMC8zVGFNVFZ4a2xMWW5sTkxtcnlyK2gvaXBGcFVsZ0Mx?=
 =?utf-8?B?UXJvU2JyOFNYTkhwU095WktKT2ZJa3JId2VBOTd6azJ0MFdNU0JxampReGIr?=
 =?utf-8?B?QTRyUGMyVkZtNUNsRHA5bDRFK09HWFZrbEhZQTdqc25MV29td1ZXbE9xNDM1?=
 =?utf-8?B?SU9jTmtvWVhaSytEazFGSC9IMTcrWUMzOXVpcGRyOTNSYkR6dnFXeEJ3eEhO?=
 =?utf-8?B?UjRjM2pyQUhTdVNGZ3ZPYzg2VkpHNlJJTDFBeFNXRUx6YnRiOFB6WVFyQlV0?=
 =?utf-8?B?TDJPV05JZFQ0anJQQTNBamhOWWpwbEQrc3BHczRRekJaSHRpTHVCZUh4NzNt?=
 =?utf-8?B?a1RRY1c2LzZEMzMvRHFpL2FPWldTaGxoNU5xei8zMnVGV2VKZndTZHYzaFRx?=
 =?utf-8?B?VXVoT2NjdkZaMzUyN1JRL2NDUFp6ckhNM0cxTHl4NHM3WHJtUjhBek5GVkFZ?=
 =?utf-8?B?NW1qbFhQSjI5eXVXOUNteFlSQlZsakxWY0hJSWppdXFJeFFzSnY2REI1WDVq?=
 =?utf-8?B?RVhBMTFHaHFNZWhaSmZJZGVVT0U2Wmh1bURRZkhVSFFxVGowV1duQksxYVZu?=
 =?utf-8?B?L29BaUZJdUxvNk1HYVozd0laVDFSRE1UM3dENWY3a3lYTVZVSktaQjM3RUxj?=
 =?utf-8?B?dk9TTDJRRDB0a0RuNEpsWGM2anRXZEJJZmVBTFh6bCs1d0JZdDNSaFhUdmFE?=
 =?utf-8?B?dTR3ajFKZmNwRWZMNDdhTkNuRmNWMGFSb2thcHdrQWF6bjlURjBpY1pjZnhw?=
 =?utf-8?B?b0tETjF4Y0t3d3NSMlZwd0JxUVErbjFydWlOeFpwQi9BNDJ3d2VPWHhZT2oz?=
 =?utf-8?B?Mm1CaXQra3BIczBaNzRWQlpQVm41V2lVZUVJY0NSYTNSc1dHVk1XY0JWeUZ0?=
 =?utf-8?Q?7WcyevT26dwH6Q4mafzSVKS1S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b966ce2d-bfff-42a4-b3e7-08dcf8016755
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 10:06:49.5551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WIr9vje0UHrE5r30o9oTwGVHrl+2tIcxJ3X9+qcpjCnwxmsC+OKDFT1sRxP6kFVIqhS3vIeZua5n790XfyVCAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8417

Hi Joerg,


On 10/29/2024 3:08 PM, Joerg Roedel wrote:
> On Mon, Oct 28, 2024 at 09:38:10AM +0000, Vasant Hegde wrote:
>> Consolidate all the code to create an IDENTITY domain into one
>> function. This removes the legacy __iommu_domain_alloc() path from all
>> paths, and preps it for final removal.
> 
> I get a compile error here because the static __iommu_domain_alloc() is
> now unused. Any reason this patch does not remove it?

In my base (v6.12-rc3) + this series, iommu_domain_alloc() calls above function.

Looks like you pull Baolu's series which removed iommu_domain_alloc() [1] as
well. So now there is no user for above function and hit compilation error.

[1] https://lore.kernel.org/linux-iommu/ZyClPkzekxXKqTFV@8bytes.org/T/#t



-Vasant
