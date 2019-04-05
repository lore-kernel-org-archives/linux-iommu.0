From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
Date: Fri, 5 Apr 2019 09:53:28 -0700
Message-ID: <20190405165328.GA9532@rosenzweig.io>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-4-robh@kernel.org>
 <5efdc3cb-7367-65e1-d1bf-14051db5da10@arm.com>
 <20190405161632.GA9160@rosenzweig.io>
 <34a7038e-34f0-0cc4-4fc4-9b7dda356df6@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <34a7038e-34f0-0cc4-4fc4-9b7dda356df6@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Price <steven.price@arm.com>
Cc: Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Neil Armstrong <narmstrong@baylibre.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>, iommu@lists.linux-foundation.org, "Marty E . Plummer" <hanetzer@startmail.com>, Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

> Sorry - "Thread Local Storage" - e.g. registers spilled to memory from a
> shader program.

Gotcha, thank you. Register spilling isn't implemented yet, so I haven't
run into this. (Partially because the blob's RA is very good so it's
somewhat nontrivial to get it to spill... not that I've tried, the real
reason is that the RA I have implemented right now works and I don't
want to mess with it ;P)

> At the moment I don't have any permission to share details which aren't
> already public in the kbase driver. Hopefully that situation will
> change. I'm also very much not an expert on anything but the kernel
> driver (I tried to stay away from shader compilers and all that graphics
> knowledge...). The details of the job descriptors is only really
> publicly documented in terms of the "replay workaround" which is quite
> limited.

Alright, no worries! We'll see where the tide turns, indeed :)

> I think we all felt like that :) Still the Nexus 10 wasn't a bad tablet,
> and the Chromebook was an exciting first!

*looks around to 2 Kevins and 2 Veyrons sprawled about* At first,
indeeed.... ;)

> You should be able to express the dependencies using fences. At the time
> kbase was started there was no fence mechanism in the kernel. We
> invented horrible things like UMP[1] and KDS[2] for cross-driver sharing.

Ah-ha, I see; I didn't know if there was an explicit reason kbase didn't
use fencing, but if it didn't exist, that's reason enough.

> It all comes down to how small your job chains are - if you don't need
> to squeeze too many through the hardware you should be fine. But there's
> going to be some performance gain to be had implementing it.

For sure.

> [1] I forget what it actually stands for, but was an attempt to do
> something like dma_buf

Unified Memory Provider, iirc.

> If you don't implement the replay workaround I'm very happy :)

Pff.

> The main missing part for the Arm user space is feature registers. That
> and the lack of SAME_VA is horrible to emulate (keep allocating until it
> happens to land in a free area of user space memory).

Alright, both of those will probably be needed for us sooner or later,
so no harm in implementing those. Thank you!

> Arm user space also makes use of cached memory with explicit cache sync
> operations. It of course works fine with uncached and ignoring the sync,
> but again I'm not sure how much performance is being lost.

I would be interested as well, since even when I used kbase for stuff, I set
everything uncached/unsynced to keep myself sane, but that could be a
very real performance issue on some workloads.
