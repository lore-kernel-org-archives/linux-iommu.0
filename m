From: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
Date: Mon, 15 Apr 2019 10:30:14 +0100
Message-ID: <50682635-4134-f36b-dcb0-2a4d98eedb3c@arm.com>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-4-robh@kernel.org>
 <5efdc3cb-7367-65e1-d1bf-14051db5da10@arm.com>
 <20190405161632.GA9160@rosenzweig.io>
 <34a7038e-34f0-0cc4-4fc4-9b7dda356df6@arm.com>
 <20190415091837.GV2665@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190415091837.GV2665@phenom.ffwll.local>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Neil Armstrong <narmstrong@baylibre.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, iommu@lists.linux-foundation.org, "Marty E . Plummer" <hanetzer@startmail.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On 15/04/2019 10:18, Daniel Vetter wrote:
> On Fri, Apr 05, 2019 at 05:42:33PM +0100, Steven Price wrote:
>> On 05/04/2019 17:16, Alyssa Rosenzweig wrote:
>>> acronym once ever and have it as a "??"), I'm not sure how to respond to
>>> that... We don't know how to allocate memory for the GPU-internal data
>>> structures (the tiler heap, for instance, but also a few others I've
>>> just named "misc_0" and "scratchpad" -- guessing one of those is for
>>> "TLS"). With kbase, I took the worst-case strategy of allocating
>>> gigantic chunks on startup with tiny commit counts and GROW_ON_GPF set.
>>> With the new driver, well, our memory consumption is scary since
>>> implementing GROW_ON_GPF in an upstream-friendly way is a bit more work
>>> and isn't expected to hit the 5.2 window.
>>
>> Yes GROW_ON_GPF is pretty much required for the tiler heap - it's not
>> (reasonably) possible to determine how big it should be. The Arm user
>> space driver does the same approach (tiny commit count, but allow it to
>> grow).
> 
> Jumping in here with a drive through comment ...
> 
> Growing gem bo and dma-buf is going to be endless amounts of fun, since we
> hard-coded that their size is invariant.
> 
> I think the only reasonable way to implement this is if you allocate a
> really huge bo, map it, but only put the pages in on faulting. Or when
> really evil userspace tries to export it. Actually changing the underlying
> buffer size is not going to work I think.

Yes the idea is that you allocate a large amount of virtual address
space, but only put a few physical pages in. If the GPU needs more you
fault them in as necessary. The "buffer size" (i.e. virtual address
region) never changes size.

> Note: I didn't read kbase, so might be totally wrong in how GROW_ON_GPF
> works.

For kbase we simply don't support exporting this type of memory, and are
fairly restrictive about mapping it into user space (user space
shouldn't normally need to read it).

Since Panfrost is using GEM BO it will have to deal with malicious user
space. But it would be sufficient to simply fully back the region in
that case.

Recent version of kbase also support what is termed JIT (Just In Time
memory allocation). Basically this involves the kernel driver
allocating/freeing memory regions just before the job is loaded onto the
GPU. These regions might also be GROW_ON_GPF. The intention is that when
there isn't memory pressure these regions can be kept between jobs, but
under memory pressure they can be discarded and recreated if they turn
out to be needed again.

Given the differences between the Panfrost and the proprietary user
space I'm not sure exactly what form this will need to be for Panfrost,
but Vulkan makes memory management "more interesting"! Allocating
upfront for the worst case can become prohibitively expensive.

Steve
