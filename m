From: Yisheng Xie <xieyisheng1@huawei.com>
Subject: Re: [RFCv2 PATCH 00/36] Process management for IOMMU + SVM for SMMUv3
Date: Mon, 9 Oct 2017 17:49:52 +0800
Message-ID: <0c6778d8-741f-0db7-fe3c-df88a75ebbb2@huawei.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, robin.murphy@arm.com, bhelgaas@google.com, alex.williamson@redhat.com, tn@semihalf.com, liubo95@huawei.com, thunder.leizhen@huawei.com, gabriele.paoloni@huawei.com, nwatters@codeaurora.org, okaya@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org, jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com, ashok.raj@intel.com, robdclark@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hi Jean,

On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
> Following discussions at plumbers and elsewhere, it seems like we need to
> unify some of the Shared Virtual Memory (SVM) code, in order to define
> clear semantics for the SVM API.
> 
> My previous RFC [1] was centered on the SMMUv3, but some of this code will
> need to be reused by the SMMUv2 and virtio-iommu drivers. This second
> proposal focuses on abstracting a little more into the core IOMMU API, and
> also trying to find common ground for all SVM-capable IOMMUs.
> 
> SVM is, in the context of the IOMMU, sharing page tables between a process
> and a device. Traditionally it requires IO Page Fault and Process Address
> Space ID capabilities in device and IOMMU.
> 
> * A device driver can bind a process to a device, with iommu_process_bind.
>   Internally we hold on to the mm and get notified of its activity with an
>   mmu_notifier. The bond is removed by exit_mm, by a call to
>   iommu_process_unbind or iommu_detach_device.
> 
> * iommu_process_bind returns a 20-bit PASID (PCI terminology) to the
>   device driver, which programs it into the device to access the process
>   address space.
> 
> * The device and the IOMMU support recoverable page faults. This can be
>   either ATS+PRI for PCI, or platform-specific mechanisms such as Stall
>   for SMMU.
> 
> Ideally systems wanting to use SVM have to support these three features,
> but in practice we'll see implementations supporting just a subset of
> them, especially in validation environments. So even if this particular
> patchset assumes all three capabilities, it should also be possible to
> support PASID without IOPF (by pinning everything, see non-system SVM in
> OpenCL)
How to pin everything? If user malloc anything we should pin it. It should
from user or driver?

> , or IOPF without PASID (sharing the single device address space
> with a process, could be useful for DPDK+VFIO).
> 
> Implementing both these cases would enable PT sharing alone. Some people
> would also like IOPF alone without SVM (covered by this series) or process
> management without shared PT (not covered). Using these features
> individually is also important for testing, as SVM is in its infancy and
> providing easy ways to test is essential to reduce the number of quirks
> down the line.
> 
>   Process management
>   ==================
> 
> The first part of this series introduces boilerplate code for managing
> PASIDs and processes bound to devices. It's something any IOMMU driver
> that wants to support bind/unbind will have to do, and it is difficult to
> get right.
> 
> Patches
> 1: iommu_process and PASID allocation, attach and release
> 2: process_exit callback for device drivers
> 3: iommu_process search by PASID
> 4: track process changes with an MMU notifiers
> 5: bind and unbind operations
> 
> My proposal uses the following model:
> 
> * The PASID space is system-wide. This means that a Linux process will
>   have a single PASID. I introduce the iommu_process structure and a
>   global IDR to manage this.
> 
> * An iommu_process can be bound to multiple domains, and a domain can have
>   multiple iommu_process.
when bind a task to device, can we create a single domain for it? I am thinking
about process management without shared PT(for some device only support PASID
without pri ability), it seems hard to expand if a domain have multiple iommu_process?
Do you have any idea about this?

> 
> * IOMMU groups share same PASID table. IOMMU groups are a convenient way
>   to cover various hardware weaknesses that prevent a group of device to
>   be isolated by the IOMMU (untrusted bridge, for instance). It's foolish
>   to assume that all PASID implementations will perfectly isolate devices
>   within a bus and functions within a device, so let's assume all devices
>   within an IOMMU group have to share PASID traffic as well. In general
>   there will be a single device per group.
> 
> * It's up to the driver implementation to decide where to implement the
>   PASID tables. For SMMU it's more convenient to have a single PASID table
>   per domain. And I think the model fits better with the existing IOMMU
>   API: IOVA traffic is shared by all devices in a domain, so should PASID
>   traffic.
What's the meaning of "share PASID traffic"? PASID space is system-wide,
and a domain can have multiple iommu_process , so a domain can have multiple
PASIDs , one PASID for a iommu_process, right?

Yisheng Xie
Thanks


