From: Jann Horn <jannh@google.com>
Subject: [PATCH] x86/calgary: fix bitcast type warnings
Date: Thu, 28 Mar 2019 23:59:25 +0100
Message-ID: <20190328225925.241998-1-jannh@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, jannh@google.com
Cc: x86@kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

The sparse checker attempts to ensure that all conversions between
fixed-endianness numbers and numbers with native endianness are explicit.
However, the calgary code reads and writes big-endian numbers from/to IO
memory using {read,write}{l,q}(), which return native-endian numbers.

This could be addressed by putting __force casts all over the place, but
that would kind of defeat the point of the warning. Instead, create new
helpers {read,write}{l,q}_be() for big-endian IO that convert from/to
native endianness.

Most of this patch is a straightforward conversion; the following parts
aren't just mechanical replacement:

 - ->tar_val is now a native-endian number instead of big-endian
 - calioc2_handle_quirks() did `cpu_to_be32(readl(target))` when it
   intended to do `be32_to_cpu(readl(target))` (but that has no actual
   effects outside of type warnings)

This gets rid of 108 lines of sparse warnings.

Signed-off-by: Jann Horn <jannh@google.com>
---
compile-tested only

 arch/x86/kernel/pci-calgary_64.c | 108 ++++++++++++++++++-------------
 1 file changed, 64 insertions(+), 44 deletions(-)

diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
index c70720f61a34..36cd66d940fb 100644
--- a/arch/x86/kernel/pci-calgary_64.c
+++ b/arch/x86/kernel/pci-calgary_64.c
@@ -534,6 +534,26 @@ static inline int is_cal_pci_dev(unsigned short device)
 	return (is_calgary(device) || is_calioc2(device));
 }
 
+static inline u32 readl_be(const void __iomem *addr)
+{
+	return be32_to_cpu((__force __be32)readl(addr));
+}
+
+static inline u64 readq_be(const void __iomem *addr)
+{
+	return be64_to_cpu((__force __be64)readq(addr));
+}
+
+static inline void writel_be(u32 val, void __iomem *addr)
+{
+	writel((__force u32)cpu_to_be32(val), addr);
+}
+
+static inline void writeq_be(u64 val, void __iomem *addr)
+{
+	writeq((__force u64)cpu_to_be64(val), addr);
+}
+
 static void calgary_tce_cache_blast(struct iommu_table *tbl)
 {
 	u64 val;
@@ -562,7 +582,7 @@ static void calgary_tce_cache_blast(struct iommu_table *tbl)
 
 	/* invalidate TCE cache */
 	target = calgary_reg(bbar, tar_offset(tbl->it_busno));
-	writeq(tbl->tar_val, target);
+	writeq_be(tbl->tar_val, target);
 
 	/* enable arbitration */
 	target = calgary_reg(bbar, phb_offset(tbl->it_busno) | PHB_AER_OFFSET);
@@ -586,11 +606,11 @@ static void calioc2_tce_cache_blast(struct iommu_table *tbl)
 
 	/* 1. using the Page Migration Control reg set SoftStop */
 	target = calgary_reg(bbar, phb_offset(bus) | PHB_PAGE_MIG_CTRL);
-	val = be32_to_cpu(readl(target));
+	val = readl_be(target);
 	printk(KERN_DEBUG "1a. read 0x%x [LE] from %p\n", val, target);
 	val |= PMR_SOFTSTOP;
 	printk(KERN_DEBUG "1b. writing 0x%x [LE] to %p\n", val, target);
-	writel(cpu_to_be32(val), target);
+	writel_be(val, target);
 
 	/* 2. poll split queues until all DMA activity is done */
 	printk(KERN_DEBUG "2a. starting to poll split queues\n");
@@ -604,7 +624,7 @@ static void calioc2_tce_cache_blast(struct iommu_table *tbl)
 
 	/* 3. poll Page Migration DEBUG for SoftStopFault */
 	target = calgary_reg(bbar, phb_offset(bus) | PHB_PAGE_MIG_DEBUG);
-	val = be32_to_cpu(readl(target));
+	val = readl_be(target);
 	printk(KERN_DEBUG "3. read 0x%x [LE] from %p\n", val, target);
 
 	/* 4. if SoftStopFault - goto (1) */
@@ -620,21 +640,21 @@ static void calioc2_tce_cache_blast(struct iommu_table *tbl)
 	/* 5. Slam into HardStop by reading PHB_PAGE_MIG_CTRL */
 	target = calgary_reg(bbar, phb_offset(bus) | PHB_PAGE_MIG_CTRL);
 	printk(KERN_DEBUG "5a. slamming into HardStop by reading %p\n", target);
-	val = be32_to_cpu(readl(target));
+	val = readl_be(target);
 	printk(KERN_DEBUG "5b. read 0x%x [LE] from %p\n", val, target);
 	target = calgary_reg(bbar, phb_offset(bus) | PHB_PAGE_MIG_DEBUG);
-	val = be32_to_cpu(readl(target));
+	val = readl_be(target);
 	printk(KERN_DEBUG "5c. read 0x%x [LE] from %p (debug)\n", val, target);
 
 	/* 6. invalidate TCE cache */
 	printk(KERN_DEBUG "6. invalidating TCE cache\n");
 	target = calgary_reg(bbar, tar_offset(bus));
-	writeq(tbl->tar_val, target);
+	writeq_be(tbl->tar_val, target);
 
 	/* 7. Re-read PMCR */
 	printk(KERN_DEBUG "7a. Re-reading PMCR\n");
 	target = calgary_reg(bbar, phb_offset(bus) | PHB_PAGE_MIG_CTRL);
-	val = be32_to_cpu(readl(target));
+	val = readl_be(target);
 	printk(KERN_DEBUG "7b. read 0x%x [LE] from %p\n", val, target);
 
 	/* 8. Remove HardStop */
@@ -642,8 +662,8 @@ static void calioc2_tce_cache_blast(struct iommu_table *tbl)
 	target = calgary_reg(bbar, phb_offset(bus) | PHB_PAGE_MIG_CTRL);
 	val = 0;
 	printk(KERN_DEBUG "8b. writing 0x%x [LE] to %p\n", val, target);
-	writel(cpu_to_be32(val), target);
-	val = be32_to_cpu(readl(target));
+	writel_be(val, target);
+	val = readl_be(target);
 	printk(KERN_DEBUG "8c. read 0x%x [LE] from %p\n", val, target);
 }
 
@@ -670,11 +690,11 @@ static void __init calgary_reserve_peripheral_mem_1(struct pci_dev *dev)
 
 	/* peripheral MEM_1 region */
 	target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_1_LOW);
-	low = be32_to_cpu(readl(target));
+	low = readl_be(target);
 	target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_1_HIGH);
-	high = be32_to_cpu(readl(target));
+	high = readl_be(target);
 	target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_1_SIZE);
-	sizelow = be32_to_cpu(readl(target));
+	sizelow = readl_be(target);
 
 	start = (high << 32) | low;
 	limit = sizelow;
@@ -694,18 +714,18 @@ static void __init calgary_reserve_peripheral_mem_2(struct pci_dev *dev)
 
 	/* is it enabled? */
 	target = calgary_reg(bbar, phb_offset(busnum) | PHB_CONFIG_RW_OFFSET);
-	val32 = be32_to_cpu(readl(target));
+	val32 = readl_be(target);
 	if (!(val32 & PHB_MEM2_ENABLE))
 		return;
 
 	target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_2_LOW);
-	low = be32_to_cpu(readl(target));
+	low = readl_be(target);
 	target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_2_HIGH);
-	high = be32_to_cpu(readl(target));
+	high = readl_be(target);
 	target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_2_SIZE_LOW);
-	sizelow = be32_to_cpu(readl(target));
+	sizelow = readl_be(target);
 	target = calgary_reg(bbar, phb_offset(busnum) | PHB_MEM_2_SIZE_HIGH);
-	sizehigh = be32_to_cpu(readl(target));
+	sizehigh = readl_be(target);
 
 	start = (high << 32) | low;
 	limit = (sizehigh << 32) | sizelow;
@@ -774,7 +794,7 @@ static int __init calgary_setup_tar(struct pci_dev *dev, void __iomem *bbar)
 
 	/* set TARs for each PHB */
 	target = calgary_reg(bbar, tar_offset(dev->bus->number));
-	val64 = be64_to_cpu(readq(target));
+	val64 = readq_be(target);
 
 	/* zero out all TAR bits under sw control */
 	val64 &= ~TAR_SW_BITS;
@@ -785,9 +805,9 @@ static int __init calgary_setup_tar(struct pci_dev *dev, void __iomem *bbar)
 	BUG_ON(specified_table_size > TCE_TABLE_SIZE_8M);
 	val64 |= (u64) specified_table_size;
 
-	tbl->tar_val = cpu_to_be64(val64);
+	tbl->tar_val = val64;
 
-	writeq(tbl->tar_val, target);
+	writeq_be(tbl->tar_val, target);
 	readq(target); /* flush */
 
 	return 0;
@@ -801,9 +821,9 @@ static void __init calgary_free_bus(struct pci_dev *dev)
 	unsigned int bitmapsz;
 
 	target = calgary_reg(tbl->bbar, tar_offset(dev->bus->number));
-	val64 = be64_to_cpu(readq(target));
+	val64 = readq_be(target);
 	val64 &= ~TAR_SW_BITS;
-	writeq(cpu_to_be64(val64), target);
+	writeq_be(val64, target);
 	readq(target); /* flush */
 
 	bitmapsz = tbl->it_size / BITS_PER_BYTE;
@@ -825,10 +845,10 @@ static void calgary_dump_error_regs(struct iommu_table *tbl)
 	u32 csr, plssr;
 
 	target = calgary_reg(bbar, phb_offset(tbl->it_busno) | PHB_CSR_OFFSET);
-	csr = be32_to_cpu(readl(target));
+	csr = readl_be(target);
 
 	target = calgary_reg(bbar, phb_offset(tbl->it_busno) | PHB_PLSSR_OFFSET);
-	plssr = be32_to_cpu(readl(target));
+	plssr = readl_be(target);
 
 	/* If no error, the agent ID in the CSR is not valid */
 	pr_emerg("DMA error on Calgary PHB 0x%x, 0x%08x@CSR 0x%08x@PLSSR\n",
@@ -847,16 +867,16 @@ static void calioc2_dump_error_regs(struct iommu_table *tbl)
 
 	/* dump CSR */
 	target = calgary_reg(bbar, phboff | PHB_CSR_OFFSET);
-	csr = be32_to_cpu(readl(target));
+	csr = readl_be(target);
 	/* dump PLSSR */
 	target = calgary_reg(bbar, phboff | PHB_PLSSR_OFFSET);
-	plssr = be32_to_cpu(readl(target));
+	plssr = readl_be(target);
 	/* dump CSMR */
 	target = calgary_reg(bbar, phboff | 0x290);
-	csmr = be32_to_cpu(readl(target));
+	csmr = readl_be(target);
 	/* dump mck */
 	target = calgary_reg(bbar, phboff | 0x800);
-	mck = be32_to_cpu(readl(target));
+	mck = readl_be(target);
 
 	pr_emerg("DMA error on CalIOC2 PHB 0x%x\n", tbl->it_busno);
 
@@ -869,14 +889,14 @@ static void calioc2_dump_error_regs(struct iommu_table *tbl)
 		/* err regs are at 0x810 - 0x870 */
 		erroff = (0x810 + (i * 0x10));
 		target = calgary_reg(bbar, phboff | erroff);
-		errregs[i] = be32_to_cpu(readl(target));
+		errregs[i] = readl_be(target);
 		pr_cont("0x%08x@0x%lx ", errregs[i], erroff);
 	}
 	pr_cont("\n");
 
 	/* root complex status */
 	target = calgary_reg(bbar, phboff | PHB_ROOT_COMPLEX_STATUS);
-	rcstat = be32_to_cpu(readl(target));
+	rcstat = readl_be(target);
 	printk(KERN_EMERG "Calgary: 0x%08x@0x%x\n", rcstat,
 	       PHB_ROOT_COMPLEX_STATUS);
 }
@@ -889,7 +909,7 @@ static void calgary_watchdog(struct timer_list *t)
 	void __iomem *target;
 
 	target = calgary_reg(bbar, phb_offset(tbl->it_busno) | PHB_CSR_OFFSET);
-	val32 = be32_to_cpu(readl(target));
+	val32 = readl_be(target);
 
 	/* If no error, the agent ID in the CSR is not valid */
 	if (val32 & CSR_AGENT_MASK) {
@@ -901,9 +921,9 @@ static void calgary_watchdog(struct timer_list *t)
 		/* Disable bus that caused the error */
 		target = calgary_reg(bbar, phb_offset(tbl->it_busno) |
 				     PHB_CONFIG_RW_OFFSET);
-		val32 = be32_to_cpu(readl(target));
+		val32 = readl_be(target);
 		val32 |= PHB_SLOT_DISABLE;
-		writel(cpu_to_be32(val32), target);
+		writel_be(val32, target);
 		readl(target); /* flush */
 	} else {
 		/* Reset the timer */
@@ -933,13 +953,13 @@ static void __init calgary_set_split_completion_timeout(void __iomem *bbar,
 	}
 
 	target = calgary_reg(bbar, CALGARY_CONFIG_REG);
-	val64 = be64_to_cpu(readq(target));
+	val64 = readq_be(target);
 
 	/* zero out this PHB's timer bits */
 	mask = ~(0xFUL << phb_shift);
 	val64 &= mask;
 	val64 |= (timeout << phb_shift);
-	writeq(cpu_to_be64(val64), target);
+	writeq_be(val64, target);
 	readq(target); /* flush */
 }
 
@@ -954,9 +974,9 @@ static void __init calioc2_handle_quirks(struct iommu_table *tbl, struct pci_dev
 	 * CalIOC2 designers recommend setting bit 8 in 0xnDB0 to 1
 	 */
 	target = calgary_reg(bbar, phb_offset(busnum) | PHB_SAVIOR_L2);
-	val = cpu_to_be32(readl(target));
+	val = readl_be(target);
 	val |= 0x00800000;
-	writel(cpu_to_be32(val), target);
+	writel_be(val, target);
 }
 
 static void __init calgary_handle_quirks(struct iommu_table *tbl, struct pci_dev *dev)
@@ -986,7 +1006,7 @@ static void __init calgary_enable_translation(struct pci_dev *dev)
 
 	/* enable TCE in PHB Config Register */
 	target = calgary_reg(bbar, phb_offset(busnum) | PHB_CONFIG_RW_OFFSET);
-	val32 = be32_to_cpu(readl(target));
+	val32 = readl_be(target);
 	val32 |= PHB_TCE_ENABLE | PHB_DAC_DISABLE | PHB_MCSR_ENABLE;
 
 	printk(KERN_INFO "Calgary: enabling translation on %s PHB %#x\n",
@@ -995,7 +1015,7 @@ static void __init calgary_enable_translation(struct pci_dev *dev)
 	printk(KERN_INFO "Calgary: errant DMAs will now be prevented on this "
 	       "bus.\n");
 
-	writel(cpu_to_be32(val32), target);
+	writel_be(val32, target);
 	readl(target); /* flush */
 
 	timer_setup(&tbl->watchdog_timer, calgary_watchdog, 0);
@@ -1016,11 +1036,11 @@ static void __init calgary_disable_translation(struct pci_dev *dev)
 
 	/* disable TCE in PHB Config Register */
 	target = calgary_reg(bbar, phb_offset(busnum) | PHB_CONFIG_RW_OFFSET);
-	val32 = be32_to_cpu(readl(target));
+	val32 = readl_be(target);
 	val32 &= ~(PHB_TCE_ENABLE | PHB_DAC_DISABLE | PHB_MCSR_ENABLE);
 
 	printk(KERN_INFO "Calgary: disabling translation on PHB %#x!\n", busnum);
-	writel(cpu_to_be32(val32), target);
+	writel_be(val32, target);
 	readl(target); /* flush */
 
 	del_timer_sync(&tbl->watchdog_timer);
@@ -1096,7 +1116,7 @@ static int __init calgary_locate_bbars(void)
 			offset = phb_debug_offsets[phb] | PHB_DEBUG_STUFF_OFFSET;
 			target = calgary_reg(bbar, offset);
 
-			val = be32_to_cpu(readl(target));
+			val = readl_be(target);
 
 			start_bus = (u8)((val & 0x00FF0000) >> 16);
 			end_bus = (u8)((val & 0x0000FF00) >> 8);
@@ -1333,7 +1353,7 @@ static void __init get_tce_space_from_tar(void)
 						translate_empty_slots) {
 			target = calgary_reg(bus_info[bus].bbar,
 						tar_offset(bus));
-			tce_space = be64_to_cpu(readq(target));
+			tce_space = readq_be(target);
 			tce_space = tce_space & TAR_SW_BITS;
 
 			tce_space = tce_space & (~specified_table_size);
-- 
2.21.0.392.gf8f6787159e-goog
