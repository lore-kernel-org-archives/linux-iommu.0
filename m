From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] iommu: qcom: annotate PM functions as __maybe_unused
Date: Wed, 23 Aug 2017 09:53:45 -0400
Message-ID: <CAF6AEGuAnJvL2t6yF0BbKpCJuzK_FULHwN599g79C1JONDav4Q@mail.gmail.com>
References: <20170823134303.1000996-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170823134303.1000996-1-arnd@arndb.de>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Joerg Roedel <joro@8bytes.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Aug 23, 2017 at 9:42 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The qcom_iommu_disable_clocks() function is only called from PM
> code that is hidden in an #ifdef, causing a harmless warning without
> CONFIG_PM:
>
> drivers/iommu/qcom_iommu.c:601:13: error: 'qcom_iommu_disable_clocks' defined but not used [-Werror=unused-function]
>  static void qcom_iommu_disable_clocks(struct qcom_iommu_dev *qcom_iommu)
> drivers/iommu/qcom_iommu.c:581:12: error: 'qcom_iommu_enable_clocks' defined but not used [-Werror=unused-function]
>  static int qcom_iommu_enable_clocks(struct qcom_iommu_dev *qcom_iommu)
>
> Replacing that #ifdef with __maybe_unused annotations lets the compiler
> drop the functions silently instead.
>
> Fixes: 0ae349a0f33f ("iommu/qcom: Add qcom_iommu")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

thanks

Acked-by: Rob Clark <robdclark@gmail.com>

> ---
>  drivers/iommu/qcom_iommu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index 48b62aa52787..c8a587d034b0 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -860,8 +860,7 @@ static int qcom_iommu_device_remove(struct platform_device *pdev)
>         return 0;
>  }
>
> -#ifdef CONFIG_PM
> -static int qcom_iommu_resume(struct device *dev)
> +static int __maybe_unused qcom_iommu_resume(struct device *dev)
>  {
>         struct platform_device *pdev = to_platform_device(dev);
>         struct qcom_iommu_dev *qcom_iommu = platform_get_drvdata(pdev);
> @@ -869,7 +868,7 @@ static int qcom_iommu_resume(struct device *dev)
>         return qcom_iommu_enable_clocks(qcom_iommu);
>  }
>
> -static int qcom_iommu_suspend(struct device *dev)
> +static int __maybe_unused qcom_iommu_suspend(struct device *dev)
>  {
>         struct platform_device *pdev = to_platform_device(dev);
>         struct qcom_iommu_dev *qcom_iommu = platform_get_drvdata(pdev);
> @@ -878,7 +877,6 @@ static int qcom_iommu_suspend(struct device *dev)
>
>         return 0;
>  }
> -#endif
>
>  static const struct dev_pm_ops qcom_iommu_pm_ops = {
>         SET_RUNTIME_PM_OPS(qcom_iommu_suspend, qcom_iommu_resume, NULL)
> --
> 2.9.0
>
