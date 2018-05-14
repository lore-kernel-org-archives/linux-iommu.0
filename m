From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v7 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Date: Mon, 14 May 2018 10:50:29 -0700
Message-ID: <ba2bb6f7-77ea-4431-af0f-d20c19820d5d@infradead.org>
References: <152631818082.18929.13970142119193316487.stgit@sosxen2.amd.com>
 <152631842907.18929.8819955271544326298.stgit@sosxen2.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152631842907.18929.8819955271544326298.stgit@sosxen2.amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On 05/14/2018 10:20 AM, Gary R Hook wrote:
> Implement a skeleton framework for debugfs support in the
> AMD IOMMU.
> 
> Signed-off-by: Gary R Hook <gary.hook@amd.com>
> ---
>  drivers/iommu/Makefile            |    5 +++++
>  drivers/iommu/amd_iommu_debugfs.c |   39 +++++++++++++++++++++++++++++++++++++
>  drivers/iommu/amd_iommu_init.c    |    6 ++++--
>  drivers/iommu/amd_iommu_proto.h   |    6 ++++++
>  drivers/iommu/amd_iommu_types.h   |    3 +++
>  5 files changed, 57 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/iommu/amd_iommu_debugfs.c
> 
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 74cfbc392862..dd980f7dd8b6 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -30,3 +30,8 @@ obj-$(CONFIG_EXYNOS_IOMMU) += exynos-iommu.o
>  obj-$(CONFIG_FSL_PAMU) += fsl_pamu.o fsl_pamu_domain.o
>  obj-$(CONFIG_S390_IOMMU) += s390-iommu.o
>  obj-$(CONFIG_QCOM_IOMMU) += qcom_iommu.o
> +
> +# This ensures that only the required files are compiled
> +ifeq ($(CONFIG_IOMMU_DEBUGFS), y)

Most Makefiles don't use a space before the 'y', but since you tested it,
I guess either way works.

But why do this in the Makefile at all?  Why not just add another Kconfig
symbol and simplify the Makefile?

> +obj-$(CONFIG_AMD_IOMMU) += amd_iommu_debugfs.o
> +endif

-- 
~Randy
