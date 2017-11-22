From: Bob Liu <liubo95@huawei.com>
Subject: Re: [RFCv2 PATCH 01/36] iommu: Keep track of processes and PASIDs
Date: Wed, 22 Nov 2017 11:15:24 +0800
Message-ID: <588ad6f0-e78a-63de-e27a-3da4de4ab2ab@huawei.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-2-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20171006133203.22803-2-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, robin.murphy@arm.com, bhelgaas@google.com, alex.williamson@redhat.com, tn@semihalf.com, thunder.leizhen@huawei.com, xieyisheng1@huawei.com, gabriele.paoloni@huawei.com, nwatters@codeaurora.org, okaya@codeaurora.org, rfranz@cavium.com, dwmw2@infradead.org, jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com, ashok.raj@intel.com, robdclark@gmail.com
List-Id: iommu@lists.linux-foundation.org

Hey Jean,

On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
> IOMMU drivers need a way to bind Linux processes to devices. This is used
> for Shared Virtual Memory (SVM), where devices support paging. In that
> mode, DMA can directly target virtual addresses of a process.
> 
> Introduce boilerplate code for allocating process structures and binding
> them to devices. Four operations are added to IOMMU drivers:
> 
> * process_alloc, process_free: to create an iommu_process structure and
>   perform architecture-specific operations required to grab the process
>   (for instance on ARM SMMU, pin down the CPU ASID). There is a single
>   iommu_process structure per Linux process.
> 

I'm a bit confused here.
The original meaning of iommu_domain is a virtual addrspace defined by a set of io page table.
(fix me if I misunderstood).
Then what's the meaning of iommu_domain and iommu_process after introducing iommu_process?
Could you consider document these concepts? 

Thanks,
Liubo
