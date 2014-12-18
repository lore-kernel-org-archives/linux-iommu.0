From: "Zhang, Yang Z" <yang.z.zhang@intel.com>
Subject: RE: [v3 25/26] KVM: Suppress posted-interrupt when 'SN' is set
Date: Thu, 18 Dec 2014 15:09:48 +0000
Message-ID: <A9667DDFB95DB7438FA9D7D576C3D87E0AC04938@SHSMSX104.ccr.corp.intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
	<1418397300-10870-26-git-send-email-feng.wu@intel.com>
	<5491C0A2.7040503@redhat.com>
 <E959C4978C3B6342920538CF579893F002307C4A@SHSMSX104.ccr.corp.intel.com>
 <5492926E.8070207@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5492926E.8070207@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

Paolo Bonzini wrote on 2014-12-18:
> 
> 
> On 18/12/2014 04:14, Wu, Feng wrote:
>> 
>> 
>> linux-kernel-owner@vger.kernel.org wrote on mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Paolo:
>>> x86@kernel.org; Gleb Natapov; Paolo Bonzini; dwmw2@infradead.org;
>>> joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; Alex Williamson;
>>> joro-zLv9SwRftAIdnm+Jiang
>>> Liu
>>> Cc: iommu@lists.linux-foundation.org;
>>> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; KVM list;
>>> Eric Auger
>>> Subject: Re: [v3 25/26] KVM: Suppress posted-interrupt when 'SN' is
>>> set
>>> 
>>> 
>>> 
>>> On 12/12/2014 16:14, Feng Wu wrote:
>>>> Currently, we don't support urgent interrupt, all interrupts are
>>>> recognized as non-urgent interrupt, so we cannot send
>>>> posted-interrupt when 'SN' is set.
>>> 
>>> Can this happen?  If the vcpu is in guest mode, it cannot have been
>>> scheduled out, and that's the only case when SN is set.
>>> 
>>> Paolo
>> 
>> Currently, the only place where SN is set is vCPU is preempted and

If the vCPU is preempted, shouldn't the subsequent be ignored? What happens if a PI is occurs when vCPU is preempted?

>> waiting for the next scheduling in the runqueue. But I am not sure
>> whether we need to set SN for other purpose in future. Adding SN
>> checking here is just to follow the Spec. non-urgent interrupts are
>> suppressed
> when SN is set.
> 
> I would change that to a WARN_ON_ONCE then.


Best regards,
Yang
