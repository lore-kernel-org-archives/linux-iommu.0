Return-Path: <SRS0=rc6t=FM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85F8C433FE
	for <iommu@archiver.kernel.org>; Tue,  8 Dec 2020 07:13:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E3323A75
	for <iommu@archiver.kernel.org>; Tue,  8 Dec 2020 07:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E3323A75
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B9B74877E5;
	Tue,  8 Dec 2020 07:13:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gdI7XgFbxvxk; Tue,  8 Dec 2020 07:13:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 17655872F1;
	Tue,  8 Dec 2020 07:13:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA625C0893;
	Tue,  8 Dec 2020 07:13:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F9E8C013B
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 07:13:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E8F728779D
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 07:13:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PWm8JuyCXVb0 for <iommu@lists.linux-foundation.org>;
 Tue,  8 Dec 2020 07:13:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3BB61872C8
 for <iommu@lists.linux-foundation.org>; Tue,  8 Dec 2020 07:13:24 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id 131so13027109pfb.9
 for <iommu@lists.linux-foundation.org>; Mon, 07 Dec 2020 23:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=xWmdWORP2xSA8SF/fBBpyGpTlHNeOKrylAwBcpLi8AI=;
 b=HWBopCdK/zYKNU9XaTrzy+MvtNpyCzBNPw+Hr87VL7ax98P0PaHHUB3zs5RMNX7zHk
 4TrRqWtPDyjZXCoHrQ9UVGcxOAO8JgmPGuWGifb8DUnD4ZRhCNeyZy4+rK57tubOe5bJ
 i0V5lBf891j+bWsiMGfTsYrwgmSt3efjd1iBNxQ06w8xK5G9Kmb3Q/hQ3TG+/mnXRBkD
 tEbPtduFckcWYZ/PEqAGU5KAt0t0pEuZ5Hg7F1fg7ADzL0BW2ezb9lWesvuOefxrY6+z
 Fi81gVrQVzuyYD+u/jNoPIBWqjwvjhlru/bwulBAWT8lUHF+bAeGj/a8cEK65NUd4NO6
 hkhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xWmdWORP2xSA8SF/fBBpyGpTlHNeOKrylAwBcpLi8AI=;
 b=LmI4RYD7b31hfVRcmJqcAytoezHLYzZuxOF34CJa5YsN/dxWJiY+4MdIjF0FW1LeZK
 KJOcuv6+Z8dZ0Uh1KPsNwmjRW9SdInh6NoTRJYKxDG9Mxdb+BK1mW3TfQ0gNt+BlMv3y
 LX22GiGoO6ZhYAVGe8prOxvXfwebPk3ITikoXYlVc02xEjSYXKuual3AvJHvzJXd4Awy
 YSrETb5U07AmFKp7uBKs6/tito+LgxSXKo27wnDS1lFOITeMBDV2UuBguirRGjxtg1Pd
 jKSIKeRgAgmMsPNv9CaHhQ+RSKGlIagRptPBVmWpTFk9xJi1HYlqyr/qOuZe7GUDhEBs
 xzXg==
X-Gm-Message-State: AOAM533SIGacx5T9gsxJJXoYmRygbixg4C9PpIjuzZhuceUBrpBEOw1h
 m841aOZCc4W81p4/DrLOSfw=
X-Google-Smtp-Source: ABdhPJwzvlkqPw8IlSOUgigm/jQwVrd9OMVHM0DBNKMKS8I45sshs8/gAeGFl1eTOVhtP+3DgSeZPg==
X-Received: by 2002:a63:b554:: with SMTP id u20mr21681043pgo.249.1607411603843; 
 Mon, 07 Dec 2020 23:13:23 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a6ae:11ff:fe11:4b46])
 by smtp.gmail.com with ESMTPSA id b14sm15074971pgj.9.2020.12.07.23.13.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Dec 2020 23:13:22 -0800 (PST)
Date: Tue, 8 Dec 2020 16:13:20 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Tomasz Figa <tfiga@chromium.org>, ". Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH v3 5/6] media: uvcvideo: Use dma_alloc_noncontiguos API
Message-ID: <20201208071320.GA1667627@google.com>
References: <20201125221917.150463-1-ribalda@chromium.org>
 <20201130083410.GD32234@lst.de>
 <20201201033658.GE3723071@google.com>
 <20201201144916.GA14682@lst.de>
 <CAAFQd5BBEbmENrrZ-vMK9cKOap19XWmfcxwrxKfjWx-wEew8rg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAAFQd5BBEbmENrrZ-vMK9cKOap19XWmfcxwrxKfjWx-wEew8rg@mail.gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@google.com>,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
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

On (20/12/08 13:54), Tomasz Figa wrote:
> 
> In any case, Sergey is going to share a preliminary patch on how the
> current API would be used in the V4L2 videobuf2 framework. That should
> give us more input on how such a helper could look.

HUGE apologies for the previous screw up! I replied in the
gmail web-interface and that did not work out as expected
(at all, big times).

I'm sorry about that!

Take two, no html this time around.

---

My current WIP (deep WIP) series can be found at [0]. The patch that adds new
DMA API support is at the head of the series [1]. New DMA API requires us to
have several internal videobuf2 API changes before we can proceed [2]: v4l2 and
videobuf2 core do not pass enough information to the vb2 allocators now. Previously,
if user space requests non-coherent allocation v4l2 would set queue dma_attr bit,
videobuf2 core would pass queue->dma_attrs to vb2 allocator, which would 
those dma_attrs for dma_alloc(). So everything was transparent (sort of). Since we
don't have that dma_attr flag anymore, there is no way for v4l2 to pass the request
information (coherent or non-coherent) to the vb2 allocator. Hence we need to rework
the vb2 allocator API. I currently pass vb2 pointer, but we decided to rework it again
and to pass dedicated VB2_ALLOC_FLAGS from the videobuf2 core to the 
allocator. This is still in my private tree and not completely ready, will push those
patches to github later.

Another thing to notice is that the new API requires us to have two execution branches
in allocators - one for the current API; and one for the new API (if it's supported and
if user-space requested non-coherent allocation).

[0] https://github.com/sergey-senozhatsky/linux-next-ss/commits/master
[1] https://github.com/sergey-senozhatsky/linux-next-ss/commit/a45f48b483daee59594c62e4aaf01790aab960c8
[2] https://github.com/sergey-senozhatsky/linux-next-ss/commit/b784145101c398da7fe9e2608b6001e58e05a9b5

	-ss
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
