From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/12] dma-mapping: improve selection of
 dma_declare_coherent availability
Date: Wed, 13 Feb 2019 19:24:35 +0100
Message-ID: <20190213182435.GA19906@lst.de>
References: <20190211133554.30055-1-hch@lst.de> <20190211133554.30055-7-hch@lst.de> <CAL_JsqL+LiJTF5kZz2hXGbQcH+D4U0jAQE376VSUVMQmdg=XFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAL_JsqL+LiJTF5kZz2hXGbQcH+D4U0jAQE376VSUVMQmdg=XFA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Linux IOMMU <iommu@lists.linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>, x86@kernel.org, arcml <linux-snps-arc@lists.infradead.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-mips@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-riscv@lists.infradead.org, SH-Linux <linux-sh@vger.kernel.org>, linux-xtensa@linux-xtensa.org, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 12, 2019 at 02:40:23PM -0600, Rob Herring wrote:
> > diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > index 3607fd2810e4..f8c66a9472a4 100644
> > --- a/drivers/of/Kconfig
> > +++ b/drivers/of/Kconfig
> > @@ -43,6 +43,7 @@ config OF_FLATTREE
> >
> >  config OF_EARLY_FLATTREE
> >         bool
> > +       select DMA_DECLARE_COHERENT
> 
> Is selecting DMA_DECLARE_COHERENT okay on UML? We run the unittests with UML.

No, that will fail with undefined references to memunmap.

I gues this needs to be

	select DMA_DECLARE_COHERENT if HAS_DMA

> Maybe we should just get rid of OF_RESERVED_MEM. If we support booting
> from DT, then it should always be enabled anyways.

Fine with me.  Do you want me to respin the series to just remove
it?
