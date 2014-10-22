From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [PATCH v8 07/18] vfio/platform: return info for device memory
	mapped IO regions
Date: Wed, 22 Oct 2014 15:54:46 +0200
Message-ID: <CAG8rG2yiqBk2Y+b0WvcZGypNj3XhGDNet-GM3yOYaLiHc4pU=w@mail.gmail.com>
References: <1413205825-6370-1-git-send-email-a.motakis@virtualopensystems.com>
	<1413205825-6370-8-git-send-email-a.motakis@virtualopensystems.com>
	<1413909282.4202.141.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1413909282.4202.141.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "open list:VFIO DRIVER" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, VirtualOpenSystems Technical Team <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Oct 21, 2014 at 6:34 PM, Alex Williamson
<alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Mon, 2014-10-13 at 15:10 +0200, Antonios Motakis wrote:
>> This patch enables the IOCTLs VFIO_DEVICE_GET_REGION_INFO ioctl call,
>> which allows the user to learn about the available MMIO resources of
>> a device.
>>
>> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
>> ---
>>  drivers/vfio/platform/vfio_platform_common.c  | 93 +++++++++++++++++++++++++--
>>  drivers/vfio/platform/vfio_platform_private.h | 22 +++++++
>>  2 files changed, 111 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/vfio/platform/vfio_platform_common.c b/drivers/vfio/platform/vfio_platform_common.c
>> index 1e4073f..8a7e474 100644
>> --- a/drivers/vfio/platform/vfio_platform_common.c
>> +++ b/drivers/vfio/platform/vfio_platform_common.c
>> @@ -27,17 +27,84 @@
>>
>>  #include "vfio_platform_private.h"
>>
>> +static int vfio_platform_regions_init(struct vfio_platform_device *vdev)
>> +{
>> +     int cnt = 0, i;
>> +
>> +     while (vdev->get_resource(vdev, cnt))
>> +             cnt++;
>> +
>> +     vdev->regions = kcalloc(cnt, sizeof(struct vfio_platform_region),
>> +                             GFP_KERNEL);
>> +     if (!vdev->regions)
>> +             return -ENOMEM;
>> +
>> +     for (i = 0; i < cnt;  i++) {
>> +             struct resource *res =
>> +                     vdev->get_resource(vdev, i);
>> +
>> +             if (!res)
>> +                     goto err;
>> +
>> +             vdev->regions[i].addr = res->start;
>> +             vdev->regions[i].size = resource_size(res);
>> +             vdev->regions[i].flags = 0;
>> +
>> +             switch (resource_type(res)) {
>> +             case IORESOURCE_MEM:
>> +                     vdev->regions[i].type = VFIO_PLATFORM_REGION_TYPE_MMIO;
>> +                     break;
>> +             case IORESOURCE_IO:
>> +                     vdev->regions[i].type = VFIO_PLATFORM_REGION_TYPE_PIO;
>> +                     break;
>
> Ok, we have support for PIO in platform now (thanks!), does the user
> know what type of region they're dealing with?  Do they care?  For PCI
> the user tests the PCI BAR in config space to determine which type it
> is.  I'm guessing that platform would do something similar against the
> device tree or ACPI, right?

Maybe is worthwhile to add an explicit flag in
VFIO_DEVICE_GET_REGION_INFO for PIO regions. For platform devices I
don't know if we can always rely on DT or ACPI info to be available.
For VFIO PCI the BAR is always implemented, and while I have proposed
an RFC to return DT information, I don't think we can assume how a
device is described in the host, whether DT, ACPI, or dark magic.

>
>> +             default:
>> +                     goto err;
>> +             }
>> +     }
>> +
>> +     vdev->num_regions = cnt;
>> +
>> +     return 0;
>> +err:
>> +     kfree(vdev->regions);
>> +     return -EINVAL;
>> +}
>> +
>> +static void vfio_platform_regions_cleanup(struct vfio_platform_device *vdev)
>> +{
>> +     vdev->num_regions = 0;
>> +     kfree(vdev->regions);
>> +}
>> +
>>  static void vfio_platform_release(void *device_data)
>>  {
>> +     struct vfio_platform_device *vdev = device_data;
>> +
>> +     if (atomic_dec_and_test(&vdev->refcnt))
>> +             vfio_platform_regions_cleanup(vdev);
>> +
>>       module_put(THIS_MODULE);
>>  }
>>
>>  static int vfio_platform_open(void *device_data)
>>  {
>> +     struct vfio_platform_device *vdev = device_data;
>> +     int ret;
>> +
>>       if (!try_module_get(THIS_MODULE))
>>               return -ENODEV;
>>
>> +     if (atomic_inc_return(&vdev->refcnt) == 1) {
>> +             ret = vfio_platform_regions_init(vdev);
>> +             if (ret)
>> +                     goto err_reg;
>> +     }
>> +
>>       return 0;
>> +
>> +err_reg:
>> +     module_put(THIS_MODULE);
>> +     return ret;
>
> Note that if vfio_platform_regions_init() fails then your refcnt is
> wrong.  We switched to a mutex in vfio-pci to avoid this.  See
> 61d792562b53.

Ack.

>
>>  }
>>
>>  static long vfio_platform_ioctl(void *device_data,
>> @@ -58,15 +125,33 @@ static long vfio_platform_ioctl(void *device_data,
>>                       return -EINVAL;
>>
>>               info.flags = vdev->flags;
>> -             info.num_regions = 0;
>> +             info.num_regions = vdev->num_regions;
>>               info.num_irqs = 0;
>>
>>               return copy_to_user((void __user *)arg, &info, minsz);
>>
>> -     } else if (cmd == VFIO_DEVICE_GET_REGION_INFO)
>> -             return -EINVAL;
>> +     } else if (cmd == VFIO_DEVICE_GET_REGION_INFO) {
>> +             struct vfio_region_info info;
>> +
>> +             minsz = offsetofend(struct vfio_region_info, offset);
>> +
>> +             if (copy_from_user(&info, (void __user *)arg, minsz))
>> +                     return -EFAULT;
>> +
>> +             if (info.argsz < minsz)
>> +                     return -EINVAL;
>> +
>> +             if (info.index >= vdev->num_regions)
>> +                     return -EINVAL;
>> +
>> +             /* map offset to the physical address  */
>> +             info.offset = VFIO_PLATFORM_INDEX_TO_OFFSET(info.index);
>> +             info.size = vdev->regions[info.index].size;
>> +             info.flags = vdev->regions[info.index].flags;
>> +
>> +             return copy_to_user((void __user *)arg, &info, minsz);
>>
>> -     else if (cmd == VFIO_DEVICE_GET_IRQ_INFO)
>> +     } else if (cmd == VFIO_DEVICE_GET_IRQ_INFO)
>>               return -EINVAL;
>>
>>       else if (cmd == VFIO_DEVICE_SET_IRQS)
>> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
>> index ef76737..2a06035 100644
>> --- a/drivers/vfio/platform/vfio_platform_private.h
>> +++ b/drivers/vfio/platform/vfio_platform_private.h
>> @@ -15,7 +15,29 @@
>>  #ifndef VFIO_PLATFORM_PRIVATE_H
>>  #define VFIO_PLATFORM_PRIVATE_H
>>
>> +#define VFIO_PLATFORM_OFFSET_SHIFT   40
>> +#define VFIO_PLATFORM_OFFSET_MASK (((u64)(1) << VFIO_PLATFORM_OFFSET_SHIFT) - 1)
>> +
>> +#define VFIO_PLATFORM_OFFSET_TO_INDEX(off)   \
>> +     (off >> VFIO_PLATFORM_OFFSET_SHIFT)
>> +
>> +#define VFIO_PLATFORM_INDEX_TO_OFFSET(index) \
>> +     ((u64)(index) << VFIO_PLATFORM_OFFSET_SHIFT)
>> +
>> +struct vfio_platform_region {
>> +     u64                     addr;
>> +     resource_size_t         size;
>> +     u32                     flags;
>> +     u32                     type;
>> +#define VFIO_PLATFORM_REGION_TYPE_MMIO       1
>> +#define VFIO_PLATFORM_REGION_TYPE_PIO        2
>> +};
>> +
>>  struct vfio_platform_device {
>> +     struct vfio_platform_region     *regions;
>> +     u32                             num_regions;
>> +     atomic_t                        refcnt;
>> +
>>       /*
>>        * These fields should be filled by the bus driver at binding time
>>        */
>
>
>



-- 
Antonios Motakis
Virtual Open Systems
