Return-Path: <SRS0=PWDw=5R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6C0C2D0F0
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 13:53:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1352220776
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 13:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ce+oo9Nv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1352220776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DA84D86D2B;
	Wed,  1 Apr 2020 13:53:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8HLKSpLhasfA; Wed,  1 Apr 2020 13:53:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D6E2285640;
	Wed,  1 Apr 2020 13:53:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7348C1D7F;
	Wed,  1 Apr 2020 13:53:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF6BCC089F
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 13:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D772A86D24
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 13:53:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B4W2DHW2Evhs for <iommu@lists.linux-foundation.org>;
 Wed,  1 Apr 2020 13:53:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 88CA485640
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 13:53:26 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id 31so151197wrs.3
 for <iommu@lists.linux-foundation.org>; Wed, 01 Apr 2020 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=N3VZNqRqFxDjiGDS6MHyTsfY3s8TOjT37n/Z1e8mgiU=;
 b=Ce+oo9NvsmwcUsd3osdUjFez8gIP5koyw/r4j/tFrHU5HPJj9pkz8MY2ohZkvJTtaf
 kNM+MjsvpJrfQjvNejXZHFMqsa0GfS1JNTdTENS1zXqZ/FYRCnyV1NKfn4r/cPyPcSWp
 6WAw+L2nBV46G4lBaOCqeS/FgUy7c3+t+KpVBjQJnReppMBYqpFVKrIF0sns5+q0o+rA
 s6+9EuwffMSHQIds85z5uxNFfweguEfw89WnyKW2Eh3XO5PSJCXjDn+h+cCUCkY0dQWA
 WXwDJn/yyF/vUvoHPQaVpzlwi28GFUmRJUFJcQAIYiKVdyOQRh/JI+60+LNUAI/av/lH
 trew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=N3VZNqRqFxDjiGDS6MHyTsfY3s8TOjT37n/Z1e8mgiU=;
 b=Bz28HGzXEEre1c6qEnAigVOGLqP7ElnHFctA563jVxOR0vOPfZ5ZBfJb0+W9cyuxpp
 qdzl5WhshJJYKPcyciTFeUKmjKvd+UXMaTojLvZ5aPxL0WI186/+GM0cYPnGPjR2LdEU
 mn02/6vTpPZk4gifzKfSDk/mVU5HvHs0niZUkPbtyyCYjSDg50x11iZIND8Z/JboilxN
 8rY0xdxjVsKyfCXkQVsJJj39oRZmtePZkXYlwgBAbwA2tbK18PNQJoT5NjAv+SWZu1N9
 uzt6HCP9GLRfbrf+gHIPYKWAqcoLdzFfN9roXxqgjHTy2LYFJQp+5YsdZ2/Qy2vXUj3j
 9Jsg==
X-Gm-Message-State: ANhLgQ37g9Xcf1+f4e1HLuG66NuokqveLeZsB1NVvUYTv1EEUdSwU21s
 Brmgpv7oTnZbdJbd2CgHwVWFFQ==
X-Google-Smtp-Source: ADFU+vuYgJ+1ZTqAp8KuvhZlz9S/Oxuge5ptpfnYD11EEFffsjQffMmg+At3JrOekagzuea5W0Z/Wg==
X-Received: by 2002:a5d:4cc4:: with SMTP id c4mr25665802wrt.346.1585749204818; 
 Wed, 01 Apr 2020 06:53:24 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:6097:1406:6470:33b5])
 by smtp.gmail.com with ESMTPSA id t10sm2764667wrx.38.2020.04.01.06.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 06:53:24 -0700 (PDT)
Date: Wed, 1 Apr 2020 15:53:16 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 05/10] iommu/ioasid: Create an IOASID set for host SVA use
Message-ID: <20200401135316.GF882512@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-6-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1585158931-1825-6-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
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

On Wed, Mar 25, 2020 at 10:55:26AM -0700, Jacob Pan wrote:
> Bare metal SVA allocates IOASIDs for native process addresses. This
> should be separated from VM allocated IOASIDs thus under its own set.
> 
> This patch creates a system IOASID set with its quota set to PID_MAX.
> This is a reasonable default in that SVM capable devices can only bind
> to limited user processes.

Yes realistically there won't be more than PID_MAX_DEFAULT=0x8000 bound
address spaces. My machine uses a PID_MAX of 4 million though, so in
theory more than 0x8000 processes may want a bond. On Arm the limit of
shared contexts per VM is currently a little less than 0x10000 (which is
the number of CPU ASIDs).

But quotas are only necessary for VMs, when the host shares the PASID
space with them (which isn't a use-case for Arm systems as far as I know,
each VM gets its own PASID space). Could we have quota-free IOASID sets
for the host?

For the SMMU I'd like to allocate two sets, one SVA and one private for
auxiliary domains, and I don't think giving either a quota makes much
sense at the moment. There can be systems using only SVA and systems using
only private PASIDs. I think it should be first-come-first-served until
admins want a knob to define a policy themselves, based on cgroups for
example.

> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 8 +++++++-
>  drivers/iommu/ioasid.c      | 9 +++++++++
>  include/linux/ioasid.h      | 9 +++++++++
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index ec3fc121744a..af7a1ef7b31e 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3511,8 +3511,14 @@ static int __init init_dmars(void)
>  		goto free_iommu;
>  
>  	/* PASID is needed for scalable mode irrespective to SVM */
> -	if (intel_iommu_sm)
> +	if (intel_iommu_sm) {
>  		ioasid_install_capacity(intel_pasid_max_id);
> +		/* We should not run out of IOASIDs at boot */
> +		if (ioasid_alloc_system_set(PID_MAX_DEFAULT)) {
> +			pr_err("Failed to enable host PASID allocator\n");
> +			intel_iommu_sm = 0;
> +		}
> +	}
>  
>  	/*
>  	 * for each drhd
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 6265d2dbbced..9135af171a7c 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -39,6 +39,9 @@ struct ioasid_data {
>  static ioasid_t ioasid_capacity;
>  static ioasid_t ioasid_capacity_avail;
>  
> +int system_ioasid_sid;
> +static DECLARE_IOASID_SET(system_ioasid);
> +
>  /* System capacity can only be set once */
>  void ioasid_install_capacity(ioasid_t total)
>  {
> @@ -51,6 +54,12 @@ void ioasid_install_capacity(ioasid_t total)
>  }
>  EXPORT_SYMBOL_GPL(ioasid_install_capacity);
>  
> +int ioasid_alloc_system_set(int quota)
> +{
> +	return ioasid_alloc_set(&system_ioasid, quota, &system_ioasid_sid);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_alloc_system_set);

I think this helper could stay in the VT-d driver for the moment. If the
SMMU driver ever implements auxiliary domains it will use a private IOASID
set, separate from the shared IOASID set managed by iommu-sva. Both could
qualify as "system set".

Thanks,
Jean

> +
>  /*
>   * struct ioasid_allocator_data - Internal data structure to hold information
>   * about an allocator. There are two types of allocators:
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 8c82d2625671..097b1cc043a3 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -29,6 +29,9 @@ struct ioasid_allocator_ops {
>  	void *pdata;
>  };
>  
> +/* Shared IOASID set for reserved for host system use */
> +extern int system_ioasid_sid;
> +
>  #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
>  
>  #if IS_ENABLED(CONFIG_IOASID)
> @@ -41,6 +44,7 @@ int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>  int ioasid_attach_data(ioasid_t ioasid, void *data);
>  void ioasid_install_capacity(ioasid_t total);
> +int ioasid_alloc_system_set(int quota);
>  int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int *sid);
>  void ioasid_free_set(int sid, bool destroy_set);
>  int ioasid_find_sid(ioasid_t ioasid);
> @@ -88,5 +92,10 @@ static inline void ioasid_install_capacity(ioasid_t total)
>  {
>  }
>  
> +static inline int ioasid_alloc_system_set(int quota)
> +{
> +	return -ENOTSUPP;
> +}
> +
>  #endif /* CONFIG_IOASID */
>  #endif /* __LINUX_IOASID_H */
> -- 
> 2.7.4
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
