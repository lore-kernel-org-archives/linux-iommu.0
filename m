From: lantianyu1986@gmail.com
Subject: [PATCH V4 0/3] x86/Hyper-V/IOMMU: Add Hyper-V IOMMU driver to support x2apic mode
Date: Mon, 11 Feb 2019 22:20:21 +0800
Message-ID: <1549894824-26623-1-git-send-email-Tianyu.Lan@microsoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Lan Tianyu <Tianyu.Lan@microsoft.com>, arnd@arndb.de, bp@alien8.de, davem@davemloft.net, devel@linuxdriverproject.org, gregkh@linuxfoundation.org, haiyangz@microsoft.com, hpa@zytor.com, iommu@lists.linux-foundation.org, joro@8bytes.org, kys@microsoft.com, linux-kernel@vger.kernel.org, mchehab+samsung@kernel.org, mingo@redhat.com, nicolas.ferre@microchip.com, sashal@kernel.org, sthemmin@microsoft.com, tglx@linutronix.de, x86@kernel.org, michael.h.kelley@microsoft.com, vkuznets@redhat.com, alex.williamson@redhat.com, dan.carpenter@oracle.com
List-Id: iommu@lists.linux-foundation.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

On the bare metal, enabling X2APIC mode requires interrupt remapping
function which helps to deliver irq to cpu with 32-bit APIC ID.
Hyper-V doesn't provide interrupt remapping function so far and Hyper-V
MSI protocol already supports to deliver interrupt to the CPU whose
virtual processor index is more than 255. IO-APIC interrupt still has
8-bit APIC ID limitation.

This patchset is to add Hyper-V stub IOMMU driver in order to enable
X2APIC mode successfully in Hyper-V Linux guest. The driver returns X2APIC
interrupt remapping capability when X2APIC mode is available. X2APIC
destination mode is set to physical by PATCH 1 when X2APIC is available.
Hyper-V IOMMU driver will scan cpu 0~255 and set cpu into IO-APIC MAX cpu
affinity cpumask if its APIC ID is 8-bit. Driver creates a Hyper-V irq domain
to limit IO-APIC interrupts' affinity and make sure cpus assigned with IO-APIC
interrupt are in the scope of IO-APIC MAX cpu affinity.

Lan Tianyu (3):
  x86/Hyper-V: Set x2apic destination mode to physical when x2apic is   
     available
  HYPERV/IOMMU: Add Hyper-V stub IOMMU driver
  MAINTAINERS: Add Hyper-V IOMMU driver into Hyper-V CORE AND DRIVERS
    scope

 MAINTAINERS                    |   1 +
 arch/x86/kernel/cpu/mshyperv.c |  10 +++
 drivers/iommu/Kconfig          |   9 ++
 drivers/iommu/Makefile         |   1 +
 drivers/iommu/hyperv-iommu.c   | 194 +++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/irq_remapping.c  |   3 +
 drivers/iommu/irq_remapping.h  |   1 +
 7 files changed, 219 insertions(+)
 create mode 100644 drivers/iommu/hyperv-iommu.c

-- 
2.7.4
