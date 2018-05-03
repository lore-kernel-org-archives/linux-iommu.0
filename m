From: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCHv4 2/2] iommu/vt-d: Limit number of faults to clear in irq
	handler
Date: Thu, 3 May 2018 09:32:44 +0800
Message-ID: <5AEA66BC.5050202@linux.intel.com>
References: <20180331003312.6390-1-dima@arista.com>
	<20180331003312.6390-2-dima@arista.com>
	<5AE95BFF.5040306@linux.intel.com>
	<1525264687.14025.20.camel@arista.com>
	<5AEA4E84.6050609@linux.intel.com>
	<1525308755.14025.25.camel@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1525308755.14025.25.camel-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Dmitry Safonov <dima-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, 0x7f454c46-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

On 05/03/2018 08:52 AM, Dmitry Safonov wrote:
> On Thu, 2018-05-03 at 07:49 +0800, Lu Baolu wrote:
>> Hi,
>>
>> On 05/02/2018 08:38 PM, Dmitry Safonov wrote:
>>> Hi Lu,
>>>
>>> On Wed, 2018-05-02 at 14:34 +0800, Lu Baolu wrote:
>>>> Hi,
>>>>
>>>> On 03/31/2018 08:33 AM, Dmitry Safonov wrote:
>>>>> Theoretically, on some machines faults might be generated
>>>>> faster
>>>>> than
>>>>> they're cleared by CPU.
>>>> Is this a real case?
>>> No. 1/2 is a real case and this one was discussed on v3:
>>> lkml.kernel.org/r/<20180215191729.15777-1-dima-nzgTgzXrdUbQT0dZR+AlfA@public.gmane.org>
>>>
>>> It's not possible on my hw as far as I tried, but the discussion
>>> result
>>> was to fix this theoretical issue too.
>> If faults are generated faster than CPU can clear them, the PCIe
>> device should be in a very very bad state. How about disabling
>> the PCIe device and ask the administrator to replace it? Anyway,
>> I don't think that's goal of this patch series. :-)
> Uhm, yeah, my point is not about the number of faults, but about
> physical ability of iommu to generate faults faster than cpu processes
> them. I might be wrong that it's not possible (like low cpu freq?)
>
> But the number of interrupts might be high. It's like you've many
> mappings on iommu and PCIe device went off. It could be just a link
> flap. I think it makes sense not lockup on such occasions.
>
>>>>>  Let's limit the cleaning-loop by number of hw
>>>>> fault registers.
>>>> Will this cause the fault recording registers full of faults,
>>>> hence
>>>> new faults will be dropped without logging?
>>> If faults come faster then they're being cleared - some of them
>>> will be
>>> dropped without logging. Not sure if it's worth to report all
>>> faults in
>>> such theoretical(!) situation.
>>> If amount of reported faults for such situation is not enough and
>>> it's
>>> worth to keep all the faults, then probably we should introduce a
>>> workqueue here (which I did in v1, but it was rejected by the
>>> reason
>>> that it will introduce some latency in fault reporting).
>>>
>>>> And even worse, new faults will not generate interrupts?
>>> They will, we clear page fault overflow outside of the loop, so any
>>> new
>>> fault will raise interrupt, iiuc.
>>>
>> I am afraid that they might not generate interrupts any more.
>>
>> Say, the fault registers are full of events that are not cleared,
>> then a new fault comes. There is no room for this event and
>> hence the hardware might drop it silently.
> AFAICS, we're doing fault-clearing in a loop inside irq handler.
> That means that while we're clearing if a fault raises, it'll make
> an irq level triggered (or on edge) on lapic. So, whenever we return
> from the irq handler, irq will raise again.
>

Uhm, double checked with the spec. Interrupts should be generated
since we always clear the fault overflow bit.

Anyway, we can't clear faults in a limited loop, as the spec says in 7.3.1:

Software is expected to process the non-recoverable faults reported through the Fault Recording
Registers in a circular FIFO fashion starting from the Fault Recording Register referenced by the Fault
Recording Index (FRI) field, until it finds a Fault Recording Register with no faults (F field Clear).

Best regards,
Lu Baolu
