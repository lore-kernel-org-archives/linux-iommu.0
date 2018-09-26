From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH] iommu/amd: return devid as alias for ACPI HID devices
Date: Wed, 26 Sep 2018 09:42:46 +0200
Message-ID: <20180926074246.5ykyikman6krvnv4@suse.de>
References: <20180918101058.2365-1-arindam.nath@amd.com>
	<20180925133143.h46eopc5j7mnw5ac@suse.de>
	<BLUPR12MB05166F5680FA08277A8CC4F99C160@BLUPR12MB0516.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BLUPR12MB05166F5680FA08277A8CC4F99C160-7LeqcoF/hwreJlb8bxc+dwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Nath, Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Sep 25, 2018 at 03:41:34PM +0000, Nath, Arindam wrote:
> It does fix an issue where eMMC controller is an ACPI HID device and
> it fails to work with IOMMU enabled.
> 
> Since for the ACPI HID, there is no actual pci_dev backing it, there
> is a NULL pointer de-referencing inside pci_for_each_dma_alias() while
> trying to access pdev->bus->number.

Okay, added a Fixes: tag and applied for v4.19, thanks Arindam.
