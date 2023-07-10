Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D64C2EF
	for <iommu@lists.linux.dev>; Mon, 10 Jul 2023 11:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE30BC433C7;
	Mon, 10 Jul 2023 11:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688987977;
	bh=JuEeqtW3z3Pmyp7TD8m2cCMBwnc/h1lBBNCIEk2UHwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uWgIAcGIk03DoP4L/WH5y3Vsk3VkJscAyMyEtS6k8rJ/fq+6XIHtquntbrR0VSn9F
	 o4VdFghroQ0tR84kDB+LAcCAFUTXJczCazu0qsdFO6G5yPs30fwe+6gl4AFaPXYHTz
	 MEHq5Z0Uw0Dahyy5v6Y3NErThY7pZU7ZQl4DMdFgE2FJJkBHm0CLxG7Oiay0D4Gs8m
	 9tM47WyGYhSkrYoAGv/tXSjsr57vK9YtLkYbZaCFCFCqgPMGlWlaFUUEDh+JdLeEdA
	 4472Bjsc6SISAgvQh4TTpQaEJNrZfHnPWKUoPYIxzwJar6L8VJ5xhdqhgDpVvfjEvu
	 q0ISmQ6oFvJ/g==
Date: Mon, 10 Jul 2023 12:19:32 +0100
From: Will Deacon <will@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	nikhilnd@google.com, mshavit@google.com, iommu@lists.linux.dev,
	svarbanov@suse.de
Subject: Re: [PATCH] iommu: Expose an API to set identity domain
Message-ID: <20230710111931.GA717@willie-the-truck>
References: <20230707104857.348353-1-praan@google.com>
 <af4166f9-7b86-6c12-a8f8-ee0398743dd6@arm.com>
 <CAN6iL-Qu97hFbpOEPPtcVcWo_+=zjFy5fjJU-UnAqnY=ebFptw@mail.gmail.com>
 <CAN6iL-QWa=DNmfGDJHeOncZMktFyQ3LpNGiRu1Aa4cyQofdTnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN6iL-QWa=DNmfGDJHeOncZMktFyQ3LpNGiRu1Aa4cyQofdTnw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Pranjal,

Please try to avoid top-posting when you reply to the mailing list, as
it breaks the flow of conversation. See:

	Documentation/process/submitting-patches.rst

On Mon, Jul 10, 2023 at 02:33:10PM +0530, Pranjal Shrivastava wrote:
> Agreed. It's a security v/s performance trade off. The main issue
> seems to be when a PCIe endpoint maliciously spoofs its ID. However, I
> guess we can avoid that by making the API platform device specific, in
> that case only the device which is a platform device can use the API
> to say "Hey, I know what I am doing, bypass the SMMU for me". Will
> that be acceptable?

I think that's effectively already the case for the sysfs interface, no?
Untrusted PCI devices are forced into a default domain of IOMMU_DOMAIN_DMA
and you can't change that.

> Please let us know if there are any other ways/suggestions that allow
> us to install bypass for a single iommu group sitting in front of a
> platform device (This device is not removable/hot-pluggable and always
> sits on the system).

I think there are a few issues here:

> >> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> >> > index f1dcfa3f1a1b..36f158621dc5 100644
> >> > --- a/drivers/iommu/iommu.c
> >> > +++ b/drivers/iommu/iommu.c
> >> > @@ -13,6 +13,7 @@
> >> >   #include <linux/bug.h>
> >> >   #include <linux/types.h>
> >> >   #include <linux/init.h>
> >> > +#include <linux/dma-map-ops.h>
> >> >   #include <linux/export.h>
> >> >   #include <linux/slab.h>
> >> >   #include <linux/errno.h>
> >> > @@ -2908,6 +2909,10 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
> >> >       if (ret)
> >> >               goto free_new_domain;
> >> >

This code (iommu_change_dev_def_domain()) has changed significantly in
the recent merge window, so this doesn't apply.

> >> > +     /* Make sure dma_ops are appropriatley set */
> >> > +     if (type == IOMMU_DOMAIN_IDENTITY)
> >> > +             set_dma_ops(dev, NULL);
> >> > +

This is usually handled on arm64 by the unbind operation, which will
tear down the old domain and clear the function pointer.

> >> >       iommu_domain_free(prev_dom);
> >> >
> >> >       return 0;
> >> > @@ -2921,6 +2926,22 @@ static int iommu_change_dev_def_domain(struct iommu_group *group,
> >> >       return ret;
> >> >   }
> >> >
> >> > +/*
> >> > + * Sets the default domain to identity of an iommu group
> >> > + *
> >> > + * @group: The group for which the default domain should be changed
> >> > + * @dev: The first device in the group
> >> > + *
> >> > + * Returns 0 on success and error code on failure
> >> > + * Note:Presently, this function shall be called only if the driver requests to
> >> > + * change the group's default domain type to identity during the driver's probe.
> >> > + */
> >> > +int iommu_set_def_identity_domain(struct device *dev, struct iommu_group *group)
> >> > +{
> >> > +     return iommu_change_dev_def_domain(group, dev, IOMMU_DOMAIN_IDENTITY);
> >> > +}
> >> > +EXPORT_SYMBOL_GPL(iommu_set_def_identity_domain);

An exported symbol with no user in the tree is very unlikely to be
accepted...

Why can't you do what you need from userspace using the existing interface?

If a new in-kernel interface is required, then I think it (a) needs opt-in
from userspace and (b) needs an in-tree user.

Thanks,

Will
