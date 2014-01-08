From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] drm/msm: Fix link error with !MSM_IOMMU
Date: Wed, 8 Jan 2014 14:35:15 +0100
Message-ID: <20140108133514.GG29041@8bytes.org>
References: <1389134846-1000-1-git-send-email-joro@8bytes.org>
	<20140107225345.GE29041@8bytes.org>
	<CAF6AEGtHR9-oy+xaZM2bbJHnqhrwHiZeAC+asc7+Ds0x_hJeNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAF6AEGtHR9-oy+xaZM2bbJHnqhrwHiZeAC+asc7+Ds0x_hJeNQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 08, 2014 at 08:23:49AM -0500, Rob Clark wrote:
> On Tue, Jan 7, 2014 at 5:53 PM, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:
> > On Tue, Jan 07, 2014 at 11:47:26PM +0100, Joerg Roedel wrote:
> >> The DRM driver for MSM depends on symbols from the MSM
> >> IOMMU driver. Add this dependency to the Kconfig file.
> >>
> >> Fixes this comile error:
> >>
> >>   Kernel: arch/arm/boot/zImage is ready
> >>   ERROR: "msm_iommu_get_ctx" [drivers/gpu/drm/msm/msm.ko]
> >>   undefined!
> >>   make[2]: *** [__modpost] Error 1
> 
> Thanks, I'll pull this into my pull req for 3.14 drm-next.. although,
> after chatting with Stephen Boyd, I think we should eventually be able
> to get rid of this (seems msm_iommu_get_ctx() was mainly for dealing
> with secure playback (?))

It is already in my next-branch. So if you are ok with the approach for
now there is no need for action. If you want it to go through your tree
anyway please let me know and I will drop it from mine.


	Joerg
