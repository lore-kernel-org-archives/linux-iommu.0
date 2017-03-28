From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH V9 00/11] IOMMU probe deferral support
Date: Tue, 28 Mar 2017 14:15:56 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA81750D76E@lhreml504-mbs>
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
	<58D49845.9060407@hisilicon.com>
	<0ea8022b-a19b-335d-6cc6-81510196f891@codeaurora.org>
	<5FC3163CFD30C246ABAA99954A238FA81750B7CB@lhreml504-mbs>
	<db3d68f8-713c-9ae2-7df9-324bc1b375b1@arm.com>
	<5FC3163CFD30C246ABAA99954A238FA81750CCC4@lhreml504-mbs>
	<f67fb561-4238-6933-04f3-0f910f9232d1@arm.com>
	<8d7ba471-84d4-b9f3-9d2a-de166f6839d4@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <8d7ba471-84d4-b9f3-9d2a-de166f6839d4-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, "Wangzhou (B)" <wangzhou1-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "will.deacon-5wv7dgnIgG8@public.gmane.org" <will.deacon-5wv7dgnIgG8@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org" <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org" <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, "hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Sricharan R [mailto:sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org]
> Sent: Tuesday, March 28, 2017 5:54 AM
> To: Robin Murphy; Shameerali Kolothum Thodi; Wangzhou (B);
> will.deacon-5wv7dgnIgG8@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org;
> linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org;
> bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org; hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org;
> okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
> Subject: Re: [PATCH V9 00/11] IOMMU probe deferral support
> 
> Hi,
> 
[...]

> >>>  From the logs its clear that  when ixgbevf driver originally probes
> >>> and adds the device  to smmu  the dma mask is 32, but when it binds
> >>> to vfio-pci, it becomes 64 bit.
> >>
> >> Just to add to that, the mask is set to 64 bit in the ixgebvf driver
> >> probe[1]
> >
> > Aha, but of course it's still the same struct device getting bound to
> > VFIO later, so whatever mask the first driver set is still in there
> > when we go through of_dma_configure() the second time (and the fact
> > that we go through more than once being the new behaviour). So yes,
> > this is a legitimate problem and we really do need to be robust
> > against size overflow. I reckon the below tweak of your fix is
> > probably the way to go; cleaning up the arch_setup_dma_ops() interface
> can happen later.
> >
> 
> ok, i will add this fix separately and also the acpi fix that lorenzo has
> suggested in patch #8 in to the series after testing confirmation.
> 
I can confirm that the patches fixes the issues reported here . Both 
DT and ACPI works now.
 
Cheers,
Shameer 
