From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v4 1/2] iopoll: Introduce memory-mapped IO polling macros
Date: Tue, 07 Oct 2014 18:47:59 -0700
Message-ID: <vnkwoatngwmo.fsf@mitchelh-linux.qualcomm.com>
References: <1412126893-15796-1-git-send-email-mitchelh@codeaurora.org>
	<1412126893-15796-2-git-send-email-mitchelh@codeaurora.org>
	<23910474.oJQUXZsx4W@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <23910474.oJQUXZsx4W@wuerfel> (Arnd Bergmann's message of "Wed,
	01 Oct 2014 10:25:33 +0200")
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
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matt Wagantall <mattw-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Oct 01 2014 at 01:25:33 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Tuesday 30 September 2014 18:28:12 Mitchel Humpherys wrote:
>> + */
>> +#define readl_poll_timeout(addr, val, cond, sleep_us, timeout_us) \
>> +({ \
>> +       ktime_t timeout = ktime_add_us(ktime_get(), timeout_us); \
>> +       might_sleep_if(timeout_us); \
>
> Does it make sense to call this with timeout_us = 0?

Yes, the idea there being to "never timeout".  That mode should, of
course, be used with extreme caution since never timing out is not
really "playing nice" with the system.

>
>> +       for (;;) { \
>> +               (val) = readl(addr); \
>> +               if (cond) \
>> +                       break; \
>> +               if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) { \
>> +                       (val) = readl(addr); \
>> +                       break; \
>> +               } \
>> +               if (sleep_us) \
>> +                       usleep_range(DIV_ROUND_UP(sleep_us, 4), sleep_us); \
>> +       } \
>> +       (cond) ? 0 : -ETIMEDOUT; \
>> +})
>
> I think it would be better to tie the 'range' argument to the timeout. Also
> doing a division seems expensive here.

We may have cases where the HW spec says something like "the foo widget
response time is on average 5us, with a worst case of 100us."  In such a
case we may want to poll the bit very frequently to optimize for the
common case of a very fast lock time, but we may not want to error out
due to a timeout unless we've been waiting 100us.

Regarding the division, for the overwhelmingly common case where the
user of the API passes in a constant for sleep_us the compiler optimizes
out this calculation altogether and just sticks the final result in (I
verified this with gcc 4.9 and the kernel build system's built-in
support for generating .s files).  Conveying semantic meaning by using
`DIV_ROUND_UP' is nice but if you feel strongly about it we can make
this a shift instead.

>
>> +/**
>> + * readl_poll_timeout_atomic - Periodically poll an address until a condition is met or a timeout occurs
>> + * @addr: Address to poll
>> + * @val: Variable to read the value into
>> + * @cond: Break condition (usually involving @val)
>> + * @max_reads: Maximum number of reads before giving up
>> + * @time_between_us: Time to udelay() between successive reads
>> + *
>> + * Returns 0 on success and -ETIMEDOUT upon a timeout.
>> + */
>> +#define readl_poll_timeout_atomic(addr, val, cond, max_reads, time_between_us) \
>> +({ \
>> +       int count; \
>> +       for (count = (max_reads); count > 0; count--) { \
>> +               (val) = readl(addr); \
>> +               if (cond) \
>> +                       break; \
>> +               udelay(time_between_us); \
>> +       } \
>> +       (cond) ? 0 : -ETIMEDOUT; \
>> +})
>
> udelay has a large variability, I think it would be better to also use
> ktime_compare here and make the interface the same as the other one.
> You might want to add a warning if someone tries to pass more than a few
> microseconds as the timeout.

Sounds good, will update in v5.

>
> More generally speaking, using 'readl' seems fairly specific. I suspect
> that we'd have to add the entire range of accessors over time if this
> catches on: readb, readw, readq, readb_relaxed, readw_relaxed, readl_relaxed,
> readq_relaxed, ioread8, ioread16, ioread16be, ioread32, ioread32be,
> inb, inb_p, inw, inw_p, inw, inl, inl_p, and possibly more of those.
>
> Would it make sense to pass that operation as an argument?

Sure, we'll do that in v5 as well.



-Mitch

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
