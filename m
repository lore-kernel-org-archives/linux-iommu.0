Return-Path: <SRS0=3/Zu=FA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A5DC64E75
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 11:44:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B937C20658
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 11:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nYGL5wwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B937C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 42CF3872B3;
	Thu, 26 Nov 2020 11:44:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tsbMGpKCXNGm; Thu, 26 Nov 2020 11:44:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C5E58871E1;
	Thu, 26 Nov 2020 11:44:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91EE5C0891;
	Thu, 26 Nov 2020 11:44:56 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 729B0C0052
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 11:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6EBE48774E
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 11:44:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QNmnvZ6IGZRi for <iommu@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 11:44:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com
 [209.85.215.195])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CEB7587734
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 11:44:53 +0000 (UTC)
Received: by mail-pg1-f195.google.com with SMTP id t37so1541798pga.7
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 03:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UpERwUmn/OuG9/9GiqizbXJDLzVxL1S8PfGCKpa9aUg=;
 b=nYGL5wwMzInwZKf69/TnCeMo02Cht0pAdcQoAUSgCVe5YzuaNqWcOj9BMSrJG11J2f
 KNcl4S4BCDyYQZ9xw4Y7s1+6wFphhly5hk8wMuIGqUaPzSzSN98tnParN/VVKeaQNJV1
 KhMm0oyRhW/8xPEbWsyFARG/ib75aDcW85H82wQyIIf/H75HSWxzBXzqqRPWQh1WqZcX
 iPdAS4W+W92oDObcecbFDg5zHufOPtH8/afpKxrogGEW3TTkAY+fxXaJ14gouOOTshdj
 lDZUplgZzM2IrqxRyA5OetWAyeNjvrdA+uf3NtbZL7nOSM1+RgxdRJ0hsNWi3qqnzHJX
 thgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UpERwUmn/OuG9/9GiqizbXJDLzVxL1S8PfGCKpa9aUg=;
 b=Y5VIIt10A4cQQRVgAeuya7XEqPvoyhHOR6dxA4ywI3gkA+cTfX00vjiud/CbOecYM5
 Y0dGpmJ/D7Es5IpJO0jvgMcAUdOrkleXpdHiVWySeCesB2OH6HBuhKkJ6W+nsjAeIU6v
 1Mw23jMlslsskiGDip1DWOlpMIS9lW3mVMZkoQyjD3rCkOVnp12U9AWyYGyWcebOVtSX
 9AUqnTcEcSCX/THhu0BjbvmYbojpVWMsyQHgiBJe9BwCkxkGuQtIvMCldkuLAH/0TGZf
 5bunrb6xDdi29RpDwlGvu0tgFXydW9xICzOAk48I1HXNKAAP+sa8PLdRseYWR2RzZ7qw
 8xxw==
X-Gm-Message-State: AOAM530maIzdX+FKqXs9rlaBwKHnwf1CISP+4x1g3ZSuVtblVgI2kVnd
 kHh4/uatc/0pH/LzUabHZYQ=
X-Google-Smtp-Source: ABdhPJw/1d59DXda0KuVqjExWVYT3bxoXf2mR5gIjPc+28YwR+iFHQlRFLWrBosK+geb9FM5JmT/vA==
X-Received: by 2002:a63:62c6:: with SMTP id w189mr2343708pgb.440.1606391093464; 
 Thu, 26 Nov 2020 03:44:53 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a6ae:11ff:fe11:4b46])
 by smtp.gmail.com with ESMTPSA id d15sm6575313pjr.27.2020.11.26.03.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2020 03:44:52 -0800 (PST)
Date: Thu, 26 Nov 2020 20:44:50 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: [PATCH v3 5/6] media: uvcvideo: Use dma_alloc_noncontiguos API
Message-ID: <20201126114450.GB3723071@google.com>
References: <20201125221917.150463-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201125221917.150463-1-ribalda@chromium.org>
Cc: Sergey Senozhatsky <senozhatsky@google.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
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

On (20/11/25 23:19), Ricardo Ribalda wrote:
[..]
> +	if (uvc_urb->pages)
> +		dma_sync_sgtable_for_device(stream_to_dmadev(uvc_urb->stream),
> +					    &uvc_urb->sgt, DMA_FROM_DEVICE);

[..]

> +	if (uvc_urb->pages)
> +		dma_sync_sgtable_for_cpu(stream_to_dmadev(stream),
> +					 &uvc_urb->sgt, DMA_FROM_DEVICE);

[..]

> +	uvc_urb->pages = dma_alloc_noncontiguous(dma_dev, stream->urb_size,
> +						 &uvc_urb->dma,
> +						 gfp_flags | __GFP_NOWARN, 0);

Do we need to pass __GFP_NOWARN? It seems that

dma_alloc_noncontiguous()
  __iommu_dma_alloc_noncontiguous()
    __iommu_dma_alloc_pages()

does this internally.

> +	if (!uvc_urb->pages)
> +		return false;
> +
> +	uvc_urb->buffer = vmap(uvc_urb->pages,
> +			       PAGE_ALIGN(stream->urb_size) >> PAGE_SHIFT,
> +			       VM_DMA_COHERENT, PAGE_KERNEL);

This is not related to Ricardo's patch, just a side note:

  I think VM_DMA_COHERENT needs to be renamed. I found it a bit confusing
  to see DMA_COHERENT mapping being dma_sync-ed. It turned out that the
  flag has different meaning.

	-ss
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
