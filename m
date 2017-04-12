From: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC 0/3] virtio-iommu: a paravirtualized IOMMU
Date: Wed, 12 Apr 2017 17:06:43 +0800
Message-ID: <a0920e37-a11e-784c-7d90-be6617ea7686@redhat.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <virtio-dev-return-2068-gcvd-virtio-dev=m.gmane.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: cdall@linaro.org, will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, joro@8bytes.org, mst@redhat.com, alex.williamson@redhat.com, marc.zyngier@arm.com
List-Id: iommu@lists.linux-foundation.org



On 2017年04月08日 03:17, Jean-Philippe Brucker wrote:
> This is the initial proposal for a paravirtualized IOMMU device using
> virtio transport. It contains a description of the device, a Linux driver,
> and a toy implementation in kvmtool. With this prototype, you can
> translate DMA to guest memory from emulated (virtio), or passed-through
> (VFIO) devices.
>
> In its simplest form, implemented here, the device handles map/unmap
> requests from the guest. Future extensions proposed in "RFC 3/3" should
> allow to bind page tables to devices.
>
> There are a number of advantages in a paravirtualized IOMMU over a full
> emulation. It is portable and could be reused on different architectures.
> It is easier to implement than a full emulation, with less state tracking.
> It might be more efficient in some cases, with less context switches to
> the host and the possibility of in-kernel emulation.

I like the idea. Consider the complexity of IOMMU hardware. I believe we 
don't want to have and fight  for bugs of three or more different IOMMU 
implementations in either userspace or kernel.

Thanks

>
> When designing it and writing the kvmtool device, I considered two main
> scenarios, illustrated below.
>
> Scenario 1: a hardware device passed through twice via VFIO
>
>     MEM____pIOMMU________PCI device________________________       HARDWARE
>              |     (2b)                                    \
>    ----------|-------------+-------------+------------------\-------------
>              |             :     KVM     :                   \
>              |             :             :                    \
>         pIOMMU drv         :         _______virtio-iommu drv   \    KERNEL
>              |             :        |    :          |           \
>            VFIO            :        |    :        VFIO           \
>              |             :        |    :          |             \
>              |             :        |    :          |             /
>    ----------|-------------+--------|----+----------|------------/--------
>              |                      |    :          |           /
>              | (1c)            (1b) |    :     (1a) |          / (2a)
>              |                      |    :          |         /
>              |                      |    :          |        /   USERSPACE
>              |___virtio-iommu dev___|    :        net drv___/
>                                          :
>    --------------------------------------+--------------------------------
>                   HOST                   :             GUEST
>
> (1) a. Guest userspace is running a net driver (e.g. DPDK). It allocates a
>         buffer with mmap, obtaining virtual address VA. It then send a
>         VFIO_IOMMU_MAP_DMA request to map VA to an IOVA (possibly VA=IOVA).
>      b. The maping request is relayed to the host through virtio
>         (VIRTIO_IOMMU_T_MAP).
>      c. The mapping request is relayed to the physical IOMMU through VFIO.
>
> (2) a. The guest userspace driver can now instruct the device to directly
>         access the buffer at IOVA
>      b. IOVA accesses from the device are translated into physical
>         addresses by the IOMMU.
>
> Scenario 2: a virtual net device behind a virtual IOMMU.
>
>    MEM__pIOMMU___PCI device                                     HARDWARE
>           |         |
>    -------|---------|------+-------------+-------------------------------
>           |         |      :     KVM     :
>           |         |      :             :
>      pIOMMU drv     |      :             :
>               \     |      :      _____________virtio-net drv      KERNEL
>                \_net drv   :     |       :          / (1a)
>                     |      :     |       :         /
>                    tap     :     |    ________virtio-iommu drv
>                     |      :     |   |   : (1b)
>    -----------------|------+-----|---|---+-------------------------------
>                     |            |   |   :
>                     |_virtio-net_|   |   :
>                           / (2)      |   :
>                          /           |   :                      USERSPACE
>                virtio-iommu dev______|   :
>                                          :
>    --------------------------------------+-------------------------------
>                   HOST                   :             GUEST
>
> (1) a. Guest virtio-net driver maps the virtio ring and a buffer
>      b. The mapping requests are relayed to the host through virtio.
> (2) The virtio-net device now needs to access any guest memory via the
>      IOMMU.
>
> Physical and virtual IOMMUs are completely dissociated. The net driver is
> mapping its own buffers via DMA/IOMMU API, and buffers are copied between
> virtio-net and tap.
>
>
> The description itself seemed too long for a single email, so I split it
> into three documents, and will attach Linux and kvmtool patches to this
> email.
>
> 	1. Firmware note,
> 	2. device operations (draft for the virtio specification),
> 	3. future work/possible improvements.
>
> Just to be clear on the terms I'm using:
>
> pIOMMU	physical IOMMU, controlling DMA accesses from physical devices
> vIOMMU	virtual IOMMU (virtio-iommu), controlling DMA accesses from
> 	physical and virtual devices to guest memory.
> GVA, GPA, HVA, HPA
> 	Guest/Host Virtual/Physical Address
> IOVA	I/O Virtual Address, the address accessed by a device doing DMA
> 	through an IOMMU. In the context of a guest OS, IOVA is GVA.
>
> Note: kvmtool is GPLv2. Linux patches are GPLv2, except for UAPI
> virtio-iommu.h header, which is BSD 3-clause. For the time being, the
> specification draft in RFC 2/3 is also BSD 3-clause.
>
>
> This proposal may be involuntarily centered around ARM architectures at
> times. Any feedback would be appreciated, especially regarding other IOMMU
> architectures.
>
> Thanks,
> Jean-Philippe
