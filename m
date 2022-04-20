Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE77C433EF
	for <iommu@archiver.kernel.org>; Wed, 20 Apr 2022 07:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00481840CC;
	Wed, 20 Apr 2022 07:12:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xKcf9XyNBAm8; Wed, 20 Apr 2022 07:12:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ECD99840CE;
	Wed, 20 Apr 2022 07:12:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D082DC002F;
	Wed, 20 Apr 2022 07:12:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1211C002C
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 07:12:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7F76540C47
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 07:12:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o0XMdla6gmCd for <iommu@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 07:12:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6DF44401F8
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 07:12:25 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 40C0768B05; Wed, 20 Apr 2022 09:12:18 +0200 (CEST)
Date: Wed, 20 Apr 2022 09:12:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 03/25] dma-direct: take dma-ranges/offsets into account
 in resource mapping
Message-ID: <20220420071217.GA5152@lst.de>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru>
 <0baff803-b0ea-529f-095a-897398b4f63f@arm.com>
 <20220417224427.drwy3rchwplthelh@mobilestation>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220417224427.drwy3rchwplthelh@mobilestation>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Rob Herring <robh@kernel.org>, Vladimir Murzin <vladimir.murzin@arm.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
 linux-pci@vger.kernel.org, Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Frank Li <Frank.Li@nxp.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
 Serge Semin <Sergey.Semin@baikalelectronics.ru>, dmaengine@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>,
 Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
 Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On Mon, Apr 18, 2022 at 01:44:27AM +0300, Serge Semin wrote:
> > but a DMA controller might also want to access something in the MMIO range
> > 0x0-0x7fffffff, of which it still has an identical non-offset view. If a
> > driver was previously using dma_map_resource() for that, it would now start
> > getting DMA_MAPPING_ERROR because the dma_range_map exists but doesn't
> > describe the MMIO region. I agree that in hindsight it's not an ideal
> > situation, but it's how things have ended up, so at this point I'm wary of
> > making potentially-breaking changes.
> 
> Hmm, what if the driver was previously using for instance the
> dma_direct_map_sg() method for it?

dma_map_resource is for mapping MMIO space, and must not be called on
memory in the kernel map.  For dma_map_sg (or all the other dma_map_*
interface except for dma_map_resource), the reverse is true.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
