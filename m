From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] lib: Improve a size determination in seven functions
Date: Sun, 8 Oct 2017 12:49:26 +0200
Message-ID: <CAMuHMdWfhccS-SUXDQETse+MnzDVk1r6cOkxJxbFWzV7Xmt0ng@mail.gmail.com>
References: <9a81d82d-fb1b-38d3-1dbf-31e6bf4ff677@users.sourceforge.net> <3a32f0e7-75a2-857e-c63c-10d4b5942622@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3a32f0e7-75a2-857e-c63c-10d4b5942622@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: iommu@lists.linux-foundation.org, kasan-dev@googlegroups.com, Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Christoph Hellwig <hch@lst.de>, Daniel Mentz <danielmentz@google.com>, Dmitry Vyukov <dvyukov@google.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Philipp Reisner <philipp.reisner@linbit.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, LKML <linux-kernel@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Oct 7, 2017 at 7:50 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 7 Oct 2017 19:19:45 +0200
>
> Replace the specification of data structures by pointer dereferences
> as the parameter for the operator "sizeof" to make the corresponding size
> determination a bit safer according to the Linux coding style convention.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
