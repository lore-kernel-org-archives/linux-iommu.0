From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [PATCHv7 20/26] vfio/platform: trigger an interrupt via eventfd
Date: Fri, 26 Sep 2014 17:03:53 +0200
Message-ID: <CAG8rG2zSaKqmZMiEa4W68zvLU4UgW0VHpLxWFqmidPk76FPuaw@mail.gmail.com>
References: <1411483586-29304-1-git-send-email-a.motakis@virtualopensystems.com>
	<1411483586-29304-21-git-send-email-a.motakis@virtualopensystems.com>
	<1411578009.24563.107.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1411578009.24563.107.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
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
Cc: KVM devel mailing list <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, VirtualOpenSystems Technical Team <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Sep 24, 2014 at 7:00 PM, Alex Williamson
<alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On Tue, 2014-09-23 at 16:46 +0200, Antonios Motakis wrote:
>> This patch allows to set an eventfd for a patform device's interrupt,
>> and also to trigger the interrupt eventfd from userspace for testing.
>>
>> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
>> ---
>>  drivers/vfio/platform/vfio_platform_irq.c     | 89 ++++++++++++++++++++++++++-
>>  drivers/vfio/platform/vfio_platform_private.h |  2 +
>>  2 files changed, 89 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
>> index 007b386..25a7825 100644
>> --- a/drivers/vfio/platform/vfio_platform_irq.c
>> +++ b/drivers/vfio/platform/vfio_platform_irq.c
>> @@ -45,11 +45,91 @@ static int vfio_platform_set_irq_unmask(struct vfio_platform_device *vdev,
>>       return -EINVAL;
>>  }
>>
>> +static irqreturn_t vfio_irq_handler(int irq, void *dev_id)
>> +{
>> +     struct vfio_platform_irq *irq_ctx = dev_id;
>> +
>> +     eventfd_signal(irq_ctx->trigger, 1);
>> +
>> +     return IRQ_HANDLED;
>> +}
>> +
>> +static int vfio_set_trigger(struct vfio_platform_device *vdev,
>> +                         int index, int fd)
>> +{
>> +     struct vfio_platform_irq *irq = &vdev->irqs[index];
>> +     struct eventfd_ctx *trigger;
>> +     int ret;
>> +
>> +     if (irq->trigger) {
>> +             free_irq(irq->hwirq, irq);
>> +             kfree(irq->name);
>> +             eventfd_ctx_put(irq->trigger);
>> +             irq->trigger = NULL;
>> +     }
>> +
>> +     if (fd < 0) /* Disable only */
>> +             return 0;
>> +
>> +     irq->name = kasprintf(GFP_KERNEL, "vfio-irq[%d](%s)",
>> +                                             irq->hwirq, vdev->name);
>> +     if (!irq->name)
>> +             return -ENOMEM;
>> +
>> +     trigger = eventfd_ctx_fdget(fd);
>> +     if (IS_ERR(trigger)) {
>> +             kfree(irq->name);
>> +             return PTR_ERR(trigger);
>> +     }
>> +
>> +     irq->trigger = trigger;
>> +
>> +     ret = request_irq(irq->hwirq, vfio_irq_handler, 0, irq->name, irq);
>> +     if (ret) {
>> +             kfree(irq->name);
>> +             eventfd_ctx_put(trigger);
>> +             irq->trigger = NULL;
>> +             return ret;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>>  static int vfio_platform_set_irq_trigger(struct vfio_platform_device *vdev,
>>                                    unsigned index, unsigned start,
>>                                    unsigned count, uint32_t flags, void *data)
>>  {
>> -     return -EINVAL;
>> +     struct vfio_platform_irq *irq = &vdev->irqs[index];
>> +     uint8_t irq_bitmap;
>
> Minor nit here and also present in the next patch, I believe when we
> have DATA_BOOL, it's defined to be a u8 array, where each byte is a
> bool, not each bit.  So it's not actually a bitmap.  The PCI code
> handles any non-zero byte as true, not just bit0.  Thanks,
>

Ok, I will correct this. Thanks for the clarification.

> Alex
>
>> +     int32_t fd;
>> +
>> +     switch (flags & VFIO_IRQ_SET_DATA_TYPE_MASK) {
>> +     case VFIO_IRQ_SET_DATA_NONE:
>> +             if (count == 0)
>> +                     return vfio_set_trigger(vdev, index, -1);
>> +
>> +             vfio_irq_handler(irq->hwirq, irq);
>> +             return 0;
>> +
>> +     case VFIO_IRQ_SET_DATA_BOOL:
>> +             if (copy_from_user(&irq_bitmap, data, sizeof(uint8_t)))
>> +                     return -EFAULT;
>> +
>> +             if (irq_bitmap == 0x1) {
>> +                     vfio_irq_handler(irq->hwirq, irq);
>> +                     return 0;
>> +             }
>> +
>> +             return -EINVAL;
>> +
>> +     case VFIO_IRQ_SET_DATA_EVENTFD:
>> +             if (copy_from_user(&fd, data, sizeof(int32_t)))
>> +                     return -EFAULT;
>> +
>> +             return vfio_set_trigger(vdev, index, fd);
>> +     }
>> +
>> +     return -EFAULT;
>>  }
>>
>>  int vfio_platform_set_irqs_ioctl(struct vfio_platform_device *vdev,
>> @@ -95,7 +175,7 @@ int vfio_platform_irq_init(struct vfio_platform_device *vdev)
>>               if (hwirq < 0)
>>                       goto err;
>>
>> -             vdev->irqs[i].flags = 0;
>> +             vdev->irqs[i].flags = VFIO_IRQ_INFO_EVENTFD;
>>               vdev->irqs[i].count = 1;
>>               vdev->irqs[i].hwirq = hwirq;
>>       }
>> @@ -110,6 +190,11 @@ err:
>>
>>  void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev)
>>  {
>> +     int i;
>> +
>> +     for (i = 0; i < vdev->num_irqs; i++)
>> +             vfio_set_trigger(vdev, i, -1);
>> +
>>       vdev->num_irqs = 0;
>>       kfree(vdev->irqs);
>>  }
>> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
>> index 4201b94..765b371 100644
>> --- a/drivers/vfio/platform/vfio_platform_private.h
>> +++ b/drivers/vfio/platform/vfio_platform_private.h
>> @@ -28,6 +28,8 @@ struct vfio_platform_irq {
>>       u32                     flags;
>>       u32                     count;
>>       int                     hwirq;
>> +     char                    *name;
>> +     struct eventfd_ctx      *trigger;
>>  };
>>
>>  struct vfio_platform_region {
>
>
>



-- 
Antonios Motakis
Virtual Open Systems
