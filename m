From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] drivers/iommu: don't select DEBUG_FS for
 AMD_IOMMU_STATS
Date: Tue, 5 Apr 2016 12:37:54 -0400
Message-ID: <20160405123754.30786ede@grimm.local.home>
References: <1459041524-30929-1-git-send-email-paul.gortmaker@windriver.com>
	<20160405151951.GG11519@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160405151951.GG11519@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

On Tue, 5 Apr 2016 17:19:51 +0200
Joerg Roedel <joro@8bytes.org> wrote:

> On Sat, Mar 26, 2016 at 09:18:44PM -0400, Paul Gortmaker wrote:
> > We have at least one big banner telling people that they should
> > not deploy production kernels with DEBUG options enabled, but
> > at the same time, we make it hard for people to turn DEBUG_FS
> > off when we select (vs. depend on) the CONFIG_DEBUG_FS option.
> > 
> > Since we actively discourage people using debug-like features
> > on any builds that are production oriented (see trace_printk
> > banner for one example), so a generic sounding option should
> > not select DEBUG_FS.  
> 
> That reasoning sounds a bit odd, as most production kernels have
> DEBUG_FS enabled anyway, and I see no problem with that.
> 
> Disabling all debug features in 'production kernels' is a bit overkill.
> Only if the feature has any runtime impact (performance, memory
> consumption, security, ...) it makes sense to disable it for production
> kernels.
> 
> Other features could stay enabled, and DEBUG_FS is one of them. For some
> debug features we even don't offer a way to disable them, see BUG_ON,
> WARN_ON and friends.
> 

I will argue that people have asked me to move tracing out of debugfs
(which is why I created tracefs) because the problem with debugfs is
that it opens up a entire system that is not well scrutinized, and
holds lots of possible ways to crack the kernel.

Disabling debugfs does help with the "security" point you mentioned
above.

-- Steve
