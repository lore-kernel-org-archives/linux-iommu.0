From: Kim Phillips <kim.phillips@linaro.org>
Subject: Re: [RFC PATCH v2 0/7] VFIO for device tree based platform devices
 (work in progress)
Date: Mon, 2 Dec 2013 18:08:45 +0000
Message-ID: <20131202180845.1a383879edcdb7e53dabe7c7@linaro.org>
References: <1380554923-17818-1-git-send-email-a.motakis@virtualopensystems.com>
	<20131201120954.1d6cec431a99a7ad5f34da18@linaro.org>
	<CAG8rG2zir5-hXaARvuDbZ=OnX2Zs7suy_DetxYHS++5VrHGZfA@mail.gmail.com>
	<20131202160832.8f5ee84355086cdb14d6a431@linaro.org>
	<CAG8rG2zWfP+Ku5jD4DCCotpa=i6juiBTr99hsLJzJy2pqV-uZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAG8rG2zWfP+Ku5jD4DCCotpa=i6juiBTr99hsLJzJy2pqV-uZA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: a.motakis@virtualopensystems.com
Cc: kvmarm@lists.cs.columbia.edu, alex.williamson@redhat.com, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, kvm@vger.kernel.org, agraf@suse.de, B08248@freescale.com, tech@virtualopensystems.com
List-Id: iommu@lists.linux-foundation.org

On Mon, 2 Dec 2013 17:30:11 +0100
Antonios Motakis <a.motakis@virtualopensystems.com> wrote:

> On Mon, Dec 2, 2013 at 5:08 PM, Kim Phillips <kim.phillips@linaro.org> wrote:
> > On Mon, 2 Dec 2013 14:56:58 +0100
> > Antonios Motakis <a.motakis@virtualopensystems.com> wrote:
> >
> >> VFIO for platform is still under development, and cannot be used yet
> >> to fully assign a device. However, looking at the example you ran, I
> >> would not have expected it to fail so spectacularly, so this is
> >> definitely something I will investigate for our next update to the
> >
> > it fails in executing this call in vfio-correctness-tests.c [1]:
> >
> > ioctl(container, VFIO_SET_IOMMU, VFIO_TYPE1_IOMMU);
> >
> 
> Hm, I realize now that you where trying to bind the SMMU to the VFIO
> driver. This is not the right way to use it, the SMMU device needs to
> be bound by a valid SMMU driver. However, you need to bind the target

look at the device address - not the compatible name:  I'm binding the
'tv' device, made compatible with the sysmmu via Cho KyongHo's "ARM:
dts: Add description of System MMU of Exynos SoCs":

       sysmmu_tv: sysmmu@14650000 {
               compatible = "samsung,exynos4210-sysmmu";
               reg = <0x14650000 0x1000>;
               interrupt-parent = <&combiner>;
               interrupts = <7 4>;
               clock-names = "sysmmu";
               clocks = <&clock 349>;
               samsung,power-domain = <&pd_disp1>;
       };

although I don't understand why it's being made compatible with the
sysmmu driver.

> device to vfio-platform. To do that you need to edit the device tree,
> as mentioned in the patch series description; this is because at the
> time it was not possible to have a platform driver dynamically bind to
> any device (this particular point will be fixed in future versions)

I'm using this:

https://lkml.org/lkml/2013/10/11/51

to bind.

> Also, you need to check from the device tree if the device is actually
> linked with an SMMU. In my case I was testing using the MFC.

ok, I thought it was, but I'll double-check, or may try using the MFC.

> >> patch series. Thanks for pointing this out. I plan to release an
> >> updated series with several improvements and fixes soon enough.
> >
> > may I ask how you test the patchseries currently?  If on arndale, any
> > particular device?  Also, I'm assuming you're using a different
> > userspace test than Alex Williamson's vfio-tests?
> >
> 
> Since this is a work in progress, I initially used a custom test where
> I directly put each IOCTL I was testing. Since devices on the Arndale
> are not very well documented, today I am testing on the FastModels
> SMMU model which includes a pl330 controller.

ok, thanks for the info.

> Keep in mind this version of the patchset is not supposed to fully let
> you use a device with VFIO yet, just discover it and attempt some
> basic mappings. In the meantime we have fixed several bugs when
> actually trying to access memory regions, and added missing
> functionality. Soon we will release a functional version along with
> some easily reproducible tests.

ok, no problem, thanks.

Kim
