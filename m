Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CC5C433F5
	for <iommu@archiver.kernel.org>; Tue, 26 Apr 2022 09:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50E6640095;
	Tue, 26 Apr 2022 09:01:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id guwK-qvF538k; Tue, 26 Apr 2022 09:01:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8D8FB40072;
	Tue, 26 Apr 2022 09:01:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A7F3C0039;
	Tue, 26 Apr 2022 09:01:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 80FCDC002D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 09:01:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F9E781AF3
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 09:01:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qyDRyt2i_kou for <iommu@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 09:01:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E16A81A92
 for <iommu@lists.linux-foundation.org>; Tue, 26 Apr 2022 09:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1650963712; x=1682499712;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=QL2x8lXrIb4jKPEsCIaM87Qxn+mUBNER/gBwSqZgzag=;
 b=kcuq2Nrw7TCYrmvP3cGeb/HdEGBtsYyIeve56WNVT64vpZgGLAxLh6iP
 2xxLRWq1+mOxFmVQsuRfymxwIGr+9qST5pq2/y3+B0fwlQv9bcBZfFW0P
 9cha7z3iKlyAhwLVQLaHJ80A603Ccjdb87ECLjICuRd0/xc8+IgK/prgU
 iAdJA/MnZ8fXmL4KEbxF/HA8s+r+hb7gPVcVEV+hJ/riA5Bhv8hGgtXJL
 xCFO4ERZ7/GfPv10CpJPqWH+JZVCgKWi6FDu5e4oyqNwXz/JLW2yzKOEK
 WI72dsIp5JUWW3p8zYQT1JswfK4VCoOwhD01P6KvVscphD/hRs1moOP1z w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="290649729"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; d="scan'208";a="290649729"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2022 02:01:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; d="scan'208";a="558202655"
Received: from sning-mobl2.ccr.corp.intel.com (HELO [10.249.171.83])
 ([10.249.171.83])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2022 02:01:36 -0700
Message-ID: <38f74aea-ac9a-a7db-2dc4-013671241add@linux.intel.com>
Date: Tue, 26 Apr 2022 17:01:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 2/2] PCI: Rename pci_dev->untrusted to
 pci_dev->untrusted_dma
Content-Language: en-US
To: Rajat Jain <rajatja@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Rajat Jain <rajatxjain@gmail.com>, Dmitry Torokhov <dtor@google.com>,
 Jesse Barnes <jsbarnes@google.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Pavel Machek <pavel@denx.de>, Oliver O'Halloran <oohall@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org
References: <20220426000640.3581446-1-rajatja@google.com>
 <20220426000640.3581446-2-rajatja@google.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220426000640.3581446-2-rajatja@google.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022/4/26 08:06, Rajat Jain wrote:
> Rename the field to make it more clear, that the device can execute DMA
> attacks on the system, and thus the system may need protection from
> such attacks from this device.
> 
> No functional change intended.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> v6: No change in this patch, rebased on top of changes in other patch.
> v5: Use "untrusted_dma" as property name, based on feedback.
>      Reorder the patches in the series.
> v4: Initial version, created based on comments on other patch
> 
>   drivers/iommu/dma-iommu.c   | 6 +++---
>   drivers/iommu/intel/iommu.c | 2 +-
>   drivers/iommu/iommu.c       | 2 +-
>   drivers/pci/ats.c           | 2 +-
>   drivers/pci/pci-acpi.c      | 2 +-
>   drivers/pci/pci.c           | 2 +-
>   drivers/pci/probe.c         | 8 ++++----
>   drivers/pci/quirks.c        | 2 +-
>   include/linux/pci.h         | 5 +++--
>   9 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 09f6e1c0f9c0..aeee4be7614d 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -497,14 +497,14 @@ static int iova_reserve_iommu_regions(struct device *dev,
>   	return ret;
>   }
>   
> -static bool dev_is_untrusted(struct device *dev)
> +static bool dev_has_untrusted_dma(struct device *dev)
>   {
> -	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
> +	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted_dma;
>   }
>   
>   static bool dev_use_swiotlb(struct device *dev)
>   {
> -	return IS_ENABLED(CONFIG_SWIOTLB) && dev_is_untrusted(dev);
> +	return IS_ENABLED(CONFIG_SWIOTLB) && dev_has_untrusted_dma(dev);
>   }
>   
>   /**
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index df5c62ecf942..b88f47391140 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4843,7 +4843,7 @@ static bool intel_iommu_is_attach_deferred(struct device *dev)
>    */
>   static bool risky_device(struct pci_dev *pdev)
>   {
> -	if (pdev->untrusted) {
> +	if (pdev->untrusted_dma) {
>   		pci_info(pdev,
>   			 "Skipping IOMMU quirk for dev [%04X:%04X] on untrusted PCI link\n",
>   			 pdev->vendor, pdev->device);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index f2c45b85b9fc..d8d3133e2947 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1525,7 +1525,7 @@ static int iommu_get_def_domain_type(struct device *dev)
>   {
>   	const struct iommu_ops *ops = dev_iommu_ops(dev);
>   
> -	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted)
> +	if (dev_is_pci(dev) && to_pci_dev(dev)->untrusted_dma)
>   		return IOMMU_DOMAIN_DMA;
>   
>   	if (ops->def_domain_type)
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index c967ad6e2626..477c16ba9341 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -42,7 +42,7 @@ bool pci_ats_supported(struct pci_dev *dev)
>   	if (!dev->ats_cap)
>   		return false;
>   
> -	return (dev->untrusted == 0);
> +	return (dev->untrusted_dma == 0);
>   }
>   EXPORT_SYMBOL_GPL(pci_ats_supported);
>   
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index d7c6ba48486f..7c2784e7e954 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1395,7 +1395,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
>   
>   	pci_acpi_optimize_delay(pci_dev, adev->handle);
>   	pci_acpi_set_external_facing(pci_dev);
> -	pci_dev->untrusted |= pci_dev_has_dma_property(pci_dev);
> +	pci_dev->untrusted_dma |= pci_dev_has_dma_property(pci_dev);
>   	pci_acpi_add_edr_notifier(pci_dev);
>   
>   	pci_acpi_add_pm_notifier(adev, pci_dev);
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 9ecce435fb3f..1fb0eb8646c8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -958,7 +958,7 @@ static void pci_std_enable_acs(struct pci_dev *dev)
>   	ctrl |= (cap & PCI_ACS_UF);
>   
>   	/* Enable Translation Blocking for external devices and noats */
> -	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
> +	if (pci_ats_disabled() || dev->external_facing || dev->untrusted_dma)
>   		ctrl |= (cap & PCI_ACS_TB);
>   
>   	pci_write_config_word(dev, pos + PCI_ACS_CTRL, ctrl);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 17a969942d37..d2a9b26fcede 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1587,7 +1587,7 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>   		dev->is_thunderbolt = 1;
>   }
>   
> -static void set_pcie_untrusted(struct pci_dev *dev)
> +static void pci_set_untrusted_dma(struct pci_dev *dev)
>   {
>   	struct pci_dev *parent;
>   
> @@ -1596,8 +1596,8 @@ static void set_pcie_untrusted(struct pci_dev *dev)
>   	 * untrusted as well.
>   	 */
>   	parent = pci_upstream_bridge(dev);
> -	if (parent && (parent->untrusted || parent->external_facing))
> -		dev->untrusted = true;
> +	if (parent && (parent->untrusted_dma || parent->external_facing))
> +		dev->untrusted_dma = true;
>   }
>   
>   static void pci_set_removable(struct pci_dev *dev)
> @@ -1862,7 +1862,7 @@ int pci_setup_device(struct pci_dev *dev)
>   	/* Need to have dev->cfg_size ready */
>   	set_pcie_thunderbolt(dev);
>   
> -	set_pcie_untrusted(dev);
> +	pci_set_untrusted_dma(dev);
>   
>   	/* "Unknown power state" */
>   	dev->current_state = PCI_UNKNOWN;
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 41aeaa235132..583d35968413 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5135,7 +5135,7 @@ static int pci_quirk_enable_intel_spt_pch_acs(struct pci_dev *dev)
>   	ctrl |= (cap & PCI_ACS_CR);
>   	ctrl |= (cap & PCI_ACS_UF);
>   
> -	if (pci_ats_disabled() || dev->external_facing || dev->untrusted)
> +	if (pci_ats_disabled() || dev->external_facing || dev->untrusted_dma)
>   		ctrl |= (cap & PCI_ACS_TB);
>   
>   	pci_write_config_dword(dev, pos + INTEL_SPT_ACS_CTRL, ctrl);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 60adf42460ab..2453a794bdb2 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -444,13 +444,14 @@ struct pci_dev {
>   	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>   	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
>   	/*
> -	 * Devices marked being untrusted are the ones that can potentially
> +	 * Devices marked with untrusted_dma are the ones that can potentially
>   	 * execute DMA attacks and similar. They are typically connected
>   	 * through external ports such as Thunderbolt but not limited to
>   	 * that. When an IOMMU is enabled they should be getting full
>   	 * mappings to make sure they cannot access arbitrary memory.
>   	 */
> -	unsigned int	untrusted:1;
> +	unsigned int	untrusted_dma:1;
> +
>   	/*
>   	 * Info from the platform, e.g., ACPI or device tree, may mark a
>   	 * device as "external-facing".  An external-facing device is

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Thanks,
-baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
