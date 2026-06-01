Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012039.outbound.protection.outlook.com [52.101.43.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BED33E351
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 06:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294798; cv=fail; b=CCceI2rsOzFV33Io9wVBs5J+nNwTW/qRZn5GF94IvKwoMNxSK9nDANL8Ch6Ytk/vYVPKDPQApmOCumes0U0m3F4Qu1gfvJQM7anam/BroQ+iDkI6fyqxLKuPMxmZEesHuStWhoB7sTKqf9BX4FCtGxKjV6aIxZPv7g8YcIWBPWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294798; c=relaxed/simple;
	bh=ugaq0EsG87EEcjE/rBV/FPULNmjDXHjE7d5ImIY0SAA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOiLeZqx/EG8gGpW0+h6p4HB5YLqlhiIJMFolWvSqxvkyo+/xTQmyd+lrlplf68Z2x8UZnf2xhW5oBTEdAEad13d2Pn5ZhJwE2GL0j6ngAAc6oL74RUWmlNgGM+Rdco8gccxPZRdN1z4kH+nbLpjT5Cd28eecXuXpINN14J6F1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XVcZhmKU; arc=fail smtp.client-ip=52.101.43.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XVcZhmKU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcpbfgz0+aeZZ+V72z2GbkTlnG7FR2TOqIiSf8BhBfgj0uA00GXjRlGogNZ+QTTPBi5xPenJgc093nPWrlvNOZdhkfzIotYWnUArxnxVFugrUKyZeXWtIPhsIpa4/zY09Wmi55o1WSNRTFYwVrugQZKM7dAlLP0TKZNTfweLsXRZVvC81YngqhQUQwhwlPbEow+SzTwE7OPZQjvjbk41uGwR2enSIZ4cxX7P7/a+MO4m+wvu8OVRcLsEs639cDtU6UT4lQU4bitgYmIQXgJDeTaWoJ2ufBWJsY0PFuF7yhUYmt0Xe8BVP/cJYsy6Oqg7domO/Eg0sEgV7nI8zDOiIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksp/a9S925NT0rxLMgg9ITBS4woMycGXabYya6+vuH8=;
 b=CMU81MVmJEcHmrTbSiwTzVO+KQNkMgdE34KMp8qOLzyLG9MEMzEygSrCK1gI0GxfqTvPrZVWNK44o0Ro/pSGhD8tBvyHbORLcahyChSgOX2ok/ZFmjFNlmm3hL0WYZI5+VsoaCdWbR96uM4SHOs2KZ6rjOqokYFuaZJGMWdj+qXS+n42GAR/E9OjYKiJq9ghWTvTU9nMJZISTbiyHZp0Rht5QYZ3da+dpdlY6aB70iSMtyMk9nLLHLRhB0yyJ/L+1hhpsZwysSEgT6onhB2dYzd+941AFyy03lfrk82cPoW1XGzcQbZw5AMUi4qAbP5WIhneoCbZ1Blfvy9uM9L24w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ksp/a9S925NT0rxLMgg9ITBS4woMycGXabYya6+vuH8=;
 b=XVcZhmKUOpdVloZdPwHdYKHZ+erSgdDOSmiBrhgfKMB2tX1NaAG0tXlruNOUFOcrOh4sZRaJm+NcuLlcHUCwi87j0Ik7OBqOcbw6wylF68CcPHeLZsn9HlOsgD9Zx9HYxPwT2TDu2XEu5Qpn8BeJLSB563xyZwQw75dUKYAim9Q=
Received: from CY8P220CA0032.NAMP220.PROD.OUTLOOK.COM (2603:10b6:930:47::16)
 by DS0PR12MB999105.namprd12.prod.outlook.com (2603:10b6:8:301::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 06:19:53 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:930:47:cafe::ab) by CY8P220CA0032.outlook.office365.com
 (2603:10b6:930:47::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 06:19:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 06:19:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 01:19:51 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 31 May
 2026 23:19:50 -0700
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 01:19:44 -0500
Date: Mon, 1 Jun 2026 06:19:38 +0000
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
Subject: Re: [PATCH v2 04/16] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <ajb2t6557ykrjtvzfrhd2tprewpwzqwko46j6kbepntd4cofwy@yylws4yeg2zd>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-5-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-5-skhawaja@google.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|DS0PR12MB999105:EE_
X-MS-Office365-Filtering-Correlation-Id: f86e36b1-3e8a-4453-95e2-08debfa5cac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|7416014|376014|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	D6sMp5a6fFfUwBmLO1u7/RxSkjTgVjqCXSu89kgMTcgV0r5l/Ilj2hDzcQir5H+vd1HFHox3Eq6pg7GPz4XsSIc3QTxyBvrjdA4tzdNroWMwovLvF8BbTpDtjPNQpoyg02AkjlE7t9icdAH+MIbzh88y1tVt4/WXy1VHKnS40filSbLGiyQVaf8KLRIiB0zYG5IHbj74/eVVUozZB/eXCOek+z3qlH4H9kbT0+vB1aNVdR7tRZHvIahDHnM6Tjq0Nad8RLCxdPJmYjIQ9TyN79W3RfeSKiq9fJywVNKb6O9yfEYQq9KDldhQDn5is3FmEkB8jSYI46aYJmMOhVJys6wlRmuFTeKpRytnivpS7y8n5lDta9oLm1gz19gv26ZFMtX4PqzFxmJtc6JJr7lsjoTfmcglEbrdVwfByxkt8EULrfVLjRAXzHiLaqUGCQMqh/xsbRj4iSy+XsFFIdaEq3EomTCtf2VRkIUin+rQ9vgQt+tVtYboz5oIB6NeeQa5AeHxbytWAjuIiWVyf1DB4DNj8FWguaHnJiiRQMxOuHA9HqFFeUs5cjMfOyBg/SX5jRsnX6XCtMi8ILEEwWlIN1pgAMqBHYeZfOc1rNY4cg7Q6AU9kq7fYR2DeX0ztFVwNMvCqH91/kDR6jUOcdm1CAEfLz0GkSMLXae9sH1q9zsPp41ZU7XNFUgRXzCvJug1BlYi9XSR1MKwpgrETL43wEkWXQlbfPNiWq/R8tD/dXw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XSQTx7fPdeWXoogwCRs/dkMrtSAxwR6I0CsGdEy9syqsXNt1gV5XPggoepN8cxML8OH3n0Dv4n516NtCExVFKcd7bYROuSwHHyWVcKYqaeBu7XFR9XI1Yegsj/HBvd9bdU7rmKiMs+jbMHm/Nxr/+myvLBy4eWYyyrbYrC6hArQ0Upsbpy5cmd8Z17+eHejeH8PHu1ATWJv1trXfq56k6hd0knU/rvGLnVfYuHaMvQ+dh4DLVJUPVob+J8F/cBH8O/CbfgEtR1Fm2vRv3l04x9INtWpKulTJTztMO44YTj6FD1ZwUJ+hiPCH5+v10EhlmhZFQbFI5ADI+oaQ9EmQDCk/bcYOa5QnbRuwyrfbOZnEk2AYA4K3NFLUAgwZ5usKUoTp0bbD8Rqisvd/RnbY3otgGGJPJR2my7rqJ/appwP3bx08CesCgMZ30Gl4ca2Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 06:19:52.4929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f86e36b1-3e8a-4453-95e2-08debfa5cac4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999105

On Mon, Apr 27, 2026 at 05:56:21PM +0000, Samiullah Khawaja wrote:
> Add IOMMU ops to preserve/unpreserve a device. These can be implemented
> by the IOMMU drivers that support preservation of devices that have
> their IOMMU domains preserved. During device preservation the state of
> the associated IOMMU is also preserved as dependency.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
 
[..]

> +void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
> +{
> +	struct iommu_flb_obj *flb_obj;
> +	struct iommu_device_ser *iommu_device_ser;
> +	struct dev_iommu *iommu;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	if (!dev_is_pci(dev))
> +		return;
> +
> +	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
> +		return;
> +
> +	pdev = to_pci_dev(dev);

nit

pdev is declared and assigned, but never used here.

> +	iommu = dev->iommu;
> +	if (!iommu->iommu_dev->ops->unpreserve_device ||
> +	    !iommu->iommu_dev->ops->unpreserve)
> +		return;
> +
> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
> +	if (WARN_ON(ret))
> +		return;
> +
> +	guard(mutex)(&flb_obj->lock);
> +	iommu_device_ser = dev_iommu_preserved_state(dev);
> +	if (WARN_ON(!iommu_device_ser))
> +		return;
> +
> +	iommu->iommu_dev->ops->unpreserve_device(dev, iommu_device_ser);
> +	dev->iommu->device_ser = NULL;
> +
> +	iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
> +}
> diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
> index 6019cfc27428..279c7ab04f09 100644
> --- a/include/linux/iommu-liveupdate.h
> +++ b/include/linux/iommu-liveupdate.h
> @@ -8,14 +8,37 @@
>  #ifndef _LINUX_IOMMU_LIVEUPDATE_H
>  #define _LINUX_IOMMU_LIVEUPDATE_H
>  
> +#include <linux/device.h>
>  #include <linux/iommu.h>
>  #include <linux/liveupdate.h>
>  #include <linux/kho/abi/iommu.h>
>  
>  #ifdef CONFIG_IOMMU_LIVEUPDATE
> +static inline void *dev_iommu_preserved_state(struct device *dev)
> +{
> +	struct iommu_device_ser *ser;
> +
> +	if (!dev->iommu)
> +		return NULL;
> +
> +	ser = dev->iommu->device_ser;
> +	if (ser && !ser->hdr.incoming)
> +		return ser;
> +
> +	return NULL;
> +}
> +
>  int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser);
>  void iommu_domain_unpreserve(struct iommu_domain *domain);
> +int iommu_preserve_device(struct iommu_domain *domain,
> +			  struct device *dev, u64 *preserved_state);
> +void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev);
>  #else
> +static inline void *dev_iommu_preserved_state(struct device *dev)
> +{
> +	return NULL;
> +}
> +
>  static inline int iommu_domain_preserve(struct iommu_domain *domain, struct iommu_domain_ser **ser)
>  {
>  	return -EOPNOTSUPP;
> @@ -24,6 +47,16 @@ static inline int iommu_domain_preserve(struct iommu_domain *domain, struct iomm
>  static inline void iommu_domain_unpreserve(struct iommu_domain *domain)
>  {
>  }
> +
> +static inline int iommu_preserve_device(struct iommu_domain *domain,
> +					struct device *dev, u64 *preserved_state)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
> +{
> +}
>  #endif
>  
>  int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 3853a3946733..1c424b32c5fc 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -655,6 +655,10 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
>   *               resources shared/passed to user space IOMMU instance. Associate
>   *               it with a nesting @parent_domain. It is required for driver to
>   *               set @viommu->ops pointing to its own viommu_ops
> + * @preserve_device: Preserve state of a device for liveupdate.
> + * @unpreserve_device: Unpreserve state that was preserved earlier.
> + * @preserve: Preserve state of iommu translation hardware for liveupdate.
> + * @unpreserve: Unpreserve state of iommu that was preserved earlier.
>   * @owner: Driver module providing these ops
>   * @identity_domain: An always available, always attachable identity
>   *                   translation.
> @@ -711,6 +715,13 @@ struct iommu_ops {
>  			   struct iommu_domain *parent_domain,
>  			   const struct iommu_user_data *user_data);
>  
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	int (*preserve_device)(struct device *dev, struct iommu_device_ser *device_ser);
> +	void (*unpreserve_device)(struct device *dev, struct iommu_device_ser *device_ser);
> +	int (*preserve)(struct iommu_device *iommu, struct iommu_hw_ser *iommu_ser);
> +	void (*unpreserve)(struct iommu_device *iommu, struct iommu_hw_ser *iommu_ser);
> +#endif
> +
>  	const struct iommu_domain_ops *default_domain_ops;
>  	struct module *owner;
>  	struct iommu_domain *identity_domain;
> @@ -806,6 +817,8 @@ struct iommu_domain_ops {
>   * @singleton_group: Used internally for drivers that have only one group
>   * @max_pasids: number of supported PASIDs
>   * @ready: set once iommu_device_register() has completed successfully
> + * @outgoing_preserved_state: preserved iommu state of outgoing kernel for
> + * liveupdate.
>   */
>  struct iommu_device {
>  	struct list_head list;
> @@ -815,6 +828,10 @@ struct iommu_device {
>  	struct iommu_group *singleton_group;
>  	u32 max_pasids;
>  	bool ready;
> +
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	struct iommu_hw_ser *outgoing_preserved_state;
> +#endif
>  };
>  
>  /**
> @@ -869,6 +886,9 @@ struct dev_iommu {
>  	u32				pci_32bit_workaround:1;
>  	u32				require_direct:1;
>  	u32				shadow_on_flush:1;
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	struct iommu_device_ser		*device_ser;
> +#endif
>  };
>  
>  int iommu_device_register(struct iommu_device *iommu,
> -- 
> 2.54.0.545.g6539524ca2-goog
> 
