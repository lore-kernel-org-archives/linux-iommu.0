From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH 1/6] iommu/arm-smmu: add support for specifying clocks
Date: Tue, 09 Sep 2014 18:29:42 -0700
Message-ID: <vnkwa968b6ux.fsf@mitchelh-linux.qualcomm.com>
References: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
	<1407891099-24641-2-git-send-email-mitchelh@codeaurora.org>
	<20140819125833.GO23128@arm.com> <53F39F6D.1040205@codeaurora.org>
	<20140826142757.GU23445@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140826142757.GU23445-5wv7dgnIgG8@public.gmane.org> (Will Deacon's message of "Tue,
	26 Aug 2014 15:27:58 +0100")
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
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 26 2014 at 07:27:58 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> [adding Mike]
>
> On Tue, Aug 19, 2014 at 08:03:09PM +0100, Olav Haugan wrote:
>> Hi Will,
>
> Hi Olav,
>
>> On 8/19/2014 5:58 AM, Will Deacon wrote:
>> > On Wed, Aug 13, 2014 at 01:51:34AM +0100, Mitchel Humpherys wrote:
>> >> On some platforms with tight power constraints it is polite to only
>> >> leave your clocks on for as long as you absolutely need them. Currently
>> >> we assume that all clocks necessary for SMMU register access are always
>> >> on.
>> >>
>> >> Add some optional device tree properties to specify any clocks that are
>> >> necessary for SMMU register access and turn them on and off as needed.
>> >>
>> >> If no clocks are specified in the device tree things continue to work
>> >> the way they always have: we assume all necessary clocks are always
>> >> turned on.
>> > 
>> > How does this interact with an SMMU in bypass mode?
>> 
>> Do you mean if you have a platform that requires clock and power
>> management but we leave the SMMU in bypass (i.e. no one calls into the
>> SMMU driver) how are the clock/power managed?
>> 
>> Clients of the SMMU driver are required to vote for clocks and power
>> when they know they need to use the SMMU. However, the clock and power
>> needed to be on for the SMMU to service bus masters aren't necessarily
>> the same as the ones needed to read/write registers...See below.
>
> The case I'm thinking of is where a device masters through the IOMMU, but
> doesn't make use of any translations. In this case, its transactions will
> bypass the SMMU and I want to ensure that continues to happen, regardless of
> the power state of the SMMU.

Then I assume the driver for such a device wouldn't be attaching to (or
detaching from) the IOMMU, so we won't be touching it at all either
way. Or am I missing something?

>
>> >> +static int arm_smmu_enable_clocks(struct arm_smmu_device *smmu)
>> >> +{
>> >> +	int i, ret = 0;
>> >> +
>> >> +	for (i = 0; i < smmu->num_clocks; ++i) {
>> >> +		ret = clk_prepare_enable(smmu->clocks[i]);
>> >> +		if (ret) {
>> >> +			dev_err(smmu->dev, "Couldn't enable clock #%d\n", i);
>> >> +			while (i--)
>> >> +				clk_disable_unprepare(smmu->clocks[i]);
>> >> +			break;
>> >> +		}
>> >> +	}
>> >> +
>> >> +	return ret;
>> >> +}
>> >> +
>> >> +static void arm_smmu_disable_clocks(struct arm_smmu_device *smmu)
>> >> +{
>> >> +	int i;
>> >> +
>> >> +	for (i = 0; i < smmu->num_clocks; ++i)
>> >> +		clk_disable_unprepare(smmu->clocks[i]);
>> >> +}
>> > 
>> > What stops theses from racing with each other when there are multiple
>> > clocks? I also assume that the clk API ignores calls to clk_enable_prepare
>> > for a clk that's already enabled? I couldn't find that code...
>> 
>> All the clock APIs are reference counted yes. Not sure what you mean by
>> racing with each other? When you call to enable a clock the call does
>> not return until the clock is already ON (or OFF).
>
> I was thinking of an interrupt handler racing with normal code, but actually
> you balance the clk enable/disable in the interrupt handlers. However, it's
> not safe to call these clk functions from irq context anyway, since
> clk_prepare may sleep.

Ah yes. You okay with moving to a threaded IRQ?

>
>> >> +int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>> >>  {
>> >>  	unsigned long size;
>> >>  	void __iomem *gr0_base = ARM_SMMU_GR0(smmu);
>> >> @@ -2027,10 +2124,16 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>> >>  	}
>> >>  	dev_notice(dev, "registered %d master devices\n", i);
>> >>  
>> >> -	err = arm_smmu_device_cfg_probe(smmu);
>> >> +	err = arm_smmu_init_clocks(smmu);
>> >>  	if (err)
>> >>  		goto out_put_masters;
>> >>  
>> >> +	arm_smmu_enable_clocks(smmu);
>> >> +
>> >> +	err = arm_smmu_device_cfg_probe(smmu);
>> >> +	if (err)
>> >> +		goto out_disable_clocks;
>> >> +
>> >>  	parse_driver_options(smmu);
>> >>  
>> >>  	if (smmu->version > 1 &&
>> >> @@ -2039,7 +2142,7 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>> >>  			"found only %d context interrupt(s) but %d required\n",
>> >>  			smmu->num_context_irqs, smmu->num_context_banks);
>> >>  		err = -ENODEV;
>> >> -		goto out_put_masters;
>> >> +		goto out_disable_clocks;
>> >>  	}
>> >>  
>> >>  	for (i = 0; i < smmu->num_global_irqs; ++i) {
>> >> @@ -2061,12 +2164,16 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>> >>  	spin_unlock(&arm_smmu_devices_lock);
>> >>  
>> >>  	arm_smmu_device_reset(smmu);
>> >> +	arm_smmu_disable_clocks(smmu);
>> > 
>> > I wonder if this is really the right thing to do. Rather than the
>> > fine-grained clock enable/disable you have, why don't we just enable in
>> > domain_init and disable in domain_destroy, with refcounting for the clocks?
>> > 
>> 
>> So the whole point of all of this is that we try to save power. As Mitch
>> wrote in the commit text we want to only leave the clock and power on
>> for as short period of time as possible.
>
> Understood, but if the clocks are going up and down like yo-yos, then it's
> not obvious that you end up saving any power at all. Have you tried
> measuring the power consumption with different granularities for the
> clocks?

This has been profiled extensively and for some use cases it's a huge
win. Unfortunately we don't have any numbers for public sharing :( but
you can imagine a use case where some multimedia framework maps a bunch
of buffers into an SMMU at the beginning of some interactive user
session and doesn't unmap them until the (human) user decides they are
done. This could be a long time, all the while these clocks could be
off, saving power.

> The code you're proposing seems to take the approach of `we're going to
> access registers so enable the clocks, access the registers then disable the
> clocks', which is simple but may not be particularly effective.

Yes, that's a good summary of the approach here. It has been effective
in saving power for us in the past...


-Mitch

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
