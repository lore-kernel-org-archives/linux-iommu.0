From: Yijing Wang <wangyijing-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [Patch Part2 V1 11/14] iommu/vt-d, PCI: update DRHD/RMRR/ATSR
	device scope caches when PCI hotplug happens
Date: Thu, 9 Jan 2014 16:52:01 +0800
Message-ID: <52CE6331.60000@huawei.com>
References: <1389085234-22296-1-git-send-email-jiang.liu@linux.intel.com>
	<1389085234-22296-12-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1389085234-22296-12-git-send-email-jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Yinghai Lu <yinghai-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Gerry,
   This is patch solution is better than mine, it's more reliable.
I tested this patch in my huawei RH5885 platform, after applied it,
the issue is gone. But I can not test it in the case that bus number changed
after hotplug. Anyway, it's a good solution.

Thanks!
Yijing.

On 2014/1/7 17:00, Jiang Liu wrote:
> Current Intel DMAR/IOMMU driver assumes that all PCI devices associated
> with DMAR/RMRR/ATSR device scope arrays are created at boot time and
> won't change at runtime, so it caches pointers of associated PCI device
> object. That assumption may be wrong now due to:
> 1) introduction of PCI host bridge hotplug
> 2) PCI device hotplug through sysfs interfaces.
> 

> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index 31c72d5..15c9ce0 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -194,6 +194,209 @@ void dmar_free_dev_scope(struct pci_dev __rcu ***devices, int *cnt)
>  	*cnt = 0;
>  }
>  
> +/* Optimize out kzalloc()/kfree() for normal cases */
> +static char dmar_pci_notify_info_buf[64];

In my idea, pci device add/remove is not a frequent action, so maybe using kzalloc and kfree make
code more simplified, this is just my personal opinion.

> +
> +static struct dmar_pci_notify_info *
> +dmar_alloc_pci_notify_info(struct pci_dev *dev, unsigned long event)
> +{
> +	int level = 0;
> +	size_t size;
