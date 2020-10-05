Return-Path: <SRS0=BXsX=DM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D221CC4363A
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 13:09:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1694620848
	for <iommu@archiver.kernel.org>; Mon,  5 Oct 2020 13:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1694620848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AED6A85487;
	Mon,  5 Oct 2020 13:09:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mjjuHMQMMAKq; Mon,  5 Oct 2020 13:09:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 23ACD8522E;
	Mon,  5 Oct 2020 13:09:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18081C016F;
	Mon,  5 Oct 2020 13:09:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C979CC0051
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 13:08:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B7B1487083
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 13:08:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UCThQdr4JGOt for <iommu@lists.linux-foundation.org>;
 Mon,  5 Oct 2020 13:08:57 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8FCBA8707A
 for <iommu@lists.linux-foundation.org>; Mon,  5 Oct 2020 13:08:57 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7EDB367373; Mon,  5 Oct 2020 15:08:52 +0200 (CEST)
Date: Mon, 5 Oct 2020 15:08:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC 0/3] iommu: Reserved regions for IOVAs beyond dma_mask
 and iommu aperture
Message-ID: <20201005130852.GB2163@lst.de>
References: <20200928195037.22654-1-eric.auger@redhat.com>
 <20200928164224.12350d84@w520.home>
 <1cbaf3e7-cf88-77f6-4cc4-46dcd60eb649@redhat.com>
 <20200929121849.455af184@w520.home>
 <20201005104410.GA12138@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201005104410.GA12138@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Will Deacon <will@kernel.org>, robin.murphy@arm.com,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>, dwmw2@infradead.org, hch@lst.de,
 eric.auger.pro@gmail.com
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

On Mon, Oct 05, 2020 at 11:44:10AM +0100, Lorenzo Pieralisi wrote:
> > I see that there are both OF and ACPI hooks in pci_dma_configure() and
> > both modify dev->dma_mask, which is what pci-sysfs is exposing here,
> > but I'm not convinced this even does what it's intended to do.  The
> > driver core calls this via the bus->dma_configure callback before
> > probing a driver, but then what happens when the driver calls
> > pci_set_dma_mask()?  This is just a wrapper for dma_set_mask() and I
> > don't see anywhere that would take into account the existing
> > dev->dma_mask.  It seems for example that pci_dma_configure() could
> > produce a 42 bit mask as we have here, then the driver could override
> > that with anything that the dma_ops.dma_supported() callback finds
> > acceptable, and I don't see any instances where the current
> > dev->dma_mask is considered.  Am I overlooking something? 
> 
> I don't think so but Christoph and Robin can provide more input on
> this - it is a long story.
> 
> ACPI and OF bindings set a default dma_mask (and dev->bus_dma_limit),
> this does not prevent a driver from overriding the dev->dma_mask but DMA
> mapping code still takes into account the dev->bus_dma_limit.
> 
> This may help:
> 
> git log -p 03bfdc31176c

This is at best a historic artefact.  Bus drivers have no business
messing with the DMA mask, dev->bus_dma_limit is the way to communicate
addressing limits on the bus (or another interconnect closer to the CPU).
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
