From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
Date: Fri, 5 Apr 2019 09:16:32 -0700
Message-ID: <20190405161632.GA9160@rosenzweig.io>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-4-robh@kernel.org>
 <5efdc3cb-7367-65e1-d1bf-14051db5da10@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5efdc3cb-7367-65e1-d1bf-14051db5da10@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Price <steven.price@arm.com>
Cc: Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org, Sean Paul <sean@poorly.run>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Neil Armstrong <narmstrong@baylibre.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>, iommu@lists.linux-foundation.org, "Marty E . Plummer" <hanetzer@startmail.com>, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

> I'm also somewhat surprised that you don't need loads of other
> properties from the GPU - in particular knowing the number of shader
> cores is useful for allocating the right amount of memory for TLS (and
> can't be obtained purely from the GPU_ID).

Since I have no idea what TLS is (and in my notes, I've come across the
acronym once ever and have it as a "??"), I'm not sure how to respond to
that... We don't know how to allocate memory for the GPU-internal data
structures (the tiler heap, for instance, but also a few others I've
just named "misc_0" and "scratchpad" -- guessing one of those is for
"TLS"). With kbase, I took the worst-case strategy of allocating
gigantic chunks on startup with tiny commit counts and GROW_ON_GPF set.
With the new driver, well, our memory consumption is scary since
implementing GROW_ON_GPF in an upstream-friendly way is a bit more work
and isn't expected to hit the 5.2 window.

Given this is kernel facing, I'm hoping 're able to share some answers
here?

> I think this comment might have survived since the very earliest version
> of the Midgard driver! :)

^_^

> But I'm not sure anything will attempt to lock a region spanning two
> pages like that.

At least at the moment, I align everything kernel-facing to page
granularity in userspace, so it's not a cornercase I'm going to hit
anytime soon. Still probably better to have it technically correct.

> To be fair only for BASE_HW_ISSUE_6367/T60X - but yes it's not a
> pleasant workaround. There's no way on that hardware to reliably drain
> the write buffer other than waiting.

*wishing T60X disappeared intensifies* ;)

Granted there are enough other errata specific to it that aren't worked
around here that, well, it makes you wonder ;)

> Do we have a good way of user space determining which requirements are
> supported by the driver? At the moment it's just the one. kbase outgeew
> the original u16 and has an ugly "compat_core_req", so I suspect you're
> going to need to add several more along the way.

Oh, so that's why compat_/core_req is split off! I thought somebody just
thought it would be "fun" to break the UABI ;)

I've definitely issues using the wrong core_req field for the kbase I
had setup, that set me back a little bit on RK3399/T860 bringup *purses
lips*

To be fair, bunches of the kbase reqs are for soft jobs, which I don't
feel are a good fit for how the Panfrost kernel works. If we need to
implement functionality corresponding to softjobs, that would likely be
done with dedicated ioctl(s), instead of affecting the core_req field.

On that note

> You might also want to consider being able to submit more than one job
> chain at a time - but that could easily be implemented using a new ioctl
> in the future.

The issue with that at the bottom is having to introduce something akin
to kbase's annoyingly intra-job-chain dependency management (read: I
still don't understand how FBOs are supposed to work with kbase ;) ),
which AFAIK we push off to userspace right now via standard fencing. If
we want to submit batches at a time, we would potentially need to
express those somewhat complex dependency trees, which is a lot of work
for diminishing returns at this stage. Future ioctl indeed...

> There's no SUBMIT_CL in this posting? I think you just need s/_CL//.

+1

> You are probably going to want flags for at least:
> 
>  * No execute/No read/No write (good for security, especially with
> buffer sharing between processes)
> 
>  * Alignment (shader programs have quite strict alignment requirements,
> I believe kbase just ensures that the shader memory block doesn't cross
> a 16MB boundary which covers most cases).
> 
>  * Page fault behaviour (kbase has GROW_ON_GPF)
> 
>  * Coherency management

+1 for all of these. This is piped through in userspace (for kbase), but
the corresponding functionality isn't there yet in the Panfrost kernel.
You're right there should at least be a flags field for future use.

> One issue that I haven't got to the bottom of is that I can trigger a
> lockdep splat:

Oh, "fun"...

> This is with the below simple reproducer:

@Rob, ideas?

> Other than that in my testing (on a Firefly RK3288) I didn't experience
> any problems pushing jobs from the ARM userspace blob through it.

Nice!

Besides what was mentioned above, any other functionality you'll need
for that? (e.g. the infamous replay workaround...)
