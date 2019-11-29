Return-Path: <SRS0=o1xy=ZV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9576AC432C0
	for <iommu@archiver.kernel.org>; Fri, 29 Nov 2019 16:51:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C0A9208E4
	for <iommu@archiver.kernel.org>; Fri, 29 Nov 2019 16:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0A9208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1D99A87E92;
	Fri, 29 Nov 2019 16:51:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PsX5YpTBi46X; Fri, 29 Nov 2019 16:51:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 02B5E87CBE;
	Fri, 29 Nov 2019 16:51:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7B09C1DD5;
	Fri, 29 Nov 2019 16:51:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53689C0881
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 16:51:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3C4E586C24
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 16:51:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7ywBem8lT1Th for <iommu@lists.linux-foundation.org>;
 Fri, 29 Nov 2019 16:50:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from ale.deltatee.com (ale.deltatee.com [207.54.116.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B08A886AB5
 for <iommu@lists.linux-foundation.org>; Fri, 29 Nov 2019 16:50:18 +0000 (UTC)
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230]
 helo=[192.168.11.155])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1iajTD-0007PZ-KQ; Fri, 29 Nov 2019 09:50:16 -0700
To: James Sewart <jamessewart@arista.com>, linux-pci@vger.kernel.org
References: <20191120193228.GA103670@google.com>
 <6A902F0D-FE98-4760-ADBB-4D5987D866BE@arista.com>
 <20191126173833.GA16069@infradead.org>
 <547214A9-9FD0-4DD5-80E1-1F5A467A0913@arista.com>
 <9c54c5dd-702c-a19b-38ba-55ab73b24729@deltatee.com>
 <435064D4-00F0-47F5-94D2-2C354F6B1206@arista.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <058383d9-69fe-65e3-e410-eebd99840261@deltatee.com>
Date: Fri, 29 Nov 2019 09:50:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <435064D4-00F0-47F5-94D2-2C354F6B1206@arista.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: helgaas@kernel.org, alex.williamson@redhat.com,
 dima@arista.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, 0x7f454c46@gmail.com, hch@infradead.org,
 linux-pci@vger.kernel.org, jamessewart@arista.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v4 1/2] PCI: Add parameter nr_devfns to pci_add_dma_alias
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Cc: Dmitry Safonov <dima@arista.com>, Dmitry Safonov <0x7f454c46@gmail.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>
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



On 2019-11-29 5:49 a.m., James Sewart wrote:
> pci_add_dma_alias can now be used to create a dma alias for a range of
> devfns.
> 
> Signed-off-by: James Sewart <jamessewart@arista.com>
> ---
>  drivers/pci/pci.c    | 23 ++++++++++++++++++-----
>  drivers/pci/quirks.c | 14 +++++++-------
>  include/linux/pci.h  |  2 +-
>  3 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a97e2571a527..9b0e3481fe17 100644
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
> @@ -5873,8 +5874,14 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>   * cannot be left as a userspace activity).  DMA aliases should therefore
>   * be configured via quirks, such as the PCI fixup header quirk.
>   */
> -void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
> +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned nr_devfns)
>  {
> +	int devfn_to;
> +
> +	if (nr_devfns > U8_MAX+1)
> +		nr_devfns = U8_MAX+1;

Why +1? That doesn't seem right to me....

> +	devfn_to = devfn_from + nr_devfns - 1;
> +
>  	if (!dev->dma_alias_mask)
>  		dev->dma_alias_mask = bitmap_zalloc(U8_MAX, GFP_KERNEL);
>  	if (!dev->dma_alias_mask) {
> @@ -5882,9 +5889,15 @@ void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
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
>  
>  bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2)
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 320255e5e8f8..0f3f5afc73fd 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3932,7 +3932,7 @@ int pci_dev_specific_reset(struct pci_dev *dev, int probe)
>  static void quirk_dma_func0_alias(struct pci_dev *dev)
>  {
>  	if (PCI_FUNC(dev->devfn) != 0)
> -		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
> +		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 0), 1);
>  }
>  
>  /*
> @@ -3946,7 +3946,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_RICOH, 0xe476, quirk_dma_func0_alias);
>  static void quirk_dma_func1_alias(struct pci_dev *dev)
>  {
>  	if (PCI_FUNC(dev->devfn) != 1)
> -		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 1));
> +		pci_add_dma_alias(dev, PCI_DEVFN(PCI_SLOT(dev->devfn), 1), 1);
>  }
>  
>  /*
> @@ -4031,7 +4031,7 @@ static void quirk_fixed_dma_alias(struct pci_dev *dev)
>  
>  	id = pci_match_id(fixed_dma_alias_tbl, dev);
>  	if (id)
> -		pci_add_dma_alias(dev, id->driver_data);
> +		pci_add_dma_alias(dev, id->driver_data, 1);
>  }
>  
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ADAPTEC2, 0x0285, quirk_fixed_dma_alias);
> @@ -4073,9 +4073,9 @@ DECLARE_PCI_FIXUP_HEADER(0x8086, 0x244e, quirk_use_pcie_bridge_dma_alias);
>   */
>  static void quirk_mic_x200_dma_alias(struct pci_dev *pdev)
>  {
> -	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0));
> -	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0));
> -	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3));
> +	pci_add_dma_alias(pdev, PCI_DEVFN(0x10, 0x0), 1);
> +	pci_add_dma_alias(pdev, PCI_DEVFN(0x11, 0x0), 1);
> +	pci_add_dma_alias(pdev, PCI_DEVFN(0x12, 0x3), 1);
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2260, quirk_mic_x200_dma_alias);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x2264, quirk_mic_x200_dma_alias);
> @@ -5273,7 +5273,7 @@ static void quirk_switchtec_ntb_dma_alias(struct pci_dev *pdev)
>  			pci_dbg(pdev,
>  				"Aliasing Partition %d Proxy ID %02x.%d\n",
>  				pp, PCI_SLOT(devfn), PCI_FUNC(devfn));
> -			pci_add_dma_alias(pdev, devfn);
> +			pci_add_dma_alias(pdev, devfn, 1);
>  		}
>  	}
>  
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 1a6cf19eac2d..84a8d4c2b24e 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2323,7 +2323,7 @@ static inline struct eeh_dev *pci_dev_to_eeh_dev(struct pci_dev *pdev)
>  }
>  #endif
>  
> -void pci_add_dma_alias(struct pci_dev *dev, u8 devfn);
> +void pci_add_dma_alias(struct pci_dev *dev, u8 devfn_from, unsigned nr_devfns);
>  bool pci_devs_are_dma_aliases(struct pci_dev *dev1, struct pci_dev *dev2);
>  int pci_for_each_dma_alias(struct pci_dev *pdev,
>  			   int (*fn)(struct pci_dev *pdev,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
