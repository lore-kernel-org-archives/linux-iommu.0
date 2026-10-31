Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793408866;
	b=JCoXfoaFi/B4ljilh7cehFHckbG3GAD7pmV5jqNBA3u44HAHj3zBN73QZ0oiUMt4uQQa
	 8f5dycupkIfzd1yVkymR2/ZeaGPB8rqo4hoAqVK1jrjuOjmgdR37uRoO5ILxMf6MF3m3J
	 4YBDcrDOqPeqqJcLam4TTI7P+upAHgmdO+BshqU87seusfBQmqKTXP9PMoeT3pbNL2023
	 SXo/XnvbDpGE5+tVa6ThfMx35OxdILGpjspyrAsFHX1Sg9xXN2b2EUC0QVjn5SPDI94VB
	 9OCzJL8OX0sgI+q9SjvBKRUTl6yJVoUMieHGwzLkVgmZfeVviyao8zO3fe1auGtckIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793408866;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=RwzR5McN88CII9Iz/WY42q8HfyvrScWxXGYHM1MqfO8=;
	b=LzlXUEfEsdl3t3eVYf9gSzLZGlShFKHH4ToIaPrFP4eSvee5VJuEJOhntW9dAh5NRL+9
	 PRYMUPFVc4Rg1P6bSkNo/dY/ZnXXsdi+paQP18ECqYQH2m3n8ZLnJpGtJmxViFRO5SBeM
	 nw9esDqHSXLldbEiPGuBJsgvgGbY/HowCuxQhDF7P1HDUs8wSvG3Lw6wIUghAuTENg9UP
	 Qv/CstKfzyNe8twGHZxPws5umeWdEPzPj7y3jfBbkOPw0VGSZcREgNIKl6MAWofAsk/5u
	 Y/ADlV9ltG+ovWtOVuQ/iOCvCzHaoaEwHO4kvslbj/qB4lT1i7WUgjW3vUcD7Ynj1/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="Bsg76F/n";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.70
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013070.outbound.protection.outlook.com [40.93.201.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CA6606A31E
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 01:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62CA6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Bsg76F/n
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N86BOCGUwN4F4H0p69RkZ1miysvIdGZWPc2bS2IvftDT/oaN4yhNiA8k+Xj42HrvXHQ2H4PxmCPjRUODRZmLjQQutdousg2Yow70Gh8KqmefPt8e+4pnJEGcH6U/KSbByUmPFv5lW4qvGGntEDITuTJXGIhfbm/RU8il8PKBRwgYRLu1usFv5mB1ipSdCrDuab+WyUfiw7WwTq78UO+ik4sxDIWTUpkRA6ao86r8JvW4TEeE53TavgV7T2rzmY1lfuVGAvtgjn+/bOWyL7yAgp8RbvoZFYnkhK2EAILtGZ7Yq5ek/v+4Q0TOw6y/6RXFQgjBvy/cqkkresNdJI1tGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwzR5McN88CII9Iz/WY42q8HfyvrScWxXGYHM1MqfO8=;
 b=h/vvGY5mPy3JPm4Zyo7+CkFxzK7KS/Jdt7AZnxq+J6y9bIgQ+1TxobFp5/fTL60sThHN9KfGznzDUmFnusrN5u+VjlJctm8BUC6F/WCJ+GEwQF0gXlBXIXds50stX9Q7LF/dehsBY6OvCFUvLsk912wrgS79OirAUavOQQmCn0LAQllmrzYQVmUn1OO2TwvCBOqAQ+aUzB54AiZrKz8webpLesur9Ovzqra05VD7ToduyNZPSwAfssDn8DhuCksJYloIiTqf7I8zIHC3s+E1bjcTO4oLaxx4GwRVuAvB6V2WK3mPrjHUOCqeHkC0ajHKaBshlWumyBwlEvOGngXjWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=oss.nxp.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwzR5McN88CII9Iz/WY42q8HfyvrScWxXGYHM1MqfO8=;
 b=Bsg76F/nMdoU3zBjQWD2dMdUcGaaBVizU0I44uZKhM4h6VqrndsWXdxC1BmKlWxlpjp/d/M6oY+CAoRhHdn1EWZCHnksiFymJvnXTMAdqXIhbJKDE4yJTEi5N8Img69+dIKHUwKlBrcobzi7c/L91G2yfTIy5iBuKelD+ktH7f0YeY9G574dCaQjWtSD/2uQHe06Fheo4OzzEJlwWpuU2VwkmMNvGNvjKKbLXFJAXYxVcQxi192FWJJoB5OGFe+vb2EMqYSYGpLhek+DYzLLTG50ZF3Qym7mBXUWEmMKUXiv6FOS1owaXtNPhAuwu7q0/x0Jjfs/yuv43eky8ko6mQ==
Received: from PH8PR05CA0015.namprd05.prod.outlook.com (2603:10b6:510:2cc::16)
 by MW6PR12MB8998.namprd12.prod.outlook.com (2603:10b6:303:249::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sat, 31 Oct
 2026 01:07:38 +0000
Received: from CY8PEPF0000005D.namprd21.prod.outlook.com
 (2603:10b6:510:2cc:cafe::a2) by PH8PR05CA0015.outlook.office365.com
 (2603:10b6:510:2cc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5 via Frontend Transport; Sat, 31
 Oct 2026 01:07:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY8PEPF0000005D.mail.protection.outlook.com (10.167.247.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.0 via Frontend Transport; Sat, 31 Oct 2026 01:07:38 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 18:07:20 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 30 Oct 2026 18:07:19 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Fri, 30 Oct 2026 18:07:18 -0700
Date: Fri, 30 Oct 2026 18:07:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Joerg Roedel (AMD)" <joro@8bytes.org>, "Thierry
 Reding" <thierry.reding@kernel.org>, Krishna Reddy <vdumpa@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, Jean-Philippe Brucker
	<jpb@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC v7 4/7] iommu/arm-smmu-v3: Use a per-domain CD table
 for non-PASID streams
Message-ID: <auU/RARTx8dv5mAE@nvidia.com>
References: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-0-961726ebd6ab@Example.Com>
 <20261030-smmu-shared-sid-ver7-2026-10-26-v7-4-961726ebd6ab@Example.Com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261030-smmu-shared-sid-ver7-2026-10-26-v7-4-961726ebd6ab@Example.Com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF0000005D:EE_|MW6PR12MB8998:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1c31c8-3467-4479-43bc-08df36eb5afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|7416014|1800799024|261026121527099003|22082099003|18002099003|11063799006|56012099006|10067099003|261021121427099003|261009223027099003|4143699003|261022105027099003|261021135927099003|261021123027099003|261022075727099003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	Zb9yuu5owqPP2lIDfDRlAgYvIUpbKlutBND6as10j05PncDTZLgZhhK68F/Yz+BXk4cwCfm8FeZkj8bg4dOlUSMognfGsodbUgEVoGfWv25pUMeO8k3USYs/WYaZarYrOu//sjmpcCjoVpA7xVldukHJF5pxFUPa+HhfIfQ5TOe7HmsRZqEa1CuN4uM6V8tz0qBMnsRQNVCl/DXHdp+BlaeRlgglMT4P0t97IgLDITqmwqEliZJhiY4TzkdHnjVjgynIDb9E75VGx2gLxl4Y1VDELBYSk97D7zpwhaNuKLqsHUMjBL5d3RbuoFPWTweH49UOIZFbBJoMP4CCH7RbnzPCRjuAQilQj8GXyLxavq7SsyWNun+BTGf2Vyk0auiIl9g/1NlbQYXCqbYQb1HnJhwq8Stubk8vNJ+6uK56ZFilcAPsoHVIduoX/ISoxg3n6sth1FEXzuKfibf/yi6vGv0pPpMMwDk+vc9vvFtEg5nAxZUMTTI2HdOLS0GP4J5rk7R5lQCKUr05rhkgMSfGM44Qnv94id4LpjY+v+tW+yRzPyorPk3XXgIMWslQYNoX0PHsgyPVx5p9UYAf7Yn59UGx/I3NTVK06mjswpTWa8345KtZKAI2HG1EzS0bwLZtWiQ8aie7QhRGVtaizsamXcZNyTFGEaiU7UgsLZVoNnL3VNHP17wzhA2gL9u8GtMtrd1NA+GhYtKcsf0kzJulCA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(7416014)(1800799024)(261026121527099003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(261021121427099003)(261009223027099003)(4143699003)(261022105027099003)(261021135927099003)(261021123027099003)(261022075727099003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FgjFSVz9lRxr30ZTlocSCY6ky7ElCQqY7YgrkTyAWMz2K8DBZOtb8+MTIc++3kFDgciLKIodE4Jf5as63tJkhW1iuoH1S5ZS1Ap5odu1NsxpFQjlxe+iePMHZxtlJ1caimEUKSKQNNEw2ccpxz/Yy/mfHABSCQp46qTZFysGyHI9vQeu+2kEmi1E332LvMHrbUYddmJtYLq3p1Wm55HVBKYBMPez911Pak3HIEzF4+3liX73e1NSc/d6vKUMxu3aaMQHM4hpsy0m8ouFFAgMi1mILg7p5wUeG3EG0tF6ia+BrZYL6ZbHsIEad5kho2O24P+MjqdoZFT+PaWycw0hG2g0A7xzGNVpEChQrNwK/erGWGjzsB84+5g2WuV2BwCzN0G4UHXDvuF8ut7VkpKfSdnvq0TLMYx/Fyw9tFQ078c4zRBKQU6kXbuhwQPuYf1f
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 01:07:38.0720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1c31c8-3467-4479-43bc-08df36eb5afa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY8PEPF0000005D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8998

On Fri, Oct 30, 2026 at 08:09:36PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The CD describes the domain context, so non-PASID devices attached to the
> same S1 domain do not need private copies of it. Store a CD table in
> struct arm_smmu_domain and make non-PASID streams point their STE at that
> table.

> @@ -3044,6 +3055,9 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
>  		mutex_lock(&arm_smmu_asid_lock);
>  		xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
>  		mutex_unlock(&arm_smmu_asid_lock);
> +
> +		if (arm_smmu_cdtab_allocated(&smmu_domain->cd_table))
> +			arm_smmu_free_domain_cd_tables(smmu_domain);

Same comments as previous: fold arm_smmu_cdtab_allocated in.

> @@ -3854,11 +3879,27 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev,
>  		return -EINVAL;
>  
>  	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
> -		cdptr = arm_smmu_alloc_cd_ptr(master, IOMMU_NO_PASID);
> +		/*
> +		 * Non-PASID devices use the domain's shared CD table. The
> +		 * private table is needed for substreams (PASID), for
> +		 * ATS-always-on (S1DSS), and for the stall model: CD.S is a
> +		 * per-CD property and cannot be shared by devices that
> +		 * terminate faults.
> +		 */
> +		if (master->ats_always_on ||
> +		    master->stall_enabled ||

For readability, let's add a helper:

static bool arm_smmu_master_needs_private_cdtab(struct arm_smmu_master *master)
{
	/* Reason 1 */
	if (master->ats_always_on)
		return true;
	/* Reason 2 */
	if (master->stall_enabled)
		return true;
	return false;
}

> @@ -3978,10 +4022,17 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
>  	    sid_domain->type != IOMMU_DOMAIN_BLOCKED)
>  		return -EINVAL;
>  
> +	first = !arm_smmu_ssids_in_use(&master->cd_table);
>  	cdptr = arm_smmu_alloc_cd_ptr(master, pasid);
>  	if (!cdptr)
>  		return -ENOMEM;
>  
> +	if (first) {
> +		cd0ptr = arm_smmu_alloc_cd_ptr(master, IOMMU_NO_PASID);
> +		if (!cd0ptr)
> +			return -ENOMEM;
> +	}

Maybe allocate cd0ptr in arm_smmu_alloc_cd_tables()?

We can also have a helper to share with arm_smmu_alloc_cd_ptr().

static int arm_smmu_alloc_cd_ptr_l2(struct arm_smmu_master *master, u32 ssid)
{
	[...]
	*l2ptr = dma_alloc_coherent(master->smmu->dev, sizeof(**l2ptr),
				    &l2ptr_dma, GFP_KERNEL);
	if (!*l2ptr)
		return -ENOMEM;

	arm_smmu_write_cd_l1_desc(&cd_table->l2.l1tab[idx], l2ptr_dma);
	return 0;
}

> @@ -3997,8 +4048,39 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
>  	cd->data[0] |= cpu_to_le64(
>  		FIELD_PREP(CTXDESC_CD_0_ASID, smmu_domain->cd.asid));
>  
> +	/*
> +	 * The private CD table is taking over the STE now. Make sure its
> +	 * default substream matches the RID domain before the STE points at
> +	 * it, since non-PASID traffic follows CD[0].
> +	 */
> +	if (first) {
> +		if ((sid_domain->type & __IOMMU_DOMAIN_PAGING) &&
> +		    to_smmu_domain(sid_domain)->stage == ARM_SMMU_DOMAIN_S1) {
> +			struct arm_smmu_cd cd0;
> +
> +			arm_smmu_make_s1_cd(&cd0, master,
> +					    to_smmu_domain(sid_domain));
> +			arm_smmu_write_cd_entry(master, IOMMU_NO_PASID,
> +						cd0ptr, &cd0);
> +		} else if (sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
> +			   sid_domain->type == IOMMU_DOMAIN_BLOCKED) {
> +			arm_smmu_clear_cd(master, IOMMU_NO_PASID);
> +		} else {
> +			WARN_ON(1);
> +		}
> +	}
> +
>  	arm_smmu_write_cd_entry(master, pasid, cdptr, cd);
> -	arm_smmu_update_ste(master, sid_domain, state.ats_enabled);
> +
> +	/*
> +	 * A repeat PASID attach leaves the STE on the private table with the
> +	 * same S1DSS/EATS. Only the first attach (or an ATS change) needs to
> +	 * rewrite it; arm_smmu_write_ste() would otherwise issue a redundant
> +	 * CMD_PREFETCH_CFG for every stream.
> +	 */
> +	if (first || !master->cd_table.in_ste ||
> +	    master->ste_ats_enabled != state.ats_enabled)
> +		arm_smmu_update_ste(master, sid_domain, state.ats_enabled);

master->cd_table.in_ste could be set when STE walks master's CD
table. Then, you don't need to check "first". And move the guard
back into arm_smmu_update_ste.

> @@ -4017,35 +4099,48 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
>  		.old_domain = old_domain,
>  		.ssid = pasid,
>  	};
> +	int ret = 0;
>  
>  	mutex_lock(&arm_smmu_asid_lock);
>  	arm_smmu_attach_prepare_invs(&state, NULL);
> +	/*
> +	 * Unlink the PASID from the domain before invalidating its CD.
> +	 * arm_smmu_mm_release() walks this list with only devices_lock held
> +	 * and writes a valid, faulting CD; unlinking first prevents it from
> +	 * resurrecting used_ssids after the last PASID is detached.
> +	 */
> +	state.old_master_domain = arm_smmu_remove_master_domain(
> +		master, &smmu_domain->domain, pasid);
>  	arm_smmu_clear_cd(master, pasid);

Sashiko pointed out that it needs devices_lock here.

>  	/*
> -	 * When the last user of the CD table goes away downgrade the STE back
> -	 * to a non-cd_table one, by re-attaching its sid_domain.
> +	 * When the last user of the CD table goes away, switch the STE back to
> +	 * the domain's shared CD table (S1) or to the native bypass/abort STE
> +	 * (identity/blocked), by re-attaching its sid_domain. The private CD
> +	 * table is kept allocated for reuse and freed when the device goes
> +	 * away.
>  	 */
>  	if (!arm_smmu_ssids_in_use(&master->cd_table)) {
>  		struct iommu_domain *sid_domain =
>  			iommu_driver_get_domain_for_dev(master->dev);
>  		bool ats_always_on = master->ats_always_on &&
>  				     sid_domain->type != IOMMU_DOMAIN_BLOCKED;
> -		bool downgrade = sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
> -				 sid_domain->type == IOMMU_DOMAIN_BLOCKED;
> +		bool s1 = (sid_domain->type & __IOMMU_DOMAIN_PAGING) &&
> +			  to_smmu_domain(sid_domain)->stage ==
> +				  ARM_SMMU_DOMAIN_S1;
>  
> -		if (!ats_always_on && downgrade)
> -			sid_domain->ops->attach_dev(sid_domain, dev,
> -						    sid_domain);
> +		if (!ats_always_on &&
> +		    (s1 || sid_domain->type == IOMMU_DOMAIN_IDENTITY ||
> +		     sid_domain->type == IOMMU_DOMAIN_BLOCKED))
> +			ret = sid_domain->ops->attach_dev(sid_domain, dev,
> +							  sid_domain);

This covers almost all the possible domain types here. So, just
drop that downgrade, and it should cover the other cases:

		if (!ats_always_on)

Nicolin
