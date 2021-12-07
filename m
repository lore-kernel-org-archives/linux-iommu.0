Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CE9C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 21:05:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66E0F60648;
	Tue,  7 Dec 2021 21:05:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bZR_j7UJgfOV; Tue,  7 Dec 2021 21:05:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6BB5E60ED2;
	Tue,  7 Dec 2021 21:05:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48915C002F;
	Tue,  7 Dec 2021 21:05:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44F53C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 21:05:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 24AB383336
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 21:05:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ITEs7y2RW_Af for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 21:05:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 76E1E832EB
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 21:05:07 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CEB9BB81E89;
 Tue,  7 Dec 2021 21:05:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4744FC341C1;
 Tue,  7 Dec 2021 21:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638911104;
 bh=B1uq1LxQ+zV7OmdTOwCRtNnO2jvBQqZ4s4dpqK7FSx0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=FtAnSeLche3tDfxYR56d58ANFwkYFafEMJxsxNrKfqKSblB85o+rbHYZ0oIIlySDv
 tsgfTCkxzfo51fNQXVhI9AfB029y60Tf37iykBBNUPrO9avyXhGWg3TNkVZDa3+bLl
 MKDQoxA+9Eb/eCVob/myMBPCDOUC7Lks1kDQXL/5zr8Jhktfir9G8Gj5qdNVWJyvmY
 nSUYSnGBdz6NxEsdbnDrce0qOvuWXhcMslMcv0JD/Q3qxC0C9Ez3+52Iiaa26ekY+F
 2GXwtyHKPUf3jS2KFP70m0i6puvts4TC/fan1RswEtNWghn5k8zw3s0sx0LXHK3Kax
 bg5UGKj2mjoaA==
Date: Tue, 7 Dec 2021 15:05:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 19/36] PCI/MSI: Store properties in device::msi::data
Message-ID: <20211207210503.GA77830@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211206210438.688216619@linutronix.de>
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

On Mon, Dec 06, 2021 at 11:39:26PM +0100, Thomas Gleixner wrote:
> Store the properties which are interesting for various places so the MSI
> descriptor fiddling can be removed.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> V2: Use the setter function
> ---
>  drivers/pci/msi/msi.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -244,6 +244,8 @@ static void free_msi_irqs(struct pci_dev
>  		iounmap(dev->msix_base);
>  		dev->msix_base = NULL;
>  	}
> +
> +	msi_device_set_properties(&dev->dev, 0);
>  }
>  
>  static void pci_intx_for_msi(struct pci_dev *dev, int enable)
> @@ -341,6 +343,7 @@ msi_setup_entry(struct pci_dev *dev, int
>  {
>  	struct irq_affinity_desc *masks = NULL;
>  	struct msi_desc *entry;
> +	unsigned long prop;
>  	u16 control;
>  
>  	if (affd)
> @@ -372,6 +375,10 @@ msi_setup_entry(struct pci_dev *dev, int
>  	if (entry->pci.msi_attrib.can_mask)
>  		pci_read_config_dword(dev, entry->pci.mask_pos, &entry->pci.msi_mask);
>  
> +	prop = MSI_PROP_PCI_MSI;
> +	if (entry->pci.msi_attrib.is_64)
> +		prop |= MSI_PROP_64BIT;
> +	msi_device_set_properties(&dev->dev, prop);
>  out:
>  	kfree(masks);
>  	return entry;
> @@ -514,6 +521,7 @@ static int msix_setup_entries(struct pci
>  		if (masks)
>  			curmsk++;
>  	}
> +	msi_device_set_properties(&dev->dev, MSI_PROP_PCI_MSIX | MSI_PROP_64BIT);
>  	ret = 0;
>  out:
>  	kfree(masks);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
