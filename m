From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] [v3] dma-mapping: work around clang bug
Date: Fri, 8 Mar 2019 10:00:24 -0800
Message-ID: <CAKwvOdnvY2DbFv8-NHWF=MabKQwi80F3E+jZJYudJxJK8tELYA@mail.gmail.com>
References: <20190307104900.2506657-1-arnd@arndb.de> <20190308152732.GA20294@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190308152732.GA20294@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Robin Murphy <robin.murphy@arm.com>, Jesper Dangaard Brouer <brouer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Paul Burton <paul.burton@mips.com>, iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 8, 2019 at 7:27 AM Christoph Hellwig <hch@lst.de> wrote:
>
> NAK on this whole patch.  Please fix the compiler instead of making
> a complete mess of a common macro.

Definitely on the TODO list; higher priority, but not highest right
now.  I'll see if I can get some help with it.
-- 
Thanks,
~Nick Desaulniers
