From: Shaohua Li <shli-b10kYP2dOMg@public.gmane.org>
Subject: Re: [PATCH 2/4] iommu: add a bitmap based dma address allocator
Date: Wed, 25 Nov 2015 09:33:30 -0800
Message-ID: <20151125173320.GA92074@devbig084.prn1.facebook.com>
References: <cover.1448401089.git.shli@fb.com>
	<4c0804c85404be81acfe81fcd402f1af484e9d5f.1448401089.git.shli@fb.com>
	<1448402209.44976.109.camel@intel.com>
	<20151124220511.GA2106568@devbig084.prn1.facebook.com>
	<20151125144613.GA3763@suse.de>
	<1448469599.44976.134.camel@intel.com> <5655E545.1010509@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5655E545.1010509-b10kYP2dOMg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jens Axboe <axboe-b10kYP2dOMg@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "Woodhouse,
	David" <david.woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Kernel-team-b10kYP2dOMg@public.gmane.org" <Kernel-team-b10kYP2dOMg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Nov 25, 2015 at 09:43:49AM -0700, Jens Axboe wrote:
> On 11/25/2015 09:40 AM, Woodhouse, David wrote:
> >On Wed, 2015-11-25 at 15:46 +0100, jroedel-l3A5Bk7waGM@public.gmane.org wrote:
> >>On Tue, Nov 24, 2015 at 02:05:12PM -0800, Shaohua Li wrote:
> >>>The lib/iommu-common.c uses a bitmap and a lock. This implementation
> >>>actually uses a percpu_ida which completely avoids locking. It would be
> >>>possible to make lib/iommu-common.c use percpu_ida too if somebody wants
> >>>to do it, but I think this shouldn't be a blocker for these patches
> >>>giving it has huge performance gain.
> >>
> >>It doesn't "completely avoids locking", the percpu_ida code uses a lock
> >>internally too. Also, what is the memory and device address space
> >>overhead per cpu?
> >
> >A percpu lock doesn't bounce cachelines between CPUs very much, so from
> >that point of view it might as well not exist :)
> 
> As long as the address space can remain more than ~50% empty, it is
> indeed practically lockless. Are we ever worried about higher
> utilization? If so, in my experience percpu_ida fails miserable near
> or at exhaustion.

The patch uses TASK_RUNNING for tag allocation, so it doesn't wait. I
thought it's ok, no?

Thanks,
Shaohua
