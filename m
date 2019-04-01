From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
Date: Mon, 1 Apr 2019 10:24:44 +0200
Message-ID: <40a521b3-a99c-2cd3-f3ac-cfec873fc934@baylibre.com>
References: <20190401074730.12241-1-robh@kernel.org>
 <20190401074730.12241-4-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190401074730.12241-4-robh@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>, "Marty E . Plummer" <hanetzer@startmail.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>
List-Id: iommu@lists.linux-foundation.org

On 01/04/2019 09:47, Rob Herring wrote:
> This adds the initial driver for panfrost which supports Arm Mali
> Midgard and Bifrost family of GPUs. Currently, only the T860 and
> T760 Midgard GPUs have been tested.
> 
> v2:
> - Add GPU reset on job hangs (Tomeu)
> - Add RuntimePM and devfreq support (Tomeu)
> - Fix T760 support (Tomeu)
> - Add a TODO file (Rob, Tomeu)
> - Support multiple in fences (Tomeu)
> - Drop support for shared fences (Tomeu)
> - Fill in MMU de-init (Rob)
> - Move register definitions back to single header (Rob)
> - Clean-up hardcoded job submit todos (Rob)
> - Implement feature setup based on features/issues (Rob)
> - Add remaining Midgard DT compatible strings (Rob)
> 
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Eric Anholt <eric@anholt.net>
> Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Neil, I've kept your reset support separate for now. Let me know if you
> prefer me to squash it or keep it separate.

You can squash all my changes and add my sign-off.

Neil

> 
>  drivers/gpu/drm/Kconfig                      |   2 +
>  drivers/gpu/drm/Makefile                     |   1 +
>  drivers/gpu/drm/panfrost/Kconfig             |  14 +
>  drivers/gpu/drm/panfrost/Makefile            |  12 +
>  drivers/gpu/drm/panfrost/TODO                |  27 +
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c  | 191 +++++++
>  drivers/gpu/drm/panfrost/panfrost_devfreq.h  |  14 +
>  drivers/gpu/drm/panfrost/panfrost_device.c   | 227 ++++++++
>  drivers/gpu/drm/panfrost/panfrost_device.h   | 118 ++++
>  drivers/gpu/drm/panfrost/panfrost_drv.c      | 484 ++++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_features.h | 309 +++++++++++
>  drivers/gpu/drm/panfrost/panfrost_gem.c      |  92 +++
>  drivers/gpu/drm/panfrost/panfrost_gem.h      |  29 +
>  drivers/gpu/drm/panfrost/panfrost_gpu.c      | 374 +++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_gpu.h      |  19 +
>  drivers/gpu/drm/panfrost/panfrost_issues.h   | 176 ++++++
>  drivers/gpu/drm/panfrost/panfrost_job.c      | 556 +++++++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_job.h      |  51 ++
>  drivers/gpu/drm/panfrost/panfrost_mmu.c      | 366 ++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_mmu.h      |  17 +
>  drivers/gpu/drm/panfrost/panfrost_regs.h     | 298 ++++++++++
>  include/uapi/drm/panfrost_drm.h              | 140 +++++
>  22 files changed, 3517 insertions(+)
>  create mode 100644 drivers/gpu/drm/panfrost/Kconfig
>  create mode 100644 drivers/gpu/drm/panfrost/Makefile
>  create mode 100644 drivers/gpu/drm/panfrost/TODO
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_devfreq.c
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_devfreq.h
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_device.c
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_device.h
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_drv.c
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_features.h
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_gem.c
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_gem.h
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_gpu.c
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_gpu.h
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_issues.h
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_job.c
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_job.h
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_mmu.c
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_mmu.h
>  create mode 100644 drivers/gpu/drm/panfrost/panfrost_regs.h
>  create mode 100644 include/uapi/drm/panfrost_drm.h
> 
[...]
