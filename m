From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 03/15] iommu/arm-smmu: fix decimal printf format
	specifiers prefixed with 0x
Date: Wed, 6 Aug 2014 11:20:25 +0100
Message-ID: <20140806102025.GE23882@arm.com>
References: <1407300121-32432-1-git-send-email-hans@hanshq.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407300121-32432-1-git-send-email-hans-7z9IcJk4adCsTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Hans Wennborg <hans-7z9IcJk4adCsTnJN9+BGXg@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Aug 06, 2014 at 05:42:01AM +0100, Hans Wennborg wrote:
> The prefix suggests the number should be printed in hex, so use
> the %x specifier to do that.
> 
> Found by using regex suggested by Joe Perches.
> 
> Signed-off-by: Hans Wennborg <hans-7z9IcJk4adCsTnJN9+BGXg@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index ca18d6d..d84f983 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -623,7 +623,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>  
>  	if (fsr & FSR_IGN)
>  		dev_err_ratelimited(smmu->dev,
> -				    "Unexpected context fault (fsr 0x%u)\n",
> +				    "Unexpected context fault (fsr 0x%x)\n",
>  				    fsr);
>  
>  	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);

Thanks, applied.

Will
