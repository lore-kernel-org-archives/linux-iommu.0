From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [RFC 2/3] virtio-iommu: device probing and operations
Date: Fri,  7 Apr 2017 20:17:46 +0100
Message-ID: <20170407191747.26618-3-jean-philippe.brucker@arm.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <virtio-dev-return-2044-gcvd-virtio-dev=m.gmane.org@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
In-Reply-To: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: cdall@linaro.org, will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, joro@8bytes.org, mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com, marc.zyngier@arm.com
List-Id: iommu@lists.linux-foundation.org

After the virtio-iommu device has been probed and the driver is aware of
the devices translated by the IOMMU, it can start sending requests to the
virtio-iommu device. The operations described here are voluntarily
minimalistic, so vIOMMU devices can be as simple as possible to implement,
and can be extended with feature bits.

	I.   Overview
	II.  Feature bits
	III. Device configuration layout
	IV.  Device initialization
	V.   Device operations
	     1. Attach device
	     2. Detach device
	     3. Map region
	     4. Unmap region


  I. Overview
  ===========

Requests are small buffers added by the guest to the request virtqueue.
The guest can add a batch of them to the queue and send a notification
(kick) to the device to have all of them handled.

Here is an example flow:

* attach(address space, device), kick: create a new address space and
  attach a device to it
* map(address space, virt, phys, size, flags): create a mapping between a
  guest-virtual and a guest-physical addresses
* map, map, map, kick

* ... here the guest device can perform DMA to the freshly mapped memory

* unmap(address space, virt, size), unmap, kick
* detach(address space, device), kick

The following description attempts to use the same format as other virtio
devices. We won't go into details of the virtio transport, please refer to
[VIRTIO-v1.0] for more information.

As a quick reminder, the virtio (1.0) transport can be described with the
following flow:

                             HOST  :  GUEST
                     (3)           :
                    .----- [available ring] <-----. (2)
                   /               :               \
                  v   (4)          :          (1)   \
            [device] <--- [descriptor table] <---- [driver]
                  \                :                 ^
                   \               :                /
                (5) '-------> [used ring] ---------'
                                   :            (6)
                                   :

(1) Driver has a buffers with a payload to send via virtio. It writes
    address and size of buffer in a descriptor. It can chain N sub-buffers
    by writing N descriptors and linking them together. The first
    descriptor of the chain is referred to as the head.
(2) Driver queues the head index into the 'available' ring.
(3) Driver notifies the device. Since virtio-iommu uses MMIO, notification
    is done by writing to a doorbell address. KVM traps it and forwards
    the notification to the virtio device. Device dequeues the head index
    from the 'available' ring.
(4) Device reads all descriptors in the chain, handles the payload.
(5) Device writes the head index into the 'used' ring and sends a
    notification to the guest, by injecting an interrupt.
(6) Driver pops the head from the used ring, and optionally read the
    buffers that were updated by the device.


  II. Feature bits
  ================

VIRTIO_IOMMU_F_INPUT_RANGE (0)
 Available range of virtual addresses is described in input_range

VIRTIO_IOMMU_F_IOASID_BITS (1)
 The number of address spaces supported is described in ioasid_bits

VIRTIO_IOMMU_F_MAP_UNMAP (2)
 Map and unmap requests are available. This is here to allow a device or
 driver to only implement page-table sharing, once we introduce the
 feature. Device will be able to only select one of F_MAP_UNMAP or
 F_PT_SHARING. For the moment, this bit must always be set.
 
VIRTIO_IOMMU_F_BYPASS (3)
 When not attached to an address space, devices behind the IOMMU can
 access the physical address space.

  III. Device configuration layout
  ================================

	struct virtio_iommu_config {
		u64 page_size_mask;
		struct virtio_iommu_range {
			u64 start;
			u64 end;
		} input_range;
		u8 ioasid_bits;
	};

  IV. Device initialization
  =========================

1. page_size_mask contains the bitmask of all page sizes that can be
   mapped. The least significant bit set defines the page granularity of
   IOMMU mappings. Other bits in the mask are hints describing page sizes
   that the IOMMU can merge into a single mapping (page blocks).

   There is no lower limit for the smallest page granularity supported by
   the IOMMU. It is legal for the driver to map one byte at a time if the
   device advertises it.

   page_size_mask must have at least one bit set.

2. If the VIRTIO_IOMMU_F_IOASID_BITS feature is negotiated, ioasid_bits
   contains the number of bits supported in an I/O Address Space ID, the
   identifier used in map/unmap requests. A value of 0 is valid, and means
   that a single address space is supported.

   If the feature is not negotiated, address space identifiers can use up
   to 32 bits.

3. If the VIRTIO_IOMMU_F_INPUT_RANGE feature is negotiated, input_range
   contains the virtual address range that the IOMMU is able to translate.
   Any mapping request to virtual addresses outside of this range will
   fail.

   If the feature is not negotiated, virtual mappings span over the whole
   64-bit address space (start = 0, end = 0xffffffffffffffff)

4. If the VIRTIO_IOMMU_F_BYPASS feature is negotiated, devices behind the
   IOMMU not attached to an address space are allowed to access
   guest-physical addresses. Otherwise, accesses to guest-physical
   addresses may fault.


  V. Device operations
  ====================

Driver send requests on the request virtqueue (0), notifies the device and
waits for the device to return the request with a status in the used ring.
All requests are split in two parts: one device-readable, one device-
writeable. Each request must therefore be described with at least two
descriptors, as illustrated below.

	31                       7      0
	+--------------------------------+ <------- RO descriptor
	|      0 (reserved)     |  type  |
	+--------------------------------+
	|                                |
	|            payload             |
	|                                | <------- WO descriptor
	+--------------------------------+
	|      0 (reserved)     | status |
	+--------------------------------+

	struct virtio_iommu_req_head {
		u8	type;
		u8	reserved[3];
	};

	struct virtio_iommu_req_tail {
		u8	status;
		u8	reserved[3];
	};

(Note on the format choice: this format forces the payload to be split in
two - one read-only buffer, one write-only. It is necessary and sufficient
for our purpose, and does not close the door to future extensions with
more complex requests, such as a WO field sandwiched between two RO ones.
With virtio 1.0 ring requirements, such a request would need to be
described by two chains of descriptors, which might be more complex to
implement efficiently, but still possible. Both devices and drivers must
assume that requests are segmented anyway.)

Type may be one of:

VIRTIO_IOMMU_T_ATTACH			1
VIRTIO_IOMMU_T_DETACH			2
VIRTIO_IOMMU_T_MAP			3
VIRTIO_IOMMU_T_UNMAP			4

A few general-purpose status codes are defined here. Driver must not
assume a specific status to be returned for an invalid request. Except for
0 that always means "success", these values are hints to make
troubleshooting easier.

VIRTIO_IOMMU_S_OK			0
 All good! Carry on.

VIRTIO_IOMMU_S_IOERR			1
 Virtio communication error 

VIRTIO_IOMMU_S_UNSUPP			2
 Unsupported request

VIRTIO_IOMMU_S_DEVERR			3
 Internal device error

VIRTIO_IOMMU_S_INVAL			4
 Invalid parameters

VIRTIO_IOMMU_S_RANGE			5
 Out-of-range parameters

VIRTIO_IOMMU_S_NOENT			6
 Entry not found

VIRTIO_IOMMU_S_FAULT			7
 Bad address


  1. Attach device
  ----------------

struct virtio_iommu_req_attach {
	le32	address_space;
	le32	device;
	le32	flags/reserved;
};

Attach a device to an address space. 'address_space' is an identifier
unique to the guest. If the address space doesn't exist in the IOMMU
device, it is created. 'device' is an identifier unique to the IOMMU. The
host communicates unique device ID to the guest during boot. The method
used to communicate this ID is outside the scope of this specification,
but the following rules must apply:

* The device ID is unique from the IOMMU point of view. Multiple devices
  whose DMA transactions are not translated by the same IOMMU may have the
  same device ID. Devices whose DMA transactions may be translated by the
  same IOMMU must have different device IDs.

* Sometimes the host cannot completely isolate two devices from each
  others. For example on a legacy PCI bus, devices can snoop DMA
  transactions from their neighbours. In this case, the host must
  communicate to the guest that it cannot isolate these devices from each
  others. The method used to communicate this is outside the scope of this
  specification. The IOMMU device must ensure that devices that cannot be
  isolated by the host have the same address spaces.

Multiple devices may be added to the same address space. A device cannot
be attached to multiple address spaces (that is, with the map/unmap
interface. For SVM, see page table and context table sharing proposal.)

If the device is already attached to another address space 'old', it is
detached from the old one and attached to the new one. The device cannot
access mappings from the old address space after this request completes.

The device either returns VIRTIO_IOMMU_S_OK, or an error status. We
suggest the following error status, that would help debug the driver.

NOENT: device not found.
RANGE: address space is outside the range allowed by ioasid_bits.


  2. Detach device
  ----------------

struct virtio_iommu_req_detach {
	le32	device;
	le32	flags/reserved;
};

Detach a device from its address space. When this request completes, the
device cannot access any mapping from that address space anymore. If the
device isn't attached to any address space, the request returns
successfully.

After all devices have been successfully detached from an address space,
its ID can be reused by the driver for another address space.

NOENT: device not found.
INVAL: device wasn't attached to any address space.


  3. Map region
  -------------

struct virtio_iommu_req_map {
	le32	address_space;
	le64	phys_addr;
	le64	virt_addr;
	le64	size;
	le32	flags;
};

VIRTIO_IOMMU_MAP_F_READ		0x1
VIRTIO_IOMMU_MAP_F_WRITE	0x2
VIRTIO_IOMMU_MAP_F_EXEC		0x4

Map a range of virtually-contiguous addresses to a range of
physically-contiguous addresses. Size must always be a multiple of the
page granularity negotiated during initialization. Both phys_addr and
virt_addr must be aligned on the page granularity. The address space must
have been created with VIRTIO_IOMMU_T_ATTACH.

The range defined by (virt_addr, size) must be within the limits specified
by input_range. The range defined by (phys_addr, size) must be within the
guest-physical address space. This includes upper and lower limits, as
well as any carving of guest-physical addresses for use by the host (for
instance MSI doorbells). Guest physical boundaries are set by the host
using a firmware mechanism outside the scope of this specification.

(Note that this format prevents from creating the identity mapping in a
single request (0x0 - 0xfff....fff) -> (0x0 - 0xfff...fff), since it would
result in a size of zero. Hopefully allowing VIRTIO_IOMMU_F_BYPASS
eliminates the need for issuing such request. It would also be unlikely to
conform to the physical range restrictions from the previous paragraph)

(Another note, on flags: it is unlikely that all possible combinations of
flags will be supported by the physical IOMMU. For instance, (W & !R) or
(E & W) might be invalid. I haven't taken time to devise a clever way to
advertise supported and implicit (for instance "W implies R") flags or
combination thereof for the moment, but I could at least try to research
common models. Keeping in mind that we might soon want to add more flags,
such as privileged, device, transient, shared, etc. whatever these would
mean)

This request is only available when VIRTIO_IOMMU_F_MAP_UNMAP has been
negotiated.

INVAL: invalid flags
RANGE: virt_addr, phys_addr or range are not in the limits specified
       during negotiation. For instance, not aligned to page granularity.
NOENT: address space not found.


  4. Unmap region
  ---------------

struct virtio_iommu_req_unmap {
	le32	address_space;
	le64	virt_addr;
	le64	size;
	le32	reserved;
};

Unmap a range of addresses mapped with VIRTIO_IOMMU_T_MAP. The range,
defined by virt_addr and size, must exactly cover one or more contiguous
mappings created with MAP requests. All mappings covered by the range are
removed. Driver should not send a request covering unmapped areas.

We define a mapping as a virtual region created with a single MAP request.
virt_addr should exactly match the start of an existing mapping. The end
of the range, (virt_addr + size - 1), should exactly match the end of an
existing mapping. Device must reject any request that would affect only
part of a mapping. If the requested range spills outside of mapped
regions, the device's behaviour is undefined.

These rules are illustrated with the following requests (with arguments
(va, size)), assuming each example sequence starts with a blank address
space:

	map(0, 10)
	unmap(0, 10) -> allowed

	map(0, 5)
	map(5, 5)
	unmap(0, 10) -> allowed

	map(0, 10)
	unmap(0, 5) -> forbidden

	map(0, 10)
	unmap(0, 15) -> undefined

	map(0, 5)
	map(10, 5)
	unmap(0, 15) -> undefined

(Note: the semantics of unmap are chosen to be compatible with VFIO's
type1 v2 IOMMU API. This way a device serving as intermediary between
guest and VFIO doesn't have to keep an internal tree of mappings. They are
a bit tighter than VFIO, in that they don't allow unmap spilling outside
mapped regions. Spilling is 'undefined' at the moment, because it should
work in most cases but I don't know if it's worth the added complexity in
devices that are not simply transmitting requests to VFIO. Splitting
mappings won't ever be allowed, but see the relaxed proposal in 3/3 for
more lenient semantics)

This request is only available when VIRTIO_IOMMU_F_MAP_UNMAP has been
negotiated.

NOENT: address space not found.
FAULT: mapping not found.
RANGE: request would split a mapping.


[VIRTIO-v1.0] Virtual I/O Device (VIRTIO) Version 1.0.  03 December 2013.
              Committee Speciﬁcation Draft 01 / Public Review Draft 01.
              http://docs.oasis-open.org/virtio/virtio/v1.0/csprd01/virtio-v1.0-csprd01.html
