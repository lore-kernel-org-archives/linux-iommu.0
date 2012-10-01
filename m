From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 14/16] iommu/irq: Use amd_iommu_irq_ops if supported
Date: Mon, 1 Oct 2012 10:08:42 +0200
Message-ID: <20121001080841.GN4009@amd.com>
References: <1348835046-3262-1-git-send-email-joerg.roedel@amd.com>
	<1348835046-3262-15-git-send-email-joerg.roedel@amd.com>
	<CAKocOONaiMJs7pWeWxO=_bN5_KU=jZh=kvL7U_v-w9LmSrQ+Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKocOONaiMJs7pWeWxO=_bN5_KU=jZh=kvL7U_v-w9LmSrQ+Fw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shuah Khan <shuahkhan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 28, 2012 at 05:39:03PM -0600, Shuah Khan wrote:
> On Fri, Sep 28, 2012 at 6:24 AM, Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org> wrote:
> >  void __init setup_irq_remapping_ops(void)
> >  {
> >         remap_ops = &intel_irq_remap_ops;
> > +
> > +#ifdef CONFIG_AMD_IOMMU
> > +       if (amd_iommu_irq_ops.prepare() == 0)
> > +               remap_ops = &amd_iommu_irq_ops;
> > +#endif
> 
> Should remap_ops be set to null when amd_iommu_irq_ops.prepare()
> fails?What happens if remap_ops left set to intel_irq_remap_ops?
> Should remap_ops = &intel_irq_remap_ops; moved into #else case
> forifdef CONFIG_AMD_IOMMU?

Remap-Ops does not need to be set to NULL because irq_remapping_enabled
will not get set to true then and remap_ops will not get called. The
Intel path can't also be moved to #else because this would mean that
kernels can only support eihter, Intel or AMD IOMMU. But Linux can
support both in the same kernel.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
