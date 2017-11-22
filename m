From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [RFCv2 PATCH 01/36] iommu: Keep track of processes and PASIDs
Date: Wed, 22 Nov 2017 13:04:22 +0000
Message-ID: <42f815ee-2a9a-ac49-2392-5c03c1d4c809@arm.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-2-jean-philippe.brucker@arm.com>
 <588ad6f0-e78a-63de-e27a-3da4de4ab2ab@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <588ad6f0-e78a-63de-e27a-3da4de4ab2ab@huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Bob Liu <liubo95@huawei.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc: "joro@8bytes.org" <joro@8bytes.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, Robin Murphy <Robin.Murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "tn@semihalf.com" <tn@semihalf.com>, "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>, "xieyisheng1@huawei.com" <xieyisheng1@huawei.com>, "gabriele.paoloni@huawei.com" <gabriele.paoloni@huawei.com>, nwat
List-Id: iommu@lists.linux-foundation.org

On 22/11/17 03:15, Bob Liu wrote:
> Hey Jean,
> 
> On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
>> IOMMU drivers need a way to bind Linux processes to devices. This is used
>> for Shared Virtual Memory (SVM), where devices support paging. In that
>> mode, DMA can directly target virtual addresses of a process.
>>
>> Introduce boilerplate code for allocating process structures and binding
>> them to devices. Four operations are added to IOMMU drivers:
>>
>> * process_alloc, process_free: to create an iommu_process structure and
>>   perform architecture-specific operations required to grab the process
>>   (for instance on ARM SMMU, pin down the CPU ASID). There is a single
>>   iommu_process structure per Linux process.
>>
> 
> I'm a bit confused here.
> The original meaning of iommu_domain is a virtual addrspace defined by a set of io page table.
> (fix me if I misunderstood).

iommu_domain can also be seen as a logical partition of devices that share
the same address spaces (the concept comes from AMD and Intel IOMMU
domains, I believe). Without PASIDs it was a single address space, with
PASIDs it can have multiple address spaces.

> Then what's the meaning of iommu_domain and iommu_process after introducing iommu_process?
> Could you consider document these concepts? 

iommu_process is used to keep track of Linux process address spaces. I'll
rename it to io_mm in next version, to make it clear that it doesn't
represent a Linux task but an mm_struct instead. However the
implementation stays pretty much identical. A domain can be associated to
multiple io_mm, and an io_mm can be associated to multiple domains.

In the IOMMU architectures I know, PASID is implemented like this. You
have the device tables (stream tables on SMMU), pointing to PASID tables
(context descriptor tables on SMMU). In the following diagram,

                    .->+--------+
                   / 0 |        |------ io_pgtable
                  /    +--------+
                 /   1 |        |------ io_mm->mm X
    +--------+  /      +--------+
  0 |      A |-'     2 |        |-.
    +--------+         +--------+  \
  1 |        |       3 |        |   \
    +--------+         +--------+    -- io_mm->mm Y
  2 |      B |--.     PASID tables  /
    +--------+   \                 |
  3 |      B |----+--->+--------+  |
    +--------+   /   0 |        |- | -- io_pgtable
  4 |      B |--'      +--------+  |
    +--------+       1 |        |  |
  Device tables        +--------+  |
                     2 |        |--'
                       +--------+
                     3 |        |------ io_mm->priv io_pgtable
                       +--------+
                      PASID tables

* Device 0 (e.g. PCI 0000:00:00.0) is in domain A.
* Devices 2, 3 and 4 are in domain B.
* Domain A has the top set of PASID tables.
* Domain B has the bottom set of PASID tables.

* Domain A is bound to process address space X.
  -> Device 0 can access X with PASID 1.
* Both domains A and B are bound to process address space Y.
  -> Devices 0, 2, 3 and 4 can access Y with PASID 2

* PASID 0 is special on Arm SMMU (with S1DSS=0b10). It will always be
  reserved for classic DMA map/unmap. Even for hypothetical devices that
  don't support non-pasid transactions, I'd like to keep this convention.
  It should be quite useful for device drivers to have PASID 0 available
  with DMA map/unmap.

* When introducing "private" PASID address spaces (that many are asking
  for), which are backed by a set of io-pgtable and map/unmap ops, I
  suppose they would reuse the io_mm structure. In this example PASID 3 is
  associated to a private address space and not backed by an mm. Since the
  PASID space is global, PASID 3 won't be available for any other domain.

Does this clarify the current design, or is it just more confusing?

Thanks,
Jean
