From: Robert Richter <robert.richter@cavium.com>
Subject: Re: [PATCH v3 1/7] iommu/arm-smmu-v3: Introduce SMMU option
 PAGE0_REGS_ONLY for ThunderX2 errata #74
Date: Sat, 6 May 2017 00:26:45 +0200
Message-ID: <20170505222645.GZ16981@rric.localdomain>
References: <1493986091-30521-1-git-send-email-gakula@caviumnetworks.com>
 <1493986091-30521-2-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493986091-30521-2-git-send-email-gakula@caviumnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Geetha sowjanya <gakula@caviumnetworks.com>
Cc: will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, iommu@lists.linux-foundation.org, jcm@redhat.com, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, geethasowjanya.akula@gmail.com, linu.cherian@cavium.com, Charles.Garcia-Tobin@arm.com, Geetha Sowjanya <geethasowjanya.akula@cavium.com>
List-Id: iommu@lists.linux-foundation.org

On 05.05.17 17:38:05, Geetha sowjanya wrote:
> From: Linu Cherian <linu.cherian@cavium.com>
> 
> Cavium ThunderX2 SMMU implementation doesn't support page 1 register space
> and PAGE0_REGS_ONLY option will be enabled as an errata workaround.
> 
> This option when turned on, replaces all page 1 offsets used for
> EVTQ_PROD/CONS, PRIQ_PROD/CONS register access with page 0 offsets.
> 
> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
> Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
> ---
>  .../devicetree/bindings/iommu/arm,smmu-v3.txt      |  6 +++
>  drivers/iommu/arm-smmu-v3.c                        | 44 ++++++++++++++++------
>  2 files changed, 38 insertions(+), 12 deletions(-)

> @@ -412,6 +412,9 @@
>  #define MSI_IOVA_BASE			0x8000000
>  #define MSI_IOVA_LENGTH			0x100000
>  
> +#define ARM_SMMU_PAGE0_REGS_ONLY(smmu)		\
> +	((smmu)->options & ARM_SMMU_OPT_PAGE0_REGS_ONLY)

Why hide the check behind this macro? Maybe make
ARM_SMMU_OPT_PAGE0_REGS_ONLY shorter a bit instead?

-Robert
