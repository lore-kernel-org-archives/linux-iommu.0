Return-Path: <SRS0=xEY5=QC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B310BC433EF
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 20:48:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58AD463241
	for <iommu@archiver.kernel.org>; Mon, 15 Nov 2021 20:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 58AD463241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 123A7400CE;
	Mon, 15 Nov 2021 20:48:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tCmzXSGUJt2O; Mon, 15 Nov 2021 20:48:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id ABB9A40192;
	Mon, 15 Nov 2021 20:48:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80B8CC001E;
	Mon, 15 Nov 2021 20:48:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69290C0012
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 20:48:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4A6B5607A9
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 20:48:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P6RmCzapEvie for <iommu@lists.linux-foundation.org>;
 Mon, 15 Nov 2021 20:48:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D39726066E
 for <iommu@lists.linux-foundation.org>; Mon, 15 Nov 2021 20:48:23 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29D5C63240;
 Mon, 15 Nov 2021 20:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637009303;
 bh=Ab04UsOLuYDaWgm25keP0dnQCwf2wKgMMT8FZu0wdU4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=p+hZZ1wwOqkazM54o6HvrGw9tCG0HCBtef7yJtD1WKlY1aVo0bn1uDBS3uH2zcTum
 F1hwf/F/+qWGyMrgMbPGJi3/MaQbqVkcJiSJTP7Sso6dp1MeM62oJ6EbZ0dqqUw8RC
 XDutK2ZgWNduVzYoxkXW4dPZOz4gnxdL+xd0lKnEVHgxdeeSml/+l35jc0SDOg+tOe
 XjdyGPwy4QyA/zVawD0Ox/ObYmU2s2nOfF+1SSCB8gE/nxeeyG6SjuroobyovNR3PQ
 /jaXEC8b1Lzdog7PhMV6IudqpvicpbPfktdvROHIVrrIIgzgZ/vQ+E8qQd9+N/mJoL
 fEZElHCplMLLw==
Date: Mon, 15 Nov 2021 14:48:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 03/11] PCI: pci_stub: Suppress kernel DMA ownership
 auto-claiming
Message-ID: <20211115204821.GA1587269@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211115020552.2378167-4-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org, rafael@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-pci@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Will Deacon <will@kernel.org>
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

On Mon, Nov 15, 2021 at 10:05:44AM +0800, Lu Baolu wrote:
> pci_stub allows the admin to block driver binding on a device and make
> it permanently shared with userspace. Since pci_stub does not do DMA,
> it is safe. 

Can you elaborate on what "permanently shared with userspace" means
here?  I assume it's only permanent as long as pci-stub is bound to
the device?

Also, a few words about what "it is safe" means here would be helpful.

> However the admin must understand that using pci_stub allows
> userspace to attack whatever device it was bound to.

The admin isn't going to read this sentence.  Should there be a doc
update related to this?  What sort of attack does this refer to?

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
