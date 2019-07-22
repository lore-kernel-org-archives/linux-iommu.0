Return-Path: <SRS0=E6XH=VT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27F1C76190
	for <iommu@archiver.kernel.org>; Mon, 22 Jul 2019 18:45:37 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82CAA21955
	for <iommu@archiver.kernel.org>; Mon, 22 Jul 2019 18:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82CAA21955
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5E18CE55;
	Mon, 22 Jul 2019 18:45:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D46D5E46
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Jul 2019 18:45:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com
	[209.85.217.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 5DEA27F8
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Jul 2019 18:45:26 +0000 (UTC)
Received: by mail-vs1-f68.google.com with SMTP id a186so25327532vsd.7
	for <iommu@lists.linux-foundation.org>;
	Mon, 22 Jul 2019 11:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to;
	bh=0oC255nlMTJCbfZqi2fsaWmaMOyLtXK3narxYZHsJ+g=;
	b=mU+v1LEmfzARkWP0jOP+nBsifj3D/03h1xsE3S3hge4frfAexkU8UnaTQNoQ/MyGYM
	HLEmNwYiH81OjdY1k4OOBi9m5WSk73gVh88QX8scPfYS9FN9/ILUrEKOx777BLrxXvNV
	CBb5MvO/PZxHI8PisrKP7OV8xnwMZJx2Pq+yXfvn4evhuwM6ziz/NgCS9edrHbF+uV8J
	aWMGpA863yd4C0tDv4NbAvqQ9/reQQ8ZXNdYESzD7he2/lVuiRxMWvsZGfVQVlaQT/wK
	7SP89sRGe+3P0FLzOgOzryIrjp5UWhOa12XSQMgpjnGDZNs6fBGA+P4RhJC10Ip8Rokx
	fokQ==
X-Gm-Message-State: APjAAAXquD9me0h/eX5UD5kk45KWohVta2rK9cEGLfj5ks4Ca8xi1udi
	52ExOz663r31EkR/p2GSMz413Q==
X-Google-Smtp-Source: APXvYqy1dMOsoJwK19xN4gvienu0+UYNi8SU4/cq7VQCMGv+XWMnqskbibzUi+xg/xwOJYk7B7n4Xw==
X-Received: by 2002:a67:7a11:: with SMTP id v17mr45678796vsc.114.1563821125566;
	Mon, 22 Jul 2019 11:45:25 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
	by smtp.gmail.com with ESMTPSA id
	u8sm15327600vke.34.2019.07.22.11.45.21
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 22 Jul 2019 11:45:24 -0700 (PDT)
Date: Mon, 22 Jul 2019 14:45:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v2] dma-mapping: Use dma_get_mask in dma_addressing_limited
Message-ID: <20190722143724-mutt-send-email-mst@kernel.org>
References: <20190722165149.3763-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190722165149.3763-1-eric.auger@redhat.com>
Cc: jasowang@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	iommu@lists.linux-foundation.org, eric.auger.pro@gmail.com,
	robin.murphy@arm.com, hch@lst.de
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

On Mon, Jul 22, 2019 at 06:51:49PM +0200, Eric Auger wrote:
> We currently have cases where the dma_addressing_limited() gets
> called with dma_mask unset. This causes a NULL pointer dereference.
> 
> Use dma_get_mask() accessor to prevent the crash.
> 
> Fixes: b866455423e0 ("dma-mapping: add a dma_addressing_limited helper")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

If possible I really prefer this approach: avoids changing all callers
and uses documented interfaces.

> ---
> 
> v1 -> v2:
> - was [PATCH 1/2] dma-mapping: Protect dma_addressing_limited
>   against NULL dma_mask
> - Use dma_get_mask
> ---
>  include/linux/dma-mapping.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index e11b115dd0e4..f7d1eea32c78 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -689,8 +689,8 @@ static inline int dma_coerce_mask_and_coherent(struct device *dev, u64 mask)
>   */
>  static inline bool dma_addressing_limited(struct device *dev)
>  {
> -	return min_not_zero(*dev->dma_mask, dev->bus_dma_mask) <
> -		dma_get_required_mask(dev);
> +	return min_not_zero(dma_get_mask(dev), dev->bus_dma_mask) <
> +			    dma_get_required_mask(dev);
>  }
>  
>  #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
> -- 
> 2.20.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
