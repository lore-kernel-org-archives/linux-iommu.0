From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: Reparenting a platform device
Date: Fri, 06 Apr 2012 19:24:23 -0700
Message-ID: <20120407022423.EFB053E1858@localhost>
References: <20120405084258.GA19798@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120405084258.GA19798-RM9K5IK7kjIyiCvfTdI0JKcOhU4Rzj621B7CTYaBSLdn68oJJulU0Q@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 5 Apr 2012 10:42:58 +0200, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> Hi,
> 
> I have a device tree where I have a GART device and a DRM device which uses
> the GART. The GART is implemented by an IOMMU driver (tegra-gart) and
> requires the user device to be a child of the GART device (it explicitly
> checks for this when the user device is attached).
> 
> I've tried two alternatives to achieve this: create the GART device in the
> user driver's .probe() function and explicitly set the DRM device's parent
> to the resulting platform device like so:
> 
> 	gart = platform_device_alloc(...);
> 	...
> 	pdev->dev.parent = &gart->dev;

Yeah, don't *ever* try to do this.  The device hierarchy is a complex
data structure which must never be directly manipulated.

> 
> The alternative is to use the device tree to look up the GART device node and
> resolve it to the corresponding struct device:
> 
> 	gart_node = of_parse_phandle(drm->dev->of_node, "gart-parent", 0);
> 	gart = bus_find_device(drm->dev->bus, NULL, gart_node, match_of_node);
> 
> Where match_of_node matches each struct device's .of_node field to the
> gart_node.
> 
> Both of these variants seem to work, and the DRM device can be properly
> attached to the GART device. However, after the DRM driver's .probe() exits,
> I get the following error:

I don't understand what you're trying to describe here as the 2nd
option.

Regardless, reparenting should not ben the solution at all.  What does
the device tree that you envision look like for this?  What devices
are created, and what drivers bind to them?

g.
