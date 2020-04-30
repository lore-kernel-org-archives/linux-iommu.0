Return-Path: <SRS0=XdCg=6O=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B25AFC47256
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 18:33:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A69E2076D
	for <iommu@archiver.kernel.org>; Thu, 30 Apr 2020 18:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A69E2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6336188789;
	Thu, 30 Apr 2020 18:33:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OVqTZSvrrkQT; Thu, 30 Apr 2020 18:33:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B4665886A5;
	Thu, 30 Apr 2020 18:33:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9994BC0864;
	Thu, 30 Apr 2020 18:33:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74415C016F
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 18:33:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5A4AA24F97
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 18:33:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S6R+s42GQvtL for <iommu@lists.linux-foundation.org>;
 Thu, 30 Apr 2020 18:33:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by silver.osuosl.org (Postfix) with ESMTPS id 924F124F0B
 for <iommu@lists.linux-foundation.org>; Thu, 30 Apr 2020 18:33:29 +0000 (UTC)
IronPort-SDR: SRfjYfTH3DBC5NXO99s99FZO1lDEA0B/9W0tVfhoOmczggfre8TfedLIuXhvS786OSSQAPNXuU
 mWB9BM/sdqlA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2020 11:33:28 -0700
IronPort-SDR: J48xY2cKJPAK1NVryygQbF/nagAXDIYz1I6SC3AHIW5UHcqfCG66Luu3iM/N/zRymWaoSl5F24
 9Hf1OxKC5PKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,336,1583222400"; d="scan'208";a="433056299"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga005.jf.intel.com with ESMTP; 30 Apr 2020 11:33:28 -0700
Date: Thu, 30 Apr 2020 11:39:31 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v6 02/25] iommu/ioasid: Add ioasid references
Message-ID: <20200430113931.0fbf7a37@jacob-builder>
In-Reply-To: <20200430143424.2787566-3-jean-philippe@linaro.org>
References: <20200430143424.2787566-1-jean-philippe@linaro.org>
 <20200430143424.2787566-3-jean-philippe@linaro.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: devicetree@vger.kernel.org, kevin.tian@intel.com, jgg@ziepe.ca,
 linux-pci@vger.kernel.org, robin.murphy@arm.com, fenghua.yu@intel.com,
 hch@infradead.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 zhangfei.gao@linaro.org, catalin.marinas@arm.com, felix.kuehling@amd.com,
 will@kernel.org, christian.koenig@amd.com,
 linux-arm-kernel@lists.infradead.org
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

On Thu, 30 Apr 2020 16:34:01 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> Let IOASID users take references to existing ioasids with
> ioasid_get(). ioasid_free() drops a reference and only frees the
> ioasid when its reference number is zero. It returns whether the
> ioasid was freed.
> 
Looks good to me, I was planning to do the same for VT-d use. Just a
couple of points for potential extension. I can rebase on top of this.


> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  include/linux/ioasid.h | 10 ++++++++--
>  drivers/iommu/ioasid.c | 30 +++++++++++++++++++++++++++++-
>  2 files changed, 37 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 6f000d7a0ddcd..609ba6f15b9e3 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -34,7 +34,8 @@ struct ioasid_allocator_ops {
>  #if IS_ENABLED(CONFIG_IOASID)
>  ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t
> max, void *private);
> -void ioasid_free(ioasid_t ioasid);
> +void ioasid_get(ioasid_t ioasid);
> +bool ioasid_free(ioasid_t ioasid);
>  void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>  		  bool (*getter)(void *));
>  int ioasid_register_allocator(struct ioasid_allocator_ops
> *allocator); @@ -48,10 +49,15 @@ static inline ioasid_t
> ioasid_alloc(struct ioasid_set *set, ioasid_t min, return
> INVALID_IOASID; }
>  
> -static inline void ioasid_free(ioasid_t ioasid)
> +static inline void ioasid_get(ioasid_t ioasid)
>  {
>  }
>  
> +static inline bool ioasid_free(ioasid_t ioasid)
> +{
> +	return false;
> +}
> +
>  static inline void *ioasid_find(struct ioasid_set *set, ioasid_t
> ioasid, bool (*getter)(void *))
>  {
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 0f8dd377aada3..46511ac53e0c8 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -15,6 +15,7 @@ struct ioasid_data {
>  	struct ioasid_set *set;
>  	void *private;
>  	struct rcu_head rcu;
> +	refcount_t refs;
>  };
>  
>  /*
> @@ -314,6 +315,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set,
> ioasid_t min, ioasid_t max, 
>  	data->set = set;
>  	data->private = private;
> +	refcount_set(&data->refs, 1);
>  
>  	/*
>  	 * Custom allocator needs allocator data to perform platform
> specific @@ -345,12 +347,33 @@ ioasid_t ioasid_alloc(struct
> ioasid_set *set, ioasid_t min, ioasid_t max, }
>  EXPORT_SYMBOL_GPL(ioasid_alloc);
>  
> +/**
> + * ioasid_get - obtain a reference to the IOASID
> + */
> +void ioasid_get(ioasid_t ioasid)
why void? what if the ioasid is not valid.

> +{
> +	struct ioasid_data *ioasid_data;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> +	if (ioasid_data)
> +		refcount_inc(&ioasid_data->refs);
> +	spin_unlock(&ioasid_allocator_lock);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_get);
> +
>  /**
>   * ioasid_free - Free an IOASID
>   * @ioasid: the ID to remove
> + *
> + * Put a reference to the IOASID, free it when the number of
> references drops to
> + * zero.
> + *
> + * Return: %true if the IOASID was freed, %false otherwise.
>   */
> -void ioasid_free(ioasid_t ioasid)
> +bool ioasid_free(ioasid_t ioasid)
>  {
> +	bool free = false;
>  	struct ioasid_data *ioasid_data;
>  
>  	spin_lock(&ioasid_allocator_lock);
> @@ -360,6 +383,10 @@ void ioasid_free(ioasid_t ioasid)
>  		goto exit_unlock;
>  	}
>  
> +	free = refcount_dec_and_test(&ioasid_data->refs);
> +	if (!free)
> +		goto exit_unlock;
> +
Just FYI, we may need to add states for the IOASID, i.g. mark the IOASID
inactive after free. And prohibit ioasid_get() after freed. For VT-d,
this is useful when KVM queries the IOASID.

>  	active_allocator->ops->free(ioasid,
> active_allocator->ops->pdata); /* Custom allocator needs additional
> steps to free the xa element */ if (active_allocator->flags &
> IOASID_ALLOCATOR_CUSTOM) { @@ -369,6 +396,7 @@ void
> ioasid_free(ioasid_t ioasid) 
>  exit_unlock:
>  	spin_unlock(&ioasid_allocator_lock);
> +	return free;
>  }
>  EXPORT_SYMBOL_GPL(ioasid_free);
>  

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
