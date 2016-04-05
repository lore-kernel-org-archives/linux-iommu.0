From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] drivers/iommu: don't select DEBUG_FS for AMD_IOMMU_STATS
Date: Wed, 6 Apr 2016 00:41:52 +0200
Message-ID: <20160405224152.GK17838@8bytes.org>
References: <1459041524-30929-1-git-send-email-paul.gortmaker@windriver.com>
	<20160405151951.GG11519@8bytes.org>
	<20160405123754.30786ede@grimm.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160405123754.30786ede-2kNGR76GQU9OHLTnHDQRgA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Cc: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 05, 2016 at 12:37:54PM -0400, Steven Rostedt wrote:
> I will argue that people have asked me to move tracing out of debugfs
> (which is why I created tracefs) because the problem with debugfs is
> that it opens up a entire system that is not well scrutinized, and
> holds lots of possible ways to crack the kernel.
> 
> Disabling debugfs does help with the "security" point you mentioned
> above.

Yes, that reasoning makes more sense than "debug features are bad for
production". It should've been part of the commit message.

The AMD_IOMMU_STATS feature is on my list of things to remove anyway, it
is mostly disabled and should be done differently (via per-device sysfs
stats). So I am just going to remove it for now.


	Joerg
