From: Shuah Khan <shuahkhan@gmail.com>
Subject: Re: [PATCH 14/16] iommu/irq: Use amd_iommu_irq_ops if supported
Date: Fri, 28 Sep 2012 17:39:03 -0600
Message-ID: <CAKocOONaiMJs7pWeWxO=_bN5_KU=jZh=kvL7U_v-w9LmSrQ+Fw@mail.gmail.com>
References: <1348835046-3262-1-git-send-email-joerg.roedel@amd.com>
	<1348835046-3262-15-git-send-email-joerg.roedel@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348835046-3262-15-git-send-email-joerg.roedel@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Sep 28, 2012 at 6:24 AM, Joerg Roedel <joerg.roedel@amd.com> wrote:
> Finally enable interrupt remapping for AMD systems.
>
> Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
> ---
>  drivers/iommu/irq_remapping.c |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/iommu/irq_remapping.c b/drivers/iommu/irq_remapping.c
> index 151690d..faf85d6 100644
> --- a/drivers/iommu/irq_remapping.c
> +++ b/drivers/iommu/irq_remapping.c
> @@ -51,6 +51,11 @@ early_param("intremap", setup_irqremap);
>  void __init setup_irq_remapping_ops(void)
>  {
>         remap_ops = &intel_irq_remap_ops;
> +
> +#ifdef CONFIG_AMD_IOMMU
> +       if (amd_iommu_irq_ops.prepare() == 0)
> +               remap_ops = &amd_iommu_irq_ops;
> +#endif

Should remap_ops be set to null when amd_iommu_irq_ops.prepare()
fails?What happens if remap_ops left set to intel_irq_remap_ops?
Should remap_ops = &intel_irq_remap_ops; moved into #else case
forifdef CONFIG_AMD_IOMMU?
>  }
>
>  int irq_remapping_supported(void)
> --
> 1.7.9.5
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
