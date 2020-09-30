Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E18C47420
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 14:45:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E4420789
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 14:45:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULFKs8MY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E4420789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 10B50871DF;
	Wed, 30 Sep 2020 14:45:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m6VO5q+dxTpC; Wed, 30 Sep 2020 14:45:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8420385E3A;
	Wed, 30 Sep 2020 14:45:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6227CC016F;
	Wed, 30 Sep 2020 14:45:29 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AB69FC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 14:45:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9EBCA20365
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 14:45:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PgvUXecIxMFj for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 14:45:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by silver.osuosl.org (Postfix) with ESMTPS id 0398E20337
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 14:45:28 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5C7A820789
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 14:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601477127;
 bh=uitBVKzK5eSn73NODN0g6lArFVEY6TVlvPfSJuwxRog=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ULFKs8MYBPpiqQu9MBrLsNEHx/tm50uUej7Oti/iYe0yc1Wmcsal4PX8aWnJ4XD96
 6Jd91IncKleF/Z9bSvRxgYWR8bx2aFpDQn6W1PUnr34P/6UEO9p/yk0w3IkTKUbF9Z
 9nEQ2FHAAVO7vXhS6OvEE4pyR++fZ5e6EicOi2nc=
Received: by mail-ed1-f47.google.com with SMTP id e22so2142214edq.6
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 07:45:27 -0700 (PDT)
X-Gm-Message-State: AOAM531t+9uEleHKCBR1LhOGd7U5Ol7dDwtEZmsLAuNDZQVyrVBKf591
 eoZkvGVtygZsVWQblQ0tlOyEbs8mdlG+HroreAI=
X-Google-Smtp-Source: ABdhPJzAYe0nAYLDdCHSY4Z+CtKlLw49Vw78B00scxZ8PBmBf3t4Ca/lTesoegejXmkdHGsdERiqGGLJZbHQ8XRJMPY=
X-Received: by 2002:a50:e78f:: with SMTP id b15mr3191569edn.104.1601477125978; 
 Wed, 30 Sep 2020 07:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200930084258.25493-1-nicoleotsuka@gmail.com>
 <20200930084258.25493-2-nicoleotsuka@gmail.com>
 <f9712d4c-8497-ca84-0d8a-d33eb6abc513@gmail.com>
In-Reply-To: <f9712d4c-8497-ca84-0d8a-d33eb6abc513@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 30 Sep 2020 16:45:13 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfbCRDY7TUZ4HXphrd6boWYEKb_DMOxth3ucPTB2UCUtw@mail.gmail.com>
Message-ID: <CAJKOXPfbCRDY7TUZ4HXphrd6boWYEKb_DMOxth3ucPTB2UCUtw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] memory: tegra: Add
 devm_tegra_get_memory_controller()
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, jonathanh@nvidia.com,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org
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

On Wed, 30 Sep 2020 at 16:41, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> ...
> > +struct tegra_mc *devm_tegra_get_memory_controller(struct device *dev)
> > +{
> > +     struct platform_device *pdev;
> > +     struct device_node *np;
> > +     struct tegra_mc *mc;
> > +     int err;
> > +
> > +     np = of_find_matching_node_and_match(NULL, tegra_mc_of_match, NULL);
> > +     if (!np)
> > +             return ERR_PTR(-ENOENT);
> > +
> > +     pdev = of_find_device_by_node(np);
> > +     of_node_put(np);
> > +     if (!pdev)
> > +             return ERR_PTR(-ENODEV);
> > +
> > +     mc = platform_get_drvdata(pdev);
> > +     if (!mc) {
> > +             put_device(mc->dev);
>
> This should be put_device(&pdev->dev). Please always be careful while
> copying someones else code :)

Good catch. I guess devm_add_action_or_reset() would also work... or
running Smatch on new code. Smatch should point it out.

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
