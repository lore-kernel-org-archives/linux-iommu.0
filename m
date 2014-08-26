From: Andy Burns <iommu+lists-6TVDe6PzSGq9FHfhHBbuYA@public.gmane.org>
Subject: re: [RFC PATCH v2 2/2] iommu/intel: Make use of PCIe requester ID
	interface
Date: Tue, 26 Aug 2014 08:13:51 +0100
Message-ID: <53FC33AF.5040407@adslpipe.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

I'm running into an IOMMU crash on CentOS7, it seems this patch series 
aims to fix the same type of issue, any thoughts as to whether it is 
likely to help in my case?

[ 0.451393] IOMMU: Prepare 0-16MiB unity mapping for LPC
[ 0.451400] IOMMU: Setting identity map for device 0000:00:1f.0 [0x0 - 
0xffffff]
[ 0.451455] PCI-DMA: Intel(R) Virtualization Technology for Directed I/O
[ 0.451546] ------------[ cut here ]------------
[ 0.451552] WARNING: at drivers/pci/search.c:46 
pci_find_upstream_pcie_bridge+0x87/0x90()
[ 0.451553] Modules linked in:
[ 0.451557] CPU: 2 PID: 1 Comm: swapper/0 Not tainted 
3.10.0-123.6.3.el7.x86_64 #1
[ 0.451558] Hardware name: To Be Filled By O.E.M. To Be Filled By 
O.E.M./H97 Pro4, BIOS P1.40 07/29/2014
[ 0.451559] 0000000000000000 000000003a87b4a1 ffff880408885cf0 
ffffffff815e20bb
[ 0.451561] ffff880408885d28 ffffffff8105dee1 ffff880408212000 
ffff88040821c000
[ 0.451563] ffff88040821c098 0000000000000000 0000000000000000 
ffff880408885d38
[ 0.451565] Call Trace:
[ 0.451570] [<ffffffff815e20bb>] dump_stack+0x19/0x1b
[ 0.451574] [<ffffffff8105dee1>] warn_slowpath_common+0x61/0x80
[ 0.451576] [<ffffffff8105e00a>] warn_slowpath_null+0x1a/0x20
[ 0.451579] [<ffffffff812ec727>] pci_find_upstream_pcie_bridge+0x87/0x90
[ 0.451582] [<ffffffff814a9d8d>] intel_iommu_add_device+0x4d/0x230
[ 0.451585] [<ffffffff814a0e30>] ? bus_set_iommu+0x50/0x50
[ 0.451588] [<ffffffff814a0e5a>] add_iommu_group+0x2a/0x50
[ 0.451591] [<ffffffff813b4563>] bus_for_each_dev+0x73/0xc0
[ 0.451593] [<ffffffff814a0e28>] bus_set_iommu+0x48/0x50
[ 0.451597] [<ffffffff81a58273>] intel_iommu_init+0x3ea/0x413
[ 0.451601] [<ffffffff81a11c93>] ? memblock_find_dma_reserve+0x147/0x147
[ 0.451603] [<ffffffff81a11ca5>] pci_iommu_init+0x12/0x3c
[ 0.451606] [<ffffffff810020e2>] do_one_initcall+0xe2/0x190
[ 0.451608] [<ffffffff81a09153>] kernel_init_freeable+0x18b/0x22a
[ 0.451610] [<ffffffff81a0892b>] ? do_early_param+0x88/0x88
[ 0.451614] [<ffffffff815c3960>] ? rest_init+0x80/0x80
[ 0.451617] [<ffffffff815c396e>] kernel_init+0xe/0x180
[ 0.451619] [<ffffffff815f26ec>] ret_from_fork+0x7c/0xb0
[ 0.451621] [<ffffffff815c3960>] ? rest_init+0x80/0x80
[ 0.451626] ---[ end trace e5ab4299053e7cdf ]---

I will report back after testing. To save duplication there's info about 
my setup here ...

<http://centos.org/forums/viewtopic.php?f=47&t=48115>
