Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34EFC433EF
	for <iommu@archiver.kernel.org>; Wed, 23 Feb 2022 18:01:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A02F2828E3;
	Wed, 23 Feb 2022 18:01:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ubwJZmi2DbWn; Wed, 23 Feb 2022 18:01:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6DF43828DA;
	Wed, 23 Feb 2022 18:01:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F942C001A;
	Wed, 23 Feb 2022 18:01:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B78A2C0011
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 18:01:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A4503408EA
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 18:01:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y9n07a50F36Z for <iommu@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 18:01:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E710B408E6
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 18:00:59 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B2D8B615BB;
 Wed, 23 Feb 2022 18:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49542C340E7;
 Wed, 23 Feb 2022 18:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645639258;
 bh=MKgM7o1ruy/HHVrV8jzkBEnkhlTNGQHGNcPOUmal/Q8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=Dn9BdjkvSFawU2lRdlkhhaSUHY0lCFtqhfLoKAK0O5Q6lp8y32dKlD7/1KueDIBVC
 2smUZEzG53JpiSnGMJ5sz0cYdkxfejWfGkoiEkmSkV2eEkwFtRel2evULq9t0gm/km
 /5KDF/pJP3ThdwCXxRAy3z8ZIpxrAvwaovzYBRkJ37rWa8Iaayi9FBz9pttnDrdMIJ
 rFgDagq7fBLz5dnl1Y0h8s9pZtEuUTRHFDkfWFwk+fNNFWxCVL6bwa+72WYubKLSE7
 mGAWO5e+SRHCPaNEKctvp7KtwZoO1w8nqoHA96iW90gagwxbfWorKsET1bawbW4lR3
 5r0Uhb1e3kvzA==
Date: Wed, 23 Feb 2022 12:00:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 07/14] PCI: Add driver dma ownership management
Message-ID: <20220223180056.GA140951@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220104015644.2294354-8-baolu.lu@linux.intel.com>
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

In subject,

s/dma/DMA/ to match the other patches

On Tue, Jan 04, 2022 at 09:56:37AM +0800, Lu Baolu wrote:
> Multiple PCI devices may be placed in the same IOMMU group because
> they cannot be isolated from each other. These devices must either be
> entirely under kernel control or userspace control, never a mixture. This
> checks and sets DMA ownership during driver binding, and release the
> ownership during driver unbinding.
> 
> The device driver may set a new flag (no_kernel_api_dma) to skip calling
> iommu_device_use_dma_api() during the binding process. For instance, the
> userspace framework drivers (vfio etc.) which need to manually claim
> their own dma ownership when assigning the device to userspace.

s/vfio/VFIO/ when used as an acronym (occurs in several patches)

> + * @no_kernel_api_dma: Device driver doesn't use kernel DMA API for DMA.
> + *		Drivers which don't require DMA or want to manually claim the
> + *		owner type (e.g. userspace driver frameworks) could set this
> + *		flag.

s/Drivers which/Drivers that/

>  static int pci_dma_configure(struct device *dev)
>  {
> +	struct pci_driver *driver = to_pci_driver(dev->driver);
>  	struct device *bridge;
>  	int ret = 0;
>  
> +	if (!driver->no_kernel_api_dma) {

Ugh.  Double negative, totally agree this needs a better name that
reverses the sense.  Every place you use it, you negate it again.

> +	if (ret && !driver->no_kernel_api_dma)
> +		iommu_device_unuse_dma_api(dev);

> +static void pci_dma_cleanup(struct device *dev)
> +{
> +	struct pci_driver *driver = to_pci_driver(dev->driver);
> +
> +	if (!driver->no_kernel_api_dma)
> +		iommu_device_unuse_dma_api(dev);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
