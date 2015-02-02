From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: use a threaded handler for context
	interrupts
Date: Mon, 02 Feb 2015 12:10:02 -0800
Message-ID: <vnkwa90why79.fsf@mitchelh-linux.qualcomm.com>
References: <1421970482-11722-1-git-send-email-mitchelh@codeaurora.org>
	<20150123112415.GD23058@arm.com>
	<vnkw61bx2klr.fsf@mitchelh-linux.qualcomm.com>
	<20150128120738.GJ1569@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150128120738.GJ1569-5wv7dgnIgG8@public.gmane.org> (Will Deacon's message of "Wed,
	28 Jan 2015 12:07:39 +0000")
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 28 2015 at 04:07:39 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> On Fri, Jan 23, 2015 at 10:33:20PM +0000, Mitchel Humpherys wrote:
>> On Fri, Jan 23 2015 at 03:24:15 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
>> > On Thu, Jan 22, 2015 at 11:48:02PM +0000, Mitchel Humpherys wrote:
>> >> Context interrupts can call domain-specific handlers which might sleep.
>> >> Currently we register our handler with request_irq, so our handler is
>> >> called in atomic context, so domain handlers that sleep result in an
>> >> invalid context BUG.  Fix this by using request_threaded_irq.
>> >> 
>> >> This also prepares the way for doing things like enabling clocks within
>> >> our interrupt handler.
>> >> 
>> >> Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> >> ---
>> >>  drivers/iommu/arm-smmu.c | 5 +++--
>> >>  1 file changed, 3 insertions(+), 2 deletions(-)
>> >> 
>> >> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
>> >> index 6cd47b75286f..81f6b54d94b1 100644
>> >> --- a/drivers/iommu/arm-smmu.c
>> >> +++ b/drivers/iommu/arm-smmu.c
>> >> @@ -973,8 +973,9 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>> >>  	spin_unlock_irqrestore(&smmu_domain->lock, flags);
>> >>  
>> >>  	irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
>> >> -	ret = request_irq(irq, arm_smmu_context_fault, IRQF_SHARED,
>> >> -			  "arm-smmu-context-fault", domain);
>> >> +	ret = request_threaded_irq(irq, NULL, arm_smmu_context_fault,
>> >> +				IRQF_ONESHOT | IRQF_SHARED,
>> >> +				"arm-smmu-context-fault", domain);
>> >>  	if (IS_ERR_VALUE(ret)) {
>> >>  		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
>> >>  			cfg->irptndx, irq);
>> >
>> > I think I'd rather keep a simple atomic handler, then have a threaded
>> > handler for actually issuing the report_iommu_fault. i.e. we only wake
>> > the thread when it looks like there's some work to do. That also works
>> > much better for shared interrupts.
>> 
>> Are you still against adding clock support to the driver?  If not, we'll
>> need to move to a threaded handler when clocks come in anyways...
>> 
>> Can you elaborate what you mean regarding shared interrupts?  Even
>> without clocks it seems like the code clarity / performance tradeoff
>> would favor a threaded handler, given that performance isn't important
>> here.
>
> With a shared handler (e.g. a bunch of context banks have the same IRQ)
> then I assume that we don't want to end up with multiple handler threads
> all tripping over each other. I'd rather have one thread that handles work
> queued up by multiple low-level handlers.
>
> Do you have a preference either way?

Ok I think I understand the scenario you're describing.  If multiple
context banks are sharing an interrupt line their handlers currently
execute serially, but with threaded handlers they would all be woken up
and possibly execute concurrently.  I hadn't really considered this
because none of our targets have CBs sharing interrupts.  In any case,
the CBs that aren't interrupting should quickly return IRQ_NONE when
they notice that !(fsr & FSR_FAULT), so is this really a concern?

Anyways, we can always hold off on this until we have a more compelling
motivation for it.  For example, if we need to enable clocks to read
registers then threaded IRQs seem like the best solution.  Hopefully
I'll find time to have another go at the clocks stuff soon, which is the
real reason why we're using threaded IRQs for context interrupts in our
msm tree.


-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
