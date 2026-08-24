Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E75B46D544
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 17:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787592323; cv=fail; b=W4tc9nweyjFRdM7k5Qtpf60T6cr3UmefNgMECZ+16QDAqRPtXFtnCW0zOoY6O+OcVQSheWgM+AldKZmJicrB9QJ6vGSA7ClJtt83HtlpIri0YMmzzTHOzoOtCsegf4CoyRYTLjJrGY1MhbFKoFrYiDIHX41db5QDWahWZUJJZhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787592323; c=relaxed/simple;
	bh=RGy+1vLYTGwmgvm07daj3MNikY/TOzBoN8ZPDsDo8tk=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=CQTveiFBkAgU9iDDBKT6WmhBanS/ACUoTHgxzBUsmeCaOUmcWQMQ2xCMGqS326AT/FB74ljWP8uuULK/OpWy50gUKcJ1UA4rJw3dU/9f3V7SLrcBF4B1WwfBVn9mZHOOKW9wLz2hcw/sb5s6bozGuuIoKc2Z90FABNMX3RMJeKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZmQbyY6N; arc=fail smtp.client-ip=52.101.53.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZmQbyY6N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tl7tjINhLIwt4zklzEd8rKy7Cs2n3Fk11xU5E8u8jUy3amXiG8cwjbTefcH0JwVsTIvJYFRtWQX+seYJ5MTBPugyeY/L88lb2/QHIVkhIoaXcmRUACYoDJ5sxt0NnO2nQM0AgAdASuk+92e4+6uLjfGViuzg3sWcCig1nAPgAlYR+7JkwATN7w1d9sogTRrUwLVVeF+sCWHPrGniEMBRUAvVRWubFC/ghQC1sU8QV7dXYnLl5vPuXoh6lz8M8+lXM6HDyF86kOZUtU8l2Idtz6BXfIREaSzQHxQ17va3WS1wfsGiU1rO48MLlVS8cKIaEEJPgwJ005iOmlDgZaRZuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRNmwqnyn8fFwcTSZ8/m5XkZxu61fgVpm0IRn/0tMjQ=;
 b=HLHd8IMxuUCnRfk8LWHS5giuPczoCT0Gtbtevdwx5n5YDtHD9toA3Sbl1qknToWqyr6VVVJsh8OSTDSq7tC67ze6lqLav9awWxLTmZAuV/9b3eaaEmT2Oz8bMByX/yf9ULCmO8SOVC4T7ytE1dxNi72HnDqEXbVcEndI91CqlpibX7CPc4qsMZvWiJqp5Hz6VAIYFdzNNbK4dLAMaXOslqpPzna3FzgSugq/CbsZG0GZhX0gC38wXMVQQXILCJzf79uGs3AknTiSaAWNNt3Ki1Ga9DjZZiYscJ2uIThPEMKwDDu5CA7tjDP0T6Tm9SWBOsuW0c8hgmN5lak1X69PPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRNmwqnyn8fFwcTSZ8/m5XkZxu61fgVpm0IRn/0tMjQ=;
 b=ZmQbyY6Ns+9GRLRhXRJtGxyhkgqN6DWfrq5a6IcLnzemhCQRPB4BsMXxefcm1OyGf/ZjqfazGHeI9CjpWA3gcz4eUz4GXikNFGyL/jvABt9j/z+nUE7g8T/K1oaOgKK3bZFf7lWiGh2MHOBdmnoF2i9rgOLgQWlzcoAuFYrOq0Xh0dIPTatbcUdZhKK6TWcgcTNjhqppsgqzeHzm0Lhr5xHcEKQ4BmdPUHV1b971/wIeo4fJNTzWu1Jwam48CmuJnUb0p7aDo9ABPgCCEYca5QqSGWfJkhX0zfAg8OETZmsakCIR3LpP7vCJx8I/cDbQgZ7vGCJHsTP4C+m4L7qQgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:25:08 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 17:25:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 09/24] iommu/amd: Introduce and map vIOMMU private IPA
 region
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
 jgg@nvidia.com, yi.l.liu@intel.com, kevin.tian@intel.com, 
 nicolinc@nvidia.com, vasant.hegde@amd.com, jon.grimm@amd.com, 
 santosh.shukla@amd.com, Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, 
 wnliu@google.com, dantuluris@google.com, chriscli@google.com, 
 kpsingh@google.com, alejandro.j.jimenez@oracle.com, 
 joao.m.martins@oracle.com
In-Reply-To: <20260727132913.22475-10-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-10-suravee.suthikulpanit@amd.com>
Date: Mon, 24 Aug 2026 14:24:56 -0300
Message-Id: <178759229632.3131778.18162973370003245229.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BL1PR13CA0423.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: 116d816d-f303-400f-cbea-08df0204a417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	F17aYRXuR9dnPKZmrwza2K3FBTbMzWYNnKhaS1pgLY4MnDIwiY4dRCtCmVZGAulDIJbtFN6RMJWLeSZl7s5o5OW3rAtzOKyHSExmKb+Xnz8HWTQ1FPv/upFBmEUxr9z0CDbZaiil84zTcIw3wd/0QayDM7j5ItCs3qlaTQyHWr1ZPI8XIs3zWfGuuWQ9CJuznqvOqk9Ig/BlIcYWXyDxvYxbZFvw0438ZLNSzO4hpPNWH6OTD9oCwYUow00KkeIyp3K2x7BB1X2ssbuYgJ5o4K50QZ+K9KuPcJpauhQHv4p1Luet+f0E8K+U3g8VX9RTzliz9my2H3dIwti5KuDchJdMc36M20fyuVK/rTSLuPjFZ1IVsH80BIbr0GdtnDCw5q5ak2AUDpVy1oUKorbBnjnwdsnSJ0YU1FBr9yNwPOrj21P0ZSKgQueFtUehcllEL3dY+VFjrXwAYQL6uDooCBkzx1b4F08Yls9gBRWxaymub6MHK3Zp7Uj8bFJj5zctKwEeHvO0qvBGewj1SuFpvA1Lfi1n+msdGDyk+60SqTDUrYWxlr6Q9+hyjxsM7szF8VERNSimzH5l4wxA1ZIV3f3jIn16pB4tRSJ2y82ALtlKN4cKdLP4CaWXA4p4/WIUsMSlqvNwLD2D7RK4L96EyaU1Mga7CDMpk7G4z+EM91E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUI0Zmx3RjY5S3FkNG5rR0tqMTRJRUhIYXFuQmk1TXJaa0hJM2t5a2ZFVWVx?=
 =?utf-8?B?RU5Vcm1MZGt3K29zRXZ0SVdLNXd0dGhNVmYyWEVNeUUyeGRhZUV0UHROcHdp?=
 =?utf-8?B?WkR1WHpiTVJQOFJLU3FUVlZGcG82NGxsa21DeE1QWnF6QnJ0VG1OKzNITFNG?=
 =?utf-8?B?emc5WlZGWUF6eDA5NUtNR3dhRWs5RFNZM1ZnTzdUelI3NzJ3Q2JkM2hZTE1E?=
 =?utf-8?B?Y1RkZjd3ODIyY1NPZVhDYlJ4SWVTVEJxa1p3THN3Rzk1emRiSWZrM3lJeU54?=
 =?utf-8?B?SHBzcVkwc3phOTVUU2ZqV1gwanNzUERBYmpORlByTEoxc3p4dUdyTnV5U3Ny?=
 =?utf-8?B?WUZOMEVhakdKRWlRTDBYM1ZPMHp2M3B6MWpxNG5rQTQxNDlab29iWkRFWURl?=
 =?utf-8?B?Uk5QU0MrQkwyK25ycDYrTG81dGpjZlpiK3ZGT3NBdkJGN0N4NVp3Nk04MDN3?=
 =?utf-8?B?Z0g3S2w3bW9ORmhHWFBub1daeFZjMTloNGdjM2g2NHQxMUJrV3J6Rnl4R1lP?=
 =?utf-8?B?Ymp6M21xU1IzOFY2NFRjMDJlSWw2V05mazFWdDcrSnZON0RtaEptV3FQZllK?=
 =?utf-8?B?bWZPUENSYXU4aGZJZXZDd0daUHVPNFVSaEQ1Qko0Y2hrbUdPK2pVa3g0Z0p3?=
 =?utf-8?B?d0EzcEp0ZWhJSlFYWUJYSXErWTdlRXdNSldUMGJpVzRkc2lLWlJYczFmTTlk?=
 =?utf-8?B?WFk3N3pFOFYwb09Nc2JMbFk0M3l2cnRpV2xVTjEvL1h4RU9tRGFTWUVtaERT?=
 =?utf-8?B?L3NtVERFazgzNzVzVW96d3pQVTJZdTVzV3RoTHZ2TlJxTy8wblNsM3FaZktV?=
 =?utf-8?B?elVCNk9PRXMrZUp0eVF4TE5aR2RsTUQzeUovSFFxTThZbXZ0ZXphdUM0TW9t?=
 =?utf-8?B?cU5Uc2hmeGh5dWZ4VzAvaHdGUFBpTk8zaTZjajEzZTBybDRaOWlxRCsyb282?=
 =?utf-8?B?aENpd1VpemdHWklSVHBmZThNbE82WHduRXRPL3NrZlp6VGFMeHhJK3NQR1NF?=
 =?utf-8?B?WUFsTW0rMjMxL2xtN3R0NVg5RDJLeXJOc0xZTmNlVloxdzRFRlo1dUZPWVpH?=
 =?utf-8?B?SjJFOTYrY2ZIbjQ3UFBRd3NtTCtBdEM2bmxKRVdFWjJCQ3pQdHNscFJTdUFY?=
 =?utf-8?B?RkIrKzBrL3JSUHQwY1hrcGRHNTl6Qi9ueDkwR0Jhd21BdG5IY2tYV0pWZVlM?=
 =?utf-8?B?Rmcxb3dCM3lhTTg5cW5oaUhvRzVMMEJna0hUUU1YVHA5S1VMYStUUjRmaXBw?=
 =?utf-8?B?SFFoWHFwL0h5SnFYVmJuWWViZU1scksweEpESkUrU0FCNmpabnlOczl4RkM0?=
 =?utf-8?B?U2hmeS9ZcTBIQ1BFUFZWL255QlRiVitBbFp2cm9Pcld5SUc2NkE0Q2JscjBZ?=
 =?utf-8?B?dmMvMTJnbFZXUEFIRTZET3c1UVA2T3R6RE1ObWhNSEZFQzNlL2hlcll0NDdi?=
 =?utf-8?B?a2dMWjBKdGlwbEFWSGo2ZDBCaTdnWTIwdjFxREVQQ0VEUmphYmJ4Y2x3Zm05?=
 =?utf-8?B?TUwrL25YZkZwc1VDeXdUWXd3bENaSmRtb2RHYVRVUTlXUUFQV2h5NDVJazJO?=
 =?utf-8?B?RU5PTm9CL2dUVHRLOWN3QkdydlBxUC9nNndPUzI5czlnd252aVVDNS9wL3lj?=
 =?utf-8?B?RkFTQTBKWFBLbTcwOXJBZTVWRGswL0hueVpqU003bk1GbGRDbnF2alU2Nklh?=
 =?utf-8?B?RHY1NzBuSllvYy8yemxhb2UyT1RMYVBjdmdhMDlQNnpMTFlSc0VsNzM5N1BW?=
 =?utf-8?B?MWkxTDV3SEUvbWpkZ0hBSEV6THEwSmNibm1aaUp1VTc1bHByRmpTQ1RVblpp?=
 =?utf-8?B?Yk5sNGFVWTdSbERKbXoveTEva3F6Rk5sMlJDbm9iejBTK1N2dFNRdmpBMENI?=
 =?utf-8?B?T2pFQ3R6SFJKdUxIN0VVMTJNbkJHSHZNTDZzbVJPYk13UnFuVzZSaUV6NGlX?=
 =?utf-8?B?eTYrdzg3YXFTVDlxM1RHaVRoc2EybG9oZWFVTE9mRlJEK2RRY2dTb2prWGJG?=
 =?utf-8?B?RGFINXlqQkxvUlFoaW5pNFV3emMrUDcxM1QyVnN1ekpJWEFzVlp6TzZOUFF1?=
 =?utf-8?B?akV5YmJqK1I5cCtiVFAxZEVZeVhSVzhqbVhxSEpCTDhxU3lyQkNqMVpjbWtj?=
 =?utf-8?B?YTVMbUV6LzdkaFhDM1BVY3Q1VHU2Mm02SzVua2pnMVlUM09FZGFOY2NQTUlj?=
 =?utf-8?B?WXVDQlVVUDVMdDdsVHRrK2QxTEZIdkdvMlhpQXhqTDJHUE5nci9aUGFVcHBF?=
 =?utf-8?B?WStJbEVzSDI1UUI3QUJTZ1Z0QWRIZlBwTkhDTmtYS2pkR3E0d2pyWld1Yk9D?=
 =?utf-8?Q?YoJcZH6T1T3WRoGwiC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116d816d-f303-400f-cbea-08df0204a417
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 17:25:06.7881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPmCqCv4xgOQJIw7qtXvUnSfKJoatfyo4aP+XKdkw/8aCB4MvZMwThmBpcmpQlbz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302

> [ ... 197 lines skipped ... ]
> +static void viommu_priv_unmap_free(struct amd_iommu *iommu, u64 iova, size_t size,
> +					 void *cpu_va)
> +{
> +	size_t unmapped;
> +
> +	if (!cpu_va)
> +		return;
> +	if (!iommu || !iommu->viommu_pdom)
> +		return;
> +
> +	unmapped = iommu_unmap(&iommu->viommu_pdom->domain, iova, size);
> +	if (unmapped != size)
> +		pr_warn("%s: unmapped %#zx of %#lx at %#llx\n", __func__, unmapped, size, iova);

This should be a WARN_ON, the kernel has malfunctioned if the mapping
it put there cannot be unmapped.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
