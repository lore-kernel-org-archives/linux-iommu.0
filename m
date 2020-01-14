Return-Path: <SRS0=+KdK=3D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B0CC33CB1
	for <iommu@archiver.kernel.org>; Tue, 14 Jan 2020 08:51:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC1F42075B
	for <iommu@archiver.kernel.org>; Tue, 14 Jan 2020 08:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1F42075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 805DE847E5;
	Tue, 14 Jan 2020 08:51:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2tKWZaWF3Qa8; Tue, 14 Jan 2020 08:51:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1CCCC8330E;
	Tue, 14 Jan 2020 08:51:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0980DC1D83;
	Tue, 14 Jan 2020 08:51:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A7A2C077D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 08:51:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 48A1486E88
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 08:51:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5WOBhcylnh6A for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jan 2020 08:51:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EAF3586DEA
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 08:51:40 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id A23B868B20; Tue, 14 Jan 2020 09:51:38 +0100 (CET)
Date: Tue, 14 Jan 2020 09:51:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH v3 3/5] PCI: Introduce pci_direct_dma_alias()
Message-ID: <20200114085138.GC32024@lst.de>
References: <1578676873-6206-1-git-send-email-jonathan.derrick@intel.com>
 <1578676873-6206-4-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1578676873-6206-4-git-send-email-jonathan.derrick@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
 Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>, Christoph Hellwig <hch@lst.de>
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

On Fri, Jan 10, 2020 at 10:21:11AM -0700, Jon Derrick wrote:
> The current DMA alias implementation requires the aliased device be on
> the same PCI bus as the requester ID. This introduces an arch-specific
> mechanism to point to another PCI device when doing mapping and
> PCI DMA alias search.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>  arch/x86/pci/common.c |  7 +++++++
>  drivers/pci/pci.c     | 19 ++++++++++++++++++-
>  drivers/pci/search.c  |  7 +++++++
>  include/linux/pci.h   |  1 +
>  4 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index 1e59df0..83334a5 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -736,3 +736,10 @@ int pci_ext_cfg_avail(void)
>  	else
>  		return 0;
>  }
> +
> +#if IS_ENABLED(CONFIG_VMD)
> +struct pci_dev *pci_direct_dma_alias(struct pci_dev *dev)
> +{
> +	return to_pci_sysdata(dev->bus)->vmd_dev;
> +}
> +#endif
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index ad746d9..1362694 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6034,7 +6034,9 @@ bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
>  	return (dev1->dma_alias_mask &&
>  		test_bit(dev2->devfn, dev1->dma_alias_mask)) ||
>  	       (dev2->dma_alias_mask &&
> -		test_bit(dev1->devfn, dev2->dma_alias_mask));
> +		test_bit(dev1->devfn, dev2->dma_alias_mask)) ||
> +	       (pci_direct_dma_alias(dev1) == dev2) ||
> +	       (pci_direct_dma_alias(dev2) == dev1);

No need for the inner braces here.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
