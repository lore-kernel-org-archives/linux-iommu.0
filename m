Return-Path: <SRS0=cHqw=D4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB05C388F9
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 14:57:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F193222C8
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 14:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NoGcYBly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F193222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1A45C8740B;
	Wed, 21 Oct 2020 14:57:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rMhzzyNunLeJ; Wed, 21 Oct 2020 14:57:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6F31187401;
	Wed, 21 Oct 2020 14:57:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5723FC0052;
	Wed, 21 Oct 2020 14:57:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C77EC0051
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 14:57:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5AAF6863DB
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 14:57:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2GEMlGQ2VyWg for <iommu@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 14:57:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B265D863D9
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 14:57:30 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id c15so2585432ejs.0
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=uDhQg/1PwpQnDC2Kzqd7p30WxXAYl/Dt0HzmXyUtUtM=;
 b=NoGcYBlystc010ave+WzAHOpt++dZH1i/YRqz/rXzQfPQOwEAjmaEqQhJaS+WWtMTu
 6GVHomUOSTiseTimztfpf+NO3y7sVKox40ScNxOCe56vlQAJNNBkF3qgzhhMc/rZFE2H
 J1aU0qD1e0TA/fp9RXG49pFSkYRWc5SC3vXLBxW73s3rtQiVpQz0thT1Y/DAawSq8Zf+
 l6V9/VQ0P7tG3WEqgMPwvw0JR8YMJemq+RnNArdFxVDpzpmDmI3tbC0Qq13g7nVdqVlk
 JZPNMSURbeKabzPhg0An0u6KY/iO79UYfkAmm53xgLkTBmxKgbQBDsjT84uufnqcTt0A
 7Jbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uDhQg/1PwpQnDC2Kzqd7p30WxXAYl/Dt0HzmXyUtUtM=;
 b=Dh04g50aGDuSWueRfGmoO4bP8VqDdoySIQXUYQ/uiRmc20J7+g/HHTZ0kmFmkoI8FW
 ffUA09AxDvJ4gOaR9NUFUe3ODV3pQyDwXWUkxV1nuDKMqFgdoBtEdfK1AQS1L1RzR18J
 netZbcXBzJ651HR9g8f+Ec/ACUQyfHlCVSByT7Njl34fprCFXTKUBarGwgUg9xjgy3no
 2NcrRugfCXoYOgOvv0vWav7UFsTKI8A6SwFzclSMSXiP2wsks2dMktAV8odYXsPJIVl2
 2IZAhOiMAam3FdRf8a8aMae52lHG7nv5bfQ6spZvl7+4s15rPPMpxuvLxIgoeVjokXes
 7cJQ==
X-Gm-Message-State: AOAM530qw9R//r5/iXJRsygKOu4tL/gbD2QX50dil0Hw4R0oZtvg1dBA
 3ZONvGQCGevGayFdGieyNUKpiQ==
X-Google-Smtp-Source: ABdhPJy6ik6ltUjA3Gre7jtRggbeq5hOPX2y/q2s1z+uiXxa5wNrPld0RrdyPY19/Z5YmdIFB92h2A==
X-Received: by 2002:a17:906:e15:: with SMTP id
 l21mr4022951eji.509.1603292249135; 
 Wed, 21 Oct 2020 07:57:29 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id z2sm110970edr.64.2020.10.21.07.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 07:57:28 -0700 (PDT)
Date: Wed, 21 Oct 2020 16:57:09 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.pan.linux@gmail.com>
Subject: Re: [PATCH v3 06/14] iommu/ioasid: Introduce API to adjust the quota
 of an ioasid_set
Message-ID: <20201021145709.GD1653231@myrica>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1601329121-36979-7-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1601329121-36979-7-git-send-email-jacob.jun.pan@linux.intel.com>
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

On Mon, Sep 28, 2020 at 02:38:33PM -0700, Jacob Pan wrote:
> Each ioasid_set is given a quota during allocation. As system
> administrators balance resources among VMs, we shall support the
> adjustment of quota at runtime. The new quota cannot be less than the
> outstanding IOASIDs already allocated within the set. The extra quota
> will be returned to the system-wide IOASID pool if the new quota is
> smaller than the existing one.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Minor comments below, but

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/ioasid.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/ioasid.h |  6 ++++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 61e25c2375ab..cf8c7d34e2de 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -654,6 +654,53 @@ void ioasid_set_put(struct ioasid_set *set)
>  EXPORT_SYMBOL_GPL(ioasid_set_put);
>  
>  /**
> + * ioasid_adjust_set - Adjust the quota of an IOASID set
> + * @set:	IOASID set to be assigned
> + * @quota:	Quota allowed in this set
> + *
> + * Return 0 on success. If the new quota is smaller than the number of
> + * IOASIDs already allocated, -EINVAL will be returned. No change will be
> + * made to the existing quota.
> + */
> +int ioasid_adjust_set(struct ioasid_set *set, int quota)

@quota probably doesn't need to be signed (since it's the same as an
ioasid_t, which is unsigned).

> +{
> +	int ret = 0;
> +
> +	if (quota <= 0)
> +		return -EINVAL;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +	if (set->nr_ioasids > quota) {
> +		pr_err("New quota %d is smaller than outstanding IOASIDs %d\n",
> +			quota, set->nr_ioasids);
> +		ret = -EINVAL;
> +		goto done_unlock;
> +	}
> +
> +	if ((quota > set->quota) &&
> +		(quota - set->quota > ioasid_capacity_avail)) {

misaligned

> +		ret = -ENOSPC;
> +		goto done_unlock;
> +	}
> +
> +	/* Return the delta back to system pool */
> +	ioasid_capacity_avail += set->quota - quota;
> +
> +	/*
> +	 * May have a policy to prevent giving all available IOASIDs
> +	 * to one set. But we don't enforce here, it should be in the
> +	 * upper layers.
> +	 */

I think here would be OK to check about fairness. But anyway, we don't
have to worry about this yet, so I'd just drop the comment.

Thanks,
Jean

> +	set->quota = quota;
> +
> +done_unlock:
> +	spin_unlock(&ioasid_allocator_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_adjust_set);
> +
> +/**
>   * ioasid_find - Find IOASID data
>   * @set: the IOASID set
>   * @ioasid: the IOASID to find
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 1ae213b660f0..0a5e82148eb9 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -62,6 +62,7 @@ struct ioasid_allocator_ops {
>  void ioasid_install_capacity(ioasid_t total);
>  ioasid_t ioasid_get_capacity(void);
>  struct ioasid_set *ioasid_set_alloc(void *token, ioasid_t quota, int type);
> +int ioasid_adjust_set(struct ioasid_set *set, int quota);
>  void ioasid_set_get(struct ioasid_set *set);
>  void ioasid_set_put(struct ioasid_set *set);
>  
> @@ -99,6 +100,11 @@ static inline struct ioasid_set *ioasid_set_alloc(void *token, ioasid_t quota, i
>  	return ERR_PTR(-ENOTSUPP);
>  }
>  
> +static inline int ioasid_adjust_set(struct ioasid_set *set, int quota)
> +{
> +	return -ENOTSUPP;
> +}
> +
>  static inline void ioasid_set_put(struct ioasid_set *set)
>  {
>  }
> -- 
> 2.7.4
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
