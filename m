Return-Path: <SRS0=R9yw=VE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46CBC48BDE
	for <iommu@archiver.kernel.org>; Sun,  7 Jul 2019 15:13:21 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24D82082E
	for <iommu@archiver.kernel.org>; Sun,  7 Jul 2019 15:13:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24D82082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 847AF1E76;
	Sun,  7 Jul 2019 15:13:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id C47FC1E1A
	for <iommu@lists.linux-foundation.org>;
	Sun,  7 Jul 2019 15:03:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 750A5148
	for <iommu@lists.linux-foundation.org>;
	Sun,  7 Jul 2019 15:03:53 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F0E4A7FDCA;
	Sun,  7 Jul 2019 15:03:52 +0000 (UTC)
Received: from [10.36.116.46] (ovpn-116-46.ams2.redhat.com [10.36.116.46])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A0D5E98B1;
	Sun,  7 Jul 2019 15:03:48 +0000 (UTC)
Subject: Re: [PATCH v7 6/6] vfio/type1: remove duplicate retrieval of reserved
	regions
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com
References: <20190626151248.11776-1-shameerali.kolothum.thodi@huawei.com>
	<20190626151248.11776-7-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <7e4fd6c4-ac01-1378-cf8d-35ef490fe7ca@redhat.com>
Date: Sun, 7 Jul 2019 17:03:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190626151248.11776-7-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Sun, 07 Jul 2019 15:03:53 +0000 (UTC)
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
> As we now already have the reserved regions list, just pass that into
> vfio_iommu_has_sw_msi() fn.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  drivers/vfio/vfio_iommu_type1.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 450081802dcd..43b1e68ebce9 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1308,15 +1308,13 @@ static struct vfio_group *find_iommu_group(struct vfio_domain *domain,
>  	return NULL;
>  }
>  
> -static bool vfio_iommu_has_sw_msi(struct iommu_group *group, phys_addr_t *base)
> +static bool vfio_iommu_has_sw_msi(struct list_head *group_resv_regions,
> +				  phys_addr_t *base)
>  {
> -	struct list_head group_resv_regions;
> -	struct iommu_resv_region *region, *next;
> +	struct iommu_resv_region *region;
>  	bool ret = false;
>  
> -	INIT_LIST_HEAD(&group_resv_regions);
> -	iommu_get_group_resv_regions(group, &group_resv_regions);
> -	list_for_each_entry(region, &group_resv_regions, list) {
> +	list_for_each_entry(region, group_resv_regions, list) {
>  		/*
>  		 * The presence of any 'real' MSI regions should take
>  		 * precedence over the software-managed one if the
> @@ -1332,8 +1330,7 @@ static bool vfio_iommu_has_sw_msi(struct iommu_group *group, phys_addr_t *base)
>  			ret = true;
>  		}
>  	}
> -	list_for_each_entry_safe(region, next, &group_resv_regions, list)
> -		kfree(region);
> +
>  	return ret;
>  }
>  
> @@ -1774,7 +1771,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  	if (ret)
>  		goto out_detach;
>  
> -	resv_msi = vfio_iommu_has_sw_msi(iommu_group, &resv_msi_base);
> +	resv_msi = vfio_iommu_has_sw_msi(&group_resv_regions, &resv_msi_base);
>  
>  	INIT_LIST_HEAD(&domain->group_list);
>  	list_add(&group->next, &domain->group_list);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
