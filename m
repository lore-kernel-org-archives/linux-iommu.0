Return-Path: <SRS0=jPbF=ND=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44B9C4338F
	for <iommu@archiver.kernel.org>; Thu, 12 Aug 2021 09:21:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 671FE60EB9
	for <iommu@archiver.kernel.org>; Thu, 12 Aug 2021 09:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 671FE60EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F101405EC;
	Thu, 12 Aug 2021 09:21:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PUNRICsdzATX; Thu, 12 Aug 2021 09:21:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E4FCD40540;
	Thu, 12 Aug 2021 09:21:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C28E1C001A;
	Thu, 12 Aug 2021 09:21:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 378ADC000E
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 09:21:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 273CF606BE
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 09:21:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=chromium.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NHy2nZsNf-PP for <iommu@lists.linux-foundation.org>;
 Thu, 12 Aug 2021 09:21:29 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 07F8F6066E
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 09:21:28 +0000 (UTC)
Received: by mail-qv1-xf35.google.com with SMTP id dt3so890806qvb.6
 for <iommu@lists.linux-foundation.org>; Thu, 12 Aug 2021 02:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SmZ+/nyBNyi7W1OAT4slsmhGWuIvjhgj8UeehGa0k/Y=;
 b=hVjYySTSr0mjWPr6vJnVDO+D69tCC702LiCJ7rDBEZ8U0jtHIsGHwHbhAUChGNDAQT
 OSReT1EQFc2WwI8Cf0k/ghW7OzOe19N/C1NkQCb0SsByX0aMrEBtVsUdHa+2KoC/+SF+
 dnayMuuUuEmRW/in/Hyw2px4iqdls/d/ae7u8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SmZ+/nyBNyi7W1OAT4slsmhGWuIvjhgj8UeehGa0k/Y=;
 b=ILAp2ifTnqvvDZFsjiaOWvUlaEg76YQITJPKObK83u27jk/wLfaZwq4ReNjt6TJCN8
 OkHeCtSJ4YV6TeN70bejF36G+fbKHxpioIJbOPgGsciIQjlJ5hcg8cIGFpxvgISwFajR
 DBgYWwFkI3r+bPKUzY1nczIWFtpthOUylVXfOHAwxVqGhyVyL9i0hKRImB7MRi352rYw
 Ew3jFiZoBsKN+QzObn2qSA4V9VcxZ0sf0D7aYuwRE9uID/Kq7Tc8krmBl/U2SQGYmB3i
 lcVFo6yoF5eY38CIhBLcOm+ELT6xEQohUPENfT4fhttT8/DpSiIy7+PkPdQRtezbU7zH
 8LHQ==
X-Gm-Message-State: AOAM531YfUtSn4R8+5cieT9w51/ZejJFoXCmqQFbqhAUk5ZQ0Tju1rXn
 yWcWKa6kd0FPDhXGLqbkvIhQa5cUUQmQYQAdTnzqvQ==
X-Google-Smtp-Source: ABdhPJzAD5fCBvwB9Laq4jiGcu6LVmTZWScIZ8Ggkj0igXEtHBmNYvtKbvo5AxQJ0QOBWO39LUPJr7M+FhPPk1ER2EM=
X-Received: by 2002:a05:6214:2247:: with SMTP id
 c7mr2902170qvc.52.1628760087852; 
 Thu, 12 Aug 2021 02:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210811024247.1144246-1-stevensd@google.com>
 <20210811024247.1144246-3-stevensd@google.com>
 <5b4fd891-a86a-42cd-5b69-bc08d351dd3a@arm.com>
In-Reply-To: <5b4fd891-a86a-42cd-5b69-bc08d351dd3a@arm.com>
From: David Stevens <stevensd@chromium.org>
Date: Thu, 12 Aug 2021 18:21:16 +0900
Message-ID: <CAD=HUj7RLtRkKwRHOAeuJXiiLp9WujOysYAoU0s2Nx5qR1_B7g@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] dma-iommu: fix arch_sync_dma for map
To: Robin Murphy <robin.murphy@arm.com>
Cc: open list <linux-kernel@vger.kernel.org>, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

On Thu, Aug 12, 2021 at 3:47 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-08-11 03:42, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > When calling arch_sync_dma, we need to pass it the memory that's
> > actually being used for dma. When using swiotlb bounce buffers, this is
> > the bounce buffer. Move arch_sync_dma into the __iommu_dma_map_swiotlb
> > helper, so it can use the bounce buffer address if necessary. This also
> > means it is no longer necessary to call iommu_dma_sync_sg_for_device in
> > iommu_dma_map_sg for untrusted devices.
> >
> > Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> >   drivers/iommu/dma-iommu.c | 16 +++++++---------
> >   1 file changed, 7 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 54e103b989d9..4f0cc4a0a61f 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -576,6 +576,9 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
> >               memset(padding_start, 0, padding_size);
> >       }
> >
> > +     if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>
> Make that an "else if" - otherwise you're just reintroducing the same
> thing that the third hunk is trying to clean up.

swiotlb_tbl_map_single only copies into the swiotlb buffer, it doesn't
do any architectural syncing. So this block is necessary in the
swiotlb case as well, for iommu_dma_map_page to work properly.

The third chunk is a separate optimization, so I'll split it out into
its own patch.

-David
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
