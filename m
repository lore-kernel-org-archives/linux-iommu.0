From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu: qcom: annotate PM functions as __maybe_unused
Date: Mon, 28 Aug 2017 11:25:17 +0200
Message-ID: <20170828092516.tht3a67qeytao3y7@8bytes.org>
References: <20170823134303.1000996-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170823134303.1000996-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Clark <robdclark@gmail.com>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Aug 23, 2017 at 03:42:45PM +0200, Arnd Bergmann wrote:
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
> ---
>  drivers/iommu/qcom_iommu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied, thanks.
