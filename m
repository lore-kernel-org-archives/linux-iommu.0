Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B583DA7D4
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556124; cv=none; b=t57SzHscje0jZEELpy/QQR8yl7IjJF64ziI7rH8CBnnpZGfVGPMXmm0H5rrnZeImPQk9bqIStbW7uMsKxlPAGR6TLhI5JV2vvYKbIF5Q9p8WL8e0lMaRCyWPgRnJ8IrZkoa9FLX6lARsdEh6ujhnAwOqTDxLm8AVH3QqCrvW874=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556124; c=relaxed/simple;
	bh=lxfDI/CI5VlYeUePE7k6ldgnppsOlKa/jNLXmGk3OZM=;
	h=Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type; b=Rg2mCQzXTrB+TqfXnMVaFnWl8HFukr7s6sN118Sevd6sPz+K6CYnDRAM8UZQefmCas6feZ0W2sDoDdqWcw+FDzccoKWXfgGpMvZIY8RGHZRDA46Aqtk0+LXtzDvPpKEZFVABBlI7K0JpDbNCP2VGDdOjWXtxRfD7+NU+5IsEZpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4gWFgn4Mv7z5B13c;
	Thu, 04 Jun 2026 14:55:17 +0800 (CST)
Received: from szxlzmapp01.zte.com.cn ([10.5.231.85])
	by mse-fl2.zte.com.cn with SMTP id 6546t9Gn017570;
	Thu, 4 Jun 2026 14:55:09 +0800 (+08)
	(envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp04[null])
	by mapi (Zmail) with MAPI id mid12;
	Thu, 4 Jun 2026 14:55:10 +0800 (CST)
X-Zmail-TransId: 2b066a21214ec27-b4cdb
X-Mailer: Zmail v1.0
Message-ID: <20260604145510898G2kTwM2Pr25QE5H8T4Wh6@zte.com.cn>
Date: Thu, 4 Jun 2026 14:55:10 +0800 (CST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <linux-acpi@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
Cc: <sunilvl@ventanamicro.com>, <rafael@kernel.org>, <lenb@kernel.org>,
        <pjw@kernel.org>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <alex@ghiti.fr>, <tomasz.jeznach@linux.dev>
Subject: =?UTF-8?B?W1BBVENIXSBpb21tdS9yaXNjdjogQWRkIGRlcGVuZGVuY3kgYmV0d2VlbiBpb21tdSBhbmQgZGV2aWNlcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6546t9Gn017570
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 04 Jun 2026 14:55:17 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A212155.001/4gWFgn4Mv7z5B13c

From: Wang Yechao <wang.yechao255@zte.com.cn>

Commit 9156585280f1 ("ACPI: RIMT: Add dependency between iommu and
devices") adds the dependency between iommu and devices on ACPI
systems. On devicetree systems, the incorrect removal order also
occurs.

It can be reproduced on the QEMU RISC-V machine if the kernel enables
IOMMU_DMA:

[  635.081530] e1000e: EEE TX LPI TIMER: 00000000
[  656.100306] rcu: INFO: rcu_sched self-detected stall on CPU
[  656.101374] rcu:     5-....: (5250 ticks this GP) idle=d774/1/0x4000000000000000 softirq=5173/5185 fqs=2625
[  656.102237] rcu:     (t=5251 jiffies g=36825 q=101 ncpus=16)
[  656.103801] CPU: 5 UID: 0 PID: 1958 Comm: reboot Tainted: G        W           7.1.0-rc5 #31 PREEMPTLAZY
[  656.104127] Tainted: [W]=WARN
[  656.104182] Hardware name: QEMU QEMU Virtual Machine, BIOS 2.7 02/02/2022
[  656.104339] epc : riscv_iommu_cmd_sync.constprop.0+0xb8/0x148
[  656.105352]  ra : riscv_iommu_cmd_sync.constprop.0+0xa8/0x148
[  656.105433] epc : ffffffff807ca980 ra : ffffffff807ca970 sp : ff60000085dbf960
[  656.105475]  gp : ffffffff81e0d798 tp : ff60000084b58e00 t0 : ffffffff80021048
[  656.105514]  t1 : ff60000081b18400 t2 : 45203a6530303031 s0 : ff60000085dbf9c0
[  656.105554]  s1 : 00000098c92a567c a0 : 00000098c03986f0 a1 : ff60000085dbf970
[  656.105594]  a2 : 000024bb5cac6aee a3 : ff200000004f1000 a4 : ff6000008140a040
[  656.105632]  a5 : 0000000000000669 a6 : 0000000000000000 a7 : 00000000ffffa000
[  656.105669]  s2 : 0000000000000000 s3 : 00000098c0398308 s4 : 000000000000066a
[  656.105706]  s5 : 0000000008f0d180 s6 : 000000a8d08b8de9 s7 : 0000000000001fff
[  656.105743]  s8 : ff6000008140a040 s9 : ff6000008484cb00 s10: ff200000005cc000
[  656.105781]  s11: ff600000814652a0 t3 : 000000f000000000 t4 : 0000000000000000
[  656.105845]  t5 : 0000000000000003 t6 : ff600000841666b0 ssp : 0000000000000000
[  656.105883] status: 0000000200000120 badaddr: 0000000000000000 cause: 8000000000000005
[  656.106072] riscv_iommu_cmd_sync.constprop.0+0xb8/0x148
[  656.106321] riscv_iommu_iotlb_inval+0x120/0x160
[  656.106373] riscv_iommu_iotlb_sync+0x48/0x60
[  656.106422] __iommu_dma_unmap+0xca/0xf8
[  656.106470] iommu_dma_unmap_phys+0x58/0xc8
[  656.106517] dma_unmap_phys+0x15c/0x248
[  656.106564] dma_unmap_page_attrs+0x1e/0x30
[  656.106915] e1000_clean_rx_ring+0x1d2/0x200 [e1000e]
[  656.107668] e1000e_down+0x168/0x1c8 [e1000e]
[  656.107995] e1000e_pm_freeze+0x94/0x128 [e1000e]
[  656.108328] e1000_shutdown+0x28/0x48 [e1000e]
[  656.108652] pci_device_shutdown+0x34/0x48
[  656.108706] device_shutdown+0x104/0x1e8
[  656.108752] kernel_restart+0x46/0xb8
[  656.108797] __do_sys_reboot+0xc0/0x1c8
[  656.108840] __riscv_sys_reboot+0x22/0x38
[  656.108882] do_trap_ecall_u+0x236/0x3f8
[  656.108947] handle_exception+0x15a/0x166

So move the device link into the iommu driver to fix both ACPI and
devicetree systems.

Fixes: 488ffbf18171 ("iommu/riscv: Paging domain support")
Signed-off-by: Wang Yechao <wang.yechao255@zte.com.cn>
---
 drivers/acpi/riscv/rimt.c   | 7 -------
 drivers/iommu/riscv/iommu.c | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
index 906282b0e63c..229c4a0d47a3 100644
--- a/drivers/acpi/riscv/rimt.c
+++ b/drivers/acpi/riscv/rimt.c
@@ -263,13 +263,6 @@ static int rimt_iommu_xlate(struct device *dev, struct acpi_rimt_node *node, u32
 	if (!rimt_fwnode)
 		return -EPROBE_DEFER;

-	/*
-	 * EPROBE_DEFER ensures IOMMU is probed before the devices that
-	 * depend on them. During shutdown, however, the IOMMU may be removed
-	 * first, leading to issues. To avoid this, a device link is added
-	 * which enforces the correct removal order.
-	 */
-	device_link_add(dev, rimt_fwnode->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
 	return acpi_iommu_fwspec_init(dev, deviceid, rimt_fwnode);
 }

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index a31f50bbad35..f9368e977346 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -1385,6 +1385,13 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)

 	dev_iommu_priv_set(dev, info);

+	/*
+	 * During shutdown, however, the IOMMU may be removed first, leading
+	 * to issues. To avoid this, a device link is added which enforces
+	 * the correct removal order.
+	 */
+	device_link_add(dev, fwspec->iommu_fwnode->dev, DL_FLAG_AUTOREMOVE_CONSUMER);
+
 	return &iommu->iommu;
 }

-- 
2.43.5
