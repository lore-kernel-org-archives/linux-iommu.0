Return-Path: <SRS0=codQ=S4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1CAC43219
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 22:10:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6EEB2084F
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 22:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6EEB2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 996511890;
	Fri, 26 Apr 2019 22:10:51 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 455551887
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 22:08:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8DC4082B
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 22:08:40 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	26 Apr 2019 15:08:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,399,1549958400"; d="scan'208";a="146193264"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by fmsmga007.fm.intel.com with ESMTP; 26 Apr 2019 15:08:38 -0700
Date: Fri, 26 Apr 2019 15:11:22 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 14/19] iommu: Add guest PASID bind function
Message-ID: <20190426151122.528101b6@jacob-builder>
In-Reply-To: <35194a94-ed09-d086-8725-f7e1bdfbb877@redhat.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1556062279-64135-15-git-send-email-jacob.jun.pan@linux.intel.com>
	<35194a94-ed09-d086-8725-f7e1bdfbb877@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190426221122.TUJUtrhjKO0hKrZ_CkbPNKSmWDtxMCUVPR5rwIRBlpk@z>

On Fri, 26 Apr 2019 17:53:43 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 4/24/19 1:31 AM, Jacob Pan wrote:
> > Guest shared virtual address (SVA) may require host to shadow guest
> > PASID tables. Guest PASID can also be allocated from the host via
> > enlightened interfaces. In this case, guest needs to bind the guest
> > mm, i.e. cr3 in guest phisical address to the actual PASID table
> > in  
> physical
got it

> > the host IOMMU. Nesting will be turned on such that guest virtual
> > address can go through a two level translation:
> > - 1st level translates GVA to GPA
> > - 2nd level translates GPA to HPA
> > This patch introduces APIs to bind guest PASID data to the assigned
> > device entry in the physical IOMMU. See the diagram below for usage
> > explaination.
> > 
> >     .-------------.  .---------------------------.
> >     |   vIOMMU    |  | Guest process mm, FL only |
> >     |             |  '---------------------------'
> >     .----------------/
> >     | PASID Entry |--- PASID cache flush -
> >     '-------------'                       |
> >     |             |                       V
> >     |             |
> >     '-------------'
> > Guest
> > ------| Shadow |--------------------------|------------
> >       v        v                          v
> > Host
> >     .-------------.  .----------------------.
> >     |   pIOMMU    |  | Bind FL for GVA-GPA  |
> >     |             |  '----------------------'
> >     .----------------/  |
> >     | PASID Entry |     V (Nested xlate)
> >     '----------------\.---------------------.
> >     |             |   |Set SL to GPA-HPA    |
> >     |             |   '---------------------'
> >     '-------------'
> > 
> > Where:
> >  - FL = First level/stage one page tables
> >  - SL = Second level/stage two page tables
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> >  drivers/iommu/iommu.c      | 20 ++++++++++++++++++++
> >  include/linux/iommu.h      | 10 ++++++++++
> >  include/uapi/linux/iommu.h | 15 ++++++++++++++-
> >  3 files changed, 44 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 498c28a..072f8f3 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1561,6 +1561,26 @@ int iommu_cache_invalidate(struct
> > iommu_domain *domain, struct device *dev, }
> >  EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
> >  
> > +int iommu_sva_bind_gpasid(struct iommu_domain *domain,
> > +			struct device *dev, struct
> > gpasid_bind_data *data) +{
> > +	if (unlikely(!domain->ops->sva_bind_gpasid))
> > +		return -ENODEV;
> > +
> > +	return domain->ops->sva_bind_gpasid(domain, dev, data);
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
> > +
> > +int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct
> > device *dev,
> > +			int pasid)
> > +{
> > +	if (unlikely(!domain->ops->sva_unbind_gpasid))
> > +		return -ENODEV;
> > +
> > +	return domain->ops->sva_unbind_gpasid(dev, pasid);
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
> > +
> >  static void __iommu_detach_device(struct iommu_domain *domain,
> >  				  struct device *dev)
> >  {
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 4b92e4b..611388e 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -231,6 +231,8 @@ struct iommu_sva_ops {
> >   * @detach_pasid_table: detach the pasid table
> >   * @cache_invalidate: invalidate translation caches
> >   * @pgsize_bitmap: bitmap of all possible supported page sizes
> > + * @sva_bind_gpasid: bind guest pasid and mm
> > + * @sva_unbind_gpasid: unbind guest pasid and mm
> >   */
> >  struct iommu_ops {
> >  	bool (*capable)(enum iommu_cap);
> > @@ -295,6 +297,10 @@ struct iommu_ops {
> >  
> >  	int (*cache_invalidate)(struct iommu_domain *domain,
> > struct device *dev, struct iommu_cache_invalidate_info *inv_info);
> > +	int (*sva_bind_gpasid)(struct iommu_domain *domain,
> > +			struct device *dev, struct
> > gpasid_bind_data *data); +
> > +	int (*sva_unbind_gpasid)(struct device *dev, int pasid);  
> So I am confused now. As the scalable mode PASID table entry contains
> both the FL and SL PT pointers, will you ever use the
> attach/detach_pasid_table or are we the only known users on ARM?
> 
In scalable mode, we will not use attach pasid table. So ARM will be
the only user for now.
Guest PASID table is shadowed, PASID cache flush in the guest will
trigger sva_bind_gpasid.
I introduced bind PASID table for the previous VT-d spec that has
extend context mode (deprecated), where SL is shared by all PASIDs on 
the same device.
> >  
> >  	unsigned long pgsize_bitmap;
> >  };
> > @@ -409,6 +415,10 @@ extern void iommu_detach_pasid_table(struct
> > iommu_domain *domain); extern int iommu_cache_invalidate(struct
> > iommu_domain *domain, struct device *dev,
> >  				  struct
> > iommu_cache_invalidate_info *inv_info); +extern int
> > iommu_sva_bind_gpasid(struct iommu_domain *domain,
> > +		struct device *dev, struct gpasid_bind_data *data);
> > +extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> > +				struct device *dev, int pasid);  
> definition in !CONFIG_IOMMU_API case?
right

> >  extern struct iommu_domain *iommu_get_domain_for_dev(struct device
> > *dev); extern struct iommu_domain *iommu_get_dma_domain(struct
> > device *dev); extern int iommu_map(struct iommu_domain *domain,
> > unsigned long iova, diff --git a/include/uapi/linux/iommu.h
> > b/include/uapi/linux/iommu.h index 61a3fb7..5c95905 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -235,6 +235,19 @@ struct iommu_cache_invalidate_info {
> >  		struct iommu_inv_addr_info addr_info;
> >  	};
> >  };
> > -
> > +/**
> > + * struct gpasid_bind_data - Information about device and guest
> > PASID binding
> > + * @gcr3:	Guest CR3 value from guest mm
> > + * @pasid:	Process address space ID used for the guest mm
> > + * @addr_width:	Guest address width. Paging mode can also
> > be derived.
> > + */
> > +struct gpasid_bind_data {
> > +	__u64 gcr3;
> > +	__u32 pasid;
> > +	__u32 addr_width;
> > +	__u32 flags;
> > +#define	IOMMU_SVA_GPASID_SRE	BIT(0) /* supervisor
> > request */
> > +	__u8 padding[4];
> > +};  
> 
> 
> Thanks
> 
> Eric
> >  
> >  #endif /* _UAPI_IOMMU_H */
> >   

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
