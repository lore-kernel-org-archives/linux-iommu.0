From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07 controllers
	behind SMMUv3
Date: Tue, 10 Oct 2017 09:42:30 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838421875@FRAEML521-MBX.china.huawei.com>
References: <20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com>
	<20171006140450.89652-5-shameerali.kolothum.thodi@huawei.com>
	<20171009235452.GP25517@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20171009235452.GP25517-1RhO1Y9PlrlHTL0Zs8A6p5iNqAH0jzoTYJqu5kTmcBRl57MIdRCFDg@public.gmane.org>
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
To: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: "Guohanjun (Hanjun Guo)" <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "sudeep.holla-5wv7dgnIgG8@public.gmane.org" <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org" <devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

HI Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas [mailto:helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> Sent: Tuesday, October 10, 2017 12:55 AM
> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> Cc: lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org; marc.zyngier-5wv7dgnIgG8@public.gmane.org;
> sudeep.holla-5wv7dgnIgG8@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org; robin.murphy-5wv7dgnIgG8@public.gmane.org;
> joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; Gabriele Paoloni
> <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org;
> Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>; Wangzhou (B)
> <wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>; Guohanjun (Hanjun Guo)
> <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> Subject: Re: [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07 controllers behind
> SMMUv3
> 
> Please change subject line:
> 
> -  PCI: hisi: blacklist hip06/hip07 controllers behind SMMUv3
> +  PCI: hisi: Blacklist hip06/hip07 controllers behind SMMUv3

Ok.

> On Fri, Oct 06, 2017 at 03:04:50PM +0100, Shameer Kolothum wrote:
> > The HiSilicon erratum 161010801 describes the limitation of HiSilicon
> > platforms hip06/hip07 to support the SMMUv3 mappings for MSI
> > transactions.
> 
> I don't suppose there's a URL for this erratum, is there?

We don't have anything public at the moment. This is part of the internal
documentation at the moment.

> > PCIe controller on these platforms has to differentiate the MSI
> > payload against other DMA payload and has to modify the MSI payload.
> > This basically makes it difficult for this platforms to have a SMMU
> > translation for MSI. In order to workaround this, ARM
> > SMMUv3 driver requires a quirk to treat the MSI regions separately.
> > Such a quirk is currently missing for DT based systems and therefore
> > we need to blacklist the hip06/hip07 PCIe controllers.
> 
> I don't understand the DT connection here.  If this is a hardware erratum, I
> assume the a quirk would be required whether the system uses DT, ACPI,
> etc.

Yes, this is a hardware erratum and we are almost there to add the ACPI
quirk into the SMMUv3 driver for this.  But we got the feedback that 
either we have to have the DT support or we should blacklist the affected
devices so that from the SMMUv3 driver point of view it will not run into the
quirk unnecessarily[1].

We attempted to provide a DT solution, but it looks like DT requires more
discussions and a more generic approach than ACPI[2]. Hence we are blacklisting
the PCIe for now so that we can have the ACPI support goes through. (Also we 
don't have the DT binding in the mainline which support SMMU on these 
platforms and also DT is not officially supported for these platforms).

> > Signed-off-by: Shameer Kolothum
> <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> 
> I assume this will go via some non-PCI tree.  If I were applying this, I would
> look for an ack from Zhou or Gabriele in addition to mine.
> 
> > ---
> >  drivers/pci/dwc/pcie-hisi.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/pci/dwc/pcie-hisi.c b/drivers/pci/dwc/pcie-hisi.c
> > index a201791..6800747 100644
> > --- a/drivers/pci/dwc/pcie-hisi.c
> > +++ b/drivers/pci/dwc/pcie-hisi.c
> > @@ -270,6 +270,12 @@ static int hisi_pcie_probe(struct platform_device
> *pdev)
> >  	struct resource *reg;
> >  	int ret;
> >
> > +	if ((IS_BUILTIN(CONFIG_ARM_SMMU_V3)) &&
> > +			of_property_read_bool(dev->of_node, "iommu-
> map")) {
> 
> Does the presence of "iommu-map" tell you this is an SMMUv3?  Could it
> have a different type of IOMMU?  I can't tell from reading
> Documentation/devicetree/bindings/pci/pci-iommu.txt.

Only if the SMMUv3 driver is loaded and iommu-map binding property present,
the pcie devices will use SMMU translated iova for MSI doorbell addresses.

> Why do you care whether CONFIG_ARM_SMMU_V3 is set?  Does MSI work
> correctly if SMMUv3 is present but not used?

Yes. MSI will work if no SMMUv3 is used.

> Is it really necessary to ignore the PCIe controller completely?
> Could you use the devices below it as long as you disable MSI for them?  I
> know there are probably devices that require MSI, so maybe it's easier to
> just ignore everything than to respond to reports of "my device doesn't work
> because it requires MSI."

We are blacklisting MSI for PCIe only if the kernel is using DT and is configured
to use SMMUv3. Otherwise it is fine. And as I said above DT is not officially
supported on these platforms.

Thanks,
Shameer

1. [PATCH v6 3/3] iommu/arm-smmu-v3:Enable ACPI based HiSilicon erratum 161010801
https://www.spinics.net/lists/arm-kernel/msg602873.html
2. [PATCH v8 3/5] iommu/of: Add msi address regions reservation helper
https://www.spinics.net/lists/arm-kernel/msg609431.html
