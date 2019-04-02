From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
Date: Mon, 1 Apr 2019 17:33:26 -0700
Message-ID: <20190402003326.GB12934@rosenzweig.io>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-4-robh@kernel.org>
 <6ce32759-ea83-ee79-33d3-237737f7b866@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6ce32759-ea83-ee79-33d3-237737f7b866@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>, Neil Armstrong <narmstrong@baylibre.com>, "Marty E . Plummer" <hanetzer@startmail.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: iommu@lists.linux-foundation.org

> the userspace definitely doesn't support T624

This is true, yes. Shouldn't be too hard to backport; if there's still
interest in Midgard 1st/2nd gen, I suppose I can grab hardware and sort
it out...

> You probably want a dma_set_mask_and_coherent() call for your 'real' output
> address size somewhere - the default 32-bit mask works out OK for RK3399,
> but on systems with RAM above 4GB io-pgtable will get very unhappy about DMA
> bounce-buffering.

Out of curiosity, are there Mali systems with >4GB RAM? That sounds
awesome :)

> Any chance of resurrecting the generic "arm,mali-midgard" compatible? :P

...Would that require editing everybody's DT file?

-----

Thank you for the review!
