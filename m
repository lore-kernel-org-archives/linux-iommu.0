From: "Elliott, Robert (Server Storage)" <Elliott@hp.com>
Subject: RE: [PATCH RESEND v8] iopoll: Introduce memory-mapped IO polling
 macros
Date: Tue, 25 Nov 2014 00:53:19 +0000
Message-ID: <94D0CD8314A33A4D9D801C0FE68B4029593C5E1F@G9W0745.americas.hpqcorp.net>
References: <1416860092-11620-1-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416860092-11620-1-git-send-email-mitchelh@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mitchel Humpherys <mitchelh@codeaurora.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: Matt Wagantall <mattw@codeaurora.org>, "Don Brace (PMC)" <Don.Brace@pmcs.com>, "Scales, Webb" <webb.scales@hp.com>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Mitchel Humpherys
> Sent: Monday, 24 November, 2014 2:15 PM
...
> From: Matt Wagantall <mattw@codeaurora.org>
> 
> It is sometimes necessary to poll a memory-mapped register until its value
> satisfies some condition. Introduce a family of convenience macros that do
> this. Tight-looping, sleeping, and timing out can all be accomplished
> using these macros.
> 
...
> +#define readx_poll_timeout(op, addr, val, cond, sleep_us, timeout_us)	\
> +({ \
> +	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us); \
> +	might_sleep_if(sleep_us); \
> +	for (;;) { \
> +		(val) = op(addr); \
> +		if (cond) \
> +			break; \
> +		if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) {
> \
> +			(val) = op(addr); \
> +			break; \
> +		} \
> +		if (sleep_us) \
> +			usleep_range((sleep_us >> 2) + 1, sleep_us); \

The hpsa SCSI driver used to use usleep_range in a loop like 
that, but we found that it caused scheduler problems during
boots because it uses TASK_UNINTERRUPTIBLE:
[    9.260668] [sched_delayed] sched: RT throttling activated

msleep() worked much better.

---
Rob Elliott    HP Server Storage
