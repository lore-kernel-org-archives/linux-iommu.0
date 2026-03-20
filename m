Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803733246ED
	for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 06:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773988623; cv=fail; b=MHYkqMZz4fiSKhgsQYClzuHzM4g45ozSQQgdwX9f7zxGd1CYIzfSMNfrBOo7Sdk3Q67v8GIa7nLFa7ncwAIXKy6U3tja8j4R7q5FZrNI0VR3a3TTx+ZBS8WjSPOVht+0NZ1l4PWM5j2CRxlpyyec2zROz0TJXHy1rhfPoizeB3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773988623; c=relaxed/simple;
	bh=YsxM6kqhR+dZ5ovffnG23Ll9+3aGARdximxKQa74vho=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGX1kuAUyXozp+eOs1KER+YMy+/19KOoEwiAk8ukBqufhWjTNyJF5eQazmTZnOi7TPnqP4bU4k1x4q8MUySIgF2a002byOyU3cUzr5zh5E+ClZCiGwI6xcHEHz10VIyLTMT8YiRhQT0zs0YKBklc4xMgsAIssM2NS3xP13LnzEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NaZtXvGn; arc=fail smtp.client-ip=52.101.43.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NaZtXvGn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckC+PxV+YL9YJqJmAidQkAAPTDNpkjUrA3+NlFjIo+ow9zQ1PgYMSUoSyJfLUq8gkYpVbOScupL0sCxe4eQan49wQGmAgnqRYFjE74hwWkaupsrF1pZEEWzSAxH7o+5X/c0yIAQOJ/JnkTywX1wAoFJbBpvQfx9aq8AFg6WzM6CZHphdZs7pVMLtF1rexFfcYPCyMJ4eiZy9t3GxbZ6/V/YM0PHCf3yptdg8x8BBGMdPkDQv2SiINTKQj3KbgbKzmvj5OZ67SSEvuNAzEJjUrC/kGgtkRKBJn92QCymjNQMMaxdP7GU2hRKuIaFT4sdqRj1HVF26Owts1PTEurNgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rn8+IoSJ9x8cvHpVPu9gWqJAg8R5p8fBagxNjMq0SA=;
 b=kiWn/g7QtiIkX8YEGJO+7QNmeEgLP0GrktoDFutQcbvA0JE+4C1SY1OlMhujNllDyS1ChxhxkkfmPRB4fpCyOQe+wogZqB24T4e5v7hkrvM39AGOnBSvvls/kff8lvfV2RBCKaTpJw+FZ+m9t22CQxqLy73/Q2iXhWBXX8czgJx2BVUZlUL+Q3/41pYLPoUeKNCHYDn+ys9oFolxox9fR4T8b0UJRIgNysTh+1pVVIlULnaYjH/xmIgAD+gixN2omwzNPbga+HMA/ONyw9bwrXekrjgCiwsvc8PPLCFekJVs9mgRQqgU9FiPwc313tLGD6sL475ng9lEN02HzMbNXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rn8+IoSJ9x8cvHpVPu9gWqJAg8R5p8fBagxNjMq0SA=;
 b=NaZtXvGnmvNDuwbUK1uDbPwl3SeLGurg0qgBh0tMdO4zzdBA6uDwluh2GRvI+EkKMe4QMWKd6Fm9mHLK7kJKth4IG4lREn967UNgQz/iwXozbuFByPNPKiL1Sw6tHJPAoL6QViZ1hfg7SSlKtu5E55J+/MrjbCgCT2sHJQP3ZeY=
Received: from CH0PR13CA0046.namprd13.prod.outlook.com (2603:10b6:610:b2::21)
 by DS4PR12MB9748.namprd12.prod.outlook.com (2603:10b6:8:29e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 06:35:58 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:b2:cafe::30) by CH0PR13CA0046.outlook.office365.com
 (2603:10b6:610:b2::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20 via Frontend
 Transport; Fri, 20 Mar 2026 06:35:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.0 via Frontend Transport; Fri, 20 Mar 2026 06:35:58 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 01:35:57 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 19 Mar
 2026 23:35:57 -0700
Received: from amd.com (10.180.168.240) by satlexmb08.amd.com (10.181.42.217)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 20 Mar 2026 01:35:54 -0500
Date: Fri, 20 Mar 2026 06:35:50 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>, Vasant Hegde
	<Vasant.Hegde@amd.com>
CC: Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <ahuang12@lenovo.com>
Subject: Re: [PATCH 1/2] iommu/amd: Keep x2apic enabled when appending
 amd_iommu=off
Message-ID: <x5vb7yzww5bfw2jamjjyvexe5ekygnbee5s4g3pkk6e2pkstdj@dejo5755hbbn>
References: <20260319061507.541-1-adrianhuang0701@gmail.com>
 <20260319061507.541-2-adrianhuang0701@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260319061507.541-2-adrianhuang0701@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|DS4PR12MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: 438bea61-23e1-4e8d-b1b9-08de864af247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uaP3AP8S3WnBBkGSDBvT5DzDsWNz0nPPREaP3lujva+xWMbIKPSZesEBeRCCUPydkWqRWHWFlYoN/5coqlEt4KlfJuiQsBcGw6KCof+MhJcUc1dt6EQ9kOEqywywyd+0gCzQj9PG/9ZpLuI7ERUV3Komv4+T2ApebZ23g+YxUqE+3YtUOKTHHmUPGkfAU94/TitYH1Z3/NrFp7VpCb83Rmo4nozUMe+weop4KHlZDlNfcBXeOOoUrmrpjRAb+fNJ1KRwemefF/KK8ml/Y3bzXmGjq7mMyoOhkyMNW2ilgVVo4xB7BzEHU7tPveapzggR1sxlu2Vv0iloLuwBqe2+vlcObPHOFD5yDjk580lUtK3jnsEvdNhj5JZQ5Ud9Y0VbeUswCwVjvQm2VQLIDxE2jROyJO5Z1gvNZOF9VEwwf5wlPtv93Jfy1rPytmRMXRk11gQR70ZJpPDRg+3QH0CiJ0bxwP5ihqBHio9K3FjXrdT+HvB1ugquoIWCns/I5g8wCDDe97+CdtzSL10ZbZPcMwDG5cIU8KbDRzCW4VyAoVXK1bTO6HsZQWNAyqfnSo/+yPCXkn09ezMa4JSHl6Kxdtnh6cBNWvFTClrkYnESwBCYQ9JYexKmgU+ZKSGEXRRPrvt24sLscJG6h2LIzzdSs4Kf15Jxwf8DSJsjZiP67eBJ21mWmvMkxr7W8qn5L2T1wcKErSHRdTZ5OMNQYH19HqNnOnDewL7GUgNSF/hotNxgBazpgGN8eUd7FWy/+sHlOvtV6VI6JVRFcg1HxMyLwg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hXCYgvCEpdASKIsqNuIyWjU1mf2PxZp/2MaC5YwoZedD1FMxhQH6mK6raTr7qoUsyHwnV4QgaHDPUvUJQII7nfHCJVe42qBelbfJ2Wj0bwH0ts4WTOgpFI0XC/0ywAKIayfbh6kg+x7Hw2N/v3x3BDnaL0f10wmpEqjTfEtryVOybAu/7sRW6mPmNxKBgbvqYpZT8ijZHwijcXOpz23xn1JmeftAyEaP4qktVzLS3/CfLXaLjZRK/yUEOcbHUNslr4SIjWEHhT88BASvzT4qEgmEJbpplHDqO8DOQofTh3y0KVTD5jjBNu4IFYpGiYVlFx8CgNA4dGg6rL5M6S/ico3lonLdlHxNmY14M8F6GA6PQXn3UPgc4a/ukbtMyDY4rfubVEiEgYMfAZTUTwIbqjh2KBVOgIOC2NwzDE4smC/QdoG+PZKcyG41RMtzMvol
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 06:35:58.3064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 438bea61-23e1-4e8d-b1b9-08de864af247
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9748

On Thu, Mar 19, 2026 at 02:15:06PM +0800, Adrian Huang (Lenovo) wrote:
> When booting with amd_iommu=off, the AMD IOMMU driver currently
> disables the entire IOMMU subsystem, which also results in x2APIC
> being turned off. Consequently, the APIC mode falls back from
> x2APIC to physical flat mode.
> 
> The dmesg log shows the transition:
>   x2apic: enabled by BIOS, switching to x2apic ops
>   ...
>   APIC: Switched APIC routing to: cluster x2apic
>   ...
>   APIC: Switch to symmetric I/O mode setup
>   x2apic: IRQ remapping doesn't support X2APIC mode
>   x2apic disabled
>   APIC: Switched APIC routing to: physical flat
> 
> Since physical flat mode supports only up to 255 APIC IDs,
> systems with large CPU counts cannot fully initialize. For example,
> on a 448-core system, the kernel reports repeated errors such as:
>   smpboot: CPU 112 has invalid APIC ID 100. Aborting bringup
>   smpboot: CPU 113 has invalid APIC ID 102. Aborting bringup
>   ...
>   smp: Brought up 2 nodes, 224 CPUs
> 
> Eventually, only 224 CPUs are brought up because of valid APIC IDs
> and the APIC ID limitation of the physical flat mode.
> 
> In contrast, on an Intel platform with 960 cores, booting with
> intel_iommu=off does not disable x2APIC:
>     x2apic: enabled by BIOS, switching to x2apic ops
>     ...
>     APIC: Switched APIC routing to: cluster x2apic
>     ...
>     APIC: Switch to symmetric I/O mode setup
>     DMAR: Host address width 46
>     ...
>     smpboot: CPU0: Intel(R) Xeon(R) Platinum 8490H (family: 0x6,
>     model: 0x8f, stepping: 0x6)
>     ...
>     smp: Brought up 8 nodes, 960 CPUs
> 
> This confirms that x2APIC remains enabled when intel_iommu=off
> is specified.
> 
> Adjust the semantics of "amd_iommu=off" so that:
> 
>   * DMA translation is disabled
>   * x2apic remains enabled
> 
> This preserves x2APIC functionality and allows large CPU count
> systems to operate correctly, while still disabling DMA remapping.
> 
> With this patch, the system correctly brings up all 448 cores when
> booting with amd_iommu=off, as verified by the logs below:
>   x2apic: enabled by BIOS, switching to x2apic ops
>   ...
>   APIC: Switched APIC routing to: cluster x2apic
>   ...
>   APIC: Switch to symmetric I/O mode setup
>   ...
>   smp: Brought up 2 nodes, 448 CPUs
>   ...
>   AMD-Vi: Interrupt remapping enabled
>   AMD-Vi: X2APIC enabled
>   ...
> 
> Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
> ---
>  drivers/iommu/amd/amd_iommu.h |  1 +
>  drivers/iommu/amd/init.c      | 56 ++++++++++++++++++++++++++++-------
>  drivers/iommu/amd/iommu.c     | 14 +++++++++
>  3 files changed, 61 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 1342e764a548..82c10f55f0ea 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -22,6 +22,7 @@ void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
>  void amd_iommu_restart_ga_log(struct amd_iommu *iommu);
>  void amd_iommu_restart_ppr_log(struct amd_iommu *iommu);
>  void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
> +void amd_iommu_dev_set_pci_msi_domain(struct device *dev);
>  void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
>  void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
>  				  gfp_t gfp, size_t size);
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index f3fd7f39efb4..0f577534702d 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3396,6 +3396,41 @@ static __init void iommu_snp_enable(void)
>  #endif
>  }
>  
> +static int __init amd_iommu_devices_set_pci_msi_domain(void)
> +{
> +	struct pci_dev *dev = NULL;
> +	struct amd_iommu *iommu;
> +	int ret = 0;
> +
> +	/* Register IRQ handler for each iommu device. */
> +	for_each_iommu(iommu) {
> +		iommu->dev = pci_get_domain_bus_and_slot(iommu->pci_seg->id,
> +						 PCI_BUS_NUM(iommu->devid),
> +						 iommu->devid & 0xff);
> +		if (!iommu->dev)
> +			return -ENODEV;
> +
> +		ret = iommu_init_irq(iommu);
> +		if (ret)
> +			return ret;
> +
> +		iommu->dev->irq_managed = 1;
> +	}
> +
> +	/*
> +	 * In configurations where the IOMMU is disabled but x2APIC is
> +	 * required for high CPU counts (> 256), the kernel must explicitly
> +	 * map PCI Message Signaled Interrupt (MSI) domains to the IOMMU
> +	 * hardware's interrupt domain to ensure valid interrupt routing.
> +	 */
> +	for_each_pci_dev(dev)
> +		amd_iommu_dev_set_pci_msi_domain(&dev->dev);
> +
> +	print_iommu_info();
> +
> +	return ret;
> +}
> +
>  /****************************************************************************
>   *
>   * AMD IOMMU Initialization State Machine
> @@ -3416,13 +3451,8 @@ static int __init state_next(void)
>  		}
>  		break;
>  	case IOMMU_IVRS_DETECTED:
> -		if (amd_iommu_disabled) {
> -			init_state = IOMMU_CMDLINE_DISABLED;
> -			ret = -EINVAL;
> -		} else {
> -			ret = early_amd_iommu_init();
> -			init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
> -		}
> +		ret = early_amd_iommu_init();
> +		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_ACPI_FINISHED;
>  		break;
>  	case IOMMU_ACPI_FINISHED:
>  		early_enable_iommus();
> @@ -3430,9 +3460,15 @@ static int __init state_next(void)
>  		init_state = IOMMU_ENABLED;
>  		break;
>  	case IOMMU_ENABLED:
> -		register_syscore(&amd_iommu_syscore);
> -		iommu_snp_enable();
> -		ret = amd_iommu_init_pci();
> +		if (amd_iommu_disabled) {
> +			amd_iommu_devices_set_pci_msi_domain();
> +			init_state = IOMMU_CMDLINE_DISABLED;

There is no point in assigning IOMMU_CMDLINE_DISABLED as it will
overwrite at below.
and IMO syscore must be registered when interrupt remapping is on, in
order to support suspend/resume operations.

> +			ret = -EINVAL;

and we are relying on this error for teardown(below in this function), which
may be fragile, an explicit handling should be there for 'amd_iommu=off'.
@vasant, your openion?

> +		} else {
> +			register_syscore(&amd_iommu_syscore);
> +			iommu_snp_enable();
> +			ret = amd_iommu_init_pci();
> +		}
>  		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_PCI_INIT;
>  		break;
>  	case IOMMU_PCI_INIT:
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 81c4d7733872..75b10eca9ecf 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2439,6 +2439,20 @@ static void detach_device(struct device *dev)
>  	mutex_unlock(&dev_data->mutex);
>  }
>  
> +void amd_iommu_dev_set_pci_msi_domain(struct device *dev)
> +{
> +	struct amd_iommu *iommu;
> +
> +	if (!check_device(dev))
> +		return;
> +
> +	iommu = rlookup_amd_iommu(dev);
> +	if (!iommu)
> +		return;
> +
> +	amd_iommu_set_pci_msi_domain(dev, iommu);
> +}
> +
>  static struct iommu_device *amd_iommu_probe_device(struct device *dev)
>  {
>  	struct iommu_device *iommu_dev;
> -- 
> 2.47.3
> 
