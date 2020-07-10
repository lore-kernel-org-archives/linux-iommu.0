Return-Path: <SRS0=wTTv=AV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBAEC433E0
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 19:48:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595CB20748
	for <iommu@archiver.kernel.org>; Fri, 10 Jul 2020 19:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="G8ptAYtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595CB20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tcd.ie
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2971F2048D;
	Fri, 10 Jul 2020 19:48:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9i55hJQsEuVD; Fri, 10 Jul 2020 19:48:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 40BB720475;
	Fri, 10 Jul 2020 19:48:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25D0EC0890;
	Fri, 10 Jul 2020 19:48:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33403C016F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 19:48:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 31CF4875A8
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 19:48:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KTl5hpm2EKCH for <iommu@lists.linux-foundation.org>;
 Fri, 10 Jul 2020 19:48:09 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5AAC88551F
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 19:48:09 +0000 (UTC)
Received: by mail-qk1-f195.google.com with SMTP id j80so6472279qke.0
 for <iommu@lists.linux-foundation.org>; Fri, 10 Jul 2020 12:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tcd-ie.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A/XxOf2MPny3gUO9mnh1IW4HAphuhFeUQbRFZXAvCpM=;
 b=G8ptAYtqk+SEo+CGoUOHZRF+vl7lJLdIBT0S/pHrduzEbWxvqh1IfPE2/4VhppHPde
 YRXFOyzoKkrWceSDyBehaHWrFlUcgXHG6dZJw/Ckmn9tJWTq/vXETO0JL2rxorvAqYgr
 sfYAe5TLkNk/6oh5kEcCbqnW3iSm0YxUhQvE7I1A5yKSuwuC4rUGD6Q7HEO+tu1wAlSl
 tD0rGE8wl+/tQgRZmMsrGa6EwlUhvHi7G/Qlh1O3Vt+4ehxXhBo8td3OJyHLYU9R9Rnm
 rBv1SJmQ77C6sJHC+gp5sx/9NhXLg9ziLq8flwiewQDJ8rwiHelTeKULpgwtJnZC8Zqx
 8ynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A/XxOf2MPny3gUO9mnh1IW4HAphuhFeUQbRFZXAvCpM=;
 b=aj/6W4UG+dqgKkXr1dbwUNhBl/GXxKzNfcpLVCyJPNYpS13E7Vmz1z9rnIbrquo+Sw
 oDeFV9QXpdKyFQLF9FSp9fFAO4x4Q9QSUuUV8R5mxR9T3fS3/xzzfr3UhM6SYg/kk4Y2
 zazoFZNrvJ/aZm1oftn3a2IWpRrIi/sqOfV6iqpsP2BKsm+Jq+m3t7ZIk9pShAgQrI/q
 zvkADSjbAxf/1rITSzMltKinybkj2qduHwk/pZVzFVCv0r6MC/8b3nuRz1gmosGl8Fn5
 ofXhpQuEMhUAZmUUdprojwvw6tQJ+FMfq2RKLPI5EDN8iNLhWu4Fl2p4LqmmpdqS5LXn
 NWuA==
X-Gm-Message-State: AOAM532jmkGqoXDQxkQ/nhzElvkWeZ4iGMV4ZoXkkE/Z36q3Hqby9Lgs
 +Fa0v21yE67j7V7OzJCzAd9ptJeEPdbdzeHF7N4Z7CouXJkr9A==
X-Google-Smtp-Source: ABdhPJxMIWGB7DkTs3ZmaVNfNrJhTVDywQypoX4jJyE5KKI9jPnWPX+st4yY6PAU87KCAHCqBg6cegX8IfVhneQ5zK4=
X-Received: by 2002:a05:6638:2172:: with SMTP id
 p18mr81169397jak.63.1594408706326; 
 Fri, 10 Jul 2020 12:18:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190908165642.22253-1-murphyt7@tcd.ie>
 <20190908165642.22253-5-murphyt7@tcd.ie>
 <20200710155933.GA20886@lst.de>
In-Reply-To: <20200710155933.GA20886@lst.de>
From: Tom Murphy <murphyt7@tcd.ie>
Date: Fri, 10 Jul 2020 12:18:15 -0700
Message-ID: <CALQxJuumgH9xR-J1Nj3LQsLW6k+4ie_0Ho3N9UJiN4R0JBGYoQ@mail.gmail.com>
Subject: Re: [PATCH V6 4/5] iommu/dma-iommu: Use the dev->coherent_dma_mask
To: Christoph Hellwig <hch@lst.de>
Cc: Heiko Stuebner <heiko@sntech.de>, virtualization@lists.linux-foundation.org,
 linux-tegra@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>,
 Will Deacon <will@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>,
 Gerald Schaefer <gerald.schaefer@de.ibm.com>, linux-s390@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Kukjin Kim <kgene@kernel.org>, Robin Murphy <robin.murphy@arm.com>
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

>Btw, what is the current state of converting intel-iommu to the dma-iommu

These changes expose a bug in the i915 intel driver which hasn't been
fixed yet. I don't think anyone is actively working on it but I plan
on merging as many patches as I can so it's easier to do the
intel-iommu -> dma-iommu conversion once the bug is fixed.

You can read more about it here:
https://patchwork.kernel.org/cover/11306999/

On Fri, 10 Jul 2020 at 08:59, Christoph Hellwig <hch@lst.de> wrote:
>
> Btw, what is the current state of converting intel-iommu to the dma-iommu
> code?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
