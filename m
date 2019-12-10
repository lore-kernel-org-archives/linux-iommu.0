Return-Path: <SRS0=4E9V=2A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46573C43603
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 22:37:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E7E22077B
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 22:37:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpF77bDR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E7E22077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E4F5E22851;
	Tue, 10 Dec 2019 22:37:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xg81JT3R2VJy; Tue, 10 Dec 2019 22:37:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E20C32283C;
	Tue, 10 Dec 2019 22:37:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D360DC1796;
	Tue, 10 Dec 2019 22:37:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E3AEC0881
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 22:37:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 0BC2D22851
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 22:37:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A6p9oxX-3kUJ for <iommu@lists.linux-foundation.org>;
 Tue, 10 Dec 2019 22:37:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 40C972283C
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 22:37:47 +0000 (UTC)
Received: from localhost (mobile-166-170-223-177.mycingular.net
 [166.170.223.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B6617214D8;
 Tue, 10 Dec 2019 22:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576017467;
 bh=pmltaW9LsjEuTpeKbuA3I4m6I9tXYKuy+WxPnOiBySg=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=GpF77bDRMYOZMzZUsc1xfZBNt0grHZ4wf9ahTXpwyB/3gWFtElsyCOKqPj3U1bJFM
 F12G87CHzuPAb/bUPdSWsiVx1FaP+i8FGPXzpLIMlG9rGYgTSbaTbyG8VW14eyc8d+
 yP9jUwAsNzCNQ3sJ/NVKANDpE4MxAYItUWmqRpYM=
Date: Tue, 10 Dec 2019 16:37:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: James Sewart <jamessewart@arista.com>
Subject: Re: [PATCH v6 2/3] PCI: Add parameter nr_devfns to pci_add_dma_alias
Message-ID: <20191210223745.GA167002@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D4C7374E-4DFE-4024-8E76-9F54BF421B62@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Dmitry Safonov <dima@arista.com>, linux-pci@vger.kernel.org,
 Dmitry Safonov <0x7f454c46@gmail.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Logan Gunthorpe <logang@deltatee.com>
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

[+cc Joerg]

On Tue, Dec 03, 2019 at 03:43:53PM +0000, James Sewart wrote:
> pci_add_dma_alias can now be used to create a dma alias for a range of
> devfns.
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: James Sewart <jamessewart@arista.com>
> ---
>  drivers/pci/pci.c    | 22 +++++++++++++++++-----
>  drivers/pci/quirks.c | 14 +++++++-------
>  include/linux/pci.h  |  2 +-
>  3 files changed, 25 insertions(+), 13 deletions(-)

Heads up Joerg: I also updated drivers/iommu/amd_iommu.c (this is the
one reported by the kbuild test robot) and removed the printk there
that prints the same thing as the one in pci_add_dma_alias(), and I
updated a PCI quirk that was merged after this patch was posted.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d3c83248f3ce..dbb01aceafda 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5857,7 +5857,8 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>  /**
>   * pci_add_dma_alias - Add a DMA devfn alias for a device
>   * @dev: the PCI device for which alias is added
> - * @devfn: alias slot and function
> + * @devfn_from: alias slot and function
> + * @nr_devfns: Number of subsequent devfns to alias
>   *
>   * This helper encodes an 8-bit devfn as a bit number in dma_alias_mask
>   * which is used to program permissible bus-devfn source addresses for DMA
> @@ -5873,8 +5874,13 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>   * cannot be left as a userspace activity).  DMA aliases should therefore
>   * be configured via quirks, such as the PCI fixup header quirk.
>   */
> -void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
> +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned nr_devfns)
>  {
> +	int devfn_to;
> +
> +	nr_devfns = min(nr_devfns, (unsigned)MAX_NR_DEVFNS);
> +	devfn_to = devfn_from + nr_devfns - 1;

I made this look like:

+       devfn_to = min(devfn_from + nr_devfns - 1,
+                      (unsigned) MAX_NR_DEVFNS - 1);

so devfn_from=0xf0, nr_devfns=0x20 doesn't cause devfn_to to wrap
around.

I did keep Logan's reviewed-by, so let me know if I broke something.

>  	if (!dev->dma_alias_mask)
>  		dev->dma_alias_mask = bitmap_zalloc(MAX_NR_DEVFNS, GFP_KERNEL);
>  	if (!dev->dma_alias_mask) {
> @@ -5882,9 +5888,15 @@ void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
>  		return;
>  	}
>  
> -	set_bit(devfn, dev->dma_alias_mask);
> -	pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
> -		 PCI_SLOT(devfn), PCI_FUNC(devfn));
> +	bitmap_set(dev->dma_alias_mask, devfn_from, nr_devfns);
> +
> +	if (nr_devfns == 1)
> +		pci_info(dev, "Enabling fixed DMA alias to %02x.%d\n",
> +				PCI_SLOT(devfn_from), PCI_FUNC(devfn_from));
> +	else if(nr_devfns > 1)
> +		pci_info(dev, "Enabling fixed DMA alias for devfn range from %02x.%d to %02x.%d\n",
> +				PCI_SLOT(devfn_from), PCI_FUNC(devfn_from),
> +				PCI_SLOT(devfn_to), PCI_FUNC(devfn_to));
>  }
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
