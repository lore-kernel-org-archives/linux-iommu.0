From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v4 1/2] iopoll: Introduce memory-mapped IO polling macros
Date: Thu, 09 Oct 2014 15:45:05 -0700
Message-ID: <vnkwppe07thq.fsf@mitchelh-linux.qualcomm.com>
References: <1412126893-15796-1-git-send-email-mitchelh@codeaurora.org>
	<1412126893-15796-2-git-send-email-mitchelh@codeaurora.org>
	<23910474.oJQUXZsx4W@wuerfel>
	<vnkwoatngwmo.fsf@mitchelh-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <vnkwoatngwmo.fsf-Yf+dfxj6toJBVvN7MMdr1KRtKmQZhJ7pQQ4Iyu8u01E@public.gmane.org> (Mitchel
	Humpherys's message of "Tue, 07 Oct 2014 18:47:59 -0700")
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

On Tue, Oct 07 2014 at 06:47:59 PM, Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>>> +#define readl_poll_timeout_atomic(addr, val, cond, max_reads, time_between_us) \
>>> +({ \
>>> +       int count; \
>>> +       for (count = (max_reads); count > 0; count--) { \
>>> +               (val) = readl(addr); \
>>> +               if (cond) \
>>> +                       break; \
>>> +               udelay(time_between_us); \
>>> +       } \
>>> +       (cond) ? 0 : -ETIMEDOUT; \
>>> +})
>>
>> udelay has a large variability, I think it would be better to also use
>> ktime_compare here and make the interface the same as the other one.
>> You might want to add a warning if someone tries to pass more than a few
>> microseconds as the timeout.
>
> Sounds good, will update in v5.

Except I'll probably hold off on adding a warning about udelay since
udelay already includes a "warning" (a compile error, actually) when
exceedingly large delays are requested.


-Mitch

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
