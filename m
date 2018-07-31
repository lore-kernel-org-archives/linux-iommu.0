From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: use the generic dma-noncoherent code for sh V2
Date: Tue, 31 Jul 2018 15:25:46 +0200
Message-ID: <CAK8P3a0ZsU=qKhA2ux0X1Zqo0aD6d9T8wnwc5Kr9T6wbsGp2fw@mail.gmail.com>
References: <20180724120147.15096-1-hch@lst.de> <20180724202115.GA4685@lst.de>
 <18df6608-61c1-963d-bb1a-d46320232f40@landley.net> <20180730090648.GA18361@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180730090648.GA18361@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Rob Landley <rob@landley.net>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, Jacopo Mondi <jacopo+renesas@jmondi.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 30, 2018 at 11:06 AM, Christoph Hellwig <hch@lst.de> wrote:
> On Fri, Jul 27, 2018 at 11:20:21AM -0500, Rob Landley wrote:
>> Speaking of DMA:
>
> Which really has nothing to do with the dma mapping code, which
> also means I can't help you much unfortunately.
>
> That being said sh is the last pending of the initial dma-noncoherent
> conversion, I'd greatly appreciate if we could get this reviewed and
> merge for the 4.19 merge window..

I've spent 30 minutes looking through your submission to find something
wrong with it now, but it all looks fine, the only criticism would be that
some of the changelogs could provide a little more background.

The original implementation seems odd in some places, but your
new version resolves the few concerns I had (like mixing up
phys and dma addresses), and I didn't see anything that should
change behavior.

I hope that helps.

      Arnd
