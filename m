From: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [RFC 0/5] vfio: AMBA devices support
Date: Mon, 25 Aug 2014 18:56:11 -0500
Message-ID: <20140825185611.cc359282a66d6afe7a4a590e@freescale.com>
References: <1408698088-5349-1-git-send-email-a.motakis@virtualopensystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1408698088-5349-1-git-send-email-a.motakis@virtualopensystems.com>
Sender: kvm-owner@vger.kernel.org
To: Antonios Motakis <a.motakis@virtualopensystems.com>
Cc: alex.williamson@redhat.com, kvmarm@lists.cs.columbia.edu, iommu@lists.linux-foundation.org, tech@virtualopensystems.com, a.rigo@virtualopensystems.com, kvm@vger.kernel.org, christoffer.dall@linaro.org, will.deacon@arm.com, stuart.yoder@freescale.com, eric.auger@linaro.org, marc.zyngier@arm.com
List-Id: iommu@lists.linux-foundation.org

On Fri, 22 Aug 2014 11:01:23 +0200
Antonios Motakis <a.motakis@virtualopensystems.com> wrote:

> This patch series depends on the VFIO for PLATFORM devices patch series,
> and implements AMBA device support for VFIO.

...

>  drivers/amba/bus.c                            |  43 +++
>  drivers/vfio/platform/Kconfig                 |  10 +
>  drivers/vfio/platform/Makefile                |   6 +-
>  drivers/vfio/platform/vfio_amba.c             | 129 +++++++++
>  drivers/vfio/platform/vfio_platform.c         | 355 +-----------------------
>  drivers/vfio/platform/vfio_platform_common.c  | 380 ++++++++++++++++++++++++++
>  drivers/vfio/platform/vfio_platform_irq.c     |   6 +-
>  drivers/vfio/platform/vfio_platform_private.h |   9 +-
>  include/linux/amba/bus.h                      |   1 +
>  9 files changed, 591 insertions(+), 348 deletions(-)
>  create mode 100644 drivers/vfio/platform/vfio_amba.c
>  create mode 100644 drivers/vfio/platform/vfio_platform_common.c

I think this patchseries should be merged with its dependent
patchseries, in order to not have to review the common vfio_platform
code twice.

just my 2c.

Thanks,

Kim
