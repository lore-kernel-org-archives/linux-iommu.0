From: Linu Cherian <linu.cherian@cavium.com>
Subject: Re: [PATCH v3 0/7] Cavium ThunderX2 SMMUv3 errata workarounds
Date: Mon, 8 May 2017 20:45:36 +0530
Message-ID: <20170508151536.GA27789@virtx40>
References: <1493986091-30521-1-git-send-email-gakula@caviumnetworks.com>
 <20170505222250.GY16981@rric.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170505222250.GY16981@rric.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Robert Richter <robert.richter@cavium.com>
Cc: Geetha sowjanya <gakula@caviumnetworks.com>, will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, iommu@lists.linux-foundation.org, jcm@redhat.com, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, sgoutham@cavium.com, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, geethasowjanya.akula@gmail.com, Charles.Garcia-Tobin@arm.com
List-Id: iommu@lists.linux-foundation.org

On Sat May 06, 2017 at 12:22:50AM +0200, Robert Richter wrote:
> On 05.05.17 17:38:04, Geetha sowjanya wrote:
> > From: Linu Cherian <linu.cherian@cavium.com>
> > 
> > Cavium ThunderX2 SMMUv3 implementation has two Silicon Erratas.
> > 1. Errata ID #74
> >    SMMU register alias Page 1 is not implemented
> > 2. Errata ID #126
> >    SMMU doesnt support unique IRQ lines and also MSI for gerror, 
> >    eventq and cmdq-sync
> > 
> > The following patchset does software workaround for these two erratas.
> > 
> > This series is based on patchset. 
> > https://www.spinics.net/lists/arm-kernel/msg578443.html
> > 
> > Changes from v1:
> >  Since the use of MIDR register is rejected and SMMU_IIDR is broken on this 
> >  silicon, as suggested by Will Deacon modified the patches to use ThunderX2 
> >  SMMUv3 IORT model number to enable errata workaround.
> > 
> > Changes from v2:
> >  Updated "Documentation/devicetree/bindings/iommu/arm,smmu-v3.txt" document with 
> >  new SMMU option used to enable errata workaround.
> >  
> > Geetha Sowjanya (1):
> >   iommu/arm-smmu-v3: Add workaround for Cavium ThunderX2 erratum #126
> > 
> > Linu Cherian (6):
> >   iommu/arm-smmu-v3: Introduce smmu option PAGE0_REGS_ONLY for ThunderX2
> >     errata#74.
> >   iommu/arm-smmu-v3: Do resource size checks based on SMMU option
> >     PAGE0_REGS_ONLY
> >   ACPICA: IORT: Add Cavium ThunderX2 SMMUv3 model definition.
> >   iommu/arm-smmu-v3: For ACPI based device probing, set PAGE0_REGS_ONLY
> >     option     for ThunderX2 SMMUv3 implementations.
> >   ACPI/IORT: Fixup SMMUv3 resource size for Cavium ThunderX2 SMMUv3
> >     model
> >   arm64: Documentation: Add Cavium ThunderX2 SMMUv3 erratas
> 
> This split into patches does not look reasonable to me. 1 patch only
> for each workaround should be sufficient.
> 

* Should we not atleast keep the changes in drivers/acpi/iort.c and
 include/acpi/actbl2.h seperate, since they are outside smmuv3 driver ? 

* Probably i can merge the below patches, 
  1. iommu/arm-smmu-v3: Introduce smmu option PAGE0_REGS_ONLY for ThunderX2 
    errata#74.
  2. iommu/arm-smmu-v3: Do resource size checks based on SMMU option
     PAGE0_REGS_O

Is that fine ?

Thanks.
-- 
Linu cherian
