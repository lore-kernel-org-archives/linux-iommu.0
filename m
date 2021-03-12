Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B75DC433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 20:57:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16CFD64F89
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 20:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16CFD64F89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFA324EB95;
	Fri, 12 Mar 2021 20:57:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bhW2ySpe76uV; Fri, 12 Mar 2021 20:57:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66FD446EFC;
	Fri, 12 Mar 2021 20:57:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3ABB4C000A;
	Fri, 12 Mar 2021 20:57:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5166C0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 20:57:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9E8E74EB95
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 20:57:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BGp0C1pougxl for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 20:57:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D86E84DDE7
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 20:57:09 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C09564F87;
 Fri, 12 Mar 2021 20:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615582629;
 bh=mkL75zFRcvY7SDVV8rIsNBThP6Ch2Zj5Sc2UsAwvmCY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=kKZvn2V5xv7vpfX93Th5HlKcyhtTFfyTOdhE+m5fKiVxM27wSYf500/9OadIahsw+
 oEGYQIHa1AwIK5CClP76fHluAH6DgvHGmwD1Kea5H0lGK94aaa2xCgbL6GQHBkCRBy
 fVCGSAVP/trm3ZEI5cH7YCoGdMP86GqMr+tM1r6Q+i+i6nEhMLbeEbyGFsvblGKgXb
 xQ672JWkV5EhfxHIkbYo60ElXUtpihbb1u6Rtm7tTANTg6lC/odVOR3a1b0iFOziBY
 eq9ls4SRmtP/ZzQ/Cqg3h/hLa//KTnib5Y9jqx7r0b4zd9zW8JIrje6QXqM4nEM/hW
 3rwqhKzBPmI7A==
Date: Fri, 12 Mar 2021 14:57:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [RFC PATCH v2 02/11] PCI/P2PDMA: Avoid pci_get_slot() which sleeps
Message-ID: <20210312205707.GA2288658@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210311233142.7900-3-logang@deltatee.com>
Cc: Minturn Dave B <dave.b.minturn@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-pci@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ira Weiny <iweiny@intel.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, linux-block@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Jason Ekstrand <jason@jlekstrand.net>, John Hubbard <jhubbard@nvidia.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>, Christoph Hellwig <hch@lst.de>,
 Xiong Jianxin <jianxin.xiong@intel.com>
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

On Thu, Mar 11, 2021 at 04:31:32PM -0700, Logan Gunthorpe wrote:
> In order to use upstream_bridge_distance_warn() from a dma_map function,
> it must not sleep. However, pci_get_slot() takes the pci_bus_sem so it
> might sleep.
> 
> In order to avoid this, try to get the host bridge's device from
> bus->self, and if that is not set just get the first element in the
> list. It should be impossible for the host bridges device to go away
> while references are held on child devices, so the first element
> should not change and this should be safe.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/pci/p2pdma.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index bd89437faf06..2135fe69bb07 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -311,11 +311,15 @@ static const struct pci_p2pdma_whitelist_entry {
>  static bool __host_bridge_whitelist(struct pci_host_bridge *host,
>  				    bool same_host_bridge)
>  {
> -	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
>  	const struct pci_p2pdma_whitelist_entry *entry;
> +	struct pci_dev *root = host->bus->self;
>  	unsigned short vendor, device;
>  
>  	if (!root)
> +		root = list_first_entry_or_null(&host->bus->devices,
> +						struct pci_dev, bus_list);

Replacing one ugliness (assuming there is a pci_dev for the host
bridge, and that it is at 00.0) with another (still assuming a pci_dev
and that it is host->bus->self or the first entry).  I can't suggest
anything better, but maybe a little comment in the code would help
future readers.

I wish we had a real way to discover this property without the
whitelist, at least for future devices.  Was there ever any interest
in a _DSM or similar interface for this?

I *am* very glad to remove a pci_get_slot() usage.

> +
> +	if (!root || root->devfn)
>  		return false;
>  
>  	vendor = root->vendor;

Don't you need to also remove the "pci_dev_put(root)" a few lines
below?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
