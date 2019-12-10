Return-Path: <SRS0=4E9V=2A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810E6C00454
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 22:31:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4878920838
	for <iommu@archiver.kernel.org>; Tue, 10 Dec 2019 22:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx/aoNNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4878920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2A266884DF;
	Tue, 10 Dec 2019 22:31:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Rw3zZ1ezu2dA; Tue, 10 Dec 2019 22:31:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 888A2884D7;
	Tue, 10 Dec 2019 22:31:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78B7EC1796;
	Tue, 10 Dec 2019 22:31:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D02D5C0881
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 22:31:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id BC2AB86D89
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 22:31:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vsSBH021dMYz for <iommu@lists.linux-foundation.org>;
 Tue, 10 Dec 2019 22:31:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2A1B186786
 for <iommu@lists.linux-foundation.org>; Tue, 10 Dec 2019 22:31:50 +0000 (UTC)
Received: from localhost (mobile-166-170-223-177.mycingular.net
 [166.170.223.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9EDE5206EC;
 Tue, 10 Dec 2019 22:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576017110;
 bh=OWeDD1ggaI7KtD7dXyfUWEhw8ibkokJLLFnshu+t8Bs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=jx/aoNNd4yeJQOJni2d8Jm2bVglXRvoz4EFeLcuMkv+4rwBBQgDPc8e0091THiWqv
 ByDPON5LbCRk5pfsGKnre0V6A3u0AVAS3HCh4SvEgK46AtHn1Lj4VDYvmleLkrwvjW
 e7Rs9VJEMWlZSW72/q1C36bfYYi7lcjJcJDvAF2c=
Date: Tue, 10 Dec 2019 16:31:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: James Sewart <jamessewart@arista.com>
Subject: Re: [PATCH v6 1/3] PCI: Fix off by one in dma_alias_mask allocation
 size
Message-ID: <20191210223148.GA166696@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <910070E3-7964-4549-B77F-EC7FC6144503@arista.com>
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

On Tue, Dec 03, 2019 at 03:43:22PM +0000, James Sewart wrote:
> The number of possible devfns is 256, add def and correct uses.
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: James Sewart <jamessewart@arista.com>

I applied these three patches to pci/virtualization for v5.6, thanks!

I moved the MAX_NR_DEVFNS from include/linux/pci.h to
drivers/pci/pci.h since nobody outside drivers/pci needs it.

> ---
>  drivers/pci/pci.c    | 2 +-
>  drivers/pci/search.c | 2 +-
>  include/linux/pci.h  | 2 ++
>  3 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a97e2571a527..d3c83248f3ce 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5876,7 +5876,7 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>  void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
>  {
>  	if (!dev->dma_alias_mask)
> -		dev->dma_alias_mask = bitmap_zalloc(U8_MAX, GFP_KERNEL);
> +		dev->dma_alias_mask = bitmap_zalloc(MAX_NR_DEVFNS, GFP_KERNEL);
>  	if (!dev->dma_alias_mask) {
>  		pci_warn(dev, "Unable to allocate DMA alias mask\n");
>  		return;
> diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> index bade14002fd8..9e4dfae47252 100644
> --- a/drivers/pci/search.c
> +++ b/drivers/pci/search.c
> @@ -43,7 +43,7 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
>  	if (unlikely(pdev->dma_alias_mask)) {
>  		u8 devfn;
>  
> -		for_each_set_bit(devfn, pdev->dma_alias_mask, U8_MAX) {
> +		for_each_set_bit(devfn, pdev->dma_alias_mask, MAX_NR_DEVFNS) {
>  			ret = fn(pdev, PCI_DEVID(pdev->bus->number, devfn),
>  				 data);
>  			if (ret)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1a6cf19eac2d..6481da29d667 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -57,6 +57,8 @@
>  #define PCI_DEVID(bus, devfn)	((((u16)(bus)) << 8) | (devfn))
>  /* return bus from PCI devid = ((u16)bus_number) << 8) | devfn */
>  #define PCI_BUS_NUM(x) (((x) >> 8) & 0xff)
> +/* Number of possible devfns. devfns can be from 0.0 to 1f.7 inclusive */
> +#define MAX_NR_DEVFNS 256
>  
>  /* pci_slot represents a physical slot */
>  struct pci_slot {
> -- 
> 2.24.0
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
