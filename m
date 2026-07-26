Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDF53C8708
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785082226; cv=fail; b=c+Pj/guVCHgwSEKxbkVit46attAdcPQXIJ0oahHXLSlhoIyJKpZyY9jWfgLfv7CWSYrlYiuq/I6etR+r3NmIsFv1Nblv+tpZKTdSMejGSV9ycVg88GNj5bcEkCdOxbeK3ztLwvSxznAQW8wvex039+acsbSgB2gFCKddzkXwajI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785082226; c=relaxed/simple;
	bh=XogPHqDqjpqud8Ff0XXQlf9OR7Krirf0MtxLgi/9VxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r4Mm4RhqL9yO7cFnHBAX4/CGlUkJ6HN+4uCyJTy7ybb2j9KPhXQduaaWGoFVIEk9kbEx1S3uth95Ol2au6tTHvcwXYyd0DTEHG9qyfjUzP1oY50hb3JWxsYZFw4/Vj2BSmd0eXJcpEH0b1QsXOBBTgWT7MmzdqA5kWMNS9HXQxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Vi7Ofuqd; arc=fail smtp.client-ip=52.101.57.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Vi7Ofuqd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYkdV5Xl3SWS6xb/+bMVoFpSfY+cMt7sMpjqRT1kV8wevNHMrqBZ5H4X0w+8swF+sQN4zYqG3rL0itVDViNUixGfpVmSVlIbUVY0yDu3Ei3hAW8hbJOWZDjG7vpvZrSb8axhaWhhKvPFJblwb5pLpBU6NEDb0BpxKfAqqP4ZiQzwHK/pNyYo57qlbVNckdqag/H+CMlaxMcpXYhbvUlhK72/txlhM8BTK+EYsXlY4PUZl6GNkcU66rGiJNRIAZg2PDScbgCL3QE0fJVcFNwwuCBg0xQHt6YuTFwmSr1oitiFLIsw8RO53ttMlAzIT/oa6DeEopkQOzm62Mpg4xRUbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yK/tu7zFAPXH0H2Fh+3t8ot/JXzJ2mfYdU2sgaWfHT4=;
 b=wQAlsMyfgRAIQs8RKfjt1t/HN0GzkO+400Dw9XBf6xtkyFgQPqW7fvPiHzOqOg+Fi3UeUswkqyzBbxD2LNlehMBTmx0DPrM9H7vbOMA83uO/Udiyov3O9O2oTsYC4rGgbBQA9Y860mS8WyfLLhyjsKpQ0F3ZUhiygcPbemVFras91Pgwo6kcU3JOzWfleDGLlMMMtCqWfSWy4MK9wd6zneDYhTrRFrTDYBVDrUnPH/ctKfPxZEWLOjQTRCGihzPsVw35xSh77Lyfs9qSNStbzytKxQWUp2WLiTV6ddA0SbafgdAYHuwXmUQZWuX6pnzmfmYwtOWGDXCGV7lbTeywUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yK/tu7zFAPXH0H2Fh+3t8ot/JXzJ2mfYdU2sgaWfHT4=;
 b=Vi7OfuqdDmR+R2WNRRUuzPReq1oCW+hokn4RdlwlKXj6xY2LROcBSmTnrI2XEDeLrGbsQ4D6F5BnwJBPpln6wfE/MgeHaMP6U+0s62FiNQgKaFULBgpWaeSkHLX0hPMh700Qtemkmzupr5Plo9MnTVpZLmblb/fhjKezGA/b/WqgiWpMm4s1aczSkR5jMb07XC7MPdyYeFaDkKh5EopDGleYsO3EMa3hIQI6AFUN19bBXOEnNPlXpeoTRbE/A1OLlLn4XglUJ35bgJeruuK/tnk4eTQ6k0s8m8SW/dWXfnOSe/cx+vcit9ulVPey5qaUTS2LyvnhAd+/M67FliyrRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sun, 26 Jul
 2026 16:10:21 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 16:10:20 +0000
Date: Sun, 26 Jul 2026 13:10:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, catalin.marinas@arm.com,
	joro@8bytes.org, jpb@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: Add HAFT support for SVA
Message-ID: <amYxa51b2j/Cdw/6@nvidia.com>
References: <cover.1784814923.git.robin.murphy@arm.com>
 <57ae366ec501a142bd20f2cc7d18b3eca8eeac25.1784814923.git.robin.murphy@arm.com>
 <amTH7xHBY2ol4LHw@nvidia.com>
 <amX25rcF-ETdnUPj@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amX25rcF-ETdnUPj@willie-the-truck>
X-ClientProxiedBy: MW4P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::20) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 5860578c-026d-41e2-d3e2-08deeb306411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	65SZL4AY+nZFMwPpA9ZxymXAyg9ld81+O4gtE5xuvkGFvQEE+2alFiA+j/bbnhzXXA6OmcSrPnqAhrWJ7COjIJi4y31fDxpIqTJHv6CAnNGOifi6o7XmoLi5q1JWipQBWVyI9O+xEa/vDgVRjKXPj2005zrnwOO6UaB7FjBXJLqa0kLS+xaLeBCXFC7PSJNRwUbxOoH7OmriHp2ITMvmeXbx21DtDq+R9gpuuzqzS011BTvk11Tj9FvUHqAV/loKWx9F00xWgNJtf/ZVWNQpRwyR5NL1H/es6Yyni67yamPaByrOC2DANELrlbMVgqC9cbmrOlmWciUIWZrCqU1KBiIbM9wBb6naJKhL7YA0s7c83jVqUzcpt8RxvKECrLviC3GRsMRSAlGS/nBXHXEb0pByZeL0A+FWbKmFGiv9Ar/cxOPMNi6PGC/eAkGkNoM5Q7riqkOc7MJt0Erlrvm4gCtUDee8TQC0IF5GtWH4ulobhF9eq7FEdoZkiWeRznIkvT19hXFCD8EQxfDSnsU9u0tZT4hluoDFABJDkxrp2Am12xULsCyztrYqKIA/cb0mL8DU2A2O3m9aj861nAzgTYhZL9IGXl7kkYHMKblg17345B/x7j21HPIEtqjX2NVEtk1SyxNj7Q3h1IIAHLfxwnCaFtoHjfJPN6LXHj9Cpfs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rO2GXqnOnBvD1Pgu3sNs5ZZ+KQtzYFrgxQRezhSJs10A7D46RoZ4G4nzfSa3?=
 =?us-ascii?Q?SY7GoESuuo/ukByTFDaXB8qxTkmWMuRL4WkYxlui+sQzafgmSRgz3zpgCaE9?=
 =?us-ascii?Q?5lk5Pl2NaZCFnHIbUfNvtx++E/s2gAC4Zs1k/NuV7Jcc+JLz1i9nntF6eCmS?=
 =?us-ascii?Q?+iZUJrA+PLAnSYl3QKWaB8DFZPvNjH3o+OE0/eDxxTdb9CD/Ue5CI4fVqS4W?=
 =?us-ascii?Q?PDY03eUho7y2ZyWNYK3TM2GSbK+LjZR2X13ysHW5OAqF3/ZQ8QLdDFcOV6Eg?=
 =?us-ascii?Q?AC/VGheNiUsQ7X80vigSsA1yhb3VXjGBEuvdPuUZXFt2Y1DhJhaRXrYW3mgk?=
 =?us-ascii?Q?wOyZwFIuWJYzBMN6Nrz7I9/uE1AX6reKNm8aaOIB4XrnJXNHykzLozRp9ccz?=
 =?us-ascii?Q?biYEU6t2rzzg8dDGej0bON18XfzVQjlONgw3/k8o7GzWkc3ruZuSw18rpnmd?=
 =?us-ascii?Q?qd/qUP3ujm1yiJvFQRtOQU2VdipAb+ZuHabj/P5gSAD/Hs7qXDrTfzFLA9Nl?=
 =?us-ascii?Q?+1MhqjvdMDNInnyRS1h+2keVRO90TAMyd1IqSymQ5QGsWtJxPkKqRslNmaIZ?=
 =?us-ascii?Q?c6pJWLnpEWV6xU1S+e8kYjeEG0F54fxw9X6DxtxxEz4EjWw747tBAvlHw6OR?=
 =?us-ascii?Q?VTffzjIjrX2sPLNF3GreESGel/R1KSfQDDIvFF/xXpX/FUqA/xjkHqWGBLIf?=
 =?us-ascii?Q?oq5PKudY4NpYoE/Web/irSTg0/RkIX32qAbc5GSquaK4AB1+PsZxVA2EhyB0?=
 =?us-ascii?Q?61ZMzTn5WKsKdCt9wheHH4qYFMyJYAs9ezfuJtBkZ0kdu9AUCRcOxy8ePl31?=
 =?us-ascii?Q?9HFIbYPURHtS4JqOD6G74d6cAC9FGsSHd3ljaPc80Tl0j6j6imqIpCHil5Hg?=
 =?us-ascii?Q?ypauEEALVqf1ei0n2rvUDO0WI4nEsaa5SHjvubFa1v3Zw/VICNV1LwAIP5YV?=
 =?us-ascii?Q?9L8CFvqw2reyHXcJZ9uOAM0HWjLrwDGjWS2l3Al9sbQ5RSmC07LwoMZM+Twr?=
 =?us-ascii?Q?mR7sKFHQbLrqHZfnihJPQRWFzDTX/HUdW61gREgBSMFnAEtxaDBFBAhVBe+t?=
 =?us-ascii?Q?S7vtErLW4UW87fELP9RNVOsHGBIa6+5IBn59vQotkLQ/3K9Nw5auMlLvElz/?=
 =?us-ascii?Q?gNBODLBEe8MO3xOAA4ISyvTQo6fXGEeqEaWvzKJykppDQ0G3G0Iv99MOSeJx?=
 =?us-ascii?Q?DGLse+knDhrM3383nZ4qG50kFvEkXRwBNgTjILYXBg0i9cpAyhGvkweee65M?=
 =?us-ascii?Q?TFuQWkz9jFkQ4VcMR3DqDiKbZwZSwatHA14U+uJOA2FhhX4kEbJwABtSg8sQ?=
 =?us-ascii?Q?29ZZjdFsGtnJddj6164GN8QerWwhwufhVciG6nfNQdxozLI8tnR+TIrwR7zs?=
 =?us-ascii?Q?gzBzn50NzMqn1O1BBRmFRRanJkKGaZB92ry2eIqMXlmLq2rZnjdFRWdXUvWw?=
 =?us-ascii?Q?yuKrA3PoBRn9ft04ipkR0GldsgtU67l2rswdD5GyTRZYP+e0B+nJTLNGoGvW?=
 =?us-ascii?Q?YVLX5uArR7sTsbFlbC8a3PzRSmV8LxLKaWM0O8eM0SBmva9krpNsG9mxx/Qo?=
 =?us-ascii?Q?d1Wv98x2NZZncqTDYEu83Yze/3SrrA9Q2pKORHhbJqmlLDJbcnI4V2AMXMaW?=
 =?us-ascii?Q?mQks0IQEpwpfXTMj8GLBIqBhs8IRitR6G8SnvWTj3ZTMaqwMHbrHxAtydh3P?=
 =?us-ascii?Q?fv5EUhorASRuYZ1QzR84wdnb6MEGOuCBxD04GNZEnUX27P87?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5860578c-026d-41e2-d3e2-08deeb306411
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 16:10:20.3868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPrQ7ttfuYlw2YHiww8a5q3vkz4lGeOFu5zOT1Dtjk9e7NYFzYLsEypRZxlIBOs6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527

On Sun, Jul 26, 2026 at 01:00:38PM +0100, Will Deacon wrote:
> On Sat, Jul 25, 2026 at 11:27:59AM -0300, Jason Gunthorpe wrote:
> > On Thu, Jul 23, 2026 at 03:19:44PM +0100, Robin Murphy wrote:
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> > > @@ -102,6 +102,8 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
> > >  			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HA);
> > >  		if (master->smmu->features & ARM_SMMU_FEAT_HD)
> > >  			target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_HD);
> > > +		if (master->smmu->features & ARM_SMMU_FEAT_HAFT && system_supports_haft())
> > > +			target->data[1] |= cpu_to_le64(CTXDESC_CD_1_HAFT);
> > >  	} else {
> > >  		target->data[0] |= cpu_to_le64(CTXDESC_CD_0_TCR_EPD0);
> > 
> > Based on the Sashiko remark and your note you should lift all the
> > HA/HD/HAFT bits outside this if (mm) block.
> > 
> > AFAICT it is fine for HA/HD/HAFT to be set with EPD0, the HW won't
> > process any PTEs so they won't have any effect.
> 
> I'm not sure about that. The spec says this about CD.HAFT:

Sorry I see this was unclear

I ment to move all *three* bits outside the if.

There is no reason for EPD0 to also require setting any of those three
bits to zero, AFAICT.

I agree with you we can't just put HAFT outside.

Jason
