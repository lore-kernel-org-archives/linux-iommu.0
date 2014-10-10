From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v4 1/2] iopoll: Introduce memory-mapped IO polling macros
Date: Fri, 10 Oct 2014 12:44:45 -0700
Message-ID: <vnkwoatjn1zm.fsf@mitchelh-linux.qualcomm.com>
References: <1412126893-15796-1-git-send-email-mitchelh@codeaurora.org>
	<23910474.oJQUXZsx4W@wuerfel>
	<vnkwoatngwmo.fsf@mitchelh-linux.qualcomm.com>
	<2434048.k6JtGScJfe@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2434048.k6JtGScJfe@wuerfel> (Arnd Bergmann's message of "Wed, 08
	Oct 2014 15:40:46 +0200")
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

On Wed, Oct 08 2014 at 06:40:46 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Tuesday 07 October 2014 18:47:59 Mitchel Humpherys wrote:
>> On Wed, Oct 01 2014 at 01:25:33 AM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
>> > On Tuesday 30 September 2014 18:28:12 Mitchel Humpherys wrote:
>> >> + */
>> >> +#define readl_poll_timeout(addr, val, cond, sleep_us, timeout_us) \
>> >> +({ \
>> >> +       ktime_t timeout = ktime_add_us(ktime_get(), timeout_us); \
>> >> +       might_sleep_if(timeout_us); \
>> >
>> > Does it make sense to call this with timeout_us = 0?
>> 
>> Yes, the idea there being to "never timeout".  That mode should, of
>> course, be used with extreme caution since never timing out is not
>> really "playing nice" with the system.
>
> But then you certainly still 'might_sleep' here. The
> might_sleep_if(timeout_us) line suggests that it won't sleep, but
> that isn't the case.

Yes looks like that was actually a bug.  Should have been
might_sleep_if()'ing on sleep_us.  This is fixed in the v5 I just sent
out.


[...]

>> Regarding the division, for the overwhelmingly common case where the
>> user of the API passes in a constant for sleep_us the compiler optimizes
>> out this calculation altogether and just sticks the final result in (I
>> verified this with gcc 4.9 and the kernel build system's built-in
>> support for generating .s files).  Conveying semantic meaning by using
>> `DIV_ROUND_UP' is nice but if you feel strongly about it we can make
>> this a shift instead.
>
> The more important question is probably if you want to keep the _ROUND_UP
> part. If that's not significant, I think a shift would be better.

If we drop the _ROUND_UP then passing a sleep_us <= 4 would result in a
minimum sleep time of 0, so we'd be polling a lot faster than the user
had expected.



-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
