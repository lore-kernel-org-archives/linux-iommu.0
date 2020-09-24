Return-Path: <SRS0=ygJE=DB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40F9C4363D
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 18:29:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25A352311E
	for <iommu@archiver.kernel.org>; Thu, 24 Sep 2020 18:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25A352311E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E38FF86B2D;
	Thu, 24 Sep 2020 18:29:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1CrlpieDFnbs; Thu, 24 Sep 2020 18:29:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D2DCD86B2B;
	Thu, 24 Sep 2020 18:29:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BCCBDC0889;
	Thu, 24 Sep 2020 18:29:49 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8BBA2C0051
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 18:29:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 8490E20422
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 18:29:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2KPiFpZTn3pE for <iommu@lists.linux-foundation.org>;
 Thu, 24 Sep 2020 18:29:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
 by silver.osuosl.org (Postfix) with ESMTPS id C3EBA203E2
 for <iommu@lists.linux-foundation.org>; Thu, 24 Sep 2020 18:29:46 +0000 (UTC)
Received: from lhreml721-chm.china.huawei.com (unknown [172.18.7.106])
 by Forcepoint Email with ESMTP id F180640490732B561407;
 Thu, 24 Sep 2020 19:29:43 +0100 (IST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml721-chm.china.huawei.com (10.201.108.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 24 Sep 2020 19:29:43 +0100
Received: from lhreml710-chm.china.huawei.com ([169.254.81.184]) by
 lhreml710-chm.china.huawei.com ([169.254.81.184]) with mapi id
 15.01.1913.007; Thu, 24 Sep 2020 19:29:43 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Jacob Pan <jacob.pan.linux@gmail.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, David Woodhouse
 <dwmw2@infradead.org>
Subject: RE: [PATCH v2 4/9] iommu/ioasid: Add reference couting functions
Thread-Topic: [PATCH v2 4/9] iommu/ioasid: Add reference couting functions
Thread-Index: AQHWeFM+3LMH6JurcEu9bAF2eVkkYql4RlcA
Date: Thu, 24 Sep 2020 18:29:43 +0000
Message-ID: <fecfa20f4ff743f481d91dbff6983b85@huawei.com>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-5-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1598070918-21321-5-git-send-email-jacob.jun.pan@linux.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.86.144]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Wu
 Hao <hao.wu@intel.com>
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

Hi Jacob,

> -----Original Message-----
> From: iommu [mailto:iommu-bounces@lists.linux-foundation.org] On Behalf Of
> Jacob Pan
> Sent: 22 August 2020 05:35
> To: iommu@lists.linux-foundation.org; LKML <linux-kernel@vger.kernel.org>;
> Jean-Philippe Brucker <jean-philippe@linaro.com>; Lu Baolu
> <baolu.lu@linux.intel.com>; Joerg Roedel <joro@8bytes.org>; David
> Woodhouse <dwmw2@infradead.org>
> Cc: Tian, Kevin <kevin.tian@intel.com>; Raj Ashok <ashok.raj@intel.com>; Wu
> Hao <hao.wu@intel.com>
> Subject: [PATCH v2 4/9] iommu/ioasid: Add reference couting functions
> 
> There can be multiple users of an IOASID, each user could have hardware
> contexts associated with the IOASID. In order to align lifecycles,
> reference counting is introduced in this patch. It is expected that when
> an IOASID is being freed, each user will drop a reference only after its
> context is cleared.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/ioasid.c | 113
> +++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/ioasid.h |   4 ++
>  2 files changed, 117 insertions(+)
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index f73b3dbfc37a..5f31d63c75b1 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -717,6 +717,119 @@ int ioasid_set_for_each_ioasid(struct ioasid_set
> *set,
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
> + *     If recount is non-zero, mark IOASID as
> IOASID_STATE_FREE_PENDING.
> + *     No new reference can be added. The IOASID is not returned to the
> pool
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

Is it better to have a return for this based on whether ioasid is freed or not? 

I was going through Jean's SMMUv3 SVA patches[1] and that one returns true
if ioasid was freed. And that info is subsequently used to reset the pasid associated
with a mm. Though, not sure that is still relevant or not.

Thanks,
Shameer
1. https://lore.kernel.org/linux-iommu/20200918101852.582559-3-jean-philippe@linaro.org/

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
>  int ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
>  			       void (*fn)(ioasid_t id, void *data),
>  			       void *data);
> --
> 2.7.4
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
