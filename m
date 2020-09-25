Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE48DC4727F
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 21:23:33 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 775E321D7F
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 21:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oh/rOaeX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775E321D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id ED6052E193;
	Fri, 25 Sep 2020 21:23:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dr-yPfAA64Im; Fri, 25 Sep 2020 21:23:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D598920482;
	Fri, 25 Sep 2020 21:23:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C79E2C0859;
	Fri, 25 Sep 2020 21:23:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9BD09C0051
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 21:23:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 83F73869A7
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 21:23:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K0D9GL0um7x3 for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 21:23:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id B2C69866D9
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 21:23:26 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id g4so5379465wrs.5
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 14:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xu3WUdYX5svcbV4xrw1b6YX5aAbNB7AgpH2Adx4jZFo=;
 b=Oh/rOaeXFzcu9qSAmCq/rolkH8P14hud6p8K5BfNI2WFG5a9+CDyEGSSQhX2ckSOFm
 zhaUJj91cpSE7fjOgEU1lXwLJ+IWz8fvIt0d9ZLig66lfafGswbdX3HjuUIetLcvXIRK
 iTH/uLltlOJ4fw+ePue65S94O7opuSVXxQHSpsONmulokYemM7SGq9yQ+hWEmXvhV86F
 z03M9NhNkvuyYCe3g7sBFrF7SAacgZVx0Vpqiomtz+6y2XL78RtnxnguoI2dZ69jA0P6
 sb1aT7CbUe0tNayEoXajWXtZalCNyj5M83zbwKR5M/a2WvCpOpF2gPQoaJNqY08mROL1
 4Blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xu3WUdYX5svcbV4xrw1b6YX5aAbNB7AgpH2Adx4jZFo=;
 b=pgX7eb7TbQmsQ5y7kfsnlJD3oNl56feiNeuwjqXbG6aJKxU6QkBjFWdAMQMZRPKanC
 Oj/NLn1rvlmlfbiJANZN8U9VPfsHaJuLHPzO0gkhjhb5X8GTlyLHyr5dH94a6mIt5YSP
 Y8CUJpELW2oYUxj7QC+AycdMkHZcH5g6JIa88FA/gu/VuQDxKqIfDc8nUGGt09M7EIV/
 7LgKMe8gfqZdJtMHpr90kHGeS6v7cR4q/SC/kgH366A063lC4WSZfJ2frt3/sPe6YWAu
 XHkV2q8CsZDjdJDxMXmtma5Q7dhENJaGbir9reUiNcqFawKuQWWhTmxw7QQe7LELD59v
 PHmg==
X-Gm-Message-State: AOAM532KiJSPXjgrF/OTD5/IIlfoM0uIUO3dIOyswsodx7NrWcfLucDz
 yn0T+D1eS+PZpsaL4XXtu1oOCMgXd+YeOjmCfnI=
X-Google-Smtp-Source: ABdhPJwCPyTdQSA04vqPSfWKSY3pipKmyGpRObz8EdYnATmeFvpcGyznCvz/MGH6xrabFJhMlum7YCBfq8aVNQdHzTI=
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr6384708wrr.111.1601069005049; 
 Fri, 25 Sep 2020 14:23:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133259eucas1p273f0e05005b7b1158d884295d35745fd@eucas1p2.samsung.com>
 <20200513133245.6408-5-m.szyprowski@samsung.com>
 <alpine.DEB.2.20.2009211803580.19454@agoins-DiGiTS>
 <afb59d1b-1fcf-fd6d-2b48-e078e129f1eb@samsung.com>
In-Reply-To: <afb59d1b-1fcf-fd6d-2b48-e078e129f1eb@samsung.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 25 Sep 2020 17:23:14 -0400
Message-ID: <CADnq5_OP4pEg7Cg9E=TUB0viSX8rTALQoFck=ueTh=phTtUfEA@mail.gmail.com>
Subject: Re: [Linaro-mm-sig] [PATCH v5 05/38] drm: prime: use sgtable
 iterators in drm_prime_sg_to_page_addr_arrays()
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Alex Goins <agoins@nvidia.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Tue, Sep 22, 2020 at 2:28 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Alex,
>
> On 22.09.2020 01:15, Alex Goins wrote:
> > Tested-by: Alex Goins <agoins@nvidia.com>
> >
> > This change fixes a regression with drm_prime_sg_to_page_addr_arrays() and
> > AMDGPU in v5.9.
>
> Thanks for testing!
>
> > Commit 39913934 similarly revamped AMDGPU to use sgtable helper functions. When
> > it changed from dma_map_sg_attrs() to dma_map_sgtable(), as a side effect it
> > started correctly updating sgt->nents to the return value of dma_map_sg_attrs().
> > However, drm_prime_sg_to_page_addr_arrays() incorrectly uses sgt->nents to
> > iterate over pages, rather than sgt->orig_nents, resulting in it now returning
> > the incorrect number of pages on AMDGPU.
> >
> > I had written a patch that changes drm_prime_sg_to_page_addr_arrays() to use
> > for_each_sgtable_sg() instead of for_each_sg(), iterating using sgt->orig_nents:
> >
> > -       for_each_sg(sgt->sgl, sg, sgt->nents, count) {
> > +       for_each_sgtable_sg(sgt, sg, count) {
> >
> > This patch takes it further, but still has the effect of fixing the number of
> > pages that drm_prime_sg_to_page_addr_arrays() returns. Something like this
> > should be included in v5.9 to prevent a regression with AMDGPU.
>
> Probably the easiest way to handle a fix for v5.9 would be to simply
> merge the latest version of this patch also to v5.9-rcX:
> https://lore.kernel.org/dri-devel/20200904131711.12950-3-m.szyprowski@samsung.com/
>
>
> This way we would get it fixed and avoid possible conflict in the -next.
> Do you have any AMDGPU fixes for v5.9 in the queue? Maybe you can add
> that patch to the queue? Dave: would it be okay that way?

I think this should go into drm-misc for 5.9 since it's an update to
drm_prime.c.  Is that patch ready to merge?
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
> _______________________________________________
> Linaro-mm-sig mailing list
> Linaro-mm-sig@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/linaro-mm-sig
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
