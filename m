From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 1/6] iommu/arm-smmu: add support for specifying clocks
Date: Wed, 10 Sep 2014 12:09:06 -0700
Message-ID: <vnkwbnqn9tt9.fsf@mitchelh-linux.qualcomm.com>
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
	<1407891099-24641-2-git-send-email-mitchelh@codeaurora.org>
	<20140819125833.GO23128@arm.com> <53F39F6D.1040205@codeaurora.org>
	<20140826142757.GU23445@arm.com>
	<vnkwa968b6ux.fsf@mitchelh-linux.qualcomm.com>
	<20140910182739.GM1710@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140910182739.GM1710-5wv7dgnIgG8@public.gmane.org> (Will Deacon's message of "Wed,
	10 Sep 2014 19:27:39 +0100")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Sep 10 2014 at 11:27:39 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> On Wed, Sep 10, 2014 at 02:29:42AM +0100, Mitchel Humpherys wrote:
>> On Tue, Aug 26 2014 at 07:27:58 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>> > On Tue, Aug 19, 2014 at 08:03:09PM +0100, Olav Haugan wrote:
>> >> Clients of the SMMU driver are required to vote for clocks and power
>> >> when they know they need to use the SMMU. However, the clock and power
>> >> needed to be on for the SMMU to service bus masters aren't necessarily
>> >> the same as the ones needed to read/write registers...See below.
>> >
>> > The case I'm thinking of is where a device masters through the IOMMU, but
>> > doesn't make use of any translations. In this case, its transactions will
>> > bypass the SMMU and I want to ensure that continues to happen, regardless of
>> > the power state of the SMMU.
>> 
>> Then I assume the driver for such a device wouldn't be attaching to (or
>> detaching from) the IOMMU, so we won't be touching it at all either
>> way. Or am I missing something?
>
> As long as its only the register file that gets powered down, then there's
> no issue. However, that's making assumptions about what these clocks are
> controlling. Is there a way for the driver to know which aspects of the
> device are controlled by which clock?

Yes, folks should only be putting "config" clocks here. In our system,
at least, the clocks for configuring the SMMU are different than those
for using it. Maybe I should make a note about what "kinds" of clocks
can be specified here in the bindings (i.e. only those that can be
safely disabled while still allowing translations to occur)?

>
>> >> > What stops theses from racing with each other when there are multiple
>> >> > clocks? I also assume that the clk API ignores calls to clk_enable_prepare
>> >> > for a clk that's already enabled? I couldn't find that code...
>> >> 
>> >> All the clock APIs are reference counted yes. Not sure what you mean by
>> >> racing with each other? When you call to enable a clock the call does
>> >> not return until the clock is already ON (or OFF).
>> >
>> > I was thinking of an interrupt handler racing with normal code, but actually
>> > you balance the clk enable/disable in the interrupt handlers. However, it's
>> > not safe to call these clk functions from irq context anyway, since
>> > clk_prepare may sleep.
>> 
>> Ah yes. You okay with moving to a threaded IRQ?
>
> A threaded IRQ already makes sense for context interrupts (if anybody has a
> platform that can do stalls properly), but it seems a bit weird for the
> global fault handler. Is there no way to fix the race instead?

Are you referring to the scenario where someone might be disabling
clocks at the same time? This isn't a problem since the clocks are
refcounted. I believe the main problem here is calling clk_enable from
atomic context since it might sleep.

For my own edification, why would it be weird to move to a threaded IRQ
here? We're not really doing any important work here (just printing an
informational message) so moving to a threaded IRQ actually seems like
the courteous thing to do...

>
>> >> >> @@ -2061,12 +2164,16 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>> >> >>  	spin_unlock(&arm_smmu_devices_lock);
>> >> >>  
>> >> >>  	arm_smmu_device_reset(smmu);
>> >> >> +	arm_smmu_disable_clocks(smmu);
>> >> > 
>> >> > I wonder if this is really the right thing to do. Rather than the
>> >> > fine-grained clock enable/disable you have, why don't we just enable in
>> >> > domain_init and disable in domain_destroy, with refcounting for the clocks?
>> >> > 
>> >> 
>> >> So the whole point of all of this is that we try to save power. As Mitch
>> >> wrote in the commit text we want to only leave the clock and power on
>> >> for as short period of time as possible.
>> >
>> > Understood, but if the clocks are going up and down like yo-yos, then it's
>> > not obvious that you end up saving any power at all. Have you tried
>> > measuring the power consumption with different granularities for the
>> > clocks?
>> 
>> This has been profiled extensively and for some use cases it's a huge
>> win. Unfortunately we don't have any numbers for public sharing :( but
>> you can imagine a use case where some multimedia framework maps a bunch
>> of buffers into an SMMU at the beginning of some interactive user
>> session and doesn't unmap them until the (human) user decides they are
>> done. This could be a long time, all the while these clocks could be
>> off, saving power.
>
> Ok, I can see that. I wonder whether we could wrap all of the iommu_ops
> functions with the clock enable/disable code, instead of putting it directly
> into the drivers?

Interesting idea... I'm up for it if the IOMMU core and driver
maintainers are okay with it.

>
>> > The code you're proposing seems to take the approach of `we're going to
>> > access registers so enable the clocks, access the registers then disable the
>> > clocks', which is simple but may not be particularly effective.
>> 
>> Yes, that's a good summary of the approach here. It has been effective
>> in saving power for us in the past...
>
> Mike, do you have any experience with this sort of stuff?
>
> Will



-Mitch

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
