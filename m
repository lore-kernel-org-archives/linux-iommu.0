From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v7 10/17] KVM: x86: Update IRTE for posted-interrupts
Date: Wed, 26 Aug 2015 00:36:13 +0000
Message-ID: <E959C4978C3B6342920538CF579893F0026C44D6@SHSMSX104.ccr.corp.intel.com>
References: <1440492620-15934-1-git-send-email-feng.wu@intel.com>
	<1440492620-15934-11-git-send-email-feng.wu@intel.com>
	<1440532664.20355.9.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1440532664.20355.9.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> Sent: Wednesday, August 26, 2015 3:58 AM
> To: Wu, Feng
> Cc: pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org;
> eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH v7 10/17] KVM: x86: Update IRTE for posted-interrupts
> 
> On Tue, 2015-08-25 at 16:50 +0800, Feng Wu wrote:
> > This patch adds the routine to update IRTE for posted-interrupts
> > when guest changes the interrupt configuration.
> >
> > Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> > ---
> >  arch/x86/kvm/x86.c | 73
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> > +		kvm_set_msi_irq(e, &irq);
> > +		if (!kvm_intr_is_single_vcpu(kvm, &irq, &vcpu))
> > +			continue;
> > +
> > +		vcpu_info.pi_desc_addr = kvm_x86_ops->get_pi_desc_addr(vcpu);
> > +		vcpu_info.vector = irq.vector;
> > +
> > +		if (set)
> > +			ret = irq_set_vcpu_affinity(host_irq, &vcpu_info);
> > +		else {
> > +			/* suppress notification event before unposting */
> > +			kvm_x86_ops->pi_set_sn(vcpu);
> > +			ret = irq_set_vcpu_affinity(host_irq, NULL);
> > +			kvm_x86_ops->pi_clear_sn(vcpu);
> > +		}
> 
> Can we add trace events so that we have a way to tell when PI is being
> enabled/disabled other than performance heuristics?  Thanks,

Sure, I will add it.

Thanks,
Feng

> 
> Alex
> > 
> 
