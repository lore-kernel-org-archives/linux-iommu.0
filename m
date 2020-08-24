Return-Path: <SRS0=rIde=CC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B17C433E3
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 18:29:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD572074D
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 18:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SiRUisSj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD572074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C49F38820F;
	Mon, 24 Aug 2020 18:29:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6iv6J36UJ2rR; Mon, 24 Aug 2020 18:29:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 368F487E6C;
	Mon, 24 Aug 2020 18:29:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2496EC016F;
	Mon, 24 Aug 2020 18:29:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5CC7C0051
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:29:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 936C08816B
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:29:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cpOTNtdjadLK for <iommu@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 18:29:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id B88B087E6C
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 18:29:50 +0000 (UTC)
Received: by mail-ed1-f66.google.com with SMTP id w2so8958313edv.7
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 11:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KU4zqL83rIya+dDobk/RnK3hyM/osaOo/rErdYHKbRI=;
 b=SiRUisSjAktTKtcthtgr7dvGj8q5J831Nlf9lV8tc2OcwR/PHxo9YY/46lqekd1GxV
 X50UhVjg2rE6paV/EFkTiKtx+Ol/FxpFEy/v0INMuWUXuESqVJ1sca7NTP+DlBjGR8uL
 CWbngNmyDMtIMc6QHp+VjUgRokMMn2gb1T0BM9VybnsjDLu/T7Tt/OihAdL9yI3CI7VJ
 mGrdGZJ8y/s+EVDc2iq64JQ3UDfGl7UGkvejbj2b8YGPmrIdyFophillcvZe6Cvmi4xd
 M41JG2QUOTWxdLkvi8IH97OQT3/7QfObEqfcWHOfaAMPiCACf2YwdO2N7el0B8w1MN3j
 EiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KU4zqL83rIya+dDobk/RnK3hyM/osaOo/rErdYHKbRI=;
 b=PgZvEDkoCyIJsPW5nzhekUsU/NEb6N0ibqYsTwbyJdXOpN7V+4I+te0yfs5klYGaoX
 tRnEMw+8w1bXVoh+Mz9uQsKPuMEDJdarUAh9W+B7HDe8sF1s9TZhgN4Tv4kVApvtTfQd
 W2ECY+Q37+pUVzdwL0LxJpylfad6hPF3X4S6hT6lokHqnVLGy2uG5XXOmEQhRPxENc77
 joxPkSCQU9kxajj9YogyUG8h7jEWlkDpDYp5BWjPfuo0DAtnK06suk8KTEpzVONn1Qay
 ZQkyYhfvxAB/y5Utox2fujLNn6e79q4v16Gdu5YHSZs59b090+mqVf6dOQCnxyD76lj9
 azlA==
X-Gm-Message-State: AOAM533wBvHAxskuLcD2WNHmcORh2Up4XRyjQ1BANxdnK2YncjZK3aAQ
 4yV3nz20J2lyv0AFUZ+cxD/ReA==
X-Google-Smtp-Source: ABdhPJygYLealOvR28rVwZzTVa7qk5jJtMf4NND7+WXxpgF46I21oTc1IedTOaFRLVXWu5IRerM9VQ==
X-Received: by 2002:a05:6402:17d8:: with SMTP id
 s24mr6272779edy.61.1598293788731; 
 Mon, 24 Aug 2020 11:29:48 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id df22sm10447332edb.93.2020.08.24.11.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 11:29:48 -0700 (PDT)
Date: Mon, 24 Aug 2020 20:29:31 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.pan.linux@gmail.com>
Subject: Re: [PATCH v2 2/9] iommu/ioasid: Rename ioasid_set_data()
Message-ID: <20200824182931.GC3210689@myrica>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-3-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1598070918-21321-3-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Wu Hao <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

On Fri, Aug 21, 2020 at 09:35:11PM -0700, Jacob Pan wrote:
> Rename ioasid_set_data() to ioasid_attach_data() to avoid confusion with
> struct ioasid_set. ioasid_set is a group of IOASIDs that share a common
> token.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/intel/svm.c | 6 +++---
>  drivers/iommu/ioasid.c    | 6 +++---
>  include/linux/ioasid.h    | 4 ++--
>  3 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index b6972dca2ae0..37a9beabc0ca 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -342,7 +342,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>  			svm->gpasid = data->gpasid;
>  			svm->flags |= SVM_FLAG_GUEST_PASID;
>  		}
> -		ioasid_set_data(data->hpasid, svm);
> +		ioasid_attach_data(data->hpasid, svm);
>  		INIT_LIST_HEAD_RCU(&svm->devs);
>  		mmput(svm->mm);
>  	}
> @@ -394,7 +394,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>  	list_add_rcu(&sdev->list, &svm->devs);
>   out:
>  	if (!IS_ERR_OR_NULL(svm) && list_empty(&svm->devs)) {
> -		ioasid_set_data(data->hpasid, NULL);
> +		ioasid_attach_data(data->hpasid, NULL);
>  		kfree(svm);
>  	}
>  
> @@ -437,7 +437,7 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
>  				 * the unbind, IOMMU driver will get notified
>  				 * and perform cleanup.
>  				 */
> -				ioasid_set_data(pasid, NULL);
> +				ioasid_attach_data(pasid, NULL);
>  				kfree(svm);
>  			}
>  		}
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 0f8dd377aada..5f63af07acd5 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -258,14 +258,14 @@ void ioasid_unregister_allocator(struct ioasid_allocator_ops *ops)
>  EXPORT_SYMBOL_GPL(ioasid_unregister_allocator);
>  
>  /**
> - * ioasid_set_data - Set private data for an allocated ioasid
> + * ioasid_attach_data - Set private data for an allocated ioasid
>   * @ioasid: the ID to set data
>   * @data:   the private data
>   *
>   * For IOASID that is already allocated, private data can be set
>   * via this API. Future lookup can be done via ioasid_find.
>   */
> -int ioasid_set_data(ioasid_t ioasid, void *data)
> +int ioasid_attach_data(ioasid_t ioasid, void *data)
>  {
>  	struct ioasid_data *ioasid_data;
>  	int ret = 0;
> @@ -287,7 +287,7 @@ int ioasid_set_data(ioasid_t ioasid, void *data)
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(ioasid_set_data);
> +EXPORT_SYMBOL_GPL(ioasid_attach_data);
>  
>  /**
>   * ioasid_alloc - Allocate an IOASID
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 6f000d7a0ddc..9c44947a68c8 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -39,7 +39,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>  		  bool (*getter)(void *));
>  int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
> -int ioasid_set_data(ioasid_t ioasid, void *data);
> +int ioasid_attach_data(ioasid_t ioasid, void *data);
>  
>  #else /* !CONFIG_IOASID */
>  static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
> @@ -67,7 +67,7 @@ static inline void ioasid_unregister_allocator(struct ioasid_allocator_ops *allo
>  {
>  }
>  
> -static inline int ioasid_set_data(ioasid_t ioasid, void *data)
> +static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
>  {
>  	return -ENOTSUPP;
>  }
> -- 
> 2.7.4
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
