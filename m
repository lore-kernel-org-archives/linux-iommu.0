From: Bjorn Helgaas <bjorn.helgaas@gmail.com>
Subject: Re: [PATCH v1 4/7] iommu/vt-d: Remove unnecessary local variable initializations
Date: Sun, 10 Feb 2019 21:33:25 -0600
Message-ID: <CABhMZUUKe0b9RkscDX6WR0tpQmhW_nFoYKHTvthpKwZ4vMirOA@mail.gmail.com>
References: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <154966356809.132359.5318207850182898116.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <63ae370c-2239-62c5-2378-98916608acc4@linux.intel.com>
Reply-To: bjorn@helgaas.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <63ae370c-2239-62c5-2378-98916608acc4@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Sun, Feb 10, 2019 at 8:00 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Hi,
>
> On 2/9/19 6:06 AM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > A local variable initialization is a hint that the variable will be used in
> > an unusual way.  If the initialization is unnecessary, that hint becomes a
> > distraction.
> >
> > Remove unnecessary initializations.  No functional change intended.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >   drivers/iommu/intel-iommu.c |   27 +++++++++++++--------------
> >   1 file changed, 13 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 81077803880f..2acd08c82cdc 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -865,7 +865,7 @@ static void free_context_table(struct intel_iommu *iommu)
> >   static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
> >                                     unsigned long pfn, int *target_level)
> >   {
> > -     struct dma_pte *parent, *pte = NULL;
> > +     struct dma_pte *parent, *pte;
> >       int level = agaw_to_level(domain->agaw);
> >       int offset;
> >
> > @@ -922,7 +922,7 @@ static struct dma_pte *dma_pfn_level_pte(struct dmar_domain *domain,
> >                                        unsigned long pfn,
> >                                        int level, int *large_page)
> >   {
> > -     struct dma_pte *parent, *pte = NULL;
> > +     struct dma_pte *parent, *pte;
> >       int total = agaw_to_level(domain->agaw);
> >       int offset;
> >
> > @@ -954,7 +954,7 @@ static void dma_pte_clear_range(struct dmar_domain *domain,
> >                               unsigned long start_pfn,
> >                               unsigned long last_pfn)
> >   {
> > -     unsigned int large_page = 1;
> > +     unsigned int large_page;
> >       struct dma_pte *first_pte, *pte;
> >
> >       BUG_ON(!domain_pfn_supported(domain, start_pfn));
> > @@ -1132,7 +1132,7 @@ static struct page *domain_unmap(struct dmar_domain *domain,
> >                                unsigned long start_pfn,
> >                                unsigned long last_pfn)
> >   {
> > -     struct page *freelist = NULL;
> > +     struct page *freelist;
>
> I am afraid this change might cause problem. "freelist" might go through
> dma_pte_clear_level() without any touches.

Thanks for your review!  Can you clarify your concern?  "freelist"
isn't passed into dma_pte_clear_level().  Here's the existing code
(before this patch).  I don't see a use of "freelist" before we assign
the result of dma_pte_clear_level() to it.  But maybe I'm overlooking
something.

static struct page *domain_unmap(struct dmar_domain *domain,
                                 unsigned long start_pfn,
                                 unsigned long last_pfn)
{
        struct page *freelist = NULL;

        BUG_ON(!domain_pfn_supported(domain, start_pfn));
        BUG_ON(!domain_pfn_supported(domain, last_pfn));
        BUG_ON(start_pfn > last_pfn);

        /* we don't need lock here; nobody else touches the iova range */
        freelist = dma_pte_clear_level(domain, agaw_to_level(domain->agaw),
                                       domain->pgd, 0, start_pfn,
last_pfn, NULL);
