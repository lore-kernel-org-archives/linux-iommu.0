From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] intel-iommu: Quiesce devices before disabling IOMMU
Date: Sun, 8 Sep 2013 19:47:52 +0800
Message-ID: <20130908114752.GA24572@dhcp-16-252.nay.redhat.com>
References: <1377069354-5056-1-git-send-email-indou.takao@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1377069354-5056-1-git-send-email-indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/kexec/>
List-Post: <mailto:kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/kexec>,
 <mailto:kexec-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "kexec" <kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: kexec-bounces+glkk-kexec=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,
Patch is great and works on my HP-z420.
There are several small concerns, please see inline comments.

On 08/21/13 at 04:15pm, Takao Indoh wrote:
> This patch quiesces devices before disabling IOMMU on boot to stop
> ongoing DMA. In intel_iommu_init(), check context entries and if there
> is entry whose present bit is set then reset corresponding device.
> 
> When IOMMU is already enabled on boot, it is disabled and new DMAR table
> is created and then re-enabled in intel_iommu_init(). This causes DMAR
> faults if there are in-flight DMAs.
> 
> This causes problem on kdump. Devices are working in first kernel, and
> after switching to second kernel and initializing IOMMU, many DMAR faults
> occur and it causes problems like driver error or PCI SERR, at last
> kdump fails. This patch fixes this problem.
> 
> Signed-off-by: Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
> 
> 
> NOTE:
> To reset devices this patch uses bus reset interface introduced by
> following commits in PCI "next" branch.
> 
> 64e8674fbe6bc848333a9b7e19f8cc019dde9eab
> 5c32b35b004f5ef70dcf62bbc42b8bed1e50b471
> 2e35afaefe64946caaecfacaf7fb568e46185e88
> 608c388122c72e1bf11ba8113434eb3d0c40c32d
> 77cb985ad4acbe66a92ead1bb826deffa47dd33f
> 090a3c5322e900f468b3205b76d0837003ad57b2
> a6cbaadea0af9b4aa6eee2882f2aa761ab91a4f8
> de0c548c33429cc78fd47a3c190c6d00b0e4e441
> 1b95ce8fc9c12fdb60047f2f9950f29e76e7c66d
> ---
>  drivers/iommu/intel-iommu.c |   55 ++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 54 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index eec0d3e..efb98eb 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3663,6 +3663,56 @@ static struct notifier_block device_nb = {
>  	.notifier_call = device_notifier,
>  };
>  
> +/* Reset PCI devices if its entry exists in DMAR table */
> +static void __init iommu_reset_devices(struct intel_iommu *iommu, u16 segment)
> +{
> +	u64 addr;
> +	struct root_entry *root;
> +	struct context_entry *context;
> +	int bus, devfn;
> +	struct pci_dev *dev;
> +
> +	addr = dmar_readq(iommu->reg + DMAR_RTADDR_REG);
> +	if (!addr)
> +		return;
> +
> +	/*
> +	 *  In the case of kdump, ioremap is needed because root-entry table
> +	 *  exists in first kernel's memory area which is not mapped in second
> +	 *  kernel
> +	 */
> +	root = (struct root_entry *)ioremap(addr, PAGE_SIZE);
> +	if (!root)
> +		return;
> +
> +	for (bus = 0; bus < ROOT_ENTRY_NR; bus++) {
> +		if (!root_present(&root[bus]))
> +			continue;
> +
> +		context = (struct context_entry *)ioremap(
> +			root[bus].val & VTD_PAGE_MASK, PAGE_SIZE);
> +		if (!context)
> +			continue;
> +
> +		for (devfn = 0; devfn < ROOT_ENTRY_NR; devfn++) {
For context_entry table, the context_entry has the same size as
root_entry currently, so it's also correct to use ROOT_ENTRY_NR. But for
future extention and removing confusion, can we define a new MACRO on
calculating the size of context_entry table, e.g CONTEXT_ENTRY_NR?

> +			if (!context_present(&context[devfn]))
> +				continue;
> +
> +			dev = pci_get_domain_bus_and_slot(segment, bus, devfn);
> +			if (!dev)
> +				continue;
> +
> +			if (!pci_reset_bus(dev->bus)) /* go to next bus */

Here, we have got the specific dev, why don't we just call
pci_reset_function? If call pci_reset_bus here, will it repeat resetting
devices on the same bus many times?

> +				break;
> +			else /* Try per-function reset */
> +				pci_reset_function(dev);
> +
> +		}
> +		iounmap(context);
> +	}
> +	iounmap(root);
> +}
> +
>  int __init intel_iommu_init(void)
>  {
>  	int ret = 0;
> @@ -3687,8 +3737,11 @@ int __init intel_iommu_init(void)
>  			continue;
>  
>  		iommu = drhd->iommu;
> -		if (iommu->gcmd & DMA_GCMD_TE)
> +		if (iommu->gcmd & DMA_GCMD_TE) {
> +			if (reset_devices)
> +				iommu_reset_devices(iommu, drhd->segment);

I remember the double reset issue vivek concerned in the old patch. Here
the iommu reset is done at the very beginning of pci_iommu_init, it's
after the bus subsystem init, it means here only iommu reset, am I
right?

If yes, I think this patch is clear and logic is simple.

BTW, what's the status of Alex's PCI patchset which this patch depends
on?

Baoquan
Thanks

>  			iommu_disable_translation(iommu);
> +		}
>  	}
>  
>  	if (dmar_dev_scope_init() < 0) {
> -- 
> 1.7.1
> 
> 
> 
> _______________________________________________
> kexec mailing list
> kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/kexec
