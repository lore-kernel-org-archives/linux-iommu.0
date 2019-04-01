From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 2/3] drm: Add a drm_gem_objects_lookup helper
Date: Mon, 1 Apr 2019 15:06:48 +0200
Message-ID: <CAKMK7uE7-XV3cZxS8GT_EDa7yojOLPQi+LqkF85h_0z_JL6gYw@mail.gmail.com>
References: <20190401074730.12241-1-robh@kernel.org> <20190401074730.12241-3-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401074730.12241-3-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>, Neil Armstrong <narmstrong@baylibre.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 1, 2019 at 9:47 AM Rob Herring <robh@kernel.org> wrote:
>
> Similar to the single handle drm_gem_object_lookup(),
> drm_gem_objects_lookup() takes an array of handles and returns an array
> of GEM objects.
>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/gpu/drm/drm_gem.c | 46 +++++++++++++++++++++++++++++++--------
>  include/drm/drm_gem.h     |  2 ++
>  2 files changed, 39 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 388b3742e562..5c9bff45e5e1 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -663,6 +663,42 @@ void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
>  }
>  EXPORT_SYMBOL(drm_gem_put_pages);
>
> +/**
> + * drm_gem_objects_lookup - look up GEM objects from an array of handles
> + * @filp: DRM file private date
> + * @handle: pointer to array of userspace handle
> + * @count: size of handle array
> + * @objs: pointer to array of drm_gem_object pointers
> + *
> + * Returns:
> + *
> + * @objs filled in with GEM object pointers. -ENOENT is returned on a lookup
> + * failure. 0 is returned on success.

Bonus points for adding references between the array and normal lookup
functions to guide people around. Also a comment that the buffers need
to be released with drm_gem_object_put().

> + */
> +int drm_gem_objects_lookup(struct drm_file *filp, u32 *handle, int count,
> +                          struct drm_gem_object **objs)

With a pointer to a pointer I'd expect this function to do the
allocation, but it doesn't. Normal pointer is enough to pass an array.
Also maybe make the handle pointer
const, so it's clear that it's an input parameter.

With the bikesheds addressed:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +{
> +       int i, ret = 0;
> +       struct drm_gem_object *obj;
> +
> +       spin_lock(&filp->table_lock);
> +
> +       for (i = 0; i < count; i++) {
> +               /* Check if we currently have a reference on the object */
> +               obj = idr_find(&filp->object_idr, handle[i]);
> +               if (!obj) {
> +                       ret = -ENOENT;
> +                       break;
> +               }
> +               drm_gem_object_get(obj);
> +               objs[i] = obj;
> +       }
> +       spin_unlock(&filp->table_lock);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL(drm_gem_objects_lookup);
> +
>  /**
>   * drm_gem_object_lookup - look up a GEM object from its handle
>   * @filp: DRM file private date
> @@ -678,15 +714,7 @@ drm_gem_object_lookup(struct drm_file *filp, u32 handle)
>  {
>         struct drm_gem_object *obj;
>
> -       spin_lock(&filp->table_lock);
> -
> -       /* Check if we currently have a reference on the object */
> -       obj = idr_find(&filp->object_idr, handle);
> -       if (obj)
> -               drm_gem_object_get(obj);
> -
> -       spin_unlock(&filp->table_lock);
> -
> +       drm_gem_objects_lookup(filp, &handle, 1, &obj);
>         return obj;
>  }
>  EXPORT_SYMBOL(drm_gem_object_lookup);
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 2955aaab3dca..5404225e0194 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -381,6 +381,8 @@ struct page **drm_gem_get_pages(struct drm_gem_object *obj);
>  void drm_gem_put_pages(struct drm_gem_object *obj, struct page **pages,
>                 bool dirty, bool accessed);
>
> +int drm_gem_objects_lookup(struct drm_file *filp, u32 *handle, int count,
> +                          struct drm_gem_object **objs);
>  struct drm_gem_object *drm_gem_object_lookup(struct drm_file *filp, u32 handle);
>  long drm_gem_reservation_object_wait(struct drm_file *filep, u32 handle,
>                                     bool wait_all, unsigned long timeout);
> --
> 2.19.1
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
