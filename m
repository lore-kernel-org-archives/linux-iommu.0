Return-Path: <SRS0=R9yw=VE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9089CC48BDB
	for <iommu@archiver.kernel.org>; Sun,  7 Jul 2019 15:13:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BAFD2082E
	for <iommu@archiver.kernel.org>; Sun,  7 Jul 2019 15:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BAFD2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 176C21E6A;
	Sun,  7 Jul 2019 15:13:15 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 9319F1E1A
	for <iommu@lists.linux-foundation.org>;
	Sun,  7 Jul 2019 15:03:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 4364B148
	for <iommu@lists.linux-foundation.org>;
	Sun,  7 Jul 2019 15:03:36 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B36A9308339B;
	Sun,  7 Jul 2019 15:03:35 +0000 (UTC)
Received: from [10.36.116.46] (ovpn-116-46.ams2.redhat.com [10.36.116.46])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2462019C79;
	Sun,  7 Jul 2019 15:03:29 +0000 (UTC)
Subject: Re: [PATCH v7 4/6] vfio/type1: check dma map request is within a
	valid iova range
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com
References: <20190626151248.11776-1-shameerali.kolothum.thodi@huawei.com>
	<20190626151248.11776-5-shameerali.kolothum.thodi@huawei.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <d44d9c7a-9333-616e-21fd-999bfa7aafe4@redhat.com>
Date: Sun, 7 Jul 2019 17:03:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190626151248.11776-5-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Sun, 07 Jul 2019 15:03:35 +0000 (UTC)
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
> This checks and rejects any dma map request outside valid iova
> range.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> v6 --> v7
> 
> Addressed the case where a container with only an mdev device will
> have an empty list(Suggested by Alex).
> ---
>  drivers/vfio/vfio_iommu_type1.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index e872fb3a0f39..89ad0da7152c 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1050,6 +1050,27 @@ static int vfio_pin_map_dma(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  	return ret;
>  }
>  
> +/*
> + * Check dma map request is within a valid iova range
> + */
> +static bool vfio_iommu_iova_dma_valid(struct vfio_iommu *iommu,
> +				      dma_addr_t start, dma_addr_t end)
> +{
> +	struct list_head *iova = &iommu->iova_list;
> +	struct vfio_iova *node;
> +
> +	list_for_each_entry(node, iova, list) {
> +		if (start >= node->start && end <= node->end)
> +			return true;
> +	}
> +
> +	/*
> +	 * Check for list_empty() as well since a container with
> +	 * only an mdev device will have an empty list.
> +	 */
> +	return list_empty(&iommu->iova_list);
iova

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


> +}
> +
>  static int vfio_dma_do_map(struct vfio_iommu *iommu,
>  			   struct vfio_iommu_type1_dma_map *map)
>  {
> @@ -1093,6 +1114,11 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
>  		goto out_unlock;
>  	}
>  
> +	if (!vfio_iommu_iova_dma_valid(iommu, iova, iova + size - 1)) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
>  	dma = kzalloc(sizeof(*dma), GFP_KERNEL);
>  	if (!dma) {
>  		ret = -ENOMEM;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
