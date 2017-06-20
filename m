From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v8 2/3] iommu/arm-smmu-v3: Add workaround for Cavium
 ThunderX2 erratum #74
Date: Tue, 20 Jun 2017 19:06:19 +0100
Message-ID: <20170620180618.GE28035@arm.com>
References: <1497968259-16390-1-git-send-email-gakula@caviumnetworks.com>
 <1497968259-16390-3-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1497968259-16390-3-git-send-email-gakula@caviumnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Geetha sowjanya <gakula@caviumnetworks.com>
Cc: robin.murphy@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, iommu@lists.linux-foundation.org, robert.moore@intel.com, lv.zheng@intel.com, rjw@rjwysocki.net, jcm@redhat.com, linux-kernel@vger.kernel.org, robert.richter@cavium.com, catalin.marinas@arm.com, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, geethasowjanya.akula@gmail.com, devel@acpica.org, linu.cherian@cavium.com, Charles.Garcia-Tobin@arm.com, robh@kernel.org, Geetha Sowjanya <geethasowjanya.akula@cavium.com>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 20, 2017 at 07:47:38PM +0530, Geetha sowjanya wrote:
> From: Linu Cherian <linu.cherian@cavium.com>
> 
> Cavium ThunderX2 SMMU implementation doesn't support page 1 register space
> and PAGE0_REGS_ONLY option is enabled as an errata workaround.
> This option when turned on, replaces all page 1 offsets used for
> EVTQ_PROD/CONS, PRIQ_PROD/CONS register access with page 0 offsets.
> 
> SMMU resource size checks are now based on SMMU option PAGE0_REGS_ONLY,
> since resource size can be either 64k/128k.
> For this, arm_smmu_device_dt_probe/acpi_probe has been moved before
> platform_get_resource call, so that SMMU options are set beforehand.
> 
> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
> Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
> ---
>  Documentation/arm64/silicon-errata.txt             |    1 +
>  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |    6 ++
>  drivers/iommu/arm-smmu-v3.c                        |   68 ++++++++++++++-----
>  3 files changed, 57 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
> index 10f2ddd..4693a32 100644
> --- a/Documentation/arm64/silicon-errata.txt
> +++ b/Documentation/arm64/silicon-errata.txt
> @@ -62,6 +62,7 @@ stable kernels.
>  | Cavium         | ThunderX GICv3  | #23154          | CAVIUM_ERRATUM_23154        |
>  | Cavium         | ThunderX Core   | #27456          | CAVIUM_ERRATUM_27456        |
>  | Cavium         | ThunderX SMMUv2 | #27704          | N/A                         |
> +| Cavium         | ThunderX2 SMMUv3| #74             | N/A                         |
>  |                |                 |                 |                             |
>  | Freescale/NXP  | LS2080A/LS1043A | A-008585        | FSL_ERRATUM_A008585         |
>  |                |                 |                 |                             |
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> index be57550..6ecc48c 100644
> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt
> @@ -49,6 +49,12 @@ the PCIe specification.
>  - hisilicon,broken-prefetch-cmd
>                      : Avoid sending CMD_PREFETCH_* commands to the SMMU.
>  
> +- cavium,cn9900-broken-page1-regspace
> +                    : Replaces all page 1 offsets used for EVTQ_PROD/CONS,
> +		      PRIQ_PROD/CONS register access with page 0 offsets.
> +		      Set for Caviun ThunderX2 silicon that doesn't support

s/Caviun/Cavium/

Will
