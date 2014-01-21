From: "Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [RFC PATCH] vfio/iommu_type1: Multi-IOMMU domain support
Date: Tue, 21 Jan 2014 16:46:22 +0000
Message-ID: <6435bb49d4714b24baaf707e76559a55@BN1PR03MB266.namprd03.prod.outlook.com>
References: <20140117203126.11429.25235.stgit@gimli.home>
	<4b9118cb4cc744bdb2e9c25fa32d6950@BL2PR03MB259.namprd03.prod.outlook.com>
	<1390311348.8705.265.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1390311348.8705.265.camel-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
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
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> Sent: Tuesday, January 21, 2014 7:06 PM
> To: Bhushan Bharat-R65777
> Cc: Sethi Varun-B16395; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [RFC PATCH] vfio/iommu_type1: Multi-IOMMU domain support
> 
> On Tue, 2014-01-21 at 07:27 +0000, Bharat.Bhushan-KZfg59tc24xl57MIdRCFDg@public.gmane.org wrote:
> > > +	domain->domain = iommu_domain_alloc(domain->bus);
> > > +	if (!domain->domain) {
> > > +		ret = -EIO;
> > > +		goto out_free;
> > > +	}
> > > +
> > > +	ret = iommu_attach_group(domain->domain, iommu_group);
> > > +	if (ret)
> > > +		goto out_domain;
> > > +
> > > +	INIT_LIST_HEAD(&domain->group_list);
> > > +	list_add(&group->next, &domain->group_list);
> > > +
> > > +	if (!allow_unsafe_interrupts &&
> > > +	    !iommu_domain_has_cap(domain->domain, IOMMU_CAP_INTR_REMAP)) {
> > > +		pr_warn("%s: No interrupt remapping support.  Use the module
> > > +param
> > > \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this
> > > platform\n",
> > > +		       __func__);
> > > +		ret = -EPERM;
> > > +		goto out_detach;
> > > +	}
> > > +
> > > +	if (iommu_domain_has_cap(domain->domain, IOMMU_CAP_CACHE_COHERENCY))
> > > +		domain->prot |= IOMMU_CACHE;
> > > +
> > > +	/* Try to match an existing compatible domain. */
> > > +	list_for_each_entry(d, &iommu->domain_list, next) {
> > > +		if (d->bus == domain->bus && d->prot == domain->prot) {
> >
> > Are not we talking about allowing a domain to support different bus type if
> domain/iommu-group properties matches.
> 
> This is where I was suggesting to Varun that we could test iommu_ops instead of
> bus_type.
> 
> > > +			iommu_detach_group(domain->domain, iommu_group);
> > > +			if (!iommu_attach_group(d->domain, iommu_group)) {
> > > +				list_add(&group->next, &d->group_list);
> > > +				iommu_domain_free(domain->domain);
> > > +				kfree(domain);
> > > +				mutex_unlock(&iommu->lock);
> > > +				return 0;
> > > +			}
> > > +
> > > +			ret = iommu_attach_group(domain->domain, iommu_group);
> > > +			if (ret)
> > > +				goto out_domain;
> > > +		}
> > > +	}
> > > +
> > > +	/* replay mappings on new domains */
> > > +	ret = vfio_iommu_replay(iommu, domain);
> >
> > IIUC; We created a new domain because an already existing domain does
> > not have same attribute; say domain->prot; But in vfio_iommu_replay() we pick
> up any domain, first domain, and create mapping accordingly.
> > Should not we use attributes of this domain otherwise we may get "reserved bit
> faults"?
> 
> We use an existing domain to get the iova to physical mappings, should those not
> be consistent regardless of the domain we pick?  We're not using any of the low
> level attributes that could cause something like a reserved bit fault.  Thanks,

You are right, we use dma->addr etc from any domain and but uses "prot" from the domain passed to replay function().
So effectively the only difference (from dma mapping perspective) between domains in a container is "prot"

Thanks
-Bharat
> 
> Alex
> 
> 
