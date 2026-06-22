Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011034.outbound.protection.outlook.com [40.93.194.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8C834DB6D
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782161515; cv=fail; b=r8wqUjdjnsRl84wpHNjMemJMaflEI25hVPoRRURRR9lDIh24ZmsiPZB7Yq4PBcXzx29KZ608nTUXJkARufHpG7k5hXSlvAhcorU2WDI4S6VDQepXrNsKjh6OQPoYelerQ/YAbDYGjJrgedz7q2acuKwzVsOBsA5ZDXvPRWDB9JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782161515; c=relaxed/simple;
	bh=T/kLNOdjdbUCsAf1TtZzm3esWdon30wkrR8IiHI4wGk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8WRIITydug+hbkUMFXGmEfGG4JDGa17NWgyWRkOd62hulE+PYzqBdWepW6Bi0gmDMtYtFsrHSAmJdhInXvzwdUZ0B2lr5O2wIuSu+w836GLbS8tJ0KZ5LL5H/8BfsrOyqfp93qmFF6/92YYuNFtfEnTOnrEk6d/2waGXThUxkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W+siVeva; arc=fail smtp.client-ip=40.93.194.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W+siVeva"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNt0hnsnvybauxg4w/AfyMmnxLtl+6+j0yVrFQOWNnxrj9uXBb6aAgHd83HxyIUtEciEmXHT1OQNP1ZDQ23rGr8qq1VIFFCqERP8t+xsB8dVEkUUbOZUw6QbvLSab3bE8ZdA++LOwpgPqBBKuK8MClfEBARtHKHniUpO+KzEva8lkKqmchdBwNm+PZ1J16Nf3etSEgw9a5raH6KwaWeo29A5/Vg0+cumEmEX45vo75ti5uEGEGpOhHzVnQudLo0AiuQSG2nbIDM8kzOipQU0r9T7UldF6dX6UWPKhTKIJvNaQow0IVQOoeSnAgx7HQRqkkI4FaA8Gq/euwSLhIwOhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P77wt6FdAz9SgVTfL6FTmZm9Ot3WjHVJ7/IbTsCFRSc=;
 b=UWmnvEoZzN/WRqS7ryoIucwwtsBDjsJsV1l2o0jLc7NEnDTzy43btrHM6qJHgu5RjcmaP5LQFz9z+XrZIhrIvtSfqy7f804nvSh0QOYTMmeixZUWnPE27ddT5KloYhVRr6wO1wZA18Lu+qzMyCrqeCUp7IM0kAUt51KU+DmTpO8C3z6Nu/+m1x/rAXy+ETAqWoUaS8cjozy/oPSx5BZDUr6qwmhhF2l87iSvLNaCdmuyJlA2Pfb7ygtdRQP7DYaU1txw6QNbd+0ITALWrdGmcddahSlunNvBZeYKrZlYf2EZ3i8G4A4Q6njR9NDITi3YipjcxbW9rg1iGWLiE9MG0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=debian.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P77wt6FdAz9SgVTfL6FTmZm9Ot3WjHVJ7/IbTsCFRSc=;
 b=W+siVevaJR5ATqKasWCfJBw8cZ18TWPQraBW++G4KKwV95/hO3PGmzVHYW4uq2nIa8cSbpjKmbg9mHOp/wrzH+Iv1PH/hoMtWd8gqE4dHPWMmBKZoAKwniVg+AWPJKU/UuoAZ68srLfKzmYNbFcLrHzuiV//4FzcNJMU98nCRiRV6jEhgcaU0fOECsbpcpW9gzSFNUnhGqT1bZz4MPB/L9Dca7Vzh4O3CVmyorptFahFsxbBJySvXyCfvr2seKMSsrdMnYk0RbuvLyHCQD87nBLK1/qaCWajqdhK24ajzMKAd+eVZEfmAMooHLDEjdfcRKYbaZKRgu6R/lBtBK8uzQ==
Received: from BLAPR05CA0012.namprd05.prod.outlook.com (2603:10b6:208:36e::21)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 20:51:48 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:36e:cafe::1d) by BLAPR05CA0012.outlook.office365.com
 (2603:10b6:208:36e::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Mon,
 22 Jun 2026 20:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 20:51:48 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 13:51:29 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 13:51:28 -0700
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Jun 2026 13:51:26 -0700
Date: Mon, 22 Jun 2026 13:51:24 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Breno Leitao <leitao@debian.org>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel (AMD)" <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, <rmikey@meta.com>,
	<rneu@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Disable PRI when no priq IRQ is
 available
Message-ID: <ajmgTMrCUGqnBLiI@nvidia.com>
References: <20260622-smmu_pri-v1-1-14ad92b6043f@debian.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260622-smmu_pri-v1-1-14ad92b6043f@debian.org>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|BY5PR12MB4195:EE_
X-MS-Office365-Filtering-Correlation-Id: a86c933d-63a8-4cfb-ba1e-08ded0a01401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|36860700016|1800799024|82310400026|18002099003|22082099003|13003099007|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	Gf3jU11BG7BkxWhWUm0PXxsGtSMXcBa8fK5VwwxMjzdiy/mQ+Ng3zJbHwtUXpf770hMVTF3n55Mdfm1RZSxULqkNfKY83zo804HEEYpbdfI9OA3lKbPzzJp6wVUAvMpVjSvh1LF9Vh06tXiXuuMBZyTwoBxIP+PlehbaTjNSVd0TzsQG2oXT6Wqd6iAxLzToBOQqndj7b1tXjUlHPbJUJLjYjruFfo8gBsaSHcrIsTtSmKayCA2uNiAy1UGtBDKsxJIRIzFMDUKg5v4DyjckyQBH9q6JwORZnEA4xU1SHz0IBhZ6gR78RkqsG+boOK6qJ0W6/UXiRHqkjb9zbqFGp1kRF0LgWnT8mZ91SzitsNyZIORIBU142vnOGXB7quWV6OZJ0tg6/NQd0SGbjU9Q3dwYCehOb0ZHVp66EfTTGtttyD0pc+0tIh7FNQvME+67cULEUqGc41lFIaofAERweKA5QnMZz9JPaUpkPnUbYqsogxW3aLpgvYI1LDsuPuGGw5fgJkpBtWn5Dw5Ee6241yzQKcG3mvwi6tGaN/YUioRm7N2Jy0RsTKfFIbBPsJ4X6mpFCA0Mk5dTcVoI1KQNLZMK1gs6hVJh4iK5RqZkA3dSuUh1ZqYS1HfXGTmlbhtyFtcur5RQuIDG+s0LrdimgFqxM4hxS34cZy+/EVQbTJy3edGs8s7a0ZVvaA7sfsCIZwCflfnpai5izexgQCcz2w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(36860700016)(1800799024)(82310400026)(18002099003)(22082099003)(13003099007)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Aj3W2Uo7pDm6kGHTcRYlSWmWTwFlDjZUl+lvasTlCCjTKq1ssbCyO3P1M1luoe8lGQL3NGB3jFfjQShx4DSjTieQ6F7l2zvycIlt80mrYZCBZeqmGAtjvhrp2mBhoCayoC61jTm5NNWGSXUe7n0dCKEUvBWar6nWivKHzgdD8+l6cucGmRRW1qAczaxVcsih2/b67vAXWyTRykBWHTVb/GWA3O5XxafO11XHLYu2KCzxIEeiOKq2kYAkJz+svtVwWfIMn56yh6/hlHgaFQQU/w9XZgCV1Vc6ggkR+5+k8kZslRWpziBhJsDCfjHKWrFJc5aKAn3ehWpf7e0OtX0Z921S9f3URr9CxrLYQhKjK/vqTPx8ZZKMsLu6Xto7YBiz7vhZLQNjNk75LfG77YskyGpPod7OujIbahbrukvOaXiGTqNF1amofh4MkDQTQDCA
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 20:51:48.0799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a86c933d-63a8-4cfb-ba1e-08ded0a01401
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195

On Mon, Jun 22, 2026 at 09:17:03AM -0700, Breno Leitao wrote:
> When platform firmware advertises an SMMU as PRI-capable in IDR0.PRI
> but does not assign a GSIV for its priq, arm_smmu_setup_unique_irqs()
> warns and continues. ARM_SMMU_FEAT_PRI remains set, so the driver
> still allocates the PRI queue, programs PRIQ_BASE/PROD/CONS, enables
> IRQ_CTRL_PRIQ_IRQEN, and lets IOMMU_DEV_FEAT_IOPF be advertised to
> upper layers. Page Request messages from devices land in a queue no
> one drains, and SVA binds appear to succeed while silently dropping
> every page fault.
> 
> Clear ARM_SMMU_FEAT_PRI in the missing-IRQ path so every PRI-gated
> site in the driver consistently treats the SMMU as PRI-less, instead of
> the half-baked stated.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a10affb483a4f..44bafbb38e242 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4659,7 +4659,8 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
>  				dev_warn(smmu->dev,
>  					 "failed to enable priq irq\n");
>  		} else {
> -			dev_warn(smmu->dev, "no priq irq - PRI will be broken\n");
> +			dev_warn(smmu->dev, "no priq irq - disabling PRI\n");
> +			smmu->features &= ~ARM_SMMU_FEAT_PRI;

This is covered by PATCH-7 in my PRI series:
https://lore.kernel.org/linux-iommu/cover.1779944354.git.nicolinc@nvidia.com/

FWIW, changing arm_smmu_setup_unique_irqs() alone isn't complete,
as Sashiko pointed it out:
https://sashiko.dev/#/patchset/20260622-smmu_pri-v1-1-14ad92b6043f%40debian.org

Nicolin
