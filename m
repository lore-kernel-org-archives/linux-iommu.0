From: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [v3 19/26] KVM: kvm-vfio: implement the VFIO skeleton for VT-d
	Posted-Interrupts
Date: Fri, 12 Dec 2014 23:14:53 +0800
Message-ID: <1418397300-10870-20-git-send-email-feng.wu@intel.com>
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

This patch adds the kvm-vfio interface for VT-d Posted-Interrrupts.
When guests update MSI/MSI-x information for an assigned-device,
QEMU will use KVM_DEV_VFIO_DEVICE_POST_IRQ attribute to setup
IRTE for VT-d PI. Userspace program can also use
KVM_DEV_VFIO_DEVICE_UNPOST_IRQ to change back to irq remapping mode.
This patch implements these IRQ attributes.

Signed-off-by: Feng Wu <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 include/linux/kvm_host.h |  20 +++++++++
 virt/kvm/vfio.c          | 107 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5cd4420..ca9a393 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1134,6 +1134,26 @@ static inline int kvm_arch_vfio_set_forward(struct kvm_fwd_irq *fwd_irq,
 }
 #endif
 
+#ifdef __KVM_HAVE_ARCH_KVM_VFIO_POST
+/*
+ * kvm_arch_vfio_update_pi_irte - set IRTE for Posted-Interrupts
+ *
+ * @kvm: kvm
+ * @host_irq: host irq of the interrupt
+ * @guest_irq: gsi of the interrupt
+ * @set: set or unset PI
+ * returns 0 on success, < 0 on failure
+ */
+int kvm_arch_vfio_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
+				 uint32_t guest_irq, bool set);
+#else
+static int kvm_arch_vfio_update_pi_irte(struct kvm *kvm, unsigned int host_irq,
+					uint32_t guest_irq, bool set)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT
 
 static inline void kvm_vcpu_set_in_spin_loop(struct kvm_vcpu *vcpu, bool val)
diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
index 6bc7001..dbc6c3b 100644
--- a/virt/kvm/vfio.c
+++ b/virt/kvm/vfio.c
@@ -446,6 +446,99 @@ out:
 	return ret;
 }
 
+static int kvm_vfio_pci_get_irq_count(struct pci_dev *pdev, int irq_type)
+{
+	if (irq_type == VFIO_PCI_INTX_IRQ_INDEX) {
+		u8 pin;
+
+		pci_read_config_byte(pdev, PCI_INTERRUPT_PIN, &pin);
+		if (pin)
+			return 1;
+	} else if (irq_type == VFIO_PCI_MSI_IRQ_INDEX)
+		return pci_msi_vec_count(pdev);
+	else if (irq_type == VFIO_PCI_MSIX_IRQ_INDEX)
+		return pci_msix_vec_count(pdev);
+
+	return 0;
+}
+
+static int kvm_vfio_control_pi(struct kvm_device *kdev,
+			       int32_t __user *argp, bool set)
+{
+	struct kvm_vfio_dev_irq pi_info;
+	uint32_t *gsi;
+	unsigned long minsz;
+	struct vfio_device *vdev;
+	struct msi_desc *entry;
+	struct device *dev;
+	struct pci_dev *pdev;
+	int i, max, ret;
+
+	minsz = offsetofend(struct kvm_vfio_dev_irq, count);
+
+	if (copy_from_user(&pi_info, (void __user *)argp, minsz))
+		return -EFAULT;
+
+	if (pi_info.argsz < minsz || pi_info.index >= VFIO_PCI_NUM_IRQS)
+		return -EINVAL;
+
+	vdev = kvm_vfio_get_vfio_device(pi_info.fd);
+	if (IS_ERR(vdev))
+		return PTR_ERR(vdev);
+
+	dev = kvm_vfio_external_base_device(vdev);
+	if (!dev || !dev_is_pci(dev)) {
+		ret = -EFAULT;
+		goto put_vfio_device;
+	}
+
+	pdev = to_pci_dev(dev);
+
+	max = kvm_vfio_pci_get_irq_count(pdev, pi_info.index);
+	if (max <= 0) {
+		ret = -EFAULT;
+		goto put_vfio_device;
+	}
+
+	if (pi_info.argsz - minsz < pi_info.count * sizeof(u32) ||
+	    pi_info.start >= max || pi_info.start + pi_info.count > max) {
+		ret = -EINVAL;
+		goto put_vfio_device;
+	}
+
+	gsi = memdup_user((void __user *)((unsigned long)argp + minsz),
+			   pi_info.count * sizeof(u32));
+	if (IS_ERR(gsi)) {
+		ret = PTR_ERR(gsi);
+		goto put_vfio_device;
+	}
+
+#ifdef CONFIG_PCI_MSI
+	for (i = 0; i < pi_info.count; i++) {
+		list_for_each_entry(entry, &pdev->msi_list, list) {
+			if (entry->msi_attrib.entry_nr != pi_info.start+i)
+				continue;
+
+			ret = kvm_arch_vfio_update_pi_irte(kdev->kvm,
+							   entry->irq,
+							   gsi[i],
+							   set);
+			if (ret)
+				goto free_gsi;
+		}
+	}
+#endif
+
+	ret = 0;
+
+free_gsi:
+	kfree(gsi);
+
+put_vfio_device:
+	kvm_vfio_put_vfio_device(vdev);
+	return ret;
+}
+
 static int kvm_vfio_set_device(struct kvm_device *kdev, long attr, u64 arg)
 {
 	int32_t __user *argp = (int32_t __user *)(unsigned long)arg;
@@ -456,6 +549,14 @@ static int kvm_vfio_set_device(struct kvm_device *kdev, long attr, u64 arg)
 	case KVM_DEV_VFIO_DEVICE_UNFORWARD_IRQ:
 		ret = kvm_vfio_control_irq_forward(kdev, attr, argp);
 		break;
+#ifdef __KVM_HAVE_ARCH_KVM_VFIO_POST
+	case KVM_DEV_VFIO_DEVICE_POST_IRQ:
+		ret = kvm_vfio_control_pi(kdev, argp, 1);
+		break;
+	case KVM_DEV_VFIO_DEVICE_UNPOST_IRQ:
+		ret = kvm_vfio_control_pi(kdev, argp, 0);
+		break;
+#endif
 	default:
 		ret = -ENXIO;
 	}
@@ -511,6 +612,12 @@ static int kvm_vfio_has_attr(struct kvm_device *dev,
 		case KVM_DEV_VFIO_DEVICE_UNFORWARD_IRQ:
 			return 0;
 #endif
+#ifdef __KVM_HAVE_ARCH_KVM_VFIO_POST
+		case KVM_DEV_VFIO_DEVICE_POST_IRQ:
+		case KVM_DEV_VFIO_DEVICE_UNPOST_IRQ:
+			return 0;
+#endif
+
 		}
 		break;
 	}
-- 
1.9.1
