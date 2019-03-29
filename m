From: Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH 05/13] soc/fsl/bqman: page align iommu mapping sizes
Date: Fri, 29 Mar 2019 17:06:45 -0500
Message-ID: <CADRPPNTh65rwPVVzJBWt-cNrbQWAoo0FeTGnCHDiqSxvARa_5g@mail.gmail.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com> <20190329140014.8126-6-laurentiu.tudor@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190329140014.8126-6-laurentiu.tudor@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Netdev <netdev@vger.kernel.org>, madalin.bucur@nxp.com, Roy Pledge <roy.pledge@nxp.com>, camelia.groza@nxp.com, David Miller <davem@davemloft.net>, Linux IOMMU <iommu@lists.linux-foundation.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 29, 2019 at 9:01 AM <laurentiu.tudor@nxp.com> wrote:
>
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> Prior to calling iommu_map()/iommu_unmap() page align the size or
> failures such as below could happen:
>
> iommu: unaligned: iova 0x... pa 0x... size 0x4000 min_pagesz 0x10000
> qman_portal 500000000.qman-portal: failed to iommu_map() -22
>
> Seen when booted a kernel compiled with 64K page size support.

This will silently incease the actual space mapped to 64K when the
driver is actually trying to map 4K.  Will this potentially cause
security breaches?  If it is really safe to map 64K, probably the
better way is to increase the region size to 64k in the device tree
explicitly.

>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>  drivers/soc/fsl/qbman/bman_ccsr.c   | 2 +-
>  drivers/soc/fsl/qbman/qman_ccsr.c   | 4 ++--
>  drivers/soc/fsl/qbman/qman_portal.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c b/drivers/soc/fsl/qbman/bman_ccsr.c
> index b209c79511bb..3a6e01bde32d 100644
> --- a/drivers/soc/fsl/qbman/bman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/bman_ccsr.c
> @@ -230,7 +230,7 @@ static int fsl_bman_probe(struct platform_device *pdev)
>         /* Create an 1-to-1 iommu mapping for FBPR area */
>         domain = iommu_get_domain_for_dev(dev);
>         if (domain) {
> -               ret = iommu_map(domain, fbpr_a, fbpr_a, fbpr_sz,
> +               ret = iommu_map(domain, fbpr_a, fbpr_a, PAGE_ALIGN(fbpr_sz),
>                                 IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
>                 if (ret)
>                         dev_warn(dev, "failed to iommu_map() %d\n", ret);
> diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
> index eec7700507e1..8d3c950ce52d 100644
> --- a/drivers/soc/fsl/qbman/qman_ccsr.c
> +++ b/drivers/soc/fsl/qbman/qman_ccsr.c
> @@ -783,11 +783,11 @@ static int fsl_qman_probe(struct platform_device *pdev)
>         /* Create an 1-to-1 iommu mapping for fqd and pfdr areas */
>         domain = iommu_get_domain_for_dev(dev);
>         if (domain) {
> -               ret = iommu_map(domain, fqd_a, fqd_a, fqd_sz,
> +               ret = iommu_map(domain, fqd_a, fqd_a, PAGE_ALIGN(fqd_sz),
>                                 IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
>                 if (ret)
>                         dev_warn(dev, "iommu_map(fqd) failed %d\n", ret);
> -               ret = iommu_map(domain, pfdr_a, pfdr_a, pfdr_sz,
> +               ret = iommu_map(domain, pfdr_a, pfdr_a, PAGE_ALIGN(pfdr_sz),
>                                 IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
>                 if (ret)
>                         dev_warn(dev, "iommu_map(pfdr) failed %d\n", ret);
> diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> index dfb62f9815e9..bce56da2b01f 100644
> --- a/drivers/soc/fsl/qbman/qman_portal.c
> +++ b/drivers/soc/fsl/qbman/qman_portal.c
> @@ -297,7 +297,7 @@ static int qman_portal_probe(struct platform_device *pdev)
>                  */
>                 err = iommu_map(domain,
>                                 addr_phys[0]->start, addr_phys[0]->start,
> -                               resource_size(addr_phys[0]),
> +                               PAGE_ALIGN(resource_size(addr_phys[0])),
>                                 IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
>                 if (err)
>                         dev_warn(dev, "failed to iommu_map() %d\n", err);
> --
> 2.17.1
>
