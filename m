From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: What differences and relations between SVM, HSA, HMM and Unified
 Memory?
Date: Mon, 12 Jun 2017 12:37:00 +0100
Message-ID: <20c9cdd5-5118-f916-d8ad-70b7c1434d73@arm.com>
References: <9BD73EA91F8E404F851CF3F519B14AA8CE753F@SZXEMI503-MBS.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9BD73EA91F8E404F851CF3F519B14AA8CE753F@SZXEMI503-MBS.china.huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Wuzongyong (Cordius Wu, Euler Dept)" <wuzongyong1@huawei.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "Wanzongshun (Vincent)" <wanzongshun@huawei.com>, "oded.gabbay@amd.com" <oded.gabbay@amd.com>
List-Id: iommu@lists.linux-foundation.org

Hello,

On 10/06/17 05:06, Wuzongyong (Cordius Wu, Euler Dept) wrote:
> Hi,
> 
> Could someone explain differences and relations between the SVM(Shared
> Virtual Memory, by Intel), HSA(Heterogeneous System Architecture, by AMD),
> HMM(Heterogeneous Memory Management, by Glisse) and UM(Unified Memory, by
> NVIDIA) ? Are these in the substitutional relation?
> 
> As I understand it, these aim to solve the same thing, sharing pointers
> between CPU and GPU(implement with ATS/PASID/PRI/IOMMU support). So far,
> SVM and HSA can only be used by integrated gpu. And, Intel declare that
> the root ports doesn’t not have the required TLP prefix support, resulting
>  that SVM can’t be used by discrete devices. So could someone tell me the
> required TLP prefix means what specifically?>
> With HMM, we can use allocator like malloc to manage host and device
> memory. Does this mean that there is no need to use SVM and HSA with HMM,
> or HMM is the basis of SVM and HAS to implement Fine-Grained system SVM
> defined in the opencl spec?

I can't provide an exhaustive answer, but I have done some work on SVM.
Take it with a grain of salt though, I am not an expert.

* HSA is an architecture that provides a common programming model for CPUs
and accelerators (GPGPUs etc). It does have SVM requirement (I/O page
faults, PASID and compatible address spaces), though it's only a small
part of it.

* Similarly, OpenCL provides an API for dealing with accelerators. OpenCL
2.0 introduced the concept of Fine-Grained System SVM, which allows to
pass userspace pointers to devices. It is just one flavor of SVM, they
also have coarse-grained and non-system. But they might have coined the
name, and I believe that in the context of Linux IOMMU, when we talk about
"SVM" it is OpenCL's fine-grained system SVM.

* Nvidia Cuda has a feature similar to fine-grained system SVM, called
Unified Virtual Adressing. I'm not sure whether it maps exactly to
OpenCL's system SVM. Nividia's Unified Memory seems to be more in line
with HMM, because in addition to unifying the virtual address space, they
also unify system and device memory.


So SVM is about userspace API, the ability to perform DMA on a process
address space instead of using a separate DMA address space. One possible
implementation, for PCIe endpoints, uses ATS+PRI+PASID.

* The PASID extension adds a prefix to the PCI TLP (characterized by
bits[31:29] = 0b100) that specifies which address space is affected by the
transaction. The IOMMU uses (RequesterID, PASID, Virt Addr) to derive a
Phys Addr, where it previously only needed (RID, IOVA).

* The PRI extension allows to handle page faults from endpoints, which are
bound to happen if they attempt to access process memory.

* PRI requires ATS. PRI adds two new TLPs, but ATS makes use of the AT
field [11:10] in PCIe TLPs, which was previously reserved.

So PCI switches, endpoints, root complexes and IOMMUs all have to be aware
of these three extensions in order to use SVM with discrete endpoints.


While SVM is only about virtual address space, HMM deals with physical
storage. If I understand correctly, HMM allows to transparently use device
RAM from userspace applications. So upon an I/O page fault, the mm
subsystem will migrate data from system memory into device RAM. It would
differ from "pure" SVM in that you would use different page directories on
IOMMU and MMU sides, and synchronize them using MMU notifiers. But please
don't take this at face value, I haven't had time to look into HMM yet.

Thanks,
Jean
