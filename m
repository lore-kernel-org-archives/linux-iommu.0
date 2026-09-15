Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013048.outbound.protection.outlook.com [40.93.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515BE374E42
	for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 14:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483951; cv=fail; b=JiqoUjv73RQFg2BTrzIxoiRWCJLNZShD8ET7EthLLu4JRBw8DfhYCXkgO+2pSeuZ30uT6SlRCMvZ3bR6EKcB/OLF1gPpUMStsoe4sU3we6OZYa6Ui6LVlDwldO0tBN2hcjBElOoRoNsZR5Xrezh87+B+Fqz7UonCSiWyaksTRs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483951; c=relaxed/simple;
	bh=SySGYJIlb3IrwlzUKNu890PrXZJQGhasgbgSnz19WME=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2iczSLUfBJzjo2rbxOA5WmOgQ2mihWCV2y2s+vDA+zhbP2bKgIsXPv4jODW0GnMsYdTuPff95C2NBzkNMYrT/Q5/alMvdtOqlymAT0jXCD0y56glXK44our0AWbdBIpBmF3Q5h8bmbO+PM1ZHmU3W0pPE+09CL4JwaAMW+K6NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gWW54ABR; arc=fail smtp.client-ip=40.93.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gWW54ABR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9u5sq42reaHIXqpKAjJGi9g6gFT8gS64yGNRavu8V1DAgPOkNO1MabmofmqEx/e5VWTRc0V6/PGPOJdwIgaDgvRNwGOaskjmvPakpMG5i5xP5u+HFHZb3mJ64u1EhewVQkySBNaLcWMPB0yxpBuxV9IrEeVw1ocvcVdfmcz4ryIr5la48lghDSoEf3g+b16cMLei8OWVp3ooQ7h3XUTG7a/iiaTz1znwbQOycvuTUYXXFS4pIJyZg27APl5CrERDd3lrGU6kKWjc0dXajKqpc+XXdASyC16swC3s9tGkMIoYFb+8SL4SKtAP3zoHO1joebtkiG2gTI/IoEMz0PNAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUy0pr4vt390kw7Tfas0GUCPL91wKehUET8MOM34iAA=;
 b=RmApTUDz+qAq8uREZI2tfUg9nwDxlXyhKIYnhlwxiHtKyasYU6z+Yv+Qc3D/KJrjNoFZvZ/wV2K56l5VphAMdd3ZIOnyLrLIzIy8vyTMViwGxw5iYUiswhVed8+NwmH9RnIo4WhzRrJMTbvfbUco33oOUC4NhxmXDgGGCMMpzIC/pE9VJ8tUbSQ1xnaxM1Z31L4ClS7ckfNdJ8tW02Jo4EWAtunff0KmiOW+1cJHGm6x5mfH7FcKEnzZIb8cHoXmagCIFULkNAf895Qazx6Mm4cBbfxn1+eV+u15GZ70JVYvfe/H5WLnrk/oS7KTUyaIb+unLq/4FcSGrtCoWZ6NOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUy0pr4vt390kw7Tfas0GUCPL91wKehUET8MOM34iAA=;
 b=gWW54ABRbiaca8EVgRfI5+zH+8GaSpRFYVSjzj2jYIbSaK56Eb0UeMs4+/ZHVJxec5BAHGE/ep7MvLi+WDXKbB3rOE2xbb2xsGtU35IqFOhLLIw+RgzVJumXKywft3aJEDcP7EySgTTwPi3fHpFYKKAJamP/nHdPfhNyolER8CE=
Received: from MW4PR04CA0041.namprd04.prod.outlook.com (2603:10b6:303:6a::16)
 by LVUPR12MB999183.namprd12.prod.outlook.com (2603:10b6:408:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Tue, 15 Sep
 2026 14:52:25 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::9d) by MW4PR04CA0041.outlook.office365.com
 (2603:10b6:303:6a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 14:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 14:52:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 09:52:23 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 15 Sep
 2026 09:52:23 -0500
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 15 Sep 2026 09:52:20 -0500
Date: Tue, 15 Sep 2026 14:52:12 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Vasant Hegde <vasant.hegde@amd.com>
CC: <iommu@lists.linux.dev>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>, <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Move GA log allocation to init
Message-ID: <opyhwbfe5dz7puj7rbyvoq2e5npm2oe7wo2hzfsre3gwx37uzu@q6nlfqfwph6g>
References: <20260911104317.5183-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260911104317.5183-1-vasant.hegde@amd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|LVUPR12MB999183:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e72e84-fea8-4bba-f750-08df1338f417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aIXCm7DffoZ0N4+Fso87qkcpbqEsgbRAGCttU9CgEIdCxIPPHal+YliX81wU/FaPnZ5NCk8G8bLBbxhuL4rs0FmsFfo5mAgowLPIriBrf8XjEHhA0wxVenmCd4GKZ4zm/88v3mzDH+yWynPzU+qrPjdkmEoTd59nJtBLb1iqfURHBJGB5u53SMiRCmyvIunXdxUv/yvQ93FK9Q5y2qIoFUoUpUimkuNgkuc3cEsLk4uUT7RN4eTJgKiKItsFNPsh9Z+eHaSHpWu3M9ewoVO88NpCWuzBkEfiPlk0SxIdBRxeGsjc0eq0k4baQJQHjJTqy6L1x6F85c94Grs9YcwgAmDyOnXKLBJPykUHQrQ1HpnfayJqWLoMvNTYtrkmwyfZpaFd5VZ8tBwztSFD/5Od++yHAQxkH4L0vK+CKOGP5IyfofqdwtY9o8EPeUgk3F4mO8/05+Pvl0DAkVU9Xm8wLjMSJ5CzmmFgop4BOQ7v/1oK0H0jYbzU/VVGz1jkkWk5k++JQ4wQwaN7d5sko5S0VFu0Njkcwu5k4Jkwgx4iIhoHiUJvlOP54HUVy/cHoi+SKJAr3k/7ue1J7QiimisAHJq4/PamobbX6zJWsDkFI+NnYW6noD6sa2539i4uWaoI2ntjEx3cTObCmDN8hxHw+2OQta1pVWg8vOzudnXO1GyIE8wp9Pc7aYgjUwT2WrUiDJ8N4ejErM+OhhBeEyzWPA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kpZTS8pcRS3QJ/HJ6g7QF3Og9t7OS1pxOLVmTqU7KG974KWg8d1A9H/tqTz0N4mEW2G99Ffm1fkLFabNbFxUpwHjhuSql9eZHkaabrh8FMVzTKsVbhsPAiifLIREkcmGhLEkEVuImvYIMFA0kx/aMUwpcYTpj/YF0MKHGKUyP30+GX2bMiBGyWhnvC5DWmGmFw8Fr+n4Ju0c798gJDXMPcISMSvtfkIF1kiiP1I04GtSTV31f+AcUqpBpx8Z2VA38uKpQ+6n9BG1QzAAaunHGxVx22x50bhkj4m9FvIyc17ai8oh94eUjRcmICzwhxX9FNw9d5TFiWu7dcX1Dp8gk7t2nmQJ0zzj+YguJmVKbBPYec5IfMJc+ryQl2NNM52e5qG0Bf/ZFsfjovbptpeuz5PkdWBxHYVUaDF/i1YjwgzsMpTqZq3Q0aK2Irljn44j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 14:52:24.2849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e72e84-fea8-4bba-f750-08df1338f417
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999183

On Fri, Sep 11, 2026 at 10:43:17AM +0000, Vasant Hegde wrote:
> Currently GA log buffer allocation is done at the time of enabling ga
> log. This mixes capability checking, resource allocation, and hardware
> enablement into a single late stage code path.
> 
> Move capability checking and buffer allocation to init path:
>   - check_vapic_support(): Checks AVIC support
> 
>   - alloc_ga_log(): Rename iommu_init_ga_log() as alloc_ga_log(). It will
>     allocate the GA log and GA log tail buffers for a given IOMMU. Remove
>     redundant checks inside alloc_ga_log().
> 
>   - enable_iommus_vapic() is simplified - it handles enabling GA log and
>     GAM/SNPAVIC support for IOMMUs.
> 
> Finally update iommu_ga_log_enable() return value from int to bool as
> return value is used in boolean context only.
> 

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
> 
> Base commit: adbd8a08208 from iommu/fixes branch.
> 
> -Vasant
> 
>  drivers/iommu/amd/init.c | 74 +++++++++++++++++++++++-----------------
>  1 file changed, 42 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 8a410d4aa370..3c72701d2306 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -916,13 +916,13 @@ static void free_ga_log(struct amd_iommu *iommu)
>  }
>  
>  #ifdef CONFIG_IRQ_REMAP
> -static int iommu_ga_log_enable(struct amd_iommu *iommu)
> +static bool iommu_ga_log_enable(struct amd_iommu *iommu)
>  {
>  	u32 status, i;
>  	u64 entry;
>  
>  	if (!iommu->ga_log)
> -		return -EINVAL;
> +		return false;
>  
>  	entry = iommu_virt_to_phys(iommu->ga_log) | GA_LOG_SIZE_512;
>  	memcpy_toio(iommu->mmio_base + MMIO_GA_LOG_BASE_OFFSET,
> @@ -946,35 +946,31 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
>  	}
>  
>  	if (WARN_ON(i >= MMIO_STATUS_TIMEOUT))
> -		return -EINVAL;
> +		return false;
>  
> -	return 0;
> +	return true;
>  }
> +#endif /* CONFIG_IRQ_REMAP */
>  
> -static int iommu_init_ga_log(struct amd_iommu *iommu)
> +static int alloc_ga_log(struct amd_iommu *iommu)
>  {
> +#ifdef CONFIG_IRQ_REMAP
>  	int nid = iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
>  
> -	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
> -		return -EINVAL;
> -
> -	if (iommu->ga_log && iommu->ga_log_tail)
> -		return 0;
> -
>  	iommu->ga_log = iommu_alloc_pages_node_sz(nid, GFP_KERNEL, GA_LOG_SIZE);
>  	if (!iommu->ga_log)
> -		goto err_out;
> +		return -ENOMEM;
>  
>  	iommu->ga_log_tail = iommu_alloc_pages_node_sz(nid, GFP_KERNEL, 8);
> -	if (!iommu->ga_log_tail)
> -		goto err_out;
> +	if (!iommu->ga_log_tail) {
> +		iommu_free_pages(iommu->ga_log);
> +		iommu->ga_log = NULL;
> +		return -ENOMEM;
> +	}
> +#endif
>  
>  	return 0;
> -err_out:
> -	free_ga_log(iommu);
> -	return -EINVAL;
>  }
> -#endif /* CONFIG_IRQ_REMAP */
>  
>  static int __init alloc_cwwb_sem(struct amd_iommu *iommu)
>  {
> @@ -2152,6 +2148,27 @@ static void __init late_iommu_features_init(struct amd_iommu *iommu)
>  	}
>  }
>  
> +/* Must be called after SNP support check is complete (iommu_snp_enable()) */
> +static bool check_vapic_support(void)
> +{
> +	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
> +		return false;
> +
> +	if (!check_feature(FEATURE_GAM_VAPIC)) {
> +		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
> +		return false;
> +	}
> +
> +	if (amd_iommu_snp_en &&
> +	    !FEATURE_SNPAVICSUP_GAM(amd_iommu_efr2)) {
> +		pr_warn("Force to disable Virtual APIC due to SNP\n");
> +		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int __init iommu_init_pci(struct amd_iommu *iommu)
>  {
>  	int cap_ptr = iommu->cap_ptr;
> @@ -2196,6 +2213,12 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
>  	if (check_feature(FEATURE_PPR) && amd_iommu_alloc_ppr_log(iommu))
>  		return -ENOMEM;
>  
> +	if (check_vapic_support()) {
> +		ret = alloc_ga_log(iommu);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
>  		pr_info("Using strict mode due to virtualization\n");
>  		iommu_set_dma_strict();
> @@ -3010,22 +3033,9 @@ static void enable_iommus_vapic(void)
>  	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
>  		return;
>  
> -	if (!check_feature(FEATURE_GAM_VAPIC)) {
> -		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
> -		return;
> -	}
> -
> -	if (amd_iommu_snp_en &&
> -	    !FEATURE_SNPAVICSUP_GAM(amd_iommu_efr2)) {
> -		pr_warn("Force to disable Virtual APIC due to SNP\n");
> -		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
> -		return;
> -	}
> -
>  	/* Enabling GAM and SNPAVIC support */
>  	for_each_iommu(iommu) {
> -		if (iommu_init_ga_log(iommu) ||
> -		    iommu_ga_log_enable(iommu))
> +		if (!iommu_ga_log_enable(iommu))
>  			return;
>  
>  		iommu_feature_enable(iommu, CONTROL_GAM_EN);
> -- 
> 2.31.1
> 
