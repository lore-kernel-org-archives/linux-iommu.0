From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [v3 18/26] KVM: kvm-vfio: User API for VT-d Posted-Interrupts
Date: Fri, 12 Dec 2014 23:14:52 +0800
Message-ID: <1418397300-10870-19-git-send-email-feng.wu@intel.com>
References: <1418397300-10870-1-git-send-email-feng.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1418397300-10870-1-git-send-email-feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gleb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pbonzini-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

This patch adds and documents two new attributes
KVM_DEV_VFIO_DEVICE_POST_IRQ and KVM_DEV_VFIO_DEVICE_UNPOST_IRQ
in KVM_DEV_VFIO_DEVICE group. The new attributes are used for
VT-d Posted-Interrupts.

When guest OS changes the interrupt configuration for an
assigned device, such as, MSI/MSIx data/address fields,
QEMU will use this IRQ attribute to tell KVM to update the
related IRTE according the VT-d Posted-Interrrupts Specification,
such as, the guest vector should be updated in the related IRTE.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 Documentation/virtual/kvm/devices/vfio.txt |  9 +++++++++
 include/uapi/linux/kvm.h                   | 11 +++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/virtual/kvm/devices/vfio.txt b/Documentation/virtual/kvm/devices/vfio.txt
index f7aff29..ecfbf61 100644
--- a/Documentation/virtual/kvm/devices/vfio.txt
+++ b/Documentation/virtual/kvm/devices/vfio.txt
@@ -42,3 +42,12 @@ activated before VFIO_DEVICE_SET_IRQS has been called to trigger the IRQ
 or associate an eventfd to it. Unforwarding can only be called while the
 signaling has been disabled with VFIO_DEVICE_SET_IRQS. If this condition is
 not satisfied, the command returns an -EBUSY.
+
+  KVM_DEV_VFIO_DEVICE_POST_IRQ: set a VFIO device IRQ as posted
+  KVM_DEV_VFIO_DEVICE_UNPOST_IRQ: set a VFIO device IRQ as remapped
+For this attribute, kvm_device_attr.addr points to a kvm_vfio_dev_irq struct.
+
+When guest OS changes the interrupt configuration for an assigned device,
+such as, MSI/MSIx data/address fields, QEMU will use this IRQ attribute
+to tell KVM to update the related IRTE according the VT-d Posted-Interrrupts
+Specification, such as, the guest vector should be updated in the related IRTE.
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index a269a42..8f51487 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -949,6 +949,8 @@ struct kvm_device_attr {
 #define  KVM_DEV_VFIO_DEVICE			2
 #define   KVM_DEV_VFIO_DEVICE_FORWARD_IRQ			1
 #define   KVM_DEV_VFIO_DEVICE_UNFORWARD_IRQ			2
+#define   KVM_DEV_VFIO_DEVICE_POST_IRQ				3
+#define   KVM_DEV_VFIO_DEVICE_UNPOST_IRQ			4
 
 enum kvm_device_type {
 	KVM_DEV_TYPE_FSL_MPIC_20	= 1,
@@ -973,6 +975,15 @@ struct kvm_arch_forwarded_irq {
 	__u32 gsi; /* gsi, ie. virtual IRQ number */
 };
 
+struct kvm_vfio_dev_irq {
+	__u32	argsz;
+	__u32	fd;		/* file descriptor of the VFIO device */
+	__u32	index;		/* VFIO device IRQ index */
+	__u32	start;
+	__u32	count;
+	__u32	gsi[];		/* gsi, ie. virtual IRQ number */
+};
+
 /*
  * ioctls for VM fds
  */
-- 
1.9.1
