Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8FBC433FE
	for <iommu@archiver.kernel.org>; Sun, 17 Apr 2022 22:44:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18ED161066;
	Sun, 17 Apr 2022 22:44:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T08SLPjNWKeI; Sun, 17 Apr 2022 22:44:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8FDD86105A;
	Sun, 17 Apr 2022 22:44:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D410C002F;
	Sun, 17 Apr 2022 22:44:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10820C002C
 for <iommu@lists.linux-foundation.org>; Sun, 17 Apr 2022 22:44:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 06D7C8198A
 for <iommu@lists.linux-foundation.org>; Sun, 17 Apr 2022 22:44:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8U3NUti2Kpph for <iommu@lists.linux-foundation.org>;
 Sun, 17 Apr 2022 22:44:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5D89A818EC
 for <iommu@lists.linux-foundation.org>; Sun, 17 Apr 2022 22:44:33 +0000 (UTC)
Received: by mail-lf1-x12b.google.com with SMTP id g19so7964965lfv.2
 for <iommu@lists.linux-foundation.org>; Sun, 17 Apr 2022 15:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=LwL2vU1Y4rEx7fp4xQ0NE5LHa6S7wIIRHWsweJHp/S4=;
 b=ZsoCe5DKL9mci/5LWRa9uhnGnGq1TiCOQqdzpP++sO6v7oToeLpHXVV5twJYSMZnYg
 thDQYvQFp5DnOztILW6Rp6gN7hndgG/H4qELH4bkhn0p7xQaq5H1xngphhX2g4X4hlEe
 39dcsTdofp+7Bp3Z5rK1xtmoGgaUZtqaAkzIT74DGEZu2OrzHkzkY2y5Xdrv0ixwAejc
 vkOtTyBCwp+JrcjHE7pDYi3vzvGv/idgEtaiiqjmMUfFOD4uPu1lYg6yYvx7orhZhVOT
 idScYVkM38kKRrVt5MU1EYo16Ti82yfWwnM3nYFwgR5vOISv6FUVEO/Mu2v7ghTcgbTR
 lufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=LwL2vU1Y4rEx7fp4xQ0NE5LHa6S7wIIRHWsweJHp/S4=;
 b=5z8ZlCcbNJ0KomEh54JMPQG1Es+Gs0gixdMwCj5vrHVgZzy3hhWw22UHUV2kEFL6Xd
 r7L6SJQFsgjbZPcBurn4DvYNWNowgv+4T8/3ssVAU2NrPr0fAcNNRuD5iM0nXwk/LNR1
 Fh4tfVk9lLdv7z31wWXawi7/0vBzSKaZNOhzqOAfEwtRFIzMWeOppyxGLTMPpy8UnU2F
 Ap2/iPv5jPXz8UYH4A/il7FreMDvnK+7/a72VKptkanQsOBpSrTPfnHErHhB+cFR40Fh
 9hJSz3ms/oPED/R7NdupGak8q99D+e4jBKgbFQd3eUHheIMLxbJWg+4sXxABKj+FwPU0
 qOcA==
X-Gm-Message-State: AOAM532pyPpvFEbVVroSP8AK8NePaBNB3npfA9e0aImetxMZH0Iy4mvl
 8hHi5SMlzRlfiaVOfdK+Vj4=
X-Google-Smtp-Source: ABdhPJxfCZ025Rb0Mmt+KK32rkLcgRudACwrJ59+qDkBk8mPNNZB23XjVp0tlcuQ4buww1w/hql4Cw==
X-Received: by 2002:a05:6512:1329:b0:44b:6f2:6444 with SMTP id
 x41-20020a056512132900b0044b06f26444mr5996703lfu.529.1650235470821; 
 Sun, 17 Apr 2022 15:44:30 -0700 (PDT)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
 by smtp.gmail.com with ESMTPSA id
 g15-20020a056512118f00b0044a835fd17esm1040254lfr.162.2022.04.17.15.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Apr 2022 15:44:30 -0700 (PDT)
Date: Mon, 18 Apr 2022 01:44:27 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 03/25] dma-direct: take dma-ranges/offsets into account
 in resource mapping
Message-ID: <20220417224427.drwy3rchwplthelh@mobilestation>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru>
 <0baff803-b0ea-529f-095a-897398b4f63f@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0baff803-b0ea-529f-095a-897398b4f63f@arm.com>
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

Hello Robin.

Sorry for the delayed answer. My comments are below.

On Thu, Mar 24, 2022 at 11:30:38AM +0000, Robin Murphy wrote:
> On 2022-03-24 01:48, Serge Semin wrote:
> > A basic device-specific linear memory mapping was introduced back in
> > commit ("dma: Take into account dma_pfn_offset") as a single-valued offset
> > preserved in the device.dma_pfn_offset field, which was initialized for
> > instance by means of the "dma-ranges" DT property. Afterwards the
> > functionality was extended to support more than one device-specific region
> > defined in the device.dma_range_map list of maps. But all of these
> > improvements concerned a single pointer, page or sg DMA-mapping methods,
> > while the system resource mapping function turned to miss the
> > corresponding modification. Thus the dma_direct_map_resource() method now
> > just casts the CPU physical address to the device DMA address with no
> > dma-ranges-based mapping taking into account, which is obviously wrong.
> > Let's fix it by using the phys_to_dma_direct() method to get the
> > device-specific bus address from the passed memory resource for the case
> > of the directly mapped DMA.
> 

> It may not have been well-documented at the time, but this was largely
> intentional. The assumption based on known systems was that where
> dma_pfn_offset existed, it would *not* apply to peer MMIO addresses.

Well, I'd say it wasn't documented or even discussed at all. At least
after a pretty much comprehensive retrospective research I failed to
find any note about the reason of having all the dma_direct_map*()
methods converted to supporting the dma_pfn_offset/dma_range_map
ranges, but leaving the dma_direct_map_resource() method out of that
conversion. Neither it is immediately inferable from the method usage
and its prototype that it is supposed to be utilized for the DMA
memory addresses, not the CPU one.

> 
> For instance, DTs for TI Keystone 2 platforms only describe an offset for
> RAM:
> 
> 	dma-ranges = <0x80000000 0x8 0x00000000 0x80000000>;
> 
> but a DMA controller might also want to access something in the MMIO range
> 0x0-0x7fffffff, of which it still has an identical non-offset view. If a
> driver was previously using dma_map_resource() for that, it would now start
> getting DMA_MAPPING_ERROR because the dma_range_map exists but doesn't
> describe the MMIO region. I agree that in hindsight it's not an ideal
> situation, but it's how things have ended up, so at this point I'm wary of
> making potentially-breaking changes.

Hmm, what if the driver was previously using for instance the
dma_direct_map_sg() method for it? Following this logic you would have
needed to decline the whole dma_pfn_offset/dma_range_map ranges
support, since the dma_direct_map_sg(), dma_direct_map_page(),
dma_direct_alloc*() methods do take the offsets into account. What we
can see now is that the same physical address will be differently
mapped by the dma_map_resource() and, for instance, dma_map_sg()
methods. All of these methods expect to have the "phys_addr_t" address
passed, which is the CPU address, not the DMA one. Doesn't that look
erroneous? IIUC in accordance with the common kernel definition the
"resource" suffix indicates the CPU-visible address (like struct
resource range), not the DMA address. No matter whether it's used to
describe the RAM or MMIO range.

AFAICS the dma_range_map just defines the offset-based DMA-to-CPU
mapping for the particular bus/device. If the device driver already
knows the DMA address why does it need to map it at all? I see some
contradiction here.

> 
> May I ask what exactly your setup looks like, if you have a DMA controller
> with an offset view of its "own" MMIO space?

I don't have such. But what I see here is either the wrong
dma_direct_map_resource() implementation or a redundant mapping
performed in some platforms/DMA-device drivers. Indeed judging by the
dma_map_resource() method declaration it expects to have the
CPU-address passed, which will be mapped in accordance with the
"dma-ranges"-based DMA-to-CPU memory mapping in the same way as the
rest of the dma_direct-family methods. If DMA address is already known
then it is supposed to be used as-is with no any additional remapping
procedure performed.

The last but not least regarding the DMA controllers and the
dma_map_resource() usage. The dma_slave_config structure was converted
to having the CPU-physical src/dst address specified in commit
9575632052ba ("dmaengine: make slave address physical"). So the DMA
client drivers now have to set the slave source and destination
addresses defined in the CPU address space, while the DMA engine
driver needs to map it in accordance with the platform/device specific
configs.

To sum up as I see it the problem is in the dma_map_resource()
semantics still exist. The semantic isn't documented in any way while
its implementation looks confusing. You say that the method
expects to have the DMA address passed, but at the same
time it has the phys_addr argument of the phys_addr_t type. If it had
dma_addr_t type instead that would have been much less confusing.
Could you clarify whether my considerations above are wrong and in what
aspect?

-Sergey

> 
> Thanks,
> Robin.
> 
> > Fixes: 25f1e1887088 ("dma: Take into account dma_pfn_offset")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >   kernel/dma/direct.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 50f48e9e4598..9ce8192b29ab 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -497,7 +497,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
> >   dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
> >   		size_t size, enum dma_data_direction dir, unsigned long attrs)
> >   {
> > -	dma_addr_t dma_addr = paddr;
> > +	dma_addr_t dma_addr = phys_to_dma_direct(dev, paddr);
> >   	if (unlikely(!dma_capable(dev, dma_addr, size, false))) {
> >   		dev_err_once(dev,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
