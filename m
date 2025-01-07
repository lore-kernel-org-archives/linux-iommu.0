Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDCB1DFE01
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736252156; cv=fail; b=dGuysUNq+oqAKOKzrScwzsRNJaXe89uDaM+wzpH7OXf9ksNAofldGDPbzweHWtIIZNuu4zlIdkgnJ2USgsRItK7OGWwrdGRM2csDe8s/JRUYGfXKgS+yQHaJRXHGfRC65lMJvMA2HaeAVWvg4OMUEvTvTsr8RYAvtwU0mUGyur4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736252156; c=relaxed/simple;
	bh=984vYJ6sooooUIKV4Cr37jSaf24m8tW2WsmASAgZgkE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iujTecs01BtRQAVLdWbt11pr8Raii25F39B/zzma8o0FjiGZNwDGNRNIq1bWZpKf5DBHuE2tZl8N8wpFHj4XNCGtDAs47w2p0SHh49/SUIqDlBiwp2SMvtM+v0+H8dpeeoMh8xZA/eGA8NWeI/vhU3NhoUnD0HkYxFCIRWVFkQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Oa/uibdL; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Oa/uibdL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMcfizZhByoH/qOFhDqv7f2VqA53W0nsHaA1JJa9mdVlIdDAr+HyefGbNL5GA9r2JNf21JNsaTgModHFz/mknehRlaTL9EW9AkFLI1hqXL3NoHljgSPVKgSzpWYEcsHHzaRIPyQGWbMyhREPhBgIDXiiTpxUXTbmHaeZCCpfvoVNmE8L8Rdcz+msW2oCgL+/rnwUDnywV5BBQbc3KVxuPbtcTntDbdWuqx7k2RICXL0XfTibEHQQFRX8Ai6yMSRMPAxqj4yQ5/TslRJ9GTyF8nT9lwpA82qGVneQGp5fMHvOsEDa/+7zrbHfIr5l++AQadxkEVJdn6z7Qi76H6DvIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBM1wwm6vS45ftIRGaEVAB79kzsdhzb9cczylq2l/J4=;
 b=Oh97nL4c9Q4QuFCNdQRuOuW4t9Q5yYZ2G33aLYdm/UOw93VNQM77WCM29AvDI6x12n/pjYo2a91/XuIfOY4l7VCrycNC161qOCP8W9pbdhiQLM540YQWTvfE0aR+clG8sVZcWq4sugWGcEi27gq6S39llz30RhGJHG/7UEha0FiEZ+VLqIQ7aMz81Sry5X6Ao1ZY3HfBZdVfN8oNk5irLLxrxQBDAJbP2vU6hR1gjRZESAxT3o/zVcySbjOJPO4bsGdVAzoOk7hV5/yvmOVK2P1M5QBJPPjnac0RMvgOsMxf67e1H8AcCm+SsyO6wvutkb6VfZIRYt9dsW35R0azKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBM1wwm6vS45ftIRGaEVAB79kzsdhzb9cczylq2l/J4=;
 b=Oa/uibdLbnUzEHe4RyH9p2gE5TIQyY+hkLhQv5d+XYsLxdufLwU2QO+526mxrwfZpL0kVgP5g8UlPHJQ/4ISn8HroZ6CrCG/BvuYKowm9O763MuRmwvJk2x+JZc1LCcd44MSG0m4h9VFsnlywerPZ4L62Lfb5w0gfFw9duU/ck4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.18; Tue, 7 Jan 2025 12:15:48 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8335.011; Tue, 7 Jan 2025
 12:15:48 +0000
Message-ID: <f87e897e-028f-43a7-9557-e65778267fc8@amd.com>
Date: Tue, 7 Jan 2025 17:45:38 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/amd: Preserve default DTE fields when updating
 Host Page Table Root
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
 jgg@nvidia.com, joao.m.martins@oracle.com, boris.ostrovsky@oracle.com
References: <20250106191413.3107140-1-alejandro.j.jimenez@oracle.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250106191413.3107140-1-alejandro.j.jimenez@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: 0010064e-9c42-408d-a546-08dd2f1504b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UENDL3RndkR4ekdJU2lsdDZNNllaWFAzREFPMmhMa0R5SFFacUtjcXoxdGpD?=
 =?utf-8?B?akJ0QS82R3VDMjBiMW1EeVZud0tzcGN4anczRkhPck5YSWdFckgycmxWWHJn?=
 =?utf-8?B?eVFvUjlYbGttbG5NbXFwa1oyZWR3ZzE0RDM2bExDcU8wM1ZENFdxTlpTNTRa?=
 =?utf-8?B?TVcvSmNEV3g3a29ycjc2Z0cwT2F1cmg2c0ZHZk5uTkc3STA1WGJ2U0hxeG9W?=
 =?utf-8?B?cy95czczUC9EREZ0R3hqdzBlRWlhdjRXU2RlR1lrbUV5VkpSWmI3cGdCek93?=
 =?utf-8?B?RTNFK0VqT0RDeFJxeWZrRTF0YmpvVktRaWNtVkdZbkVaSTZoMUNtQ2FkREs4?=
 =?utf-8?B?RklZV2FpTWJucTNKRGZpOXJlaERPVGx1Zi9heDNrbEVVeTc3cE9DcGNxVDJw?=
 =?utf-8?B?RkV5dW5ueWx3VURhYTBVUnMvSGUzM2xyQnJhR3E4LzdGUzZNamVKUSt6N053?=
 =?utf-8?B?NW5oRUNEaE1NYWRXNnNjbkk1STFOWHdUcVllMjN2SkZ6NGJyNWNSeFhJdld6?=
 =?utf-8?B?eVVBWmZtZFpoc0svUlY0SnZYd3ZYdzhHc1RlZmo1VHZlL1lWblp0VWwramV6?=
 =?utf-8?B?MU54U053TG9sRGN3SmwxRVd3Z0VPaXdpYjhSaktLc2ZmL09lZ2FCQVdUdWxB?=
 =?utf-8?B?bXlROEVtR3NWdWRwT1p1bmx4aGp5ajZvTnIyc0w3eGltdDZnL3pSOXAxOUpW?=
 =?utf-8?B?SkRTT1oxUUlwbU5ZSHU1M3FvZDl1enBaeUZpVytyUjNXMm9ITE91TVhFQ1Js?=
 =?utf-8?B?d01jNU1ENUJIeWIycWttVTJOM3FpejNIUzdvdmJheUFLTFlpeDVlKzFnZWFX?=
 =?utf-8?B?MmVWYnpRdmpQQnZUV0w4aG1waksvRlUzeHpubUNwZGRPRy9jVnF0T2Q4Rzkr?=
 =?utf-8?B?YVp3RUUrSzZIeEVWQ2Q2Y2pDMDV6eS9TMlp5Tll5ZUUxZ2paOGJsbTNPYUxH?=
 =?utf-8?B?NmRsclNSVE05bXZCeUlSMit4WG9RbGE4c0V2V3BIOU9pdDJiWlhjd25sYytO?=
 =?utf-8?B?bHhXaXpoMzFscDVhLzJHeVlFMlpBUzZhYU9kY0NtekdLdXZZcDdzVDVkUFdI?=
 =?utf-8?B?U3AxRmtjbTFYWmhidjlCVTgrVmxYQitWODF1NTdVek45K1VkdEg3dklFWUg4?=
 =?utf-8?B?ZWxncldUZ2txTnFkdWhYS3dYLzVEcm1YNndtNFk2Sy96ZVl4S2VxVVRJdlcv?=
 =?utf-8?B?YlpqNUIwZDBSQ21PbldqL0hsdkxUc3dQYmo1YTllQXozdGloZEJUM3Zka2cv?=
 =?utf-8?B?YmxWekYzSjhFZHZlUGtWUnR5QVFWK0ZtQUNNRlpqZDcvSXRSRGlTVnhqSm9G?=
 =?utf-8?B?K1VxTGlWdXhuNUtKSXVUYVp0MGR2U1o5emNZYUJnQWw1anorZURlSnRoQ2NJ?=
 =?utf-8?B?b3JFRmZSaUlzVlhucEh2ZnR5VVRCOGs5R3liaTRaTVRzL3NUQXFocTBwZTZ0?=
 =?utf-8?B?M1VNZlJIN3VDNHlZT1BCV00yb2tpbEZHRFB5NzhWWW4yemlyVWFFTkRhZmcy?=
 =?utf-8?B?MGR1ZWx0Skg2b3o5Wlh5UzU3c095VXZLZEdEVDlVdFBqY1lnVVR5eHMwaW4y?=
 =?utf-8?B?N3VkRXJEMDJRUWZrcHVFckFtakc0N2h2NWwwNGY3MlZSOWQzSGdHYzJyK0JN?=
 =?utf-8?B?Y041ekJONHBZaUlTNFpLM1d4TE5jY09GeSs4V1ZHOUp1UkRjaUVJcERiWUtZ?=
 =?utf-8?B?SUV1OUh2dHR2K04vQ0hnTTV5MUJ4ZUtnUmJka2xsOUU4L2UxQUIyN1cxWmVt?=
 =?utf-8?B?TSt5RElrU0ZMTzh4YXFXR1dla29LM0hPcVZiL2VZei9qaHhvV00weUN3VjZN?=
 =?utf-8?B?a3EvUDB2QXJxWWxjcVJ0TzFLc25rSlppajUwSThJS0duNWhKblBOU3lQelBB?=
 =?utf-8?Q?jiIkdYBp00D7X?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU5iS1AxZ2c0b0QvUHJsZTQ1QXRodEd3c29USGdRMHQ0WVVvNWN1R0JKNm9j?=
 =?utf-8?B?a2lhSm9GSEJXL0ZFU0JkVmJaUmlwVzNIWC9YelRvVFBBdGtxcXNTMW9iOFZ1?=
 =?utf-8?B?YWRUK2tNelEwQzJuOGhEVUFvY29DaDJvTEhzSUU0WC9IWEtreW9ORWNMZVY2?=
 =?utf-8?B?L2xkQmtUOVIrQUNEKzFlOURXTm5EQWRmZjNWQmR0M05IY0ZGaEFEQ3M4aFFT?=
 =?utf-8?B?UU5KWFZrYVJwQ3p3ZGIxRHBLeUVzWHB2ZDhPNWNBWmR0UzF3S2h0Vm1wa3lT?=
 =?utf-8?B?YnV5NGF2Rk1xa1dpdzZJYmRuNHVURVdueUZYbkVQYktLL0REbk5GTEpBbDdP?=
 =?utf-8?B?VlZUVGwxbTlmMDF1REdLV0I1djJtc3BFYzlrOVh3U253NlNCaFB3MWVwYkkv?=
 =?utf-8?B?YnRSUU5ia2I3d1JJbFVyUmdHaldWVWQ2R1hpZURtamRZOGx6bWhaUTFVd3p2?=
 =?utf-8?B?NHpReHhYenI2Z1RxVUdiSE05L1lheUFMQ3FMTFYwTTlpdU56VGRnVVN4ZXNW?=
 =?utf-8?B?VnNpd2ltVmtUYUpacXU1VFovblE5OGkvN01rY3pFV0s1Ympic0cwY1ZHeHpZ?=
 =?utf-8?B?QWNYdS82clYzTUU2NFIwM0lyaDRhN2NuelA4b3c2WWsxK0NmamFFRm14OXFU?=
 =?utf-8?B?eUV6YjQ4aVNMYVdvd2JDcmRSZW8rZjIwS0RXalpIR1dwZkNGZE1BMCttdlFs?=
 =?utf-8?B?dENKWEVIaFBQeVdUNmVYd0ZhbXUzM3dyOE4zYlpCempFT2JwL0tXTWFoRFRo?=
 =?utf-8?B?SDJEUUh6NTUyTTMyemxpY3M0c1VhaGtVRVM4SWtJUUpxT0lZTDkrL0h2MWJD?=
 =?utf-8?B?S29HdzNPS2NDZ3loZDNnQzNmZ0xOTkNUYWJ2UU9DUUhtYTVVeHIwMHJQL1d4?=
 =?utf-8?B?RjZhc1Q4OWVwWm9RbHpnaDRKQmhlQjlvWXFWb0JQNi8wU1g4dmNDU1l3ZUhn?=
 =?utf-8?B?TkhTSVY3aGdacUhrcEFDemduWWdaVkpOOVZZS25Hc0pGbHhOZzkzZnhXYlR0?=
 =?utf-8?B?bDNtTlg2YUZXeWFGc1A1YlhlVEFRYVhSUmVYVmlHaGRrNmpPU3JrQzB6NlU4?=
 =?utf-8?B?NXlhN2NveHZBSjVKMjNhWHNrRHhYd1BqQitvVHQxYm01OWN3MVo4eFh0T0dC?=
 =?utf-8?B?c1BMSHhzc2JPYWpkSmpEWWk0YmxJMXBBRm9RRkhkV0tpLzIwSHZmS2QxNk9t?=
 =?utf-8?B?SDdrd0hucnprd0pjK3J3RDdTMFB2R3B3Ryt2eHhHa1VkejhIY3B6cU01NUtn?=
 =?utf-8?B?THV5dEVJR1hMV1VUcmtxaXQ0anc3MHRpNC9oRVhRMzNWazExMytFbE9KOWNs?=
 =?utf-8?B?VDlLbFo3bkRLdUpjbUNUdDZzNGd3MEhZWkplaytka1FXNVBWSzhSQ21FSkE2?=
 =?utf-8?B?NVdxMU9ITVZncDZrTDJpYWpsdEk2TG04cFlGd3g0UHFocGtlQm5ScTh3MjR0?=
 =?utf-8?B?Q0YxK0hyVmZnOVp3LzBVd0xqREN0UmJTdzJSUHd0SkZtcjdoMVNkSlROL2lw?=
 =?utf-8?B?SlRtdTB4anJoVEZ1L1NKYlJ2WlZ1bTB2VjQxMVlwazlmK2REMC9OMzdGWlBW?=
 =?utf-8?B?aDAzQ2d3QVdCQkhLTVA2MytFcWFUNlExS3lWWE0xb2tCTStqQlVmYjR5K3J1?=
 =?utf-8?B?SlhuOEVYOWZHUkdyT1lUeTJzVGFlTjRZVlZuOUoxbGtLWWx5Q2FmN1RLNmRo?=
 =?utf-8?B?bkVrdVVjUUhyazV2RkxpekRWMElaem9TSlVITDl1T2d2a0NPUzIxVk1vcEVU?=
 =?utf-8?B?UFRmOUJDSDRsdUNqVlBvN3JPaUVYandzanZtY2tnT1hBenhReXJscHFXaXJ0?=
 =?utf-8?B?YTNIZlp5eURhVWpvUzRDc0tLK3pDbHpPdjFtazI4eXhTSDEvN2JCYlI5eWRS?=
 =?utf-8?B?QklLUVRCWk1QWkwvdUFxSk0yc0x1ZEc5M3JTYzRzdEpLRWdiVG56Zm42d0E0?=
 =?utf-8?B?c2xwbk9mcHhsbUlmMGxtOUxCNU8zbDZ2ZUtwVWY4aVNjZXZyVXFGaGt6VDA0?=
 =?utf-8?B?U01rUUxUYWxpRlVRaFZSQW9NT2NoNXFWdlMzdlRIU3h4TENrK3o1Q1h6SnFm?=
 =?utf-8?B?NDQyT1VjR2pjR1ZGVTNnUlNHVGlNckU2VjFaOTVwSFhLKy9LYlVhMi9lYkMw?=
 =?utf-8?Q?DLARM+F6hNXCHk+4/tKL4hTXq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0010064e-9c42-408d-a546-08dd2f1504b4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 12:15:47.9751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u31OIJ+xpavFpJJod34TCwkwr1s+O+IyX1bepEBSGdaB+pPU4GMLqYxSp+V96vUFG+o3/MzFsEzWKVOnnHcIbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327

Hi Alejandro, Suravee,



On 1/7/2025 12:44 AM, Alejandro Jimenez wrote:
> When updating the page table root field on the DTE, avoid overwriting any
> bits that are already set. The earlier call to make_clear_dte() writes
> default values that all DTEs must have set (currently DTE[V]), and those
> must be preserved.
> 
> Currently this doesn't cause problems since the page table root update is
> the first field that is set after make_clear_dte() is called, and
> DTE_FLAG_V is set again later along with the permission bits (IR/IW).
> Remove this redundant assignment too.

Good catch!

> > Fixes: fd5dff9de4be ("iommu/amd: Modify set_dte_entry() to use 256-bit DTE
helpers")
> Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> ---
>  drivers/iommu/amd/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 20177e18eb0d..a8c17b602c95 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2052,12 +2052,12 @@ static void set_dte_entry(struct amd_iommu *iommu,
>  	make_clear_dte(dev_data, dte, &new);

This fix is fine. But with all changes we have done in this code does, do we
really need make_clear_dte()?

How about removing `make_clear_dte()` and moving DTE_FLAG_V to
write_dte_lower128() ?

-Vasant



