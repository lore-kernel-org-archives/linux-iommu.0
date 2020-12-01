Return-Path: <SRS0=bYB5=FF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E51C64E7A
	for <iommu@archiver.kernel.org>; Tue,  1 Dec 2020 03:37:06 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B8B207DE
	for <iommu@archiver.kernel.org>; Tue,  1 Dec 2020 03:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xhga9YlK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B8B207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 18161873CF;
	Tue,  1 Dec 2020 03:37:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kJNTuAgpm+WE; Tue,  1 Dec 2020 03:37:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3CBB3872F1;
	Tue,  1 Dec 2020 03:37:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F214C0859;
	Tue,  1 Dec 2020 03:37:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 12D03C0052
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 03:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 064B68731A
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 03:37:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N6Uw0AH9OnWw for <iommu@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 03:37:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 74C5F872F1
 for <iommu@lists.linux-foundation.org>; Tue,  1 Dec 2020 03:37:01 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id iq13so383927pjb.3
 for <iommu@lists.linux-foundation.org>; Mon, 30 Nov 2020 19:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=NL582lgLVSi6KvAu9Utf9CebPYU3CkLIdkP46F4/+EA=;
 b=Xhga9YlKz842XlE+bb+SVEwobT1WQdwHoo7D7fOlF20D0+a3pLa7mD7wAMBsoNZD92
 uuQtPfpMZeW+IlOssf8/rWOw+QKg4PspN2T5/kdsgqzAFOZ/HTDb+IXKvmETtlQE+uV2
 lXobZ7ntNQW3D5X2jcCxlPBk3A7ivPUpAfZpczlDxl01oriyRBobJvB++T+NdzzoDFX7
 veXQz8MvK4l4UMZubI5hihJlJiCZ99c5RCXeBsHjgSAWU3w/C3tTOv0G4Nrm+05jAcQ5
 apm/NsHGqk7+d0Nsg27zQ1AjqTIesG3qtSe40lJruY1ZgMRjOr4KyeRX3RaEahrQ9fce
 rjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=NL582lgLVSi6KvAu9Utf9CebPYU3CkLIdkP46F4/+EA=;
 b=lLBpoVRIv1Ka2bSF4JQq9pMWAvof3ANXUGyhxpucPxDdxuSTUtZLdutirkyVsh1jdS
 7ee75fcEIPQViVDt3cl98mxgj45FGXNJL/H/HnulStUnsIbL7jE+dpVQqWcRM/w2eAoQ
 AzSZb+Fa1IUy9ibKWvhqRzrJwcTVCIixdGfkOVW1UjMkT6m1vY7One/A7sDl1qyhZ4QA
 AcpZ8lUnWgIUS1uL6fqwMh2Iz7Gm0eOPYtgEJwFN47lfdcTVY0fn59XxnJ3LV6N1aWGq
 Cnm2kzcXUsTpvcvxNNTAfAyiA9XyiDb7bNt8QT4apsASezhdebeUi4dWnsAzLvg03fDM
 6NdA==
X-Gm-Message-State: AOAM530DbUohrpOlaNnEgoSlizZn0l6chH36v7sSThcPqEIp2nXDv2PO
 fmrd85My6WZY08sJ8bTz5JA=
X-Google-Smtp-Source: ABdhPJzmYqh8DitkJm6pCCwff8gLw1CZT70pu7CE5gBkghmKUNChEaqVJDkSnRtWr2lmiD9MQutdvA==
X-Received: by 2002:a17:90a:c003:: with SMTP id
 p3mr600818pjt.221.1606793820977; 
 Mon, 30 Nov 2020 19:37:00 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a6ae:11ff:fe11:4b46])
 by smtp.gmail.com with ESMTPSA id w131sm489881pfd.14.2020.11.30.19.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Nov 2020 19:37:00 -0800 (PST)
Date: Tue, 1 Dec 2020 12:36:58 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 5/6] media: uvcvideo: Use dma_alloc_noncontiguos API
Message-ID: <20201201033658.GE3723071@google.com>
References: <20201125221917.150463-1-ribalda@chromium.org>
 <20201130083410.GD32234@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201130083410.GD32234@lst.de>
Cc: Sergey Senozhatsky <senozhatsky@google.com>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Ricardo Ribalda <ribalda@chromium.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
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

On (20/11/30 09:34), Christoph Hellwig wrote:
> 
> > +	uvc_urb->pages = dma_alloc_noncontiguous(dma_dev, stream->urb_size,
> > +						 &uvc_urb->dma,
> > +						 gfp_flags | __GFP_NOWARN, 0);
> > +	if (!uvc_urb->pages)
> > +		return false;
> > +
> > +	uvc_urb->buffer = vmap(uvc_urb->pages,
> > +			       PAGE_ALIGN(stream->urb_size) >> PAGE_SHIFT,
> > +			       VM_DMA_COHERENT, PAGE_KERNEL);
> > +	if (!uvc_urb->buffer) {
> > +		dma_free_noncontiguous(dma_dev, stream->urb_size,
> > +				       uvc_urb->pages, uvc_urb->dma);
> > +		return false;
> > +	}
> > +
> > +	if (sg_alloc_table_from_pages(&uvc_urb->sgt, uvc_urb->pages,
> > +				PAGE_ALIGN(stream->urb_size) >> PAGE_SHIFT, 0,
> > +				stream->urb_size, GFP_KERNEL)) {
> > +		vunmap(uvc_urb->buffer);
> > +		dma_free_noncontiguous(dma_dev, stream->urb_size,
> > +				       uvc_urb->pages, uvc_urb->dma);
> > +		return false;
> > +	}
> 
> I wonder if we should lift this into a helper.  On the one hand I had
> proliferating struct scatterlist usage, on the other hand it is all over
> the media and drm code anyway, and duplicating this doesn't help anyone.

Not that I have any sound experience in this area, but the helper
probably won't hurt. Do you also plan to add vmap() to that helper
or dma_alloc_noncontiguous()/sg_alloc_table_from_pages() only?

	helper()
	{
		dma_alloc_noncontiguous();
		sg_alloc_table_from_pages();

		if ((dma_attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0)
			vmap();
	}

videobuf2-dma-contig still has to carry around two versions: one that
deals with the noncontig pages and sgt (new API); and the current one.
But if the helper will include fallback to coherent allocations then
this may change, depending on the helper implementation.

	-ss
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
