From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3 v3] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Mon, 22 Oct 2012 18:53:02 -0500
Message-ID: <1350949982.30970.11@snotra>
References: <6AE080B68D46FC4BA2D2769E68D765B7081084A7@039-SN2MPN1-023.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6AE080B68D46FC4BA2D2769E68D765B7081084A7@039-SN2MPN1-023.039d.mgd.msft.net>
	(from B04825@freescale.com on Mon Oct 22 16:18:07 2012)
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: Sethi Varun-B16395 <B16395@freescale.com>, "joerg.roedel@amd.com" <joerg.roedel@amd.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 10/22/2012 04:18:07 PM, Tabi Timur-B04825 wrote:
> On Wed, Oct 17, 2012 at 12:32 PM, Varun Sethi  
> <Varun.Sethi@freescale.com> wrote:
> > +}
> > +
> > +static unsigned long pamu_get_fspi_and_allocate(u32 subwin_cnt)
> > +{
> 
> subwin_cnt should probably be an unsigned int.
> 
> This function needs to be documented.  What value is being returned?

spaact offset (yes, this needs to be documented)

> > +       unsigned long spaace_addr;
> > +
> > +       spaace_addr = gen_pool_alloc(spaace_pool, subwin_cnt *  
> sizeof(paace_t));
> > +       if (!spaace_addr)
> > +               return ULONG_MAX;
> 
> What's wrong with returning 0 on error?

0 is a valid spaact offset

> > +
> > +       return (spaace_addr - (unsigned long)spaact) /  
> (sizeof(paace_t));
> 
> Is this supposed to be a virtual address?  If so, then return void*
> instead of an unsigned long.

It's not a virtual address.  How often does subtraction followed by  
division result in a valid virtual address?

> > +int  pamu_update_paace_stash(int liodn, u32 subwin, u32 value)

Whitespace

> > +#define PAMU_PAGE_SHIFT 12
> > +#define PAMU_PAGE_SIZE  4096ULL
> 
> 4096ULL?  Why not just 4096?

This lets it be used in phys_addr_t expressions without needing casts
everywhere or dropping bits.

> > +/* This bitmap advertises the page sizes supported by PAMU hardware
> > + * to the IOMMU API.
> > + */
> > +#define FSL_PAMU_PGSIZES       (~0xFFFUL)
> 
> There should be a better way to define this.  ~(PAMU_PAGE_SIZE-1)  
> maybe?

Is it even true?  We don't support IOMMU pages larger than the SoC can
address.

The (~0xFFFUL) version also discards some valid IOMMU page sizes on
32-bit kernels.  One use case for windows larger than the CPU virtual
address space is creating one big identity-map window to effectively
disable translation.  If we're to support that, the size of  
pgsize_bitmap
will need to change as well.

> > +static int map_liodn(int liodn, struct fsl_dma_domain *dma_domain)
> > +{
> > +       u32 subwin_cnt = dma_domain->subwin_cnt;
> > +       unsigned long rpn;
> > +       int ret = 0, i;
> > +
> > +       if (subwin_cnt) {
> > +               struct dma_subwindow *sub_win_ptr =
> > +                                       &dma_domain->sub_win_arr[0];
> > +               for (i = 0; i < subwin_cnt; i++) {
> > +                       if (sub_win_ptr[i].valid) {
> > +                               rpn = sub_win_ptr[i].paddr >>
> > +                                        PAMU_PAGE_SHIFT,
> > +                               spin_lock(&iommu_lock);
> > +                               ret = pamu_config_spaace(liodn,  
> subwin_cnt, i,
> > +                                                         
> sub_win_ptr[i].size,
> > +                                                        -1,
> > +                                                        rpn,
> > +                                                         
> dma_domain->snoop_id,
> > +                                                         
> dma_domain->stash_id,
> > +                                                        (i > 0) ?  
> 1 : 0,
> > +                                                         
> sub_win_ptr[i].prot);
> > +                               spin_unlock(&iommu_lock);
> > +                               if (ret) {
> > +                                       pr_err("PAMU SPAACE  
> configuration failed for liodn %d\n",
> > +                                                liodn);
> > +                                       return ret;
> > +                               }
> > +                       }
> > +               }

Break up that nesting with some subfunctions.

> > +       while (!list_empty(&dma_domain->devices)) {
> > +               info = list_entry(dma_domain->devices.next,
> > +                       struct device_domain_info, link);
> > +               remove_domain_ref(info, dma_domain->subwin_cnt);
> > +       }
> 
> I wonder if you should use list_for_each_safe() instead.

The above is simpler if you're destroying the entire list.

> > +}
> > +
> > +static int configure_domain_dma_state(struct fsl_dma_domain  
> *dma_domain, int enable)
> 
> bool enable
> 
> Finally, please CC: me on all IOMMU and PAMU patches you post  
> upstream.

Me too.

-Scott
