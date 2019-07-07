Return-Path: <SRS0=R9yw=VE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43A7C48BDB
	for <iommu@archiver.kernel.org>; Sun,  7 Jul 2019 15:08:32 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85F632082E
	for <iommu@archiver.kernel.org>; Sun,  7 Jul 2019 15:08:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85F632082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 417961E72;
	Sun,  7 Jul 2019 15:08:27 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7B3A81E1A
	for <iommu@lists.linux-foundation.org>;
	Sun,  7 Jul 2019 15:03:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 9106D148
	for <iommu@lists.linux-foundation.org>;
	Sun,  7 Jul 2019 15:03:13 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3CD5883D7;
	Sun,  7 Jul 2019 15:03:06 +0000 (UTC)
Received: from [10.36.116.46] (ovpn-116-46.ams2.redhat.com [10.36.116.46])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2672477D48;
	Sun,  7 Jul 2019 15:02:57 +0000 (UTC)
Subject: Re: [PATCH v7 2/6] vfio/type1: Check reserve region conflict and
	update iova list
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com
References: <20190626151248.11776-1-shameerali.kolothum.thodi@huawei.com>
	<20190626151248.11776-3-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3f190415-3ed0-247a-e761-7fd8c160dded@redhat.com>
Date: Sun, 7 Jul 2019 17:02:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190626151248.11776-3-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Sun, 07 Jul 2019 15:03:09 +0000 (UTC)
Cc: kevin.tian@intel.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	xuwei5@hisilicon.com, linuxarm@huawei.com, iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Shameer,

On 6/26/19 5:12 PM, Shameer Kolothum wrote:
> This retrieves the reserved regions associated with dev group and
> checks for conflicts with any existing dma mappings. Also update
> the iova list excluding the reserved regions.

s/reserve/reserved in the commit title
> 
> Reserved regions with type IOMMU_RESV_DIRECT_RELAXABLE are
> excluded from above checks as they are considered as directly
> mapped regions which are known to be relaxable.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 96 +++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 970d1ec06aed..b6bfdfa16c33 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1508,6 +1508,88 @@ static int vfio_iommu_aper_resize(struct list_head *iova,
>  	return 0;
>  }
>  
> +/*
> + * Check reserved region conflicts with existing dma mappings
> + */
> +static bool vfio_iommu_resv_conflict(struct vfio_iommu *iommu,
> +				     struct list_head *resv_regions)
> +{
> +	struct iommu_resv_region *region;
> +
> +	/* Check for conflict with existing dma mappings */
> +	list_for_each_entry(region, resv_regions, list) {
> +		if (region->type == IOMMU_RESV_DIRECT_RELAXABLE)
> +			continue;
> +
> +		if (vfio_find_dma(iommu, region->start, region->length))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/*
> + * Check iova region overlap with  reserved regions and
> + * exclude them from the iommu iova range
> + */
> +static int vfio_iommu_resv_exclude(struct list_head *iova,
> +				   struct list_head *resv_regions)
> +{
> +	struct iommu_resv_region *resv;
> +	struct vfio_iova *n, *next;
> +
> +	list_for_each_entry(resv, resv_regions, list) {
> +		phys_addr_t start, end;
> +
> +		if (resv->type == IOMMU_RESV_DIRECT_RELAXABLE)
> +			continue;
> +
> +		start = resv->start;
> +		end = resv->start + resv->length - 1;
> +
> +		list_for_each_entry_safe(n, next, iova, list) {
> +			int ret = 0;
> +
> +			/* No overlap */
> +			if (start > n->end || end < n->start)
> +				continue;
> +			/*
> +			 * Insert a new node if current node overlaps with the
> +			 * reserve region to exlude that from valid iova range.
> +			 * Note that, new node is inserted before the current
> +			 * node and finally the current node is deleted keeping
> +			 * the list updated and sorted.
> +			 */
> +			if (start > n->start)
> +				ret = vfio_iommu_iova_insert(&n->list, n->start,
> +							     start - 1);
> +			if (!ret && end < n->end)
> +				ret = vfio_iommu_iova_insert(&n->list, end + 1,
> +							     n->end);
> +			if (ret)
> +				return ret;
> +
> +			list_del(&n->list);
> +			kfree(n);
> +		}
> +	}
> +
> +	if (list_empty(iova))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static void vfio_iommu_resv_free(struct list_head *resv_regions)
> +{
> +	struct iommu_resv_region *n, *next;
> +
> +	list_for_each_entry_safe(n, next, resv_regions, list) {
> +		list_del(&n->list);
> +		kfree(n);
> +	}
> +}
> +
>  static void vfio_iommu_iova_free(struct list_head *iova)
>  {
>  	struct vfio_iova *n, *next;
> @@ -1559,6 +1641,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	phys_addr_t resv_msi_base;
>  	struct iommu_domain_geometry geo;
>  	LIST_HEAD(iova_copy);
> +	LIST_HEAD(group_resv_regions);
>  
>  	mutex_lock(&iommu->lock);
>  
> @@ -1644,6 +1727,13 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  		goto out_detach;
>  	}
>  
> +	iommu_get_group_resv_regions(iommu_group, &group_resv_regions);
> +
> +	if (vfio_iommu_resv_conflict(iommu, &group_resv_regions)) {
> +		ret = -EINVAL;
> +		goto out_detach;
> +	}
> +
>  	/* Get a copy of the current iova list and work on it */
>  	ret = vfio_iommu_iova_get_copy(iommu, &iova_copy);
>  	if (ret)
> @@ -1654,6 +1744,10 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	if (ret)
>  		goto out_detach;
>  
> +	ret = vfio_iommu_resv_exclude(&iova_copy, &group_resv_regions);
> +	if (ret)
> +		goto out_detach;
> +
>  	resv_msi = vfio_iommu_has_sw_msi(iommu_group, &resv_msi_base);
>  
>  	INIT_LIST_HEAD(&domain->group_list);
> @@ -1714,6 +1808,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	/* Delete the old one and insert new iova list */
>  	vfio_iommu_iova_insert_copy(iommu, &iova_copy);
>  	mutex_unlock(&iommu->lock);
> +	vfio_iommu_resv_free(&group_resv_regions);
>  
>  	return 0;
>  
> @@ -1722,6 +1817,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  out_domain:
>  	iommu_domain_free(domain->domain);
>  	vfio_iommu_iova_free(&iova_copy);
> +	vfio_iommu_resv_free(&group_resv_regions);
>  out_free:
>  	kfree(domain);
>  	kfree(group);
> 
Thanks

Eric
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
