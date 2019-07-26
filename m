Return-Path: <SRS0=gbr8=VX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18C5C76191
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 17:10:00 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A13C322CD1
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 17:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A13C322CD1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AE0ACD9E;
	Fri, 26 Jul 2019 17:09:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D461AD9E
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 17:09:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 278928A0
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 17:09:53 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ABCE330B9BF6;
	Fri, 26 Jul 2019 17:09:52 +0000 (UTC)
Received: from [10.36.116.102] (ovpn-116-102.ams2.redhat.com [10.36.116.102])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 31D1A620CA;
	Fri, 26 Jul 2019 17:09:47 +0000 (UTC)
Subject: Re: [PATCH v8 1/6] vfio/type1: Introduce iova list and add iommu
	aperture validity check
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	alex.williamson@redhat.com
References: <20190723160637.8384-1-shameerali.kolothum.thodi@huawei.com>
	<20190723160637.8384-2-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <929cc8b2-af38-5245-e463-3b3f21d7af7b@redhat.com>
Date: Fri, 26 Jul 2019 19:09:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190723160637.8384-2-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Fri, 26 Jul 2019 17:09:52 +0000 (UTC)
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

On 7/23/19 6:06 PM, Shameer Kolothum wrote:
> This introduces an iova list that is valid for dma mappings. Make
> sure the new iommu aperture window doesn't conflict with the current
> one or with any existing dma mappings during attach.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
> v7-->v8
>  -Addressed suggestions by Eric to update comments.
> ---
>  drivers/vfio/vfio_iommu_type1.c | 184 +++++++++++++++++++++++++++++++-
>  1 file changed, 181 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 054391f30fa8..6a69652b406b 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -62,6 +62,7 @@ MODULE_PARM_DESC(dma_entry_limit,
>  
>  struct vfio_iommu {
>  	struct list_head	domain_list;
> +	struct list_head	iova_list;
>  	struct vfio_domain	*external_domain; /* domain for external user */
>  	struct mutex		lock;
>  	struct rb_root		dma_list;
> @@ -97,6 +98,12 @@ struct vfio_group {
>  	bool			mdev_group;	/* An mdev group */
>  };
>  
> +struct vfio_iova {
> +	struct list_head	list;
> +	dma_addr_t		start;
> +	dma_addr_t		end;
> +};
> +
>  /*
>   * Guest RAM pinning working set or DMA target
>   */
> @@ -1388,6 +1395,146 @@ static int vfio_mdev_iommu_device(struct device *dev, void *data)
>  	return 0;
>  }
>  
> +/*
> + * This is a helper function to insert an address range to iova list.
> + * The list is initially created with a single entry corresponding to
> + * the IOMMU domain geometry to which the device group is attached.
> + * The list aperture gets modified when a new domain is added to the
> + * container if the new aperture doesn't conflict with the current one
> + * or with any existing dma mappings. The list is also modified to
> + * exclude any reserved regions associated with the device group.
> + */
> +static int vfio_iommu_iova_insert(struct list_head *head,
> +				  dma_addr_t start, dma_addr_t end)
> +{
> +	struct vfio_iova *region;
> +
> +	region = kmalloc(sizeof(*region), GFP_KERNEL);
> +	if (!region)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&region->list);
> +	region->start = start;
> +	region->end = end;
> +
> +	list_add_tail(&region->list, head);
> +	return 0;
> +}
> +
> +/*
> + * Check the new iommu aperture conflicts with existing aper or with any
> + * existing dma mappings.
> + */
> +static bool vfio_iommu_aper_conflict(struct vfio_iommu *iommu,
> +				     dma_addr_t start, dma_addr_t end)
> +{
> +	struct vfio_iova *first, *last;
> +	struct list_head *iova = &iommu->iova_list;
> +
> +	if (list_empty(iova))
> +		return false;
> +
> +	/* Disjoint sets, return conflict */
> +	first = list_first_entry(iova, struct vfio_iova, list);
> +	last = list_last_entry(iova, struct vfio_iova, list);
> +	if (start > last->end || end < first->start)
> +		return true;
> +
> +	/* Check for any existing dma mappings below the new start */
> +	if (start > first->start) {
> +		if (vfio_find_dma(iommu, first->start, start - first->start))
> +			return true;
> +	}
> +
> +	/* Check for any existing dma mappings beyond the new end */
> +	if (end < last->end) {
> +		if (vfio_find_dma(iommu, end + 1, last->end - end))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/*
> + * Resize iommu iova aperture window. This is called only if the new
> + * aperture has no conflict with existing aperture and dma mappings.
> + */
> +static int vfio_iommu_aper_resize(struct list_head *iova,
> +				  dma_addr_t start, dma_addr_t end)
> +{
> +	struct vfio_iova *node, *next;
> +
> +	if (list_empty(iova))
> +		return vfio_iommu_iova_insert(iova, start, end);
> +
> +	/* Adjust iova list start */
> +	list_for_each_entry_safe(node, next, iova, list) {
> +		if (start < node->start)
> +			break;
> +		if (start >= node->start && start < node->end) {
> +			node->start = start;
> +			break;
> +		}
> +		/* Delete nodes before new start */
> +		list_del(&node->list);
> +		kfree(node);
> +	}
> +
> +	/* Adjust iova list end */
> +	list_for_each_entry_safe(node, next, iova, list) {
> +		if (end > node->end)
> +			continue;
> +		if (end > node->start && end <= node->end) {
> +			node->end = end;
> +			continue;
> +		}
> +		/* Delete nodes after new end */
> +		list_del(&node->list);
> +		kfree(node);
> +	}
> +
> +	return 0;
> +}
> +
> +static void vfio_iommu_iova_free(struct list_head *iova)
> +{
> +	struct vfio_iova *n, *next;
> +
> +	list_for_each_entry_safe(n, next, iova, list) {
> +		list_del(&n->list);
> +		kfree(n);
> +	}
> +}
> +
> +static int vfio_iommu_iova_get_copy(struct vfio_iommu *iommu,
> +				    struct list_head *iova_copy)
> +{
> +	struct list_head *iova = &iommu->iova_list;
> +	struct vfio_iova *n;
> +	int ret;
> +
> +	list_for_each_entry(n, iova, list) {
> +		ret = vfio_iommu_iova_insert(iova_copy, n->start, n->end);
> +		if (ret)
> +			goto out_free;
> +	}
> +
> +	return 0;
> +
> +out_free:
> +	vfio_iommu_iova_free(iova_copy);
> +	return ret;
> +}
> +
> +static void vfio_iommu_iova_insert_copy(struct vfio_iommu *iommu,
> +					struct list_head *iova_copy)
> +{
> +	struct list_head *iova = &iommu->iova_list;
> +
> +	vfio_iommu_iova_free(iova);
> +
> +	list_splice_tail(iova_copy, iova);
> +}
>  static int vfio_iommu_type1_attach_group(void *iommu_data,
>  					 struct iommu_group *iommu_group)
>  {
> @@ -1398,6 +1545,8 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	int ret;
>  	bool resv_msi, msi_remap;
>  	phys_addr_t resv_msi_base;
> +	struct iommu_domain_geometry geo;
> +	LIST_HEAD(iova_copy);
>  
>  	mutex_lock(&iommu->lock);
>  
> @@ -1474,6 +1623,29 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	if (ret)
>  		goto out_domain;
>  
> +	/* Get aperture info */
> +	iommu_domain_get_attr(domain->domain, DOMAIN_ATTR_GEOMETRY, &geo);
> +
> +	if (vfio_iommu_aper_conflict(iommu, geo.aperture_start,
> +				     geo.aperture_end)) {
> +		ret = -EINVAL;
> +		goto out_detach;
> +	}
> +
> +	/*
> +	 * We don't want to work on the original iova list as the list
> +	 * gets modified and in case of failure we have to retain the
> +	 * original list. Get a copy here.
> +	 */
> +	ret = vfio_iommu_iova_get_copy(iommu, &iova_copy);
> +	if (ret)
> +		goto out_detach;
> +
> +	ret = vfio_iommu_aper_resize(&iova_copy, geo.aperture_start,
> +				     geo.aperture_end);
> +	if (ret)
> +		goto out_detach;
> +
>  	resv_msi = vfio_iommu_has_sw_msi(iommu_group, &resv_msi_base);
>  
>  	INIT_LIST_HEAD(&domain->group_list);
> @@ -1507,8 +1679,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  				list_add(&group->next, &d->group_list);
>  				iommu_domain_free(domain->domain);
>  				kfree(domain);
> -				mutex_unlock(&iommu->lock);
> -				return 0;
> +				goto done;
>  			}
>  
>  			ret = vfio_iommu_attach_group(domain, group);
> @@ -1531,7 +1702,9 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	}
>  
>  	list_add(&domain->next, &iommu->domain_list);
> -
> +done:
> +	/* Delete the old one and insert new iova list */
> +	vfio_iommu_iova_insert_copy(iommu, &iova_copy);
>  	mutex_unlock(&iommu->lock);
>  
>  	return 0;
> @@ -1540,6 +1713,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	vfio_iommu_detach_group(domain, group);
>  out_domain:
>  	iommu_domain_free(domain->domain);
> +	vfio_iommu_iova_free(&iova_copy);
>  out_free:
>  	kfree(domain);
>  	kfree(group);
> @@ -1679,6 +1853,7 @@ static void *vfio_iommu_type1_open(unsigned long arg)
>  	}
>  
>  	INIT_LIST_HEAD(&iommu->domain_list);
> +	INIT_LIST_HEAD(&iommu->iova_list);
>  	iommu->dma_list = RB_ROOT;
>  	iommu->dma_avail = dma_entry_limit;
>  	mutex_init(&iommu->lock);
> @@ -1722,6 +1897,9 @@ static void vfio_iommu_type1_release(void *iommu_data)
>  		list_del(&domain->next);
>  		kfree(domain);
>  	}
> +
> +	vfio_iommu_iova_free(&iommu->iova_list);
> +
>  	kfree(iommu);
>  }
>  
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
