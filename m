From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v3 16/26] KVM: Make struct kvm_irq_routing_table accessible
Date: Fri, 19 Dec 2014 23:39:34 +0000
Message-ID: <E959C4978C3B6342920538CF579893F00230CFC3@SHSMSX104.ccr.corp.intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
	<1418397300-10870-17-git-send-email-feng.wu@intel.com>
	<5491ACA9.5020507@redhat.com>
	<E959C4978C3B6342920538CF579893F00230A97C@SHSMSX104.ccr.corp.intel.com>
	<5494132C.7060204@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5494132C.7060204-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Paolo Bonzini [mailto:paolo.bonzini-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] On Behalf Of Paolo
> Bonzini
> Sent: Friday, December 19, 2014 8:00 PM
> To: Wu, Feng; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [v3 16/26] KVM: Make struct kvm_irq_routing_table accessible
> 
> 
> 
> On 19/12/2014 03:19, Wu, Feng wrote:
> >>> > >
> >>> > > +#ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
> >>> > > +
> >>> > > +struct kvm_irq_routing_table {
> >>> > > +	int chip[KVM_NR_IRQCHIPS][KVM_IRQCHIP_NUM_PINS];
> >>> > > +	struct kvm_kernel_irq_routing_entry *rt_entries;
> >>> > > +	u32 nr_rt_entries;
> >>> > > +	/*
> >>> > > +	 * Array indexed by gsi. Each entry contains list of irq chips
> >>> > > +	 * the gsi is connected to.
> >>> > > +	 */
> >>> > > +	struct hlist_head map[0];
> >>> > > +};
> >>> > > +
> >>> > > +#else
> >>> > > +
> >>> > > +struct kvm_irq_routing_table {};
> >> >
> >> > If possible, just make this "struct kvm_irq_routing_table;" and pull
> >> > this line to include/linux/kvm_types.h.
> >> >
> >> > Paolo
> > Do you mean move the definition of struct kvm_irq_routing_table
> > to include/linux/kvm_types.h and add a declaration here?
> 
> Move
> 
> struct kvm_irq_routing_table;
> 
> to include/linux/kvm_types.h.  In kvm_host.h, leave the #ifdef with the
> full definition but drop the #else.
> 
> Paolo


Paolo, Thanks for the explanation. I notice that " struct kvm_irq_routing_table;"
is already in include/linux/kvm_types.h.

Thanks,
Feng
