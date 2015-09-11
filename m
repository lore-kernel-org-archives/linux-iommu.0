From: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 04/17] KVM: Get Posted-Interrupts descriptor address
	from 'struct kvm_vcpu'
Date: Fri, 11 Sep 2015 12:50:11 +0200
Message-ID: <55F2B1E3.8070009@redhat.com>
References: <1440492620-15934-1-git-send-email-feng.wu@intel.com>
	<1440492620-15934-5-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1440492620-15934-5-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, mtosatti-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 25/08/2015 10:50, Feng Wu wrote:
> Define an interface to get PI descriptor address from the vCPU structure.
> 
> Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

See the later review, this interface and the one in patch 5 is too
low-level.

Paolo

> ---
>  arch/x86/include/asm/kvm_host.h |  2 ++
>  arch/x86/kvm/vmx.c              | 11 +++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index af11bca..d50c1d3 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -858,6 +858,8 @@ struct kvm_x86_ops {
>  	void (*enable_log_dirty_pt_masked)(struct kvm *kvm,
>  					   struct kvm_memory_slot *slot,
>  					   gfn_t offset, unsigned long mask);
> +
> +	u64 (*get_pi_desc_addr)(struct kvm_vcpu *vcpu);
>  	/* pmu operations of sub-arch */
>  	const struct kvm_pmu_ops *pmu_ops;
>  };
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 316f9bf..81a995c 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -610,6 +610,10 @@ static inline struct vcpu_vmx *to_vmx(struct kvm_vcpu *vcpu)
>  #define FIELD64(number, name)	[number] = VMCS12_OFFSET(name), \
>  				[number##_HIGH] = VMCS12_OFFSET(name)+4
>  
> +struct pi_desc *vcpu_to_pi_desc(struct kvm_vcpu *vcpu)
> +{
> +	return &(to_vmx(vcpu)->pi_desc);
> +}
>  
>  static unsigned long shadow_read_only_fields[] = {
>  	/*
> @@ -4487,6 +4491,11 @@ static void vmx_sync_pir_to_irr_dummy(struct kvm_vcpu *vcpu)
>  	return;
>  }
>  
> +static u64 vmx_get_pi_desc_addr(struct kvm_vcpu *vcpu)
> +{
> +	return __pa((u64)vcpu_to_pi_desc(vcpu));
> +}
> +
>  /*
>   * Set up the vmcs's constant host-state fields, i.e., host-state fields that
>   * will not change in the lifetime of the guest.
> @@ -10460,6 +10469,8 @@ static struct kvm_x86_ops vmx_x86_ops = {
>  	.flush_log_dirty = vmx_flush_log_dirty,
>  	.enable_log_dirty_pt_masked = vmx_enable_log_dirty_pt_masked,
>  
> +	.get_pi_desc_addr = vmx_get_pi_desc_addr,
> +
>  	.pmu_ops = &intel_pmu_ops,
>  };
>  
> 
