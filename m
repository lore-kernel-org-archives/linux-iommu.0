From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v11 15/27] iommu/exynos: use convenient macro to handle
 gate clocks
Date: Fri, 14 Mar 2014 14:43:42 +0100
Message-ID: <5323078E.4060903@samsung.com>
References: <20140314140951.3d443a3096e80297c9fecef0@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <20140314140951.3d443a3096e80297c9fecef0@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Cho KyongHo <pullip.cho@samsung.com>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>, Linux DeviceTree <devicetree@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>, Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Cc: Antonios Motakis <a.motakis@virtualopensystems.com>, Grant Grundler <grundler@chromium.org>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene.kim@samsung.com>, Prathyush <prathyush.k@samsung.com>, Rahul Sharma <rahul.sharma@samsung.com>, Sachin Kamat <sachin.kamat@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Varun Sethi <Varun.Sethi@freescale.com>
List-Id: iommu@lists.linux-foundation.org

Hi KyongHo,

On 14.03.2014 06:09, Cho KyongHo wrote:
> exynos-iommu driver must care about master H/W's gate clock as well as
> System MMU's gate clock. To enhance readability of the source code,
> macros to gate/ungate those clocks are defined.
>
> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> ---
>   drivers/iommu/exynos-iommu.c |   34 ++++++++++++++++++++++------------
>   1 file changed, 22 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 71e77f1..cef62d0 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -101,6 +101,16 @@
>   #define REG_PB1_SADDR		0x054
>   #define REG_PB1_EADDR		0x058
>
> +#define __clk_gate_ctrl(data, clk, en)	do {		\
> +		if (data->clk)				\
> +			clk_##en##able(data->clk);	\
> +	} while (0)
> +
> +#define __sysmmu_clk_enable(data)	__clk_gate_ctrl(data, clk, en)
> +#define __sysmmu_clk_disable(data)	__clk_gate_ctrl(data, clk, dis)
> +#define __master_clk_enable(data)	__clk_gate_ctrl(data, clk_master, en)
> +#define __master_clk_disable(data)	__clk_gate_ctrl(data, clk_master, dis)
> +

I'd say that such macros only obfuscate code, without any gains, as you 
can see in diffstat - this patch adds more lines than it removes.

Please drop this change.

Best regards,
Tomasz
