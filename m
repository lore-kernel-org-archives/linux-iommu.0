Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E35EEC433EF
	for <iommu@archiver.kernel.org>; Wed, 20 Apr 2022 08:47:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8BFCF410D3;
	Wed, 20 Apr 2022 08:47:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G7MV8cCJ6Mz9; Wed, 20 Apr 2022 08:47:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5B92E40103;
	Wed, 20 Apr 2022 08:47:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23588C002F;
	Wed, 20 Apr 2022 08:47:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 601CFC002C
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 08:47:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 393F3840B8
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 08:47:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tpZGX89Sdv0a for <iommu@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 08:47:52 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A158D840AF
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 08:47:52 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id BA3C368AFE; Wed, 20 Apr 2022 10:47:46 +0200 (CEST)
Date: Wed, 20 Apr 2022 10:47:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 03/25] dma-direct: take dma-ranges/offsets into account
 in resource mapping
Message-ID: <20220420084746.GA11606@lst.de>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru>
 <0baff803-b0ea-529f-095a-897398b4f63f@arm.com>
 <20220417224427.drwy3rchwplthelh@mobilestation>
 <20220420071217.GA5152@lst.de>
 <20220420083207.pd3hxbwezrm2ud6x@mobilestation>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220420083207.pd3hxbwezrm2ud6x@mobilestation>
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

I can't really comment on the dma-ranges exlcusion for P2P mappings,
as that predates my involvedment, however:

On Wed, Apr 20, 2022 at 11:32:07AM +0300, Serge Semin wrote:
> See, if I get to map a virtual memory address to be accessible by any
> PCIe peripheral device, then the dma_map_sg/dma_map_page/etc
> procedures will take the PCIe host controller dma-ranges into account.
> It will work as expected and the PCIe devices will see the memory what
> I specified. But if I get to pass the physical address of the same
> page or a physical address of some device of the DEVs space to the
> dma_map_resource(), then the PCIe dma-ranges won't be taken into
> account, and the result mapping will be incorrect. That's why the
> current dma_map_resource() implementation seems very confusing to me.
> As I see it phys_addr_t is the type of the Interconnect address space,
> meanwhile dma_addr_t describes the PCIe, DEVs address spaces.
> 
> Based on what I said here and in my previous email could you explain
> what do I get wrong?

You simply must not use dma_map_resource for normal kernel memory.
So while the exclusion might be somewhat confusing, that confusion
really should not matter for any proper use of the API.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
