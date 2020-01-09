Return-Path: <SRS0=4b30=26=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E892EC282DD
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 18:21:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B254A2067D
	for <iommu@archiver.kernel.org>; Thu,  9 Jan 2020 18:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFHa0o+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B254A2067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7B03F883CD;
	Thu,  9 Jan 2020 18:21:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pByJjsP8DV6N; Thu,  9 Jan 2020 18:21:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CBD32883CB;
	Thu,  9 Jan 2020 18:21:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9C061C18DC;
	Thu,  9 Jan 2020 18:21:40 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E219DC0881
 for <iommu@lists.linuxfoundation.org>; Thu,  9 Jan 2020 18:21:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CDBC32156B
 for <iommu@lists.linuxfoundation.org>; Thu,  9 Jan 2020 18:21:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xmQ6tX2Kj+hf for <iommu@lists.linuxfoundation.org>;
 Thu,  9 Jan 2020 18:21:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 7FEE221514
 for <iommu@lists.linuxfoundation.org>; Thu,  9 Jan 2020 18:21:37 +0000 (UTC)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 655DE2072A;
 Thu,  9 Jan 2020 18:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578594097;
 bh=+sBgitQL3mchSzP4Zk7erYJ9ZJ5ThhSnczn5fnQvSkY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=qFHa0o+FuNFrYUBweK+4sytw7pvbDe8ilh4PEgH8e0aoeuk84pqZuF/CKpz2edZfr
 mupIUv4nVDn+sooFYGrIG/xXBlmXBR/gSAwEfF3UM2dntd9XVzj1yYk+Rjei2nobkJ
 gkdIy7JMsz81pP7LvYZ/l5J6mi+KI3F5Jhv9VCpY=
Date: Thu, 9 Jan 2020 19:17:58 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 05/16] drivers/iommu: Take a ref to the IOMMU driver
 prior to ->add_device()
Message-ID: <20200109181758.GD589933@kroah.com>
References: <20191219120352.382-1-will@kernel.org>
 <20191219120352.382-6-will@kernel.org>
 <20191219144437.GA1959534@kroah.com>
 <20200109141602.GA12236@willie-the-truck>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200109141602.GA12236@willie-the-truck>
Cc: iommu@lists.linuxfoundation.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Saravana Kannan <saravanak@google.com>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
 "Isaac J. Manjarres" <isaacm@codeaurora.org>
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

On Thu, Jan 09, 2020 at 02:16:03PM +0000, Will Deacon wrote:
> Hi Greg,
> 
> On Thu, Dec 19, 2019 at 03:44:37PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Dec 19, 2019 at 12:03:41PM +0000, Will Deacon wrote:
> > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > > index f2223cbb5fd5..e9f94d3f7a04 100644
> > > --- a/include/linux/iommu.h
> > > +++ b/include/linux/iommu.h
> > > @@ -246,9 +246,10 @@ struct iommu_iotlb_gather {
> > >   * @sva_get_pasid: Get PASID associated to a SVA handle
> > >   * @page_response: handle page request response
> > >   * @cache_invalidate: invalidate translation caches
> > > - * @pgsize_bitmap: bitmap of all possible supported page sizes
> > >   * @sva_bind_gpasid: bind guest pasid and mm
> > >   * @sva_unbind_gpasid: unbind guest pasid and mm
> > > + * @pgsize_bitmap: bitmap of all possible supported page sizes
> > > + * @owner: Driver module providing these ops
> > >   */
> > >  struct iommu_ops {
> > >  	bool (*capable)(enum iommu_cap);
> > > @@ -318,6 +319,7 @@ struct iommu_ops {
> > >  	int (*sva_unbind_gpasid)(struct device *dev, int pasid);
> > >  
> > >  	unsigned long pgsize_bitmap;
> > > +	struct module *owner;
> > 
> > Everyone is always going to forget to set this field.  I don't think you
> > even set it for all of the different iommu_ops possible in this series,
> > right?
> 
> I only initialised the field for those drivers which can actually be built
> as a module, but I take your point about this being error-prone.
> 
> > The "trick" we did to keep people from having to remember this is to do
> > what we did for the bus registering functions.
> > 
> > Look at pci_register_driver in pci.h:
> > #define pci_register_driver(driver)             \
> >         __pci_register_driver(driver, THIS_MODULE, KBUILD_MODNAME)
> > 
> > Then we set the .owner field in the "real" __pci_register_driver() call.
> > 
> > Same thing for USB and lots, if not all, other driver register
> > functions.
> > 
> > You can do the same thing here, and I would recommend it.
> 
> Yes, that makes sense, cheers. Diff below. I'll send it to Joerg along
> with some other SMMU patches that have come in since the holiday.
> 
> Will
> 
> --->8
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 03dc97842875..e82997a705a8 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2733,7 +2733,6 @@ static struct iommu_ops arm_smmu_ops = {
>  	.get_resv_regions	= arm_smmu_get_resv_regions,
>  	.put_resv_regions	= arm_smmu_put_resv_regions,
>  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
> -	.owner			= THIS_MODULE,
>  };
>  
>  /* Probing and initialisation functions */
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 5ef1f2e100d7..93d332423f6f 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -1623,7 +1623,6 @@ static struct iommu_ops arm_smmu_ops = {
>  	.get_resv_regions	= arm_smmu_get_resv_regions,
>  	.put_resv_regions	= arm_smmu_put_resv_regions,
>  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
> -	.owner			= THIS_MODULE,
>  };
>  
>  static void arm_smmu_device_reset(struct arm_smmu_device *smmu)
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e9f94d3f7a04..90007c92ad2d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -388,12 +388,19 @@ void iommu_device_sysfs_remove(struct iommu_device *iommu);
>  int  iommu_device_link(struct iommu_device   *iommu, struct device *link);
>  void iommu_device_unlink(struct iommu_device *iommu, struct device *link);
>  
> -static inline void iommu_device_set_ops(struct iommu_device *iommu,
> -					const struct iommu_ops *ops)
> +static inline void __iommu_device_set_ops(struct iommu_device *iommu,
> +					  const struct iommu_ops *ops)
>  {
>  	iommu->ops = ops;
>  }
>  
> +#define iommu_device_set_ops(iommu, ops)				\
> +do {									\
> +	struct iommu_ops *__ops = (struct iommu_ops *)(ops);		\
> +	__ops->owner = THIS_MODULE;					\
> +	__iommu_device_set_ops(iommu, __ops);				\
> +} while (0)
> +
>  static inline void iommu_device_set_fwnode(struct iommu_device *iommu,
>  					   struct fwnode_handle *fwnode)
>  {

Looks good:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
