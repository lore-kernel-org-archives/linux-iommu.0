Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D302C433DF
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 14:30:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 307D720771
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 14:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rulvypuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307D720771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CE4A787F2F;
	Tue,  7 Jul 2020 14:30:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wpquN5rIVcFR; Tue,  7 Jul 2020 14:30:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A1C9287E84;
	Tue,  7 Jul 2020 14:30:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75C89C0893;
	Tue,  7 Jul 2020 14:30:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91487C016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 14:30:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 78DDF89A23
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 14:30:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ghdZcD1FT85u for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 14:30:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9520C89A07
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 14:30:08 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200707143006euoutp0153541ff07a43458759687b86eea10675~ffsutk2gw0247702477euoutp01b
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 14:30:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200707143006euoutp0153541ff07a43458759687b86eea10675~ffsutk2gw0247702477euoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1594132206;
 bh=3LoKDhvTEKK1epggjyqI8U4nqR+CoQMy2G6Vf/Le/eo=;
 h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
 b=rulvypuLpp8klpNsV3WbOExojrpHVkD236kkknobY51CcXqdqZiV18vFiGPSy06IX
 qZRoQoE1fOrEz10ww0K2b4llSJYdX1mhPSte+N5TjX3Na5WHyOF6jabnTbND7k5PdH
 kh2fVjuy9YnHhnMwdU7Q+LAYGVbnDVBVRLwgH34w=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200707143005eucas1p18712e1cef53a6e813e512d4fd63bef90~ffsuIJ7Un0077400774eucas1p1O;
 Tue,  7 Jul 2020 14:30:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id E7.A5.05997.DE6840F5; Tue,  7
 Jul 2020 15:30:05 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200707143005eucas1p101df630ab6b0626ff41acefbb78b450b~ffstwSHAI3104731047eucas1p1e;
 Tue,  7 Jul 2020 14:30:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200707143005eusmtrp11a17c632aa67425febc551f1cce8e34f~ffstvjTfC2277422774eusmtrp12;
 Tue,  7 Jul 2020 14:30:05 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-8f-5f0486ed1ee6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id E0.B4.06017.DE6840F5; Tue,  7
 Jul 2020 15:30:05 +0100 (BST)
Received: from [106.210.85.205] (unknown [106.210.85.205]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20200707143003eusmtip167fe58a29723098ee2c3be52f44a7254~ffssZssIf1180311803eusmtip1w;
 Tue,  7 Jul 2020 14:30:03 +0000 (GMT)
Subject: Re: [PATCH v7 01/36] drm: prime: add common helper to check
 scatterlist contiguity
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
From: Andrzej Hajda <a.hajda@samsung.com>
Message-ID: <b74fc6a2-31d1-3e2b-db84-954e41949ed9@samsung.com>
Date: Tue, 7 Jul 2020 16:30:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200619103636.11974-2-m.szyprowski@samsung.com>
Content-Language: en-GB
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeyyVcRjH93tv5zh18nZo54linZWmFaVWb1TrtnrbWqv+shZ68Q7jYOeg
 1FaWy4wYmlVquqCDLofjcMSsdUrIpVzmEg1DpToUuqJ1Xi/Lf5/f8/0+z/d5tp8UV3SQDtKQ
 8CheE86FqSgZUfHy9+tNliTCb3NhgQuT1tKAMaXX9STT8X2cYooe1GLMnadezFTHIMYYhjpJ
 pr3qFsU8evFOwjz7Okwyxi+Z5N4l7MPch4g1/Rgg2f7UOowty7/E9v4dwtmr3TrEVvfEUWy6
 sRixZY0X2EmD03HZKdmuQD4sJIbXuO85IwsufzyARTY5nct+NCGJQxWQgmykQG+DwVIdLrCC
 LkSQVeMh8hSCt/W7U5DMypMIZmpT8YWGn9ljlCjoEMzm5iHxMY6gOj2NEFx2tA/UDRiQwPa0
 EUF89iHBhAujEjtrMEGgaFeYLeuhBJbTe6ChrHWOCXotmG+PSgReQfuCftSEiZ7l0HBjeC7A
 xurvM8XPBeC0M5gst3CRlXB5qogUwoD+JoHMsWvzex+EIX0JKbIdfKozSkReBY1XrxAiX4L+
 wgRcbE5GUF7yZL7ZC/pa/li3k1oTXEFf5S6W90GruZkUykAvg27LcnGHZZBVIcQKZTkkJylE
 9xroby6fH6iEgjffqQykyll0Wc6ia3IWXZPzP/cOIoqRko/WqoN4rUc4f9ZNy6m10eFBbgER
 agOy/rXGv3VTlahqxt+MaClSLZUHc4SfguRitLFqMwIprrKX729u9FXIA7nY87wmwk8THcZr
 zchRSqiU8q33Rn0UdBAXxYfyfCSvWVAxqY1DHErwH3EY7B7Kr0mXn8BWdoRO1x9YV6/PO2xx
 NHm6rr8fuu5XW3JvRaEhNfG2kSzY0aAeydrp0uNpC6eL2hwu2h7MKO4fr/QYCPEs8c4L3njk
 A330eS/+sWsa237y/WBAvneT7tDsza5jd1dPcNNFPdTnVzpldUynxRQd5Ky6WeDariK0wdyW
 DbhGy/0DsQYvd2cDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsVy+t/xu7pv21jiDZ6+4rHoPXeSyWLjjPWs
 Fle+vmezWLn6KJPFgv3WFl+uPGSy2PT4GqvF5V1z2CzWHrnLbnHwwxNWiy1vJrI6cHusmbeG
 0WP7twesHve7jzN5bF5S73H732Nmj8k3ljN67L7ZwObRt2UVo8fm09UenzfJBXBF6dkU5ZeW
 pCpk5BeX2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GVsXfeAqeCMXMXU
 tZ/YGxi3SXQxcnJICJhIfJ/6jq2LkYtDSGApo8ShJSuZIRLiErvnv4WyhSX+XOuCKnrLKHH3
 wwawhLBArMTxB5sYQRIiAlsYJZ6tOAzmMAt8ZpT4e/0jVMtRRokrB2cygbSwCWhK/N18kw3E
 5hWwkzi5+SKYzSKgInFo/kt2EFtUIE5i+Zb57BA1ghInZz5hAbE5gervbG9mBLGZBcwk5m1+
 yAxhy0tsfzsHyhaXaPqyknUCo9AsJO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xUZ6xYm5xaV5
 6XrJ+bmbGIHxvO3Yzy07GLveBR9iFOBgVOLhzUhkiRdiTSwrrsw9xCjBwawkwut09nScEG9K
 YmVValF+fFFpTmrxIUZToOcmMkuJJucDU01eSbyhqaG5haWhubG5sZmFkjhvh8DBGCGB9MSS
 1OzU1ILUIpg+Jg5OqQZG/Wd2m/Mucr5h8n8/Uf/FH6smcecFu7N+iEbaB348tz8278QZU6ll
 qt2bbsxM173hHDqvoaHNc26YUWxzixnrHJvCi8+YDlk6nJl03yNGOEX3WltNp/9KH8ntHH9L
 E+8bsrV//vXS8Ov5khjzyx+7Jq/VaNzIEaIqYV/17V9JEr/h1fMSAqJKLMUZiYZazEXFiQAx
 ewWx/QIAAA==
X-CMS-MailID: 20200707143005eucas1p101df630ab6b0626ff41acefbb78b450b
X-Msg-Generator: CA
X-RootMTR: 20200619103653eucas1p2542a7f42db61b22a43919666368dbbfa
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200619103653eucas1p2542a7f42db61b22a43919666368dbbfa
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
 <CGME20200619103653eucas1p2542a7f42db61b22a43919666368dbbfa@eucas1p2.samsung.com>
 <20200619103636.11974-2-m.szyprowski@samsung.com>
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
> It is a common operation done by DRM drivers to check the contiguity
> of the DMA-mapped buffer described by a scatterlist in the
> sg_table object. Let's add a common helper for this operation.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/gpu/drm/drm_gem_cma_helper.c | 23 +++------------------
>   drivers/gpu/drm/drm_prime.c          | 31 ++++++++++++++++++++++++++++
>   include/drm/drm_prime.h              |  2 ++
>   3 files changed, 36 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
> index 06a5b9ee1fe0..41566a15dabd 100644
> --- a/drivers/gpu/drm/drm_gem_cma_helper.c
> +++ b/drivers/gpu/drm/drm_gem_cma_helper.c
> @@ -471,26 +471,9 @@ drm_gem_cma_prime_import_sg_table(struct drm_device *dev,
>   {
>   	struct drm_gem_cma_object *cma_obj;
>   
> -	if (sgt->nents != 1) {
> -		/* check if the entries in the sg_table are contiguous */
> -		dma_addr_t next_addr = sg_dma_address(sgt->sgl);
> -		struct scatterlist *s;
> -		unsigned int i;
> -
> -		for_each_sg(sgt->sgl, s, sgt->nents, i) {
> -			/*
> -			 * sg_dma_address(s) is only valid for entries
> -			 * that have sg_dma_len(s) != 0
> -			 */
> -			if (!sg_dma_len(s))
> -				continue;
> -
> -			if (sg_dma_address(s) != next_addr)
> -				return ERR_PTR(-EINVAL);
> -
> -			next_addr = sg_dma_address(s) + sg_dma_len(s);
> -		}
> -	}
> +	/* check if the entries in the sg_table are contiguous */
> +	if (drm_prime_get_contiguous_size(sgt) < attach->dmabuf->size)
> +		return ERR_PTR(-EINVAL);
>   
>   	/* Create a CMA GEM buffer. */
>   	cma_obj = __drm_gem_cma_create(dev, attach->dmabuf->size);
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index bbfc713bfdc3..226cd6ad3985 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -825,6 +825,37 @@ struct sg_table *drm_prime_pages_to_sg(struct page **pages, unsigned int nr_page
>   }
>   EXPORT_SYMBOL(drm_prime_pages_to_sg);
>   
> +/**
> + * drm_prime_get_contiguous_size - returns the contiguous size of the buffer
> + * @sgt: sg_table describing the buffer to check
> + *
> + * This helper calculates the contiguous size in the DMA address space
> + * of the the buffer described by the provided sg_table.
> + *
> + * This is useful for implementing
> + * &drm_gem_object_funcs.gem_prime_import_sg_table.
> + */
> +unsigned long drm_prime_get_contiguous_size(struct sg_table *sgt)
> +{
> +	dma_addr_t expected = sg_dma_address(sgt->sgl);
> +	struct scatterlist *sg;
> +	unsigned long size = 0;
> +	int i;
> +
> +	for_each_sgtable_dma_sg(sgt, sg, i) {
> +		unsigned int len = sg_dma_len(sg);
> +
> +		if (!len)
> +			break;


I wander if in some dark corners of the kernel 0-length buffers can be 
in use :)


> +		if (sg_dma_address(sg) != expected)
> +			break;
> +		expected += len;
> +		size += len;
> +	}
> +	return size;
> +}
> +EXPORT_SYMBOL(drm_prime_get_contiguous_size);
> +
>   /**
>    * drm_gem_prime_export - helper library implementation of the export callback
>    * @obj: GEM object to export
> diff --git a/include/drm/drm_prime.h b/include/drm/drm_prime.h
> index 9af7422b44cf..47ef11614627 100644
> --- a/include/drm/drm_prime.h
> +++ b/include/drm/drm_prime.h
> @@ -92,6 +92,8 @@ struct sg_table *drm_prime_pages_to_sg(struct page **pages, unsigned int nr_page
>   struct dma_buf *drm_gem_prime_export(struct drm_gem_object *obj,
>   				     int flags);
>   
> +unsigned long drm_prime_get_contiguous_size(struct sg_table *sgt);
> +

Reviewed-by <a.hajda@samsung.com>

Regards
Andrzej


>   /* helper functions for importing */
>   struct drm_gem_object *drm_gem_prime_import_dev(struct drm_device *dev,
>   						struct dma_buf *dma_buf,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
