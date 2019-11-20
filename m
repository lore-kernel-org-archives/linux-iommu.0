Return-Path: <SRS0=wR7u=ZM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A328AC432C3
	for <iommu@archiver.kernel.org>; Wed, 20 Nov 2019 20:59:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3BA2071F
	for <iommu@archiver.kernel.org>; Wed, 20 Nov 2019 20:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XjKsKehq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3BA2071F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4CCBC24BE8;
	Wed, 20 Nov 2019 20:59:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DhWJFAGZqxnU; Wed, 20 Nov 2019 20:59:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3E73C24A75;
	Wed, 20 Nov 2019 20:59:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AD62C1DC9;
	Wed, 20 Nov 2019 20:59:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68EB3C18DA
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 20:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 50441887BC
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 20:59:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m3WXRs0fpsTu for <iommu@lists.linux-foundation.org>;
 Wed, 20 Nov 2019 20:59:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 04BE2887BB
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 20:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574283581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wo+ZIg72qV+TilQzP5gFEMlESnLx+bJGy+3blH5Vk/c=;
 b=XjKsKehqABQJ4N8ZHpfjInvI5bd2yEBb2o6cagLoB6xX+Pq4CpNyak+PvbubsnC8VLDqdt
 YiR9OazINkbDryZWYmrNpxkrRFCH1kS9u9+opNG/45Vgjd8+nhguJwiA0UUiJR+A3q+4es
 ke8iPX/SETg+SGbrQboHO/tLnM++bAY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-hW26wTJ7NGaCdR8H60wEuA-1; Wed, 20 Nov 2019 15:59:38 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C2EF1883521;
 Wed, 20 Nov 2019 20:59:36 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2FEA175E3B;
 Wed, 20 Nov 2019 20:59:32 +0000 (UTC)
Subject: Re: [PATCH v3 1/8] iommu/vt-d: Fix CPU and IOMMU SVM feature matching
 checks
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>
References: <1574186193-30457-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1574186193-30457-2-git-send-email-jacob.jun.pan@linux.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <de4820e4-fd3f-d3fe-d133-4c83e2b1312b@redhat.com>
Date: Wed, 20 Nov 2019 21:59:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1574186193-30457-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: hW26wTJ7NGaCdR8H60wEuA-1
X-Mimecast-Spam-Score: 0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>
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

On 11/19/19 6:56 PM, Jacob Pan wrote:
> Shared Virtual Memory(SVM) is based on a collective set of hardware
> features detected at runtime. There are requirements for matching CPU
> and IOMMU capabilities.
> 
> The current code checks CPU and IOMMU feature set for SVM support but
> the result is never stored nor used. Therefore, SVM can still be used
> even when these checks failed. The consequences can be:
> 1. CPU uses 5-level paging mode for virtual address of 57 bits, but
> IOMMU can only support 4-level paging mode with 48 bits address for DMA.
> 2. 1GB page size is used by CPU but IOMMU does not support it. VT-d
> unrecoverable faults may be generated.
> 
> The best solution to fix these problems is to prevent them in the first
> place.
> 
> This patch consolidates code for checking PASID, CPU vs. IOMMU paging
> mode compatibility, as well as provides specific error messages for
> each failed checks. On sane hardware configurations, these error message
> shall never appear in kernel log.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  drivers/iommu/intel-iommu.c | 10 ++--------
>  drivers/iommu/intel-svm.c   | 40 +++++++++++++++++++++++++++-------------
>  include/linux/intel-iommu.h |  5 ++++-
>  3 files changed, 33 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 3f974919d3bd..d598168e410d 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3289,10 +3289,7 @@ static int __init init_dmars(void)
>  
>  		if (!ecap_pass_through(iommu->ecap))
>  			hw_pass_through = 0;
> -#ifdef CONFIG_INTEL_IOMMU_SVM
> -		if (pasid_supported(iommu))
> -			intel_svm_init(iommu);
> -#endif
> +		intel_svm_check(iommu);
>  	}
>  
>  	/*
> @@ -4471,10 +4468,7 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>  	if (ret)
>  		goto out;
>  
> -#ifdef CONFIG_INTEL_IOMMU_SVM
> -	if (pasid_supported(iommu))
> -		intel_svm_init(iommu);
> -#endif
> +	intel_svm_check(iommu);
>  
>  	if (dmaru->ignored) {
>  		/*
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 9b159132405d..716c543488f6 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -23,19 +23,6 @@
>  
>  static irqreturn_t prq_event_thread(int irq, void *d);
>  
> -int intel_svm_init(struct intel_iommu *iommu)
> -{
> -	if (cpu_feature_enabled(X86_FEATURE_GBPAGES) &&
> -			!cap_fl1gp_support(iommu->cap))
> -		return -EINVAL;
> -
> -	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
> -			!cap_5lp_support(iommu->cap))
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
>  #define PRQ_ORDER 0
>  
>  int intel_svm_enable_prq(struct intel_iommu *iommu)
> @@ -99,6 +86,33 @@ int intel_svm_finish_prq(struct intel_iommu *iommu)
>  	return 0;
>  }
>  
> +static inline bool intel_svm_capable(struct intel_iommu *iommu)
> +{
> +	return iommu->flags & VTD_FLAG_SVM_CAPABLE;
> +}
> +
> +void intel_svm_check(struct intel_iommu *iommu)
> +{
> +	if (!pasid_supported(iommu))
> +		return;
> +
> +	if (cpu_feature_enabled(X86_FEATURE_GBPAGES) &&
> +	    !cap_fl1gp_support(iommu->cap)) {
> +		pr_err("%s SVM disabled, incompatible 1GB page capability\n",
> +		       iommu->name);
> +		return;
> +	}
> +
> +	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
> +	    !cap_5lp_support(iommu->cap)) {
> +		pr_err("%s SVM disabled, incompatible paging mode\n",
> +		       iommu->name);
> +		return;
> +	}
> +
> +	iommu->flags |= VTD_FLAG_SVM_CAPABLE;
> +}
> +
>  static void intel_flush_svm_range_dev (struct intel_svm *svm, struct intel_svm_dev *sdev,
>  				unsigned long address, unsigned long pages, int ih)
>  {
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index ed11ef594378..7dcfa1c4a844 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -433,6 +433,7 @@ enum {
>  
>  #define VTD_FLAG_TRANS_PRE_ENABLED	(1 << 0)
>  #define VTD_FLAG_IRQ_REMAP_PRE_ENABLED	(1 << 1)
> +#define VTD_FLAG_SVM_CAPABLE		(1 << 2)
>  
>  extern int intel_iommu_sm;
>  
> @@ -656,7 +657,7 @@ void iommu_flush_write_buffer(struct intel_iommu *iommu);
>  int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev);
>  
>  #ifdef CONFIG_INTEL_IOMMU_SVM
> -int intel_svm_init(struct intel_iommu *iommu);
> +extern void intel_svm_check(struct intel_iommu *iommu);
>  extern int intel_svm_enable_prq(struct intel_iommu *iommu);
>  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
>  
> @@ -684,6 +685,8 @@ struct intel_svm {
>  };
>  
>  extern struct intel_iommu *intel_svm_device_to_iommu(struct device *dev);
> +#else
> +static inline void intel_svm_check(struct intel_iommu *iommu) {}
>  #endif
>  
>  #ifdef CONFIG_INTEL_IOMMU_DEBUGFS
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
