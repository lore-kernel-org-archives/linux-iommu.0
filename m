Return-Path: <SRS0=CZ1O=C7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1911C4727F
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 01:26:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F05B23A62
	for <iommu@archiver.kernel.org>; Tue, 22 Sep 2020 01:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJqhwKes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F05B23A62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 085F58720B;
	Tue, 22 Sep 2020 01:26:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NlAyaA+ot0eQ; Tue, 22 Sep 2020 01:26:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 09C7D870D6;
	Tue, 22 Sep 2020 01:26:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D2149C0889;
	Tue, 22 Sep 2020 01:26:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61DC4C0051
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 01:26:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 48D778705C
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 01:26:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S08q5yMWZQIL for <iommu@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 01:26:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 85A0A8710E
 for <iommu@lists.linux-foundation.org>; Tue, 22 Sep 2020 01:26:46 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id k18so1647060wmj.5
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 18:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EwkCPgCitGetW6yWn1orUd/9JWGX18dm0dessM84fGA=;
 b=XJqhwKesgxxoneddVSf20VBkrrsT0ax+8jpxfLfjlaRV9BbhWHgdo7GG11Y0hdcJwU
 3zPmfiFaA0hrmsx/VmHuBH6Ql2NzM+URt5nSUMkkiuLcL+yrdIiYdvKB2ajmf3hzQuZy
 uegahPiyv/X3TGiIIlTydmIdHOWYse8gSIBk+fEaqQVdVidjFBwbfYJA6QnYuaSuBWup
 JpvEWpcxUgC02W/tdj+oOWlcaXFczT0OX2bkigrhVKXN+QfUuVy9fxUta4xEExaYZp/Y
 gTng2uocepGvbf8hwarfezAFrMTVTQoxd03ouptRLZQZy0aiVlx9HhRymXIaPEDFYVLj
 2nBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EwkCPgCitGetW6yWn1orUd/9JWGX18dm0dessM84fGA=;
 b=ToXJyY/hBbWF7TBfxew52qmkxCK8Himu44oiStjE69iAA4zg+fsnbMOpG6bSWXxvmH
 +QDKQmZBQ6MWe+zYUaoKWmfB2z3RGmW8o2DthiTJNZxqn5WcL3UJw0+fwF1B7W0fJRzJ
 SDF+O0Hy3UbL3BBzbedWKpgmK7fx7E7VjF7GiUAYL7OZmfTVSxqOkkC3qJBNQLQZQGMj
 E/rSnmgMn/XlBg5e3SwdrjY9A5al276VVAeyP7favtjVUmKN7VJ37q2IRq+EPAIg1kma
 OGZ/RzuSTsaC/WqE8o4UCH7c9ldxg+iiwuDP5rWzAfxGx8SrieJ1zREglhL1j2fj8Aam
 /c6g==
X-Gm-Message-State: AOAM533ay2dnoubrqXvF5RxSScB+VjPJSNbmheH+yJGSYyBhZVGxSKS9
 Dbiur+a2mf/FtPDE+VOCHXG8oWPjQ3mi2YNlxpU=
X-Google-Smtp-Source: ABdhPJyX5IceDiEN7uurpddreCAjgBIWneUFzY3pSLOA9oYfNTQAt3JlP4q5FDqc7qs5jSI0oVWF6J0DVzpZ1VTocjE=
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr1800077wmg.164.1600738004991; 
 Mon, 21 Sep 2020 18:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200905200454.240929-1-robdclark@gmail.com>
 <20200921213054.GA4270@willie-the-truck>
In-Reply-To: <20200921213054.GA4270@willie-the-truck>
From: Rob Clark <robdclark@gmail.com>
Date: Mon, 21 Sep 2020 18:27:45 -0700
Message-ID: <CAF6AEGsMsarDGqYYLtkZMKHxKZKBsfZsByWit=vEsAoKXqs6UQ@mail.gmail.com>
Subject: Re: [PATCH v17 00/20] iommu/arm-smmu + drm/msm: per-process GPU
 pgtables
To: Will Deacon <will@kernel.org>
Cc: Wambui Karuga <wambui.karugax@gmail.com>, Hanna Hawa <hannah@marvell.com>,
 Akhil P Oommen <akhilpo@codeaurora.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, Eric Anholt <eric@anholt.net>,
 Thierry Reding <thierry.reding@gmail.com>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>,
 Emil Velikov <emil.velikov@collabora.com>, Rob Clark <robdclark@chromium.org>,
 Jonathan Marek <jonathan@marek.ca>, Ben Dooks <ben.dooks@codethink.co.uk>,
 Sibi Sankar <sibis@codeaurora.org>, Thierry Reding <treding@nvidia.com>,
 Brian Masney <masneyb@onstation.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Joerg Roedel <jroedel@suse.de>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Sharat Masetty <smasetty@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Douglas Anderson <dianders@chromium.org>,
 open list <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Shawn Guo <shawn.guo@linaro.org>,
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

On Mon, Sep 21, 2020 at 2:31 PM Will Deacon <will@kernel.org> wrote:
>
> On Sat, Sep 05, 2020 at 01:04:06PM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > NOTE: I have re-ordered the series, and propose that we could merge this
> >       series in the following order:
> >
> >        1) 01-11 - merge via drm / msm-next
> >        2) 12-15 - merge via iommu, no dependency on msm-next pull req
>
> Thanks, I've queued 12-15 in the smmu tree.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/updates
>

Thx, let me know if you are up for trying a post-rc1 pull req for
16-18 (plus Bjorn's series if it is reposted in time).. I can
certainly help rebase/wrangle patches if that helps.. otherwise we can
try for those next cycle

BR,
-R
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
