Return-Path: <SRS0=PWDw=5R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7BBC2D0F3
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 15:42:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 328A1212CC
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 15:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328A1212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 074F0882A9;
	Wed,  1 Apr 2020 15:42:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id clVoLBvl1yIb; Wed,  1 Apr 2020 15:42:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 48EA1882A3;
	Wed,  1 Apr 2020 15:42:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B2E4C1D7F;
	Wed,  1 Apr 2020 15:42:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74338C089F
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 15:42:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5E6EC86D8D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 15:42:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l9FL66ESEG_h for <iommu@lists.linux-foundation.org>;
 Wed,  1 Apr 2020 15:42:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6D5F386D8B
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 15:42:12 +0000 (UTC)
IronPort-SDR: /P36AvDWVdgfsti/+L3tsBQ0+4ElqHLfDCIoVEKmnDZkLFjishqccOWs8h4+wZuzZJh4kSEeMi
 hXhL/WMlrs4g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2020 08:42:11 -0700
IronPort-SDR: rgCl/iz8Ek08zmzuVmldpgZqfvojhQHg1defdVYSXAfYoo4olQfaqbZ1R5j8j90i2P1BvHtIXv
 XhCaL5zD5Xlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,332,1580803200"; d="scan'208";a="328495700"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga001.jf.intel.com with ESMTP; 01 Apr 2020 08:42:11 -0700
Date: Wed, 1 Apr 2020 08:47:59 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH V10 11/11] iommu/vt-d: Add custom allocator for IOASID
Message-ID: <20200401084759.575b38c4@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA146@SHSMSX104.ccr.corp.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-12-git-send-email-jacob.jun.pan@linux.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA146@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

On Sat, 28 Mar 2020 10:22:41 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Saturday, March 21, 2020 7:28 AM
> > 
> > When VT-d driver runs in the guest, PASID allocation must be
> > performed via virtual command interface. This patch registers a
> > custom IOASID allocator which takes precedence over the default
> > XArray based allocator. The resulting IOASID allocation will always
> > come from the host. This ensures that PASID namespace is system-
> > wide.
> > 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel-iommu.c | 84
> > +++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/intel-iommu.h |  2 ++
> >  2 files changed, 86 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index a76afb0fd51a..c1c0b0fb93c3
> > 100644 --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -1757,6 +1757,9 @@ static void free_dmar_iommu(struct intel_iommu
> > *iommu)
> >  		if (ecap_prs(iommu->ecap))
> >  			intel_svm_finish_prq(iommu);
> >  	}
> > +	if (ecap_vcs(iommu->ecap) && vccap_pasid(iommu->vccap))
> > +
> > ioasid_unregister_allocator(&iommu->pasid_allocator); +
> >  #endif
> >  }
> > 
> > @@ -3291,6 +3294,84 @@ static int copy_translation_tables(struct
> > intel_iommu *iommu)
> >  	return ret;
> >  }
> > 
> > +#ifdef CONFIG_INTEL_IOMMU_SVM
> > +static ioasid_t intel_ioasid_alloc(ioasid_t min, ioasid_t max,
> > void *data)  
> 
> the name is too generic... can we add vcmd in the name to clarify
> its purpose, e.g. intel_vcmd_ioasid_alloc?
> 
I feel the intel_ prefix is a natural extension of a generic API, we do
that for other IOMMU APIs, right?

> > +{
> > +	struct intel_iommu *iommu = data;
> > +	ioasid_t ioasid;
> > +
> > +	if (!iommu)
> > +		return INVALID_IOASID;
> > +	/*
> > +	 * VT-d virtual command interface always uses the full 20
> > bit
> > +	 * PASID range. Host can partition guest PASID range based
> > on
> > +	 * policies but it is out of guest's control.
> > +	 */
> > +	if (min < PASID_MIN || max > intel_pasid_max_id)
> > +		return INVALID_IOASID;
> > +
> > +	if (vcmd_alloc_pasid(iommu, &ioasid))
> > +		return INVALID_IOASID;
> > +
> > +	return ioasid;
> > +}
> > +
> > +static void intel_ioasid_free(ioasid_t ioasid, void *data)
> > +{
> > +	struct intel_iommu *iommu = data;
> > +
> > +	if (!iommu)
> > +		return;
> > +	/*
> > +	 * Sanity check the ioasid owner is done at upper layer,
> > e.g. VFIO
> > +	 * We can only free the PASID when all the devices are
> > unbound.
> > +	 */
> > +	if (ioasid_find(NULL, ioasid, NULL)) {
> > +		pr_alert("Cannot free active IOASID %d\n", ioasid);
> > +		return;
> > +	}  
> 
> However the sanity check is not done in default_free. Is there a
> reason why using vcmd adds such  new requirement?
> 
Since we don't support nested guest. This vcmd allocator is only used
by the guest IOMMU driver not VFIO. We expect IOMMU driver to have
control of the free()/unbind() ordering.

For default_free, it can come from user space and host VFIO which can
be out of order. But we will solve that issue with the blocking
notifier.

> > +	vcmd_free_pasid(iommu, ioasid);
> > +}
> > +
> > +static void register_pasid_allocator(struct intel_iommu *iommu)
> > +{
> > +	/*
> > +	 * If we are running in the host, no need for custom
> > allocator
> > +	 * in that PASIDs are allocated from the host system-wide.
> > +	 */
> > +	if (!cap_caching_mode(iommu->cap))
> > +		return;  
> 
> is it more accurate to check against vcmd capability?
> 
I think this is sufficient. The spec says if vcmd is present, we must
use it but not the other way.

> > +
> > +	if (!sm_supported(iommu)) {
> > +		pr_warn("VT-d Scalable Mode not enabled, no PASID
> > allocation\n");
> > +		return;
> > +	}
> > +
> > +	/*
> > +	 * Register a custom PASID allocator if we are running in
> > a guest,
> > +	 * guest PASID must be obtained via virtual command
> > interface.
> > +	 * There can be multiple vIOMMUs in each guest but only one
> > allocator
> > +	 * is active. All vIOMMU allocators will eventually be
> > calling the same  
> 
> which one? the first or last?
> 
All allocators share the same ops, so first=last. IOASID code will
inspect the ops function and see if they are shared with others then
use the same ops.

> > +	 * host allocator.
> > +	 */
> > +	if (ecap_vcs(iommu->ecap) && vccap_pasid(iommu->vccap)) {
> > +		pr_info("Register custom PASID allocator\n");
> > +		iommu->pasid_allocator.alloc = intel_ioasid_alloc;
> > +		iommu->pasid_allocator.free = intel_ioasid_free;
> > +		iommu->pasid_allocator.pdata = (void *)iommu;
> > +		if
> > (ioasid_register_allocator(&iommu->pasid_allocator)) {
> > +			pr_warn("Custom PASID allocator failed,
> > scalable mode disabled\n");
> > +			/*
> > +			 * Disable scalable mode on this IOMMU if
> > there
> > +			 * is no custom allocator. Mixing SM
> > capable vIOMMU
> > +			 * and non-SM vIOMMU are not supported.
> > +			 */
> > +			intel_iommu_sm = 0;  
> 
> since you register an allocator for every vIOMMU, means previously
> registered allocators should also be unregistered here?
> 
True, but it is not necessary for two reasons:
1. This should not happen unless something went seriously wrong.
All vIOMMU shares the same alloc/free function, so they are put under
the same bucket by IOASID. So the case for the first vIOMMU to succeed
then fail in later vIOMMU registration should not happen. Unless kernel
run out of memory etc.

2. Once SM is disabled, there is no user of ioasid allocator.

> > +		}
> > +	}
> > +}
> > +#endif
> > +
> >  static int __init init_dmars(void)
> >  {
> >  	struct dmar_drhd_unit *drhd;
> > @@ -3408,6 +3489,9 @@ static int __init init_dmars(void)
> >  	 */
> >  	for_each_active_iommu(iommu, drhd) {
> >  		iommu_flush_write_buffer(iommu);
> > +#ifdef CONFIG_INTEL_IOMMU_SVM
> > +		register_pasid_allocator(iommu);
> > +#endif
> >  		iommu_set_root_entry(iommu);
> >  		iommu->flush.flush_context(iommu, 0, 0, 0,
> > DMA_CCMD_GLOBAL_INVL);
> >  		iommu->flush.flush_iotlb(iommu, 0, 0, 0,
> > DMA_TLB_GLOBAL_FLUSH);
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index 9cbf5357138b..9c357a325c72
> > 100644 --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -19,6 +19,7 @@
> >  #include <linux/iommu.h>
> >  #include <linux/io-64-nonatomic-lo-hi.h>
> >  #include <linux/dmar.h>
> > +#include <linux/ioasid.h>
> > 
> >  #include <asm/cacheflush.h>
> >  #include <asm/iommu.h>
> > @@ -563,6 +564,7 @@ struct intel_iommu {
> >  #ifdef CONFIG_INTEL_IOMMU_SVM
> >  	struct page_req_dsc *prq;
> >  	unsigned char prq_name[16];    /* Name for PRQ interrupt */
> > +	struct ioasid_allocator_ops pasid_allocator; /* Custom
> > allocator for PASIDs */
> >  #endif
> >  	struct q_inval  *qi;            /* Queued invalidation
> > info */ u32 *iommu_state; /* Store iommu states between suspend and
> > resume.*/
> > --
> > 2.7.4  
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
