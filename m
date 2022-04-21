Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B555C433EF
	for <iommu@archiver.kernel.org>; Thu, 21 Apr 2022 17:35:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2E37740961;
	Thu, 21 Apr 2022 17:35:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J3ty4uzkHB_p; Thu, 21 Apr 2022 17:35:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AA65F40906;
	Thu, 21 Apr 2022 17:35:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B91BC0033;
	Thu, 21 Apr 2022 17:35:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14610C002C
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 17:35:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 00B9740909
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 17:35:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IMrNcX87SKxw for <iommu@lists.linux-foundation.org>;
 Thu, 21 Apr 2022 17:35:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2BD440906
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 17:35:28 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id bn33so6634915ljb.6
 for <iommu@lists.linux-foundation.org>; Thu, 21 Apr 2022 10:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=CDk3a6VgKrZuT8ZcRh1/xIe6Q0/s0tC/sVKTkENgNak=;
 b=HeelgZvGa0y6CTancPNWQ6vJjNAi4x3ORh1p9cTFIepZtsgDrk5Ua6dZiycoOCMVcL
 c4GF4hlUa93OAG6fjFG70QF72SD6PrFkoHV1ild6F5WtUNjX56+ZucwjS8QgIhLBMVk9
 QpsHGI+ifnv0PcHajHaqLWcLbi6w0wTAcWOpYB3zsIgeoZ9PZxnuYeAEHKN8PiPUvTkW
 tk4m8PijCv/+ZhESRdi9DypwJQb5g+NPDE9hd2T+FtJN+xX+UabFM0JJlhzrTcsSEnaq
 LMZDZ1VM7onPn8PAGmVO+bscs7PfEfZGf9HRPC7G23BkqZwfoFO6cQHTQ2CHu1k4T6RK
 OdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CDk3a6VgKrZuT8ZcRh1/xIe6Q0/s0tC/sVKTkENgNak=;
 b=kOF56lG3KGu2B3rwCoFrgPMgGScr5DXeEjAtUdU6KuYzNwFmkIB80mivaKHr5thJqx
 1nRIEHLI1CrQ75BQzOJ3wd97wTMwf4Nr49Drza27Hnl2dv5fdnJybv331qxSeawiZCiy
 Sj4kV2/FcyCuYLomeSBt/c7ksigF4kNO5PMEVfHzuUt6FFK4WDGUVKq9nNcKTCh0lH3Y
 xx1LcsXWGkRfIyuiqJWgutR2eXeSkPEb8c+hxNQ08fV7q1HzMoYoXbWZlf3RbjoJlfi3
 94CZ8QWl29n4+zVkSSNlrV5clgGx0ukOukTN6t7pG6+in9V2DfgBWgYWObS1C5nWvH50
 pnrA==
X-Gm-Message-State: AOAM531DC6Pi4oOhge+JJ0EXyhbvumVsl3S+uprjIrPC0OhtRtszoZ4K
 Esn1Q1Roupi5w6C/Pzq5Pms=
X-Google-Smtp-Source: ABdhPJymumgPppR/Yl89vnqcwNccCGJXbwHpQ2AQqL54zDGwa3jfofsqs/k5W5r/iygpYJQNVkNePw==
X-Received: by 2002:a2e:9e10:0:b0:24b:5cb5:867c with SMTP id
 e16-20020a2e9e10000000b0024b5cb5867cmr458277ljk.401.1650562526246; 
 Thu, 21 Apr 2022 10:35:26 -0700 (PDT)
Received: from mobilestation ([95.79.183.147])
 by smtp.gmail.com with ESMTPSA id
 m20-20020a194354000000b0046f8c68f965sm2004975lfj.166.2022.04.21.10.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Apr 2022 10:35:25 -0700 (PDT)
Date: Thu, 21 Apr 2022 20:35:23 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/25] dma-direct: take dma-ranges/offsets into account
 in resource mapping
Message-ID: <20220421173523.ig62jtvj7qbno6q7@mobilestation>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru>
 <0baff803-b0ea-529f-095a-897398b4f63f@arm.com>
 <20220417224427.drwy3rchwplthelh@mobilestation>
 <20220420071217.GA5152@lst.de>
 <20220420083207.pd3hxbwezrm2ud6x@mobilestation>
 <20220420084746.GA11606@lst.de>
 <20220420085538.imgibqcyupvvjpaj@mobilestation>
 <20220421144536.GA23289@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220421144536.GA23289@lst.de>
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

On Thu, Apr 21, 2022 at 04:45:36PM +0200, Christoph Hellwig wrote:
> On Wed, Apr 20, 2022 at 11:55:38AM +0300, Serge Semin wrote:
> > On Wed, Apr 20, 2022 at 10:47:46AM +0200, Christoph Hellwig wrote:
> > > I can't really comment on the dma-ranges exlcusion for P2P mappings,
> > > as that predates my involvedment, however:
> > 
> > My example wasn't specific to the PCIe P2P transfers, but about PCIe
> > devices reaching some platform devices over the system interconnect
> > bus.
> 
> So strike PCIe, but this our definition of Peer to Peer accesses.
> 
> > What if I get to have a physical address of a platform device and want
> > have that device being accessed by a PCIe peripheral device? The
> > dma_map_resource() seemed very much suitable for that. But considering
> > what you say it isn't.
> 

> dma_map_resource is the right thing for that.  But the physical address
> of MMIO ranges in the platform device should not have struct pages
> allocated for it, and thus the other dma_map_* APIs should not work on
> it to start with.

The problem is that the dma_map_resource() won't work for that, but
presumably the dma_map_sg()-like methods will (after some hacking with
the phys address, but anyway). Consider the system diagram in my
previous email. Here is what I would do to initialize a DMA
transaction between a platform device and a PCIe peripheral device:

1) struct resource *rsc = platform_get_resource(plat_dev, IORESOURCE_MEM, 0);

2) dma_addr_t dar = dma_map_resource(&pci_dev->dev, rsc->start, rsc->end - rsc->start + 1,
                                      DMA_FROM_DEVICE, 0);

3) dma_addr_t sar;
   void *tmp = dma_alloc_coherent(&pci_dev->dev, PAGE_SIZE, &sar, GFP_KERNEL);
   memset(tmp, 0xaa, PAGE_SIZE);

4) PCIe device: DMA.DAR=dar, DMA.SAR=sar. RUN.

If there is no dma-ranges specified in the PCIe Host controller
DT-node, the PCIe peripheral devices will see the rest of the system
memory as is (no offsets and remappings). But if there is dma-ranges
with some specific system settings it may affect the PCIe MRd/MWr TLPs
address translation including the addresses targeted to the MMIO
space. In that case the mapping performed on step 2) will return a
wrong DMA-address since the corresponding dma_direct_map_resource()
just returns the passed physical address missing the
'pci_dev->dma_range_map'-based mapping performed in
translate_phys_to_dma().

Note the mapping on step 3) works correctly because it calls the
translate_phys_to_dma() of the direct DMA interface thus taking the
PCie dma-ranges into account.

To sum up as I see it either restricting dma_map_resource() to map
just the intra-bus addresses was wrong or there must be some
additional mapping infrastructure for the denoted systems. Though I
don't see a way the dma_map_resource() could be fixed to be suitable
for each considered cases.

-Sergey
   
map the platforms

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
