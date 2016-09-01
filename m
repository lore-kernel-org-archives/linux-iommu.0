From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v5 17/19] iommu/arm-smmu: Wire up generic configuration
	support
Date: Thu, 1 Sep 2016 20:02:11 +0100
Message-ID: <20160901190210.GY6721@arm.com>
References: <cover.1471975357.git.robin.murphy@arm.com>
	<4439250e01ac071bae8f03a5ccf107ed7ddc0b49.1471975357.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4439250e01ac071bae8f03a5ccf107ed7ddc0b49.1471975357.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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

On Tue, Aug 23, 2016 at 08:05:28PM +0100, Robin Murphy wrote:
> With everything else now in place, fill in an of_xlate callback and the
> appropriate registration to plumb into the generic configuration
> machinery, and watch everything just work.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/arm-smmu.c | 168 ++++++++++++++++++++++++++++++-----------------
>  1 file changed, 107 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index ea22beb58b59..85bc74d8fca0 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -43,6 +43,7 @@
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/of_iommu.h>
> +#include <linux/of_platform.h>
>  #include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> @@ -418,6 +419,8 @@ struct arm_smmu_option_prop {
>  
>  static atomic_t cavium_smmu_context_count = ATOMIC_INIT(0);
>  
> +static bool legacy_binding_used;

I think we need to be a bit stricter here, and force all SMMUs to probe
using the same binding. I think that just boils down to checking against
this flag in the probe routine when we're not the first device.

will
