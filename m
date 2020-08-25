Return-Path: <SRS0=rFPO=CD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6A4C433E3
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 10:20:01 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E0A42068F
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 10:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wq9KLpLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0A42068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D531A87CA2;
	Tue, 25 Aug 2020 10:20:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q4FzVhjk-cWL; Tue, 25 Aug 2020 10:19:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 80FC887C8E;
	Tue, 25 Aug 2020 10:19:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69FFEC088B;
	Tue, 25 Aug 2020 10:19:59 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4D0DC016F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 10:19:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C46BC860CD
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 10:19:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kOuTpklytAXa for <iommu@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 10:19:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com
 [209.85.218.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A8E0685DF6
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 10:19:56 +0000 (UTC)
Received: by mail-ej1-f67.google.com with SMTP id u21so15146077ejz.0
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 03:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=g18an+DnGAA2/tAmNxTP2/NMhw8KAjHBuuMiMwzqHUs=;
 b=Wq9KLpLV7gS2hZMsyl2+UIAW9Sr/bOA3Pgi3h1lsSFHVBCle6Ln0BwaIXMkWrNbb82
 PsbJ36Vd3j7UkVMV1Aih/kPt7HDZ9d33Xg6KquakrieGFJI7OZP+gzIfb8klpTgUTa95
 EvgiOeAZnO9Qm9683tKZelPpeYVY6D2Lizp8cpZDd4y72gZGUEvXfL+3UysI8taIwEbK
 CyhaXu3VgdSDbsKiDywKAFN6v7MGkCWpsYUF2eoQZcY1Xcj5rlk3jYedsfFc0bB1bhsh
 A0VpkWQpvzIsAfvAjT359ThTa69X800czoFouF9izDHGR4usfHggB7SU+7xKJyKTqkPR
 Bofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=g18an+DnGAA2/tAmNxTP2/NMhw8KAjHBuuMiMwzqHUs=;
 b=RDKRzfI1jaZfgXiAt+LjG6jhBASUN2cB/PgsuE9MYRjxHlaC1n6qom5e6ogmOEx/ox
 vHkHqeOFDahKu0TYsRqK97SIwbcgH+LunquKBBDNhxOmmeUaLHXUmLerjUv4hj0b/C3j
 1IZqn1hxH+jAVW3oYNVXwZm6oSp8oMf2Z4evARdMYs8gNKYrGCbSprT7hyXa2vQ0KmbL
 Sn2Zv+AwecKR0F/Ieyd9W6Yts5SzxYwchNimEKPcMwCfEbkLX2J/Klq+Rp1zzCJqHgKN
 mOXEaVGw7PxQEbqsYfdfnT7G+uVmvRp4sKgzcUOzD4nqrVN1MoGhYxExXH5qWBoxBLSS
 V2ew==
X-Gm-Message-State: AOAM531WkQlcldfTWwviS944SY8bVJ3VZyTZ+BYWG8tVrvsKPLEnRhFc
 zpaDEBbzT2/h6Xu1xWr0CdIVwg==
X-Google-Smtp-Source: ABdhPJwxPOml6Gv5fBtKomLGI/+jo8vwNZePq0KfoSrMCm6JvGRloclftRCgdC9/se1yRCOMLoKxVg==
X-Received: by 2002:a17:906:2998:: with SMTP id
 x24mr7058914eje.131.1598350794888; 
 Tue, 25 Aug 2020 03:19:54 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id j5sm10266638edy.29.2020.08.25.03.19.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 03:19:54 -0700 (PDT)
Date: Tue, 25 Aug 2020 12:19:37 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.pan.linux@gmail.com>
Subject: Re: [PATCH v2 4/9] iommu/ioasid: Add reference couting functions
Message-ID: <20200825101937.GA3252704@myrica>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-5-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1598070918-21321-5-git-send-email-jacob.jun.pan@linux.intel.com>
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

On Fri, Aug 21, 2020 at 09:35:13PM -0700, Jacob Pan wrote:
> There can be multiple users of an IOASID, each user could have hardware
> contexts associated with the IOASID. In order to align lifecycles,
> reference counting is introduced in this patch. It is expected that when
> an IOASID is being freed, each user will drop a reference only after its
> context is cleared.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/ioasid.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/ioasid.h |   4 ++
>  2 files changed, 117 insertions(+)
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index f73b3dbfc37a..5f31d63c75b1 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -717,6 +717,119 @@ int ioasid_set_for_each_ioasid(struct ioasid_set *set,
>  EXPORT_SYMBOL_GPL(ioasid_set_for_each_ioasid);
>  
>  /**
> + * IOASID refcounting rules
> + * - ioasid_alloc() set initial refcount to 1
> + *
> + * - ioasid_free() decrement and test refcount.
> + *     If refcount is 0, ioasid will be freed. Deleted from the system-wide
> + *     xarray as well as per set xarray. The IOASID will be returned to the
> + *     pool and available for new allocations.
> + *
> + *     If recount is non-zero, mark IOASID as IOASID_STATE_FREE_PENDING.
> + *     No new reference can be added. The IOASID is not returned to the pool
> + *     for reuse.
> + *     After free, ioasid_get() will return error but ioasid_find() and other
> + *     non refcount adding APIs will continue to work until the last reference
> + *     is dropped
> + *
> + * - ioasid_get() get a reference on an active IOASID
> + *
> + * - ioasid_put() decrement and test refcount of the IOASID.
> + *     If refcount is 0, ioasid will be freed. Deleted from the system-wide
> + *     xarray as well as per set xarray. The IOASID will be returned to the
> + *     pool and available for new allocations.
> + *     Do nothing if refcount is non-zero.
> + *
> + * - ioasid_find() does not take reference, caller must hold reference
> + *
> + * ioasid_free() can be called multiple times without error until all refs are
> + * dropped.
> + */

Since you already document this in ioasid.rst, I'm not sure the comment
is necessary. Maybe the doc for _free/_put would be better in the
function's documentation.

> +
> +int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid)
> +{
> +	struct ioasid_data *data;
> +
> +	data = xa_load(&active_allocator->xa, ioasid);
> +	if (!data) {
> +		pr_err("Trying to get unknown IOASID %u\n", ioasid);
> +		return -EINVAL;
> +	}
> +	if (data->state == IOASID_STATE_FREE_PENDING) {
> +		pr_err("Trying to get IOASID being freed%u\n", ioasid);
> +		return -EBUSY;
> +	}
> +
> +	if (set && data->set != set) {
> +		pr_err("Trying to get IOASID not in set%u\n", ioasid);
> +		/* data found but does not belong to the set */
> +		return -EACCES;
> +	}
> +	refcount_inc(&data->users);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_get_locked);

Is it necessary to export the *_locked variant?  Who'd call them and how
would they acquire the lock?

> +
> +/**
> + * ioasid_get - Obtain a reference of an ioasid
> + * @set
> + * @ioasid

Can be dropped. The doc checker will throw a warning, though.

> + *
> + * Check set ownership if @set is non-null.
> + */
> +int ioasid_get(struct ioasid_set *set, ioasid_t ioasid)
> +{
> +	int ret = 0;

No need to initialize ret

> +
> +	spin_lock(&ioasid_allocator_lock);
> +	ret = ioasid_get_locked(set, ioasid);
> +	spin_unlock(&ioasid_allocator_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_get);
> +
> +void ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid)
> +{
> +	struct ioasid_data *data;
> +
> +	data = xa_load(&active_allocator->xa, ioasid);
> +	if (!data) {
> +		pr_err("Trying to put unknown IOASID %u\n", ioasid);
> +		return;
> +	}
> +
> +	if (set && data->set != set) {
> +		pr_err("Trying to drop IOASID not in the set %u\n", ioasid);
> +		return;
> +	}
> +
> +	if (!refcount_dec_and_test(&data->users)) {
> +		pr_debug("%s: IOASID %d has %d remainning users\n",
> +			__func__, ioasid, refcount_read(&data->users));
> +		return;
> +	}
> +	ioasid_do_free(data);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_put_locked);
> +
> +/**
> + * ioasid_put - Drop a reference of an ioasid
> + * @set
> + * @ioasid
> + *
> + * Check set ownership if @set is non-null.
> + */
> +void ioasid_put(struct ioasid_set *set, ioasid_t ioasid)
> +{
> +	spin_lock(&ioasid_allocator_lock);
> +	ioasid_put_locked(set, ioasid);
> +	spin_unlock(&ioasid_allocator_lock);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_put);
> +
> +/**
>   * ioasid_find - Find IOASID data
>   * @set: the IOASID set
>   * @ioasid: the IOASID to find
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 412d025d440e..310abe4187a3 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -76,6 +76,10 @@ int ioasid_attach_data(ioasid_t ioasid, void *data);
>  int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_is_in_set(struct ioasid_set *set, ioasid_t ioasid);
> +int ioasid_get(struct ioasid_set *set, ioasid_t ioasid);
> +int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid);
> +void ioasid_put(struct ioasid_set *set, ioasid_t ioasid);
> +void ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid);

Please also add the stubs for !CONFIG_IOASID.

Thanks,
Jean

>  int ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
>  			       void (*fn)(ioasid_t id, void *data),
>  			       void *data);
> -- 
> 2.7.4
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
