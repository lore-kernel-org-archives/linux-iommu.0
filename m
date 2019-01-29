From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Subject: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted
Date: Tue, 29 Jan 2019 15:08:12 -0200
Message-ID: <87zhrj8kcp.fsf@morokweng.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: virtualization@lists.linux-foundation.org
Cc: linuxppc-devel@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Christoph Hellwig <hch@lst.de>, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@linux.ibm.com>, Paul Mackerras <paulus@ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Ram Pai <linuxram@us.ibm.com>
List-Id: iommu@lists.linux-foundation.org


Hello,

With Christoph's rework of the DMA API that recently landed, the patch
below is the only change needed in virtio to make it work in a POWER
secure guest under the ultravisor.

The other change we need (making sure the device's dma_map_ops is NULL
so that the dma-direct/swiotlb code is used) can be made in
powerpc-specific code.

Of course, I also have patches (soon to be posted as RFC) which hook up
<linux/mem_encrypt.h> to the powerpc secure guest support code.

What do you think?

>From d0629a36a75c678b4a72b853f8f7f8c17eedd6b3 Mon Sep 17 00:00:00 2001
From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Thu, 24 Jan 2019 22:08:02 -0200
Subject: [RFC PATCH] virtio_ring: Use DMA API if guest memory is encrypted

The host can't access the guest memory when it's encrypted, so using
regular memory pages for the ring isn't an option. Go through the DMA API.

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 drivers/virtio/virtio_ring.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index cd7e755484e3..321a27075380 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -259,8 +259,11 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
 	 * not work without an even larger kludge.  Instead, enable
 	 * the DMA API if we're a Xen guest, which at least allows
 	 * all of the sensible Xen configurations to work correctly.
+	 *
+	 * Also, if guest memory is encrypted the host can't access
+	 * it directly. In this case, we'll need to use the DMA API.
 	 */
-	if (xen_domain())
+	if (xen_domain() || sev_active())
 		return true;

 	return false;
