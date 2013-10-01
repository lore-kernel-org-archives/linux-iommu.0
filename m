From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/7] Return info for device and its memory regions and
	interrupts
Date: Tue, 01 Oct 2013 13:41:40 -0600
Message-ID: <1380656500.14271.40.camel@ul30vt.home>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
	<1380554923-17818-4-git-send-email-a.motakis@virtualopensystems.com>
	<1380562776.2674.177.camel@ul30vt.home>
	<CAG8rG2yPXX9WtmhJqYMNE_3x4RNGkb1BDab8F3Pk8KUhntM9fg@mail.gmail.com>
	<9F6FE96B71CF29479FF1CDC8046E15036D3803@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <9F6FE96B71CF29479FF1CDC8046E15036D3803-TcFNo7jSaXOLgTCmFNXF2K4g8xLGJsHaLnY5E4hWTkheoWH0uzbU5w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Yoder Stuart-B08248 <B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, KVM devel mailing list <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, VirtualOpenSystems Technical Team <tech-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, kvm-arm <kvmarm-FPEHb7Xf0XXUo1n7N8X6UoWGPAHP3yOg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2013-10-01 at 19:32 +0000, Yoder Stuart-B08248 wrote:
> > Antonios Motakis wrote
> > > Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > > I notice all the open firmware calls here and I'm curious,
> > > will all platform devices be making use of open firmware?
> > > I don't know if this is synonymous with device tree or not.
> > > Thanks,
> >
> > This VFIO driver will support only devices implemented
> > on the device tree. While there can be platform devices
> > outside the device tree, I don't think it makes sense
> > to support them from the same driver. This is why I
> > originally called the driver VFIO_DT, however I renamed
> > it to VFIO_PLATFORM after feedback from the first
> > RFC. However personally, I still think the VFIO_DT name
> > is more appropriate since we don't support all platform
> > devices, only those that use the device tree.
> 
> But there is no 'device tree' bus.  The bus type we're
> dealing with is a platform bus.
> 
> vfio for platform devices should be independent of whether
> the device was discovered in a device tree or not.
> All you're doing is exposing mappable regions and IRQs
> to user space and it does not matter where the info originated.
> 
> You should be using platform bus structs here not
> reparsing device tree nodes.  The struct
> platform_device already has resource info in the 
> struct:
> 
> struct platform_device {
>         const char      *name;
>         u32             id;
>         struct device   dev;
>         u32             num_resources;
>         struct resource *resource;
> };

It seems likely(?) that platform devices could be described via ACPI at
some point, so keeping this abstraction would be a plus.  Thanks,

Alex 
