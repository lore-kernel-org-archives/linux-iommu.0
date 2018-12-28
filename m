From: Liviu Dudau <liviu@dudau.co.uk>
Subject: Re: [PATCH dma-mapping tree] arm64: default to the direct mapping in
 get_arch_dma_ops
Date: Fri, 28 Dec 2018 17:30:57 +0000
Message-ID: <20181228173057.GA20342@bart.dudau.co.uk>
References: <20181214150240.26427-1-hch@lst.de> <20181219165502.GA25904@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181219165502.GA25904@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>
Cc: catalin.marinas@arm.com, iommu@lists.linux-foundation.org, robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org, will.deacon@arm.com
List-Id: iommu@lists.linux-foundation.org

On Wed, Dec 19, 2018 at 05:55:02PM +0100, Christoph Hellwig wrote:
> As all maintainers seem to be off to their holidays already I've
> applied this now given that I don't want to leave arm64 in broken
> state in linux-next any longer.

Hi Christoph,

Talking about linux-next being broken, I found out that with
next-20181224 the nvme driver with an HMB NVMe SSD (Toshiba RC-100)
also fails on a RK3399 board (NanoPC T4). It works with v4.20 just fine.

The reason for linking it to your patchset is that I get this on
next-20181224 (the DMA addresses looks the same for the allocated buffers):

.......
[    3.731134] rockchip-pcie f8000000.pcie: Looking up vpcie12v-supply from device tree
[    3.731177] rockchip-pcie f8000000.pcie: Looking up vpcie12v-supply property in node /pcie@f8000000 failed
[    3.731277] rockchip-pcie f8000000.pcie: no vpcie12v regulator found
[    3.731858] rockchip-pcie f8000000.pcie: Looking up vpcie3v3-supply from device tree
[    3.732021] rockchip-pcie f8000000.pcie: Linked as a consumer to regulator.2
[    3.732661] rockchip-pcie f8000000.pcie: Looking up vpcie1v8-supply from device tree
[    3.732695] rockchip-pcie f8000000.pcie: Looking up vpcie1v8-supply property in node /pcie@f8000000 failed
[    3.732777] rockchip-pcie f8000000.pcie: no vpcie1v8 regulator found
[    3.733351] rockchip-pcie f8000000.pcie: Looking up vpcie0v9-supply from device tree
[    3.733384] rockchip-pcie f8000000.pcie: Looking up vpcie0v9-supply property in node /pcie@f8000000 failed
[    3.733465] rockchip-pcie f8000000.pcie: no vpcie0v9 regulator found
[    3.795175] rockchip-pcie f8000000.pcie: host bridge /pcie@f8000000 ranges:
[    3.795834] rockchip-pcie f8000000.pcie: Parsing ranges property...
[    3.795910] rockchip-pcie f8000000.pcie:   MEM 0xfa000000..0xfbdfffff -> 0xfa000000
[    3.796628] rockchip-pcie f8000000.pcie:    IO 0xfbe00000..0xfbefffff -> 0xfbe00000
[    3.797781] rockchip-pcie f8000000.pcie: PCI host bridge to bus 0000:00
[    3.798384] pci_bus 0000:00: root bus resource [bus 00-1f]
[    3.798956] pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff]
[    3.799580] pci_bus 0000:00: root bus resource [io  0x0000-0xfffff] (bus address [0xfbe00000-0xfbefffff])
[    3.800431] pci_bus 0000:00: scanning bus
[    3.800516] pci 0000:00:00.0: [1d87:0100] type 01 class 0x060400
[    3.800819] pci 0000:00:00.0: supports D1
[    3.800835] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    3.800860] pci 0000:00:00.0: PME# disabled
[    3.808046] pci_bus 0000:00: fixups for bus
[    3.808079] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 0
[    3.808097] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    3.808847] pci 0000:00:00.0: scanning [bus 00-00] behind bridge, pass 1
[    3.809130] pci_bus 0000:01: scanning bus
[    3.809224] pci 0000:01:00.0: [1179:0113] type 00 class 0x010802
[    3.809416] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[    3.809647] pci 0000:01:00.0: Upstream bridge's Max Payload Size set to 128 (was 256, max 256)
[    3.810436] pci 0000:01:00.0: Max Payload Size set to 128 (was 128, max 128)
[    3.811536] pci 0000:01:00.0: PME# supported from D0 D3hot
[    3.811569] pci 0000:01:00.0: PME# disabled
[    3.811862] pci 0000:01:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x2 link at 0000:00:00.0 (capable of 15.752 Gb/s with 8 GT/s x2 link)
[    3.820219] pci_bus 0000:01: fixups for bus
[    3.820239] pci_bus 0000:01: bus scan returning with max=01
[    3.820261] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 01
[    3.820291] pci_bus 0000:00: bus scan returning with max=01
[    3.820361] pci 0000:00:00.0: BAR 14: assigned [mem 0xfa000000-0xfa0fffff]
[    3.820994] pci 0000:01:00.0: BAR 0: assigned [mem 0xfa000000-0xfa003fff 64bit]
[    3.821702] pci 0000:00:00.0: PCI bridge to [bus 01]
[    3.822167] pci 0000:00:00.0:   bridge window [mem 0xfa000000-0xfa0fffff]
[    3.823242] pcieport 0000:00:00.0: assign IRQ: got 229
[    3.823281] pcieport 0000:00:00.0: enabling device (0000 -> 0002)

...... (nvme compiled as module, modprobed from shell) .....

[   50.938888] nvme 0000:01:00.0: assign IRQ: got 229
[   50.939441] nvme nvme0: pci function 0000:01:00.0
[   50.940189] pcieport 0000:00:00.0: enabling bus mastering
[   50.940226] nvme 0000:01:00.0: enabling device (0000 -> 0002)
[   50.940784] nvme 0000:01:00.0: enabling bus mastering
[   51.097451] nvme nvme0: allocated 38 MiB host memory buffer.
[   51.097970] nvme nvme0: 0x000000001d8ec924 -> [0xffff000000000000, 0x400]
[   51.098609] nvme nvme0: 0x00000000bd00b691 -> [0xffff000000000000, 0x400]
[   51.099215] nvme nvme0: 0x0000000098e20ad2 -> [0xffff000000000000, 0x400]
[   51.099820] nvme nvme0: 0x000000003a390633 -> [0xffff000000000000, 0x400]
[   51.100423] nvme nvme0: 0x000000001cddf671 -> [0xffff000000000000, 0x400]
[   51.101026] nvme nvme0: 0x000000002587680f -> [0xffff000000000000, 0x400]
[   51.101629] nvme nvme0: 0x00000000bc2c89f9 -> [0xffff000000000000, 0x400]
[   51.102232] nvme nvme0: 0x000000005b3ef3ef -> [0xffff000000000000, 0x400]
[   51.102862] nvme nvme0: 0x000000004ec4a26a -> [0xffff000000000000, 0x400]
[   51.103466] nvme nvme0: 0x00000000ee7f030f -> [0xffff000000000000, 0x200]
[  111.582818] nvme nvme0: I/O 7 QID 0 timeout, disable controller
[  111.599289] nvme nvme0: failed to set host mem (err -4, flags 0x1).
[  111.599862] nvme nvme0: nvme_free_host_mem: nr_host_mem_descs = 10
[  111.616938] nvme nvme0: Removing after probe failure status: -4
[  111.617558] nvme nvme0: nvme_free_host_mem: nr_host_mem_descs = 0
[  111.618270] nvme nvme0: failed to set APST feature (-19)

The extra lines come from me trying to figure out what is going on with this patch:

--8<--------------------------------------------------------------------------------------

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5a0bf6a24d507..73df69385bccd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1881,12 +1881,15 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
 {
 	int i;
 
+	dev_info(dev->ctrl.device, "%s: nr_host_mem_descs = %d\n",
+		 __func__, dev->nr_host_mem_descs);
 	for (i = 0; i < dev->nr_host_mem_descs; i++) {
 		struct nvme_host_mem_buf_desc *desc = &dev->host_mem_descs[i];
 		size_t size = le32_to_cpu(desc->size) * dev->ctrl.page_size;
 
-		dma_free_coherent(dev->dev, size, dev->host_mem_desc_bufs[i],
-				le64_to_cpu(desc->addr));
+		dma_free_attrs(dev->dev, size, dev->host_mem_desc_bufs[i],
+			       le64_to_cpu(desc->addr),
+			       DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_NO_WARN);
 	}
 
 	kfree(dev->host_mem_desc_bufs);
@@ -1952,8 +1955,9 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 	while (--i >= 0) {
 		size_t size = le32_to_cpu(descs[i].size) * dev->ctrl.page_size;
 
-		dma_free_coherent(dev->dev, size, bufs[i],
-				le64_to_cpu(descs[i].addr));
+		dma_free_attrs(dev->dev, size, bufs[i],
+			       le64_to_cpu(descs[i].addr),
+			       DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_NO_WARN);
 	}
 
 	kfree(bufs);
@@ -2020,6 +2024,12 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 		dev_info(dev->ctrl.device,
 			"allocated %lld MiB host memory buffer.\n",
 			dev->host_mem_size >> ilog2(SZ_1M));
+		for (ret = 0; ret < dev->nr_host_mem_descs; ret++) {
+			dev_info(dev->ctrl.device,
+				"0x%p -> [0x%llx, 0x%x]\n", dev->host_mem_desc_bufs[ret],
+				le64_to_cpu(dev->host_mem_descs[ret].addr),
+				le32_to_cpu(dev->host_mem_descs[ret].size));
+		}
 	}
 
 	ret = nvme_set_host_mem(dev, enable_bits);

--8<--------------------------------------------------------------------------------------

The change to use dma_free_attrs() instead of dma_free_coherent() is needed otherwise I get
a crash in mm/vmalloc.c (patch sent to ML) or the modprobe hangs and I get the above err -4.


Best regards,
Liviu


> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
           ________________________________________________________
  ________|                                                        |_______
  \       |  With enough courage, you can do without a reputation  |      /
   \      |                                  -- Rhett Butler       |     /
   /      |________________________________________________________|     \
  /__________)                                                  (_________\
