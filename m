From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Wed, 14 Jan 2015 19:17:50 +0000
Message-ID: <20150114191749.GL4050@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<54B63028.3090701@nvidia.com> <20150114104610.GC4050@arm.com>
	<4122226.MTzV1JgdDD@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4122226.MTzV1JgdDD@phil>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org" <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 14, 2015 at 01:51:36PM +0000, Heiko St=FCbner wrote:
> Am Mittwoch, 14. Januar 2015, 10:46:10 schrieb Will Deacon:
> > On Wed, Jan 14, 2015 at 09:00:24AM +0000, Alexandre Courbot wrote:
> > > On 12/02/2014 01:57 AM, Will Deacon wrote:
> > > > This patch plumbs the existing ARM IOMMU DMA infrastructure (which =
isn't
> > > > actually called outside of a few drivers) into arch_setup_dma_ops, =
so
> > > > that we can use IOMMUs for DMA transfers in a more generic fashion.
> > > > =

> > > > Since this significantly complicates the arch_setup_dma_ops functio=
n,
> > > > it is moved out of line into dma-mapping.c. If CONFIG_ARM_DMA_USE_I=
OMMU
> > > > is not set, the iommu parameter is ignored and the normal ops are u=
sed
> > > > instead.
> > > =

> > > A series for IOMMU support with Tegra/Nouveau ceased to work after th=
is
> > > patch.
> > =

> > Which series? This code shouldn't even be executed unless you start usi=
ng
> > of_xlate and the generic bindings.
> > =

> > > The Tegra IOMMU is not registered by the time the DT is parsed,
> > > and thus all devices end up without the proper DMA ops set up because
> > > the phandle to the IOMMU cannot be resolved.
> > =

> > You might want to look at the patches posted for the exynos, renesas an=
d ARM
> > SMMUs for some hints in how to use the new API.
> > =

> > > Subsequently calling arm_iommu_create_mapping() and
> > > arm_iommu_attach_device() from the driver (as I used to do until 3.18)
> > > does not help since the call to set_dma_ops() has been moved out of
> > > arm_iommu_attach_device(). Therefore there seems to be no way for a d=
evice
> > > to gets its correct DMA ops unless the IOMMU is ready by the time the=
 DT
> > > is parsed.
> > > =

> > > Also potentially affected by this are the Rockchip DRM and OMAP3 ISP
> > > drivers, which follow the same pattern.
> > =

> > I don't understand why any code currently in mainline should be affecte=
d.
> > Please can you elaborate on the failure case?
> =

> As Alexandre suspected the new Rockchip drm code seems to be affected by
> this. I hadn't played with the drm code before last weekend and was then
> stumbling over different iommu related issues. As I hadn't to much contact
> with iommus till now I didn't get very far.
> =

> But with Alexandre's bandaid patch of adding
> 	set_dma_ops(dev, &iommu_ops);
> to arm_iommu_attach_device both problems go away.
> =

> =

> So to elaborate on the two failure cases:

Aha, I see what you mean now -- the issue is that attaching to an IOMMU
domain no longer swizzles the DMA ops. Furthermore, we also need to take
into account the coherency of the device, which we didn't do before (and
assumedly "worked" because all of the users happened to be non-coherent).

Maybe we just need to add something like arm_iommu_swizzle_dma_ops, so
that direct users of the arm_iommu_* API can manage things manually?

Will
