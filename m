From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH 3/4] iommu/arm-smmu: Disable stalling faults for all
	endpoints
Date: Mon, 19 Dec 2016 14:33:36 +0530
Message-ID: <000c01d259d6$cc750460$655f0d20$@codeaurora.org>
References: <1471525542-14969-1-git-send-email-will.deacon@arm.com>
	<1471525542-14969-4-git-send-email-will.deacon@arm.com>
	<CAF6AEGujUb37qagBZK1T13eAh=50zy0z5HpFF9FsuvkZZ7c5qw@mail.gmail.com>
	<20161216115413.GE13191@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161216115413.GE13191-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Will Deacon' <will.deacon-5wv7dgnIgG8@public.gmane.org>, 'Rob Clark' <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: 'linux-arm-msm' <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, 'Jordan Crouse' <jcrouse-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Will,

>On Tue, Dec 06, 2016 at 06:30:21PM -0500, Rob Clark wrote:
>> On Thu, Aug 18, 2016 at 9:05 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>> > Enabling stalling faults can result in hardware deadlock on poorly
>> > designed systems, particularly those with a PCI root complex upstream of
>> > the SMMU.
>> >
>> > Although it's not really Linux's job to save hardware integrators from
>> > their own misfortune, it *is* our job to stop userspace (e.g. VFIO
>> > clients) from hosing the system for everybody else, even if they might
>> > already be required to have elevated privileges.
>> >
>> > Given that the fault handling code currently executes entirely in IRQ
>> > context, there is nothing that can sensibly be done to recover from
>> > things like page faults anyway, so let's rip this code out for now and
>> > avoid the potential for deadlock.
>>
>> so, I'd like to re-introduce this feature, I *guess* as some sort of
>> opt-in quirk (ie. disabled by default unless something in DT tells you
>> otherwise??  But I'm open to suggestions.  I'm not entirely sure what
>> hw was having problems due to this feature.)
>>
>> On newer snapdragon devices we are using arm-smmu for the GPU, and
>> halting the GPU so the driver's fault handler can dump some GPU state
>> on faults is enormously helpful for debugging and tracking down where
>> in the gpu cmdstream the fault was triggered.  In addition, we will
>> eventually want the ability to update pagetables from fault handler
>> and resuming the faulting transition.
>
>I'm not against reintroducing this, but it would certainly need to be
>opt-in, as you suggest. If we want to try to use stall faults to enable
>demand paging for DMA, then that means running core mm code to resolve
>the fault and we can't do that in irq context. Consequently, we have to
>hand this off to a thread, which means the hardware must allow the SS
>bit to remain set without immediately reasserting the interrupt line.
>Furthermore, we can't handle multiple faults on a context-bank, so we'd
>need to restrict ourselves to one device (i.e. faulting stream) per
>domain (CB).
>
>I think that means we want both specific compatible strings to identify
>the SS bit behaviour, but also a way to opt-in for the stall model as a
>separate property to indicate that the SoC integration can support this
>without e.g. deadlocking.
>

To understand the reason on the need for the quirk based on SS bit behavior,
if the platform supports stall model and enabled, then SS bit should be implemented
and remain set until the RESUME register is written back, means same behavior
always ?

Regards,
 Sricharan
