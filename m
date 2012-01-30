From: Joerg Roedel <joerg.roedel-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/5] iommu/amd: Implement DOMAIN_ATTR_GEOMETRY attribute
Date: Mon, 30 Jan 2012 15:24:24 +0100
Message-ID: <20120130142424.GR19255@amd.com>
References: <20120120160344.GG2205@amd.com> <4F219A9C.8000400@freescale.com>
	<20120126183116.GI19255@amd.com> <4F219E82.106@freescale.com>
	<20120126185101.GJ19255@amd.com> <4F21A2D5.6000204@freescale.com>
	<20120126194428.GH6269@8bytes.org> <4F21B152.3010103@freescale.com>
	<20120127110120.GL19255@amd.com> <4F2315A3.80909@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4F2315A3.80909-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Wood Scott-B07421 <B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Jan 27, 2012 at 03:22:43PM -0600, Scott Wood wrote:

> OK, so there's a geometry that is read-only, and potentially a
> driver-specific geometry that is read/write.  The default config for
> PAMU would likely be a 1 MiB aperture in which the dma api can do
> arbitrary 4k mappings -- this fits within the get generic geometry
> operation.

Better: There is a read-only geometry for _all_ IOMMUs. Some IOMMUs may
also allow to write the geometry, like PAMU.

> Should generic get geometry return an error if the driver-specific
> geometry has been set to something that doesn't fit within the generic
> geometry model?

A domain can only have one geometry. So if you set a new geometry
subsequent calls to get_attr will return the new geometry.

> I said a generic attribute (not GART specific) -- but if we're never
> going to use the generic geometry struct for a set operation, bundling
> it should be OK.

The generic struct should be used to set the geometry. But you can read
out the old geometry and set force_aperture to the same value in the new
geometry. Drivers should actually return -EINVAL when the user tries to
set an unsupported value for force_aperture.

> No, at this point I'm just trying to follow the API development while
> tending to other tasks.  I think Varun is working on the code for now.

Okay, maybe it is better to follow a 'release early, release often'
model here. So we can work out the issues together.


	Joerg

-- 
AMD Operating System Research Center

Advanced Micro Devices GmbH Einsteinring 24 85609 Dornach
General Managers: Alberto Bozzo
Registration: Dornach, Landkr. Muenchen; Registerger. Muenchen, HRB Nr. 43632
