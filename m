From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [v3 25/26] KVM: Suppress posted-interrupt when 'SN' is set
Date: Thu, 18 Dec 2014 09:38:06 +0100
Message-ID: <5492926E.8070207@redhat.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>	<1418397300-10870-26-git-send-email-feng.wu@intel.com>	<5491C0A2.7040503@redhat.com> <E959C4978C3B6342920538CF579893F002307C4A@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <E959C4978C3B6342920538CF579893F002307C4A@SHSMSX104.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: iommu@lists.linux-foundation.org, kvm@vger.kernel.orgkvm@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org



On 18/12/2014 04:14, Wu, Feng wrote:
> 
> 
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org
>> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Paolo Bonzini
>> Sent: Thursday, December 18, 2014 1:43 AM
>> To: Wu, Feng; Thomas Gleixner; Ingo Molnar; H. Peter Anvin; x86@kernel.org;
>> Gleb Natapov; Paolo Bonzini; dwmw2@infradead.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; Alex
>> Williamson; Jiang Liu
>> Cc: iommu@lists.linux-foundation.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; KVM list;
>> Eric Auger
>> Subject: Re: [v3 25/26] KVM: Suppress posted-interrupt when 'SN' is set
>>
>>
>>
>> On 12/12/2014 16:14, Feng Wu wrote:
>>> Currently, we don't support urgent interrupt, all interrupts
>>> are recognized as non-urgent interrupt, so we cannot send
>>> posted-interrupt when 'SN' is set.
>>
>> Can this happen?  If the vcpu is in guest mode, it cannot have been
>> scheduled out, and that's the only case when SN is set.
>>
>> Paolo
> 
> Currently, the only place where SN is set is vCPU is preempted and waiting for
> the next scheduling in the runqueue. But I am not sure whether we need to
> set SN for other purpose in future. Adding SN checking here is just to follow
> the Spec. non-urgent interrupts are suppressed when SN is set.

I would change that to a WARN_ON_ONCE then.

Paolo

> Thanks,
> Feng
> 
>>
>>> Signed-off-by: Feng Wu
>> <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>> ---
>>>  arch/x86/kvm/vmx.c | 11 +++++++++--
>>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
>>> index a1c83a2..0aee151 100644
>>> --- a/arch/x86/kvm/vmx.c
>>> +++ b/arch/x86/kvm/vmx.c
>>> @@ -4401,15 +4401,22 @@ static int vmx_vm_has_apicv(struct kvm *kvm)
>>>  static void vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int
>> vector)
>>>  {
>>>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>>> -	int r;
>>> +	int r, sn;
>>>
>>>  	if (pi_test_and_set_pir(vector, &vmx->pi_desc))
>>>  		return;
>>>
>>> +	/*
>>> +	 * Currently, we don't support urgent interrupt, all interrupts
>>> +	 * are recognized as non-urgent interrupt, so we cannot send
>>> +	 * posted-interrupt when 'SN' is set.
>>> +	 */
>>> +	sn = pi_test_sn(&vmx->pi_desc);
>>> +
>>>  	r = pi_test_and_set_on(&vmx->pi_desc);
>>>  	kvm_make_request(KVM_REQ_EVENT, vcpu);
>>>  #ifdef CONFIG_SMP
>>> -	if (!r && (vcpu->mode == IN_GUEST_MODE))
>>> +	if (!r && !sn && (vcpu->mode == IN_GUEST_MODE))
>>>  		apic->send_IPI_mask(get_cpu_mask(vcpu->cpu),
>>>  				POSTED_INTR_VECTOR);
>>>  	else
>>> --
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
