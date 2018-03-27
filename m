From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dma-mapping: clearing GFP_ZERO flag caused crashes of Ethernet on
	arc/hsdk board.
Date: Tue, 27 Mar 2018 21:11:32 +0300
Message-ID: <CAHp75VeZSsdR1=ZhOM6jseYCP3m0GyE=8EjJUxWosze9BBw9rQ@mail.gmail.com>
References: <1522170774.2593.9.camel@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1522170774.2593.9.camel-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Evgeniy Didin <Evgeniy.Didin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: "jesper.nilsson-VrBV9hrLPhE@public.gmane.org" <jesper.nilsson-VrBV9hrLPhE@public.gmane.org>, Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org" <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, "dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Eugeniy Paltsev <Eugeniy.Paltsev-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>, "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 27, 2018 at 8:12 PM, Evgeniy Didin
<Evgeniy.Didin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org> wrote:
> Hello,
>
> After commit  57bf5a8963f8 ("dma-mapping: clear harmful GFP_* flags in common code")  we noticed problems with Ethernet controller on one of our platforms (namely ARC HSDK).
> I
> n particular we see that removal of __GFP_ZERO flag in function dma_alloc_attrs() was the culprit because in our implementation of arc_dma_alloc() we only allocate zeroed pages if
> that flag is explicitly set by the caller. Now with unconditional removal of that flag in dma_alloc_attrs() we allocate non-zeroed pages and that seem to cause problems.
>
> From
> mentioned commit message I may conclude that architectural code is supposed to always allocate zeroed pages but I cannot find any requirement of that in kernel's documentation.
> Coul
> d you please point me to that requirement if that exists at all, then we'll implement a fix in our arch code like that:

Can you elaborate what driver is in use?
stmmac with dwmac-anarion?

If so, this driver (w/o anarion parts, which I believe doesn't have
anything to do with this) is widely used on other platforms.
We have to see a lot of reports, though only one so far?

The logical question is why?

Another question why caller can't ask for zero pages explicitly?

P.S. Current kernel code shows only 3 use cases of GFP_ZERO. It seems
arm64 has something similar in mind.

> --------------------->8---------------------
> diff --git
> a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
> index 1dcc404b5aec..c92e518413aa 100644
> --- a/arch/arc/mm/dma.c
> +++ b/arch/arc/mm/dma.c
> @@ -30,7 +30,7 @@ static void *arc_dma_alloc(struct
> device *dev, size_t size,
>       void *kvaddr;
>       int need_coh = 1, need_kvaddr = 0;
>
> -       page = alloc_pages(gfp, order);
> +       page = alloc_pages(gfp | __GFP_ZERO, order);
>
> if (!page)
>               return NULL;
> --------------------->8---------------------
>
> Best regards,
> Evgeniy Didin



-- 
With Best Regards,
Andy Shevchenko
