From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 0/2] SWIOTLB fixes for 4.20
Date: Tue, 20 Nov 2018 11:24:18 -0800
Message-ID: <CALAqxLX5GPwce=oWh5nf2w8pjoCJUVkxCr7_hrqVVfYVHzx-fw@mail.gmail.com>
References: <cover.1542722463.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1542722463.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux-foundation.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 20, 2018 at 6:10 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> This is what I have so far, which at least resolves the most ovbious
> problems. I still haven't got very far with the USB corruption issue
> I see on Juno with -rc1, but I'm yet to confirm whether that's actually
> attributable to the SWIOTLB changes or something else entirely.
>
> Robin.
>
> Robin Murphy (2):
>   swiotlb: Make DIRECT_MAPPING_ERROR viable
>   swiotlb: Skip cache maintenance on map error
>
>  include/linux/dma-direct.h | 2 +-
>  kernel/dma/swiotlb.c       | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)

Thanks so much for chasing this down!

Unfortunately AOSP is giving me grief this week, so I've not been able
to test the full environment, but I don't seem to be hitting the io
hangs I was seeing earlier with this patch set.

For both:
  Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
