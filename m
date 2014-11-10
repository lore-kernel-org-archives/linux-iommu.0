From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 13/13] iommu/vt-d: Add a command line parameter for VT-d
	posted-interrupts
Date: Mon, 10 Nov 2014 14:57:49 -0700
Message-ID: <1415656669.16601.293.camel@ul30vt.home>
References: <1415600812-27773-1-git-send-email-feng.wu@intel.com>
	<1415600812-27773-14-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1415600812-27773-14-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 2014-11-10 at 14:26 +0800, Feng Wu wrote:
> Enable VT-d Posted-Interrtups and add a command line
> parameter for it.
> 
> Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/iommu/irq_remapping.c |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
> index 0e36860..3cb9429 100644
> --- a/drivers/iommu/irq_remapping.c
> +++ b/drivers/iommu/irq_remapping.c
> @@ -23,7 +23,7 @@ int irq_remap_broken;
>  int disable_sourceid_checking;
>  int no_x2apic_optout;
>  
> -int disable_irq_post = 1;
> +int disable_irq_post = 0;
>  int irq_post_enabled = 0;
>  EXPORT_SYMBOL_GPL(irq_post_enabled);
>  
> @@ -206,6 +206,13 @@ static __init int setup_irqremap(char *str)
>  }
>  early_param("intremap", setup_irqremap);
>  
> +static __init int setup_nointpost(char *str)
> +{
> +	disable_irq_post = 1;
> +	return 0;
> +}
> +early_param("nointpost", setup_nointpost);
> +

Documentation/kernel-parameters.txt?  Thanks,

Alex

>  void __init setup_irq_remapping_ops(void)
>  {
>  	remap_ops = &intel_irq_remap_ops;
