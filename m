Return-Path: <SRS0=gbr8=VX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E843EC7618B
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 17:09:52 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C90CD21734
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 17:09:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C90CD21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 683C5D7E;
	Fri, 26 Jul 2019 17:09:52 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 79B32D13
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 17:09:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 22498894
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 17:09:49 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BD9681DF9;
	Fri, 26 Jul 2019 17:09:48 +0000 (UTC)
Received: from [10.36.116.102] (ovpn-116-102.ams2.redhat.com [10.36.116.102])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 720055DE80;
	Fri, 26 Jul 2019 17:09:43 +0000 (UTC)
Subject: Re: [PATCH v8 3/6] vfio/type1: Update iova list on detach
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	alex.williamson@redhat.com
References: <20190723160637.8384-1-shameerali.kolothum.thodi@huawei.com>
	<20190723160637.8384-4-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <c672300c-b689-d880-8cec-94092d9583ca@redhat.com>
Date: Fri, 26 Jul 2019 19:09:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190723160637.8384-4-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Fri, 26 Jul 2019 17:09:48 +0000 (UTC)
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
> Get a copy of iova list on _group_detach and try to update the list.
> On success replace the current one with the copy. Leave the list as
> it is if update fails.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
> v7 --> v8
>   -Fixed possible invalid holes in iova list if there are no more
>    reserved regions in vfio_iommu_resv_refresh().
>   -Handled iommu_get_group_resv_regions() err case in
>    vfio_iommu_resv_refresh()
>   -Tidy up of iova_copy list fail case.
> ---
>  drivers/vfio/vfio_iommu_type1.c | 94 +++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index a3c9794ccf83..7005a8cfca1b 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1867,12 +1867,93 @@ static void vfio_sanity_check_pfn_list(struct vfio_iommu *iommu)
>  	WARN_ON(iommu->notifier.head);
>  }
>  
> +/*
> + * Called when a domain is removed in detach. It is possible that
> + * the removed domain decided the iova aperture window. Modify the
> + * iova aperture with the smallest window among existing domains.
> + */
> +static void vfio_iommu_aper_expand(struct vfio_iommu *iommu,
> +				   struct list_head *iova_copy)
> +{
> +	struct vfio_domain *domain;
> +	struct iommu_domain_geometry geo;
> +	struct vfio_iova *node;
> +	dma_addr_t start = 0;
> +	dma_addr_t end = (dma_addr_t)~0;
> +
> +	if (list_empty(iova_copy))
> +		return;
> +
> +	list_for_each_entry(domain, &iommu->domain_list, next) {
> +		iommu_domain_get_attr(domain->domain, DOMAIN_ATTR_GEOMETRY,
> +				      &geo);
> +		if (geo.aperture_start > start)
> +			start = geo.aperture_start;
> +		if (geo.aperture_end < end)
> +			end = geo.aperture_end;
> +	}
> +
> +	/* Modify aperture limits. The new aper is either same or bigger */
> +	node = list_first_entry(iova_copy, struct vfio_iova, list);
> +	node->start = start;
> +	node = list_last_entry(iova_copy, struct vfio_iova, list);
> +	node->end = end;
> +}
> +
> +/*
> + * Called when a group is detached. The reserved regions for that
> + * group can be part of valid iova now. But since reserved regions
> + * may be duplicated among groups, populate the iova valid regions
> + * list again.
> + */
> +static int vfio_iommu_resv_refresh(struct vfio_iommu *iommu,
> +				   struct list_head *iova_copy)
> +{
> +	struct vfio_domain *d;
> +	struct vfio_group *g;
> +	struct vfio_iova *node;
> +	dma_addr_t start, end;
> +	LIST_HEAD(resv_regions);
> +	int ret;
> +
> +	if (list_empty(iova_copy))
> +		return -EINVAL;
> +
> +	list_for_each_entry(d, &iommu->domain_list, next) {
> +		list_for_each_entry(g, &d->group_list, next) {
> +			ret = iommu_get_group_resv_regions(g->iommu_group,
> +							   &resv_regions);
> +			if (ret)
> +				goto done;
> +		}
> +	}
> +
> +	node = list_first_entry(iova_copy, struct vfio_iova, list);
> +	start = node->start;
> +	node = list_last_entry(iova_copy, struct vfio_iova, list);
> +	end = node->end;
> +
> +	/* purge the iova list and create new one */
> +	vfio_iommu_iova_free(iova_copy);
> +
> +	ret = vfio_iommu_aper_resize(iova_copy, start, end);
> +	if (ret)
> +		goto done;
> +
> +	/* Exclude current reserved regions from iova ranges */
> +	ret = vfio_iommu_resv_exclude(iova_copy, &resv_regions);
> +done:
> +	vfio_iommu_resv_free(&resv_regions);
> +	return ret;
> +}
> +
>  static void vfio_iommu_type1_detach_group(void *iommu_data,
>  					  struct iommu_group *iommu_group)
>  {
>  	struct vfio_iommu *iommu = iommu_data;
>  	struct vfio_domain *domain;
>  	struct vfio_group *group;
> +	LIST_HEAD(iova_copy);
>  
>  	mutex_lock(&iommu->lock);
>  
> @@ -1895,6 +1976,13 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>  		}
>  	}
>  
> +	/*
> +	 * Get a copy of iova list. This will be used to update
> +	 * and to replace the current one later. Please note that
> +	 * we will leave the original list as it is if update fails.
> +	 */
> +	vfio_iommu_iova_get_copy(iommu, &iova_copy);
> +
>  	list_for_each_entry(domain, &iommu->domain_list, next) {
>  		group = find_iommu_group(domain, iommu_group);
>  		if (!group)
> @@ -1920,10 +2008,16 @@ static void vfio_iommu_type1_detach_group(void *iommu_data,
>  			iommu_domain_free(domain->domain);
>  			list_del(&domain->next);
>  			kfree(domain);
> +			vfio_iommu_aper_expand(iommu, &iova_copy);
>  		}
>  		break;
>  	}
>  
> +	if (!vfio_iommu_resv_refresh(iommu, &iova_copy))
> +		vfio_iommu_iova_insert_copy(iommu, &iova_copy);
> +	else
> +		vfio_iommu_iova_free(&iova_copy);
> +
>  detach_group_done:
>  	mutex_unlock(&iommu->lock);
>  }
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
