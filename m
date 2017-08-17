From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] irqchip/gic-{v2m, v3-its}: check iommu capable before
	doing iommu map
Date: Thu, 17 Aug 2017 09:52:55 +0100
Message-ID: <8017a14e-0855-de2c-9a78-5abeab25aeb1@arm.com>
References: <1502958508-195670-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1502958508-195670-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 17/08/17 09:28, Shawn Lin wrote:
> If a PCIe RC use gic-v2m or gic-v3-its as a msi domain but doesn't
> have iommu support, we don't need to do iommu_dma_map_msi_msg to
> get mapped iommu address as all we need is the physical address.
> Otherwise we see the oops shown below as we can't get a iommu_group
> for a device without iommu capable.
> 
> Unable to handle kernel NULL pointer dereference at virtual address
> 000000d0
> [00000000000000d0] user address but active_mm is swapper
> Internal error: Oops: 96000004 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 3 PID: 1 Comm: swapper/0 Not tainted
> 4.13.0-rc5-next-20170815-00001-g0744890-dirty #53
> Hardware name: Firefly-RK3399 Board (DT)
> task: ffff80007bc70000 task.stack: ffff80007bc6c000
> PC is at iommu_get_domain_for_dev+0x38/0x50
> LR is at iommu_dma_map_msi_msg+0x3c/0x1b8
> pc : [<ffff000008569210>] lr : [<ffff00000856c1e4>] pstate:
> a0000045
> 
> ...
> 
> [<ffff000008569210>] iommu_get_domain_for_dev+0x38/0x50
> [<ffff00000856c1e4>] iommu_dma_map_msi_msg+0x3c/0x1b8
> [<ffff0000083d4d8c>] its_irq_compose_msi_msg+0x44/0x50
> [<ffff00000811be50>] irq_chip_compose_msi_msg+0x40/0x58
> [<ffff000008120e34>] msi_domain_activate+0x1c/0x48
> [<ffff00000811d9f8>] __irq_domain_activate_irq+0x40/0x58
> [<ffff00000811f724>] irq_domain_activate_irq+0x24/0x40
> [<ffff00000812139c>] msi_domain_alloc_irqs+0x104/0x190
> [<ffff000008445abc>] pci_msi_setup_msi_irqs+0x3c/0x48
> [<ffff00000844658c>] __pci_enable_msi_range+0x21c/0x408
> [<ffff0000084468a4>] pci_alloc_irq_vectors_affinity+0x104/0x168
> [<ffff00000843cd98>] pcie_port_device_register+0x200/0x488
> [<ffff00000843d2ac>] pcie_portdrv_probe+0x34/0xd0
> [<ffff00000842e2cc>] local_pci_probe+0x3c/0xb8
> [<ffff00000842f5f8>] pci_device_probe+0x138/0x170
> [<ffff00000857d964>] driver_probe_device+0x21c/0x2d8
> [<ffff00000857db6c>] __device_attach_driver+0x9c/0xf8
> [<ffff00000857bbfc>] bus_for_each_drv+0x5c/0x98
> [<ffff00000857d61c>] __device_attach+0xc4/0x138
> [<ffff00000857d6a0>] device_attach+0x10/0x18
> [<ffff00000842395c>] pci_bus_add_device+0x4c/0xa8
> [<ffff0000084239fc>] pci_bus_add_devices+0x44/0x90
> [<ffff000008451e88>] rockchip_pcie_probe+0xc70/0xcc8
> [<ffff00000857f738>] platform_drv_probe+0x58/0xc0
> [<ffff00000857d964>] driver_probe_device+0x21c/0x2d8
> [<ffff00000857dacc>] __driver_attach+0xac/0xb0
> [<ffff00000857bb3c>] bus_for_each_dev+0x64/0xa0
> [<ffff00000857d258>] driver_attach+0x20/0x28
> [<ffff00000857cd08>] bus_add_driver+0x110/0x230
> [<ffff00000857e468>] driver_register+0x60/0xf8
> [<ffff00000857f690>] __platform_driver_register+0x40/0x48
> [<ffff000008dd6dc0>] rockchip_pcie_driver_init+0x18/0x20
> [<ffff000008083970>] do_one_initcall+0xb0/0x120
> [<ffff000008db0cfc>] kernel_init_freeable+0x184/0x224
> [<ffff00000896fce8>] kernel_init+0x10/0x100
> [<ffff000008084ad0>] ret_from_fork+0x10/0x18
> 
> This patch is to fix the problem exposed by the commit mentioned below.
> Before this commit, iommu has a work around method to fix this but now
> it doesn't. So we could fix this in gic code but maybe still need a fixes
> tag here.
> 
> Fixes: 05f80300dc8b ("iommu: Finish making iommu_group support mandatory")
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

That looks pretty horrible. Please see the patch I posted in response to
your initial report:

http://marc.info/?l=linux-pci&m=150295809430903&w=2

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
