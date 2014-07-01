From: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 04/10] memory: Add Tegra124 memory controller support
Date: Tue, 1 Jul 2014 15:14:52 +0300
Message-ID: <8761jh9sxv.fsf@nvidia.com>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Paul Walmsley <pwalmsley-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Dave Martin <Dave.Martin-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Allen Martin <AMartin-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rhyland Klein <rklein-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org


Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> diff --git a/include/dt-bindings/memory/tegra124-mc.h b/include/dt-bindings/memory/tegra124-mc.h
> new file mode 100644
> index 000000000000..6b1617ce022f
> --- /dev/null
> +++ b/include/dt-bindings/memory/tegra124-mc.h
> @@ -0,0 +1,30 @@
> +#ifndef DT_BINDINGS_MEMORY_TEGRA124_MC_H
> +#define DT_BINDINGS_MEMORY_TEGRA124_MC_H
> +
> +#define TEGRA_SWGROUP_DC       0
> +#define TEGRA_SWGROUP_DCB      1
> +#define TEGRA_SWGROUP_AFI      2
> +#define TEGRA_SWGROUP_AVPC     3
> +#define TEGRA_SWGROUP_HDA      4
> +#define TEGRA_SWGROUP_HC       5
> +#define TEGRA_SWGROUP_MSENC    6
> +#define TEGRA_SWGROUP_PPCS     7
> +#define TEGRA_SWGROUP_SATA     8
> +#define TEGRA_SWGROUP_VDE      9
> +#define TEGRA_SWGROUP_MPCORELP 10
> +#define TEGRA_SWGROUP_MPCORE   11
> +#define TEGRA_SWGROUP_ISP2     12
> +#define TEGRA_SWGROUP_XUSB_HOST        13
> +#define TEGRA_SWGROUP_XUSB_DEV 14
> +#define TEGRA_SWGROUP_ISP2B    15
> +#define TEGRA_SWGROUP_TSEC     16
> +#define TEGRA_SWGROUP_A9AVP    17
> +#define TEGRA_SWGROUP_GPU      18
> +#define TEGRA_SWGROUP_SDMMC1A  19
> +#define TEGRA_SWGROUP_SDMMC2A  20
> +#define TEGRA_SWGROUP_SDMMC3A  21
> +#define TEGRA_SWGROUP_SDMMC4A  22
> +#define TEGRA_SWGROUP_VIC      23
> +#define TEGRA_SWGROUP_VI       24
> +
> +#endif

In the SMMUv8 patch series, I have assigned unique IDs for all those
HWAs among Tegra SoC generations so that DT can provide which HWAs are
attached to that SoC. The SMMUv8 driver would be unified among Tegra
SoCs, then.
