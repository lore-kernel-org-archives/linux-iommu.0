Return-Path: <SRS0=LVl/=KN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2533C43462
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 18:59:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66C7661355
	for <iommu@archiver.kernel.org>; Tue, 18 May 2021 18:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C7661355
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F2C640282;
	Tue, 18 May 2021 18:59:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XjWRk8hwRaIO; Tue, 18 May 2021 18:59:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 771CA40356;
	Tue, 18 May 2021 18:59:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55E1AC000E;
	Tue, 18 May 2021 18:59:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36025C0001
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 18:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2011C837AC
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 18:59:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DHNlpXjd4zYU for <iommu@lists.linux-foundation.org>;
 Tue, 18 May 2021 18:59:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D5F6843F5
 for <iommu@lists.linux-foundation.org>; Tue, 18 May 2021 18:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621364347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tfjlufh0xC6ZP3c7VljIYlskYT5mjHLtMK/8FSz46Jg=;
 b=Derp9YoXlHjKR/sq6CfSLGt7Dfmq4iyh0ap1SR93W9JaxBGQGF3TrPYmFgty/9Xxb25VcP
 PTsP6PI5EmzQmo5gdGMXSVhTpFv3VPo0Euei1oa2lgD9GxkxweQnj1wAaJCyjPQUGvQOR9
 nK78k+RLwNOhMiyN4Zxe5Riyhfwut7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-urbit0cmMIiAzdAOFUsM4A-1; Tue, 18 May 2021 14:59:05 -0400
X-MC-Unique: urbit0cmMIiAzdAOFUsM4A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEEFF6D4E6;
 Tue, 18 May 2021 18:59:03 +0000 (UTC)
Received: from redhat.com (ovpn-113-225.phx2.redhat.com [10.3.113.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED03B100F49F;
 Tue, 18 May 2021 18:59:02 +0000 (UTC)
Date: Tue, 18 May 2021 12:58:18 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Shenming Lu <lushenming@huawei.com>
Subject: Re: [RFC PATCH v3 6/8] vfio/type1: No need to statically pin and
 map if IOPF enabled
Message-ID: <20210518125818.2282941f.alex.williamson@redhat.com>
In-Reply-To: <20210409034420.1799-7-lushenming@huawei.com>
References: <20210409034420.1799-1-lushenming@huawei.com>
 <20210409034420.1799-7-lushenming@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 iommu@lists.linux-foundation.org, linux-api@vger.kernel.org,
 wanghaibin.wang@huawei.com, Robin Murphy <robin.murphy@arm.com>,
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

On Fri, 9 Apr 2021 11:44:18 +0800
Shenming Lu <lushenming@huawei.com> wrote:

> If IOPF enabled for the VFIO container, there is no need to statically
> pin and map the entire DMA range, we can do it on demand. And unmap
> according to the IOPF mapped bitmap when removing vfio_dma.
> 
> Note that we still mark all pages dirty even if IOPF enabled, we may
> add IOPF-based fine grained dirty tracking support in the future.
> 
> Signed-off-by: Shenming Lu <lushenming@huawei.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 38 +++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 7df5711e743a..dcc93c3b258c 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -175,6 +175,7 @@ struct vfio_iopf_group {
>  #define IOPF_MAPPED_BITMAP_GET(dma, i)	\
>  			      ((dma->iopf_mapped_bitmap[(i) / BITS_PER_LONG]	\
>  			       >> ((i) % BITS_PER_LONG)) & 0x1)  
> +#define IOPF_MAPPED_BITMAP_BYTES(n)	DIRTY_BITMAP_BYTES(n)
>  
>  #define WAITED 1
>  
> @@ -959,7 +960,8 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
>  	 * already pinned and accounted. Accouting should be done if there is no
>  	 * iommu capable domain in the container.
>  	 */
> -	do_accounting = !IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu);
> +	do_accounting = !IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu) ||
> +			iommu->iopf_enabled;
>  
>  	for (i = 0; i < npage; i++) {
>  		struct vfio_pfn *vpfn;
> @@ -1048,7 +1050,8 @@ static int vfio_iommu_type1_unpin_pages(void *iommu_data,
>  
>  	mutex_lock(&iommu->lock);
>  
> -	do_accounting = !IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu);
> +	do_accounting = !IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu) ||
> +			iommu->iopf_enabled;

pin/unpin are actually still pinning pages, why does iopf exempt them
from accounting?


>  	for (i = 0; i < npage; i++) {
>  		struct vfio_dma *dma;
>  		dma_addr_t iova;
> @@ -1169,7 +1172,7 @@ static long vfio_unmap_unpin(struct vfio_iommu *iommu, struct vfio_dma *dma,
>  	if (!dma->size)
>  		return 0;
>  
> -	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu))
> +	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu) || iommu->iopf_enabled)
>  		return 0;
>  
>  	/*
> @@ -1306,11 +1309,20 @@ static void vfio_unmap_partial_iopf(struct vfio_iommu *iommu,
>  	}
>  }
>  
> +static void vfio_dma_clean_iopf(struct vfio_iommu *iommu, struct vfio_dma *dma)
> +{
> +	vfio_unmap_partial_iopf(iommu, dma, dma->iova, dma->iova + dma->size);
> +
> +	kfree(dma->iopf_mapped_bitmap);
> +}
> +
>  static void vfio_remove_dma(struct vfio_iommu *iommu, struct vfio_dma *dma)
>  {
>  	WARN_ON(!RB_EMPTY_ROOT(&dma->pfn_list));
>  	vfio_unmap_unpin(iommu, dma, true);
>  	vfio_unlink_dma(iommu, dma);
> +	if (iommu->iopf_enabled)
> +		vfio_dma_clean_iopf(iommu, dma);
>  	put_task_struct(dma->task);
>  	vfio_dma_bitmap_free(dma);
>  	if (dma->vaddr_invalid) {
> @@ -1359,7 +1371,8 @@ static int update_user_bitmap(u64 __user *bitmap, struct vfio_iommu *iommu,
>  	 * mark all pages dirty if any IOMMU capable device is not able
>  	 * to report dirty pages and all pages are pinned and mapped.
>  	 */
> -	if (iommu->num_non_pinned_groups && dma->iommu_mapped)
> +	if (iommu->num_non_pinned_groups &&
> +	    (dma->iommu_mapped || iommu->iopf_enabled))
>  		bitmap_set(dma->bitmap, 0, nbits);

This seems like really poor integration of iopf into dirty page
tracking.  I'd expect dirty logging to flush the mapped pages and
write faults to mark pages dirty.  Shouldn't the fault handler also
provide only the access faulted, so for example a read fault wouldn't
mark the page dirty?

>  
>  	if (shift) {
> @@ -1772,6 +1785,16 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
>  		goto out_unlock;
>  	}
>  
> +	if (iommu->iopf_enabled) {
> +		dma->iopf_mapped_bitmap = kvzalloc(IOPF_MAPPED_BITMAP_BYTES(
> +						size >> PAGE_SHIFT), GFP_KERNEL);
> +		if (!dma->iopf_mapped_bitmap) {
> +			ret = -ENOMEM;
> +			kfree(dma);
> +			goto out_unlock;
> +		}


So we're assuming nothing can fault and therefore nothing can reference
the iopf_mapped_bitmap until this point in the series?


> +	}
> +
>  	iommu->dma_avail--;
>  	dma->iova = iova;
>  	dma->vaddr = vaddr;
> @@ -1811,8 +1834,11 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
>  	/* Insert zero-sized and grow as we map chunks of it */
>  	vfio_link_dma(iommu, dma);
>  
> -	/* Don't pin and map if container doesn't contain IOMMU capable domain*/
> -	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu))
> +	/*
> +	 * Don't pin and map if container doesn't contain IOMMU capable domain,
> +	 * or IOPF enabled for the container.
> +	 */
> +	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu) || iommu->iopf_enabled)
>  		dma->size = size;
>  	else
>  		ret = vfio_pin_map_dma(iommu, dma, size);

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
