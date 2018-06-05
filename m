From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v8 1/2] iommu - Enable debugfs exposure of IOMMU driver
 internals
Date: Tue, 5 Jun 2018 19:08:24 +0200
Message-ID: <20180605170824.GA11965@kroah.com>
References: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
 <152761819480.2654.5371070582955429468.stgit@sosgrh1.amd.com>
 <20180529184101.GB10618@kroah.com>
 <3249cc11-09d8-2078-28a6-efd3078ca0e9@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3249cc11-09d8-2078-28a6-efd3078ca0e9@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gary R Hook <gary.hook@amd.com>
Cc: iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, Jun 05, 2018 at 12:01:41PM -0500, Gary R Hook wrote:
> > > +/**
> > > + * iommu_debugfs_new_driver_dir - create a vendor directory under debugfs/iommu
> > > + * @vendor: name of the vendor-specific subdirectory to create
> > > + *
> > > + * This function is called by an IOMMU driver to create the top-level debugfs
> > > + * directory for that driver.
> > > + *
> > > + * Return: upon success, a pointer to the dentry for the new directory.
> > > + *         NULL in case of failure.
> > > + */
> > > +struct dentry *iommu_debugfs_new_driver_dir(const char *vendor)
> > > +{
> > > +	struct dentry *d_new;
> > > +
> > > +	d_new = debugfs_create_dir(vendor, iommu_debugfs_dir);
> > > +
> > > +	return d_new;
> > > +}
> > > +EXPORT_SYMBOL_GPL(iommu_debugfs_new_driver_dir);
> > 
> > Why are you wrapping a debugfs call?  Why not just export
> > iommu_debugfs_dir instead?
> 
> It was a choice, as I stated in my other post. It is not a requirement.
> If you resolutely reject this approach, that's fine. I'll change it, no
> worries.

Either is fine, but if it stays, it should stay a single line function
:)

thanks,

greg k-h
