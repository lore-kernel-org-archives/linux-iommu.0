Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012047.outbound.protection.outlook.com [52.101.53.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B1B3F39FC
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073046; cv=fail; b=UL+Z+hqSl5r1KUxjDpv4u0hea/UpQ2VDeiMCUA/7p7NotB78rdosVELuLhHawdiqQgvMl3Cj1QPyK9bc+8lXHTFCuVziXYlEiEyKDNeTqpd+xBHRMPSUlEzQg3+fD9aI55dUgoUHnCrS8j1P3i1l0JBVfy3/W/LGHuoJe/EVZb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073046; c=relaxed/simple;
	bh=2UtYxGhveYnzuGm4R58WVRSolHqqe42x7fWCdWGVCNA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epTz2KTOo4+oWW1Ygc/2DUZUDgobOTRD2QEJNbY6fylW8FZvzfEW4dL2fxjt17u6zZpSgpahmtVmCVJNtE6mU2uaw54Q7Aikxql2JK03bMJ6mUXjO0qCQgcIfd2/j5Wv7qyz+chCWy2JOhlrrJsZBb2FeS9+M8aY6qoC0LcILbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mGXvxl9a; arc=fail smtp.client-ip=52.101.53.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mGXvxl9a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaKVgc+Gf7furLBNKIGp0xrWXlW4HGb0175uHiM2JjL7pe3G5KW95rtkf5GnVCUQdek+8v7+jZY4iqR4aE5nDDrhEWJJVFHRBMK7NC4G1Eh9Pgp9QFGffN766CYVfSFeXt7dEG40aXkkmi5nSOvgXeZxQwOuTDmoNruxx7pk0YxKad3ee+MMw/e/6Ez9148B5opdfuXAtbO1LRJRtmhzq6D2XGcD8EtKfMJdlLqmO6QWU/VV2JM6/y7AB3GSdwEanv5h3JOlAx7h+3GXeTnsHK6cBt5bkw85NilWi8X9gqCd+cFx/ztfE5dM/DkCSkwQzsF1nvAgt3xemDDlAcYEjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SC8Y+3FuvOLn+yqHMDvf1/BjqMst7FKo8bbufasg9Iw=;
 b=rXQcCtO5jHCVzM3XaFmgkE4rChj4B2fPXIAAQIZtdVLwoTC9b6rs30wp1Dsl3/NhecRvk9O1Ibq+JFx4uEaiMEgrYu9JYU85pd6Vps4+C1p3rM7bL38a0At5T6foKhdDgD2I7MswOM3vaWWIWH92qh5B49gASTTPQ5CSd5+UmGOj0jGoHqyux1pyNfscWiZzuCwZPs6sxNWyxs2poFfDEnqgqulLFOaqmpi7aLnocl8goW9eixTbyKU7WfWyiaTwe/vlciQcxeD7EYs4hjB2UzHbn22bwIVdeObeV3rNzCCpWCzfbPJXixf7Y/WDLEqj0pux20qvMmx6/p26P/oi3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SC8Y+3FuvOLn+yqHMDvf1/BjqMst7FKo8bbufasg9Iw=;
 b=mGXvxl9alYofC798cNSVwBng6jATUStoF6yoDV59yUowZaXTh/+z0QmmGmnKdBZSZxfpVAWNANexYdhnCSyv9sR4c2FQOsACazVphJLaimJmos1/WCeQZ6nqEo/xTbuj2yodFRJyoPL03o6FUgQNdiu6wyaW0pGogeWGh0UMCkE=
Received: from DS2PEPF0000455C.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::514) by SA1PR12MB6821.namprd12.prod.outlook.com
 (2603:10b6:806:25c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 16:43:57 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:2c:400:0:1003:0:6) by DS2PEPF0000455C.outlook.office365.com
 (2603:10b6:f:fc00::514) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 29
 May 2026 16:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 16:43:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 11:43:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 11:43:54 -0500
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Fri, 29 May 2026 11:43:47 -0500
Date: Fri, 29 May 2026 16:43:42 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Samiullah Khawaja <skhawaja@google.com>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy
	<robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Alex Williamson
	<alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, "Parav
 Pandit" <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu
	<witu@nvidia.com>, Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, "Andrew
 Morton" <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, "Pranjal
 Shrivastava" <praan@google.com>, Vipin Sharma <vipinsh@google.com>, YiFei Zhu
	<zhuyifei@google.com>
Subject: Re: [PATCH v2 10/16] iommu: Restore and reattach preserved domains
 to devices
Message-ID: <zgdfgca45ealra5cckvsgeugfkuwdv6kima5f7hbun4m6lnjjo@bqxhvyoeovyz>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-11-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-11-skhawaja@google.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|SA1PR12MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: aab0ad4f-41a2-48c7-a6be-08debda17a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|18002099003|22082099003|56012099006|11063799006|4143699003|27256017;
X-Microsoft-Antispam-Message-Info:
	mFrEeYn8e6x4S/BXEG4tbznvZPYkqGS28a/g+bZDiZ6vihRs8FNg4AgANXYVE5LFGRVBMtJOG099X7uipNtZLJ+shTjL+z3E1Y2BsIh6KyoVMAvkNdTUBBg8kzvRDnJX6NyOpXDiSPcurUle+dswBBXNd1lLdDdoZJ5qiSDkvel8TzF/RvXoVtBP1XBZdTZzaqmftXGswBL+Wn3wCiz/SYQlHa2rmqIu1GAQdcj3PzZPuXKhpM9Y6AZ/sc6DPTqogJG1JxeQEBnNqEkalXB6rfQrQOanotkbEdE4sZIuSZGlHE8q5t16+b9L2YbC0QS3tLqHKW7w6GiDZNmZLXanSv1o8qSB+wypntTVfpK0010zsx079O//X0suueSuRjj/ZZEpzBrfKmd+sjhUmXqqgIThUUFbnH2ct0Qk4gDwK2OPrZwpiU7shsQ3F5t+hgylJuZE/V88RSPhOgR8hfF3DrWezCzVKTC2yDie4UgXpfIJc9w8zrwQV91ZDORlTHJLRzaQxopw9xQHNCdMzpsd9EboG0fUTUeL2rEAkb5fLOrFdLCU87qqbYEOzAWFpxi83KKd1lzPESGyHAWBx3lWhT0TWybU3o0g0H9R+/RiFda/vDCT3fHsZJmSpkkCtC4Ogxms0CINCeUdZip7n8SAhw2Gtsb6q0ZSWDoE/TQbTUHxTAhncrk9KCtGIfFyWLT9IMXqsuzPXz9LZLxybAyG0L4HUFLd9IweJhPB6fKWbQbn93rbUf2jYaYIuRT5hdJtvYw/r64HQuYkK5rTeSMp/TC0VN8R2mRKsLpJu7WMUAk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z8jq3/bentMRrCHL0jrC462itwtzbwW6WaqqfqtUj59pRfuq1YYMKqKI06tfAp2NUaJsVnjAiQjYUbD94MtvtKJHgeViw3k/D1bsWhFLCm61Pc4wdqtv2I5DrHrGsMDn1L5kIePvkw1IU0RHNkL70g9f+3d2lggMgN1KdfnOap213ooXgRXLDpC+al7o4nauW2ViJCsX6BUV1rZSEO4iDj4Dcv/mtSWCK34hdAEY6yFjA7w1qE71FFDmKgNbRg27QlukLcUWza1sQqSw64pCg40UJE4YFmnzPJei2BtrvpygBLywt6blluvYwHl8VpKjgBJIBX+febyzo/e70s3Z9TxfI2WL1xuiuRDlCqMHjUch9LLW7vhX+4veuMexiJUHP/7dF8paiqhaBO40TTxhDMKKsdm0rpwnJhQZm+EmUSrgZ0NxSoTXS4LsbG74oOnj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 16:43:57.0943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aab0ad4f-41a2-48c7-a6be-08debda17a3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821

On Mon, Apr 27, 2026 at 05:56:27PM +0000, Samiullah Khawaja wrote:
> Restore the preserved domains by restoring the page tables using restore
> IOMMU domain op. Reattach the preserved domain to the device during
> default domain setup. While attaching, reuse the domain ID that was used
> in the previous kernel. The context entry setup is not needed as that is
> preserved during liveupdate.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/intel/iommu.c      | 49 ++++++++++++++------
>  drivers/iommu/intel/iommu.h      |  3 +-
>  drivers/iommu/intel/nested.c     |  2 +-
>  drivers/iommu/iommu.c            | 61 ++++++++++++++++++++++++-
>  drivers/iommu/liveupdate.c       | 78 ++++++++++++++++++++++++++++++++
>  include/linux/iommu-liveupdate.h | 50 ++++++++++++++++++++
>  6 files changed, 224 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 4118a0861f38..b90757164cd8 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1031,7 +1031,8 @@ static bool first_level_by_default(struct intel_iommu *iommu)
>  	return true;
>  }
>  
> -int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
> +int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu,
> +			int restore_did)
>  {
>  	struct iommu_domain_info *info, *curr;
>  	int num, ret = -ENOSPC;
> @@ -1051,8 +1052,11 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
>  		return 0;
>  	}
>  
> -	num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
> -			      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
> +	if (restore_did >= IDA_START_DID)
> +		num = restore_did;
> +	else
> +		num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
> +				      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
>  	if (num < 0) {
>  		pr_err("%s: No free domain ids\n", iommu->name);
>  		goto err_unlock;
> @@ -1320,10 +1324,14 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>  {
>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>  	struct intel_iommu *iommu = info->iommu;
> +	struct device_ser *device_ser = NULL;

Typo here? iommu_device_ser.
compiles because dev_iommu_restored_state() returns void * and the 
variable is only null-checked, never dereferenced.

Ankit

>  	unsigned long flags;
>  	int ret;
>  
> -	ret = domain_attach_iommu(domain, iommu);
> +	device_ser = dev_iommu_restored_state(dev);
> +
> +	ret = domain_attach_iommu(domain, iommu,
> +				  dev_iommu_restore_did(dev, &domain->domain));
>  	if (ret)
>  		return ret;
>  
> @@ -1336,16 +1344,18 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>  	if (dev_is_real_dma_subdevice(dev))
>  		return 0;
>  
> -	if (!sm_supported(iommu))
> -		ret = domain_context_mapping(domain, dev);
> -	else if (intel_domain_is_fs_paging(domain))
> -		ret = domain_setup_first_level(iommu, domain, dev,
> -					       IOMMU_NO_PASID, NULL);
> -	else if (intel_domain_is_ss_paging(domain))
> -		ret = domain_setup_second_level(iommu, domain, dev,
> -						IOMMU_NO_PASID, NULL);
> -	else if (WARN_ON(true))
> -		ret = -EINVAL;
> +	if (!device_ser) {
> +		if (!sm_supported(iommu))
> +			ret = domain_context_mapping(domain, dev);
> +		else if (intel_domain_is_fs_paging(domain))
> +			ret = domain_setup_first_level(iommu, domain, dev,
> +						       IOMMU_NO_PASID, NULL);
> +		else if (intel_domain_is_ss_paging(domain))
> +			ret = domain_setup_second_level(iommu, domain, dev,
> +							IOMMU_NO_PASID, NULL);
> +		else if (WARN_ON(true))
> +			ret = -EINVAL;
> +	}
>  
>  	if (ret)
>  		goto out_block_translation;
> @@ -3170,6 +3180,15 @@ int paging_domain_compatible(struct iommu_domain *domain, struct device *dev)
>  	struct intel_iommu *iommu = info->iommu;
>  	int ret = -EINVAL;
>  
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	/*
> +	 * Restored IOMMU domains are already attached to the device and can
> +	 * only be freed. So no need to check the compatibility.
> +	 */
> +	if (iommu_domain_restored_state(domain))
> +		return 0;
> +#endif
> +
>  	if (intel_domain_is_fs_paging(dmar_domain))
>  		ret = paging_domain_compatible_first_stage(dmar_domain, iommu);
>  	else if (intel_domain_is_ss_paging(dmar_domain))
> @@ -3647,7 +3666,7 @@ domain_add_dev_pasid(struct iommu_domain *domain,
>  	if (!dev_pasid)
>  		return ERR_PTR(-ENOMEM);
>  
> -	ret = domain_attach_iommu(dmar_domain, iommu);
> +	ret = domain_attach_iommu(dmar_domain, iommu, -1);
>  	if (ret)
>  		goto out_free;
>  
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index b0ec0b471a43..8e37acf7de12 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1182,7 +1182,8 @@ void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
>   */
>  #define QI_OPT_WAIT_DRAIN		BIT(0)
>  
> -int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
> +int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu,
> +			int restore_did);
>  void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
>  void device_block_translation(struct device *dev);
>  int paging_domain_compatible(struct iommu_domain *domain, struct device *dev);
> diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
> index 2b979bec56ce..6e13f697b463 100644
> --- a/drivers/iommu/intel/nested.c
> +++ b/drivers/iommu/intel/nested.c
> @@ -40,7 +40,7 @@ static int intel_nested_attach_dev(struct iommu_domain *domain,
>  		return ret;
>  	}
>  
> -	ret = domain_attach_iommu(dmar_domain, iommu);
> +	ret = domain_attach_iommu(dmar_domain, iommu, -1);
>  	if (ret) {
>  		dev_err_ratelimited(dev, "Failed to attach domain to iommu\n");
>  		return ret;
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0561990f46e3..e888700da53d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -18,6 +18,7 @@
>  #include <linux/errno.h>
>  #include <linux/host1x_context_bus.h>
>  #include <linux/iommu.h>
> +#include <linux/iommu-liveupdate.h>
>  #include <linux/iommufd.h>
>  #include <linux/idr.h>
>  #include <linux/err.h>
> @@ -505,6 +506,10 @@ static int iommu_init_device(struct device *dev)
>  		goto err_free;
>  	}
>  
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	dev->iommu->device_ser = iommu_get_device_preserved_data(dev);
> +#endif
> +
>  	iommu_dev = ops->probe_device(dev);
>  	if (IS_ERR(iommu_dev)) {
>  		ret = PTR_ERR(iommu_dev);
> @@ -2204,6 +2209,13 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>  	ret = domain->ops->attach_dev(domain, dev, old);
>  	if (ret)
>  		return ret;
> +
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	/* The associated state can be unset once restored. */
> +	if (dev_iommu_restored_state(dev))
> +		WRITE_ONCE(dev->iommu->device_ser, NULL);
> +#endif
> +
>  	dev->iommu->attach_deferred = 0;
>  	trace_attach_device_to_domain(dev);
>  	return 0;
> @@ -3159,6 +3171,47 @@ int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
>  }
>  EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
>  
> +static inline void *__iommu_group_restored_state(struct iommu_group *group)
> +{
> +	struct device *dev;
> +
> +	dev = iommu_group_first_dev(group);
> +	if (!dev_is_pci(dev))
> +		return NULL;
> +
> +	return dev_iommu_restored_state(dev);
> +}
> +
> +static struct iommu_domain *__iommu_group_restore_domain(struct iommu_group *group)
> +{
> +	struct iommu_device_ser *device_ser;
> +	struct iommu_domain *domain;
> +	struct device *dev;
> +	void *owner;
> +
> +	lockdep_assert_held(&group->mutex);
> +	dev = iommu_group_first_dev(group);
> +	if (!dev_is_pci(dev))
> +		return NULL;
> +
> +	device_ser = dev_iommu_restored_state(dev);
> +	if (!device_ser)
> +		return NULL;
> +
> +	domain = iommu_restore_domain(dev, device_ser, &owner);
> +	if (WARN_ON(IS_ERR(domain)))
> +		return NULL;
> +
> +	/*
> +	 * Ownership of groups with preserved devices is set during boot. These
> +	 * will be reclaimed later by the entity (iommufd) that preserved them.
> +	 */
> +	WARN_ON(group->owner);
> +	group->owner = owner;
> +	group->owner_cnt = 1;
> +	return domain;
> +}
> +
>  /**
>   * iommu_setup_default_domain - Set the default_domain for the group
>   * @group: Group to change
> @@ -3173,8 +3226,8 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>  				      int target_type)
>  {
>  	struct iommu_domain *old_dom = group->default_domain;
> +	struct iommu_domain *dom, *restored_domain;
>  	struct group_device *gdev;
> -	struct iommu_domain *dom;
>  	bool direct_failed;
>  	int req_type;
>  	int ret;
> @@ -3218,6 +3271,10 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>  	/* We must set default_domain early for __iommu_device_set_domain */
>  	group->default_domain = dom;
>  	if (!group->domain) {
> +		if (__iommu_group_restored_state(group))
> +			restored_domain = __iommu_group_restore_domain(group);
> +		else
> +			restored_domain = dom;
>  		/*
>  		 * Drivers are not allowed to fail the first domain attach.
>  		 * The only way to recover from this is to fail attaching the
> @@ -3225,7 +3282,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>  		 * in group->default_domain so it is freed after.
>  		 */
>  		ret = __iommu_group_set_domain_internal(
> -			group, dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
> +			group, restored_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED);
>  		if (WARN_ON(ret))
>  			goto out_free_old;
>  	} else {
> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> index 60ee29b0c6bd..0888871784ea 100644
> --- a/drivers/iommu/liveupdate.c
> +++ b/drivers/iommu/liveupdate.c
> @@ -234,6 +234,41 @@ int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
>  }
>  EXPORT_SYMBOL(iommu_for_each_preserved_device);
>  
> +static inline bool match_device_ser(struct iommu_device_ser *match,
> +				    struct pci_dev *pdev)
> +{
> +	return match->devid == pci_dev_id(pdev) && match->pci_domain_nr == pci_domain_nr(pdev->bus);
> +}
> +
> +struct iommu_device_ser *iommu_get_device_preserved_data(struct device *dev)
> +{
> +	struct iommu_device_ser *device_ser = NULL;
> +	struct iommu_device_array_ser *array;
> +	struct iommu_flb_obj *flb_obj;
> +	int ret, idx;
> +
> +	if (!dev_is_pci(dev))
> +		return NULL;
> +
> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
> +	if (ret)
> +		return NULL;
> +
> +	array = phys_to_virt(flb_obj->ser->device_array_phys);
> +	iommu_liveupdate_for_each_obj(array, device_ser, idx) {
> +		if (match_device_ser(device_ser, to_pci_dev(dev))) {
> +			device_ser->hdr.incoming = true;
> +			goto out;
> +		}
> +	}
> +
> +	device_ser = NULL;
> +out:
> +	liveupdate_flb_put_incoming(&iommu_flb);
> +	return device_ser;
> +}
> +EXPORT_SYMBOL(iommu_get_device_preserved_data);
> +
>  struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
>  {
>  	struct iommu_hw_ser *iommu_ser = NULL;
> @@ -512,3 +547,46 @@ void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
>  
>  	iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
>  }
> +
> +struct iommu_domain *iommu_restore_domain(struct device *dev,
> +					  struct iommu_device_ser *ser,
> +					  void **owner)
> +{
> +	struct iommu_domain_ser *domain_ser;
> +	struct iommu_flb_obj *flb_obj;
> +	struct iommu_domain *domain;
> +	int ret;
> +
> +	domain_ser = phys_to_virt(ser->domain_iommu_ser.domain_phys);
> +
> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	guard(mutex)(&flb_obj->lock);
> +	if (domain_ser->restored_domain) {
> +		domain = domain_ser->restored_domain;
> +		goto out;
> +	}
> +
> +	domain_ser->hdr.incoming =  true;
> +	domain = iommu_paging_domain_alloc(dev);
> +	if (IS_ERR(domain))
> +		goto out;
> +
> +	ret = domain->ops->restore(domain, domain_ser);
> +	if (ret) {
> +		iommu_domain_free(domain);
> +		domain = ERR_PTR(ret);
> +		goto out;
> +	}
> +
> +	/* The device is owned by the preserved state. */
> +	*owner = ser;
> +	domain->preserved_state = domain_ser;
> +	domain_ser->restored_domain = domain;
> +
> +out:
> +	liveupdate_flb_put_incoming(&iommu_flb);
> +	return domain;
> +}
> diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
> index 0baf6bc2d93f..75d27256c883 100644
> --- a/include/linux/iommu-liveupdate.h
> +++ b/include/linux/iommu-liveupdate.h
> @@ -30,6 +30,20 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
>  	return NULL;
>  }
>  
> +static inline void *dev_iommu_restored_state(struct device *dev)
> +{
> +	struct iommu_device_ser *ser;
> +
> +	if (!dev->iommu)
> +		return NULL;
> +
> +	ser = dev->iommu->device_ser;
> +	if (ser && ser->hdr.incoming)
> +		return ser;
> +
> +	return NULL;
> +}
> +
>  static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
>  {
>  	struct iommu_domain_ser *ser;
> @@ -41,8 +55,22 @@ static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
>  	return NULL;
>  }
>  
> +static inline int dev_iommu_restore_did(struct device *dev, struct iommu_domain *domain)
> +{
> +	struct iommu_device_ser *ser = dev_iommu_restored_state(dev);
> +
> +	if (ser && iommu_domain_restored_state(domain))
> +		return ser->domain_iommu_ser.attachment_id;
> +
> +	return -1;
> +}
> +
> +struct iommu_domain *iommu_restore_domain(struct device *dev,
> +					  struct iommu_device_ser *ser,
> +					  void **owner);
>  int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
>  				    void *arg);
> +struct iommu_device_ser *iommu_get_device_preserved_data(struct device *dev);
>  struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type);
>  int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser);
>  void iommu_domain_unpreserve(struct iommu_domain *domain);
> @@ -60,16 +88,38 @@ static inline void *dev_iommu_preserved_state(struct device *dev)
>  	return NULL;
>  }
>  
> +static inline void *dev_iommu_restored_state(struct device *dev)
> +{
> +	return NULL;
> +}
> +
> +static inline int dev_iommu_restore_did(struct device *dev, struct iommu_domain *domain)
> +{
> +	return -1;
> +}
> +
>  static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
>  {
>  	return NULL;
>  }
>  
> +static inline struct iommu_domain *iommu_restore_domain(struct device *dev,
> +							struct iommu_device_ser *ser,
> +							void **owner)
> +{
> +	return NULL;
> +}
> +
>  static inline int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn, void *arg)
>  {
>  	return -EOPNOTSUPP;
>  }
>  
> +static inline struct iommu_device_ser *iommu_get_device_preserved_data(struct device *dev)
> +{
> +	return NULL;
> +}
> +
>  static inline struct iommu_hw_ser *iommu_get_preserved_data(u64 token, enum iommu_type_ser type)
>  {
>  	return NULL;
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
