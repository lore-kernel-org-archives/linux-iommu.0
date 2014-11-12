From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 13/19] vfio/platform: support for level sensitive
	interrupts
Date: Wed, 12 Nov 2014 16:03:30 +0100
Message-ID: <546376C2.6050109@linaro.org>
References: <1414433284-31719-1-git-send-email-a.motakis@virtualopensystems.com>	
	<1414433284-31719-14-git-send-email-a.motakis@virtualopensystems.com>
	<1414784196.27420.328.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1414784196.27420.328.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Cc: VFIO DRIVER <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, marc.zyngier-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org, kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 10/31/2014 08:36 PM, Alex Williamson wrote:
> On Mon, 2014-10-27 at 19:07 +0100, Antonios Motakis wrote:
>> Level sensitive interrupts are exposed as maskable and automasked
>> interrupts and are masked and disabled automatically when they fire.
>>
>> Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
>> ---
>>  drivers/vfio/platform/vfio_platform_irq.c     | 102 +++++++++++++++++++++++++-
>>  drivers/vfio/platform/vfio_platform_private.h |   2 +
>>  2 files changed, 100 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
>> index 2ac8ed7..563abf6 100644
>> --- a/drivers/vfio/platform/vfio_platform_irq.c
>> +++ b/drivers/vfio/platform/vfio_platform_irq.c
>> @@ -31,18 +31,108 @@
>>  
>>  #include "vfio_platform_private.h"
>>  
>> +static void vfio_platform_mask(struct vfio_platform_irq *irq_ctx)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&irq_ctx->lock, flags);
>> +
>> +	if (!irq_ctx->masked) {
>> +		disable_irq(irq_ctx->hwirq);
>> +		irq_ctx->masked = true;
>> +	}
>> +
>> +	spin_unlock_irqrestore(&irq_ctx->lock, flags);
>> +}
>> +
>>  static int vfio_platform_set_irq_mask(struct vfio_platform_device *vdev,
>>  				    unsigned index, unsigned start,
>>  				    unsigned count, uint32_t flags, void *data)
>>  {
>> -	return -EINVAL;
>> +	if (start != 0 || count != 1)
>> +		return -EINVAL;
>> +
>> +	if (!(vdev->irqs[index].flags & VFIO_IRQ_INFO_MASKABLE))
>> +		return -EINVAL;
>> +
>> +	if (flags & VFIO_IRQ_SET_DATA_EVENTFD)
>> +		return -EINVAL; /* not implemented yet */
>> +
>> +	if (flags & VFIO_IRQ_SET_DATA_NONE) {
>> +		vfio_platform_mask(&vdev->irqs[index]);
>> +
>> +	} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
>> +		uint8_t mask = *(uint8_t *)data;
>> +
>> +		if (mask)
>> +			vfio_platform_mask(&vdev->irqs[index]);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void vfio_platform_unmask(struct vfio_platform_irq *irq_ctx)
>> +{
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&irq_ctx->lock, flags);
>> +
>> +	if (irq_ctx->masked) {
>> +		enable_irq(irq_ctx->hwirq);
>> +		irq_ctx->masked = false;
>> +	}
>> +
>> +	spin_unlock_irqrestore(&irq_ctx->lock, flags);
>>  }
>>  
>>  static int vfio_platform_set_irq_unmask(struct vfio_platform_device *vdev,
>>  				    unsigned index, unsigned start,
>>  				    unsigned count, uint32_t flags, void *data)
>>  {
>> -	return -EINVAL;
>> +	if (start != 0 || count != 1)
>> +		return -EINVAL;
>> +
>> +	if (!(vdev->irqs[index].flags & VFIO_IRQ_INFO_MASKABLE))
>> +		return -EINVAL;
>> +
>> +	if (flags & VFIO_IRQ_SET_DATA_EVENTFD)
>> +		return -EINVAL; /* not implemented yet */
>> +
>> +	if (flags & VFIO_IRQ_SET_DATA_NONE) {
>> +		vfio_platform_unmask(&vdev->irqs[index]);
>> +
>> +	} else if (flags & VFIO_IRQ_SET_DATA_BOOL) {
>> +		uint8_t unmask = *(uint8_t *)data;
>> +
>> +		if (unmask)
>> +			vfio_platform_unmask(&vdev->irqs[index]);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static irqreturn_t vfio_maskable_irq_handler(int irq, void *dev_id)
>> +{
>> +	struct vfio_platform_irq *irq_ctx = dev_id;
>> +	unsigned long flags;
>> +	int ret = IRQ_NONE;
>> +
>> +	spin_lock_irqsave(&irq_ctx->lock, flags);
>> +
>> +	if (!irq_ctx->masked) {
>> +		ret = IRQ_HANDLED;
>> +
>> +		/* automask maskable interrupts */
>> +		disable_irq_nosync(irq_ctx->hwirq);
>> +		irq_ctx->masked = true;
>> +	}
>> +
>> +	spin_unlock_irqrestore(&irq_ctx->lock, flags);
>> +
>> +	if (ret == IRQ_HANDLED)
>> +		eventfd_signal(irq_ctx->trigger, 1);
>> +
>> +	return ret;
> 
> This is not just a maskable irq handler, but specifically a level (aka
> automasked) handler.  So this should only be used for AUTOMASKED irqs.
> 
>>  }

Antonios, Alex,

When turning forwarded IRQ modality on/off, I guess I now should the
swap the handlers (free_irq, request_irq) adding some extra complexity
in the driver compared to the previous implementation. Do you confirm
this is the prefered way?

Thanks

Eric

>>  
>>  static irqreturn_t vfio_irq_handler(int irq, void *dev_id)
>> @@ -103,7 +193,7 @@ static int vfio_platform_set_irq_trigger(struct vfio_platform_device *vdev,
>>  	irq_handler_t handler;
>>  
>>  	if (vdev->irqs[index].flags & VFIO_IRQ_INFO_MASKABLE)
>> -		return -EINVAL; /* not implemented */
>> +		handler = vfio_maskable_irq_handler;
> 
> As noted in the previous patch, this should be a test for AUTOMASKED,
> not just MASKABLE.
> 
>>  	else
>>  		handler = vfio_irq_handler;
>>  
>> @@ -175,13 +265,17 @@ int vfio_platform_irq_init(struct vfio_platform_device *vdev)
>>  		if (hwirq < 0)
>>  			goto err;
>>  
>> +		spin_lock_init(&vdev->irqs[i].lock);
>> +
>>  		vdev->irqs[i].flags = VFIO_IRQ_INFO_EVENTFD;
>>  
>>  		if (irq_get_trigger_type(hwirq) & IRQ_TYPE_LEVEL_MASK)
>> -			vdev->irqs[i].flags |= VFIO_IRQ_INFO_MASKABLE;
>> +			vdev->irqs[i].flags |= VFIO_IRQ_INFO_MASKABLE
>> +						| VFIO_IRQ_INFO_AUTOMASKED;
>>  
>>  		vdev->irqs[i].count = 1;
>>  		vdev->irqs[i].hwirq = hwirq;
>> +		vdev->irqs[i].masked = false;
>>  	}
>>  
>>  	vdev->num_irqs = cnt;
>> diff --git a/drivers/vfio/platform/vfio_platform_private.h b/drivers/vfio/platform/vfio_platform_private.h
>> index a3f2411..d25c4cd 100644
>> --- a/drivers/vfio/platform/vfio_platform_private.h
>> +++ b/drivers/vfio/platform/vfio_platform_private.h
>> @@ -30,6 +30,8 @@ struct vfio_platform_irq {
>>  	int			hwirq;
>>  	char			*name;
>>  	struct eventfd_ctx	*trigger;
>> +	bool			masked;
>> +	spinlock_t		lock;
>>  };
>>  
>>  struct vfio_platform_region {
> 
> 
> 
