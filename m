From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [RFC PATCH kvmtool 15/15] virtio: use virtio-iommu when available
Date: Fri,  7 Apr 2017 20:24:55 +0100
Message-ID: <20170407192455.26814-16-jean-philippe.brucker@arm.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
 <20170407192455.26814-1-jean-philippe.brucker@arm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170407192455.26814-1-jean-philippe.brucker@arm.com>
Sender: kvm-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: cdall@linaro.org, will.deacon@arm.com, robin.murphy@arm.com, lorenzo.pieralisi@arm.com, joro@8bytes.org, mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com, marc.zyngier@arm.com
List-Id: iommu@lists.linux-foundation.org

This is for development only. Virtual devices might blow up unexpectedly.
In general it seems to work (slowing devices down by a factor of two of
course). virtio-scsi, virtio-rng and virtio-balloon are still untested.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 virtio/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/virtio/core.c b/virtio/core.c
index 66e0cecb..4ca632f9 100644
--- a/virtio/core.c
+++ b/virtio/core.c
@@ -1,4 +1,5 @@
 #include <linux/virtio_config.h>
+#include <linux/virtio_ids.h>
 #include <linux/virtio_ring.h>
 #include <linux/types.h>
 #include <sys/uio.h>
@@ -369,6 +370,8 @@ int virtio_init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
 {
 	void *virtio;
 
+	vdev->use_iommu = kvm->cfg.viommu && subsys_id != VIRTIO_ID_IOMMU;
+
 	switch (trans) {
 	case VIRTIO_PCI:
 		virtio = calloc(sizeof(struct virtio_pci), 1);
-- 
2.12.1
