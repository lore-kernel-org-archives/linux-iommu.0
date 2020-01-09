Return-Path: <SRS0=4b30=26=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EB8C282DD
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 23:11:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D524020656
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 23:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvWR4qyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D524020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DD6BC86AB5;
	Thu,  9 Jan 2020 23:11:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l1ODXSZFV0Dy; Thu,  9 Jan 2020 23:11:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DABAE86AAE;
	Thu,  9 Jan 2020 23:11:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF979C1796;
	Thu,  9 Jan 2020 23:11:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4131FC0881
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 23:11:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 38B6586C82
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 23:11:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r7IPrl7sJpUW for <iommu@lists.linux-foundation.org>;
 Thu,  9 Jan 2020 23:11:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6CCA58567A
 for <iommu@lists.linux-foundation.org>; Thu,  9 Jan 2020 23:11:43 +0000 (UTC)
Received: from localhost (mobile-166-170-223-177.mycingular.net
 [166.170.223.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E04C22073A;
 Thu,  9 Jan 2020 23:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578611503;
 bh=dhPLAlyVcnx4/SDqpz6V/KM2GWr4mIZ3arCcmlZBD14=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=tvWR4qyiWV0MqUDef2PBNapevfkoIbFPg7BPm9xBxDNCP81sqJYBhw+OV2unLD377
 0+ENfwOSwat8qiFfMjRKhcl2smTZuE7b6Ub3cdXDzW/0FdEOMb7Ah3cR85F1wbQQRp
 Mm+HkkztNXtfss+ZexcW3Ib4aPs++lfL7m7iY3iI=
Date: Thu, 9 Jan 2020 17:11:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH v2 3/5] PCI: Introduce direct dma alias
Message-ID: <20200109231141.GA41540@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1578580256-3483-4-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
 Keith Busch <kbusch@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Christoph Hellwig <hch@lst.de>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

In subject:
s/Introduce direct dma alias/Add pci_direct_dma_alias()/

On Thu, Jan 09, 2020 at 07:30:54AM -0700, Jon Derrick wrote:
> The current dma alias implementation requires the aliased device be on
> the same bus as the dma parent. This introduces an arch-specific
> mechanism to point to an arbitrary struct device when doing mapping and
> pci alias search.

"arbitrary struct device" is a little weird since an arbitrary device
doesn't have to be a PCI device, but these mappings and aliases only
make sense in the PCI domain.

Maybe it has something to do with pci_sysdata.vmd_dev being a
"struct device *" rather than a "struct pci_dev *"?  I don't know why
that is, because it looks like every place you use it, you use
to_pci_dev() to get the pci_dev pointer back anyway.  But I assume you
have some good reason for that.

s/dma/DMA/
s/pci/PCI/
(above and also in code comments below)

> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  arch/x86/pci/common.c |  7 +++++++
>  drivers/pci/pci.c     | 17 ++++++++++++++++-
>  drivers/pci/search.c  |  9 +++++++++
>  include/linux/pci.h   |  1 +
>  4 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 1e59df0..565cc17 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -736,3 +736,10 @@ int pci_ext_cfg_avail(void)
>  	else
>  		return 0;
>  }
> +
> +#if IS_ENABLED(CONFIG_VMD)
> +struct device *pci_direct_dma_alias(struct pci_dev *dev)
> +{
> +	return to_pci_sysdata(dev->bus)->vmd_dev;
> +}
> +#endif
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ad746d9..e4269e9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6034,7 +6034,9 @@ bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
>  	return (dev1->dma_alias_mask &&
>  		test_bit(dev2->devfn, dev1->dma_alias_mask)) ||
>  	       (dev2->dma_alias_mask &&
> -		test_bit(dev1->devfn, dev2->dma_alias_mask));
> +		test_bit(dev1->devfn, dev2->dma_alias_mask)) ||
> +	       (pci_direct_dma_alias(dev1) == &dev2->dev) ||
> +	       (pci_direct_dma_alias(dev2) == &dev1->dev);
>  }
>  
>  bool pci_device_is_present(struct pci_dev *pdev)
> @@ -6058,6 +6060,19 @@ void pci_ignore_hotplug(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_ignore_hotplug);
>  
> +/**
> + * pci_direct_dma_alias - Get dma alias for pci device
> + * @dev: the PCI device that may have a dma alias
> + *
> + * Permits the platform to provide architecture-specific functionality to
> + * devices needing to alias dma to another device. This is the default
> + * implementation. Architecture implementations can override this.
> + */
> +struct device __weak *pci_direct_dma_alias(struct pci_dev *dev)
> +{
> +	return NULL;
> +}
> +
>  resource_size_t __weak pcibios_default_alignment(void)
>  {
>  	return 0;
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index bade140..6d61209 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -32,6 +32,15 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
>  	struct pci_bus *bus;
>  	int ret;
>  
> +	if (unlikely(pci_direct_dma_alias(pdev))) {
> +		struct device *dev = pci_direct_dma_alias(pdev);
> +
> +		if (dev_is_pci(dev))
> +			pdev = to_pci_dev(dev);
> +		return fn(pdev, PCI_DEVID(pdev->bus->number, pdev->devfn),
> +			  data);
> +	}
> +
>  	ret = fn(pdev, pci_dev_id(pdev), data);
>  	if (ret)
>  		return ret;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c393dff..82494d3 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1202,6 +1202,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>  int pci_select_bars(struct pci_dev *dev, unsigned long flags);
>  bool pci_device_is_present(struct pci_dev *pdev);
>  void pci_ignore_hotplug(struct pci_dev *dev);
> +struct device *pci_direct_dma_alias(struct pci_dev *dev);
>  
>  int __printf(6, 7) pci_request_irq(struct pci_dev *dev, unsigned int nr,
>  		irq_handler_t handler, irq_handler_t thread_fn, void *dev_id,
> -- 
> 1.8.3.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
