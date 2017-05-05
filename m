From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] iommu: add qcom_iommu
Date: Fri, 5 May 2017 14:04:21 -0500
Message-ID: <CAL_Jsq+5noR6pE5da9C8PTdX2c5HE9s4Mt4ovMi6w9FbhX6EXg@mail.gmail.com>
References: <20170504133436.24288-4-robdclark@gmail.com> <20170505182151.22931-1-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170505182151.22931-1-robdclark@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: Linux IOMMU <iommu@lists.linux-foundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Sricharan <sricharan@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Archit Taneja <architt@codeaurora.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, May 5, 2017 at 1:21 PM, Rob Clark <robdclark@gmail.com> wrote:
> An iommu driver for Qualcomm "B" family devices which do not completely
> implement the ARM SMMU spec.  These devices have context-bank register
> layout that is similar to ARM SMMU, but no global register space (or at
> least not one that is accessible).
>
> Signed-off-by: Rob Clark <robdclark@gmail.com>
> ---
> v1: original
> v2: bindings cleanups and kconfig issues that kbuild robot pointed out
> v4: fix issues pointed out by Rob H. and actually make device removal
>     work
> v3: fix WARN_ON() splats reported by Archit
>
>  drivers/iommu/Kconfig      |   9 +
>  drivers/iommu/Makefile     |   1 +
>  drivers/iommu/qcom_iommu.c | 833 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 843 insertions(+)
>  create mode 100644 drivers/iommu/qcom_iommu.c
>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 37e204f..f8f79a4 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -359,4 +359,13 @@ config MTK_IOMMU_V1
>
>           if unsure, say N here.
>
> +config QCOM_IOMMU
> +       bool "Qualcomm IOMMU Support"

Either this needs to be tristate or...

[...]
> +#include <linux/module.h>

this include and the things that need it should go. Or some
explanation like "once X happens, then we can enable as module" and
leave it all for now.

See this[1] for some background.

Rob

[1] https://lwn.net/Articles/643854/
