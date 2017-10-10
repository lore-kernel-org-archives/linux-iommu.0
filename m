From: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 4/4] PCI: hisi: blacklist hip06/hip07 controllers
	behind SMMUv3
Date: Mon, 9 Oct 2017 19:15:42 -0500
Message-ID: <20171010001542.GR25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20171006140450.89652-1-shameerali.kolothum.thodi@huawei.com>
	<20171006140450.89652-5-shameerali.kolothum.thodi@huawei.com>
	<20171009235452.GP25517@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171009235452.GP25517-1RhO1Y9PlrlHTL0Zs8A6p5iNqAH0jzoTYJqu5kTmcBRl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Shameer Kolothum <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Oct 09, 2017 at 06:54:52PM -0500, Bjorn Helgaas wrote:
> Please change subject line:
> 
> -  PCI: hisi: blacklist hip06/hip07 controllers behind SMMUv3
> +  PCI: hisi: Blacklist hip06/hip07 controllers behind SMMUv3
> 
> On Fri, Oct 06, 2017 at 03:04:50PM +0100, Shameer Kolothum wrote:
> > The HiSilicon erratum 161010801 describes the limitation of
> > HiSilicon platforms hip06/hip07 to support the SMMUv3 mappings
> > for MSI transactions.
> 
> I don't suppose there's a URL for this erratum, is there?
> 
> > PCIe controller on these platforms has to differentiate the MSI
> > payload against other DMA payload and has to modify the MSI
> > payload. This basically makes it difficult for this platforms to
> > have a SMMU translation for MSI. In order to workaround this, ARM
> > SMMUv3 driver requires a quirk to treat the MSI regions separately.
> > Such a quirk is currently missing for DT based systems and therefore
> > we need to blacklist the hip06/hip07 PCIe controllers.
> 
> I don't understand the DT connection here.  If this is a hardware
> erratum, I assume the a quirk would be required whether the system
> uses DT, ACPI, etc.
> 
> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> 
> I assume this will go via some non-PCI tree.  If I were applying this,
> I would look for an ack from Zhou or Gabriele in addition to mine.

Never mind about this part; I see they already have acked it.  I really
need to learn to read the whole thread before responding :)
