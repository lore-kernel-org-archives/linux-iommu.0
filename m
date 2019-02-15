From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] iommu/arm-smmu: Allow disabling bypass via kernel config
Date: Thu, 14 Feb 2019 16:40:26 -0800
Message-ID: <CAD=FV=WeBD0bqxWPZcV1dz5Sdn47Ap=FZU3Y+YPbxsVCQEUcLQ@mail.gmail.com>
References: <20190214204433.155715-1-dianders@chromium.org> <4238ceb7-d286-9ef9-39b6-b2e0571f2981@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4238ceb7-d286-9ef9-39b6-b2e0571f2981@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will.deacon@arm.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Vivek Gautam <vivek.gautam@codeaurora.org>, Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@chromium.org>, LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

Hi,

On Thu, Feb 14, 2019 at 1:32 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Hi Doug,
>
> On 2019-02-14 8:44 pm, Douglas Anderson wrote:
> > Right now the only way to disable the iommu bypass for the ARM SMMU is
> > with the kernel command line parameter 'arm-smmu.disable_bypass'.
> >
> > In general kernel command line parameters make sense for things that
> > someone would like to tweak without rebuilding the kernel or for very
> > basic communication between the bootloader and the kernel, but are
> > awkward for other things.  Specifically:
> > * Human parsing of the kernel command line can be difficult since it's
> >    just a big runon space separated line of text.
> > * If every bit of the system was configured via the kernel command
> >    line the kernel command line would get very large and even more
> >    unwieldly.
> > * Typically there are not easy ways in build systems to adjust the
> >    kernel command line for config-like options.
> >
> > Let's introduce a new config option that allows us to disable the
> > iommu bypass without affecting the existing default nor the existing
> > ability to adjust the configuration via kernel command line.
>
> I say let's just flip the default - for a while now it's been one of
> those "oh yeah, we should probably do that" things that gets instantly
> forgotten again, so some 3rd-party demand is plenty to convince me :)
>
> There are few reasons to allow unmatched stream bypass, and even fewer
> good ones, so I'd be happy to shift the command-line burden over to the
> esoteric cases at this point, and consider the config option in future
> if anyone from that camp pops up and screams hard enough.

Sure, I can submit that patch if we want.  I presume I'll get lots of
screaming but I'm used to that.  ;-)

...specifically I found that when I turned on "disably bypass" on my
board (sdm845-cheza, which is not yet upstream) that a bunch of things
that used to work broke.  That's a good thing because all the things
that broke need to be fixed properly (by adding the IOMMUs) but
presumably my board is not special in relying on the old insecure
behavior.

I'm about to head on vacation for a week so I'm not sure I'll get to
re-post before then.  If not I'll post this sometime after I get back
unless someone beats me to it.

-Doug
