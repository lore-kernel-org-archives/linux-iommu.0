From: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v7 16/17] KVM: Warn if 'SN' is set during posting
	interrupts by software
Date: Fri, 11 Sep 2015 12:59:03 +0200
Message-ID: <55F2B3F7.6000306@redhat.com>
References: <1440492620-15934-1-git-send-email-feng.wu@intel.com>
	<1440492620-15934-17-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1440492620-15934-17-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
> Currently, we don't support urgent interrupt, all interrupts
> are recognized as non-urgent interrupt, so we cannot post
> interrupts when 'SN' is set.
> 
> If the vcpu is in guest mode, it cannot have been scheduled out,
> and that's the only case when SN is set currently, warning if
> SN is set.
> 
> Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  arch/x86/kvm/vmx.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 64e35ea..eb640a1 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -4494,6 +4494,22 @@ static inline bool kvm_vcpu_trigger_posted_interrupt(struct kvm_vcpu *vcpu)
>  {
>  #ifdef CONFIG_SMP
>  	if (vcpu->mode == IN_GUEST_MODE) {
> +		struct vcpu_vmx *vmx = to_vmx(vcpu);
> +
> +		/*
> +		 * Currently, we don't support urgent interrupt,
> +		 * all interrupts are recognized as non-urgent
> +		 * interrupt, so we cannot post interrupts when
> +		 * 'SN' is set.
> +		 *
> +		 * If the vcpu is in guest mode, it means it is
> +		 * running instead of being scheduled out and
> +		 * waiting in the run queue, and that's the only
> +		 * case when 'SN' is set currently, warning if
> +		 * 'SN' is set.
> +		 */
> +		WARN_ON_ONCE(pi_test_sn(&vmx->pi_desc));
> +
>  		apic->send_IPI_mask(get_cpu_mask(vcpu->cpu),
>  				POSTED_INTR_VECTOR);
>  		return true;
> 

Reviewed-by: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
