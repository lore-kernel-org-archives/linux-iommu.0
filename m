Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EEBC433EF
	for <iommu@archiver.kernel.org>; Wed, 29 Dec 2021 21:16:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 128DB4096F;
	Wed, 29 Dec 2021 21:16:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3idqwwfrB2Ab; Wed, 29 Dec 2021 21:16:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id DECF240958;
	Wed, 29 Dec 2021 21:16:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FCC9C002F;
	Wed, 29 Dec 2021 21:16:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 151E6C0012
 for <iommu@lists.linux-foundation.org>; Wed, 29 Dec 2021 21:16:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E396280BED
 for <iommu@lists.linux-foundation.org>; Wed, 29 Dec 2021 21:16:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rn9i0afGyUqe for <iommu@lists.linux-foundation.org>;
 Wed, 29 Dec 2021 21:16:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F1F6080BD9
 for <iommu@lists.linux-foundation.org>; Wed, 29 Dec 2021 21:16:30 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E3989B81A0C;
 Wed, 29 Dec 2021 21:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEF2C36AE9;
 Wed, 29 Dec 2021 21:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640812587;
 bh=cjyr8peC0EwKteN+JSIctBlIqiolVktDfzhMSIQZ+DE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=Vgjmo1GhUSsmFHn1ckCJL8DqIveMa8+rBwPsRn5zv8bVRjfHGKxuXoTqGU7lkBDcH
 VxbG80fnd8XvvOHDQrOfcxku0d0kA7WCKHxhu1xWCJV3N9TBgcT3niy8ikUAbvm99R
 eU1BQX2u8bfnOCGnANyuGPryT4/Ewh7P1kCLMoOo6OFhb0wMNPbN9iDsVGi8QZfMUG
 hraBTiBhEB0ReFcNZfltH+Eja2O+oRLVWJbrBgx43iW7ZKkft1V1bNo/JfvCAY8gwb
 0vX25amhqPnnn/8AI2Ngh6pUNxjlpbo75eFj5F1tK9Tnbv86AFwdGy+NarfhfhNkw9
 wJOJpc9lzNytA==
Date: Wed, 29 Dec 2021 15:16:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 04/13] PCI: portdrv: Suppress kernel DMA ownership
 auto-claiming
Message-ID: <20211229211626.GA1701512@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211217063708.1740334-5-baolu.lu@linux.intel.com>
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

On Fri, Dec 17, 2021 at 02:36:59PM +0800, Lu Baolu wrote:
> IOMMU grouping on PCI necessitates that if we lack isolation on a bridge
> then all of the downstream devices will be part of the same IOMMU group
> as the bridge. The existing vfio framework allows the portdrv driver to
> be bound to the bridge while its downstream devices are assigned to user
> space. The pci_dma_configure() marks the iommu_group as containing only
> devices with kernel drivers that manage DMA. Avoid this default behavior
> for the portdrv driver in order for compatibility with the current vfio
> policy.

A word about the isolation would be useful.  I think you're referring
to some specific ACS controls, probably P2P Request Redirect?

I guess this is just a wording issue, but I think it's actually the
*lack* of some ACS controls that forces us to put several devices in
the same IOMMU group, isn't it?  It's not that we start with "IOMMU
grouping" and that necessitates something else.

Maybe something like this?

  If a switch lacks ACS P2P Request Redirect (and possibly other
  controls?), a device below the switch can bypass the IOMMU and DMA
  directly to other devices below the switch, so all the downstream
  devices must be in the same IOMMU group as the switch itself.

> The commit 5f096b14d421b ("vfio: Whitelist PCI bridges") extended above
> policy to all kernel drivers of bridge class. This is not always safe.
> For example, The shpchp_core driver relies on the PCI MMIO access for the
> controller functionality. With its downstream devices assigned to the
> userspace, the MMIO might be changed through user initiated P2P accesses
> without any notification. This might break the kernel driver integrity
> and lead to some unpredictable consequences.
> 
> For any bridge driver, in order to avoiding default kernel DMA ownership
> claiming, we should consider:
> 
>  1) Does the bridge driver use DMA? Calling pci_set_master() or
>     a dma_map_* API is a sure indicate the driver is doing DMA
> 
>  2) If the bridge driver uses MMIO, is it tolerant to hostile
>     userspace also touching the same MMIO registers via P2P DMA
>     attacks?
> 
> Conservatively if the driver maps an MMIO region at all, we can say that
> it fails the test.

I'm not sure what all this explanation is telling me.  It says
something done by 5f096b14d421 is not always safe, but this patch
doesn't fix any of those unsafe things.

If it doesn't explain why we need this patch or how this patch works,
I don't think we need it in the commit log.

Maybe this is an explanation for why you didn't set
.suppress_auto_claim_dma_owner for shpc_driver?

Minor typos above:
  s/in order to avoiding default/before avoiding default/
  s/relies on the PCI MMIO access/relies on PCI MMIO access/
  s/For example, The/For example, the/
  s/is a sure indicate the/is a sure indication the/

> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/pci/pcie/portdrv_pci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 35eca6277a96..c48a8734f9c4 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -202,7 +202,10 @@ static struct pci_driver pcie_portdriver = {
>  
>  	.err_handler	= &pcie_portdrv_err_handler,
>  
> -	.driver.pm	= PCIE_PORTDRV_PM_OPS,
> +	.driver		= {
> +		.pm = PCIE_PORTDRV_PM_OPS,
> +		.suppress_auto_claim_dma_owner = true,
> +	},
>  };
>  
>  static int __init dmi_pcie_pme_disable_msi(const struct dmi_system_id *d)
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
