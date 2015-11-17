From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] docs: iommu: Documentation for iommu in hi6220 SoC
Date: Tue, 17 Nov 2015 11:36:11 -0600
Message-ID: <CAL_JsqJy7e7WR=mjTNJKB=r2y0nUq1mZ4++Wb5=DMogTitrpMQ@mail.gmail.com>
References: <1447761468-36952-1-git-send-email-puck.chen@hisilicon.com> <1447761468-36952-2-git-send-email-puck.chen@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447761468-36952-2-git-send-email-puck.chen@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Feng <puck.chen@hisilicon.com>
Cc: yudongbin@hisilicon.com, saberlily.xia@hisilicon.com, suzhuangluan@hisilicon.com, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Yiping Xu <xuyiping@hisilicon.com>, z.liuxinliang@hisilicon.com, puck.chen@aliyun.com, weidong2@hisilicon.com, w.f@huawei.com, Joerg Roedel <joro@8bytes.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Wei Xu <xuwei5@hisilicon.com>, qijiwen@hisilicon.com, shilin pan <peter.panshilin@hisilicon.com>, dan.zhao@hisilicon.com, Linuxarm <linuxarm@huawei.com>, Arnd Bergmann <arnd@linaro.org>, Rob Herring <rob.herring@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Nov 17, 2015 at 5:57 AM, Chen Feng <puck.chen@hisilicon.com> wrote:
> Documentation for hi6220 iommu driver.

Please use get_maintainers.pl and re-send to correct lists
(devicetree@vger.kernel.org).

>
> Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
> ---
>  .../bindings/iommu/hisi,hi6220-iommu.txt           | 32 ++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt
>
> diff --git a/Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt b/Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt
> new file mode 100644
> index 0000000..44f9101
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/hisi,hi6220-iommu.txt
> @@ -0,0 +1,32 @@
> +Hi6220 SoC SMMU Device Driver devicetree document
> +The media system shared the same smmu IP to access DDR memory. And all
> +media IP used the same page table.
> +
> +Below binding describes the system mmu for media system in hi6220 platform
> +
> +Required properties:
> +- compatible: should contain "hisilicon,hi6220-smmu".
> +- reg: A tuple of base address and size of System MMU registers.
> +- clocks: a list of phandle + clock-specifier pairs, one for each entry
> +  in clock-names.
> +- clock-names: should contain:
> +  * "smmu"
> +  * "media-sc"
> +  * "smmu-peri"
> +- interrupts: An interrupt specifier for interrupt signal of System MMU.
> +- #iommu-cells: The iommu-cells should be 0. Because no additional information
> +  needs to be encoded in the specifier.
> +
> +Examples:
> +       iommu@f4210000 {
> +               compatible = "hisilicon,hi6220-smmu";
> +               reg = <0x0 0xf4210000 0x0 0x1000>;
> +               interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&sys_ctrl HI6220_MMU_CLK>,
> +                        <&media_ctrl HI6220_MED_MMU>,
> +                        <&sys_ctrl HI6220_MEDIA_PLL_SRC>;
> +               clock-names = "smmu",
> +                             "media-sc",
> +                             "smmu-peri";
> +               #iommu-cells = <0>;
> +       };
> --
> 1.9.1
>
