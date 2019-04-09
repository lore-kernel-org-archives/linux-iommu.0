From: Rob Herring <robh@kernel.org>
Subject: [PATCH v3 0/3] Initial Panfrost driver
Date: Tue,  9 Apr 2019 15:54:24 -0500
Message-ID: <20190409205427.6943-1-robh@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Lyude Paul <lyude@redhat.com>, Eric Anholt <eric@anholt.net>, Neil Armstrong <narmstrong@baylibre.com>, Steven Price <steven.price@arm.com>, Boris Brezillon <boris.brezillon@collabora.com>
List-Id: iommu@lists.linux-foundation.org

Here's v3 of the panfrost driver. Lot's of changes from review comments
and further testing. Details are in each patch. Of note, a problem with
MMU page faults has been addressed improving the stability. In the
process, the TLB invalidate has been optimized which Tomeu says has
improved the performance some.

Several dependencies have been applied already, but the first 2 patches
are the remaining dependencies. We need to take the iommu change via
drm-misc or we need a stable branch.

I'm hoping this is the last version. I'm hoping to apply this to drm-misc
this week before -rc5 cutoff.

A git branch is here[1].

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git panfrost-rebase-v3


Rob Herring (3):
  iommu: io-pgtable: Add ARM Mali midgard MMU page table format
  drm: Add a drm_gem_objects_lookup helper
  drm/panfrost: Add initial panfrost driver

 MAINTAINERS                                  |   9 +
 drivers/gpu/drm/Kconfig                      |   2 +
 drivers/gpu/drm/Makefile                     |   1 +
 drivers/gpu/drm/drm_gem.c                    |  93 ++-
 drivers/gpu/drm/panfrost/Kconfig             |  14 +
 drivers/gpu/drm/panfrost/Makefile            |  12 +
 drivers/gpu/drm/panfrost/TODO                |  27 +
 drivers/gpu/drm/panfrost/panfrost_devfreq.c  | 218 ++++++++
 drivers/gpu/drm/panfrost/panfrost_devfreq.h  |  14 +
 drivers/gpu/drm/panfrost/panfrost_device.c   | 252 +++++++++
 drivers/gpu/drm/panfrost/panfrost_device.h   | 124 ++++
 drivers/gpu/drm/panfrost/panfrost_drv.c      | 460 +++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_features.h | 309 ++++++++++
 drivers/gpu/drm/panfrost/panfrost_gem.c      |  95 ++++
 drivers/gpu/drm/panfrost/panfrost_gem.h      |  29 +
 drivers/gpu/drm/panfrost/panfrost_gpu.c      | 362 ++++++++++++
 drivers/gpu/drm/panfrost/panfrost_gpu.h      |  19 +
 drivers/gpu/drm/panfrost/panfrost_issues.h   | 176 ++++++
 drivers/gpu/drm/panfrost/panfrost_job.c      | 560 +++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_job.h      |  51 ++
 drivers/gpu/drm/panfrost/panfrost_mmu.c      | 369 ++++++++++++
 drivers/gpu/drm/panfrost/panfrost_mmu.h      |  17 +
 drivers/gpu/drm/panfrost/panfrost_regs.h     | 298 ++++++++++
 drivers/iommu/io-pgtable-arm.c               |  91 ++-
 drivers/iommu/io-pgtable.c                   |   1 +
 include/drm/drm_gem.h                        |   2 +
 include/linux/io-pgtable.h                   |   7 +
 include/uapi/drm/panfrost_drm.h              | 142 +++++
 28 files changed, 3722 insertions(+), 32 deletions(-)
 create mode 100644 drivers/gpu/drm/panfrost/Kconfig
 create mode 100644 drivers/gpu/drm/panfrost/Makefile
 create mode 100644 drivers/gpu/drm/panfrost/TODO
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_devfreq.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_devfreq.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_device.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_device.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_drv.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_features.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_gem.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_gem.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_gpu.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_gpu.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_issues.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_job.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_job.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_mmu.c
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_mmu.h
 create mode 100644 drivers/gpu/drm/panfrost/panfrost_regs.h
 create mode 100644 include/uapi/drm/panfrost_drm.h

--
2.19.1
