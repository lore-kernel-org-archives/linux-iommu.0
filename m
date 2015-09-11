From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v7 15/17] KVM: Update Posted-Interrupts Descriptor when
 vCPU is blocked
Date: Fri, 11 Sep 2015 13:21:22 +0200
Message-ID: <55F2B932.4030707@redhat.com>
References: <1440492620-15934-1-git-send-email-feng.wu@intel.com>
 <1440492620-15934-16-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1440492620-15934-16-git-send-email-feng.wu@intel.com>
Sender: kvm-owner@vger.kernel.org
To: Feng Wu <feng.wu@intel.com>, alex.williamson@redhat.com, joro@8bytes.org, mtosatti@redhat.com
Cc: eric.auger@linaro.org, kvm@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org



On 25/08/2015 10:50, Feng Wu wrote:
> This patch updates the Posted-Interrupts Descriptor when vCPU
> is blocked.
> 
> pre-block:
> - Add the vCPU to the blocked per-CPU list
> - Set 'NV' to POSTED_INTR_WAKEUP_VECTOR
> 
> post-block:
> - Remove the vCPU from the per-CPU list
> 
> Signed-off-by: Feng Wu <feng.wu@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |   5 ++
>  arch/x86/kvm/vmx.c              | 151 ++++++++++++++++++++++++++++++++++++++++
>  arch/x86/kvm/x86.c              |  55 ++++++++++++---
>  include/linux/kvm_host.h        |   3 +
>  virt/kvm/kvm_main.c             |   3 +
>  5 files changed, 207 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 22269b4..32af275 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -554,6 +554,8 @@ struct kvm_vcpu_arch {
>  	 */
>  	bool write_fault_to_shadow_pgtable;
>  
> +	bool halted;
> +
>  	/* set at EPT violation at this point */
>  	unsigned long exit_qualification;
>  
> @@ -868,6 +870,9 @@ struct kvm_x86_ops {
>  
>  	void (*pi_clear_sn)(struct kvm_vcpu *vcpu);
>  	void (*pi_set_sn)(struct kvm_vcpu *vcpu);
> +
> +	int (*pi_pre_block)(struct kvm_vcpu *vcpu);
> +	void (*pi_post_block)(struct kvm_vcpu *vcpu);

Just pre_block/post_block please.  Also, please document the return
value of pre_block.

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ef93fdc..fc7f222 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5869,7 +5869,13 @@ int kvm_vcpu_halt(struct kvm_vcpu *vcpu)
>  {
>  	++vcpu->stat.halt_exits;
>  	if (irqchip_in_kernel(vcpu->kvm)) {
> -		vcpu->arch.mp_state = KVM_MP_STATE_HALTED;
> +		/* Handle posted-interrupt when vCPU is to be halted */
> +		if (!kvm_x86_ops->pi_pre_block ||
> +		    (kvm_x86_ops->pi_pre_block &&

No need to test kvm_x86_ops->pi_pre_block again.

> +		    kvm_x86_ops->pi_pre_block(vcpu) == 0)) {
> +			vcpu->arch.halted = true;
> +			vcpu->arch.mp_state = KVM_MP_STATE_HALTED;
> +		}
>  		return 1;
>  	} else {
>  		vcpu->run->exit_reason = KVM_EXIT_HLT;
> @@ -6518,6 +6524,21 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  			kvm_vcpu_reload_apic_access_page(vcpu);
>  	}
>  
> +	/*
> +	 * Since posted-interrupts can be set by VT-d HW now, in this
> +	 * case, KVM_REQ_EVENT is not set. We move the following
> +	 * operations out of the if statement.
> +	 */

Just "KVM_REQ_EVENT is not set when posted interrupts are set by VT-d
hardware, so we have to update RVI unconditionally", please.

Could we skip this (in a future patch) if PI.ON=0?

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
> @@ -6534,13 +6555,6 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
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
> @@ -6711,10 +6725,31 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
>  
>  	for (;;) {
>  		if (vcpu->arch.mp_state == KVM_MP_STATE_RUNNABLE &&
> -		    !vcpu->arch.apf.halted)
> +		    !vcpu->arch.apf.halted) {
> +			/*
> +			 * For some cases, we can get here with
> +			 * vcpu->arch.halted being true.
> +			 */

Which cases?

Paolo

> +			if (kvm_x86_ops->pi_post_block && vcpu->arch.halted) {
> +				kvm_x86_ops->pi_post_block(vcpu);
> +				vcpu->arch.halted = false;
> +			}
> +
>  			r = vcpu_enter_guest(vcpu);
> -		else
> +		} else {
>  			r = vcpu_block(kvm, vcpu);
> +
> +			/*
> +			 * pi_post_block() must be called after
> +			 * pi_pre_block() which is called in
> +			 * kvm_vcpu_halt().
> +			 */
> +			if (kvm_x86_ops->pi_post_block && vcpu->arch.halted) {
> +				kvm_x86_ops->pi_post_block(vcpu);
> +				vcpu->arch.halted = false;
> +			}
> +		}
> +
>  		if (r <= 0)
>  			break;
>  
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index f4005dc..6aa69f4 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -233,6 +233,9 @@ struct kvm_vcpu {
>  	unsigned long requests;
>  	unsigned long guest_debug;
>  
> +	int pre_pcpu;
> +	struct list_head blocked_vcpu_list;
> +
>  	struct mutex mutex;
>  	struct kvm_run *run;
>  
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 8b8a444..191c7eb 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -220,6 +220,9 @@ int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id)
>  	init_waitqueue_head(&vcpu->wq);
>  	kvm_async_pf_vcpu_init(vcpu);
>  
> +	vcpu->pre_pcpu = -1;
> +	INIT_LIST_HEAD(&vcpu->blocked_vcpu_list);
> +
>  	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
>  	if (!page) {
>  		r = -ENOMEM;
> 
