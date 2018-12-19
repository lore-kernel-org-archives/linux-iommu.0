From: Krishna Reddy <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH v3 2/6] iommu/arm-smmu: Add support to program multiple
	ARM SMMU's identically
Date: Wed, 19 Dec 2018 20:36:54 +0000
Message-ID: <BYAPR12MB2759C4AB588260ECB46046E3B3BE0@BYAPR12MB2759.namprd12.prod.outlook.com>
References: <1543887414-18209-1-git-send-email-vdumpa@nvidia.com>
	<1543887414-18209-3-git-send-email-vdumpa@nvidia.com>
	<5e1b242c-d2d5-9478-6726-2921bea9f3dc@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5e1b242c-d2d5-9478-6726-2921bea9f3dc-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Sachin Nikam <Snikam-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Thomas Zeng (SW-TEGRA)" <thomasz-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Juha Tukkinen <jtukkinen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Pritesh Raithatha <praithatha-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "jon.he-5wv7dgnIgG8@public.gmane.org" <jon.he-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Timo Alho <talho-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Yu-Huan Hsu <YHsu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Alexander Van Brunt <avanbrunt-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,
Thanks for the feedback :)

>The whole point of the library idea was to factor out the code in such a way that all the details
>specific to a particular implementation can be kept together. But what this patch does is insert
>Tegra194-specific handling all through the 'common' code, which is the exact opposite of that concept
>and just makes more hard-to-maintain mess.

In an attempt to reuse most of the ARM SMMU implementation, which heavily relies on data from arm_smmu_device,
The library code has been added with some functionality only usable by Tegra194 SMMU driver. 
In V4 patches, I am working on to add a mechanism to override writel/readl functions in library so that
Tegra smmu driver can override read/write functions and handle programming of multiple instances on its own. 

>The amount of copy-paste duplication in patch #4 has the opposite problem - about 95% of that isn't 
>Tegra194-specific at all (I mean, how many fsl_mc instances does it have?), and having multiple copies of
> generic code with the potential to diverge is also not what anyone wants.

I have split the code in a way that library only contains the code that deals with register programming.
And avoided platform driver code and DT parsing code getting into library, which can allow drivers changing
Independently if necessary in future.

> Plus I don't think ending up building 
> multiple separate drivers will even work in general - thanks to the current state of
>bus_set_iommu() etc., you can't use the regular driver for your third SMMU at the same time.

Good point!
>From code, platform_dma_configure/of_dma_configure/of_iommu_configure takes care
of setting right iommu_ops for devices based on the iommu DT node they have in iommus=<> entry.

If iommu.c is updated to use dev->bus->dma_configure(),  then it doesn't really need to use dev->bus->iommu_ops.
dev->bus->dma_configure() can be used to set dev->dma_ops to the right one, if dev->dma_ops is not
already set. 
If this approach looks good, I can make a patch to clean up bus->iommu_ops usage related code to allow
devices to use specific SMMU instance as they need.

>I think what really needs to be done is to conceptually split the driver into "architecture" and "implementation"
> layers - at some point after the holidays we're probably going to sit down and go through all the various quirks and
> specifics we know about to try and figure out what that should actually look like.

If you can provide some high level details on what to keep in library vs implementation after holidays, I would be
 happy to rework the patches.  Will look forward for further discussions on this.

-KR
