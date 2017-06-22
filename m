From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v9 0/3] Cavium ThunderX2 SMMUv3 errata workarounds
Date: Thu, 22 Jun 2017 19:58:22 +0100
Message-ID: <20170622185822.GK15336@arm.com>
References: <1498133138-20244-1-git-send-email-gakula@caviumnetworks.com>
 <20170622182257.GI15336@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170622182257.GI15336@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Geetha sowjanya <gakula@caviumnetworks.com>
Cc: robin.murphy@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, iommu@lists.linux-foundation.org, robert.moore@intel.com, lv.zheng@intel.com, rjw@rjwysocki.net, jcm@redhat.com, linux-kernel@vger.kernel.org, robert.richter@cavium.com, catalin.marinas@arm.com, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, geethasowjanya.akula@gmail.com, devel@acpica.org, linu.cherian@cavium.com, Charles.Garcia-Tobin@arm.com, robh@kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 22, 2017 at 07:22:57PM +0100, Will Deacon wrote:
> On Thu, Jun 22, 2017 at 05:35:35PM +0530, Geetha sowjanya wrote:
> > Cavium ThunderX2 SMMUv3 implementation has two Silicon Erratas.
> > 1. Errata ID #74
> >    SMMU register alias Page 1 is not implemented
> > 2. Errata ID #126
> >    SMMU doesnt support unique IRQ lines and also MSI for gerror,
> >    eventq and cmdq-sync
> > 
> > The following patchset does software workaround for these two erratas.
> 
> I've picked up the first two patches, and left comments on the final patch.

... except that it doesn't build:


drivers/acpi/arm64/iort.c: In function ‘arm_smmu_v3_resource_size’:
drivers/acpi/arm64/iort.c:837:21: error: ‘ACPI_IORT_SMMU_V3_CAVIUM_CN99XX’ undeclared (first use in this function)
  if (smmu->model == ACPI_IORT_SMMU_V3_CAVIUM_CN99XX)
                     ^
drivers/acpi/arm64/iort.c:837:21: note: each undeclared identifier is reported only once for each function it appears in
make[4]: *** [drivers/acpi/arm64/iort.o] Error 1


I don't see ACPI_IORT_SMMU_V3_CAVIUM_CN99XX defined, even in linux-next.

What's the plan here?

Will
