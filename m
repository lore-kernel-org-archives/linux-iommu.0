Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF44C433E0
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 15:02:18 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6AAE206E2
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 15:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DeBAWV0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AAE206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7AD5E89A6D;
	Tue,  7 Jul 2020 15:02:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TfCd8zdweff2; Tue,  7 Jul 2020 15:02:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6646789A55;
	Tue,  7 Jul 2020 15:02:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 425C1C0893;
	Tue,  7 Jul 2020 15:02:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E5CBC016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 15:02:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0569C89030
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 15:02:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K+QLCrKFSQkH for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 15:02:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 131C18902F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 15:02:12 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200707150210euoutp02c81bbde53ef03cd849a5eead8769cf18~fgIu90Ots0055000550euoutp02a
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 15:02:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200707150210euoutp02c81bbde53ef03cd849a5eead8769cf18~fgIu90Ots0055000550euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1594134130;
 bh=wOb/cwkj3XJiREprcybZVqbIIRoFX3C5VdLNDsmM354=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=DeBAWV0FX7eFTUx0PQzHr+d7B1H8zmsfQteKBweMLVvvFADnHPAnvU7wSPLtQpbGN
 e3tzTeOAgAinCOeWbW7jUZ0pR/WQhLDG3gh4Ipn+cu9QHTKLFJMq+NlzEVhYJI+Dm7
 ttLCtLHZFuXbaCwmHFjsgxHv+PROdra9Dc757eFY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20200707150210eucas1p2c875f6411dc355973b7512b4cdcc6310~fgIubcEW10679706797eucas1p2K;
 Tue,  7 Jul 2020 15:02:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 20.74.06456.27E840F5; Tue,  7
 Jul 2020 16:02:10 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200707150209eucas1p17faf97752ee07c5b7dae3f359a18db90~fgIuGDO0o0165001650eucas1p1U;
 Tue,  7 Jul 2020 15:02:09 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200707150209eusmtrp2e8b136c9b25a7dd37470b5db0e6c6154~fgIuFWk-O1360213602eusmtrp2Y;
 Tue,  7 Jul 2020 15:02:09 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-fe-5f048e72144f
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id A7.09.06017.17E840F5; Tue,  7
 Jul 2020 16:02:09 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200707150208eusmtip224acf9ca1e9dc958003f2203ce8bb385~fgIsm4kJv1267812678eusmtip2U;
 Tue,  7 Jul 2020 15:02:08 +0000 (GMT)
Subject: Re: [PATCH v7 03/36] drm: core: fix common struct sg_table related
 issues
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <f7306f61-089f-9639-1d7d-2dca60ef19d3@samsung.com>
Date: Tue, 7 Jul 2020 17:02:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200619103636.11974-4-m.szyprowski@samsung.com>
Content-Language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+c5tZ6vZcSp700icVhikSRcOGVIWcf4ME6MkddVBLW/taGVB
 WpaJ1jAt0qElmXfNa06NqEY6RFrLy1IqZlqB4TJ1FlZazqPkf7/3e5738sBH44oB0p2OTUjm
 NQnqOBUlI1q7Zk1bNFoicmverJS9aerG2MaCepLtn5mg2KqaTowteRbI2vs/YmzTqIVk+zqK
 KLbu5QcJ++L7J5JtGb9F7lnF1d6rRZz+xzDJWXOMGNf8MI17Nz+Kc/mDFYh7MpROcdqWasQ1
 91zkppvWH5Qdle0+ycfFnuU1/kFRshhDYaYkKc/3/PUOG5mOir2ykZQGZjsMmRtRNpLRCqYS
 Qc5UKSkWdgTm511LyjSCyi8F+HKL3lRHiUIFguHqIkwsJhAUWI0Sh8uFCQVtZzpysCvTgiDj
 zgGHCXeMumZ5ijkEivGFueYhysFyJgiGG0cWmWB8oNSSsbjOjYmA+jE9JnqcobvwE+Fg6YJ/
 tHZu0Y8znqC3FeEiK+GKvWoxBDCTEng71CwR794PLz4UUSK7wFdjy9L7Ovjbfh8TOQ2slVdx
 sTkLweOG9qXQgfDe9GuhmV7Y4Av1Hf4OBGYvVJRtEtEJBm3O4glOkNd6Fxef5ZCVqRBneIH1
 1eOleUooM89QuUilWxFMtyKMbkUY3f+1JYioRko+RYiP5oWABP6cn6COF1ISov1OJMY3oYXP
 1jNvnGpDM73HDYihkWq1PEZNRCpI9VkhNd6AgMZVrvLgVz0RCvlJdeoFXpMYqUmJ4wUD8qAJ
 lVK+7cHYMQUTrU7mT/N8Eq9ZVjFa6p6OgmP+hFudbTtvkIc7X4/8nHUpi15z6dL4YLmlTTjd
 UFjo+dT+O39yU+6wOQTTHlrbQ9q1MPU5qa9/4Exx1JHJ+rBd+wZqkFtlkHeIT7d/eO8G5vLE
 KcncDsOZ58kedboCb8JtlTSZ/Gb0GFFsDGvb9Sj0dmr53FhS1zZ8XG97E6sihBh1wGZcI6j/
 Ac/ypUFoAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsVy+t/xe7qFfSzxBg/e6Vv0njvJZLFxxnpW
 iytf37NZrFx9lMliwX5riy9XHjJZbHp8jdXi8q45bBZrj9xltzj44QmrxZY3E1kduD3WzFvD
 6LH92wNWj/vdx5k8Ni+p97j97zGzx+Qbyxk9dt9sYPPo27KK0WPz6WqPz5vkArii9GyK8ktL
 UhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DIOzWxjL5ikWdG+
 6y1rA+NcxS5GTg4JAROJ7efWsnUxcnEICSxllPjddoYNIiEusXv+W2YIW1jiz7UuqKK3jBJb
 Ds9nBUkIC4RI9B1tYARJiAhsYZR4tuIwmMMs8JlR4u/1j1AtRxklrk/bww7SwiagKfF3802w
 HbwCdhIPNj4Cs1kEVCQWX2sG2ycqECexfMt8dogaQYmTM5+wgNicQPWP1/wFq2cWMJOYt/kh
 M4QtL7H97RwoW1yi6ctK1gmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+kVJ+YWl+al
 6yXn525iBMbztmM/t+xg7HoXfIhRgINRiYc3I5ElXog1say4MvcQowQHs5IIr9PZ03FCvCmJ
 lVWpRfnxRaU5qcWHGE2BnpvILCWanA9MNXkl8YamhuYWlobmxubGZhZK4rwdAgdjhATSE0tS
 s1NTC1KLYPqYODilGhiLjXwys542i7Xa+3luWq07iflvn7vXe8etKxvfiqctfzXxzdFyf6t1
 uy1mXOWZnt4WK2eUeiHu/ltj7trXe68qPOMsXDfB89i2sPbd76rbZz1WKmTzOZxyYrVqkrfS
 iXte79XPi0bsevzsUp6c4IHbXjzu20KS/33zbYg3qrx7aH64fpqG8VMlluKMREMt5qLiRAAO
 5m+6/QIAAA==
X-CMS-MailID: 20200707150209eucas1p17faf97752ee07c5b7dae3f359a18db90
X-Msg-Generator: CA
X-RootMTR: 20200619103655eucas1p1b01cbe67526e2b2f8254eb20ccac1858
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103655eucas1p1b01cbe67526e2b2f8254eb20ccac1858
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
 <CGME20200619103655eucas1p1b01cbe67526e2b2f8254eb20ccac1858@eucas1p1.samsung.com>
 <20200619103636.11974-4-m.szyprowski@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Thomas Zimmermann <tzimmermann@suse.de>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
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


On 19.06.2020 12:36, Marek Szyprowski wrote:
> The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
> returns the number of the created entries in the DMA address space.
> However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
> dma_unmap_sg must be called with the original number of the entries
> passed to the dma_map_sg().
>
> struct sg_table is a common structure used for describing a non-contiguous
> memory buffer, used commonly in the DRM and graphics subsystems. It
> consists of a scatterlist with memory pages and DMA addresses (sgl entry),
> as well as the number of scatterlist entries: CPU pages (orig_nents entry)
> and DMA mapped pages (nents entry).
>
> It turned out that it was a common mistake to misuse nents and orig_nents
> entries, calling DMA-mapping functions with a wrong number of entries or
> ignoring the number of mapped entries returned by the dma_map_sg()
> function.
>
> To avoid such issues, lets use a common dma-mapping wrappers operating
> directly on the struct sg_table objects and use scatterlist page
> iterators where possible. This, almost always, hides references to the
> nents and orig_nents entries, making the code robust, easier to follow
> and copy/paste safe.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>


I guess whole patchset can go via drm-misc, after r-b/a-b.


Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>


Regards
Andrzej
> ---
>   drivers/gpu/drm/drm_cache.c            |  2 +-
>   drivers/gpu/drm/drm_gem_shmem_helper.c | 14 +++++++++-----
>   drivers/gpu/drm/drm_prime.c            | 11 ++++++-----
>   3 files changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
> index 03e01b000f7a..0fe3c496002a 100644
> --- a/drivers/gpu/drm/drm_cache.c
> +++ b/drivers/gpu/drm/drm_cache.c
> @@ -127,7 +127,7 @@ drm_clflush_sg(struct sg_table *st)
>   		struct sg_page_iter sg_iter;
>   
>   		mb(); /*CLFLUSH is ordered only by using memory barriers*/
> -		for_each_sg_page(st->sgl, &sg_iter, st->nents, 0)
> +		for_each_sgtable_page(st, &sg_iter, 0)
>   			drm_clflush_page(sg_page_iter_page(&sg_iter));
>   		mb(); /*Make sure that all cache line entry is flushed*/
>   
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 4b7cfbac4daa..47d8211221f2 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -126,8 +126,8 @@ void drm_gem_shmem_free_object(struct drm_gem_object *obj)
>   		drm_prime_gem_destroy(obj, shmem->sgt);
>   	} else {
>   		if (shmem->sgt) {
> -			dma_unmap_sg(obj->dev->dev, shmem->sgt->sgl,
> -				     shmem->sgt->nents, DMA_BIDIRECTIONAL);
> +			dma_unmap_sgtable(obj->dev->dev, shmem->sgt,
> +					  DMA_BIDIRECTIONAL, 0);
>   			sg_free_table(shmem->sgt);
>   			kfree(shmem->sgt);
>   		}
> @@ -424,8 +424,7 @@ void drm_gem_shmem_purge_locked(struct drm_gem_object *obj)
>   
>   	WARN_ON(!drm_gem_shmem_is_purgeable(shmem));
>   
> -	dma_unmap_sg(obj->dev->dev, shmem->sgt->sgl,
> -		     shmem->sgt->nents, DMA_BIDIRECTIONAL);
> +	dma_unmap_sgtable(obj->dev->dev, shmem->sgt, DMA_BIDIRECTIONAL, 0);
>   	sg_free_table(shmem->sgt);
>   	kfree(shmem->sgt);
>   	shmem->sgt = NULL;
> @@ -697,12 +696,17 @@ struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_object *obj)
>   		goto err_put_pages;
>   	}
>   	/* Map the pages for use by the h/w. */
> -	dma_map_sg(obj->dev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL);
> +	ret = dma_map_sgtable(obj->dev->dev, sgt, DMA_BIDIRECTIONAL, 0);
> +	if (ret)
> +		goto err_free_sgt;
>   
>   	shmem->sgt = sgt;
>   
>   	return sgt;
>   
> +err_free_sgt:
> +	sg_free_table(sgt);
> +	kfree(sgt);
>   err_put_pages:
>   	drm_gem_shmem_put_pages(shmem);
>   	return ERR_PTR(ret);
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index b717e52e909e..d583d6545666 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -617,6 +617,7 @@ struct sg_table *drm_gem_map_dma_buf(struct dma_buf_attachment *attach,
>   {
>   	struct drm_gem_object *obj = attach->dmabuf->priv;
>   	struct sg_table *sgt;
> +	int ret;
>   
>   	if (WARN_ON(dir == DMA_NONE))
>   		return ERR_PTR(-EINVAL);
> @@ -626,11 +627,12 @@ struct sg_table *drm_gem_map_dma_buf(struct dma_buf_attachment *attach,
>   	else
>   		sgt = obj->dev->driver->gem_prime_get_sg_table(obj);
>   
> -	if (!dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
> -			      DMA_ATTR_SKIP_CPU_SYNC)) {
> +	ret = dma_map_sgtable(attach->dev, sgt, dir,
> +			      DMA_ATTR_SKIP_CPU_SYNC);
> +	if (ret) {
>   		sg_free_table(sgt);
>   		kfree(sgt);
> -		sgt = ERR_PTR(-ENOMEM);
> +		sgt = ERR_PTR(ret);
>   	}
>   
>   	return sgt;
> @@ -652,8 +654,7 @@ void drm_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
>   	if (!sgt)
>   		return;
>   
> -	dma_unmap_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
> -			   DMA_ATTR_SKIP_CPU_SYNC);
> +	dma_unmap_sgtable(attach->dev, sgt, dir, DMA_ATTR_SKIP_CPU_SYNC);
>   	sg_free_table(sgt);
>   	kfree(sgt);
>   }
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
