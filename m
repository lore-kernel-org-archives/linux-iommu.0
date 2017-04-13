From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC 0/3] virtio-iommu: a paravirtualized IOMMU
Date: Thu, 13 Apr 2017 08:41:01 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D190CA999C@SHSMSX101.ccr.corp.intel.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170407191747.26618-1-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "virtio-dev-sDuHXQ4OtrM4h7I2RyI4rWD2FQJk+8+b@public.gmane.org" <virtio-dev-sDuHXQ4OtrM4h7I2RyI4rWD2FQJk+8+b@public.gmane.org>
Cc: "cdall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <cdall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Jean-Philippe Brucker
> Sent: Saturday, April 8, 2017 3:18 AM
> 
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
> 
> When designing it and writing the kvmtool device, I considered two main
> scenarios, illustrated below.
> 
> Scenario 1: a hardware device passed through twice via VFIO
> 
>    MEM____pIOMMU________PCI device________________________
> HARDWARE
>             |     (2b)                                    \
>   ----------|-------------+-------------+------------------\-------------
>             |             :     KVM     :                   \
>             |             :             :                    \
>        pIOMMU drv         :         _______virtio-iommu drv   \    KERNEL
>             |             :        |    :          |           \
>           VFIO            :        |    :        VFIO           \
>             |             :        |    :          |             \
>             |             :        |    :          |             /
>   ----------|-------------+--------|----+----------|------------/--------
>             |                      |    :          |           /
>             | (1c)            (1b) |    :     (1a) |          / (2a)
>             |                      |    :          |         /
>             |                      |    :          |        /   USERSPACE
>             |___virtio-iommu dev___|    :        net drv___/
>                                         :
>   --------------------------------------+--------------------------------
>                  HOST                   :             GUEST
> 

Usually people draw such layers in reverse order, e.g. hw in the
bottom then kernel in the middle then user in the top. :-)

> (1) a. Guest userspace is running a net driver (e.g. DPDK). It allocates a
>        buffer with mmap, obtaining virtual address VA. It then send a
>        VFIO_IOMMU_MAP_DMA request to map VA to an IOVA (possibly
> VA=IOVA).
>     b. The maping request is relayed to the host through virtio
>        (VIRTIO_IOMMU_T_MAP).
>     c. The mapping request is relayed to the physical IOMMU through VFIO.
> 
> (2) a. The guest userspace driver can now instruct the device to directly
>        access the buffer at IOVA
>     b. IOVA accesses from the device are translated into physical
>        addresses by the IOMMU.
> 
> Scenario 2: a virtual net device behind a virtual IOMMU.
> 
>   MEM__pIOMMU___PCI device                                     HARDWARE
>          |         |
>   -------|---------|------+-------------+-------------------------------
>          |         |      :     KVM     :
>          |         |      :             :
>     pIOMMU drv     |      :             :
>              \     |      :      _____________virtio-net drv      KERNEL
>               \_net drv   :     |       :          / (1a)
>                    |      :     |       :         /
>                   tap     :     |    ________virtio-iommu drv
>                    |      :     |   |   : (1b)
>   -----------------|------+-----|---|---+-------------------------------
>                    |            |   |   :
>                    |_virtio-net_|   |   :
>                          / (2)      |   :
>                         /           |   :                      USERSPACE
>               virtio-iommu dev______|   :
>                                         :
>   --------------------------------------+-------------------------------
>                  HOST                   :             GUEST
> 
> (1) a. Guest virtio-net driver maps the virtio ring and a buffer
>     b. The mapping requests are relayed to the host through virtio.
> (2) The virtio-net device now needs to access any guest memory via the
>     IOMMU.
> 
> Physical and virtual IOMMUs are completely dissociated. The net driver is
> mapping its own buffers via DMA/IOMMU API, and buffers are copied
> between
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
> pIOMMU	physical IOMMU, controlling DMA accesses from physical
> devices
> vIOMMU	virtual IOMMU (virtio-iommu), controlling DMA accesses
> from
> 	physical and virtual devices to guest memory.

maybe clearer to call controlling 'virtual' DMA access since we're
essentially doing DMA virtualization here. Otherwise I read it
a bit confusing since DMA accesses from physical device should
be controlled by pIOMMU.

> GVA, GPA, HVA, HPA
> 	Guest/Host Virtual/Physical Address
> IOVA	I/O Virtual Address, the address accessed by a device doing DMA
> 	through an IOMMU. In the context of a guest OS, IOVA is GVA.

This statement is not accurate. For kernel DMA protection, it is 
per-device standalone address space (definitely nothing to do 
with GVA). For user DMA protection, user space driver decides 
how it wants to construct IOVA address space. could be a 
standalone one, or reuse GVA. In virtualization case it is either
GPA (w/o vIOMMU) or guest IOVA (w/ IOMMU and guest creates
IOVA space).

anyway IOVA concept is clear. possibly just removing the example
is still clear. :-)

> 
> Note: kvmtool is GPLv2. Linux patches are GPLv2, except for UAPI
> virtio-iommu.h header, which is BSD 3-clause. For the time being, the
> specification draft in RFC 2/3 is also BSD 3-clause.
> 
> 
> This proposal may be involuntarily centered around ARM architectures at
> times. Any feedback would be appreciated, especially regarding other
> IOMMU
> architectures.
> 

thanks for doing this. will definitely look them in detail and feedback.

Thanks
Kevin
