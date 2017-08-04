From: Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v9 12/13] iommu/amd: Clear out the GV flag when handle
 deferred domain attach
Date: Fri, 4 Aug 2017 15:18:04 +0200
Message-ID: <20170804131804.GZ3431@suse.de>
References: <1501587449-9817-1-git-send-email-bhe@redhat.com>
 <1501587449-9817-13-git-send-email-bhe@redhat.com>
 <20170804123041.GX3431@suse.de>
 <20170804131320.GO1874@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170804131320.GO1874@x1>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Fri, Aug 04, 2017 at 09:13:20PM +0800, Baoquan He wrote:
> On 08/04/17 at 02:30pm, Joerg Roedel wrote:
> > On Tue, Aug 01, 2017 at 07:37:28PM +0800, Baoquan He wrote:
> > > @@ -2466,11 +2472,21 @@ static struct protection_domain *get_domain(struct device *dev)
> > >  		return ERR_PTR(-EINVAL);
> > >  
> > >  	domain = get_dev_data(dev)->domain;
> > > -	if (domain == NULL && get_dev_data(dev)->defer_attach) {
> > > +	if (domain == NULL && dev_data->defer_attach) {
> > > +		u16 alias = amd_iommu_alias_table[dev_data->devid];
> > >  		get_dev_data(dev)->defer_attach = false;
> > >  		io_domain = iommu_get_domain_for_dev(dev);
> > >  		domain = to_pdomain(io_domain);
> > >  		attach_device(dev, domain);
> > > +		/*
> > > +		 * If the deferred attached domain is not v2, should clear out
> > > +		 * the old GV flag.
> > > +		 */
> > > +		if (!(domain->flags & PD_IOMMUV2_MASK)) {
> > > +			clear_dte_flag_gv(dev_data->devid);
> > > +			if (alias != dev_data->devid)
> > > +				clear_dte_flag_gv(dev_data->devid);
> > 
> > Hmm, thinking more about it, I am not sure what the IOMMU responds to
> > PRI/PASID prefixes if the GV flag is 0.
> > 
> > But until we know it causes problems we should just disable the bit
> > while doing the copy in the previous patch and avoid any special
> > handling like done here.
> 
> So just drop this patch, right? Will do if I got it right. Thanks.

Yes, and clear the GV flag in the previous patch too.
