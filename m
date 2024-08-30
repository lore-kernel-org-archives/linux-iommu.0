Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B278E1B253B
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725032990; cv=none; b=l6bXTjWFhkecRWXdA/Fpu0MCX9YkELfhv4RM0HbyxLh4/DWkiSNjS1CN9gQvcOcG9T57cg34q0M+JCT4rRfqg234Nzf/CC/3Lpfu0IQcP0ftcSDHoMQD9Enp/UnS6/wxyLiwLZ1OJ1h2hLLagS8zanfYFU9C/Jhc2UiGjWyxDZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725032990; c=relaxed/simple;
	bh=sCuP9k2SvnU6BxO72VXBd/pgd8sCAH51nempaZ5KRyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+DkSR2H56SCHi9G3APf+tQFrX8gJnGORHrrobJvryXNOeInt6D42CADs9PUeYjq1YriXrYe2hjavB4LF7wBWNQHhLETx8Usd6+28/Dhex3HeZEF/HSA2+HIET+n2VWS83+67zWfFgxtooT4QpP05qheSrxXb4NNyyIDUhF17fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26BE71063;
	Fri, 30 Aug 2024 08:50:11 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 378F83F762;
	Fri, 30 Aug 2024 08:49:42 -0700 (PDT)
Message-ID: <f330e50c-677a-4982-8ede-dd1e35cc3954@arm.com>
Date: Fri, 30 Aug 2024 16:49:40 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/7] iommu/riscv: Add RISC-V IOMMU PCIe device driver
To: Tomasz Jeznach <tjeznach@rivosinc.com>, Jim Shu <jim.shu@sifive.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Anup Patel <apatel@ventanamicro.com>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 linux@rivosinc.com, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Sebastien Boeuf <seb@rivosinc.com>,
 iommu@lists.linux.dev, Palmer Dabbelt <palmer@dabbelt.com>,
 Nick Kossifidis <mick@ics.forth.gr>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org,
 Lu Baolu <baolu.lu@linux.intel.com>, Zong Li <zong.li@sifive.com>
References: <cover.1718388908.git.tjeznach@rivosinc.com>
 <e2792d6559f9f3e02b2243538647ef60f14176fd.1718388909.git.tjeznach@rivosinc.com>
 <CALw707q=B4h4CF3CvJOiRMMYqzvO_NG+taMLzZquCP=A9bgu0g@mail.gmail.com>
 <CAH2o1u5qU8y=FHRANQ74WnGfMim24Pho2av17rE5ZObZywjB4g@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <CAH2o1u5qU8y=FHRANQ74WnGfMim24Pho2av17rE5ZObZywjB4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/08/2024 4:37 pm, Tomasz Jeznach wrote:
> On Fri, Aug 30, 2024 at 12:04 AM Jim Shu <jim.shu@sifive.com> wrote:
>>
>> Hi Tomasz,
>>
>> QEMU RISC-V IOMMU will switch the PCIe vendor/device ID to Red Hat one
>> [1] in the latest v6 patch.
>> Will we also support the PCIe ID of Red Hat one in the Linux driver?
>>
> 
> Absolutely yes. I've been holding of with adding Red Hat PID/VID to
> limit number of changes outside iommu subsystem in this patch series,
> planing to sent single change adding new PCI IDs once this series is
> accepted.

It shouldn't entail any changes outside this code - per pci_ids.h, 
PCI_VENDOR_ID_REDHAT is already defined, while the individual IOMMU 
device IDs *should* stay local to this driver as the only user of them. 
Similarly, the Rivos vendor ID would only warrant factoring out once 
another driver turns up wanting to share it.

Thanks,
Robin.

> Driver implementation is generic and should correctly
> interact with QEMU model and other hardware implementations of RISC-V
> IOMMU specification.
> 
> Best regards,
>   - Tomasz
> 
>> [1] https://patchew.org/QEMU/20240801154334.1009852-1-dbarboza@ventanamicro.com/20240801154334.1009852-5-dbarboza@ventanamicro.com/
>>
>>
>> Regards,
>> Jim Shu
>>
>>
>>
>> On Sat, Jun 15, 2024 at 1:29 PM Tomasz Jeznach <tjeznach@rivosinc.com> wrote:
>>>
>>> Introduce device driver for PCIe implementation
>>> of RISC-V IOMMU architected hardware.
>>>
>>> IOMMU hardware and system support for MSI or MSI-X is
>>> required by this implementation.
>>>
>>> Vendor and device identifiers used in this patch
>>> matches QEMU implementation of the RISC-V IOMMU PCIe
>>> device, from Rivos VID (0x1efd) range allocated by the PCI-SIG.
>>>
>>> MAINTAINERS | added iommu-pci.c already covered by matching pattern.
>>>
>>> Link: https://lore.kernel.org/qemu-devel/20240307160319.675044-1-dbarboza@ventanamicro.com/
>>> Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
>>> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
>>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
>>> ---
>>>   drivers/iommu/riscv/Kconfig     |   5 ++
>>>   drivers/iommu/riscv/Makefile    |   1 +
>>>   drivers/iommu/riscv/iommu-pci.c | 119 ++++++++++++++++++++++++++++++++
>>>   3 files changed, 125 insertions(+)
>>>   create mode 100644 drivers/iommu/riscv/iommu-pci.c
>>>
>>> diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
>>> index 5dcc5c45aa50..c071816f59a6 100644
>>> --- a/drivers/iommu/riscv/Kconfig
>>> +++ b/drivers/iommu/riscv/Kconfig
>>> @@ -13,3 +13,8 @@ config RISCV_IOMMU
>>>
>>>            Say Y here if your SoC includes an IOMMU device implementing
>>>            the RISC-V IOMMU architecture.
>>> +
>>> +config RISCV_IOMMU_PCI
>>> +       def_bool y if RISCV_IOMMU && PCI_MSI
>>> +       help
>>> +         Support for the PCIe implementation of RISC-V IOMMU architecture.
>>> diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
>>> index e4c189de58d3..f54c9ed17d41 100644
>>> --- a/drivers/iommu/riscv/Makefile
>>> +++ b/drivers/iommu/riscv/Makefile
>>> @@ -1,2 +1,3 @@
>>>   # SPDX-License-Identifier: GPL-2.0-only
>>>   obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-platform.o
>>> +obj-$(CONFIG_RISCV_IOMMU_PCI) += iommu-pci.o
>>> diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pci.c
>>> new file mode 100644
>>> index 000000000000..e675acceb290
>>> --- /dev/null
>>> +++ b/drivers/iommu/riscv/iommu-pci.c
>>> @@ -0,0 +1,119 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +
>>> +/*
>>> + * Copyright © 2022-2024 Rivos Inc.
>>> + * Copyright © 2023 FORTH-ICS/CARV
>>> + *
>>> + * RISCV IOMMU as a PCIe device
>>> + *
>>> + * Authors
>>> + *     Tomasz Jeznach <tjeznach@rivosinc.com>
>>> + *     Nick Kossifidis <mick@ics.forth.gr>
>>> + */
>>> +
>>> +#include <linux/compiler.h>
>>> +#include <linux/init.h>
>>> +#include <linux/iommu.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/pci.h>
>>> +
>>> +#include "iommu-bits.h"
>>> +#include "iommu.h"
>>> +
>>> +/* Rivos Inc. assigned PCI Vendor and Device IDs */
>>> +#ifndef PCI_VENDOR_ID_RIVOS
>>> +#define PCI_VENDOR_ID_RIVOS             0x1efd
>>> +#endif
>>> +
>>> +#ifndef PCI_DEVICE_ID_RIVOS_IOMMU
>>> +#define PCI_DEVICE_ID_RIVOS_IOMMU       0xedf1
>>> +#endif
>>> +
>>> +static int riscv_iommu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>> +{
>>> +       struct device *dev = &pdev->dev;
>>> +       struct riscv_iommu_device *iommu;
>>> +       int rc, vec;
>>> +
>>> +       rc = pcim_enable_device(pdev);
>>> +       if (rc)
>>> +               return rc;
>>> +
>>> +       if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM))
>>> +               return -ENODEV;
>>> +
>>> +       if (pci_resource_len(pdev, 0) < RISCV_IOMMU_REG_SIZE)
>>> +               return -ENODEV;
>>> +
>>> +       rc = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
>>> +       if (rc)
>>> +               return dev_err_probe(dev, rc, "pcim_iomap_regions failed\n");
>>> +
>>> +       iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
>>> +       if (!iommu)
>>> +               return -ENOMEM;
>>> +
>>> +       iommu->dev = dev;
>>> +       iommu->reg = pcim_iomap_table(pdev)[0];
>>> +
>>> +       pci_set_master(pdev);
>>> +       dev_set_drvdata(dev, iommu);
>>> +
>>> +       /* Check device reported capabilities / features. */
>>> +       iommu->caps = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAPABILITIES);
>>> +       iommu->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
>>> +
>>> +       /* The PCI driver only uses MSIs, make sure the IOMMU supports this */
>>> +       switch (FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps)) {
>>> +       case RISCV_IOMMU_CAPABILITIES_IGS_MSI:
>>> +       case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
>>> +               break;
>>> +       default:
>>> +               return dev_err_probe(dev, -ENODEV,
>>> +                                    "unable to use message-signaled interrupts\n");
>>> +       }
>>> +
>>> +       /* Allocate and assign IRQ vectors for the various events */
>>> +       rc = pci_alloc_irq_vectors(pdev, 1, RISCV_IOMMU_INTR_COUNT,
>>> +                                  PCI_IRQ_MSIX | PCI_IRQ_MSI);
>>> +       if (rc <= 0)
>>> +               return dev_err_probe(dev, -ENODEV,
>>> +                                    "unable to allocate irq vectors\n");
>>> +
>>> +       iommu->irqs_count = rc;
>>> +       for (vec = 0; vec < iommu->irqs_count; vec++)
>>> +               iommu->irqs[vec] = msi_get_virq(dev, vec);
>>> +
>>> +       /* Enable message-signaled interrupts, fctl.WSI */
>>> +       if (iommu->fctl & RISCV_IOMMU_FCTL_WSI) {
>>> +               iommu->fctl ^= RISCV_IOMMU_FCTL_WSI;
>>> +               riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
>>> +       }
>>> +
>>> +       return riscv_iommu_init(iommu);
>>> +}
>>> +
>>> +static void riscv_iommu_pci_remove(struct pci_dev *pdev)
>>> +{
>>> +       struct riscv_iommu_device *iommu = dev_get_drvdata(&pdev->dev);
>>> +
>>> +       riscv_iommu_remove(iommu);
>>> +}
>>> +
>>> +static const struct pci_device_id riscv_iommu_pci_tbl[] = {
>>> +       {PCI_VENDOR_ID_RIVOS, PCI_DEVICE_ID_RIVOS_IOMMU,
>>> +        PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
>>> +       {0,}
>>> +};
>>> +
>>> +static struct pci_driver riscv_iommu_pci_driver = {
>>> +       .name = KBUILD_MODNAME,
>>> +       .id_table = riscv_iommu_pci_tbl,
>>> +       .probe = riscv_iommu_pci_probe,
>>> +       .remove = riscv_iommu_pci_remove,
>>> +       .driver = {
>>> +               .suppress_bind_attrs = true,
>>> +       },
>>> +};
>>> +
>>> +builtin_pci_driver(riscv_iommu_pci_driver);
>>> --
>>> 2.34.1
>>>
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
