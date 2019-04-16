From: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
Date: Tue, 16 Apr 2019 09:51:50 +0200
Message-ID: <20190416075150.GR2665@phenom.ffwll.local>
References: <20190401074730.12241-1-robh@kernel.org>
	<20190401074730.12241-4-robh@kernel.org>
	<5efdc3cb-7367-65e1-d1bf-14051db5da10@arm.com>
	<20190405161632.GA9160@rosenzweig.io>
	<34a7038e-34f0-0cc4-4fc4-9b7dda356df6@arm.com>
	<20190415091837.GV2665@phenom.ffwll.local>
	<50682635-4134-f36b-dcb0-2a4d98eedb3c@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50682635-4134-f36b-dcb0-2a4d98eedb3c-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Steven Price <steven.price-5wv7dgnIgG8@public.gmane.org>
Cc: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, "Marty E . Plummer" <hanetzer-zVALfsKDk1AS+FvcfC7Uqw@public.gmane.org>, Sean Paul <sean-p7yTbzM4H96eqtR555YLDQ@public.gmane.org>, Alyssa Rosenzweig <alyssa-kyPdXwtBHbIqQpLF9uBUvQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 15, 2019 at 10:30:14AM +0100, Steven Price wrote:
> On 15/04/2019 10:18, Daniel Vetter wrote:
> > On Fri, Apr 05, 2019 at 05:42:33PM +0100, Steven Price wrote:
> >> On 05/04/2019 17:16, Alyssa Rosenzweig wrote:
> >>> acronym once ever and have it as a "??"), I'm not sure how to respond to
> >>> that... We don't know how to allocate memory for the GPU-internal data
> >>> structures (the tiler heap, for instance, but also a few others I've
> >>> just named "misc_0" and "scratchpad" -- guessing one of those is for
> >>> "TLS"). With kbase, I took the worst-case strategy of allocating
> >>> gigantic chunks on startup with tiny commit counts and GROW_ON_GPF set.
> >>> With the new driver, well, our memory consumption is scary since
> >>> implementing GROW_ON_GPF in an upstream-friendly way is a bit more work
> >>> and isn't expected to hit the 5.2 window.
> >>
> >> Yes GROW_ON_GPF is pretty much required for the tiler heap - it's not
> >> (reasonably) possible to determine how big it should be. The Arm user
> >> space driver does the same approach (tiny commit count, but allow it to
> >> grow).
> > 
> > Jumping in here with a drive through comment ...
> > 
> > Growing gem bo and dma-buf is going to be endless amounts of fun, since we
> > hard-coded that their size is invariant.
> > 
> > I think the only reasonable way to implement this is if you allocate a
> > really huge bo, map it, but only put the pages in on faulting. Or when
> > really evil userspace tries to export it. Actually changing the underlying
> > buffer size is not going to work I think.
> 
> Yes the idea is that you allocate a large amount of virtual address
> space, but only put a few physical pages in. If the GPU needs more you
> fault them in as necessary. The "buffer size" (i.e. virtual address
> region) never changes size.
> 
> > Note: I didn't read kbase, so might be totally wrong in how GROW_ON_GPF
> > works.
> 
> For kbase we simply don't support exporting this type of memory, and are
> fairly restrictive about mapping it into user space (user space
> shouldn't normally need to read it).

You can still disallow sharing with any other driver (in the dma-buf
attach callback), and then enforce whatever mapping restrictions you want
on the panfrost.ko ioctl interface. That should be roughly equivalent to
the restrictions kbase imposes.
> 
> Since Panfrost is using GEM BO it will have to deal with malicious user
> space. But it would be sufficient to simply fully back the region in
> that case.
> 
> Recent version of kbase also support what is termed JIT (Just In Time
> memory allocation). Basically this involves the kernel driver
> allocating/freeing memory regions just before the job is loaded onto the
> GPU. These regions might also be GROW_ON_GPF. The intention is that when
> there isn't memory pressure these regions can be kept between jobs, but
> under memory pressure they can be discarded and recreated if they turn
> out to be needed again.
> 
> Given the differences between the Panfrost and the proprietary user
> space I'm not sure exactly what form this will need to be for Panfrost,
> but Vulkan makes memory management "more interesting"! Allocating
> upfront for the worst case can become prohibitively expensive.

The usual way to do that is with a WONTNEED/WILLNEED madvise ioctl on the
gem bo. I guess that could also be set at create time to essentially only
require the bo to exist during an execbuf call. Should fit pretty well
into what other drivers are doing with gem shmem already I think.

ofc needs a shrinker to be able to reap these bo.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
