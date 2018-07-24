From: "Li, Philip" <philip.li@intel.com>
Subject: RE: [PATCH 4/5] sh: split arch/sh/mm/consistent.c
Date: Tue, 24 Jul 2018 12:11:18 +0000
Message-ID: <831EE4E5E37DCC428EB295A351E662494CC41594@shsmsx102.ccr.corp.intel.com>
References: <20180719130516.1989-1-hch@lst.de>
 <20180719130516.1989-5-hch@lst.de> <20180723084207.GI6784@w540>
 <CAMuHMdX=b0iAnDw1=85MXNBSMD=MxZb27QrO3rEWHYq0vB+3ow@mail.gmail.com>
 <20180724114334.GA21973@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724114334.GA21973@lst.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jacopo Mondi <jacopo@jmondi.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jacopo Mondi <jacopo+renesas@jmondi.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lkp <lkp@intel.com>
List-Id: iommu@lists.linux-foundation.org

> Subject: Re: [PATCH 4/5] sh: split arch/sh/mm/consistent.c
> 
> On Mon, Jul 23, 2018 at 10:49:39AM +0200, Geert Uytterhoeven wrote:
> > > > +     *dma_handle = virt_to_phys(ret);
> > > > +     if (!WARN_ON(!dev))
> > > > +             *dma_handle - PFN_PHYS(dev->dma_pfn_offset);
> > > vs
> > > > -     *dma_handle = virt_to_phys(ret);
> > > > -     if (!WARN_ON(!dev))
> > > > -             *dma_handle -= PFN_PHYS(dev->dma_pfn_offset);
> >
> > Doesn't look right to me, neither.
> >
> > No complaints for 0day? My gcc says:
> >
> >     error: statement with no effect [-Werror=unused-value]
> 
> For some reason 0day has failed me multiple times for sh.  Does the
> 0day bot even cover sh at all?
yes, we do cover the sh arch. Sorry for missing the reports for sh arch.

After check, for unknown reason, certain commit leads to large build error and makes
disc full, so that other sh builds are impacted (blocked). I will follow up this to see
how to solve the issue.

kernel/sh-allnoconfig/gcc-7# find -mindepth 1 -maxdepth 1|xargs -i du -sh {}
30G     ./f41ccf64b487381388c2b5ef8c13d79509dde76e
kernel/sh-rsk7269_defconfig/gcc-7# find -mindepth 1 -maxdepth 1|xargs -i du -sh {}
32G     ./f41ccf64b487381388c2b5ef8c13d79509dde76e

kernel/sh-rsk7269_defconfig/gcc-7/f41ccf64b487381388c2b5ef8c13d79509dde76e/build-error# ls
make-oldnoconfig
make-prepare
make-prepare.0
make-prepare.1
make-prepare.10
make-prepare.100
make-prepare.1000

Thanks
