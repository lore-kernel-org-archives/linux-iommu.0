Return-Path: <SRS0=PWDw=5R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EF3C2D0F0
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 13:47:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC9BC20776
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 13:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yzt4PGcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC9BC20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B2ABF8854A;
	Wed,  1 Apr 2020 13:47:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qXKnukCoUozM; Wed,  1 Apr 2020 13:47:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E96798851B;
	Wed,  1 Apr 2020 13:47:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D151AC1D7F;
	Wed,  1 Apr 2020 13:47:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B62B8C089F
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 13:47:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A4B738853D
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 13:47:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gN3NZVi4hPxr for <iommu@lists.linux-foundation.org>;
 Wed,  1 Apr 2020 13:47:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6557B8851B
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 13:47:55 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id j17so44753wru.13
 for <iommu@lists.linux-foundation.org>; Wed, 01 Apr 2020 06:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=hWTKXsOIBcGEc6kXxJqNe/OurUmZ8Fi9q5gmK7Ykzbk=;
 b=Yzt4PGcTugsqsrDVm2wwnOdflaXj0EOYsps9dKGliRz8umqQMXhE+VebsJZv8hqjIM
 XbLvV0xCiTDK6VVDzqg2FygHEPvMfoXK+9UddvB+tNEmCGA1DmgdYkR78gr6gn9BLNFI
 ocp0AGc8zDiYs7DqjsmLmo9LrLsA3bJuagVcCTFKRGz/1/pVq4JVBuYVpHPBBu47PgHb
 iafoAyDlgEI4+GS8fEp6hfypaTLyR+LKS+7Hv69dk/z3ITIBs8xmPDsj0svsJpuKvKc4
 2kgKp0bp3BZMgMPa1Xpg4goSspgMfx/Y4I18V76Y/mBgPELhdQyDgqL8ykme5XElEgmH
 UyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hWTKXsOIBcGEc6kXxJqNe/OurUmZ8Fi9q5gmK7Ykzbk=;
 b=kyPJ+CiR4n3mQd0lrpF1YD0h5BvM0QeNc7N9lgowBb5D72IMMLdRtclvY/Ew0/BEOB
 aL6bQHZjf+n7uzR0HA8dai/31GVdawYRKllv8VY5m5JEao1XO6O2hwQGQTKGDP2AUOEG
 ajueXoCTWMDhdp/O1xh/GNk2WiOBO5roXwznU/eq6MF6QWwDCp35d8GCkjtxvFLWtogh
 MbWStcz5Sb9T0CzjVNmMwG0RyGHy3SvCYiF4r0VxSsiEJX/P9EpCNgDknlT2Mv/6LO/5
 hWMTSKwjiRm+5Qnb2Gr78DR0EJN2XuSgtsiVZ8JLkmTR3tBWe7svq6ZrswgCZYhc7Z2S
 X9Qw==
X-Gm-Message-State: ANhLgQ1HrY4Y3zvagbawsKNvWY4NdcveZl0rjMeIb2A5KpPNetK3tl0Q
 0i5E1x53i2JCoMz1ZilpLmNogQ==
X-Google-Smtp-Source: ADFU+vtLBDtrQthnQoLxciFoJt3vXdCBxwjmgjXUlPGu5uL6h5v2lol0mgsvvJ1/YI/5YA2RJu4SRA==
X-Received: by 2002:adf:df8a:: with SMTP id z10mr24727794wrl.278.1585748873708; 
 Wed, 01 Apr 2020 06:47:53 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:6097:1406:6470:33b5])
 by smtp.gmail.com with ESMTPSA id t11sm2938647wru.69.2020.04.01.06.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2020 06:47:53 -0700 (PDT)
Date: Wed, 1 Apr 2020 15:47:45 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 03/10] iommu/ioasid: Introduce per set allocation APIs
Message-ID: <20200401134745.GE882512@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1585158931-1825-4-git-send-email-jacob.jun.pan@linux.intel.com>
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

On Wed, Mar 25, 2020 at 10:55:24AM -0700, Jacob Pan wrote:
> IOASID set defines a group of IDs that share the same token. The
> ioasid_set concept helps to do permission checking among users as in the
> current code.
> 
> With guest SVA usage, each VM has its own IOASID set. More
> functionalities are needed:
> 1. Enforce quota, each guest may be assigned limited quota such that one
> guest cannot abuse all the system resource.
> 2. Stores IOASID mapping between guest and host IOASIDs
> 3. Per set operations, e.g. free the entire set
> 
> For each ioasid_set token, a unique set ID is assigned. This makes
> reference of the set and data lookup much easier to implement.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/ioasid.c | 147 +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/ioasid.h |  13 +++++
>  2 files changed, 160 insertions(+)
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 4026e52855b9..27ee57f7079b 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -10,6 +10,25 @@
>  #include <linux/spinlock.h>
>  #include <linux/xarray.h>
>  
> +static DEFINE_XARRAY_ALLOC(ioasid_sets);
> +/**
> + * struct ioasid_set_data - Meta data about ioasid_set
> + *
> + * @token:	Unique to identify an IOASID set
> + * @xa:		XArray to store subset ID and IOASID mapping
> + * @size:	Max number of IOASIDs can be allocated within the set
> + * @nr_ioasids	Number of IOASIDs allocated in the set
> + * @sid		ID of the set
> + */
> +struct ioasid_set_data {
> +	struct ioasid_set *token;
> +	struct xarray xa;
> +	int size;
> +	int nr_ioasids;
> +	int sid;
> +	struct rcu_head rcu;
> +};
> +
>  struct ioasid_data {
>  	ioasid_t id;
>  	struct ioasid_set *set;
> @@ -388,6 +407,111 @@ void ioasid_free(ioasid_t ioasid)
>  EXPORT_SYMBOL_GPL(ioasid_free);
>  
>  /**
> + * ioasid_alloc_set - Allocate a set of IOASIDs
> + * @token:	Unique token of the IOASID set
> + * @quota:	Quota allowed in this set
> + * @sid:	IOASID set ID to be assigned
> + *
> + * Return 0 upon success. Token will be stored internally for lookup,
> + * IOASID allocation within the set and other per set operations will use
> + * the @sid assigned.
> + *
> + */
> +int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int *sid)
> +{
> +	struct ioasid_set_data *sdata;
> +	ioasid_t id;
> +	int ret = 0;
> +
> +	if (quota > ioasid_capacity_avail) {
> +		pr_warn("Out of IOASID capacity! ask %d, avail %d\n",
> +			quota, ioasid_capacity_avail);
> +		return -ENOSPC;
> +	}

This check should be in the same critical section as the quota
substraction

> +
> +	sdata = kzalloc(sizeof(*sdata), GFP_KERNEL);
> +	if (!sdata)
> +		return -ENOMEM;

I don't understand why we need this structure at all, nor why we need the
SID. Users have already allocated an ioasid_set, so why not just stick the
content of ioasid_set_data in there, and pass the ioasid_set pointer to
ioasid_alloc()?

> +
> +	spin_lock(&ioasid_allocator_lock);
> +
> +	ret = xa_alloc(&ioasid_sets, &id, sdata,
> +		       XA_LIMIT(0, ioasid_capacity_avail - quota),
> +		       GFP_KERNEL);

Same as Kevin, I think the limit should be the static ioasid_capacity. And
perhaps a comment explaining the worst case of one PASID per set. I found
a little confusing using the same type ioasid_t for IOASIDs and IOASID
sets, it may be clearer to use an int for IOASID set IDs.

Thanks,
Jean

> +	if (ret) {
> +		kfree(sdata);
> +		goto error;
> +	}
> +
> +	sdata->token = token;
> +	sdata->size = quota;
> +	sdata->sid = id;
> +
> +	/*
> +	 * Set Xarray is used to store IDs within the set, get ready for
> +	 * sub-set ID and system-wide IOASID allocation results.
> +	 */
> +	xa_init_flags(&sdata->xa, XA_FLAGS_ALLOC);
> +
> +	ioasid_capacity_avail -= quota;
> +	*sid = id;
> +
> +error:
> +	spin_unlock(&ioasid_allocator_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_alloc_set);
> +
> +/**
> + * ioasid_free_set - Free all IOASIDs within the set
> + *
> + * @sid:		The IOASID set ID to be freed
> + * @destroy_set:	Whether to keep the set for further allocation.
> + *			If true, the set will be destroyed.
> + *
> + * All IOASIDs allocated within the set will be freed upon return.
> + */
> +void ioasid_free_set(int sid, bool destroy_set)
> +{
> +	struct ioasid_set_data *sdata;
> +	struct ioasid_data *entry;
> +	unsigned long index;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +	sdata = xa_load(&ioasid_sets, sid);
> +	if (!sdata) {
> +		pr_err("No IOASID set found to free %d\n", sid);
> +		goto done_unlock;
> +	}
> +
> +	if (xa_empty(&sdata->xa)) {
> +		pr_warn("No IOASIDs in the set %d\n", sdata->sid);
> +		goto done_destroy;
> +	}
> +
> +	/* Just a place holder for now */
> +	xa_for_each(&sdata->xa, index, entry) {
> +		/* Free from per sub-set pool */
> +		xa_erase(&sdata->xa, index);
> +	}
> +
> +done_destroy:
> +	if (destroy_set) {
> +		xa_erase(&ioasid_sets, sid);
> +
> +		/* Return the quota back to system pool */
> +		ioasid_capacity_avail += sdata->size;
> +		kfree_rcu(sdata, rcu);
> +	}
> +
> +done_unlock:
> +	spin_unlock(&ioasid_allocator_lock);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_free_set);
> +
> +
> +/**
>   * ioasid_find - Find IOASID data
>   * @set: the IOASID set
>   * @ioasid: the IOASID to find
> @@ -431,6 +555,29 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>  }
>  EXPORT_SYMBOL_GPL(ioasid_find);
>  
> +/**
> + * ioasid_find_sid - Retrieve IOASID set ID from an ioasid
> + *                   Caller must hold a reference to the set.
> + *
> + * @ioasid: IOASID associated with the set
> + *
> + * Return IOASID set ID or error
> + */
> +int ioasid_find_sid(ioasid_t ioasid)
> +{
> +	struct ioasid_data *ioasid_data;
> +	int ret = 0;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> +	ret = (ioasid_data) ? ioasid_data->sdata->sid : -ENOENT;
> +
> +	spin_unlock(&ioasid_allocator_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_find_sid);
> +
>  MODULE_AUTHOR("Jean-Philippe Brucker <jean-philippe.brucker@arm.com>");
>  MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
>  MODULE_DESCRIPTION("IO Address Space ID (IOASID) allocator");
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 9711fa0dc357..be158e03c034 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -41,6 +41,9 @@ int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>  int ioasid_set_data(ioasid_t ioasid, void *data);
>  void ioasid_install_capacity(ioasid_t total);
> +int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int *sid);
> +void ioasid_free_set(int sid, bool destroy_set);
> +int ioasid_find_sid(ioasid_t ioasid);
>  #else /* !CONFIG_IOASID */
>  static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
>  				    ioasid_t max, void *private)
> @@ -52,6 +55,15 @@ static inline void ioasid_free(ioasid_t ioasid)
>  {
>  }
>  
> +static inline int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int *sid)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline void ioasid_free_set(int sid, bool destroy_set)
> +{
> +}
> +
>  static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>  				bool (*getter)(void *))
>  {
> @@ -75,5 +87,6 @@ static inline int ioasid_set_data(ioasid_t ioasid, void *data)
>  static inline void ioasid_install_capacity(ioasid_t total)
>  {
>  }
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
