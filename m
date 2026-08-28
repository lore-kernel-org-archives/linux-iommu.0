Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011067.outbound.protection.outlook.com [52.101.57.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7C136C581
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 15:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932422; cv=fail; b=aIb76i+rJTDMN4nNrgZFl2ti/IXEVwIk7dVpoUrjiP4HVRIunAiZkZTNkUp7H81Ncagxgsni1Lnv7UIWjlUqlSL9ljAOukXmS5tD1fv8HXprJsh0eSddX7Gn5vcez8rcX4U2GYBgPwLXw5XKevlcAwRjVkSoXLRPBUTOE6CwDQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932422; c=relaxed/simple;
	bh=/Qnk3NHscVx0ldx9vHuvL/A2TlQScAE4TGef7PuTe+k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dP68I4cHhW7KYDsMw4kEYLNUGs2BQueqGdOAY7FU4z+UPrY71j8bMCr1366k1db8IYQwEKy2/9j+mF+H59Nc6DUHn1uUpU7UqxYVT6eD+VNyEpzuqGxEFSmkZrYRXiyxWhLJWI3P7ErGSo9VS1E5QlBn93rbzAanb0jo106hGO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jc3L6i9M; arc=fail smtp.client-ip=52.101.57.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jc3L6i9M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMBKOO2R5O6twqwKui6BQmoo3sRGgYAT25OyYo/l7E2i9F5J5NYopyPj3x4newFvlG6gbWuZ87F7cm2CztgWtGIqFu6gUTeepMOf1b6+rv8uCFdTaqqpCcY8n2tllO7PfrfVZJPDt5QxwEmbJ7+LFKZrPQ2pLpu9deglJ5bYycgEMY4yGHdFhg574dveoJcmeyEUY+qDyf4MAHO8LJ62swt+tXNPaAAzwF3764MWBlExCcjUE+A+OqJK26WkmRasDz2theumPzoPmCwzuyZVtAd8QuIAqxzHuUkvMhFgWxXw99BGLJhVMVbu/dpRH+htYjIFvWej+uvUrxDt/z3kig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Te/nibzvRNz/l4yc+XX1tJsA5REE/CbQ0uUXruNZAF4=;
 b=eFtpLXMp1jfLNuZqPI9DyaWOzueSFu02J2jSqWHIkgNJhCzCRCFNMsrCMOOsFLlwmxnNGtoyPtXMQNpUpJP8dXATpAZ7l/6G82GQqEtXk3K4mzxSotqazpDlNBI0P13bOJ2h+e+95ccXVDGmC2wxYnm3+j0yiVxJIORXwVZBio7p0VEkjexXwA+ix2b+THajJ4Q3hjhLR/CnidIRSJ23weGP0CNyWpwc8Z33GJzx84s9UTkBYC29/tuPOZMQdW+Irv70mQ94rOGKFl53bqZtNHPX0lcMoMzLFuvQ8R1/dv0P8qEbEfxfU/vUODIl1a/lBpNUlohiuWXAIglOxQFfBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=rong.moe smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Te/nibzvRNz/l4yc+XX1tJsA5REE/CbQ0uUXruNZAF4=;
 b=jc3L6i9Mh3Q7sf7gccjWINRqbyovs1x6NWpkucHJviDAp2uIHxJmKOQm63orv2Ir++0FIGBs/OwRdSU0EYG/Glz4rgUMjbAZ5MMzjSOLrFxlBrKpcjnYv4peVILPWjBPlGZrzxzCOBi6c8oytma8vyGr7kZ+SS7pGc32azrWHpA=
Received: from PH7P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::22)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:53:36 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::6f) by PH7P223CA0001.outlook.office365.com
 (2603:10b6:510:338::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 15:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 15:53:33 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 10:53:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 28 Aug
 2026 10:53:32 -0500
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 28 Aug 2026 10:53:28 -0500
Date: Fri, 28 Aug 2026 15:53:26 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Rong Zhang <i@rong.moe>
CC: "Joerg Roedel (AMD)" <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Huang Rui
	<ray.huang@amd.com>, Sairaj Kodilkar <sarunkod@amd.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] iommu/amd: Remove ad-hoc checks that are never
 true
Message-ID: <ocec7sibtqumour7yrbom46ya3rpyfrhe4yhi446gluf4i5e24@an5rjva2wlyh>
References: <20260823-amd-iommu-fix-acs-v3-0-dd768e09d771@rong.moe>
 <20260823-amd-iommu-fix-acs-v3-3-dd768e09d771@rong.moe>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260823-amd-iommu-fix-acs-v3-3-dd768e09d771@rong.moe>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: 5826d314-c125-4130-0432-08df051c8384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|6133799003|10067099003|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/n7nKEL0D6T7zoXO5eg3X/gW71W4lI0sKhI+dY3JEx91t+CRRG69qDDt/ao27UZ1F9shfUj57P81bHUZ+b4oaEXllNYKB7TTGqFb0danfyVnIAaNBnAquOVvgL49k1MTIVIDCuGzCj2dLEAYwWKh+cQu8p0CcjxxYYN2yvo2mdDpW/E9ycSjN3zumlAK6VYb/zcbLpi5b8HLSon//v1YoIBzzf6bQmyoajthAA6TI8T+clmmdf+7c8ze3HLZhTfR4zgUuWpEyVGY2vDIguIxP8Z/WexIYxhhIyfikemGJ3d+ROSR/xJE4V1QF3cL1pXMOyZXJUkT2Ywh/1absL7N5hi7lYhxtFZNTbC489Zepzz5hAzuUcR9aJkA7TTyJpG7pFmJhTs/sqHdLeMtTApdnIiirRgHH4EAHhcVDl3MfulSndmgqMTeKRSj0sd4CUkhAEhUEd4SpC4ME1NgSXfEOnLftuEEt74NLtCbFPND7VmJqe9xbiooMzMLq6Qq8OnXzy8BUWJYg6PhgwT3ieAFUTZfhS3Z5qSaNyhrzw+jYdZJiHFIqHkaICIR3Z8bEztlpFb9Gon/oGv98WRQjt1O/aK4WwHQdIBSEsKRsPH9ep1518eBobEj6Uxi7ppdEMnk663J3gLF4AybrgnddebOXmb4lRdKRA+E6TSqjs+vjVhUPNOmmTdEX+Wf8oOU47vzul2Ij1XjFKi99AowQD+RQw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(6133799003)(10067099003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	P93M6RweapjHGljXi3IbmCD65WzZylSFPVLeFLS1yGe5hYcIgkUUhNdjJXxeh+IaMt3/Aku6R6SbeBwzXGdlYqxHv5Y1tMh+wJsfMZpqX326DrY9KbaBQplFafx/zxcvlihhfpHVVevq9ETSZBPItQQHEZwY8uqZhV94uUd4Y4ArcEZtSpVfSgoQGbTgP/UwgJgvqFrz03ITJ8uYWKiMJhrzg1RGoU3Td/DFeWf8kjPug1+ZIjjVKn9v5REpzDaUjQCSVK1xbX4rthQtQ/jAxVkzU7F3zak5V0+P7EoqodgNN5lb/reeqAT1dlfwvvVVN0r8dKNvkcr01h8itdbbYb5CUfLSxO34pO5oIpOPmjKSuLtG9gZhUouG1LUXkLf738AlSJlgVH/x2vkivXU9SLPoyCvfmsex78wCB37JDn4kcIVPRRjocDAc/I+a1skt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:53:33.2714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5826d314-c125-4130-0432-08df051c8384
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202

On Sun, Aug 23, 2026 at 06:20:17AM +0800, Rong Zhang wrote:
> The state transitions of the AMD IOMMU Initialization State Machine
> imply that some ad-hoc checks will never be true. In detail, they are
> only reachable if the previous state transitions have succeeded, but the
> conditions are only true if the previous state transitions have failed.
> 
> Therefore, remove the redundant ad-hoc checks.
> 
> Signed-off-by: Rong Zhang <i@rong.moe>

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

> ---
>  drivers/iommu/amd/init.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 72b5b11b9d75..d81adb8efe0e 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -163,7 +163,6 @@ int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
>  int amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_VAPIC;
>  static int amd_iommu_xt_mode = IRQ_REMAP_XAPIC_MODE;
>  
> -static bool amd_iommu_detected;
>  static bool amd_iommu_disabled __initdata;
>  static bool amd_iommu_force_enable __initdata;
>  static bool amd_iommu_irtcachedis;
> @@ -3222,9 +3221,6 @@ static int __init early_amd_iommu_init(void)
>  	acpi_status status;
>  	u8 efr_hats, max_vasize;
>  
> -	if (!amd_iommu_detected)
> -		return -ENODEV;
> -
>  	status = acpi_get_table("IVRS", 0, &ivrs_base);
>  	if (status == AE_NOT_FOUND)
>  		return -ENODEV;
> @@ -3303,7 +3299,7 @@ static int __init early_amd_iommu_init(void)
>  	}
>  
>  	/* Disable any previously enabled IOMMUs */
> -	if (!is_kdump_kernel() || amd_iommu_disabled)
> +	if (!is_kdump_kernel())
>  		disable_iommus();
>  
>  	if (amd_iommu_irq_remap)
> @@ -3398,12 +3394,6 @@ static __init void iommu_snp_enable(void)
>  	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
>  		return;
>  
> -	/* SNP support required IOMMU to be ON */
> -	if (no_iommu) {
> -		pr_warn("SNP: IOMMU disabled, SNP cannot be supported.\n");
> -		goto disable_snp;
> -	}
> -
>  	amd_iommu_snp_mode0_sup = check_feature2(FEATURE_SNP_PAGE_MODE0_SUP);
>  	/*
>  	 * If SNP page mode 0 is not enabled, then SNP support requires that IOMMU
> @@ -3716,7 +3706,6 @@ void __init amd_iommu_detect(void)
>  	if (ret)
>  		goto disable_snp;
>  
> -	amd_iommu_detected = true;
>  	iommu_detected = 1;
>  	x86_init.iommu.iommu_init = amd_iommu_init;
>  	return;
> 
> -- 
> 2.55.0
> 
