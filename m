Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 433C6C433F5
	for <iommu@archiver.kernel.org>; Wed, 20 Apr 2022 08:32:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C9E3240126;
	Wed, 20 Apr 2022 08:32:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4e3ybOyiYTNd; Wed, 20 Apr 2022 08:32:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 83DFE40103;
	Wed, 20 Apr 2022 08:32:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 588DEC002F;
	Wed, 20 Apr 2022 08:32:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5F646C002C
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 08:32:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3BB3A419AE
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 08:32:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z5eV_PPBYtBr for <iommu@lists.linux-foundation.org>;
 Wed, 20 Apr 2022 08:32:13 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 23CD7409DE
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 08:32:12 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id u7so1515422lfs.8
 for <iommu@lists.linux-foundation.org>; Wed, 20 Apr 2022 01:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GPxsA15dgGFa86oqnVuniKPo2oEPXdNE69XGNs7GEZ4=;
 b=biTEx2Cij71YqsgTogTpKJ8RDg3A4KiMWrobTDx7XvAfIcXCkppoYtn+feizM0q9bN
 qHO57uy1m2cSKYzDI5swmGJKnDovfPekAfPti7mvLhItxH6otCLSJPr4QLXicY4A6xDH
 RA0K6hcuvmlowJsHqtKzeRXi8AOtCaC1wPOtyEO0s2TTTLa6xVkzSOf1iHgDAfrLNwSC
 j+6be8/t8BQfIuOrjfRiJ9ctDYQtCIjd3KMngyqzwwCAlBQJrol4lwCPWdW+tbS7dJjW
 dmtEUBnSJBc3pqPyfGW+ijjDecQ6/FNNxHCkY2vW14FDi1gdpG6EhyRfJhrpzC4o+7tm
 p/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GPxsA15dgGFa86oqnVuniKPo2oEPXdNE69XGNs7GEZ4=;
 b=A9pcDETDp8ZKBnhnUDB5OuOlnNqj0f3E9Bt1Ec3qkQaLYweQACmGFme48OP8cqV8d8
 uH0X81t4LliOlRUGhfrvv8v511CMJYhMlVkJ5z/ysK+gLK1vI6OpGJuhEKjy/zBdjdY+
 hbrdDfX5zEOWlGw8FbbLqBvCLHGKyB4zTFF8qCb1kVMjvg22RDLdzuUv42WUuvJdzhlw
 Jz1bjSYM7IRB/veuAPyvWggsohjDnNdzKPV2UVOBpXXCQqNZhwG2Hkd58lEvBFAwj+gA
 3Yx9DPcPisvGpDeZY5yGntAJFrqEUUM+KT9sHyQbYimLY7ynj+UwZDRNlI/uvfuEGil8
 +mvg==
X-Gm-Message-State: AOAM533sQ1LtA4lmWUYJ7+Hk0I/AhmJ4RXb4g0WG1Q8EzG9RaTezgLGE
 DLLYiuFhws2Is+oLCiSMECw=
X-Google-Smtp-Source: ABdhPJztYLKaiAxqjABpHrtgdItpQMSKM4Eb7T9hX03BL4ZnheHxygmEy6brIUNd9V0l6eu8Ju2c+w==
X-Received: by 2002:ac2:4e66:0:b0:46b:c3d3:e203 with SMTP id
 y6-20020ac24e66000000b0046bc3d3e203mr14527874lfs.380.1650443530951; 
 Wed, 20 Apr 2022 01:32:10 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
 by smtp.gmail.com with ESMTPSA id
 bu20-20020a056512169400b0043eaf37af75sm1755570lfb.199.2022.04.20.01.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Apr 2022 01:32:10 -0700 (PDT)
Date: Wed, 20 Apr 2022 11:32:07 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/25] dma-direct: take dma-ranges/offsets into account
 in resource mapping
Message-ID: <20220420083207.pd3hxbwezrm2ud6x@mobilestation>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru>
 <0baff803-b0ea-529f-095a-897398b4f63f@arm.com>
 <20220417224427.drwy3rchwplthelh@mobilestation>
 <20220420071217.GA5152@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220420071217.GA5152@lst.de>
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

On Wed, Apr 20, 2022 at 09:12:17AM +0200, Christoph Hellwig wrote:
> On Mon, Apr 18, 2022 at 01:44:27AM +0300, Serge Semin wrote:
> > > but a DMA controller might also want to access something in the MMIO range
> > > 0x0-0x7fffffff, of which it still has an identical non-offset view. If a
> > > driver was previously using dma_map_resource() for that, it would now start
> > > getting DMA_MAPPING_ERROR because the dma_range_map exists but doesn't
> > > describe the MMIO region. I agree that in hindsight it's not an ideal
> > > situation, but it's how things have ended up, so at this point I'm wary of
> > > making potentially-breaking changes.
> > 
> > Hmm, what if the driver was previously using for instance the
> > dma_direct_map_sg() method for it?
> 

> dma_map_resource is for mapping MMIO space, and must not be called on
> memory in the kernel map.  For dma_map_sg (or all the other dma_map_*
> interface except for dma_map_resource), the reverse is true.

I've got it from the Robin comment. Exactly that part seems very much
confusing to me, because what you say doesn't cohere with the passed
address type. If the passed address belongs to the MMIO space and is a
part of the CPU physical address space, then it is supposed to be
visible by the CPU as is (see the very first diagram in [1]). So the
mapping performed in the dma_map_resource() and dma_map_sg() methods
is supposed to match. Otherwise the spaces you are talking about are
different and as such need to be described by different types. Since
what you are talking about more seem like a DMA address space, then the
dma_map_resource() address needs to have the dma_addr_t type instead
of the phys_addr_t.

BTW here is a brightest example of a system, which contradicts the
MMIO-specific mapping semantics you are talking about (it actually
matches to what we've got except some interconnect implementation
peculiarities):

              +-----+
              | DDR |
              +--+--+
                 |
  +-----+ +------+-------+ +---------+
  | CPU +-+ Interconnect +-+ DEVs... |
  +-----+ +-----^-+------+ +---------+
     dma-ranges-| |-ranges
              +-+-v-+
              | PCI |
              +-----+

See, if I get to map a virtual memory address to be accessible by any
PCIe peripheral device, then the dma_map_sg/dma_map_page/etc
procedures will take the PCIe host controller dma-ranges into account.
It will work as expected and the PCIe devices will see the memory what
I specified. But if I get to pass the physical address of the same
page or a physical address of some device of the DEVs space to the
dma_map_resource(), then the PCIe dma-ranges won't be taken into
account, and the result mapping will be incorrect. That's why the
current dma_map_resource() implementation seems very confusing to me.
As I see it phys_addr_t is the type of the Interconnect address space,
meanwhile dma_addr_t describes the PCIe, DEVs address spaces.

Based on what I said here and in my previous email could you explain
what do I get wrong?

[1] Documentation/core-api/dma-api-howto.rst

-Sergey

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
