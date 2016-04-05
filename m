From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] drivers/iommu: don't select DEBUG_FS for AMD_IOMMU_STATS
Date: Tue, 5 Apr 2016 17:19:51 +0200
Message-ID: <20160405151951.GG11519@8bytes.org>
References: <1459041524-30929-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459041524-30929-1-git-send-email-paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Steven Rostedt (Red Hat)" <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Mar 26, 2016 at 09:18:44PM -0400, Paul Gortmaker wrote:
> We have at least one big banner telling people that they should
> not deploy production kernels with DEBUG options enabled, but
> at the same time, we make it hard for people to turn DEBUG_FS
> off when we select (vs. depend on) the CONFIG_DEBUG_FS option.
> 
> Since we actively discourage people using debug-like features
> on any builds that are production oriented (see trace_printk
> banner for one example), so a generic sounding option should
> not select DEBUG_FS.

That reasoning sounds a bit odd, as most production kernels have
DEBUG_FS enabled anyway, and I see no problem with that.

Disabling all debug features in 'production kernels' is a bit overkill.
Only if the feature has any runtime impact (performance, memory
consumption, security, ...) it makes sense to disable it for production
kernels.

Other features could stay enabled, and DEBUG_FS is one of them. For some
debug features we even don't offer a way to disable them, see BUG_ON,
WARN_ON and friends.


	Joerg
