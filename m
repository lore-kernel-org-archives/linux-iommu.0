From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: Reparenting a platform device
Date: Thu, 19 Apr 2012 20:26:30 -0600
Message-ID: <20120420022630.B9BF23E08B0@localhost>
References: <20120405084258.GA19798@avionic-0098.adnet.avionic-design.de>
 <20120407022423.EFB053E1858@localhost>
 <20120407113510.GA22116@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120407113510.GA22116-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Sat, 7 Apr 2012 13:35:10 +0200, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> * Grant Likely wrote:
> > On Thu, 5 Apr 2012 10:42:58 +0200, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> > > Hi,
> > > 
> > > I have a device tree where I have a GART device and a DRM device which uses
> > > the GART. The GART is implemented by an IOMMU driver (tegra-gart) and
> > > requires the user device to be a child of the GART device (it explicitly
> > > checks for this when the user device is attached).
> > > 
> > > I've tried two alternatives to achieve this: create the GART device in the
> > > user driver's .probe() function and explicitly set the DRM device's parent
> > > to the resulting platform device like so:
> > > 
> > > 	gart = platform_device_alloc(...);
> > > 	...
> > > 	pdev->dev.parent = &gart->dev;
> > 
> > Yeah, don't *ever* try to do this.  The device hierarchy is a complex
> > data structure which must never be directly manipulated.
> > 
> > > 
> > > The alternative is to use the device tree to look up the GART device node and
> > > resolve it to the corresponding struct device:
> > > 
> > > 	gart_node = of_parse_phandle(drm->dev->of_node, "gart-parent", 0);
> > > 	gart = bus_find_device(drm->dev->bus, NULL, gart_node, match_of_node);
> > > 
> > > Where match_of_node matches each struct device's .of_node field to the
> > > gart_node.
> > > 
> > > Both of these variants seem to work, and the DRM device can be properly
> > > attached to the GART device. However, after the DRM driver's .probe() exits,
> > > I get the following error:
> > 
> > I don't understand what you're trying to describe here as the 2nd
> > option.
> > 
> > Regardless, reparenting should not ben the solution at all.  What does
> > the device tree that you envision look like for this?  What devices
> > are created, and what drivers bind to them?
> 
> The reason why I need to reparent at all is because the IOMMU driver requires
> the user to be a child of the IOMMU device. If you look at the driver in
> drivers/iommu/tegra-gart.c you'll see that it references dev->parent in
> several places, most notably in the gart_iommu_attach_dev() function. So
> there's really only two options that I can see: 1) create a virtual device
> that is a child of the GART and is in charge of the actual allocations from
> the GART and have the DRM driver use that interface or 2) change the GART
> driver's behaviour in a way that the parent/child relationship is no longer a
> requirement.

Either is fine by me.

> 1) has the advantage of providing a central allocation manager for the GART
> and will allow to register multiple clients with the GART. 2) does not have
> that advantage.
> 
> Another alternative may be to allow only a single device to attach to the
> GART that doesn't have to be a child of the GART. That way the DRM could take
> care of GART aperture allocations, which seems to be the most logical place
> to do that anyway.

That also works.  As long as nothing messes about with odd reparenting
then I'm happy.

g.
