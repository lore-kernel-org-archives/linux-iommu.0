Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4806BC433E6
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 09:10:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF66464E27
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 09:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF66464E27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 300EE87498;
	Fri, 29 Jan 2021 09:10:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Phkf+pzRCSYn; Fri, 29 Jan 2021 09:10:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B860F87497;
	Fri, 29 Jan 2021 09:10:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93466C1E6F;
	Fri, 29 Jan 2021 09:10:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2FF4C013A
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 09:10:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CF89687490
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 09:10:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 10dZK+haUgZj for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 09:10:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 65AA686113
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 09:10:46 +0000 (UTC)
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DRs3Y4714z160br;
 Fri, 29 Jan 2021 17:09:29 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Fri, 29 Jan 2021 17:10:36 +0800
From: Zhou Wang <wangzhou1@hisilicon.com>
To: Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>
Subject: [RFC PATCH 3/3] iommu/arm-smmu-v3: Add debug interfaces for SMMUv3
Date: Fri, 29 Jan 2021 17:06:24 +0800
Message-ID: <1611911184-116261-4-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1611911184-116261-1-git-send-email-wangzhou1@hisilicon.com>
References: <1611911184-116261-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

This patch adds debug interfaces for SMMUv3 driver in sysfs. It adds debug
related files under /sys/kernel/debug/iommu/smmuv3.

User should firstly set device and pasid to pci_dev and pasid by:
(currently only support PCI device)
echo <domain>:<bus>:<dev>.<fun> > /sys/kernel/debug/iommu/smmuv3/pci_dev
echo <pasid> > /sys/kernel/debug/iommu/smmuv3/pasid

Then value in cd and ste can be got by:
cat /sys/kernel/debug/iommu/smmuv3/ste
cat /sys/kernel/debug/iommu/smmuv3/cd

S1 and S2 page tables can be got by:
cat /sys/kernel/debug/iommu/smmuv3/pt_dump_s1
cat /sys/kernel/debug/iommu/smmuv3/pt_dump_s2

For ste, cd and page table, related device and pasid are set in pci_dev and
pasid files as above.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 drivers/iommu/Kconfig                       |  11 +
 drivers/iommu/arm/arm-smmu-v3/Makefile      |   1 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   3 +
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   8 +
 drivers/iommu/arm/arm-smmu-v3/debugfs.c     | 398 ++++++++++++++++++++++++++++
 5 files changed, 421 insertions(+)
 create mode 100644 drivers/iommu/arm/arm-smmu-v3/debugfs.c

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 192ef8f..4822c88 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -325,6 +325,17 @@ config ARM_SMMU_V3_SVA
 	  Say Y here if your system supports SVA extensions such as PCIe PASID
 	  and PRI.
 
+config ARM_SMMU_V3_DEBUGFS
+	bool "Export ARM SMMUv3 internals in Debugfs"
+	depends on ARM_SMMU_V3 && IOMMU_DEBUGFS
+	help
+	  DO NOT ENABLE THIS OPTION UNLESS YOU REALLY KNOW WHAT YOU ARE DOING!
+
+	  Expose ARM SMMUv3 internals in Debugfs.
+
+	  This option is -NOT- intended for production environments, and should
+	  only be enabled for debugging ARM SMMUv3.
+
 config S390_IOMMU
 	def_bool y if S390 && PCI
 	depends on S390 && PCI
diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
index 54feb1ec..55b411a 100644
--- a/drivers/iommu/arm/arm-smmu-v3/Makefile
+++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
 arm_smmu_v3-objs-y += arm-smmu-v3.o
 arm_smmu_v3-objs-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
 arm_smmu_v3-objs := $(arm_smmu_v3-objs-y)
+obj-$(CONFIG_ARM_SMMU_V3_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b65f63e2..aac7fdb 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3602,6 +3602,8 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	arm_smmu_debugfs_init();
+
 	return arm_smmu_set_bus_ops(&arm_smmu_ops);
 }
 
@@ -3610,6 +3612,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
 	arm_smmu_set_bus_ops(NULL);
+	arm_smmu_debugfs_uninit();
 	iommu_device_unregister(&smmu->iommu);
 	iommu_device_sysfs_remove(&smmu->iommu);
 	arm_smmu_device_disable(smmu);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 3e7af39..31c4580 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -752,4 +752,12 @@ static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
 
 static inline void arm_smmu_sva_notifier_synchronize(void) {}
 #endif /* CONFIG_ARM_SMMU_V3_SVA */
+
+#ifdef CONFIG_ARM_SMMU_V3_DEBUGFS
+void arm_smmu_debugfs_init(void);
+void arm_smmu_debugfs_uninit(void);
+#else
+static inline void arm_smmu_debugfs_init(void) {}
+static inline void arm_smmu_debugfs_uninit(void) {}
+#endif /* CONFIG_ARM_SMMU_V3_DEBUGFS */
 #endif /* _ARM_SMMU_V3_H */
diff --git a/drivers/iommu/arm/arm-smmu-v3/debugfs.c b/drivers/iommu/arm/arm-smmu-v3/debugfs.c
new file mode 100644
index 0000000..1af219a
--- /dev/null
+++ b/drivers/iommu/arm/arm-smmu-v3/debugfs.c
@@ -0,0 +1,398 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/debugfs.h>
+#include <linux/iommu.h>
+#include <linux/io-pgtable.h>
+#include <linux/pci.h>
+#include "arm-smmu-v3.h"
+#include "../../io-pgtable-arm.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt)	"SMMUv3 debug: " fmt
+
+#define NAME_BUF_LEN 32
+
+static struct dentry *arm_smmu_debug;
+static char dump_pci_dev[NAME_BUF_LEN];
+static u32 pasid;
+static struct mutex lock;
+
+static ssize_t master_pdev_read(struct file *filp, char __user *buf,
+				size_t count, loff_t *pos)
+{
+	char pdev_name[NAME_BUF_LEN];
+	char name[NAME_BUF_LEN];
+	int ret;
+
+	mutex_lock(&lock);
+	strncpy(pdev_name, dump_pci_dev, NAME_BUF_LEN);
+	mutex_unlock(&lock);
+
+	if (!strlen(pdev_name)) {
+		pr_err("Please set pci_dev firstly\n");
+		return 0;
+	}
+
+	ret = scnprintf(name, NAME_BUF_LEN, "%s\n", pdev_name);
+	return simple_read_from_buffer(buf, count, pos, name, ret);
+}
+
+static ssize_t master_pdev_write(struct file *filp, const char __user *buf,
+				 size_t count, loff_t *pos)
+{
+	char name[NAME_BUF_LEN];
+	struct device *dev;
+	int len;
+
+	if (*pos != 0)
+		return 0;
+
+	if (count >= NAME_BUF_LEN)
+		return -ENOSPC;
+
+	len = simple_write_to_buffer(name, NAME_BUF_LEN - 1, pos, buf, count);
+	if (len < 0)
+		return len;
+	name[len] = '\0';
+
+	dev = bus_find_device_by_name(&pci_bus_type, NULL, name);
+	if (!dev) {
+		pr_err("Failed to find device\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&lock);
+	strncpy(dump_pci_dev, dev_name(dev), NAME_BUF_LEN);
+	mutex_unlock(&lock);
+
+	put_device(dev);
+
+	return count;
+}
+
+static const struct file_operations master_pdev_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.read = master_pdev_read,
+	.write = master_pdev_write,
+};
+
+static struct arm_smmu_master *arm_smmu_get_master(struct device *dev)
+{
+	struct arm_smmu_master *master;
+
+	if (!dev->iommu) {
+		pr_err("master device driver may not be loaded!\n");
+		return NULL;
+	}
+
+	master = dev_iommu_priv_get(dev);
+	if (!master) {
+		pr_err("Failed to find master dev\n");
+		return NULL;
+	}
+
+	return master;
+}
+
+static void ste_dump(struct seq_file *m, struct device *dev, __le64 *ste)
+{
+	int i;
+
+	seq_printf(m, "SMMUv3 STE values for device: %s\n", dev_name(dev));
+	for (i = 0; i < STRTAB_STE_DWORDS; i++) {
+		seq_printf(m, "0x%016llx\n", *ste);
+		ste++;
+	}
+}
+
+static int ste_show(struct seq_file *m, void *unused)
+{
+	struct arm_smmu_master *master;
+	struct arm_smmu_device *smmu;
+	struct device *dev;
+	__le64 *ste;
+
+	mutex_lock(&lock);
+
+	dev = bus_find_device_by_name(&pci_bus_type, NULL, dump_pci_dev);
+	if (!dev) {
+		mutex_unlock(&lock);
+		pr_err("Failed to find device\n");
+		return -EINVAL;
+	}
+
+	master = arm_smmu_get_master(dev);
+	if (!master) {
+		put_device(dev);
+		mutex_unlock(&lock);
+		return -ENODEV;
+	}
+	smmu = master->smmu;
+
+	/* currently only support one master one sid */
+	ste = arm_smmu_get_step_for_sid(smmu, master->sids[0]);
+	ste_dump(m, dev, ste);
+
+	put_device(dev);
+	mutex_unlock(&lock);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ste);
+
+static void cd_dump(struct seq_file *m, struct device *dev, __le64 *cd)
+{
+	int i;
+
+	seq_printf(m, "SMMUv3 CD values for device: %s, ssid: 0x%x\n",
+		   dev_name(dev), pasid);
+	for (i = 0; i < CTXDESC_CD_DWORDS; i++) {
+		seq_printf(m, "0x%016llx\n", *cd);
+		cd++;
+	}
+}
+
+static int cd_show(struct seq_file *m, void *unused)
+{
+	struct arm_smmu_master *master;
+	struct arm_smmu_domain *domain;
+	struct device *dev;
+	__le64 *cd;
+	int ret;
+
+	mutex_lock(&lock);
+
+	dev = bus_find_device_by_name(&pci_bus_type, NULL, dump_pci_dev);
+	if (!dev) {
+		mutex_unlock(&lock);
+		pr_err("Failed to find device\n");
+		return -EINVAL;
+	}
+
+	master = arm_smmu_get_master(dev);
+	if (!master) {
+		ret = -ENODEV;
+		goto err_out;
+	}
+	domain = master->domain;
+
+	cd = arm_smmu_get_cd_ptr(domain, pasid);
+	if (!cd) {
+		ret = -EINVAL;
+		pr_err("Failed to find cd(ssid: %u)\n", pasid);
+		goto err_out;
+	}
+	cd_dump(m, dev, cd);
+
+	put_device(dev);
+	mutex_unlock(&lock);
+
+	return 0;
+
+err_out:
+	put_device(dev);
+	mutex_unlock(&lock);
+	return ret;
+}
+DEFINE_SHOW_ATTRIBUTE(cd);
+
+static void __ptdump(arm_lpae_iopte *ptep, int lvl, u64 va,
+		     struct arm_lpae_io_pgtable *data, struct seq_file *m)
+{
+	arm_lpae_iopte pte, *ptep_next;
+	u64 i, tmp_va = 0;
+	int entry_num;
+
+	entry_num = 1 << (data->bits_per_level + ARM_LPAE_PGD_IDX(lvl, data));
+
+	for (i = 0; i < entry_num; i++) {
+		pte = READ_ONCE(*(ptep + i));
+		if (!pte)
+			continue;
+
+		tmp_va = va | (i << ARM_LPAE_LVL_SHIFT(lvl, data));
+
+		if (iopte_leaf(pte, lvl, data->iop.fmt)) {
+			/* To do: print prot */
+			seq_printf(m, "va: %llx -> pa: %llx\n", tmp_va,
+				   iopte_to_paddr(pte, data));
+			continue;
+		}
+
+		ptep_next = iopte_deref(pte, data);
+		__ptdump(ptep_next, lvl + 1, tmp_va, data, m);
+	}
+}
+
+static void ptdump(struct seq_file *m, struct arm_smmu_domain *domain,
+		   void *pgd, int stage)
+{
+	struct arm_lpae_io_pgtable *data, data_sva;
+	int levels, va_bits, bits_per_level;
+	struct io_pgtable_ops *ops;
+	arm_lpae_iopte *ptep = pgd;
+
+	if (stage == 1 && !pasid) {
+		ops = domain->pgtbl_ops;
+		data = io_pgtable_ops_to_data(ops);
+	} else {
+		va_bits = VA_BITS - PAGE_SHIFT;
+		bits_per_level = PAGE_SHIFT - ilog2(sizeof(arm_lpae_iopte));
+		levels = DIV_ROUND_UP(va_bits, bits_per_level);
+
+		data_sva.start_level = ARM_LPAE_MAX_LEVELS - levels;
+		data_sva.pgd_bits = va_bits - (bits_per_level * (levels - 1));
+		data_sva.bits_per_level = bits_per_level;
+		data_sva.pgd = pgd;
+
+		data = &data_sva;
+	}
+
+	__ptdump(ptep, data->start_level, 0, data, m);
+}
+
+static int pt_dump_s1_show(struct seq_file *m, void *unused)
+{
+	struct arm_smmu_master *master;
+	struct arm_smmu_domain *domain;
+	struct device *dev;
+	__le64 *cd;
+	void *pgd;
+	u64 ttbr;
+	int ret;
+
+	mutex_lock(&lock);
+
+	dev = bus_find_device_by_name(&pci_bus_type, NULL, dump_pci_dev);
+	if (!dev) {
+		mutex_unlock(&lock);
+		pr_err("Failed to find device\n");
+		return -EINVAL;
+	}
+
+	master = arm_smmu_get_master(dev);
+	if (!master) {
+		ret = -ENODEV;
+		goto err_out;
+	}
+	domain = master->domain;
+
+	cd = arm_smmu_get_cd_ptr(domain, pasid);
+	if (!cd || !(le64_to_cpu(cd[0]) & CTXDESC_CD_0_V)) {
+		ret = -EINVAL;
+		pr_err("Failed to find valid cd(ssid: %u)\n", pasid);
+		goto err_out;
+	}
+
+	/* CD0 and other CDx are all using ttbr0 */
+	ttbr = le64_to_cpu(cd[1]) & CTXDESC_CD_1_TTB0_MASK;
+	pgd = phys_to_virt(ttbr);
+
+	if (ttbr) {
+		seq_printf(m, "SMMUv3 dump page table for device %s, stage 1, ssid 0x%x:\n",
+			   dev_name(dev), pasid);
+		ptdump(m, domain, pgd, 1);
+	}
+
+	put_device(dev);
+	mutex_unlock(&lock);
+
+	return 0;
+
+err_out:
+	put_device(dev);
+	mutex_unlock(&lock);
+	return ret;
+}
+DEFINE_SHOW_ATTRIBUTE(pt_dump_s1);
+
+static int pt_dump_s2_show(struct seq_file *m, void *unused)
+{
+	struct arm_smmu_master *master;
+	struct arm_smmu_device *smmu;
+	struct device *dev;
+	__le64 *ste;
+	u64 vttbr;
+	void *pgd;
+	int ret;
+
+	mutex_lock(&lock);
+
+	dev = bus_find_device_by_name(&pci_bus_type, NULL, dump_pci_dev);
+	if (!dev) {
+		mutex_unlock(&lock);
+		pr_err("Failed to find device\n");
+		return -EINVAL;
+	}
+
+	master = arm_smmu_get_master(dev);
+	if (!master) {
+		ret = -ENODEV;
+		goto err_out;
+	}
+	smmu = master->smmu;
+
+	/* currently only support one master one sid */
+	ste = arm_smmu_get_step_for_sid(smmu, master->sids[0]);
+	if (!(le64_to_cpu(ste[0]) & (1UL << 2))) {
+		ret = -EINVAL;
+		pr_err("Stage 2 translation is not valid\n");
+		goto err_out;
+	}
+
+	vttbr = le64_to_cpu(ste[3]) & STRTAB_STE_3_S2TTB_MASK;
+	pgd = phys_to_virt(vttbr);
+
+	if (vttbr) {
+		seq_printf(m, "SMMUv3 dump page table for device %s, stage 2:\n",
+			   dev_name(dev));
+		ptdump(m, 0, pgd, 2);
+	}
+
+	put_device(dev);
+	mutex_unlock(&lock);
+
+	return 0;
+
+err_out:
+	put_device(dev);
+	mutex_unlock(&lock);
+	return ret;
+}
+DEFINE_SHOW_ATTRIBUTE(pt_dump_s2);
+
+void arm_smmu_debugfs_init(void)
+{
+	mutex_init(&lock);
+
+	arm_smmu_debug = debugfs_create_dir("smmuv3", iommu_debugfs_dir);
+
+	debugfs_create_file("pci_dev", 0644, arm_smmu_debug, NULL,
+			    &master_pdev_fops);
+	/*
+	 * Problem here is we need to know dump which cd, currently my idea
+	 * is we can get related pasid by smmu_bond_get trace point or by
+	 * debug interface of master device specific driver, then here we
+	 * use pasid to dump related cd.
+	 *
+	 * Or there is no need to dump page table about s1(pasid != 0) and s2
+	 * as they can be got by /proc/<pid>/pagemap.
+	 */
+	debugfs_create_u32("pasid", 0644, arm_smmu_debug, &pasid);
+
+	debugfs_create_file("ste", 0444, arm_smmu_debug, NULL, &ste_fops);
+
+	debugfs_create_file("cd", 0444, arm_smmu_debug, NULL, &cd_fops);
+
+	debugfs_create_file("pt_dump_s1", 0444, arm_smmu_debug, NULL,
+			    &pt_dump_s1_fops);
+
+	debugfs_create_file("pt_dump_s2", 0444, arm_smmu_debug, NULL,
+			    &pt_dump_s2_fops);
+}
+
+void arm_smmu_debugfs_uninit(void)
+{
+	debugfs_remove_recursive(arm_smmu_debug);
+	mutex_destroy(&lock);
+}
-- 
2.8.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
