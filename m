From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH/RFC] driver core: Postpone DMA tear-down until after
 devres release
Date: Tue, 26 Mar 2019 11:41:38 +0000
Message-ID: <9966a420-b081-a8ed-7f7b-20d97c9f7996@huawei.com>
References: <20190207193653.18221-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190207193653.18221-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel <joro@8bytes.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, chenxiang <chenxiang66@hisilicon.com>, Xiaofei Tan <tanxiaofei@huawei.com>
List-Id: iommu@lists.linux-foundation.org

>
> Memory is incorrectly freed using the direct ops, as dma_map_ops = NULL.
> Oops...
>
> After reversing the order of the calls to arch_teardown_dma_ops() and
> devres_release_all(), dma_map_ops is still valid, and the DMA memory is
> now released using __iommu_free_attrs():
>
>     +sata_rcar ee300000.sata: dmam_release:32: size 2048 vaddr ffffff8012145000 dma_handle 0x0x00000000fffff000 attrs 0x0
>     +sata_rcar ee300000.sata: dma_free_attrs:289: size 2048, ops = iommu_dma_ops
>     +sata_rcar ee300000.sata: dma_free_attrs:311: calling __iommu_free_attrs()
> ---
>  drivers/base/dd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 8ac10af17c0043a3..d62487d024559620 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -968,9 +968,9 @@ static void __device_release_driver(struct device *dev, struct device *parent)
>  			drv->remove(dev);
>
>  		device_links_driver_cleanup(dev);
> -		arch_teardown_dma_ops(dev);
>
>  		devres_release_all(dev);
> +		arch_teardown_dma_ops(dev);
>  		dev->driver = NULL;

Hi guys,

Could there still be the same problem in the error path of really_probe():

static int really_probe(struct device *dev, struct device_driver *drv)
{

	[...]

	goto done;

probe_failed:
	arch_teardown_dma_ops(dev);
dma_failed:
	if (dev->bus)
		blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
				     BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
pinctrl_bind_failed:
	device_links_no_driver(dev);
	devres_release_all(dev);
	driver_sysfs_remove(dev);
	dev->driver = NULL;
	dev_set_drvdata(dev, NULL);

We seem to be able to call arch_teardown_dma_ops() prior to 
devres_release_all() if we reach probe_failed label.

We have seen this crash when our driver probe fails on a dev branch 
based on v5.1-rc1:

[   87.896707] hisi_sas_v3_hw 0000:74:02.0: Adding to iommu group 2
[   87.909765] scsi host1: hisi_sas_v3_hw
[   89.127958] hisi_sas_v3_hw 0000:74:02.0: evaluate _DSM failed
[   89.134043] BUG: Bad page state in process swapper/0  pfn:313f5
[   89.139965] page:ffff7e0000c4fd40 count:1 mapcount:0 
mapping:0000000000000000 index:0x0
[   89.147960] flags: 0xfffe00000001000(reserved)
[   89.152398] raw: 0fffe00000001000 ffff7e0000c4fd48 ffff7e0000c4fd48 
0000000000000000
[   89.160130] raw: 0000000000000000 0000000000000000 00000001ffffffff 
0000000000000000
[   89.167861] page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
[   89.174290] bad because of flags: 0x1000(reserved)
[   89.179070] Modules linked in:
[   89.182117] CPU: 49 PID: 1 Comm: swapper/0 Not tainted 
5.1.0-rc1-43081-g22d97fd-dirty #1433
[   89.190453] Hardware name: Huawei D06/D06, BIOS Hisilicon D06 UEFI 
RC0 - V1.12.01 01/29/2019
[   89.198876] Call trace:
[   89.201316]  dump_backtrace+0x0/0x118
[   89.204965]  show_stack+0x14/0x1c
[   89.208272]  dump_stack+0xa4/0xc8
[   89.211576]  bad_page+0xe4/0x13c
[   89.214791]  free_pages_check_bad+0x4c/0xc0
[   89.218961]  __free_pages_ok+0x30c/0x340
[   89.222871]  __free_pages+0x30/0x44
[   89.226347]  __dma_direct_free_pages+0x30/0x38
[   89.230777]  dma_direct_free+0x24/0x38
[   89.234513]  dma_free_attrs+0x9c/0xd8
[   89.238161]  dmam_release+0x20/0x28
[   89.241640]  release_nodes+0x17c/0x220
[   89.245375]  devres_release_all+0x34/0x54
[   89.249371]  really_probe+0xc4/0x2c8
[   89.252933]  driver_probe_device+0x58/0xfc
[   89.257016]  device_driver_attach+0x68/0x70
[   89.261185]  __driver_attach+0x94/0xdc
[   89.264921]  bus_for_each_dev+0x5c/0xb4
[   89.268744]  driver_attach+0x20/0x28
[   89.272306]  bus_add_driver+0x14c/0x200
[   89.276128]  driver_register+0x6c/0x124
[   89.279953]  __pci_register_driver+0x48/0x50
[   89.284213]  sas_v3_pci_driver_init+0x20/0x28
[   89.288557]  do_one_initcall+0x40/0x25c
[   89.292381]  kernel_init_freeable+0x2b8/0x3c0
[   89.296727]  kernel_init+0x10/0x100
[   89.300202]  ret_from_fork+0x10/0x18
[   89.303773] Disabling lock debugging due to kernel taint
[   89.309076] BUG: Bad page state in process swapper/0  pfn:313f6
[   89.314988] page:ffff7e0000c4fd80 count:1 mapcount:0 
mapping:0000000000000000 index:0x0
[   89.322983] flags: 0xfffe00000001000(reserved)
[   89.327417] raw: 0fffe00000001000 ffff7e0000c4fd88 ffff7e0000c4fd88 
0000000000000000
[   89.335149] raw: 0000000000000000 0000000000000000 00000001ffffffff 
0000000000000000

Thanks,
John


>  		dev_set_drvdata(dev, NULL);
>  		if (dev->pm_domain && dev->pm_domain->dismiss)
>
