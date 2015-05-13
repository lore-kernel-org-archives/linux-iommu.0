From: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC PATCH] iommu: add ARM short descriptor page table allocator.
Date: Wed, 13 May 2015 10:52:43 +0800
Message-ID: <1431485563.4799.2.camel@mhfsdcap03>
References: <1430206881-18294-1-git-send-email-yong.wu@mediatek.com>
 <CABuKBeKupM0zmWu6T3g5omH7PRo9Oxp85bfpQVhC1ur16_dzvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CABuKBeKupM0zmWu6T3g5omH7PRo9Oxp85bfpQVhC1ur16_dzvg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: srv_heupstream <srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tomasz Figa <tfiga-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2015-05-12 at 11:15 +0200, Matthias Brugger wrote:
> 2015-04-28 9:41 GMT+02:00 Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>:
> > This patch is for ARM Short Descriptor Format.It has 2-levels
> > pagetable and the allocator supports 4K/64K/1M/16M.
> >
> > Signed-off-by: Yong Wu <yong.wu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
[snip]
> > +static phys_addr_t arm_short_iova_to_phys(struct io_pgtable_ops *ops,
> > +                                         unsigned long iova)
> > +{
> > +       struct arm_short_io_pgtable *data = io_pgtable_short_ops_to_data(ops);
> > +       arm_short_iopte *pte, *pgd = data->pgd;
> > +       phys_addr_t pa = 0;
> > +
> > +       pgd += ARM_SHORT_PGD_IDX(iova);
> > +
> > +       if (ARM_SHORT_F_PGD_TYPE_IS_PAGE(*pgd)) {
> > +               pte = arm_short_get_pte_in_pgd(*pgd, iova);
> > +
> > +               if (ARM_SHORT_F_PTE_TYPE_GET(*pte)
> > +                   == ARM_SHORT_F_PTE_TYPE_LARGE) {
> > +                       pa = (*pte) & ARM_SHORT_F_PTE_PA_LARGE_MSK;
> > +                       pa |= iova & (~ARM_SHORT_F_PTE_PA_LARGE_MSK);
> > +               } else if (ARM_SHORT_F_PTE_TYPE_GET(*pte)
> > +                          == ARM_SHORT_F_PTE_TYPE_SMALL) {
> 
> Would make it easier to read:
> u8 pte_type;
> 
> [...]
> 
> pte_type = ARM_SHORT_F_PTE_TYPE_GET(*pte)
> if (pte_type == ARM_SHORT_F_PTE_TYPE_LARGE) {
> [...]
> } else if (pte_type == ARM_SHORT_F_PTE_TYPE_SMALL) {
> [...]
Hi Matthias,
	Thanks for your review.I will fix this in next version.
