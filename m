From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] iommu: Use %zx instead %lx and cast to unsigned long
Date: Sun, 23 Jun 2013 21:14:36 +0200
Message-ID: <CAMuHMdWb4WK9ZuJ-vwdywgDSSbZTnnS1emF02VzrUgrSt5VKsg@mail.gmail.com>
References: <20130621153331.2881.35589.stgit@bling.home>
	<20130623114930.GA2557@8bytes.org>
	<1372009427.3137.54.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372009427.3137.54.camel@joe-AO722>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Sun, Jun 23, 2013 at 7:43 PM, Joe Perches <joe@perches.com> wrote:
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -807,20 +807,19 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
>          * size of the smallest page supported by the hardware
>          */
>         if (!IS_ALIGNED(iova | paddr | size, min_pagesz)) {
> -               pr_err("unaligned: iova 0x%lx pa 0x%lx size 0x%lx min_pagesz "
> -                       "0x%x\n", iova, (unsigned long)paddr,
> -                       (unsigned long)size, min_pagesz);
> +               pr_err("unaligned: iova 0x%lx pa 0x%lx size 0x%zx min_pagesz 0x%x\n",
> +                      iova, (unsigned long)paddr, size, min_pagesz);

While we're at it, paddr is phys_addr_t (which can be 32-bit or 64-bit),
so it should be cast to unsigned long long (instead of unsigned long),
and printed using %llx (instead of %lx).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
