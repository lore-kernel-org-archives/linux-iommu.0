From: Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH 01/13] soc/fsl/qman: fixup liodns only on ppc targets
Date: Fri, 29 Mar 2019 16:50:23 -0500
Message-ID: <CADRPPNQ9AGRvq8XDjeTerUBry+_hO-U=shCXFaqHhtc9QvMvng@mail.gmail.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com> <20190329140014.8126-2-laurentiu.tudor@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329140014.8126-2-laurentiu.tudor@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Netdev <netdev@vger.kernel.org>, madalin.bucur@nxp.com, Roy Pledge <roy.pledge@nxp.com>, camelia.groza@nxp.com, David Miller <davem@davemloft.net>, Linux IOMMU <iommu@lists.linux-foundation.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 29, 2019 at 9:01 AM <laurentiu.tudor@nxp.com> wrote:
>
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> ARM SoCs use SMMU so the liodn fixup done in the qman driver is no
> longer making sense and it also breaks the ICID settings inherited
> from u-boot. Do the fixups only for PPC targets.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/soc/fsl/qbman/qman_ccsr.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
> index 109b38de3176..12e414ca3b03 100644
> --- a/drivers/soc/fsl/qbman/qman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/qman_ccsr.c
> @@ -598,6 +598,7 @@ static int qman_init_ccsr(struct device *dev)
>  #define LIO_CFG_LIODN_MASK 0x0fff0000
>  void qman_liodn_fixup(u16 channel)
>  {
> +#ifdef CONFIG_PPC
>         static int done;
>         static u32 liodn_offset;
>         u32 before, after;
> @@ -617,6 +618,7 @@ void qman_liodn_fixup(u16 channel)
>                 qm_ccsr_out(REG_REV3_QCSP_LIO_CFG(idx), after);
>         else
>                 qm_ccsr_out(REG_QCSP_LIO_CFG(idx), after);
> +#endif

According to the Linux coding style recommendation, it would be better
to put the #ifdef into the header files
"drivers/soc/fsl/qbman/qman_priv.h".  And I'm not sure if this is
needed on PPC when IOMMU(PAMU) driver is not compiled, if not,
probably using CONFIG_PAMU as condition would be even better.

>  }
>
>  #define IO_CFG_SDEST_MASK 0x00ff0000
> --
> 2.17.1
>
