Return-Path: <SRS0=1lY2=7I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B469C433DF
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 11:32:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 116A62073B
	for <iommu@archiver.kernel.org>; Tue, 26 May 2020 11:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="aGN8/fYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116A62073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B91EE883D7;
	Tue, 26 May 2020 11:32:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0-n9GG9zUTCc; Tue, 26 May 2020 11:32:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id ADD718837F;
	Tue, 26 May 2020 11:32:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94D00C088D;
	Tue, 26 May 2020 11:32:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 47840C016F
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 11:32:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 329CD88265
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 11:32:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gyfYv+C8dmvM for <iommu@lists.linux-foundation.org>;
 Tue, 26 May 2020 11:31:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com
 [209.85.210.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D1A2F87F5D
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 11:31:59 +0000 (UTC)
Received: by mail-ot1-f66.google.com with SMTP id d7so15951458ote.6
 for <iommu@lists.linux-foundation.org>; Tue, 26 May 2020 04:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=edTucrrhXN6V4llb+iJ6E89JH542mkCUYUO4cFFBSq8=;
 b=aGN8/fYlBZtC/O0HPJioAJDFXEl1EKIqh48gVGEseZge1RSD+6ZJ+Vd1Ygk7WsUiBQ
 2koLpbOnSxVT+v4ugow+jFX2DiKRsHvM/7p+yEm/ZUa0ijbY2x4j1GqJXf51BsbzMDnD
 BQSFbmNzjABlRFcmrqZN1EwG4aypCM6kLqRH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=edTucrrhXN6V4llb+iJ6E89JH542mkCUYUO4cFFBSq8=;
 b=X3i9bDMjSmD9qtsM4U8m9znlF5XBcR9p7in4CfJTLi5Erf5vXlEU/D17FZHgliIBaA
 HAL0t2Nq2YgdIx3+ZX53tBb7UH8z5KfvLz1JKX9tz2eTlfonobCWGE8PVE12jWU1LtXF
 elyOKBahKUUK6uEd1Q4xMYhm2IQtpHvNkfLWH8ArLCUbAagrJmHCrJI/f0/JYgX/x3EX
 Wf8KW3WKFED3SdQlSe05WZsZmxlxs9ZiXcO41nKm1SQr/c38V+8z1CyFWKDpJs83JEAk
 kOtyhcUnavSu5SbqS2s274BpHgA4udZfR9JHU6OBEyXrP2eqQ+D6Y9FdiYP0DkAUDqUd
 HWvA==
X-Gm-Message-State: AOAM531nVacsm/1pj3QCNxdFMyyyps+PTsOUcSLnj38TlbhHELMeOHS0
 yJ3UZcvWJ/W7yUxwpQ41fRSCCFBRZcwGXQc9QKqj5A==
X-Google-Smtp-Source: ABdhPJzCrvWpIr7oiZie/ZO14zr8xx2eKHZLh/b7YFaD0J7MeUVnKhbsTaugx/2157KZB7xg+CLgr312FbFucLK+W50=
X-Received: by 2002:a9d:600e:: with SMTP id h14mr497056otj.281.1590492719014; 
 Tue, 26 May 2020 04:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200513132127eucas1p23f6be10bbd627e69e36d2451068b3204@eucas1p2.samsung.com>
 <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513134741.GA12712@lst.de>
 <83d04017-c6f2-d714-963c-ffa9c7248790@samsung.com>
In-Reply-To: <83d04017-c6f2-d714-963c-ffa9c7248790@samsung.com>
From: Daniel Vetter <daniel@ffwll.ch>
Date: Tue, 26 May 2020 13:31:47 +0200
Message-ID: <CAKMK7uFkvhytb9vKng+2_LuaLFvnEB_5e2s5EAWnVgA9VjRwZA@mail.gmail.com>
Subject: Re: [PATCH v5 00/38] DRM: fix struct sg_table nents vs. orig_nents
 misuse
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Tue, May 26, 2020 at 9:01 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi
>
> On 13.05.2020 15:47, Christoph Hellwig wrote:
> > I've pushed out a branch with the first three patches here:
> >
> >     git://git.infradead.org/users/hch/dma-mapping.git dma-sg_table-helper
> >
> > Gitweb:
> >
> >     http://git.infradead.org/users/hch/dma-mapping.git/shortlog/refs/heads/dma-sg_table-helper
> >
> > and merged it into the dma-mapping for-next tree.  Unless someone shouts
> > the branch should be considered immutable in 24 hours.
>
> David & Daniel: could you merge all the DRM related changes on top of
> the provided branch? Merging those changes separately would take a lots
> of time because of the dependencies on the sgtable helpers and changes
> in the DRM core.

We generally freeze drm for big rework past -rc6 (small drivers tend
to be a bit later). I think simpler if we just land this in the merge
window and then smash the drm patches on top for 5.9 merge window.

Or all in in the same topic branch, but feels a bit late for that and
making sure nothing breaks.
-Daniel

>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
