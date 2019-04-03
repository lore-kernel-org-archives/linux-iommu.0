From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
Date: Tue, 2 Apr 2019 23:57:01 -0500
Message-ID: <CAL_JsqKbqNDMx26Tkyrem-NXF_0iApcWaaEDphtfy6kX050Upg@mail.gmail.com>
References: <20190401074730.12241-1-robh@kernel.org> <20190401074730.12241-4-robh@kernel.org>
 <6ce32759-ea83-ee79-33d3-237737f7b866@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6ce32759-ea83-ee79-33d3-237737f7b866@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>, Neil Armstrong <narmstrong@baylibre.com>, "Marty E . Plummer" <hanetzer@startmail.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 1, 2019 at 2:12 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 01/04/2019 08:47, Rob Herring wrote:
> > This adds the initial driver for panfrost which supports Arm Mali
> > Midgard and Bifrost family of GPUs. Currently, only the T860 and
> > T760 Midgard GPUs have been tested.
>
> FWIW, on an antique T624 (Juno) it seems to work no worse than the kbase
> driver plus panfrost-nondrm, which is to say it gets far enough to prove
> that the userspace definitely doesn't support T624 (kmscube manages to
> show a grey background, but the GPU is constantly falling over with page
> faults trying to dereference address 0 - for obvious reasons I'm not
> going to get any further involved in debugging that).
>
> A couple of discoveries and general observations below.
>
> > v2:
> > - Add GPU reset on job hangs (Tomeu)
> > - Add RuntimePM and devfreq support (Tomeu)
> > - Fix T760 support (Tomeu)
> > - Add a TODO file (Rob, Tomeu)
> > - Support multiple in fences (Tomeu)
> > - Drop support for shared fences (Tomeu)
> > - Fill in MMU de-init (Rob)
> > - Move register definitions back to single header (Rob)
> > - Clean-up hardcoded job submit todos (Rob)
> > - Implement feature setup based on features/issues (Rob)
> > - Add remaining Midgard DT compatible strings (Rob)
> >
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Cc: Sean Paul <sean@poorly.run>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> > Cc: Lyude Paul <lyude@redhat.com>
> > Cc: Eric Anholt <eric@anholt.net>
> > Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
> > Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> [...]
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
> > new file mode 100644
> > index 000000000000..227ba5202a6f
> > --- /dev/null
> > +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
> > @@ -0,0 +1,227 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
> > +/* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +#include "panfrost_device.h"
> > +#include "panfrost_devfreq.h"
> > +#include "panfrost_features.h"
> > +#include "panfrost_gpu.h"
> > +#include "panfrost_job.h"
> > +#include "panfrost_mmu.h"
> > +
> > +static int panfrost_clk_init(struct panfrost_device *pfdev)
> > +{
> > +     int err;
> > +     unsigned long rate;
> > +
> > +     pfdev->clock = devm_clk_get(pfdev->dev, NULL);
> > +     if (IS_ERR(pfdev->clock)) {
>
> The DT binding says clocks are optional, but this doesn't treat them as
> such.

Hum, I would think effectively clocks are always there and necessary
for thermal reasons.


> > +     spin_lock_init(&pfdev->mm_lock);
> > +
> > +     /* 4G enough for now. can be 48-bit */
> > +     drm_mm_init(&pfdev->mm, SZ_32M >> PAGE_SHIFT, SZ_4G);
>
> You probably want a dma_set_mask_and_coherent() call for your 'real'
> output address size somewhere - the default 32-bit mask works out OK for
> RK3399, but on systems with RAM above 4GB io-pgtable will get very
> unhappy about DMA bounce-buffering.

Yes, I have a todo for figuring out the # of physaddr bits in the mmu
setup (as this call is just relevant to the input address side).
Though maybe just calling dma_set_mask_and_coherent() is enough and I
don't need to know the exact number of output bits for the io-pgtable
setup?

> > +     return err;
> > +}
> > +
> > +static int panfrost_remove(struct platform_device *pdev)
> > +{
> > +     struct panfrost_device *pfdev = platform_get_drvdata(pdev);
> > +     struct drm_device *ddev = pfdev->ddev;
> > +
> > +     drm_dev_unregister(ddev);
> > +     pm_runtime_get_sync(pfdev->dev);
> > +     pm_runtime_put_sync_autosuspend(pfdev->dev);
> > +     pm_runtime_disable(pfdev->dev);
> > +     panfrost_device_fini(pfdev);
> > +     drm_dev_put(ddev);
> > +     return 0;
> > +}
> > +
> > +static const struct of_device_id dt_match[] = {
> > +     { .compatible = "arm,mali-t604" },
> > +     { .compatible = "arm,mali-t624" },
> > +     { .compatible = "arm,mali-t628" },
> > +     { .compatible = "arm,mali-t720" },
> > +     { .compatible = "arm,mali-t760" },
> > +     { .compatible = "arm,mali-t820" },
> > +     { .compatible = "arm,mali-t830" },
> > +     { .compatible = "arm,mali-t860" },
> > +     { .compatible = "arm,mali-t880" },
>
> Any chance of resurrecting the generic "arm,mali-midgard" compatible? :P

I wouldn't mind, but we still need all these and I don't think we'd be
adding more. For bifrost, we're adding 'arm,mali-bifrost' from the
start.

> > diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> > new file mode 100644
> > index 000000000000..867e2ba3a761
> > --- /dev/null
> > +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> [...]

> > +     /* Limit read & write ID width for AXI */
> > +     if (panfrost_has_hw_feature(pfdev, HW_FEATURE_3BIT_EXT_RW_L2_MMU_CONFIG))
> > +             quirks &= ~(L2_MMU_CONFIG_3BIT_LIMIT_EXTERNAL_READS |
> > +                         L2_MMU_CONFIG_3BIT_LIMIT_EXTERNAL_WRITES);
> > +     else
> > +             quirks &= ~(L2_MMU_CONFIG_LIMIT_EXTERNAL_READS |
> > +                         L2_MMU_CONFIG_LIMIT_EXTERNAL_WRITES);
> > +
> > +#if 0
> > +     if (kbdev->system_coherency == COHERENCY_ACE) {
> > +             /* Allow memory configuration disparity to be ignored, we
> > +              * optimize the use of shared memory and thus we expect
> > +              * some disparity in the memory configuration */
> > +             quirks |= L2_MMU_CONFIG_ALLOW_SNOOP_DISPARITY;
>
> Well that sounds terrifying; I rather wish my brain had preprocessed
> that #if already.

What can I say, copied from Arm's driver. I'm just going to drop for now.

>
> > +     }
> > +#endif
> > +     gpu_write(pfdev, GPU_L2_MMU_CONFIG, quirks);
> > +
> > +     quirks = 0;
> > +     if ((panfrost_model_eq(pfdev, 0x860) || panfrost_model_eq(pfdev, 0x880)) &&
> > +         pfdev->features.revision >= 0x2000)
> > +             quirks |= JM_MAX_JOB_THROTTLE_LIMIT << JM_JOB_THROTTLE_LIMIT_SHIFT;
> > +     else if (panfrost_model_eq(pfdev, 0x6000) &&
> > +              pfdev->features.coherency_features == COHERENCY_ACE)
> > +             quirks |= (COHERENCY_ACE_LITE | COHERENCY_ACE) <<
> > +                        JM_FORCE_COHERENCY_FEATURES_SHIFT;
>
> Experience says you can never really trust what ID registers claim about
> system integration stuff like coherency, because eventually someone will
> get a tieoff wrong and make it all fall apart. If even the vendor driver
> has a DT override for it you know you're on thin ice ;)

Unlike the vendor driver, we only have to care about cases seen upstream...

> Ultimately, most of your I/O coherency behaviour will be governed by
> what the DMA API thinks (based on "dma-coherent"), so if you end up with
> mismatched expectations at the point coherency_features gets set up then
> you're liable to have a bad time. See the arm-smmu drivers for prior
> examples of handling the equivalent thing.

None of this matters til bifrost and a platform implementing this, so
I'll worry about it then.

Thanks for the review.

Rob
