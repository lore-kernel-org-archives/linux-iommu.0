Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7CEC2BA19
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 15:53:19 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B12A2078B
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 15:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B12A2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EE3442033B;
	Wed, 15 Apr 2020 15:53:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IOZRqEQiaRTN; Wed, 15 Apr 2020 15:53:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D219E20382;
	Wed, 15 Apr 2020 15:53:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF7DFC089E;
	Wed, 15 Apr 2020 15:53:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B228DC0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 15:53:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A0D942033B
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 15:53:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gyZqmVQpPDrx for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 15:53:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by silver.osuosl.org (Postfix) with ESMTPS id 0120520531
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 15:53:13 +0000 (UTC)
IronPort-SDR: WppJ0AzoK0yVnLDz4taxkqtlOGrxetW8D015VGQx1UUs47JtvH875LIVe6NF4xJhI6KfEdCcHm
 bBuRq0+ttPlg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2020 08:53:13 -0700
IronPort-SDR: F6uUaqyd6cceLSV0Kq4PASCZhpm64sTmBxjVMAAcmV6plfo2xf/+A5Rr/5MG5sM7lvlIP+oEsC
 oMslcndCbN5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,387,1580803200"; d="scan'208";a="253561163"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga003.jf.intel.com with ESMTP; 15 Apr 2020 08:53:13 -0700
Date: Wed, 15 Apr 2020 08:59:08 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v11 01/13] iommu: Introduce attach/detach_pasid_table API
Message-ID: <20200415085908.0e1803b7@jacob-builder>
In-Reply-To: <c781ce8d-7fe4-0fee-ba95-a1e493e003f5@redhat.com>
References: <20200414150607.28488-1-eric.auger@redhat.com>
 <20200414150607.28488-2-eric.auger@redhat.com>
 <20200414151548.658a0401@jacob-builder>
 <c781ce8d-7fe4-0fee-ba95-a1e493e003f5@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, alex.williamson@redhat.com, kvm@vger.kernel.org,
 peter.maydell@linaro.org, maz@kernel.org, zhangfei.gao@foxmail.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, robin.murphy@arm.com, bbhushan2@marvell.com,
 will@kernel.org, kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
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

On Wed, 15 Apr 2020 16:52:10 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> On 4/15/20 12:15 AM, Jacob Pan wrote:
> > Hi Eric,
> > 
> > There are some discussions about how to size the uAPI data.
> > https://lkml.org/lkml/2020/4/14/939
> > 
> > I think the problem with the current scheme is that when uAPI data
> > gets extended, if VFIO continue to use:
> > 
> > minsz = offsetofend(struct vfio_iommu_type1_set_pasid_table,
> > config); if (copy_from_user(&spt, (void __user *)arg, minsz))
> > 
> > It may copy more data from user than what was setup by the user.
> > 
> > So, as suggested by Alex, we could add argsz to the IOMMU uAPI
> > struct. So if argsz > minsz, then fail the attach_table since
> > kernel might be old, doesn't know about the extra data.
> > If argsz <= minsz, kernel can support the attach_table but must
> > process the data based on flags or config.  
> 
> So I guess we would need both an argsz _u32 + a new flag _u32 right?
> 
Yes.
> I am ok with that idea. Besides how will you manage for existing IOMMU
> UAPIs?
I plan to add argsz and flags (if not already have one)

> At some point you envisionned to have a getter at iommu api
> level to retrieve the size of a structure for a given version, right?
> 
This idea is shot down. There is no version-size lookup.
So the current plan is for user to fill out argsz in each IOMMU uAPI
struct. VFIO does the copy_from_user() based on argsz (sanitized
against the size of current kernel struct).

IOMMU vendor driver process the data based on flags which indicates
new capability/extensions.

> Thanks
> 
> Eric
> > 
> > Does it make sense to you?
> > 
> > 
> > On Tue, 14 Apr 2020 17:05:55 +0200
> > Eric Auger <eric.auger@redhat.com> wrote:
> >   
> >> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>
> >> In virtualization use case, when a guest is assigned
> >> a PCI host device, protected by a virtual IOMMU on the guest,
> >> the physical IOMMU must be programmed to be consistent with
> >> the guest mappings. If the physical IOMMU supports two
> >> translation stages it makes sense to program guest mappings
> >> onto the first stage/level (ARM/Intel terminology) while the host
> >> owns the stage/level 2.
> >>
> >> In that case, it is mandated to trap on guest configuration
> >> settings and pass those to the physical iommu driver.
> >>
> >> This patch adds a new API to the iommu subsystem that allows
> >> to set/unset the pasid table information.
> >>
> >> A generic iommu_pasid_table_config struct is introduced in
> >> a new iommu.h uapi header. This is going to be used by the VFIO
> >> user API.
> >>
> >> Signed-off-by: Jean-Philippe Brucker
> >> <jean-philippe.brucker@arm.com> Signed-off-by: Liu, Yi L
> >> <yi.l.liu@linux.intel.com> Signed-off-by: Ashok Raj
> >> <ashok.raj@intel.com> Signed-off-by: Jacob Pan
> >> <jacob.jun.pan@linux.intel.com> Signed-off-by: Eric Auger
> >> <eric.auger@redhat.com> Reviewed-by: Jean-Philippe Brucker
> >> <jean-philippe.brucker@arm.com> ---
> >>  drivers/iommu/iommu.c      | 19 ++++++++++++++
> >>  include/linux/iommu.h      | 18 ++++++++++++++
> >>  include/uapi/linux/iommu.h | 51
> >> ++++++++++++++++++++++++++++++++++++++ 3 files changed, 88
> >> insertions(+)
> >>
> >> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> >> index 2b471419e26c..b71ad56f8c99 100644
> >> --- a/drivers/iommu/iommu.c
> >> +++ b/drivers/iommu/iommu.c
> >> @@ -1723,6 +1723,25 @@ int iommu_sva_unbind_gpasid(struct
> >> iommu_domain *domain, struct device *dev, }
> >>  EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
> >>  
> >> +int iommu_attach_pasid_table(struct iommu_domain *domain,
> >> +			     struct iommu_pasid_table_config *cfg)
> >> +{
> >> +	if (unlikely(!domain->ops->attach_pasid_table))
> >> +		return -ENODEV;
> >> +
> >> +	return domain->ops->attach_pasid_table(domain, cfg);
> >> +}
> >> +EXPORT_SYMBOL_GPL(iommu_attach_pasid_table);
> >> +
> >> +void iommu_detach_pasid_table(struct iommu_domain *domain)
> >> +{
> >> +	if (unlikely(!domain->ops->detach_pasid_table))
> >> +		return;
> >> +
> >> +	domain->ops->detach_pasid_table(domain);
> >> +}
> >> +EXPORT_SYMBOL_GPL(iommu_detach_pasid_table);
> >> +
> >>  static void __iommu_detach_device(struct iommu_domain *domain,
> >>  				  struct device *dev)
> >>  {
> >> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> >> index 7ef8b0bda695..3e1057c3585a 100644
> >> --- a/include/linux/iommu.h
> >> +++ b/include/linux/iommu.h
> >> @@ -248,6 +248,8 @@ struct iommu_iotlb_gather {
> >>   * @cache_invalidate: invalidate translation caches
> >>   * @sva_bind_gpasid: bind guest pasid and mm
> >>   * @sva_unbind_gpasid: unbind guest pasid and mm
> >> + * @attach_pasid_table: attach a pasid table
> >> + * @detach_pasid_table: detach the pasid table
> >>   * @pgsize_bitmap: bitmap of all possible supported page sizes
> >>   * @owner: Driver module providing these ops
> >>   */
> >> @@ -307,6 +309,9 @@ struct iommu_ops {
> >>  				      void *drvdata);
> >>  	void (*sva_unbind)(struct iommu_sva *handle);
> >>  	int (*sva_get_pasid)(struct iommu_sva *handle);
> >> +	int (*attach_pasid_table)(struct iommu_domain *domain,
> >> +				  struct iommu_pasid_table_config
> >> *cfg);
> >> +	void (*detach_pasid_table)(struct iommu_domain *domain);
> >>  
> >>  	int (*page_response)(struct device *dev,
> >>  			     struct iommu_fault_event *evt,
> >> @@ -446,6 +451,9 @@ extern int iommu_sva_bind_gpasid(struct
> >> iommu_domain *domain, struct device *dev, struct
> >> iommu_gpasid_bind_data *data); extern int
> >> iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device
> >> *dev, ioasid_t pasid); +extern int iommu_attach_pasid_table(struct
> >> iommu_domain *domain,
> >> +				    struct
> >> iommu_pasid_table_config *cfg); +extern void
> >> iommu_detach_pasid_table(struct iommu_domain *domain); extern
> >> struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
> >> extern struct iommu_domain *iommu_get_dma_domain(struct device
> >> *dev); extern int iommu_map(struct iommu_domain *domain, unsigned
> >> long iova, @@ -1048,6 +1056,16 @@ iommu_aux_get_pasid(struct
> >> iommu_domain *domain, struct device *dev) return -ENODEV; }
> >>  
> >> +static inline
> >> +int iommu_attach_pasid_table(struct iommu_domain *domain,
> >> +			     struct iommu_pasid_table_config *cfg)
> >> +{
> >> +	return -ENODEV;
> >> +}
> >> +
> >> +static inline
> >> +void iommu_detach_pasid_table(struct iommu_domain *domain) {}
> >> +
> >>  static inline struct iommu_sva *
> >>  iommu_sva_bind_device(struct device *dev, struct mm_struct *mm,
> >> void *drvdata) {
> >> diff --git a/include/uapi/linux/iommu.h
> >> b/include/uapi/linux/iommu.h index 4ad3496e5c43..8d00be10dc6d
> >> 100644 --- a/include/uapi/linux/iommu.h
> >> +++ b/include/uapi/linux/iommu.h
> >> @@ -321,4 +321,55 @@ struct iommu_gpasid_bind_data {
> >>  	};
> >>  };
> >>  
> >> +/**
> >> + * struct iommu_pasid_smmuv3 - ARM SMMUv3 Stream Table Entry
> >> stage 1 related
> >> + *     information
> >> + * @version: API version of this structure
> >> + * @s1fmt: STE s1fmt (format of the CD table: single CD, linear
> >> table
> >> + *         or 2-level table)
> >> + * @s1dss: STE s1dss (specifies the behavior when @pasid_bits != 0
> >> + *         and no PASID is passed along with the incoming
> >> transaction)
> >> + * @padding: reserved for future use (should be zero)
> >> + *
> >> + * The PASID table is referred to as the Context Descriptor (CD)
> >> table on ARM
> >> + * SMMUv3. Please refer to the ARM SMMU 3.x spec (ARM IHI 0070A)
> >> for full
> >> + * details.
> >> + */
> >> +struct iommu_pasid_smmuv3 {
> >> +#define PASID_TABLE_SMMUV3_CFG_VERSION_1 1
> >> +	__u32	version;
> >> +	__u8	s1fmt;
> >> +	__u8	s1dss;
> >> +	__u8	padding[2];
> >> +};
> >> +
> >> +/**
> >> + * struct iommu_pasid_table_config - PASID table data used to bind
> >> guest PASID
> >> + *     table to the host IOMMU
> >> + * @version: API version to prepare for future extensions
> >> + * @format: format of the PASID table
> >> + * @base_ptr: guest physical address of the PASID table
> >> + * @pasid_bits: number of PASID bits used in the PASID table
> >> + * @config: indicates whether the guest translation stage must
> >> + *          be translated, bypassed or aborted.
> >> + * @padding: reserved for future use (should be zero)
> >> + * @smmuv3: table information when @format is
> >> %IOMMU_PASID_FORMAT_SMMUV3
> >> + */
> >> +struct iommu_pasid_table_config {
> >> +#define PASID_TABLE_CFG_VERSION_1 1
> >> +	__u32	version;
> >> +#define IOMMU_PASID_FORMAT_SMMUV3	1
> >> +	__u32	format;
> >> +	__u64	base_ptr;
> >> +	__u8	pasid_bits;
> >> +#define IOMMU_PASID_CONFIG_TRANSLATE	1
> >> +#define IOMMU_PASID_CONFIG_BYPASS	2
> >> +#define IOMMU_PASID_CONFIG_ABORT	3
> >> +	__u8	config;
> >> +	__u8    padding[6];
> >> +	union {
> >> +		struct iommu_pasid_smmuv3 smmuv3;
> >> +	};
> >> +};
> >> +
> >>  #endif /* _UAPI_IOMMU_H */  
> > 
> > [Jacob Pan]
> >   
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
