Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F57CC433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Dec 2021 20:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1551D8142C;
	Wed, 29 Dec 2021 20:42:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RLNwvnFsA0Uq; Wed, 29 Dec 2021 20:42:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 00D2181425;
	Wed, 29 Dec 2021 20:42:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA427C001E;
	Wed, 29 Dec 2021 20:42:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E07F9C0012
 for <iommu@lists.linux-foundation.org>; Wed, 29 Dec 2021 20:42:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D5B7F81425
 for <iommu@lists.linux-foundation.org>; Wed, 29 Dec 2021 20:42:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aL8LoeuORwyW for <iommu@lists.linux-foundation.org>;
 Wed, 29 Dec 2021 20:42:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 30DEB8141F
 for <iommu@lists.linux-foundation.org>; Wed, 29 Dec 2021 20:42:07 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E683AB81840;
 Wed, 29 Dec 2021 20:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4842CC36AEA;
 Wed, 29 Dec 2021 20:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640810523;
 bh=Rw2gOb2/8KzlEQNxczhYbxeUYfMz9rcfWKTvcBef+uU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=Z8libg51KX2kY+CIF2+bXUsg0EIcNN5yMgxTuiaYdAhsx5bwEoib7kJks3+pCa4tH
 EpOL6ai2kwnLyrXdG6uD93x+1IaXqDX8sHPxD8RVGF6K9c8qySePI19RLG2NCr9aTU
 dap8mwqCB1JHL1MXEG4LcXJooB3Jwt0RGlWNIXftfvgABMADN/tSR0Z53Lh1Emo1dj
 /XgphNYqxVU4RAE8i7+DSqpogbiH3+2+K5WMl3bqkwbtTvPk4wtlayEyvi/0/yuMJj
 y2FDN1dzMmy++2YtlZDujx+6DwDo8DalV/gJKTydVtRP7aUcTpCIpdJdKMT8XG/i3v
 o+SRMFCe8Uk2Q==
Date: Wed, 29 Dec 2021 14:42:02 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 03/13] PCI: pci_stub: Suppress kernel DMA ownership
 auto-claiming
Message-ID: <20211229204202.GA1700874@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211217063708.1740334-4-baolu.lu@linux.intel.com>
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
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

On Fri, Dec 17, 2021 at 02:36:58PM +0800, Lu Baolu wrote:
> The pci_dma_configure() marks the iommu_group as containing only devices
> with kernel drivers that manage DMA.

I'm looking at pci_dma_configure(), and I don't see the connection to
iommu_groups.

> Avoid this default behavior for the
> pci_stub because it does not program any DMA itself.  This allows the
> pci_stub still able to be used by the admin to block driver binding after
> applying the DMA ownership to vfio.

> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/pci/pci-stub.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
> index e408099fea52..6324c68602b4 100644
> --- a/drivers/pci/pci-stub.c
> +++ b/drivers/pci/pci-stub.c
> @@ -36,6 +36,9 @@ static struct pci_driver stub_driver = {
>  	.name		= "pci-stub",
>  	.id_table	= NULL,	/* only dynamic id's */
>  	.probe		= pci_stub_probe,
> +	.driver		= {
> +		.suppress_auto_claim_dma_owner = true,

The new .suppress_auto_claim_dma_owner controls whether we call
iommu_device_set_dma_owner().  I guess you added
.suppress_auto_claim_dma_owner because iommu_device_set_dma_owner()
must be done *before* we call the driver's .probe() method?

Otherwise, we could call some new interface from .probe() instead of
adding the flag to struct device_driver.

> +	},
>  };
>  
>  static int __init pci_stub_init(void)
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
