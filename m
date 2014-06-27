From: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 04/10] memory: Add Tegra124 memory controller support
Date: Fri, 27 Jun 2014 15:41:20 +0800
Message-ID: <53AD2020.1050802@nvidia.com>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
	<1403815790-8548-5-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1403815790-8548-5-git-send-email-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar
	Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Arnd
	Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Allen Martin <AMartin-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Thierry,

On 06/27/2014 04:49 AM, Thierry Reding wrote:
[snip]
> +
> +#define MC_INTSTATUS 0x000
> +#define  MC_INT_DECERR_MTS (1 << 16)
> +#define  MC_INT_SECERR_SEC (1 << 13)
> +#define  MC_INT_DECERR_VPR (1 << 12)
> +#define  MC_INT_INVALID_APB_ASID_UPDATE (1 << 11)
> +#define  MC_INT_INVALID_SMMU_PAGE (1 << 10)
> +#define  MC_INT_ARBITRATION_EMEM (1 << 9)
> +#define  MC_INT_SECURITY_VIOLATION (1 << 8)
> +#define  MC_INT_DECERR_EMEM (1 << 6)
> +#define MC_INTMASK 0x004
> +#define MC_ERR_STATUS 0x08
> +#define MC_ERR_ADR 0x0c
> +
[snip]
> +
> +#define SMMU_PDE_ATTR          (SMMU_PDE_READABLE | SMMU_PDE_WRITABLE | \
> +                                SMMU_PDE_NONSECURE)
> +#define SMMU_PTE_ATTR          (SMMU_PTE_READABLE | SMMU_PTE_WRITABLE | \
> +                                SMMU_PTE_NONSECURE)
> +
> +#define SMMU_PDE_VACANT(n)     (((n) << 10) | SMMU_PDE_ATTR)
> +#define SMMU_PTE_VACANT(n)     (((n) << 12) | SMMU_PTE_ATTR)

There is an ISR to catch the invalid SMMU translation. Do you want to 
modify the identity mapping with read/write attribute of the unused SMMU 
pages?

This can make sure we capture the invalid SMMU translation. And helps 
for driver to capture issues when using SMMU.

-joseph

> +static irqreturn_t tegra124_mc_irq(int irq, void *data)
> +{
> +       struct tegra_mc *mc = data;
> +       u32 value, status, mask;
> +
> +       /* mask all interrupts to avoid flooding */
> +       mask = mc_readl(mc, MC_INTMASK);
> +       mc_writel(mc, 0, MC_INTMASK);
> +
> +       status = mc_readl(mc, MC_INTSTATUS);
> +       mc_writel(mc, status, MC_INTSTATUS);
> +
> +       dev_dbg(mc->dev, "INTSTATUS: %08x\n", status);
> +
> +       if (status & MC_INT_DECERR_MTS)
> +               dev_dbg(mc->dev, "  DECERR_MTS\n");
> +
> +       if (status & MC_INT_SECERR_SEC)
> +               dev_dbg(mc->dev, "  SECERR_SEC\n");
> +
> +       if (status & MC_INT_DECERR_VPR)
> +               dev_dbg(mc->dev, "  DECERR_VPR\n");
> +
> +       if (status & MC_INT_INVALID_APB_ASID_UPDATE)
> +               dev_dbg(mc->dev, "  INVALID_APB_ASID_UPDATE\n");
> +
> +       if (status & MC_INT_INVALID_SMMU_PAGE)
> +               dev_dbg(mc->dev, "  INVALID_SMMU_PAGE\n");
> +
> +       if (status & MC_INT_ARBITRATION_EMEM)
> +               dev_dbg(mc->dev, "  ARBITRATION_EMEM\n");
> +
> +       if (status & MC_INT_SECURITY_VIOLATION)
> +               dev_dbg(mc->dev, "  SECURITY_VIOLATION\n");
> +
> +       if (status & MC_INT_DECERR_EMEM)
> +               dev_dbg(mc->dev, "  DECERR_EMEM\n");
> +
> +       value = mc_readl(mc, MC_ERR_STATUS);
> +
> +       dev_dbg(mc->dev, "ERR_STATUS: %08x\n", value);
> +       dev_dbg(mc->dev, "  type: %x\n", (value >> 28) & 0x7);
> +       dev_dbg(mc->dev, "  protection: %x\n", (value >> 25) & 0x7);
> +       dev_dbg(mc->dev, "  adr_hi: %x\n", (value >> 20) & 0x3);
> +       dev_dbg(mc->dev, "  swap: %x\n", (value >> 18) & 0x1);
> +       dev_dbg(mc->dev, "  security: %x\n", (value >> 17) & 0x1);
> +       dev_dbg(mc->dev, "  r/w: %x\n", (value >> 16) & 0x1);
> +       dev_dbg(mc->dev, "  adr1: %x\n", (value >> 12) & 0x7);
> +       dev_dbg(mc->dev, "  client: %x\n", value & 0x7f);
> +
> +       value = mc_readl(mc, MC_ERR_ADR);
> +       dev_dbg(mc->dev, "ERR_ADR: %08x\n", value);
> +
> +       mc_writel(mc, mask, MC_INTMASK);
> +
> +       return IRQ_HANDLED;
> +}
> +
