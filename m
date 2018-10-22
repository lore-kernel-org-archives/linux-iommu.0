From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC PATCH 0/6] Auxiliary IOMMU domains and Arm SMMUv3
Date: Mon, 22 Oct 2018 06:53:34 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19BE0E176@SHSMSX101.ccr.corp.intel.com>
References: <20181019181158.2395-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181019181158.2395-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Cc: "rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "robin.murphy-5wv7dgnIgG8@public.gmane.org" <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org]
> Sent: Saturday, October 20, 2018 2:12 AM
> 
> This is a first prototype adding auxiliary domain support to Arm SMMUv3,
> following Lu Baolu's latest proposal for IOMMU aware mediated devices
> [1]. It works, but the attach() API still doesn't feel right. See (2)
> below.
> 
> Patch 1 adapts iommu.c to the current proposal for auxiliary domains.
> Patches 2-4 rework the PASID allocator to make it usable for SVA and
> AUXD simultaneously. Patches 5-6 add AUXD support to SMMUv3.
> 
> 
> When a device can have multiple address space, for instance with PCI
> PASID, an auxiliary domain (AUXD) is the IOMMU representation of one
> address space. I distinguish auxiliary from "main" domain, which
> represents the non-PASID address space but also (at least for SMMUv3)
> the whole device context, PASID tables etc.

I'd like to clarify a bit. :-)

a domain can always represent one or more address spaces, where an 
address space could be for IOVA or GPA and/or other address spaces for 
SVA. Address spaces may be chained together in so-called nested mode.

a domain can be associated with a full device (in BDF granular), and/or 
with a partition of a device (say in PASID granular). In the former case,
the domain becomes the master (or primary) domain of the device. In
the latter case, the domain becomes the auxiliary domain of the device.

vendor domain structure may include vendor-specific states which
are applied to device context at attach time, e.g. PASID table (SMMUv3) 
if representing as master domain, or PASID value (VT-d scalable mode)
if representing as auxiliary domain.

so the domain definition is never changed with the introduction of
AUXD. 'auxiliary' is a per-device attribute which takes effect when at
domain attach time. A domain is perfectly sane to represent as a
master domain to deviceA and an auxiliary domain to deviceB at the
same time (say when device A and a mdev on deviceB are assigned to
same VM), while supporting one or more address spaces.

I explained above concept in my KVM forum session:

https://events.linuxfoundation.org/wp-content/uploads/2017/12/Hardware-Assisted-Mediated-Pass-Through-with-VFIO-Kevin-Tian-Intel.pdf (slide 16/17)

> 
> Auxiliary domains will be used by VFIO for IOMMU-aware mdev, and by
> any
> other device driver that wants to use PASID for private address spaces
> (as opposed to SVA [2]). The following API is available to device
> drivers:
> 
> (1) Enable AUXD for a device. Enable PASID if necessary and set an AUXD
>     flag on the IOMMU data associated to a device.
> 
>     For my own convenience I've been using the SVA infrastructure since
>     I already had the locking and IOMMU ops in place. The proposed
>     interface is also missing min_pasid and max_pasid parameters, which
>     could be needed by device drivers to enforce PASID limits.
>     iommu_sva_init_device() without arguments already enables PASID, so
>     I just added an AUXD flag to SVA features:
> 
>       iommu_sva_init_device(dev, IOMMU_SVA_FEAT_AUXD,
>                             min_pasid, max_pasid, NULL)
>       iommu_sva_shutdown_device(dev)
> 
>     Or as proposed in [1]:
> 
>       iommu_set_dev_attr(dev, IOMMU_DEV_ATTR_AUXD_ENABLE, NULL)
>       iommu_set_dev_attr(dev, IOMMU_DEV_ATTR_AUXD_DISABLE, NULL)
> 
>     Finding a compromise for this interface should be easy.
> 
> (2) Allocate a domain and attach it to the device.
> 
>       dom = iommu_domain_alloc()
>       iommu_attach_device(dom, dev)
> 
>     I still have concerns about this part, which are highlighted by the
>     messy changes of patch 1. I think it would make more sense to
>     introduce new attach/detach_dev_aux() functions instead of reusing
>     attach/detach_dev()
> 
>     Can we reconsider this and avoid unnecessary complications in IOMMU
>     core and drivers? Does the VFIO code greatly benefit from using the
>     same attach() function? It could as well use a different one for
>     devices in AUXD mode, which the mediating driver could tell by
>     adding a flag in mdev_set_iommu_device(), for example.

Baolu gave some recommendations to patch 1. Please check whether it can
help reduce the mess.

IMO using same API is conceptually clearer to VFIO... let's gather in KVM
forum to have a conclusion, with Alex being there.

Thanks
Kevin

> 
>     And I don't think other users of AUXD would benefit from using the
>     same attach() function, since they will know whether they want to be
>     using main or auxiliary domain when doing attach().
> 
> (3) Get the PASID, and program it in the device
> 
>       iommu_domain_get_attr(dom, DOMAIN_ATTR_AUXD_ID, &pasid)
> 
> (4) Create DMA mappings
> 
>       iommu_map(dom, ...)
>       iommu_unmap(dom, ...)
> 
>     Ultimately it would be nice to add PASID support to the DMA API as
>     well. For now drivers allocate IOVAs and pages themselves.
> 
> 
> For vfio-mdev, a driver that wants to create mdevs only performs steps (1)
> and (3):
> 
> * When initializing the parent device, enable AUXD (1)
> * In mdev_parent_ops::create(), call
> mdev_set_iommu_device(mdev_dev(mdev),
>   mdev_parent_dev(mdev)).
> * In mdev_parent_ops::open(), get the PASID (3) and install it in the
>   parent device.
> * In mdev_parent_ops::close(), clear the PASID
> 
> 
> This code and the many patches it depends on can be found on my
> iommu/auxd branch:
> 	git://linux-arm.org/linux-jpb.git iommu/auxd
> 
> [1] [PATCH v3 0/8] vfio/mdev: IOMMU aware mediated device
>     https://lwn.net/ml/linux-kernel/20181012051632.26064-1-
> baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org/
> [2] [PATCH v3 00/10] Shared Virtual Addressing for the IOMMU
>     https://www.spinics.net/lists/iommu/msg30076.html
> 
> Jean-Philippe Brucker (6):
>   iommu: Adapt attach/detach_dev() for auxiliary domains
>   drivers core: Add I/O ASID allocator
>   iommu/sva: Use external PASID allocator
>   iommu/sva: Support AUXD feature
>   iommu/arm-smmu-v3: Implement detach_dev op
>   iommu/arm-smmu-v3: Add support for auxiliary domains
> 
>  drivers/base/Kconfig        |   7 ++
>  drivers/base/Makefile       |   1 +
>  drivers/base/ioasid.c       | 140 ++++++++++++++++++++++++++++++
>  drivers/iommu/Kconfig       |   1 +
>  drivers/iommu/arm-smmu-v3.c | 164
> ++++++++++++++++++++++++++++++++++--
>  drivers/iommu/iommu-sva.c   | 113 +++++++++++++++++--------
>  drivers/iommu/iommu.c       |  58 +++++++++----
>  include/linux/ioasid.h      |  45 ++++++++++
>  include/linux/iommu.h       |  12 +++
>  9 files changed, 479 insertions(+), 62 deletions(-)
>  create mode 100644 drivers/base/ioasid.c
>  create mode 100644 include/linux/ioasid.h
> 
> --
> 2.19.1
