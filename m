Return-Path: <SRS0=vdHR=V5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED01C19759
	for <iommu@archiver.kernel.org>; Thu,  1 Aug 2019 14:04:53 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D49D20838
	for <iommu@archiver.kernel.org>; Thu,  1 Aug 2019 14:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D49D20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 9286C13CD;
	Thu,  1 Aug 2019 14:04:28 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DD0531522
	for <iommu@lists.linux-foundation.org>;
	Thu,  1 Aug 2019 13:46:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id B2D307ED
	for <iommu@lists.linux-foundation.org>;
	Thu,  1 Aug 2019 13:46:07 +0000 (UTC)
Received: from lhreml704-cah.china.huawei.com (unknown [172.18.7.106])
	by Forcepoint Email with ESMTP id 4D82E2A6FF4387D75594;
	Thu,  1 Aug 2019 14:46:05 +0100 (IST)
Received: from LHREML524-MBS.china.huawei.com ([169.254.2.132]) by
	lhreml704-cah.china.huawei.com ([10.201.108.45]) with mapi id
	14.03.0415.000; Thu, 1 Aug 2019 14:46:02 +0100
From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
	<eric.auger.pro@gmail.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"hch@infradead.org" <hch@infradead.org>
Subject: RE: [PATCH] iommu: revisit iommu_insert_resv_region() implementation
Thread-Topic: [PATCH] iommu: revisit iommu_insert_resv_region() implementation
Thread-Index: AQHVRt9EwXI06tl+a0iF8fJk/6TXR6bmTwBg
Date: Thu, 1 Aug 2019 13:46:02 +0000
Message-ID: <5FC3163CFD30C246ABAA99954A238FA83F33E69F@lhreml524-mbs.china.huawei.com>
References: <20190730140055.9998-1-eric.auger@redhat.com>
In-Reply-To: <20190730140055.9998-1-eric.auger@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.227.237]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
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

Hi Eric,

> -----Original Message-----
> From: Eric Auger [mailto:eric.auger@redhat.com]
> Sent: 30 July 2019 15:01
> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; joro@8bytes.org;
> iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org;
> dwmw2@infradead.org; alex.williamson@redhat.com;
> robin.murphy@arm.com; hch@infradead.org
> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Subject: [PATCH] iommu: revisit iommu_insert_resv_region() implementation
> 
> Current implementation is recursive and in case of allocation
> failure the existing @regions list is altered. A non recursive
> version looks better for maintainability and simplifies the
> error handling. We use a separate stack for overlapping segment
> merging.
> 
> Note this new implementation may change the region order of
> appearance in /sys/kernel/iommu_groups/<n>/reserved_regions
> files but this order has never been documented, see
> commit bc7d12b91bd3 ("iommu: Implement reserved_regions
> iommu-group sysfs file"). Previously the regions were sorted
> by start address. Now they are first sorted by type and within
> a type they are sorted by start address.

I had a quick run with this patch on one of our boards(D05) where we
actually have an untranslated HW MSI region.

Before..
estuary:/$ cat /sys/kernel/iommu_groups/3/reserved_regions
0x0000000008000000 0x00000000080fffff msi
0x00000000c6010000 0x00000000c601ffff msi 

After...
estuary:/$ cat /sys/kernel/iommu_groups/3/reserved_regions
0x00000000c6010000 0x00000000c601ffff msi
0x0000000008000000 0x00000000080fffff msi

I think the order is reversed now because they are both different types, but are 
called "msi". Slightly confusing, but not sure it's a good idea to change the
description to something more obvious. 

Cheers,
Shameer

> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> ---
>  drivers/iommu/iommu.c | 96 ++++++++++++++++++++++---------------------
>  1 file changed, 50 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 0c674d80c37f..7479f3d38e61 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -229,60 +229,64 @@ static ssize_t iommu_group_show_name(struct
> iommu_group *group, char *buf)
>   * @new: new region to insert
>   * @regions: list of regions
>   *
> - * The new element is sorted by address with respect to the other
> - * regions of the same type. In case it overlaps with another
> - * region of the same type, regions are merged. In case it
> - * overlaps with another region of different type, regions are
> - * not merged.
> + * Elements are sorted by region type and elements of the same
> + * type are sorted by start address. Overlapping segments of the
> + * same type are merged.
>   */
>  static int iommu_insert_resv_region(struct iommu_resv_region *new,
>  				    struct list_head *regions)
>  {
> -	struct iommu_resv_region *region;
> -	phys_addr_t start = new->start;
> -	phys_addr_t end = new->start + new->length - 1;
> -	struct list_head *pos = regions->next;
> +	struct iommu_resv_region *iter, *tmp, *nr, *top;
> +	struct list_head low, high, stack;
> +	bool added = false;
> 
> -	while (pos != regions) {
> -		struct iommu_resv_region *entry =
> -			list_entry(pos, struct iommu_resv_region, list);
> -		phys_addr_t a = entry->start;
> -		phys_addr_t b = entry->start + entry->length - 1;
> -		int type = entry->type;
> +	INIT_LIST_HEAD(&low);
> +	INIT_LIST_HEAD(&high);
> +	INIT_LIST_HEAD(&stack);
> 
> -		if (end < a) {
> -			goto insert;
> -		} else if (start > b) {
> -			pos = pos->next;
> -		} else if ((start >= a) && (end <= b)) {
> -			if (new->type == type)
> -				return 0;
> -			else
> -				pos = pos->next;
> -		} else {
> -			if (new->type == type) {
> -				phys_addr_t new_start = min(a, start);
> -				phys_addr_t new_end = max(b, end);
> -				int ret;
> -
> -				list_del(&entry->list);
> -				entry->start = new_start;
> -				entry->length = new_end - new_start + 1;
> -				ret = iommu_insert_resv_region(entry, regions);
> -				kfree(entry);
> -				return ret;
> -			} else {
> -				pos = pos->next;
> -			}
> -		}
> -	}
> -insert:
> -	region = iommu_alloc_resv_region(new->start, new->length,
> -					 new->prot, new->type);
> -	if (!region)
> +	nr = iommu_alloc_resv_region(new->start, new->length,
> +				     new->prot, new->type);
> +	if (!nr)
>  		return -ENOMEM;
> 
> -	list_add_tail(&region->list, pos);
> +	/*
> +	 * Elements are dispatched into 3 lists: low/high contain
> +	 * segments of lower/higher types than @new; only segments
> +	 * with same type as @new remain in @regions, including @new
> +	 * ordered inserted by start address
> +	 */
> +	list_for_each_entry_safe(iter, tmp, regions, list) {
> +		if (iter->type < nr->type) {
> +			list_move_tail(&iter->list, &low);
> +		} else if (iter->type > nr->type) {
> +			list_move_tail(&iter->list, &high);
> +		} else if (nr->start <= iter->start && !added) {
> +			list_add_tail(&nr->list, &iter->list);
> +			added = true;
> +		}
> +	}
> +	if (!added)
> +		list_add_tail(&nr->list, regions);
> +
> +	/* Merge overlapping segments in @regions, if any */
> +	list_move(regions->next, &stack); /* move the 1st elt to the stack */
> +	list_for_each_entry_safe(iter, tmp, regions, list) {
> +		phys_addr_t top_end, iter_end = iter->start + iter->length - 1;
> +
> +		top = list_last_entry(&stack, struct iommu_resv_region, list);
> +		top_end = top->start + top->length - 1;
> +
> +		if (iter->start > top_end + 1) {
> +			list_move(&iter->list, &top->list);
> +		} else {
> +			top->length = max(top_end, iter_end) - top->start + 1;
> +			list_del(&iter->list);
> +			kfree(iter);
> +		}
> +	}
> +	list_splice(&stack, regions);
> +	list_splice(&low, regions);
> +	list_splice_tail(&high, regions);
>  	return 0;
>  }
> 
> --
> 2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
