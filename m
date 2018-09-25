From: "Nath, Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH] iommu/amd: return devid as alias for ACPI HID devices
Date: Tue, 25 Sep 2018 15:41:34 +0000
Message-ID: <BLUPR12MB05166F5680FA08277A8CC4F99C160@BLUPR12MB0516.namprd12.prod.outlook.com>
References: <20180918101058.2365-1-arindam.nath@amd.com>
	<20180925133143.h46eopc5j7mnw5ac@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180925133143.h46eopc5j7mnw5ac-l3A5Bk7waGM@public.gmane.org>
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
To: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Joerg,

> -----Original Message-----
> From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> Sent: Tuesday, September 25, 2018 7:02 PM
> To: Nath, Arindam <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Suthikulpanit, Suravee
> <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> Subject: Re: [PATCH] iommu/amd: return devid as alias for ACPI HID devices
> 
> Hi Arindam,
> 
> On Tue, Sep 18, 2018 at 03:40:58PM +0530, Arindam Nath wrote:
> > @@ -246,7 +246,13 @@ static u16 get_alias(struct device *dev)
> >
> >  	/* The callers make sure that get_device_id() does not fail here */
> >  	devid = get_device_id(dev);
> > +
> > +	/* For ACPI HID devices, we simply return the devid as such */
> > +	if (!dev_is_pci(dev))
> > +		return devid;
> > +
> 
> Does this fix some bug? If there is no alias defined for the device-id,
> it should just return the correct devid even without that change.

It does fix an issue where eMMC controller is an ACPI HID device and it fails to work with IOMMU enabled.

Since for the ACPI HID, there is no actual pci_dev backing it, there is a NULL pointer de-referencing inside pci_for_each_dma_alias() while trying to access pdev->bus->number.

Thanks,
Arindam

> 
> Regards,
> 
> 	Joerg
