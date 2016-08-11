From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V6 0/6] iommu/msm: Add DT adaptation and generic bindings support
Date: Thu, 11 Aug 2016 16:11:58 -0400
Message-ID: <CAF6AEGsF5M1sfwaXKW0x=Mu=nQJR-9+xqrtXd=7Vz_+6G_u25A@mail.gmail.com>
References: <1465817767-9856-1-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465817767-9856-1-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, stepanm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Archit Taneja <architt-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jun 13, 2016 at 7:36 AM, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> The msm_iommu.c driver currently works based on platform data.
> A single master device can be connected to more than one iommu and multiple
> contexts in each of the iommu. This association between master and iommus was
> represented from platform data using parent/child devices. The master drivers
> were responsible for attaching all of the iommus/context to a domain. Now the
> platform data support is removed and DT support is added. The master/iommus are
> added through generic iommu bindings.
>
> This is essentially rework of the patch posted earlier by
> Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>. This series folds the changes in to the
> existing driver with the addition of generic bindings.
>
>         http://www.spinics.net/lists/linux-arm-msm/msg10077.html
>
> Tested this series on ifc6410 board.

btw, the current state, at least on linaro integration branch, fault
handling doesn't work so well (ie. device never gets resumed).. which
is a bit unfortunate for a gpu (and results in a *lot* of rebooting on
my part when debugging userspace).  I haven't had time yet to compare
to the ancient downstream driver, but not sure if you have any ideas?

I guess probably disabling stall on fault would help.  But I'm not
even getting the "Fault occurred in context.." prints.  Seeing the
fault iova is pretty useful since that plus gpu cmdstream trace helps
me figure out which texture/etc is being accessed out of bounds.

BR,
-R

> [V6] After some discussions on patch 6 [1] from previous post,
>      it was concluded that the changes for using relaxed writes
>      in all places should not be a part of this series, so should
>      be moved it. So removed that patch and added Acked/Tested tags.
>      [1] https://patchwork.kernel.org/patch/9129231/
>
> [V5] Changed the compatible binding name as per comments, added comments
>      for usage of barriers in patch 6.
>
> [V4] Addressed comments for making the iommu compatible binding more soc
>      specific and updated the documentation for the iommu clocks.
>
> [V3] Addressed comments to correct the usage
>      of the #iommu-cells binding, improve the flush_iotlb_range function,
>      added a new patch to use writel_relaxed for register access and split
>      up the documentation patch.
>
> [V2] Adapted the driver to use generic ARMV7S short descriptor pagetable ops
>      and addressed comments.
>
> [V1]
>    https://lists.linuxfoundation.org/pipermail/iommu/2015-August/014074.html
>
> Sricharan R (6):
>   iommu/msm: Add DT adaptation
>   documentation: iommu: Add bindings for msm,iommu-v0 ip
>   iommu/msm: Move the contents from msm_iommu_dev.c to msm_iommu.c
>   iommu/msm: Add support for generic master bindings
>   iommu/msm: use generic ARMV7S short descriptor pagetable ops
>   iommu/msm: Remove driver BROKEN
>
>  .../devicetree/bindings/iommu/msm,iommu-v0.txt     |  64 ++
>  drivers/iommu/Kconfig                              |   2 +-
>  drivers/iommu/Makefile                             |   2 +-
>  drivers/iommu/msm_iommu.c                          | 870 +++++++++++----------
>  drivers/iommu/msm_iommu.h                          |  73 +-
>  drivers/iommu/msm_iommu_dev.c                      | 381 ---------
>  6 files changed, 564 insertions(+), 828 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
>  delete mode 100644 drivers/iommu/msm_iommu_dev.c
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
