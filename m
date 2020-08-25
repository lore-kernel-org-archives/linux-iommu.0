Return-Path: <SRS0=rFPO=CD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996E7C433E1
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 10:22:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 642192068F
	for <iommu@archiver.kernel.org>; Tue, 25 Aug 2020 10:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ao1qF1KY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642192068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4BC57204DF;
	Tue, 25 Aug 2020 10:22:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZWcZDApiAw9A; Tue, 25 Aug 2020 10:22:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 25482204B3;
	Tue, 25 Aug 2020 10:22:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18D1AC088B;
	Tue, 25 Aug 2020 10:22:30 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3EE7C016F
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 10:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DFCED86365
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 10:22:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BmvY2jx7Uh8O for <iommu@lists.linux-foundation.org>;
 Tue, 25 Aug 2020 10:22:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E61D0860FB
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 10:22:27 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id m20so10748195eds.2
 for <iommu@lists.linux-foundation.org>; Tue, 25 Aug 2020 03:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=orjn/VuUmFAKu7SvmsNFkE/hoRSrEyeiukqJjo9MKuA=;
 b=ao1qF1KYWbLmB8Rvob7GVVtTIKVV5d6PFFqIHS9ydk3k+eRpYe7cioZwJgj1wdwvGN
 zhVKELt8vhbVDUCm2Hk2+KrSmb+RdQswCx1p8t7Qgl1MZJtG1cYZtfPNHtr1YFICMY4V
 ECoDQLEDXGwAL8e6aAurywWHwC3Q+K+X+1EiJGUHgJC+GE4Xu3S6BSNFY4ILv35UOtsB
 i0UY+g7rPqMJ+JHkyPYpINjy+lT7OD1Z39m0SJaLkeiZ/Ivn1rK0gPrly/omtL5Wua9V
 6KiMMBzL5OlvEK9hWENUzJWRFgBqnvMsOfLJXYytvU4KK3VT/woJR9mOwEuuH5H/sjIk
 77cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=orjn/VuUmFAKu7SvmsNFkE/hoRSrEyeiukqJjo9MKuA=;
 b=Oj/avOUwV4ecCg0gSqlEB1AXPkhfFv5fNVJuSl6XKRipEkNo2UMXuQf1zEun3ZiXos
 t9t7TIxQhrSv/KGOn7fn4HhbSvB4G42YtfKjynKtSeBOBvNokhRxdRUu2i93Yog74cTD
 712qSQd9LBQVMUfPjyTGTsC9Bpp+BrkgnBKcKT45ZRNYJtPq0WHpBFnfcaLFWhHLx0+q
 qggyNY8lEG1Ld74LX7fTHQIAJWmRHVIGFMmKoOcw8OqfN/Dfa+ZDR4z/QbkUBQ0HjFqD
 iE6l9DHjvqeSV5CO8Ehn0G1hGHarBHXFVFedQbQQYPtP6gIVUVqf1Sij+AMNsaRmkO6a
 +thw==
X-Gm-Message-State: AOAM531ZY0pvvx/eTorZ+RjOhYI5sE78x8XPH/WctoYc/hgES128WSqE
 545RSd22kVmgBAsM9o2AbmLesX+FB2+jCowt
X-Google-Smtp-Source: ABdhPJwADXHBjgMYgFOWzT5HTr50X6O0YIi/ax3qATZjnb7cxoJoh1npIkB1GHYvWPSJH1FVA5mkag==
X-Received: by 2002:a50:ee92:: with SMTP id f18mr9021140edr.191.1598350946357; 
 Tue, 25 Aug 2020 03:22:26 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id df22sm12730912edb.93.2020.08.25.03.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 03:22:25 -0700 (PDT)
Date: Tue, 25 Aug 2020 12:22:09 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.pan.linux@gmail.com>
Subject: Re: [PATCH v2 5/9] iommu/ioasid: Introduce ioasid_set private ID
Message-ID: <20200825102209.GC3252704@myrica>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-6-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1598070918-21321-6-git-send-email-jacob.jun.pan@linux.intel.com>
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

On Fri, Aug 21, 2020 at 09:35:14PM -0700, Jacob Pan wrote:
> When an IOASID set is used for guest SVA, each VM will acquire its
> ioasid_set for IOASID allocations. IOASIDs within the VM must have a
> host/physical IOASID backing, mapping between guest and host IOASIDs can
> be non-identical. IOASID set private ID (SPID) is introduced in this
> patch to be used as guest IOASID. However, the concept of ioasid_set
> specific namespace is generic, thus named SPID.
> 
> As SPID namespace is within the IOASID set, the IOASID core can provide
> lookup services at both directions. SPIDs may not be allocated when its
> IOASID is allocated, the mapping between SPID and IOASID is usually
> established when a guest page table is bound to a host PASID.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/ioasid.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/ioasid.h | 12 +++++++++++
>  2 files changed, 66 insertions(+)
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 5f31d63c75b1..c0aef38a4fde 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -21,6 +21,7 @@ enum ioasid_state {
>   * struct ioasid_data - Meta data about ioasid
>   *
>   * @id:		Unique ID
> + * @spid:	Private ID unique within a set
>   * @users	Number of active users
>   * @state	Track state of the IOASID
>   * @set		Meta data of the set this IOASID belongs to
> @@ -29,6 +30,7 @@ enum ioasid_state {
>   */
>  struct ioasid_data {
>  	ioasid_t id;
> +	ioasid_t spid;
>  	struct ioasid_set *set;
>  	refcount_t users;
>  	enum ioasid_state state;
> @@ -326,6 +328,58 @@ int ioasid_attach_data(ioasid_t ioasid, void *data)
>  EXPORT_SYMBOL_GPL(ioasid_attach_data);
>  
>  /**
> + * ioasid_attach_spid - Attach ioasid_set private ID to an IOASID
> + *
> + * @ioasid: the ID to attach
> + * @spid:   the ioasid_set private ID of @ioasid
> + *
> + * For IOASID that is already allocated, private ID within the set can be
> + * attached via this API. Future lookup can be done via ioasid_find.

via ioasid_find_by_spid()?

> + */
> +int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
> +{
> +	struct ioasid_data *ioasid_data;
> +	int ret = 0;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> +
> +	if (!ioasid_data) {
> +		pr_err("No IOASID entry %d to attach SPID %d\n",
> +			ioasid, spid);
> +		ret = -ENOENT;
> +		goto done_unlock;
> +	}
> +	ioasid_data->spid = spid;
> +
> +done_unlock:
> +	spin_unlock(&ioasid_allocator_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_attach_spid);
> +
> +ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid)

Maybe add a bit of documentation as this is public-facing.

> +{
> +	struct ioasid_data *entry;
> +	unsigned long index;
> +
> +	if (!xa_load(&ioasid_sets, set->sid)) {
> +		pr_warn("Invalid set\n");
> +		return INVALID_IOASID;
> +	}
> +
> +	xa_for_each(&set->xa, index, entry) {
> +		if (spid == entry->spid) {
> +			pr_debug("Found ioasid %lu by spid %u\n", index, spid);
> +			refcount_inc(&entry->users);

Nothing prevents ioasid_free() from concurrently dropping the refcount to
zero and calling ioasid_do_free(). The caller will later call ioasid_put()
on a stale/reallocated index.

> +			return index;
> +		}
> +	}
> +	return INVALID_IOASID;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_find_by_spid);
> +
> +/**
>   * ioasid_alloc - Allocate an IOASID
>   * @set: the IOASID set
>   * @min: the minimum ID (inclusive)
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 310abe4187a3..d4b3e83672f6 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -73,6 +73,8 @@ bool ioasid_is_active(ioasid_t ioasid);
>  
>  void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid, bool (*getter)(void *));
>  int ioasid_attach_data(ioasid_t ioasid, void *data);
> +int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid);
> +ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid);
>  int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_is_in_set(struct ioasid_set *set, ioasid_t ioasid);
> @@ -136,5 +138,15 @@ static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
>  	return -ENOTSUPP;
>  }
>  
> +staic inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +static inline ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid)
> +{
> +	return -ENOTSUPP;

INVALID_IOASID

Thanks,
Jean

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
