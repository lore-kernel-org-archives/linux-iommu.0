Return-Path: <SRS0=rIde=CC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D45EC433DF
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 02:32:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28DB0206F7
	for <iommu@archiver.kernel.org>; Mon, 24 Aug 2020 02:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28DB0206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EC07B20471;
	Mon, 24 Aug 2020 02:32:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hak-A1z9bfOD; Mon, 24 Aug 2020 02:32:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 53C271FFFE;
	Mon, 24 Aug 2020 02:32:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22C13C07FF;
	Mon, 24 Aug 2020 02:32:28 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53157C0051
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 02:32:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3B82187089
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 02:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K0ZNzObfto2p for <iommu@lists.linux-foundation.org>;
 Mon, 24 Aug 2020 02:32:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 092C087E65
 for <iommu@lists.linux-foundation.org>; Mon, 24 Aug 2020 02:32:25 +0000 (UTC)
IronPort-SDR: Bsp/6xz8NRaHHfdicqAL1KBCHSmUqmgPIxLUb7Gi1ayamjirHU/n5j7JMeXu330vnM0YsFAEgG
 LhJg4/XpMmdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="240648558"
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; d="scan'208";a="240648558"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Aug 2020 19:32:24 -0700
IronPort-SDR: f8BfuEqWTP5sF+vKPqyqpugwW/EVHkAZhhuLHBcpA3DRmizcxLRTSVlya3D5U3ZfZjHj3ZMp/x
 CN0wybww5fwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; d="scan'208";a="402122343"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139])
 ([10.239.159.139])
 by fmsmga001.fm.intel.com with ESMTP; 23 Aug 2020 19:32:21 -0700
Subject: Re: [PATCH v2 4/9] iommu/ioasid: Add reference couting functions
To: Jacob Pan <jacob.pan.linux@gmail.com>, iommu@lists.linux-foundation.org,
 LKML <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-5-git-send-email-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <31af38ba-5cda-5d60-237e-f98cfc87da1b@linux.intel.com>
Date: Mon, 24 Aug 2020 10:26:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1598070918-21321-5-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Wu Hao <hao.wu@intel.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Jacob,

On 8/22/20 12:35 PM, Jacob Pan wrote:
> There can be multiple users of an IOASID, each user could have hardware
> contexts associated with the IOASID. In order to align lifecycles,
> reference counting is introduced in this patch. It is expected that when
> an IOASID is being freed, each user will drop a reference only after its
> context is cleared.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/ioasid.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/ioasid.h |   4 ++
>   2 files changed, 117 insertions(+)
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index f73b3dbfc37a..5f31d63c75b1 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -717,6 +717,119 @@ int ioasid_set_for_each_ioasid(struct ioasid_set *set,
>   EXPORT_SYMBOL_GPL(ioasid_set_for_each_ioasid);
>   
>   /**
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
> +
> +/**
> + * ioasid_get - Obtain a reference of an ioasid
> + * @set
> + * @ioasid
> + *
> + * Check set ownership if @set is non-null.
> + */
> +int ioasid_get(struct ioasid_set *set, ioasid_t ioasid)
> +{
> +	int ret = 0;
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
>    * ioasid_find - Find IOASID data
>    * @set: the IOASID set
>    * @ioasid: the IOASID to find

Do you need to increase the refcount of the found ioasid and ask the
caller to drop it after use? Otherwise, the ioasid might be freed
elsewhere.

Best regards,
baolu

> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 412d025d440e..310abe4187a3 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -76,6 +76,10 @@ int ioasid_attach_data(ioasid_t ioasid, void *data);
>   int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>   void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>   void ioasid_is_in_set(struct ioasid_set *set, ioasid_t ioasid);
> +int ioasid_get(struct ioasid_set *set, ioasid_t ioasid);
> +int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid);
> +void ioasid_put(struct ioasid_set *set, ioasid_t ioasid);
> +void ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid);
>   int ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
>   			       void (*fn)(ioasid_t id, void *data),
>   			       void *data);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
