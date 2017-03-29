From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Make sure IOMMUs are off when intel_iommu=off
Date: Wed, 29 Mar 2017 08:51:53 -0700
Message-ID: <20170329085153.5d215d44@jacob-builder>
References: <1490799639-15965-1-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1490799639-15965-1-git-send-email-joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 29 Mar 2017 17:00:39 +0200
Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org> wrote:

> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> 
> When booting into a kexec kernel with intel_iommu=off, and
> the previous kernel had intel_iommu=on, the IOMMU hardware
> is still enabled and gets not disabled by the new kernel.
> 
> This causes the boot to fail because DMA is blocked by the
> hardware. Disable the IOMMUs when we find it enabled in the
> kexec kernel and boot with intel_iommu=off.
> 
> Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index d412a31..1662288 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -4730,6 +4730,15 @@ static int intel_iommu_cpu_dead(unsigned int
> cpu) return 0;
>  }
>  
> +static void intel_disable_iommus(void)
> +{
> +	struct intel_iommu *iommu = NULL;
> +	struct dmar_drhd_unit *drhd;
> +
> +	for_each_iommu(iommu, drhd)
> +		iommu_disable_translation(iommu);
should we also disable IR here? i.e.
iommu_disable_irq_remapping(iommu);

> +}
> +
>  static inline struct intel_iommu *dev_to_intel_iommu(struct device
> *dev) {
>  	return container_of(dev, struct intel_iommu, iommu.dev);
> @@ -4840,8 +4849,15 @@ int __init intel_iommu_init(void)
>  		goto out_free_dmar;
>  	}
>  
> -	if (no_iommu || dmar_disabled)
> +	if (no_iommu || dmar_disabled) {
> +		/*
> +		 * Make sure the IOMMUs are switched off, even when
> we
> +		 * boot into a kexec kernel and the previous kernel
> left
> +		 * them enabled
> +		 */
> +		intel_disable_iommus();
>  		goto out_free_dmar;
> +	}
>  
>  	if (list_empty(&dmar_rmrr_units))
>  		pr_info("No RMRR found\n");

[Jacob Pan]
