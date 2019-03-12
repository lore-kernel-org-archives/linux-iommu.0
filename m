From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 0/9] Bounce buffer for untrusted devices
Date: Tue, 12 Mar 2019 14:07:23 +0800
Message-ID: <b818f647-766e-71f0-779e-1c997fd6a144@linux.intel.com>
References: <20190312060005.12189-1-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312060005.12189-1-baolu.lu@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com, jacob.jun.pan@intel.com, alan.cox@intel.com, kevin.tian@intel.com, mika.westerberg@linux.intel.com, pengfei.xu@intel.com
Cc: baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Should be titled as "iommu/vt-d: Bounce buffer for untrusted devices".
Sorry for the inconvenience.

On 3/12/19 1:59 PM, Lu Baolu wrote:
> An external PCI device is a PCI peripheral device connected
> to the system through an external bus, such as Thunderbolt.
> What makes it different is that it can't be trusted to the
> same degree as the devices build into the system. Generally,
> a trusted PCIe device will DMA into the designated buffers
> and not overrun or otherwise write outside the specified
> bounds. But it's different for an external device. The minimum
> IOMMU mapping granularity is one page (4k), so for DMA transfers
> smaller than that a malicious PCIe device can access the whole
> page of memory even if it does not belong to the driver in
> question. This opens a possibility for DMA attack. For more
> information about DMA attacks imposed by an untrusted PCI/PCIe
> device, please refer to [2].
> 
> This implements bounce buffer for the untrusted external
> devices. The transfers should be limited in isolated pages
> so the IOMMU window does not cover memory outside of what
> the driver expects. Full pages within a buffer could be
> directly mapped in IOMMU page table, but for partial pages
> we use bounce page instead.
> 
> In addition, the IOMMU mappings cached in the IOTLB for
> untrusted devices should be invalidated immediately after
> the unmap operation. Otherwise, the IOMMU window is left
> open to attacks.
> 
> The implementation of bounce buffers for untrusted devices
> will cause a little performance overhead, but we didn't see
> any user experience problems. The users could use the kernel
> parameter of "intel_iommu=nobounce" to remove the performance
> overhead if they trust their devices enough.
> 
> The Thunderbolt vulnerabiltiies is public and has a nice
> name as Thunderclap nowadays. Please refer to [1] [3] for
> more information. This patch series aims to mitigate the
> concerns.
> 
> The bounce buffer idea:
> 
> Based-on-idea-by: Mika Westerberg <mika.westerberg@intel.com>
> Based-on-idea-by: Ashok Raj <ashok.raj@intel.com>
> Based-on-idea-by: Alan Cox <alan.cox@intel.com>
> 
> The patch series has been tested by:
> 
> Tested-by: Xu Pengfei <pengfei.xu@intel.com>
> Tested-by: Mika Westerberg <mika.westerberg@intel.com>
> 
> [1] https://thunderclap.io/
> [2] https://thunderclap.io/thunderclap-paper-ndss2019.pdf
> [3] https://christian.kellner.me/2019/02/27/thunderclap-and-linux/
> 
> Lu Baolu (9):
>    iommu/vt-d: Add trace events for domain map/unmap
>    iommu/vt-d: Add helpers for domain mapping/unmapping
>    iommu/vt-d: Add address walk helper
>    iommu/vt-d: Add bounce buffer API for domain map/unmap
>    iommu/vt-d: Add bounce buffer API for dma sync
>    iommu/vt-d: Check whether device requires bounce buffer
>    iommu/vt-d: Add dma sync ops for untrusted devices
>    iommu/vt-d: Flush IOTLB for untrusted device in time
>    iommu/vt-d: Use bounce buffer for untrusted devices
> 
>   .../admin-guide/kernel-parameters.txt         |   5 +
>   drivers/iommu/Makefile                        |   1 +
>   drivers/iommu/intel-iommu.c                   | 360 ++++++++++--
>   drivers/iommu/intel-pgtable.c                 | 518 ++++++++++++++++++
>   drivers/iommu/intel-trace.c                   |  14 +
>   include/linux/intel-iommu.h                   |  24 +
>   include/trace/events/intel_iommu.h            | 132 +++++
>   7 files changed, 1010 insertions(+), 44 deletions(-)
>   create mode 100644 drivers/iommu/intel-pgtable.c
>   create mode 100644 drivers/iommu/intel-trace.c
>   create mode 100644 include/trace/events/intel_iommu.h
> 
