From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/3] drm: Add a drm_gem_objects_lookup helper
Date: Mon, 8 Apr 2019 15:09:06 -0500
Message-ID: <CAL_Jsq+So-kadir8o8T-YNYkfOYD8vopAS3UWGbSdRVLjH_JGQ@mail.gmail.com>
References: <20190401074730.12241-1-robh@kernel.org> <20190401074730.12241-3-robh@kernel.org>
 <CAKMK7uE7-XV3cZxS8GT_EDa7yojOLPQi+LqkF85h_0z_JL6gYw@mail.gmail.com>
 <155412649586.24691.809508732198367112@skylake-alporthouse-com> <8736n120jw.fsf@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8736n120jw.fsf@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Anholt <eric@anholt.net>
Cc: Chris Wilson <chris@chris-wilson.co.uk>, Daniel Vetter <daniel@ffwll.ch>, Neil Armstrong <narmstrong@baylibre.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Sean Paul <sean@poorly.run>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Steven Price <steven.price@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 1, 2019 at 10:43 AM Eric Anholt <eric@anholt.net> wrote:
>
> Chris Wilson <chris@chris-wilson.co.uk> writes:
>
> > Quoting Daniel Vetter (2019-04-01 14:06:48)
> >> On Mon, Apr 1, 2019 at 9:47 AM Rob Herring <robh@kernel.org> wrote:
> >> > +{
> >> > +       int i, ret = 0;
> >> > +       struct drm_gem_object *obj;
> >> > +
> >> > +       spin_lock(&filp->table_lock);
> >> > +
> >> > +       for (i = 0; i < count; i++) {
> >> > +               /* Check if we currently have a reference on the object */
> >> > +               obj = idr_find(&filp->object_idr, handle[i]);
> >> > +               if (!obj) {
> >> > +                       ret = -ENOENT;
> >
> > Unwind previous drm_gem_object_get(), the caller has no idea how many
> > were processed before the error.
>
> I had the same thought, but the pattern we have is that you're loading
> into a refcounted struct that will free the BOs when you're done,
> anyway.

The real bug here is if allocation of the array fails. The BO array
may be NULL when the count is not. So this V3D cleanup hunk:

for (i = 0; i < exec->bo_count; i++)
  drm_gem_object_put_unlocked(&exec->bo[i]->base.base);
  kvfree(exec->bo);

Needs to be wrapped with 'if (exec->bo)'. We have a similar problem
with fence arrays too.

Thanks to Steven for noticing this copied code in panfrost.

Rob
