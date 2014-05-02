From: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
Subject: Re: [RFC PATCH v5 11/11] VFIO_PLATFORM: Support for maskable and
	automasked interrupts
Date: Fri, 2 May 2014 19:25:39 +0200
Message-ID: <CAG8rG2xZd2VnAbw=-V_cd76Zv0ZJkdpYyJ-GWA5C-kkHfZ_ZiQ@mail.gmail.com>
References: <1398700371-20096-1-git-send-email-a.motakis@virtualopensystems.com>
	<1398700371-20096-12-git-send-email-a.motakis@virtualopensystems.com>
	<1398707198.24318.293.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1398707198.24318.293.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, KVM devel mailing list <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, alvise rigo <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Stuart Yoder <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, VirtualOpenSystems Technical Team <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, Christoffer Dall <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 28, 2014 at 7:46 PM, Alex Williamson
<alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>
> On Mon, 2014-04-28 at 17:52 +0200, Antonios Motakis wrote:
> > Adds support to mask interrupts, and also for automasked interrupts.
> > Level sensitive interrupts are exposed as automasked interrupts and
> > are masked and disabled automatically when they fire.
> >
> > Signed-off-by: Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>
> > ---
> >  drivers/vfio/platform/vfio_platform_irq.c     | 117 ++++++++++++++++++++++++--
> >  drivers/vfio/platform/vfio_platform_private.h |   2 +
> >  2 files changed, 113 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
> > index 433edc1..e38982f 100644
> > --- a/drivers/vfio/platform/vfio_platform_irq.c
> > +++ b/drivers/vfio/platform/vfio_platform_irq.c
> > @@ -52,9 +52,16 @@ int vfio_platform_irq_init(struct vfio_platform_device *vdev)
> >               struct vfio_platform_irq irq;
> >               int hwirq = platform_get_irq(vdev->pdev, i);
> >
> > -             irq.flags = VFIO_IRQ_INFO_EVENTFD;
> > +             spin_lock_init(&irq.lock);
> > +
> > +             irq.flags = VFIO_IRQ_INFO_EVENTFD | VFIO_IRQ_INFO_MASKABLE;
> > +
> > +             if (irq_get_trigger_type(hwirq) & IRQ_TYPE_LEVEL_MASK)
> > +                     irq.flags |= VFIO_IRQ_INFO_AUTOMASKED;
> > +
> >               irq.count = 1;
> >               irq.hwirq = hwirq;
> > +             irq.masked = false;
> >
> >               vdev->irq[i] = irq;
> >       }
> > @@ -66,19 +73,39 @@ void vfio_platform_irq_cleanup(struct vfio_platform_device *vdev)
> >  {
> >       int i;
> >
> > -     for (i = 0; i < vdev->num_irqs; i++)
> > +     for (i = 0; i < vdev->num_irqs; i++) {
> >               vfio_set_trigger(vdev, i, -1);
> >
> > +             if (vdev->irq[i].masked)
> > +                     enable_irq(vdev->irq[i].hwirq);
>
> This looks suspicious.  set_trigger(,, -1) calls free_irq() and here we
> enable_irq().  Shouldn't the nexe user's call to request_irq() be
> sufficient to re-enable it?  Thanks,
>

This is actually called when we unbind from the device, so it is
indeed not needed.

> Alex
>
