Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E129EC433EF
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 16:41:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7AFA860B74;
	Tue,  4 Jan 2022 16:41:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ZfhpLTHo5WL; Tue,  4 Jan 2022 16:41:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 27E9560AB1;
	Tue,  4 Jan 2022 16:41:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1259C0030;
	Tue,  4 Jan 2022 16:41:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AA0BC001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 16:41:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 267FB60B74
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 16:41:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yfxBhiN7KhBQ for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 16:41:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1A81860AB1
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 16:41:05 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 61365B8107A;
 Tue,  4 Jan 2022 16:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E53C36AE9;
 Tue,  4 Jan 2022 16:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641314462;
 bh=7LIvck5HPV89YRWtE6kFpffx/kn63b1CJh/KGhZQUKs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=LRvO6MenpPinEO+T+hEV/YbUXSjLlkY8NoW3HQ9aE099V5K48u6VhHatEzBsKSBPT
 cmffNDot4PE1jdfo57Arc+b1RjDJF4UindSch9QkjJJQOHEuyDv3Sb/V9CrAZ8qboX
 FqEMlIC2YhID+deJpRGh+rGjD91a069/0BkOvhCvCmsJK1jZi8rBUdT+Y4L6D1LoWJ
 +iF+m+fxZZCM303intD0VWXGgWalDOLkP/rubmrzKenN5dJymlBii0CMk5vgf2rQ4c
 l4GnLXjX0UYge02uSn7jN4nWu8z/+1dWw6issq/EjMI7Z4BLY3xzgU97f0cFdn+/Kk
 7cEOBvSJL88ew==
Date: Tue, 4 Jan 2022 10:41:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v5 01/14] iommu: Add dma ownership management interfaces
Message-ID: <20220104164100.GA101735@bhelgaas>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YdQcgFhIMYvUwABV@infradead.org>
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, Jan 04, 2022 at 02:08:00AM -0800, Christoph Hellwig wrote:
> On Tue, Jan 04, 2022 at 09:56:31AM +0800, Lu Baolu wrote:
> > Multiple devices may be placed in the same IOMMU group because they
> > cannot be isolated from each other. These devices must either be
> > entirely under kernel control or userspace control, never a mixture.

I guess the reason is that if a group contained a mixture, userspace
could attack the kernel by programming a device to DMA to a device
owned by the kernel?

> > This adds dma ownership management in iommu core and exposes several
> > interfaces for the device drivers and the device userspace assignment
> > framework (i.e. vfio), so that any conflict between user and kernel
> > controlled DMA could be detected at the beginning.

Maybe I'm missing the point because I don't know what "conflict
between user and kernel controlled DMA" is.  Are you talking about
both userspace and the kernel programming the same device to do DMA?

> > The device driver oriented interfaces are,
> > 
> > 	int iommu_device_use_dma_api(struct device *dev);
> > 	void iommu_device_unuse_dma_api(struct device *dev);

Nit, do we care whether it uses the actual DMA API?  Or is it just
that iommu_device_use_dma_api() tells us the driver may program the
device to do DMA?

> > Devices under kernel drivers control must call iommu_device_use_dma_api()
> > before driver probes. The driver binding process must be aborted if it
> > returns failure.

"Devices" don't call functions.  Drivers do, or in this case, it looks
like the bus DMA code (platform, amba, fsl, pci, etc).

These functions are EXPORT_SYMBOL_GPL(), but it looks like all the
callers are built-in, so maybe the export is unnecessary?

You use "iommu"/"IOMMU" and "dma"/"DMA" interchangeably above.  Would
be easier to read if you picked one.

> > The vfio oriented interfaces are,
> > 
> > 	int iommu_group_set_dma_owner(struct iommu_group *group,
> > 				      void *owner);
> > 	void iommu_group_release_dma_owner(struct iommu_group *group);
> > 	bool iommu_group_dma_owner_claimed(struct iommu_group *group);
> > 
> > The device userspace assignment must be disallowed if the set dma owner
> > interface returns failure.

Can you connect this back to the "never a mixture" from the beginning?
If all you cared about was prevent an IOMMU group from containing
devices with a mixture of kernel drivers and userspace drivers, I
assume you could do that without iommu_device_use_dma_api().  So is
this a way to *allow* a mixture under certain restricted conditions?

Another nit below.

> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > ---
> >  include/linux/iommu.h |  31 ++++++++
> >  drivers/iommu/iommu.c | 161 +++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 189 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index de0c57a567c8..568f285468cf 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -682,6 +682,13 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> >  void iommu_sva_unbind_device(struct iommu_sva *handle);
> >  u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> >  
> > +int iommu_device_use_dma_api(struct device *dev);
> > +void iommu_device_unuse_dma_api(struct device *dev);
> > +
> > +int iommu_group_set_dma_owner(struct iommu_group *group, void *owner);
> > +void iommu_group_release_dma_owner(struct iommu_group *group);
> > +bool iommu_group_dma_owner_claimed(struct iommu_group *group);
> > +
> >  #else /* CONFIG_IOMMU_API */
> >  
> >  struct iommu_ops {};
> > @@ -1082,6 +1089,30 @@ static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
> >  {
> >  	return NULL;
> >  }
> > +
> > +static inline int iommu_device_use_dma_api(struct device *dev)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline void iommu_device_unuse_dma_api(struct device *dev)
> > +{
> > +}
> > +
> > +static inline int
> > +iommu_group_set_dma_owner(struct iommu_group *group, void *owner)
> > +{
> > +	return -ENODEV;
> > +}
> > +
> > +static inline void iommu_group_release_dma_owner(struct iommu_group *group)
> > +{
> > +}
> > +
> > +static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
> > +{
> > +	return false;
> > +}
> >  #endif /* CONFIG_IOMMU_API */
> >  
> >  /**
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 8b86406b7162..ff0c8c1ad5af 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -48,6 +48,8 @@ struct iommu_group {
> >  	struct iommu_domain *default_domain;
> >  	struct iommu_domain *domain;
> >  	struct list_head entry;
> > +	unsigned int owner_cnt;
> > +	void *owner;
> >  };
> >  
> >  struct group_device {
> > @@ -289,7 +291,12 @@ int iommu_probe_device(struct device *dev)
> >  	mutex_lock(&group->mutex);
> >  	iommu_alloc_default_domain(group, dev);
> >  
> > -	if (group->default_domain) {
> > +	/*
> > +	 * If device joined an existing group which has been claimed
> > +	 * for none kernel DMA purpose, avoid attaching the default
> > +	 * domain.

AOL: another "none kernel DMA purpose" that doesn't read well.  Is
this supposed to be "non-kernel"?  What does "claimed for non-kernel
DMA purpose" mean?  What interface does that?

> > +	 */
> > +	if (group->default_domain && !group->owner) {
> >  		ret = __iommu_attach_device(group->default_domain, dev);
> >  		if (ret) {
> >  			mutex_unlock(&group->mutex);
> > @@ -2320,7 +2327,7 @@ static int __iommu_attach_group(struct iommu_domain *domain,
> >  {
> >  	int ret;
> >  
> > -	if (group->default_domain && group->domain != group->default_domain)
> > +	if (group->domain && group->domain != group->default_domain)
> >  		return -EBUSY;
> >  
> >  	ret = __iommu_group_for_each_dev(group, domain,
> > @@ -2357,7 +2364,11 @@ static void __iommu_detach_group(struct iommu_domain *domain,
> >  {
> >  	int ret;
> >  
> > -	if (!group->default_domain) {
> > +	/*
> > +	 * If group has been claimed for none kernel DMA purpose, avoid
> > +	 * re-attaching the default domain.
> > +	 */
> 
> none kernel reads odd.  But maybe drop that and just say 'claimed
> already' ala:
> 
> 	/*
> 	 * If the group has been claimed already, do not re-attach the default
> 	 * domain.
> 	 */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
