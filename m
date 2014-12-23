From: Paolo Bonzini <pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [v3 06/26] iommu,
	x86: No need to migrating irq for VT-d Posted-Interrupts
Date: Tue, 23 Dec 2014 10:34:05 +0100
Message-ID: <5499370D.8000703@redhat.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>	<1418397300-10870-7-git-send-email-feng.wu@intel.com>	<A9667DDFB95DB7438FA9D7D576C3D87E0AC0486D@SHSMSX104.ccr.corp.intel.com>	<E959C4978C3B6342920538CF579893F00230A649@SHSMSX104.ccr.corp.intel.com>	<A9667DDFB95DB7438FA9D7D576C3D87E0AC04E77@SHSMSX104.ccr.corp.intel.com>	<54941326.4080405@redhat.com>
	<A9667DDFB95DB7438FA9D7D576C3D87E0AC06282@SHSMSX104.ccr.corp.intel.com>
	<54992C2C.5030305@redhat.com>
	<E959C4978C3B6342920538CF579893F002314236@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <E959C4978C3B6342920538CF579893F002314236-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Zhang, Yang Z" <yang.z.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "H. Peter Anvin" <hpa-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Gleb Natapov <gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, KVM list <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



On 23/12/2014 10:07, Wu, Feng wrote:
>> On 23/12/2014 01:37, Zhang, Yang Z wrote:
>>> I don't quite understand it. If user set an interrupt's affinity to a
>>> CPU, but he still see the interrupt delivers to other CPUs in host.
>>> Do you think it is a right behavior?
>>
>> No, the interrupt is not delivered at all in the host.  Normally you'd have:
>>
>> - interrupt delivered to CPU from host affinity
>>
>> - VFIO interrupt handler writes to irqfd
>>
>> - interrupt delivered to vCPU from guest affinity
>>
>> Here, you just skip the first two steps.  The interrupt is delivered to
>> the thread that is running the vCPU directly, so the host affinity is
>> bypassed entirely.
>>
>> ... unless you are considering the case where the vCPU is blocked and
>> the host is processing the posted interrupt wakeup vector.  In that case
>> yes, it would be better to set NDST to a CPU matching the host affinity.
> 
> In my understanding, wakeup vector should have no relationship with the
> host affinity of the irq. Wakeup notification event should be delivered to
> the pCPU which the vCPU was blocked on. And in kernel's point of view,
> the irq is not associated with the wakeup vector, right?

That is correct indeed.  It is not associated to the wakeup vector,
hence this patch is right, I think.

However, the wakeup vector has the same function as the VFIO interrupt
handler, so you could argue that it is tied to the host affinity rather
than the guest.  Let's wait for Yang to answer.

Paolo
