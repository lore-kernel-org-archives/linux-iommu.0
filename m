Return-Path: <SRS0=PRYs=65=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF63C433DF
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 10:14:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C9942073E
	for <iommu@archiver.kernel.org>; Fri, 15 May 2020 10:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaVbI4u7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9942073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D9F8C88D9A;
	Fri, 15 May 2020 10:14:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 16Fcy5hlt64F; Fri, 15 May 2020 10:13:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 502CA88D5C;
	Fri, 15 May 2020 10:13:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44A3CC0178;
	Fri, 15 May 2020 10:13:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9668FC016F
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 10:13:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 857DD87B99
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 10:13:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yJxwgoghZET0 for <iommu@lists.linux-foundation.org>;
 Fri, 15 May 2020 10:13:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 0A25087B83
 for <iommu@lists.linux-foundation.org>; Fri, 15 May 2020 10:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589537634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jyQOE3+SkaVkSO/7md1YvnjZQrQMGjMiOYyHXoqnMIo=;
 b=FaVbI4u7RuPhAyxAg6C/rmQnchAv+EcQ1TgYuOrt9SrfhpddBMUPGHjxbGLfzhnC7pNhYH
 oZFJCk45QZOVWo0tFWvi+TPjCpJ6gZa+/pV1fYcfVTRk6Q/YUNDxeWLf3yVNJE/z7WTzaD
 1tEDoDg/Lv4ZuOWz3nOst/kppVMhOXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-w3BMy0_SM1mEjilMgqtsgA-1; Fri, 15 May 2020 06:13:50 -0400
X-MC-Unique: w3BMy0_SM1mEjilMgqtsgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBF8A18FE863;
 Fri, 15 May 2020 10:13:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A9535F72E;
 Fri, 15 May 2020 10:13:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 484C416E16; Fri, 15 May 2020 12:13:47 +0200 (CEST)
Date: Fri, 15 May 2020 12:13:47 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v5 30/38] dmabuf: fix common struct sg_table related issues
Message-ID: <20200515101347.sbdiriypovujohkm@sirius.home.kraxel.org>
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133318eucas1p1dd6c1ac6a777874c115070d8b5197f34@eucas1p1.samsung.com>
 <20200513133245.6408-30-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200513133245.6408-30-m.szyprowski@samsung.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Sumit Semwal <sumit.semwal@linaro.org>,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux-foundation.org,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
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

> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index acb26c6..89e293b 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -63,10 +63,9 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
>  					GFP_KERNEL);
>  	if (ret < 0)
>  		goto err;
> -	if (!dma_map_sg(dev, sg->sgl, sg->nents, direction)) {
> -		ret = -EINVAL;
> +	ret = dma_map_sgtable(dev, sg, direction, 0);
> +	if (ret < 0)
>  		goto err;
> -	}
>  	return sg;
>  
>  err:
> @@ -78,7 +77,7 @@ static struct sg_table *get_sg_table(struct device *dev, struct dma_buf *buf,
>  static void put_sg_table(struct device *dev, struct sg_table *sg,
>  			 enum dma_data_direction direction)
>  {
> -	dma_unmap_sg(dev, sg->sgl, sg->nents, direction);
> +	dma_unmap_sgtable(dev, sg, direction, 0);
>  	sg_free_table(sg);
>  	kfree(sg);
>  }

Easy straightforward conversation.

Acked-by: Gerd Hoffmann <kraxel@redhat.com>

take care,
  Gerd

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
