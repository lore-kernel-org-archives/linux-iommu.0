From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Correct COHACC override message
Date: Mon, 25 Sep 2017 15:19:52 +0100
Message-ID: <20170925141952.GA12270@red-moon>
References: <d41c3eb397c0f406c75b1e52c85c45ef87dc325d.1506347740.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <d41c3eb397c0f406c75b1e52c85c45ef87dc325d.1506347740.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 25, 2017 at 02:55:40PM +0100, Robin Murphy wrote:
> Slightly confusingly, when reporting a mismatch of the ID register
> value, we still refer to the IORT COHACC override flag as the
> "dma-coherent property" if we booted with ACPI. Update the message
> to be firmware-agnostic in line with SMMUv2.
> 
> Reported-by: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Apologies - missed while reshuffling the probe path to enable
ACPI probing:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>

> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 47f52b1ab838..4c63b3cf4eba 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2523,7 +2523,7 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  	 * register, but warn on mismatch.
>  	 */
>  	if (!!(reg & IDR0_COHACC) != coherent)
> -		dev_warn(smmu->dev, "IDR0.COHACC overridden by dma-coherent property (%s)\n",
> +		dev_warn(smmu->dev, "IDR0.COHACC overridden by FW configuration (%s)\n",
>  			 coherent ? "true" : "false");
>  
>  	switch (reg & IDR0_STALL_MODEL_MASK << IDR0_STALL_MODEL_SHIFT) {
> -- 
> 2.13.4.dirty
> 
> _______________________________________________
> iommu mailing list
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
