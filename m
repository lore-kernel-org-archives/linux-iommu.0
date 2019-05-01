From: Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH v2 1/9] soc/fsl/qman: fixup liodns only on ppc targets
Date: Wed, 1 May 2019 15:08:38 -0500
Message-ID: <CADRPPNRGxEz_YXhzrJPCZrz_Xc-9Fh21tgbjERoOazMMQmiVbA@mail.gmail.com>
References: <20190427071031.6563-1-laurentiu.tudor@nxp.com> <20190427071031.6563-2-laurentiu.tudor@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190427071031.6563-2-laurentiu.tudor@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Netdev <netdev@vger.kernel.org>, madalin.bucur@nxp.com, Roy Pledge <roy.pledge@nxp.com>, camelia.groza@nxp.com, David Miller <davem@davemloft.net>, Linux IOMMU <iommu@lists.linux-foundation.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Sat, Apr 27, 2019 at 2:14 AM <laurentiu.tudor@nxp.com> wrote:
>
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> ARM SoCs use SMMU so the liodn fixup done in the qman driver is no
> longer making sense and it also breaks the ICID settings inherited
> from u-boot. Do the fixups only for PPC targets.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Applied for next.  Thanks.

Leo
> ---
>  drivers/soc/fsl/qbman/qman_ccsr.c | 2 +-
>  drivers/soc/fsl/qbman/qman_priv.h | 9 ++++++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
> index 109b38de3176..a6bb43007d03 100644
> --- a/drivers/soc/fsl/qbman/qman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/qman_ccsr.c
> @@ -596,7 +596,7 @@ static int qman_init_ccsr(struct device *dev)
>  }
>
>  #define LIO_CFG_LIODN_MASK 0x0fff0000
> -void qman_liodn_fixup(u16 channel)
> +void __qman_liodn_fixup(u16 channel)
>  {
>         static int done;
>         static u32 liodn_offset;
> diff --git a/drivers/soc/fsl/qbman/qman_priv.h b/drivers/soc/fsl/qbman/qman_priv.h
> index 75a8f905f8f7..04515718cfd9 100644
> --- a/drivers/soc/fsl/qbman/qman_priv.h
> +++ b/drivers/soc/fsl/qbman/qman_priv.h
> @@ -193,7 +193,14 @@ extern struct gen_pool *qm_cgralloc; /* CGR ID allocator */
>  u32 qm_get_pools_sdqcr(void);
>
>  int qman_wq_alloc(void);
> -void qman_liodn_fixup(u16 channel);
> +#ifdef CONFIG_FSL_PAMU
> +#define qman_liodn_fixup __qman_liodn_fixup
> +#else
> +static inline void qman_liodn_fixup(u16 channel)
> +{
> +}
> +#endif
> +void __qman_liodn_fixup(u16 channel);
>  void qman_set_sdest(u16 channel, unsigned int cpu_idx);
>
>  struct qman_portal *qman_create_affine_portal(
> --
> 2.17.1
>
