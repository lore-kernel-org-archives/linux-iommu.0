Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221D4C43217
	for <iommu@archiver.kernel.org>; Mon, 28 Feb 2022 19:56:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CD593403CF;
	Mon, 28 Feb 2022 19:56:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MNL8K9YNpPaw; Mon, 28 Feb 2022 19:56:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7865B40116;
	Mon, 28 Feb 2022 19:56:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59786C0077;
	Mon, 28 Feb 2022 19:56:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1554AC001A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 19:56:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0230140509
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 19:56:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aLA_A55r2KwD for <iommu@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 19:56:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C4C2E404F9
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 19:56:35 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by sin.source.kernel.org (Postfix) with ESMTPS id E1C6DCE187E;
 Mon, 28 Feb 2022 19:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E835BC340F1;
 Mon, 28 Feb 2022 19:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646078190;
 bh=0OOU4ypDKyXvi1uajjSPnUmhPXeaSTp6ukVsSrlQHcA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=RTXisNBZzA45iz5I1nD1Q49iYcdgMwiouYVpm5sJdmQu/9H3Ov4Fq04ogI46PGsIA
 oaBc37LVfwkKEZGCfFvr/j6nXxvPNIVuYPdJshypg2oWys6+aYhwo/oVHDZ0rhpKY+
 +4mXh3fKy9RPjTyNheqYMVhvd9FlT6UZqMOgAL17c9ULCYs2cORvz/yNnrsPYMQQc0
 UsPcu4z97fXmbKmf7hrkgc98uhwRfmsW9ncPZar9gWRTnnR+05/5gM/is7Mp1mvv7y
 7xb/Zt2d7+4d+67ra8MyvoYhvG1UD37XJaFlwAMYuOJcjBzVy9IrI4UHnH5VWgi1+a
 HJ04Qzzd6J+DA==
Date: Mon, 28 Feb 2022 13:56:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v7 06/11] PCI: portdrv: Set driver_managed_dma
Message-ID: <20220228195628.GA515785@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220228005056.599595-7-baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, rafael@kernel.org, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Stuart Yoder <stuyoder@gmail.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On Mon, Feb 28, 2022 at 08:50:51AM +0800, Lu Baolu wrote:
> If a switch lacks ACS P2P Request Redirect, a device below the switch can
> bypass the IOMMU and DMA directly to other devices below the switch, so
> all the downstream devices must be in the same IOMMU group as the switch
> itself.
> 
> The existing VFIO framework allows the portdrv driver to be bound to the
> bridge while its downstream devices are assigned to user space. The
> pci_dma_configure() marks the IOMMU group as containing only devices
> with kernel drivers that manage DMA. Avoid this default behavior for the
> portdrv driver in order for compatibility with the current VFIO usage.

It would be nice to explicitly say here how we can look at portdrv
(and pci_stub) and conclude that ".driver_managed_dma = true" is safe.

Otherwise I won't know what kind of future change to portdrv might
make it unsafe.

> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pcie/portdrv_pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 35eca6277a96..6b2adb678c21 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -202,6 +202,8 @@ static struct pci_driver pcie_portdriver = {
>  
>  	.err_handler	= &pcie_portdrv_err_handler,
>  
> +	.driver_managed_dma = true,
> +
>  	.driver.pm	= PCIE_PORTDRV_PM_OPS,
>  };
>  
> -- 
> 2.25.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
