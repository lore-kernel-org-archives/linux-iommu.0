Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF694C43334
	for <iommu@archiver.kernel.org>; Fri, 24 Jun 2022 13:28:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72D008483E;
	Fri, 24 Jun 2022 13:28:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 72D008483E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fdNVZ5J0zCGa; Fri, 24 Jun 2022 13:28:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 405838480E;
	Fri, 24 Jun 2022 13:28:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 405838480E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12BC3C0032;
	Fri, 24 Jun 2022 13:28:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A42F1C002D
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 13:28:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7E86842593
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 13:28:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7E86842593
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VfgTyzHQC7TO for <iommu@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 13:28:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9610D42583
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9610D42583
 for <iommu@lists.linux-foundation.org>; Fri, 24 Jun 2022 13:28:14 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 52E59672; Fri, 24 Jun 2022 15:28:12 +0200 (CEST)
Date: Fri, 24 Jun 2022 15:28:08 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] iommu/dma: Add config for PCI SAC address trick
Message-ID: <YrW76PPKadbZuN/3@8bytes.org>
References: <3f06994f9f370f9d35b2630ab75171ecd2065621.1654782107.git.robin.murphy@arm.com>
 <YrMSJ6AGwn3PxSIH@8bytes.org>
 <b9439692-c72b-b856-c7c0-e60a863f3e74@arm.com>
 <YrRPfhXvdPo0Y6Cx@8bytes.org>
 <653fba02-7eef-5f0d-66dd-7599af84db86@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <653fba02-7eef-5f0d-66dd-7599af84db86@arm.com>
Cc: iommu@lists.linux-foundation.org, will@kernel.org,
 linux-kernel@vger.kernel.org, hch@lst.de
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

On Thu, Jun 23, 2022 at 12:41:00PM +0100, Robin Murphy wrote:
> On 2022-06-23 12:33, Joerg Roedel wrote:
> > On Wed, Jun 22, 2022 at 02:12:39PM +0100, Robin Murphy wrote:
> > > Thanks for your bravery!
> > 
> > It already starts, with that patch I am getting:
> > 
> > 	xhci_hcd 0000:02:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000f address=0xff00ffffffefe000 flags=0x0000]
> > 
> > In my kernel log. The device is an AMD XHCI controller and seems to
> > funciton normally after boot. The message disappears with
> > iommu.forcedac=0.
> > 
> > Need to look more into that...
> 
> Given how amd_iommu_domain_alloc() sets the domain aperture, presumably the
> DMA address allocated was 0xffffffffffefe000? Odd that it gets bits punched
> out in the middle rather than simply truncated off the top as I would have
> expected :/

So even more weird, as a workaround I changed the AMD IOMMU driver to
allocate a 4-level page-table and limit the DMA aperture to 48 bits. I
still get the same message.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
