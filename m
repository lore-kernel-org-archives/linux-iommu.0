Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9E8145FE0
	for <iommu@lists.linux.dev>; Tue, 10 Mar 2026 05:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773119820; cv=fail; b=sB+iFzM4wIQmACYE+3sygM2Nl33c/5xIwZKtoZrJRMa7Iht17+LspU995ek0nbslc7z/NMdSp7DSLMjeQD913etgRAjLwK0g4CgNz/R2LE0tuTrfWNwcZXK8usGY4+skx3G802bZI25s6eRJm9eORW5XKsG5N9URI84LXiQIeqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773119820; c=relaxed/simple;
	bh=6bzhxMwTIX4qlXaDhU3LK/l+Y6CR71jAq2kIb3KLxJU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fzCp9iXsK0uUV7hCmHsNOZ3hUQmoWV/0xvlnmemMw4OoNLfvDhzCB1yV1MXse11B0/4ppBNVivFVVPDOafvFrCob/OsEp9lCDb06xly1fzFX2mDr4+1fAGoVNZf21sRvlepvMYSeGNWGlKzA2yUvp9bx5OoDJu9Rmj9i/4OzPEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qO3pA4lX; arc=fail smtp.client-ip=52.101.56.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qO3pA4lX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gaU3EhYe4zHeGPlmgsVSNbtqjRTVuLXQCKVpHKqk6wYrhz1lCN4ehX8yOZC/XxvUb3ZIJ8uN9FGnU+jEHtdLTRDz99kqdGxipRfeBS/y9E6Kei51Uw8PKZN6nAYBVpj6EiK+p2FAsg8WXeULO4BZYXSYGh1PNvzrMVrAxgprK41aeYkKPQu/KYUo/D8Zog0TIhvitoKa4D93KRHxpcLLb7qU3G5+chhYbWv3pxRhxskx6D1aqk0pBtUKXJ9bCnKn/lxOUkDKdMl9twdFd+lueVcqxj1w2JiN5MTehFqbzPyUVlkHkbqyNRRpFK3e29sWkK7Kffc6/Jf1G9jr549tjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmiIHFGb4mvlgRvEEzkhMaOaqwspGAB6lH0beLZR/gs=;
 b=kVS4xo2oPnBms9T5BWTHuWRZzVt4GHev1C7YW1JPfWiAjKnTySEd0FofQH65BCdNJ82454rvx6XwNTPLA3RXus4XslsFkz30vJFBdtTe4IVU9Ufde7FE31K3Ohkna1LUzldFcZhhMm8NzLv7B7LA1VrKbltthF5WeoddhKYjH35pAJYzKLm1A5LruS6avmk0B+mbdU6aUxnoCJY7Tf+gWcRPox5limnaI+ZA4cVWMvSYlPDM9O+E8irg7HqUo3BpudCaAFBYJFInqzzd2hBsaqT7v8aIlLJuwOYWFCbQJCCF8C2tKSjYy/GKNXWMnGof4Ujzmb0VKYI0IcmaPq81Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmiIHFGb4mvlgRvEEzkhMaOaqwspGAB6lH0beLZR/gs=;
 b=qO3pA4lXsppBdDrrF03TKP9HZ0H0xIobXQVq2vr3Zk4E2A/t/cOwHNJTbJHy0g8LUB9+eImRoMdhDcHhWDyGk8puLmsutD6teRX4Y2rHEoMARm3gIyoIK4aIv7JAYsvx0KuYQUVPmoCqbpwwIBKsBXsQ32qdrGyfOiOTtdORBnE=
Received: from SA1PR03CA0014.namprd03.prod.outlook.com (2603:10b6:806:2d3::10)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 05:16:52 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:2d3:cafe::a6) by SA1PR03CA0014.outlook.office365.com
 (2603:10b6:806:2d3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Tue,
 10 Mar 2026 05:16:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Tue, 10 Mar 2026 05:16:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 10 Mar
 2026 00:16:51 -0500
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 10 Mar 2026 00:16:45 -0500
Date: Tue, 10 Mar 2026 05:16:35 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Samiullah Khawaja <skhawaja@google.com>
CC: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy
	<robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Alex Williamson
	<alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, Saeed Mahameed
	<saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, Parav
 Pandit <parav@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu
	<witu@nvidia.com>, Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin
	<pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, Andrew
 Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, Pranjal
 Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>, YiFei Zhu
	<zhuyifei@google.com>
Subject: Re: [PATCH 08/14] iommu: Restore and reattach preserved domains to
 devices
Message-ID: <gglhu55vvyqdlunnlpas44trhcijcx3mabk75o4zcc7atvuuyd@sna3cmfaapbh>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-9-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-9-skhawaja@google.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 338fbf29-d42e-4820-e0f7-08de7e643d1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|7053199007|7142099003;
X-Microsoft-Antispam-Message-Info:
	tHOnXfTJbvdy2F15cLHeLhjF+89/74N2zKA2HwHSoJjIPLJIzj4z0GQE1X57U4UZX0EZUvSp8kpKM3K9MlpM5F7SQP4ADDwx6yGAEz/A3gCg1/etB0JG1BQ5f76V5R5y4f5UrQcQAJtNTYY0WoU9fRJCchU1SxKxtJsdPwfsYETrbNOFHH0OAtrR8KaxVvvDoy5YmeLIcFlP2HFQFcXFV/NU2Q6ctIIA0TjCdnrs1mU66dc/vK1iEt4NwRStvJr1OtJ7++u7BfZQLZXKLwX1pwGFAcjLV657089oSjvMuBa0P0KF66XP8JbCSu3WdubftcXso4KGc6JQg7nQdrX0Fn6eqKvmxmPNhfsvm6HN8lr5We79SqjU6pAXzgn5QZxnylpbcc0JgrYdlGxUc3nyQR4vD/poIJhmIaL4xBiL+gOm52YKtCTQuYhQ+WLQU4dD9qnVH0B4nGjUvlFysNKbG0wFqE/mmcCrVi/cjzIAnNF9rxN+1h6Cp7cJNNVhotJg2JIa2IT+9oHETxpM8Fk3R9tRym+5q3WkeiuKsUzt9I1CGSq5ILAYAbS9pUjFNrXnbzStmC4mvRTpE8V8GcwwWMDUzE/2hAHG1aetFibcsV2/rjqWQuijXN5uclBURS/kzd9psh7PnizVy2v4YgAcLX6OP/K28PB1WpXgnmykLkOZL8kkmjfT+HdtA42uMLXyE8NVUGZ6VclNbyy8uga8D8bdaMC6RFaqBiFqugSU5ViB+3iOJIRz4D91a/nriPo0cIow6RpCys4u4NDtS/Q8Dw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(7053199007)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6gB70/G9m8g80k3habYgYxPPtT9mjbgYLnTArbEw+jhQb4v2pbkfHBstjNsmFlHmBfinMdVUizMTXbB8MUlJ02RiGLtw4ajfWsotnv2Ll0/AFJkoH2m7Xbt8Ek4Gn0Oc1rlaFnEJ1kemcaIVUnZfx6YbZ6sykQzM+sLwkovWo6WNkQu54cFHVue+4cmRqVFv6ZadloCxxz9jWLapngoyKgeOHi+32cC2NkzNB/cYZPLPMCGrhkVtRIggfOACW8LDvkL00NyNNquOwkkl/GmTCMbkb250Yqqi1OPjGXfLfYapnbtlkV9Z5BToBIKMwVy04GL0NsOrlN+Fi8Vs0wlwYJQ26AmMJfsyoKQSAqZbY6DUoqX6BdAT6X94YNfPCM1pHojsm3MUqJAi436V13oyX/oIxsA7j9nizk6lr/ZP4MptreyuRZ5xJP7jbaa9qNG8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 05:16:51.9828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 338fbf29-d42e-4820-e0f7-08de7e643d1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796

On Tue, Feb 03, 2026 at 10:09:42PM +0000, Samiullah Khawaja wrote:
> Restore the preserved domains by restoring the page tables using restore
> IOMMU domain op. Reattach the preserved domain to the device during
> default domain setup. While attaching, reuse the domain ID that was used
> in the previous kernel. The context entry setup is not needed as that is
> preserved during liveupdate.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/intel/iommu.c  | 40 ++++++++++++++++++------------
>  drivers/iommu/intel/iommu.h  |  3 ++-
>  drivers/iommu/intel/nested.c |  2 +-
>  drivers/iommu/iommu.c        | 47 ++++++++++++++++++++++++++++++++++--
>  drivers/iommu/liveupdate.c   | 31 ++++++++++++++++++++++++
>  include/linux/iommu-lu.h     |  8 ++++++
>  6 files changed, 112 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 8acb7f8a7627..83faad53f247 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1029,7 +1029,8 @@ static bool first_level_by_default(struct intel_iommu *iommu)
>  	return true;
>  }
>  
> -int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
> +int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu,
> +			int restore_did)
>  {
>  	struct iommu_domain_info *info, *curr;
>  	int num, ret = -ENOSPC;
> @@ -1049,8 +1050,11 @@ int domain_attach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu)
>  		return 0;
>  	}
>  
> -	num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
> -			      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
> +	if (restore_did >= 0)
> +		num = restore_did;
> +	else
> +		num = ida_alloc_range(&iommu->domain_ida, IDA_START_DID,
> +				      cap_ndoms(iommu->cap) - 1, GFP_KERNEL);
>  	if (num < 0) {
>  		pr_err("%s: No free domain ids\n", iommu->name);
>  		goto err_unlock;
> @@ -1321,10 +1325,14 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
>  {
>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>  	struct intel_iommu *iommu = info->iommu;
> +	struct device_ser *device_ser = NULL;
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
> @@ -1337,16 +1345,18 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
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
> @@ -3630,7 +3640,7 @@ domain_add_dev_pasid(struct iommu_domain *domain,
>  	if (!dev_pasid)
>  		return ERR_PTR(-ENOMEM);
>  
> -	ret = domain_attach_iommu(dmar_domain, iommu);
> +	ret = domain_attach_iommu(dmar_domain, iommu, -1);
>  	if (ret)
>  		goto out_free;
>  
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index d7bf63aff17d..057bd6035d85 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1174,7 +1174,8 @@ void __iommu_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
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
> index a3fb8c193ca6..4fed9f5981e5 100644
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
> index c0632cb5b570..8103b5372364 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -18,6 +18,7 @@
>  #include <linux/errno.h>
>  #include <linux/host1x_context_bus.h>
>  #include <linux/iommu.h>
> +#include <linux/iommu-lu.h>
>  #include <linux/iommufd.h>
>  #include <linux/idr.h>
>  #include <linux/err.h>
> @@ -489,6 +490,10 @@ static int iommu_init_device(struct device *dev)
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
> @@ -2149,6 +2154,13 @@ static int __iommu_attach_device(struct iommu_domain *domain,
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
> @@ -3061,6 +3073,34 @@ int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
>  }
>  EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
>  
> +static struct iommu_domain *__iommu_group_maybe_restore_domain(struct iommu_group *group)
> +{
> +	struct device_ser *device_ser;
> +	struct iommu_domain *domain;
> +	struct device *dev;
> +
> +	dev = iommu_group_first_dev(group);
> +	if (!dev_is_pci(dev))
> +		return NULL;
> +
> +	device_ser = dev_iommu_restored_state(dev);
> +	if (!device_ser)
> +		return NULL;
> +
> +	domain = iommu_restore_domain(dev, device_ser);
> +	if (WARN_ON(IS_ERR(domain)))
> +		return NULL;
> +
> +	/*
> +	 * The group is owned by the entity (a preserved iommufd) that provided
> +	 * this token in the previous kernel. It will be used to reclaim it
> +	 * later.
> +	 */
> +	group->owner = (void *)device_ser->token;
> +	group->owner_cnt = 1;
> +	return domain;
> +}
> +
>  /**
>   * iommu_setup_default_domain - Set the default_domain for the group
>   * @group: Group to change
> @@ -3075,8 +3115,8 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>  				      int target_type)
>  {
>  	struct iommu_domain *old_dom = group->default_domain;
> +	struct iommu_domain *dom, *restored_domain;
>  	struct group_device *gdev;
> -	struct iommu_domain *dom;
>  	bool direct_failed;
>  	int req_type;
>  	int ret;
> @@ -3120,6 +3160,9 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>  	/* We must set default_domain early for __iommu_device_set_domain */
>  	group->default_domain = dom;
>  	if (!group->domain) {
> +		restored_domain = __iommu_group_maybe_restore_domain(group);
> +		if (!restored_domain)
> +			restored_domain = dom;
>  		/*
>  		 * Drivers are not allowed to fail the first domain attach.
>  		 * The only way to recover from this is to fail attaching the
> @@ -3127,7 +3170,7 @@ static int iommu_setup_default_domain(struct iommu_group *group,
>  		 * in group->default_domain so it is freed after.
>  		 */
>  		ret = __iommu_group_set_domain_internal(
> -			group, dom, IOMMU_SET_DOMAIN_MUST_SUCCEED);
> +			group, restored_domain, IOMMU_SET_DOMAIN_MUST_SUCCEED);
>  		if (WARN_ON(ret))
>  			goto out_free_old;
>  	} else {
> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> index 83eb609b3fd7..6b211436ad25 100644
> --- a/drivers/iommu/liveupdate.c
> +++ b/drivers/iommu/liveupdate.c
> @@ -501,3 +501,34 @@ void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
>  
>  	iommu_unpreserve_locked(iommu->iommu_dev);
>  }
> +
> +struct iommu_domain *iommu_restore_domain(struct device *dev, struct device_ser *ser)
> +{
> +	struct iommu_domain_ser *domain_ser;
> +	struct iommu_lu_flb_obj *flb_obj;
> +	struct iommu_domain *domain;
> +	int ret;
> +
> +	domain_ser = __va(ser->domain_iommu_ser.domain_phys);
> +
> +	ret = liveupdate_flb_get_incoming(&iommu_flb, (void **)&flb_obj);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	guard(mutex)(&flb_obj->lock);
> +	if (domain_ser->restored_domain)
> +		return domain_ser->restored_domain;
> +
> +	domain_ser->obj.incoming =  true;
> +	domain = iommu_paging_domain_alloc(dev);
> +	if (IS_ERR(domain))
> +		return domain;
> +
> +	ret = domain->ops->restore(domain, domain_ser);
> +	if (ret)

'domain' will leak here.

> +		return ERR_PTR(ret);
> +
> +	domain->preserved_state = domain_ser;
> +	domain_ser->restored_domain = domain;
> +	return domain;
> +}
> diff --git a/include/linux/iommu-lu.h b/include/linux/iommu-lu.h
> index 48c07514a776..4879abaf83d3 100644
> --- a/include/linux/iommu-lu.h
> +++ b/include/linux/iommu-lu.h
> @@ -65,6 +65,8 @@ static inline int dev_iommu_restore_did(struct device *dev, struct iommu_domain
>  	return -1;
>  }
>  
> +struct iommu_domain *iommu_restore_domain(struct device *dev,
> +					  struct device_ser *ser);
>  int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn,
>  				    void *arg);
>  struct device_ser *iommu_get_device_preserved_data(struct device *dev);
> @@ -95,6 +97,12 @@ static inline void *iommu_domain_restored_state(struct iommu_domain *domain)
>  	return NULL;
>  }
>  
> +static inline struct iommu_domain *iommu_restore_domain(struct device *dev,
> +							struct device_ser *ser)
> +{
> +	return NULL;
> +}
> +
>  static inline int iommu_for_each_preserved_device(iommu_preserved_device_iter_fn fn, void *arg)
>  {
>  	return -EOPNOTSUPP;
> -- 
> 2.53.0.rc2.204.g2597b5adb4-goog
> 
