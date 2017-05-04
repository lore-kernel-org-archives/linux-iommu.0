From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/7] iommu/arm-smmu-v3: Introduce SMMU option
 PAGE0_REGS_ONLY
Date: Thu, 4 May 2017 17:32:33 +0100
Message-ID: <20170504163233.GH20461@leverpostej>
References: <1493901339-14929-1-git-send-email-gakula@caviumnetworks.com>
 <1493901339-14929-2-git-send-email-gakula@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493901339-14929-2-git-send-email-gakula@caviumnetworks.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Geetha sowjanya <gakula@caviumnetworks.com>
Cc: will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, iommu@lists.linux-foundation.org, Geetha Sowjanya <geethasowjanya.akula@cavium.com>, jcm@redhat.com, linu.cherian@cavium.com, linux-kernel@vger.kernel.org, geethasowjanya.akula@gmail.com, linux-acpi@vger.kernel.org, robert.richter@cavium.com, catalin.marinas@arm.com, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org, Charles.Garcia-Tobin@arm.com
List-Id: iommu@lists.linux-foundation.org

On Thu, May 04, 2017 at 06:05:33PM +0530, Geetha sowjanya wrote:
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
>  drivers/iommu/arm-smmu-v3.c | 44 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 12 deletions(-)

>  static struct arm_smmu_option_prop arm_smmu_options[] = {

> +	{ ARM_SMMU_OPT_PAGE0_REGS_ONLY, "cavium-cn99xx,broken-page1-regspace"},

No patch in this series documented the new property.

Please update Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt,
with a description of the property. i.e. what it describes, and when it
should be set.

Please either make that a prepatory path, or merge it in with this one.

Thanksm
Mark.
