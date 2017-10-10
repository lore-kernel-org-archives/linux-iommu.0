From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 02/16] iommu/vt-d: add bind_pasid_table function
Date: Tue, 10 Oct 2017 15:21:20 +0200
Message-ID: <20171010132119.jwtayeordrvvnlen@8bytes.org>
References: <1507244624-39189-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1507244624-39189-3-git-send-email-jacob.jun.pan@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1507244624-39189-3-git-send-email-jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Liu-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Rafael Wysocki <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Oct 05, 2017 at 04:03:30PM -0700, Jacob Pan wrote:
> +	pdev = to_pci_dev(dev);
> +	if (!pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_PRI))
> +		return -EINVAL;
> +	sid = PCI_DEVID(bus, devfn);

Okay, you search for the PRI capability ...
> +
> +	info = dev->archdata.iommu;
> +	if (!info || !info->pasid_supported) {
> +		dev_err(dev, "No PASID support\n");
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	if (!info->pasid_enabled) {
> +		ret = pci_enable_pasid(pdev, info->pasid_supported & ~1);
> +		if (ret)
> +			goto out;

... and you enable PASID in bind_pasid_table() ...


> +	/*
> +	 * REVISIT: we might want to clear the PASID table pointer
> +	 * as part of context clear operation. Currently, it leaves
> +	 * stale data but should be ignored by hardware since PASIDE
> +	 * is clear.
> +	 */
> +	/* ATS will be reenabled when remapping is restored */
> +	pci_disable_ats(to_pci_dev(dev));

.. while you disable ATS in unbind_pasid_table(). Where does this
asymmetry come from?

>  #define CONTEXT_DINVE		(1ULL << 8)
>  #define CONTEXT_PRS		(1ULL << 9)
> +#define CONTEXT_NESTE		(1ULL << 10)

Missing 'D' at the end?
