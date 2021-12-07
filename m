Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8D4C433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 21:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E3CBA40955;
	Tue,  7 Dec 2021 21:03:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2fEs0qZ4phOM; Tue,  7 Dec 2021 21:03:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AFA0440958;
	Tue,  7 Dec 2021 21:03:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72245C002F;
	Tue,  7 Dec 2021 21:03:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7497C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 21:03:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A9A3840958
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 21:03:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sugjP1dcGIK0 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 21:03:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3993C40955
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 21:03:51 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 644DEB81E83;
 Tue,  7 Dec 2021 21:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3146C341C3;
 Tue,  7 Dec 2021 21:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638911027;
 bh=vdg+fdIoCSHr3OuhnQ0WRPeCcsFTBIQTTd4u0ji8WKw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=BWMnoqb5zI+AmfRiWx3hI7UPFSjiK/sP2RxrS/8pFSfaQGXzC3HU5dj9jSSkTmxbf
 ycQhxHGG+Fcj7qVvDrSdgVJzP+m2Fjh741SbIXpMXFhrEEquIdcMBPdXl+aCsQmDEI
 3zeK6GYY3etemeN1yu/6VsPnz0YoMH8zSdcDzIsPZqnlh4gHq48kIVDNWK7rfFTy1S
 gUW/xdBLJLcAxyL2Qhdnp0jAybfRKhRZLoNsDlD33Kr8AWcXVe4iBXGW98+dAzo2jz
 rnorth7z8Yvh3+kr56v1pmkD4iYXulFwuR50cFJdivxqVn0FvmmJNz1QRCJTf0dRQk
 vTu+UFqcSYVkw==
Date: Tue, 7 Dec 2021 15:03:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 03/36] PCI/MSI: Allocate MSI device data on first use
Message-ID: <20211207210345.GA77648@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211206210437.821900680@linutronix.de>
Cc: Nishanth Menon <nm@ti.com>, Mark Rutland <mark.rutland@arm.com>,
 Stuart Yoder <stuyoder@gmail.com>, linux-pci@vger.kernel.org,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Marc Zygnier <maz@kernel.org>, Sinan Kaya <okaya@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Megha Dey <megha.dey@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, xen-devel@lists.xenproject.org,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater <clg@kaod.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Juergen Gross <jgross@suse.com>, Tero Kristo <kristo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 dmaengine@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
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

On Mon, Dec 06, 2021 at 11:39:00PM +0100, Thomas Gleixner wrote:
> Allocate MSI device data on first use, i.e. when a PCI driver invokes one
> of the PCI/MSI enablement functions.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/msi.c |   20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -889,10 +889,12 @@ static int __pci_enable_msi_range(struct
>  /* deprecated, don't use */
>  int pci_enable_msi(struct pci_dev *dev)
>  {
> -	int rc = __pci_enable_msi_range(dev, 1, 1, NULL);
> -	if (rc < 0)
> -		return rc;
> -	return 0;
> +	int rc = msi_setup_device_data(&dev->dev);
> +
> +	if (!rc)
> +		rc = __pci_enable_msi_range(dev, 1, 1, NULL);
> +
> +	return rc < 0 ? rc : 0;
>  }
>  EXPORT_SYMBOL(pci_enable_msi);
>  
> @@ -947,7 +949,11 @@ static int __pci_enable_msix_range(struc
>  int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
>  		int minvec, int maxvec)
>  {
> -	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL, 0);
> +	int ret = msi_setup_device_data(&dev->dev);
> +
> +	if (!ret)
> +		ret = __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL, 0);
> +	return ret;
>  }
>  EXPORT_SYMBOL(pci_enable_msix_range);
>  
> @@ -974,8 +980,12 @@ int pci_alloc_irq_vectors_affinity(struc
>  				   struct irq_affinity *affd)
>  {
>  	struct irq_affinity msi_default_affd = {0};
> +	int ret = msi_setup_device_data(&dev->dev);
>  	int nvecs = -ENOSPC;
>  
> +	if (ret)
> +		return ret;
> +
>  	if (flags & PCI_IRQ_AFFINITY) {
>  		if (!affd)
>  			affd = &msi_default_affd;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
