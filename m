From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 08/11] iommu/msm: Make use of iommu_device_register
	interface
Date: Fri, 10 Feb 2017 16:33:40 +0100
Message-ID: <20170210153339.GK7339@8bytes.org>
References: <1486639981-32368-1-git-send-email-joro@8bytes.org>
	<1486639981-32368-9-git-send-email-joro@8bytes.org>
	<5bda5842-45b4-fc3c-7eea-351e4c2261b1@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5bda5842-45b4-fc3c-7eea-351e4c2261b1-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Feb 10, 2017 at 02:35:39PM +0000, Robin Murphy wrote:
> On 09/02/17 11:32, Joerg Roedel wrote:
> > +	ret = iommu_device_sysfs_add(&iommu->iommu, iommu->dev, NULL,
> > +				     "msm-smmu.%pa", &ioaddr);
> > +	if (ret) {
> > +		pr_err("Could not add msm-smmu at %pa to sysfs\n", &ioaddr);
> > +		goto fail;
> > +	}
> 
> Nit: there's a bit of inconsistency with printing errors between the
> various drivers (for both _sysfs_add and _register). I reckon if we want
> error messages we may as well just fold them into the helper functions.

Yeah, this could be unified too. For now I looked how verbose the
driver was that I was going to change and added messages to be
consistent inside the drivers.

> 
> > +
> > +	iommu_device_set_ops(&iommu->iommu, &msm_iommu_ops);
> > +	iommu_device_set_fwnode(&iommu->iommu, &pdev->dev.of_node->fwnode);
> > +
> > +	ret = iommu_device_register(&iommu->iommu);
> > +	if (ret) {
> > +		pr_err("Could not register msm-smmu at %pa\n", &ioaddr);
> > +		goto fail;
> > +	}
> 
> I think there's a corresponding unregister missing for
> msm_iommu_remove() here (and similarly in the ARM SMMU drivers, looking
> back). I know it's not strictly a problem at the moment, but I do now
> have IOMMU-drivers-as-modules working on top of the probe deferral
> series... ;)

Well, that there was an iommu_register_instance() without any
unregistration interface at all makes me believe that unregistering
iommus is not really implemented yet.

And in fact, the remove functions for msm and arm-smmu seem to only
disable the hardware, but are not removing the corresponding data
structures.

So I think we are fine from that side.


	Joerg
