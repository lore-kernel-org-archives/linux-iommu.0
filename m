From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v7 02/17] KVM: Add some helper functions for
 Posted-Interrupts
Date: Fri, 11 Sep 2015 12:16:44 +0200
Message-ID: <55F2AA0C.4020209@redhat.com>
References: <1440492620-15934-1-git-send-email-feng.wu@intel.com>
 <1440492620-15934-3-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440492620-15934-3-git-send-email-feng.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Feng Wu <feng.wu@intel.com>, alex.williamson@redhat.com, joro@8bytes.org, mtosatti@redhat.com
Cc: eric.auger@linaro.org, kvm@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org



On 25/08/2015 10:50, Feng Wu wrote:
> This patch adds some helper functions to manipulate the
> Posted-Interrupts Descriptor.
> 
> Signed-off-by: Feng Wu <feng.wu@intel.com>
> ---
>  arch/x86/kvm/vmx.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 271dd70..316f9bf 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -443,6 +443,8 @@ struct nested_vmx {
>  };
>  
>  #define POSTED_INTR_ON  0
> +#define POSTED_INTR_SN  1
> +
>  /* Posted-Interrupt Descriptor */
>  struct pi_desc {
>  	u32 pir[8];     /* Posted interrupt requested */
> @@ -483,6 +485,30 @@ static int pi_test_and_set_pir(int vector, struct pi_desc *pi_desc)
>  	return test_and_set_bit(vector, (unsigned long *)pi_desc->pir);
>  }
>  
> +static void pi_clear_sn(struct pi_desc *pi_desc)
> +{
> +	return clear_bit(POSTED_INTR_SN,
> +			(unsigned long *)&pi_desc->control);
> +}
> +
> +static void pi_set_sn(struct pi_desc *pi_desc)
> +{
> +	return set_bit(POSTED_INTR_SN,
> +			(unsigned long *)&pi_desc->control);
> +}
> +
> +static int pi_test_on(struct pi_desc *pi_desc)
> +{
> +	return test_bit(POSTED_INTR_ON,
> +			(unsigned long *)&pi_desc->control);
> +}
> +
> +static int pi_test_sn(struct pi_desc *pi_desc)
> +{
> +	return test_bit(POSTED_INTR_SN,
> +			(unsigned long *)&pi_desc->control);
> +}
> +
>  struct vcpu_vmx {
>  	struct kvm_vcpu       vcpu;
>  	unsigned long         host_rsp;
> 

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
