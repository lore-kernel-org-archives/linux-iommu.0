Return-Path: <SRS0=Fz8+=DJ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4D8C35257
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 17:50:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AAE120758
	for <iommu@archiver.kernel.org>; Fri,  2 Oct 2020 17:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RJpr45/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AAE120758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 53D55868CE;
	Fri,  2 Oct 2020 17:50:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BrxeNnWDOgEx; Fri,  2 Oct 2020 17:50:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D86BA868C7;
	Fri,  2 Oct 2020 17:50:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDA8AC0889;
	Fri,  2 Oct 2020 17:50:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 898D2C0051
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 17:50:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 85DF9873C9
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 17:50:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a-Q9dw5WjuPz for <iommu@lists.linux-foundation.org>;
 Fri,  2 Oct 2020 17:50:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 927D3873C4
 for <iommu@lists.linux-foundation.org>; Fri,  2 Oct 2020 17:50:43 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id j2so2719407wrx.7
 for <iommu@lists.linux-foundation.org>; Fri, 02 Oct 2020 10:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=qAPpXyP2inoV5988zgEtk6OBNQO3398NaIIov4Pf6CQ=;
 b=RJpr45/4P2FGGNGEF9uVylMkqY1nCY362/Pe04N9/zLIkTKj6c8tlNLV0p5RD/a0TT
 Ty3+xJBDLUvDrEZAqV5tSAB08542QPBDKf/vqu2XDmGQ75qRztQF3N6COsP+/FvHxri2
 qdumrnufMfHTTgIumy0jLCxdGJjwz6xFIYUPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qAPpXyP2inoV5988zgEtk6OBNQO3398NaIIov4Pf6CQ=;
 b=QFMMTeMUq5mpYRCAFvzpf9ejnoDN8bzQudfuPpZ0+4Jb3caXKqv79u4YNA/tb4FTgQ
 vd5pgPme6P7595RC8lE++tmvl5D8KgqaPM9dYlN5fYemGSZTeFybtpYBS5Sslub+oD8R
 CGGyFdTlqgFaYWzvTXWGIKgGBVTxNBGYagywbfD6LkYXHxBZuM/VsjMekcJmgp1Zbg6f
 2/xnw/Q2ABWeOgzAtBUOc5DTcb4/JcfmAM2OP24pt0KHH6KbUcP0qeJn+A8tYUcTxdG4
 vGvvW6BrJMqwB+Svp5IJlYc/1AFStlG2N9A+0XnEbqGoajWMqR7GTgrHncs+VBN2V6nY
 gElg==
X-Gm-Message-State: AOAM533tdbicfJnaWAfSvZtV+ylVxwegoewxy9T5DyYa1swXV1EF7ufS
 CcHIyHu6sBPDS05YwkiYIBhXUg==
X-Google-Smtp-Source: ABdhPJxSyoTgiDrvz+UtW8zZTkuPjuaRZvm7GtOtIfqF/g+LFn4V8JKTG6/VT+K90I9I9WVVS78v7w==
X-Received: by 2002:a5d:4a49:: with SMTP id v9mr4667478wrs.153.1601661042072; 
 Fri, 02 Oct 2020 10:50:42 -0700 (PDT)
Received: from chromium.org (216.131.76.34.bc.googleusercontent.com.
 [34.76.131.216])
 by smtp.gmail.com with ESMTPSA id d19sm2604808wmd.0.2020.10.02.10.50.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2020 10:50:41 -0700 (PDT)
Date: Fri, 2 Oct 2020 17:50:40 +0000
From: Tomasz Figa <tfiga@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 8/8] WIP: add a dma_alloc_contiguous API
Message-ID: <20201002175040.GA1131147@chromium.org>
References: <20200930160917.1234225-1-hch@lst.de>
 <20200930160917.1234225-9-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200930160917.1234225-9-hch@lst.de>
Cc: linux-media@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
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

Hi Christoph,

On Wed, Sep 30, 2020 at 06:09:17PM +0200, Christoph Hellwig wrote:
> Add a new API that returns a virtually non-contigous array of pages
> and dma address.  This API is only implemented for dma-iommu and will
> not be implemented for non-iommu DMA API instances that have to allocate
> contiguous memory.  It is up to the caller to check if the API is
> available.

Would you mind scheding some more light on what made the previous attempt
not work well? I liked the previous API because it was more consistent with
the regular dma_alloc_coherent().

> 
> The intent is that media drivers can use this API if either:

FWIW, the USB subsystem also has similar needs, and so do some DRM drivers
using DMA API rather than IOMMU API directly. Basically I believe that all
the users removed in your previous series relied on custom downstream
patches to make DMA_ATTR_NON_CONSISTENT work and could be finally made work
in upstream using this API.

> 
>  - no kernel mapping or only temporary kernel mappings are required.
>    That is as a better replacement for DMA_ATTR_NO_KERNEL_MAPPING
>  - a kernel mapping is required for cached and DMA mapped pages, but
>    the driver also needs the pages to e.g. map them to userspace.
>    In that sense it is a replacement for some aspects of the recently
>    removed and never fully implemented DMA_ATTR_NON_CONSISTENT

What's the expected allocation and mapping flow with the latter? Would that be

pages = dma_alloc_noncoherent(...)
vaddr = vmap(pages, ...);

?

Would one just use the usual dma_sync_for_{cpu,device}() for cache
invallidate/clean, while keeping the mapping in place?

Best regards,
Tomasz
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
