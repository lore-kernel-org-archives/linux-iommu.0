Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3284356440
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 12:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725019273; cv=none; b=L68FaRsVAeWc+zt9wRmdyA+ZsYI3EyAYDX2XgNo2DD8qbtNONOIrYULdLrWQDcUfR7kYIV8GVRK+NDeR8KgPtl0agtwTjX02s4Whxs4n+fNmpakB+nCArfA1Osxo4KGf80Zxm/wu7Oxg5adsEA/VateHhzB8gjUoMcv46Z1S6YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725019273; c=relaxed/simple;
	bh=bHtLDn0Wsn5DAZMI5MFUbrKX2XmlMvWqakZmLM6IBYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=agWbZ0l0vfhoL2eEMR4/x0NJlRJYC6Mtm6RHSaxI2vzbgquEFyPuBI8Tv8xFVQHa0B/eZyuvN6jRtqPE27IMt97VThJ2szPlHmW801BGgs3xhxdqsgIofJkkEw6aVYQrSEumi/Xqd9KtzSu2IKzOzUBu1raBh2MxO7QIGgLbWnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=eGF1LJWY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="eGF1LJWY"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71433096e89so1425086b3a.3
        for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 05:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1725019271; x=1725624071; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S+J8nDWKmcjiFDnbhyvi48+lL6iNF2GBrnR+36Q3WWM=;
        b=eGF1LJWYTGX+XAfdX0iKzKrSoT/BB2kopiFvTXHp/gGgkABUv2FxvE1YarO7naiR0/
         9R5SHroJQpE+HSnCnW8o+rCgjbiaKCj9cFMDz4jMJl+OrJSEwwNhP3zN7KRIvDR9UC5S
         PN++kXhDM+zPctC1BOqFTbsgqANuQpsZ5WHgof4PIqEgH0twMX7rH5Oh/sNFHBB+4M7V
         FjedmKnZgnVqRnFxR7WTK5yCTBOtEV8toBfbPfeEJhWXNwbJBofVZdzVZY0GB7xyBgxV
         7jt40CLjxxJiO/pjpZv1wgLRGBhSVi9UTSBBtNIYgqjxA4gy9JXYQPMtBoIwRpVDJ6lF
         kRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725019271; x=1725624071;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+J8nDWKmcjiFDnbhyvi48+lL6iNF2GBrnR+36Q3WWM=;
        b=QrOQC9FyUIUgCysWo3mx0qP5RkQzcifGacZ1zpnycpdqtPhWKQQzx0Nls2TZOepx0Y
         5iog9NkIrbOtppEWDQFOFoFBuB0m1nvAeIUTIFG+lBP82Co/9ZjY6/oITlB1x7IjnlKV
         7xI4XmQXO+AiEkJtxblK+x3ddQjilQMmLFJANgf6dgXpFPgqKId1D0iS6IsZ8n5QDswB
         yI7kI+YiSpa64KMJfnAqoT9wuXv91zFFWkjGeiC9XgTi/mdiqzUC/pA5Sgnvk59sh5Fk
         i0305evrWbYJjLn1PtyeczyrOJ6C0OvI94ZoUatWz4yRQeM4zsk/Ehjik2PogvqgStKW
         dqkg==
X-Forwarded-Encrypted: i=1; AJvYcCX0sakGIRok/O6yvXkmQLW/NqjmP8IyXdRGHWI5sAzs9Wz0zn+dSBxLR/m5XZf84nIfpW3jQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxLMsI1h2y6hMGMf7k5bG230lyAVcpW9epA2oUA7BwZpzKk6PsS
	oImZWtizpPdgr1KOT/tbDq4y4RlBu2NdU01+MGE8oHpIrFkdFuW2dEzd/ILSDDM=
X-Google-Smtp-Source: AGHT+IGKLvAFAz/eBLXMb30uIZ9vdANBzSIr6ORPbKAbI0x7ooOqoOsCu8d84XfIMHbv7krKGeaTpw==
X-Received: by 2002:a05:6a00:981:b0:706:58ef:613 with SMTP id d2e1a72fcca58-715dfc72cfdmr7188548b3a.27.1725019269804;
        Fri, 30 Aug 2024 05:01:09 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.227.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e569ef15sm2599685b3a.105.2024.08.30.05.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Aug 2024 05:01:09 -0700 (PDT)
Message-ID: <3fdb33d3-16cd-49a6-bad7-81631f99c291@ventanamicro.com>
Date: Fri, 30 Aug 2024 09:01:02 -0300
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/7] iommu/riscv: Add RISC-V IOMMU PCIe device driver
To: Jim Shu <jim.shu@sifive.com>, Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Anup Patel <apatel@ventanamicro.com>,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, linux@rivosinc.com,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Sebastien Boeuf <seb@rivosinc.com>, iommu@lists.linux.dev,
 Palmer Dabbelt <palmer@dabbelt.com>, Nick Kossifidis <mick@ics.forth.gr>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-riscv@lists.infradead.org,
 Lu Baolu <baolu.lu@linux.intel.com>, Zong Li <zong.li@sifive.com>
References: <cover.1718388908.git.tjeznach@rivosinc.com>
 <e2792d6559f9f3e02b2243538647ef60f14176fd.1718388909.git.tjeznach@rivosinc.com>
 <CALw707q=B4h4CF3CvJOiRMMYqzvO_NG+taMLzZquCP=A9bgu0g@mail.gmail.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <CALw707q=B4h4CF3CvJOiRMMYqzvO_NG+taMLzZquCP=A9bgu0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/30/24 4:04 AM, Jim Shu wrote:
> Hi Tomasz,
> 
> QEMU RISC-V IOMMU will switch the PCIe vendor/device ID to Red Hat one
> [1] in the latest v6 patch.
> Will we also support the PCIe ID of Red Hat one in the Linux driver?
> 
> [1] https://patchew.org/QEMU/20240801154334.1009852-1-dbarboza@ventanamicro.com/20240801154334.1009852-5-dbarboza@ventanamicro.com/

The QEMU-side background of this change: the original patches from Tomasz was
hardcoding a Rivos PCI ID, i.e. the device was being registered as a Rivos IOMMU
PCI device. The thing is that there isn't anything  Rivos specific in the QEMU
IOMMU emulation, since we're adhering to the riscv-iommu spec entirely (with a
couple of design choices here and there), thus we decided it would be better to
get a generic PCI IOMMU ID.

Red Hat was kind enough to gave us one from their PCI ID space, since RVI didn't
bother getting an ID for this reference device, and we're using the Red Hat ID
in the QEMU emulation. The QEMU IOMMU PCI device is by default reported as
1b36:0014 (PCI_VENDOR_ID_REDHAT : PCI_DEVICE_ID_REDHAT_RISCV_IOMMU).

This change happened in v3, sent in May 2024:

https://lore.kernel.org/qemu-riscv/20240523173955.1940072-1-dbarboza@ventanamicro.com/

This change would make the QEMU IOMMU PCI device incompatible with this kernel
support, so we added a capability to set the PCI ID for the device in the QEMU
command line. To make the IOMMU PCI device work with the current kernel support, that
is being set to a Rivos PCI device, change the vendor/device ID to match what the
kernel driver expects:

(...)  -device riscv-iommu-pci,vendor-id=0x1efd,device-id=0xedf1

The ability to set vendor-id/device-id of this device will allow an easier development
of other proprietary IOMMU PCI drivers, i.e. it's not a hack to make the current kernel
support work.

As for this kernel support, I didn't fully review it to see if there is a Rivos specific
behavior being implemented. If this isn't the case perhaps there is a case to be made
to also make the kernel driver more generic - in this case feel free to use the same as
QEMU is going to use (PCI_VENDOR_ID_REDHAT : PCI_DEVICE_ID_REDHAT_RISCV_IOMMU - 1b36:0014).


Thanks,

Daniel


> 
> 
> Regards,
> Jim Shu
> 
> 
> 
> On Sat, Jun 15, 2024 at 1:29 PM Tomasz Jeznach <tjeznach@rivosinc.com> wrote:
>>
>> Introduce device driver for PCIe implementation
>> of RISC-V IOMMU architected hardware.
>>
>> IOMMU hardware and system support for MSI or MSI-X is
>> required by this implementation.
>>
>> Vendor and device identifiers used in this patch
>> matches QEMU implementation of the RISC-V IOMMU PCIe
>> device, from Rivos VID (0x1efd) range allocated by the PCI-SIG.
>>
>> MAINTAINERS | added iommu-pci.c already covered by matching pattern.
>>
>> Link: https://lore.kernel.org/qemu-devel/20240307160319.675044-1-dbarboza@ventanamicro.com/
>> Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
>> Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
>> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
>> ---
>>   drivers/iommu/riscv/Kconfig     |   5 ++
>>   drivers/iommu/riscv/Makefile    |   1 +
>>   drivers/iommu/riscv/iommu-pci.c | 119 ++++++++++++++++++++++++++++++++
>>   3 files changed, 125 insertions(+)
>>   create mode 100644 drivers/iommu/riscv/iommu-pci.c
>>
>> diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
>> index 5dcc5c45aa50..c071816f59a6 100644
>> --- a/drivers/iommu/riscv/Kconfig
>> +++ b/drivers/iommu/riscv/Kconfig
>> @@ -13,3 +13,8 @@ config RISCV_IOMMU
>>
>>            Say Y here if your SoC includes an IOMMU device implementing
>>            the RISC-V IOMMU architecture.
>> +
>> +config RISCV_IOMMU_PCI
>> +       def_bool y if RISCV_IOMMU && PCI_MSI
>> +       help
>> +         Support for the PCIe implementation of RISC-V IOMMU architecture.
>> diff --git a/drivers/iommu/riscv/Makefile b/drivers/iommu/riscv/Makefile
>> index e4c189de58d3..f54c9ed17d41 100644
>> --- a/drivers/iommu/riscv/Makefile
>> +++ b/drivers/iommu/riscv/Makefile
>> @@ -1,2 +1,3 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   obj-$(CONFIG_RISCV_IOMMU) += iommu.o iommu-platform.o
>> +obj-$(CONFIG_RISCV_IOMMU_PCI) += iommu-pci.o
>> diff --git a/drivers/iommu/riscv/iommu-pci.c b/drivers/iommu/riscv/iommu-pci.c
>> new file mode 100644
>> index 000000000000..e675acceb290
>> --- /dev/null
>> +++ b/drivers/iommu/riscv/iommu-pci.c
>> @@ -0,0 +1,119 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +
>> +/*
>> + * Copyright © 2022-2024 Rivos Inc.
>> + * Copyright © 2023 FORTH-ICS/CARV
>> + *
>> + * RISCV IOMMU as a PCIe device
>> + *
>> + * Authors
>> + *     Tomasz Jeznach <tjeznach@rivosinc.com>
>> + *     Nick Kossifidis <mick@ics.forth.gr>
>> + */
>> +
>> +#include <linux/compiler.h>
>> +#include <linux/init.h>
>> +#include <linux/iommu.h>
>> +#include <linux/kernel.h>
>> +#include <linux/pci.h>
>> +
>> +#include "iommu-bits.h"
>> +#include "iommu.h"
>> +
>> +/* Rivos Inc. assigned PCI Vendor and Device IDs */
>> +#ifndef PCI_VENDOR_ID_RIVOS
>> +#define PCI_VENDOR_ID_RIVOS             0x1efd
>> +#endif
>> +
>> +#ifndef PCI_DEVICE_ID_RIVOS_IOMMU
>> +#define PCI_DEVICE_ID_RIVOS_IOMMU       0xedf1
>> +#endif
>> +
>> +static int riscv_iommu_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>> +{
>> +       struct device *dev = &pdev->dev;
>> +       struct riscv_iommu_device *iommu;
>> +       int rc, vec;
>> +
>> +       rc = pcim_enable_device(pdev);
>> +       if (rc)
>> +               return rc;
>> +
>> +       if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM))
>> +               return -ENODEV;
>> +
>> +       if (pci_resource_len(pdev, 0) < RISCV_IOMMU_REG_SIZE)
>> +               return -ENODEV;
>> +
>> +       rc = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
>> +       if (rc)
>> +               return dev_err_probe(dev, rc, "pcim_iomap_regions failed\n");
>> +
>> +       iommu = devm_kzalloc(dev, sizeof(*iommu), GFP_KERNEL);
>> +       if (!iommu)
>> +               return -ENOMEM;
>> +
>> +       iommu->dev = dev;
>> +       iommu->reg = pcim_iomap_table(pdev)[0];
>> +
>> +       pci_set_master(pdev);
>> +       dev_set_drvdata(dev, iommu);
>> +
>> +       /* Check device reported capabilities / features. */
>> +       iommu->caps = riscv_iommu_readq(iommu, RISCV_IOMMU_REG_CAPABILITIES);
>> +       iommu->fctl = riscv_iommu_readl(iommu, RISCV_IOMMU_REG_FCTL);
>> +
>> +       /* The PCI driver only uses MSIs, make sure the IOMMU supports this */
>> +       switch (FIELD_GET(RISCV_IOMMU_CAPABILITIES_IGS, iommu->caps)) {
>> +       case RISCV_IOMMU_CAPABILITIES_IGS_MSI:
>> +       case RISCV_IOMMU_CAPABILITIES_IGS_BOTH:
>> +               break;
>> +       default:
>> +               return dev_err_probe(dev, -ENODEV,
>> +                                    "unable to use message-signaled interrupts\n");
>> +       }
>> +
>> +       /* Allocate and assign IRQ vectors for the various events */
>> +       rc = pci_alloc_irq_vectors(pdev, 1, RISCV_IOMMU_INTR_COUNT,
>> +                                  PCI_IRQ_MSIX | PCI_IRQ_MSI);
>> +       if (rc <= 0)
>> +               return dev_err_probe(dev, -ENODEV,
>> +                                    "unable to allocate irq vectors\n");
>> +
>> +       iommu->irqs_count = rc;
>> +       for (vec = 0; vec < iommu->irqs_count; vec++)
>> +               iommu->irqs[vec] = msi_get_virq(dev, vec);
>> +
>> +       /* Enable message-signaled interrupts, fctl.WSI */
>> +       if (iommu->fctl & RISCV_IOMMU_FCTL_WSI) {
>> +               iommu->fctl ^= RISCV_IOMMU_FCTL_WSI;
>> +               riscv_iommu_writel(iommu, RISCV_IOMMU_REG_FCTL, iommu->fctl);
>> +       }
>> +
>> +       return riscv_iommu_init(iommu);
>> +}
>> +
>> +static void riscv_iommu_pci_remove(struct pci_dev *pdev)
>> +{
>> +       struct riscv_iommu_device *iommu = dev_get_drvdata(&pdev->dev);
>> +
>> +       riscv_iommu_remove(iommu);
>> +}
>> +
>> +static const struct pci_device_id riscv_iommu_pci_tbl[] = {
>> +       {PCI_VENDOR_ID_RIVOS, PCI_DEVICE_ID_RIVOS_IOMMU,
>> +        PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
>> +       {0,}
>> +};
>> +
>> +static struct pci_driver riscv_iommu_pci_driver = {
>> +       .name = KBUILD_MODNAME,
>> +       .id_table = riscv_iommu_pci_tbl,
>> +       .probe = riscv_iommu_pci_probe,
>> +       .remove = riscv_iommu_pci_remove,
>> +       .driver = {
>> +               .suppress_bind_attrs = true,
>> +       },
>> +};
>> +
>> +builtin_pci_driver(riscv_iommu_pci_driver);
>> --
>> 2.34.1
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
