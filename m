From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Wed, 14 Jan 2015 10:46:10 +0000
Message-ID: <20150114104610.GC4050@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<1417453034-21379-9-git-send-email-will.deacon@arm.com>
	<54B63028.3090701@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54B63028.3090701-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Alex,

On Wed, Jan 14, 2015 at 09:00:24AM +0000, Alexandre Courbot wrote:
> On 12/02/2014 01:57 AM, Will Deacon wrote:
> > This patch plumbs the existing ARM IOMMU DMA infrastructure (which isn't
> > actually called outside of a few drivers) into arch_setup_dma_ops, so
> > that we can use IOMMUs for DMA transfers in a more generic fashion.
> >
> > Since this significantly complicates the arch_setup_dma_ops function,
> > it is moved out of line into dma-mapping.c. If CONFIG_ARM_DMA_USE_IOMMU
> > is not set, the iommu parameter is ignored and the normal ops are used
> > instead.
> 
> A series for IOMMU support with Tegra/Nouveau ceased to work after this 
> patch.

Which series? This code shouldn't even be executed unless you start using
of_xlate and the generic bindings.

> The Tegra IOMMU is not registered by the time the DT is parsed, 
> and thus all devices end up without the proper DMA ops set up because 
> the phandle to the IOMMU cannot be resolved.

You might want to look at the patches posted for the exynos, renesas and ARM
SMMUs for some hints in how to use the new API.

> Subsequently calling arm_iommu_create_mapping() and
> arm_iommu_attach_device() from the driver (as I used to do until 3.18)
> does not help since the call to set_dma_ops() has been moved out of
> arm_iommu_attach_device(). Therefore there seems to be no way for a device
> to gets its correct DMA ops unless the IOMMU is ready by the time the DT
> is parsed.
> 
> Also potentially affected by this are the Rockchip DRM and OMAP3 ISP 
> drivers, which follow the same pattern.

I don't understand why any code currently in mainline should be affected.
Please can you elaborate on the failure case?

> This raises the following questions:
> 
> 1) Why are arm_iommu_create_mapping() and arm_iommu_attach_device() 
> still public since they cannot set the DMA ops and thus seem to be 
> useless outside of arch_setup_dma_ops()?

It has callers outside of the file. I'd like to make it static, but that
means doing some non-trivial porting of all the callers, which I'm also
unable to test.

> 2) Say you want to use the IOMMU API in your driver, and have an iommu 
> property in your device's DT node. If by chance your IOMMU is registered 
> early, you will already have a mapping automatically created even before 
> your probe function is called. Can this be avoided? Is it even safe?

Currently, I think you have to either teardown the ops manually or return
an error from of_xlate. Thierry was also looking at this sort of thing,
so it might be worth talking to him.

Will
