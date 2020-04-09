Return-Path: <SRS0=CVo8=5Z=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77787C2BB55
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 10:31:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DEFA2083E
	for <iommu@archiver.kernel.org>; Thu,  9 Apr 2020 10:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaKZ5F3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEFA2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1787B86AEB;
	Thu,  9 Apr 2020 10:31:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1guT_CJFKyzF; Thu,  9 Apr 2020 10:31:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 75D3186AD3;
	Thu,  9 Apr 2020 10:31:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5959FC089F;
	Thu,  9 Apr 2020 10:31:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 239B4C0177
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 10:31:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0E12286ADF
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 10:31:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CHXtD070u5-8 for <iommu@lists.linux-foundation.org>;
 Thu,  9 Apr 2020 10:31:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [205.139.110.61])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BBEF986AD3
 for <iommu@lists.linux-foundation.org>; Thu,  9 Apr 2020 10:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586428279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5l4oIm1W9iSBccPrCEaBXIuDP10N0FjMt/RbcFAy1Mo=;
 b=FaKZ5F3XrOL2vzXs3S36zGicyvn1ecEhqfQ9O/a0Gj9ogyAbmsHbeu/DBd91HvUf7kh3Yq
 Ld+AE1fw1pi0LQ5hjcIeyPnpjRF1SgE1HAUOHVLhEMAeP6WYA2jTRELY/d1fM7uvlhutxb
 LmZq8bQMOWc5IBfjg3RzGHa4u+20WwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-rsetYb6kPoiWgRizy7nklQ-1; Thu, 09 Apr 2020 06:31:14 -0400
X-MC-Unique: rsetYb6kPoiWgRizy7nklQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B875107ACC4;
 Thu,  9 Apr 2020 10:31:12 +0000 (UTC)
Received: from [10.36.115.53] (ovpn-115-53.ams2.redhat.com [10.36.115.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD0079A253;
 Thu,  9 Apr 2020 10:31:05 +0000 (UTC)
Subject: Re: [PATCH v11 10/10] iommu/vt-d: Add custom allocator for IOASID
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <1585939334-21396-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585939334-21396-11-git-send-email-jacob.jun.pan@linux.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7a471ea9-b31d-b0a7-f66f-1e23c253fbee@redhat.com>
Date: Thu, 9 Apr 2020 12:31:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1585939334-21396-11-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>
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

Hi Jacob,

On 4/3/20 8:42 PM, Jacob Pan wrote:
> When VT-d driver runs in the guest, PASID allocation must be
> performed via virtual command interface. This patch registers a
> custom IOASID allocator which takes precedence over the default
> XArray based allocator. The resulting IOASID allocation will always
> come from the host. This ensures that PASID namespace is system-
> wide.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 84 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/intel-iommu.h |  2 ++
>  2 files changed, 86 insertions(+)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 045c5c08d71d..ff3f0386951f 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -1732,6 +1732,9 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
>  		if (ecap_prs(iommu->ecap))
>  			intel_svm_finish_prq(iommu);
>  	}
> +	if (ecap_vcs(iommu->ecap) && vccap_pasid(iommu->vccap))
> +		ioasid_unregister_allocator(&iommu->pasid_allocator);
> +
>  #endif
>  }
>  
> @@ -3266,6 +3269,84 @@ static int copy_translation_tables(struct intel_iommu *iommu)
>  	return ret;
>  }
>  
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +static ioasid_t intel_vcmd_ioasid_alloc(ioasid_t min, ioasid_t max, void *data)
> +{
> +	struct intel_iommu *iommu = data;
> +	ioasid_t ioasid;
> +
> +	if (!iommu)
> +		return INVALID_IOASID;
> +	/*
> +	 * VT-d virtual command interface always uses the full 20 bit
> +	 * PASID range. Host can partition guest PASID range based on
> +	 * policies but it is out of guest's control.
> +	 */
> +	if (min < PASID_MIN || max > intel_pasid_max_id)
> +		return INVALID_IOASID;
> +
> +	if (vcmd_alloc_pasid(iommu, &ioasid))
> +		return INVALID_IOASID;
> +
> +	return ioasid;
> +}
> +
> +static void intel_vcmd_ioasid_free(ioasid_t ioasid, void *data)
> +{
> +	struct intel_iommu *iommu = data;
> +
> +	if (!iommu)
> +		return;
> +	/*
> +	 * Sanity check the ioasid owner is done at upper layer, e.g. VFIO
> +	 * We can only free the PASID when all the devices are unbound.
> +	 */
> +	if (ioasid_find(NULL, ioasid, NULL)) {
> +		pr_alert("Cannot free active IOASID %d\n", ioasid);
> +		return;
> +	}
> +	vcmd_free_pasid(iommu, ioasid);
> +}
> +
> +static void register_pasid_allocator(struct intel_iommu *iommu)
> +{
> +	/*
> +	 * If we are running in the host, no need for custom allocator
> +	 * in that PASIDs are allocated from the host system-wide.
> +	 */
> +	if (!cap_caching_mode(iommu->cap))
> +		return;
> +
> +	if (!sm_supported(iommu)) {
> +		pr_warn("VT-d Scalable Mode not enabled, no PASID allocation\n");
> +		return;
> +	}
> +
> +	/*
> +	 * Register a custom PASID allocator if we are running in a guest,
> +	 * guest PASID must be obtained via virtual command interface.
> +	 * There can be multiple vIOMMUs in each guest but only one allocator
> +	 * is active. All vIOMMU allocators will eventually be calling the same
> +	 * host allocator.
> +	 */
nit: I prefer
if (!ecap_vcs(iommu->ecap) || !vccap_pasid(iommu->vccap))
	returns;
as it removes indents.
		
> +	if (ecap_vcs(iommu->ecap) && vccap_pasid(iommu->vccap)) {
> +		pr_info("Register custom PASID allocator\n");
> +		iommu->pasid_allocator.alloc = intel_vcmd_ioasid_alloc;
> +		iommu->pasid_allocator.free = intel_vcmd_ioasid_free;
> +		iommu->pasid_allocator.pdata = (void *)iommu;
> +		if (ioasid_register_allocator(&iommu->pasid_allocator)) {
> +			pr_warn("Custom PASID allocator failed, scalable mode disabled\n");
> +			/*
> +			 * Disable scalable mode on this IOMMU if there
> +			 * is no custom allocator. Mixing SM capable vIOMMU
> +			 * and non-SM vIOMMU are not supported.
> +			 */
> +			intel_iommu_sm = 0;
> +		}
> +	}
> +}
> +#endif
> +
>  static int __init init_dmars(void)
>  {
>  	struct dmar_drhd_unit *drhd;
> @@ -3383,6 +3464,9 @@ static int __init init_dmars(void)
>  	 */
>  	for_each_active_iommu(iommu, drhd) {
>  		iommu_flush_write_buffer(iommu);
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +		register_pasid_allocator(iommu);
> +#endif
>  		iommu_set_root_entry(iommu);
>  		iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
>  		iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index f652db3198d9..e122cb30388e 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -19,6 +19,7 @@
>  #include <linux/iommu.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/dmar.h>
> +#include <linux/ioasid.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/iommu.h>
> @@ -588,6 +589,7 @@ struct intel_iommu {
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  	struct page_req_dsc *prq;
>  	unsigned char prq_name[16];    /* Name for PRQ interrupt */
> +	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for PASIDs */
>  #endif
>  	struct q_inval  *qi;            /* Queued invalidation info */
>  	u32 *iommu_state; /* Store iommu states between suspend and resume.*/
> 
Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
