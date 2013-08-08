From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH v9 05/16] clk: exynos: add gate clock descriptions of
 System MMU
Date: Thu, 08 Aug 2013 13:17:34 +0200
Message-ID: <52037E4E.5050706@samsung.com>
References: <002901ce941b$0130db50$039291f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <002901ce941b$0130db50$039291f0$@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Cho KyongHo <pullip.cho@samsung.com>
Cc: 'Linux ARM Kernel' <linux-arm-kernel@lists.infradead.org>, 'Linux IOMMU' <iommu@lists.linux-foundation.org>, 'Linux Kernel' <linux-kernel@vger.kernel.org>, 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, 'Joerg Roedel' <joro@8bytes.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Prathyush' <prathyush.k@samsung.com>, 'Rahul Sharma' <rahul.sharma@samsung.com>, 'Subash Patel' <supash.ramaswamy@linaro.org>, 'Grant Grundler' <grundler@chromium.org>, 'Antonios Motakis' <a.motakis@virtualopensystems.com>, kvmarm@lists.cs.columbia.edu, 'Sachin Kamat' <sachin.kamat@linaro.org>
List-Id: iommu@lists.linux-foundation.org

On 08/08/2013 11:38 AM, Cho KyongHo wrote:
> This adds gate clocks of all System MMUs and their master IPs
> that are not apeared in clk-exynos5250.c
> Also fixes GATE_IP_ACP to 0x18800 and changed GATE_DA to GATE
> for System MMU clocks in clk-exynos4.c
> 
> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>
> ---
>  .../devicetree/bindings/clock/exynos5250-clock.txt |   26 +++++++++
>  drivers/clk/samsung/clk-exynos4.c                  |   27 +++------
>  drivers/clk/samsung/clk-exynos5250.c               |   57 ++++++++++++++++----
>  3 files changed, 82 insertions(+), 28 deletions(-)
[...]
> @@ -349,19 +358,26 @@ static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
>  	GATE(gscl3, "gscl3", "aclk266", GATE_IP_GSCL, 3, 0, 0),
>  	GATE(gscl_wa, "gscl_wa", "div_gscl_wa", GATE_IP_GSCL, 5, 0, 0),
>  	GATE(gscl_wb, "gscl_wb", "div_gscl_wb", GATE_IP_GSCL, 6, 0, 0),
> -	GATE(smmu_gscl0, "smmu_gscl0", "aclk266", GATE_IP_GSCL, 7, 0, 0),
> -	GATE(smmu_gscl1, "smmu_gscl1", "aclk266", GATE_IP_GSCL, 8, 0, 0),
> -	GATE(smmu_gscl2, "smmu_gscl2", "aclk266", GATE_IP_GSCL, 9, 0, 0),
> -	GATE(smmu_gscl3, "smmu_gscl3", "aclk266", GATE_IP_GSCL, 10, 0, 0),
> +	GATE(smmu_gscl0, "smmu_gscl0", "none", GATE_IP_GSCL, 7, 0, 0),
> +	GATE(smmu_gscl1, "smmu_gscl1", "none", GATE_IP_GSCL, 8, 0, 0),
> +	GATE(smmu_gscl2, "smmu_gscl2", "none", GATE_IP_GSCL, 9, 0, 0),
> +	GATE(smmu_gscl3, "smmu_gscl3", "none", GATE_IP_GSCL, 10, 0, 0),

Why are the smmu clocks' parent clocks removed ? Shouldn't both the gscaler
gate clock and the gscaler smmu clock be still same, as it is in case of
exynos4 ?
