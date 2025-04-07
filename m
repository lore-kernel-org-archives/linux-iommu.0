Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01C11C68A6
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047955; cv=fail; b=LIqUQHrMMiYejmJvp/bASOLLa1ZhSBd9l3j7CpEpx+chV6iRazLWh2p/vaZT1qs/pycxHiDiXNPLktFqL+P2w/XN+d8o+licqnpUIYXVv3JAHdsY7kFX6VMXBo8oui2HP3Kg23i2Uqo+gmow34JOE/wT5RujAn1V2afJUjNzAPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047955; c=relaxed/simple;
	bh=EElESVk/nGVnUS91Cik2QxdA0Fhx6QCRhUg+GujdHFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YBWIJzCJO9wrg2B6gmrhqN2ltIb7FkBCl0+BsTMJD+ZauNCtqjc9mhWUQ3jBTJ8+vlMLGKuSrBLIPEcHuy3XMCuCzbj2fIXnt3SG1D9MXJoeOUA6hwqFzmGqwBmjmRkHFFLVejmnhEqALA5beDnqDKznFva3PxsJHwiEMCRJxA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FzuVX+R9; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FzuVX+R9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myIFr5ZztAx467vY1BFjl+1TwD+wgBv3QAGMz8nAPRBOgODko3xFq68Jh16GJdmCUICDjIiMBWdSNRX7APA9ZXQ/fShmoy7gJ+LVsV5T7+6aHVh7ycD9nt972GZG3ibtAno4FfP4Jbut4d8zGgWYyns9ss9G+v1UBSFfjWJu/FW7vIVKVKNaVzvj0bY+OwsC/EFUh97n24/jhi2UtsdYT/5yO9hitofkdAR8M/shQkhXGL4eUUqVncrjUYm6M/eR+Lm6St+RRwLF4ttQuw5qTFtsHxlMKFXXMEXZYCKgak1DtNAijoIVGidCpnYavi9VgG9dOdzrY7SZgKcNPsPj/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cW5g6oSC3q+FXXhzRDJE6dyDi4cvTqiCDE713D5Yw2U=;
 b=ycGrTKu4oAl1kGXcuY76g/uN+3kNZacL0AIckpLz1C3u8ciJaOoB6eS701Wu4ghtNtedyWHVxdjBIwwxPl4VIAajKFEAWjBs3qUqbsDXazX0bMpnoacPqopc5Z7XPsY5yF8XG7M5VUsmxqDH1HASfpEWy07wcK0oWDIwRuWet+DinGC72DIFOTr5MW7SCm7ZwCxxfyUC6hTDRDD4sk8BUlY/uferHBS+Jbaxb8F8Ih3jyyLhPECi9sa+Z6kxc7dT3fW21Jma0IFk/CGmacJZQMJ/pLFM97ag30ffYwpxL2WgRwxnzJ6cPmd+t/fcvFIyXTBI9ujJYugjKoYLMSuWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cW5g6oSC3q+FXXhzRDJE6dyDi4cvTqiCDE713D5Yw2U=;
 b=FzuVX+R9q3FpXDySoUdEnCPzYXRsSHziAJrvR7Q3uF80o5Ep+64Vahw97y+wA0UzKgYwfnZq96fXiZPZRB8iLs6jE+ZwgaIIdxnntSLdUFYmZM/k/Tj49gv5TRuex4YbZWggrmy7etco64Qjt9gdQQ+lwpDKCxsHsdu354/8lxhS96l9mLETmLkM4OzFshQzRqn3poaaVKkf2QC5T+P3IDIPfNHGIowugWwg9JIZCMDQzmeoBuxxhJInMsNn57Z7UK/V9MSwVyYfC1L9UreujykvThRFDHQVYIQQWMq/jscFZGFARBJ1jBNqg6+2lzw2/6lGDyfi+5SLmuq5r6IyfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Mon, 7 Apr
 2025 17:45:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 17:45:51 +0000
Date: Mon, 7 Apr 2025 14:45:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, thierry.reding@gmail.com, vdumpa@nvidia.com,
	robin.murphy@arm.com, joro@8bytes.org, jonathanh@nvidia.com,
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc 2/2] iommu/tegra241-cmdqv: Fix UAF due to re-entry of
 tegra241_cmdqv_remove()
Message-ID: <20250407174550.GC1722458@nvidia.com>
References: <cover.1744014481.git.nicolinc@nvidia.com>
 <b3cebee623b4c3fc7de0aa2abcb703b9342ba33d.1744014481.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3cebee623b4c3fc7de0aa2abcb703b9342ba33d.1744014481.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0320.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: f12ddfc3-a917-46a9-54ef-08dd75fc09aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YP/qdR9cOo/Ogjq1p0T/araqSK8/R0egS5m03o9g/iYwr0MqfKCPxC+i0WIt?=
 =?us-ascii?Q?RWfnJat0k18/MO3+rPyPgUv36PmvpWyV18go+FFdqRZPDlPacUVipE2taDHr?=
 =?us-ascii?Q?rwSJVf+ZRbRS87e/qoRthcqLszchM1JxMw4UCWGyU6cm2qKtw5g6lGcmvCE0?=
 =?us-ascii?Q?0gifo8I4xzP6+uiJWWFgdRa3u4xOotsXPV3nsjvktz4ntd3AfF++G0gNq9VG?=
 =?us-ascii?Q?Z6gXPnMw3PwDgGEM5Z0AScbn1Z9yP9ZF9HK1DSsNiMTDTDNqzc0pnQIb8hJd?=
 =?us-ascii?Q?wog92RcvDHhuWX1IVJfpSRftsLdBwp9NefSHqbxajOuebKgjwLWRdcUm5T3H?=
 =?us-ascii?Q?j9ATuH+eAWr5vXUzeHl3zc8U230cnxpE1KImjhbsMAC72QPV3/TRhuCdG+rM?=
 =?us-ascii?Q?9AJU6j4hf6LZ05RiSx2mL0/RveEvRDmL4GSd7zvEoQxcnEhIcm5sZFGx951F?=
 =?us-ascii?Q?GD0hpXCOI++L6VVeadZz10nBmTV2yNFIo9clw4yt4tLFQPDXl4QI7YZrNOpx?=
 =?us-ascii?Q?9ihSGn3KeX4wjKlwUe7X6JU69tQjlpnaRg86daj5e8IFRZ4fh1lMJOsG5ew5?=
 =?us-ascii?Q?WlThF2ocLT5eqAtX6fSStQiMWp3O3pTtyX4D6Ij+5uBuemhOcBUil0e0BhpO?=
 =?us-ascii?Q?sKp8cLTLOZiZFfkGvcTNIReHvc1s+Kj8gmiV1VdkM/usGevg0WUSPbPiLEr9?=
 =?us-ascii?Q?z/W82zEqm2KWL55YNeron9Ik42bq2spasFDX+N3OptTa8Oo8KipodkD09pKu?=
 =?us-ascii?Q?HzNQETvknxUZABCaa1OzWAoKen5ms7BALlnErQ1hfsFNrdU0KPRqvnYpZpOV?=
 =?us-ascii?Q?hU0ZPmHJEYIItREXAKTimk+SL7K7SUXQK/XV1Va5yvXndbrjuFmwim2LNvup?=
 =?us-ascii?Q?LiNgc+MBKpBrTIxQAXksDde+OFwbKn/SIs0LunXxSh0AsBXBNvVkf4PMutHZ?=
 =?us-ascii?Q?vDzbJ7G+7iuuHB/lLvwPVl4t5z8sVxyJOI4LGN34knn80mY9EFB7tNvF5ekn?=
 =?us-ascii?Q?VRq+lF/ED9q0Tsq0r7mOdY/q0kjUusS06KQc5lr5tkd8OwEll0P1BcItvP6+?=
 =?us-ascii?Q?uHr5laCVj6BC69z3ZrWsBZA85zAWzmDsjlsSzg8QIS9dfhm6NSEbU70P87ex?=
 =?us-ascii?Q?Izi/YKfWgSO8wMV1n/ll5grXriVsIT35WoZSEyV6GxXlz2mHxlZVLmkQDgyg?=
 =?us-ascii?Q?E0sFWkJIIdUFOzd53EF1U+6DcE903LRhx822v6SDeJ/efVg7p54Z29BzVYZZ?=
 =?us-ascii?Q?RXgAAhrsQNC7S8Kp//1t24Hef9MRnHVDEZbkzMigYXr/OfKnOllzVJ3Furx1?=
 =?us-ascii?Q?WyQUXuGuGtsUNr5tUBUluSqQzIC0RMKHD0HC2oDoN8CmIdxA7d3Yo236fGAf?=
 =?us-ascii?Q?GopMQQuJ44QKqjNma5YqoRKvkkGX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xb6BO9AjMtBEwLKLEPQF/Zl6wxguUPlYLezIOpkcr76r0sEmmJ1u3oprWyWc?=
 =?us-ascii?Q?0Gc2XoU1K6GdCCrWIxvnmTi1p67po9q89P2Rx0jW5Ibhzfs6P/MTattGFfTd?=
 =?us-ascii?Q?T6qh5b2O0qVmqgwrcGS2Ztw2D0U8qoOd7gfria5N+bR/Tw7dQtkA00FoFK/6?=
 =?us-ascii?Q?mys13Gq1bxoN+sjIR9j39N15XcUBh2IPVb6aIxuxnTVonALFOsray+8dXB4K?=
 =?us-ascii?Q?Hd+FV1dkEgFvCYMDcGiZD/ZlZerthCH1KTu+wEmxungJdwAD6Dr9FOaCJNVi?=
 =?us-ascii?Q?O8ZFvsLnC0LG9BGkS+aiYT/cZlWYpQcWGClJuT0OCcdAUo6jUuiQULF0OVzz?=
 =?us-ascii?Q?nrDvSsHzM0x7uYwN+p6VTLF1S54xD1p8ccbYRvDo6n8ESzNJ5UuYsN9uC87V?=
 =?us-ascii?Q?tnTo9KfIqyM3jbikrJeUlcN5UrgpDTJMr/pUHNIaX/dFgm04BiKG3IwaXL27?=
 =?us-ascii?Q?sFikqqDvEN7nATKF07zSAIatArYe6LEDhkqh47WHg9rel+M6BDKXmR9LRVg7?=
 =?us-ascii?Q?ZSH3IEh3AVWuemrDvSs5SxZvrv8uExiCbacBvcr/6bx7bgeE0rznE0nM3qsd?=
 =?us-ascii?Q?5tXqDMh37d1jewJDtattwrEqh6RKawScO4MOou2B3+ehoxewBG4p4jzBgz6m?=
 =?us-ascii?Q?IR6IktQUDz7FpgZhnpfk+lgaYxuqkb1A5uiXNHgqCMB1VYVeEo91fdavgID5?=
 =?us-ascii?Q?6AkRG4bQX/jqL5tOeUAACaghGSqtK6AmI+AR2MKq9udHqi5uC+dalN7VBDla?=
 =?us-ascii?Q?hK8uZ59PuZVUAzNFEnhK4OKHVcyOCARAoYlRkH/QzL5BpH3rLodRM+8pBcST?=
 =?us-ascii?Q?ZsSLcHoD6jR7Nym5jiK9OAlzQ4BkHRtqqLxqPWbe+pkY29/lJ3YZ4B54neTS?=
 =?us-ascii?Q?p6syoWedrIlr195hsy1sYBOgad6Av7kMUiVsijrydxJlG+8nTrfj9NkxbqfH?=
 =?us-ascii?Q?Q+OxICGJ4uoJ++DTLvmKrQymXh9aQ7oyWYPpS3whQ1nUM0eu+ysxWOS5LvFJ?=
 =?us-ascii?Q?JLC2h/ZeIcA01dU4P+/WI4cBsBd076j3rhT3Ji7PP2UW1giyZueVtiUm2051?=
 =?us-ascii?Q?VDbfcL/NXMrF2m3LM8KVypIseKvaXuB9Bng4cwj2Xt5O9R7gNI5lCa9LeRLP?=
 =?us-ascii?Q?LmP2dt7IgeOhcnqUDgU47X7YJ+xY+ca20P3NbPSh+jpx6tY6QbxuyDvWXcae?=
 =?us-ascii?Q?hVwS4+LoWlZoHuhJlmQzcSHukMT5yPZgrY4E0mC/jiy0hRjY+/QIQYNNe38n?=
 =?us-ascii?Q?QonJjlArPxKrgzbe1USzTbhptKnj4TJN/nkeUfVCQXmy8xirppu1FS5g8rFc?=
 =?us-ascii?Q?cwQ303fgEteI+iwKfjEn7b/z2GcIBboYv2RZD6d8SZV81txTOjK743VIHQDh?=
 =?us-ascii?Q?C5ejzkzT3NrIkiY+yrBjNywGQrgmpyHiqzcTBi1/JCqmjNTsJocUWZ/zHlNR?=
 =?us-ascii?Q?prHtC5kOF1ZL/mF48lnkaYQPyreWONsNGRvoUso3zsyoHUucQ/zgiRrUatD7?=
 =?us-ascii?Q?vbPyn5pcU6IdycGVmOUZ2MYpsraQpny6gHxxXFLoS4XZtw/fk2/doUCPBKGm?=
 =?us-ascii?Q?86igDqu/7yw2dhpWTezHhWWuF90yGU0uNQ9HqUmw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f12ddfc3-a917-46a9-54ef-08dd75fc09aa
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 17:45:51.2961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0q0OcgGiAwKPdRLgrOtozW7AXGXKSxrMYHS38doBBDci2G+i/QOvTfMzBfKWShm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453

On Mon, Apr 07, 2025 at 01:35:00AM -0700, Nicolin Chen wrote:
> When falling back to standard SMMU CMDQ, impl_ops must be set to NULL, so
> tegra241_cmdqv_remove() will not be re-entered by arm_smmu_impl_remove(),
> which will trigger a UAF.
> 
> Fixes: 483e0bd8883a ("iommu/tegra241-cmdqv: Do not allocate vcmdq until dma_set_mask_and_coherent")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
