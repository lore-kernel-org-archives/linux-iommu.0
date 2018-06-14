From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/2] dma-mapping: move all DMA mapping code to
        kernel/dma
Date: Thu, 14 Jun 2018 14:25:45 +0200
Message-ID: <20180614122545.GA27818@lst.de>
References: <20180614120029.27315-1-hch@lst.de> <20180614120029.27315-3-hch@lst.de> <CAHp75Vcpmx=GLU087Et+LA0_LOCF-xu1beKzb4iLxoOOi91Qmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vcpmx=GLU087Et+LA0_LOCF-xu1beKzb4iLxoOOi91Qmg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 14, 2018 at 03:13:46PM +0300, Andy Shevchenko wrote:
> For my point of view, makes sense!
> 
> > +config HAS_DMA
> > +       bool
> > +       depends on !NO_DMA
> > +       default y
> 
> I see it's just move from other file, though we might switch to
>   def_bool y
> instead of two lines.

Makes sense, but I'd rather send it together with a bunch of other
cleanups in that area for the 4.19 merge window.
