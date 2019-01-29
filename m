From: jglisse@redhat.com
Subject: [RFC PATCH 3/5] mm/vma: add support for peer to peer to device vma
Date: Tue, 29 Jan 2019 12:47:26 -0500
Message-ID: <20190129174728.6430-4-jglisse@redhat.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129174728.6430-1-jglisse@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Logan Gunthorpe <logang@deltatee.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian Koenig <christian.koenig@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Jason Gunthorpe <jgg@mellanox.com>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>, iommu@lists.linux-foundation.org
List-Id: iommu@lists.linux-foundation.org

From: Jérôme Glisse <jglisse@redhat.com>

Allow mmap of device file to export device memory to peer to peer
devices. This will allow for instance a network device to access a
GPU memory or to access a storage device queue directly.

The common case will be a vma created by userspace device driver
that is then share to another userspace device driver which call
in its kernel device driver to map that vma.

The vma does not need to have any valid CPU mapping so that only
peer to peer device might access its content. Or it could have
valid CPU mapping too in that case it should point to same memory
for consistency.

Note that peer to peer mapping is highly platform and device
dependent and it might not work in all the cases. However we do
expect supports for this to grow on more hardware platform.

This patch only adds new call backs to vm_operations_struct bulk
of code light within common bus driver (like pci) and device
driver (both the exporting and importing device).

Current design mandate that the importer must obey mmu_notifier
and invalidate any peer to peer mapping anytime a notification
of invalidation happens for a range that have been peer to peer
mapped. This allows exporter device to easily invalidate mapping
for any importer device.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux-foundation.org
---
 include/linux/mm.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 80bb6408fe73..1bd60a90e575 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -429,6 +429,44 @@ struct vm_operations_struct {
 			pgoff_t start_pgoff, pgoff_t end_pgoff);
 	unsigned long (*pagesize)(struct vm_area_struct * area);
 
+	/*
+	 * Optional for device driver that want to allow peer to peer (p2p)
+	 * mapping of their vma (which can be back by some device memory) to
+	 * another device.
+	 *
+	 * Note that the exporting device driver might not have map anything
+	 * inside the vma for the CPU but might still want to allow a peer
+	 * device to access the range of memory corresponding to a range in
+	 * that vma.
+	 *
+	 * FOR PREDICTABILITY IF DRIVER SUCCESSFULY MAP A RANGE ONCE FOR A
+	 * DEVICE THEN FURTHER MAPPING OF THE SAME IF THE VMA IS STILL VALID
+	 * SHOULD ALSO BE SUCCESSFUL. Following this rule allow the importing
+	 * device to map once during setup and report any failure at that time
+	 * to the userspace. Further mapping of the same range might happen
+	 * after mmu notifier invalidation over the range. The exporting device
+	 * can use this to move things around (defrag BAR space for instance)
+	 * or do other similar task.
+	 *
+	 * IMPORTER MUST OBEY mmu_notifier NOTIFICATION AND CALL p2p_unmap()
+	 * WHEN A NOTIFIER IS CALL FOR THE RANGE ! THIS CAN HAPPEN AT ANY
+	 * POINT IN TIME WITH NO LOCK HELD.
+	 *
+	 * In below function, the device argument is the importing device,
+	 * the exporting device is the device to which the vma belongs.
+	 */
+	long (*p2p_map)(struct vm_area_struct *vma,
+			struct device *device,
+			unsigned long start,
+			unsigned long end,
+			dma_addr_t *pa,
+			bool write);
+	long (*p2p_unmap)(struct vm_area_struct *vma,
+			  struct device *device,
+			  unsigned long start,
+			  unsigned long end,
+			  dma_addr_t *pa);
+
 	/* notification that a previously read-only page is about to become
 	 * writable, if an error is returned it will cause a SIGBUS */
 	vm_fault_t (*page_mkwrite)(struct vm_fault *vmf);
-- 
2.17.2
