Return-Path: <SRS0=qXOr=FH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A528DC63777
	for <iommu@archiver.kernel.org>; Thu,  3 Dec 2020 06:04:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02D3020643
	for <iommu@archiver.kernel.org>; Thu,  3 Dec 2020 06:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02D3020643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 477AC87737;
	Thu,  3 Dec 2020 06:04:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IqNuB1PiYHZy; Thu,  3 Dec 2020 06:04:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2CCEC87732;
	Thu,  3 Dec 2020 06:04:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13205C163C;
	Thu,  3 Dec 2020 06:04:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BA0BDC0FA7
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 06:04:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A18A18698F
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 06:04:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OG2PmmXoBBr5 for <iommu@lists.linux-foundation.org>;
 Thu,  3 Dec 2020 06:04:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com
 [209.85.167.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D149386909
 for <iommu@lists.linux-foundation.org>; Thu,  3 Dec 2020 06:04:38 +0000 (UTC)
Received: by mail-lf1-f67.google.com with SMTP id d8so1055384lfa.1
 for <iommu@lists.linux-foundation.org>; Wed, 02 Dec 2020 22:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i3ZfoIQ82MnzqWNj21WEZs0AiTW/X3VKZYL9qOBzRgs=;
 b=YFgtOCqB2A6PtCxXfCh6M5QEOENLm7BfWm2Nyefdv9JxgPtXzsoXlNpNv46ac+EPMq
 6J6RCQMObMO0ialqdGVwmkTKY1DzPHhuNzYZk8qh/FN7Cjh+rg8Zqi6JrB+6T4H/cXoq
 ICB5NWH1AsoMUv6ziWP1RKxQp+E+MWLy6+c+MkB/071xyR/IQfkCshhJZEmOVc8+AlcX
 Pk275wS4+JscXIxjyCmskZGskPdOPBRWn3MxwUBRLoQjxpKdQolavH9+nkoYj3JjBTL6
 dMVPZk/Q+rkMoqjMKsQTVWXFa1wf08p4oSREK0+2b83ksO7nJWHBw2QivtyByl2K6ZWK
 Vu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i3ZfoIQ82MnzqWNj21WEZs0AiTW/X3VKZYL9qOBzRgs=;
 b=OcNJ8vkkiQyatjCtXAGibyKdeRdXy25lygDRNLuAUGjdUg5rNf2S1V4laAj+obYwiX
 yl/9c44b2GSLbtRaLkVcvh4dDbbplWQgv3/EYsfn21PYeAilWQ0fzlxLw3WD9Axu3L6t
 lHNOTELrueSHjXFdxnMmtulonRCfM/I0ylh67HPk7g8Er7KI6hTPOJhqOmN/HyhbDs4B
 cTPHyTSNsQtpZniR5aEZMQXdIKFz9uyMWbJ8hl/pDjB7zjQAXRFJXEENJ4MXGjqA/I+r
 tgByazCGWuwjtaBgl4htdkjBA51RgGcCbOHX5uih0uRGgA2o2wsU39rucHKLI/sJhdsQ
 5LMA==
X-Gm-Message-State: AOAM53062UoTF/jGtbSFPKcqeIvLHfTaIvJgoXsyM7w88kH5zyDUXYiL
 cIO7Mt8Vnm0vxZ723PAfY8kjitQvHTCA/QAU9XI=
X-Google-Smtp-Source: ABdhPJzTaUsBKOp4Vl/7vi4gI+xBxp+p7JXFHLnQNo+zcr0STYerwcGp1HIU8c64plJToP1OFW8hByGcJ61lk9SSvhM=
X-Received: by 2002:ac2:550d:: with SMTP id j13mr652596lfk.301.1606975476894; 
 Wed, 02 Dec 2020 22:04:36 -0800 (PST)
MIME-Version: 1.0
References: <1605608734-84416-1-git-send-email-john.garry@huawei.com>
 <160685669713.992935.17438167536143205811.b4-ty@kernel.org>
In-Reply-To: <160685669713.992935.17438167536143205811.b4-ty@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 3 Dec 2020 06:04:25 +0000
Message-ID: <CAJwJo6YmF+tW2_it2BLCP6fLBrUR6kfx7jG0hsNy6uYG203Jfw@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/4] iommu/iova: Solve longterm IOVA issue
To: Will Deacon <will@kernel.org>
Cc: kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
 linuxarm@huawei.com, open list <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, xiyou.wangcong@gmail.com,
 robin.murphy@arm.com
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

On Tue, 1 Dec 2020 at 21:50, Will Deacon <will@kernel.org> wrote:
>
> On Tue, 17 Nov 2020 18:25:30 +0800, John Garry wrote:
> > This series contains a patch to solve the longterm IOVA issue which
> > leizhen originally tried to address at [0].
> >
> > A sieved kernel log is at the following, showing periodic dumps of IOVA
> > sizes, per CPU and per depot bin, per IOVA size granule:
> > https://raw.githubusercontent.com/hisilicon/kernel-dev/topic-iommu-5.10-iova-debug-v3/aging_test
> >
> > [...]
>
> Applied the final patch to arm64 (for-next/iommu/iova), thanks!
>
> [4/4] iommu: avoid taking iova_rbtree_lock twice
>       https://git.kernel.org/arm64/c/3a651b3a27a1

Glad it made in next, 2 years ago I couldn't convince iommu maintainer
it's worth it (but with a different justification):
https://lore.kernel.org/linux-iommu/20180621180823.805-3-dima@arista.com/

Thanks,
             Dmitry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
