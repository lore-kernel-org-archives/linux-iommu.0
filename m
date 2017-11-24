From: Bob Liu <liubo95@huawei.com>
Subject: Re: [RFCv2 PATCH 10/36] vfio: Add support for Shared Virtual Memory
Date: Fri, 24 Nov 2017 16:23:26 +0800
Message-ID: <419afe22-816d-263f-9c85-1a9e28c723b7@huawei.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-11-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171006133203.22803-11-jean-philippe.brucker@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: mark.rutland@arm.com, xieyisheng1@huawei.com, gabriele.paoloni@huawei.com, catalin.marinas@arm.com, will.deacon@arm.com, okaya@codeaurora.org, yi.l.liu@intel.com, lorenzo.pieralisi@arm.com, ashok.raj@intel.com, tn@semihalf.com, joro@8bytes.org, rfranz@cavium.com, lenb@kernel.org, jacob.jun.pan@linux.intel.com, alex.williamson@redhat.com, robh+dt@kernel.org, thunder.leizhen@huawei.com, bhelgaas@google.com, dwmw2@infradead.org, rjw@rjwysocki.net, robdclark@gmail.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, robin.murphy@arm.com, nwatters@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
> Add two new ioctl for VFIO containers. VFIO_DEVICE_BIND_PROCESS creates a
> bond between a container and a process address space, identified by a
> device-specific ID named PASID. This allows the device to target DMA
> transactions at the process virtual addresses without a need for mapping
> and unmapping buffers explicitly in the IOMMU. The process page tables are
> shared with the IOMMU, and mechanisms such as PCI ATS/PRI may be used to
> handle faults. VFIO_DEVICE_UNBIND_PROCESS removed a bond identified by a
> PASID.
> 

How about hide bind/unbind into ioctl(VFIO_SET_IOMMU)? 
e.g always bind to current process in SET_IOMMU.

Not sure about the real use case.

> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 243 +++++++++++++++++++++++++++++++++++++++-
>  include/uapi/linux/vfio.h       |  69 ++++++++++++
>  2 files changed, 311 insertions(+), 1 deletion(-)
> 
