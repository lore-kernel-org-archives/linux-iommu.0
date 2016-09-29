From: Konrad Rzeszutek Wilk <konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/1] arch/x86: Add CONFIG_IOMMU_DEFAULT_PT for iommu=pt
Date: Thu, 29 Sep 2016 14:20:47 -0400
Message-ID: <20160929182046.GA10202@localhost.localdomain>
References: <2ebef311-b346-f3ed-2fca-ce4715b84c9d@brocade.com>
	<20160929181150.GC9432@localhost.localdomain>
	<ed808649-22d6-8447-5ddb-5d19665b7fa3@brocade.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ed808649-22d6-8447-5ddb-5d19665b7fa3-43mecJUBy8ZBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Glenn Serre <gserre-yk0uUPyXz1dBDgjK7y7TUQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 29, 2016 at 11:18:34AM -0700, Glenn Serre wrote:
> Good morning,
> 
> On 09/29/2016 11:11 AM, Konrad Rzeszutek Wilk wrote:
> > On Thu, Sep 29, 2016 at 09:58:55AM -0700, Glenn Serre wrote:
> > > Add CONFIG_IOMMU_DEFAULT_PT for iommu=pt
> > > 
> > > Allow default to iommu=pt without adding to command line.
> > > Add iommu=nopt to turn off default.
> > 
> > What's the reason / use-case for it?
> 
> The top-level reason is we would prefer our kernel command line to not grow
> any larger than it already is.
> 

That:
> The reason we use iommu=pt is to support using the DPDK igb_uio driver,
> which we need to do on servers that have an iommu but lack ACS.
> 

Should be part of the commit description.


> Thanks,
> --Glenn S.
> 
> > 
> > > 
> > > Signed-off-by: Glenn Serre <gserre-43mecJUBy8ZBDgjK7y7TUQ@public.gmane.org>
> > > ---
> > >  Documentation/kernel-parameters.txt | 3 ++-
> > >  arch/x86/Kconfig                    | 7 +++++++
> > >  arch/x86/kernel/pci-dma.c           | 6 ++++++
> > >  3 files changed, 15 insertions(+), 1 deletion(-)
> > > 
> > > --- a/Documentation/kernel-parameters.txt
> > > +++ b/Documentation/kernel-parameters.txt
> > > @@ -1607,7 +1607,8 @@
> > >  		nomerge
> > >  		forcesac
> > >  		soft
> > > -		pt		[x86, IA-64]
> > > +		pt		[x86]
> > > +		nopt		[x86]
> > >  		nobypass	[PPC/POWERNV]
> > >  			Disable IOMMU bypass, using IOMMU for PCI devices.
> > > 
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -845,6 +845,15 @@
> > >  	def_bool y
> > >  	depends on CALGARY_IOMMU || GART_IOMMU || SWIOTLB || AMD_IOMMU
> > > 
> > > +config IOMMU_DEFAULT_PT
> > > +	int "Default iommu pt value (0-1)"
> > > +	range 0 1
> > > +	default "0"
> > > +	prompt "Set to 1 to default to iommu=pt"
> > > +	help
> > > +	  Setting this option to 1 will set iommu passthrough (iommu=pt)
> > > +	  by default.  Use iommu=nopt to override.
> > > +
> > >  config MAXSMP
> > >  	bool "Enable Maximum number of SMP Processors and NUMA Nodes"
> > >  	depends on X86_64 && SMP && DEBUG_KERNEL
> > > --- a/arch/x86/kernel/pci-dma.c
> > > +++ b/arch/x86/kernel/pci-dma.c
> > > @@ -43,7 +43,7 @@
> > >   * useful if a user wants to use an IOMMU only for KVM device assignment to
> > >   * guests and not for driver dma translation.
> > >   */
> > > -int iommu_pass_through __read_mostly;
> > > +int iommu_pass_through __read_mostly = CONFIG_IOMMU_DEFAULT_PT;
> > > 
> > >  extern struct iommu_table_entry __iommu_table[], __iommu_table_end[];
> > > 
> > > @@ -196,6 +196,8 @@
> > >  #endif
> > >  		if (!strncmp(p, "pt", 2))
> > >  			iommu_pass_through = 1;
> > > +		if (!strncmp(p, "nopt", 4))
> > > +			iommu_pass_through = 0;
> > > 
> > >  		gart_parse_options(p);
> > > 
> > > _______________________________________________
> > > iommu mailing list
> > > iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> > > https://urldefense.proofpoint.com/v2/url?u=https-3A__lists.linuxfoundation.org_mailman_listinfo_iommu&d=DQIBAg&c=IL_XqQWOjubgfqINi2jTzg&r=3biwyMBB1JD9rm0R5wqz7zcDVkNif9HJ5Pflrr18dkw&m=JAPHQW96EkN4p33Jc7yZG15XGwK_KprKNxbbQvkgJ1c&s=HSZCSWNkVn-60uhbA_07tZgukoQbP3zZAhU0con30VY&e=
