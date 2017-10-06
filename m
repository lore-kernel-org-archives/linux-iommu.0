From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 10/16] iommu: introduce device fault report API
Date: Fri, 6 Oct 2017 10:36:02 +0100
Message-ID: <5103e49c-d74c-c697-b5f7-e5c54edce595@arm.com>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1507244624-39189-11-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1507244624-39189-11-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jacob,

On 06/10/17 00:03, Jacob Pan wrote:
> Traditionally, device specific faults are detected and handled within
> their own device drivers. When IOMMU is enabled, faults such as DMA
> related transactions are detected by IOMMU. There is no generic
> reporting mechanism to report faults back to the in-kernel device
> driver or the guest OS in case of assigned devices.
> 
> Faults detected by IOMMU is based on the transaction's source ID which
> can be reported at per device basis, regardless of the device type is a
> PCI device or not.
> 
> The fault types include recoverable (e.g. page request) and
> unrecoverable faults(e.g. access error). In most cases, faults can be
> handled by IOMMU drivers internally. The primary use cases are as
> follows:
> 1. page request fault originated from an SVM capable device that is
> assigned to guest via vIOMMU. In this case, the first level page tables
> are owned by the guest. Page request must be propagated to the guest to
> let guest OS fault in the pages then send page response. In this
> mechanism, the direct receiver of IOMMU fault notification is VFIO,
> which can relay notification events to QEMU or other user space
> software.
> 
> 2. faults need more subtle handling by device drivers. Other than
> simply invoke reset function, there are needs to let device driver
> handle the fault with a smaller impact.
> 
> This patchset is intended to create a generic fault report API such
> that it can scale as follows:
> - all IOMMU types
> - PCI and non-PCI devices
> - recoverable and unrecoverable faults
> - VFIO and other other in kernel users
> - DMA & IRQ remapping (TBD)
> The original idea was brought up by David Woodhouse and discussions
> summarized at https://lwn.net/Articles/608914/.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Signed-off-by: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
[...]
> +int iommu_register_device_fault_handler(struct device *dev,
> +					iommu_dev_fault_handler_t handler)
> +{
> +	if (dev->iommu_fault_param)
> +		return -EBUSY;
> +	get_device(dev);
> +	dev->iommu_fault_param =
> +		kzalloc(sizeof(struct iommu_fault_param), GFP_KERNEL);
> +	if (!dev->iommu_fault_param)
> +		return -ENOMEM;
> +	dev->iommu_fault_param->dev_fault_handler = handler;

Since the handler is owned by a device driver, you also need to clean it
up when switching the driver (native->VFIO and VFIO->native), in
iommu_attach_device I suppose.

Thanks,
Jean
