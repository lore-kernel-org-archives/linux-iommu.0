From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v7 6/7] iommu/arm-smmu: do not advertise
	IOMMU_CAP_INTR_REMAP
Date: Fri, 22 Apr 2016 12:16:26 +0100
Message-ID: <571A080A.4040406@arm.com>
References: <1461086687-2658-1-git-send-email-eric.auger@linaro.org>
	<1461086687-2658-7-git-send-email-eric.auger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1461086687-2658-7-git-send-email-eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, eric.auger-qxv4g6HH51o@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Eric, Alex,

On 19/04/16 18:24, Eric Auger wrote:
> Do not advertise IOMMU_CAP_INTR_REMAP for arm-smmu(-v3). Indeed the
> irq_remapping capability is abstracted on irqchip side for ARM as
> opposed to Intel IOMMU featuring IRQ remapping HW.
>
> So to check IRQ remapping capability, the msi domain needs to be
> checked instead.
>
> This commit needs to be applied after "vfio/type1: also check IRQ
> remapping capability at msi domain" else the legacy interrupt
> assignment gets broken with arm-smmu.

Hmm, that smells of papering over a different problem. I may have missed 
it, but I don't see anything changing legacy interrupt behaviour in this 
series - are legacy INTx (or platform) interrupts intrinsically safe 
because they're physically wired, or intrinsically unsafe because they 
could be shared? If it's the latter then I don't see how the IOMMU or 
MSI controller changes anything in that respect, and if it's the former 
then surely we should support that right now without the SMMU having to 
lie about MSI isolation? I started looking into it but I'm a bit lost...

Robin.

> Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>   drivers/iommu/arm-smmu-v3.c | 3 ++-
>   drivers/iommu/arm-smmu.c    | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index afd0dac..1d0106c 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -1386,7 +1386,8 @@ static bool arm_smmu_capable(enum iommu_cap cap)
>   	case IOMMU_CAP_CACHE_COHERENCY:
>   		return true;
>   	case IOMMU_CAP_INTR_REMAP:
> -		return true; /* MSIs are just memory writes */
> +		/* interrupt translation handled at MSI controller level */
> +		return false;
>   	case IOMMU_CAP_NOEXEC:
>   		return true;
>   	default:
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 492339f..6232b2a 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1312,7 +1312,8 @@ static bool arm_smmu_capable(enum iommu_cap cap)
>   		 */
>   		return true;
>   	case IOMMU_CAP_INTR_REMAP:
> -		return true; /* MSIs are just memory writes */
> +		/* interrupt translation handled at MSI controller level */
> +		return false;
>   	case IOMMU_CAP_NOEXEC:
>   		return true;
>   	default:
>
