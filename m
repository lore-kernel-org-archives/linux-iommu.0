From: "Elliott, Robert (Server Storage)" <Elliott@hp.com>
Subject: RE: [PATCH RESEND v8] iopoll: Introduce memory-mapped IO polling
 macros
Date: Tue, 25 Nov 2014 03:02:30 +0000
Message-ID: <94D0CD8314A33A4D9D801C0FE68B4029593C61A3@G9W0745.americas.hpqcorp.net>
References: <1416860092-11620-1-git-send-email-mitchelh@codeaurora.org>
	<94D0CD8314A33A4D9D801C0FE68B4029593C5E1F@G9W0745.americas.hpqcorp.net>
 <vnkwy4r0gjne.fsf@mitchelh-linux.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <vnkwy4r0gjne.fsf@mitchelh-linux.qualcomm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mitchel Humpherys <mitchelh@codeaurora.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Thierry Reding <thierry.reding@gmail.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Matt Wagantall <mattw@codeaurora.org>, "Don Brace (PMC)" <Don.Brace@pmcs.com>, "Scales, Webb" <webb.scales@hp.com>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Mitchel Humpherys [mailto:mitchelh@codeaurora.org]
> Sent: Monday, November 24, 2014 7:21 PM
> To: Elliott, Robert (Server Storage)
...
> > The hpsa SCSI driver used to use usleep_range in a loop like
> > that, but we found that it caused scheduler problems during
> > boots because it uses TASK_UNINTERRUPTIBLE:
> > [    9.260668] [sched_delayed] sched: RT throttling activated
> >
> > msleep() worked much better.

Sorry, that might have been msleep_interruptible() - the fixes
are still not upstream, so I'll have to doublecheck tomorrow.

> Hmm, maybe you were just sleeping for too long?  According to
> Documentation/timers/timers-howto.txt, usleep_range is what should be
> used for non-atomic sleeps in the range [10us, 20ms].  Plus we need
> microsecond granularity anyways, so msleep wouldn't cut it.

The intervals and the overall number of loops were indeed long.  I 
think the corrected code waits a total of 1 second; before the fix,
600 seconds.

> If there are any potential users of these macros that would want to
> sleep for more than 20ms I guess we could add a special case here to use
> msleep when sleep_us exceeds 20,000 or so.
...

Maybe just a comment in the documentation for the macro would suffice,
possibly with a separate macro for longer interval sleeps.  I don't
want to force an extra msleep() call to be compiled into a bunch
of places where it's not needed.


---
Rob Elliott    HP Server Storage
