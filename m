From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC v1 3/7] iommu/arm-smmu-v3: Replace the device tree binding
 for hisilicon broken prefetch cmd with erratum id
Date: Mon, 15 May 2017 10:23:51 -0500
Message-ID: <CAL_JsqLH7iT7O2U3g6J26YGBUmt53PDymLJ5VCLByW_97L_M4w@mail.gmail.com>
References: <20170513094731.3676-1-shameerali.kolothum.thodi@huawei.com> <20170513094731.3676-4-shameerali.kolothum.thodi@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170513094731.3676-4-shameerali.kolothum.thodi@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
To: shameer <shameerali.kolothum.thodi@huawei.com>
Cc: Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Gabriele Paoloni <gabriele.paoloni@huawei.com>, John Garry <john.garry@huawei.com>, Linux IOMMU <iommu@lists.linux-foundation.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, devel@acpica.org, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, Hanjun Guo <guohanjun@huawei.com>
List-Id: iommu@lists.linux-foundation.org

On Sat, May 13, 2017 at 4:47 AM, shameer
<shameerali.kolothum.thodi@huawei.com> wrote:
> Signed-off-by: shameer <shameerali.kolothum.thodi@huawei.com>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> index be57550..bf48e92 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> @@ -46,7 +46,7 @@ the PCIe specification.
>                          devicetree/bindings/interrupt-controller/msi.txt
>                        for a description of the msi-parent property.
>
> -- hisilicon,broken-prefetch-cmd
> +- hisilicon,erratum-161010701

Why? Your missing commit msg should answer that. This breaks
compatibility, so you are stuck with the old string.

I'd prefer that you start using the compatible string rather than
every vendor adding a property for every errata.

Rob
