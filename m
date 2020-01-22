Return-Path: <SRS0=k9Qp=3L=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37213C32771
	for <iommu@archiver.kernel.org>; Wed, 22 Jan 2020 21:13:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB84F24673
	for <iommu@archiver.kernel.org>; Wed, 22 Jan 2020 21:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hr15TIge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB84F24673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A4A5086239;
	Wed, 22 Jan 2020 21:13:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ar704Dt5t7H6; Wed, 22 Jan 2020 21:13:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 064BC86234;
	Wed, 22 Jan 2020 21:13:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE450C1796;
	Wed, 22 Jan 2020 21:13:04 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D0B1C0174
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 21:13:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 46EAF86239
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 21:13:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eAEoYnco9MCa for <iommu@lists.linux-foundation.org>;
 Wed, 22 Jan 2020 21:13:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 1B2CB86234
 for <iommu@lists.linux-foundation.org>; Wed, 22 Jan 2020 21:13:02 +0000 (UTC)
Received: from localhost (mobile-166-175-186-165.mycingular.net
 [166.175.186.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 62EC52465B;
 Wed, 22 Jan 2020 21:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579727581;
 bh=fFweYeenFvs4HkuADNdVlhMAmdzgO7l02edUze2SN3M=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=hr15TIgenBSUenmaLItA1B+GdJ/AEhGWjr6P+Sgz4A9BmG6msd+dAgWMMi0bablaF
 qQ1XQE8RAWxBNy9t89QA0PGBgOppc6DhSiqxQNVVsJjUGoJMK7MDVTK5BNg3W68hmS
 a94emKuOhZI2Me8cFNwwFUbeLsSBMfMHUZdg+mAI=
Date: Wed, 22 Jan 2020 15:12:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH v5 3/7] PCI: Introduce pci_real_dma_dev()
Message-ID: <20200122211259.GA19172@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1579613871-301529-4-git-send-email-jonathan.derrick@intel.com>
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

On Tue, Jan 21, 2020 at 06:37:47AM -0700, Jon Derrick wrote:
> The current DMA alias implementation requires the aliased device be on
> the same PCI bus as the requester ID. This introduces an arch-specific
> mechanism to point to another PCI device when doing mapping and
> PCI DMA alias search. The default case returns the actual device.
> 
> CC: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Looks like a nice cleanup to me.

Lorenzo, let me know if you want me to take this.

> ---
>  arch/x86/pci/common.c | 10 ++++++++++
>  drivers/pci/pci.c     | 19 ++++++++++++++++++-
>  drivers/pci/search.c  |  6 ++++++
>  include/linux/pci.h   |  1 +
>  4 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 1e59df0..fe21a5c 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -736,3 +736,13 @@ int pci_ext_cfg_avail(void)
>  	else
>  		return 0;
>  }
> +
> +#if IS_ENABLED(CONFIG_VMD)
> +struct pci_dev *pci_real_dma_dev(struct pci_dev *dev)
> +{
> +	if (is_vmd(dev->bus))
> +		return to_pci_sysdata(dev->bus)->vmd_dev;
> +
> +	return dev;
> +}
> +#endif
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 581b177..36d24f2 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6048,7 +6048,9 @@ bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
>  	return (dev1->dma_alias_mask &&
>  		test_bit(dev2->devfn, dev1->dma_alias_mask)) ||
>  	       (dev2->dma_alias_mask &&
> -		test_bit(dev1->devfn, dev2->dma_alias_mask));
> +		test_bit(dev1->devfn, dev2->dma_alias_mask)) ||
> +	       pci_real_dma_dev(dev1) == dev2 ||
> +	       pci_real_dma_dev(dev2) == dev1;
>  }
>  
>  bool pci_device_is_present(struct pci_dev *pdev)
> @@ -6072,6 +6074,21 @@ void pci_ignore_hotplug(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_ignore_hotplug);
>  
> +/**
> + * pci_real_dma_dev - Get PCI DMA device for PCI device
> + * @dev: the PCI device that may have a PCI DMA alias
> + *
> + * Permits the platform to provide architecture-specific functionality to
> + * devices needing to alias DMA to another PCI device on another PCI bus. If
> + * the PCI device is on the same bus, it is recommended to use
> + * pci_add_dma_alias(). This is the default implementation. Architecture
> + * implementations can override this.
> + */
> +struct pci_dev __weak *pci_real_dma_dev(struct pci_dev *dev)
> +{
> +	return dev;
> +}
> +
>  resource_size_t __weak pcibios_default_alignment(void)
>  {
>  	return 0;
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index e4dbdef..2061672 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -32,6 +32,12 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
>  	struct pci_bus *bus;
>  	int ret;
>  
> +	/*
> +	 * The device may have an explicit alias requester ID for DMA where the
> +	 * requester is on another PCI bus.
> +	 */
> +	pdev = pci_real_dma_dev(pdev);
>  	ret = fn(pdev, pci_dev_id(pdev), data);
>  	if (ret)
>  		return ret;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 930fab2..3840a54 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1202,6 +1202,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>  int pci_select_bars(struct pci_dev *dev, unsigned long flags);
>  bool pci_device_is_present(struct pci_dev *pdev);
>  void pci_ignore_hotplug(struct pci_dev *dev);
> +struct pci_dev *pci_real_dma_dev(struct pci_dev *dev);
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
