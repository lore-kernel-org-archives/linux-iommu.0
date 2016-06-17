From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v2 03/15] arm64: mm: change IOMMU notifier action to
	attach DMA ops
Date: Fri, 17 Jun 2016 15:15:36 +0100
Message-ID: <20160617141536.GA24840@red-moon>
References: <1465306270-27076-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1465306270-27076-4-git-send-email-lorenzo.pieralisi@arm.com>
	<5763C27A.9030306@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5763C27A.9030306-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Fri, Jun 17, 2016 at 10:27:22AM +0100, Robin Murphy wrote:
> Hi Lorenzo,
> 
> I think this patch makes sense even independent of the rest of the
> series, one nit inline notwithstanding.

Thanks. Yes I added it to this series since it is not strictly
necessary (ie it does not fix anything) in the mainline, but
it *is* necessary for this whole series to function when we
boot through ACPI.

I will send it out in a separate patch and fold changes you
request below, it would be good to have some coverage for
it before merging it.

Thank you !
Lorenzo

> Marek; I'm curious as to whether this could make the workaround in
> 722ec35f7 obsolete as well, or are all the drivers also bound
> super-early in the setup you had there?
> 
> On 07/06/16 14:30, Lorenzo Pieralisi wrote:
> >Current bus notifier in ARM64 (__iommu_attach_notifier)
> >attempts to attach dma_ops to a device on BUS_NOTIFY_ADD_DEVICE
> >action notification.
> >
> >This causes issues on ACPI based systems, where PCI devices
> >can be added before the IOMMUs the devices are attached to
> >had a chance to be probed, causing failures on attempts to
> >attach dma_ops in that the domain for the respective IOMMU
> >may not be set-up yet by the time the bus notifier is run.
> >
> >Devices dma_ops do not require to be set-up till the matching
> >device drivers are probed. This means that instead of running
> >the notifier attaching dma_ops to devices (__iommu_attach_notifier)
> >on BUS_NOTIFY_ADD_DEVICE action, it can be run just before the
> >device driver is bound to the device in question (on action
> >BUS_NOTIFY_BIND_DRIVER) so that it is certain that its IOMMU
> >group and domain are set-up accordingly at the time the
> >notifier is triggered.
> >
> >This patch changes the notifier action upon which dma_ops
> >are attached to devices and defer it to driver binding time,
> >so that IOMMU devices have a chance to be probed and to register
> >their bus notifiers before the dma_ops attach sequence for a
> >device is actually carried out.
> >
> >Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> >Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> >Cc: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
> >Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> >---
> >  arch/arm64/mm/dma-mapping.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> >index c566ec8..79b0882 100644
> >--- a/arch/arm64/mm/dma-mapping.c
> >+++ b/arch/arm64/mm/dma-mapping.c
> >@@ -848,7 +848,7 @@ static int __iommu_attach_notifier(struct notifier_block *nb,
> >  {
> >  	struct iommu_dma_notifier_data *master, *tmp;
> >
> >-	if (action != BUS_NOTIFY_ADD_DEVICE)
> >+	if (action != BUS_NOTIFY_BIND_DRIVER)
> 
> With this, you can also get rid of the priority setting and big fat
> explanatory comment in register_iommu_dma_ops_notifier().
> 
> Robin.
> 
> >  		return 0;
> >
> >  	mutex_lock(&iommu_dma_notifier_lock);
> >
> 
