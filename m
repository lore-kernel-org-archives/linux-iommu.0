Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22299C433EF
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 21:05:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D29BD4045E;
	Tue,  7 Dec 2021 21:05:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cftCDDeh06iG; Tue,  7 Dec 2021 21:05:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D76D140261;
	Tue,  7 Dec 2021 21:05:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE690C002F;
	Tue,  7 Dec 2021 21:05:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00C7BC0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 21:05:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E27F340943
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 21:05:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Ycj-b0QY_zD for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 21:05:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0741040941
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 21:05:49 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 97655B81E8A;
 Tue,  7 Dec 2021 21:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E534FC341C1;
 Tue,  7 Dec 2021 21:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638911146;
 bh=emmb3xsy+H3LBfwGrcgXTk/PL3JNw+p8ei444INyEeo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=tUHMVIuvSKD4KpV71T2u3HTnNeDdjH94nw6ue1OFelE7L1C2fPpkpG+VJS6EQ7RbL
 DE4nTrcL4DzJJW3p9KkxJ90aY6WFOuJBcNOz8jNU3ACfHQRdCHhgymSV73nOEduwEV
 6C7Yc+PJ57lEXe3kC7Fnk7gDayIipgMIIFTSVZY22xFXTXz0GcB0An+vkRX1XJHFeD
 76cd+8jimETlvZcjXu7IptnZ7ZJ5TZKmn3H2yllAjGpq1LNMQk63AsB8yMhOvkaWG7
 8Ad9xB75VRw/OAC03WjVlipOwF+92OCz7KOMco287/fqEZgDdhOY94sgRr2WDdSvK3
 r75m+DCO8+wLg==
Date: Tue, 7 Dec 2021 15:05:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 28/36] PCI/MSI: Use __msi_get_virq() in pci_get_vector()
Message-ID: <20211207210544.GA77966@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211206210439.181331216@linutronix.de>
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

On Mon, Dec 06, 2021 at 11:39:41PM +0100, Thomas Gleixner wrote:
> Use msi_get_vector() and handle the return value to be compatible.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
> V2: Handle the INTx case directly instead of trying to be overly smart - Marc
> ---
>  drivers/pci/msi/msi.c |   25 +++++--------------------
>  1 file changed, 5 insertions(+), 20 deletions(-)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -1032,28 +1032,13 @@ EXPORT_SYMBOL(pci_free_irq_vectors);
>   */
>  int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
>  {
> -	if (dev->msix_enabled) {
> -		struct msi_desc *entry;
> +	unsigned int irq;
>  
> -		for_each_pci_msi_entry(entry, dev) {
> -			if (entry->msi_index == nr)
> -				return entry->irq;
> -		}
> -		WARN_ON_ONCE(1);
> -		return -EINVAL;
> -	}
> +	if (!dev->msi_enabled && !dev->msix_enabled)
> +		return !nr ? dev->irq : -EINVAL;
>  
> -	if (dev->msi_enabled) {
> -		struct msi_desc *entry = first_pci_msi_entry(dev);
> -
> -		if (WARN_ON_ONCE(nr >= entry->nvec_used))
> -			return -EINVAL;
> -	} else {
> -		if (WARN_ON_ONCE(nr > 0))
> -			return -EINVAL;
> -	}
> -
> -	return dev->irq + nr;
> +	irq = msi_get_virq(&dev->dev, nr);
> +	return irq ? irq : -EINVAL;
>  }
>  EXPORT_SYMBOL(pci_irq_vector);
>  
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
