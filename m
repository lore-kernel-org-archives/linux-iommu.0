Return-Path: <SRS0=fUNI=5K=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A55C18E5B
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 08:37:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3FF206F6
	for <iommu@archiver.kernel.org>; Wed, 25 Mar 2020 08:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3FF206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0632C88253;
	Wed, 25 Mar 2020 08:37:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PCekhSxAfm3l; Wed, 25 Mar 2020 08:37:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8EADC88252;
	Wed, 25 Mar 2020 08:37:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F1CBC1D74;
	Wed, 25 Mar 2020 08:37:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E089AC0177
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 08:37:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D337288253
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 08:37:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w7bwYwXPBW8k for <iommu@lists.linux-foundation.org>;
 Wed, 25 Mar 2020 08:37:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5DBFC88252
 for <iommu@lists.linux-foundation.org>; Wed, 25 Mar 2020 08:37:45 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8C21B68BFE; Wed, 25 Mar 2020 09:37:40 +0100 (CET)
Date: Wed, 25 Mar 2020 09:37:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 1/2] dma-mapping: add a dma_ops_bypass flag to struct
 device
Message-ID: <20200325083740.GC21605@lst.de>
References: <20200320141640.366360-1-hch@lst.de>
 <20200320141640.366360-2-hch@lst.de>
 <2f31d0dd-aa7e-8b76-c8a1-5759fda5afc9@ozlabs.ru>
 <20200323083705.GA31245@lst.de> <20200323085059.GA32528@lst.de>
 <87sghz2ibh.fsf@linux.ibm.com> <20200323172256.GB31269@lst.de>
 <ffce1af6-a215-dee8-7b5c-2111f43accfd@ozlabs.ru>
 <20200324075402.GJ23447@lst.de>
 <41975da3-3a4a-fc3c-2b90-8d607cf220e6@ozlabs.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <41975da3-3a4a-fc3c-2b90-8d607cf220e6@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Christoph Hellwig <hch@lst.de>
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

On Wed, Mar 25, 2020 at 03:51:36PM +1100, Alexey Kardashevskiy wrote:
> >> This is for persistent memory which you can DMA to/from but yet it does
> >> not appear in the system as a normal memory and therefore requires
> >> special handling anyway (O_DIRECT or DAX, I do not know the exact
> >> mechanics). All other devices in the system should just run as usual,
> >> i.e. use 1:1 mapping if possible.
> > 
> > On other systems (x86 and arm) pmem as long as it is page backed does
> > not require any special handling.  This must be some weird way powerpc
> > fucked up again, and I suspect you'll have to suffer from it.
> 
> 
> It does not matter if it is backed by pages or not, the problem may also
> appear if we wanted for example p2p PCI via IOMMU (between PHBs) and
> MMIO might be mapped way too high in the system address space and make
> 1:1 impossible.

How can it be mapped too high for a direct mapping with a 64-bit DMA
mask?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
