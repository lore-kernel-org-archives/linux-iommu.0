Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010045.outbound.protection.outlook.com [52.101.201.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D18F175A60
	for <iommu@lists.linux.dev>; Sun, 26 Jul 2026 16:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785082136; cv=fail; b=NnRHb8SENN0SeesLkbZb33awiGvr9cDcOPVgc+vn0dYeUvyzS0jd/uGCCyYf3tSv7ABLySltC+KO1M0DCQiyHTtZw5zdcR2N0VsZIx04wyeHVhWgiRwvYJncr2fU+qxk2JKaxMa04t/kFQCQunJgYVED6vHtx1nNkJ514h8w3hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785082136; c=relaxed/simple;
	bh=veaqmCsqnmxVnidDksaTjXL9MITOJPuv8pbVpPVPbtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cNBvKZ6IyGEqvqbfaqtN+6X1BIAmUUyRlpXgGv+3yhvKFfbPz5T5K4xCk52FNvxKjW4JeBASxVwiqPlxjIbCK6MGH+r6e3bzotsXK6ocQO/H/iezM9TFqMUS6FOQ+KrVsVr4zP5u6D0KSrCf3JD0dC+Q/LWGFIRBMjmiOK9Z1EU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VlAE1ZDy; arc=fail smtp.client-ip=52.101.201.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VlAE1ZDy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXjNYmo9mOEoK3/KkQp+et6JYQZJM/Z/1/oBPoNF01eaUQJaSN3oLgPq9pLc2T41q8fioFOXVe35ftdLG7u7lEga4U6uziI7r94SwNYqurbXzZqzLvhAuvOAFcpE5ZhcTGep99GQwdA5aqItNuXY233sPrEtUbBwzxrHc+sBzsEGsojUwHFaKG2JHupUb1JGTEeEmJSq4uOgv1R+wLpZzVHiks3CwoodoIS6Mt8nBSGRBD0cxLzVkJ6KKXVMB1Cj/uB+RsKXmvx+8artQJunPQj/MQ6QfM7R1y3etkHdvDDLPfkUUNg23iAuarUPRX3DImbhbL72BdNRKvaZnOEexQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g71p42X1UtXuiJdRFWk681Y5nIBOlgOarhJUh7iI6sc=;
 b=ApmIyzt+PRXt1f4FqSWFKYMmOYJ5f+cLoSd2m7m1slWAiPN7xT1usJnpy88OJvUPc5CIHl9B6ld2pbnGKMQ2rxO56tP43AHvy5emb0Q9pzq3a7Wb7N/07L0uR0Sj4w+A3gJ+6OgTcm3AOeQsKl8LyxtwBJ07mFKV63JCejSxCppO39zoltUtI2pXUc3OeXWXd2Pmdx3g/GMYT0GZoU9sVR+oNOe+fEh1JY0K004X+mOIAsy2AFXdfLYk4tmATsmURKcHTLbOexLY+0t7uMT33f0YZN3Mx5yi6KWYtvMbnQuptBZmNqkZdmymHchKLmS7dBCzhjZJck3AYKr8DpXlLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g71p42X1UtXuiJdRFWk681Y5nIBOlgOarhJUh7iI6sc=;
 b=VlAE1ZDyEZP0XISj8GkfC8gJ4HKNB0YMiDTZWJaH13v5eevD5eKbYhVyuc9Tatg3SJmIlOs1D5yzgFYaUsX+7fcCHqonTe2X1VMktLverZMAdUP8H/4lrEFQI8H+2BJSJfbnOXy5muAb/olA+Jpga2nJA6xDAtIc7dMcffKw/iEnmNDIDH6JliGFwOXUBUw5UrSxJie0O3M7U5tiVrqr+qvDXyX/DClB/qhXSMIMINbs5ViHviCOT/IhT3Z3UKN9l0boCXYWL5GdHEWowJwmbh0b/DDGqaEapk5/f3PICE/r1VT70pHB+Ist31AaXsAn9EP16O6yt6L32pHKaVtHoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Sun, 26 Jul
 2026 16:08:52 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0245.012; Sun, 26 Jul 2026
 16:08:52 +0000
Date: Sun, 26 Jul 2026 13:08:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, catalin.marinas@arm.com,
	joro@8bytes.org, jpb@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: Add HAFT support for SVA
Message-ID: <amYxEj7L85+DO+pE@nvidia.com>
References: <cover.1784814923.git.robin.murphy@arm.com>
 <57ae366ec501a142bd20f2cc7d18b3eca8eeac25.1784814923.git.robin.murphy@arm.com>
 <amTH7xHBY2ol4LHw@nvidia.com>
 <amX25rcF-ETdnUPj@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amX25rcF-ETdnUPj@willie-the-truck>
X-ClientProxiedBy: MW4PR04CA0380.namprd04.prod.outlook.com
 (2603:10b6:303:81::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c3259e-dded-401f-a3a9-08deeb302f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|11063799006|4143699003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	hA4iJnm18A5iFyokpq3nsmYTnZJfsX4llP6xvERCr+3TxkrHHxWEQ8ruLlNSiNWn61CM2XgTPxJnF/47Cw7PJNYnBKaKqlM3CjGFImUeeJImT39WLCxfSoFtsz00VFZnbQYL0vYqy3MEmdXu62ZsZTOY8wnBGJG6dVQJ/Hw41ERRo8qtIJlLG35QFzEqw09ZmvhzgZZj7ZN7YwrQ8ltRFQwRo+B50hNXbQDCq39SICLYvSilJynD4319ZGvSp/jGDSR2GRm+xzhQMQmwD6GBrDLLLY5qWTy3UzlCENYOQhSLJfjfTYSG5sj1TBFaIweBAdVhFY7G+3e4Av0zFHnSrdGSR62wBWq1E3UlD3S2llS5GDQhLew35f0VODL2u1eH8KtI8BPfTcZ6N+TTDdcgcFVeCvjHJJ4mo3ypDlUIP4ILEEUQu3YF4Z9stv7Bh8JaRTkWk8eR6gOsHECMD473Y20X13I2fLIddKzSRwRZzoMJ7wgRb+MCjaV+mVVZClb3+8ujXE5F60jgntMXXYHnlGYX1cLrrvVXm+sEjwWdO+1C6vipEqAvi/GfPyeGZPBa3ZMBiltrFWxNjxhjyUzzqn01i0TswxhzUgTtPrHW7z0YzJDEH6ImKUsB6N1s5MKc2qhChq4G4ONyVVjh2r28TAxlOfn2rbYBdG7KVssUniw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oJ1Ol0fFM/UYb/zsipaJU57j35Vq+eQKvgpPyVXW4ByugOCaSFHGYGERek6e?=
 =?us-ascii?Q?nQ8ehNMDkrghMQRORhuQ8cmvv/2Ww5kqsUFMtJzo2GVMgxei8/4HUevKIrPL?=
 =?us-ascii?Q?OFnGgPZZwkCRbkppWSGiwq64R2dKGE5FyQX9FRvER/5JUdSjtaxYlKrV8Xnu?=
 =?us-ascii?Q?XM7qw8rmEM4J1b+h8uAugjAjxgQk+EuFxl5QzGtfoRSwAQqOLBXuLRuKWhRp?=
 =?us-ascii?Q?uWl5o+QIfEhTX18Y3T82V0zYV7JUBHh2FGNmmH8n/jvg4UWRE3B9dFvFuAso?=
 =?us-ascii?Q?63GrSAI0gXlqnkndAQK765kIE4DkNQ2JVuU/shC3GmSNaxBHa4U2vWgrxVr6?=
 =?us-ascii?Q?GqitYv86RwUDyXGZcFggLswwODeJakGvkbSBW5fkr7JS1ndh3btDTRpHTYMB?=
 =?us-ascii?Q?ioHFy/x31eXLPx8LB5IH1lXwFIbOPcjy8JPuR5Ykw4dlJFmYsJ/ZOUAVkSaR?=
 =?us-ascii?Q?V9X8wbtqQEd/nVjMvN4G1KMYzqNCOioswQQKIVTyy0uA76J9IMM7gzdUULzh?=
 =?us-ascii?Q?TZOMSjoan8zlZQpEPEyuFWUPPXojqPVIRpi3J2nwdtJiPOaLyPiwh0n8slYE?=
 =?us-ascii?Q?pVBMk55M9q/2LNDwForZPTF7GlFupvzLzj/2uigDpKC7nJ6X5AtU4nHmWKeb?=
 =?us-ascii?Q?d2rRN5jgdeAAQLAJJCvYLjbiL4U1Jq+qJK2+jzWL3f6W4IWr7PGErnjWg4fD?=
 =?us-ascii?Q?/H1/3ULP0vnKaSprJGAgbFCyIg5G3EFI4fCoLy+BJx+s+fCwt+q0V/NjrpVX?=
 =?us-ascii?Q?Xt3zCihEFavFq3vQsUmlS7DgZ1qEKn7fj06qygrp0I+w9pVFhYj6jb4Q0HZZ?=
 =?us-ascii?Q?LJR3peZyvWRHb0SByiac4K8VZZeASExtOb5kqBNdX4gsCAfJ9PHgnfqzoOSz?=
 =?us-ascii?Q?gdJzgnhHsQhfDF6qg/Ny9sJotdhVjbnMaWd3ItQ7CB/lcy5fdTcOJysRhOPT?=
 =?us-ascii?Q?Jwl7hT+8Zu06pquugIfEiJrITKv5dkLjZFzA9L5yRuS7QLaDI3X2LtZsRVsk?=
 =?us-ascii?Q?t1MRA4Rp0WP7yEGSTW5xKLRSJP2hhng8qVgzk5HVOpb3Sg13sT+qDx5Gad7G?=
 =?us-ascii?Q?JVDLF62THUZKhVywKBwH52aAq6RquffVwHb6Us4iRHjwF23V6894nGYP8o+T?=
 =?us-ascii?Q?1tbTQZRIHwh9mljM9OWCUL0Y/lh895JrPUM6qIsox6XFJzwfIrgvGy88NwF4?=
 =?us-ascii?Q?W3gEhQmZYA6T4HEIiPAEEiaUpWEmlI3QzzzkEE0LLf8Cq44YmStKs+8kRV5H?=
 =?us-ascii?Q?8auVUe9odBQXimP9ipScrKVC79GbXwLz0D12KUjH/ORXgTlek+lRI+rg6hPS?=
 =?us-ascii?Q?eOX1MnWDuxZ+eydAkRWjdHLTL4BxoJNYVhASz0JEWZWtgGsqHxEPVq9ktclS?=
 =?us-ascii?Q?tRpOxSo1OTuJ8ATM6KStUEhmUlaD1QOMbaEmVrGR3dqGtCl4dM+9N9PB/u0l?=
 =?us-ascii?Q?cRWBxzrSPDuqmDOwaEyIOqoXV9rFIASFYTxunD46UENx5ZL2FZ4OdIF5hyEk?=
 =?us-ascii?Q?v9migYxk4dQU5GEOb9zfBcywCjVGwQytLGqsUyag90KbpbWCGXNV/j6WKayy?=
 =?us-ascii?Q?W4DzNH3YV4+rAl8dnDoJLUAelfhLq7mp3OhKylLDqF5qjuyuCkuXWWErkBqM?=
 =?us-ascii?Q?JNAXFYfV2b9AGKZpqAGQFnMhcgVVc3D3TLLWT7xQLLgHg4XhOx1faQx8pCwY?=
 =?us-ascii?Q?aLYKOw/GXLkGtbqvABoJzsb6WDxECUNIjAQQnYYA92D7BVpb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c3259e-dded-401f-a3a9-08deeb302f85
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2026 16:08:52.2914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ydklY9qnDKLiRB32XT5fyq8GMstkGjeMn2QndXA8VXMiAQ6jw3i6e/sIRjjQXhp
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
> 
> | If CD.HA is 0 and not IGNORED, it is ILLEGAL to set this field to 1
> | and this results in C_BAD_CD.

Right, this is what Robin pointed to
 
> so the question is whether or not CD.HA is IGNORED when EPD0 is set, and
> I couldn't find anything to suggest that is the case (which kinda makes
> sense, given that there are two TTBs).

Not quite, I said to lift all three bits out. So the spec question is
if any HA/HD/HAFT have to be zero when EPD0 is set, and I think it
does not say that (again it makes sense since there are two TTBs)?

Basically we want HA=1, HAFT=1, EPD0=1, TTBR0=0 as the "drop"
configuration.

IOW I don't think there was any reason HA/HD were put in that branch
in the first place.

Jason
