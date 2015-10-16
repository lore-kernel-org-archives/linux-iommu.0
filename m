From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v9 17/18] KVM: Update Posted-Interrupts Descriptor when
	vCPU is blocked
Date: Fri, 16 Oct 2015 01:45:19 +0000
Message-ID: <E959C4978C3B6342920538CF579893F00ADDD8E4@SHSMSX104.ccr.corp.intel.com>
References: <1442586596-5920-1-git-send-email-feng.wu@intel.com>
	<1442586596-5920-18-git-send-email-feng.wu@intel.com>
	<CALzav=f8KhXswW-FCuKOYmWoih3QM3HMFHkGmQ3q9mnLoqg+hA@mail.gmail.com>
	<E959C4978C3B6342920538CF579893F00ADD7E55@SHSMSX104.ccr.corp.intel.com>
	<CALzav=d62jW7ZY3wn_-u6uhfvFXtCsvS_UoK2TPyZMvp=OPJpQ@mail.gmail.com>
	<561FECB7.6080503@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <561FECB7.6080503-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Matlack <dmatlack-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: kvm list <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marcelo Tosatti <mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Paolo Bonzini [mailto:paolo.bonzini-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org] On Behalf Of Paolo
> Bonzini
> Sent: Friday, October 16, 2015 2:13 AM
> To: David Matlack <dmatlack-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>; Wu, Feng <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>; Marcelo
> Tosatti <mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>; eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; kvm list
> <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH v9 17/18] KVM: Update Posted-Interrupts Descriptor when
> vCPU is blocked
> 
> 
> 
> On 15/10/2015 19:39, David Matlack wrote:
> > But after spending more time reading the source code this morning I
> > found that kvm_vcpu_check_block() eventually calls into
> > vmx_sync_pir_to_irr(), which copies PIR to IRR and clears ON. And then
> > apic_find_highest_irr() detects the pending posted interrupt.
> 
> Right.  And related to this, Feng, can you check if this is still
> necessary on kvm/queue:
> 
> @@ -6518,6 +6523,20 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  			kvm_vcpu_reload_apic_access_page(vcpu);
>  	}
> 
> +	/*
> +	 * KVM_REQ_EVENT is not set when posted interrupts are set by
> +	 * VT-d hardware, so we have to update RVI unconditionally.
> +	 */
> +	if (kvm_lapic_enabled(vcpu)) {
> +		/*
> +		 * Update architecture specific hints for APIC
> +		 * virtual interrupt delivery.
> +		 */
> +		if (kvm_x86_ops->hwapic_irr_update)
> +			kvm_x86_ops->hwapic_irr_update(vcpu,
> +				kvm_lapic_find_highest_irr(vcpu));
> +	}
> +
>  	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win) {
>  		kvm_apic_accept_events(vcpu);
>  		if (vcpu->arch.mp_state == KVM_MP_STATE_INIT_RECEIVED) {
> @@ -6534,13 +6553,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  			kvm_x86_ops->enable_irq_window(vcpu);
> 
>  		if (kvm_lapic_enabled(vcpu)) {
> -			/*
> -			 * Update architecture specific hints for APIC
> -			 * virtual interrupt delivery.
> -			 */
> -			if (kvm_x86_ops->hwapic_irr_update)
> -				kvm_x86_ops->hwapic_irr_update(vcpu,
> -					kvm_lapic_find_highest_irr(vcpu));
>  			update_cr8_intercept(vcpu);
>  			kvm_lapic_sync_to_vapic(vcpu);
>  		}
> 

I think the above code is needed, before the place where 'KVM_REQ_EVENT'
got checked in vcpu_enter_guest(), VT-d hardware can issue notification
event at any time. Consider the following scenario:

vcpu_run()
{
	......	
	
	for(;;) {
		point #1
		vcpu_enter_guest()
	}	

	point #2
}

For example, if we receive notification events issued by VT-d hardware at
point #1 and point#2, then enter vcpu_enter_guest() with 'KVM_REQ_EVENT'
not set, the interrupts cannot be delivered to guest during _this_ VM-Entry.

The point is that VT-d hardware can issue notification event at any time,
but it cannot set 'KVM_REQ_EVENT' like software does.

Maybe one thing we can do is only executing the following code when
vt-d pi is enabled,

 +	/*
 +	 * KVM_REQ_EVENT is not set when posted interrupts are set by
 +	 * VT-d hardware, so we have to update RVI unconditionally.
 +	 */
 +	if (kvm_lapic_enabled(vcpu)) {
 +		/*
 +		 * Update architecture specific hints for APIC
 +		 * virtual interrupt delivery.
 +		 */
 +		if (kvm_x86_ops->hwapic_irr_update)
 +			kvm_x86_ops->hwapic_irr_update(vcpu,
 +				kvm_lapic_find_highest_irr(vcpu));
 +	}
 +

And do this inside the KVM_REQ_EVENT check when VT-d PI is not enabled.

Thanks,
Feng

> 
> It may be obsolete now that we have the patch from Radim to set
> KVM_REQ_EVENT
> in vmx_sync_pir_to_irr
> (http://permalink.gmane.org/gmane.linux.kernel/2057138).
> 
> Thanks,
> 
> Paolo
