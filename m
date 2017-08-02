From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH -next] iommu/of: Check for valid fwspec after
	of_pci_iommu_init
Date: Wed, 2 Aug 2017 17:39:17 +0100
Message-ID: <7451645e-54e2-1ef3-fe28-80e1ff22cfdb@arm.com>
References: <1501690300-5447-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1501690300-5447-1-git-send-email-sudeep.holla-5wv7dgnIgG8@public.gmane.org>
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
To: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 02/08/17 17:11, Sudeep Holla wrote:
> The successful return from of_pci_iommu_init doesn't ensure valid
> fwspec if it's IOMMU is disabled.
> 
> Accessing dev->iommu_fwspec->ops without checking dev->iommu_fwspec
> could result in NULL pointer dereference.
> 
> Unable to handle kernel NULL pointer dereference at virtual address 00000000
> task: ffff800976880000 task.stack: ffff800976888000
> PC is at of_iommu_configure+0x130/0x138
> LR is at of_iommu_configure+0x118/0x138
>  of_iommu_configure+0x130/0x138
>  of_dma_configure+0xa8/0x190
>  dma_configure+0x40/0xe8
>  driver_probe_device+0x190/0x2d0
>  __device_attach_driver+0x9c/0xf8
>  bus_for_each_drv+0x58/0x98
>  __device_attach+0xc4/0x138
>  device_attach+0x10/0x18
>  pci_bus_add_device+0x4c/0xa8
>  pci_bus_add_devices+0x44/0x90
>  pci_bus_add_devices+0x74/0x90
>  pci_host_common_probe+0x14c/0x3a8
>  gen_pci_probe+0x2c/0x38
>  platform_drv_probe+0x58/0xc0
>  driver_probe_device+0x214/0x2d0
>  __driver_attach+0xac/0xb0
>  bus_for_each_dev+0x60/0xa0
>  driver_attach+0x20/0x28
>  bus_add_driver+0x110/0x230
>  driver_register+0x60/0xf8
>  __platform_driver_register+0x44/0x50
>  gen_pci_driver_init+0x18/0x20
>  do_one_initcall+0x38/0x120
>  kernel_init_freeable+0x184/0x224
>  kernel_init+0x10/0x100
> 
> This patch adds the check for dev->iommu_fwspec and fixes the above.
> 
> Fixes: d87beb749281 ("iommu/of: Handle PCI aliases properly")
> Cc: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/of_iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Hi Robin,
> 
> I see this crash on Juno with linux-next. Enabling PCIe SMMU fixes the
> issue, but we may need to handle the disabled SMMU case to continue to
> work with old DTBs.

Ugh, a disabled IOMMU should be conceptually the same as no IOMMU, but I
guess the phandle chasing fails to fail. Per the design intent, the most
correct fix should be this:

----->8-----
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index be8ac1ddec06..9bc83f94bc10 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -163,6 +163,8 @@ static int of_pci_iommu_init(struct pci_dev *pdev,
u16 alias, void *data)

        if (IS_ERR(ops))
                return PTR_ERR(ops);
+       if (!ops)
+               return 1;

        return info->np == pdev->bus->dev.of_node;
 }
-----8<-----

But looking again, I think an even better fix involves ripping out much
of the PTR_ERR shenanigans with ops that leads to this confusion in the
first place. Give me a moment...

Thanks,
Robin.

> 
> Regards,
> Sudeep
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index 34160e7a8dd7..11e08ff2db57 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -200,7 +200,8 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>  					     of_pci_iommu_init, &info);
>  		if (err) /* err > 0 means the walk stopped, but non-fatally */
>  			ops = ERR_PTR(min(err, 0));
> -		else /* success implies both fwspec and ops are now valid */
> +		/* success may not imply fwspec is valid */
> +		else if (dev->iommu_fwspec)
>  			ops = dev->iommu_fwspec->ops;
>  	} else {
>  		struct of_phandle_args iommu_spec;
> --
> 2.7.4
> 
