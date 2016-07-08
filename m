From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 1/8] arm64: mm: change IOMMU notifier action to attach
 DMA ops
Date: Fri, 8 Jul 2016 18:06:42 +0100
Message-ID: <20160708170642.GD22099@e104818-lin.cambridge.arm.com>
References: <cover.1467388950.git.robin.murphy@arm.com>
 <06d430a86f5d7f461308a9278bf25f40fb50d93c.1467388950.git.robin.murphy@arm.com>
 <20160708145521.GD6493@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160708145521.GD6493-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jul 08, 2016 at 03:55:21PM +0100, Will Deacon wrote:
> On Fri, Jul 01, 2016 at 05:50:10PM +0100, Robin Murphy wrote:
> > From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> > 
> > Current bus notifier in ARM64 (__iommu_attach_notifier)
> > attempts to attach dma_ops to a device on BUS_NOTIFY_ADD_DEVICE
> > action notification.
> > 
> > This will cause issues on ACPI based systems, where PCI devices
> > can be added before the IOMMUs the devices are attached to
> > had a chance to be probed, causing failures on attempts to
> > attach dma_ops in that the domain for the respective IOMMU
> > may not be set-up yet by the time the bus notifier is run.
> > 
> > Devices dma_ops do not require to be set-up till the matching
> > device drivers are probed. This means that instead of running
> > the notifier attaching dma_ops to devices (__iommu_attach_notifier)
> > on BUS_NOTIFY_ADD_DEVICE action, it can be run just before the
> > device driver is bound to the device in question (on action
> > BUS_NOTIFY_BIND_DRIVER) so that it is certain that its IOMMU
> > group and domain are set-up accordingly at the time the
> > notifier is triggered.
> > 
> > This patch changes the notifier action upon which dma_ops
> > are attached to devices and defer it to driver binding time,
> > so that IOMMU devices have a chance to be probed and to register
> > their bus notifiers before the dma_ops attach sequence for a
> > device is actually carried out.
> > 
> > As a result we also no longer need worry about racing with
> > iommu_bus_notifier(), or about retrying the queue in case devices
> > were added too early on DT-based systems, so clean up the notifier
> > itself plus the additional workaround from 722ec35f7fae ("arm64:
> > dma-mapping: fix handling of devices registered before arch_initcall")
> > 
> > Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> > Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
> > Cc: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> > [rm: get rid of other now-redundant bits]
> > Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> > ---
> > 
> > v4: No change.
> > 
> >  arch/arm64/mm/dma-mapping.c | 22 +++++-----------------
> >  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> Whilst this series is unlikely to make it for 4.8, this patch is
> independent and it would be good to see it queued in the arm64 tree for
> 4.8, if possible. It shouldn't change anything on its own, but it's a
> prerequisite for this series and anything on the IORT side from Lorenzo,
> so it makes sense to me to keep the delta down if we can.

I queued it for 4.8. Thanks.

-- 
Catalin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
