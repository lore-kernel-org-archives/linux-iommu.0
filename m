From: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops
	into arch_setup_dma_ops
Date: Wed, 14 Jan 2015 18:00:24 +0900
Message-ID: <54B63028.3090701@nvidia.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
	<1417453034-21379-9-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1417453034-21379-9-git-send-email-will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, arnd-r2nGTMty4D4@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: jroedel-l3A5Bk7waGM@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 12/02/2014 01:57 AM, Will Deacon wrote:
> This patch plumbs the existing ARM IOMMU DMA infrastructure (which isn't
> actually called outside of a few drivers) into arch_setup_dma_ops, so
> that we can use IOMMUs for DMA transfers in a more generic fashion.
>
> Since this significantly complicates the arch_setup_dma_ops function,
> it is moved out of line into dma-mapping.c. If CONFIG_ARM_DMA_USE_IOMMU
> is not set, the iommu parameter is ignored and the normal ops are used
> instead.

A series for IOMMU support with Tegra/Nouveau ceased to work after this 
patch. The Tegra IOMMU is not registered by the time the DT is parsed, 
and thus all devices end up without the proper DMA ops set up because 
the phandle to the IOMMU cannot be resolved. Subsequently calling 
arm_iommu_create_mapping() and arm_iommu_attach_device() from the driver 
(as I used to do until 3.18) does not help since the call to 
set_dma_ops() has been moved out of arm_iommu_attach_device(). Therefore 
there seems to be no way for a device to gets its correct DMA ops unless 
the IOMMU is ready by the time the DT is parsed.

Also potentially affected by this are the Rockchip DRM and OMAP3 ISP 
drivers, which follow the same pattern.

This raises the following questions:

1) Why are arm_iommu_create_mapping() and arm_iommu_attach_device() 
still public since they cannot set the DMA ops and thus seem to be 
useless outside of arch_setup_dma_ops()?

2) Say you want to use the IOMMU API in your driver, and have an iommu 
property in your device's DT node. If by chance your IOMMU is registered 
early, you will already have a mapping automatically created even before 
your probe function is called. Can this be avoided? Is it even safe?

The issue is workarounded (at least for me) with the following patch:

--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -1961,6 +1961,7 @@ int arm_iommu_attach_device(struct device *dev,

         kref_get(&mapping->kref);
         dev->archdata.mapping = mapping;
+       set_dma_ops(dev, &iommu_ops);

         pr_debug("Attached IOMMU controller to %s device.\n", 
dev_name(dev));
         return 0;

This allows arm_iommu_create_mapping() and arm_iommu_attach_device() to 
set the correct DMA ops when called from the driver. But it doesn't look 
like mergeable material and I'd like to know whether there is a better 
way to handle this, or whether I should just use the IOMMU API directly. 
Knowing that even this might not be safe if ARM_DMA_USE_IOMMU is enabled 
because of point 2) above.

So basically I'm afraid I might not even be able to use the IOMMU safely 
after this. Or am I missing anything?

Thanks,
Alex.
