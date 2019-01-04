From: Eric Wong <e@80x24.org>
Subject: Re: iommu_intel or i915 regression in 4.18, 4.19.12 and drm-tip
Date: Fri, 4 Jan 2019 01:06:26 +0000
Message-ID: <20190104010626.e6yqdqkmdcqjepke@dcvr>
References: <20181227114948.ev4b3jte3ubsc5us@dcvr>
 <154642214920.6261.102817444136744919@jlahtine-desk.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <154642214920.6261.102817444136744919@jlahtine-desk.ger.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>, David Woodhouse <dwmw2@infradead.org>, Jani Nikula <jani.nikula@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Joonas Lahtinen <joonas.lahtinen@linux.intel.com> wrote:
> Quoting Eric Wong (2018-12-27 13:49:48)
> > I just got a used Thinkpad X201 (Core i5 M 520, Intel QM57
> > chipset) and hit some kernel panics while trying to view
> > image/animation-intensive stuff in Firefox (X11) unless I use
> > "iommu_intel=igfx_off".
> > 
> > With Debian stable backport kernels, "linux-image-4.17.0-0.bpo.3-amd64"
> > (4.17.17-1~bpo9+1) has no problems.  But "linux-image-4.18.0-0.bpo.3-amd64"
> > (4.18.20-2~bpo9+1) gives a blank screen before I can login via agetty
> > and run startx.

> Most confusing about this is that 4.17 would have worked to begin with,
> without intel_iommu=igfx_off (unless it was the default for older
> kernel?)

Yeah, so the Debian bpo 4.17(.17) kernel did not set
CONFIG_INTEL_IOMMU_DEFAULT_ON, so I didn't encounter problems.
My self-built kernels all set CONFIG_INTEL_IOMMU_DEFAULT_ON.

Booting the Debian 4.17 kernel with "intel_iommu=on" gives the
same hanging problem I hit with self-built 4.19.{12,13} kernels.

I'm not sure how far back the problem goes (maybe forever),
since I only got this hardware.  Not sure what's the problem
with Debian 4.18, either; but (self-built) 4.19.13 is fine w/o
CONFIG_INTEL_IOMMU_DEFAULT_ON.

Debian backports doesn't have kernels for 4.19 or 4.20, yet.

> Did you maybe update other parts of the system while updating the
> kernel?

Definitely not; just the kernel + headers ("make bindeb-pkg)".

> If you could attach full boot dmesg from working and non-working kernel +
> have config file of both kernel's in Bugzilla. That'd be a good start!

Sorry, I get anxiety attacks when it comes to logins and forms.
Anyways, I managed to get the Debian kernel dmesg output uploaded
with and without iommu_intel=on:
https://bugs.freedesktop.org/attachment.cgi?bugid=109219
