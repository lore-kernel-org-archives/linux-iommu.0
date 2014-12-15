From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: change IOMMU_EXEC to IOMMU_NOEXEC
Date: Mon, 15 Dec 2014 11:45:27 +0100
Message-ID: <CAMuHMdW9s+VKqz=TWV0H+cqNGY8amZsHAwHHSvM9q033sh-j3Q@mail.gmail.com>
References: <1418518503-20250-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1418518503-20250-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: iommu@lists.linux-foundation.org, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Joerg Roedel <joro@8bytes.org>, Antonios Motakis <a.motakis@virtualopensystems.com>
List-Id: iommu@lists.linux-foundation.org

Hi Laurent,

On Sun, Dec 14, 2014 at 1:55 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The IOMMU_EXEC flag has been renamed to IOMMU_NOEXEC by commit

... inverted and replaced by ...

At first I hadn't noticed this, and was wondering about the seemingly unrelated
change in the first hunk.

> a720b41c41f5a7e4 ("iommu/arm-smmu: change IOMMU_EXEC to IOMMU_NOEXEC").
> Update the driver accordingly.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> This fixes a build breakage in Linus' master branch introduce by the commit
> mentioned above.
>
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index e5ed0216929f..7a1bcf6627b6 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -558,7 +558,7 @@ static pmd_t *ipmmu_alloc_pmd(struct ipmmu_vmsa_device *mmu, pgd_t *pgd,
>
>  static u64 ipmmu_page_prot(unsigned int prot, u64 type)
>  {
> -       u64 pgprot = ARM_VMSA_PTE_XN | ARM_VMSA_PTE_nG | ARM_VMSA_PTE_AF
> +       u64 pgprot = ARM_VMSA_PTE_nG | ARM_VMSA_PTE_AF
>                    | ARM_VMSA_PTE_SH_IS | ARM_VMSA_PTE_AP_UNPRIV
>                    | ARM_VMSA_PTE_NS | type;
>
> @@ -568,8 +568,8 @@ static u64 ipmmu_page_prot(unsigned int prot, u64 type)
>         if (prot & IOMMU_CACHE)
>                 pgprot |= IMMAIR_ATTR_IDX_WBRWA << ARM_VMSA_PTE_ATTRINDX_SHIFT;
>
> -       if (prot & IOMMU_EXEC)
> -               pgprot &= ~ARM_VMSA_PTE_XN;
> +       if (prot & IOMMU_NOEXEC)
> +               pgprot |= ARM_VMSA_PTE_XN;
>         else if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
>                 /* If no access create a faulting entry to avoid TLB fills. */
>                 pgprot &= ~ARM_VMSA_PTE_PAGE;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
