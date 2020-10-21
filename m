Return-Path: <SRS0=cHqw=D4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9116C55179
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 14:55:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11B982224E
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 14:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gtraypYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B982224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8A82886D39;
	Wed, 21 Oct 2020 14:55:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07KrBm0+sZ1m; Wed, 21 Oct 2020 14:55:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 820B886CFC;
	Wed, 21 Oct 2020 14:55:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7616FC0052;
	Wed, 21 Oct 2020 14:55:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E86E3C0051
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 14:55:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D23F0870EB
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 14:55:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1jnA1PJ0IbEf for <iommu@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 14:54:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com
 [209.85.218.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C4F09870EF
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 14:54:58 +0000 (UTC)
Received: by mail-ej1-f68.google.com with SMTP id u8so3701928ejg.1
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 07:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=BFCPvM2IrIxIbO/NAcdmKF4cshlij12nw9Eb0WJDBag=;
 b=gtraypYYX1Ts6KvEYPbWTw38IGVzD3hSarSd3/Gs5PLsvUR0OJ0quvcAk1qwBnB4eV
 E6qili6MZI8oOMOUenDUtlxhJb7rLtMhImtFofl3fq/Na6Udq4wr+05g5K2MG7pmP/Fk
 RIHSA1rm2s1ZRNmzGRZNvWpdiQSwFlRvi6DermMxq3byJLg7xzP9CMBhShZCDU1o8M1T
 GUWKNZwGtrolIY/ZUpP470LmDY13GXicW2Bv5diWJg+EykFuwV+jXR7apuP4VOJLEUAZ
 hTJYD2Y4TV4wKdvro4O4firrBitP8OqhnYCK6S4JlxRC0w9Q1lfqmkNteDpRRdVtOu0M
 xhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BFCPvM2IrIxIbO/NAcdmKF4cshlij12nw9Eb0WJDBag=;
 b=p5uQBxkyp+VpUxml6l6+GMuT5hr7WvsmTEr/59VhqkGv56DEsN2W/RcU/7Qn13998f
 9I02CtgXJTrXZhVvhNLAJFSJUkzX+nFcG3+Yp4bEdOLNXQ0bvDnbjvbVCqmfRUPSNrJ8
 ih1XtCu2ScQUaHpbcU5XWmbwyeBZPHBHWqjPrZU0AefpO7KkxCn4d2QsL6tqqxPOztP8
 rIDaFd+IuiX0hfEZxs5sIdKwS5tHR2k0qJr2VdKGl4AHAMtpOaKPJnu2p8ngm/cOZFvD
 Ye1SYqyMCfRpS2b3xMi2uMC6+BoA3gTHIJ+4tNsxUavObyDZLp5TTDiXvHWpMJJXu+eC
 vquA==
X-Gm-Message-State: AOAM533NKtk5rYoysp5lPv5FWBDPhW8t95jtQMv17GOkKFy7Hhg3LxK8
 q01clhAiXsQ60qFO1N+Tzz1C5g==
X-Google-Smtp-Source: ABdhPJzhzTRYyOOgZYy1AMK6rSQ1NL+2tSuKTUBIqZvdQLncyfEHZsHZ7BDLcE7Yw9HNN5D2QgbCQg==
X-Received: by 2002:a17:906:d292:: with SMTP id
 ay18mr4038597ejb.244.1603292097022; 
 Wed, 21 Oct 2020 07:54:57 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y1sm2226896edj.76.2020.10.21.07.54.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 07:54:56 -0700 (PDT)
Date: Wed, 21 Oct 2020 16:54:36 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.pan.linux@gmail.com>
Subject: Re: [PATCH v3 03/14] iommu/ioasid: Add a separate function for
 detach data
Message-ID: <20201021145436.GA1653231@myrica>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1601329121-36979-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1601329121-36979-4-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-api@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Yi Sun <yi.y.sun@intel.com>
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

On Mon, Sep 28, 2020 at 02:38:30PM -0700, Jacob Pan wrote:
> IOASID private data can be cleared by ioasid_attach_data() with a NULL
> data pointer. A common use case is for a caller to free the data
> afterward. ioasid_attach_data() calls synchronize_rcu() before return
> such that free data can be sure without outstanding readers.
> However, since synchronize_rcu() may sleep, ioasid_attach_data() cannot
> be used under spinlocks.
> 
> This patch adds ioasid_detach_data() as a separate API where
> synchronize_rcu() is called only in this case. ioasid_attach_data() can
> then be used under spinlocks. In addition, this change makes the API
> symmetrical.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

A typo below, but

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/intel/svm.c |  4 ++--
>  drivers/iommu/ioasid.c    | 54 ++++++++++++++++++++++++++++++++++++++---------
>  include/linux/ioasid.h    |  5 ++++-
>  3 files changed, 50 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 2c5645f0737a..06a16bee7b65 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -398,7 +398,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>  	list_add_rcu(&sdev->list, &svm->devs);
>   out:
>  	if (!IS_ERR_OR_NULL(svm) && list_empty(&svm->devs)) {
> -		ioasid_attach_data(data->hpasid, NULL);
> +		ioasid_detach_data(data->hpasid);
>  		kfree(svm);
>  	}
>  
> @@ -441,7 +441,7 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
>  				 * the unbind, IOMMU driver will get notified
>  				 * and perform cleanup.
>  				 */
> -				ioasid_attach_data(pasid, NULL);
> +				ioasid_detach_data(pasid);
>  				kfree(svm);
>  			}
>  		}
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 5f63af07acd5..6cfbdfb492e0 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -272,24 +272,58 @@ int ioasid_attach_data(ioasid_t ioasid, void *data)
>  
>  	spin_lock(&ioasid_allocator_lock);
>  	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> -	if (ioasid_data)
> -		rcu_assign_pointer(ioasid_data->private, data);
> -	else
> +
> +	if (!ioasid_data) {
>  		ret = -ENOENT;
> -	spin_unlock(&ioasid_allocator_lock);
> +		goto done_unlock;
> +	}
>  
> -	/*
> -	 * Wait for readers to stop accessing the old private data, so the
> -	 * caller can free it.
> -	 */
> -	if (!ret)
> -		synchronize_rcu();
> +	if (ioasid_data->private) {
> +		ret = -EBUSY;
> +		goto done_unlock;
> +	}
> +	rcu_assign_pointer(ioasid_data->private, data);
> +
> +done_unlock:
> +	spin_unlock(&ioasid_allocator_lock);
>  
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(ioasid_attach_data);
>  
>  /**
> + * ioasid_detach_data - Clear the private data of an ioasid
> + *
> + * @ioasid: the IOASIDD to clear private data

IOASID

> + */
> +void ioasid_detach_data(ioasid_t ioasid)
> +{
> +	struct ioasid_data *ioasid_data;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> +
> +	if (!ioasid_data) {
> +		pr_warn("IOASID %u not found to detach data from\n", ioasid);
> +		goto done_unlock;
> +	}
> +
> +	if (ioasid_data->private) {
> +		rcu_assign_pointer(ioasid_data->private, NULL);
> +		goto done_unlock;
> +	}
> +
> +done_unlock:
> +	spin_unlock(&ioasid_allocator_lock);
> +	/*
> +	 * Wait for readers to stop accessing the old private data,
> +	 * so the caller can free it.
> +	 */
> +	synchronize_rcu();
> +}
> +EXPORT_SYMBOL_GPL(ioasid_detach_data);
> +
> +/**
>   * ioasid_alloc - Allocate an IOASID
>   * @set: the IOASID set
>   * @min: the minimum ID (inclusive)
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 9c44947a68c8..c7f649fa970a 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -40,7 +40,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>  int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>  int ioasid_attach_data(ioasid_t ioasid, void *data);
> -
> +void ioasid_detach_data(ioasid_t ioasid);
>  #else /* !CONFIG_IOASID */
>  static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
>  				    ioasid_t max, void *private)
> @@ -72,5 +72,8 @@ static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
>  	return -ENOTSUPP;
>  }
>  
> +static inline void ioasid_detach_data(ioasid_t ioasid)
> +{
> +}
>  #endif /* CONFIG_IOASID */
>  #endif /* __LINUX_IOASID_H */
> -- 
> 2.7.4
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
