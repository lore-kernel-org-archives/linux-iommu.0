From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] dts: arm64/sdm845: Add node for arm,mmu-500
Date: Thu, 19 Jul 2018 17:08:31 -0600
Message-ID: <CAL_JsqKQgZq23F7gqNoEDzpWj3zVR7Tsok3cZZCpCL=Br_+BeA@mail.gmail.com>
References: <20180719175356.14753-1-vivek.gautam@codeaurora.org> <20180719175356.14753-2-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180719175356.14753-2-vivek.gautam@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vivek Gautam <vivek.gautam@codeaurora.org>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Andy Gross <andy.gross@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Linux IOMMU <iommu@lists.linux-foundation.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tomasz Figa <tfiga@chromium.org>, Sricharan <sricharan@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, David Brown <david.brown@linaro.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Jul 19, 2018 at 11:54 AM Vivek Gautam
<vivek.gautam@codeaurora.org> wrote:
>
> Add device node for arm,mmu-500 available on sdm845.
> This MMU-500 with single TCU and multiple TBU architecture
> is shared among all the peripherals except gpu on sdm845.
>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  4 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 73 +++++++++++++++++++++++++++++++++
>  2 files changed, 77 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> index 6d651f314193..13b50dff440f 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -58,3 +58,7 @@
>                 bias-pull-up;
>         };
>  };
> +
> +&apps_smmu {
> +       status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 00722b533a92..70ca18ae6cb3 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -980,6 +980,79 @@
>                         cell-index = <0>;
>                 };
>
> +               apps_smmu: arm,smmu@15000000 {

iommu@...

> +                       compatible = "arm,mmu-500";

Really unmodified by QCom? Would be better to have SoC specific compatible.

Rob
