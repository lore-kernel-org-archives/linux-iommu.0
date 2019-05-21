Return-Path: <SRS0=R8za=TV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5D0C04AB4
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 13:04:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7574A2182B
	for <iommu@archiver.kernel.org>; Tue, 21 May 2019 13:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="0mA1oRUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7574A2182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 32280C3F;
	Tue, 21 May 2019 13:04:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DD51DBDC
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 13:04:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C220027B
	for <iommu@lists.linux-foundation.org>;
	Tue, 21 May 2019 13:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=L/Xu0P7F2m2k6/NXaV/K5aAUVa/t1N/MPvRs3G2PoR8=;
	b=0mA1oRUyi1YJlkuM/HBI+9ud0
	ynBkK4QrRQxvnUfk1iOcI3dGO62FxGuKafy8qEsvG5qqc6dQ9i0HkmayDi97nw+sTWOpBnpOP7MIm
	FvxXuM/tKvGHqs3I448C94JO1rA4CYGy3JZgsedHTXleMGEaT4vmdg4pyNUOh54PqW4frotbW/1Vg
	9tzdiI09hlgdLhJqON6ds8kJQsBMgaB5KjmRL6Zkg/MbZ0qSbWAS1Pqv5s2nnsMMnBF2P4iJ2hYf0
	1TZeB2V60IXiXr7jMX3XBfzHh4DMiyG9xxFLdAlcnOAi/eOXurUjVqBxMnMIaEjyM5OSfHIQLbhnX
	BRxI0Xrdw==;
Received: from shell.armlinux.org.uk
	([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:55920)
	by pandora.armlinux.org.uk with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
	(envelope-from <linux@armlinux.org.uk>)
	id 1hT4Ra-0001Kc-5y; Tue, 21 May 2019 14:04:38 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1hT4RZ-0005qi-50; Tue, 21 May 2019 14:04:37 +0100
Date: Tue, 21 May 2019 14:04:37 +0100
From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/2] dma-mapping: truncate dma masks to what dma_addr_t
	can hold
Message-ID: <20190521130436.bgt53bf7nshz62ip@shell.armlinux.org.uk>
References: <20190521124729.23559-1-hch@lst.de>
	<20190521124729.23559-2-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190521124729.23559-2-hch@lst.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
	linux-kernel@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Tue, May 21, 2019 at 02:47:28PM +0200, Christoph Hellwig wrote:
> The dma masks in struct device are always 64-bits wide.  But for builds
> using a 32-bit dma_addr_t we need to ensure we don't store an
> unsupportable value.  Before Linux 5.0 this was handled at least by
> the ARM dma mapping code by never allowing to set a larger dma_mask,
> but these days we allow the driver to just set the largest supported
> value and never fall back to a smaller one.  Ensure this always works
> by truncating the value.

So how does the driver negotiation for >32bit addresses work if we don't
fail for large masks?

I'm thinking about all those PCI drivers that need DAC cycles for >32bit
addresses, such as e1000, which negotiate via (eg):

        /* there is a workaround being applied below that limits
         * 64-bit DMA addresses to 64-bit hardware.  There are some
         * 32-bit adapters that Tx hang when given 64-bit DMA addresses
         */
        pci_using_dac = 0;
        if ((hw->bus_type == e1000_bus_type_pcix) &&
            !dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
                pci_using_dac = 1;
        } else {
                err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
                if (err) {
                        pr_err("No usable DMA config, aborting\n");
                        goto err_dma;
                }
        }

and similar.  If we blindly trunate the 64-bit to 32-bit, aren't we
going to end up with PCI cards using DAC cycles to a host bridge that
do not support DAC cycles?

> 
> Fixes: 9eb9e96e97b3 ("Documentation/DMA-API-HOWTO: update dma_mask sections")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/mapping.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index f7afdadb6770..1f628e7ac709 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -317,6 +317,12 @@ void arch_dma_set_mask(struct device *dev, u64 mask);
>  
>  int dma_set_mask(struct device *dev, u64 mask)
>  {
> +	/*
> +	 * Truncate the mask to the actually supported dma_addr_t width to
> +	 * avoid generating unsupportable addresses.
> +	 */
> +	mask = (dma_addr_t)mask;
> +
>  	if (!dev->dma_mask || !dma_supported(dev, mask))
>  		return -EIO;
>  
> @@ -330,6 +336,12 @@ EXPORT_SYMBOL(dma_set_mask);
>  #ifndef CONFIG_ARCH_HAS_DMA_SET_COHERENT_MASK
>  int dma_set_coherent_mask(struct device *dev, u64 mask)
>  {
> +	/*
> +	 * Truncate the mask to the actually supported dma_addr_t width to
> +	 * avoid generating unsupportable addresses.
> +	 */
> +	mask = (dma_addr_t)mask;
> +
>  	if (!dma_supported(dev, mask))
>  		return -EIO;
>  
> -- 
> 2.20.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
