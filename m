From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [PATCH v8 13/18] vfio/platform: support for maskable and
	automasked interrupts
Date: Wed, 22 Oct 2014 15:55:56 +0200
Message-ID: <CAG8rG2wuRusF6DxEr0aNP1AJq6==WfN-4jX7MXwVuRkgm2scVQ@mail.gmail.com>
References: <1413205825-6370-1-git-send-email-a.motakis@virtualopensystems.com>
	<1413205825-6370-14-git-send-email-a.motakis@virtualopensystems.com>
	<1413913638.4202.153.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1413913638.4202.153.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
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

On Tue, Oct 21, 2014 at 7:47 PM, Alex Williamson
<alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Mon, 2014-10-13 at 15:10 +0200, Antonios Motakis wrote:
>> Adds support to mask interrupts, and also for automasked interrupts.
>> Level sensitive interrupts are exposed as automasked interrupts and
>> are masked and disabled automatically when they fire.
>>
>> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
>> ---
>>  drivers/vfio/platform/vfio_platform_irq.c     | 94 +++++++++++++++++++++++++--
>>  drivers/vfio/platform/vfio_platform_private.h |  2 +
>>  2 files changed, 91 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
>> index 4359b9c..7620a17 100644
>> --- a/drivers/vfio/platform/vfio_platform_irq.c
>> +++ b/drivers/vfio/platform/vfio_platform_irq.c
>> @@ -31,27 +31,103 @@
>>
>>  #include "vfio_platform_private.h"
>>
>> +static void vfio_platform_mask(struct vfio_platform_irq *irq_ctx)
>> +{
>> +     unsigned long flags;
>> +
>> +     spin_lock_irqsave(&irq_ctx->lock, flags);
>> +
>> +     if (!irq_ctx->masked) {
>> +             disable_irq(irq_ctx->hwirq);
>> +             irq_ctx->masked = true;
>> +     }
>> +
>> +     spin_unlock_irqrestore(&irq_ctx->lock, flags);
>> +}
>> +
>>  static int vfio_platform_set_irq_mask(struct vfio_platform_device *vdev,
>>                                   unsigned index, unsigned start,
>>                                   unsigned count, uint32_t flags, void *data)
>>  {
>> -     return -EINVAL;
>> +     if (start != 0 || count != 1)
>> +             return -EINVAL;
>> +
>> +     if (flags & VFIO_IRQ_SET_DATA_EVENTFD)
>> +             return -EINVAL; /* not implemented yet */
>> +
>> +     if (flags & VFIO_IRQ_SET_DATA_NONE) {
>> +             vfio_platform_mask(&vdev->irqs[index]);
>> +
>> +     } else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
>> +             uint8_t mask = *(uint8_t *)data;
>> +
>> +             if (mask)
>> +                     vfio_platform_mask(&vdev->irqs[index]);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static void vfio_platform_unmask(struct vfio_platform_irq *irq_ctx)
>> +{
>> +     unsigned long flags;
>> +
>> +     spin_lock_irqsave(&irq_ctx->lock, flags);
>> +
>> +     if (irq_ctx->masked) {
>> +             enable_irq(irq_ctx->hwirq);
>> +             irq_ctx->masked = false;
>> +     }
>> +
>> +     spin_unlock_irqrestore(&irq_ctx->lock, flags);
>>  }
>>
>>  static int vfio_platform_set_irq_unmask(struct vfio_platform_device *vdev,
>>                                   unsigned index, unsigned start,
>>                                   unsigned count, uint32_t flags, void *data)
>>  {
>> -     return -EINVAL;
>> +     if (start != 0 || count != 1)
>> +             return -EINVAL;
>> +
>> +     if (flags & VFIO_IRQ_SET_DATA_EVENTFD)
>> +             return -EINVAL; /* not implemented yet */
>> +
>> +     if (flags & VFIO_IRQ_SET_DATA_NONE) {
>> +             vfio_platform_unmask(&vdev->irqs[index]);
>> +
>> +     } else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
>> +             uint8_t unmask = *(uint8_t *)data;
>> +
>> +             if (unmask)
>> +                     vfio_platform_unmask(&vdev->irqs[index]);
>> +     }
>> +
>> +     return 0;
>>  }
>>
>>  static irqreturn_t vfio_irq_handler(int irq, void *dev_id)
>>  {
>>       struct vfio_platform_irq *irq_ctx = dev_id;
>> +     unsigned long flags;
>> +     int ret = IRQ_NONE;
>>
>> -     eventfd_signal(irq_ctx->trigger, 1);
>> +     spin_lock_irqsave(&irq_ctx->lock, flags);
>> +
>> +     if (!irq_ctx->masked) {
>> +             ret = IRQ_HANDLED;
>> +
>> +             if (irq_ctx->flags & VFIO_IRQ_INFO_AUTOMASKED) {
>> +                     disable_irq_nosync(irq_ctx->hwirq);
>> +                     irq_ctx->masked = true;
>> +             }
>> +     }
>>
>> -     return IRQ_HANDLED;
>> +     spin_unlock_irqrestore(&irq_ctx->lock, flags);
>> +
>> +     if (ret == IRQ_HANDLED)
>> +             eventfd_signal(irq_ctx->trigger, 1);
>> +
>> +     return ret;
>>  }
>
> If you actually have edge interrupts, you're unnecessarily penalizing
> them with the spinlock here.  You could do like vfio-pci and only
> advertise level interrupts as maskable then use separate edge vs level
> handlers.
>

Ok, I shall implement separate handlers then.

>>
>>  static int vfio_set_trigger(struct vfio_platform_device *vdev,
>> @@ -169,9 +245,17 @@ int vfio_platform_irq_init(struct vfio_platform_device *vdev)
>>               if (hwirq < 0)
>>                       goto err;
>>
>> -             vdev->irqs[i].flags = VFIO_IRQ_INFO_EVENTFD;
>> +             spin_lock_init(&vdev->irqs[i].lock);
>> +
>> +             vdev->irqs[i].flags = VFIO_IRQ_INFO_EVENTFD
>> +                                     | VFIO_IRQ_INFO_MASKABLE;
>> +
>> +             if (irq_get_trigger_type(hwirq) & IRQ_TYPE_LEVEL_MASK)
>> +                     vdev->irqs[i].flags |= VFIO_IRQ_INFO_AUTOMASKED;
>> +
>>               vdev->irqs[i].count = 1;
>>               vdev->irqs[i].hwirq = hwirq;
>> +             vdev->irqs[i].masked = false;
>>       }
>>
>>       vdev->num_irqs = cnt;
>> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
>> index 47af6e0..65e80e7 100644
>> --- a/drivers/vfio/platform/vfio_platform_private.h
>> +++ b/drivers/vfio/platform/vfio_platform_private.h
>> @@ -30,6 +30,8 @@ struct vfio_platform_irq {
>>       int                     hwirq;
>>       char                    *name;
>>       struct eventfd_ctx      *trigger;
>> +     bool                    masked;
>> +     spinlock_t              lock;
>>  };
>>
>>  struct vfio_platform_region {
>
>
>



-- 
Antonios Motakis
Virtual Open Systems
