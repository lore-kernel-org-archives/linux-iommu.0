From: "Zhang, Yang Z" <yang.z.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v3 25/26] KVM: Suppress posted-interrupt when 'SN' is set
Date: Fri, 19 Dec 2014 05:25:44 +0000
Message-ID: <A9667DDFB95DB7438FA9D7D576C3D87E0AC050B1@SHSMSX104.ccr.corp.intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
	<1418397300-10870-26-git-send-email-feng.wu@intel.com>
	<5491C0A2.7040503@redhat.com>
	<E959C4978C3B6342920538CF579893F002307C4A@SHSMSX104.ccr.corp.intel.com>
	<5492926E.8070207@redhat.com>
	<A9667DDFB95DB7438FA9D7D576C3D87E0AC04938@SHSMSX104.ccr.corp.intel.com>
	<E959C4978C3B6342920538CF579893F00230ABEB@SHSMSX104.ccr.corp.intel.com>
	<A9667DDFB95DB7438FA9D7D576C3D87E0AC04FED@SHSMSX104.ccr.corp.intel.com>
	<E959C4978C3B6342920538CF579893F00230ADA0@SHSMSX104.ccr.corp.intel.com>
	<A9667DDFB95DB7438FA9D7D576C3D87E0AC05059@SHSMSX104.ccr.corp.intel.com>
	<E959C4978C3B6342920538CF579893F00230AE04@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <E959C4978C3B6342920538CF579893F00230AE04-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
To: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Wu, Feng wrote on 2014-12-19:
> 
> 
> Zhang, Yang Z wrote on 2014-12-19:
>> Subject: RE: [v3 25/26] KVM: Suppress posted-interrupt when 'SN' is
>> set
>> 
>> Wu, Feng wrote on 2014-12-19:
>>> 
>>> 
>>> Zhang, Yang Z wrote on 2014-12-19:
>>>> Subject: RE: [v3 25/26] KVM: Suppress posted-interrupt when 'SN'
>>>> is set
>>>> 
>>>> Wu, Feng wrote on 2014-12-19:
>>>>> 
>>>>> 
>>>>> iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org wrote on
>>>> mailto:iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of:
>>>>>> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
>>>>>> linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>>>> Subject: RE: [v3 25/26] KVM: Suppress posted-interrupt when 'SN'
>>>>>> is set
>>>>>> 
>>>>>> Paolo Bonzini wrote on 2014-12-18:
>>>>>>> 
>>>>>>> 
>>>>>>> On 18/12/2014 04:14, Wu, Feng wrote:
>>>>>>>> 
>>>>>>>> 
>>>>>>>> linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org wrote on
>>>>>> mailto:linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Paolo:
>>>>>>>>> x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; Gleb Natapov; Paolo Bonzini;
>>>>>>>>> dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org;
>>>>>>>>> joro-zLv9SwRftAIdnm+yROfE0A-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org; Alex Williamson;
>>>>>>>>> joro-zLv9SwRftAIdnm+Jiang Liu Cc:
>>>>>>>>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org;
>>>>>>>>> linux-kernel-u79uwXL29TY76Z2rM5mHXA-XMD5yJDbdMReXY1tMh2IBg@public.gmane.org; KVM list;
>>>>>>>>> Eric Auger Subject: Re: [v3 25/26] KVM: Suppress
>>>>>>>>> posted-interrupt when 'SN' is set
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> 
>>>>>>>>> On 12/12/2014 16:14, Feng Wu wrote:
>>>>>>>>>> Currently, we don't support urgent interrupt, all
>>>>>>>>>> interrupts are recognized as non-urgent interrupt, so we
>>>>>>>>>> cannot send posted-interrupt when 'SN' is set.
>>>>>>>>> 
>>>>>>>>> Can this happen?  If the vcpu is in guest mode, it cannot
>>>>>>>>> have been scheduled out, and that's the only case when SN is set.
>>>>>>>>> 
>>>>>>>>> Paolo
>>>>>>>> 
>>>>>>>> Currently, the only place where SN is set is vCPU is
>>>>>>>> preempted and
>>>>>> 
>>>>>> If the vCPU is preempted, shouldn't the subsequent be ignored?
>>>>>> What happens if a PI is occurs when vCPU is preempted?
>>>>> 
>>>>> If a vCPU is preempted, the 'SN' bit is set, the subsequent
>>>>> interrupts are suppressed for posting.
>>>> 
>>>> I mean what happens if we don't set SN bit. From my point, if
>>>> preempter already disabled the interrupt, it is ok to leave SN
>>>> bit as zero. But if preempter enabled the interrupt, doesn't this
>>>> mean he allow interrupt to happen? BTW, since there already has
>>>> ON bit, so this means there only have one interrupt arrived at
>>>> most and it doesn't hurt performance. Do we really need to set SN bit?
>>> 
>>> 
>>> See this scenario:
>>> vCPU0 is running on pCPU0
>>> --> vCPU0 is preempted by vCPU1
>>> --> Then vCPU1 is running on pCPU0 and vCPU0 is waiting for
>>> --> schedule in runqueue
>>> 
>>> If the we don't set SN for vCPU0, then all subsequent interrupts
>>> for
>>> vCPU0 is posted to vCPU1, this will consume hardware and software
>> 
>> The PI vector for vCPU1 is notification vector, but the PI vector
>> for
>> vCPU0 should be wakeup vector. Why vCPU1 will consume this PI event?
> 
> Wakeup vector is only used for blocking case, when vCPU is preempted
> and waiting in the runqueue, the NV is the notification vector.

I see your point. But from performance point, if we can schedule the vCPU to another PCPU to handle the interrupt, it would helpful. But I remember current KVM will not schedule the vCPU in run queue (even though it got preempted) to another pCPU to run(Am I right?). So it may hard to do it.

> 
> Thanks,
> Feng
> 
>> 
>>> efforts and in fact it is not needed at all. If SN is set for
>>> vCPU0, VT-d hardware will not issue Notification Event for vCPU0
>>> when an interrupt is for it, but just setting the related PIR bit.
>>> 
>>> Thanks,
>>> Feng
>>> 
>>>> 
>>>>> 
>>>>> Thanks,
>>>>> Feng
>>>>> 
>>>>>> 
>>>>>>>> waiting for the next scheduling in the runqueue. But I am not
>>>>>>>> sure whether we need to set SN for other purpose in future.
>>>>>>>> Adding SN checking here is just to follow the Spec.
>>>>>>>> non-urgent interrupts are suppressed
>>>>>>> when SN is set.
>>>>>>> 
>>>>>>> I would change that to a WARN_ON_ONCE then.
>>>>>> 
>>>>>> 
>>>>>> Best regards,
>>>>>> Yang
>>>>>> 
>>>>>> 
>>>>>> _______________________________________________
>>>>>> iommu mailing list
>>>>>> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>>>>>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
>>>> 
>>>> 
>>>> Best regards,
>>>> Yang
>>>> 
>> 
>> 
>> Best regards,
>> Yang
>>


Best regards,
Yang
