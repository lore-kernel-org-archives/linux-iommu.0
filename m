From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH RESEND v8] iopoll: Introduce memory-mapped IO polling
	macros
Date: Mon, 24 Nov 2014 17:21:09 -0800
Message-ID: <vnkwy4r0gjne.fsf@mitchelh-linux.qualcomm.com>
References: <1416860092-11620-1-git-send-email-mitchelh@codeaurora.org>
	<94D0CD8314A33A4D9D801C0FE68B4029593C5E1F@G9W0745.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <94D0CD8314A33A4D9D801C0FE68B4029593C5E1F-W1gbDvblbosSZAcGdq5asR6epYMZPwEe5NbjCUgZEJk@public.gmane.org>
	(Robert Elliott's message of "Tue, 25 Nov 2014 00:53:19 +0000")
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Elliott, Robert (Server Storage)" <Elliott-VXdhtT5mjnY@public.gmane.org>
Cc: "Scales, Webb" <webb.scales-VXdhtT5mjnY@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Don Brace (PMC)" <Don.Brace-PwyqCcigF0Q@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matt Wagantall <mattw-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Nov 24 2014 at 04:53:19 PM, "Elliott, Robert (Server Storage)" <Elliott-VXdhtT5mjnY@public.gmane.org> wrote:
>> -----Original Message-----
>> From: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-kernel-
>> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Mitchel Humpherys
>> Sent: Monday, 24 November, 2014 2:15 PM
> ...
>> From: Matt Wagantall <mattw-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>> 
>> It is sometimes necessary to poll a memory-mapped register until its value
>> satisfies some condition. Introduce a family of convenience macros that do
>> this. Tight-looping, sleeping, and timing out can all be accomplished
>> using these macros.
>> 
> ...
>> +#define readx_poll_timeout(op, addr, val, cond, sleep_us, timeout_us)	\
>> +({ \
>> +	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us); \
>> +	might_sleep_if(sleep_us); \
>> +	for (;;) { \
>> +		(val) = op(addr); \
>> +		if (cond) \
>> +			break; \
>> +		if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) {
>> \
>> +			(val) = op(addr); \
>> +			break; \
>> +		} \
>> +		if (sleep_us) \
>> +			usleep_range((sleep_us >> 2) + 1, sleep_us); \
>
> The hpsa SCSI driver used to use usleep_range in a loop like 
> that, but we found that it caused scheduler problems during
> boots because it uses TASK_UNINTERRUPTIBLE:
> [    9.260668] [sched_delayed] sched: RT throttling activated
>
> msleep() worked much better.

Hmm, maybe you were just sleeping for too long?  According to
Documentation/timers/timers-howto.txt, usleep_range is what should be
used for non-atomic sleeps in the range [10us, 20ms].  Plus we need
microsecond granularity anyways, so msleep wouldn't cut it.

If there are any potential users of these macros that would want to
sleep for more than 20ms I guess we could add a special case here to use
msleep when sleep_us exceeds 20,000 or so.


-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
