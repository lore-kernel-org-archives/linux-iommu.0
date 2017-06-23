From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 2/9] iommu/vt-d: add bind_pasid_table function
Date: Fri, 23 Jun 2017 12:59:00 -0600
Message-ID: <20170623125900.61091315@w520.home>
References: <1497478983-77580-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1497478983-77580-3-git-send-email-jacob.jun.pan@linux.intel.com>
	<20170622165215.5989e02c@w520.home>
	<20170623111952.09915a6d@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170623111952.09915a6d@jacob-builder>
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
Cc: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Tian,
	Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, 23 Jun 2017 11:19:52 -0700
Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> On Thu, 22 Jun 2017 16:52:15 -0600
> Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> 
> > On Wed, 14 Jun 2017 15:22:56 -0700
> > Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > > +static int intel_iommu_unbind_pasid_table(struct iommu_domain
> > > *domain,
> > > +					struct device *dev)
> > > +{
> > > +	struct intel_iommu *iommu;
> > > +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> > > +	u8 bus, devfn;
> > > +
> > > +	iommu = device_to_iommu(dev, &bus, &devfn);
> > > +	if (!iommu)
> > > +		return -ENODEV;
> > > +	/*
> > > +	 * REVISIT: we might want to clear the PASID table pointer
> > > +	 * as part of context clear operation. Currently, it leaves
> > > +	 * stale data but should be ignored by hardware since
> > > PASIDE
> > > +	 * is clear.
> > > +	 */
> > > +	/* ATS will be reenabled when remapping is restored */
> > > +	pci_disable_ats(to_pci_dev(dev));    
> > 
> > dev_is_pci()?
> >   
> good to check, even thought intel iommu supports PCI only.

That's not true, intel-iommu supports non-PCI devices defined in ACPI
as well.  Thanks,

Alex
