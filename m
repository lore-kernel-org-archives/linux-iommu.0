From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [RFC 04/10] memory: Add Tegra124 memory controller support
Date: Mon, 30 Jun 2014 16:43:23 -0600
Message-ID: <53B1E80B.5040503@wwwdotorg.org>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
	<1403815790-8548-5-git-send-email-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Allen Martin <amartin-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 06/26/2014 02:49 PM, Thierry Reding wrote:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> The memory controller on NVIDIA Tegra124 exposes various knobs that can
> be used to tune the behaviour of the clients attached to it.
> 
> Currently this driver sets up the latency allowance registers to the HW
> defaults. Eventually an API should be exported by this driver (via a
> custom API or a generic subsystem) to allow clients to register latency
> requirements.
> 
> This driver also registers an IOMMU (SMMU) that's implemented by the
> memory controller.

> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig

> +config TEGRA124_MC
> +	bool "Tegra124 Memory Controller driver"
> +	depends on ARCH_TEGRA

Does it make sense to default to y for system-level drivers like this?

> diff --git a/drivers/memory/tegra124-mc.c b/drivers/memory/tegra124-mc.c

As a general comment, I wonder why the Tegra124 code/data here is
ifdef'd based on CONFIG_ARCH_TEGRA_124_SOC but the Tegra132 code isn't
ifdef'd at all. I'd assert that the Tegra124 code is small enough it's
hardly worth worrying about ifdefs.

> +static inline void smmu_flush_ptc(struct tegra_smmu *smmu, struct page *page,
> +				  unsigned long offset)
> +{
> +	phys_addr_t phys = page ? page_to_phys(page) : 0;
> +	u32 value;
> +
> +	if (page) {
> +		offset &= ~(smmu->soc->atom_size - 1);
> +
> +#ifdef CONFIG_PHYS_ADDR_T_64BIT
> +		value = (phys >> 32) & SMMU_PTC_FLUSH_HI_MASK;
> +#else
> +		value = 0;
> +#endif

Shouldn't Tegra124 have CONFIG_PHYS_ADDR_T_64BIT defined, such that
there's no need for this ifdef? Certainly Tegra124 {has,can have} RAM
above 4GB physical, for some memory map layouts (i.e. non swiss cheese).

(I assume most of this code matches the existing Tegra30 SMMU driver, so
I didn't look at all of it that closely).

> +static int tegra_smmu_attach(struct iommu *iommu, struct device *dev)
...
> +#ifndef CONFIG_ARM64
> +	return arm_iommu_attach_device(dev, group->mapping);
> +#else
> +	return 0;
> +#endif

Hmm. Why must an SMMU driver for the exact same HW operate differently
depending on the CPU that's attached to the SoC? Surely the requirements
for how IOMMU drives should work should be the same for all architectures?

> +static int tegra_mc_probe(struct platform_device *pdev)

> +	err = devm_request_irq(&pdev->dev, mc->irq, tegra124_mc_irq,
> +			       IRQF_SHARED, dev_name(&pdev->dev), mc);

I don't see any code in tegra_mc_remove() that guarantees that the IRQ
won't fire between tegra_mc_remove() returning, and the devm cleanup
code running to unhook that IRQ handler.

> diff --git a/include/dt-bindings/memory/tegra124-mc.h b/include/dt-bindings/memory/tegra124-mc.h

This file is part of the DT binding, so should be added in the patch
that adds the binding.
