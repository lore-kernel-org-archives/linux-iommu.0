From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: change IOMMU_EXEC to IOMMU_NOEXEC
Date: Mon, 15 Dec 2014 20:37:18 +0200
Message-ID: <4684279.HqCnjf9iNv@avalon>
References: <1418518503-20250-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<CAMuHMdW9s+VKqz=TWV0H+cqNGY8amZsHAwHHSvM9q033sh-j3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAMuHMdW9s+VKqz=TWV0H+cqNGY8amZsHAwHHSvM9q033sh-j3Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

On Monday 15 December 2014 11:45:27 Geert Uytterhoeven wrote:
> On Sun, Dec 14, 2014 at 1:55 AM, Laurent Pinchart wrote:
> > The IOMMU_EXEC flag has been renamed to IOMMU_NOEXEC by commit
> 
> ... inverted and replaced by ...
> 
> At first I hadn't noticed this, and was wondering about the seemingly
> unrelated change in the first hunk.

Good point. I'll submit a v2.

> > a720b41c41f5a7e4 ("iommu/arm-smmu: change IOMMU_EXEC to IOMMU_NOEXEC").
> > Update the driver accordingly.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> > ---
> > 
> >  drivers/iommu/ipmmu-vmsa.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > This fixes a build breakage in Linus' master branch introduce by the
> > commit mentioned above.
> > 
> > diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> > index e5ed0216929f..7a1bcf6627b6 100644
> > --- a/drivers/iommu/ipmmu-vmsa.c
> > +++ b/drivers/iommu/ipmmu-vmsa.c
> > @@ -558,7 +558,7 @@ static pmd_t *ipmmu_alloc_pmd(struct ipmmu_vmsa_device
> > *mmu, pgd_t *pgd,
> >  static u64 ipmmu_page_prot(unsigned int prot, u64 type)
> >  {
> > -       u64 pgprot = ARM_VMSA_PTE_XN | ARM_VMSA_PTE_nG | ARM_VMSA_PTE_AF
> > +       u64 pgprot = ARM_VMSA_PTE_nG | ARM_VMSA_PTE_AF
> >                    | ARM_VMSA_PTE_SH_IS | ARM_VMSA_PTE_AP_UNPRIV
> >                    | ARM_VMSA_PTE_NS | type;
> > @@ -568,8 +568,8 @@ static u64 ipmmu_page_prot(unsigned int prot, u64
> > type)
> >         if (prot & IOMMU_CACHE)
> >                 pgprot |= IMMAIR_ATTR_IDX_WBRWA <<
> >                 ARM_VMSA_PTE_ATTRINDX_SHIFT;
> > -       if (prot & IOMMU_EXEC)
> > -               pgprot &= ~ARM_VMSA_PTE_XN;
> > +       if (prot & IOMMU_NOEXEC)
> > +               pgprot |= ARM_VMSA_PTE_XN;
> >         else if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
> >                 /* If no access create a faulting entry to avoid TLB
> >                 fills. */
> >                 pgprot &= ~ARM_VMSA_PTE_PAGE;

-- 
Regards,

Laurent Pinchart
