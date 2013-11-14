From: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH] iommu/fsl_pamu: use physical cpu index to find the
	matched cpu nodes
Date: Thu, 14 Nov 2013 16:10:25 -0600
Message-ID: <1384467025.1403.210.camel@snotra.buserror.net>
References: <1384457440.2144.15.camel@haiying-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1384457440.2144.15.camel@haiying-laptop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Haiying Wang <Haiying.Wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2013-11-14 at 14:30 -0500, Haiying Wang wrote:
> In the case we miss to bring up some cpus, we need to make sure we can
> find the correct cpu nodes in the device tree based on the given logical
> cpu index from the caller.
> 
> Signed-off-by: Haiying Wang <Haiying.Wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> ---
>  drivers/iommu/fsl_pamu.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
> index cba0498..a9ab57b 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -539,6 +539,7 @@ u32 get_stash_id(u32 stash_dest_hint, u32 vcpu)

Should probably also s/vcpu/cpu/g as vcpu makes no sense outside of
virtualization code.

>  	u32 cache_level;
>  	int len, found = 0;
>  	int i;
> +	u32 cpuid = get_hard_smp_processor_id(vcpu);

s/cpuid/phys_cpu/ or similar

-Scott
