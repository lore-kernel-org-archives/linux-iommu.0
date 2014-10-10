From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v4 1/2] iopoll: Introduce memory-mapped IO polling macros
Date: Fri, 10 Oct 2014 13:24:18 -0700
Message-ID: <vnkwegufn05p.fsf@mitchelh-linux.qualcomm.com>
References: <1412126893-15796-1-git-send-email-mitchelh@codeaurora.org>
	<2434048.k6JtGScJfe@wuerfel>
	<vnkwoatjn1zm.fsf@mitchelh-linux.qualcomm.com>
	<1922221.DKAGMVXrIn@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1922221.DKAGMVXrIn@wuerfel> (Arnd Bergmann's message of "Fri, 10
	Oct 2014 21:50:23 +0200")
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

On Fri, Oct 10 2014 at 12:50:23 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
> On Friday 10 October 2014 12:44:45 Mitchel Humpherys wrote:
>> >> Regarding the division, for the overwhelmingly common case where the
>> >> user of the API passes in a constant for sleep_us the compiler optimizes
>> >> out this calculation altogether and just sticks the final result in (I
>> >> verified this with gcc 4.9 and the kernel build system's built-in
>> >> support for generating .s files).  Conveying semantic meaning by using
>> >> `DIV_ROUND_UP' is nice but if you feel strongly about it we can make
>> >> this a shift instead.
>> >
>> > The more important question is probably if you want to keep the _ROUND_UP
>> > part. If that's not significant, I think a shift would be better.
>> 
>> If we drop the _ROUND_UP then passing a sleep_us <= 4 would result in a
>> minimum sleep time of 0, so we'd be polling a lot faster than the user
>> had expected.
>
> How about changing the semantics to sleep at least the sleep_us time,
> and at most four times that? This would turn the expensive division into
> a multiplication and avoid the need for rounding.

We already have a bunch of code using this and I'm not sure what the
effect would be on the system by changing this.  It would probably be
negligible but saving a couple of instructions hardly seems like
justification for a change...  More importantly, I think users would
rather poll their register a little quicker than they asked, rather than
slower.

> If there are important reasons to keep doing the division, you could
> instead use '(sleep_us >> 4) + 1', which is also very cheap to compute
> and avoids the problem you mention.

But I think you meant `(sleep_us >> 2) + 1', right?  Incidentally, that
illustrates the benefit of the semantic clarity provided by explicitly
dividing :).  In any case, I'm happy to go with a shift here for v6.


-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
