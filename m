From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [RFCv2 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
	erratum 161010801
Date: Thu, 8 Jun 2017 09:09:28 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA838363D5D@FRAEML521-MBX.china.huawei.com>
References: <20170531143213.82100-1-shameerali.kolothum.thodi@huawei.com>
	<20170531143213.82100-3-shameerali.kolothum.thodi@huawei.com>
	<20170606135623.GB20126@red-moon>
	<5FC3163CFD30C246ABAA99954A238FA838362082@FRAEML521-MBX.china.huawei.com>
	<20170608084851.GA8607@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170608084851.GA8607@red-moon>
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
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: "Guohanjun (Hanjun Guo)" <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Gabriele Paoloni <gabriele.paoloni-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "marc.zyngier-5wv7dgnIgG8@public.gmane.org" <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Wangzhou (B)" <wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "sudeep.holla-5wv7dgnIgG8@public.gmane.org" <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org" <devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Lorenzo Pieralisi [mailto:lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org]
> Sent: Thursday, June 08, 2017 9:49 AM
> To: Shameerali Kolothum Thodi
> Cc: marc.zyngier-5wv7dgnIgG8@public.gmane.org; sudeep.holla-5wv7dgnIgG8@public.gmane.org; will.deacon-5wv7dgnIgG8@public.gmane.org;
> robin.murphy-5wv7dgnIgG8@public.gmane.org; hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org; Gabriele Paoloni; John
> Garry; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-
> kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; devel-E0kO6a4B6psdnm+yROfE0A@public.gmane.org;
> Linuxarm; Wangzhou (B); Guohanjun (Hanjun Guo)
> Subject: Re: [RFCv2 2/2] iommu/arm-smmu-v3:Enable ACPI based HiSilicon
> erratum 161010801
> 
> On Tue, Jun 06, 2017 at 03:01:36PM +0000, Shameerali Kolothum Thodi
> wrote:
> 
> [...]
> 
> > > > +	irq_dom = pci_msi_get_device_domain(to_pci_dev(dev));
> > > > +	if (irq_dom) {
> > > > +		int	ret;
> > > > +		u32	rid;
> > > > +
> > > > +		rid = pci_msi_domain_get_msi_rid(irq_dom,
> > > to_pci_dev(dev));
> > > > +		ret = iort_dev_find_its_base(dev, rid, 0, &base);
> > >
> > > Well, here we use ITS id 0 which is fine as long as code in IORT
> > > uses the same policy for getting the irq_domain (ie we want to
> > > reserve the ITS address space that is actually used by the device to
> > > send IRQs not a a different one) it is just a heads-up because I find this
> confusing.
> >
> > Ok. Just to make it clear, 0 is the index into the ITS identifier
> > list.  I noted that iort_get_device_domain() uses index 0 while
> > retrieving the ITS identifier.  May be use the same approach here as
> > well? ie, remove the index from function call?
> >
> > I am not sure, how we can get the index info  though theoretically It
> > is possible for the ITS group node having multiple ITSs.
> 
> Actually I think it would make sense to reserve ALL ITS regions a device may
> be mapped to instead of just index 0 (ie in your case it is equivalent); this
> leaves us some leeway as to choose which ITS the device will be actually
> mapped to and this code does not have to care.

Ok. That make sense. Just a quick one, is it ok to add another helper function in
iort code to retrieve the its->its_count then? 

Thanks,
Shameer
