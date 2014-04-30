From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH v5 03/11] VFIO_IOMMU_TYPE1 for platform bus devices
	on ARM
Date: Wed, 30 Apr 2014 14:08:14 +0100
Message-ID: <20140430130814.GB15719@arm.com>
References: <1398700371-20096-1-git-send-email-a.motakis@virtualopensystems.com>
	<1398700371-20096-4-git-send-email-a.motakis@virtualopensystems.com>
	<1398703421.24318.262.camel@ul30vt.home>
	<20140428191920.GC22135@arm.com>
	<1398715690.24318.321.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398715690.24318.321.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
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
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <Marc.Zyngier-5wv7dgnIgG8@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <a.rigo-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <stuart.yoder-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org" <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, "kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org" <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>, "christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Apr 28, 2014 at 09:08:10PM +0100, Alex Williamson wrote:
> On Mon, 2014-04-28 at 20:19 +0100, Will Deacon wrote:
> > Please excuse any ignorance on part here (I'm not at all familiar with the
> > Intel IOMMU), but shouldn't this really be a property of the interrupt
> > controller itself? On ARM with GICv3, there is a separate block called the
> > ITS (interrupt translation service) which is part of the interrupt
> > controller. The ITS provides a doorbell page which the SMMU can map into a
> > guest operating system to provide MSI for passthrough devices, but this
> > isn't something the SMMU is aware of -- it will just see the iommu_map
> > request for a non-cacheable mapping.
> 
> I don't know the history of why this is an IOMMU domain capability on
> x86, it's sort of a paradox.  An MSI from a device is conceptually just
> a DMA write and is therefore logically co-located in the IOMMU hardware,
> but x86 doesn't allow it to be mapped via the IOMMU API interfaces.  For
> compatibility, interrupt remapping support is buried deep in the
> request_irq interface and effectively invisible other than having this
> path to query it.  Therefore this flag is effectively just saying "MSI
> isolation support is present and enabled".  IOW, the host is protected
> from interrupt injection attacks from malicious devices.  If there is
> some property of your platform that makes this always the case, then the
> IOMMU driver can always export this capability as true.

Thanks for the explanation. On ARM, the SMMU does indeed see the MSI write
just like a normal write, so it can be mapped via iommu_map() to point at
the interrupt controller doorbell page. I guess that means we can enable
this capability for all MSI-capable devices upstream of the SMMU, providing
that the IRQ controller doesn't have any horrible quirks.

> With PCI, MSI is configured via spec defined configuration space
> registers, so we emulate these registers and prevent user access to them
> so that we don't need to allow the user a way to setup an interrupt
> remapping entry.  It's done for them via request_irq.
> 
> IIRC, the Freescale devices have a limited number of MSI pages and can
> therefore create some instances with isolation while others may require
> sharing.  In that case I would expect this flag to indicate whether the
> domain has an exclusive or shared page.
> 
> In any case, I suspect keying on the bus_type here is not the correct
> way to go.  Thanks,

Agreed, I was more intrigued by the meaning of the flag.

Thanks,

Will
