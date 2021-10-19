Return-Path: <SRS0=0fjx=PH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D78C433EF
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 19:57:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52EBD610CC
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 19:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 52EBD610CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C62960A49;
	Tue, 19 Oct 2021 19:57:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tdhD_TgNiY6M; Tue, 19 Oct 2021 19:57:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 14FC560886;
	Tue, 19 Oct 2021 19:57:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5DDAC0011;
	Tue, 19 Oct 2021 19:57:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB43CC000D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 19:57:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id AC17D402B6
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 19:57:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=google.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QzF9J1LlMQ4K for <iommu@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 19:57:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C6E3400E7
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 19:57:53 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id
 nn3-20020a17090b38c300b001a03bb6c4ebso777861pjb.1
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 12:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:in-reply-to:message-id:references
 :mime-version; bh=RlOfhqZOeIlYyON71bYTz5/GFP47325drgTt8RSwEno=;
 b=cRtG2LMW7JoH5dabE38+V1teGIRxs1h5XgXxNj5F46z/Tu/J2eJnspsr+sVG/LPSCY
 ztiPZfT3tTlA4agk1p7hq16btX2WdMBn7abo4lWDFmRJfgaF2MaUJIS08c/6MeFkhBcq
 SAtdrrfOyjJ+2J6rbyQ9JMAdsu7kOn0a6NWI0Qg0BtAGidWjeCR4WA5LSY+uv1QFMYdf
 WUp2cBdk+hOk0QFwZc6rA660zrYylHoRtvncOUK4DJH0SYMla6PI9VzMG80FzchlAZBS
 VEUFDQ2Y/suFoPCjAlBjf5Sg4y5w3Ebc6prIWoywWM4b0ASX0g2g2Tq/N5GIzc+glb6l
 zuiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
 :references:mime-version;
 bh=RlOfhqZOeIlYyON71bYTz5/GFP47325drgTt8RSwEno=;
 b=T7EP1LWv99atFvRF1CCdCr/95otzz3N+p3hjWAc1PCNNTruW/LIeunpiH3mZpc7mNH
 ME12n2iXfsqsO4G9WRCZEkvc14zbZz39qJaUwpWor/3zrU4vckA6pwp4SXl3+X7zWdpE
 bWd38ebCitbXaGp1Q7QicBZS+h9Z653R+6Bg5b1mpYLDl5pwn70msuoh5uDNVKQJJsLc
 yM3FwXupm5/RFCQ+KLXy8co7l6XFucK9zfSqdtgK3xyIwK9IGxONIa0CPS1lVjelQd7e
 olEbmGc/Ld9KIClcc3m8Itv+3FP3Sq8ejXzRhYvhbJQInl/W3EBvriiZb9Jt8Bo7NCi+
 9MZg==
X-Gm-Message-State: AOAM530b98q6jj0GlLFh58U5gcvhlHhfxSunQRThF2rb4yeIkMPm0WsK
 xTBRQMtzx9Kld6fdDsFjRdCMBQ==
X-Google-Smtp-Source: ABdhPJx4fFf2YxsdOA6ESC1SRpIyjznDIr5copYJgEOOeu4Vyh4yDmaEnsbywVzi77OV98EPFwNFYw==
X-Received: by 2002:a17:90b:251:: with SMTP id
 fz17mr2195626pjb.52.1634673473401; 
 Tue, 19 Oct 2021 12:57:53 -0700 (PDT)
Received: from [2620:15c:17:3:346:b4cf:84da:678d]
 ([2620:15c:17:3:346:b4cf:84da:678d])
 by smtp.gmail.com with ESMTPSA id om5sm4396pjb.36.2021.10.19.12.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 12:57:52 -0700 (PDT)
Date: Tue, 19 Oct 2021 12:57:52 -0700 (PDT)
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 4/4] dma-direct: factor out a helper for
 DMA_ATTR_NO_KERNEL_MAPPING allocations
In-Reply-To: <20211019122916.2468032-5-hch@lst.de>
Message-ID: <13523682-5fbc-d6ea-c1ed-13946e26524b@google.com>
References: <20211019122916.2468032-1-hch@lst.de>
 <20211019122916.2468032-5-hch@lst.de>
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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
From: David Rientjes via iommu <iommu@lists.linux-foundation.org>
Reply-To: David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, 19 Oct 2021, Christoph Hellwig wrote:

> Split the code for DMA_ATTR_NO_KERNEL_MAPPING allocations into a separate
> helper to make dma_direct_alloc a little more readable.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David Rientjes <rientjes@google.com>

(I think my name got mangled in your To: field on the original emails :)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
