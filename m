Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14ED4C4332F
	for <iommu@archiver.kernel.org>; Mon, 28 Feb 2022 19:54:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A7B8B405DF;
	Mon, 28 Feb 2022 19:54:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ljph7CYW2jEd; Mon, 28 Feb 2022 19:54:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 145FF40116;
	Mon, 28 Feb 2022 19:54:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D74DCC0077;
	Mon, 28 Feb 2022 19:54:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7642CC001A
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 19:54:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 70882814B6
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 19:54:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LPQqwlGxtwFR for <iommu@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 19:54:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F61681433
 for <iommu@lists.linux-foundation.org>; Mon, 28 Feb 2022 19:54:21 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5A55560A57;
 Mon, 28 Feb 2022 19:54:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAD7C340F1;
 Mon, 28 Feb 2022 19:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646078059;
 bh=ONxRshZXU9sTf+2igTSe3xpdN1ybB8ozak/Pf50aaAw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=FQdVqA8T/y015/V6feFrGYtnl9N3bso2NN5eZ+xCOfi7Adw4x0bBZLjivwfnQ+Hnj
 XBKOAdDLk6HXa3gmIN+uyEXJ+PyCDCBcPc4eDzgQUVTcZMsFZiGH3EaE/y9r2Eghhn
 PdNvBu2OiFERxMOjWVBnhgney/Wk3CrpR8P6MqNG/YtyOoevR6JE5V4eaTwd/X2/Y6
 Q813ZsuDZSZxkXD3VFLyqpsRh54rXV5y3kFSAbiUyTHmXRkJprv4A6LDBPxTuhwQm7
 1bOzd9JpS/g7xCmxQfZH9v/ZcfHUgwJ6ExQWA0SwndMqlfAxAEsIUt5U0B7v0xOSY8
 GTD/XZl2dRNAQ==
Date: Mon, 28 Feb 2022 13:54:18 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v7 05/11] PCI: pci_stub: Set driver_managed_dma
Message-ID: <20220228195418.GA515725@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220228005056.599595-6-baolu.lu@linux.intel.com>
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

On Mon, Feb 28, 2022 at 08:50:50AM +0800, Lu Baolu wrote:
> The current VFIO implementation allows pci-stub driver to be bound to
> a PCI device with other devices in the same IOMMU group being assigned
> to userspace. The pci-stub driver has no dependencies on DMA or the
> IOVA mapping of the device, but it does prevent the user from having
> direct access to the device, which is useful in some circumstances.
> 
> The pci_dma_configure() marks the iommu_group as containing only devices
> with kernel drivers that manage DMA. For compatibility with the VFIO
> usage, avoid this default behavior for the pci_stub. This allows the
> pci_stub still able to be used by the admin to block driver binding after
> applying the DMA ownership to VFIO.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci-stub.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
> index e408099fea52..d1f4c1ce7bd1 100644
> --- a/drivers/pci/pci-stub.c
> +++ b/drivers/pci/pci-stub.c
> @@ -36,6 +36,7 @@ static struct pci_driver stub_driver = {
>  	.name		= "pci-stub",
>  	.id_table	= NULL,	/* only dynamic id's */
>  	.probe		= pci_stub_probe,
> +	.driver_managed_dma = true,
>  };
>  
>  static int __init pci_stub_init(void)
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
