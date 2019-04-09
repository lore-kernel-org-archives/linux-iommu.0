From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
Date: Tue, 9 Apr 2019 11:15:21 -0500
Message-ID: <CAL_Jsq+qcLRFX0xyKuFEDW3+n6oukfmgemtO4MumCFp_-qqcUg@mail.gmail.com>
References: <20190401074730.12241-1-robh@kernel.org> <20190401074730.12241-4-robh@kernel.org>
 <5efdc3cb-7367-65e1-d1bf-14051db5da10@arm.com> <CAL_Jsq+wAUS=gukDLoY6DWP40w4Wtyd_Y4B2S3KMCx2ekL97qg@mail.gmail.com>
 <CAAObsKCnycxxKWA+bUeU9vOu53eT9WZVkzdZ0KCtW9Xj9cV8Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAObsKCnycxxKWA+bUeU9vOu53eT9WZVkzdZ0KCtW9Xj9cV8Cw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Neil Armstrong <narmstrong@baylibre.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, Linux IOMMU <iommu@lists.linux-foundation.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "Marty E . Plummer" <hanetzer@startmail.com>, Sean Paul <sean@poorly.run>, Alyssa Rosenzweig <alyssa@rosenzweig.io>
List-Id: iommu@lists.linux-foundation.org

On Tue, Apr 9, 2019 at 10:56 AM Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>
> On Mon, 8 Apr 2019 at 23:04, Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Apr 5, 2019 at 7:30 AM Steven Price <steven.price@arm.com> wrote:
> > >
> > > On 01/04/2019 08:47, Rob Herring wrote:
> > > > This adds the initial driver for panfrost which supports Arm Mali
> > > > Midgard and Bifrost family of GPUs. Currently, only the T860 and
> > > > T760 Midgard GPUs have been tested.
> >
> > [...]
> > > > +
> > > > +             if (status & JOB_INT_MASK_ERR(j)) {
> > > > +                     job_write(pfdev, JS_COMMAND_NEXT(j), JS_COMMAND_NOP);
> > > > +                     job_write(pfdev, JS_COMMAND(j), JS_COMMAND_HARD_STOP_0);
> > >
> > > Hard-stopping an already completed job isn't likely to do very much :)
> > > Also you are using the "_0" version which is only valid when "job chain
> > > disambiguation" is present.
>
> Yeah, guess that can be removed.

Steven, TBC, are you suggesting removing both lines or leaving
JS_COMMAND_NOP? I don't think we can ever have a pending job at this
point as there's no queuing. So the NOP probably isn't needed, but
doesn't hurt to have it either.

> > > I suspect in this case you should also be signalling the fence? At the
> > > moment you rely on the GPU timeout recovering from the fault.
> >
> > I'll defer to Tomeu who wrote this (IIRC).
>
> Yes, that would be an improvement.

Actually, I think that would break recovery because the job timeout
will bail out if the done fence is signaled already. Perhaps we want
to timeout immediately if that is possible with the scheduler.

Rob
