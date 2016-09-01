From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 05/19] iommu/arm-smmu: Implement of_xlate() for SMMUv3
Date: Thu, 1 Sep 2016 18:06:04 +0100
Message-ID: <20160901170604.GP6721@arm.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
	<6088007f60a24b36a3bf965b62521f99cd908019.1471975357.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6088007f60a24b36a3bf965b62521f99cd908019.1471975357.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, punit.agrawal-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, thunder.leizhen-hv44wF8Li93QT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

On Tue, Aug 23, 2016 at 08:05:16PM +0100, Robin Murphy wrote:
> Now that we can properly describe the mapping between PCI RIDs and
> stream IDs via "iommu-map", and have it fed it to the driver
> automatically via of_xlate(), rework the SMMUv3 driver to benefit from
> that, and get rid of the current misuse of the "iommus" binding.
> 
> Since having of_xlate wired up means that masters will now be given the
> appropriate DMA ops, we also need to make sure that default domains work
> properly. This necessitates dispensing with the "whole group at a time"
> notion for attaching to a domain, as devices which share a group get
> attached to the group's default domain one by one as they are initially
> probed.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
> 
> v5: Simplify init code, use firmware-agnostic (and more efficient)
>     driver-based instance lookup

I'm largely happy with this, just one question below...

> @@ -2649,7 +2602,14 @@ static int arm_smmu_device_dt_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, smmu);
>  
>  	/* Reset the device */
> -	return arm_smmu_device_reset(smmu);
> +	ret = arm_smmu_device_reset(smmu);
> +	if (ret)
> +		return ret;

... if we fail the probe at this point, the drvdata remains set. Do you
need to clear it, or we can we guarantee that nobody is going to try
arm_smmu_get_by_node with the (failed) SMMU's device node?

Alternatively, we could postpone setting the drvdata until the very end
of probe.

Will
