Return-Path: <SRS0=cHqw=D4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F88C388F9
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 17:01:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F9FB222E9
	for <iommu@archiver.kernel.org>; Wed, 21 Oct 2020 17:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HAnWHjuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9FB222E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C492E2F9FB;
	Wed, 21 Oct 2020 17:01:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GzcYkUKOjhXy; Wed, 21 Oct 2020 17:01:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9F3662EC59;
	Wed, 21 Oct 2020 14:57:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CDC6C0052;
	Wed, 21 Oct 2020 14:57:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AFA8BC0051
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 14:57:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AB7648740B
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 14:57:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jwTmDeRQFUzb for <iommu@lists.linux-foundation.org>;
 Wed, 21 Oct 2020 14:57:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9A01B87401
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 14:57:55 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id v19so2871535edx.9
 for <iommu@lists.linux-foundation.org>; Wed, 21 Oct 2020 07:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8fS1Un7tm4hoyXJsqhftc1rCjizgyzgSNGUCjm2e3M8=;
 b=HAnWHjuqdAkDysqsuCVv7ZNFRz7Ch50Tyt8VWUH2yRgrGlTtpJXjd7/SOCjBdy54bp
 zCQT702zaGQKAAysikG0BrM62ZC2oIDeC8vEb1MpcUnSDt3TUf5wMhZR2W2BTPFIpfl0
 WJlD/dTSlRPUB4wKY4BQ5DGENmf8ydHKzAg3QJ96R5ex4dSW/OM6xVihfR2VoabVmOLP
 fM59T04L84Zg54APbj4xzZs7HK1uAufQWPFwAlR7tbs45adHVXqDtJJub2jg74rf7WRI
 KXPB8tECXuaEsx7b10fQhYnjzm3G4eEYxxSdZgbUalugBEQpvJUdsakkdHlZsA/6nwjD
 1QRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8fS1Un7tm4hoyXJsqhftc1rCjizgyzgSNGUCjm2e3M8=;
 b=PG+K7TjuTSbU8P4krSj9j3KStRnF93CTGRy/FROqmMsgC8uQMe5mSzNuQKrGF/3+hg
 gXa3XDu2mFEW3d8IHOsC59iQwcKnV77JCjYdkPHVHZdR+5qLPE1EO7SIRvOUw2s3avJl
 xw58EVKattJF+dBVcJS/LeO4xu7fVYAQKYK+WI7Ii676SixtBaEAqpcLWonpryFLKLgF
 as8eFdNx0RqJftmaCpoKvyXJwMQNH6q6Vp3rL2bfOlLCoZyI+hsQPe2u91Oltte+n5x+
 /Eyc8ljmXgIUo+7yCdlvPSzCtjwG1kOC642IppztqrAhuoXwF4IY+tL3ChyNfBk7XtOt
 cBlw==
X-Gm-Message-State: AOAM5317L8eBzYW6aGSEXKP0eH4kSWw1jbSGrCDmdgsyGqC8lx7vifqq
 bY0P4MXfhGIqlg2fOevrAwzVVQ==
X-Google-Smtp-Source: ABdhPJwpjrnhBHug8yxg0CgMBaHasHwZV1qOVXOGryBbHqLEvEQv6AWyUzedMz6X1p7Igtf2M8MzLg==
X-Received: by 2002:a05:6402:151a:: with SMTP id
 f26mr3587638edw.386.1603292274101; 
 Wed, 21 Oct 2020 07:57:54 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id r9sm1973753edt.3.2020.10.21.07.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 07:57:53 -0700 (PDT)
Date: Wed, 21 Oct 2020 16:57:34 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.pan.linux@gmail.com>
Subject: Re: [PATCH v3 07/14] iommu/ioasid: Add an iterator API for ioasid_set
Message-ID: <20201021145734.GE1653231@myrica>
References: <1601329121-36979-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1601329121-36979-8-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1601329121-36979-8-git-send-email-jacob.jun.pan@linux.intel.com>
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

On Mon, Sep 28, 2020 at 02:38:34PM -0700, Jacob Pan wrote:
> Users of an ioasid_set may not keep track of all the IOASIDs allocated
> under the set. When collective actions are needed for each IOASIDs, it
> is useful to iterate over all the IOASIDs within the set. For example,
> when the ioasid_set is freed, the user might perform the same cleanup
> operation on each IOASID.
> 
> This patch adds an API to iterate all the IOASIDs within the set.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Could add a short description of the function parameters, but

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/ioasid.c | 17 +++++++++++++++++
>  include/linux/ioasid.h |  9 +++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index cf8c7d34e2de..9628e78b2ab4 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -701,6 +701,23 @@ int ioasid_adjust_set(struct ioasid_set *set, int quota)
>  EXPORT_SYMBOL_GPL(ioasid_adjust_set);
>  
>  /**
> + * ioasid_set_for_each_ioasid - Iterate over all the IOASIDs within the set
> + *
> + * Caller must hold a reference of the set and handles its own locking.
> + */
> +void ioasid_set_for_each_ioasid(struct ioasid_set *set,
> +				void (*fn)(ioasid_t id, void *data),
> +				void *data)
> +{
> +	struct ioasid_data *entry;
> +	unsigned long index;
> +
> +	xa_for_each(&set->xa, index, entry)
> +		fn(index, data);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_set_for_each_ioasid);
> +
> +/**
>   * ioasid_find - Find IOASID data
>   * @set: the IOASID set
>   * @ioasid: the IOASID to find
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 0a5e82148eb9..aab58bc26714 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -75,6 +75,9 @@ int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>  int ioasid_attach_data(ioasid_t ioasid, void *data);
>  void ioasid_detach_data(ioasid_t ioasid);
> +void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
> +				void (*fn)(ioasid_t id, void *data),
> +				void *data);
>  #else /* !CONFIG_IOASID */
>  static inline void ioasid_install_capacity(ioasid_t total)
>  {
> @@ -131,5 +134,11 @@ static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
>  static inline void ioasid_detach_data(ioasid_t ioasid)
>  {
>  }
> +
> +static inline void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
> +					      void (*fn)(ioasid_t id, void *data),
> +					      void *data)
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
