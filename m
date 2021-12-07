Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DAFC433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 21:05:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ADBD760EDB;
	Tue,  7 Dec 2021 21:05:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xGFqV_axuC68; Tue,  7 Dec 2021 21:05:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9E27F60EDA;
	Tue,  7 Dec 2021 21:05:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B417C002F;
	Tue,  7 Dec 2021 21:05:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 453A1C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 21:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 271EF83E80
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 21:05:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PGk74w2VpiJm for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 21:05:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 70B8083E74
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 21:05:27 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id A06AFB81E86;
 Tue,  7 Dec 2021 21:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C0FC341C3;
 Tue,  7 Dec 2021 21:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638911124;
 bh=SSlqi2avER7Dt/gWeQCpUUK2WPs6V3REpcTbyOpLSVo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=CQtpmV/VopSugovJYtB6rKgOASfGm+plq9ohd+c4gicwGabcfRU6ytOddQjW3Ve3g
 tNsgaOjeq555aKWCr9jX9ODfSAmC5gTVJ3vse/nmE/bt6EDI8IgNQkIg/STXmf+7zE
 U64SEr9asqbhWIQiNhiBgpiH/BRtSY7WmUh34L91oWrRiTQR4AmZqrtRLVMJBHFyQ9
 UasPXsz2PYCPtfItiij1woyf8fHZ+e13Xx+SVxc9GVYIn8V5Hs0PkqB4OagIliTaI+
 V7FpgXy1X/0HnHOAWVtqEJ1pP+FwItrm6eFFL4yJzWnlD+4qQ//Q8RNQddmclqTqgt
 UL3+7UtH4ejJw==
Date: Tue, 7 Dec 2021 15:05:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch V2 25/36] PCI/MSI: Provide MSI_FLAG_MSIX_CONTIGUOUS
Message-ID: <20211207210522.GA77919@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211206210439.021277807@linutronix.de>
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

On Mon, Dec 06, 2021 at 11:39:36PM +0100, Thomas Gleixner wrote:
> Provide a domain info flag which makes the core code check for a contiguous
> MSI-X index on allocation. That's simpler than checking it at some other
> domain callback in architecture code.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/msi/irqdomain.c |   16 ++++++++++++++--
>  include/linux/msi.h         |    2 ++
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> --- a/drivers/pci/msi/irqdomain.c
> +++ b/drivers/pci/msi/irqdomain.c
> @@ -89,9 +89,21 @@ static int pci_msi_domain_check_cap(stru
>  	if (pci_msi_desc_is_multi_msi(desc) &&
>  	    !(info->flags & MSI_FLAG_MULTI_PCI_MSI))
>  		return 1;
> -	else if (desc->pci.msi_attrib.is_msix && !(info->flags & MSI_FLAG_PCI_MSIX))
> -		return -ENOTSUPP;
>  
> +	if (desc->pci.msi_attrib.is_msix) {
> +		if (!(info->flags & MSI_FLAG_PCI_MSIX))
> +			return -ENOTSUPP;
> +
> +		if (info->flags & MSI_FLAG_MSIX_CONTIGUOUS) {
> +			unsigned int idx = 0;
> +
> +			/* Check for gaps in the entry indices */
> +			for_each_msi_entry(desc, dev) {
> +				if (desc->msi_index != idx++)
> +					return -ENOTSUPP;
> +			}
> +		}
> +	}
>  	return 0;
>  }
>  
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -376,6 +376,8 @@ enum {
>  	MSI_FLAG_LEVEL_CAPABLE		= (1 << 6),
>  	/* Populate sysfs on alloc() and destroy it on free() */
>  	MSI_FLAG_DEV_SYSFS		= (1 << 7),
> +	/* MSI-X entries must be contiguous */
> +	MSI_FLAG_MSIX_CONTIGUOUS	= (1 << 8),
>  };
>  
>  int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
