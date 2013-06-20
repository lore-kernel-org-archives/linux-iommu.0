From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] iommu: Quirked PCIe bridge test and search function
Date: Thu, 20 Jun 2013 15:59:14 +0200
Message-ID: <20130620135914.GS2575@8bytes.org>
References: <20130528183527.3318.5365.stgit@bling.home>
	<20130528184020.3318.7800.stgit@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130528184020.3318.7800.stgit-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Tue, May 28, 2013 at 12:40:20PM -0600, Alex Williamson wrote:
> +bool iommu_pci_is_pcie_bridge(struct pci_dev *pdev)
> +{
> +	if (!pdev->subordinate)
> +		return false;
> +
> +	if (pci_is_pcie(pdev))
> +		return true;
> +
> +#ifdef CONFIG_PCI_QUIRKS
> +	/*
> +	 * If we're not on the root bus, look one device upstream of the
> +	 * current device.  If that device is PCIe and is not a PCIe-to-PCI
> +	 * bridge, then the current device is effectively PCIe as it must
> +	 * be the PCIe-to-PCI bridge.  This handles several bridges that
> +	 * violate the PCIe spec by not exposing a PCIe capability:
> +	 * https://bugzilla.kernel.org/show_bug.cgi?id=44881
> +	 */
> +	if (!pci_is_root_bus(pdev->bus)) {
> +		struct pci_dev *parent = pdev->bus->self;
> +
> +		if (pci_is_pcie(parent) &&
> +		    pci_pcie_type(parent) != PCI_EXP_TYPE_PCI_BRIDGE)
> +			return true;
> +	}

Hmm, that looks a bit dangerous. Do we have a list of PCI
vendor/device-ids of these broken bridges to match against instead of
some open-coded heuristics?

That would probably also help to bring this into the PCI code.


	Joerg
