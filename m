From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v7 1/2] iopoll: Introduce memory-mapped IO polling macros
Date: Thu, 30 Oct 2014 11:17:32 -0700
Message-ID: <vnkwsii5bewz.fsf@mitchelh-linux.qualcomm.com>
References: <1414617220-21493-1-git-send-email-mitchelh@codeaurora.org>
	<1414617220-21493-2-git-send-email-mitchelh@codeaurora.org>
	<20141030114100.GB32589@arm.com> <2369912.UOLoWKRnHU@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2369912.UOLoWKRnHU@wuerfel> (Arnd Bergmann's message of "Thu, 30
	Oct 2014 13:00:23 +0100")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matt Wagantall <mattw-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 30 2014 at 05:00:23 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Thursday 30 October 2014 11:41:00 Will Deacon wrote:
>> > +
>> > +#define readl_poll_timeout(addr, val, cond, delay_us, timeout_us) \
>> > +	readx_poll_timeout(readl, addr, val, cond, delay_us, timeout_us)
>> > +
>> > +#define readl_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
>> > +	readx_poll_timeout_atomic(readl, addr, val, cond, delay_us, timeout_us)
>> > +
>> > +#define readb_poll_timeout(addr, val, cond, delay_us, timeout_us) \
>> > +	readx_poll_timeout(readb, addr, val, cond, delay_us, timeout_us)
>> > +
>> > +#define readb_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
>> > +	readx_poll_timeout_atomic(readb, addr, val, cond, delay_us, timeout_us)
>> > +
>> > +#define readw_poll_timeout(addr, val, cond, delay_us, timeout_us) \
>> > +	readx_poll_timeout(readw, addr, val, cond, delay_us, timeout_us)
>> > +
>> > +#define readw_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
>> > +	readx_poll_timeout_atomic(readw, addr, val, cond, delay_us, timeout_us)
>> > +
>> > +#define readq_poll_timeout(addr, val, cond, delay_us, timeout_us) \
>> > +	readx_poll_timeout(readq, addr, val, cond, delay_us, timeout_us)
>> > +
>> > +#define readq_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
>> > +	readx_poll_timeout_atomic(readq, addr, val, cond, delay_us, timeout_us)
>
> Sort these by size (b, w, l, q) maybe?

Sure

>
>> > +#define ioread32_poll_timeout(addr, val, cond, delay_us, timeout_us) \
>> > +	readx_poll_timeout(ioread32, addr, val, cond, delay_us, timeout_us)
>> > +
>> > +#define ioread32_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
>> > +	readx_poll_timeout_atomic(ioread32, addr, val, cond, delay_us, timeout_us)
>> > +
>> > +#define ioread32b3_poll_timeout(addr, val, cond, delay_us, timeout_us) \
>> > +	readx_poll_timeout(ioread32b3, addr, val, cond, delay_us, timeout_us)
>> > +
>> > +#define ioread32b3_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
>> > +	readx_poll_timeout_atomic(ioread32b3, addr, val, cond, delay_us, timeout_us)
>
> What is ioread32b3?

Looks like it's a... typo!  It was supposed to be ioread32be.

>
>> > +#define inb_poll_timeout(addr, val, cond, delay_us, timeout_us) \
>> > +	readx_poll_timeout(inb, addr, val, cond, delay_us, timeout_us)
>> > +
>> > +#define inb_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
>> > +	readx_poll_timeout_atomic(inb, addr, val, cond, delay_us, timeout_us)
>> > +
>> > +#define inb_p_poll_timeout(addr, val, cond, delay_us, timeout_us) \
>> > +	readx_poll_timeout(inb_p, addr, val, cond, delay_us, timeout_us)
>> > +
>> > +#define inb_p_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
>> > +	readx_poll_timeout_atomic(inb_p, addr, val, cond, delay_us, timeout_us)
>
> I would leave out the _p variants, they are very rarely used anyway.
>
> Looking at the long list, I wonder if we should really define each variant,
> or just expect drivers to call readx_poll_timeout{,_atomic} directly and
> pass whichever accessor they want.

That sounds reasonable although I think we'd at least want to include
the readX family of functions.


-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
