From: Sethi Varun-B16395 <B16395@freescale.com>
Subject: RE: [PATCH 3/3 v3] iommu/fsl: Freescale PAMU driver and IOMMU API
 implementation.
Date: Tue, 23 Oct 2012 11:35:56 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D223951@039-SN2MPN1-013.039d.mgd.msft.net>
References: <6AE080B68D46FC4BA2D2769E68D765B7081084A7@039-SN2MPN1-023.039d.mgd.msft.net>
	(from B04825@freescale.com on Mon Oct 22 16:18:07 2012)
 <1350949982.30970.11@snotra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1350949982.30970.11@snotra>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wood Scott-B07421 <B07421@freescale.com>, Tabi Timur-B04825 <B04825@freescale.com>
Cc: "joerg.roedel@amd.com" <joerg.roedel@amd.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, October 23, 2012 5:23 AM
> To: Tabi Timur-B04825
> Cc: Sethi Varun-B16395; joerg.roedel@amd.com; iommu@lists.linux-
> foundation.org; linuxppc-dev@lists.ozlabs.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 3/3 v3] iommu/fsl: Freescale PAMU driver and IOMMU
> API implementation.
> 
> On 10/22/2012 04:18:07 PM, Tabi Timur-B04825 wrote:
> > On Wed, Oct 17, 2012 at 12:32 PM, Varun Sethi
> > <Varun.Sethi@freescale.com> wrote:
> > > +}
> > > +
> > > +static unsigned long pamu_get_fspi_and_allocate(u32 subwin_cnt) {
> >
> > subwin_cnt should probably be an unsigned int.
> >
> > This function needs to be documented.  What value is being returned?
> 
> spaact offset (yes, this needs to be documented)
[Sethi Varun-B16395] Ok.

> 
> > > +/* This bitmap advertises the page sizes supported by PAMU hardware
> > > + * to the IOMMU API.
> > > + */
> > > +#define FSL_PAMU_PGSIZES       (~0xFFFUL)
> >
> > There should be a better way to define this.  ~(PAMU_PAGE_SIZE-1)
> > maybe?
> 
> Is it even true?  We don't support IOMMU pages larger than the SoC can
> address.
> 
> The (~0xFFFUL) version also discards some valid IOMMU page sizes on 32-
> bit kernels.  One use case for windows larger than the CPU virtual
> address space is creating one big identity-map window to effectively
> disable translation.  If we're to support that, the size of pgsize_bitmap
> will need to change as well.
> 
[Sethi Varun-B16395] Correct, this needs to be fixed. I will try to address this
In a separate patch (would require changes to iommu_map).

> > > +static int map_liodn(int liodn, struct fsl_dma_domain *dma_domain)
> > > +{
> > > +       u32 subwin_cnt = dma_domain->subwin_cnt;
> > > +       unsigned long rpn;
> > > +       int ret = 0, i;
> > > +
> > > +       if (subwin_cnt) {
> > > +               struct dma_subwindow *sub_win_ptr =
> > > +                                       &dma_domain->sub_win_arr[0];
> > > +               for (i = 0; i < subwin_cnt; i++) {
> > > +                       if (sub_win_ptr[i].valid) {
> > > +                               rpn = sub_win_ptr[i].paddr >>
> > > +                                        PAMU_PAGE_SHIFT,
> > > +                               spin_lock(&iommu_lock);
> > > +                               ret = pamu_config_spaace(liodn,
> > subwin_cnt, i,
> > > +
> > sub_win_ptr[i].size,
> > > +                                                        -1,
> > > +                                                        rpn,
> > > +
> > dma_domain->snoop_id,
> > > +
> > dma_domain->stash_id,
> > > +                                                        (i > 0) ?
> > 1 : 0,
> > > +
> > sub_win_ptr[i].prot);
> > > +                               spin_unlock(&iommu_lock);
> > > +                               if (ret) {
> > > +                                       pr_err("PAMU SPAACE
> > configuration failed for liodn %d\n",
> > > +                                                liodn);
> > > +                                       return ret;
> > > +                               }
> > > +                       }
> > > +               }
> 
> Break up that nesting with some subfunctions.
> 
> > > +       while (!list_empty(&dma_domain->devices)) {
> > > +               info = list_entry(dma_domain->devices.next,
> > > +                       struct device_domain_info, link);
> > > +               remove_domain_ref(info, dma_domain->subwin_cnt);
> > > +       }
> >
> > I wonder if you should use list_for_each_safe() instead.
> 
> The above is simpler if you're destroying the entire list.
> 
> > > +}
> > > +
> > > +static int configure_domain_dma_state(struct fsl_dma_domain
> > *dma_domain, int enable)
> >
> > bool enable
> >
> > Finally, please CC: me on all IOMMU and PAMU patches you post
> > upstream.
> 
> Me too.
[Sethi Varun-B16395] Sure.

-Varun
