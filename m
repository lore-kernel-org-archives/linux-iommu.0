From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [v3 25/26] KVM: Suppress posted-interrupt when 'SN' is set
Date: Wed, 17 Dec 2014 18:42:55 +0100
Message-ID: <5491C09F.9010409@redhat.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com> <1418397300-10870-26-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1418397300-10870-26-git-send-email-feng.wu@intel.com>
Sender: kvm-owner@vger.kernel.org
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, KVM list <kvm@vger.kernel.org>, Eric Auger <eric.auger@linaro.org>
List-Id: iommu@lists.linux-foundation.org



On 12/12/2014 16:14, Feng Wu wrote:
> Currently, we don't support urgent interrupt, all interrupts
> are recognized as non-urgent interrupt, so we cannot send
> posted-interrupt when 'SN' is set.

Can this happen?  If the vcpu is in guest mode, it cannot have been
scheduled out, and that's the only case when SN is set.

Paolo

> Signed-off-by: Feng Wu <feng.wu@intel.com>
> ---
>  arch/x86/kvm/vmx.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index a1c83a2..0aee151 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -4401,15 +4401,22 @@ static int vmx_vm_has_apicv(struct kvm *kvm)
>  static void vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> -	int r;
> +	int r, sn;
>  
>  	if (pi_test_and_set_pir(vector, &vmx->pi_desc))
>  		return;
>  
> +	/*
> +	 * Currently, we don't support urgent interrupt, all interrupts
> +	 * are recognized as non-urgent interrupt, so we cannot send
> +	 * posted-interrupt when 'SN' is set.
> +	 */
> +	sn = pi_test_sn(&vmx->pi_desc);
> +
>  	r = pi_test_and_set_on(&vmx->pi_desc);
>  	kvm_make_request(KVM_REQ_EVENT, vcpu);
>  #ifdef CONFIG_SMP
> -	if (!r && (vcpu->mode == IN_GUEST_MODE))
> +	if (!r && !sn && (vcpu->mode == IN_GUEST_MODE))
>  		apic->send_IPI_mask(get_cpu_mask(vcpu->cpu),
>  				POSTED_INTR_VECTOR);
>  	else
> -- 

