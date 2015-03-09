From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] iommu: arm-smmu: set a more appropriate DMA mask
Date: Mon, 09 Mar 2015 22:27:02 +0100
Message-ID: <2824241.CYpYodyNAY@wuerfel>
References: <2ad6f0a7d198d607e252c420fef52d95dbe048c6.1425581413.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2ad6f0a7d198d607e252c420fef52d95dbe048c6.1425581413.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thursday 05 March 2015 18:56:36 Robin Murphy wrote:
> @@ -1630,6 +1630,13 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>         size = arm_smmu_id_size_to_bits((id >> ID2_OAS_SHIFT) & ID2_OAS_MASK);
>         smmu->pa_size = size;
>  
> +       /*
> +        * What the page table walker can address actually depends on which
> +        * descriptor format is in use, but since a) we don't know that yet,
> +        * and b) it can vary per context bank, this will have to do...
> +        */
> +       dma_set_mask_and_coherent(smmu->dev, DMA_BIT_MASK(size));
> +
>         if (smmu->version == ARM_SMMU_V1) {
>                 smmu->va_size = smmu->ipa_size;
>                 size = SZ_4K | SZ_2M | SZ_1G;
> 

dma_set_mask_and_coherent() can fail if the parent bus cannot access all
of RAM. While that would be serious misdesign for an IOMMU, you should not
just ignore that failure and at least print a message once.

Why not just attempt to set a 64-bit mask?

	Arnd
